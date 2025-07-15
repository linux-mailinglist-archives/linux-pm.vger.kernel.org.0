Return-Path: <linux-pm+bounces-30857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AFCB058F1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 13:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9E11894AFB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C448E2DBF45;
	Tue, 15 Jul 2025 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFe3xm34"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2CE2D9EEA
	for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579328; cv=none; b=d2x34Q8p2kK7tL49oPOzG6qIu0bTDDbGgAgmMbjWF/63/aiXIqt+POsB7huoC4+fD0cTaTlpdm0IM34bgrBjm8rXnQMzXPYOLb4Us1zrJpJNj5W/3Q7jCSlByfwRqXRUMJFGLR7Lz3MVXbkPWXVjkwHC24GwRyJVxXBZv80HTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579328; c=relaxed/simple;
	bh=cTflvjFePLQxgKie4eKSTOOZevSjP8T8WicglUvKhQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GnlP3JOIoNIF7sKYbW6hq4eI+FOC2XjyS6gyMMBkCA0xPl766N8fMDWMO/s9C7gDOXlvj2pbghErlUQQsXAAjbcL+UtFnTvFibrpMQ0usGrQQrarf/6ZgJNENJDcj58L4rsUEAoVQo3yOkVAFo6SQ3qUjp1ZAwhFaAVLxYE+vD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFe3xm34; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7176c66e99cso50027157b3.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 04:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752579324; x=1753184124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cTflvjFePLQxgKie4eKSTOOZevSjP8T8WicglUvKhQU=;
        b=iFe3xm34o1P7aisfwOISpuflN8teXe+tqF5/2ugnBELlt/uV/fSdig4v7FpO0mVVYh
         tVKFJgoet+cPV1weniH0Xv+jMVEKnlahnrGwZVOvEPqY9mVc/kSbDM/fxd2CkAWhll5P
         UagJX937yAyWqgANAeV4K4HBLzIYSUBlU1SxDFQop74ZNEpoOXn+TuvDUzwdpYY7dBCW
         V4SKLuulcRmeXp+ty4WTtgmR7a6noGyooIMvui/5VDp5diYDQE/S3nQBC6/BrDkKxsbU
         MSsa8cVukZvmFHzTt28x0acTnt74g80Pzsr5JTTRft6UaUAknBKKIjQnIM9CRzTySDl/
         fwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752579324; x=1753184124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTflvjFePLQxgKie4eKSTOOZevSjP8T8WicglUvKhQU=;
        b=uehu81cQW5sCU4o6MTnFZFuNvnM/EL9cHkmdGtSXpdvDTa+ybg4H7BfuG3Efm417Fl
         Q2e/R9FeLg/zI4p1E3RUHiATGks1H9KSR23YlhE8ARDTHVLFbLAN2dg+dZh5y8NrPSCB
         0olJqXvcTEeqobRJaip1hBuEd6fG6FZm8gNOqsuLficg91EEmo+tWdpHK9Ff9BZfCHLf
         OOLDRWogvRMviEv1Ye18czX7Pk7s4TlBbagvoZxMcVJzVk1cvLPSxOkaKE9lPAL1Jqs3
         tIMDojiITbvWzOh8NcvyIay1YA/dFQjDyrTvoiMC+3TDIpp4/CQ5Ib+glqZNLADg9Kow
         l4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWUPQC+P+BmkuzU9PzLHhbT7GnAsJC/7Unq5WMMevbAaACDWxVSyAGdYKXfmvj3ifJD+XSyUINqPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKf0wbplyDuRpaU/w4B1U9Q2+/sR7CZUHDPrjj5UUvCHoRWB8K
	4gb0PNt/BLuAUMU5Cli8oogDUsGbE65M+r6pAEGof+2MWhZRgy23xn+Uas8StgD/CVOyMN6fbs9
	HrtwCxHJ7TjqzzTE3FBWeZu9cyoywFXIPPXomEdfsDQ==
X-Gm-Gg: ASbGncuQlwti1OJZ2vGke7Mvfe8l8fD35IMWAD9kC6g4q9zxlxrCba9/yd2+RF4+l8w
	HNpqrOJt0KM/XmeOZmwq1/FkZvc4I11lCgIj6qO+Y33cP0fo2CdmsP7cZBBf5ZLBsIH0nHIzmTo
	rsZIVuaPtCFk9tUaAdm6TDbCeoJLgPzClmURVC/sRduakCSiFiqiQKEflHoBqixp6nw84qZFyps
	zawXeBv7NSNq2KQl7Q=
X-Google-Smtp-Source: AGHT+IHfjHxIt9nZkak6zCnhG7sn8uSPBfYsxEtsb2a6mcbcWZf8ySh+73e1WwlnP3JuKOMwe35Yu94PqLxFVbjU1Uc=
X-Received: by 2002:a05:690c:6a08:b0:716:6a18:1740 with SMTP id
 00721157ae682-717d5e30ff5mr244148587b3.33.1752579324012; Tue, 15 Jul 2025
 04:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CGME20250710122654eucas1p20f1179a9ff22d562d89252f924d34dae@eucas1p2.samsung.com>
 <20250701114733.636510-22-ulf.hansson@linaro.org> <212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com>
 <CAPDyKFrPOgWW_=ehCjtqAUR97HoLKmgFNO3bRT50-w6A1LgGFw@mail.gmail.com>
 <01646690-8964-49c8-bbed-556380844b14@nvidia.com> <CAPDyKFooYFVrzLEqOtwb02iyEf+c6qPB8+Us1--Y-oXbJVG+SQ@mail.gmail.com>
In-Reply-To: <CAPDyKFooYFVrzLEqOtwb02iyEf+c6qPB8+Us1--Y-oXbJVG+SQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 13:34:47 +0200
X-Gm-Features: Ac12FXw0mZPGQfTep1pMZhaIh1PE21HNet-YtWTUWTNvcL1vhGLnVaD4aB7xFiQ
Message-ID: <CAPDyKFq=6vZ4xbuduE9TvGB-NtCMpBKProYNRv-=c3cBZdTuPw@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] pmdomain: core: Leave powered-on genpds on until late_initcall_sync
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Saravana Kannan <saravanak@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Hiago De Franco <hiago.franco@toradex.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 13:32, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 15 Jul 2025 at 12:28, Jon Hunter <jonathanh@nvidia.com> wrote:
> >
> > Hi Ulf,
> >
> > On 10/07/2025 15:54, Ulf Hansson wrote:
> > > On Thu, 10 Jul 2025 at 14:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > >>
> > >> On 01.07.2025 13:47, Ulf Hansson wrote:
> > >>> Powering-off a genpd that was on during boot, before all of its consumer
> > >>> devices have been probed, is certainly prone to problems.
> > >>>
> > >>> As a step to improve this situation, let's prevent these genpds from being
> > >>> powered-off until genpd_power_off_unused() gets called, which is a
> > >>> late_initcall_sync().
> > >>>
> > >>> Note that, this still doesn't guarantee that all the consumer devices has
> > >>> been probed before we allow to power-off the genpds. Yet, this should be a
> > >>> step in the right direction.
> > >>>
> > >>> Suggested-by: Saravana Kannan <saravanak@google.com>
> > >>> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> > >>> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
> > >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >>
> > >> This change has a side effect on some Exynos based boards, which have
> > >> display and bootloader is configured to setup a splash screen on it.
> > >> Since today's linux-next, those boards fails to boot, because of the
> > >> IOMMU page fault.
> > >
> > > Thanks for reporting, let's try to fix this as soon as possible then.
> > >
> > >>
> > >> This happens because the display controller is enabled and configured to
> > >> perform the scanout from the spash-screen buffer until the respective
> > >> driver will reset it in driver probe() function. This however doesn't
> > >> work with IOMMU, which is being probed earlier than the display
> > >> controller driver, what in turn causes IOMMU page fault once the IOMMU
> > >> driver gets attached. This worked before applying this patch, because
> > >> the power domain of display controller was simply turned off early
> > >> effectively reseting the display controller.
> > >
> > > I can certainly try to help to find a solution, but I believe I need
> > > some more details of what is happening.
> > >
> > > Perhaps you can point me to some relevant DTS file to start with?
> > >
> > >>
> > >> This has been discussed a bit recently:
> > >> https://lore.kernel.org/all/544ad69cba52a9b87447e3ac1c7fa8c3@disroot.org/
> > >> and I can add a workaround for this issue in the bootloaders of those
> > >> boards, but this is something that has to be somehow addressed in a
> > >> generic way.
> > >
> > > It kind of sounds like there is a missing power-domain not being
> > > described in DT for the IOMMU, but I might have understood the whole
> > > thing wrong.
> > >
> > > Let's see if we can work something out in the next few days, otherwise
> > > we need to find another way to let some genpds for these platforms to
> > > opt out from this new behaviour.
> >
> > Have you found any resolution for this? I have also noticed a boot
> > regression on one of our Tegra210 boards and bisect is pointing to this
> > commit. I don't see any particular crash, but a hang on boot.
>
> Thanks for reporting!
>
> For Exynos we opt-out from the behaviour by enforcing a sync_state of
> all PM domains upfront [1], which means before any devices get
> attached.
>
> Even if that defeats the purpose of the $subject series, this was one
> way forward that solved the problem. When the boot-ordering problem
> (that's how I understood the issue) for Exynos gets resolved, we
> should be able to drop the hack, at least that's the idea.
>
> >
> > If there is any debug we can enable to see which pmdomain is the problem
> > let me know.
>
> There aren't many debug prints in genpd that I think makes much sense
> to enable, but you can always give it a try. Since you are hanging,
> obviously you can't look at the genpd debugfs data...
>
> Note that, the interesting PM domains are those that are powered-on
> when calling pm_genpd_init(). As a start, I would add some debug
> prints in () to see which PM domains that are relevant to track.

/s/()/tegra_powergate_add()

> Potentially you could then try to power them off and register them
> accordingly with genpd. One by one, to see which of them is causing
> the problem.
>
> Another option could be to add a new genpd config flag
> (GENPD_FLAG_DONT_STAY_ON or something along those lines), that informs
> genpd to not set the genpd->stay_on in pm_genpd_init(). Then
> tegra_powergate_add() would have to set GENPD_FLAG_DONT_STAY_ON for
> those genpds that really need it.
>
> Kind regards
> Uffe
>
> [1]
> https://lore.kernel.org/all/20250711114719.189441-1-ulf.hansson@linaro.org/

