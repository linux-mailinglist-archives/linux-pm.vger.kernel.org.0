Return-Path: <linux-pm+bounces-21792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A37A3067E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 09:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AAF16096B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDE31F0E39;
	Tue, 11 Feb 2025 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ipt3mM2B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C401F03F1
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264136; cv=none; b=N+3rEVMPxAA456GaDB+OtzGH1ZUMC7YvTvLcuzB/NoIDGv+vqlvCNosSY6rRZKOAfFIBYIkMbD/8BeZQ1h3igKPnSJwByJV8ujvUXXZUQKKL3gAiGtELE3iGvk4bdiw+nm1VOrXG5o5SssruBoO9dP3fYQhSnYbUGmjIyDA3z5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264136; c=relaxed/simple;
	bh=so3608nuzu2Z4wPWCdEL2Kh4q3DiMgLd3JHw50uJwm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VpqI/J65FUIDgzRN8X+JlPo9sAvtkXP5gy1s+Ukpo8NlFuH4iGv0BizO4exfFPIDF6kKYrlz0oilS+gnxWnY1MmQN3IhhcAYDOO+5r9GfZslQt25RKghRqDsUGvU0mJ6L8OF7BvVZhZH/+XGuEuOFUNFTZA2zL/cnF1TwwpgEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ipt3mM2B; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dd14c99c3so1744034f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 00:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739264133; x=1739868933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ATS9kH3JOXqCDIar73OnrkF9ilRSB+64NK3pHta400=;
        b=Ipt3mM2BzfG8lgSS2kohFvQxHtDPdXzQ2CpG+8Igq/BwRimRwi9w2TdVQwBbOeIy6Y
         oRAbXfvKqfNB3noJUdnOCxO01Rk34EM6tzSDhbrHkXANNvpx8hYEbGI/2Z9n6ZuRL3HG
         keuAlx4Nr/UzoGmyiK+Dc6GUu4SzzkloKAYHomVTVzGYZavF+S1pqqj/bQf+3wrh+NTR
         9MwfN0kdza2HsFy1jzBD1bvpB4eUqqvdw/yamDgg3igrDsHgyYBT285oI3c+fY5uiEEf
         XGBuMeKysdiRYtyHvbgvTY4S3DSvxQeEaOSTKZEdO3vLV6AyM1TiQt+LEip1B7cxsY5u
         ychA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739264133; x=1739868933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ATS9kH3JOXqCDIar73OnrkF9ilRSB+64NK3pHta400=;
        b=ZsZCwxUv9hd5zfhJc0ZeVxQ8YDWkBN5gL74UCwYRYHF6+frrEXG5FIEWSYN5Ox83qr
         miCxpD9vRjvZSz031vs1AjaryHUxIn3+n+HmXM7TG/cs1tASm3Q9MsvhQt8ECVid7W+a
         21hyFUFXShwefOPHgccWbuoSWjS9eN1lubw+DZLPwXQbGBs7IhCOpdtQ3yIzOdg9xPag
         Mvzpbc3VcIxTGutbn5i/fOef6QAhsojd+rjdYzltPq9GC6Ob4GpFh62bIdSNGlo74s2X
         bKxBN6R2VFDbjcqhROiwkgFergzu0v2KKIgQKjQGisYHDoDMSPaVcqA2LiHQ9kiOSIRM
         q9/A==
X-Forwarded-Encrypted: i=1; AJvYcCX3+scMD3kMLEvYoWeXX63v6n+L3l9Ke9k8q2iICoUjr0YhkiA32Ux+kxrc2nqZTgieu0CIRAFW5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2yKhYwq4TGiY9wr4E2idvwdSDwEodkrb9ycSwLHZLXazy8xjw
	Lht62aNPNwk1ELffTbEJMZm+LTKyYKJHDli4bScT+UF6liM+1x2A8vvfevsJNIQ=
X-Gm-Gg: ASbGncsDyyXyBdFJI4BQtbyTein6xT0b31q2aflQ0WpMfyEddyIC5EdmatdfUx8o3Ny
	Agbw8SDNoweofHDg3fOM00VPTz3C89nGh+iyepm30wISIuN4S53rR252/QF0UnjMVrugDV08o4i
	8wco1Czn7ikj7Ue7jUTmu1svpkArwIdPy1nMDJAJaolpAO739dLUCdmvIq/xYaZgayFyUaZ2WE7
	aPDQknP5gB3Ky4nvzy/8I7F040m81Fi17QBDkZbJaD/eGvelVvpGqX8Zuo8v2yzN64+yh+O4xKJ
	d8MAPYg3Db4FcG4zpqgOnvJOwMLJhDfqQRnxM1yUuYz+LSivjBpbjcU=
X-Google-Smtp-Source: AGHT+IGlpUgTYtIiheMDAuizrYUdnfwTiXvy3+Z24hKU84ausw4miBggLrIYHvGUHbl0rw2KWztuoA==
X-Received: by 2002:a05:6000:1865:b0:385:e105:d884 with SMTP id ffacd0b85a97d-38dc9371e85mr13413888f8f.46.1739264132995;
        Tue, 11 Feb 2025 00:55:32 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38dd187360asm9452225f8f.43.2025.02.11.00.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 00:55:32 -0800 (PST)
Message-ID: <bdd94f9c-e751-4a16-848c-bb83cf1be569@linaro.org>
Date: Tue, 11 Feb 2025 09:55:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: Correct indentation and style in
 DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20250107131027.246608-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250107131027.246608-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/01/2025 14:10, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks

   -- D.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

