Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2C7278CFD
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgIYPmN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 11:42:13 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:25019 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgIYPmM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Sep 2020 11:42:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601048532; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=l4blT2IOXNBfUGMd3o8Mqd//fADRTBg/Wb0aNRk+Vf0=; b=nTm0+cIA1uJaVIgI/5sCp3wwrqMD3RU1OppuwvbCxSG+ibPizaq6X1LXumrIbm4q1UE0t8xK
 9i8UX5hJb/XTW6C4z+Y5iFbIQspoSoJJCnN7tfHS0sv7hnTIpeIlMAsMYT6awt4YELXq95tK
 2miAIgVheL9VURFVLrOnz9nify8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f6e0fc2d106659f828f92f7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Sep 2020 15:41:54
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC2CDC43382; Fri, 25 Sep 2020 15:41:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3151C433C8;
        Fri, 25 Sep 2020 15:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3151C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 25 Sep 2020 09:41:52 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH RFC] PM / Domains: enable domain idle state accounting
Message-ID: <20200925154152.GA17911@codeaurora.org>
References: <20200925024200.6429-1-ilina@codeaurora.org>
 <CAJZ5v0gLL8KxeLxYtQ0pVeYket5uXeTktL9MB3Uf7MW-MiD5rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gLL8KxeLxYtQ0pVeYket5uXeTktL9MB3Uf7MW-MiD5rg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 25 2020 at 09:29 -0600, Rafael J. Wysocki wrote:
>On Fri, Sep 25, 2020 at 4:42 AM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> To enable better debug of PM domains, let's keep a track of the success
>> and failures in entering each domain idle state.
>>
>> This statistics is exported in debugfs when reading the idle_states
>> node, associated with each PM domain.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>
>> ---
>> This patch depends-on: https://lkml.org/lkml/2020/9/24/465
>> ---
>>  drivers/base/power/domain.c | 7 +++++--
>>  include/linux/pm_domain.h   | 2 ++
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index f001ac6326fb..ba3355f935da 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -564,6 +564,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>>
>>         genpd->status = GENPD_STATE_OFF;
>>         genpd_update_accounting(genpd);
>> +       genpd->states[genpd->state_idx].usage++;
>>
>>         list_for_each_entry(link, &genpd->child_links, child_node) {
>>                 genpd_sd_counter_dec(link->parent);
>> @@ -574,6 +575,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>>
>>         return 0;
>>  busy:
>> +       genpd->states[genpd->state_idx].failed++;
>
>What about consistently calling these "rejected" instead of "failed"?
>
I wasn't sure, will change these too. Thanks Rafael.

--Lina

>>         if (nr_calls)
>>                 __raw_notifier_call_chain(&genpd->power_notifiers,
>>                                           GENPD_STATE_ON, NULL,
>> @@ -3053,7 +3055,7 @@ static int idle_states_show(struct seq_file *s, void *data)
>>         if (ret)
>>                 return -ERESTARTSYS;
>>
>> -       seq_puts(s, "State          Time Spent(ms)\n");
>> +       seq_puts(s, "State          Time Spent(ms) Usage          Failed\n");
>>
>>         for (i = 0; i < genpd->state_count; i++) {
>>                 ktime_t delta = 0;
>> @@ -3065,7 +3067,8 @@ static int idle_states_show(struct seq_file *s, void *data)
>>
>>                 msecs = ktime_to_ms(
>>                         ktime_add(genpd->states[i].idle_time, delta));
>> -               seq_printf(s, "S%-13i %lld\n", i, msecs);
>> +               seq_printf(s, "S%-13i %-14lld %-14llu %llu\n", i, msecs,
>> +                             genpd->states[i].usage, genpd->states[i].failed);
>>         }
>>
>>         genpd_unlock(genpd);
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 3b2b561ce846..c30994ec0cec 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -82,6 +82,8 @@ struct genpd_power_state {
>>         s64 power_off_latency_ns;
>>         s64 power_on_latency_ns;
>>         s64 residency_ns;
>> +       u64 usage;
>> +       u64 failed;
>>         struct fwnode_handle *fwnode;
>>         ktime_t idle_time;
>>         void *data;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
