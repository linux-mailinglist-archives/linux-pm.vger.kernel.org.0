Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9892C9411
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 01:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgLAAhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 19:37:13 -0500
Received: from mout02.posteo.de ([185.67.36.66]:49291 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgLAAhM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 19:37:12 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 96D102400FD
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 01:36:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1606782974; bh=rrbN3/SDunSxqor3Puciur64iZk0KAGNTiqy4EgRFR8=;
        h=From:To:Cc:Subject:Date:From;
        b=XNKyStLpfH7KzlU8S5ANljmpa65xHbIaR/SZAiSHfDkI8TFhXSZcT3koVCOhBvb4S
         JrDzoy47zTfU36SQedzLhR6pH5pANJaJAHZ5s6W2NUav0MUt2/2CG8hPWPAyLNykDJ
         3ickqEQ1Wcz9aIImKzzsz+COFdba39kCV5P+QyOt7yQjYjrh6kIudUZ1rQLzRV/wWG
         VMFzmhlQI32XvvvKlT4auOvphV3cDfP/W9ERMP8evuhcdjI/zLI2ZQNXGn0893HyMa
         AX/ihb4udqw5tF0sJkIcB5jjVQkT9vRDu6ygj2x79SXtDvR6XetfHU4ceRThfAWb4N
         HggYNVWEjx+qw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4ClNSW4xW6z6tmS;
        Tue,  1 Dec 2020 01:36:11 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Leonard Crestez <cdleonard@gmail.com>, akashast@codeaurora.org,
        Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <c110af2f-635a-71f5-735c-1346b7af0ef9@posteo.de>
 <bae4ae77-4d4d-6298-0af7-1d8db7dc7afe@linaro.org>
 <95ae2a9e-f0f7-fcfb-b113-c69286e85bad@posteo.de>
Subject: Re: question: interconnect: changes in 5.10 / imx8mq ?
Message-ID: <fa823263-4d1d-7f5c-2b25-12d450129c46@posteo.de>
Date:   Tue, 1 Dec 2020 01:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <95ae2a9e-f0f7-fcfb-b113-c69286e85bad@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30.11.20 23:10, Martin Kepplinger wrote:
> On 30.11.20 22:18, Georgi Djakov wrote:
>> On 30.11.20 22:34, Martin Kepplinger wrote:
>>> hi,
>>>
>>> what I've used on v5.9 on imx8mq in order to hook up dram frequency 
>>> to interconnect (via mxsfb/lcdif) - and has worked fine - is:
>>>
>>> * add the NOC node description with "#interconnect-cells = <1>;"
>>> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/8a6b8486a3e94e2886bde01000f9532e03d243a4 
>>>
>>> (original author is Leonard. I'll preserve authorship when submitting)
>>>
>>> * add "interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
>>> " to lcdif:
>>> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/6c4bbcdc315da01a9dc8bbda36290587ce1ed33a 
>>
>>
>> [..]
>>>
>>>   node                                  tag          avg         peak
>>> --------------------------------------------------------------------
>>> NOC                                          2147483647   2147483647
>>>    30320000.lcd-controller                0            0            0
>>> DRAM                                         2147483647   2147483647
>>>    30320000.lcd-controller                0            0            0
>>> (...)
>>>
>>>
>>>
>>> what am I doing wrong on recent kernels?
>>
>> Hi Martin,
>> This looks related to sync_state. Please try the change below.
>> It would be nice to get these DT patches merged into mainline.
> 
> that's the plan. I'll send them soon.
> 
>>
>> Thanks,
>> Georgi
>>
>> diff --git a/drivers/interconnect/imx/imx8mq.c 
>> b/drivers/interconnect/imx/imx8mq.c
>> index ba43a15aefec..9bb951b075e9 100644
>> --- a/drivers/interconnect/imx/imx8mq.c
>> +++ b/drivers/interconnect/imx/imx8mq.c
>> @@ -94,6 +94,7 @@ static struct platform_driver imx8mq_icc_driver = {
>>       .remove = imx8mq_icc_remove,
>>       .driver = {
>>           .name = "imx8mq-interconnect",
>> +        .sync_state = icc_sync_state,
>>       },
>>   };
> 
> that's exactly it. thanks a lot!
> 
>                             martin

but there follows the next problem. it looks imx8m specific:

On the librem5-devkit where I initially tested, switching works. FYI we 
have the 2 frequencies:
https://source.puri.sm/martin.kepplinger/linux-next/-/blob/5.10-rc5/librem5__integration/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts#L283
(the opp table also to be submitted to mainline soon)

On the Librem5 itself (different SoC revision, different frequencies 
available) it fails:
https://source.puri.sm/martin.kepplinger/linux-next/-/blob/5.10-rc5/librem5__integration/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi#L387

When I "request 0" (or disable the icc path) in order to switch to 25Mhz 
I now get:

[  129.391755] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to 
set dram_apb parent: -16
[  129.391959] imx8m-ddrc-devfreq 3d400000.memory-controller: ddrc 
failed freq switch to 25000000 from 800000000: error -16. now at 25000000
[  129.406133] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to 
update frequency from PM QoS (-16)

and the system hangs at this point.

I'm not aware of any changes we do in our tree in that area to mainline.

Only removing all but one frequency in the opp node, leaving only 
opp-800M, "works around" (not really) the error (just mentioning as a 
data point if that helps). I hope that's not misleading - no idea where 
exactly the problem lies.

I don't find obvious changes since v5.9 that could cause the error. Do you?

thanks,

                             martin
