Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BC92CA194
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgLALg2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 06:36:28 -0500
Received: from mout02.posteo.de ([185.67.36.66]:36367 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbgLALg2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 06:36:28 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 02F54240101
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 12:35:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1606822528; bh=RNuzN2v+xN2WGT4Vb5WR96l0+9Yt3dhLly0LH5n48z0=;
        h=To:Cc:From:Subject:Date:From;
        b=PHuEMAw+/2+X6Pv6xENd1NAO8AXoyzTsLVT9ItkozdQxFyfp3QQfCJM5UZQDhtz1q
         /VD5G3HODWbQUt0K5oRuxJBqtPDISbDjU3W2l3Vdv58isa0JVjK+oM+FqFHaPqE+i5
         oReAB4B13MXaOP7JQHSr+O8bcBEDNV+bD8aLVA5dTVTHjIcYwzOpkn6RZ5KOsW5PPR
         HSI+TWMQKXf66OLZ939gZnCvecJKfV6zO0IqBDvcyfSOcIPqqwLE5U3CfNSL+sCycB
         WUAFK3xKDThd0TiVAxaK9VHMvo8qgkodzBaXEfkmCzxzAH9HML5Re6afhPbc6FGLW+
         3dsRG51pJK3hA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Clg5929S5z9rxY;
        Tue,  1 Dec 2020 12:35:25 +0100 (CET)
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Leonard Crestez <cdleonard@gmail.com>, akashast@codeaurora.org,
        Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "kernel@puri.sm" <kernel@puri.sm>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <c110af2f-635a-71f5-735c-1346b7af0ef9@posteo.de>
 <bae4ae77-4d4d-6298-0af7-1d8db7dc7afe@linaro.org>
 <95ae2a9e-f0f7-fcfb-b113-c69286e85bad@posteo.de>
 <fa823263-4d1d-7f5c-2b25-12d450129c46@posteo.de>
 <a6e73aba-3dbc-51ee-f9f5-e6c32a0112c2@linaro.org>
From:   Martin Kepplinger <martink@posteo.de>
Subject: Re: question: interconnect: changes in 5.10 / imx8mq ?
Message-ID: <a97dd90c-57d2-9e74-523f-24c9556a933a@posteo.de>
Date:   Tue, 1 Dec 2020 12:35:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <a6e73aba-3dbc-51ee-f9f5-e6c32a0112c2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01.12.20 10:10, Georgi Djakov wrote:
> On 12/1/20 02:36, Martin Kepplinger wrote:
>> On 30.11.20 23:10, Martin Kepplinger wrote:
>>> On 30.11.20 22:18, Georgi Djakov wrote:
>>>> On 30.11.20 22:34, Martin Kepplinger wrote:
>>>>> hi,
>>>>>
>>>>> what I've used on v5.9 on imx8mq in order to hook up dram frequency 
>>>>> to interconnect (via mxsfb/lcdif) - and has worked fine - is:
>>>>>
>>>>> * add the NOC node description with "#interconnect-cells = <1>;"
>>>>> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/8a6b8486a3e94e2886bde01000f9532e03d243a4 
>>>>>
>>>>> (original author is Leonard. I'll preserve authorship when submitting)
>>>>>
>>>>> * add "interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
>>>>> " to lcdif:
>>>>> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/6c4bbcdc315da01a9dc8bbda36290587ce1ed33a 
>>>>
>>>>
>>>>
>>>>
>>>> [..]
>>>>>
>>>>>   node                                  tag          avg         peak
>>>>> --------------------------------------------------------------------
>>>>> NOC                                          2147483647   2147483647
>>>>>    30320000.lcd-controller                0            0            0
>>>>> DRAM                                         2147483647   2147483647
>>>>>    30320000.lcd-controller                0            0            0
>>>>> (...)
>>>>>
>>>>>
>>>>>
>>>>> what am I doing wrong on recent kernels?
>>>>
>>>> Hi Martin,
>>>> This looks related to sync_state. Please try the change below.
>>>> It would be nice to get these DT patches merged into mainline.
>>>
>>> that's the plan. I'll send them soon.
>>>
>>>>
>>>> Thanks,
>>>> Georgi
>>>>
>>>> diff --git a/drivers/interconnect/imx/imx8mq.c 
>>>> b/drivers/interconnect/imx/imx8mq.c
>>>> index ba43a15aefec..9bb951b075e9 100644
>>>> --- a/drivers/interconnect/imx/imx8mq.c
>>>> +++ b/drivers/interconnect/imx/imx8mq.c
>>>> @@ -94,6 +94,7 @@ static struct platform_driver imx8mq_icc_driver = {
>>>>       .remove = imx8mq_icc_remove,
>>>>       .driver = {
>>>>           .name = "imx8mq-interconnect",
>>>> +        .sync_state = icc_sync_state,
>>>>       },
>>>>   };
>>>
>>> that's exactly it. thanks a lot!
>>>
>>>                             martin
>>
>> but there follows the next problem. it looks imx8m specific:
>>
>> On the librem5-devkit where I initially tested, switching works. FYI 
>> we have the 2 frequencies:
>> https://source.puri.sm/martin.kepplinger/linux-next/-/blob/5.10-rc5/librem5__integration/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts#L283 
>>
>> (the opp table also to be submitted to mainline soon)
>>
>> On the Librem5 itself (different SoC revision, different frequencies 
>> available) it fails:
>> https://source.puri.sm/martin.kepplinger/linux-next/-/blob/5.10-rc5/librem5__integration/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi#L387 
>>
>>
>> When I "request 0" (or disable the icc path) in order to switch to 
>> 25Mhz I now get:
>>
>> [  129.391755] imx8m-ddrc-devfreq 3d400000.memory-controller: failed 
>> to set dram_apb parent: -16
>> [  129.391959] imx8m-ddrc-devfreq 3d400000.memory-controller: ddrc 
>> failed freq switch to 25000000 from 800000000: error -16. now at 25000000
>> [  129.406133] imx8m-ddrc-devfreq 3d400000.memory-controller: failed 
>> to update frequency from PM QoS (-16)
> 
> I am not familiar with the clock tree of this platform, but it looks 
> like -EBUSY is returned when the we are trying to change the parent of 
> the clock.
> 
>> and the system hangs at this point.
>>
>> I'm not aware of any changes we do in our tree in that area to mainline.
>>
>> Only removing all but one frequency in the opp node, leaving only 
>> opp-800M, "works around" (not really) the error (just mentioning as a 
>> data point if that helps). I hope that's not misleading - no idea 
>> where exactly the problem lies.
> 
> When there is only a single frequency, then probably we do not try to 
> change the
> mux settings and that's why it does not hang. Maybe check the clock tree 
> and if
> all needed clocks and branches are enabled.
> 

thanks for taking the time here. I don't see notable changes to the 
clock tree compared to 5.9. Specifically, "dram_apb" where reparenting 
fails, is running on 5.10 too.

It's strange that I see this error on imx8mq-librem5 but not on 
imx8mq-librem5-devkit.

thanks,
                              martin
