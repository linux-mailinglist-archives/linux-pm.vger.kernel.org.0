Return-Path: <linux-pm+bounces-8869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27D4902215
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68971C21D4B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E368E824A0;
	Mon, 10 Jun 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRpGkcha"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC982480
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024007; cv=none; b=XuUjVME8MyOoJImXujOINbIj8DXkjTFHTwarAR+AiVapMuCmb8yhKDc3hlx+PxmA4VHgbRRY5MAiBu9oLWFWHN/+NuDFbuQlhOWB32KqUnuYHYceFsCE+vENDJS1guOLGy+BvaZMpqSs83IhIUhN211iytzozmwoK5fYRbybSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024007; c=relaxed/simple;
	bh=3gSu77CRbLsL3fT1BOSMsE50OrS2gq/tfB2PvP6bqCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbzrprH0O0PoWZXhtSlwMajT1svngf5zjRV57p1LhVY/G2pbJ2jlRg1ziY1Ez0RxHD6X49cTwuMPNCeTIU9MiZCxJ+yWOaDlG8H0X5nmLiPn5pwwDmR06ihy3cSWmDxEqztzG4vAuu33//Iygjo+rWH92dnkk0nhWqFvoCXTIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LRpGkcha; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so221252466b.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718024003; x=1718628803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5NiCgiH6tBNSxYszNsKgKYfhtybdeOGmeeP1kQW09hQ=;
        b=LRpGkcha1AFRZBMeDvwvL7PB8mnei7CihLqhvgmSGGhbMgJPWdYtJsL0fOMiV+p8ie
         gld6Jiyz37d1dxi81b4sIi9kVssn5k7IhLEN6LryFSS+Es4BoTc1E2vSi+Aistjr1QB7
         BPlF68ow2UFosU7+3iZygNkebCX+QsPIvwC7tQ83rqREC9DhW5B4y13Gomq872fTDhMs
         4D23JkXSrtvFXZzcTH5Eo1sHwgTBHOh3V1jOBHofxVCWdKr8A46Jtjttnr4i8ZEhRsRB
         g46Dghuv+LwPIG//dh6LivQroWzu3dR75cF6yPRt9mOYGv28F2cTa1QYBgCkNs+Qp2sj
         TaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718024003; x=1718628803;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NiCgiH6tBNSxYszNsKgKYfhtybdeOGmeeP1kQW09hQ=;
        b=k9tr1guVvruI7JAc1gjBHBWAkHUv8+wFox7cv1g0V/SZzdEWxgHFAgpRwF+pem8pJM
         evpj22XSCTl+AvLp6X/Qoq58Ifdq4cESRMqyk+UrvuoJvHCnHkKXArS22q1uMS7APHOu
         val6NSZkTHmfXWj2DNa4RSIfC2bH3MMyBWPDcQwzny4jJjCh7I6+YXzXAheigHy0LSke
         PdgARHf9dlTT0xb/Hc/5NAcFe8Wk3CwEWb7jAnJM4VT+KxHwnEw1/senvjfOb12JBYNg
         ShpKuO/I7PGtY61KCmImJ+ZTieN1nZpxztUf3pBb1D7ERSB3UPdZ+tRkAtFYN8X12nmL
         Tw8w==
X-Forwarded-Encrypted: i=1; AJvYcCUSvuqlyKf5gFXlQAyAszOiz0A85XWL5yP57tveH+Jo7vVzf3iameLKxIDdSq1jyJv3MdsDVvnky94TtqOzwUhVVfetKYCL57U=
X-Gm-Message-State: AOJu0Yy5yHEPWkDewCnqgzIy86N3PNLtVmDkF+DpweVMHc0kLRqJ8VYN
	a9C7DZXWF/STAYysbb5iu2vZXI4SLGdmIqvp3L9BUmK70TrM6P6+v3jq8e2clV0=
X-Google-Smtp-Source: AGHT+IE/QKq54GmhJHswFQw6alZwfSU4pn7FjD4NnagLVPYnJZe9TvKyRUacV/yT8D2HaVUT30Yfeg==
X-Received: by 2002:a17:906:2b98:b0:a6f:11c9:f349 with SMTP id a640c23a62f3a-a6f11c9f539mr245521066b.23.1718024003135;
        Mon, 10 Jun 2024 05:53:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1f148bebsm134026266b.62.2024.06.10.05.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 05:53:22 -0700 (PDT)
Message-ID: <831dc04b-d257-4c99-9645-7aa18e3b764b@linaro.org>
Date: Mon, 10 Jun 2024 14:53:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] dt-bindings: interconnect: Add Qualcomm MSM8937 DT
 bindings
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
 <20240609182112.13032-4-a39.skl@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240609182112.13032-4-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2024 20:20, Adam Skladowski wrote:
> Add bindings for Qualcomm MSM8937 Network-On-Chip interconnect devices.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

Since I expect resend, all trivial nits from patch #1 apply here as well.

> ---
>  .../bindings/interconnect/qcom,msm8937.yaml   | 81 ++++++++++++++++
>  .../dt-bindings/interconnect/qcom,msm8937.h   | 93 +++++++++++++++++++
>  2 files changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
> new file mode 100644
> index 000000000000..39a1ca441bb2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8937.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8937 Network-On-Chip interconnect
> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>
> +
> +description: |
> +  The Qualcomm MSM8937 interconnect providers support adjusting the
> +  bandwidth requirements between the various NoC fabrics.
> +
> +allOf:
> +  - $ref: qcom,rpm-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8937-bimc
> +      - qcom,msm8937-pcnoc
> +      - qcom,msm8937-snoc
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  '^interconnect-[a-z0-9\-]+$':
> +    type: object
> +    $ref: qcom,rpm-common.yaml#
> +    description:
> +      The interconnect providers do not have a separate QoS register space,
> +      but share parent's space.
> +
> +    allOf:
> +      - $ref: qcom,rpm-common.yaml#
> +
> +    properties:
> +      compatible:
> +        const: qcom,msm8937-snoc-mm
> +
> +    required:
> +      - compatible
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +    #include <dt-bindings/interconnect/qcom,rpm-icc.h>
> +
> +    bimc: interconnect@400000 {
> +        compatible = "qcom,msm8937-bimc";
> +        reg = <0x00400000 0x5a000>;
> +        #interconnect-cells = <2>;
> +    };

Drop node

> +
> +    pcnoc: interconnect@500000 {
> +        compatible = "qcom,msm8937-pcnoc";
> +        reg = <0x00500000 0x13080>;
> +        #interconnect-cells = <2>;
> +    };

Drop node

> +



Best regards,
Krzysztof


