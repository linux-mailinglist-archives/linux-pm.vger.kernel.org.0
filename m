Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850AF290951
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409200AbgJPQHe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 12:07:34 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:60725 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406603AbgJPQHc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Oct 2020 12:07:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602864451; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=uhJj53xCONRhKPJcFztd2R/9OTHPKcPGdJ0r6ifqp7A=; b=OQ8sfyBX9aUP8erpf3h8n+qxwKHbK1KXS7jvG2PM1hmz3/dXqPF4WvXY9QohOd7xHy3spYyw
 I4ZGB0Dyyw6q8UcSqgGhQMWGkPrlKfRlchcE3enWkNdhbFLyON5n3pYG3E4/q00PQDXh4R2W
 oc2R7i+vvVQaJBEIyZ6LtWE8pbQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f89c53e588858a304698c5d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 16:07:26
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 99D81C433F1; Fri, 16 Oct 2020 16:07:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0857C433C9;
        Fri, 16 Oct 2020 16:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0857C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 16 Oct 2020 10:07:24 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v3] PM / Domains: enable domain idle state accounting
Message-ID: <20201016160724.GB16756@codeaurora.org>
References: <20201015204722.18764-1-ilina@codeaurora.org>
 <CAJZ5v0ifjHRomAxEKTW5z+VEZLGeM5MN-NcRxUUgrFQvtB0seQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ifjHRomAxEKTW5z+VEZLGeM5MN-NcRxUUgrFQvtB0seQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16 2020 at 09:55 -0600, Rafael J. Wysocki wrote:
>On Thu, Oct 15, 2020 at 10:47 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> To enable better debug of PM domains, let's keep a track of the success
>> and rejections in entering each domain idle state.
>>
>> This statistics is exported in debugfs when reading the idle_states
>> node, associated with each PM domain.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v3:
>>         - Rebased on top of mainline
>
>I still needed to rebase it to apply it to my tree, so please double
>check the result in the bleeding-edge branch.
>
Okay, will rebase on that branch and post shortly.
Thanks Rafael.

>Thanks!
>
>> ---
>>  drivers/base/power/domain.c | 10 +++++++---
>>  include/linux/pm_domain.h   |  2 ++
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 2cb5e04cf86c..20ecc1a7113c 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -559,12 +559,15 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>>                  * happen very often).
>>                  */
>>                 ret = _genpd_power_off(genpd, true);
>> -               if (ret)
>> +               if (ret) {
>> +                       genpd->states[genpd->state_idx].rejected++;
>>                         return ret;
>> +               }
>>         }
>>
>>         genpd->status = GPD_STATE_POWER_OFF;
>>         genpd_update_accounting(genpd);
>> +       genpd->states[genpd->state_idx].usage++;
>>
>>         list_for_each_entry(link, &genpd->child_links, child_node) {
>>                 genpd_sd_counter_dec(link->parent);
>> @@ -2932,7 +2935,7 @@ static int idle_states_show(struct seq_file *s, void *data)
>>         if (ret)
>>                 return -ERESTARTSYS;
>>
>> -       seq_puts(s, "State          Time Spent(ms)\n");
>> +       seq_puts(s, "State          Time Spent(ms) Usage          Rejected\n");
>>
>>         for (i = 0; i < genpd->state_count; i++) {
>>                 ktime_t delta = 0;
>> @@ -2944,7 +2947,8 @@ static int idle_states_show(struct seq_file *s, void *data)
>>
>>                 msecs = ktime_to_ms(
>>                         ktime_add(genpd->states[i].idle_time, delta));
>> -               seq_printf(s, "S%-13i %lld\n", i, msecs);
>> +               seq_printf(s, "S%-13i %-14lld %-14llu %llu\n", i, msecs,
>> +                             genpd->states[i].usage, genpd->states[i].rejected);
>>         }
>>
>>         genpd_unlock(genpd);
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index ee11502a575b..1d9a8de6b7ac 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -82,6 +82,8 @@ struct genpd_power_state {
>>         s64 power_off_latency_ns;
>>         s64 power_on_latency_ns;
>>         s64 residency_ns;
>> +       u64 usage;
>> +       u64 rejected;
>>         struct fwnode_handle *fwnode;
>>         ktime_t idle_time;
>>         void *data;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
