Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA379212E69
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 23:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGBVBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 17:01:30 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:59060 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbgGBVB2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 17:01:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593723687; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=MrJDxWrf2N4TbGJfco8+HjKPzeQQULCNLSgOC4TTleI=; b=GKep2tze/NashRoczKxi8V0eA4+DgeZyV+zH0ldLIPri4nWyJ1K8cpk5YwoF+5Ml1I2r2ZwZ
 8QR9mJxvMN3fPMomu2Hfg3dADFHAlxu3hsEqvv0EXSZq2o3j3IQspijxhs3mXsQ+zyxBHuw5
 276YnqaXoUo/crmxInw4qMMDhuM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5efe4b13bfb34e631cf7c2df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 21:01:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54286C433C6; Thu,  2 Jul 2020 21:01:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.117] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C29E8C433C8;
        Thu,  2 Jul 2020 21:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C29E8C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH 1/4] interconnect: qcom: Support bcm-voter-specific TCS
 wait behavior
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200623040814.23791-1-mdtipton@codeaurora.org>
 <20200623040814.23791-2-mdtipton@codeaurora.org>
 <fee03dda-4c17-701b-bb1a-bf9482cc476d@linaro.org>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <9833fdac-2790-d488-e998-93fd077dfb03@codeaurora.org>
Date:   Thu, 2 Jul 2020 14:01:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fee03dda-4c17-701b-bb1a-bf9482cc476d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/2/2020 2:02 AM, Georgi Djakov wrote:
> Hi Mike,
> 
> On 6/23/20 07:08, Mike Tipton wrote:
>> Currently, all bcm-voters set tcs_cmd::wait=true for the last VCD
>> command in each TCS (AMC, WAKE, and SLEEP). However, some bcm-voters
>> don't need the completion and instead need to optimize for latency. For
>> instance, disabling wait-for-completion in the WAKE set can decrease
>> resume latency and allow for certain operations to occur in parallel
>> with the WAKE TCS triggering. This is only safe in very specific
>> situations. Keep the default behavior of always waiting, but allow it to
>> be overridden in devicetree.
>>
>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>> ---
>>   drivers/interconnect/qcom/bcm-voter.c | 32 ++++++++++++++++++---------
>>   1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> [..]
>> @@ -336,7 +342,11 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   
>>   	voter->dev = &pdev->dev;
>> -	voter->np = pdev->dev.of_node;
>> +	voter->np = np;
>> +
>> +	if (of_property_read_u32(np, "qcom,tcs-wait", &voter->tcs_wait))
> 
> This DT property needs to be documented.
Whoops, will do.

> 
> Thanks,
> Georgi
> 
