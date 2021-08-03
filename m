Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806733DE579
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 06:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhHCEi7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 00:38:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:62834 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhHCEi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 00:38:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627965528; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=FbLhNhA4Y+LPC/c0c9AGj9/wDZXAL/8/x3Qxh+OZH8c=; b=aLBCDuDGWgHE55xdT7DUAoK10hQfu+jFPupSSe8C6w0qadBZiFCB8OS/57VRTkOFNJ+G51MS
 FOF7svaCIw2Cuw1rT1EH7zNRXj+yPwL40gtAsLKX3JyKjhAZZu/AXbVaqoiYlmNQGRs77T1e
 v1e8+h+/+8JVnv/hhIA+49rOKOE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6108c84996a66e66b2fbe972 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Aug 2021 04:38:33
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 57CBCC433F1; Tue,  3 Aug 2021 04:38:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [49.207.203.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A433C433F1;
        Tue,  3 Aug 2021 04:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A433C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v5 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <1626764876-10229-1-git-send-email-rnayak@codeaurora.org>
 <1626764876-10229-2-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFrzHD6rXP5TnqrAVnrZExc2JLFe3HoGF+yM_tsaZYwh8g@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <35950d34-5cab-1b09-9864-49217a83f68d@codeaurora.org>
Date:   Tue, 3 Aug 2021 10:08:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrzHD6rXP5TnqrAVnrZExc2JLFe3HoGF+yM_tsaZYwh8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/2/2021 6:29 PM, Ulf Hansson wrote:
> On Tue, 20 Jul 2021 at 09:12, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>
>> Some devices within power domains with performance states do not
>> support DVFS, but still need to vote on a default/static state
>> while they are active. They can express this using the 'required-opps'
>> property in device tree, which points to the phandle of the OPP
>> supported by the corresponding power-domains.
>>
>> Add support to parse this information from DT and then set the
>> specified performance state during attach and drop it on detach.
>> runtime suspend/resume callbacks already have logic to drop/set
>> the vote as needed and should take care of dropping the default
>> perf state vote on runtime suspend and restore it back on runtime
>> resume.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   drivers/base/power/domain.c | 28 +++++++++++++++++++++++++---
>>   include/linux/pm_domain.h   |  1 +
>>   2 files changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index a934c67..f454031 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2598,6 +2598,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
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
>> @@ -2635,9 +2641,10 @@ static void genpd_dev_pm_sync(struct device *dev)
>>   static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>                                   unsigned int index, bool power_on)
>>   {
>> +       struct device_node *np;
>>          struct of_phandle_args pd_args;
>>          struct generic_pm_domain *pd;
>> -       int ret;
>> +       int ret, pstate;
>>
>>          ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>>                                  "#power-domain-cells", index, &pd_args);
>> @@ -2675,10 +2682,25 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
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
> 
> Please use dev->of_node instead (it is set to the same of_node as
> base_dev by the callers of __genpd_dev_pm_attach) as it's more
> consistent with existing code.
> 
>> +       if (of_parse_phandle(np, "required-opps", index)) {
>> +               pstate = of_get_required_opp_performance_state(np, index);
>> +               if (pstate < 0) {
>> +                       ret = pstate;
>> +                       dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
>> +                               pd->name, ret);
>> +               }
>> +               dev_pm_genpd_set_performance_state(dev, pstate);
>> +               dev_gpd_data(dev)->default_pstate = pstate;
> 
> This doesn't look entirely correct to me. If we fail to translate a
> required opp to a performance state, we shouldn't try to set it.

yeah, that does not seem right at all :(

> Perhaps it's also easier to call
> of_get_required_opp_performance_state() unconditionally of whether a
> "required-opps" specifier exists. If it fails with the translation,
> then we just skip setting a default state and continue with returning
> 1.
> 
> Would that work?

I think it should, I'll redo the error handling, hopefully right this time,
and re-post. Thanks for the review.

> 
>> +       }
>>
>> -       return ret ? -EPROBE_DEFER : 1;
>> +       return ret ? ret : 1;
>>   }
>>
>>   /**
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 21a0577..67017c9 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -198,6 +198,7 @@ struct generic_pm_domain_data {
>>          struct notifier_block *power_nb;
>>          int cpu;
>>          unsigned int performance_state;
>> +       unsigned int default_pstate;
>>          unsigned int rpm_pstate;
>>          ktime_t next_wakeup;
>>          void *data;
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>
> 
> Kind regards
> Uffe
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
