Return-Path: <linux-pm+bounces-4294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30858601EB
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 19:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A3328E781
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D5954906;
	Thu, 22 Feb 2024 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbhIOVaB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97472548FF
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627457; cv=none; b=gn787m1D/e392zR8YCXOAZL0zHU3BjMZp3z2V8Tm1sS7u9hZsVDE09q5Q+0M3bCwhKnMHa/9znpv04cgPcIUiQaJnLDxy4dT+7g2xQnEbKn9OOZNvJBZSSO4au9QXeF8bnr405wdWlAlf5wwtL6AV93BcBBy32npAsmPpQkM64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627457; c=relaxed/simple;
	bh=1Tw8s+DClYHUogHJhbrGvBp/2kXGIQUYNPE/2LdOkdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUwohnEx/aS1OyOigk/oLPP5ZuuStf4GGzLcjYBi523AzoAIUY3cpCf5UqQVWmHSSL89I14roDtl1KAV0IePX1IUuZbnGWZfugpDv2vORSwd6IfqDHbLPxrfHRnl5oeTuCcvOs7dhVS5WBh8NxP5vAOWUUe41JznOI8TDoqPoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KbhIOVaB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3392b045e0aso27095f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 10:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708627454; x=1709232254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBKdIE0MqGxWNqgnCMzfW9UY12c2Cp9wReUt3CTynV8=;
        b=KbhIOVaBac+9oUYHkmSxMGjrcMjQiwDvEZECITafVGqAv0wOyszb/cTgtVgUY78cR1
         gqJYOxIqu927WOOIJFUGH8a68EY45JoBPal0UOdMLXcG6QraQcZntKvTz/KyMj2gisdJ
         0qiqTjGS/SA5wfv/FyyrJH2jlU2lSAyBCMLHhOnY6s5Xxe0J5AQDuKfQPEHtgp390Am6
         WVhfFlAOXmhZoQiiu9zjLdCitR+62MIOcliVQRkdsGZEOL70OPKLmAF3mFLtcZ60swzj
         0Ez/vJywihsjcJiM1o3YV7+c4+2/LTRDY/m2tnyIJMJZ5o1SI9fSBToQXrQOYqGhm2GS
         UIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708627454; x=1709232254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBKdIE0MqGxWNqgnCMzfW9UY12c2Cp9wReUt3CTynV8=;
        b=WDNCSWquv2RCFQGqlNYg0Z9VCK1jrINR256ChZkKIdtBc+jjSbmthS+Nis/rF3NIOA
         9AjSKeC2UkUwPT5PGiHrX7xKaWoRER3tKgvjpop641k8CLlHPU9Mk2Hr7EFrVPc8/QCF
         uGVlMzbmlYIHcu1aXj2m7BsEt4VTVAYU9igbgQ2TiJnyNp5q2VkoFiDNXW5AdqBmU5XW
         F14JcvVTFWiDD8YtZXF2nBU9Bpf4EGg+ERez2EVgel/br4mE/00xPdeOygkRNuygV484
         zQkopoZBed+NBgsuszyPe0PFisO1fiWTBjHukTt2E9rup17U74VfX0LYH/FtSTzz3AB2
         A6dA==
X-Forwarded-Encrypted: i=1; AJvYcCWyjv/6EoQQV+RU5+vKAU8N/va3KYe2XE3GN2amjwvtoomnfI66Z4HjcB6Gk1PQJ4dqjfZkhFYMiLi9U/od0cKDPEU/We0k7Gw=
X-Gm-Message-State: AOJu0YxzT8CUrf9j39vgXgp4U7PMKLuJVR5Wtzk1qWy2IwEH8PCFBpFt
	JOBMnOnlZiax/Pk3VCzSH72WsIIwuRUp5hDNF5Hnep7VLYTurCet7bzS9lgl57o=
X-Google-Smtp-Source: AGHT+IGFxuTSliDPqku8YICfE8X0xSWjseqmFo4felniOL36LbKB9BcJX2RKD9QRRp8hCWOrEoiodQ==
X-Received: by 2002:a5d:448f:0:b0:33d:35ef:ac2e with SMTP id j15-20020a5d448f000000b0033d35efac2emr15938wrq.17.1708627454014;
        Thu, 22 Feb 2024 10:44:14 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k3-20020a056000004300b0033b79d385f6sm21179398wrx.47.2024.02.22.10.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 10:44:13 -0800 (PST)
Message-ID: <dcd115fd-dc38-4f48-8485-9e4d64f53b4a@linaro.org>
Date: Thu, 22 Feb 2024 19:44:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] soc: sunxi: sram: export register 0 for THS on
 H616
Content-Language: en-US
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Maksim Kiselev <bigunclemax@gmail.com>, Bob McChesney
 <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20240219153639.179814-1-andre.przywara@arm.com>
 <20240219153639.179814-2-andre.przywara@arm.com>
 <2717467.mvXUDI8C0e@jernej-laptop>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2717467.mvXUDI8C0e@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 19:26, Jernej Škrabec wrote:
> Dne ponedeljek, 19. februar 2024 ob 16:36:33 CET je Andre Przywara napisal(a):
>> The Allwinner H616 SoC contains a mysterious bit at register offset 0x0
>> in the SRAM control block. If bit 16 is set (the reset value), the
>> temperature readings of the THS are way off, leading to reports about
>> 200C, at normal ambient temperatures. Clearing this bits brings the
>> reported values down to the expected values.
>> The BSP code clears this bit in firmware (U-Boot), and has an explicit
>> comment about this, but offers no real explanation.
>>
>> Experiments in U-Boot show that register 0x0 has no effect on the SRAM C
>> visibility: all tested bit settings still allow full read and write
>> access by the CPU to the whole of SRAM C. Only bit 24 of the register at
>> offset 0x4 makes all of SRAM C inaccessible by the CPU. So modelling
>> the THS switch functionality as an SRAM region would not reflect reality.
>>
>> Since we should not rely on firmware settings, allow other code (the THS
>> driver) to access this register, by exporting it through the already
>> existing regmap. This mimics what we already do for the LDO control and
>> the EMAC register.
>>
>> To avoid concurrent accesses to the same register at the same time, by
>> the SRAM switch code and the regmap code, use the same lock to protect
>> the access. The regmap subsystem allows to use an existing lock, so we
>> just need to hook in there.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> I guess this one goes through sunxi tree, right?

I'll pick this patch along with the patch 2-6, so through the thermal 
tree. The patch 7/7 will go indeed via the sunxi tree


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


