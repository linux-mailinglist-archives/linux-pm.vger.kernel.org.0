Return-Path: <linux-pm+bounces-40982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E6D2EA8D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1BCA3048ED8
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4872E1758;
	Fri, 16 Jan 2026 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPaj2LfF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74053332EA7
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555109; cv=none; b=rVUAwi7o3MglO+JgVEaG4AwJ0eOwJc32aAh25MO4igoQQl1507Zxs2N1aE2me/59fqPP5WmNJw9Q4q09OOYYutUgyaZdiZLI8SC+Gmu4bnnvOHbHVC31l8nXFZLw2gP+ZtMUnYEQITfNy6xETErc/LmcvDsN11MEyVeoO2DhX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555109; c=relaxed/simple;
	bh=AghABfkarHqDZQKCjjyiZmDcR7FwtgnGUdqMcOQ//v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsA9RF8QHXjg9BdZ2EfoR/sY9su1pMAj8BLAaMRvifnXR1R7D4CdtjiA//bce64N9XZm3Fad7i4QmD6ZQAMcnbc0nLmPVfqSwpv/pJBnR7XAlh2Xg11OViVWnBDQy91aLjxJNrg7JVJ8ydk329Uk800tFCILFuii4ft7Rkt2Vu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pPaj2LfF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so9729815e9.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 01:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768555106; x=1769159906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+AGXRtrMXkyrXKzRmoE9z026WTEqpV4D7gQD8MxXK4=;
        b=pPaj2LfFQNsV88/GHrQq8j7NyFSfU/ZTDN+4B8nBIYcZJrzTPueWLPTs/Q0d1gyv/c
         HgdMyYHx8FLjkpzE2hY7VFzLJSKVDHDMSNa42+8Y919PDLXNcAJOOW8jrU9NM0z0c5o4
         FvXWiuzEtD6EjoYC+U1BUyQPd2te4/iiWI43aai+IbYvMOYO+ii4DcpPGFqhWUo0fx9J
         DnAqW2ZeVyRho43aCwDPZrtXkPsUdcW9XHNnm1R00tYWW5jJmTzPJCvJa72QG84mYyvV
         424yZJ8tX3V5N/hjMCH0pRxE0qZ9m/edSu5OLEXRJ7UNVcViOY4YPedEMQW7eEoyWAG9
         2mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768555106; x=1769159906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+AGXRtrMXkyrXKzRmoE9z026WTEqpV4D7gQD8MxXK4=;
        b=fTilhxNwByB2V/hIuzb178PUV8fpVDsM0djmsnUIrwFs7eOxyjNyiCsmfQcoHdtan/
         A1Nwgsvrdapn/BNx04naIUTeRDIQfQyG1SnD5mioZFFlvgscWqsvse7Unr4xZb1xZ+af
         BDto4FOCLdHWLB0yN47/NV7mk31sDbm5cCJcR0BKdUnpDS8VjkWcU+WDc9QBkorWIGT+
         MImXxf09XKev2f1ZCQ+/SWeAiXgOvcEvqHxBy0BKWfgqOFdVKboulQdiK+WYtZoAx6JM
         UPc1xnDrHNpUed2J+gSi0v/dfY0c5vbjln6hHGVm6wShXLV0mrwm5l1wGRalbu2gyf0h
         3lOg==
X-Forwarded-Encrypted: i=1; AJvYcCVcYeXLsmiBaHvL8uS/dqERoX6I9/5kpvszBdO/M6VYLiFHxztDwqlNv6DCprEg3Ky0IRWeKIbpfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmMGXwXBP1xS/GZcSCIJ+9g8krF6z8rLiEnbRQlbfudzQHAyA
	s2CXS9QhPNvxPeAIhPzPU7Vrz/j0L1mhBzi18RaMQvc8N0wDu0p5VV/IEtlVj48J4Ic=
X-Gm-Gg: AY/fxX7veqTGuLe7H4Mev0aO4ZYvPkbkDl5+sIBEeQUMtZD997lTeuwrhKTBFaXJtd1
	R/I/2f9x1y0ASHHp3pl/Ir+3o2CyyLBNYJibo6H0kw51tZNn/VismAR33LLalj3imbOWRrSZfAH
	VNqaFLHtk8OLOrF6RiZ9Eegoxea0S0UDWtXWzfzdr6jw13JXcFSIW+rl3b9ybUvFvgIJfsm33p5
	+THX+2HIBOAX7Fv4jcFDePhuErZaKVxwGXNj57t/Ge5qiYvdLybPWE3cRz60Kpsr7CoLtBm+PXY
	g+tPnkNM+CTa8lLnmiNHR6RtcwmNtQk0qpEuRMEPe+/Hu7+TnpZ/bEyTuc90lkg8hudQWbkXfI4
	JsctZXt2fCuvVgPAH9Wm/772d4lzUFjRkjUcq7nBfGi4fs4VKvwdTsuxS+QNmBVKJYl7iRApKmN
	6b+/B5JFa796xe7U/SXA==
X-Received: by 2002:a05:600c:6209:b0:477:641a:1402 with SMTP id 5b1f17b1804b1-48023ea2fc7mr6725565e9.4.1768555105706;
        Fri, 16 Jan 2026 01:18:25 -0800 (PST)
Received: from [10.11.12.107] ([86.127.43.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071besm87551575e9.10.2026.01.16.01.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 01:18:25 -0800 (PST)
Message-ID: <d3dedf5e-ada3-4d33-b1a5-7556ba80ffb1@linaro.org>
Date: Fri, 16 Jan 2026 11:18:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] dt-bindings: mfd: Add Google GS101 TMU Syscon
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, willmcvicker@google.com,
 jyescas@google.com, shin.son@samsung.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
 <20260114-acpm-tmu-v1-3-cfe56d93e90f@linaro.org>
 <20260115-slim-denim-potoo-cad9cb@quoll>
 <200d34bf-150e-4f8a-b400-2f54863502ac@linaro.org>
 <e2f028d6-774f-4773-889f-7d56b833067e@kernel.org>
 <fcc5405e-189d-4195-8db0-3acf35bbc0a9@linaro.org>
 <26d86470-aaa2-46e3-9940-010a903df4fd@linaro.org>
 <0176a63a-6b04-4e30-b718-847133882050@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <0176a63a-6b04-4e30-b718-847133882050@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/16/26 11:14 AM, Krzysztof Kozlowski wrote:
> On 16/01/2026 09:50, Tudor Ambarus wrote:
>>
>> Because of the hybrid approach I'm arguing the ACPM child node does not
>> fully describe the hardware, and it's just a firmware abstraction.
>> So option 2/ would be to have just the TMU IP block described with a
>> phandle to the ACPM IPC:
>>
>> soc: soc@0 {
>>     tmu@100a0000 {
>>         compatible = "google,gs101-tmu-top";
>>         reg = <0x100a0000 0x800>;
>>         clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
>>         interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
>>         
>>         /* The "Firmware Phandle" approach */
>>         samsung,acpm-ipc = <&acpm_ipc>;
>>         
>>         #thermal-sensor-cells = <1>;
> 
> Yes, this one, I think it's the best representation.

I was leaning towards this as well. Thank you! I'll start reworking the
patches.

Cheers,
ta


