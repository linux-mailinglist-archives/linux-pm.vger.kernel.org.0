Return-Path: <linux-pm+bounces-16375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 793869AE446
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 13:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84F01C2154F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 11:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0033F1D2B21;
	Thu, 24 Oct 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAlEuUI3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E971D1E72
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771083; cv=none; b=ie4mO/ANPqBqpJd1yPvJ8QCO85XFXwfmRIvWZ8MAY518zV23MqP4JHpxAUSCANVqZK2t6+XZ/IUB+LP/liATwu2J4np5Lw/iBUK5VBisJ1h80japRaBQyoN4JItd1z85l4FmTG3OJD8U0kfwfOGobHmTI3rTGSkXXy9MBFEBfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771083; c=relaxed/simple;
	bh=TMwKFmIXmqzS5x4W1yplBkSZ7GLBkQ+WVVyIQYanxFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HF3EIEmugHrXDZQ8L20CAjihhgmMtx3u3DUEvTaM34LKw54IesrEcZ48xcxV1RjcH1gSbukokKZqA0VJ/NRzD9TRdQeYtLalye4x/xV8xN1zBWlR1sS/zvN6zsXOzZa2AE4H1f3PB0GfwR9UMX/36nTLMCAdA9KWP6tOUD3dQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAlEuUI3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d50fad249so577785f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729771080; x=1730375880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMUh089hk0TDYl3i02fhUTGpVWWZ8Xi7jhCcIpeuQK4=;
        b=CAlEuUI3V7QKOaG9Qzp+wOZsa7Z7cPB9yx/+o4/ID6JRyop2mG29Vv2drIhKy5uRNr
         D/BCIyhiBpccj3qIViCuMdBRX5dA/JXI2qAUCviRGSAvlzwdUvDJA5i/m1atS+L8Lptm
         E0YkxtKj7ORgVuWkRodKMc/MyK1/PAwKkmTTi7lXQKL0w4IVPN2yLvyiy1AVKtt92Qj3
         M/Q90Bd6bjIWKOCrRa9hZgBvl3K0cO1qpzKxicky5wXqYRRBVsVqvt59K+PBwSLZMXJJ
         Almt1l5t3MZFNhdhvIcCZqknYZgWEn2+69hanW/LQWH6tVduUq3k6aM48MYZ1gqvXWAd
         qQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771080; x=1730375880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMUh089hk0TDYl3i02fhUTGpVWWZ8Xi7jhCcIpeuQK4=;
        b=gAjVAU16qeZF9aBO/oJTr+lkYxMtynm8IIiwW1ZaJkskjmMb8/btD1JdkmFrRu2fRP
         83WvSZiE05kXkzeeL8YnwSXQkw/zLtFhFW+nka+ZUlWR0Pwcp8L32WGSUlgcMnTnu5ia
         onighheOwK2ceCoqwdmkdCo13qQcCGkyP23zAw+JCI8b+J/nKatromElaKKlMvrTH352
         zzfvu7ZaclAq57kOtdk1hGsW6pZz28yD1QtXk35U4xZon98CfcR0VtgZgE5nPSJqIc+f
         r3NxLNiMJA8nnaXIDv7oYC2Icsw46KJHxwx/Quu118+5YijgDUv6kzwElB4VP9zx88fK
         QEvw==
X-Forwarded-Encrypted: i=1; AJvYcCVOue0rPee/DjomKbBwV2yfbnDVEz1E4ThvY1YH1mV/iJNpi4cl7WKUIV5QF2AAdoZSjh8akwXHEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JRT4AxaEReoIQga8HvW2gIEOpa2KumTlSmnv9+pAKd2wur6O
	XTWoOsB39zcxrAuC/vCmAIbsW69bWNpp2A5fwYpuZR1izl5hIDuRhVRm+ImU79c=
X-Google-Smtp-Source: AGHT+IHwlD/N8thxGFMjsqeo2hByECDuXyX4BJqwX5km4H1c7VJRNHwwg6KxA9EAfXdb3TGB+VJIYQ==
X-Received: by 2002:adf:e848:0:b0:37d:398f:44f9 with SMTP id ffacd0b85a97d-38045898b4emr1354687f8f.32.1729771079896;
        Thu, 24 Oct 2024 04:57:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b4dsm11109750f8f.18.2024.10.24.04.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 04:57:59 -0700 (PDT)
Message-ID: <d7a2ddee-42c5-415f-8b7f-b7c21aa373a4@linaro.org>
Date: Thu, 24 Oct 2024 13:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/lib/thermal: Rm thermal.h soft link.
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240912045031.18426-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240912045031.18426-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/09/2024 06:50, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Run "make -C tools thermal" can create a soft link
> for thermal.h in tools/include/uapi/linux.
> Just rm it when make clean.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

