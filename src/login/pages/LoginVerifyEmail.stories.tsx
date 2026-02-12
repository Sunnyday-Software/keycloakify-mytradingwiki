import type { Meta, StoryObj } from "@storybook/react";
import { createKcPageStory, createStorybookStoryHref } from "../KcPageStory";

const { KcPageStory } = createKcPageStory({ pageId: "login-verify-email.ftl" });
const INFO_STORY_TITLE = "Authentication/Login Flow/Post Login Information (info.ftl)";

const meta = {
    title: "Authentication/Login Flow/Enrollment Email Verified (login-verify-email.ftl)",
    component: KcPageStory
} satisfies Meta<typeof KcPageStory>;

export default meta;

type Story = StoryObj<typeof meta>;

export const DefaultState: Story = {
    render: () => <KcPageStory />
};

export const ContinueToInfo: Story = {
    render: () => (
        <KcPageStory
            kcContext={{
                url: {
                    loginAction: createStorybookStoryHref({
                        title: INFO_STORY_TITLE,
                        exportName: "DefaultMessage"
                    })
                }
            }}
        />
    )
};
