Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EB54BA669
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbiBQQuv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Feb 2022 11:50:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbiBQQur (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Feb 2022 11:50:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BEFCD5C7
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 08:50:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s24so4326574edr.5
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 08:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fssx3Pq7Tr5cTG95P9U3gymWGu1RTV70KnA/iD+IHis=;
        b=kt8mhFozEB46tD+PCNcah6OB4+XA4FrhtNEFeKlGHfYdVpejelqKjEk+Qa2QgmOo4T
         s6JEU1UbCmrxLoxmhRt/aBZ2FTjOCMEifcXWfuXzHq70twphIanZ9Sm7JzCcNb/XIk9F
         WreIJKO8P8v36EHwnR/MHlJJHcSHS+tyi8g+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fssx3Pq7Tr5cTG95P9U3gymWGu1RTV70KnA/iD+IHis=;
        b=dRlgDQgh6vlkapvpUvd2MklCQJr75odrc/SqLsr1nwP6AVOX+rbfmJF5OtQnce1CsR
         e7siqMSj7vspPSs/udmdgwzX0KBEithktpGKUbdi0y++0yp1OUwC1kpM7hKYOX5kfNdt
         c1wWdSYfFPaPlQ1JelD/v0gi/76etgSOR0/3jWWxYkERl1r1dEM4CcoZsHeWq5XQSKuB
         UKTGphb3IoRTdfBWC5xDxTSnjCVt+MKbvkvRZgFoKuxBDvcMIrGVYsU+HHSKW9/29Ce2
         49Oz0QF15evdUjHslBMxYFRbdxSynwhKgVaj4ILn6AwR2b88D3SKyRNLvYjJ8/eELQ+d
         RRBA==
X-Gm-Message-State: AOAM532APl4kUHVGSCFtkDguE9L2MXUDC8CUPzv9jWcWt0kqYa+prybP
        HGH8sxfZT89Sn6/fafRg/cJrzRhlYZidvS/7IsE=
X-Google-Smtp-Source: ABdhPJzKOLQGVpwcphleMYuczpAU1fZIbgEMkfI/NlWYtZTJz6j4BPZVlOoFnJyFs+OfDxaILoGNDA==
X-Received: by 2002:a05:6402:1e88:b0:410:ebb4:c329 with SMTP id f8-20020a0564021e8800b00410ebb4c329mr3570876edf.300.1645116630626;
        Thu, 17 Feb 2022 08:50:30 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id hs25sm1354639ejc.172.2022.02.17.08.50.28
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 08:50:29 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id p9so10060590wra.12
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 08:50:28 -0800 (PST)
X-Received: by 2002:a5d:64ef:0:b0:1e3:1e05:d042 with SMTP id
 g15-20020a5d64ef000000b001e31e05d042mr2888765wri.679.1645116628087; Thu, 17
 Feb 2022 08:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20220207073036.14901-1-lukasz.luba@arm.com> <20220207073036.14901-2-lukasz.luba@arm.com>
 <YgG+TmLrCSXX4Bvt@google.com> <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
 <CAD=FV=UtQgrwPXg4zTZtBin3LWY1yTgCKQ05MmCNqK_6F5S8VA@mail.gmail.com> <adbc1cd5-7598-a0b1-629c-8dd920aac2d0@arm.com>
In-Reply-To: <adbc1cd5-7598-a0b1-629c-8dd920aac2d0@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Feb 2022 08:50:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XzTSxg9sAtUcDhoLnY736u1qGKJy4OwLKp56_ruSUUvQ@mail.gmail.com>
Message-ID: <CAD=FV=XzTSxg9sAtUcDhoLnY736u1qGKJy4OwLKp56_ruSUUvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Feb 16, 2022 at 3:28 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> On 2/16/22 5:21 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Feb 8, 2022 at 1:32 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>>     Another important thing is the consistent scale of the power values
> >>>     provided by the cooling devices. All of the cooling devices in a single
> >>>     thermal zone should have power values reported either in milli-Watts
> >>>     or scaled to the same 'abstract scale'.
> >>
> >> This can change. We have removed the userspace governor from kernel
> >> recently. The trend is to implement thermal policy in FW. Dealing with
> >> some intermediate configurations are causing complicated design, support
> >> of the algorithm logic is also more complex.
> >
> > One thing that didn't get addressed is the whole "The trend is to
> > implement thermal policy in FW". I'm not sure I can get on board with
> > that trend. IMO "moving to FW" isn't a super great trend. FW is harder
> > to update than kernel and trying to keep it in sync with the kernel
> > isn't wonderful. Unless something _has_ to be in FW I personally
> > prefer it to be in the kernel.
>
> There are pros and cons for both approaches (as always).
>
> Although, there are some use cases, where the kernel is not able to
> react that fast, e.g. sudden power usage changes, which can cause
> that the power rail is not able to sustain within required conditions.
> When we are talking about tough requirements for those power & thermal
> policies, the mechanism must be fast, precised and reliable.
>
> Here you can find Arm reference FW implementation and an IPA clone
> in there (I have been reviewing this) [1][2].
>
> As you can see there is a new FW feature set:
> "MPMM, Traffic-cop and Thermal management".
>
> Apart from Arm implementation, there are already known thermal
> monitoring mechanisms in HW/FW. Like in the new Qcom SoCs which
> are using this driver code [3]. The driver receives an interrupt
> about throttling conditions and just populates the thermal pressure.

Yeah, this has come up in another context recently too. Right on on
the Qcom SoCs I'm working with (sc7180 on Chromebooks) we've
essentially disabled all the HW/FW throttling (LMH), preferring to let
Linux manage things. We chose to do it this way with the assumption
that Linux would be able to make better decisions than the firmware
and it was easier to understand / update than an opaque
vendor-provided blob. LMH is still there with super high limits in
case Linux goofs up (we don't want to damage the CPU) but it's not the
primary means of throttling.

As you said, Linux reacts a bit slower, though I've heard that might
be fixed soon-ish? So far on sc7180 Chromebooks it hasn't been a
problem because we have more total thermal mass and the CPUs in sc7180
don't actually generate that much heat compared to other CPUs. We also
have thermal interrupts enabled, which helps. That being said,
improvements are certainly welcome!


> > ...although now that I re-read this, I'm not sure which firmware you
> > might be talking about. Is this the AP firmware, or some companion
> > chip / coprocessor? Even so, I'd still rather see things done in the
> > kernel when possible...
>
> It's a FW run on a dedicated microprocessor. In Arm SoCs it's usually
> some Cortex-M. We communicated with it from the kernel via SCMI drivers
> (using shared memory and mailboxes). We recommend to use the SCMI
> protocol to send e.g. 'performance request' to the FW via 'fast
> channel' instead of having an implementation of PMIC and clock, and do
> the voltage & freq change in the kernel (using drivers & locking). That
> implementation allows to avoid costly locking and allows to go via
> that SCMI cpufreq driver [4] and SCMI perf layer [5] the task scheduler.
> We don't need a dedicated 'sugov' kthread in a Deadline policy to
> do that work and preempt the currently running task.
>
> IMHO the FW approach opens new opportunities.
>
> Regards,
> Lukasz
>
> [1] https://github.com/ARM-software/SCP-firmware/pull/588
> [2]
> https://github.com/ARM-software/SCP-firmware/pull/588/commits/59c62ead5eb66353ae805c367bfa86192e28c410
> [3]
> https://elixir.bootlin.com/linux/v5.17-rc4/source/drivers/cpufreq/qcom-cpufreq-hw.c#L287
> [4]
> https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/scmi-cpufreq.c#L65
> [5]
> https://elixir.bootlin.com/linux/v5.17-rc4/source/drivers/firmware/arm_scmi/perf.c#L465
