Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0493E8DFA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbhHKKBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 06:01:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64775 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbhHKKBf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 06:01:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628676072; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=YsRXRW60o9vyHLLImrko8sF08vcveheFzhu6/n2s0+Y=; b=YvbW0Cw8LN9CtNbWPSmtoSPWyLX6zdqAU8d9rrf4Ks4ViVKjvUWZPu1qZBJ6tcdoBOvS9yMe
 F3g2Gz6VXLSCWKReVb5pMBoM7EXqAtqYZtAFvDPjSYAyaD/MB+Iv2mGNJ8yNfNBlqr/R6p4T
 7Pan140aXhDWMjhHWuBB/n46XyE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61139fd5f746c298d96b87ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Aug 2021 10:00:52
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7E28FC433F1; Wed, 11 Aug 2021 10:00:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [49.207.220.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89553C433F1;
        Wed, 11 Aug 2021 10:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89553C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <1628074696-7979-1-git-send-email-rnayak@codeaurora.org>
 <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFrebwt5=S7hqXvcqRvt+-EXLcVmRSRZt1uPf-9n7_pRDg@mail.gmail.com>
 <2afd0fac-ed28-c090-a345-3fd4284b4125@codeaurora.org>
 <20210810024308.gurvzpbe2bc2bhky@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <e452c0b5-5555-d6e2-40da-6aa21a26766d@codeaurora.org>
Date:   Wed, 11 Aug 2021 15:30:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810024308.gurvzpbe2bc2bhky@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/10/2021 8:13 AM, Viresh Kumar wrote:
> On 09-08-21, 16:38, Rajendra Nayak wrote:
>> Sure, I can do that, apart from the error print, the function currently also
>> returns a -EINVAL in case of the missing 'required-opps', are we suggesting
>> we change that to not return an error also?
> 
> No.
> 
>> Since this is completely optional in the device node, we would want the function to
>> ideally not return error and only do so in case 'required-opps' exists and the
>> translation to performance state fails.
> 
> Not really. The function should return failure if the property isn't
> there, but it shouldn't be EINVAL but ENODEV.

In my case I don't want to error out if the property is missing, I want to error out
only when the property exists but can't be translated into a performance state.

So currently I check if the property exists and *only then* try to translate it, Ulf asked
me to skip the check. If I do that and I call of_get_required_opp_performance_state()
unconditionally, and if it errors out I will need to put in additional logic (check for
return value of ENODEV) to distinguish between the property-does-not-exist vs
property-exists-but-cannot-be-translated case.
It just seems more straight-forward to call this only when the property exists, Ulf?
  

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
