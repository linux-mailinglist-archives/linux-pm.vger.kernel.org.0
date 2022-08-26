Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD25A290B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Aug 2022 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbiHZOGD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiHZOGC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 10:06:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE4DC0E61
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 07:05:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k9so1979534wri.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Z+0yDajJ0wMjpgyqOUnKw47mL+zdc8UQAtbyK28TADE=;
        b=1TrEMsMjrNGXQg3zlIfMbp6DcGA/mnvnYEcXOVNWIZtxGMMtIIDBXFAdTbQdg1JhiZ
         NOUGwIig0tV7ocKG7N6MfxSRKKhCjxzyzNULveaen25A473Kz6VG6VewMXb6F9ODrHl3
         prvKMEYieaPC+isGsSBb5ZIGpmk1EXoIf7Xw/CMMowCQsPdIVOPsUbH3NE90Rjt6Vgsb
         wFetqy6U4nj5bS5DNnxsjUfxh4KXHMP2z9YMVBFv7o0B8WdX4pq+IybwfAv9Uh3nXWjK
         EtbG3Zxi2O/zO0WdLbyauOW08/7V+J6sJJ+2QI6d9IPSydep7VVX/UsSRlXBZFPlcItP
         /Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Z+0yDajJ0wMjpgyqOUnKw47mL+zdc8UQAtbyK28TADE=;
        b=k+XHBDxCzQ7AMDec0eac+rWjOArT4fnxGUxovibJQuL8X93DAqwCLEXTru56ALgo4W
         c7rUPVdD5ekgUgXY7F1kH+fDCi/pPCPic2jZ4PB+j+iUzhbCdBb0RDf7rOZ4okc2IHDE
         ZhJvxtutkU1GERU2PY3USTV5C0pf+w5bieN+yeL5j/IOqzBC0jiUwQcEj5HnomSBoFaU
         V+PSkSEpDrIe6joWlt3LfGp8QvWZYrdMjuxaI2aafXlX8bTdNGUli/giYiUTomYf9wy2
         q1JA3GhI8h2l3O61T964JaD+VHm3+h4fgeVRfTCI98b9j3romvFKmK197mx5OZDqK7ub
         8d8w==
X-Gm-Message-State: ACgBeo2O4A2uojt4SlXH6PduIGjG0/0ZuMrJcapAvTI8msRNLdjU78hu
        OzAiglqw/ahzdPosViUNAbrZYQ==
X-Google-Smtp-Source: AA6agR5LuyIlDMydRhgyzTFzClAGY8aeGYDhoH5FtmW4fur5TkLAwiWQlSHq4jMGUpVO741aer/a0w==
X-Received: by 2002:a5d:5305:0:b0:225:453a:be9b with SMTP id e5-20020a5d5305000000b00225453abe9bmr5058563wrv.516.1661522757838;
        Fri, 26 Aug 2022 07:05:57 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id j2-20020adff542000000b0021e51c039c5sm1967727wrp.80.2022.08.26.07.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 07:05:57 -0700 (PDT)
Message-ID: <cf60d0a7-2dec-a6c7-879f-ab4812a1e034@baylibre.com>
Date:   Fri, 26 Aug 2022 16:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/4] thermal: mediatek: control buffer enablement
 tweaks
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Markus Schneider-Pargmann <msp@baylibre.com>
References: <20220720181854.547881-1-aouledameur@baylibre.com>
 <20220720181854.547881-4-aouledameur@baylibre.com>
 <a143dfcd-7a6a-49ff-6bed-4ffdb0fa1c4a@collabora.com>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <a143dfcd-7a6a-49ff-6bed-4ffdb0fa1c4a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Angelo,

On 7/21/22 10:11, AngeloGioacchino Del Regno wrote:
> Il 20/07/22 20:18, Amjad Ouled-Ameur ha scritto:
>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>
>> Add logic in order to be able to turn on the control buffer on MT8365.
>> This change now allows to have control buffer support for 
>> MTK_THERMAL_V1,
>> and it allows to define the register offset, and mask used to enable it.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> ---
>>   drivers/thermal/mtk_thermal.c | 23 +++++++++++++++++------
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/mtk_thermal.c 
>> b/drivers/thermal/mtk_thermal.c
>> index 216eb0d61c5b..1dc276f8c4f1 100644
>> --- a/drivers/thermal/mtk_thermal.c
>> +++ b/drivers/thermal/mtk_thermal.c
>> @@ -283,6 +283,9 @@ struct mtk_thermal_data {
>>       bool need_switch_bank;
>>       struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>>       enum mtk_thermal_version version;
>> +    u32 apmixed_buffer_ctl_reg;
>> +    u32 apmixed_buffer_ctl_mask;
>> +    u32 apmixed_buffer_ctl_set;
>>   };
>>     struct mtk_thermal {
>> @@ -578,6 +581,9 @@ static const struct mtk_thermal_data 
>> mt7622_thermal_data = {
>>       .adcpnp = mt7622_adcpnp,
>>       .sensor_mux_values = mt7622_mux_values,
>>       .version = MTK_THERMAL_V2,
>> +    .apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
>> +    .apmixed_buffer_ctl_mask = ~0x37,
>
> This is effectively GENMASK(31, 6) | BIT(3) :-)
>
>> +    .apmixed_buffer_ctl_set = 0x1,
>
> ...and this is BIT(0)
>
Thank you for the catch, will update them appropriately.
>>   }; >
>>   /*
>> @@ -1031,14 +1037,18 @@ static const struct of_device_id 
>> mtk_thermal_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
>>   -static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
>> +static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
>> +                       void __iomem *apmixed_base)
>>   {
>>       int tmp;
>
> Since you're practically restructuring this function, please fix this 
> wrong
> variable type, as this should be a u32.
>
Sure agreed.


Thank you Angelo for the review.

Regards,

Amjad

> Regards,
> Angelo
