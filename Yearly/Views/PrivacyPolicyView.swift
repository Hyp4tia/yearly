import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Privacy Policy")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Effective Date: October 5, 2026")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom, 8)

                policyCard(
                    title: "1. Zero Data Collection",
                    body: "Yearly does not collect, store, transmit, or share any personal information, location data, device identifiers, or usage analytics."
                )

                policyCard(
                    title: "2. 100% On-Device Processing",
                    body: "All calculations—including elapsed days, days remaining, and percent complete—occur strictly on your device using native iOS calendar APIs. No date or usage data ever leaves your device."
                )

                policyCard(
                    title: "3. No Third-Party Trackers",
                    body: "Yearly contains no third-party tracking frameworks, advertising identifiers (IDFA), analytics SDKs, or social media integration."
                )

                policyCard(
                    title: "4. No Permissions Required",
                    body: "Yearly does not request access to your Camera, Photos, Contacts, Microphone, Location, or Health data."
                )

                policyCard(
                    title: "5. Home Screen & Lock Screen Widgets",
                    body: "The Yearly widget operates completely offline, reading only your current system date and appearance preference to schedule 12:00 AM updates locally."
                )

                policyCard(
                    title: "6. Children's Privacy",
                    body: "Because Yearly collects no data whatsoever, it complies fully with the Children's Online Privacy Protection Act (COPPA) and the General Data Protection Regulation (GDPR)."
                )

                policyCard(
                    title: "7. Contact & Open Source",
                    body: "If you have questions about this policy, contact support at ziadm0386@icloud.com or visit the public repository at github.com/Hyp4tia/yearly."
                )
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func policyCard(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(body)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(uiColor: .secondarySystemBackground))
        )
    }
}

#Preview {
    NavigationStack {
        PrivacyPolicyView()
    }
}
