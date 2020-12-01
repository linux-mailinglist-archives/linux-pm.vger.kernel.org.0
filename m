Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2BE2C9BAA
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 10:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbgLAJLB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 04:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389782AbgLAJK7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 04:10:59 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD1C0613CF
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 01:10:19 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g185so3438119wmf.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 01:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JjxvJ2GleejcsbyAWz/qvOrfkeToAmCJLaBzuYcwAW8=;
        b=QSentZr0N7M4DgIznk+9d6rKD8dROFQuDUg9HOShIt+7fqQ23lxewgpjhieK/6IEJl
         otqqznp94s1qlBHpM5LhNvN22PIiFDXiq2QyfNfQ+3zgB/K/f5btQuzf4b7BZri7IKBi
         kvHK/l8ymmxnj9nK/VBeMWhfHkVllu98JfjjFrS0y2EIlBCnOJ4L2nJKlHBQY9WeZ0dH
         Aqys4bKllx4ctgp08t4wFV6/Vf5lhYp2WxHkphODJpGm5GRpKEVtGfNkpnuep8oo3lKw
         M+s0z1WFQkJEfMv5vVq191asQgMe9dN0IjiURbdNSnNIKh2bOK1LDa2DMeKAeTUMraec
         sEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JjxvJ2GleejcsbyAWz/qvOrfkeToAmCJLaBzuYcwAW8=;
        b=GATs0JbVUBs/+4S8m9qEgY6k4uzSENjDK/kP5nYLQxaumYa1iBKFaGuAwtvpfFhdFj
         21z+IXDxvAFTdExUfjCgJJ+c+ncuKLeNuHFxswoC8v+juBOBoahxQh/Cq+NeBIqI2OHg
         l08/SqsknGersu6nU8ikDPwEjjeDwevxEiJePm44HCXZyPW1ujYtQIcTKNajdm7rp0Qd
         p+/YYuI7tsjzb3IeZULCBBzSc3Y+a0ZUhbsadybzydHiFRwYwvkrHzRQx0bMvt4tXQa4
         9MxTNuEA6Sc6dgId0kv40rQ4g5a0JGC6qqS9d5VAK+nss2fjJ8fIYEP8b16yYt34BKmX
         /WVw==
X-Gm-Message-State: AOAM532U6ORrhewJL9MJuATo/FLJUoHx9NkdWR5kZQDJLaF8CzkRoK+M
        b9RVYNZlML5m2uQrVUkNb5xIaQ==
X-Google-Smtp-Source: ABdhPJwM2xFBOo6ADYEHlZrEbjhM4LZmpyu5KArnauA585VR0JmlIFvfrkYcunOrB0J4QWla1QhEHA==
X-Received: by 2002:a1c:a9c4:: with SMTP id s187mr1692886wme.116.1606813817895;
        Tue, 01 Dec 2020 01:10:17 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id j6sm2008865wrq.38.2020.12.01.01.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 01:10:17 -0800 (PST)
To:     Martin Kepplinger <martink@posteo.de>,
        Leonard Crestez <cdleonard@gmail.com>, akashast@codeaurora.org,
        Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <c110af2f-635a-71f5-735c-1346b7af0ef9@posteo.de>
 <bae4ae77-4d4d-6298-0af7-1d8db7dc7afe@linaro.org>
 <95ae2a9e-f0f7-fcfb-b113-c69286e85bad@posteo.de>
 <fa823263-4d1d-7f5c-2b25-12d450129c46@posteo.de>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: question: interconnect: changes in 5.10 / imx8mq ?
Message-ID: <a6e73aba-3dbc-51ee-f9f5-e6c32a0112c2@linaro.org>
Date:   Tue, 1 Dec 2020 11:10:19 +0200
MIME-Version: 1.0
In-Reply-To: <fa823263-4d1d-7f5c-2b25-12d450129c46@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/1/20 02:36, Martin Kepplinger wrote:
> On 30.11.20 23:10, Martin Kepplinger wrote:
>> On 30.11.20 22:18, Georgi Djakov wrote:
>>> On 30.11.20 22:34, Martin Kepplinger wrote:
>>>> hi,
>>>>
>>>> what I've used on v5.9 on imx8mq in order to hook up dram frequency to 
>>>> interconnect (via mxsfb/lcdif) - and has worked fine - is:
>>>>
>>>> * add the NOC node description with "#interconnect-cells = <1>;"
>>>> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/8a6b8486a3e94e2886bde01000f9532e03d243a4 
>>>>
>>>> (original author is Leonard. I'll preserve authorship when submitting)
>>>>
>>>> * add "interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
>>>> " to lcdif:
>>>> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/6c4bbcdc315da01a9dc8bbda36290587ce1ed33a 
>>>
>>>
>>>
>>> [..]
>>>>
>>>>   node                                  tag          avg         peak
>>>> --------------------------------------------------------------------
>>>> NOC                                          2147483647   2147483647
>>>>    30320000.lcd-controller                0            0            0
>>>> DRAM                                         2147483647   2147483647
>>>>    30320000.lcd-controller                0            0            0
>>>> (...)
>>>>
>>>>
>>>>
>>>> what am I doing wrong on recent kernels?
>>>
>>> Hi Martin,
>>> This looks related to sync_state. Please try the change below.
>>> It would be nice to get these DT patches merged into mainline.
>>
>> that's the plan. I'll send them soon.
>>
>>>
>>> Thanks,
>>> Georgi
>>>
>>> diff --git a/drivers/interconnect/imx/imx8mq.c 
>>> b/drivers/interconnect/imx/imx8mq.c
>>> index ba43a15aefec..9bb951b075e9 100644
>>> --- a/drivers/interconnect/imx/imx8mq.c
>>> +++ b/drivers/interconnect/imx/imx8mq.c
>>> @@ -94,6 +94,7 @@ static struct platform_driver imx8mq_icc_driver = {
>>>       .remove = imx8mq_icc_remove,
>>>       .driver = {
>>>           .name = "imx8mq-interconnect",
>>> +        .sync_state = icc_sync_state,
>>>       },
>>>   };
>>
>> that's exactly it. thanks a lot!
>>
>>                             martin
> 
> but there follows the next problem. it looks imx8m specific:
> 
> On the librem5-devkit where I initially tested, switching works. FYI we have the 
> 2 frequencies:
> https://source.puri.sm/martin.kepplinger/linux-next/-/blob/5.10-rc5/librem5__integration/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts#L283 
> 
> (the opp table also to be submitted to mainline soon)
> 
> On the Librem5 itself (different SoC revision, different frequencies available) 
> it fails:
> https://source.puri.sm/martin.kepplinger/linux-next/-/blob/5.10-rc5/librem5__integration/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi#L387 
> 
> 
> When I "request 0" (or disable the icc path) in order to switch to 25Mhz I now get:
> 
> [  129.391755] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to set 
> dram_apb parent: -16
> [  129.391959] imx8m-ddrc-devfreq 3d400000.memory-controller: ddrc failed freq 
> switch to 25000000 from 800000000: error -16. now at 25000000
> [  129.406133] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to update 
> frequency from PM QoS (-16)

I am not familiar with the clock tree of this platform, but it looks like -EBUSY 
is returned when the we are trying to change the parent of the clock.

> and the system hangs at this point.
> 
> I'm not aware of any changes we do in our tree in that area to mainline.
> 
> Only removing all but one frequency in the opp node, leaving only opp-800M, 
> "works around" (not really) the error (just mentioning as a data point if that 
> helps). I hope that's not misleading - no idea where exactly the problem lies.

When there is only a single frequency, then probably we do not try to change the
mux settings and that's why it does not hang. Maybe check the clock tree and if
all needed clocks and branches are enabled.

Thanks,
Georgi
