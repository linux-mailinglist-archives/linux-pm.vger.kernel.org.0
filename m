Return-Path: <linux-pm+bounces-8871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB992902224
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A152846C1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37A81728;
	Mon, 10 Jun 2024 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJ9yMHim"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4EC80C07
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024244; cv=none; b=XtqB2WApYpT6iQJYKzHdw3a61IjGjblgKgaiMLS6RnTz1zJ8qBxNjbBrGy47HcQheoc4bDSgU/H+uBz77gRB38hOx4PzlKldnOZ26HtDensvO0JJ21DAo3nmjXeMMzPYaXmF4A0FXKA2tmZATzFchSMFbBFyjz5Ze+ayWQiFVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024244; c=relaxed/simple;
	bh=yg1xPoHNtnIUumoATGu6LmkAR1aS+hHVXOLPzoPOgE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/Trv0RHLABELcU6ucv7D1L22iH7DIoCXVkJfI3QrYLTeWXDrCNDmZCy+3rJUhIPjI2hwFc/EaIjY97MDhnotSi1bbvbNTTX37v2f4INqzOEjr+YcGXAehm5FWDI3jNJut5Tzu+/6/t5wCCLhUp6X2FnSOMS5hTVQE0bQznTKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dJ9yMHim; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso6447873a12.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718024241; x=1718629041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P4YW+LJlPWVCF1oCUQwCJYAu8LrhPqKFR1EwKZrTF2U=;
        b=dJ9yMHimpc8YQQPWERTOEtoAoO84Fw2Qy1c+fN8TAZVg3dbFaws20GjVQ/6p4U2d8l
         GsgueHSdLfP4HFNSVKcdkYpqdVwwjyAMPBiCCKoFt71lfhI3rSfnDUEWtP7J72dbpI+/
         8SKZUOHa7JI6u6UDzyLDbBoJ0YvPcJhxi86XJm2ZXLM6QMVgZbsR/SS6XL6gRwxl82Pe
         10coWBnbHn5Oy7WRXcMqxkDw/jpuAUVLf7dVEvV0afbGFAaRJiDx6WEnW7Eyhxi+7f6k
         XCDIEZ5+rHZptr9VOE1RzrGi+GQnBDUGd+51KGFTHw6kPxtaFJM628tIGN8QnVMxvL7e
         kDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718024241; x=1718629041;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4YW+LJlPWVCF1oCUQwCJYAu8LrhPqKFR1EwKZrTF2U=;
        b=pGb5zGSQzZHETpSAGAPQM4Xc5Xyncyl+V1kA8gyll2HNBMOz1VpyjOhEQxFwnKTzkv
         x8qOXQGwBYyg+0q5iqdFemGFBnP+sz+iPOaD5PPt+buqW53mF3DYh7/I2pgti5eyXBRS
         rbCBMUebO9OGRF76qRR9+jTm3hXoNq0zikC+6qfx2LU9rfcqy0vtxdKES0ELH0HH60Kt
         SUNzPqXW3ivHjw6+KvoHpBN7LoEJ9qAuHTnoslLieYnHsWaH+O1jO/DT409eeu0bS/sB
         4nUtY4hG35edx/bFK4wncM9scUGy4rEqu4ZjgxEPS7UUOTc2WBCIgb8uaTuIZiNegNvE
         SZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh0G5MTXSUhjs1y/YesxPmxQeSv0dJ8lGPiAyZLeadNc8sFwWs2eY5YwZMs3awqmc8ZL18U9p1jz/DvWDgw9jElCvcDAO2lV8=
X-Gm-Message-State: AOJu0Yy5sTtziagIoG1iuK2QJEGMqeODDOYr582csBNIYYR8jp2ofmyw
	2cKlAQRJOJvj2ZHEA4NnFUOBevzV1kCFSqkYRs+FqBbMPIPD2YNIBCSD2j65f/A=
X-Google-Smtp-Source: AGHT+IG+FeCeTet+g006PrNx4Oxxdd0ygI0KsztkfpC9VYROLRJPSKBsn/ij3w2B7yqDBKHzj0cmyg==
X-Received: by 2002:a05:6402:b7b:b0:57c:735f:3967 with SMTP id 4fb4d7f45d1cf-57c735f3978mr2686598a12.8.1718024240999;
        Mon, 10 Jun 2024 05:57:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c8f3a0c33sm87824a12.82.2024.06.10.05.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 05:57:20 -0700 (PDT)
Message-ID: <08822480-a909-4724-9250-e7286d5ce90a@linaro.org>
Date: Mon, 10 Jun 2024 14:57:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] dt-bindings: interconnect: qcom: msm8939: Fix example
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240609182112.13032-1-a39.skl@gmail.com>
 <20240609182112.13032-8-a39.skl@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240609182112.13032-8-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2024 20:21, Adam Skladowski wrote:
> For now example list snoc_mm as children of bimc which is obviously
> not valid, change example and include rest of nocs in it.
> 
> Fixes: 462baaf4c628 ("dt-bindings: interconnect: qcom: Fix and separate out MSM8939")
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../bindings/interconnect/qcom,msm8939.yaml   | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
> index fd15ab5014fb..a77e6aa2fbee 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
> @@ -56,19 +56,25 @@ examples:
>    - |
>      #include <dt-bindings/clock/qcom,rpmcc.h>
>  
> -    snoc: interconnect@580000 {
> -        compatible = "qcom,msm8939-snoc";
> -        reg = <0x00580000 0x14000>;
> -        #interconnect-cells = <1>;
> -    };
> -
>      bimc: interconnect@400000 {
>          compatible = "qcom,msm8939-bimc";
>          reg = <0x00400000 0x62000>;
> -        #interconnect-cells = <1>;
> +        #interconnect-cells = <2>;
> +    };
> +
> +    pcnoc: interconnect@500000 {
> +        compatible = "qcom,msm8939-pcnoc";
> +        reg = <0x00500000 0x11000>;
> +        #interconnect-cells = <2>;
> +    };

Don't grow the examples.

It is enough to have one example to validate the schema and show how the
binding is used. If schema covers multiple combinations of devices and
their properties, then more than one example seems reasonable. This is
not the case. All of this is redundant... and redundant information is
not good because as this commit shows it leads to something which people
think is not correct and they find bugs. So just drop the redundant
information.

Keep only one, correct example.

Best regards,
Krzysztof


