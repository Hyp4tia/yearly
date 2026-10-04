import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 12) {
                        Image("AppIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)

                        Text("Yearly")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Version 1.0")
                            .font(.footnote)
                            .foregroundStyle(.secondary)

                        Text("A minimalist perspective on time, mapping every day of your year as a single point of progress.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .listRowBackground(Color.clear)
                }

                Section("Privacy & Data") {
                    Label {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("100% On-Device")
                                .font(.body)
                                .fontWeight(.medium)
                            Text("Yearly does not require an account, has no analytics or third-party trackers, and never collects or transmits any personal data.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    } icon: {
                        Image(systemName: "lock.shield.fill")
                            .foregroundStyle(.green)
                    }

                    Label {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Zero Network Requests")
                                .font(.body)
                                .fontWeight(.medium)
                            Text("The app functions entirely offline. Calculations are computed instantly using your device's native system calendar.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    } icon: {
                        Image(systemName: "wifi.slash")
                            .foregroundStyle(.blue)
                    }
                }

                Section("Home Screen Widget") {
                    Label {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Glanceable Progress")
                                .font(.body)
                                .fontWeight(.medium)
                            Text("Add the Yearly widget to your Home Screen or Lock Screen to see days remaining and yearly completion at a glance. Updates automatically each midnight.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    } icon: {
                        Image(systemName: "square.grid.2x2.fill")
                            .foregroundStyle(.orange)
                    }
                }

                Section {
                    NavigationLink {
                        PrivacyPolicyView()
                    } label: {
                        HStack {
                            Label("Privacy Policy", systemImage: "hand.raised.fill")
                            Spacer()
                        }
                    }

                    Link(destination: URL(string: "https://hyp4tia.github.io/yearly/")!) {
                        HStack {
                            Text("Web Privacy Policy (GitHub Pages)")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                } header: {
                    Text("Privacy & Transparency")
                } footer: {
                    Text("Crafted for OLED displays and pure focus.")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 16)
                }
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AboutView()
}
