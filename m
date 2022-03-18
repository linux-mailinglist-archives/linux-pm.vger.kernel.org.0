Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C69C4DD6CB
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 10:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiCRJFj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Mar 2022 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiCRJFg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2022 05:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AB8117F3CF
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2022 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647594257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CCWw6tr10nuZiS724je/fzeaONphOekjWae3Q49P/M=;
        b=Ya1rFDZtGeJc6w6Nd/Xy8dX8x0yEH3UsZhsjeu6UEhf72DKQHdOWfBw7II6x74OH8YXM/o
        +lQ6xKZyiExFea/63QVfeB1etVpU6EsWnjHCVbb17yeaXmoSEGDWzCos4gQFydnfWMCWmQ
        vQqmCeLcBw7RkYNCJUzWu5pjn2qilA8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-ITQMKscdOry9sbUZ826CzQ-1; Fri, 18 Mar 2022 05:04:16 -0400
X-MC-Unique: ITQMKscdOry9sbUZ826CzQ-1
Received: by mail-ej1-f70.google.com with SMTP id gx12-20020a1709068a4c00b006df7e8181ceso3942624ejc.10
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2022 02:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2CCWw6tr10nuZiS724je/fzeaONphOekjWae3Q49P/M=;
        b=BaJND4unreToiTsPY2bBLNMCc8AuHIZUZhIc09gYuTiNTH/nuyVBcQC0sp2Il31LAS
         Thn/9vhXYeHN3kzbMJWAI2mPX4IugjPp5sf6b2nFj5ZFfGbDswKEig1C1FQiAE/I04Wm
         COVeqhBosaXYh5jC8jdS8wDAm29ms0agJ5sh949WjtFV+nVeP/9muLfuRg7zkl9bQAxD
         BSkWyqm1ycdf6/Z5Bz12TEs1VcziJetDmrflSUiPJuUiaF+5QIQJVrGcQa9Kq543nbuJ
         rWykXVkq4zoKgyRh55EsRR20LJ2XAybXHwunhs4XMy0xJMBopy34rItTh420IpFFBisV
         Fbew==
X-Gm-Message-State: AOAM532cIDzGKO9+XfYdxb7/kInGj7Ip8t9cwCILuyda1TI3St2rzwRJ
        +SE0Eej/667RGYqN5vL/k/xj7bbap3gZvwY/F1AIfwev0UPgKsswC9ymLVGRSkW8BIB291+7HeU
        GvdAqXpYDavP0j39y/NY=
X-Received: by 2002:a17:906:4fd2:b0:6db:21ba:e434 with SMTP id i18-20020a1709064fd200b006db21bae434mr8298112ejw.714.1647594254900;
        Fri, 18 Mar 2022 02:04:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrdZ7+l7FFwp7l8isRVHJ+HMF8wuWgWxqvQzVeYBfcWA79JoZ1mgOYyn+CpNFjGKoKnrLqgw==
X-Received: by 2002:a17:906:4fd2:b0:6db:21ba:e434 with SMTP id i18-20020a1709064fd200b006db21bae434mr8298097ejw.714.1647594254667;
        Fri, 18 Mar 2022 02:04:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id gt34-20020a1709072da200b006df6bb3db69sm3501939ejc.158.2022.03.18.02.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 02:04:14 -0700 (PDT)
Message-ID: <fcb5ac4e-d4d1-43fb-c41f-8b9078e07bb5@redhat.com>
Date:   Fri, 18 Mar 2022 10:04:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/4] power: supply: max17042_battery: use ModelCfg refresh
 on max17055
Content-Language: en-US
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
 <20220318001048.20922-3-sebastian.krzyszkowiak@puri.sm>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220318001048.20922-3-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/18/22 01:10, Sebastian Krzyszkowiak wrote:
> Unlike other models, max17055 doesn't require cell characterization
> data and operates on smaller amount of input variables (DesignCap,
> VEmpty, IChgTerm and ModelCfg). Input data can already be filled in
> by max17042_override_por_values, however model refresh bit has to be
> set after adjusting input variables in order to make them apply.
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/power/supply/max17042_battery.c | 73 +++++++++++++++----------
>  include/linux/power/max17042_battery.h  |  3 +
>  2 files changed, 48 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index c019d6c52363..c39250349a1d 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -806,6 +806,13 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
>  	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)) {
>  		max17042_override_por(map, MAX17047_V_empty, config->vempty);
>  	}
> +
> +	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
> +		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
> +		// VChg is 1 by default, so allow it to be set to 0
> +		regmap_update_bits(map, MAX17055_ModelCfg,
> +				MAX17055_MODELCFG_VCHG_BIT, config->model_cfg);
> +	}
>  }
>  
>  static int max17042_init_chip(struct max17042_chip *chip)
> @@ -814,44 +821,54 @@ static int max17042_init_chip(struct max17042_chip *chip)
>  	int ret;
>  
>  	max17042_override_por_values(chip);
> +
> +	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
> +		regmap_write_bits(map, MAX17055_ModelCfg,
> +				  MAX17055_MODELCFG_REFRESH_BIT, MAX17055_MODELCFG_REFRESH_BIT);
> +	}
> +

This can be folded into the if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {}
which you add to max17042_override_por_values() above.


>  	/* After Power up, the MAX17042 requires 500mS in order
>  	 * to perform signal debouncing and initial SOC reporting
>  	 */
>  	msleep(500);
>  
> -	/* Initialize configuration */
> -	max17042_write_config_regs(chip);
> -
> -	/* write cell characterization data */
> -	ret = max17042_init_model(chip);
> -	if (ret) {
> -		dev_err(&chip->client->dev, "%s init failed\n",
> -			__func__);
> -		return -EIO;
> -	}
> +	if ((chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042) ||
> +	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047) ||
> +	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050)) {
> +		/* Initialize configuration */
> +		max17042_write_config_regs(chip);
> +
> +		/* write cell characterization data */
> +		ret = max17042_init_model(chip);
> +		if (ret) {
> +			dev_err(&chip->client->dev, "%s init failed\n",
> +				__func__);
> +			return -EIO;
> +		}
>  
> -	ret = max17042_verify_model_lock(chip);
> -	if (ret) {
> -		dev_err(&chip->client->dev, "%s lock verify failed\n",
> -			__func__);
> -		return -EIO;
> -	}
> -	/* write custom parameters */
> -	max17042_write_custom_regs(chip);
> +		ret = max17042_verify_model_lock(chip);
> +		if (ret) {
> +			dev_err(&chip->client->dev, "%s lock verify failed\n",
> +				__func__);
> +			return -EIO;
> +		}
> +		/* write custom parameters */
> +		max17042_write_custom_regs(chip);
>  
> -	/* update capacity params */
> -	max17042_update_capacity_regs(chip);
> +		/* update capacity params */
> +		max17042_update_capacity_regs(chip);
>  
> -	/* delay must be atleast 350mS to allow VFSOC
> -	 * to be calculated from the new configuration
> -	 */
> -	msleep(350);
> +		/* delay must be at least 350mS to allow VFSOC
> +		 * to be calculated from the new configuration
> +		 */
> +		msleep(350);
>  
> -	/* reset vfsoc0 reg */
> -	max17042_reset_vfsoc0_reg(chip);
> +		/* reset vfsoc0 reg */
> +		max17042_reset_vfsoc0_reg(chip);
>  
> -	/* load new capacity params */
> -	max17042_load_new_capacity_params(chip);
> +		/* load new capacity params */
> +		max17042_load_new_capacity_params(chip);
> +	}
>  
>  	/* Init complete, Clear the POR bit */
>  	regmap_update_bits(map, MAX17042_STATUS, STATUS_POR_BIT, 0x0);
> diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
> index c417abd2ab70..6943921cab5e 100644
> --- a/include/linux/power/max17042_battery.h
> +++ b/include/linux/power/max17042_battery.h
> @@ -23,6 +23,8 @@
>  
>  #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
>  
> +#define MAX17055_MODELCFG_REFRESH_BIT	BIT(15)
> +
>  enum max17042_register {
>  	MAX17042_STATUS		= 0x00,
>  	MAX17042_VALRT_Th	= 0x01,
> @@ -208,6 +210,7 @@ struct max17042_config_data {
>  	u16	full_soc_thresh;	/* 0x13 */
>  	u16	design_cap;	/* 0x18 */
>  	u16	ichgt_term;	/* 0x1E */
> +	u16	model_cfg;	/* 0xDB */
>  
>  	/* MG3 config */
>  	u16	at_rate;	/* 0x04 */

Regards,

Hans

