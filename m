Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6C4475A8
	for <lists+linux-pm@lfdr.de>; Sun,  7 Nov 2021 21:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhKGUcB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Nov 2021 15:32:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235592AbhKGUcB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Nov 2021 15:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636316957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/5LRYVwHQyJvvVcv9iCDTdzBn2XZaP9407DZ/SL0II=;
        b=Ai2wiaMvso8VBOC2XkBINoZyrUfCNDDS9SrpVhsSG3ZCTvGpX6MICA53u1EHfta9LWp8nA
        w1COql/6AFCULv1zPDE6o4DVz6l4MHi1f9jPTbucLvaF4h2QpfNU8tedxVcYzut6sIACWI
        iluwUOMQx6onaySGicUdzl8Ar7sWHJs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-eTqzDmXkPtuhevHlqllHYQ-1; Sun, 07 Nov 2021 15:29:16 -0500
X-MC-Unique: eTqzDmXkPtuhevHlqllHYQ-1
Received: by mail-ed1-f70.google.com with SMTP id m8-20020a056402510800b003e29de5badbso13081831edd.18
        for <linux-pm@vger.kernel.org>; Sun, 07 Nov 2021 12:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w/5LRYVwHQyJvvVcv9iCDTdzBn2XZaP9407DZ/SL0II=;
        b=vypKbXEpIdPScQcZlAKquC4ZLSP31jiqEkbRQIqAoE8H+hVoRelWnkw6eqrrYzqwvC
         3Fm1XbxVoGSiA87GU6tVSw1R7jEgrcet9gTyAvD4WC/GazmU+O9HrM7F51nv8fHgJjoo
         rdGaw2OB6DHg43EiFSFp1uUNK12xHIP1dqAe/Fbk+TGl75x+lrwp9/2ArAsv8CLT7/OV
         bcjhkh19agOu2oOmhiFSmr0q5ZbwsGAoMPBSvnx7stMJk2xla3vnpnlKDEvO7zbERPml
         SIg82iZfHpVp2lUw2aPAFizf0Te7wx+U460ADOokJt7/v+fW+1WrejcxHrScbc1JEj+0
         gHCg==
X-Gm-Message-State: AOAM531XI1065jCGfu/xi7/DT5hE0x44MEXSvHBejtyqDv475gYkLbrz
        Ql6BhHOJ6oGo3cbdnBf1CFVhL+jPTbga5sBS4fw9KMCTkpTZlp0kZBlgfzltJJj9PYLipXYpeGK
        xyQpKtyjLsuJMQKSCMGU=
X-Received: by 2002:aa7:ce17:: with SMTP id d23mr87739187edv.264.1636316954871;
        Sun, 07 Nov 2021 12:29:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygWsgZpeco1f3PPpzh4tt+NsyIIeo7Hs1mGD+RVD3in0p+wu6JC5zWaz7ZT9/FEI5jgOXHXQ==
X-Received: by 2002:aa7:ce17:: with SMTP id d23mr87739172edv.264.1636316954749;
        Sun, 07 Nov 2021 12:29:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r26sm7155361ejd.85.2021.11.07.12.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 12:29:14 -0800 (PST)
Message-ID: <11948739-cb0d-e80a-3230-deab9211a36c@redhat.com>
Date:   Sun, 7 Nov 2021 21:29:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/4] bq25890_charger: Rename IILIM field to IINLIM
Content-Language: en-US
To:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211107202001.54579-1-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211107202001.54579-1-jekhor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/7/21 21:19, Yauhen Kharuzhy wrote:
> Rename the Input Current Limit field in the REG00 from IILIM to IINLIM
> accordingly with the bq2589x datasheet. This is just cosmetical change
> to reduce confusion.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

Thank you, this typo was annoying me too :)

Patch subject prefix should be: "power: supply: bq25890: "

Otherwise this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/bq25890_charger.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 34ec186a2e9a..34467bfb9537 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -40,7 +40,7 @@ static const char *const bq25890_chip_name[] = {
>  };
>  
>  enum bq25890_fields {
> -	F_EN_HIZ, F_EN_ILIM, F_IILIM,				     /* Reg00 */
> +	F_EN_HIZ, F_EN_ILIM, F_IINLIM,				     /* Reg00 */
>  	F_BHOT, F_BCOLD, F_VINDPM_OFS,				     /* Reg01 */
>  	F_CONV_START, F_CONV_RATE, F_BOOSTF, F_ICO_EN,
>  	F_HVDCP_EN, F_MAXC_EN, F_FORCE_DPM, F_AUTO_DPDM_EN,	     /* Reg02 */
> @@ -153,7 +153,7 @@ static const struct reg_field bq25890_reg_fields[] = {
>  	/* REG00 */
>  	[F_EN_HIZ]		= REG_FIELD(0x00, 7, 7),
>  	[F_EN_ILIM]		= REG_FIELD(0x00, 6, 6),
> -	[F_IILIM]		= REG_FIELD(0x00, 0, 5),
> +	[F_IINLIM]		= REG_FIELD(0x00, 0, 5),
>  	/* REG01 */
>  	[F_BHOT]		= REG_FIELD(0x01, 6, 7),
>  	[F_BCOLD]		= REG_FIELD(0x01, 5, 5),
> @@ -256,7 +256,7 @@ enum bq25890_table_ids {
>  	/* range tables */
>  	TBL_ICHG,
>  	TBL_ITERM,
> -	TBL_IILIM,
> +	TBL_IINLIM,
>  	TBL_VREG,
>  	TBL_BOOSTV,
>  	TBL_SYSVMIN,
> @@ -299,7 +299,7 @@ static const union {
>  	/* TODO: BQ25896 has max ICHG 3008 mA */
>  	[TBL_ICHG] =	{ .rt = {0,	  5056000, 64000} },	 /* uA */
>  	[TBL_ITERM] =	{ .rt = {64000,   1024000, 64000} },	 /* uA */
> -	[TBL_IILIM] =   { .rt = {100000,  3250000, 50000} },	 /* uA */
> +	[TBL_IINLIM] =  { .rt = {100000,  3250000, 50000} },	 /* uA */
>  	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
>  	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
>  	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
> @@ -503,11 +503,11 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		break;
>  
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> -		ret = bq25890_field_read(bq, F_IILIM);
> +		ret = bq25890_field_read(bq, F_IINLIM);
>  		if (ret < 0)
>  			return ret;
>  
> -		val->intval = bq25890_find_val(ret, TBL_IILIM);
> +		val->intval = bq25890_find_val(ret, TBL_IINLIM);
>  		break;
>  
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> 

