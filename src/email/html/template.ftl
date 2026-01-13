<#macro RootLayout preheader="" title="">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="color-scheme" content="light dark">
    <meta name="supported-color-schemes" content="light dark">
    <title>${title}</title>
    <style type="text/css">
        body { margin: 0; padding: 0; background-color: #f3f4f6; }
        table { border-collapse: collapse; }
        img { border: 0; line-height: 100%; outline: none; text-decoration: none; }
        a { color: #0f766e; }
        .preheader {
            display: none !important;
            visibility: hidden;
            opacity: 0;
            color: transparent;
            height: 0;
            width: 0;
            mso-hide: all;
            overflow: hidden;
        }
        @media (prefers-color-scheme: dark) {
            body, .email-body { background-color: #0b1220 !important; }
            .card { background-color: #0f172a !important; border-color: #1f2937 !important; }
            .text { color: #e2e8f0 !important; }
            .muted { color: #94a3b8 !important; }
            .fallback { background-color: #111827 !important; border-color: #1f2937 !important; }
            .button { background-color: #14b8a6 !important; }
            a { color: #5eead4 !important; }
        }
    </style>
</head>
<body class="email-body" style="margin:0; padding:0; background-color:#f3f4f6;">
    <span class="preheader">${preheader}</span>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#f3f4f6;">
        <tr>
            <td align="center" style="padding:24px 12px;">
                <#nested>
            </td>
        </tr>
    </table>
</body>
</html>
</#macro>

<#macro CenteredCardLayout>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:520px; width:100%;">
        <tr>
            <td>
                <#nested>
            </td>
        </tr>
    </table>
</#macro>

<#macro CardStackLayout>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" class="card" style="background-color:#ffffff; border:1px solid #e5e7eb; border-radius:16px;">
        <tr>
            <td style="padding:24px; font-family:'Inter','Segoe UI',Arial,sans-serif; color:#0f172a;" class="text">
                <#nested>
            </td>
        </tr>
    </table>
</#macro>

<#macro BrandHero brandName logoUrl>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin:0 0 16px 0;">
        <tr>
            <td align="center">
                <img src="${logoUrl}" width="160" height="48" alt="${brandName}" style="border:0; display:block; outline:none; text-decoration:none; max-width:160px; width:100%; height:auto;">
            </td>
        </tr>
    </table>
</#macro>

<#macro TitleBlock title>
    <h1 style="margin:0 0 12px 0; font-size:20px; line-height:28px; font-weight:700;" class="text">${title}</h1>
</#macro>

<#macro BodyCopy intro context>
    <#if intro?has_content>
        <p style="margin:0 0 12px 0; font-size:14px; line-height:22px; color:#334155;" class="text">${intro}</p>
    </#if>
    <#if context?has_content>
        <p style="margin:0 0 20px 0; font-size:14px; line-height:22px; color:#334155;" class="text">${context}</p>
    </#if>
</#macro>

<#macro PrimaryCTA label link aria>
    <table role="presentation" cellpadding="0" cellspacing="0" style="margin:0 0 16px 0;">
        <tr>
            <td align="center" bgcolor="#0f766e" class="button" style="border-radius:8px;">
                <a href="${link}" aria-label="${aria}" style="display:inline-block; padding:12px 18px; font-size:14px; line-height:20px; color:#ffffff; text-decoration:none; font-weight:600;">${label}</a>
            </td>
        </tr>
    </table>
</#macro>

<#macro MetaRow text>
    <#if text?has_content>
        <p style="margin:0 0 16px 0; font-size:12px; line-height:18px; color:#64748b;" class="muted">${text}</p>
    </#if>
</#macro>

<#macro FallbackPanel intro label link>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" class="fallback" style="background-color:#f8fafc; border:1px solid #e5e7eb; border-radius:12px;">
        <tr>
            <td style="padding:12px; font-size:12px; line-height:18px; color:#475569; font-family:'Inter','Segoe UI',Arial,sans-serif;" class="muted">
                <#if intro?has_content>
                    <p style="margin:0 0 8px 0;">${intro}</p>
                </#if>
                <#if label?has_content>
                    <p style="margin:0; font-weight:600; color:#0f172a;" class="text">${label}</p>
                </#if>
                <p style="margin:4px 0 0 0; word-break:break-all;">
                    <a href="${link}" style="color:#0f766e; text-decoration:underline;">${link}</a>
                </p>
            </td>
        </tr>
    </table>
</#macro>

<#macro SecurityNotice note disclaimer>
    <#if note?has_content>
        <p style="margin:16px 0 8px 0; font-size:12px; line-height:18px; color:#64748b;" class="muted">${note}</p>
    </#if>
    <#if disclaimer?has_content>
        <p style="margin:0 0 16px 0; font-size:12px; line-height:18px; color:#64748b;" class="muted">${disclaimer}</p>
    </#if>
</#macro>

<#macro FooterLayout support signature>
    <#if support?has_content>
        <p style="margin:0 0 6px 0; font-size:12px; line-height:18px; color:#475569;" class="muted">${support}</p>
    </#if>
    <#if signature?has_content>
        <p style="margin:0; font-size:12px; line-height:18px; color:#475569;" class="muted">${signature}</p>
    </#if>
</#macro>

<#macro BrandedEmail preheader title intro context ctaLabel ctaLink ctaAria metaText fallbackIntro fallbackLabel fallbackLink securityNote disclaimer footerSupport footerSignature brandName>
    <@RootLayout preheader=preheader title=title>
        <@CenteredCardLayout>
            <@CardStackLayout>
                <@BrandHero brandName=brandName logoUrl="${url.resourcesUrl}/mytradingwiki.svg" />
                <@TitleBlock title=title />
                <@BodyCopy intro=intro context=context />
                <@PrimaryCTA label=ctaLabel link=ctaLink aria=ctaAria />
                <@MetaRow text=metaText />
                <@FallbackPanel intro=fallbackIntro label=fallbackLabel link=fallbackLink />
                <@SecurityNotice note=securityNote disclaimer=disclaimer />
                <@FooterLayout support=footerSupport signature=footerSignature />
            </@CardStackLayout>
        </@CenteredCardLayout>
    </@RootLayout>
</#macro>

<#macro emailLayout preheader="" title="">
    <@RootLayout preheader=preheader title=title>
        <@CenteredCardLayout>
            <@CardStackLayout>
                <#nested>
            </@CardStackLayout>
        </@CenteredCardLayout>
    </@RootLayout>
</#macro>
