Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A58945A09E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 11:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhKWKuz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 05:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhKWKuy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 05:50:54 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D22CC061574
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 02:47:46 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b67so7938063qkg.6
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 02:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LMMV7zZ1RZ9LJuOx8fZUgq3jPCgf9H57PGBTOOc/cP4=;
        b=KHZJZL1rw/UC8XglP1fGxzT62LiaAND7wVjWlcNZGfeEdxlOGOGqxmNzOOgZdsvPRt
         S092QJextLRqYqSABtih0rQNN2HmnsG5i0Lf+WPtdHf90q0kd3ZZnhlagK0cYC1SJd4r
         r+k3YMOuruu3KT0j5fl1CDeWkBgREtYVjHMHU8wUwS0eAEIqicuR5M4oThteiNjpM3g1
         hLFi2Qv5n3asslei6SbyESwySl+Rwt0kba2T0+QFjW9vyv/tiMtOlVMgEEuQy5rswh8H
         6UjzEcKv3aSiqsv4/Dqp/yAmz9qxjxkdFHnYvcNgOlw0YXLpXDsn34/2mpXA2uEUeghk
         YJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LMMV7zZ1RZ9LJuOx8fZUgq3jPCgf9H57PGBTOOc/cP4=;
        b=iTmuUxm64eNfn+HHehXrhLGIv7fPuWArb1tWf9YVcBqI7jX1qX04I01XP154q9qZI6
         /xV9A2JKu8G37UJgogOlN91ab98gOotAds/1Fj4co9MnIBgEKih33n/anwgbBDr7sNV1
         CEpH/ZRu9UXaPDntC5y6NLvB6ZEqiP2wGyrgJmGFKlYij3zFNRdXZ1bmMHLFfiFWGe80
         xPYhejgEfMgVAmUNEqjanqfG6TgZ4kkHPEAshjsFVSFn/35NWeI+xDdz4D8A/oPYyHEy
         tpkEU/gvz8OcL3c3S5SgSAXVf0fXGn452qXItr7IuIx5NIRfad6N2jsQSx2irlx0B4yB
         W5sg==
X-Gm-Message-State: AOAM531vljyUFYPXMzPNqvBIFU9PB0WZX24GbUVpyYktuu0d5W3reOky
        GqKsapALdeFoPgFCKB1dIabgWnHiRLabrRN/TBh93QBI84zOYA==
X-Google-Smtp-Source: ABdhPJzRkbLHeXnOnfJg8IdodtfeDYsd0JCZXIAesnmJoGz7+w/jUJPsn+qe4c1AAGhD38ThXFLNEkIR3u5QQRgfRUA=
X-Received: by 2002:a05:620a:430b:: with SMTP id u11mr3697694qko.473.1637664465432;
 Tue, 23 Nov 2021 02:47:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
In-Reply-To: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 23 Nov 2021 10:47:34 +0000
Message-ID: <CAHbf0-E5Zrs9-bWYMm8A-RQ7xd0DOCZopzZ2GjtH8xcFf4wVtA@mail.gmail.com>
Subject: Re: AMD Pstate
To:     Huang Rui <ray.huang@amd.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi again

Do I need to enable something else for shedutil to work, I've tried
with and without shared_mem? Compiling a kernel with -j16 has the freq
stuck at 1GHz on all cores - ondemand works fine

That's on a AMD Ryzen 9 5900HX

Also compiling with Clang-13 gives the following warnings:

drivers/cpufreq/amd-pstate.c:257:6: warning: variable 'amd_des_perf'
is used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

        if (target_perf < capacity)

            ^~~~~~~~~~~~~~~~~~~~~~

drivers/cpufreq/amd-pstate.c:272:40: note: uninitialized use occurs here

        amd_des_perf =3D clamp_t(unsigned long, amd_des_perf,

                                              ^~~~~~~~~~~~

./include/linux/minmax.h:124:60: note: expanded from macro 'clamp_t'

#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)

                                                           ^~~

./include/linux/minmax.h:112:48: note: expanded from macro 'max_t'

#define max_t(type, x, y)       __careful_cmp((type)(x), (type)(y), >)

                                                     ^

./include/linux/minmax.h:38:14: note: expanded from macro '__careful_cmp'

                __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))

                           ^

note: (skipping 1 expansions in backtrace; use
-fmacro-backtrace-limit=3D0 to see all)

./include/linux/minmax.h:104:48: note: expanded from macro 'min_t'

#define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)

                                                     ^

./include/linux/minmax.h:38:14: note: expanded from macro '__careful_cmp'

                __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))

                           ^

./include/linux/minmax.h:31:25: note: expanded from macro '__cmp_once'

                typeof(x) unique_x =3D (x);               \

                                      ^

drivers/cpufreq/amd-pstate.c:257:2: note: remove the 'if' if its
condition is always true

        if (target_perf < capacity)

        ^~~~~~~~~~~~~~~~~~~~~~~~~~~

drivers/cpufreq/amd-pstate.c:249:56: note: initialize the variable
'amd_des_perf' to silence this warning

        unsigned long amd_max_perf, amd_min_perf, amd_des_perf,

                                                              ^

                                                               =3D 0

On Sun, 21 Nov 2021 at 10:37, Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> I'm not subscribed to the mailing list so apologies for emailing you dire=
ctly
>
> It looks like something isn't quite right with the kconfig selects
>
> SCHED_MC_PRIO can't be enabled without CPU_SUP_INTEL
>
>
>
> =E2=94=82 Symbol: X86_AMD_PSTATE [=3Dy]
>
>                                                               =E2=94=82
>  =E2=94=82 Type  : bool
>
>                                                                =E2=94=82
>  =E2=94=82 Defined at drivers/cpufreq/Kconfig.x86:37
>
>                                                                =E2=94=82
>  =E2=94=82   Prompt: AMD Processor P-State driver
>
>                                                                =E2=94=82
>  =E2=94=82   Depends on: CPU_FREQ [=3Dy] && X86 [=3Dy]
>
>                                                                =E2=94=82
>  =E2=94=82   Location:
>
>                                                                =E2=94=82
>  =E2=94=82     Main menu
>
>                                                                =E2=94=82
>  =E2=94=82       -> Power management and ACPI options
>
>                                                                =E2=94=82
>  =E2=94=82         -> CPU Frequency scaling
>
>                                                                =E2=94=82
>  =E2=94=82           -> CPU Frequency scaling (CPU_FREQ [=3Dy])
>
>                                                                =E2=94=82
>  =E2=94=82 Selects: ACPI_PROCESSOR [=3Dy] && ACPI_CPPC_LIB [=3Dn] &&
> CPU_FREQ_GOV_SCHEDUTIL [=3Dy]
>
>
>
> =E2=94=82 Symbol: ACPI_CPPC_LIB [=3Dn]
>
>                                                               =E2=94=82
>  =E2=94=82 Type  : bool
>
>                                                                =E2=94=82
>  =E2=94=82 Defined at drivers/acpi/Kconfig:268
>
>                                                                =E2=94=82
>  =E2=94=82   Depends on: ACPI [=3Dy] && ACPI_PROCESSOR [=3Dy]
>
>                                                                =E2=94=82
>  =E2=94=82 Selects: MAILBOX [=3Dn] && PCC [=3Dn]
>
>                                                                =E2=94=82
>  =E2=94=82 Selected by [n]:
>
>                                                                =E2=94=82
>  =E2=94=82   - X86_INTEL_PSTATE [=3Dn] && CPU_FREQ [=3Dy] && X86 [=3Dy] &=
& X86_64
> [=3Dy] && ACPI [=3Dy] && SCHED_MC_PRIO [=3Dn]
>                                                                   =E2=94=
=82
>  =E2=94=82   - X86_AMD_PSTATE [=3Dy] && CPU_FREQ [=3Dy] && X86 [=3Dy] && =
X86_64 [=3Dy]
> && ACPI [=3Dy] && SCHED_MC_PRIO [=3Dn]
>                                                                =E2=94=82
>  =E2=94=82   - ACPI_CPPC_CPUFREQ [=3Dn] && CPU_FREQ [=3Dy] && (ARM || ARM=
64) &&
> ACPI_PROCESSOR [=3Dy]
>
>
>
> =E2=94=82 Symbol: SCHED_MC_PRIO [=3Dn]
>
>                                                               =E2=94=82
>  =E2=94=82 Type  : bool
>
>                                                                =E2=94=82
>  =E2=94=82 Defined at arch/x86/Kconfig:1029
>
>                                                                =E2=94=82
>  =E2=94=82   Prompt: CPU core priorities scheduler support
>
>                                                                =E2=94=82
>  =E2=94=82   Depends on: SCHED_MC [=3Dy] && CPU_SUP_INTEL [=3Dn]
>
>                                                                =E2=94=82
>  =E2=94=82   Location:
>
>                                                                =E2=94=82
>  =E2=94=82     Main menu
>
>                                                                =E2=94=82
>  =E2=94=82       -> Processor type and features
>
>                                                                =E2=94=82
>  =E2=94=82 (1)     -> Multi-core scheduler support (SCHED_MC [=3Dy])
>
>                                                                =E2=94=82
>  =E2=94=82 Selects: X86_INTEL_PSTATE [=3Dn] && CPU_FREQ [=3Dy]
>
>
>
> I've used this patch to work around the issue:
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 95dd1ee01546..bdfcf155f48e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1028,8 +1028,8 @@ config SCHED_MC
>
> config SCHED_MC_PRIO
>        bool "CPU core priorities scheduler support"
> -       depends on SCHED_MC && CPU_SUP_INTEL
> -       select X86_INTEL_PSTATE
> +       depends on SCHED_MC && CPU_SUP_AMD
> +       select X86_AMD_PSTATE
>        select CPU_FREQ
>        default y
>        help
>
> Which gets things working here
