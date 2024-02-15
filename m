Return-Path: <linux-pm+bounces-3933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FC855C67
	for <lists+linux-pm@lfdr.de>; Thu, 15 Feb 2024 09:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AB4282DCB
	for <lists+linux-pm@lfdr.de>; Thu, 15 Feb 2024 08:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D69D12B87;
	Thu, 15 Feb 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKFW46LR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953243C17
	for <linux-pm@vger.kernel.org>; Thu, 15 Feb 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985475; cv=none; b=Sa/t0CaEbQY1FSGQsJFFYV1HW9ftaJCrtIHGXcsZey/sj+RAoBzn9vtEYHnqFSKMiVY0ttR2KlT347LwQynfqxNNP7Pf2G0u/nAT/ewHirdzJtxscJDN+oGXyUiQJQm4UDELeVfsb9dQJUN2vouWWZtFuaTPS0IjmMm50xov9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985475; c=relaxed/simple;
	bh=JTOBiJWWU0KworatiTOeaZJg4usH/4DIgmieEgaE/OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU0ANsRG85ufHSaxXvZCHsPM44k47S5E7ivyB78f5gf7nCtTeLzkw3n0vbwx/sMim7pNWi8fQbEaMREY84QSPHZz9TviLq5SNG51/WUwqhQqRk9PVyKlLe1PEU+NjoqbYZn5jA02KpuTWcrKpJEVoUDn36SGnR837xkyPE/kuic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fKFW46LR; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d208be133bso4182511fa.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Feb 2024 00:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707985472; x=1708590272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwCuIC1bMslsjIPl6aswFvbfP7zof/j/F7ZsomcVMLk=;
        b=fKFW46LR37Yd6ReqhnQPn+eVJ1FG9pDnt1xJKm2LgFuB6VR3mlYMFT88z6ttmn2BCg
         Ab0Gtiepp3SB227qJqrYGPfKsgOaBO0hbebLXwbb31Uk5gaVDFHe2QuiU4U/VETTzYMt
         BVCktLOeSRj95igJDuq5lRFa3+hamW6VxRlKPe60d0jFeDEC6O2CJbPe94q295lO6g2f
         LW11cA2S/rm8VKBcZ8P9vRZcHMNCD2IMWwdi+7h+mLuMvxrdlaCq2ne45LarE7zbZ/pl
         GB/BZ/hT+wvC1LEvV7qHElNbCO0KYKzTt0UygH/wX1uKSw3DV0CmK6QnPWgN+p1ro4MM
         p0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707985472; x=1708590272;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwCuIC1bMslsjIPl6aswFvbfP7zof/j/F7ZsomcVMLk=;
        b=q+3VXWMzj9SQOlD2VpibLfiVIXDFjZ4eYAQMYiy9JdjmbNd9LwoLA3JiVAXMA16rzr
         JKyu9eyjlb0HFoafzbQwHky6aB7rX1FI97l+jj3c9nLD1e3BBmLET082nQJ5tfCbr6qb
         +B0BOc16ZE8viPfWo65eXkcjtqpWKCjMhKQD9YKShRC81OV8Oo8Gvxbs7HKsIaZFKIpU
         ABN9yO+EcjHapFxfPrVOpZ4F3ZN//36vf1rk3o5lsD9tiF43yYMZoZ2yjSAItwLgR+OS
         73XY4nU+Ev02awdevz5+/i/d8PfWWPZctXn8XNP4YReGSmGLQv6NRgrdMY12oEhqDI3n
         /2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXFPaDNOuwfV8W8UBqw+OOLXCXU5S729MjEWKT2YJhfymhkHQc6EOc1dFd7a+KhoFJvUOQNNLeT2P7VSmmKdkBqwnaxQsnumrk=
X-Gm-Message-State: AOJu0YwBJuKkBx8BGgm20x0pJOwSeBLavofD2kKGzonRx+GtFkRozK9W
	KN1epWt9vVqhlOeVbRIuz8C/0oXu0ICV3vqtOfUTgKJwBaYavphu8tVwuvYiavo=
X-Google-Smtp-Source: AGHT+IE6enZKHEetYt2BoknyYKotecC09lJ6VlV4R8vJH7LAgGUI+luHWGj2Mc5FlULlra0QOfUxZA==
X-Received: by 2002:a2e:9b82:0:b0:2d0:d300:e482 with SMTP id z2-20020a2e9b82000000b002d0d300e482mr684818lji.20.1707985471845;
        Thu, 15 Feb 2024 00:24:31 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id f23-20020a2e9517000000b002d0f3c58e60sm177617ljh.117.2024.02.15.00.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 00:24:31 -0800 (PST)
Message-ID: <f010b72e-955f-4bb9-aad7-5cb9bb91502c@linaro.org>
Date: Thu, 15 Feb 2024 09:24:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-am625: Use nvmem-cells for opp
Content-Language: en-US
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240206145721.2418893-1-msp@baylibre.com>
 <20240206145721.2418893-4-msp@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240206145721.2418893-4-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 15:57, Markus Schneider-Pargmann wrote:
> Use nvmem cells referring to chip variant and speed grade for the
> operating points.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am625.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> index 4193c2b3eed6..d60e1be9eb89 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> @@ -105,6 +105,8 @@ a53_opp_table: opp-table {
>  		compatible = "operating-points-v2-ti-cpu";
>  		opp-shared;
>  		syscon = <&wkup_conf>;
> +		nvmem-cells = <&chip_variant>, <&chip_speed>;
> +		nvmem-cell-names = "chipvariant", "chipspeed";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof


