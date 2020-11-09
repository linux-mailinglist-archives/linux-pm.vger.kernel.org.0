Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F082AC2A9
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 18:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbgKIRlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 12:41:20 -0500
Received: from z5.mailgun.us ([104.130.96.5]:50498 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731010AbgKIRlU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Nov 2020 12:41:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604943679; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Sgwvj7XffaOrVpgt35ymbzQsn38BkkjSeMIEPrtm/Eo=; b=mtugfPoYo2aa9DNCNbtivYswmD5b3Z1Co2DemSDKlo7ulTGfTh9fL9JLnV5UKettZUKMIv9J
 MHbdQiUKOOcdfNB7cj8SXKVRE7sIxpHkwkk6KrZokPTLcmZ7tM6gIzGIXKO6/znpgur9em2a
 CracmIzSql3kBd3q9YwO+ySIFSk=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fa97f3c0fe4be3f43f78486 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Nov 2020 17:41:16
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0AE2C433FE; Mon,  9 Nov 2020 17:41:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE35EC433C6;
        Mon,  9 Nov 2020 17:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE35EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 9 Nov 2020 10:41:13 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PM / Domains: use device's next wakeup to
 determine domain idle state
Message-ID: <X6l/OcHG37HzgFL8@codeaurora.org>
References: <20201106164811.3698-1-ilina@codeaurora.org>
 <20201106164811.3698-3-ilina@codeaurora.org>
 <CAPDyKFrv-3USmNLR3gjgaTEuTrWuYZjs3qCtnjxSOWqrxv5qsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFrv-3USmNLR3gjgaTEuTrWuYZjs3qCtnjxSOWqrxv5qsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 09 2020 at 08:27 -0700, Ulf Hansson wrote:
>On Fri, 6 Nov 2020 at 17:48, Lina Iyer <ilina@codeaurora.org> wrote:
>>
[...]
>> +static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t now)
>> +{
>> +       ktime_t domain_wakeup = KTIME_MAX;
>> +       ktime_t next_wakeup;
>> +       struct pm_domain_data *pdd;
>> +       struct gpd_link *link;
>> +
>> +       /* Find the earliest wakeup for all devices in the domain */
>> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>> +               next_wakeup = to_gpd_data(pdd)->next_wakeup;
>> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
>> +                       if (ktime_before(next_wakeup, domain_wakeup))
>> +                               domain_wakeup = next_wakeup;
>
>If it turns out that one of the device's next_wakeup is before "now",
>leading to ktime_before() above returns true - then I think you should
>bail out, no?
>
>At least, we shouldn't just continue and ignore this case, right?
>
No, that could be a very common case. Drivers are not expected to clean
up the next wakeup by setting it to KTIME_MAX. The best we can do is
to make a choice with the valid information we have. This will also map
to the current behavior. Say if all next wakeup information provided to
the devices were in the past, we would be no worse (or better) than what
we do without this change.

>> +       }
>> +
>> +       /* Then find the earliest wakeup of from all the child domains */
>> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
>> +               next_wakeup = link->child->next_wakeup;
>> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
>> +                       if (ktime_before(next_wakeup, domain_wakeup))
>> +                               domain_wakeup = next_wakeup;
>> +       }
>> +
>> +       genpd->next_wakeup = domain_wakeup;
>> +}
>> +
>> +static bool next_wakeup_allows_state(struct generic_pm_domain *genpd,
>> +                                    unsigned int state, ktime_t now)
>> +{
>> +       ktime_t domain_wakeup = genpd->next_wakeup;
>> +       s64 idle_time_ns, min_sleep_ns;
>> +
>> +       min_sleep_ns = genpd->states[state].power_off_latency_ns +
>> +                      genpd->states[state].power_on_latency_ns +
>> +                      genpd->states[state].residency_ns;
>> +
>
>I don't think you should include the power_on_latency_ns here.
>
>The validation isn't about QoS constraints, but whether we can meet
>the residency time to make it worth entering the state, from an energy
>point of view. Right?
>
Fair point. I will remove the power_on_latency_ns.

>> +       idle_time_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
>> +
>> +       return idle_time_ns >= min_sleep_ns;
>> +}
>> +
>>  static bool __default_power_down_ok(struct dev_pm_domain *pd,
>>                                      unsigned int state)
>>  {
>> @@ -209,8 +250,34 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
>>  static bool default_power_down_ok(struct dev_pm_domain *pd)
>>  {
>>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
>> +       int state_idx = genpd->state_count - 1;
>> +       ktime_t now = ktime_get();
>>         struct gpd_link *link;
>>
>> +       /*
>> +        * Find the next wakeup from devices that can determine their own wakeup
>> +        * to find when the domain would wakeup and do it for every device down
>> +        * the hierarchy. It is not worth while to sleep if the state's residency
>> +        * cannot be met.
>> +        */
>> +       update_domain_next_wakeup(genpd, now);
>> +       if (genpd->next_wakeup != KTIME_MAX) {
>> +               /* Let's find out the deepest domain idle state, the devices prefer */
>> +               while (state_idx >= 0) {
>> +                       if (next_wakeup_allows_state(genpd, state_idx, now)) {
>> +                               genpd->max_off_time_changed = true;
>> +                               break;
>> +                       }
>> +                       state_idx--;
>> +               }
>> +
>> +               if (state_idx < 0) {
>> +                       state_idx = 0;
>> +                       genpd->cached_power_down_ok = false;
>> +                       goto done;
>> +               }
>> +       }
>> +
>
>The above would introduce unnecessary overhead, as it may become
>executed in cases when it's not needed.
>
>For example, there's no point doing the above, if the domain doesn't
>specify residency values for its idle states.
>
We would still need to ensure that the next wakeup is after the
power_off_latency, if specified.

>Additionally, we don't need to recompute the domain's next wakup,
>unless a device has got a new next_wakeup value set for it. In this
>case, we can just select a state based upon an previously computed
>value, thus avoiding the recomputation.
>
If the domain's next wakeup was in the past, then using our previously
computed state may be incorrect.

>>         if (!genpd->max_off_time_changed) {
>>                 genpd->state_idx = genpd->cached_power_down_state_idx;
>>                 return genpd->cached_power_down_ok;
>> @@ -228,17 +295,21 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>>         genpd->max_off_time_ns = -1;
>>         genpd->max_off_time_changed = false;
>>         genpd->cached_power_down_ok = true;
>> -       genpd->state_idx = genpd->state_count - 1;
>>
>> -       /* Find a state to power down to, starting from the deepest. */
>> -       while (!__default_power_down_ok(pd, genpd->state_idx)) {
>> -               if (genpd->state_idx == 0) {
>> +       /*
>> +        * Find a state to power down to, starting from the state
>> +        * determined by the next wakeup.
>> +        */
>> +       while (!__default_power_down_ok(pd, state_idx)) {
>> +               if (state_idx == 0) {
>>                         genpd->cached_power_down_ok = false;
>>                         break;
>>                 }
>> -               genpd->state_idx--;
>> +               state_idx--;
>>         }
>>
>> +done:
>> +       genpd->state_idx = state_idx;
>>         genpd->cached_power_down_state_idx = genpd->state_idx;
>>         return genpd->cached_power_down_ok;
>>  }
>
>Another thing to consider for the above changes, is that the
>cpu_power_down_ok() calls into default_power_down_ok().
>
>Even if I am fine with the approach taken in $subject patch, I think
>it's important to try to keep the path a slim as possible as it's also
>executed in the CPU idlepath. 
Wouldn't this be called only the last CPU is powering down and only if
the domain is ready to power down?

>For example, $subject change means also
>that we end up calling ktime_get() twice in the same path, introducing
>unnecessary overhead. We can do better and avoid that by restructuring
>the code a bit, don't you think?
>
Hmmm, we could. I will submit a follow on patch to reorganize the code
so the ktime_get() would be called only once for either of the
power_down_ok callbacks.

Thanks for your review, Ulf.

-- Lina

