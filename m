Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB82CA2CD
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 13:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgLAMgS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 07:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLAMgR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 07:36:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B9CC0613CF
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 04:35:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z7so2399867wrn.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 04:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PBhvOuHrmZrmozsg5XMjYiCxFZYNQufxltK5JmbALq0=;
        b=iELuIdiIsfbdTnon0RwdU4ViNQR1lvN5o7hq43GDB9jGHjUiYuwgu5FmAFJmelXsRu
         CiXYq36chppJ3ZMGiNSg1gRp6W2k0/QeIhOKsyC9bnQYiVnXGE8PpdaX4sccfG0f/dnZ
         Kk/i61rssRWKF/RKdjMYhBAgmvtpCzV1V8mktOCk+LGlmwXaZstpn9txNyQTpJeTD8tX
         e3oTmQ0SeRL0FU+/uK4IBW1EbDiog5qPRC//HnHDFNdS3tJk7urVMuOrqoTXbWogwt6F
         REYqrircBdTXStuh41xD2I2hQhOhB7GegJzYw3KsjCekuatSjlZ5xTYvq3tvH1P63Be5
         Enhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PBhvOuHrmZrmozsg5XMjYiCxFZYNQufxltK5JmbALq0=;
        b=U4OCcxQZJr/Gj6SgRt0K8IjB2MAYjVxtOGX0JmjsF8tra7hW+UVpS4yfujrOESO2sZ
         JAbQNfSDuHsILvBt4myUnECncjvhWdnsbQ8qBMWcyW+TyIeWDgr5MPtl2At9TJma74kY
         3xCq02iL99qodlJglc7n3gWdRYNYVBJB3osj4zunpwpxkoZTwREYm9t0VnU0nvFsasYs
         mIoC0gjGYgRfK4/u6SkEFY2PUjHkI0ZGQPX+eqvbQKKnt6OVJg2xFu72N9hJf7nJIVMS
         Q1kdiDrev1Rr6nCyNM3bwRXYIKdlMlV4qEALl9YPDUm1QSWwVXeUd7ZtMkzNlWUP9OJI
         Tyyw==
X-Gm-Message-State: AOAM531Kh0zUY4/lxt2+z4v6xSoKbCAfB0KU6Bm9HwBgkJYkj3WgmBge
        yQBXJepWQSgj0A5TC3niSlx8eA==
X-Google-Smtp-Source: ABdhPJzolK1z/MwyGdNPMWGm17UWGGNNhYA+6ywXkJaIKSw6bgsLCHCx+sDsqURy9VxE+NprDyS/IQ==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr3570046wrr.194.1606826136251;
        Tue, 01 Dec 2020 04:35:36 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id l14sm2683462wmi.33.2020.12.01.04.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 04:35:35 -0800 (PST)
Subject: Re: question: interconnect: changes in 5.10 / imx8mq ?
To:     Martin Kepplinger <martink@posteo.de>,
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
 <a97dd90c-57d2-9e74-523f-24c9556a933a@posteo.de>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <d216ef41-46f0-59ff-5a9b-64c5cb80d26d@linaro.org>
Date:   Tue, 1 Dec 2020 14:35:34 +0200
MIME-Version: 1.0
In-Reply-To: <a97dd90c-57d2-9e74-523f-24c9556a933a@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1.12.20 13:35, Martin Kepplinger wrote:
> On 01.12.20 10:10, Georgi Djakov wrote:
>> On 12/1/20 02:36, Martin Kepplinger wrote:
>>> On 30.11.20 23:10, Martin Kepplinger wrote:
>>>> On 30.11.20 22:18, Georgi Djakov wrote:
>>>>> On 30.11.20 22:34, Martin Kepplinger wrote:
[..]
>>>
>>> but there follows the next problem. it looks imx8m specific:
>>>
>>> On the librem5-devkit where I initially tested, switching works. FYI 
>>> we have the 2 frequencies:
>>> https://source.puri.sm/martin.kepplinger/linux-next/-/blob/5.10-rc5/librem5__integration/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts#L283 
>>>
>>> (the opp table also to be submitted to mainline soon)
>>>
>>> On the Librem5 itself (different SoC revision, different frequencies 
>>> available) it fails:
>>> https://source.puri.sm/martin.kepplinger/linux-next/-/blob/5.10-rc5/librem5__integration/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi#L387 
>>>
>>>
>>> When I "request 0" (or disable the icc path) in order to switch to 
>>> 25Mhz I now get:
>>>
>>> [  129.391755] imx8m-ddrc-devfreq 3d400000.memory-controller: failed 
>>> to set dram_apb parent: -16
>>> [  129.391959] imx8m-ddrc-devfreq 3d400000.memory-controller: ddrc 
>>> failed freq switch to 25000000 from 800000000: error -16. now at 
>>> 25000000
>>> [  129.406133] imx8m-ddrc-devfreq 3d400000.memory-controller: failed 
>>> to update frequency from PM QoS (-16)
>>
>> I am not familiar with the clock tree of this platform, but it looks 
>> like -EBUSY is returned when the we are trying to change the parent of 
>> the clock.
>>
>>> and the system hangs at this point.
>>>
>>> I'm not aware of any changes we do in our tree in that area to mainline.
>>>
>>> Only removing all but one frequency in the opp node, leaving only 
>>> opp-800M, "works around" (not really) the error (just mentioning as a 
>>> data point if that helps). I hope that's not misleading - no idea 
>>> where exactly the problem lies.
>>
>> When there is only a single frequency, then probably we do not try to 
>> change the
>> mux settings and that's why it does not hang. Maybe check the clock 
>> tree and if
>> all needed clocks and branches are enabled.
>>
> 
> thanks for taking the time here. I don't see notable changes to the 
> clock tree compared to 5.9. Specifically, "dram_apb" where reparenting 
> fails, is running on 5.10 too.

It could be a DT change or something else.. Maybe try running git bisect
and see if it gives any clue.

Thanks,
Georgi

> It's strange that I see this error on imx8mq-librem5 but not on 
> imx8mq-librem5-devkit.
