Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB37306113
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 17:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbhA0Qcx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 11:32:53 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:19505 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343578AbhA0Qch (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Jan 2021 11:32:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611765132; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=z5sITnYH+hKH5ob5jP7ZjC3SvuyrrXJFxVS7t/eQ6UM=; b=qhUSwjTo/WjoOdB2+syRtcyKUrngNRYHeXGOwDqlAG8Ql/ah3XtYm9NY4/FnxRCxs1gEhA2l
 wGLnXApJJrhgJ8wW0Aso5T9fKt55flXTszJjwdT8md2FLsJHayTMGILSaPB1WgccdgEivc49
 Vk5a0SnQZinava35e1jFkiz1MqY=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6011954fbeacd1a252b67cbb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Jan 2021 16:31:11
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A443CC43468; Wed, 27 Jan 2021 16:31:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.105] (unknown [61.1.225.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3407C433ED;
        Wed, 27 Jan 2021 16:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3407C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [PATCH 03/13] opp: Keep track of currently programmed OPP
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
 <b634343a-8005-fc35-e38b-bfeaa7310a70@gmail.com>
 <20210122044532.pc7cpcgy3kjbqmls@vireshk-i7>
From:   Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <d9808e5f-bb8e-0d5c-8432-d695f8049f85@codeaurora.org>
Date:   Wed, 27 Jan 2021 22:01:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122044532.pc7cpcgy3kjbqmls@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/22/2021 10:15 AM, Viresh Kumar wrote:
> On 22-01-21, 00:41, Dmitry Osipenko wrote:
>> 21.01.2021 14:17, Viresh Kumar пишет:
>>> @@ -1074,15 +1091,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>>>   
>>>   	if (!ret) {
>>>   		ret = _set_opp_bw(opp_table, opp, dev, false);
>>> -		if (!ret)
>>> +		if (!ret) {
>>>   			opp_table->enabled = true;
>>> +			dev_pm_opp_put(old_opp);
>>> +
>>> +			/* Make sure current_opp doesn't get freed */
>>> +			dev_pm_opp_get(opp);
>>> +			opp_table->current_opp = opp;
>>> +		}
>>>   	}
>>
>> I'm a bit surprised that _set_opp_bw() isn't used similarly to
>> _set_opp_voltage() in _generic_set_opp_regulator().
>>
>> I'd expect the BW requirement to be raised before the clock rate goes UP.
> 
> I remember discussing that earlier when this stuff came in, and this I
> believe is the reason for that.
> 
> We need to scale regulators before/after frequency because when we
> increase the frequency a regulator may _not_ be providing enough power
> to sustain that (even for a short while) and this may have undesired
> effects on the hardware and so it is important to prevent that
> malfunction.
> 
> In case of bandwidth such issues will not happen (AFAIK) and doing it
> just once is normally enough. It is just about allowing more data to
> be transmitted, and won't make the hardware behave badly.
> 
I agree with Dmitry. BW is a shared resource in a lot of architectures. 
Raising clk before increasing the bw can lead to a scenario where this 
client saturate the entire BW for whatever small duration it may be. 
This will impact the latency requirements of other clients.

-Akhil.
