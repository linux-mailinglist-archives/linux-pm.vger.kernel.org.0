Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2299118E2DB
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 17:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgCUQNv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 12:13:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34866 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCUQNu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2020 12:13:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id a20so10914749edj.2;
        Sat, 21 Mar 2020 09:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjfqHm0ZTbjA1O22i1eTN10C6pr74+8t2h9HGWUzsps=;
        b=q+eQU/JSGtGnIanZm2xEotxC/67QJR70WeJ8ugDC4C+qocYTT0aB1JJJWENh3OtJRG
         JfnsyAowkl3wVDSfHFWWguUDre4H+lWF3VwZTPHbWOzAVUMeFend7qICSiIG8vBXcT1J
         tsySkqdSRkW7ej021xNt+evLChfhuXDZMQiGsTMe2+L7EeCRow/H6v/Pi9wuX2zvOd1L
         iLXwfQvBkb0UD1FVknsyxrcbzmAuvt/DNvK0fBHleYSEHuNahry7Z5r11INwILR3aTbC
         SmT7pmCiFmqJNN0m7eaWUUu9PfAbGZoWuF3UJ6VZsDD+YcC0/f70TrIvEFrJPNA4mPQ4
         14Yw==
X-Gm-Message-State: ANhLgQ0BEaImAtSyfTxPuSE21AuFmCc9aJ+BtQNj98b3uj/W6+Q6GxYz
        maipk0n01Mt1XrOOv6cHayQoUO1j9CZ8n08SwNOkM4Mu
X-Google-Smtp-Source: ADFU+vtRATptTAYawyn0YQboewjMnQzU+F+RjaWQZft3agTaWcr2wB3ik8HG3Gjq82ZuAY/7LnsiU3vxdThfv+kSFHw=
X-Received: by 2002:aa7:dbc1:: with SMTP id v1mr13429578edt.177.1584807228989;
 Sat, 21 Mar 2020 09:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <cf8b3db3-6daa-0da1-c3bb-1c0de029af7d@molgen.mpg.de>
In-Reply-To: <cf8b3db3-6daa-0da1-c3bb-1c0de029af7d@molgen.mpg.de>
From:   Len Brown <lenb@kernel.org>
Date:   Sat, 21 Mar 2020 12:13:37 -0400
Message-ID: <CAJvTdKkTrZyJc15oNQ1OSmX0_GSb3Z5bzqt=gbdHERjRCMN1MQ@mail.gmail.com>
Subject: Re: turbostat: Display all C-states on AMD Ryzen processor
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Paul,
Thanks for the note.
This devices is exposing two C-states to the OS, via ACPI tables:

cpu7: C1: ACPI HLT
cpu7: C2: ACPI IOPORT 0x414

And turbostat is showing the kernel's count of requests into those
states, and %residency in those states.

So far, this is similar to what would be seen on most Intel parts,
except Intel usually expose a couple more states to the OS, often via
a native intel_idle driver, rather than the ACPI BIOS.

That part that is really missing from AMD is hardware residency
counters.  I don't know if there are any or not.  If somebody knows of
any that are publicly documented and is willing to test patches to
show them to the user, I'd be happy to cut patches.

cheers,
-Len

On Tue, Feb 11, 2020 at 6:18 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Len,
>
>
> Running `turbostat` on an AMD Ryzen 5 PRO 1500, I do not see all C-states.
>
> ```
> $ git describe
> v5.6-rc1
> $ sudo ./turbostat
> turbostat version 19.08.31 - Len Brown <lenb@kernel.org>
> CPUID(0): AuthenticAMD 0xd CPUID levels; 0x8000001f xlevels; family:model:stepping 0x17:1:1 (23:1:1)
> CPUID(1): SSE3 MONITOR - - - TSC MSR - HT -
> CPUID(6): APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwindow, No-HWPepp, No-HWPpkg, No-EPB
> CPUID(7): No-SGX
> RAPL: 262 sec. Joule Counter Range, at 250 Watts
> cpu7: POLL: CPUIDLE CORE POLL IDLE
> cpu7: C1: ACPI HLT
> cpu7: C2: ACPI IOPORT 0x414
> cpu7: cpufreq driver: acpi-cpufreq
> cpu7: cpufreq governor: performance
> cpufreq boost: 1
> cpu0: MSR_RAPL_PWR_UNIT: 0x000a1003 (0.125000 Watts, 0.000015 Joules, 0.000977 sec.)
> Core    CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IRQ     POLL    C1      C2      POLL%   C1%     C2%     CorWatt PkgWatt
> -       -       2       0.07    2973    3493    943     0       201     737     0.00    0.37    99.57   0.12    12.42
> 0       0       2       0.08    3005    3493    122     0       7       116     0.00    0.12    99.81   0.03    12.42
> 0       1       0       0.01    2998    3493    21      0       6       14      0.00    0.10    99.89
> 1       2       0       0.01    3036    3493    25      0       13      11      0.00    0.21    99.78   0.04
> 1       3       5       0.17    2960    3493    429     0       102     324     0.00    1.41    98.45
> 4       4       2       0.05    3015    3493    74      0       24      50      0.00    0.32    99.64   0.03
> 4       5       3       0.09    2921    3493    125     0       15      110     0.00    0.28    99.63
> 5       6       2       0.07    2978    3493    124     0       26      97      0.00    0.39    99.54   0.03
> 5       7       1       0.02    3012    3493    23      0       8       15      0.00    0.13    99.84
> ```
>
> On an Intel processor more C-states are shown. Is support just lacking
> on AMD, or should a different tool be used?
>
>
> Kind regards,
>
> Paul
>


-- 
Len Brown, Intel Open Source Technology Center
