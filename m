Return-Path: <linux-pm+bounces-11078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968E930A37
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 15:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C27281715
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 13:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C605F1369B0;
	Sun, 14 Jul 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MteoV7rC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA51311B5
	for <linux-pm@vger.kernel.org>; Sun, 14 Jul 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964380; cv=none; b=EDLIKPMnPuaoyzs8NnxSyEs1oqILBYtyD5H6aymzV1SlJSb6SqDe8TcBsx7C/wfu8/sM71I41qJdZk2a7s55DYZET+UNP5p5vDiD9+343uFV++rwdi1q8ecvvLCDuEPgXNtbQ90kccEe3WCYUavEShwOsjqb1Y5TWwF50t/GguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964380; c=relaxed/simple;
	bh=6MJHalS0sNrCA+xbhaPI6x2za5a/YVSdLA+2rmpP1o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFOuOvB+66coz7YXJMDmgQMX7FobHAlydBGqiOJdHw3dB32JXlH4qFZk0/yXHvttl1gmvRwfi5FLuEMJ10YNC1IEc7lswr/k5cgoT8jlygrGarQRS4fLmKgfK2E0nh97uoyt1+vwhYrAbEpJNZHsq+3gxqro1qp1UOWAkNWcUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MteoV7rC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4279c924ca7so19347565e9.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Jul 2024 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964377; x=1721569177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2hvoP8bymcjCbxd1ikVm85o7S/ITtdMUvn8D2WhS9U=;
        b=MteoV7rClLUfRgFs2GBjk9pvvw91GaJ/Tw/q7LnZXGR4Ex77WZrhD+tBSpe/TIVYS3
         pNEHBvM4YFZjzyoI+t6RcEtTRN942GPsGjo5tlo8XHj43Yhb7RU2AdBxQ1BoVzVIFaIv
         fUYT51xVDeD6KT9W9I0SrBkFVPOzbdosYiACIRBmExL1JJPq/8EoDBbevwYTd4I7s5LR
         QuRVTqVj93Ce0/z8yzanlmE+W9e78pMvzscJqUH0rwqMsNY3FLcVM8IgGejbntkVVbsq
         eqm08pGrhsPPoG2pbCaeEAfF2oeLzowZ5McWgYKDNWgYJHRHixXuUHvukCxCzVkoqZHm
         qdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964377; x=1721569177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2hvoP8bymcjCbxd1ikVm85o7S/ITtdMUvn8D2WhS9U=;
        b=dIa+K6NDfeHmVpmYqVN1u4tyCLsl5TAUYe9mM1SHR7wk8PEz6Bbq2MZ5meHUdXp5lr
         xyVs3eDLOpbq3OTwt0rT1WGuPFCloTke9iibZxUgaRtY72/SiOUAUYPiqi+3RcjzhXh2
         TcgcQ0E56UniUd7nxjzHIa/YZsd/ahfHN/+F51E3bYr5x0fBwqzUWPqqtgYPxGdbQ5MQ
         X7LXMTBBCuPFeFly2MC1vO5bduix/6LrwwhQpPuLavVUFZk7z6cd0smXDbp4ivVxj7j6
         V/tboDqYoQDp4XksDnpXOrb2KnAILR35xzyPs+Ed8dmwyy0EdeIDMXNL+kOFl6hiYdtJ
         MUQg==
X-Forwarded-Encrypted: i=1; AJvYcCWU8bqVmuHBCS3mtQ4PMc72KczJogUZZDVhmPBbaIn0/hwA2U9WpqzBl/GOcf4kwEG4deaTton+wePJxZeyPUrHvOlTdbfuDHI=
X-Gm-Message-State: AOJu0Yw6PggTOaBcTgu1l2I7HIt2aa4cz5ln2E72Sc7fn0eNRGTkDhPY
	4UcWKOC5/1uL+cKMC0O+UY9U8xEpOe+bIxa9G074PKreVSVqYFLSDjcMIHwZiFE=
X-Google-Smtp-Source: AGHT+IHOmqMftI8wjJ5esGhg3yKLJXkjcJ17Z7maulQQ2gwkEzP+a0iVJeuDAaXkcdChgxLz64Bcow==
X-Received: by 2002:a05:600c:3b12:b0:426:66fb:fcd6 with SMTP id 5b1f17b1804b1-426706c64b5mr95085065e9.3.1720964376615;
        Sun, 14 Jul 2024 06:39:36 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:39:36 -0700 (PDT)
Message-ID: <dafd938f-cdee-4348-b091-fe3ed8209d53@tuxon.dev>
Date: Sun, 14 Jul 2024 16:39:35 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/27] power: reset: at91-reset: add reset support for
 sam9x7 SoC
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>, sre@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102843.196257-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102843.196257-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:28, Varshini Rajendran wrote:
> Add power reset support for SAM9X7 SoC.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/power/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index fece990af4a7..e3ebebc1f80d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -26,7 +26,7 @@ config POWER_RESET_AT91_POWEROFF
>  config POWER_RESET_AT91_RESET
>  	tristate "Atmel AT91 reset driver"
>  	depends on ARCH_AT91
> -	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
> +	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
>  	help
>  	  This driver supports restart for Atmel AT91SAM9 and SAMA5
>  	  SoCs

