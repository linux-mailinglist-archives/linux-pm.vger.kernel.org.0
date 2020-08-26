Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3536E253003
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 15:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgHZNdn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 09:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgHZNcn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 09:32:43 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46318C061574
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 06:32:43 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b16so2104170ioj.4
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 06:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barpilot-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ss1ahBsuacpjwRSXltHzxXXPlZjpMb8fBUu+mx+WaA0=;
        b=pV2YDm4gGeVOLDRs9SoD9t/ey5oo6Jn5i+yiYXajiVDqp00hf+19vn2QF6njFX2ucf
         ecfmFkg+1ejYXGBuai2oFmAfYG1WJ+HEPesLXFXHyu7nDs1CcAKuAbJS+zcmZjNd7GQT
         l8kCZQRVbxcnuNsCyV/78ljoJ2BESDoK+I9r7/7KVxfvmLK8eHwBSI23zIB5ztr/Zts7
         JLbkD87muiOgdeK0rpdH//kdkj/Q/Bu5NshHUs5vEXfFrrglmVt2IaVHfkyqmMfBRtzj
         7R+xbfsjPfm0X8NwiOkDcWaDcNffD8QPJ06KTXGUfNtr1EIib7DPxImjGJkBsipQ+liW
         vB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ss1ahBsuacpjwRSXltHzxXXPlZjpMb8fBUu+mx+WaA0=;
        b=oAY+dj9fGgUoJ6b15oJ5byD4k1UJyQYdUKknu9qm1YvjWYEQXZ+7dh1E4UoV6aEXpQ
         iptVeBMsSwiPD0LDsuQHJdCFGx7kLVSByOzcHSyT28dYY2VZzfL4cKQYwkF7s9TbZe6W
         yALbLeyqs5/yol4nvOV1jKEgcwUfIEWDGSC7T7aVVi+VUp2x+yUgu6eS9iYNYNc4ePp6
         T6mmHXRJPVkckgPooZJOkJ1lwnfNuaD/mDDRlt1MfgHUex5EvXjNlaeWAIm51iXEOUhf
         JYfAp0LhDaT3PDLcfJ2UN1iK1kNbMy39cmlWgQjPJo+BIkjCTBtJqe+c2AQZ1L1v7ZrR
         yVag==
X-Gm-Message-State: AOAM530pKQJBl8cRJ0R9OpdVgA4LlR4XTbjrgfo5TbkwDQQ3rSao7mkP
        4iT3Qj6rmj18AnhYKHkL/WDz8VxF+msEmA7XaEBuOA==
X-Google-Smtp-Source: ABdhPJyifgZETWPgeEmgkWQCxtIe38cCNfUgOnfz3mne9gTA7+p1ZkpyygVpWr209UqK3E9ChtDREgSeJZxzN7X6nKY=
X-Received: by 2002:a6b:e009:: with SMTP id z9mr12846483iog.124.1598448762210;
 Wed, 26 Aug 2020 06:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
 <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com> <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
In-Reply-To: <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
From:   Guilhem Lettron <guilhem@barpilot.io>
Date:   Wed, 26 Aug 2020 15:32:31 +0200
Message-ID: <CAGX5Wg0LrzPwf=2pGrQHAbFMVkOoYDxOoFa+ZmLBYshPvZQUXg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     dedekind1@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 26 Aug 2020 at 15:18, Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Wed, 2020-08-26 at 16:16 +0300, Artem Bityutskiy wrote:
> > Just get a reasonably new turbostat (it is part of the kernel tree, you
> > can compile it yourself) and run it for few seconds (like 'turbostat
> > sleep 10'), get the output (will be a lot of it), and we can check what
> > is actually going on with regards to C-states.
>
> Oh, and if you could do that with and without your patch, we could even
> compare things. But try to do it at least with the default (acpi_idle)
> configuration.

with my patch:

turbostat version 20.03.20 - Len Brown <lenb@kernel.org>
CPUID(0): GenuineIntel 0x1b CPUID levels; 0x80000008 xlevels;
family:model:stepping 0x6:7e:5 (6:126:5)
CPUID(1): SSE3 MONITOR - EIST TM2 TSC MSR ACPI-TM HT TM
CPUID(6): APERF, TURBO, DTS, PTM, HWP, No-HWPnotify, HWPwindow,
HWPepp, HWPpkg, EPB
cpu2: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT PREFETCH TURBO)
CPUID(7): SGX
cpu2: MSR_IA32_FEATURE_CONTROL: 0x00020005 (Locked )
CPUID(0x15): eax_crystal: 2 ebx_tsc: 78 ecx_crystal_hz: 38400000
TSC: 1497 MHz (38400000 Hz * 78 / 2 / 1000000)
CPUID(0x16): base_mhz: 1500 max_mhz: 3900 bus_mhz: 100
cpu2: MSR_MISC_PWR_MGMT: 0x00401c40 (ENable-EIST_Coordination
DISable-EPB DISable-OOB)
RAPL: 17476 sec. Joule Counter Range, at 15 Watts
cpu2: MSR_PLATFORM_INFO: 0x4043cf1810f00
4 * 100.0 = 400.0 MHz max efficiency frequency
15 * 100.0 = 1500.0 MHz base frequency
cpu2: MSR_IA32_POWER_CTL: 0x0024005d (C1E auto-promotion: DISabled)
cpu2: MSR_TURBO_RATIO_LIMIT: 0x2323232323232627
35 * 100.0 = 3500.0 MHz max turbo 8 active cores
35 * 100.0 = 3500.0 MHz max turbo 7 active cores
35 * 100.0 = 3500.0 MHz max turbo 6 active cores
35 * 100.0 = 3500.0 MHz max turbo 5 active cores
35 * 100.0 = 3500.0 MHz max turbo 4 active cores
35 * 100.0 = 3500.0 MHz max turbo 3 active cores
38 * 100.0 = 3800.0 MHz max turbo 2 active cores
39 * 100.0 = 3900.0 MHz max turbo 1 active cores
cpu2: MSR_CONFIG_TDP_NOMINAL: 0x0000000d (base_ratio=13)
cpu2: MSR_CONFIG_TDP_LEVEL_1: 0x000a0060 (PKG_MIN_PWR_LVL1=0
PKG_MAX_PWR_LVL1=0 LVL1_RATIO=10 PKG_TDP_LVL1=96)
cpu2: MSR_CONFIG_TDP_LEVEL_2: 0x000f00c8 (PKG_MIN_PWR_LVL2=0
PKG_MAX_PWR_LVL2=0 LVL2_RATIO=15 PKG_TDP_LVL2=200)
cpu2: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=0)
cpu2: MSR_TURBO_ACTIVATION_RATIO: 0x0000000c (MAX_NON_TURBO_RATIO=12 lock=0)
cpu2: MSR_PKG_CST_CONFIG_CONTROL: 0x74008008 (UNdemote-C1, demote-C1,
locked, pkg-cstate-limit=8 (unlimited))
current_driver: intel_idle
current_governor: menu
current_governor_ro: menu
cpu2: POLL: CPUIDLE CORE POLL IDLE
cpu2: C1: MWAIT 0x00
cpu2: C1E: MWAIT 0x01
cpu2: C6: MWAIT 0x20
cpu2: C7s: MWAIT 0x33
cpu2: C8: MWAIT 0x40
cpu2: C9: MWAIT 0x50
cpu2: C10: MWAIT 0x60
cpu2: cpufreq driver: intel_cpufreq
cpu2: cpufreq governor: schedutil
cpufreq intel_pstate no_turbo: 0
cpu2: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch
L2-Prefetch-pair L1-Prefetch L1-IP-Prefetch)
cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
cpu0: MSR_HWP_CAPABILITIES: 0x010e0d27 (high 39 guar 13 eff 14 low 1)
cpu0: MSR_HWP_REQUEST: 0x80002727 (min 39 max 39 des 0 epp 0x80 window
0x0 pkg 0x0)
cpu0: MSR_HWP_REQUEST_PKG: 0x8000ff01 (min 1 max 255 des 0 epp 0x80 window 0x0)
cpu0: MSR_HWP_STATUS: 0x00000000 (No-Guaranteed_Perf_Change, No-Excursion_Min)
cpu0: MSR_IA32_ENERGY_PERF_BIAS: 0x00000006 (balanced)
cpu0: MSR_RAPL_POWER_UNIT: 0x000a0e03 (0.125000 Watts, 0.000061
Joules, 0.000977 sec.)
cpu0: MSR_PKG_POWER_INFO: 0x00000078 (15 W TDP, RAPL 0 - 0 W, 0.000000 sec.)
cpu0: MSR_PKG_POWER_LIMIT: 0x5a8118009d80c8 (UNlocked)
cpu0: PKG Limit #1: ENabled (25.000000 Watts, 24.000000 sec, clamp ENabled)
cpu0: PKG Limit #2: ENabled (35.000000 Watts, 10.000000* sec, clamp DISabled)
cpu0: MSR_DRAM_POWER_LIMIT: 0x5400de00000000 (UNlocked)
cpu0: DRAM Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
cpu0: MSR_PP0_POLICY: 0
cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
cpu0: Cores Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
cpu0: MSR_PP1_POLICY: 0
cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
cpu0: GFX Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x05640000 (100 C)
cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x88290800 (59 C)
cpu0: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x00000003 (100 C, 100 C)
cpu2: MSR_PKGC3_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu2: MSR_PKGC6_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu2: MSR_PKGC7_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu2: MSR_PKGC8_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu2: MSR_PKGC9_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu2: MSR_PKGC10_IRTL: 0x00000000 (NOTvalid, 0 ns)
10.003466 sec
Core CPU Avg_MHz Busy% Bzy_MHz TSC_MHz IRQ SMI POLL C1 C1E C6 C7s C8
C9 C10 POLL% C1% C1E% C6% C7s% C8% C9% C10% CPU%c1 CPU%c6 CPU%c7
CoreTmp PkgTmp GFX%rc6 GFXMHz Totl%C0 Any%C0 GFX%C0 CPUGFX% Pkg%pc2
Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10 CPU%LPI SYS%LPI
PkgWatt CorWatt GFXWatt RAMWatt PKG_% RAM_%
- - 219 8.59 2549 1498 48489 160 71 1256 11389 21414 5 31317 489 8252
0.00 0.10 1.61 17.26 0.01 52.02 0.53 19.27 16.07 26.24 49.10 56 56
96.64 300 68.29 48.58 3.08 2.10 30.36 0.04 0.00 0.00 0.00 0.00 0.00
0.00 0.00 7.38 4.91 0.07 0.00 0.00 0.00
0 0 189 5.83 3239 1498 6131 20 26 222 1922 2648 0 4232 0 298 0.00 0.20
1.97 16.85 0.00 69.76 0.00 4.51 20.30 20.57 53.30 56 56 96.64 300
68.29 48.58 3.08 2.10 30.36 0.04 0.00 0.00 0.00 0.00 0.00 0.00 0.00
7.38 4.91 0.07 0.00 0.00 0.00
0 4 397 12.02 3307 1498 4248 20 5 173 1252 1552 0 3266 2 1367 0.00
0.08 1.22 10.13 0.00 46.47 0.01 28.39 14.11
1 1 302 8.53 3545 1498 6108 20 11 155 1215 3588 0 4462 0 2 0.00 0.11
1.90 28.91 0.00 59.04 0.00 0.08 14.13 31.04 46.31 55
1 5 149 6.29 2378 1498 3953 20 8 144 1391 1710 0 3239 9 1304 0.00 0.06
1.48 10.45 0.00 49.50 0.23 31.45 16.37
2 2 159 7.86 2022 1498 3688 20 5 111 1088 1450 0 3122 1 1191 0.00 0.14
0.95 9.49 0.00 49.73 0.07 31.64 13.61 19.24 59.29 54
2 6 175 7.44 2355 1498 6107 20 4 137 1726 2424 0 3863 4 651 0.00 0.06
1.90 15.83 0.00 56.39 0.04 18.00 14.03
3 3 213 11.84 1797 1498 13814 20 7 170 1431 6125 2 5634 464 2422 0.00
0.09 1.89 34.67 0.01 31.54 3.82 16.28 16.54 34.11 37.51 52
3 7 167 8.91 1871 1498 4440 20 5 144 1364 1917 3 3499 9 1017 0.00 0.07
1.55 11.78 0.03 53.73 0.07 23.83 19.47

without (3.9-rc2):

turbostat version 20.03.20 - Len Brown <lenb@kernel.org>
CPUID(0): GenuineIntel 0x1b CPUID levels; 0x80000008 xlevels;
family:model:stepping 0x6:7e:5 (6:126:5)
CPUID(1): SSE3 MONITOR - EIST TM2 TSC MSR ACPI-TM HT TM
CPUID(6): APERF, TURBO, DTS, PTM, HWP, No-HWPnotify, HWPwindow,
HWPepp, HWPpkg, EPB
cpu1: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT PREFETCH TURBO)
CPUID(7): SGX
cpu1: MSR_IA32_FEATURE_CONTROL: 0x00020005 (Locked )
CPUID(0x15): eax_crystal: 2 ebx_tsc: 78 ecx_crystal_hz: 38400000
TSC: 1497 MHz (38400000 Hz * 78 / 2 / 1000000)
CPUID(0x16): base_mhz: 1500 max_mhz: 3900 bus_mhz: 100
cpu1: MSR_MISC_PWR_MGMT: 0x00401c40 (ENable-EIST_Coordination
DISable-EPB DISable-OOB)
RAPL: 17476 sec. Joule Counter Range, at 15 Watts
cpu1: MSR_PLATFORM_INFO: 0x4043cf1810f00
4 * 100.0 = 400.0 MHz max efficiency frequency
15 * 100.0 = 1500.0 MHz base frequency
cpu1: MSR_IA32_POWER_CTL: 0x0024005f (C1E auto-promotion: ENabled)
cpu1: MSR_TURBO_RATIO_LIMIT: 0x2323232323232627
35 * 100.0 = 3500.0 MHz max turbo 8 active cores
35 * 100.0 = 3500.0 MHz max turbo 7 active cores
35 * 100.0 = 3500.0 MHz max turbo 6 active cores
35 * 100.0 = 3500.0 MHz max turbo 5 active cores
35 * 100.0 = 3500.0 MHz max turbo 4 active cores
35 * 100.0 = 3500.0 MHz max turbo 3 active cores
38 * 100.0 = 3800.0 MHz max turbo 2 active cores
39 * 100.0 = 3900.0 MHz max turbo 1 active cores
cpu1: MSR_CONFIG_TDP_NOMINAL: 0x0000000d (base_ratio=13)
cpu1: MSR_CONFIG_TDP_LEVEL_1: 0x000a0060 (PKG_MIN_PWR_LVL1=0
PKG_MAX_PWR_LVL1=0 LVL1_RATIO=10 PKG_TDP_LVL1=96)
cpu1: MSR_CONFIG_TDP_LEVEL_2: 0x000f00c8 (PKG_MIN_PWR_LVL2=0
PKG_MAX_PWR_LVL2=0 LVL2_RATIO=15 PKG_TDP_LVL2=200)
cpu1: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=0)
cpu1: MSR_TURBO_ACTIVATION_RATIO: 0x0000000c (MAX_NON_TURBO_RATIO=12 lock=0)
cpu1: MSR_PKG_CST_CONFIG_CONTROL: 0x74008008 (UNdemote-C1, demote-C1,
locked, pkg-cstate-limit=8 (unlimited))
current_driver: intel_idle
current_governor: menu
current_governor_ro: menu
cpu1: POLL: CPUIDLE CORE POLL IDLE
cpu1: C1_ACPI: ACPI FFH MWAIT 0x0
cpu1: C2_ACPI: ACPI FFH MWAIT 0x31
cpu1: C3_ACPI: ACPI FFH MWAIT 0x60
cpu1: cpufreq driver: intel_cpufreq
cpu1: cpufreq governor: schedutil
cpufreq intel_pstate no_turbo: 0
cpu1: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch
L2-Prefetch-pair L1-Prefetch L1-IP-Prefetch)
cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
cpu0: MSR_HWP_CAPABILITIES: 0x010e0d27 (high 39 guar 13 eff 14 low 1)
cpu0: MSR_HWP_REQUEST: 0x80002727 (min 39 max 39 des 0 epp 0x80 window
0x0 pkg 0x0)
cpu0: MSR_HWP_REQUEST_PKG: 0x8000ff01 (min 1 max 255 des 0 epp 0x80 window 0x0)
cpu0: MSR_HWP_STATUS: 0x00000000 (No-Guaranteed_Perf_Change, No-Excursion_Min)
cpu0: MSR_IA32_ENERGY_PERF_BIAS: 0x00000006 (balanced)
cpu0: MSR_RAPL_POWER_UNIT: 0x000a0e03 (0.125000 Watts, 0.000061
Joules, 0.000977 sec.)
cpu0: MSR_PKG_POWER_INFO: 0x00000078 (15 W TDP, RAPL 0 - 0 W, 0.000000 sec.)
cpu0: MSR_PKG_POWER_LIMIT: 0x42817000dd8170 (UNlocked)
cpu0: PKG Limit #1: ENabled (46.000000 Watts, 28.000000 sec, clamp ENabled)
cpu0: PKG Limit #2: ENabled (46.000000 Watts, 0.002441* sec, clamp DISabled)
cpu0: MSR_DRAM_POWER_LIMIT: 0x5400de00000000 (UNlocked)
cpu0: DRAM Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
cpu0: MSR_PP0_POLICY: 0
cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
cpu0: Cores Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
cpu0: MSR_PP1_POLICY: 0
cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
cpu0: GFX Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x00640000 (100 C)
cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x881d0800 (71 C)
cpu0: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x00000003 (100 C, 100 C)
cpu1: MSR_PKGC3_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu1: MSR_PKGC6_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu1: MSR_PKGC7_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu1: MSR_PKGC8_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu1: MSR_PKGC9_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu1: MSR_PKGC10_IRTL: 0x00000000 (NOTvalid, 0 ns)
10.002424 sec
Core CPU Avg_MHz Busy% Bzy_MHz TSC_MHz IRQ SMI POLL C1_ACPI C2_ACPI
C3_ACPI POLL% C1_ACPI% C2_ACPI% C3_ACPI% CPU%c1 CPU%c6 CPU%c7 CoreTmp
PkgTmp GFX%rc6 GFXMHz Totl%C0 Any%C0 GFX%C0 CPUGFX% Pkg%pc2 Pkg%pc3
Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10 CPU%LPI SYS%LPI PkgWatt
CorWatt GFXWatt RAMWatt PKG_% RAM_%
- - 204 9.81 2083 1497 50389 176 820 25733 20628 14751 0.01 10.71
36.19 42.84 29.48 0.00 60.71 58 58 97.96 300 73.65 52.84 1.861.41
16.96 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 6.08 3.79 0.03 0.00 0.00
0.00
0 0 218 7.90 2760 1497 6824 22 4 3882 3146 864 0.00 12.68 53.86 24.76
26.32 0.00 65.77 58 58 97.96 300 73.65 52.84 1.861.41 16.96 0.00 0.00
0.00 0.00 0.00 0.00 0.00 0.00 6.08 3.79 0.03 0.00 0.00 0.00
0 4 144 6.91 2084 1497 4409 22 7 2410 2078 1608 0.00 7.55 32.26 52.88 27.32
1 1 154 8.09 1903 1497 4783 22 3 2528 2178 1801 0.00 7.54 34.66 49.51
42.41 0.00 49.50 57
1 5 290 14.49 2000 1497 14750 22 755 5964 4261 4558 0.04 22.47 27.57 35.05 36.01
2 2 209 11.35 1840 1497 4663 22 1 2771 2132 1467 0.00 8.39 31.37 48.69
28.70 0.00 59.96 55
2 6 232 13.35 1738 1497 5625 22 40 3313 2140 1338 0.00 10.36 33.13 42.87 26.70
3 3 221 9.01 2451 1497 4944 22 7 2627 2536 1447 0.00 9.32 41.41 39.55
23.38 0.00 67.61 54
3 7 167 7.39 2266 1497 4391 22 3 2238 2157 1668 0.00 7.39 35.25 49.42 25.00


>
> Artem.
>

Guilhem Lettron
