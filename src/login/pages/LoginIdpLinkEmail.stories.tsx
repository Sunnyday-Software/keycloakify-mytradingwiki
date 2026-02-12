import type { Meta, StoryObj } from "@storybook/react";
import { createKcPageStory, createStorybookStoryHref } from "../KcPageStory";

const { KcPageStory } = createKcPageStory({ pageId: "login-idp-link-email.ftl" });
const ENROLLMENT_EMAIL_VERIFIED_STORY_TITLE = "Authentication/Login Flow/Enrollment Email Verified (login-verify-email.ftl)";

const meta = {
    title: "Authentication/Login Flow/First Login Confirm Email Address (login-idp-link-email.ftl)",
    component: KcPageStory
} satisfies Meta<typeof KcPageStory>;

export default meta;

type Story = StoryObj<typeof meta>;

export const DefaultState: Story = {
    render: () => <KcPageStory />
};

export const ContinueToEnrollmentVerification: Story = {
    render: () => (
        <KcPageStory
            kcContext={{
                url: {
                    loginAction: createStorybookStoryHref({
                        title: ENROLLMENT_EMAIL_VERIFIED_STORY_TITLE,
                        exportName: "DefaultState"
                    })
                }
            }}
        />
    )
};
