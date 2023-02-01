Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4806A686CA6
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 18:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjBARSs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 12:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjBARSn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 12:18:43 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE00410AA
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 09:18:40 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mf7so34752846ejc.6
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 09:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJEBduByw0+WeeEW1vYOiskBh5WFkUCHdPpVrGoxGKg=;
        b=qU0VFwynsZuhNal5A+syKnYrVS4I5WbYMXGx/mXRDHgdsBER/tT4pspStfAyD7bR6B
         a0xb1Y4IUf++CW3DPeJD87XZsUBKHdUN64EKyxjYgiytqNlvwZ2Ld3jSnbofns1/oYDh
         IqYDRLqOwcWNfoSANSdtehhWX9cfohGUXeRJh6IvHSznJ2zwmjuHzWnLTzFLdcaP4Xgz
         13hQtMuObwmglWwNyHiorlyWO94Br+rmtGVQ3pwosomo/y21C9A7yXv0L2q4WZonGIKJ
         vADtEb91JpWibNi61QQmnCDt/Oq9N0lYWxS5db6T0AyLwJr3f7k6ITZC6OQnt44CMULI
         Jhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJEBduByw0+WeeEW1vYOiskBh5WFkUCHdPpVrGoxGKg=;
        b=cRRzdjhzZxIse+Y8NvaJsU8ozyw6e4fPP6M+cYr/KC7+if7os//Li0Q48YxrR7QutK
         pJkpdapqcEmJkajt5kiGV2+U7f8zrlw/iieFH9Ut0NxHzq/vOX9k4vGy7UsKJBk7XbuL
         40M45QtkETUnUClQzShFDEvKPFCc1dA0xHef4kCF9kwPc47tmVyIErqXv5v0ujLKEAFm
         MtSfrCfaXEz80bDnKycLGL9Ua9ef1UrxIAi9zm4pCiRpVfZz1VMk+N9As8/TaKQ5Ivng
         PvYDzEurj0ymQz1jX7cGsK+qJCQZ4O0u4c5mGfMN1aCRHPWfYznEmuE/D0jwGNEJm7eF
         rrYQ==
X-Gm-Message-State: AO0yUKUJZRWmzba3DvnK+J6rsK2DstNvLgkI2fT7S5zDuXf9OlF3ai8Z
        1msV4h7mnZw/Do5+T89cmnBS+pyCrKiwgD4J
X-Google-Smtp-Source: AK7set+gewMdqHo/uilbTwhi9Jr+umQkJA0t+YVmpE9v1p0N1BH0BOEQA4p96R002G12DWbv02IDCg==
X-Received: by 2002:a17:907:8dcd:b0:878:673f:5492 with SMTP id tg13-20020a1709078dcd00b00878673f5492mr3620104ejc.40.1675271919425;
        Wed, 01 Feb 2023 09:18:39 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id jt18-20020a170906ca1200b00889a9444e29sm4543675ejb.14.2023.02.01.09.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 09:18:38 -0800 (PST)
Message-ID: <12cc1148-5fd1-0c34-1bfe-f0f610bb5274@linaro.org>
Date:   Wed, 1 Feb 2023 19:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
Content-Language: en-GB
To:     Jun Nie <jun.nie@linaro.org>, Chanwoo Choi <cwchoi00@gmail.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, bryan.odonoghue@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
 <20230201080227.473547-2-jun.nie@linaro.org>
 <cee1778f-70a0-4bb5-a18f-4dd89cf62a2e@gmail.com>
 <CABymUCMAL-iEOni_xVhDfOi60axr2ujz5kaH1V30ymE3cAjT9w@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CABymUCMAL-iEOni_xVhDfOi60axr2ujz5kaH1V30ymE3cAjT9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/02/2023 17:17, Jun Nie wrote:
> Chanwoo Choi <cwchoi00@gmail.com> 于2023年2月1日周三 19:02写道：
>>
>> Hi,
>>
>> On 23. 2. 1. 17:02, Jun Nie wrote:
>>> Cache Coherent Interconnect (CCI) is used by some Qualcomm SoCs. This
>>> driver is introduced so that its freqency can be adjusted. And regulator
>>> associated with opp table can be also adjusted accordingly which is
>>> shared with cpu cluster.
>>>
>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>> ---
>>>   drivers/devfreq/Kconfig    |   9 +++
>>>   drivers/devfreq/Makefile   |   1 +
>>>   drivers/devfreq/qcom-cci.c | 162 +++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 172 insertions(+)
>>>   create mode 100644 drivers/devfreq/qcom-cci.c
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index 9754d8b31621..6f3f1872f3fb 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -130,6 +130,15 @@ config ARM_MEDIATEK_CCI_DEVFREQ
>>>          buck voltages and update a proper CCI frequency. Use the notification
>>>          to get the regulator status.
>>>
>>> +config ARM_QCOM_CCI_DEVFREQ
>>> +     tristate "QUALCOMM CCI DEVFREQ Driver"
>>> +     depends on ARCH_QCOM || COMPILE_TEST
>>> +     select DEVFREQ_GOV_PASSIVE
>>> +     help
>>> +       This adds a devfreq driver for Qualcomm Cache Coherent Interconnect which
>>> +       shares the same regulator with the cpu cluster. This driver can track a
>>> +       proper regulator state while CCI frequency is updated.
>>
>> Maybe, this driver use the passive governor because as this description,
>> the regulator is shared with cpu cluster. But, as I commented below,
>> you use the 'userspace' governor in probe. is it right?
>>
>>> +
>>>   config ARM_RK3399_DMC_DEVFREQ
>>>        tristate "ARM RK3399 DMC DEVFREQ Driver"
>>>        depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>>> index bf40d04928d0..f2526d8c168d 100644
>>> --- a/drivers/devfreq/Makefile
>>> +++ b/drivers/devfreq/Makefile
>>> @@ -12,6 +12,7 @@ obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)        += exynos-bus.o
>>>   obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)    += imx-bus.o
>>>   obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ) += imx8m-ddrc.o
>>>   obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)       += mtk-cci-devfreq.o
>>> +obj-$(CONFIG_ARM_QCOM_CCI_DEVFREQ)   += qcom-cci.o
>>>   obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ) += rk3399_dmc.o
>>>   obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)     += sun8i-a33-mbus.o
>>>   obj-$(CONFIG_ARM_TEGRA_DEVFREQ)              += tegra30-devfreq.o
>>> diff --git a/drivers/devfreq/qcom-cci.c b/drivers/devfreq/qcom-cci.c
>>> new file mode 100644
>>> index 000000000000..21b5f133cddc
>>> --- /dev/null
>>> +++ b/drivers/devfreq/qcom-cci.c
>>> @@ -0,0 +1,162 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright 2023 Linaro Ltd.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/devfreq.h>
>>> +#include <linux/device.h>
>>> +#include <linux/module.h>
>>> +#include <linux/nvmem-consumer.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/pm_opp.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#define SPEED_PVS(s, p) ((s << 16) | p)
>>
>> What it meaning of PVS? Could you add the comment for 'PVS' and 's', 'p'?
>>
> This is what I have from Qualcomm code. Maybe others have more info about it.
> Process Voltage Scaling(PVS) Tables defines the voltage and frequency
> value based on the msm-id in SMEM and speedbin blown in the efuse
> combination.
> 
>>> +
>>> +struct qcom_cci {
>>> +     struct devfreq_dev_profile profile;
>>> +     struct devfreq *devfreq;
>>> +     struct clk *clk;
>>> +};
>>> +
>>> +static int qcom_cci_target(struct device *dev,
>>> +             unsigned long *freq, u32 flags)
>>
>> Actually, this line is not long. You can type it on one line as following:
>>
>> static int qcom_cci_target(struct device *dev, unsigned long *freq, u32 flags)
>>
>>> +{
>>> +     struct dev_pm_opp *new_opp;
>>> +     int ret;
>>
>> As I mentioned belwo, this local variable is not needed
>> if just return PTR_ERR(new_opp).
>>
>>> +
>>> +     new_opp = devfreq_recommended_opp(dev, freq, flags);
>>> +     if (IS_ERR(new_opp)) {
>>> +             ret = PTR_ERR(new_opp);
>>> +             dev_err(dev, "failed to get recommended opp: %d\n", ret);
>>> +             return ret;
>>
>> Better to add 'return PTR_ERR(new_opp)' without 'ret' local variable.
>>
>>> +     }
>>> +     dev_pm_opp_put(new_opp);
>>> +
>>> +     return dev_pm_opp_set_rate(dev, *freq);
>>> +}
>>> +
>>> +static int qcom_cci_get_cur_freq(struct device *dev, unsigned long *freq)
>>> +{
>>> +     struct qcom_cci *priv = dev_get_drvdata(dev);
>>> +
>>> +     *freq = clk_get_rate(priv->clk);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int qcom_get_dev_version(struct nvmem_cell *speedbin_nvmem)
>>> +{
>>> +     int speed = 0, pvs = 0;
>>> +     u8 *speedbin;
>>> +     size_t len;
>>> +
>>> +     speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>>> +     if (IS_ERR(speedbin))
>>> +             return PTR_ERR(speedbin);
>>> +
>>> +     speed = (speedbin[0xc] >> 2) & 0x7;
>>> +     pvs = (speedbin[0x3] >> 5 & 0x1) | ((speedbin[0x6] >> 2 & 0x3) << 1);
>>
>> Actually, 0xc, 0x3, 0x7, 0x1 and so on. It is impossible to understand
>> the meaning of this hex value. Plesae add the constant defintion
>> for the readability.
>>
> Thanks for pointing it. The bit wise manipulation will be converted
> into nvmem offset and
> bit position in next version. So driver will read out value directly
> without bit shift/mask.
> Other comments will be adopted in next version. Thanks!

Please consider handling everything using the nvmem API. If PVS is split 
into two regions it might be better to parse them separately and then 
combine them in the driver(*), rather than performing such parsing in 
the driver.

(*) while doing the rework of the tsens driver I also faced a similar 
issue. It might be nice to have 'combined' nvmem cells.

-- 
With best wishes
Dmitry

