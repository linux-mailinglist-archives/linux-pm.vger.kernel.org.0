Return-Path: <linux-pm+bounces-5488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C588DB64
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 11:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BCB290C22
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90C28DC8;
	Wed, 27 Mar 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvgIX9tr"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EC1F606
	for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536199; cv=none; b=W7LscLRrdlb1SKcq+SkFS7UaNFIZc2BDzx02weAuNiuKMDgjF7bzzSWucniegjxhuTmtRrrC6XyE5R+h5cE0zgXT1N1cz0IiG8lsCZv0DMUquLNEgOX2Y2aGWRlzfTus2L1yrF4naFVc7tLuMz+L7LNN4tVRIvs2ahfEl9v40mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536199; c=relaxed/simple;
	bh=7MAZ1oJYx2he2O/U2IQ1vXCKiFiHly3gLB+lXSIflb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wood0ci2M2cY3R9wl1hy6MmTu4+qmzFa4j20geTsbwX1BIHI5fcVihP8zdmg2XofcX/SCULA/su3wz5Yy6ES+66NPHWt/Ec2j2HCggCGkHKFstjHWIQ+iC6D1dQQun5rU0CjIVPPeMdNMxSkzgv6yv95Y9vSVz1fWgSWqzniwG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvgIX9tr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711536196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFsd9d7Gos7i1/b5V+OTo42Y7I+kMeOk7bouc9bj640=;
	b=YvgIX9trGJ5NKFfjxNs6erKKxsvlt2xISwf3AElcUOuoAL+tgdekolCuM12aoJJhCxKiOG
	LXAG27d9xM16wq8ouCurA16pcEaGAnYroYsiacn9S1TDbaKFnSX7avIusz6BlASDCKOMNK
	Hl9fUUUkljKAR9Sptv2WhVyeCKQnCSc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-ECYXLbeUPrG1TFr0uSS44Q-1; Wed, 27 Mar 2024 06:43:15 -0400
X-MC-Unique: ECYXLbeUPrG1TFr0uSS44Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a46d59152c9so481570966b.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 03:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711536194; x=1712140994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFsd9d7Gos7i1/b5V+OTo42Y7I+kMeOk7bouc9bj640=;
        b=R/ml4lUz5H2+w6bLlriJSMRWAr3GkEkjg7uiM8NW5jkdod9oEbCe8TQu9MIpQRrD1a
         CjhiSOEvicu75yTZ6egDmUqZtVj5nQnMFTX31/Y92WcT9iUQ7zas1SZrc8zYIrOhN5RQ
         fkhTSrsQOf+oogMv+XEM+6d2Unl+JLfALjGhKtiDJgyhpntGsN7qz8u2UWlv43gHiI7G
         c7iSBOFL8KGuoq8v/xFd/vqpYyY3xw0TiYcNRFIp1u+n9zahSeqo0K/jW2jb8Aic0rqI
         EpBv4SOYZQcJcR6+8yyyJzhZKwlrK3TbJKAkqbtxC0jkf1t5U5nvGMdpP0m0mNZT/T/j
         474A==
X-Gm-Message-State: AOJu0Yyxk60RcA7tcIpnUhDKB8p+gO4su9Kw/qRYjus8A0atLScbBDVi
	4dU/1zaWXDGDcnlq/pHfK0Wla4BXPIMt4FblcojG2/ktSXSROV10ptL9fDORhwV/EZtkC2EBGRZ
	ZWC+eQsjLT7sOCx0DAytzWmOyuOHhCunxpi8uzq2cdrgniyRxG8XqT9qx
X-Received: by 2002:a17:906:b310:b0:a4d:ff60:23e with SMTP id n16-20020a170906b31000b00a4dff60023emr1355418ejz.11.1711536194208;
        Wed, 27 Mar 2024 03:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/F3TWm576rM7znpuR1Ur2IS4OPqOiCggxfDxScn/bJpxRgIpLeOjAepMa+WykCQOkbHV5jA==
X-Received: by 2002:a17:906:b310:b0:a4d:ff60:23e with SMTP id n16-20020a170906b31000b00a4dff60023emr1355408ejz.11.1711536193870;
        Wed, 27 Mar 2024 03:43:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090663d100b00a468bcde79bsm5311110ejk.109.2024.03.27.03.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:43:13 -0700 (PDT)
Message-ID: <9e035ae4-cb07-4f84-8336-1a0050855bea@redhat.com>
Date: Wed, 27 Mar 2024 11:43:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] power: supply: core: fix charge_behaviour
 formatting
Content-Language: en-US, nl
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-3-8ebb0a7c2409@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-3-8ebb0a7c2409@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 3/3/24 4:31 PM, Thomas Weißschuh wrote:
> This property is documented to have a special format which exposes all
> available behaviours and the currently active one at the same time.
> For this special format some helpers are provided.
> 
> However the default property logic in power_supply_sysfs.c is not using
> the helper and the default logic only prints the currently active
> behaviour.
> 
> Adjust power_supply_sysfs.c to follow the documented format.
> 
> There are currently two in-tree drivers exposing charge behaviours:
> thinkpad_acpi and mm8013.
> thinkpad_acpi is not affected by the change, as it directly uses the
> helpers and does not use the power_supply_sysfs.c logic.
> 
> As mm8013 does not set implement desc->charge_behaviours.
> the new logic will preserve the simple output format in this case.

Since patch 1/3 now drops the charge behaviours from mm8013 I believe
these 2 paragraphs should be replaced with:

"""
thinkpad_acpi. is the only in-tree drivers currently exposing charge
behaviours. thinkpad_acpi is not affected by the change, as it directly
uses the helpers and does not use the power_supply_sysfs.c logic.
"""

> Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/power/supply/power_supply_sysfs.c | 20 ++++++++++++++++++++
>  include/linux/power_supply.h              |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 10fec411794b..a20aa0156b0a 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -271,6 +271,23 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> +						  struct power_supply *psy,
> +						  union power_supply_propval *value,
> +						  char *buf)
> +{
> +	int ret;
> +
> +	ret = power_supply_get_property(psy,
> +					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +					value);
> +	if (ret < 0)
> +		return ret;

power_supply_show_property() has already called power_supply_get_property()
before calling this, so this call can be dropped. At which point
power_supply_show_charge_behaviour() becomes just a wrapper around
power_supply_charge_behaviour_show() and thus can be dropped itself.

And then ... (continued below).

> +
> +	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
> +						  value->intval, buf);
> +}
> +
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf) {
> @@ -303,6 +320,9 @@ static ssize_t power_supply_show_property(struct device *dev,
>  		ret = power_supply_show_usb_type(dev, psy->desc,
>  						&value, buf);
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);

replace this line with:

		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
							 value.intval, buf);

Making this patch a nice simple patch :)

Regards,

Hans




> +		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret = sysfs_emit(buf, "%s\n", value.strval);
>  		break;
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index c0992a77feea..a50ee69503bf 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -242,6 +242,7 @@ struct power_supply_config {
>  struct power_supply_desc {
>  	const char *name;
>  	enum power_supply_type type;
> +	u8 charge_behaviours;
>  	const enum power_supply_usb_type *usb_types;
>  	size_t num_usb_types;
>  	const enum power_supply_property *properties;
> 


