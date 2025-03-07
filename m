Return-Path: <linux-pm+bounces-23633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD402A56A4E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 15:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9597A3669
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E5D21B9D9;
	Fri,  7 Mar 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq1KdLD3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E921ADD6;
	Fri,  7 Mar 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357526; cv=none; b=PYWw3kj1yVAvbmOq2C2TdrSqZ+CDNdZk3ZHTrhBuOZVqiSBN21hCvtSWcrRyNqW8jdfQlwHayn2KDB/hqdS3BWDeK5+7hNS13Qt2VHvJpE4aSGa03aTfjEaCBifgkkCfIaLKlX+z2GX3GzCEFCF2dNbmKjtnRMYRfkHbqnByt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357526; c=relaxed/simple;
	bh=gA1kKgFhU+9VhS4X+o0hrNIOinwo4I1C9mOk0WY1OZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERgn8edl+BEptU1QyA9S9cVw4fC7X58IIiO2zPDtzpjaosbjDZcAJd5cspAd5qu8PTAIb/QaShEoHPEnN0o2m07iyem9caWVC/d5R78E7Uq5+Gtq7bP27GRBIJpMKRX9hRiuo543VD/3PUd/zxXAM36OZnNK34m/qpTkOBmKyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq1KdLD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86ECC4CED1;
	Fri,  7 Mar 2025 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741357525;
	bh=gA1kKgFhU+9VhS4X+o0hrNIOinwo4I1C9mOk0WY1OZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cq1KdLD3IlILAhs6gUffxuTAljMGMPKK7kp+P9R26SlTmARWPZqUNWSYvq7LCDVNm
	 d2bc2aTd/wo2/IeztEKULOXqtjxrjsXSlE5nA5pv5RLWz70qrA5PzL+mKRLMC4v/L0
	 I+KV4hBdLRlo+2RdVsbdSYDpZvyFiUoXB0FSF9kbIuC0T6aTk8dA7K2dtO+yaVIrfT
	 WIexrCjNoCPpTpbOGnwmYNWG+ZtNrPTSvjdLmYe1WTy7LjZlVvqzfQjzXeaC6yxyqc
	 D7L8yisBozIHFLSWlz10fNfebUFTE924cWAYfcdS5TuYyr1NBw/2ovkJHxxPeOghrj
	 y8kneFTWaKZvw==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72a1a9dd1b0so212465a34.1;
        Fri, 07 Mar 2025 06:25:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxnNqXKGmL0PzMiNCjOlCrVNZxw6pL9ffNSegQ/Yy6xKG+G/5rC761vE1YfEP6BM0ZkQIjpxe0eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgHTEJB7hiQKMykB6WYLsUA8yp9zxC88gRaAapynZ4angMgoa
	tyVRJCkNbRgkIK3z/CuUio4+uOBdnTKwHVB7dx1W+nczFoyZiagJL2S5UUeNeSstKQqd0OOEiZ6
	UktcXCJInPMGP+EaO1n/WIz4thZg=
X-Google-Smtp-Source: AGHT+IHrn8BPA4VPZK4gNrpWmVAKymKPX0ujhAOibfwiVPmaJ1Y6zgW+h5z2SXATyxILf5DKeSM0iNbqDqK38DtGvig=
X-Received: by 2002:a05:6830:410a:b0:727:3f3e:53ba with SMTP id
 46e09a7af769-72a37c7be8emr1905104a34.26.1741357525140; Fri, 07 Mar 2025
 06:25:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307132649.4056210-1-lukasz.luba@arm.com>
In-Reply-To: <20250307132649.4056210-1-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Mar 2025 15:25:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jH3Kp0KfX9Ef6OhrJ8-_i_RibvFqWPptHK4my-jvYHCA@mail.gmail.com>
X-Gm-Features: AQ5f1Jpi8HX32u4DBeNVqAePMACF9J5teGO_ImDjJ6baaBQq8vZHcGVHNilrwIY
Message-ID: <CAJZ5v0jH3Kp0KfX9Ef6OhrJ8-_i_RibvFqWPptHK4my-jvYHCA@mail.gmail.com>
Subject: Re: [RESEND][PATCH] power: energy_model: Rework the depends on for CONFIG_ENERGY_MODEL
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	srinivas.pandruvada@linux.intel.com, jeson.gao@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 2:27=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> From: Jeson Gao <jeson.gao@unisoc.com>
>
> Now not only CPUs can use energy efficiency models, but GPUs
> can also use. On the other hand, even with only one CPU, we can also
> use energy_model to align control in thermal.
> So remove the dependence of SMP, and add the DEVFREQ.
>
> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
> [Added missing SMP config option in DTPM_CPU dependency]
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>
> Hi Rafael,
>
> This fixes the issue in the former patch with the DTMP_CPU
> implicit build dependencies on SMP.
> The original patch can be found here [1] (the one that you had to revert)=
.
>
> Regards,
> Lukasz Luba
>
> [1] https://lore.kernel.org/lkml/20241219091109.10050-1-xuewen.yan@unisoc=
.com/
>
>
>  drivers/powercap/Kconfig | 2 +-
>  kernel/power/Kconfig     | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index 69ef8d081c98b..03c4c796d9931 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -82,7 +82,7 @@ config DTPM
>
>  config DTPM_CPU
>         bool "Add CPU power capping based on the energy model"
> -       depends on DTPM && ENERGY_MODEL
> +       depends on DTPM && ENERGY_MODEL && SMP
>         help
>           This enables support for CPU power limitation based on
>           energy model.
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index ca947ed32e3dd..54a6236800194 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -380,8 +380,7 @@ config CPU_PM
>
>  config ENERGY_MODEL
>         bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
> -       depends on SMP
> -       depends on CPU_FREQ
> +       depends on CPU_FREQ || PM_DEVFREQ
>         help
>           Several subsystems (thermal and/or the task scheduler for examp=
le)
>           can leverage information about the energy consumed by devices t=
o
> --

Applied as 6.15 material, thanks!

