Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEC926BB47
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 06:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIPEPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 00:15:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59533 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgIPEPQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Sep 2020 00:15:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600229715; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=sVyIWN/5EQf1o4rLUU8501TZYsaQWVBf+J0gC/hpHCY=; b=KDhFrk5MKIndn5yXD5A44/5nPK1mKMf/9dKeLpjTk+GYu1NliXLjqXNTHtHiMAcKZx/fba6q
 k3SosKgynNfG7kSw8Ey7jczohRfnfkW72ZV7QAuqz2mDkSof1YhX8UDYH7/pSCb6slBrKv3E
 Q4UER8z9exfL82Rc3+ZaY2WGA00=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f61915024954b1631c77d4d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 04:15:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D2E7C433F1; Wed, 16 Sep 2020 04:15:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [49.207.202.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D10BC433C8;
        Wed, 16 Sep 2020 04:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D10BC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
To:     Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com>
 <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
 <20200915211309.GC2771744@google.com>
 <808029c4-3a05-1926-934d-10739190ab9e@linaro.org>
 <20200915213626.GD2771744@google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <5553e9c4-9681-e223-8a31-ea0b0582668f@codeaurora.org>
Date:   Wed, 16 Sep 2020 09:45:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915213626.GD2771744@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/16/2020 3:06 AM, Matthias Kaehlcke wrote:
> On Tue, Sep 15, 2020 at 11:23:49PM +0200, Daniel Lezcano wrote:
>> On 15/09/2020 23:13, Matthias Kaehlcke wrote:
>>> On Tue, Sep 15, 2020 at 10:55:52PM +0200, Daniel Lezcano wrote:
>>>> On 15/09/2020 19:58, Matthias Kaehlcke wrote:
>>>>> On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
>>>>>> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
>>>>>>> +Thermal folks
>>>>>>>
>>>>>>> Hi Rajendra,
>>>>>>>
>>>>>>> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
>>>>>>>> Hi Rob,
>>>>>>>>
>>>>>>>> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
>>>>>>>> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
>>>>>>>> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
>>>>>>>> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
>>>>>>>> calculating power values in mW, is there a need to document the property as something that *has* to be
>>>>>>>> based on real power measurements?
>>>>>>>
>>>>>>> Relative values may work for scheduling decisions, but not for thermal
>>>>>>> management with the power allocator, at least not when CPU cooling devices
>>>>>>> are combined with others that specify their power consumption in absolute
>>>>>>> values. Such a configuration should be supported IMO.
>>>>>>
>>>>>> The energy model is used in the cpufreq cooling device and if the
>>>>>> sustainable power is consistent with the relative values then there is
>>>>>> no reason it shouldn't work.
>>>>>
>>>>> Agreed on thermal zones that exclusively use CPUs as cooling devices, but
>>>>> what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
>>>>> GPU that specifies its power in mW?
>>>>
>>>> Well, if a SoC vendor decides to mix the units, then there is nothing we
>>>> can do.
>>>>
>>>> When specifying the power numbers available for the SoC, they could be
>>>> all scaled against the highest power number.
>>>
>>> The GPU was just one example, a device could have heat dissipating components
>>> that are not from the SoC vendor (e.g. WiFi, modem, backlight), and depending
>>> on the design it might not make sense to have separate thermal zones.
>>
>> Is it possible to elaborate, I'm not sure to get the point ?
> 
> A device could have a thermal zone with the following cooling
> devices:
> 
> - CPUs with power consumption specified as pmW (pseudo mW
> - A modem from a third party vendor. The modem can dissipate
>    significant heat and allows to throttle the bandwidth for
>    cooling. The power consumption of the modem is given in
>    mW.
> 
> These could be crammed together in a small form factor
> (e.g. ChromeCast or Chromebit) which makes it difficult to
> discern with a sensor what exactly is generating the heat,
> which is why you have a single thermal zone.
> 
> IPA is used as governor for this zone, it can't make accurate
> decisions because one cooling device specifies it's power
> consumption in pmW and the other in mW.

Is there a real example upstream for this, or is it a theoretical
problem (which can exist in the future) we are trying to solve?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
