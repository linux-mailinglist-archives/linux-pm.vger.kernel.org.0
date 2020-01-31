Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E442514ED55
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 14:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAaNaR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 08:30:17 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55018 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgAaNaR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2020 08:30:17 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200131133015euoutp01c7d6bbe78d050b0649b1d5a2c0ff5fa7~u_9XkvloD2621926219euoutp01A
        for <linux-pm@vger.kernel.org>; Fri, 31 Jan 2020 13:30:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200131133015euoutp01c7d6bbe78d050b0649b1d5a2c0ff5fa7~u_9XkvloD2621926219euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580477415;
        bh=g13mPe4nf3idGfvJQ2ydGWAXeGHLTZ8oPYtzoeqs5LY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GW3i3YYEJ50DA+0PVExSi8C5hE/6o1fxI8z+Ir2hbJl4vzRs7oUB0ChYNvOrSNUtL
         0QLkBXuRJtdeCMtPgVf7oPbVSiBoVSIk96jPpJl2WROMM3KNTy5Zbi31D8ER1P3XWE
         BJ/QVaGng2y0PIMu5cAcYyfDmwgSEkTGZcwveXT8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200131133015eucas1p1dd95266c4d8994df5020a79c3e0d1097~u_9XX1ksG2448924489eucas1p1M;
        Fri, 31 Jan 2020 13:30:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C5.5C.60679.7EB243E5; Fri, 31
        Jan 2020 13:30:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200131133014eucas1p2cf8535b64a82ba502c0a6fcedbce917d~u_9XBPE3P3081530815eucas1p2r;
        Fri, 31 Jan 2020 13:30:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200131133014eusmtrp25b641f1be51f837f7f828f2bae03fb20~u_9XAcZvI2149521495eusmtrp2L;
        Fri, 31 Jan 2020 13:30:14 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-6a-5e342be7ca6e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.DC.07950.6EB243E5; Fri, 31
        Jan 2020 13:30:14 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200131133014eusmtip29a5eb72927f4750e0f92b9b7aa874d74~u_9WZt2xT1363513635eusmtip2e;
        Fri, 31 Jan 2020 13:30:14 +0000 (GMT)
Subject: Re: [PATCH 3/3] ARM: exynos_defconfig: Enable Energy Model
 framework
To:     lukasz.luba@arm.com
Cc:     kgene@kernel.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        dietmar.eggemann@arm.com
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d14546d5-0cd8-c441-c2be-cdeefc8ebb8d@samsung.com>
Date:   Fri, 31 Jan 2020 14:30:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200127215453.15144-4-lukasz.luba@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH973nxz2s43Hc7jNM6xpTza/44ylNtdV2pi3rx2ZIXXmGOHSH
        6I/IKMlFSvRkyBJuFl3HhSW/ljW/Zi1KZuVHV3J/+LE2hDwelv9en+/n/Xl/Pu/tS2HSPsKR
        iolPYjXxqjgFaY03vV8a8DAf8Ivw1n0nmJFFM8GUdw8QzHRBI8bkT/7GmMHBBjHTnzkrZgyT
        wwTzsaWUZBZ03YgpGWwTMc8ys8RM1ciQiPl6q4Zkst92i4/ZKOvK6pDSoL9LKl8/T1feN+qR
        csHgEkyEWh+JZONiUliNV8Al6+hio1mUyMlSOzpNWAZqs8tFVhTQfjD8p4zIRdaUlK5BkLvS
        vlUsIsizrONCsYDA9LgIbY+Y5zmCZyldjaBMFySILAjWs1tFfMOePg0z7fmb7EDLoYAz4jxj
        9KgIajvceSbpw/Dgjn7TVEIHQFth/6Yep12huKlezLOMDoH5b12EoLGDD0+mNn2s6ENgKJkX
        CZ5yGJ0q3+LdYLKUYvxBQFvEMP3l08YCaqM4AfVdrkIAe5jpMYoFdob1Zn6W179EsJrzc2vY
        hKD64RopqPxhbGCZ5I0weh/Ut3gJz8ehvnIVF/xt4LPFTrjBBgqbijHhWQI5t6WC2g0aXjSQ
        22tzm2uxAqTgdiTjdqThdqTh/u+tQLgeydlkrTqK1R6MZ697alVqbXJ8lOeVBLUBbfyx3rWe
        xTeo5e/lTkRTSLFLkujkFyElVCnaNHUnAgpTOEhkJ30ipJJIVdoNVpNwUZMcx2o7kROFK+QS
        38pfF6R0lCqJjWXZRFaz3RVRVo4ZCCNNaSKW5cLrMrNePV05Ndp8L6W36geE2gZXuHjrxoKO
        VuqyzYF7roWwRARz1udc8EBfWLFTQEha/1zgo7nYm55uQ7YeRY029g6T4VzU07ChEvzM+nhe
        Yar8asi4r3q5F2vLm3fWi12XZmOTJ1R7fdzT/SlwfzfRKpOcNy4rcG20ymc/ptGq/gHQIDF7
        XwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xe7rPtE3iDCZ9V7O4/uU5q8X8I+dY
        LZ5O2Mps0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i6XXLzJZ
        3G5cwWbRuvcIuwOfx5p5axg9Nq3qZPPYvKTeo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWi
        DS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKmb3nOVDBLtOLgoe3MDYz7BLsY
        OTkkBEwknn+axdrFyMUhJLCUUaLnRjNjFyMHUEJG4vj6MogaYYk/17rYQGwhgdeMEid+1oLY
        wgK+Emu+32YGsUUExCUmzNrCAjKHWeAWk8THSe3sEEN3M0ocev+CEaSKTcBKYmL7KjCbV8BO
        Yt+ks0wgNouAqsT0bevZQWxRgQiJwztmQdUISpyc+YQFxOYUsJTYNOMTWD2zgLrEn3mXmCFs
        cYlbT+ZDxeUltr+dwzyBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k
        /NxNjMDI3Xbs55YdjF3vgg8xCnAwKvHwFkibxAmxJpYVV+YeYpTgYFYS4RV1NYwT4k1JrKxK
        LcqPLyrNSS0+xGgK9NxEZinR5HxgUskriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2a
        WpBaBNPHxMEp1cC4+XZPkTOz7Z8n+Ua5XuoM4iKL3s3mYA1lPTW7bcOs6U2Xs54kSvvtO+6U
        xpw36dZ2u6rXQvc2a23tZcjO17jJftWKLVg7Nyibz3/xi2VX5liZH6h2Srljbvt0Vm/mM885
        ka+S/Cd+qklLquN7u2zdtOsPKu8tmH9yhcTSzVur6pVMup3PPjFVYinOSDTUYi4qTgQA5IpC
        //ICAAA=
X-CMS-MailID: 20200131133014eucas1p2cf8535b64a82ba502c0a6fcedbce917d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200127215538eucas1p2b8d4886de6f59f6a62257d3d66307c73
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200127215538eucas1p2b8d4886de6f59f6a62257d3d66307c73
References: <20200127215453.15144-1-lukasz.luba@arm.com>
        <CGME20200127215538eucas1p2b8d4886de6f59f6a62257d3d66307c73@eucas1p2.samsung.com>
        <20200127215453.15144-4-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

On 1/27/20 10:54 PM, lukasz.luba@arm.com wrote:
> From: Lukasz Luba <lukasz.luba@arm.com>
> 
> Enable the Energy Model (EM) brings possibility to use Energy Aware
> Scheduler (EAS). This compiles the EM but does not enable to run EAS in
> default. The EAS only works with SchedUtil - a CPUFreq governor which
> handles direct requests from the scheduler for the frequency change. Thus,
> to make EAS working in default, the SchedUtil governor should be
> configured as default CPUFreq governor. Although, the EAS might be enabled
> in runtime, when the EM is present for CPUs, the SchedUtil is compiled and
> then set as CPUFreq governor, i.e.:
> 
> echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> echo schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
> 
> To check if EAS is ready to work, the read output from the command below
> should show '1':
> cat /proc/sys/kernel/sched_energy_aware
> 
> To disable EAS in runtime simply 'echo 0' to the file above.
> 
> Some test results, which stress the scheduler on Odroid-XU3:
> hackbench -l 500 -s 4096
> With mainline code and with this patch set.
> 
> The tests have been made with and without CONFIG_PROVE_LOCKING (PL)
> (which is set to =y in default exynos_defconfig)
> 
> 		|		this patch set			| mainline
> 		|-----------------------------------------------|---------------
> 		| performance	| SchedUtil	| SchedUtil	| performance
> 		| governor	| governor	| governor	| governor
> 		|		| w/o EAS	| w/ EAS	|
> ----------------|---------------|---------------|---------------|---------------
> hackbench w/ PL | 12.7s		| 11.7s		| 12.0s		| 13.0s - 12.2s
> hackbench w/o PL| 9.2s		| 8.1s		| 8.2s		| 9.2s - 8.4s

Would you happen to have measurements of how much power is
saved by running hackbench using "SchedUtil governor w/ EAS"
instead of "SchedUtil governor w/o EAS"?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 1db857056992..c0f8ecabc607 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -18,6 +18,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
> +CONFIG_ENERGY_MODEL=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
