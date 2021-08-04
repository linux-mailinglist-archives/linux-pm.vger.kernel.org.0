Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789F53DFFF0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 13:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbhHDLIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 07:08:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43108 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236799AbhHDLIq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Aug 2021 07:08:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628075313; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=UVTxmTbmqtIP0faK96taKsK1cEYi8KSQOq1LNUgnXtI=; b=BMzdqPUR7evp2oEhCoev/jQ5Algkeita6k6oOTu3ByCx4rYpE3BWPeAv6mhKc8pk3hL3slUH
 6r0j+s7yPdjwXlP3xsRljGwVS5JxUVicLZsTc1VTaJyA3VyPLJd+3zYXEaOwJHopqvG6FhXP
 QQXS58ijdAXRFiqAKhEhCdT6SBQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 610a75205c73bba6fb3a57e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Aug 2021 11:08:16
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E6450C43217; Wed,  4 Aug 2021 11:08:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.102] (unknown [49.207.203.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F06DDC433D3;
        Wed,  4 Aug 2021 11:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F06DDC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v5 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
From:   Rajendra Nayak <rnayak@codeaurora.org>
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
 <35950d34-5cab-1b09-9864-49217a83f68d@codeaurora.org>
Message-ID: <6fe7d326-1822-5a49-cca7-df9a2739dca8@codeaurora.org>
Date:   Wed, 4 Aug 2021 16:38:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <35950d34-5cab-1b09-9864-49217a83f68d@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/3/2021 10:08 AM, Rajendra Nayak wrote:
> 
> On 8/2/2021 6:29 PM, Ulf Hansson wrote:
>> On Tue, 20 Jul 2021 at 09:12, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>>
>>> Some devices within power domains with performance states do not
>>> support DVFS, but still need to vote on a default/static state
>>> while they are active. They can express this using the 'required-opps'
>>> property in device tree, which points to the phandle of the OPP
>>> supported by the corresponding power-domains.
>>>
>>> Add support to parse this information from DT and then set the
>>> specified performance state during attach and drop it on detach.
>>> runtime suspend/resume callbacks already have logic to drop/set
>>> the vote as needed and should take care of dropping the default
>>> perf state vote on runtime suspend and restore it back on runtime
>>> resume.
>>>
>>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>>> ---
>>>   drivers/base/power/domain.c | 28 +++++++++++++++++++++++++---
>>>   include/linux/pm_domain.h   |  1 +
>>>   2 files changed, 26 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index a934c67..f454031 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -2598,6 +2598,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>>>
>>>          dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>>>
>>> +       /* Drop the default performance state */
>>> +       if (dev_gpd_data(dev)->default_pstate) {
>>> +               dev_pm_genpd_set_performance_state(dev, 0);
>>> +               dev_gpd_data(dev)->default_pstate = 0;
>>> +       }
>>> +
>>>          for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
>>>                  ret = genpd_remove_device(pd, dev);
>>>                  if (ret != -EAGAIN)
>>> @@ -2635,9 +2641,10 @@ static void genpd_dev_pm_sync(struct device *dev)
>>>   static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>                                   unsigned int index, bool power_on)
>>>   {
>>> +       struct device_node *np;
>>>          struct of_phandle_args pd_args;
>>>          struct generic_pm_domain *pd;
>>> -       int ret;
>>> +       int ret, pstate;
>>>
>>>          ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>>>                                  "#power-domain-cells", index, &pd_args);
>>> @@ -2675,10 +2682,25 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>                  genpd_unlock(pd);
>>>          }
>>>
>>> -       if (ret)
>>> +       if (ret) {
>>>                  genpd_remove_device(pd, dev);
>>> +               return -EPROBE_DEFER;
>>> +       }
>>> +
>>> +       /* Set the default performance state */
>>> +       np = base_dev->of_node;
>>
>> Please use dev->of_node instead (it is set to the same of_node as
>> base_dev by the callers of __genpd_dev_pm_attach) as it's more
>> consistent with existing code.
>>
>>> +       if (of_parse_phandle(np, "required-opps", index)) {
>>> +               pstate = of_get_required_opp_performance_state(np, index);
>>> +               if (pstate < 0) {
>>> +                       ret = pstate;
>>> +                       dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
>>> +                               pd->name, ret);
>>> +               }
>>> +               dev_pm_genpd_set_performance_state(dev, pstate);
>>> +               dev_gpd_data(dev)->default_pstate = pstate;
>>
>> This doesn't look entirely correct to me. If we fail to translate a
>> required opp to a performance state, we shouldn't try to set it.
> 
> yeah, that does not seem right at all :(
> 
>> Perhaps it's also easier to call
>> of_get_required_opp_performance_state() unconditionally of whether a
>> "required-opps" specifier exists. If it fails with the translation,
>> then we just skip setting a default state and continue with returning
>> 1.
>>
>> Would that work?

Looks like calling of_get_required_opp_performance_state() unconditionally
makes it spit out a pr_err() in case the node is missing "required-opps" property,
so I posted a v6 [1] with the check in place and adding the missing else
condition.

[1] https://lore.kernel.org/patchwork/project/lkml/list/?series=510727

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
