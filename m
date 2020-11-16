Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE492B4A23
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgKPP5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 10:57:48 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:45776 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731037AbgKPP5s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Nov 2020 10:57:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605542266; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=6HGCSwDZVKueqqM2Nkc4f/P4EM4pfAA4O5tQ+/Y0P5Q=; b=Hxv2Mt2aPo5rNaWtfl3nU8WghS9wkjLYkkX7CmRM3HzWzhs78SV1f6KTgwfVvuCPbS0glZfa
 Wqn5tURmaLJ7jLT2fZegmAgKiHJ/5eztKQT+wyvzlNsUa2UG9UYaOEYNpw20l8BLLIOu7DbM
 4Pd14U0jksCL7xmOHaKGC06PTD4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fb2a1738bd2e3c2227600c9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 15:57:39
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E51F4C43461; Mon, 16 Nov 2020 15:57:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86AE9C433C6;
        Mon, 16 Nov 2020 15:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86AE9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 16 Nov 2020 08:57:36 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PM / Domains: use device's next wakeup to
 determine domain idle state
Message-ID: <X7KhcItlnS+uuqK2@codeaurora.org>
References: <20201106164811.3698-1-ilina@codeaurora.org>
 <20201106164811.3698-3-ilina@codeaurora.org>
 <CAPDyKFrv-3USmNLR3gjgaTEuTrWuYZjs3qCtnjxSOWqrxv5qsA@mail.gmail.com>
 <X6l/OcHG37HzgFL8@codeaurora.org>
 <CAPDyKFr8fdbMM1nsx-RZcMVtveJUP3p38z=HkL1T2C=QgM3gkQ@mail.gmail.com>
 <X6wRBLmvzztNai4y@codeaurora.org>
 <CAPDyKFr9gpH9Kh9=W4D7DRG8OuqBvkaWHvk8i47SToES=338cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFr9gpH9Kh9=W4D7DRG8OuqBvkaWHvk8i47SToES=338cA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 13 2020 at 03:34 -0700, Ulf Hansson wrote:
>On Wed, 11 Nov 2020 at 17:51, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Tue, Nov 10 2020 at 03:02 -0700, Ulf Hansson wrote:
>> >On Mon, 9 Nov 2020 at 18:41, Lina Iyer <ilina@codeaurora.org> wrote:
>> >>
>> >> On Mon, Nov 09 2020 at 08:27 -0700, Ulf Hansson wrote:
>> >> >On Fri, 6 Nov 2020 at 17:48, Lina Iyer <ilina@codeaurora.org> wrote:
>> >> >>
>> >> [...]
>> >> >> +static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t now)
>> >> >> +{
>> >> >> +       ktime_t domain_wakeup = KTIME_MAX;
>> >> >> +       ktime_t next_wakeup;
>> >> >> +       struct pm_domain_data *pdd;
>> >> >> +       struct gpd_link *link;
>> >> >> +
>> >> >> +       /* Find the earliest wakeup for all devices in the domain */
>> >> >> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>> >> >> +               next_wakeup = to_gpd_data(pdd)->next_wakeup;
>> >> >> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
>> >> >> +                       if (ktime_before(next_wakeup, domain_wakeup))
>> >> >> +                               domain_wakeup = next_wakeup;
>> >> >
>> >> >If it turns out that one of the device's next_wakeup is before "now",
>> >> >leading to ktime_before() above returns true - then I think you should
>> >> >bail out, no?
>> >> >
>> >> >At least, we shouldn't just continue and ignore this case, right?
>> >> >
>> >> No, that could be a very common case. Drivers are not expected to clean
>> >> up the next wakeup by setting it to KTIME_MAX. The best we can do is
>> >> to make a choice with the valid information we have. This will also map
>> >> to the current behavior. Say if all next wakeup information provided to
>> >> the devices were in the past, we would be no worse (or better) than what
>> >> we do without this change.
>> >
>> >Well, I don't quite agree (at least not yet), but let me elaborate, as
>> >I think we can do better without having to add complexity.
>> >
>> >Normally, I don't think a driver needs to clean up its device's next
>> >wakeup in between the remote wakeups, instead it should just set a new
>> >value.
>> >
>> >That's because, even if the driver acts to a remote wakeup or deals
>> >with a request entering a queue, the driver needs to runtime resume
>> >its device during this period. This prevents genpd from power off the
>> >PM domain, hence also the genpd governor from potentially looking at
>> >"invalid" wakeup information for its attached devices.
>> >
>> Could you elaborate a bit? Why would a remote wakeup affect the next
>> wakeup. I'm afraid that I'm not getting the situation correctly.
>
>Let me try :-)
>
>A remote wakeup is a wakeup irq that is triggered when the device is
>in runtime suspended state.
>
>I was expecting that you would be arming a remote wakeup for the
>corresponding device that is attached to a genpd, when the use case
>becomes enabled. Additionally, to allow the driver to consume the
>wakeup irq, it needs to runtime resume its device (which means its PM
>domain via genpd must be powered on as well, if it's not on already).
>
>Therefore, during the period of when the driver consumes the wakeup
>irq, its device's PM domain remains powered on. When this is
>completed, the driver allows its device to become runtime suspended
>again. At some point before the device becomes runtime suspended, the
>driver should set a new value of the "next wakeup" for its device.
>
Okay, that is clear. Thanks :)

Yes, we would expect the device to set up its next_wakeup before doing
runtime suspend and if the next wakeup is in the past, we would possibly
not have runtime suspended the device. That would keep the domain ON and
we would not come to this governor at all. And if we still are doing it,
then the device has not set the next wakeup correctly.

What you are suggesting is that, we should not power down the domain in
such a case. This would be a really hard problem to debug when a device
leaves a stale wakeup behind and we no longer power off the domain
because of that. Tracking that back to the device will be a monumental
effort. Ignoring the next wakeup though might involve a power/perf 
penalty (no worse than today), but we would not have a difficult problem
to solve.

>>
>> >Of course, I assume there are situations, where a driver actually
>> >needs to do a clean up of its device's next wakeup, but that should be
>> >less frequent and likely when a remote wakeup is disabled (for
>> >whatever reason).
>> >
>> A common case would be that the driver does not know when the usecase is
>> being turned off and therefore may not be able to set the next wakeup to
>> max. If the stale value continues to exist then we may never power off
>> the domain.
>
>Right.
>
>But, how do you know that the use case starts and what prevents us
>from knowing that the use case has stopped?
>
Usually, the device is made aware of the usecase when it starts, but
stopping the usecase might be something the device may or may not be
aware of.

>Maybe if you add a user of the new APIs, this would help me to
>understand better?
>
I have been asking some folks, but let's see.

[...]

>> >> >For example, there's no point doing the above, if the domain doesn't
>> >> >specify residency values for its idle states.
>> >> >
>> >> We would still need to ensure that the next wakeup is after the
>> >> power_off_latency, if specified.
>> >
>> >Good point! Although, I would rather avoid adding the overhead, unless
>> >the residency is specified. Do you see a problem with this approach?
>> >
>> Hmmm, no strong objections. However, we still need to run through the
>> states to make sure the residency is not set and have a variable track
>> that.
>
>Right.
>
>The important part is that we can do that once and not for every call
>to the governor.
>
>> The devices wouldn't know that and would still continue to set the
>> next wakeup, unless we find a way to let them know we are not using this
>> feature for the domain.
>
>Right.
>
>To allow the driver to know, we could respond with an error code from
>the new dev_pm_genpd_set_performance_state() API (from patch1), in
>case the genpd+governor doesn't support it.
>
It would an unnecessary work everytime a next wakeup is being set to
iterate through the available states and figure out if the residency has
been set or not. We could probably hold that result in a variable when
we setup the genpd states. Expect the next_wake to be set from a
critical path or an interrupt handler, so we have to be quick.

>Would that be okay? Otherwise we will have to add a separate genpd
>API, asking explicitly if the "next wakeup" feature is supported.
>
Would like to avoid that as much as possible.

Thanks,
Lina

