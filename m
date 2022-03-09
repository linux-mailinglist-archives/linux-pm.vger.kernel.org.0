Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835064D391F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Mar 2022 19:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiCISrI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Mar 2022 13:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiCISrF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2022 13:47:05 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC61A39D6
        for <linux-pm@vger.kernel.org>; Wed,  9 Mar 2022 10:46:05 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id c7so2511173qka.7
        for <linux-pm@vger.kernel.org>; Wed, 09 Mar 2022 10:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=um1H2klOo2HSlJxYQ9hfhq9Sq44TiBgthEbeHORHhFU=;
        b=NTfgm2eevcwEM6+CPk/7XOCsqL04LofSh4lQhxU8JhZvZS6VwCbvoY9qwRCKyfiw/I
         OxDZ/w46lrgbzj5vD28SnxhToxMaQbYQNJbD2XwPJyOGR4TCv78KCZthhpbq4C9l/nxk
         75lhNM5amAyYRtoyHpHBPy/ZSF2ojixFq9miHazWMsYuaSyzrG5eIUsDXASve3Cr/wL+
         DF/Q40ooXGIq5VTnRWvt8CnwJsub0PSUsC6wSNPPnmIZw8xnSoFQZgYpYnUIeacWsCdx
         r4KvPSLuDod/LtoZJDSieAE7EVKyt1yb7xeUQnZr9cjhYGRF7C96Flm4/9wRrd4BngEC
         Cz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=um1H2klOo2HSlJxYQ9hfhq9Sq44TiBgthEbeHORHhFU=;
        b=cBsPZiHKVjeeRiKvUQaQ4Acj9DXpS9Il5Pvttt+8YtruUop2z9UpQi6EtNK+JwnSe/
         YtBTLOBXICmhvreByEwSdVzUaeedscjmqr4UR2VOll+NOE4dIW0bN7m2sX+ZmIrhRXuo
         X/64FCR80jFUH4sMHgdLvahd4YChyhofZOXQ4KwFhwRSfN6jl7QYecsQnnrEBAcOYRA2
         3aZD0Lmlq7KeCN0tRtqfe8ee5onqJcV56HM+7+q4t/Bd63sVocV0aR9cqPYsTNkSXRVo
         tui3ae/7DI9/f7pRORDI2s2IwAm17LpioIsWpiX3jCFvJVhTQqqGFC24Bbp08sHnr2XI
         CwqQ==
X-Gm-Message-State: AOAM530C4A2AggvNY7OxED1oOQPzz9I4WzLXNrJK1fajo+WteHMP8r/D
        eZbI2i4c9gzlF0Sd/+5SdJHF0jTGLCbuytqVlCtt9g==
X-Google-Smtp-Source: ABdhPJw1e1F+KWdh3/v3cvjI92F7HWVs7MMAaaxTiK1XgvFT9pgdlk85UM3/ifv2QaPNd94CdGw4F6vFEO+XkJjheiI=
X-Received: by 2002:a05:620a:2449:b0:67d:16cc:8505 with SMTP id
 h9-20020a05620a244900b0067d16cc8505mr722088qkn.203.1646851564581; Wed, 09 Mar
 2022 10:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
 <20220307153050.3392700-2-dmitry.baryshkov@linaro.org> <YiZ9zFqz2hU8im4f@ripper>
In-Reply-To: <YiZ9zFqz2hU8im4f@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 9 Mar 2022 21:45:53 +0300
Message-ID: <CAA8EJpr8FwxNHUZeDVJ2P9suV-oRxD8eLTZdMbPYheSJdYm-yQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] cpufreq: qcom-hw: fix the race between LMH worker and cpuhp
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 8 Mar 2022 at 00:47, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Mon 07 Mar 07:30 PST 2022, Dmitry Baryshkov wrote:
>
> > qcom_lmh_dcvs_poll() can be running when the cpu is being put offline.
> > This results in the following warning. The driver would disable the
> > worker, but it happens closer to the end of cpufreq_offline(). Change
> > the locking in the qcom_lmh_dcvs_poll(), so that the worker can not run
> > in parallel with cpufreq_offline() call.
> >
> > [   37.122433] ------------[ cut here ]------------
> > [   37.127225] WARNING: CPU: 0 PID: 187 at drivers/base/arch_topology.c:180 topology_update_thermal_pressure+0xec/0x100
>
> I don't have a warning on line 180 in arch_topology.c
>
> I do however believe that my proposed patch for handling the race during
> initialization would end up with a warning there.
>
> As Viresh pointed out as I tried to land those upstream, they would
> cause problems as policy->cpus changes during hotplug, i.e. something
> very similar to what you're showing here.
>
> Could it be that you're testing this in a tree that has those patches?

Yes, I have been testing my patches on top of integration tree that
had these patchses. However the issue is still present even w/o the
patch in question, so I'll update the backtrace in V2.

>
>
> PS. The two patches that did land upstream in the end are:
> 4f774c4a65bf ("cpufreq: Reintroduce ready() callback")
> ef8ee1cb8fc8 ("cpufreq: qcom-hw: Delay enabling throttle_irq")
>
> > [   37.138098] Modules linked in:
> > [   37.141279] CPU: 0 PID: 187 Comm: kworker/0:3 Tainted: G S                5.17.0-rc6-00389-g37c83d0b8710-dirty #713
>
> 389 patches off mainline is quite far off from the upstream, please try
> to validate your changes on something closer to mainline.
>
> Regards,
> Bjorn
>
> > [   37.158306] Workqueue: events qcom_lmh_dcvs_poll
> > [   37.163095] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   37.170278] pc : topology_update_thermal_pressure+0xec/0x100
> > [   37.176131] lr : topology_update_thermal_pressure+0x20/0x100
> > [   37.181977] sp : ffff800009b6bce0
> > [   37.185402] x29: ffff800009b6bce0 x28: ffffd87abe92b000 x27: ffff04bd7292e205
> > [   37.192792] x26: ffffd87abe930af8 x25: ffffd87abe94e4c8 x24: 0000000000000000
> > [   37.200180] x23: ffff04bb01177018 x22: ffff04bb011770c0 x21: ffff04bb01177000
> > [   37.207567] x20: ffff04bb0a419000 x19: 00000000000c4e00 x18: 0000000000000000
> > [   37.214954] x17: 000000040044ffff x16: 004000b2b5503510 x15: 0000006aaa1326d2
> > [   37.222333] x14: 0000000000000232 x13: 0000000000000001 x12: 0000000000000040
> > [   37.229718] x11: ffff04bb00400000 x10: 968f57bd39f701c8 x9 : ffff04bb0acc8674
> > [   37.237095] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffffd87abd90092c
> > [   37.244478] x5 : 0000000000000016 x4 : 0000000000000000 x3 : 0000000000000100
> > [   37.251852] x2 : ffff04bb0a419020 x1 : 0000000000000100 x0 : 0000000000000100
> > [   37.259235] Call trace:
> > [   37.261771]  topology_update_thermal_pressure+0xec/0x100
> > [   37.267266]  qcom_lmh_dcvs_poll+0xbc/0x154
> > [   37.271505]  process_one_work+0x288/0x69c
> > [   37.275654]  worker_thread+0x74/0x470
> > [   37.279450]  kthread+0xfc/0x100
> > [   37.282712]  ret_from_fork+0x10/0x20
> > [   37.286417] irq event stamp: 74
> > [   37.289664] hardirqs last  enabled at (73): [<ffffd87abdd78af4>] _raw_spin_unlock_irq+0x44/0x80
> > [   37.298632] hardirqs last disabled at (74): [<ffffd87abdd71fc0>] __schedule+0x710/0xa10
> > [   37.306885] softirqs last  enabled at (58): [<ffffd87abcc90410>] _stext+0x410/0x588
> > [   37.314778] softirqs last disabled at (51): [<ffffd87abcd1bf68>] __irq_exit_rcu+0x158/0x174
> > [   37.323386] ---[ end trace 0000000000000000 ]---
> >
> > Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index 740518d8ae16..920c80d91c21 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -283,6 +283,23 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
> >       struct dev_pm_opp *opp;
> >       unsigned int freq;
> >
> > +     /*
> > +      * Synchronize against CPU going offline.
> > +      * cpufreq_offline() will get the write lock on policy->rwsem.
> > +      */
> > +retry:
> > +     if (unlikely(!down_read_trylock(&policy->rwsem))) {
> > +             mutex_lock(&data->throttle_lock);
> > +             if (data->cancel_throttle) {
> > +                     mutex_unlock(&data->throttle_lock);
> > +                     return;
> > +             }
> > +
> > +             mutex_unlock(&data->throttle_lock);
> > +
> > +             schedule();
> > +             goto retry;
> > +     }
> >       /*
> >        * Get the h/w throttled frequency, normalize it using the
> >        * registered opp table and use it to calculate thermal pressure.
> > @@ -301,9 +318,10 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
> >
> >       /*
> >        * In the unlikely case policy is unregistered do not enable
> > -      * polling or h/w interrupt
> > +      * polling or h/w interrupt.
> > +      * If we are here, we have the policy->rwsem read lock,
> > +      * cancel_throttle can be toggled only with the write lock.
> >        */
> > -     mutex_lock(&data->throttle_lock);
> >       if (data->cancel_throttle)
> >               goto out;
> >
> > @@ -318,7 +336,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
> >                                msecs_to_jiffies(10));
> >
> >  out:
> > -     mutex_unlock(&data->throttle_lock);
> > +     up_read(&policy->rwsem);
> >  }
> >
> >  static void qcom_lmh_dcvs_poll(struct work_struct *work)
> > --
> > 2.34.1
> >



-- 
With best wishes
Dmitry
