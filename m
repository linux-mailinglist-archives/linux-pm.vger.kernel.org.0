Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7081050E2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 11:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKUKyK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 05:54:10 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36903 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUKyK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 05:54:10 -0500
Received: by mail-oi1-f179.google.com with SMTP id y194so2780760oie.4
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2019 02:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsyeWxbY1Ba98DfWT86AHvcliR3cEZVbc4wiAvnn99Q=;
        b=VLTXpEgc7zknBvbxf0sed4LPA22wt3anvuqhEjHMsoYd4QLNDJezZqKZlD/6VrGJTw
         /WK23XM7nrL6+lSMqdHzJ+B/ZxMJv+/ehyR9ZVQk34lT3OWylLg8ESDPBOeNDFiGBfkQ
         bfTj5cENnL/zGjVXQtHafHwKKLESaZM4dWSmn15d/ERBJQY0Rhndl0NHjxT94QHt7R7X
         0ZcOYJe7xVz6RQF11uN6na3jUd/D+piEPRyartOqbFpFFQBt4cR4SiJDXWcS58oQwaDe
         4zaWQqs4EDEc32UVJ2hG7jn9NuTF7aH24H7kB5G3Gos7XONQpOGsjyJXQKmWMFfBc++Y
         VSZg==
X-Gm-Message-State: APjAAAVDy9d298Fnzg6NVgcNqMI1oQkBhx1RStt1HVKvXbh2OOOd6t73
        Q9p+lsIu6/rIeEkRr/eOP4sNq0o/bqT2lQeIbiM=
X-Google-Smtp-Source: APXvYqzsY89r69Poqk4C6unc+b/ApEA6Goy8BapzKXnXJGedX26LKvuk7nBUPwGczp1l32wYNcV2FHAypcqjJWHc0Vo=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr7301022oih.57.1574333647253;
 Thu, 21 Nov 2019 02:54:07 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191121093557.bycvdo4xyinbc5cb@vireshk-i7> <DB3PR0402MB39165544EDD0317095A1B72DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39165544EDD0317095A1B72DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Nov 2019 11:53:56 +0100
Message-ID: <CAJZ5v0geykeebX-67+h4twj+t7oTVBf7X7_UsXw0LAc+0Ap75Q@mail.gmail.com>
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

On Thu, Nov 21, 2019 at 11:13 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Thanks Viresh for your quick response.
> The output of cpufreq info are as below, some more info for you are, our internal tree is based on v5.4-rc7,
> and the CPU hotplug has no i.MX platform code, so far we reproduced it on i.MX8QXP, i.MX8QM and i.MX8MN.
> With cpufreq disabled, no issue met.
> I also reproduced this issue with v5.4-rc7,
> Will continue to debug and let you know if any new found.
>
> > Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
> >
> > +Rafael and PM list.
> >
> > Please provide output of following for your platform while I am having a look
> > at your problem.
> >
> > grep . /sys/devices/system/cpu/cpufreq/*/*
>
> root@imx8qxpmek:~# grep . /sys/devices/system/cpu/cpufreq/*/*
> /sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load:0
> /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy:0
> /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias:0
> /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor:1
> /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate:10000
> /sys/devices/system/cpu/cpufreq/ondemand/up_threshold:95
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3

All CPUs in one policy, CPU0 is the policy CPU and it never goes offline AFAICS.

> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq:900000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:1200000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:900000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:150000
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:900000 1200000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:ondemand userspace performance schedutil
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:900000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:cpufreq-dt
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand

Hm.  That shouldn't really make a difference, but I'm wondering if you
can reproduce this with the schedutil governor?

> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1200000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:900000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> grep: /sys/devices/system/cpu/cpufreq/policy0/stats: Is a directory
>
>
> CPUHotplug: 4524 times remaining
> [ 5954.441803] CPU1: shutdown
> [ 5954.444529] psci: CPU1 killed.
> [ 5954.481739] CPU2: shutdown
> [ 5954.484484] psci: CPU2 killed.
> [ 5954.530509] CPU3: shutdown
> [ 5954.533270] psci: CPU3 killed.
> [ 5955.561978] Detected VIPT I-cache on CPU1
> [ 5955.562015] GICv3: CPU1: found redistributor 1 region 0:0x0000000051b20000
> [ 5955.562073] CPU1: Booted secondary processor 0x0000000001 [0x410fd042]
> [ 5955.596921] Detected VIPT I-cache on CPU2
> [ 5955.596959] GICv3: CPU2: found redistributor 2 region 0:0x0000000051b40000
> [ 5955.597018] CPU2: Booted secondary processor 0x0000000002 [0x410fd042]
> [ 5955.645878] Detected VIPT I-cache on CPU3
> [ 5955.645921] GICv3: CPU3: found redistributor 3 region 0:0x0000000051b60000
> [ 5955.645986] CPU3: Booted secondary processor 0x0000000003 [0x410fd042]
> CPUHotplug: 4523 times remaining
> [ 5956.769790] CPU1: shutdown
> [ 5956.772518] psci: CPU1 killed.
> [ 5956.809752] CPU2: shutdown
> [ 5956.812480] psci: CPU2 killed.
> [ 5956.849769] CPU3: shutdown
> [ 5956.852494] psci: CPU3 killed.
> [ 5957.882045] Detected VIPT I-cache on CPU1
> [ 5957.882089] GICv3: CPU1: found redistributor 1 region 0:0x0000000051b20000
> [ 5957.882153] CPU1: Booted secondary processor 0x0000000001 [0x410fd042]
>
>
> Looping here, no hang, can response to debug console.... if attaching JTAG, I can see the CPU1
> Will busy waiting for irq_work to be free..

Well, cpufreq_offline() calls cpufreq_stop_governor() too, so there
shouldn't be any pending irq_works coming from cpufreq on the offline
CPUs after that.

Hence, if an irq_work is pending at the cpufreq_online() time, it must
be on CPU0 (which is always online).
