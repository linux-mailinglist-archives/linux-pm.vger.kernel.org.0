Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035302EBAFB
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 09:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbhAFIPN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 03:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFIPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 03:15:13 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4B9C061357
        for <linux-pm@vger.kernel.org>; Wed,  6 Jan 2021 00:14:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e25so1851482wme.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Jan 2021 00:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FfV3hyzCprel4c8D5UUPJuvA+3HUguNV7GDsYJABWM4=;
        b=jiH7vMnyXhGc6f/iiS/rTXx9kzzVUfG/BwTF2CI1kpNGidrfh3UL+Y8rhMAbfplTQ4
         1APk09ZE+FGVcGIKzGDKu5arR1tXi0qsinqrT436gD8iuG88GAuf0vOGzqLlcLeU/Hxw
         iDwYjnzvljeoblw4mZHcHTpcI0/9s46OU0sTNLJUsaYPgg7/d/KYmdqDq5m/0eYfK0KI
         GhZ+FCbYCn2RkIv+77WG/YWJMpfKTB7pr242B/FC0O0x3CnYdJGfCCT2X/Vgk5q3/Tpu
         /KQsVccG1r1Bwbpm0qaI9XgqQQb8XJ9bh+/FOCDyEiOBakkQO98ExTN2EWwr8+RrCt+m
         yPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FfV3hyzCprel4c8D5UUPJuvA+3HUguNV7GDsYJABWM4=;
        b=XNa9av7X0VZrM2nnn23svvUWRWT4e5tCU2Qa6pjb8FkkxB7EtFdN/dkP8JjmOXpTJl
         szG9cWerqckImbpZK76wA1+qE4hGl3ztfOrLUTi8a7BN+glhQh3nFAP0mpL9lpnSKr0N
         Lvm3VnKU39I2XdKFzSOLEsyRMhD/UEoe6jir+D2NKwXlfOSbpmUUSPk2700239rRKJEb
         GrFqvN9ULaCQSLpq/BCcomekrXQ/7zTv8RdqQsNuRmW/IlomhWr22cYRJwFL+OqdWLwi
         4KIgtuHAWq1WB452xEEepmtoxT/g0tqjFINPr7FtpCOOXKMP+0frhV6o9gn6kmYW3WZU
         W0wg==
X-Gm-Message-State: AOAM530ThUBssLJaLTIWYEWmZSuNw+rCToJYsDLeI9TsJjfhcZW4+5cn
        eSuHh3CkZ/vyxR2YL0/iJ2EFOIuoSTBlSw==
X-Google-Smtp-Source: ABdhPJzhtFE3/TrLKMfVx2COu7W0DF0IrzoUUUeya0H2MBGgal7PPIfG0DQ/A6JY9EnA7mGroFIOTQ==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr2639409wmj.168.1609920865385;
        Wed, 06 Jan 2021 00:14:25 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id j2sm2103092wrh.78.2021.01.06.00.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 00:14:24 -0800 (PST)
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
 <1608790134-27425-9-git-send-email-henryc.chen@mediatek.com>
 <c8b951b0-6412-d905-99e1-6350283b57c1@linaro.org>
 <1609918232.23066.5.camel@mtksdaap41>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH V6 08/13] interconnect: mediatek: Add interconnect
 provider driver
Message-ID: <a416a55c-0a7e-6505-ef53-b03f5dbc6cdc@linaro.org>
Date:   Wed, 6 Jan 2021 10:14:26 +0200
MIME-Version: 1.0
In-Reply-To: <1609918232.23066.5.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/6/21 09:30, Henry Chen wrote:
> On Mon, 2021-01-04 at 20:36 +0200, Georgi Djakov wrote:
>> On 12/24/20 08:08, Henry Chen wrote:
>>> Introduce Mediatek MT6873/MT8183/MT8192 specific provider driver
>>> using the interconnect framework.
>>>
>>>                ICC provider         ICC Nodes
>>>                                 ----          ----
>>>                ---------       |CPU |   |--- |VPU |
>>>       -----   |         |-----  ----    |     ----
>>>      |DRAM |--|DRAM     |       ----    |     ----
>>>      |     |--|scheduler|----- |GPU |   |--- |DISP|
>>>      |     |--|(EMI)    |       ----    |     ----
>>>      |     |--|         |       -----   |     ----
>>>       -----   |         |----- |MMSYS|--|--- |VDEC|
>>>                ---------        -----   |     ----
>>>                  /|\                    |     ----
>>>                   |change DRAM freq     |--- |VENC|
>>>                ----------               |     ----
>>>               |  DVFSR   |              |
>>>               |          |              |     ----
>>>                ----------               |--- |IMG |
>>>                                         |     ----
>>>                                         |     ----
>>>                                         |--- |CAM |
>>>                                               ----
>>>
>>> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
>>> ---
>>>    drivers/interconnect/Kconfig            |   1 +
>>>    drivers/interconnect/Makefile           |   1 +
>>>    drivers/interconnect/mediatek/Kconfig   |  13 ++
>>>    drivers/interconnect/mediatek/Makefile  |   3 +
>>>    drivers/interconnect/mediatek/mtk-emi.c | 330 ++++++++++++++++++++++++++++++++
>>>    5 files changed, 348 insertions(+)
>>>    create mode 100644 drivers/interconnect/mediatek/Kconfig
>>>    create mode 100644 drivers/interconnect/mediatek/Makefile
>>>    create mode 100644 drivers/interconnect/mediatek/mtk-emi.c
>>>
>>> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
>>> index 5b7204e..e939f5a 100644
>>> --- a/drivers/interconnect/Kconfig
>>> +++ b/drivers/interconnect/Kconfig
>>> @@ -13,5 +13,6 @@ if INTERCONNECT
>>>    
>>>    source "drivers/interconnect/imx/Kconfig"
>>>    source "drivers/interconnect/qcom/Kconfig"
>>> +source "drivers/interconnect/mediatek/Kconfig"
>>
>> Sort alphabetically please.
> Ok
>>
>>>    
>>>    endif
>>> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
>>> index d203520..0643a24 100644
>>> --- a/drivers/interconnect/Makefile
>>> +++ b/drivers/interconnect/Makefile
>>> @@ -6,3 +6,4 @@ icc-core-objs				:= core.o bulk.o
>>>    obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
>>>    obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
>>>    obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
>>> +obj-$(CONFIG_INTERCONNECT_MTK)		+= mediatek/
>>
>> Ditto.
> Ok
>>
>>> diff --git a/drivers/interconnect/mediatek/Kconfig b/drivers/interconnect/mediatek/Kconfig
>>> new file mode 100644
>>> index 0000000..972d3bb
>>> --- /dev/null
>>> +++ b/drivers/interconnect/mediatek/Kconfig
>>> @@ -0,0 +1,13 @@
>>> +config INTERCONNECT_MTK
>>> +	bool "Mediatek Network-on-Chip interconnect drivers"
>>> +	depends on ARCH_MEDIATEK
>>> +	help
>>> +	  Support for Mediatek's Network-on-Chip interconnect hardware.
>>> +
>>> +config INTERCONNECT_MTK_EMI
>>> +	tristate "Mediatek EMI interconnect driver"
>>> +	depends on INTERCONNECT_MTK
>>> +	depends on (MTK_DVFSRC && OF)
>>
>> Would it be possible to enable COMPILE_TEST?
> Do you means change to "depends on (MTK_DVFSRC && OF) || COMPILE_TEST" ?

Yeah, there is a stub for mtk_dvfsrc_send_request(). Maybe we could even change
it for INTERCONNECT_MTK to something like:
	depends on ARCH_MEDIATEK || COMPILE_TEST
Will this work?

Thanks,
Georgi
