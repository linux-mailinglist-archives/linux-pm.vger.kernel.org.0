Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8814ECB2
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 13:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgAaMrx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 07:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbgAaMrx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jan 2020 07:47:53 -0500
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55550214D8;
        Fri, 31 Jan 2020 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580474872;
        bh=zUVGVuT/slEg9NfW81Qpk5tDo3UxUZ/3h0IpAViw9gg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OqwJM7IGkbZ1uFh4KlR7ZdMt6WePCl41DIjNCy1y4wOuwRwRQUGX7XERZg0fW1Awl
         qzMPoAuqd4Tdrblb8yRQXWayPt3MO7nM89SYL5LYCRdYTItn37u0VDFMJArjgZWRMs
         g5cjHy5Zu+RMHjS4iItbIy1ktzcDsNUCSeZH8yzU=
Received: by mail-lj1-f177.google.com with SMTP id x7so7000300ljc.1;
        Fri, 31 Jan 2020 04:47:52 -0800 (PST)
X-Gm-Message-State: APjAAAUqphwe3HRNS4pc+jhGV6WABrC3l79V3ygZUmBJOOdxucFL7W4N
        v3v0fHb1u3vF4yoOtmCL3BdQlIYydBF7MiXfTu8=
X-Google-Smtp-Source: APXvYqz9+Y6RQt0gt8PATpeqqazsTkQ4mtFx4O+38Nhe+xGu6lufag13gYVF/5Mi0zj+NjLUD5c9sYtx8skheC/3Qe8=
X-Received: by 2002:a2e:9c85:: with SMTP id x5mr5970504lji.50.1580474870430;
 Fri, 31 Jan 2020 04:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20200127215453.15144-1-lukasz.luba@arm.com> <20200127215453.15144-2-lukasz.luba@arm.com>
In-Reply-To: <20200127215453.15144-2-lukasz.luba@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 31 Jan 2020 13:47:39 +0100
X-Gmail-Original-Message-ID: <CAJKOXPedRc3ag6DDUAXSbHk8JcAZbug5HSss9wb8YyLkP7MLaw@mail.gmail.com>
Message-ID: <CAJKOXPedRc3ag6DDUAXSbHk8JcAZbug5HSss9wb8YyLkP7MLaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: exynos_defconfig: Enable SCHED_MC
To:     lukasz.luba@arm.com
Cc:     kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 Jan 2020 at 22:55, <lukasz.luba@arm.com> wrote:
>
> From: Lukasz Luba <lukasz.luba@arm.com>
>
> Since the 'capacities-dmips-mhz' are present in the CPU nodes, make use of
> this knowledge in smarter decisions during scheduling.
>
> The values in 'capacities-dmips-mhz' are normilized, this means that i.e.
> when CPU0's capacities-dmips-mhz=100 and CPU1's 'capacities-dmips-mhz'=50,
> cpu0 is twice fast as CPU1, at the same frequency. The proper hirarchy
> in sched_domain topology could exploit the SoC architecture advantages
> like big.LITTLE.

I do not quite get how this is related to rationale behind changing defconfig...

> Enabling the SCHED_MC will create two levels in
> sched_domain hierarchy, which might be observed in:

This is looks more convincing... but still what is the need? To work with EAS?

> grep . /proc/sys/kernel/sched_domain/cpu*/domain*/{name,flags}
> /proc/sys/kernel/sched_domain/cpu0/domain0/name:MC
> /proc/sys/kernel/sched_domain/cpu0/domain1/name:DIE
> ...
> /proc/sys/kernel/sched_domain/cpu0/domain0/flags:575
> /proc/sys/kernel/sched_domain/cpu0/domain1/flags:4223

Not related to defconfig change and not visible after this commit.

Best regards,
Krzysztof

>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index e7e4bb5ad8d5..1db857056992 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -8,6 +8,7 @@ CONFIG_PERF_EVENTS=y
>  CONFIG_ARCH_EXYNOS=y
>  CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND=y
>  CONFIG_SMP=y
> +CONFIG_SCHED_MC=y
>  CONFIG_BIG_LITTLE=y
>  CONFIG_NR_CPUS=8
>  CONFIG_HIGHMEM=y
> --
> 2.17.1
>
