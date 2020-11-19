Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5222B8FA1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 11:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKSJ5N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 04:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgKSJ5M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 04:57:12 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCCEC0613CF
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2020 01:57:12 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id x13so1720454uar.4
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2020 01:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhtUo5DDWR1Wj8D/VLi8cQ8orehykMaquIOMEKE59vw=;
        b=xno0khaWrRb+B2WE5lB+NJEGpsgrt5De2fXglgPUl4KW8igRy/SFAiFsqxEsdcmeDH
         Hmm9/0TXUafLgE3G1PYvLWdJOQIpqdJRstRoCeHmi1GiTENfgJI+WmeRbyb1gR3O9VbS
         g9/XcyCRP4mLpFlm/m2BYrRKjubfRgm6co+jP4h0MtYDcsRgtkIGJhvseG9ZBtA6EdjA
         l4vVW3IBjdQnaM8GzRrFkocF8uOTH06tGoDvQy+1CTlQQ6Y6DNuU/FSqtTF0qC1wVj0u
         M44MFzstvcCLHKnIqdI+gpMDYmirKYoV+1cASFkxkBBvzBcbwLulWRXJhzS0/0+5BHuE
         ONbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhtUo5DDWR1Wj8D/VLi8cQ8orehykMaquIOMEKE59vw=;
        b=KcA8a15F772Tv4iOoaToE5odLYNozRvIvsXPSidJuj8thZURzXwxxIeG695WGHyWNh
         bDAJChQKPjExAWbdH8C6OUCnn+T9uZF09CmBDkyzz+H/QBCq01Lr0m0RFsZh6cmnGhUI
         RZGxELAjxilZpk9NDo/x5xzgDJrQNZwJi6SwliQ9tbPa5HCMpG3nhyN4F0vdHrIlTOs4
         eIhFBLnR1lDZJzgH7A7jz5bMjJLxT2G7xnnSMMma7Jepizq9Ztdw97Y9FmqQyOTRoC/G
         GqpWx58r8FaIJjyzsTvq9beJEuCKfcFT7A+wGFpogHpML0g/l5EZwQ4jKKxo8DndlDFJ
         uceg==
X-Gm-Message-State: AOAM532smCwG6G9SXMhfdtuseaOPlSGK7Bp0hP2L7bKr9sBU630/g/Ue
        yGG5Zq0yBCT13W+QTL2ogjVEdLMIw1qld5zHFpuzrw==
X-Google-Smtp-Source: ABdhPJxdKL5Mh2DLVNMy/ooX6cemQ+T+3BnsD9Jyqpy8xDlpGLA9LXtH0AiGRi1o1WyQb+tmFYC+6RycGzwUAZ2GBBU=
X-Received: by 2002:ab0:c12:: with SMTP id a18mr6868080uak.19.1605779831706;
 Thu, 19 Nov 2020 01:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20201106164811.3698-1-ilina@codeaurora.org> <20201106164811.3698-3-ilina@codeaurora.org>
 <CAPDyKFrv-3USmNLR3gjgaTEuTrWuYZjs3qCtnjxSOWqrxv5qsA@mail.gmail.com>
 <X6l/OcHG37HzgFL8@codeaurora.org> <CAPDyKFr8fdbMM1nsx-RZcMVtveJUP3p38z=HkL1T2C=QgM3gkQ@mail.gmail.com>
 <X6wRBLmvzztNai4y@codeaurora.org> <CAPDyKFr9gpH9Kh9=W4D7DRG8OuqBvkaWHvk8i47SToES=338cA@mail.gmail.com>
 <X7KhcItlnS+uuqK2@codeaurora.org>
In-Reply-To: <X7KhcItlnS+uuqK2@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Nov 2020 10:56:35 +0100
Message-ID: <CAPDyKFpKookuX2ynBfy44kyfZq48JPaUrEHevetsyoc83=UnsA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PM / Domains: use device's next wakeup to
 determine domain idle state
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Nov 2020 at 16:57, Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Fri, Nov 13 2020 at 03:34 -0700, Ulf Hansson wrote:
> >On Wed, 11 Nov 2020 at 17:51, Lina Iyer <ilina@codeaurora.org> wrote:
> >>
> >> On Tue, Nov 10 2020 at 03:02 -0700, Ulf Hansson wrote:
> >> >On Mon, 9 Nov 2020 at 18:41, Lina Iyer <ilina@codeaurora.org> wrote:
> >> >>
> >> >> On Mon, Nov 09 2020 at 08:27 -0700, Ulf Hansson wrote:
> >> >> >On Fri, 6 Nov 2020 at 17:48, Lina Iyer <ilina@codeaurora.org> wrote:
> >> >> >>
> >> >> [...]
> >> >> >> +static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t now)
> >> >> >> +{
> >> >> >> +       ktime_t domain_wakeup = KTIME_MAX;
> >> >> >> +       ktime_t next_wakeup;
> >> >> >> +       struct pm_domain_data *pdd;
> >> >> >> +       struct gpd_link *link;
> >> >> >> +
> >> >> >> +       /* Find the earliest wakeup for all devices in the domain */
> >> >> >> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> >> >> >> +               next_wakeup = to_gpd_data(pdd)->next_wakeup;
> >> >> >> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
> >> >> >> +                       if (ktime_before(next_wakeup, domain_wakeup))
> >> >> >> +                               domain_wakeup = next_wakeup;
> >> >> >
> >> >> >If it turns out that one of the device's next_wakeup is before "now",
> >> >> >leading to ktime_before() above returns true - then I think you should
> >> >> >bail out, no?
> >> >> >
> >> >> >At least, we shouldn't just continue and ignore this case, right?
> >> >> >
> >> >> No, that could be a very common case. Drivers are not expected to clean
> >> >> up the next wakeup by setting it to KTIME_MAX. The best we can do is
> >> >> to make a choice with the valid information we have. This will also map
> >> >> to the current behavior. Say if all next wakeup information provided to
> >> >> the devices were in the past, we would be no worse (or better) than what
> >> >> we do without this change.
> >> >
> >> >Well, I don't quite agree (at least not yet), but let me elaborate, as
> >> >I think we can do better without having to add complexity.
> >> >
> >> >Normally, I don't think a driver needs to clean up its device's next
> >> >wakeup in between the remote wakeups, instead it should just set a new
> >> >value.
> >> >
> >> >That's because, even if the driver acts to a remote wakeup or deals
> >> >with a request entering a queue, the driver needs to runtime resume
> >> >its device during this period. This prevents genpd from power off the
> >> >PM domain, hence also the genpd governor from potentially looking at
> >> >"invalid" wakeup information for its attached devices.
> >> >
> >> Could you elaborate a bit? Why would a remote wakeup affect the next
> >> wakeup. I'm afraid that I'm not getting the situation correctly.
> >
> >Let me try :-)
> >
> >A remote wakeup is a wakeup irq that is triggered when the device is
> >in runtime suspended state.
> >
> >I was expecting that you would be arming a remote wakeup for the
> >corresponding device that is attached to a genpd, when the use case
> >becomes enabled. Additionally, to allow the driver to consume the
> >wakeup irq, it needs to runtime resume its device (which means its PM
> >domain via genpd must be powered on as well, if it's not on already).
> >
> >Therefore, during the period of when the driver consumes the wakeup
> >irq, its device's PM domain remains powered on. When this is
> >completed, the driver allows its device to become runtime suspended
> >again. At some point before the device becomes runtime suspended, the
> >driver should set a new value of the "next wakeup" for its device.
> >
> Okay, that is clear. Thanks :)
>
> Yes, we would expect the device to set up its next_wakeup before doing
> runtime suspend and if the next wakeup is in the past, we would possibly
> not have runtime suspended the device. That would keep the domain ON and
> we would not come to this governor at all. And if we still are doing it,
> then the device has not set the next wakeup correctly.

Correct.

>
> What you are suggesting is that, we should not power down the domain in
> such a case. This would be a really hard problem to debug when a device
> leaves a stale wakeup behind and we no longer power off the domain
> because of that. Tracking that back to the device will be a monumental
> effort. Ignoring the next wakeup though might involve a power/perf
> penalty (no worse than today), but we would not have a difficult problem
> to solve.

Hmm, you have a good point!

Additionally, I guess it should be a rather seldom situation, as in
principle the wakeup irq should have been triggered already.

That said, I am okay to stick with your suggested approach.

Although, please add a comment in the code, to make it clear that the
behaviour is deliberate. Perhaps we should also clarify the function
description of dev_pm_genpd_set_next_wakeup() (in patch1) to make the
behaviour more clear for the user.

>
> >>
> >> >Of course, I assume there are situations, where a driver actually
> >> >needs to do a clean up of its device's next wakeup, but that should be
> >> >less frequent and likely when a remote wakeup is disabled (for
> >> >whatever reason).
> >> >
> >> A common case would be that the driver does not know when the usecase is
> >> being turned off and therefore may not be able to set the next wakeup to
> >> max. If the stale value continues to exist then we may never power off
> >> the domain.
> >
> >Right.
> >
> >But, how do you know that the use case starts and what prevents us
> >from knowing that the use case has stopped?
> >
> Usually, the device is made aware of the usecase when it starts, but
> stopping the usecase might be something the device may or may not be
> aware of.

Okay, I see.

I guess this means the remote wakeup stays armed, but there are no
longer any wakeups being triggered.

>
> >Maybe if you add a user of the new APIs, this would help me to
> >understand better?
> >
> I have been asking some folks, but let's see.
>
> [...]
>
> >> >> >For example, there's no point doing the above, if the domain doesn't
> >> >> >specify residency values for its idle states.
> >> >> >
> >> >> We would still need to ensure that the next wakeup is after the
> >> >> power_off_latency, if specified.
> >> >
> >> >Good point! Although, I would rather avoid adding the overhead, unless
> >> >the residency is specified. Do you see a problem with this approach?
> >> >
> >> Hmmm, no strong objections. However, we still need to run through the
> >> states to make sure the residency is not set and have a variable track
> >> that.
> >
> >Right.
> >
> >The important part is that we can do that once and not for every call
> >to the governor.
> >
> >> The devices wouldn't know that and would still continue to set the
> >> next wakeup, unless we find a way to let them know we are not using this
> >> feature for the domain.
> >
> >Right.
> >
> >To allow the driver to know, we could respond with an error code from
> >the new dev_pm_genpd_set_performance_state() API (from patch1), in
> >case the genpd+governor doesn't support it.
> >
> It would an unnecessary work everytime a next wakeup is being set to
> iterate through the available states and figure out if the residency has
> been set or not. We could probably hold that result in a variable when
> we setup the genpd states. Expect the next_wake to be set from a
> critical path or an interrupt handler, so we have to be quick.

Yes, that's the idea I had in mind.

Maybe it's not feasible, let's see. However, for sure I am looking at
decreasing overhead, not to increase. :-)

>
> >Would that be okay? Otherwise we will have to add a separate genpd
> >API, asking explicitly if the "next wakeup" feature is supported.
> >
> Would like to avoid that as much as possible.

Okay, good.

Kind regards
Uffe
