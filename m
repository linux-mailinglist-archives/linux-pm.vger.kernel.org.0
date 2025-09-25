Return-Path: <linux-pm+bounces-35426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C7BA1CCF
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 00:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8084F1C2773B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F839322767;
	Thu, 25 Sep 2025 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jo5lPm05"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE7321F27
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839502; cv=none; b=c6RRvaqW0wX4uckC0gzPnrLUdellu35+zB6COVJG7UAAagDq2rd2ZkDYaDavzivTGHfPww3TPhvsE1vfu6C4JewPRwmyltslTFbAnBtzLjyKegDIkQJh4SOU+PYyF1SpvRxxsmu3alWc0qXYbMHwlu6Y5tmrLtvJRQW8eBEyrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839502; c=relaxed/simple;
	bh=51K/RWydM2PjyVWXirdBujcKFN1Wi7wrBw7jteFADDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMkP3mQemQXa+s+1ZsQOJkcBT7S1dp6KauMOhoSQUXM4BfJHOOH3Kz2Aka2DlqlUXZjGtiUR/ZCLmfaIBPxBceDFjTnsaJiG/8PJXyzRTucccvUppnMcQjW1H0TUG2STY24C6NEqb6lWHmyDAXBsRjczHgjgPZgZCbj249pgMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jo5lPm05; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-59c662bd660so626854137.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758839499; x=1759444299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8gdJ7wKziz18TkLvoXgJuOhaMotEm6Z4D28IrFTO2s=;
        b=jo5lPm05a6rpbYb6JiOfO1eURV1VauxR+Yai7yRqZRg7KQr4kT+SkkhZch8OSrKzeO
         6I/2UfKWTBVZTWO+bWa+gS7m9GPZDygr/TQ1iDIrm81gwhUGQSubUYa8/svnjhLoJM2z
         lQ/HaMlHMVh/mu6M/z4+Eg7tYRkmNxQkcX66OqayE8YkRgkBqrmgzC5fmyp+scDVoOua
         cL4TVNqI/yvSk4hISEhgZSgUSfudUVrD2a2ohmVDcLYZUfnrYwzbFJYILjgo+ohAZZM0
         ARZpjutc/geXYRnl9OAkhP22kCZb4jKAsFgILqnt7eOL2TMiXAZZZ5uYZvgUUlMp3ELd
         h8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758839499; x=1759444299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8gdJ7wKziz18TkLvoXgJuOhaMotEm6Z4D28IrFTO2s=;
        b=dQ+PBlO2/oOiY1w8W2bMdvguByaw3gAwj51MzNVschzbklNCb62bgveGUIn+VIjg7D
         zEABtLaocfpMhM192YC2zXfpdINLkAAL1LehXA3VvqtAdgUUi3uwQa82ZOr0IkMKw1eF
         PzoHdkyffXfdtPe5PLPV4NVfpJ/U/ZvHjo0UOhmC8SEg7oD3OrMPb62hj2g/lfiYHA8M
         zlR1Wfac1x4HD/JtYZZ3KVTVgVOY+tIy7FcvAC83/e06DLiOKTJ8cDKVr90CjaNkU6VL
         zn4HiwfKYKAXatCDfbZSrd47IMmmBjq8WjS7fLBEDtenJkHTJcujwK0w+Z3EwAylFU7M
         SJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCW2e18ypjkaf50Qs7KPTJicaUBgvKiAJ8t8tSvaVh5dzfQBnEPWWohCPzUWGT4ioeSqHhaf3kDipA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2QSQZvMR4bk24VjsdSgf4KKgHw44cwouvfDyDrjldAkCTrWo7
	X5wlG3/S3HJ5g+5qP99DDUWsHiz7ldgRGtmx/1D5d2IhblAV2L0yKBWmRgLZklX7kP0SEgi/VJ3
	tf4uBu22o8f72Skg/fmFdxLnUGdmRHQyuV7I5KOwa
X-Gm-Gg: ASbGnctmnC/RYQFAJTqQlw6cuKP+DmVfTqfXDE1531C95LNQ8Bv038bdWmkn+akeXT0
	dIrhG8IqDk++BywGZ8qeBrcv0lD5yAUjszKr3nVJWS+aWIHXu+DROe0cRTWt5XBJ8qKan7HrA1Y
	DQwt1sNNboeYEVZZl4wSL9RpyQ3FsAU14ndFGZQzvByXLUbDGCG0p3RvXsvmFxPU7ErKUsbrUks
	GmyU+nhfCOddjdX89j7OMhucTQ7Hg/xaFh80Y8kuJ2B
X-Google-Smtp-Source: AGHT+IFLlk6iDpEvaZjhHPcTDawfBx/XYJFVbUN5Hu8c0lEpBCCCVTWZi91ZCI4VwGOJE/tK3T8mihQAbe8ugPAiQBI=
X-Received: by 2002:a05:6102:5488:b0:5a2:8ace:c921 with SMTP id
 ada2fe7eead31-5acc4a1eaefmr2368837137.4.1758839499299; Thu, 25 Sep 2025
 15:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-21-ulf.hansson@linaro.org> <4478f28b-47f8-4049-bf17-b7fc95cfac65@nvidia.com>
 <CAPDyKFqSyP3e=JRFYEuFefWVN5SYJWULU8SKzXmrThvyiVGXgg@mail.gmail.com>
 <a904d953-acb2-44f6-81bd-118f7abd22da@nvidia.com> <614f726c-4d6d-463b-a8b3-26d3df590575@nvidia.com>
In-Reply-To: <614f726c-4d6d-463b-a8b3-26d3df590575@nvidia.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 25 Sep 2025 15:31:02 -0700
X-Gm-Features: AS18NWACHkwlAZcjEriaXRqurBvXndQI9uNxb7x206sV9Gbmg4UhlXtVn8x_XjM
Message-ID: <CAGETcx9CpOgtPSDK_qPRQ_u58w3fedSFAfFzugXW4eYq2TLECw@mail.gmail.com>
Subject: Re: [PATCH v3 20/24] pmdomain: core: Default to use
 of_genpd_sync_state() for genpd providers
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
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
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:41=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
> Hi Ulf,
>
> On 03/09/2025 13:33, Jon Hunter wrote:
>
> ...
>
> >>> Following this change I am seeing the following warning on our Tegra1=
94
> >>> devices ...
> >>>
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 17000000.gpu
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 3960000.=
cec
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 15380000.nvjpg
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 154c0000.nvenc
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 15a80000.nvenc
> >>>
> >>> Per your change [0], the 'GENPD_FLAG_NO_SYNC_STATE' is set for Tegra
> >>> and so should Tegra be using of_genpd_sync_state() by default?
> >>
> >> This is a different power-domain provider (bpmp) in
> >> drivers/firmware/tegra/bpmp.c and
> >> drivers/pmdomain/tegra/powergate-bpmp.c.
> >>
> >> For the bpmp we don't need GENPD_FLAG_NO_SYNC_STATE, as the
> >> power-domain provider is described along with the
> >> "nvidia,tegra186-bpmp" compatible string. In the other case
> >> (drivers/soc/tegra/pmc.c) the "core-domain" and "powergates" are
> >> described through child-nodes, while ->sync_state() is managed by the
> >> parent-device-node.
> >>
> >> In the bpmp case there is no ->sync_state() callback assigned, which
> >> means genpd decides to assign a default one.
> >>
> >> The reason for the warnings above is because we are still waiting for
> >> those devices to be probed, hence the ->sync_state() callback is still
> >> waiting to be invoked. Enforcing ->sync_state() callback to be invoked
> >> can be done via user-space if that is needed.
> >>
> >> Did that make sense?
> >
> > Sorry for the delay, I was on vacation. Yes makes sense and drivers for
> > some of the above drivers are not yet upstreamed to mainline and so thi=
s
> > would be expected for now.
>
>
> I have been doing more testing and do see a lot of "tegra-bpmp bpmp:
> sync_state() pending due to" on our platforms for basically are driver
> that is built as a module.

It being "built as a module" is not reason enough for this warning to
happen though. One of the main points of fw_devlink is for things to
work just as well with modules.

In this particular system, do you never plan to load the modules? Or
is the module load just missing this timeout by a few seconds or
something?

If these can be turned off, why not turn these off using the sysfs
file or the timeout commandline option to turn them off? You are
burning power by leaving these on. A warning seems appropriate to me.

-Saravana

