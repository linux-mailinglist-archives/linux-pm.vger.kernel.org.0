Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1063518B06B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 10:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgCSJmZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 05:42:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52943 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbgCSJmY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 05:42:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584610944; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=iz2nU03/8cnH2TUu7+7ztdtrDhkWYNP0IQa4F/BXqP4=; b=d5VoNCh0q2ppD512szBole6DhqhjKB5///q0mkFKiaEYlJP3p3d0b4KvJmnpLRS3a9kM2UFq
 D6CZA0PFTB4hCSFJMMNZYOyn9DIoK5gy54qT1IZ8S/HWdQOBuy1CQOtVzrQJwZPdwCEH6Ztf
 f2YDrNRStSiYInDzBVwYMQ5C2Jw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e733e7f.7fec72c78a08-smtp-out-n01;
 Thu, 19 Mar 2020 09:42:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55451C44792; Thu, 19 Mar 2020 09:42:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.103] (unknown [106.51.30.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08BB1C433CB;
        Thu, 19 Mar 2020 09:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08BB1C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, saravanak@google.com,
        nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <19cf027ba87ade1b895ea90ac0fedbe2@codeaurora.org>
 <20200318034243.o2metmggzuah6cqw@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <f6a7930a-4eaa-6982-88c6-b50773bee9d8@codeaurora.org>
Date:   Thu, 19 Mar 2020 15:12:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318034243.o2metmggzuah6cqw@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 3/18/2020 9:12 AM, Viresh Kumar wrote:
> On 18-03-20, 02:13, Sibi Sankar wrote:
>> On 2020-01-28 01:33, Sibi Sankar wrote:
>>> This RFC series aims to extend cpu based scaling support to L3/DDR on
>>> SDM845 and SC7180 SoCs.
>>>
>>
>> Hey Viresh/Saravana,
>>
>> Ping! Can you take a stab at reviewing
>> the series, it has been on the list for
>> a while now.
> 
> I believe this depends on Saravana's series on which I have raised
> some doubts few weeks back ? I am still waiting for them to get
> clarified by him.

Could you please post a link to the discussion that you are referring to here?
I looked at a few links posted in the cover letter as dependencies and it seems
like the discussions are pending for *months* and not weeks but I might have looked
at the wrong ones.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
