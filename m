Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3D18B1C7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 11:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCSKyF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 06:54:05 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:30001 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbgCSKyD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 06:54:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584615242; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=G1xcrA3VxHhne2SYFlZHYK1yCSX3CDOuVGju3yHGiP4=; b=XT7HwtfyMBNhfCGB8EdHpLc5VYpLQ+zQGrVW5KamUZGLFeukrSFzMI4jWD+4PUodmEk4Bdf4
 RnysL9ElYF4Pm4vBxAehG7HDcYlVzy6/8CZ7gWKM6rS6Zap+p/I2t20ZiDkt3iRCGsHXn5Qn
 c7j03VmExgRpv3Xbkat1cknw1nM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e734f3f.7f655465e7a0-smtp-out-n01;
 Thu, 19 Mar 2020 10:53:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9DBD8C44791; Thu, 19 Mar 2020 10:53:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.103] (unknown [106.51.30.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00C85C433CB;
        Thu, 19 Mar 2020 10:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00C85C433CB
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
        ulf.hansson@linaro.org, linux-kernel-owner@vger.kernel.org
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <19cf027ba87ade1b895ea90ac0fedbe2@codeaurora.org>
 <20200318034243.o2metmggzuah6cqw@vireshk-i7>
 <f6a7930a-4eaa-6982-88c6-b50773bee9d8@codeaurora.org>
 <ea4265f3f4b5a439d70d3c80bcc77b7f@codeaurora.org>
 <20200319102411.oivesngrk7gy7vtw@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <78d92969-0219-d140-d788-d1b14e643e90@codeaurora.org>
Date:   Thu, 19 Mar 2020 16:23:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319102411.oivesngrk7gy7vtw@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/19/2020 3:54 PM, Viresh Kumar wrote:
> On 19-03-20, 15:41, Sibi Sankar wrote:
>> Viresh,
>> Saravana's example does show a device
>> with multiple opp tables but doesn't
>> need multiple opp table support to
>> land though (since it works fine with
>> the current implementation). I am more
>> interested  in understanding your/
>> Stephen's/Saravana's stance on adding
>> multiple opp-table support. Personally
>> I feel its inevitable, since multiple
>> qc drivers using interconnect opp-tables,
>> routinely need vote on multiple paths in
>> a non-trivial manner.
> 
> The OPP core doesn't support multiple OPP tables for a device and I
> don't understand how it will. And so I have been waiting for a reply.

I thought this series indeed is proposing to add that support in OPP core?
a.k.a "[RFC v3 06/10] opp: Allow multiple opp_tables to be mapped to a single device"

> 
>>>
>>> Could you please post a link to the discussion that you are referring to
>>> here?
>>> I looked at a few links posted in the cover letter as dependencies and
>>> it seems
>>> like the discussions are pending for *months* and not weeks but I
>>> might have looked
>>> at the wrong ones.
>>
>> https://lore.kernel.org/lkml/20200114103448.odnvqawnqb3twst5@vireshk-i7/
>>
>> Rajendra,
>> Viresh is referring to ^^ one
> 
> Right, thanks.

These discussions are stalled for over 2 months now waiting on a response from Saravana.
Viresh, whats the way forward here and how long do we plan on waiting for Saravanas response?


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
