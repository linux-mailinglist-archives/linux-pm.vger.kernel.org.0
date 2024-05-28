Return-Path: <linux-pm+bounces-8220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703F48D13F5
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 07:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99614B2101C
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 05:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A6F38DCC;
	Tue, 28 May 2024 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiHVdzww"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0B17E8FF;
	Tue, 28 May 2024 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874569; cv=none; b=N30g7RiLhUgiSJO/sIiKamlCa5HG6zScTgRr7EPJD/90TctOELgmxfQ0aYzPl1cIZDfeXnTQ8/R5jm7LhjS3U75H8gNW90kS503yu8N6Y2fxB1rrIXG7O6l/+sHP2eRYlK4fyeXVvqJpF8USzHx2BZb9qw9T03JeARxIC4WO9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874569; c=relaxed/simple;
	bh=nwW0zyqZWUJuD2uDG8iZdvx4hg2SDrpgyeNcNil+xZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y07KCDhY75i7RCOp3fm2kEMZmAQ3xQA0rMNUtF2QFEQfpsuc3+u2nzZ6yBw/MruZoI0ypsjwspkcXEwhDG2OC7vMyZ+wGMMat2Kv/V3iRKJxtKBu3Gv60q51tGt2QJtrvFw2VJswqL5+4MIS1gjzW8ruN7Uq9AP1ofxuEB9rXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiHVdzww; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5238fe0cfc9so377229e87.0;
        Mon, 27 May 2024 22:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716874566; x=1717479366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQ5YRsvHvoBAdRC3HVPp9qo9wscCEvcT4K5gwwVeDRU=;
        b=eiHVdzww+ixEe7ATEMmrma3m6/UHossdDPeCmuCYB+Qc25a7EB/CZSE16UpmvFwvjK
         w+gwOK2nR2Zb6mgpPRIWxiuT7gqMfasZ2gUUOekhNYJqdKvqmTgHfDkwu9sdjSinsNEE
         tpVdrKqtI+Qa3Kx6oN3LV+MsGYDwHuMnx2WHsVNRs20ud1wYL5oIbTN2+dGjlT+zcE9o
         XNcAQxfWOHQqbv709TbEQdBoOz5yc+A23iA7fKN7CHFmEy2opfJJrjoMp7NA47CfKjZh
         5ZOP3HyNIqu+GN5vGFGM4PHIgQIQibUUiCBtrOEvQbOGoA+duyJUS5aCC73sTh0h/ohf
         ppQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874566; x=1717479366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ5YRsvHvoBAdRC3HVPp9qo9wscCEvcT4K5gwwVeDRU=;
        b=hEQ3Yr1d2m65sZi1S5uoUw91E+mLMdMeWyA+cRVZ7LsOM6jBXmK5vV5A5MPi+URkBe
         xxiE4bfi8Xbes0BDvhc3e/hrC+QXDW6mJLm8VbWOU68pHHF2nXl1YYD0QcFB8+1gnjZm
         Nw45hdOKDaN4V2bJUOvum96GBPtNIEYa/2gMxMkgUNj6IMraSCH/nk5+GMOhOH6qx19y
         zTTt2YStZrwwr0OBokRtaE0BYVmupHfIUbCS6rf3XQac724XvmuBZf6MSvVOmVnhUbm6
         b6p5pBfJ5JeeDbTYVjWnbR8KTYkPYbmJMQAf0XSUieJHtb+AnOV2hxwwxnNieFKOkbOk
         VUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnOE68tZjsKsl0UtPvz/MuIj34NNgwhRVVmwY4nbYDfv5zXymPocYlbfrEYp2qWHTLhPS2WpxvJraKuanpOoKNtPidLtW6Ive0PCQj
X-Gm-Message-State: AOJu0Yxux6H0r2nnr8LWBwZ4DNvdIXnIg5vTNFmwXt/RZLRs4CaLud0B
	YVKMvCxrJqKUS1twIyfFel0MICpfXNtXm4zqHLCBb+u5B24UFaFYQ7DpsA==
X-Google-Smtp-Source: AGHT+IGReGPOSVoMpusxH7TfsFf0PJuifsnWkIwYw6r1iQmpNfbsbr4kIn1cZE8/HPAqNKOewGcz9A==
X-Received: by 2002:ac2:4d08:0:b0:51f:fdd3:b673 with SMTP id 2adb3069b0e04-527f15cc5a5mr4347094e87.34.1716874565894;
        Mon, 27 May 2024 22:36:05 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b730sm855379e87.134.2024.05.27.22.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 22:36:05 -0700 (PDT)
Message-ID: <d34509fa-09e7-4bb4-8d2a-0561e4b0ef26@gmail.com>
Date: Tue, 28 May 2024 08:36:03 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: supply: bd99954: remove unused struct
 'battery_data'
To: linux@treblig.org, linus.walleij@linaro.org, sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240528000634.196707-1-linux@treblig.org>
 <20240528000634.196707-2-linux@treblig.org>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240528000634.196707-2-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 03:06, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'battery_data' is unused since the original
> commit 0902f8366491 ("power: supply: Support ROHM bd99954 charger").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

> ---
>   drivers/power/supply/bd99954-charger.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/supply/bd99954-charger.c
> index 1ed1d9f99fb3..54bf88262510 100644
> --- a/drivers/power/supply/bd99954-charger.c
> +++ b/drivers/power/supply/bd99954-charger.c
> @@ -70,13 +70,6 @@
>   
>   #include "bd99954-charger.h"
>   
> -struct battery_data {
> -	u16 precharge_current;	/* Trickle-charge Current */
> -	u16 fc_reg_voltage;	/* Fast Charging Regulation Voltage */
> -	u16 voltage_min;
> -	u16 voltage_max;
> -};
> -
>   /* Initial field values, converted to initial register values */
>   struct bd9995x_init_data {
>   	u16 vsysreg_set;	/* VSYS Regulation Setting */

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


