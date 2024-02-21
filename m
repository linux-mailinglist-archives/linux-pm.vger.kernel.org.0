Return-Path: <linux-pm+bounces-4187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25B385D630
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 11:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A22B23D7E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F515AB;
	Wed, 21 Feb 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMJkmLt9"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F653DB8C
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513144; cv=none; b=dAmmyFf4u+sX02iBh35uaE/knsCodWbh3Q46qbu9lw+0ZbALjcRwaEwsDcPJgLvx1Vzm2VVel5bQcU8/C7QP3E6lsWGmQMkzLs3QTPsmUJrr0juwxh22nHVRWfMnNWBwEhIL2iAgJz8w80jADp8RlUa05HWFm70OpJvYABwwpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513144; c=relaxed/simple;
	bh=G7OSjnvlvhdDNHjP4t7feNBdrTVLrFfjHjvN1J9+y6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmrg696ktub9Oe6vqXcOCH2FXYtesJYcmlkDQDTKlo7Ikrp2E7GQDvQF2aehC8ojdY2/t9WkSQGYZ+aIju4CHWbPZqQgPPhrL5rehVhUub6h3NwtJ/of9r6GSss0GkGyuIOFrmJDRkZ2lKXl9NHuuhsP38JogdyB5eKLG4Qgk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMJkmLt9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708513141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsMrcn3TX1/NhXlQOBo16vEmVmCSCoy6lQ+lGk3L1Dc=;
	b=RMJkmLt9vYP/dMPjqiN/kwU6M+ReHIiM6tMhktGiFjmHExQtPE7yoMlb12BpJDQWBRUyKn
	sci4e5qlESxHLRUT0sPJAWlKdbnaNnDPw+cXTXJzAXoFXO9zYKWY4pStk8qQqtryifAxgK
	xhnCUoyuBBDOlUkBIga+TkqD8tQHfnY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-ldavJj1cNT2NZe80C2gGYw-1; Wed, 21 Feb 2024 05:58:59 -0500
X-MC-Unique: ldavJj1cNT2NZe80C2gGYw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a30f9374db7so765518966b.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 02:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513138; x=1709117938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsMrcn3TX1/NhXlQOBo16vEmVmCSCoy6lQ+lGk3L1Dc=;
        b=S336TAfzPv9HVKheGODt9KSM+YVOMWRl1pNM9tuay29RzclwRGHN6B1DjHHCjzfGkf
         IL4KszJNvAa4XOJTuPqMvBJxReOJ0brf/sjBUVY/yS+KLelQ5/HJBeM7jTBC29n4prEF
         OY4Y5mxfEVky4ldBRLcWVrEdJHuPyJxlPiRFxboDHm8NVaIWWDvkrL/0KTVFng3jRPa3
         WoBsP3k6zSvuJ8/hdOWynNs9X/HfvQOkANAfk5LERXAot+5lBDY4RntzthCFfNg+WMAF
         PS/fcE3hxSM69trj9VcXjQLwz9wZhGfWHl7W3iogv7HSCbKWDodLz0Svz5R7Qytfhvif
         pPfQ==
X-Gm-Message-State: AOJu0YzEx9GnB9gzqJ6OfwVwOZTmEdwEMmPMFeRlLfEha9w0QKLU4ixu
	a5k5vS4Tpj8kWau1blmKMPO8bI6GigKhwjP8KKi3QSlRbzTOJw7NH5ccmHhU+sgUjPKAfUTW1Kl
	SWE5eLB4WF3vZoWyeaMrXRbupoHSidanmXyP7tlJhsU9cFJVOpkAqhZ+W
X-Received: by 2002:a17:906:4a10:b0:a3e:8bd8:b711 with SMTP id w16-20020a1709064a1000b00a3e8bd8b711mr7146603eju.37.1708513138458;
        Wed, 21 Feb 2024 02:58:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK1a2cdomFDrjjoZ8XtPSdsFu03O5jLPN2slHTxGMz5wOS9Wx03ZNO0HuPdz8bhuEeYFuJbg==
X-Received: by 2002:a17:906:4a10:b0:a3e:8bd8:b711 with SMTP id w16-20020a1709064a1000b00a3e8bd8b711mr7146591eju.37.1708513138125;
        Wed, 21 Feb 2024 02:58:58 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id rs6-20020a170907890600b00a3e48deecd4sm3942661ejc.222.2024.02.21.02.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 02:58:57 -0800 (PST)
Message-ID: <44d463e3-91f3-43c6-8c48-41cfb6ba1131@redhat.com>
Date: Wed, 21 Feb 2024 11:58:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Deny ROCK Pi X
To: Guoyi Zhang <kuoi@bioarchlinux.org>, sre@kernel.org, wens@csie.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240221083425.440108-1-kuoi@bioarchlinux.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240221083425.440108-1-kuoi@bioarchlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/21/24 09:34, Guoyi Zhang wrote:
> The ROCK Pi X is a single board computer without batteries using the
> AXP288 PMIC where the EFI code does not disable the charger part of 
> the PMIC causing us to report a discharging battery with a continuously
> consumed battery charge to userspace.
> 
> Add it to the deny-list to avoid the bogus battery status reporting.
> 
> Signed-off-by: Guoyi Zhang <kuoi@bioarchlinux.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/axp288_fuel_gauge.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index 3be6f3b10..8f67f5d0d 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -599,6 +599,14 @@ static const struct dmi_system_id axp288_quirks[] = {
>  		},
>  		.driver_data = NULL,
>  	},
> +	{
> +		/* Radxa ROCK Pi X Single Board Computer */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "ROCK Pi X"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Radxa"),
> +		},
> +		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
> +	},
>  	{
>  		/*
>  		 * Various Ace PC/Meegopad/MinisForum/Wintel Mini-PCs/HDMI-sticks


