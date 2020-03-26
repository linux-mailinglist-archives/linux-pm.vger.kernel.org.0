Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2206F193A84
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 09:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCZIN0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 04:13:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36474 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgCZIN0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 04:13:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id k18so4761212oib.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 01:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yWiNTkGKZSkyU0D2fa4NiZkbrlvij8oc4xZ09Ks1BI=;
        b=VgTEVTJ9E0x68uA1PxeR9qNMMalLMLssiR9S6ZqLqCvLatWeV0VKe2SkQeT7HMT9mN
         CUs4k797KBar24THnpLLffYylbX226/YVehff6Q/ln18MWAcBUNwZkEhuOFTnih9Tn32
         r1g0w61rC1nMoSCzuUDfvoK7LzM4C6TQBApvQSWncNzPhPPq6+JLbSnLa63IClbN85rb
         BCLSFaYyXC1QznrdeBWGxXl4jo1EcdsgKXvGrCMlfEEcpdMxeoZFhUeRm3ePFeijOKLI
         rnvEHx8z9t2bSIFYi/HC2FAR2x1YjIem3rXtLMn6Rg92p5b0+gz2qmnbWeRP8bHL9BzM
         sw0Q==
X-Gm-Message-State: ANhLgQ0PBpYDG5yT0IM1mpTkwZXCvDhTe5e5ZaNAF/QvPWz2Rmpy5qLc
        98ozhdRiRHoFxW8ExECpwyc0vK8z87neoBhYhyA=
X-Google-Smtp-Source: ADFU+vtfA1qtDc/qkD7u/j/mSXj6XFyzVPXxJVHJD5W9bS77GMTKSK0wTKYJRpkzgtBjzEfM6YavsXRW4aM0AMzTIjc=
X-Received: by 2002:aca:f07:: with SMTP id 7mr968862oip.68.1585210405414; Thu,
 26 Mar 2020 01:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390> <alpine.DEB.2.21.2003252229520.2971@xps-7390>
In-Reply-To: <alpine.DEB.2.21.2003252229520.2971@xps-7390>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Mar 2020 09:13:14 +0100
Message-ID: <CAJZ5v0iWVhQtTn2tFVXA5mHgzgmK+dGm=GC0=fiqJknP+We6KA@mail.gmail.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Srinivas

On Thu, Mar 26, 2020 at 6:46 AM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> (Re-sent, as I think I had the wrong mailing list address before)
>
> I'm running Linus' latest master of today (and have seen this for a while
> now). I've got an IceLake CPU (i7-1065G7 running on a Dell 7390 2-in-1, but
> I'm pretty sure I've seen issue this on my HP Spectre 13 with a 9th-gen CPU).
>
> Sometimes when I boot, I get 4 RAPL "fixed counters" and sometimes I only
> get 3, and it's always the "psys" domain that's missing when it does. See
> attached output from various dmesg runs (and a snippet below).
>
> Is this a bug?
> Do you know what may cause this?
>
> If you need more info to help me help you guys with this (if it's truly an
> issue), please let me know.
>
> Thanks,
>
>         -Kenny
>
> ----
> Mar 22 05:02:48 xps-7390 kernel: [    0.756890] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> Mar 22 05:02:48 xps-7390 kernel: [    0.756892] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> Mar 22 05:02:48 xps-7390 kernel: [    0.756893] RAPL PMU: hw unit of domain package 2^-14 Joules
> Mar 22 05:02:48 xps-7390 kernel: [    0.756894] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> Mar 22 05:02:48 xps-7390 kernel: [    2.178267] intel_rapl_common: Found RAPL domain package
> Mar 22 05:02:48 xps-7390 kernel: [    3.056499] intel_rapl_common: Found RAPL domain package
> Mar 22 05:02:48 xps-7390 kernel: [    3.058417] intel_rapl_common: Found RAPL domain core
> Mar 22 05:02:48 xps-7390 kernel: [    3.062290] intel_rapl_common: Found RAPL domain uncore
> Mar 22 05:17:50 xps-7390 kernel: [    1.770794] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> Mar 22 05:17:50 xps-7390 kernel: [    1.770799] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> Mar 22 05:17:50 xps-7390 kernel: [    1.770802] RAPL PMU: hw unit of domain package 2^-14 Joules
> Mar 22 05:17:50 xps-7390 kernel: [    1.770814] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> Mar 22 05:17:50 xps-7390 kernel: [    3.176324] intel_rapl_common: Found RAPL domain package
> Mar 22 05:17:50 xps-7390 kernel: [    4.060045] intel_rapl_common: Found RAPL domain package
> Mar 22 05:17:50 xps-7390 kernel: [    4.061739] intel_rapl_common: Found RAPL domain core
> Mar 22 05:17:50 xps-7390 kernel: [    4.063129] intel_rapl_common: Found RAPL domain uncore
> Mar 22 05:28:05 xps-7390 kernel: [    1.770320] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> Mar 22 05:28:05 xps-7390 kernel: [    1.770326] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> Mar 22 05:28:05 xps-7390 kernel: [    1.770329] RAPL PMU: hw unit of domain package 2^-14 Joules
> Mar 22 05:28:05 xps-7390 kernel: [    1.770332] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> Mar 22 05:28:05 xps-7390 kernel: [    1.770335] RAPL PMU: hw unit of domain psys 2^-14 Joules
> Mar 22 05:28:05 xps-7390 kernel: [    3.148050] intel_rapl_common: Found RAPL domain package
> Mar 22 05:28:05 xps-7390 kernel: [    4.043621] intel_rapl_common: Found RAPL domain package
> Mar 22 05:28:05 xps-7390 kernel: [    4.045295] intel_rapl_common: Found RAPL domain core
> Mar 22 05:28:05 xps-7390 kernel: [    4.046823] intel_rapl_common: Found RAPL domain uncore
> Mar 22 05:37:11 xps-7390 kernel: [    1.635660] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> Mar 22 05:37:11 xps-7390 kernel: [    1.635667] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> Mar 22 05:37:11 xps-7390 kernel: [    1.635670] RAPL PMU: hw unit of domain package 2^-14 Joules
> Mar 22 05:37:11 xps-7390 kernel: [    1.635673] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> Mar 22 05:37:11 xps-7390 kernel: [    1.635676] RAPL PMU: hw unit of domain psys 2^-14 Joules
> Mar 22 05:37:11 xps-7390 kernel: [    3.043397] intel_rapl_common: Found RAPL domain package
> Mar 22 05:37:11 xps-7390 kernel: [    4.043265] intel_rapl_common: Found RAPL domain package
> Mar 22 05:37:11 xps-7390 kernel: [    4.045524] intel_rapl_common: Found RAPL domain core
> Mar 22 05:37:11 xps-7390 kernel: [    4.048153] intel_rapl_common: Found RAPL domain uncore
> ----
>
>
> --
> Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
