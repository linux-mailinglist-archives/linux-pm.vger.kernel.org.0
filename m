Return-Path: <linux-pm+bounces-20890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B592A1AA75
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 20:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53FA7A1302
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F451ADC77;
	Thu, 23 Jan 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE9Gsa7i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6D155A59;
	Thu, 23 Jan 2025 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661268; cv=none; b=CPyl1xjhZ8cmjQm08UUuT8atB2puCqPvlY7KgHwDLkBQAWrlOnDU5SYf+wUPU2GRzJAfEAEbKuZ+gFAIdlWAWsjXttd2mNgUVg5pd3ktSD6X4FLSF3HIBsOkVm2IeIaKWXYxAuqqSxQ4MmmSzoI6u8H0Bzew3CZqU9ThYPvUo54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661268; c=relaxed/simple;
	bh=FzgMlZoMTVJxW0DtNfnaS6A9Ohe9wUCQbfRzCAOE11Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5yJkdbMzFBUwiURHwk7H15e7CcavO9ccgEtONlvHTpgX5OF+wmkTKw3jbhpUdf31yie+grKV4kqZrDeVtRlDBmAa7Oo60UNBt/4vdX1DDs4R65hHvCDOLL4YuyVuZE1yZO3BIbodlV/9xy1Eijn+HI5LoOEoU1Cr8wB5FG4nMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE9Gsa7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B1EC4CEE8;
	Thu, 23 Jan 2025 19:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737661268;
	bh=FzgMlZoMTVJxW0DtNfnaS6A9Ohe9wUCQbfRzCAOE11Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GE9Gsa7iiU444KpkYxrogoBdZowGSjkyO0k7laPoPcoq6g3XxCe0poALteq4R4Zph
	 tZ3ytakM0acv90IqA3t/Tq+HIhgvttRHrxIMc4+ftcYx59CQekJex95lkIBya9MuSj
	 e8hgK78Mvi+bBQYrsrlD41mZ7vaA3+PkczkIp5mOMTvpFuEkiNLQOfTC7I53w3Jpp9
	 jdf7sxICX3pGKHys55ON+N8sg3msEwZ1hAbYoGP7MqRskWyhGBaMTolzt8pF6nm7po
	 ccEaxXFbs1MchzhtSnnv0PMPk6yc1GTQLhaCumG8Mkicq84A+N5GxqwlpPfo2bFwbT
	 FHvlAO5Y9gebg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb6b16f1a0so381760b6e.3;
        Thu, 23 Jan 2025 11:41:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2bTlj6IVKbuv5x4EDSvIGRNanZEIUIV4SY+QkTaO6HwK/WZwL9jHwYBs2fQujagHbv5Fl4Rk7vg==@vger.kernel.org, AJvYcCU7V9C0oHkHsOVNWQeSvds5ZB8Zn8ipMme4T/huVg9TUgBRpKr+5NaHQYnojJFNhxSDxKO0U0hPJAvOgA==@vger.kernel.org, AJvYcCVEOpZpIgnhBd9S709wE8X4SLZV4MHZf38NtgUP0cnkpBGSemOkDX18VwXTl84d6J/ljVpya1xIjKbdDt4=@vger.kernel.org, AJvYcCVVLQzQuckYdqBT7vUAi4h2DLKBPW9GwDjB2JN0RIZRhPehhbHgqzYvUQNhaucAEnAgRHD+vix08Yg=@vger.kernel.org, AJvYcCWjHOipYRO8UWvtWC0574+bR1bdO46PQ11F0elZ6iqzUQ6jBBPaS+uegoI1APLmurCYvTlxEvTYyMtJpJoyzA==@vger.kernel.org, AJvYcCWvRZSXABQ8XXFzYzwIGUIWfijyPt5c52qC2wYjyR/3kBZ6j25cTQFQLXOp3FqOJAZ2d/NJY+jtGVGFOXLz@vger.kernel.org, AJvYcCXi2n6hf0bY/K155NUMwZYNdSb4z4QoAhQ5WJ/l66Ll9IDc4xZiDjtLYJ3IZNNJyuE8vAbh2izAid/i6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQydVp45kHcUik6JLwug7mf4qMP/UNhJLmvII6DDCas2muRxJR
	P6p1l0vK1GhRheXmhwqox3of9az6GWpA1DrW6Z45Oq3mnm3J6cpe3dalQ6GO/OjcjoEFinLpvUQ
	33Gsjx+lEXpCZAMR8typKsusTkT8=
X-Google-Smtp-Source: AGHT+IFEZLpokzQrSZWtE1aUlhzheSpv16W1XbXdM7wOE5P8c+MPFR4VPEp6oVT06Ebj/5DfcgalM7sIG87OhMAknWU=
X-Received: by 2002:a05:6808:309c:b0:3ea:519e:cc71 with SMTP id
 5614622812f47-3f19fd7beb4mr15987065b6e.39.1737661267410; Thu, 23 Jan 2025
 11:41:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737631669.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 20:40:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gQDxb0-a5HiEa0vyWCGz01esQBy1fJ4vNXDZJ=GW1W+Q@mail.gmail.com>
X-Gm-Features: AWEUYZmJBrMCqL-riW-i0DlJyFI1cRh2mxShaIBztS2B8ipvq-I9aavy-zqQjVc
Message-ID: <CAJZ5v0gQDxb0-a5HiEa0vyWCGz01esQBy1fJ4vNXDZJ=GW1W+Q@mail.gmail.com>
Subject: Re: [PATCH 00/33] cpufreq: manage common sysfs attributes from core
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Cristian Marussi <cristian.marussi@arm.com>, 
	Fabio Estevam <festevam@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Hector Martin <marcan@marcan.st>, Huacai Chen <chenhuacai@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Kevin Hilman <khilman@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Markus Mayer <mmayer@broadcom.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Sven Peter <sven@svenpeter.dev>, 
	Thierry Reding <thierry.reding@gmail.com>, WANG Xuerui <kernel@xen0n.name>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, arm-scmi@vger.kernel.org, 
	asahi@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-omap@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 12:38=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> Hello,
>
> Most of the drivers add available and boost frequencies related attribute=
s. This
> patch series tries to avoid duplication and simplify driver's code by man=
aging
> these from core code.
>
> A quick search revealed that only the drivers that set the
> policy->freq_table field, enable these attributes. Which makes sense as
> well, since the show_available_freqs() helper works only if the
> freq_table is present.
>
> In order to simplify drivers, create the relevant sysfs files forcefully
> from cpufreq core.
>
> Pushed here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/core=
-attr

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for the series.

Thanks!

> --
> Viresh
>
> Viresh Kumar (33):
>   cpufreq: Always create freq-table related sysfs file
>   cpufreq: dt: Stop setting cpufreq_driver->attr field
>   cpufreq: acpi: Stop setting common freq attributes
>   cpufreq: apple: Stop setting cpufreq_driver->attr field
>   cpufreq: bmips: Stop setting cpufreq_driver->attr field
>   cpufreq: brcmstb: Stop setting common freq attributes
>   cpufreq: davinci: Stop setting cpufreq_driver->attr field
>   cpufreq: e_powersaver: Stop setting cpufreq_driver->attr field
>   cpufreq: elanfreq: Stop setting cpufreq_driver->attr field
>   cpufreq: imx6q: Stop setting cpufreq_driver->attr field
>   cpufreq: kirkwood: Stop setting cpufreq_driver->attr field
>   cpufreq: longhaul: Stop setting cpufreq_driver->attr field
>   cpufreq: loongson: Stop setting cpufreq_driver->attr field
>   cpufreq: mediatek: Stop setting cpufreq_driver->attr field
>   cpufreq: omap: Stop setting cpufreq_driver->attr field
>   cpufreq: p4: Stop setting cpufreq_driver->attr field
>   cpufreq: pasemi: Stop setting cpufreq_driver->attr field
>   cpufreq: pmac: Stop setting cpufreq_driver->attr field
>   cpufreq: powernow: Stop setting cpufreq_driver->attr field
>   cpufreq: powernv: Stop setting common freq attributes
>   cpufreq: qcom: Stop setting cpufreq_driver->attr field
>   cpufreq: qoriq: Stop setting cpufreq_driver->attr field
>   cpufreq: sc520_freq: Stop setting cpufreq_driver->attr field
>   cpufreq: scmi: Stop setting cpufreq_driver->attr field
>   cpufreq: scpi: Stop setting cpufreq_driver->attr field
>   cpufreq: sh: Stop setting cpufreq_driver->attr field
>   cpufreq: spear: Stop setting cpufreq_driver->attr field
>   cpufreq: speedstep: Stop setting cpufreq_driver->attr field
>   cpufreq: tegra: Stop setting cpufreq_driver->attr field
>   cpufreq: vexpress: Stop setting cpufreq_driver->attr field
>   cpufreq: virtual: Stop setting cpufreq_driver->attr field
>   cpufreq: Remove cpufreq_generic_attrs
>   cpufreq: Stop checking for duplicate available/boost freq attributes
>
>  drivers/cpufreq/acpi-cpufreq.c         |  1 -
>  drivers/cpufreq/apple-soc-cpufreq.c    |  8 --------
>  drivers/cpufreq/bmips-cpufreq.c        |  1 -
>  drivers/cpufreq/brcmstb-avs-cpufreq.c  |  1 -
>  drivers/cpufreq/cpufreq-dt.c           |  8 --------
>  drivers/cpufreq/cpufreq.c              | 15 +++++++++++++++
>  drivers/cpufreq/davinci-cpufreq.c      |  1 -
>  drivers/cpufreq/e_powersaver.c         |  1 -
>  drivers/cpufreq/elanfreq.c             |  1 -
>  drivers/cpufreq/freq_table.c           |  8 --------
>  drivers/cpufreq/imx6q-cpufreq.c        |  1 -
>  drivers/cpufreq/kirkwood-cpufreq.c     |  1 -
>  drivers/cpufreq/longhaul.c             |  1 -
>  drivers/cpufreq/loongson2_cpufreq.c    |  1 -
>  drivers/cpufreq/loongson3_cpufreq.c    |  1 -
>  drivers/cpufreq/mediatek-cpufreq-hw.c  |  1 -
>  drivers/cpufreq/mediatek-cpufreq.c     |  1 -
>  drivers/cpufreq/omap-cpufreq.c         |  1 -
>  drivers/cpufreq/p4-clockmod.c          |  1 -
>  drivers/cpufreq/pasemi-cpufreq.c       |  1 -
>  drivers/cpufreq/pmac32-cpufreq.c       |  1 -
>  drivers/cpufreq/pmac64-cpufreq.c       |  1 -
>  drivers/cpufreq/powernow-k6.c          |  1 -
>  drivers/cpufreq/powernow-k7.c          |  1 -
>  drivers/cpufreq/powernow-k8.c          |  1 -
>  drivers/cpufreq/powernv-cpufreq.c      |  2 --
>  drivers/cpufreq/qcom-cpufreq-hw.c      |  7 -------
>  drivers/cpufreq/qoriq-cpufreq.c        |  1 -
>  drivers/cpufreq/sc520_freq.c           |  1 -
>  drivers/cpufreq/scmi-cpufreq.c         |  8 --------
>  drivers/cpufreq/scpi-cpufreq.c         |  1 -
>  drivers/cpufreq/sh-cpufreq.c           |  1 -
>  drivers/cpufreq/spear-cpufreq.c        |  1 -
>  drivers/cpufreq/speedstep-centrino.c   |  1 -
>  drivers/cpufreq/speedstep-ich.c        |  1 -
>  drivers/cpufreq/speedstep-smi.c        |  1 -
>  drivers/cpufreq/tegra186-cpufreq.c     |  1 -
>  drivers/cpufreq/tegra194-cpufreq.c     |  1 -
>  drivers/cpufreq/vexpress-spc-cpufreq.c |  1 -
>  drivers/cpufreq/virtual-cpufreq.c      |  1 -
>  include/linux/cpufreq.h                |  1 -
>  41 files changed, 15 insertions(+), 75 deletions(-)
>
> --
> 2.31.1.272.g89b43f80a514
>

