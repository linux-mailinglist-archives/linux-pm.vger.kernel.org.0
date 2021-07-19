Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B443CD423
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jul 2021 13:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhGSLKQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jul 2021 07:10:16 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50317 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236302AbhGSLKQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Jul 2021 07:10:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626695456; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=cuNYcuoxuLNPM9zRI3jedhlC+1gr//ok0e0lHbfvDqg=; b=weLvoX15VS3PrtnueKVNTgg+BpRtO/snJ4PTGtkXw7aStBgXVZVYHKeUYUAdpIhvUihjbgbr
 rbzCL86Za4/XxJVqBtAr6MZxXIDQQsVhjaxANlSqEPGeDFpRtfjzPOMEqw062+CxB2mDRlCe
 UxN/Z2MahGmRG5aVM3SMSsK8UqE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60f5671fd0100c7cf9fbf4c7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Jul 2021 11:50:55
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9902C43217; Mon, 19 Jul 2021 11:50:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.50.42.221] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0AD9C433D3;
        Mon, 19 Jul 2021 11:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0AD9C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
To:     Stephen Boyd <swboyd@chromium.org>, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rojay@codeaurora.org, stephan@gerhold.net
References: <1626429658-18961-1-git-send-email-rnayak@codeaurora.org>
 <1626429658-18961-2-git-send-email-rnayak@codeaurora.org>
 <CAE-0n52AkJWAL0ptFgZOrD_BXrrMte5EbZUksf5UYzBxYisCBQ@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <43c77084-cfea-ef7f-8454-6f0dbc3b6577@codeaurora.org>
Date:   Mon, 19 Jul 2021 17:20:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n52AkJWAL0ptFgZOrD_BXrrMte5EbZUksf5UYzBxYisCBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/17/2021 1:49 AM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2021-07-16 03:00:57)
>> Some devics within power domains with performance states do not
> 
> devices
> 
>> support DVFS, but still need to vote on a default/static state
>> while they are active. They can express this using the 'required-opps'
>> property in device tree, which points to the phandle of the OPP
>> supported by the corresponding power-domains.
>>
>> Add support to parse this information from DT and then set the
>> specified performance state during attach and drop it on detach.
>> Also drop/set as part of runtime suspend/resume callbacks.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   drivers/base/power/domain.c | 37 ++++++++++++++++++++++++++++++++++---
>>   include/linux/pm_domain.h   |  1 +
>>   2 files changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index a934c67..dcc0b71 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1000,6 +1008,8 @@ static int genpd_runtime_resume(struct device *dev)
>>          genpd_stop_dev(genpd, dev);
>>   err_poweroff:
>>          if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
>> +               if (default_pstate)
>> +                       dev_pm_genpd_set_performance_state(dev, 0);
>>                  genpd_lock(genpd);
>>                  gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> 
> Maybe this should be
> 
> 		  prev_state = genpd_drop_performance_state(dev);
> 		  if (!default_pstate)
> 		  	gdp_data->rpm_pstate = prev_state;
> 
> so we don't call dev_pm_genpd_set_performance_state() effectively twice?
> Also it would make sure we call dev_pm_genpd_set_performance_state()
> underneath the genpd_lock() if that is important. Similarly do that on
> suspend path.

looking through this more, I think I can completely drop any special
handling for default_pstate in runtime suspend and resume. The existing
drop/restore login Ulf has added should take care of it.
I'll test and respin soon.

> 
>>                  genpd_power_off(genpd, true, 0);
>> @@ -2598,6 +2608,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>>
>>          dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>>
>> +       /* Drop the default performance state */
>> +       if (dev_gpd_data(dev)->default_pstate) {
>> +               dev_pm_genpd_set_performance_state(dev, 0);
>> +               dev_gpd_data(dev)->default_pstate = 0;
>> +       }
>> +
>>          for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
>>                  ret = genpd_remove_device(pd, dev);
>>                  if (ret != -EAGAIN)
>> @@ -2675,10 +2692,24 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>                  genpd_unlock(pd);
>>          }
>>
>> -       if (ret)
>> +       if (ret) {
>>                  genpd_remove_device(pd, dev);
>> +               return -EPROBE_DEFER;
>> +       }
>> +
>> +       /* Set the default performance state */
>> +       np = base_dev->of_node;
>> +       if (of_parse_phandle(np, "required-opps", index)) {
>> +               pstate = of_get_required_opp_performance_state(np, index);
>> +               if (pstate < 0) {
>> +                       dev_err(dev, "failed to set pstate:%d", pstate);
> 
> Missing newline on printk. Also can we spell out pstate as "failed to
> set required performance state %d for power-domain %d"?

thanks, will fix when I respin.
Thanks for the review.

> 
>> +                       ret = pstate;
>> +               }
>> +               dev_pm_genpd_set_performance_state(dev, pstate);
>> +               dev_gpd_data(dev)->default_pstate = pstate;
>> +       }
>>
>> -       return ret ? -EPROBE_DEFER : 1;
>> +       return ret ? ret : 1;
>>   }
>>
>>   /**

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
