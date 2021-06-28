Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB03B5DC1
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 14:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhF1MQ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 08:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhF1MQy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jun 2021 08:16:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA2EC061574
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 05:14:27 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p24so10174121ljj.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IU77WBZE9mV7D3mQ04skNRvL8L5r2XXRRJdj4vDKQlI=;
        b=LMxKD+ZqXB8Q5pFcAlMU0D19B7UTQNtCxaOM5FiHF5Me2rRzdvbJYZZ+AxdIsilsM1
         cXU0OfzcFMNBAFxJhoDHNMtcvo6IK4zw+QFOanqJ2cwGAKzUbf4Vbgtp/YZVPagh4lB3
         JeK7MxW2hJ88Ileo7gUKaVUOrVNuL08FkYGg+jjpiSdVwf5bv4vPbni1SMiFXuWFg4x5
         tV5cSz7QgfGZ74NI573dW2GTDvXHU8jznVVd+SQVTCCtsWT8MXWNoS/qBxZ+zuU/Ig4r
         CWV7MXbto/tkb4i5sl8Skjq9WLj0Yj0uFklDTIvyXrXvIZ9ZzbqPb32RSXk9+PFxNfh/
         wWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IU77WBZE9mV7D3mQ04skNRvL8L5r2XXRRJdj4vDKQlI=;
        b=JMmAEI/bo0IzpLM0gPOHTZE6QYTxvrquL0iWdKMQe4kMQNMswC8x3HblBTaClHqPsr
         fNiPh8JZdZF8ewYFklhrkn5NQu7qk+1c24xmzOWl+UDsL1PTZYq+8M/nP8mKdsinYhRB
         HoV65+uipakQvR0h3qSPbnyAr5qSJzJLb9mMh9nGOKmJEH7QS8M9Bk3/R3F7Xn67YYi/
         z8hSo0RohfDhR07t58ZWdE/pbnwOcPesfSdl+bbppEdlgWzymIRF71iCQOASalA4utRV
         HvBqGu4OV3/1wEqjG8uJbmbgmPTTPe0cLHk74fC94OTG8aPUPv2BmoETvMqiGyqenk6W
         3FIw==
X-Gm-Message-State: AOAM531WNDV8ICJAa2RzrbwZnKg1t5616I9kUXU8vlCiab/IZkZzqLdZ
        sGko5KPDlWeZgDpCTrAVAs/M6UKQuFr0JcDU3Qy+cQ==
X-Google-Smtp-Source: ABdhPJxGjFQVeWlK8SLwk4umPJ+r7JmGj9rU07PjvVIpQC689chCLz+0dj8pdQ5Gadhq5J6db5lEwvcA6JlpZ4qcYZ4=
X-Received: by 2002:a2e:9c02:: with SMTP id s2mr930558lji.299.1624882466028;
 Mon, 28 Jun 2021 05:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624266901.git.viresh.kumar@linaro.org> <20210628115452.GA28797@arm.com>
In-Reply-To: <20210628115452.GA28797@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 28 Jun 2021 14:14:14 +0200
Message-ID: <CAKfTPtAtE1WHA19=BrWyekHgFYVn0+LdTLROJzYRdshp-EYOWA@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 28 Jun 2021 at 13:54, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi guys,
>
> On Monday 21 Jun 2021 at 14:49:33 (+0530), Viresh Kumar wrote:
> > Hello,
> >
> > Changes since V2:
> >
> > - We don't need start_cpu() and stop_cpu() callbacks anymore, we can make it
> >   work using policy ->init() and exit() alone.
> >
> > - Two new cleanup patches 1/4 and 2/4.
> >
> > - Improved commit log of 3/4.
> >
> > - Dropped WARN_ON(local_freq_scale > 1024), since this can occur on counter's
> >   overlap (seen with Vincent's setup).
> >
>
> If you happen to have the data around, I would like to know more about
> your observations on ThunderX2.
>
>
> I tried ThunderX2 as well, with the following observations:
>
> Booting with userspace governor and all CPUs online, the CPPC frequency
> scale factor was all over the place (even much larger than 1024).
>
> My initial assumptions:
>  - Counters do not behave properly in light of SMT
>  - Firmware does not do a good job to keep the reference and core
>    counters monotonic: save and restore at core off.
>
> So I offlined all CPUs with the exception of 0, 32, 64, 96 - threads of
> a single core (part of policy0). With this all works very well:
>
> root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 1056000 > scaling_setspeed
> root@target:/sys/devices/system/cpu/cpufreq/policy0#
> [ 1863.095370] CPU96: cppc scale: 697.
> [ 1863.175370] CPU0: cppc scale: 492.
> [ 1863.215367] CPU64: cppc scale: 492.
> [ 1863.235366] CPU96: cppc scale: 492.
> [ 1863.485368] CPU32: cppc scale: 492.
>
> root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 1936000 > scaling_setspeed
> root@target:/sys/devices/system/cpu/cpufreq/policy0#
> [ 1891.395363] CPU96: cppc scale: 558.
> [ 1891.415362] CPU0: cppc scale: 595.
> [ 1891.435362] CPU32: cppc scale: 615.
> [ 1891.465363] CPU96: cppc scale: 635.
> [ 1891.495361] CPU0: cppc scale: 673.
> [ 1891.515360] CPU32: cppc scale: 703.
> [ 1891.545360] CPU96: cppc scale: 738.
> [ 1891.575360] CPU0: cppc scale: 779.
> [ 1891.605360] CPU96: cppc scale: 829.
> [ 1891.635360] CPU0: cppc scale: 879.
>
> root@target:/sys/devices/system/cpu/cpufreq/policy0#
> root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 2200000 > scaling_setspeed
> root@target:/sys/devices/system/cpu/cpufreq/policy0#
> [ 1896.585363] CPU32: cppc scale: 1004.
> [ 1896.675359] CPU64: cppc scale: 973.
> [ 1896.715359] CPU0: cppc scale: 1024.
>
> I'm doing a rate limited printk only for increase/decrease values over
> 64 in the scale factor value.
>
> This showed me that SMT is handled properly.
>
> Then, as soon as I start onlining CPUs 1, 33, 65, 97, the scale factor
> stops being even close to correct, for example:
>
> [238394.770328] CPU96: cppc scale: 22328.
> [238395.628846] CPU96: cppc scale: 245.
> [238516.087115] CPU96: cppc scale: 930.
> [238523.385009] CPU96: cppc scale: 245.
> [238538.767473] CPU96: cppc scale: 936.
> [238538.867546] CPU96: cppc scale: 245.
> [238599.367932] CPU97: cppc scale: 2728.
> [238599.859865] CPU97: cppc scale: 452.
> [238647.786284] CPU96: cppc scale: 1438.
> [238669.604684] CPU96: cppc scale: 27306.
> [238676.805049] CPU96: cppc scale: 245.
> [238737.642902] CPU97: cppc scale: 2035.
> [238737.664995] CPU97: cppc scale: 452.
> [238788.066193] CPU96: cppc scale: 2749.
> [238788.110192] CPU96: cppc scale: 245.
> [238817.231659] CPU96: cppc scale: 2698.
> [238818.083687] CPU96: cppc scale: 245.
> [238845.466850] CPU97: cppc scale: 2990.
> [238847.477805] CPU97: cppc scale: 452.
> [238936.984107] CPU97: cppc scale: 1590.
> [238937.029079] CPU97: cppc scale: 452.
> [238979.052464] CPU97: cppc scale: 911.
> [238980.900668] CPU97: cppc scale: 452.
> [239149.587889] CPU96: cppc scale: 803.
> [239151.085516] CPU96: cppc scale: 245.
> [239303.871373] CPU64: cppc scale: 956.
> [239303.906837] CPU64: cppc scale: 245.
> [239308.666786] CPU96: cppc scale: 821.
> [239319.440634] CPU96: cppc scale: 245.
> [239389.978395] CPU97: cppc scale: 4229.
> [239391.969562] CPU97: cppc scale: 452.
> [239415.894738] CPU96: cppc scale: 630.
> [239417.875326] CPU96: cppc scale: 245.
>

With the counter being 32bits and the freq scaling being update at
tick, you can easily get a overflow on it in idle system. I can easily
imagine that when you unplug CPUs there is enough activity on the CPU
to update it regularly whereas with all CPUs, the idle time is longer
that the counter overflow

> The counter values shown by feedback_ctrs do not seem monotonic even
> when only core 0 threads are online.
>
> ref:2812420736 del:166051103
> ref:3683620736 del:641578595
> ref:1049653440 del:1548202980
> ref:2099053440 del:2120997459
> ref:3185853440 del:2714205997
> ref:712486144  del:3708490753
> ref:3658438336 del:3401357212
> ref:1570998080 del:2279728438
>
> For now I was just wondering if you have seen the same and whether you
> have an opinion on this.
>
> > This is tested on my Hikey platform (without the actual read/write to
> > performance counters), with this script for over an hour:
> >
> > while true; do
> >     for i in `seq 1 7`;
> >     do
> >         echo 0 > /sys/devices/system/cpu/cpu$i/online;
> >     done;
> >
> >     for i in `seq 1 7`;
> >     do
> >         echo 1 > /sys/devices/system/cpu/cpu$i/online;
> >     done;
> > done
> >
> >
> > The same is done by Vincent on ThunderX2 and no issues were seen.
>
> Hotplug worked fine for me as well on both platforms I tested (Juno R2
> and ThunderX2).
>
> Thanks,
> Ionela.
