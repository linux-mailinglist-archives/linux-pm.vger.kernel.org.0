Return-Path: <linux-pm+bounces-36725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B08C0186D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1C5F4E1A84
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08533314A9F;
	Thu, 23 Oct 2025 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ja2Eu7OG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB1D13774D
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227253; cv=none; b=bBV/JROJi47kZCLaEp92DMyjmzshdIfoUaX147RJ+Y79JI8Mf/GhG5m1XzVZ2I34s+gM0aT4NLYriQaNJ+7ZdhsVy4klJEWqTwVyCCOqEttAnzjQ6hDPN0i0Q2VNRTtWWEY7b04nDhi1wSPqa6WQPdm/rdsTwff3/SaG6Y0tQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227253; c=relaxed/simple;
	bh=2YtJ6LRyOGedFxwzkzDH/Zo54OflUP87J7mbaNdzMkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dv/aQUpmS9iifCt9N9lXhn8bmFggmZbvk5UjfHDLf2fiu0ycfeHqyfXttvCDk31JN7TATQBE9iWveIBq6AZOgV8wJr2+NxG5rBpurI/9f0xdhkONyd1pA1mA+nqojqo7rHducJ+RCbc0w8uGmuyhKGO2NDqIOJnPDog3xJG1M0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ja2Eu7OG; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63d0692136bso998525d50.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761227251; x=1761832051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgz0MPvCEEIvnpRdxEKizmyGPKxuxFkbXXBpVNZQA2U=;
        b=Ja2Eu7OGV8fmhnZdia+rMmYTql6h0cSvLZ32B2KTgdoKGSfCUrOd5PdlnRkD4SoMna
         lTgyFTfMO5+GqKljBviRqhve2HNNApKaiyJ6WsWvQKozV3672XhyO1bl+n1YStYlbdq/
         eklTNaJkrAYYDNcizz/7nofFYIZuEOvEEAC8utmkroV0QA71++AFBtAEBRugVJFQwNEr
         utLzuUCDIOjHiJaoAsnrgldc56ocllALnqJ2BQcMNl+nFPfJ0dWEAmczAcQO4EPWqZ4l
         f4Bi9X/drxki7yaSIgxRzsDhQoYVhdWRvpHHCvWPXnewJnaK7y45dgtpJimU89K7vLzK
         1mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761227251; x=1761832051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgz0MPvCEEIvnpRdxEKizmyGPKxuxFkbXXBpVNZQA2U=;
        b=nAnis6PG1RMVJwUr9yul8b4t3jictjv1MOuUYCRQivNVmMybPE0D3YI0BhLMCI9FnN
         sPT2eOZgE0qh4Kf6Ao/yTrrDoWD51t8ipgCAoD4/gX5gu3jhfWKJXWqqFfYRPttvte40
         4ZT9RMIzAw7SeXDjKr5YqMb1wPlCeaqXM9SqENUT8CploGaEiEWB86m+/yboO6JCMRzn
         WOsn/A/4iVplZvGLEfD6+9sfHA9gpCx+DdfU0NZG67dxdC32/wNMeQYnxS20MwleccQJ
         tfw12Eip9g9yCOYssagKmjUdTS7fh4R9xMh0eY+OQYPAV19m+kuKjmPMm/+djyIiewxX
         sxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEhIB9HbkU2OU03jbl4kkDShpmOpEfsqpPPEgkcr5gIBUA62iqEKooOilYFmZ9Su/p+aJtjvxJ9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNk+bdpvFw7MxOac1moppV9rKz0QgJS/elUs3aVsxoYYieWOY
	Fx/gbeY8D+ft6jjyYA/94ilSVVsPhcTiti7DdQ+eGm84folSh6DUFzcmUOuhzw1shSdnSAWOeim
	T4AR1ZeLKAF3t9vjWk4N7rxUgVoc9iwANQpmcilPQaQ==
X-Gm-Gg: ASbGncssnSlbSUgOW2yo0Bvl9oxe7Owr1zzSp67tCCJ92+fazVMu6nN6sPUXNo8I2UK
	hK3D0WZU/dQvJtGYm4LJSf0rLVo+kJOMVdrA/adytcPdYkB0NiGCpt8DORbWkUXexffefP1K0kR
	rO9iT4wWmyipHqmo6PnpvCOPfgpmgR1hG12H85UaA+2eIhwS9i+rNSZ+GXutDdAkuVfvcfsTDNb
	TZWqqwwcEaeT9o/KJ4RqZ28B4PMeNFAFwTiMn4Ry/CnPQ/Oom7SgVypJS5Tqg==
X-Google-Smtp-Source: AGHT+IEDCfqv4pG4v0i8RCV2WYShTzR+pW/qVzfUKwEjCpv3rEpG8LtgRQWNRSjF/bG233OV5m2cMcbi37urgECEqnQ=
X-Received: by 2002:a05:690e:1598:10b0:63c:e90c:a6dc with SMTP id
 956f58d0204a3-63e160d9059mr18376155d50.8.1761227250806; Thu, 23 Oct 2025
 06:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
 <20251016-gs101-pd-v3-8-7b30797396e7@linaro.org> <CGME20251022110738eucas1p2cee28096ca5c9c6a802e2190d88ccf21@eucas1p2.samsung.com>
 <CAPDyKFq2esPos=D-eVz6w1VXq=4LYi6fx54K4TvsUi4JqUJOaQ@mail.gmail.com>
 <57bacc06-8a5e-4284-a520-c5d2a56545e9@samsung.com> <CAPDyKFrCS1PGwPeZd2ahZ=wKXCqPj93qAJ7V-ELELLA_OwgdSw@mail.gmail.com>
 <cca286f5-bb43-4914-864c-b5e5c73270c8@samsung.com>
In-Reply-To: <cca286f5-bb43-4914-864c-b5e5c73270c8@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Oct 2025 15:46:54 +0200
X-Gm-Features: AS18NWABfjM36klv5hIIGT-5MwjE_SPbRGTiI4LQB-iSMF8Ct_lzzibZCZxPGQY
Message-ID: <CAPDyKFppte-Rh-xNybEz8dshrD2gfqJHUpiL1bPWzZ6pBig6+g@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] pmdomain: samsung: selectively handle enforced sync_state
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Oct 2025 at 14:17, Marek Szyprowski <m.szyprowski@samsung.com> w=
rote:
>
> On 23.10.2025 12:02, Ulf Hansson wrote:
> > On Wed, 22 Oct 2025 at 20:39, Marek Szyprowski <m.szyprowski@samsung.co=
m> wrote:
> >> On 22.10.2025 13:06, Ulf Hansson wrote:
> >>> On Thu, 16 Oct 2025 at 17:58, Andr=C3=A9 Draszik <andre.draszik@linar=
o.org> wrote:
> >>>> Unconditionally calling of_genpd_sync_state() causes issues on
> >>>> platforms with child domains as the parent domain will be turned off
> >>>> before the child domain was even registered during boot.
> >>>>
> >>>> This in particular is an issue for the upcoming Google gs101 support=
 -
> >>>> all operations on child domains registered after the parent domain
> >>>> misbehave.
> >>>>
> >>>> Add a flag to the probe data to be able to sync_state conditionally
> >>>> only, and enable that flag on the two platforms currently supported =
by
> >>>> this driver.
> >>>>
> >>>> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >>>>
> >>>> ---
> >>>> v2:
> >>>> * use bool for need_early_sync_state (Krzysztof)
> >>>> ---
> >>>>    drivers/pmdomain/samsung/exynos-pm-domains.c | 5 ++++-
> >>>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/=
pmdomain/samsung/exynos-pm-domains.c
> >>>> index 638d286b57f716140b2401092415644a6805870e..15a1582aa92103a07335=
eb681600d9415369fefd 100644
> >>>> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> >>>> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> >>>> @@ -20,6 +20,7 @@
> >>>>    struct exynos_pm_domain_config {
> >>>>           /* Value for LOCAL_PWR_CFG and STATUS fields for each doma=
in */
> >>>>           u32 local_pwr_cfg;
> >>>> +       bool need_early_sync_state;
> >>>>    };
> >>>>
> >>>>    /*
> >>>> @@ -69,10 +70,12 @@ static int exynos_pd_power_off(struct generic_pm=
_domain *domain)
> >>>>
> >>>>    static const struct exynos_pm_domain_config exynos4210_cfg =3D {
> >>>>           .local_pwr_cfg          =3D 0x7,
> >>>> +       .need_early_sync_state  =3D true,
> >>>>    };
> >>>>
> >>>>    static const struct exynos_pm_domain_config exynos5433_cfg =3D {
> >>>>           .local_pwr_cfg          =3D 0xf,
> >>>> +       .need_early_sync_state  =3D true,
> >>>>    };
> >>>>
> >>>>    static const struct of_device_id exynos_pm_domain_of_match[] =3D =
{
> >>>> @@ -179,7 +182,7 @@ static int exynos_pd_probe(struct platform_devic=
e *pdev)
> >>>>            * reset during boot. As a temporary hack to manage this, =
let's enforce
> >>>>            * a sync_state.
> >>>>            */
> >>>> -       if (!ret)
> >>>> +       if (pm_domain_cfg->need_early_sync_state && !ret)
> >>>>                   of_genpd_sync_state(np);
> >>> The call to of_genpd_sync_state() was intended as a temporary solutio=
n here.
> >>>
> >>> Potentially, if we would be able to distinguish what PM domain that i=
s
> >>> causing the problem on the Exynos platforms, we could set
> >>> GENPD_FLAG_NO_STAY_ON for that genpd instead.
> >> Well, this of_genpd_sync_state() "workaround" has to be applied only t=
o
> >> the power domain of the display controller device. It can be replaced =
by
> >> the following check on the legacy Exynos systems:
> >>
> >> if (IS_ENABLED(CONFIG_ARM) &&
> >> of_device_is_compatible(np, "samsung,exynos4210-pd") &&
> >> (strstr(pd->pd.name, "LCD") || strstr(pd->pd.name, "DISP")))
> >> pd->pd.flags =3D GENPD_FLAG_NO_STAY_ON;
> > Oh wait, perhaps better to just power-off these PM domains before
> > calling pm_genpd_init(), if that can be done safely?
> >
> > At least that would guarantee the reset to happen before the display
> > driver gets probed. Instead of relying on genpd_power_off_unused()
> > (late_initcall_sync) to do it.
>
> Well, yes, this works too:
>
> if ((of_device_is_compatible(np, "samsung,exynos4210-pd") &&
>      (strstr(pd->pd.name, "LCD") || strstr(pd->pd.name, "DISP"))))
>           exynos_pd_power_off(&pd->pd);

Okay!

Should we (you or me?) send a patch and change the code like this?

>
> >> I assume that this information cannot be coded in device tree to make =
it
> >> somehow generic...
> > Right, in principle we would need a new DT property for a power-domain
> > provider, like "broken-hw-reset", because we don't have a reset-line
> > to pull.
>
> It is not a matter of broken reset at all. It is a matter of software
> configuration and the lack of 'protocol' to pass the information that
> the display controller is configured to display splash screen from the
> system memory at given address and newly instantiated drivers must to be
> aware of that.
>
> Turning display-related power domain off simply resets all that
> configuration, so drivers can start from good known 'unconfigured' state.

Alright, thanks for clarifying! Yeah, a DT property would be wrong for this=
.

In fact, there are some drivers [1] that make use of the genpd on/off
notifiers to manage a reset of its device's PM domain. It works, but
it's a bit messy. Perhaps it could be simplified with some new helper
functions, if more consumers drivers need something similar.

Kind regards
Uffe

[1]
commit c11fa1204fe9 ("drm/msm/a6xx: Use genpd notifier to ensure
cx-gdsc collapse")

