Return-Path: <linux-pm+bounces-5644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB58917D7
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 12:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65E11F22D9D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 11:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A9D6A35D;
	Fri, 29 Mar 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLM/mEpy"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE26A013
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711966; cv=none; b=oP1glcWI5KyjtL1hVpCPUjUXAWELn3EpsoymZh0dn1wWp1J5g6EkOTtK0lT/6VpFuRFVUazfKgI5oQatth3XDsPAe1yjYCVNs93MUGZaqNmdsV+uOrk3pxBn3gs7nKe8IqZMJ2Em9ClkI0PD2M8WifGsvQhQqBOuzXZkD+wvmS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711966; c=relaxed/simple;
	bh=YiuwKN8qhFuIAOgDB7+gvuNvcRqxhHIJg2+GdaxoSzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKkGI7UzxocB+vMO+OWyB4tp4AdzFszCyzVkFg1bNh42eSkyeE7JACG2rIJ5tHORTrP65nFfCHkNcY+41mi3mkf4t1ym+H82oHfyU/QxjZyvkY+LqAXhQs+t7d3skMdmYH++XNb/5V/BXT8H/SzoO8HyG9uf9qJM7i1A02YJcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLM/mEpy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711711962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4oBdGOgnjp9VHMYVc4RnnPVdgFa9XSj8SazzjSXu5g=;
	b=DLM/mEpya/26JiHcH6U/YmmgitmHElRwEPKsyEBU2EVp30uyOUYalHF0Z/fWWZHivLvUBE
	a1rfu9mm/f1SgdqKIAuZ/SjeLblT2rAD624lguOEwLKtqWUeo3bU+ukl/hVW4TtsZqM98h
	XInxiJapZMlV3k7liscR1ttwbQyzCAg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-xjZIgiOhNNS_Cl9d3aiEYw-1; Fri, 29 Mar 2024 07:32:40 -0400
X-MC-Unique: xjZIgiOhNNS_Cl9d3aiEYw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a45acc7f07cso113803866b.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 04:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711959; x=1712316759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4oBdGOgnjp9VHMYVc4RnnPVdgFa9XSj8SazzjSXu5g=;
        b=oIo77QCx7Zxywmt7CvdvB2KbCG67IoaDNI3Zdsxjh+lQC295NVYWqpi2xLFsYn1x7W
         TtZsb834qrhB7SMt5eOes+L/6PTTpCcahv1Or6fUrQlla92Bhr0cwZYzGFL2NIqKyENL
         Rb3m1ZjUASVALgnH3yDXa1zLgYhbzTVgU5Pz46lvhSf2XasqIyYaz5Qr3+qTQAZFpH1i
         VXONm4zcjIUvFn6iywfn16Ft9/hlJn5AyJB6e245bvuzOp9tgEG+YxSfP5rEavLEf7XT
         NJlbXgFJdFjk4NXQmEF9mTA91lfMs/umRaNO/nF5MZcwBHcJT7VHz28/jRms3NhVVgRD
         5O0g==
X-Forwarded-Encrypted: i=1; AJvYcCXBHVwKG2wTRvIPRH9ShgcETei0WIGvmvsyZ2rkwsx75nEyEi7kS6WLv30Cii4fI4Dn44vAVQSUTJFL1R2g2lYBF5RBbIx7WaE=
X-Gm-Message-State: AOJu0Yy8heMD0vveomoibb54JoGZR7Lx51kM956uAjUl/BwjI1567zUd
	q8d6TvgVDpw0G512NzYHx2//4Ney8l9kdyQjviaz9ecahbCxipncJBU6e9+kCoyGpSiA+bAGVRB
	gLiukXJ6nZwglamxInayiK7Em0s7Ycj+OykiSU6bQZj7gbrmUsEo3oxn1
X-Received: by 2002:a17:906:e0c4:b0:a4e:359e:a03e with SMTP id gl4-20020a170906e0c400b00a4e359ea03emr918552ejb.71.1711711959052;
        Fri, 29 Mar 2024 04:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER87D3bzG0neKDu29z4yu8LMxlAbCl6f3aOgE1ToOp8JlQHq1fhlVNJsW8s36yFAEfLW/eDA==
X-Received: by 2002:a17:906:e0c4:b0:a4e:359e:a03e with SMTP id gl4-20020a170906e0c400b00a4e359ea03emr918545ejb.71.1711711958715;
        Fri, 29 Mar 2024 04:32:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m16-20020a170906581000b00a4a3807929esm1823908ejq.119.2024.03.29.04.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 04:32:38 -0700 (PDT)
Message-ID: <f3d9a568-8953-4fce-9fef-5fe1539fb91a@redhat.com>
Date: Fri, 29 Mar 2024 12:32:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: core: simplify charge_behaviour formatting
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329-power-supply-simplify-v1-1-416f1002739f@weissschuh.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240329-power-supply-simplify-v1-1-416f1002739f@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/29/24 9:18 AM, Thomas Weißschuh wrote:
> The function power_supply_show_charge_behaviour() is not needed and can
> be removed completely.
> Removing the function also saves a spurious read of the property from
> the driver on each call.
> 
> The convulted logic was a leftover from an earlier patch revision.
> Some restructuring made this cleanup possible.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Link: https://lore.kernel.org/all/9e035ae4-cb07-4f84-8336-1a0050855bea@redhat.com/
> Fixes: 4e61f1e9d58f ("power: supply: core: fix charge_behaviour formatting")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/power_supply_sysfs.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 0d2c3724d0bc..b86e11bdc07e 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -271,23 +271,6 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
>  	return count;
>  }
>  
> -static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> -						  struct power_supply *psy,
> -						  union power_supply_propval *value,
> -						  char *buf)
> -{
> -	int ret;
> -
> -	ret = power_supply_get_property(psy,
> -					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> -					value);
> -	if (ret < 0)
> -		return ret;
> -
> -	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
> -						  value->intval, buf);
> -}
> -
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf) {
> @@ -321,7 +304,8 @@ static ssize_t power_supply_show_property(struct device *dev,
>  						&value, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> -		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);
> +		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
> +							 value.intval, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret = sysfs_emit(buf, "%s\n", value.strval);
> 
> ---
> base-commit: 070c1470ae24317e7b19bd3882b300b6d69922a4
> change-id: 20240329-power-supply-simplify-5722806eefdd
> 
> Best regards,


