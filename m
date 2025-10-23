Return-Path: <linux-pm+bounces-36707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 934A7C00623
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 12:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F5C134F86A
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE57304BD6;
	Thu, 23 Oct 2025 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQZI/bfu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F82C325C
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213807; cv=none; b=nPPDtDBOcSbQ5LyTaxO04rUMmlzSKlUnv6v2AewFBTyvJPgTHJCU4eFiW5uVmnUjBc6XWSUtOtu3TcEr6GYnXa1gZpfRdB/dk20ipIYQzbVD3MJAuPHPcYgQql+7c6DBfq5G07k92iI1f9mMTIdm284KwFuWHMDqrQExPzxP2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213807; c=relaxed/simple;
	bh=+p1CXHiLaIPMryIwnOqeXs1RBYrS5XH1NSl8EPkHO8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnP4G6vOxSKbbKd1GwPi8ePtzUExuNVtL/bUE4W+aS334mLYfz4bBXC+S8JifH87sqOmRqvzpHQSa2RKHuNvsRjRF/anwPirjvnV+H+2r7lOPrYJ4RnuuA7n3K+rBOsPXJIjOLYk3GYKq9tM/k/W+I46AStxzNZyhV1sW/qRr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZQZI/bfu; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63e3568f90dso630831d50.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761213804; x=1761818604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWquFxQQ4MHJSF9//VvQ/C1WhYfIG1u7wl2C5TWDxwA=;
        b=ZQZI/bfu4tN3zB/Za0uaqFtM7QQVYhpAmBbheuFuY/dFrppF09xN91WQDq9Q0xsdL0
         iRxvtXLLWi3Pb3dyMFz5bK9ofdCHYNkAOBwQ8FvEiWGs22BYJGXPFiXU7kqTfr18OXoA
         xpEOx3Gtan+qmmgc2CFATsIfIjfFuFzxobcO+lAAAj7wzIfDHNdqqV3fnv62xCiQipIr
         v8kttkQuNCKPGkLm0TEvTc4NyequWjt9YuebMxjuIy7fSO1uu2hUp9gjPwhkIeXmUKhS
         v0BJyV9yxxV19fN11HWseqfzei0R99RbUbzO1nrGjKNZZi2fOa9WlGGE/CINnuKYiVBI
         H0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761213804; x=1761818604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWquFxQQ4MHJSF9//VvQ/C1WhYfIG1u7wl2C5TWDxwA=;
        b=J90FLS10UQbIetKP0BDxfco106ViBgZ+YD1G0mzjRADZEd6I3wIzqRk/JhY7Y3y8Cw
         S2bKNz6ptLCt/Am4XX5bXjfQ1aA2i/7yxUc5gtoKngjB+HNrI3wbeEjJMyTjEuMdDEgH
         0H1BS1JXf3G+UE1Febc2qpInx9UNmt3j1U1Dtb8pr0jc/dxJq2hP8/Pdf3nOQWc37xR2
         RmNsI3jKtJElB6inhRFDDoZ6SsPCXhZfT3wU/TETNzUS/lotO0xE7q58NXmf8VuTw++J
         HnlxjoE1DpiHnQ4UAMlTYyE0I+63moSMzwmI4c/DW/MFh6j5rqCiDf701IpiPBrKTWgz
         z/uA==
X-Forwarded-Encrypted: i=1; AJvYcCVVTYxM4vTsIqvHmELCqdKTQkCFtwPDmkggsYcUswRJsSkY8aR5GK39vmpZQUnN7x8BxlAnq/QIrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOybRnSgF39NrILGqJgfG+FXSPWtXaTHGWaLNAHdZRciSPmJW
	89WvoK5uU0wNEa3/jMwUibFrtDVp3K5mBYqGKw/hzqBbhMoS6g6ho1mvGKSu4EaLbnxNsCd7Wst
	PTPU9etjTCWxb6UCaDZfnodsfZF0Rt23bC+I+TIVEPg==
X-Gm-Gg: ASbGncsrbq+OOcSXohw5hgcGaiWcjYVJTM9abQZAyC/1zht4K2M32h9ABBNfKztsljQ
	89jOLB0FjnZyZU4h+yRsl80V9EbUuqjbZ10VNR0yV5hcClLoostd6iI1XRXFUzMysh0sY0ulioA
	R96LKEMASXu7V3W6uF5ZBlgcRnmssbJQbYEIuUXk2y4BD5Kt/burDbtRD0al8z+OTX8n7d7T1aw
	TD1imSNaFDd1USXQzhRpqP9y6PgGSRhARkR/E8deHit05heMS8+usaBvLaMXA==
X-Google-Smtp-Source: AGHT+IHYTuBS5tdkgCmTIC44x/jualH/JELvua1Z+qzp00tin6cE2MKOBedS1C2f62vL4/dVJ0lyn45HjIoQ+rR7MQ4=
X-Received: by 2002:a05:690e:c42:b0:63e:33a7:cdf0 with SMTP id
 956f58d0204a3-63f377d2574mr1315040d50.14.1761213804328; Thu, 23 Oct 2025
 03:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
 <20251016-gs101-pd-v3-8-7b30797396e7@linaro.org> <CGME20251022110738eucas1p2cee28096ca5c9c6a802e2190d88ccf21@eucas1p2.samsung.com>
 <CAPDyKFq2esPos=D-eVz6w1VXq=4LYi6fx54K4TvsUi4JqUJOaQ@mail.gmail.com> <57bacc06-8a5e-4284-a520-c5d2a56545e9@samsung.com>
In-Reply-To: <57bacc06-8a5e-4284-a520-c5d2a56545e9@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Oct 2025 12:02:48 +0200
X-Gm-Features: AS18NWDk2cnwAbu5KPIINOVhITzbpKKTXME95wNCKMMbO1h01gk_WEP7weXC8KQ
Message-ID: <CAPDyKFrCS1PGwPeZd2ahZ=wKXCqPj93qAJ7V-ELELLA_OwgdSw@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] pmdomain: samsung: selectively handle enforced sync_state
To: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Rob Herring <robh@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 at 20:39, Marek Szyprowski <m.szyprowski@samsung.com> w=
rote:
>
> On 22.10.2025 13:06, Ulf Hansson wrote:
> > On Thu, 16 Oct 2025 at 17:58, Andr=C3=A9 Draszik <andre.draszik@linaro.=
org> wrote:
> >> Unconditionally calling of_genpd_sync_state() causes issues on
> >> platforms with child domains as the parent domain will be turned off
> >> before the child domain was even registered during boot.
> >>
> >> This in particular is an issue for the upcoming Google gs101 support -
> >> all operations on child domains registered after the parent domain
> >> misbehave.
> >>
> >> Add a flag to the probe data to be able to sync_state conditionally
> >> only, and enable that flag on the two platforms currently supported by
> >> this driver.
> >>
> >> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >>
> >> ---
> >> v2:
> >> * use bool for need_early_sync_state (Krzysztof)
> >> ---
> >>   drivers/pmdomain/samsung/exynos-pm-domains.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pm=
domain/samsung/exynos-pm-domains.c
> >> index 638d286b57f716140b2401092415644a6805870e..15a1582aa92103a07335eb=
681600d9415369fefd 100644
> >> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> >> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> >> @@ -20,6 +20,7 @@
> >>   struct exynos_pm_domain_config {
> >>          /* Value for LOCAL_PWR_CFG and STATUS fields for each domain =
*/
> >>          u32 local_pwr_cfg;
> >> +       bool need_early_sync_state;
> >>   };
> >>
> >>   /*
> >> @@ -69,10 +70,12 @@ static int exynos_pd_power_off(struct generic_pm_d=
omain *domain)
> >>
> >>   static const struct exynos_pm_domain_config exynos4210_cfg =3D {
> >>          .local_pwr_cfg          =3D 0x7,
> >> +       .need_early_sync_state  =3D true,
> >>   };
> >>
> >>   static const struct exynos_pm_domain_config exynos5433_cfg =3D {
> >>          .local_pwr_cfg          =3D 0xf,
> >> +       .need_early_sync_state  =3D true,
> >>   };
> >>
> >>   static const struct of_device_id exynos_pm_domain_of_match[] =3D {
> >> @@ -179,7 +182,7 @@ static int exynos_pd_probe(struct platform_device =
*pdev)
> >>           * reset during boot. As a temporary hack to manage this, let=
's enforce
> >>           * a sync_state.
> >>           */
> >> -       if (!ret)
> >> +       if (pm_domain_cfg->need_early_sync_state && !ret)
> >>                  of_genpd_sync_state(np);
> > The call to of_genpd_sync_state() was intended as a temporary solution =
here.
> >
> > Potentially, if we would be able to distinguish what PM domain that is
> > causing the problem on the Exynos platforms, we could set
> > GENPD_FLAG_NO_STAY_ON for that genpd instead.
>
> Well, this of_genpd_sync_state() "workaround" has to be applied only to
> the power domain of the display controller device. It can be replaced by
> the following check on the legacy Exynos systems:
>
> if (IS_ENABLED(CONFIG_ARM) &&
> of_device_is_compatible(np, "samsung,exynos4210-pd") &&
> (strstr(pd->pd.name, "LCD") || strstr(pd->pd.name, "DISP")))
> pd->pd.flags =3D GENPD_FLAG_NO_STAY_ON;

Oh wait, perhaps better to just power-off these PM domains before
calling pm_genpd_init(), if that can be done safely?

At least that would guarantee the reset to happen before the display
driver gets probed. Instead of relying on genpd_power_off_unused()
(late_initcall_sync) to do it.

>
> I assume that this information cannot be coded in device tree to make it
> somehow generic...

Right, in principle we would need a new DT property for a power-domain
provider, like "broken-hw-reset", because we don't have a reset-line
to pull.

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Kind regards
Uffe

