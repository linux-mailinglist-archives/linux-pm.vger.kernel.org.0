Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AC72A872F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 20:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgKET3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 14:29:40 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:52008 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731149AbgKET3k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 14:29:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604604578; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=xTUKoyQqWK72KnyGHbpYCnZ0pG+T1pvlVZ0AWmaPtIw=; b=eq+4mgfbypvPGibaM2fkEUZkPRqO18peF4LEQdz7nz7MoXASPGh/g7XS7RzdtyAr75ic0AgH
 AFjnwSO7rMEo9vIlmLR7HLLAc2NCjQE/xxthXTNdDy+vtyAAPFSfYdROEGESdXevTleKHoGV
 T/ELpJlUspTRsX2xCQcMsIF84ro=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5fa452861f7506a997a3aa21 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 19:29:10
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC8A9C433C9; Thu,  5 Nov 2020 19:29:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2632DC433C6;
        Thu,  5 Nov 2020 19:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2632DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 5 Nov 2020 12:29:07 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] PM / Domains: use device's next wakeup to
 determine domain idle state
Message-ID: <20201105192907.GB2526@codeaurora.org>
References: <20201020180413.32225-1-ilina@codeaurora.org>
 <20201020180413.32225-3-ilina@codeaurora.org>
 <CAJZ5v0gTA=_QOFJLMCxH+CqfDFKUJU5ZbpN2+DHLTP1gKg3HQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gTA=_QOFJLMCxH+CqfDFKUJU5ZbpN2+DHLTP1gKg3HQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for your time Rafael.

On Thu, Nov 05 2020 at 11:56 -0700, Rafael J. Wysocki wrote:
>On Tue, Oct 20, 2020 at 8:05 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> Currently, a PM domain's idle state is determined based on whether the
>> QoS requirements are met. This may not save power, if the idle state
>> residency requirements are not met.
>>
>> CPU PM domains use the next timer wakeup for the CPUs in the domain to
>> determine the sleep duration of the domain. This is compared with the
>> idle state residencies to determine the optimal idle state. For other PM
>> domains, determining the sleep length is not that straight forward. But
>> if the device's next_event is available, we can use that to determine
>> the sleep duration of the PM domain.
>>
>> Let's update the domain governor logic to check for idle state residency
>> based on the next wakeup of devices as well as QoS constraints.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>
>A few nits follow.
>
>> ---
>> Changes in v4:
>>         - Update to use next_wakeup from struct generic_pm_domain_data.
>> Changes in v3:
>>         - None
>> Changes in v2:
>>         - Fix state_idx type to hold negative value.
>>         - Update commit text.
>> ---
>>  drivers/base/power/domain_governor.c | 84 ++++++++++++++++++++++++++--
>>  include/linux/pm_domain.h            |  1 +
>>  2 files changed, 80 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
>> index 490ed7deb99a..092927b60dc0 100644
>> --- a/drivers/base/power/domain_governor.c
>> +++ b/drivers/base/power/domain_governor.c
>> @@ -117,6 +117,49 @@ static bool default_suspend_ok(struct device *dev)
>>         return td->cached_suspend_ok;
>>  }
>>
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
>> +       }
>> +
>> +       /* Then find the earliest wakeup of from all the child domains */
>> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
>> +               next_wakeup = link->child->next_wakeup;
>> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
>> +                       if (ktime_before(next_wakeup, domain_wakeup))
>> +                               domain_wakeup = next_wakeup;
>> +       }
>
>This is assuming that the lists will remain stable during the walks
>above, but is that guaranteed?
>
I would expect so. We are looking up the child domains, which should be
powered down and therefore their domain::next_wakeup should be locked in
(because we update next_wakeup only in this governor).

>> +
>> +       genpd->next_wakeup = domain_wakeup;
>> +}
>> +
>> +static bool next_wakeup_allows_state(struct generic_pm_domain *genpd,
>> +                                    unsigned int state, ktime_t now)
>> +{
>> +       s64 idle_time_ns, min_sleep_ns;
>> +       ktime_t domain_wakeup = genpd->next_wakeup;
>
>I'd move the second line to the top (it looks odd now IMO).
>
I agree and prefer that as well but I missed this.
Will update in the next spin.

>> +
>> +       min_sleep_ns = genpd->states[state].power_off_latency_ns +
>> +                      genpd->states[state].power_on_latency_ns +
>> +                      genpd->states[state].residency_ns;
>> +
>> +       idle_time_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
>> +       if (idle_time_ns < min_sleep_ns)
>> +               return false;
>> +
>> +       return true;
>
>Why not
>
>+       return idle_time_ns >= min_sleep_ns;
>
OK.

>> +}
>> +
>>  static bool __default_power_down_ok(struct dev_pm_domain *pd,
>>                                      unsigned int state)
>>  {
>> @@ -210,6 +253,33 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>>  {
>>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
>>         struct gpd_link *link;
>> +       int state_idx;
>
>Why not initialize it right away?
>
OK.

Thanks,
Lina

>> +       ktime_t now = ktime_get();
>> +
>> +       /*
>> +        * Find the next wakeup from devices that can determine their own wakeup
>> +        * to find when the domain would wakeup and do it for every device down
>> +        * the hierarchy. It is not worth while to sleep if the state's residency
>> +        * cannot be met.
>> +        */
>> +       update_domain_next_wakeup(genpd, now);
>> +       state_idx = genpd->state_count - 1;
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
>>
>>         if (!genpd->max_off_time_changed) {
>>                 genpd->state_idx = genpd->cached_power_down_state_idx;
>> @@ -228,17 +298,21 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
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
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index e00c77b1efd8..205b750a2e56 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -130,6 +130,7 @@ struct generic_pm_domain {
>>                                      unsigned int state);
>>         struct gpd_dev_ops dev_ops;
>>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>> +       ktime_t next_wakeup;    /* Maintained by the domain governor */
>>         bool max_off_time_changed;
>>         bool cached_power_down_ok;
>>         bool cached_power_down_state_idx;
>> --
