Return-Path: <linux-pm+bounces-24428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F559A6CB8D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 17:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F1A3A82CD
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758C6233134;
	Sat, 22 Mar 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gK7Ju5lB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C08228C9D
	for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2025 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742662134; cv=none; b=K1j+mPMsvFyVRqnt00o/xs0bs1hLM4Cs330bRIdmhzTChN51syz66M9KMlEE/uuPAUxWaZ2vQVsAAHV5ppp0wGaggaGrhecPmwr0XPRyX7Z7DR+5iK4JDn2r+MXuXnZ+IYDbTdDd6zyeOM1N1OpD461U7Aw/NH+yCdpp1ME6/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742662134; c=relaxed/simple;
	bh=ilKLdO+D3DKL/L6xnctvKY9xHtbWegWhEkBTUTLsBII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWSDkTjrrgUrjq9N5wtJsx5v8dsSThR7xUpS0nItZ029nYpFECWYsOdH+iaQvTsQFu0Y5/WYkQLg4t0t9Qe68ipI1P8dHkAVs/CKMYP6Dq2BH+TFXDlFPzLVs5H1RHYQ1PUJCCRKs3CDvvfog323EKtBxH4aXCAM+3/uph1dYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gK7Ju5lB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913290f754so408431f8f.1
        for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2025 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742662130; x=1743266930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6xNd0llC71oEP5dO+YkYFkjDGY4TNNnT/LXyyySQQdI=;
        b=gK7Ju5lBIcRUSIAKEaXF8ObpuhHOxw4qgMm6ld74ICOiBBmeqxHcDG7QtJu0jJfhqd
         13XGDXpMaRz/zP68mXauV9YckVSxVrxZxGD2qdyMMnNePJsSiSUm/ozkLm200pUOI9GN
         INYU6CkWyR1luKhhCs28FV863bEj+xL9ManjWstDs60K4B+WlPYtAIM1DOBWaqT7z4p9
         yX7vPkxR02rBXm/88rAm4WIihkSJOMFClu4uWAZURdeW/qz0zszCIMzvrl/1Tr7wDJdv
         zjJk/UZwBBg+BKWDgXWStkwqpBMYzJ3+EHqZr99ThWo5XFPAR/jXE8DGYeiCd+VSr/BX
         4CgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742662130; x=1743266930;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xNd0llC71oEP5dO+YkYFkjDGY4TNNnT/LXyyySQQdI=;
        b=FWN4tTfauDu/Y/hfMkWmOtiBTtFybJT9bOgr9r2IFHqkigkTh9NVG0VlS2H8x2qQpN
         gthAUHPcyCPmwEH58e6bCytaHKheOGoUWxR0xPksuahZDcBaHm3GCbPb2G8Jbj69fbEv
         B0j1opbFopI1Ztrt9nylyMAeyd6Tz+shxz4/YaqeYBO63HyNN2HqI37P710ejSC42Yq0
         Q0A+apsUBjvLhmmq1Tm1N3MqQnIk6ty5IZQ/qcJoUaf61wTTzGM0JtRcKDbb0kJGB9N/
         c7XUqI5AO/8y5Pi5/OY16OCqun8ikb2HmJOq4Jy5jKBDpsupug2emKxR20XVAQr+s3dz
         WoKw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Q/kgmUgND3DyTWCL3bChOsEDctRVUqZxyP5zQMS5OqDW70kxB8lt4BdxCEEVONU+WBTMcPv6Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybNvInqoS8kMKT6ym4XSa79CXK5kAwap02ksFETGOW0XPiYudK
	BcS86yVXMwaK2unO+7hIF72/Bdl+CyRWph+qr3+wb4lH1euI+D8T6odvQ6JVtR8=
X-Gm-Gg: ASbGncsoH5X3Yv+rjq2Z5khiNZZLMM4vD2fEXZ/WeyU688cerld8MWzPdqbHaMhrehr
	wmXOMoCzqftiTxcEFaE5wvEW3IZzxbHpN2+fpm7H4zlqiRcxs0T6MkJ8Z9ZEcKK5DwTlV9ZKXsa
	zX38A/fthcb9LuVELejiQpXoRKR/fQ2Xdpjt2+9atkFFoLeNZHwMNCgi7B5Pf1UNY5KhaCWnZ3W
	VIumGJTAa460hFBiHsZybg12zHJsb3CkOijewIiUMrAwqI/JIz+aXxyHR9Ihh2+OOzAD/fDqX7/
	yuN+/iYbF1UV0mWts9SC4kWH9P6+wbr4rDYHL+7b7CYMfXpKGuc47uJrZXpTmHg=
X-Google-Smtp-Source: AGHT+IFUj2d07WLhxhUz5wMUXxLFUNTKUJDduvrDArOmD/C/JPJ4VD5gTOfUIQ9x1XQDS8u72+38Ng==
X-Received: by 2002:a05:600c:698e:b0:43d:2318:ed7f with SMTP id 5b1f17b1804b1-43d519b63bemr25616455e9.0.1742662129679;
        Sat, 22 Mar 2025 09:48:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd277d5sm61567425e9.19.2025.03.22.09.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 09:48:49 -0700 (PDT)
Message-ID: <9477218a-7dfd-41b9-904c-a1c90490b9c9@linaro.org>
Date: Sat, 22 Mar 2025 17:48:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: supply: max77705: Fix workqueue error handling
 in probe
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <547656e3-4a5f-4f2e-802b-4edcb7c576b0@stanley.mountain>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <547656e3-4a5f-4f2e-802b-4edcb7c576b0@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2025 15:34, Dan Carpenter wrote:
> The create_singlethread_workqueue() doesn't return error pointers, it
> returns NULL.  Also cleanup the workqueue on the error paths.
> 
> Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

