Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587666403F6
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 11:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiLBKCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 05:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiLBKCl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 05:02:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C26307
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 02:02:39 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68DE86602BB8;
        Fri,  2 Dec 2022 10:02:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669975358;
        bh=poI1DdXBGmBKMUaqisonZlBsnUTOhLk7p//2IBOv5KA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F+95N8g09sJEqWdOUCBPf1gVr+C9BGexRNdiI7ZSTBtxQWES+WBcmXus0D7tXM+Er
         tNkYZZwWk+VdrKxY4sgD5OBDxO2EMGUhaQgI5ZIwsgPOtl1WjEYjHgq8y7Df0Ys2sa
         1Obbdvy2RF/FIOPlbpZ+ZHcT2Wz7uKocEa2Le1H3yoBjsvnQxDbEiM8YwSuMHXs96L
         DhTkdfIa6veQlL6cmW9+3JIY9DC9ZhRs28sAyt6grM4Iso0kzaQuB8jSIh516H/y8Z
         Jzf4yuBtKT/7ZTwDe9GJ8EdGtfJ02hYK3WVsIGQr39ToFfPUIoRGYX5hjGX1rmPePf
         5Nhbg8mW0znfA==
Message-ID: <8be3e050-f32a-6761-8ebd-49c38dfcf9eb@collabora.com>
Date:   Fri, 2 Dec 2022 11:02:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Kernel Kernel bug caused by (cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()) on Banana Pi R64 (MT7622)
Content-Language: en-US
To:     =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "vincent@systemli.org" <vincent@systemli.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "thomas.huehn@hs-nordhausen.de" <thomas.huehn@hs-nordhausen.de>,
        "daniel@makrotopia.org" <daniel@makrotopia.org>
References: <930778a1-5e8b-6df6-3276-42dcdadaf682@systemli.org>
 <eb142a22-b35e-ec3f-ee0a-9e3e7b24cea6@gmail.com>
 <bf8d2a8f-7654-29be-1104-a842c6657b5e@systemli.org>
 <02c2c955-940b-b315-0474-85d0eddad7a3@leemhuis.info>
 <Y4jHvomTrU8guBox@makrotopia.org>
 <47a4665e-333d-a6e7-a2da-96cb06c2d87b@leemhuis.info>
 <20221202052716.uj3kzkunazmgazeq@vireshk-i7>
 <0ebef1a2-6b5a-04b9-a79b-79eb3349c32b@collabora.com>
 <c76bd301-0e8d-2d2b-0d3e-a57ece9b496f@collabora.com>
 <b1822bbc3775730c4cedf9652323c7d72e663e4b.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b1822bbc3775730c4cedf9652323c7d72e663e4b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 02/12/22 10:43, Allen-KH Cheng (程冠勳) ha scritto:
> Hi Angelo,
> 
> Jia-wei is working on this issue.
> 
> We will update progress ASAP.
> 

I think I've found something: the MT7622/7623 voltage constraints
set in mediatek-cpufreq's platform data seem to be wrong.

I've sent a commit to fix those [1] and that should solve the issue
that was seen on MT7622, but the code in the voltage tracking algorithm
is unsafe: this crash should be happening because we may be calling
regulator_set_voltage() with max_uV < min_uV --- and this is not legal.

That's happening due to the OPP tables in devicetree asking for a voltage
that is higher than the {proc,sram}_max_volt declared by the platform data
in the mediatek-cpufreq driver: the solution would be to either check the
validity of the constraints everytime se call regulator_set_voltage there,
which wouldn't be optimal IMO, or walk the OPP table at mediatek-cpufreq
probe time (or init time) to either:

1. Print a big warning in kmsg and always ignore all of the OPP entries
    that request a voltage that's higher than the maximum that we declared; or
2. Fail probe/init with an error explicitly saying that the OPP entries
    are declaring an out of range voltage for sram/proc.

Anyway, thanks for the response, hope that Jia-wei confirms, or denies
my findings and makes this driver more robust ASAP.

Thank you!
Angelo

[1]: 
https://lore.kernel.org/lkml/20221202095227.167492-1-angelogioacchino.delregno@collabora.com/

> Thanks,
> Allen
> 
> On Fri, 2022-12-02 at 10:19 +0100, AngeloGioacchino Del Regno wrote:
>> Il 02/12/22 09:57, AngeloGioacchino Del Regno ha scritto:
>>> Il 02/12/22 06:27, Viresh Kumar ha scritto:
>>>> On 01-12-22, 16:39, Thorsten Leemhuis wrote:
>>>>> Thx for clarifying. And I noticed I made a mistake: I should
>>>>> have
>>>>> directed my earlier question wrt to any progress here more into
>>>>> the
>>>>> direction of Jia-Wei Chang (who authored 6a17b3876b) and Viresh
>>>>> Kumar
>>>>> (who committed it).
>>>>
>>>> I was waiting for the platform maintainers to come up with a fix.
>>>> I
>>>> have sent a patch now to revert this, in-reply-to this thread.
>>>>
>>>> Please confirm this is working fine. Thanks.
>>>>
>>>
>>> Can you guys try this patch that I've sent a while ago?
>>>
>>>
> https://lore.kernel.org/lkml/20220909093724.40078-1-angelogioacchino.delregno@collabora.com/T/#u
>>>
>>> There were comments on it, but if that solves your issue I can push
>>> a v2
>>> to solve what was reported.
>>>
>>> Regards,
>>> Angelo
>>
>> Wait, sorry, I've re-read the stacktrace and that won't help at all.
>> MediaTek, can you please look at this issue?
>>
>> Reverting the proposed commit will make MT8183 unstable.
>>
>>

