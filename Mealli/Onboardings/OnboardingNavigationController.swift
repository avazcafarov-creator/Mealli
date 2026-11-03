//
//  ViewController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 03.11.26.
//

import UIKit

final class OnboardingNavigationController: UINavigationController {
    private let header = OnboardingNavigationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden(true, animated: false)
        interactivePopGestureRecognizer?.delegate = nil
        delegate = self
        configureHeader()
    }
    
    private func configureHeader() {
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        header.onBack = { [weak self] in
            self?.popViewController(animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(header)
        viewControllers.forEach { applyHeaderInset(to: $0) }
    }
    
    private func applyHeaderInset(to viewController: UIViewController) {
        let height = header.frame.height
        guard viewController.additionalSafeAreaInsets.top != height else { return }
        viewController.additionalSafeAreaInsets.top = height
    }
    
    func pushNextStep() {
        let nextIndex = viewControllers.count
        guard nextIndex < OnboardingFlow.screens.count else { return }
        pushViewController(OnboardingFlow.screens[nextIndex](), animated: true)
    }
    
    private func updateHeader(for viewController: UIViewController) {
        guard let step = viewController as? OnboardingStep,
        let index = viewControllers.firstIndex(of: viewController) else { return }
        header.update(current: index + 1, title: step.stepTitle)
    }
}

extension OnboardingNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        applyHeaderInset(to: viewController)
        updateHeader(for: viewController)
        guard let coordinator = transitionCoordinator, coordinator.isInteractive else { return }
        coordinator.notifyWhenInteractionChanges { [weak self] context in
            guard context.isCancelled,
            let fromVC = context.viewController(forKey: .from) else { return }
            self?.updateHeader(for: fromVC)
        }
    }
}
