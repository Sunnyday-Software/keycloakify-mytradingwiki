<#import "template.ftl" as layout>

<#assign
    brandName=msg("emails.brand.name")
    preheader=msg("emails.verify.preheader", brandName)
    title=msg("emails.verify.title")
    intro=msg("emails.verify.intro", brandName)
    context=msg("emails.verify.context")
    ctaLabel=msg("emails.verify.cta")
    ctaAria=msg("emails.verify.aria.cta")
    expiration=msg("emails.verify.expiresIn", linkExpirationFormatter(linkExpiration))
    fallbackIntro=msg("emails.fallbackIntro")
    fallbackLabel=msg("emails.verify.fallbackLabel")
    securityNote=msg("emails.verify.security")
    disclaimer=msg("emails.verify.disclaimer")
    footerSupport=msg("emails.support")
    footerSignature=msg("emails.signature")
>

<@layout.BrandedEmail
    preheader=preheader
    title=title
    intro=intro
    context=context
    ctaLabel=ctaLabel
    ctaLink=link
    ctaAria=ctaAria
    metaText=expiration
    fallbackIntro=fallbackIntro
    fallbackLabel=fallbackLabel
    fallbackLink=link
    securityNote=securityNote
    disclaimer=disclaimer
    footerSupport=footerSupport
    footerSignature=footerSignature
    brandName=brandName
/>
