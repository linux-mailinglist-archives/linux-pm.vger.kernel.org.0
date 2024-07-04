Return-Path: <linux-pm+bounces-10602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474DF9275A2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 14:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BD0282BE6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51341AE09B;
	Thu,  4 Jul 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNCv11qt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C619409E;
	Thu,  4 Jul 2024 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094541; cv=none; b=UsyycmdmrwJ9wJfn/WkgT/v4k6KH3RaVCfoFeGpiXt+4nBvHYTmlgOLTuU7rJLInkd2NOS6FovxoJizSuyggxRllozXHwtaapJHtHOLQ9XQw7AnZZShACCAJuvdGlCzB6aanS51k82enlBvwgW2H7zn1o7pxgNqGdf7BR4/aLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094541; c=relaxed/simple;
	bh=Sy6IDYHgPf8XKe3WtHb2MUaaZ8EMExF1AN4pG9iz1S8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKm2EOJO4qClTD+7D8NpJhHt664fM9usEFFPQKiMWwvXY5A4rYGlk+VD63BXXpoGxffGpD+RSzALts6MhyEhk01JKtfkNvySI/sl4Za6Y1u58sTtQ5Pchn4NuoZbrfpgW7v1ZSjNvC5VjPNEm/0SxFU2Il+IxBA6uRQc7La73bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNCv11qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BFDC4AF1D;
	Thu,  4 Jul 2024 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720094540;
	bh=Sy6IDYHgPf8XKe3WtHb2MUaaZ8EMExF1AN4pG9iz1S8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iNCv11qt9ePmqAuMW8uUfuzNzF6tsSDb6lAXurGr9AJmo8z8m90621twv6pX8WwUH
	 Ve+1dTdxgRe79dgI2nUWm+esEeb+bXoNgN7s2je7hDrTuMuwhQZ3N+CzuLTcJGoz9J
	 Rnws+IMhP7Sb0PXo/W1nwmwqr6k9L5mb0frp0FfYRfie2uuB1zmITD6g2wMk4gE46e
	 L7W3Y8faWoENSgK3lRPBS+GJNE7NpnJ017UioXGVkgjebrpXm+h92NGOWAAWDIystH
	 Du7G8n0R+6mgfoM6vpHVeWjCzgzrDNr6bZwR+2uH6eHNoPt/RcNi53Yr6dOgHRKD2l
	 DdKIJOC2JLS7w==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c2247207a9so10860eaf.2;
        Thu, 04 Jul 2024 05:02:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXskQeEjeBtOXUFqCtIXfU2JSCHcePRzxm4fZQa+iM1ex6FY/Z5DEhdRoR/jXMHYMKWYBXf6NV74DKMxlg/jybLYsHPZJkNtJ5utAnmYzMiphha5t7W2pOB5UJ+ErtHtrepw9KWxlOwOj0ZU4G73VYVURD53jbkeINJUYfBxbVNBJHHYyWR8cna2/ANZY/AQ7cDlHB+CnMjIAXEtUB127EIi4beAU7kyzWc4BRiKNKHDvbH6frAXyXY6V7nSITPrK1dyVQ+1c5+rfSFdem7T2voSa8zCq6bfc2B0w==
X-Gm-Message-State: AOJu0Yy3nl1pN1H2E19yDMo++0zhCSnj4vA5gyBH4k3qbn0a/82jb+Xq
	QdGTaBDnVXqqZsL4cCO65l2/3cSBuyR+KdR1HmuICrlXyWhauljRlLPvxkYd1Cu49RoBx3dATme
	KUB2hDvJcjwd+ge4mCOvYGPHCjEs=
X-Google-Smtp-Source: AGHT+IEfXE0YhC0CadkHrUUKROvpyKyoONSuJxCmj7JBStJTkzTzhM7c6J8p1w9Caa82QdMwYxDdg2XwqcNfaJBeOS0=
X-Received: by 2002:a05:6820:2c07:b0:5c4:5cbf:a255 with SMTP id
 006d021491bc7-5c646a9379emr1242627eaf.0.1720094539244; Thu, 04 Jul 2024
 05:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720075640.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1720075640.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jul 2024 14:02:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hvA3WvhXgKB0qAL_vXy1sJxeRJid=yfTcgePYGqX8uyg@mail.gmail.com>
Message-ID: <CAJZ5v0hvA3WvhXgKB0qAL_vXy1sJxeRJid=yfTcgePYGqX8uyg@mail.gmail.com>
Subject: Re: [PATCH 0/4] cpufreq: Make cpufreq_driver->exit() return void
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Cristian Marussi <cristian.marussi@arm.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Hector Martin <marcan@marcan.st>, Huang Rui <ray.huang@amd.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Kevin Hilman <khilman@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Markus Mayer <mmayer@broadcom.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Perry Yuan <perry.yuan@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-omap@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org, 
	Lizhe <sensor1010@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 8:54=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> Make exit() return void, since it isn't used by the core.
>
> Based on initial patches sent by Lizhe [1].
>
> Rafael, I will take this through my tree for 6.11.

Sure.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for the series.

Thanks!

> --
> Viresh
>
> [1] https://lore.kernel.org/all/20240410132132.3526-1-sensor1010@163.com/
>
> Lizhe (1):
>   cpufreq: Make cpufreq_driver->exit() return void
>
> Viresh Kumar (3):
>   cpufreq: nforce2: Remove empty exit() callback
>   cpufreq: loongson2: Remove empty exit() callback
>   cpufreq: pcc: Remove empty exit() callback
>
>  drivers/cpufreq/acpi-cpufreq.c         |  4 +---
>  drivers/cpufreq/amd-pstate.c           |  7 ++-----
>  drivers/cpufreq/apple-soc-cpufreq.c    |  4 +---
>  drivers/cpufreq/bmips-cpufreq.c        |  4 +---
>  drivers/cpufreq/cppc_cpufreq.c         |  3 +--
>  drivers/cpufreq/cpufreq-dt.c           |  3 +--
>  drivers/cpufreq/cpufreq-nforce2.c      |  6 ------
>  drivers/cpufreq/e_powersaver.c         |  3 +--
>  drivers/cpufreq/intel_pstate.c         |  8 +++-----
>  drivers/cpufreq/loongson2_cpufreq.c    |  6 ------
>  drivers/cpufreq/mediatek-cpufreq-hw.c  |  4 +---
>  drivers/cpufreq/mediatek-cpufreq.c     |  4 +---
>  drivers/cpufreq/omap-cpufreq.c         |  3 +--
>  drivers/cpufreq/pasemi-cpufreq.c       |  6 ++----
>  drivers/cpufreq/pcc-cpufreq.c          |  6 ------
>  drivers/cpufreq/powernow-k6.c          |  5 ++---
>  drivers/cpufreq/powernow-k7.c          |  3 +--
>  drivers/cpufreq/powernow-k8.c          |  6 ++----
>  drivers/cpufreq/powernv-cpufreq.c      |  4 +---
>  drivers/cpufreq/ppc_cbe_cpufreq.c      |  3 +--
>  drivers/cpufreq/qcom-cpufreq-hw.c      |  4 +---
>  drivers/cpufreq/qoriq-cpufreq.c        |  4 +---
>  drivers/cpufreq/scmi-cpufreq.c         |  4 +---
>  drivers/cpufreq/scpi-cpufreq.c         |  4 +---
>  drivers/cpufreq/sh-cpufreq.c           |  4 +---
>  drivers/cpufreq/sparc-us2e-cpufreq.c   |  3 +--
>  drivers/cpufreq/sparc-us3-cpufreq.c    |  3 +--
>  drivers/cpufreq/speedstep-centrino.c   | 10 +++-------
>  drivers/cpufreq/tegra194-cpufreq.c     |  4 +---
>  drivers/cpufreq/vexpress-spc-cpufreq.c |  5 ++---
>  include/linux/cpufreq.h                |  2 +-
>  31 files changed, 37 insertions(+), 102 deletions(-)
>
> --
> 2.31.1.272.g89b43f80a514
>
>

