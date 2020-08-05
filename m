Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF623C791
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 10:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHEIOL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 04:14:11 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:52863 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728297AbgHEIOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 04:14:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596615248; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RyvAchXcrO4VTZmCU0JwSFO+inX8hdSk3Y5nuzEwGi8=; b=t4mvxT1Uw5fDipfxdt0FUtsHBhK6WXT/CXMHR5xv2+x/H7AXcM7yDokBYSichO4r9+T01Ijd
 5oNzUT+qIIY7q6uv3nbJWmzCiADx97XAHGXEiMN9FCkNYFv/EXULI/U8tADlOxwuZnWm1l5g
 vXUqe0WcFajptJFGQ8YAo7NUlRI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f2a6a4fc86dbb497399862c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 Aug 2020 08:14:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 57FDCC433CA; Wed,  5 Aug 2020 08:14:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from [192.168.1.12] (unknown [61.1.228.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96D5DC433C9;
        Wed,  5 Aug 2020 08:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96D5DC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 3/3] arm64: dts: sc7180: Add assigned-performance-states
 for i2c
To:     Stephen Boyd <swboyd@chromium.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org>
 <1596541616-27688-4-git-send-email-rnayak@codeaurora.org>
 <159660971183.1360974.3826701315718625693@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <681d8c6f-a04b-dd17-4af9-59f314b7cc60@codeaurora.org>
Date:   Wed, 5 Aug 2020 13:44:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159660971183.1360974.3826701315718625693@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/5/2020 12:11 PM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2020-08-04 04:46:56)
>> qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 Mhz)
> 
> s/Mhz/MHz/
> 
>> Though qup-i2c does not support DVFS, it still needs to vote for a
>> performance state on 'cx' to satisfy the 19.2 Mhz clock frequency
> 
> Capitalize CX?
> 
>> requirement.
>>
>> Use 'assigned-performance-states' to pass this information from
>> device tree, and also add the power-domains property to specify
>> the cx power-domain.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
> 
> Can you generate this patch with more context? The hunks all look the
> same so it's really hard to see where they apply.

Sure, will do and also fix the others mentioned above.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
