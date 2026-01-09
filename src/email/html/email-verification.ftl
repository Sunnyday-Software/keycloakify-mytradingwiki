<#import "template.ftl" as layout>

<#assign
    preheader=msg("emails.verifyEmail.preheader")
    title=msg("emails.verifyEmail.title")
    intro=msg("emails.verifyEmail.intro")
    context=msg("emails.verifyEmail.context")
    ctaLabel=msg("emails.verifyEmail.cta")
    ctaAria=msg("emails.verifyEmail.aria.cta")
    expiration=msg("emails.verifyEmail.expiration")
    fallbackIntro=msg("emails.fallbackIntro")
    fallbackLabel=msg("emails.linkLabels.verify")
    securityNote=msg("emails.security.neverShareLink")
    disclaimer=msg("emails.security.ignoreIfNoRequested")
    footerSupport=msg("emails.support")
    footerSignature=msg("emails.signature")
>

<@layout.emailLayout
    preheader=preheader
    title=title
    intro=intro
    context=context
    ctaLabel=ctaLabel
    ctaLink=link
    ctaAria=ctaAria
    expiration=expiration
    fallbackIntro=fallbackIntro
    fallbackLabel=fallbackLabel
    fallbackLink=link
    securityNote=securityNote
    disclaimer=disclaimer
    footerSupport=footerSupport
    footerSignature=footerSignature
/>
