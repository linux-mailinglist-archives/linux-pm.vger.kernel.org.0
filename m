Return-Path: <linux-pm+bounces-31746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC94B17FD4
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33DAA84267
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EB723644D;
	Fri,  1 Aug 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/49zNGn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3BE23536A
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042353; cv=none; b=pddjvS8lrPq0PIwP/ftnfdwaI8PHQTwgNkUn5EIze4nXnrCwoTRCQsBEy/KvuymNU81Vi+Ojc9JorH0U03t1AnQ8NzHpP9WrWuWY0VWsfDA/uWUnBi1aeOBC4+2YKYWsChUfSrRswvFePz3egYP06qMJRqJdwvBOtYDGJ6Mkg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042353; c=relaxed/simple;
	bh=6eCKSkwbpp+zEQC42TKus4PT6JVQvtzMaXWZQ1EfffM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mO7Nw+b2zH99K8zHfCdm57qltW8ADwmwtvSY67qp5oNR89d2oAkXxEnV7AOTdypzSS2074uWRWU6C3UDcVllTnEAVTosZrl8UbeWKz6iDocuU3UUn61O8oUAxEtt1zo3J+wUs4gCxm3Vv/nWslgWZwU0aG9CF7pdABoCDz8j23E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y/49zNGn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4563a57f947so11416555e9.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754042350; x=1754647150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAtNeeeBqfLUn+sT5Zk3U+6nRAWdfcW1/7E65kHu/Ac=;
        b=y/49zNGnEHlMIDKhiGfxqyFgeETBooiruqg9vstFK8Pt98RiitTuiNOBdhDiQ59q5n
         bxJ2xtd3hFdoAS9qRMyXV3ZU6yMIzDVI8UxrriseuNn52sP8Bq+KFMF5Bs9YxpwsMl8s
         c2ygALQjtvV4VLQTI/qm9SezyKj0xTWkVtDaYrFpGSMrcNCTaRqk6SrkSF7z5HjgrW74
         AwnAUbqgq/e7ISZrPdWeeIheHCbTFG4kEjHSzP42tBkVBpNvZ3D0Q3+MdFYV58+yfPIO
         5ga3TVbffqI6Ni6VPoJcf2PidUdJJe4aRg/AKNUAidJNDCMY2bNaRozFPtKI2537a50A
         gMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754042350; x=1754647150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAtNeeeBqfLUn+sT5Zk3U+6nRAWdfcW1/7E65kHu/Ac=;
        b=TaiXTSLDRYo/9ANL4Ovvgka4v45pu3CnP8JU7lcwA+o7gTiZIFrrQVYa82UgDnRVqb
         vKdvWiwbjIte+HHTrE7/fhpGYcPayCRNjXLICcNi6i7IrkCx89XrvbhLONjA7YmrjIAt
         mhgaAr/UE7oCQDokKhwW8zfNRSVfu6MK+dbtkHL9ts1Z3fuwPjcWO/WA7AMiqGtCLG5L
         gbgcvb+dWJobBtNQMMUB6frsemJPdFttYA958QGUs7AJsJNofVqKTecnrL74nzIXvvNL
         r8MF4Sy+B3Vz7QNBzj5JDcYPns2eAoKpSJv6uUswTvcuIv4jkiiKQBuqNO0ee8xKft82
         lROg==
X-Forwarded-Encrypted: i=1; AJvYcCU8aWUtzZE1lHalA14O/SukkpQIUTW4RtuweeMKPSrG+EwJQ3bd5MEYy5L3rIpbGXkZbNszmCz+vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymB2gJv+eETiwgTl6ZOXd9hu0sTSbeA+Sqrl6CbzIiNxQonSSu
	PlK0OP8bfjct2Rjiv8fC/lEREFb3HT8QSRD2Qq71id7xRMGHl2Fx6GwZEf6oSs7dLNo=
X-Gm-Gg: ASbGncs3Ex75pEbG4v5qGiCk/irIB+sIa2zg4jiKp+WTken5tBC+mnuWHXgIaAH9BIj
	YIJSTd6k+Ojo+Om8vr9qmU1crkE5j9mZIgiKi21Vm77vrxL1f+ppEf7/Axm2168BlrLYmPz6q5O
	HWJgVbTruEJa/nbgpBJxpGr7LLs/CRJNP3WFkTKdo22uoepXDf9nuMBg2nsvz4ZRJ8wEkmYJVH5
	22f/yKuCg7++UqJg6nS4zJ/HjaMIkrBe/dmRT+irJWUPBgxpvJCNo0uK4PX6ISZuWtqnjtn3lc0
	2XzYWl3npFLIT1TlQ97MalzNw8QYzNdgJxErnuS42O9p8gSyQzy6Zw49C9k3XKbJUODHoME/Qab
	0zI8WIaGtInqoJLvk5qYnZQ60mYGg3vKlTg9MED9JvByL992sXABKPC8TBZ588w==
X-Google-Smtp-Source: AGHT+IGSIhoRFdnMjpT8FEPv6ZdYsjdDrc9HAxmDYufhad1DYvy2LtbioIaodCfl4mJzruqCYZ3X7g==
X-Received: by 2002:a05:6000:2c06:b0:3b7:7909:5b22 with SMTP id ffacd0b85a97d-3b79d43e4e4mr5658620f8f.8.1754042350328;
        Fri, 01 Aug 2025 02:59:10 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c453ca1sm5374537f8f.48.2025.08.01.02.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 02:59:09 -0700 (PDT)
Message-ID: <86f5260f-6625-4e2d-88a8-013143922fb9@linaro.org>
Date: Fri, 1 Aug 2025 11:59:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3: Add support for per-SoC
 default trim values
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pm@vger.kernel.org
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
References: <20250625181739.28391-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250625181739.28391-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/06/2025 20:16, Marek Vasut wrote:
> The Working Sample R-Car SoCs may not yet have thermal sensor trimming
> values programmed into fuses, those fuses are blank instead. For such
> SoCs, the driver includes fallback trimming values. Those values are
> currently applied to all SoCs which use this driver.
> 
> Introduce support for per-SoC fallback trimming values in preparation
> for SoCs which do not use these current trimming values. No functional
> change is intended here.
> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

