Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20145B025F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Sep 2022 13:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiIGLHV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Sep 2022 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiIGLHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2022 07:07:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520949C8E1
        for <linux-pm@vger.kernel.org>; Wed,  7 Sep 2022 04:07:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l12so7092488ljg.9
        for <linux-pm@vger.kernel.org>; Wed, 07 Sep 2022 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lvtJG6I12xIUOgfdF4widnYZYk9JagVGFuN0/DDPLdU=;
        b=XiMUPBPxPc9IhVA1ZGgRlWRAegNFsU/EoUpWrSg+v+nbt/y4HeQi6x3+iXihRNL0le
         f5hjw/1+TTM/t3tu0+/8hOZezVP6Lhs7dAs4s+s73Hh4bKpPxt8Rnne8DypzDTXnXwvH
         ORkltv3XCpDUtqh9stWnUzrufQAFeNfQmnRvjP5OiYgAUKWhKZxaZQk4v9Wzk/ARalCt
         2jKDWi8fDljjmo745pzpdZb2djh1xhuYIhOCWcvOM6J2nIHPGDXP8tWkU1BAx98Aolec
         vvRdZui0sxbt2CvsDohKkqUTKb1a0zuTVB+ldLst4l9APdKAdaUwwNVl68txorng1xHO
         S+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lvtJG6I12xIUOgfdF4widnYZYk9JagVGFuN0/DDPLdU=;
        b=OzicyLtE/TINwtyvW32nVbo8QOw7E3z3382+IkGSyX8n033f0PoHIRn/s31Tgxd4W3
         hLGfZt4fqFksNaCW2FGlwj88EjxccqjZesNfVrRueY+cqa1sQ9BuutCREl7ubJgX3ipG
         GYUria+MyBitpxSFJoTCMLJtPo1Iw2s84leizZdo0xBAvp5SEsr20AxqT4YDRoPq+iS7
         BbGNIy48/bRtfTbAkmziP1Ba9QYxh9jFlIdtrM88zZ8IHW6zv/rixEIGaHZ9aW9ZFHh1
         Gqp/Vpg+XV8Vgj4qrMNGOQ+cmf1hwFf1AE/CYJQ75LzVaPGgT/MKJoVq9t2ku9cR41Zi
         7p0Q==
X-Gm-Message-State: ACgBeo0S7/UIC+ET7SQBTrKzUaF7Fd8UuFLWR6Vqa4lJEnFgOng6oJuY
        HqKuXcy+IJxpp+fdniVqXxuP7A==
X-Google-Smtp-Source: AA6agR4BsvretTiQT3ouMfvY5Cv6ZwiSK/2diedXXx6s6LwAJ8VnnPNgBRPXt6owZeAN/Boc80yIxg==
X-Received: by 2002:a2e:3002:0:b0:26a:b199:46df with SMTP id w2-20020a2e3002000000b0026ab19946dfmr766144ljw.304.1662548837711;
        Wed, 07 Sep 2022 04:07:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c19-20020a056512325300b0048b18700dddsm2407812lfr.106.2022.09.07.04.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:07:17 -0700 (PDT)
Message-ID: <da1178da-bb0c-fb7e-9ff9-ee4e3caaf222@linaro.org>
Date:   Wed, 7 Sep 2022 13:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 10/30] thermal/drivers/exynos: Replace
 of_thermal_is_trip_valid() by thermal_zone_get_trip()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
 <20220906164720.330701-11-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906164720.330701-11-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/09/2022 18:47, Daniel Lezcano wrote:
> The thermal_zone_get_trip() does the same check as
> of_thermal_is_trip_valid(). Replace the call to
> of_thermal_is_trip_valid() by thermal_zone_get_trip().
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 91e6860b5ec4..5e6bb74c67f0 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -554,13 +554,15 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
>  {
>  	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>  	struct thermal_zone_device *tz = data->tzd;
> +	struct thermal_trip trip;
>  	unsigned int con, interrupt_en = 0, i;
>  
>  	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
>  
>  	if (on) {
>  		for (i = 0; i < data->ntrip; i++) {
> -			if (!of_thermal_is_trip_valid(tz, i))
> +
> +			if (thermal_zone_get_trip(tz, i, &trip))

No need for empty line before. Ditto in other places.

Best regards,
Krzysztof
