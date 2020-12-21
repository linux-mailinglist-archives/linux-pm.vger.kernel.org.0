Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4292DFB26
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 11:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgLUKl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 05:41:59 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36195 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgLUKl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 05:41:59 -0500
Received: by mail-ot1-f50.google.com with SMTP id d20so8464655otl.3;
        Mon, 21 Dec 2020 02:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKSwhPok9DbPjtgaPkb092ITW/Kf3j3ORcdbyVDtOwY=;
        b=uKPm4bbujGoO2Xks1y/a3+/ZpZNQxP068c2tPSIpQAeNDqYPQPIYyUG5tLeLeEedVF
         Ozc1QsN4SHx9ezrOOo2zQ3jCuWSQ/xkB//5a8GWpkdOWVlBhQcdzMydQ5P3GesucLkZi
         5h5naLQHkicZU8ncDlHMyeAlQB06kgoFdtNAxRLJhgxHb9hrdLS3bvKXVTm8q/MVEwL2
         ehLzTA07edlQJg/2fqu1U5x0GQdynzvJnePmknjaE3fNzi1JeWY29VfAOfhGcYZEs4ue
         t74XkWcSS04wyZQjAUFJpcIBaeVO347XxEx1RZ3JRiugooo2E347mj1K5vaUgEK4JME+
         tdzw==
X-Gm-Message-State: AOAM530NOI8D0gjK2MhIHIkrmz/sh8pODYlSOM5c26d4tA0tZ2RTQWnw
        1dy2O1HGEhQdXcTiIo8Rih+Tx2zVw63iUx7neHM=
X-Google-Smtp-Source: ABdhPJypy6Ca3J5+6Qt5GG9StEeiz2AsA2iucE9yUQnwN94wIMOaev98qPCgmRbdl4Her9of0tu+2xhMhJF711mSM5Y=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr11759419otk.206.1608547277784;
 Mon, 21 Dec 2020 02:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20360841.iInq7taT2Z@kreacher> <3827230.0GnL3RTcl1@kreacher> <000901d6d489$0c26dd50$247497f0$@net>
In-Reply-To: <000901d6d489$0c26dd50$247497f0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Dec 2020 11:41:06 +0100
Message-ID: <CAJZ5v0g_KbKNJNqjDSqESds73LHmtpcLJdM8mk_xErT1NPvi3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] cpufreq: Allow drivers to receive more information
 from the governor
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 17, 2020 at 4:27 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2020.12.14 12:02 Rafael J. Wysocki wrote:
>
> > Hi,
>
> Hi Rafael,
>
> V2 test results below are new, other results are partially re-stated:
>
> For readers that do not want to read on, I didn't find anything different than with
> the other versions. This was more just due diligence.

Thanks a lot for the data, much appreciated as always!

> Legend:
>
> hwp: Kernel 5.10-rc6, HWP enabled; intel_cpufreq
> rfc (or rjw): Kernel 5.10-rc6 + this patch set, HWP enabled; intel_cpu-freq; schedutil
> no-hwp: Kernel 5.10-rc6, HWP disabled; intel_cpu-freq
> acpi (or acpi-cpufreq): Kernel 5.10-rc6, HWP disabled; acpi-cpufreq; schedutil
> patch: Kernel 5.10-rc7 + V1 patch set, HWP enabled; intel_cpu-freq; schedutil
> v2: Kernel 5.10-rc7 + V2 patch set, HWP enabled; intel_cpu-freq; schedutil
>
> Fixed work packet, fixed period, periodic workflow, load sweep up/down:
>
> load work/sleep frequency: 73 Hertz:
>
> hwp: Average: 12.00822 watts
> rjw: Average: 10.18089 watts
> no-hwp: Average: 10.21947 watts
> acpi-cpufreq: Average:  9.06585 watts
> patch: Average: 10.26060 watts
> v2: Average: 10.50444
>
> load work/sleep frequency: 113 Hertz:
>
> hwp: Average: 12.01056
> rjw: Average: 10.12303
> no-hwp: Average: 10.08228
> acpi-cpufreq: Average:  9.02215
> patch: Average: 10.27055
> v2: Average: 10.31097
>
> load work/sleep frequency: 211 Hertz:
>
> hwp: Average: 12.16067
> rjw: Average: 10.24413
> no-hwp: Average: 10.12463
> acpi-cpufreq: Average:  9.19175
> patch: Average: 10.33000
> v2: Average: 10.39811
>
> load work/sleep frequency: 347 Hertz:
>
> hwp: Average: 12.34169
> rjw: Average: 10.79980
> no-hwp: Average: 10.57296
> acpi-cpufreq: Average:  9.84709
> patch: Average: 10.67029
> v2: Average: 10.93143
>
> load work/sleep frequency: 401 Hertz:
>
> hwp: Average: 12.42562
> rjw: Average: 11.12465
> no-hwp: Average: 11.24203
> acpi-cpufreq: Average: 10.78670
> patch: Average: 10.94514
> v2: Average: 11.50324
>
>
> Serialized single threaded via PIDs per second method:
> A.K.A fixed work packet, variable period
> Results:
>
> Execution times (seconds. Less is better):
>
> no-hwp:
>
> performance: Samples: 382  ; Average: 10.54450  ; Stand Deviation:  0.01564 ; Maximum: 10.61000 ; Minimum: 10.50000
>
> schedutil: Samples: 293  ; Average: 13.73416  ; Stand Deviation:  0.73395 ; Maximum: 15.46000 ; Minimum: 11.68000
> acpi: Samples: 253  ; Average: 15.94889  ; Stand Deviation:  1.28219 ; Maximum: 18.66000 ; Minimum: 12.04000
>
> hwp:
>
> schedutil: Samples: 380  ; Average: 10.58287  ; Stand Deviation:  0.01864 ; Maximum: 10.64000 ; Minimum: 10.54000
> patch: Samples: 276  ; Average: 14.57029 ; Stand Deviation:  0.89771 ; Maximum: 16.04000 ; Minimum: 11.68000
> rfc: Samples: 271  ; Average: 14.86037  ; Stand Deviation:  0.84164 ; Maximum: 16.04000 ; Minimum: 12.21000
> v2: Samples: 274  ; Average: 14.67978  ; Stand Deviation:  1.03378 ; Maximum: 16.07000 ; Minimum: 11.43000
>
> Power (watts. More indicates higher CPU frequency and better performance. Sample time = 1 second.):
>
> no-hwp:
>
> performance: Samples: 4000  ; Average: 25.41355  ; Stand Deviation:  0.22156 ; Maximum: 26.01996 ; Minimum: 24.08807
>
> schedutil: Samples: 4000  ; Average: 12.58863  ; Stand Deviation:  5.48600 ; Maximum: 25.50934 ; Minimum:  7.54559
> acpi: Samples: 4000  ; Average:  9.57924  ; Stand Deviation:  5.41157 ; Maximum: 25.06366 ; Minimum:  5.51129
>
> hwp:
>
> schedutil: Samples: 4000  ; Average: 25.24245  ; Stand Deviation:  0.19539 ; Maximum: 25.93671 ; Minimum: 24.14746
> patch: Samples: 4000  ; Average: 11.07225  ; Stand Deviation:  5.63142 ; Maximum: 24.99493 ; Minimum:  3.67548
> rfc: Samples: 4000  ; Average: 10.35842  ; Stand Deviation:  4.77915 ; Maximum: 24.95953 ; Minimum:  7.26202
> v2: Samples: 4000  ; Average: 10.98284  ; Stand Deviation:  5.48859 ; Maximum: 25.76331 ; Minimum:  7.53790
>
>
