Return-Path: <linux-pm+bounces-8867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ED09021FC
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A7B1F22BC6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC2811E6;
	Mon, 10 Jun 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7Xp9v3Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6ED80C1F
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023846; cv=none; b=rNMZYT4bZSYZtzM2MImMg08Iy0xZN+z7Ycm/5ecdV66BdBZ6e/iyqZMwLiHxGFHN7+7DM0O4fmvOSa0qvqf/Q3RD4epOKv44jg61udWvHka+0sQ8ropHPr2jk8+1RsfcWiCgsySwf2Rg9xrliNxy9KOIdzkowIlbd2oftSGGOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023846; c=relaxed/simple;
	bh=tNmWhx9bghGx/gPDCgODHzV1BqZ/8YYV5lSZvnnr/Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3Blk6L61QhOc3R49f2eDUb0yKgNSOP9RJbCWZ584+eN2Etie4zAHtjJUp+mZCRf5uX1K/ekkk9IRGc7wPwZOLA//wmRvSr3vcx51nTGZ6VpNS6aHC3UqGpcRt4MZq/2qXkFwzh/6e9KFjmIK5DjARHkLo622CHl3hxJK09LikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G7Xp9v3Z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421757d217aso24188585e9.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718023843; x=1718628643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WVQZfuaSODSe/detgoN35rqBdnOZD2OV4kbOzoLbpBk=;
        b=G7Xp9v3ZkpTSXWhpMpFryLFr+v6VXvo2Odki/jmZaJogkG57qcHrZKOVcSOfs7luJU
         s8wwwD21IT8FbJL9mYEYgRC7U543MJJ5ZB7xwfegUCsVxWNxAFYpERs5pkPmSztEJNwS
         hIuT4hnJEjcLbSoMue5YFobVjTRVspB2xSCRnKDCddCOey0ESwXFADALfecVXnJJnjGD
         bRFhXMpl2nhpFJNVwSNvXR/MRQaTeHy+TIMdpfrNvuixCdLUHr9CKVUyVxZOXB+MizXr
         K9daXO7nDLlLFPxMzdL1ALVbnuEANapZkgdSu90CO0Sp5giW+vlzyrBcZZiKkiY4pfy0
         lHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023843; x=1718628643;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVQZfuaSODSe/detgoN35rqBdnOZD2OV4kbOzoLbpBk=;
        b=J67F3wLIl+gH/9RYy5uNhqQjbybgsrVmJ75uxAzTU1SNYirxCkAixeGETjfH/w2r8h
         93gmKdOe0004UgZk/v+olh3fh5jzPu9t6sj0/Wmk6znthjKPR73Egsn7XhzvdHVTzCcN
         kA6PZNSkTVR2nFMOmqVU/uGqiTOVZI/JFQiDE6T6pRxf2AaUY6koDHlbyD1yqjRDWlQk
         QyxksFnFARPU5QodO6rqNaTk57kfT2ZVsUrR0HrlLFPuHYpWEWiHrC0aQA8n3xUIJU70
         eXN/VN8kA8Iv19o7V0K3hiKO0ytcH8gXJcMX8aGC7W4stE2TKKTBYkHnEexx4LebKu3Z
         Kk7g==
X-Forwarded-Encrypted: i=1; AJvYcCU4DCuLJixR2UTdmtdkV1NguRmofyhFSilR+OP02c5qoaeLDd+cjn6CSDsLRUl7JMC1XlJk0z8D8Jeydt1F0wroFEo7uWOdZGI=
X-Gm-Message-State: AOJu0YxdoEV34lWjYU7eEkdCVrQWmfaooPJL4eKkvpYsPjyKSgGBROJ5
	4lX8RbxuH/JjRKGKD3IBb4Cnf6kcj1aXkGN7S3Pz1UgU7Ll890alIEJjUmPI7Sk=
X-Google-Smtp-Source: AGHT+IEbmgzwv7vfHPPjLKLtcnamF89MDucqRN1a6Jr35IsIdoXw9q3wRg5VQj1wn2HHqHU4CWVwLw==
X-Received: by 2002:a05:600c:3b20:b0:421:7e19:5afa with SMTP id 5b1f17b1804b1-4217e196259mr52996295e9.30.1718023843148;
        Mon, 10 Jun 2024 05:50:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215810242fsm172504585e9.12.2024.06.10.05.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 05:50:42 -0700 (PDT)
Message-ID: <5e980bfe-c939-478b-833e-d5816c3ed77f@linaro.org>
Date: Mon, 10 Jun 2024 14:50:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: interconnect: Add Qualcomm MSM8976 DT
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
 <20240609182112.13032-2-a39.skl@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240609182112.13032-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2024 20:20, Adam Skladowski wrote:
> Add bindings for Qualcomm MSM8976 Network-On-Chip interconnect devices.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

A nit, subject: drop second/last, redundant "DT bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> ---
>  .../bindings/interconnect/qcom,msm8976.yaml   | 107 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,msm8976.h   |  97 ++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
> new file mode 100644
> index 000000000000..bc9d08443e7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8976.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8976 Network-On-Chip interconnect
> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Qualcomm MSM8976 interconnect providers support adjusting the
> +  bandwidth requirements between the various NoC fabrics.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8976-bimc
> +      - qcom,msm8976-pcnoc
> +      - qcom,msm8976-snoc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2

I know that other qcom bindings use that order (clock-names -> clocks),
but at least for new bindings let's keep it more logical, so please
first clocks then clock-names.

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

Drop both lines.

> +
> +    properties:
> +      compatible:
> +        const: qcom,msm8976-snoc-mm
> +
> +    required:
> +      - compatible
> +
> +    unevaluatedProperties: false

Put it after $ref (before description).

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false

This goes after entire allOf section

> +
> +allOf:
> +  - $ref: qcom,rpm-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: qcom,msm8976-snoc
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: IPA clock from RPMCC
> +        clock-names:
> +          const: ipa
> +
> +      required:
> +        - clocks
> +        - clock-names

Then why do you have two items? And what with clocks for other variants?
This is supposed to be fixed/specific for each device/variant.


> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +    #include <dt-bindings/interconnect/qcom,rpm-icc.h>
> +
> +    bimc: interconnect@400000 {
> +        compatible = "qcom,msm8976-bimc";
> +        reg = <0x00400000 0x62000>;
> +        #interconnect-cells = <2>;
> +    };
> +
> +    pcnoc: interconnect@500000 {
> +        compatible = "qcom,msm8976-pcnoc";
> +        reg = <0x00500000 0x14000>;
> +        #interconnect-cells = <2>;
> +    };

Drop both nodes. The node below is enough as an example.


Best regards,
Krzysztof


