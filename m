Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DAC1050E8
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 11:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKUK42 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 05:56:28 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46119 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUK42 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 05:56:28 -0500
Received: by mail-ot1-f48.google.com with SMTP id n23so2474189otr.13
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2019 02:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOeHlR5snAOwEAWXf3tbNCDnXMaU8DGK9e4FjB7XkN8=;
        b=qRPFz0v5pu7hBtxrldzVkJGisDMfBirOsE1xHqT3HUr4fwPUuT5TFNtu4C8ODsPQYS
         yxdBjvOKjcubTxcAhgM/fspHj3oQssgwuD+E3XqXWmnaeA44Qha718S0Jc2JnuG0NgmC
         96w7FB1kPndXhU0LPjQEd+r049dyMPH6AKHi16huBHZif4gZOzpfOrwfCs8hotPvbxIL
         g3DGgTXDYLlioAG4kmDW6r98EKuhi2+COtmOJB+LwkjgiYyhgUAXHVKRkzMUzeSkJ1wI
         WAD54XtsBE6NSDtFYptdBVHgoYkyvDJvu1fvh7xRMOPZiWpNODUO+j9amOTDaapNymAA
         gGvA==
X-Gm-Message-State: APjAAAW7WNNuz5XRDL5zvJGIbcWtbYbbVUzn8+a80QZT+frS+X7qPOz1
        BwsTJJg9fZkWcqr/3PFl6SmQClizBWZ2oEQzmWWHDH7I
X-Google-Smtp-Source: APXvYqzJXuS/J6DxZzImIsE6ezQjVM7hxMJdh8+LwiDaJrAlJM9lMUI11oaLUk9M12O1Z6H92g16974DXm1XcSldhVI=
X-Received: by 2002:a9d:4c85:: with SMTP id m5mr5721517otf.118.1574333786863;
 Thu, 21 Nov 2019 02:56:26 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191121093557.bycvdo4xyinbc5cb@vireshk-i7> <DB3PR0402MB39165544EDD0317095A1B72DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0geykeebX-67+h4twj+t7oTVBf7X7_UsXw0LAc+0Ap75Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0geykeebX-67+h4twj+t7oTVBf7X7_UsXw0LAc+0Ap75Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Nov 2019 11:56:15 +0100
Message-ID: <CAJZ5v0j4z9tEDCGKRc7dHqTiJ1Fq3So=ELfvR6H25UkRmKeBvg@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 21, 2019 at 11:53 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 21, 2019 at 11:13 AM Anson Huang <anson.huang@nxp.com> wrote:
> >
> > Thanks Viresh for your quick response.
> > The output of cpufreq info are as below, some more info for you are, our internal tree is based on v5.4-rc7,
> > and the CPU hotplug has no i.MX platform code, so far we reproduced it on i.MX8QXP, i.MX8QM and i.MX8MN.
> > With cpufreq disabled, no issue met.
> > I also reproduced this issue with v5.4-rc7,
> > Will continue to debug and let you know if any new found.
> >
> > > Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
> > >
> > > +Rafael and PM list.
> > >
> > > Please provide output of following for your platform while I am having a look
> > > at your problem.
> > >
> > > grep . /sys/devices/system/cpu/cpufreq/*/*
> >
> > root@imx8qxpmek:~# grep . /sys/devices/system/cpu/cpufreq/*/*
> > /sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load:0
> > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy:0
> > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias:0
> > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor:1
> > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate:10000
> > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold:95
> > /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
>
> All CPUs in one policy, CPU0 is the policy CPU and it never goes offline AFAICS.
>
> > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq:900000
> > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:1200000
> > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:900000
> > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:150000
> > /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:900000 1200000
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:ondemand userspace performance schedutil
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:900000
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:cpufreq-dt
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
>
> Hm.  That shouldn't really make a difference, but I'm wondering if you
> can reproduce this with the schedutil governor?
>
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1200000
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:900000
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> > grep: /sys/devices/system/cpu/cpufreq/policy0/stats: Is a directory
> >
> >
> > CPUHotplug: 4524 times remaining
> > [ 5954.441803] CPU1: shutdown
> > [ 5954.444529] psci: CPU1 killed.
> > [ 5954.481739] CPU2: shutdown
> > [ 5954.484484] psci: CPU2 killed.
> > [ 5954.530509] CPU3: shutdown
> > [ 5954.533270] psci: CPU3 killed.
> > [ 5955.561978] Detected VIPT I-cache on CPU1
> > [ 5955.562015] GICv3: CPU1: found redistributor 1 region 0:0x0000000051b20000
> > [ 5955.562073] CPU1: Booted secondary processor 0x0000000001 [0x410fd042]
> > [ 5955.596921] Detected VIPT I-cache on CPU2
> > [ 5955.596959] GICv3: CPU2: found redistributor 2 region 0:0x0000000051b40000
> > [ 5955.597018] CPU2: Booted secondary processor 0x0000000002 [0x410fd042]
> > [ 5955.645878] Detected VIPT I-cache on CPU3
> > [ 5955.645921] GICv3: CPU3: found redistributor 3 region 0:0x0000000051b60000
> > [ 5955.645986] CPU3: Booted secondary processor 0x0000000003 [0x410fd042]
> > CPUHotplug: 4523 times remaining
> > [ 5956.769790] CPU1: shutdown
> > [ 5956.772518] psci: CPU1 killed.
> > [ 5956.809752] CPU2: shutdown
> > [ 5956.812480] psci: CPU2 killed.
> > [ 5956.849769] CPU3: shutdown
> > [ 5956.852494] psci: CPU3 killed.
> > [ 5957.882045] Detected VIPT I-cache on CPU1
> > [ 5957.882089] GICv3: CPU1: found redistributor 1 region 0:0x0000000051b20000
> > [ 5957.882153] CPU1: Booted secondary processor 0x0000000001 [0x410fd042]
> >
> >
> > Looping here, no hang, can response to debug console.... if attaching JTAG, I can see the CPU1
> > Will busy waiting for irq_work to be free..
>
> Well, cpufreq_offline() calls cpufreq_stop_governor() too, so there
> shouldn't be any pending irq_works coming from cpufreq on the offline
> CPUs after that.
>
> Hence, if an irq_work is pending at the cpufreq_online() time, it must
> be on CPU0 (which is always online).

Let me rephrase this: If an irq_work is pending at the
cpufreq_online() time, it must be on an online CPU, which is CPU0 if
all of the other CPUs are offline.
