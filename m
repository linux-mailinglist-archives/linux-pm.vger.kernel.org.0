Return-Path: <linux-pm+bounces-8347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F968D3121
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 10:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0D1293312
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 08:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE016C6A0;
	Wed, 29 May 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yMEtW+84"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707916D1AB
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970986; cv=none; b=lkFeWl1PRj5tzn08mDN5f7jILTV59s1HhNhG7s5UVyy7t+Ota8GJf3hAWtYMw6IkoV+fIWJ9X3Yf9wHqFEm/r8ZHAwgpsleS4/emHwjQkgodyE887ghEl2xYUqYB6TTZy8Ce9+k6aNvde0+9X9gxkiyNYL1QSNSV34ACZU0hYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970986; c=relaxed/simple;
	bh=v1feN2NUrI9P5EUMAciZLEbJjEX1j1A38in4ikzn1wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAx0rvs1RV1F2vq4eThamYIhEGv+WkV697mtmj92vfuECLQMaU2CUNvBto9Lw3WggtYyc1km031p8Gz2YdvUrYXCz6G8V0Rm/Kg5Ahq7G7PYBfANukLE5Au+bdHmJVdbxLnpT1h7G03xViRAyVmGNeV+0N2lTeBX/Q+KGfqY/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yMEtW+84; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420180b59b7so15435035e9.0
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716970982; x=1717575782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cyv9PovJHSSHJvMucpyIOkl77eWjr0heW5XICt5+8X4=;
        b=yMEtW+84oVmUaG2flLfTP6tMxeq92w9NNWMWzXdcsTo3boft9KnTjJLGGBehofyIVH
         iDsH5jdVccdpz3WE14xGFcR6GYZCRutEckW4YUjTCSaNAiDtWKB/utXN4Rg3WXDJeeNP
         mCa0cPB4skWZV4YCTVNR2GmUNHwT6Qidv0E/sQkkjTO0WgCSKQbo+jmKaerx7z6a5Cac
         wN8j4h/yF/3dOAM88hwLoAQZo3a1KigQv3vdrRqpIEJd7PfT1pWuVn3NdpJeh3cVDxuW
         ONW/kejCX0nkzRl3MAwWPVEC61lY6M8/y2PNl3t83SfCDWM/CmXO1zR8HHZeM9n/V8NR
         cJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970982; x=1717575782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cyv9PovJHSSHJvMucpyIOkl77eWjr0heW5XICt5+8X4=;
        b=W2eKxpdGbXHqCrucxqMZf20HRDcLX3kiyDHhWq7Wqaogdnuf24+R1+Dmi62jkZgwvS
         ADzLIhVeVoIrKiPjKakh3I7xtJNMLyDkOGTIjKyznztSDKh1omm3kf8uo5lE3uCwAdQA
         0VS/uJR6c9wzxrxgT2cjko2pGa98M5day4SyOROf50kS6gTrXC7E2YNMxP6i5pTdqd5F
         ohfNEyx+vVPkWTG5pcmdSTfwh+sE9X58mAe8jIr/th7PEfFzuZ+IwCUA13syIw4tall7
         GdC26wmYlOu6/XRD2Slldj583w+xzKntlAR/RRbeGqjl8t3vADXDogkDnAYiQZl9QkRH
         a+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpqjj3mZB6q5fyAfhh+1hO2TMsTFKUh+YL2EKF0lbHqNzbcrb8PvGT35CBgyh5SU+jB/cEiNwHyn5+FKf/1F5tZpTI/D7y6rI=
X-Gm-Message-State: AOJu0Yzbg43DeFcmRIVxQOJOojWrqbbd7cF0eQc99vw/mgclJ5fI/Iy/
	3XrHzUjU6cp1y2fhlpjVMkrXhbV2LF9qZJ05+WtJA72FXWQvxWUzFbsM+37odY0=
X-Google-Smtp-Source: AGHT+IH+woaE6GlA+cs5xDP5OfdceRBKfbkhD/cWJbIr1gI4V+CXAq4EQPV6Kc26S2O+apzzp1XHog==
X-Received: by 2002:a05:600c:474f:b0:421:10e4:7f6b with SMTP id 5b1f17b1804b1-42110e47fd9mr78062025e9.27.1716970981790;
        Wed, 29 May 2024 01:23:01 -0700 (PDT)
Received: from [10.1.5.19] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3582917b222sm9606959f8f.93.2024.05.29.01.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 01:23:00 -0700 (PDT)
Message-ID: <1c83bd93-92b3-4986-a154-69ae792e57ba@baylibre.com>
Date: Wed, 29 May 2024 10:23:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] thermal: Add support of multi sensors to
 thermal_core
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, rafael@kernel.org,
 daniel.lezcano@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240524143150.610949-1-abailon@baylibre.com>
 <20240524143150.610949-3-abailon@baylibre.com>
 <834e18c7-21b6-400e-aa61-a4f591027620@linaro.org>
Content-Language: en-US
From: Alexandre Bailon <abailon@baylibre.com>
In-Reply-To: <834e18c7-21b6-400e-aa61-a4f591027620@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/27/24 09:00, Krzysztof Kozlowski wrote:
> On 24/05/2024 16:31, Alexandre Bailon wrote:
>> This adds support of multi sensors to thermal.
>> Currently, this only support the get_temp operation.
>> This returns an average temperature of all the sensors.
>> If defined, a coefficient is applied to the value read from the sensor
>> before computing the average.
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>   drivers/thermal/Makefile        |   1 +
>>   drivers/thermal/thermal_core.h  |  15 ++
>>   drivers/thermal/thermal_multi.c | 332 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/thermal.h    |   5 +
>>   4 files changed, 353 insertions(+)
>>   create mode 100644 drivers/thermal/thermal_multi.c
> 
> This does not really build...
Sorry for that. I have not rebased and tested my patches on the latest 
master commit. I will be more careful for the V4.

Best regards,
Alexandre
> 
> 
> ../drivers/thermal/thermal_multi.c:249:38: error: initialization of ‘struct thermal_trip *’ from incompatible pointer type ‘struct thermal_trip_desc *’ [-Werror=incompatible-pointer-types]
> 
> Best regards,
> Krzysztof
> 

