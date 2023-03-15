Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AEB6BAD49
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 11:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjCOKOi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 06:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjCOKOO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 06:14:14 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858EE1514D
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 03:13:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g18so18886480ljl.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678875226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wR8RvE7+8ppUn+x9JPThBNI9Mo3SZq3Efy44T2RNfT8=;
        b=AbYMIMZr+Q83DLfoG17HLcKICZOjbTwqKaOfMuWPrq5yV+UbeqJGCSpHhbjKLB6Lkw
         DUu/4v9J30yo3Rg5zVCsRpCko2RpgyVPGi6WwbyyGVw3Hf7jpbEWvDb7o5kCgiS8CVYN
         m4iAteExvoFfdBjy1ESL+YVt4pBmTCHRZM8Z4HA2PRac2aI21e4CeUd5Yj/j+h6cpvri
         QL8ow8aMDMc0rWz7Fvj5A1nOgtuPIjN5+L8Gsv2YGL7W3is6X/qjOFTofDw3XFbEPdZm
         Oph/43sNg8z9uu5hJHm469ieXjy74aGBZwFk6OsS/FTsFQS3kP0k9Hzm/X2X/XskTGfD
         lgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678875226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wR8RvE7+8ppUn+x9JPThBNI9Mo3SZq3Efy44T2RNfT8=;
        b=m5ubrW5onS5xP54P2A0y3i4sxRKsOkVxgBOgKHmhEysRExZD6Y+j94ArXj9U+IgMB3
         4ANJagsDzbYgNB33fxfEijMcF6enXn1QIIrh/08bu/vUL7RGm+q+BjTDrNAmBcPk+kTJ
         kaPplbmMOhfAu/Zw+fzZFdL6cgWGoxmwYA3mPzONQvv5Izcv9vbDae4wDPHTqS82hqja
         sfTN46Dff8lFkiSaiTqcYoe9RjY+jNLxFwMVKVs89AiIJgLaohbJ1WT2PDqfAIkLmQ+k
         PNhiMbgu7khpGD7vdt2wWUonMSY56AOb286a2COGgUC9+eo3K890x/B63plk+MSvjOFb
         zL9A==
X-Gm-Message-State: AO0yUKXo8qdVfsvdeF/aQk9OAsdlUhdX38XFXfKxarJOfXdygEsM8PIS
        7ezZ2NJUXtuEx3heD6BouL8rN6BwZix5YnqUaAw=
X-Google-Smtp-Source: AK7set/JfsQDKULPg14ddMAfFduRdd5KS+luwvDe6svnh5+Z9TqWZHEtnlAz+cG+AYiaz9l7foqZkA==
X-Received: by 2002:a2e:a909:0:b0:295:b0aa:978a with SMTP id j9-20020a2ea909000000b00295b0aa978amr549353ljq.6.1678875226526;
        Wed, 15 Mar 2023 03:13:46 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a1-20020a2e9801000000b00293534d9760sm790353ljj.127.2023.03.15.03.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 03:13:46 -0700 (PDT)
Message-ID: <dc831034-98ec-9d8c-1220-9934c9d5b79e@linaro.org>
Date:   Wed, 15 Mar 2023 11:13:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/7] soc: qcom: icc-bwmon: Handle global registers
 correctly
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
 <20230304-topic-ddr_bwmon-v2-2-04db989db059@linaro.org>
 <7a143671-372a-3af8-7804-fe12f858f853@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <7a143671-372a-3af8-7804-fe12f858f853@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 15.03.2023 08:27, Krzysztof Kozlowski wrote:
> On 13/03/2023 12:41, Konrad Dybcio wrote:
>> The BWMON hardware has two sets of registers: one for the monitor itself
>> and one called "global". It has what seems to be some kind of a head
>> switch and an interrupt control register. It's usually 0x200 in size.
>>
>> On fairly recent SoCs (with the starting point seemingly being moving
>> the OSM programming to the firmware) these two register sets are
>> contiguous and overlapping, like this (on sm8450):
>>
>> /* notice how base.start == global_base.start+0x100 */
>> reg = <0x90b6400 0x300>, <0x90b6300 0x200>;
>> reg-names = "base", "global_base";
>>
>> Which led to some confusion and the assumption that since the
>> "interesting" global registers begin right after global_base+0x100,
>> there's no need to map two separate regions and one can simply subtract
>> 0x100 from the offsets.
>>
>> This is however not the case for anything older than SDM845, as the
>> global region can appear in seemingly random spots on the register map.
>>
>> Handle the case where the global registers are mapped separately to allow
>> proper functioning of BWMONv4 on MSM8998 and older. Add specific
>> compatibles for 845, 8280xp, 7280 and 8550 (all of which use the single
>> reg space scheme) to keep backwards compatibility with old DTs.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/soc/qcom/icc-bwmon.c | 228 +++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 208 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>> index d07be3700db6..2fe67a3cd2d7 100644
>> --- a/drivers/soc/qcom/icc-bwmon.c
>> +++ b/drivers/soc/qcom/icc-bwmon.c
>> @@ -34,14 +34,27 @@
>>  /* Internal sampling clock frequency */
>>  #define HW_TIMER_HZ				19200000
>>  
>> -#define BWMON_V4_GLOBAL_IRQ_CLEAR		0x008
>> -#define BWMON_V4_GLOBAL_IRQ_ENABLE		0x00c
>> +#define BWMON_V4_GLOBAL_IRQ_CLEAR		0x108
>> +#define BWMON_V4_GLOBAL_IRQ_ENABLE		0x10c
>>  /*
>>   * All values here and further are matching regmap fields, so without absolute
>>   * register offsets.
>>   */
>>  #define BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE	BIT(0)
>>  
>> +/*
>> + * Starting with SDM845, the BWMON4 register space has changed a bit:
>> + * the global registers were jammed into the beginning of the monitor region.
>> + * To keep the proper offsets, one would have to map <GLOBAL_BASE 0x200> and
>> + * <GLOBAL_BASE+0x100 0x300>, which is straight up wrong.
>> + * To facilitate for that, while allowing the older, arguably more proper
>> + * implementations to work, offset the global registers by -0x100 to avoid
>> + * having to map half of the global registers twice.
>> + */
>> +#define BWMON_V4_845_OFFSET			0x100
>> +#define BWMON_V4_GLOBAL_IRQ_CLEAR_845		(BWMON_V4_GLOBAL_IRQ_CLEAR - BWMON_V4_845_OFFSET)
>> +#define BWMON_V4_GLOBAL_IRQ_ENABLE_845		(BWMON_V4_GLOBAL_IRQ_ENABLE - BWMON_V4_845_OFFSET)
>> +
>>  #define BWMON_V4_IRQ_STATUS			0x100
>>  #define BWMON_V4_IRQ_CLEAR			0x108
>>  
>> @@ -118,8 +131,12 @@
>>  #define BWMON_NEEDS_FORCE_CLEAR			BIT(1)
>>  
>>  enum bwmon_fields {
>> +	/* Global region fields, keep them at the top */
>>  	F_GLOBAL_IRQ_CLEAR,
>>  	F_GLOBAL_IRQ_ENABLE,
>> +	F_NUM_GLOBAL_FIELDS,
>> +
>> +	/* Monitor region fields */
>>  	F_IRQ_STATUS,
> 
> F_IRQ_STATUS = F_NUM_GLOBAL_FIELDS
> or = 2, so you won't waste one space in the array.
Good find!

> 
>>  	F_IRQ_CLEAR,
>>  	F_IRQ_ENABLE,
>> @@ -157,6 +174,9 @@ struct icc_bwmon_data {
>>  
>>  	const struct regmap_config *regmap_cfg;
>>  	const struct reg_field *regmap_fields;
>> +
>> +	const struct regmap_config *global_regmap_cfg;
>> +	const struct reg_field *global_regmap_fields;
>>  };
>>  
>>  struct icc_bwmon {
>> @@ -166,6 +186,7 @@ struct icc_bwmon {
>>  
>>  	struct regmap *regmap;
>>  	struct regmap_field *regs[F_NUM_FIELDS];
>> +	struct regmap_field *global_regs[F_NUM_FIELDS];
> 
> F_NUM_GLOBAL_FIELDS?
Totally.

> 
>>  
> 
> (...)
> 
>>  }
>>  
>>  static int bwmon_probe(struct platform_device *pdev)
>> @@ -645,6 +816,21 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
>>  	.quirks = BWMON_HAS_GLOBAL_IRQ,
>>  	.regmap_fields = msm8998_bwmon_reg_fields,
>>  	.regmap_cfg = &msm8998_bwmon_regmap_cfg,
>> +	.global_regmap_fields = msm8998_bwmon_global_reg_fields,
>> +	.global_regmap_cfg = &msm8998_bwmon_global_regmap_cfg,
>> +};
>> +
>> +static const struct icc_bwmon_data sdm845_ddr_bwmon_data = {
> 
> The name "ddr" is here (and other places) confusing. This is not the DDR
> bwmon.
I suppose cpu_bwmon could make more sense?

Konrad
> 
>> +	.sample_ms = 4,
>> +	.count_unit_kb = 64,
>> +	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
>> +	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
>> +	.default_lowbw_kbps = 0,
>> +	.zone1_thres_count = 16,
>> +	.zone3_thres_count = 1,
>> +	.quirks = BWMON_HAS_GLOBAL_IRQ,
>> +	.regmap_fields = sdm845_ddr_bwmon_reg_fields,
>> +	.regmap_cfg = &sdm845_ddr_bwmon_regmap_cfg,
>>  };
>>  
>>  static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
>> @@ -673,16 +859,18 @@ static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
>>  };
>>  
>>  static const struct of_device_id bwmon_of_match[] = {
>> -	{
>> -		.compatible = "qcom,msm8998-bwmon",
>> -		.data = &msm8998_bwmon_data
>> -	}, {
>> -		.compatible = "qcom,sdm845-llcc-bwmon",
>> -		.data = &sdm845_llcc_bwmon_data
>> -	}, {
>> -		.compatible = "qcom,sc7280-llcc-bwmon",
>> -		.data = &sc7280_llcc_bwmon_data
>> -	},
>> +	/* BWMONv4, separate monitor and global register spaces */
>> +	{ .compatible = "qcom,msm8998-bwmon", .data = &msm8998_bwmon_data },
>> +	/* BWMONv4, unified register space */
>> +	{ .compatible = "qcom,sdm845-bwmon", .data = &sdm845_ddr_bwmon_data },
>> +	/* BWMONv5 */
>> +	{ .compatible = "qcom,sdm845-llcc-bwmon", .data = &sdm845_llcc_bwmon_data },
>> +	{ .compatible = "qcom,sc7280-llcc-bwmon", .data = &sc7280_llcc_bwmon_data },
>> +
>> +	/* Compatibles kept for legacy reasons */
>> +	{ .compatible = "qcom,sc7280-cpu-bwmon", .data = &sdm845_ddr_bwmon_data },
>> +	{ .compatible = "qcom,sc8280xp-cpu-bwmon", .data = &sdm845_ddr_bwmon_data },
>> +	{ .compatible = "qcom,sm8550-cpu-bwmon", .data = &sdm845_ddr_bwmon_data },
>>  	{}
>>  };
>>  MODULE_DEVICE_TABLE(of, bwmon_of_match);
>>
> 
> Best regards,
> Krzysztof
> 
