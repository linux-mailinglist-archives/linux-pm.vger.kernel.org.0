Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9B18B25D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 12:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgCSLdh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 07:33:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:53818 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbgCSLdh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 07:33:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584617616; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=NtXkDJueiiPlFXmtYg+Cti7ZiR046Y1WCJSdQ1BCU3c=; b=ulemKkSqRA0kgxTMyUaorSmaqxGj8V4lr/vzuxWh3/ymDe8eeVtZqYVnAm881nGdZ6r8uiYm
 QhpHACk+ODoL2F+cynBd8/UeeRtmnIQ8x/2VaIDg6ip1gBDarthYb87pNcRSrFEf8qIVhEmi
 vBVVUtAjm+mBgPXzU1v2bXWRk7M=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e735888.7f70287633b0-smtp-out-n04;
 Thu, 19 Mar 2020 11:33:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10774C433D2; Thu, 19 Mar 2020 11:33:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.103] (unknown [49.207.61.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89C53C433CB;
        Thu, 19 Mar 2020 11:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89C53C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
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
 <78d92969-0219-d140-d788-d1b14e643e90@codeaurora.org>
 <20200319110805.glmuc2qvgcei3mon@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <53065b03-22d5-fb78-aa6f-e4711b8ffd3b@codeaurora.org>
Date:   Thu, 19 Mar 2020 17:03:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319110805.glmuc2qvgcei3mon@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 3/19/2020 4:38 PM, Viresh Kumar wrote:
> On 19-03-20, 16:23, Rajendra Nayak wrote:
>>
>>
>> On 3/19/2020 3:54 PM, Viresh Kumar wrote:
>> I thought this series indeed is proposing to add that support in OPP core?
>> a.k.a "[RFC v3 06/10] opp: Allow multiple opp_tables to be mapped to a single device"
>>
>> These discussions are stalled for over 2 months now waiting on a response from Saravana.
>> Viresh, whats the way forward here and how long do we plan on waiting for Saravanas response?
> 
> I agree and I am equally worried about it. So lets clear the air a bit
> first. Can someone answer following :
> 
> - This series depends on the series from Saravana ? Right, so that
>    needs to get merged/accepted first ?
> 
> - If yes, then what is the way forward as Saravana isn't responding
>    right now ..

sure, I understand there is a dependency, however refusing to review the approach
(to add multiple OPPS tables per device) that this series is taking because of an outstanding
question which, if I read it right is "We can not add multiple OPP tables for a single device right now"
seems odd.

Its fine if you are not happy with the approach taken here and you can propose something else,
but it looks inevitable that we would need something like this to be supported (multiple OPP tables per device)
and hence the request to review the patches.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
