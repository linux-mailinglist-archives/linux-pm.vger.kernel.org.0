Return-Path: <linux-pm+bounces-5485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1788DB52
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 11:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA401C27754
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4503610A;
	Wed, 27 Mar 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgYlabsX"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB014276
	for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535785; cv=none; b=iyyMpD2yTnsmGw8aSBoZt7T5woGJPkpSezjyS4iH+9a1c8xlLGei9dyYJr4J6wLyR/waFZ4hGk2W8+NpzGarwrCP/uO6KjSW9IXu3Ry+Cxgg9p4w/wuU2GdkoTbg3N4DhPwnGWIKnOx9PpzhFqPUcQ+1M7P5ALlbB0WK+ye/TTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535785; c=relaxed/simple;
	bh=L6tlt98OmYQtFpQLamK6Qa2xfI5IedwVJCtmpxBH+q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ixgx6OahzuPL9oauRFKTlNB+jZDhdIUbMugQhYPW8KGchnOrcKdGWEECh90AXbDBiCfNSngAwMzYH1zZlAIIFsbJXsYvHZPTfIEjIn4iUaxPeeBTOo9u7llYWvtrouBbL/0wp+EnJ2bbE9UZ6fOvcGI/3kLiogh9GahuWBD88Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgYlabsX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711535781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLhy70EK4wmXFy+4nX1nQRJ3JiG17ewD5LnGkbVypKo=;
	b=VgYlabsXTyUBKGXV2NQhdUaeebwfNRtxNzJKdOghXmlLzhkAupAV92/LHVMDYonxTPosk8
	IDNmXBeyDVXr7a9C00FRZRPKTaWl7dSMsCpxH7WuKTu+n7vlctsCk+vaKUHOnQF6FKd9vg
	yrX0ZOtasEgD4byeAf3J0HbWwAujaXk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-rwXI1CB4Nm6oaa47qIkgqA-1; Wed, 27 Mar 2024 06:36:20 -0400
X-MC-Unique: rwXI1CB4Nm6oaa47qIkgqA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d48b182917so66829271fa.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 03:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711535779; x=1712140579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLhy70EK4wmXFy+4nX1nQRJ3JiG17ewD5LnGkbVypKo=;
        b=sqiMPxGp3jPYsYpzKr8IKkhebTEoJ2QThA1XsUH7MEYr20jvK8PlSX/G/8/NebYTFm
         dDinqFs6QTYHPxl/pPFsGic1r/K6dD3zTK6hXBcAdZ98Tq0rjgwztj3twtLj8p/p+3qP
         uCU6o5awzZJxqQh0WNsqT9EaC+Jhlo1OQZtoXUmw3UjIEsRfEUW2pwuwrDyN6Ho+guhy
         gzQkPsRjBj1lbTf89QHm/7bmtq+LzQVMpp7GuOjMJ+RMvMH3GDup/v2OA9qLSJ9dZBc3
         +iap3Qt/O5GEV0zLzETUCCC2ooGorLpgaAzhZ1sHZrFY15ehcI1SwvJgEDRNc9GbXc92
         wCbQ==
X-Gm-Message-State: AOJu0Yz+VNffODk/6xotyhmo1qV127pBL0NuJTN7Bb/0xlqAssSBrDy7
	nbfEQjBBrn8wu49rs3R3ClfNRatfwzO3k9P6hn6l7c6usOxs91Xr2nk2r2NRfQdX2Lw4qFC6670
	N/Yr0KZWhL5CaMUf+hRcK19Gkea8PsiQ9FUzoxxY4t0SiSvpSE1CalL+1
X-Received: by 2002:ac2:4850:0:b0:515:aca8:233 with SMTP id 16-20020ac24850000000b00515aca80233mr3990128lfy.15.1711535778880;
        Wed, 27 Mar 2024 03:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/1YlG0KyIzovm9MKsFwVixKSZvkkV0QgI9sTS8W5neKd/mOR4UjIkBWGVMhpL66SJai1Bgg==
X-Received: by 2002:ac2:4850:0:b0:515:aca8:233 with SMTP id 16-20020ac24850000000b00515aca80233mr3990111lfy.15.1711535778507;
        Wed, 27 Mar 2024 03:36:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ch12-20020a170906c2cc00b00a44180ab871sm5258891ejb.50.2024.03.27.03.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:36:18 -0700 (PDT)
Message-ID: <635d887f-2c3b-44dd-9aa5-3263fae880c5@redhat.com>
Date: Wed, 27 Mar 2024 11:36:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] power: supply: mm8013: fix "not charging"
 detection
Content-Language: en-US, nl
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-1-8ebb0a7c2409@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-1-8ebb0a7c2409@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/3/24 4:31 PM, Thomas Weißschuh wrote:
> The charge_behaviours property is meant as a control-knob that can be
> changed by the user.
> 
> Page 23 of [0] which documents the flag CHG_INH as follows:
> 
>   CHG_INH : Charge Inhibit      When the current is more than or equal to charge
>                                 threshold current,
>                                 charge inhibit temperature (upper/lower limit) ：1
>                                 charge permission temperature or the current is
>                                 less than charge threshold current ：0
> 
> So this is pure read-only information which is better represented as
> POWER_SUPPLY_STATUS_NOT_CHARGING.
> 
> [0] https://product.minebeamitsumi.com/en/product/category/ics/battery/fuel_gauge/parts/download/__icsFiles/afieldfile/2023/07/12/1_download_01_12.pdf
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/mm8013.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
> index caa272b03564..20c1651ca38e 100644
> --- a/drivers/power/supply/mm8013.c
> +++ b/drivers/power/supply/mm8013.c
> @@ -71,7 +71,6 @@ static int mm8013_checkdevice(struct mm8013_chip *chip)
>  
>  static enum power_supply_property mm8013_battery_props[] = {
>  	POWER_SUPPLY_PROP_CAPACITY,
> -	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
> @@ -103,16 +102,6 @@ static int mm8013_get_property(struct power_supply *psy,
>  
>  		val->intval = regval;
>  		break;
> -	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> -		ret = regmap_read(chip->regmap, REG_FLAGS, &regval);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (regval & MM8013_FLAG_CHG_INH)
> -			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> -		else
> -			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> -		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		ret = regmap_read(chip->regmap, REG_FULL_CHARGE_CAPACITY, &regval);
>  		if (ret < 0)
> @@ -187,6 +176,8 @@ static int mm8013_get_property(struct power_supply *psy,
>  
>  		if (regval & MM8013_FLAG_DSG)
>  			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (regval & MM8013_FLAG_CHG_INH)
> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		else if (regval & MM8013_FLAG_CHG)
>  			val->intval = POWER_SUPPLY_STATUS_CHARGING;
>  		else if (regval & MM8013_FLAG_FC)
> 


