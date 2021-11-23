Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B777545A37D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhKWNQ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 08:16:59 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42526 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhKWNQ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 08:16:58 -0500
Received: by mail-ot1-f47.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so15235728otv.9;
        Tue, 23 Nov 2021 05:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQTMj1h9sc24jkKcJpt+A5SG0lWWTZepdcJ/+P7uLA0=;
        b=N1JZHFWx7gquy2xNKl7nllpPqSxw5+V4YUcZIMvZnwyhFfmAjS/4q5jD6Ke5AQG46p
         HwOq64my4fVs8nY6zIayhPI1obIwxSjggJg+Ti45UM535eEITKgi4+O95yt+fBnjL5R6
         Z5V7ljNuMJrSMCJPUsLlHZsF+hQwzvsLjreqQv9wzsVUmKmQR/1m6pPlWhnnFSYzfP3c
         0d0sXIxjT5ZIL8wDxGNXtJSa6+taRykA4O3I/MUb+xMBMnZ/z2B6dUvXEmpul5csUmhX
         3o54z+KGdYIrVTgOIKh0lQt1MZyd7i6E7EWAFI5z75BzmfBTlJ5lg1i6AyoLAufB8ETv
         N1vA==
X-Gm-Message-State: AOAM531T7uwadCMbFq5ldo49goE1fGFAXOGn3gvBROeeKL9TXD+vh1kO
        BZPr+gAaet4Qd5curbDdkIAfz8p0byq85cWoLaI=
X-Google-Smtp-Source: ABdhPJw8jmPhK76m93aXgUqJNkLVODfqj4rSdqVMkn99iN+RZu+Qym2stIGrDkRq1yk18wcCA6EcIXYvfyjERlIkcRY=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr4330325otu.254.1637673230592;
 Tue, 23 Nov 2021 05:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20211119051801.1432724-1-srinivas.pandruvada@linux.intel.com>
 <a2a18288-fa7c-02fb-6376-730777823637@MichaelLarabel.com> <aaa08cd0912576c3848eaacccc9d09273ddc73f9.camel@linux.intel.com>
In-Reply-To: <aaa08cd0912576c3848eaacccc9d09273ddc73f9.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Nov 2021 14:13:32 +0100
Message-ID: <CAJZ5v0icqWf=ywFJu75fZHAfTKxGup=3j3-Y3u-vXix6OeXbCw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: ITMT support for overclocked system
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>, tim.c.chen@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 19, 2021 at 2:28 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2021-11-19 at 05:19 -0600, Michael Larabel wrote:
> > On 11/18/21 23:18, Srinivas Pandruvada wrote:
> > > On systems with overclocking enabled, CPPC Highest Performance can
> > > be
> > > hard coded to 0xff. In this case even if we have cores with
> > > different
> > > highest performance, ITMT can't be enabled as the current
> > > implementation
> > > depends on CPPC Highest Performance.
> > >
> > > On such systems we can use MSR_HWP_CAPABILITIES maximum performance
> > > field
> > > when CPPC.Highest Performance is 0xff.
> > >
> > > Due to legacy reasons, we can't solely depend on
> > > MSR_HWP_CAPABILITIES as
> > > in some older systems CPPC Highest Performance is the only way to
> > > identify
> > > different performing cores.
> > >
> > > Reported-by: Michael Larabel <Michael@MichaelLarabel.com>
> > > Signed-off-by: Srinivas Pandruvada <
> > > srinivas.pandruvada@linux.intel.com>
> > > ---
> > > This patch was tested on one Alder Lake system by enabling
> > > Overclocking.
> > > Once overclocking is enabled, we see
> > > $cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf
> > > 255 (P-Cores)
> > > 255 (P-Cores
> > > ...
> > > ...
> > > 255 (E-Cores)
> > > 255 (E-Cores)
> > > The real max performance for CPUs on this system was
> > > 0x40 for P-cores and 0x26 for E-cores.
> > > With this change applied we will see
> > > $cat /proc/sys/kernel/sched_itmt_enabled
> > > 1
> > > The resultant ITMT priorities
> > > for P-core 0x40, P-core HT sibling 0x10 and E-core 0x26
> >
> >
> > With this patch I can confirm that now sched_itmt_enabled = 1 and
> > correct highest_perf with the ASUS ROG STRIX Z690-E GAMING WIFI board
> > on
> > the latest BIOS. Thanks.
> >
> > Tested-by: Michael Larabel <Michael@MichaelLarabel.com>
> >
>
> Thanks Michael for confirming.

Applied as 5.16-rc3 material, thank you!
