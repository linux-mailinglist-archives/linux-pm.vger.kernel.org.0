Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D442AF6FB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 17:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKKQyz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 11:54:55 -0500
Received: from z5.mailgun.us ([104.130.96.5]:30709 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgKKQyy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Nov 2020 11:54:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605113694; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=O6OuMly3TJfbOBSpo9PbutFIcuKKSbbn6XrVvKQNwmg=; b=PPLt2ov7gEKx5jx6/YmHS5rzKRCzV7PgUE6yKBD4Rx8rWqbNTQrGl+VauHvPaZWD/5NOqC/C
 Nz8QxzrtxAT26gxZ8g3zxvXqZCLZDpLDBJHlLjniAi7Z201uuqwXS3En2DRgYjAr24eWhrtW
 ft+3hyirYKBzl56lAPGPEdL7ERY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fac1107d6d93bf0e9431e87 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 16:27:51
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94E1CC433FF; Wed, 11 Nov 2020 16:27:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85ED7C433C9;
        Wed, 11 Nov 2020 16:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85ED7C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 11 Nov 2020 09:27:48 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PM / Domains: use device's next wakeup to
 determine domain idle state
Message-ID: <X6wRBLmvzztNai4y@codeaurora.org>
References: <20201106164811.3698-1-ilina@codeaurora.org>
 <20201106164811.3698-3-ilina@codeaurora.org>
 <CAPDyKFrv-3USmNLR3gjgaTEuTrWuYZjs3qCtnjxSOWqrxv5qsA@mail.gmail.com>
 <X6l/OcHG37HzgFL8@codeaurora.org>
 <CAPDyKFr8fdbMM1nsx-RZcMVtveJUP3p38z=HkL1T2C=QgM3gkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFr8fdbMM1nsx-RZcMVtveJUP3p38z=HkL1T2C=QgM3gkQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 10 2020 at 03:02 -0700, Ulf Hansson wrote:
>On Mon, 9 Nov 2020 at 18:41, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Mon, Nov 09 2020 at 08:27 -0700, Ulf Hansson wrote:
>> >On Fri, 6 Nov 2020 at 17:48, Lina Iyer <ilina@codeaurora.org> wrote:
>> >>
>> [...]
>> >> +static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t now)
>> >> +{
>> >> +       ktime_t domain_wakeup = KTIME_MAX;
>> >> +       ktime_t next_wakeup;
>> >> +       struct pm_domain_data *pdd;
>> >> +       struct gpd_link *link;
>> >> +
>> >> +       /* Find the earliest wakeup for all devices in the domain */
>> >> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>> >> +               next_wakeup = to_gpd_data(pdd)->next_wakeup;
>> >> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
>> >> +                       if (ktime_before(next_wakeup, domain_wakeup))
>> >> +                               domain_wakeup = next_wakeup;
>> >
>> >If it turns out that one of the device's next_wakeup is before "now",
>> >leading to ktime_before() above returns true - then I think you should
>> >bail out, no?
>> >
>> >At least, we shouldn't just continue and ignore this case, right?
>> >
>> No, that could be a very common case. Drivers are not expected to clean
>> up the next wakeup by setting it to KTIME_MAX. The best we can do is
>> to make a choice with the valid information we have. This will also map
>> to the current behavior. Say if all next wakeup information provided to
>> the devices were in the past, we would be no worse (or better) than what
>> we do without this change.
>
>Well, I don't quite agree (at least not yet), but let me elaborate, as
>I think we can do better without having to add complexity.
>
>Normally, I don't think a driver needs to clean up its device's next
>wakeup in between the remote wakeups, instead it should just set a new
>value.
>
>That's because, even if the driver acts to a remote wakeup or deals
>with a request entering a queue, the driver needs to runtime resume
>its device during this period. This prevents genpd from power off the
>PM domain, hence also the genpd governor from potentially looking at
>"invalid" wakeup information for its attached devices.
>
Could you elaborate a bit? Why would a remote wakeup affect the next
wakeup. I'm afraid that I'm not getting the situation correctly.

>Of course, I assume there are situations, where a driver actually
>needs to do a clean up of its device's next wakeup, but that should be
>less frequent and likely when a remote wakeup is disabled (for
>whatever reason).
>
A common case would be that the driver does not know when the usecase is
being turned off and therefore may not be able to set the next wakeup to
max. If the stale value continues to exist then we may never power off
the domain.

>> >> +       /*
>> >> +        * Find the next wakeup from devices that can determine their own wakeup
>> >> +        * to find when the domain would wakeup and do it for every device down
>> >> +        * the hierarchy. It is not worth while to sleep if the state's residency
>> >> +        * cannot be met.
>> >> +        */
>> >> +       update_domain_next_wakeup(genpd, now);
>> >> +       if (genpd->next_wakeup != KTIME_MAX) {
>> >> +               /* Let's find out the deepest domain idle state, the devices prefer */
>> >> +               while (state_idx >= 0) {
>> >> +                       if (next_wakeup_allows_state(genpd, state_idx, now)) {
>> >> +                               genpd->max_off_time_changed = true;
>> >> +                               break;
>> >> +                       }
>> >> +                       state_idx--;
>> >> +               }
>> >> +
>> >> +               if (state_idx < 0) {
>> >> +                       state_idx = 0;
>> >> +                       genpd->cached_power_down_ok = false;
>> >> +                       goto done;
>> >> +               }
>> >> +       }
>> >> +
>> >
>> >The above would introduce unnecessary overhead, as it may become
>> >executed in cases when it's not needed.
>> >
>> >For example, there's no point doing the above, if the domain doesn't
>> >specify residency values for its idle states.
>> >
>> We would still need to ensure that the next wakeup is after the
>> power_off_latency, if specified.
>
>Good point! Although, I would rather avoid adding the overhead, unless
>the residency is specified. Do you see a problem with this approach?
>
Hmmm, no strong objections. However, we still need to run through the
states to make sure the residency is not set and have a variable track
that. The devices wouldn't know that and would still continue to set the
next wakeup, unless we find a way to let them know we are not using this
feature for the domain.

>Another option is to add a new governor, but if possible, I would like
>to avoid that.
>
Absolutely, we should avoid that.

>>
>> >Additionally, we don't need to recompute the domain's next wakup,
>> >unless a device has got a new next_wakeup value set for it. In this
>> >case, we can just select a state based upon an previously computed
>> >value, thus avoiding the recomputation.
>> >
>> If the domain's next wakeup was in the past, then using our previously
>> computed state may be incorrect.
>
>I am not saying you should use the previously computed *idlestate*,
>but the previously computed next wakeup.
>
I guess this falls into the first discussion, should be use the next
wakeup from the past.

>>
>> >>         if (!genpd->max_off_time_changed) {
>> >>                 genpd->state_idx = genpd->cached_power_down_state_idx;
>> >>                 return genpd->cached_power_down_ok;
>> >> @@ -228,17 +295,21 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>> >>         genpd->max_off_time_ns = -1;
>> >>         genpd->max_off_time_changed = false;
>> >>         genpd->cached_power_down_ok = true;
>> >> -       genpd->state_idx = genpd->state_count - 1;
>> >>
>> >> -       /* Find a state to power down to, starting from the deepest. */
>> >> -       while (!__default_power_down_ok(pd, genpd->state_idx)) {
>> >> -               if (genpd->state_idx == 0) {
>> >> +       /*
>> >> +        * Find a state to power down to, starting from the state
>> >> +        * determined by the next wakeup.
>> >> +        */
>> >> +       while (!__default_power_down_ok(pd, state_idx)) {
>> >> +               if (state_idx == 0) {
>> >>                         genpd->cached_power_down_ok = false;
>> >>                         break;
>> >>                 }
>> >> -               genpd->state_idx--;
>> >> +               state_idx--;
>> >>         }
>> >>
>> >> +done:
>> >> +       genpd->state_idx = state_idx;
>> >>         genpd->cached_power_down_state_idx = genpd->state_idx;
>> >>         return genpd->cached_power_down_ok;
>> >>  }
>> >
>> >Another thing to consider for the above changes, is that the
>> >cpu_power_down_ok() calls into default_power_down_ok().
>> >
>> >Even if I am fine with the approach taken in $subject patch, I think
>> >it's important to try to keep the path a slim as possible as it's also
>> >executed in the CPU idlepath.
>> Wouldn't this be called only the last CPU is powering down and only if
>> the domain is ready to power down?
>>
>> >For example, $subject change means also
>> >that we end up calling ktime_get() twice in the same path, introducing
>> >unnecessary overhead. We can do better and avoid that by restructuring
>> >the code a bit, don't you think?
>> >
>> Hmmm, we could. I will submit a follow on patch to reorganize the code
>> so the ktime_get() would be called only once for either of the
>> power_down_ok callbacks.
>
>If possible, I would rather make it part of the series. Just fold in
>some "rework" patch before extending the governor, that should be
>possible I think.
>
Sure. Since this would affect changing the default_power_down_ok(), I
thought a follow on patch would be appropriate.

Thanks,
Lina
