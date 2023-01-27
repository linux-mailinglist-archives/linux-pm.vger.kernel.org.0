Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625467F10F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jan 2023 23:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjA0WVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Jan 2023 17:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjA0WVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2023 17:21:10 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE8B8758A
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 14:21:08 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t18so6260596wro.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7mNH8UjS1eLeKEg29OSJTNzCrRV1GaewWlhXhn/Ass=;
        b=phX5a0bkyIOQHgeKrnGJ6rP2bFpUOK7+GfRnIGaTXbJHXepfIv3gEQw48mJPig+faD
         TnUHxa80I7+4/bpCYyiJbYnwnb9UzCcDTCfoxEsIaSlgLIsfyEkzyl66zWgmoEBk52gM
         03EFgs6sTQAY3FtxiyKuCSZtpb9Qbrv3J0XBq/HnJAA6h5FWsWSa2JWiy+6dcErkMotM
         agNBfcUn7fOkpRaNVJ5X3xki4GHiX/hml0PzClY3zDeOAQnHhoZn6iiccU9g1e/FEPPW
         UL8kmJzSulZMmgIhybb4RkxJbY+h+YuYjCv0MX2lvOsOjemhoTogf2Omta/Pu05L+1L4
         9NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7mNH8UjS1eLeKEg29OSJTNzCrRV1GaewWlhXhn/Ass=;
        b=wD5g92inKXZGB7KrMHccEgqf6T/000gbNTkNVkdYLFkW0BOxdzaF6Mw89sjnpp/P44
         ILuood/TQIOxtVqGGN7HHtJU6D8GrW/CqONLYMhEc8dDzVWYNYGXr5GBBwtk/UsPQl7N
         3CHwB2fLpZWj6ZGQ9jZ5evF7po5gAriPYzy1c+kDMhwyad2omJxRGCIqfLLqLW+28qtN
         4jk4thKFmJNtViOPXSVsLsSx1ubqTLNemaD7qiNyzi6Ozw6QgkD+j+Ij5YnGSel+KsN6
         cZciI2Z99KZVIfpTOzZnP37mOe5uTtKomhPoJAvADoC+cHEim4GX5+7fKod5cC8anGdY
         MnjQ==
X-Gm-Message-State: AFqh2kpuxHzkp7mpO0yJqvWqoEkua6g6zw5JJqiq1T/6hWgtapX6UCPS
        dgOO4U+KTfyDIucZBlUtyrnw4Q==
X-Google-Smtp-Source: AMrXdXvpTC0WEHjMIdqtZJgSJEbDnzIJWgxxB9utWCGhrm/ZU+Tpgj0xpGRTg69JQyKH6I1qyty5mQ==
X-Received: by 2002:adf:8b45:0:b0:2bd:e8c9:bcd5 with SMTP id v5-20020adf8b45000000b002bde8c9bcd5mr34310410wra.61.1674858067148;
        Fri, 27 Jan 2023 14:21:07 -0800 (PST)
Received: from [192.168.0.20] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d500a000000b002be0b1e556esm4947431wrt.59.2023.01.27.14.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 14:21:06 -0800 (PST)
Message-ID: <df39cc8c-29db-f401-e1a2-1a3b7e962a7e@baylibre.com>
Date:   Fri, 27 Jan 2023 23:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v9 2/5] thermal: mediatek: control buffer enablement
 tweaks
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
References: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
 <20221018-up-i350-thermal-bringup-v9-2-55a1ae14af74@baylibre.com>
 <eb3b9439-172b-daea-8f0f-53c8fe7648f9@linaro.org>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <eb3b9439-172b-daea-8f0f-53c8fe7648f9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 1/27/23 22:48, Daniel Lezcano wrote:
> On 27/01/2023 16:44, Amjad Ouled-Ameur wrote:
>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>
>> Add logic in order to be able to turn on the control buffer on MT8365.
>> This change now allows to have control buffer support for MTK_THERMAL_V1,
>> and it allows to define the register offset, and mask used to enable it.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/thermal/mtk_thermal.c | 25 ++++++++++++++++++-------
>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
>> index 8440692e3890..d8ddceb75372 100644
>> --- a/drivers/thermal/mtk_thermal.c
>> +++ b/drivers/thermal/mtk_thermal.c
>> @@ -271,6 +271,9 @@ struct mtk_thermal_data {
>>       bool need_switch_bank;
>>       struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>>       enum mtk_thermal_version version;
>> +    u32 apmixed_buffer_ctl_reg;
>> +    u32 apmixed_buffer_ctl_mask;
>> +    u32 apmixed_buffer_ctl_set;
>>   };
>>     struct mtk_thermal {
>> @@ -514,6 +517,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
>>       .adcpnp = mt7622_adcpnp,
>>       .sensor_mux_values = mt7622_mux_values,
>>       .version = MTK_THERMAL_V2,
>> +    .apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
>> +    .apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
>> +    .apmixed_buffer_ctl_set = BIT(0),
>>   };
>>     /*
>> @@ -963,14 +969,18 @@ static const struct of_device_id mtk_thermal_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
>>   -static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
>> +static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
>> +                       void __iomem *apmixed_base)
>>   {
>> -    int tmp;
>> +    u32 tmp;
>> +
>> +    if (!mt->conf->apmixed_buffer_ctl_reg)
>> +        return;
>>   -    tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
>> -    tmp &= ~(0x37);
>> -    tmp |= 0x1;
>> -    writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
>> +    tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
>> +    tmp &= mt->conf->apmixed_buffer_ctl_mask;
>> +    tmp |= mt->conf->apmixed_buffer_ctl_set;
>> +    writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
>>       udelay(200);
>>   }
>>   @@ -1070,8 +1080,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>           goto err_disable_clk_auxadc;
>>       }
>>   +    mtk_thermal_turn_on_buffer(mt, apmixed_base);
>> +
>>       if (mt->conf->version == MTK_THERMAL_V2) {
>> -        mtk_thermal_turn_on_buffer(apmixed_base);
>>           mtk_thermal_release_periodic_ts(mt, auxadc_base);
>>       }
>
> This change conflicts with commit 4f2ee0aa2e706
>
> I fixed it with:
>
> -       if (mt->conf->version != MTK_THERMAL_V1) {
> -               mtk_thermal_turn_on_buffer(apmixed_base);
> +       mtk_thermal_turn_on_buffer(apmixed_base);
> +
> +       if (mt->conf->version != MTK_THERMAL_V1)
>                 mtk_thermal_release_periodic_ts(mt, auxadc_base);
> -       }
>
I think it's rather MTK_THERMAL_V2 and not MTK_THERMAL_V1. Other than that, it looks

fine by me, thanks.


Amjad

> Let me know if there is something wrong.
>
>
