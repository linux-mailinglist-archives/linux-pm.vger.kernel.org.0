Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC53D7074
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 09:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhG0HgF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 03:36:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52530 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235504AbhG0HgE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Jul 2021 03:36:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627371365; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=n206CYcrj+jIUe5lGFPaF01ju7Kvlgz+cLDVUWfQPaE=; b=mJrz9bIqF3cTxLSOJui9ytwmn85VNI3hWYHLijLtcZBO8uDvBtMH8Umf4+9kN6mNNZQj8DlG
 eIfOcWX5MahX3BM/hvLlkbTJM23l/kBr15yCELxE4TLCcy/FEZrBmzsfu4OnPDvusnaKZ1Na
 S+o6iWZDUYxela/2OBbyx0a1/SI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60ffb75fe81205dd0ae3e611 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Jul 2021 07:35:59
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64F4BC4338A; Tue, 27 Jul 2021 07:35:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.50.54.206] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D9DCC433F1;
        Tue, 27 Jul 2021 07:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D9DCC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 2/2] arm64: dts: sc7180: Add required-opps for i2c
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rojay@codeaurora.org,
        stephan@gerhold.net
References: <1626429658-18961-1-git-send-email-rnayak@codeaurora.org>
 <1626429658-18961-3-git-send-email-rnayak@codeaurora.org>
 <YPHpsO5LlQRQxj9y@yoga>
 <CAE-0n53CHD8c7C4ETWRgzmZmFSCcBw46wSs4pKbYMRjA_tD3yg@mail.gmail.com>
 <YPHxfHPC/faq/y+J@yoga>
 <CAE-0n50qx80cMFPJ1x9rc+EMR1L+j2CUMyDjWAbnE9mPHjf-TQ@mail.gmail.com>
 <YPIBK/NJgBNZVI8Y@yoga> <12711a61-e16c-d2bc-6e04-ab94c7551abe@codeaurora.org>
 <YPXQNFYKfH/xZxFY@yoga> <bc79ea3e-4981-8f9b-f9a7-59cb972047a7@codeaurora.org>
 <YP2Y6qs5P5mb2jzE@yoga>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <b6b315ae-ee68-6ba8-7453-f28dace3d8d2@codeaurora.org>
Date:   Tue, 27 Jul 2021 13:05:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP2Y6qs5P5mb2jzE@yoga>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/25/2021 10:31 PM, Bjorn Andersson wrote:
> On Mon 19 Jul 23:29 CDT 2021, Rajendra Nayak wrote:
> 
>>
>>
>> On 7/20/2021 12:49 AM, Bjorn Andersson wrote:
>>> On Mon 19 Jul 04:37 CDT 2021, Rajendra Nayak wrote:
>>>
>>>>
>>>>
>>>> On 7/17/2021 3:29 AM, Bjorn Andersson wrote:
>>>>> On Fri 16 Jul 16:49 CDT 2021, Stephen Boyd wrote:
>>>>>
>>>>>> Quoting Bjorn Andersson (2021-07-16 13:52:12)
>>>>>>> On Fri 16 Jul 15:21 CDT 2021, Stephen Boyd wrote:
>>>>>>>
>>>>>>>> Quoting Bjorn Andersson (2021-07-16 13:18:56)
>>>>>>>>> On Fri 16 Jul 05:00 CDT 2021, Rajendra Nayak wrote:
>>>>>>>>>
>>>>>>>>>> qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 MHz)
>>>>>>>>>> Though qup-i2c does not support DVFS, it still needs to vote for a
>>>>>>>>>> performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
>>>>>>>>>> requirement.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Sounds good, but...
>>>>>>>>>
>>>>>>>>>> Use 'required-opps' to pass this information from
>>>>>>>>>> device tree, and also add the power-domains property to specify
>>>>>>>>>> the CX power-domain.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> ..is the required-opps really needed with my rpmhpd patch in place?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yes? Because rpmhpd_opp_low_svs is not the lowest performance state for
>>>>>>>> CX.
>>>>>>>
>>>>>>> On e.g. sm8250 the first available non-zero corner presented in cmd-db
>>>>>>> is low_svs.
>>>>
>>>> what rail is this? the mmcx? Perhaps it does not support RET.
>>>> cx usually supports both collapse state and RET.
>>>>
>>>
>>> That was the one I was specifically looking at for the MDSS_GDSC->MMCX
>>> issue, so it's likely I didn't look elsewhere.
>>>
>>>>>>
>>>>>> Indeed. On sc7180 it's not the first non-zero corner. I suppose
>>>>>> retention for CX isn't actually used when the SoC is awake so your
>>>>>> rpmhpd patch is putting in a vote for something that doesn't do anything
>>>>>> at runtime for CX? I imagine that rpmh only sets the aggregate corner to
>>>>>> retention when the whole SoC is suspended/sleeping, otherwise things
>>>>>> wouldn't go very well. Similarly, min_svs may be VDD minimization? If
>>>>>> so, those first two states are basically states that shouldn't be used
>>>>>> at runtime, almost like sleep states.
>>>>>>
>>>>>
>>>>> But if that's the case, I don't think it's appropriate for the "enabled
>>>>> state" of the domain to use any of those corners.
>>>>
>>>> I rechecked the downstream kernels where all this voting happens from within
>>>> the clock drivers, and I do see votes to min_svs for some clocks, but Stephen is
>>>> right that RET is not something that's voted on while in active state.
>>>>
>>>> But always going with something just above the ret level while active will also
>>>> not work for all devices, for instance for i2c on 7180, it needs a cx vote of
>>>> low svs while the rail (cx) does support something lower than that which is min svs.
>>>> (why can't it just work with min svs?, I don't know, these values and recommendations
>>>> come in from the voltage plans published by HW teams for every SoC and we just end up
>>>> using them in SW, perhaps something to dig further and understand which I will try and
>>>> do but these are the values in voltage plans and downstream kernels which work for now)
>>>>
>>>
>>> So to some degree this invalidates my argumentation about the
>>> enabled_corner in rpmhpd, given that "enabled" means a different corner
>>> for each rail - not just the one with lowest non-zero value.
>>
>> Right, it might work in some cases but might not work for all.
>>
> 
> Which makes it way less desirable.
> 
> The enable state for rpmhpd power domains doesn't meet my expectations
> for how a power domain should behave, 

Right and that's perhaps because these are not the usual power-domains,
which have one "on/active" state and one or more "off/inactive" states (off/ret/clock-stop)
Rpmhpd has multiple "on/active" states, and whats "on/active" for one consumer
might not be "on/active" for another, so this information is hard to be managed
at a generic level and these requests in some way or the other need to come
in explicitly from the resp. consumers.

> but we should at least be
> consistent across all consumers of it then...
> 
> 
> But the original issue remains, that when a device is powered by
> MDSS_GDSC, which is a subdomain of MMCX we still need to ensure that
> "on" for MMCX is actually "on" - which just happens to be the first
> non-0 corner.
> 
> But I presume we will end up having to do the same with &gcc's GDSCs,
> which are subdomains of CX and MX where this isn't true.
> 
>>>
>>> So perhaps instead of introducing the enabled_corner we need to
>>> introduce your patch and slap a WARN_ON(corner == 0) in
>>> rpmhpd_power_on() - to ensure that all clients that uses a rpmhpd domain
>>> actually do vote for a high enough corner?
>>
>> So this would mean the expectation is that the clients set the perf state/corner
>> before they call power_on? I don;t think that's the case today with most clients,
>> infact its the opposite, we power on first and then make a call to set the perf
>> state of the domain.
>>
> 
> You're right, it's pretty much always the opposite, given that genpd
> will always enable the domain during attach.
> 
> Regards,
> Bjorn
> 
>>>
>>> Regards,
>>> Bjorn
>>>
>>>>>
>>>>> As this means that anyone who needs any of the rpmhpd domains active
>>>>> also needs to specify required-opps, which wouldn't be needed for any
>>>>> other power domain provider.
>>>>>
>>>>> And more importantly it means that a device sitting in a GDSC, which
>>>>> would be parented by a rpmhpd domain has no way to specify the GDSC and
>>>>> trickle the minimum-vote up to the rpmhpd domain. (And I know that we
>>>>> don't describe the parentship of the GDSCs today, but this patch
>>>>> tells me that it's around the corner - for more than MMCX)
>>>>>
>>>>> Regards,
>>>>> Bjorn
>>>>>
>>>>>>>
>>>>>>> And if this (which?) clock requires a higher corner than the lowest
>>>>>>> possible in order to tick at this "lowest" frequency, I'm certainly
>>>>>>> interested in some more details.
>>>>>>>
>>>>
>>>> -- 
>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>>>> of Code Aurora Forum, hosted by The Linux Foundation
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
