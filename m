Return-Path: <linux-pm+bounces-27140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B1AB6F7B
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 17:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489A317E00D
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516EC27A929;
	Wed, 14 May 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6hhd98V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B027A905
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235603; cv=none; b=jG2n/cLudSTFamGCMztVXairXScbnakcFUZ2lVv7uw1+pfdAOaCvy/mUzuniB0XjoYxvAj8e9vLoXW2H+Pejtjq6Vf9/r1OpTb1AYVKLtEZ2agFrzm4NC/nf0WpmbHoAL0rqjRRpZkNnA4324KbWfQHM5Ubhkcx3eqe26iTOSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235603; c=relaxed/simple;
	bh=zMHHBnI6m3mo0ePFTe0uKSZzTUP9WZHZ7T2iGlRV0+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl5eJbBAL1DRMb7jsUiEbZLrmDs+Gd8JIC/7VNp3t02+4e4HfDdPJOqi7ZRCuxawh8YAUG7+YrBRUoswPx9EgypQCSru3PTuX+9UxOBfCW5bVT/kkhH5RujpLk7GksnPqez6Fa8Jt/0nqxfEOoL9gJBpkkROGXYYdqi0rLbpKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U6hhd98V; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e73e9e18556so1038987276.0
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747235600; x=1747840400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J8jj6jRyHpEahWPL1bxwBIDklu0Ui7Dm+eEH5GeKLrc=;
        b=U6hhd98VBx26nUxFA6BDVx8Z/bzUuTd56wtcK0gpFeIay6o/Q+foCbWD5VEDLMzd0T
         kHE2SFzJh1kPQPY+76WjoNkIF+kT6v0Lriqkzk2u+BUw77LsMSjtXs5rKPaogRgY7AUJ
         bonLvuYToOi7YddGdy0OHEa6nTHQdplYgiY3oZBJSJ8J3gRJAtcECrON8ZIpT9RPgz2j
         ifz/ZBmjTv7S5msxL7Oc1yK/+LSwpfyvv6AeqYrK2qhAf3OwWnnib/VqejHRUAYpBdvD
         lgyD+w6qm7yES5SsrZECvyZE279SLI+uItobFN8q8NvsH93hvK8WjJv+GuQqQAQLIwUD
         bogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235600; x=1747840400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8jj6jRyHpEahWPL1bxwBIDklu0Ui7Dm+eEH5GeKLrc=;
        b=kxKbrIpctedZtRetjl+IPU7l/MBQcC05hsxquyf6xcCD9nu8KdBHxizDs0vQWkmY/q
         jhaG8SPWPs6XjMmJSS4UM4kGoRHxRwgM8tm/dsv8yUGcfh95XfXJ6Rxzvq2ktkW0afBL
         05XWlYiVwSGWArrxPO5DiDb5MBwHYy4cNuL0lo49m2to1EHuO/MD1soUUyPvWvVmpbbP
         DrbOTo5nPyP2zWxHHZNZ59EJnEEhmohGX7CsiFHgNsX98uQRHa1ucGDNwlfb/MRQMf1z
         rRomdQ08N9yqGrvy7goFeQdkRyUnS8nQZL2+DIMBb4TTVQsWhSEnsuKML/+4UxvzZAnc
         cVCg==
X-Forwarded-Encrypted: i=1; AJvYcCWFlkq6eh1DPSWiDw4dONzki4fNJqVef72HFbQ/gepsMg500+aDv1oVuP+hLhICXgsRWjRLL3jIYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/e2Q2jQkIHK+t4Bp4mAY12sS4G/paF7qghQP2uyH3JeS2hI6E
	5++LD2V51/3CEXEPnpeltKLqfKNUZAnfaLlm4D2F90Y16Si1WMXNQ/ZEHKQ4ohKMStIW5kWrhaX
	P8PbvBuxaCNHGYBi2g2mPL6xbwatD5tZg9EsXb7SzqY95TWeJrPo=
X-Gm-Gg: ASbGncshK7Xci8zNkGFgMs/hFJnH8/9Syj2GC0gc9KaSKFJI0E+UobCZW1ZOYUNcMnE
	NunVAnHmc5mpSkl91IbvlCLVv4zRSmlcrVCE+O0inqwPL4JBwU5wiWIDxbf70QXcZ1OjDSA5HJZ
	SygdkrADk/0gTumwk31xBbBDRdPPrPejU=
X-Google-Smtp-Source: AGHT+IHfG4IdFhrynlohLcjINUvWUYxudJNltoIen2Onw6R0djfVvCV0/FdSfcdQNubeHC89QVS5keitmH669vIpZ7M=
X-Received: by 2002:a05:6902:2389:b0:e78:f538:1c54 with SMTP id
 3f1490d57ef6-e7b2bde5e59mr11105285276.4.1747235600229; Wed, 14 May 2025
 08:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-rk3576-emmc-fix-v3-1-0bf80e29967f@collabora.com>
 <CAPDyKFp5N23KCZwOTba6vGyk9eaS1-SjSqY52FfPDng-bahn6g@mail.gmail.com> <6154950.lOV4Wx5bFT@workhorse>
In-Reply-To: <6154950.lOV4Wx5bFT@workhorse>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 May 2025 17:12:44 +0200
X-Gm-Features: AX0GCFtDU_yTZnx-ehoHmNHeQ7h0DL35V2e2RHKt0pgXDptXnpjYmnfRRnWBnck
Message-ID: <CAPDyKFpohUibXp_ReVquAxYHY7vZ28P1XmOCTU5GPQdLKYEaNg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: add PD workaround on RK3576
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Finley Xiao <finley.xiao@rock-chips.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 16:27, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Tuesday, 29 April 2025 12:06:16 Central European Summer Time Ulf Hansson wrote:
> > On Wed, 23 Apr 2025 at 09:54, Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> > >
> > > RK3576's power domains have a peculiar design where the PD_NVM power
> > > domain, of which the sdhci controller is a part, seemingly does not have
> > > idempotent runtime disable/enable. The end effect is that if PD_NVM gets
> > > turned off by the generic power domain logic because all the devices
> > > depending on it are suspended, then the next time the sdhci device is
> > > unsuspended, it'll hang the SoC as soon as it tries accessing the CQHCI
> > > registers.
> > >
> > > RK3576's UFS support needed a new dev_pm_genpd_rpm_always_on function
> > > added to the generic power domains API to handle what appears to be a
> > > similar hardware design.
> > >
> > > Use this new function to ask for the same treatment in the sdhci
> > > controller by giving rk3576 its own platform data with its own postinit
> > > function. The benefit of doing this instead of marking the power domains
> > > always on in the power domain core is that we only do this if we know
> > > the platform we're running on actually uses the sdhci controller. For
> > > others, keeping PD_NVM always on would be a waste, as they won't run
> > > into this specific issue. The only other IP in PD_NVM that could be
> > > affected is FSPI0. If it gets a mainline driver, it will probably want
> > > to do the same thing.
> > >
> > > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >
> > Applied for next, thanks!
> >
> > Kind regards
> > Uffe
> >
>
> Hi Uffe,
>
> I was wondering whether we can get this into 6.15 as a fix as well, as 6.15
> should already have the genpd API additions this requires AFAIU.

Sure, it makes perfect sense!

>
> Fixes tag could be something like:
>
>   Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC")
>
> but may need some more flavorings to keep the stable robot overlords from
> trying to apply it to 6.14 and earlier and then starting the robot uprising
> in your inbox when they notice the API is missing.
>
> I originally left out the Fixes tag on the rewrite of this using the new
> API because I wanted to avoid those awkward backport scenarios for a fairly
> freshly supported SoC, but it'd be great to have this in 6.15 because that
> will be with us for a full release cycle to come.

I added the fixes tag and a stable tag to point out that it should be
applied only for v6.15+.

>
> Kind regards,
> Nicolas Frattaroli
>
>
>

Kind regards
Uffe

