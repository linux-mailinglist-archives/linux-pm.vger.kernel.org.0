Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84402745EC
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIVQA6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 12:00:58 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:42238 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVQA6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Sep 2020 12:00:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600790456; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Id9g9PAb20X+UF3Th1zZ5TGv7YDCbKmXeUfeSnmZowE=; b=UtGLwr86RmO+raZhTUcFV8xHmHecc8bDxE9qenaGXR25L5Uiiwj3zQekqJ9FaBzdGxFANTUz
 qWg75OoTE6sFI2r9W2SgC8zCfgwQk8gMTmNtDyk3hOfi0+RhoykJS+okSxAeIGI09lBbNY5f
 B42bfLp04oad8le87ASWJkTktno=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f6a1fb6c2a5b66eb96b9210 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 16:00:54
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EA87AC433CA; Tue, 22 Sep 2020 16:00:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35A73C433CB;
        Tue, 22 Sep 2020 16:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35A73C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 22 Sep 2020 10:00:52 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: record state entry failed statistics
Message-ID: <20200922160052.GC30658@codeaurora.org>
References: <20200902210116.7360-1-ilina@codeaurora.org>
 <CAJZ5v0gWVVPF_S_=1WyXAiB0Gse6PO8VZQf0yAr=in15CM3w7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gWVVPF_S_=1WyXAiB0Gse6PO8VZQf0yAr=in15CM3w7w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 22 2020 at 09:57 -0600, Rafael J. Wysocki wrote:
>Sorry for the delay.
>
Thanks for the review.

>On Wed, Sep 2, 2020 at 11:01 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> When CPUs fail to enter the chosen idle state it's mostly because of a
>> pending interrupt. Let's record that and show along with other
>> statistics for the idle state. This could prove useful in understanding
>> behavior of the governor and the system during usecases that involve
>> multiple CPUs.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/cpuidle/cpuidle.c | 1 +
>>  drivers/cpuidle/sysfs.c   | 3 +++
>>  include/linux/cpuidle.h   | 1 +
>
>The documentation needs to be updated too to cover the new state attribute.
>
Sure, will add that in the next spin.
>>  3 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 04becd70cc41..8dbf71f6138d 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -302,6 +302,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>>                 }
>>         } else {
>>                 dev->last_residency_ns = 0;
>> +               dev->states_usage[index].failed++;
>>         }
>>
>>         return entered_state;
>> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
>> index 091d1caceb41..f166687b3bcd 100644
>> --- a/drivers/cpuidle/sysfs.c
>> +++ b/drivers/cpuidle/sysfs.c
>> @@ -256,6 +256,7 @@ define_show_state_time_function(exit_latency)
>>  define_show_state_time_function(target_residency)
>>  define_show_state_function(power_usage)
>>  define_show_state_ull_function(usage)
>> +define_show_state_ull_function(failed)
>
>And what about calling it "rejected" instead of "failed"?
>
Works for me.

Thanks,
Lina

>>  define_show_state_str_function(name)
>>  define_show_state_str_function(desc)
>>  define_show_state_ull_function(above)
>> @@ -312,6 +313,7 @@ define_one_state_ro(latency, show_state_exit_latency);
>>  define_one_state_ro(residency, show_state_target_residency);
>>  define_one_state_ro(power, show_state_power_usage);
>>  define_one_state_ro(usage, show_state_usage);
>> +define_one_state_ro(failed, show_state_failed);
>>  define_one_state_ro(time, show_state_time);
>>  define_one_state_rw(disable, show_state_disable, store_state_disable);
>>  define_one_state_ro(above, show_state_above);
>> @@ -325,6 +327,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
>>         &attr_residency.attr,
>>         &attr_power.attr,
>>         &attr_usage.attr,
>> +       &attr_failed.attr,
>>         &attr_time.attr,
>>         &attr_disable.attr,
>>         &attr_above.attr,
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 75895e6363b8..911b99273eba 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -38,6 +38,7 @@ struct cpuidle_state_usage {
>>         u64                     time_ns;
>>         unsigned long long      above; /* Number of times it's been too deep */
>>         unsigned long long      below; /* Number of times it's been too shallow */
>> +       unsigned long long      failed; /* Number of times it failed to enter */
>>  #ifdef CONFIG_SUSPEND
>>         unsigned long long      s2idle_usage;
>>         unsigned long long      s2idle_time; /* in US */
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
