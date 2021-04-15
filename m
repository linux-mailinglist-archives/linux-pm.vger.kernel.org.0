Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B16235FF9E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 03:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhDOBbp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 21:31:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28052 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhDOBbm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Apr 2021 21:31:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618450280; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=9gnP5pgYelSlV/Rgr0abTb2Kc3chY5fICOH5Ndmud5U=; b=q0J7J7puWBMCrH1OW1Q4Z5/H3O81G5ET5z0PiunIgOuqhWs0lPb628ppXOZiIkpIBClVLqUz
 rXu2fjH21d7LJzfDBjIbVadaezarA7aNiW8iMoAG++KUJMXjyblJ73hTVUkmmS+cLvtSqrq8
 iWa99DZoOsHrBkLsyYVElPqMUEE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6077975f8166b7eff72d6a96 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Apr 2021 01:31:11
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 017C3C43463; Thu, 15 Apr 2021 01:31:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.103] (unknown [49.204.182.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0672C433C6;
        Thu, 15 Apr 2021 01:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0672C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 5/7] cpufreq: qcom-hw: Implement CPRh aware OSM
 programming
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, agross@kernel.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
 <20210119174557.227318-6-angelogioacchino.delregno@somainline.org>
 <c35bfd76-0d7e-d7bc-79ab-041b1074c1af@codeaurora.org>
 <YAh+9/IgRhI8M3ov@builder.lan>
 <92e465e4-a0d9-43eb-84f7-69fa355097a9@codeaurora.org>
 <20210413034940.o6uzjtnh2ylvikbf@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <150e19b9-9ecf-7cac-8aa3-c7c4d7a11468@codeaurora.org>
Date:   Thu, 15 Apr 2021 07:01:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413034940.o6uzjtnh2ylvikbf@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 4/13/2021 9:19 AM, Viresh Kumar wrote:
> On 12-04-21, 15:01, Taniya Das wrote:
>> Technically the HW we are trying to program here differs in terms of
>> clocking, the LUT definitions and many more. It will definitely make
>> debugging much more troublesome if we try to accommodate multiple versions of
>> CPUFREQ-HW in the same code.
>>
>> Thus to keep it simple, easy to read, debug, the suggestion is to keep it
>> with "v1" tag as the OSM version we are trying to put here is from OSM1.0.
> 
> That is a valid point and is always a case with so many drivers. What
> I am concerned about is how much code is common across versions, if it
> is 5-70%, or more, then we should definitely share, arrange to have
> callbacks or ops per version and call them in a generic fashion instead
> of writing a new driver. This is what's done across
> drivers/frameworks, etc.
> 

The code sharing here between versions should be very minimal as most 
portion of the code here in V1 would focus on programming to prepare the 
LUT to be further read by the driver, the programming in itself is huge 
for v1. I am okay if you move the v1 in a different file and invoke 
based on version.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
