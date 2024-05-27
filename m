Return-Path: <linux-pm+bounces-8152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 742C08CFE1F
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1275B1F2340E
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4251D13B29B;
	Mon, 27 May 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="ridocHYy"
X-Original-To: linux-pm@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036113D281;
	Mon, 27 May 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805746; cv=none; b=OSsvU8tBvfoDNniP2ZOqoWdE8ZPdcgtDZfu8YDRC37kcbtRe084CRI5kK9N70o0dRToG8qMJXR9Tw5dlwwVbNMQYnypTD3Bo5BPZ43NT4w/M1kyZZczW0X0FrBKGZ8ozdx1e0pEEVuZNSLd0eeicGTAht/XFymNQzpgmtDaR+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805746; c=relaxed/simple;
	bh=ZAOnZNIPCZ/gjfi2EqP8pXMwOx3RdNya75v5ylcZQ6c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TzUkMy8KbiZqGKPaBsljkj4zUVQ6zbSgFqpcN8INnsSQX316PJny4+iP6hD2FPKlm3ZRcqcQVc1Byr59WOqnqK7OEeoDd5DU4AgVwT66dufy84LcRspznnXpMH+LSe/j+y6oQs/0iArj9rCB9flonL0MxqHkkGw5ZLZKk2sV41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=ridocHYy; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 283C2401B5;
	Mon, 27 May 2024 15:21:31 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1716805292; bh=ZAOnZNIPCZ/gjfi2EqP8pXMwOx3RdNya75v5ylcZQ6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ridocHYydGXxMzSw/4pmPPWYPapNbiLLDE25aOUH1yhRhqE9IxNCaygl7dmOhLvCu
	 kfM7xS/lbMNMw/2UJ4se499cJTUropO7SxQVqXnkeEQlQxRyp/9VTqXzg16bnEijfs
	 IHYiHStZPIA1pcEPsCINtqdueHIA969sfhk+BuCikO7BTUkWycZCY7+n8gtorHnkX2
	 eP+FnETfN6HL4lc3uPpUFXCKQS/zMBU9tgpYlkXroBji92nHZAhM9HryJhvB71Gki/
	 FZJx0S/x/EDP/GwgU+gPPxFGMOAJPq1Y2u8OF9T7RO7heMsl0piZ0PpjYNH+vqNXFf
	 +sKjYJVMEd4Rw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 27 May 2024 15:21:27 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Bryan O'Donoghue
 <bryan.odonoghue@linaro.org>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: power: supply: Add Lenovo Yoga C630
 EC
In-Reply-To: <20240527-yoga-ec-driver-v3-1-327a9851dad5@linaro.org>
References: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
 <20240527-yoga-ec-driver-v3-1-327a9851dad5@linaro.org>
Message-ID: <f05953c74f2bf58256306eb3d554ae0b@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dmitry Baryshkov писал(а) 27.05.2024 15:03:
> From: Bjorn Andersson <andersson@kernel.org>
> 
> Add binding for the Embedded Controller found in the Qualcomm
> Snapdragon-based Lenovo Yoga C630.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/power/supply/lenovo,yoga-c630-ec.yaml | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> new file mode 100644
> index 000000000000..52a302850743
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/lenovo,yoga-c630-ec.yaml#

Should this binding join aspire1 one in bindings/platform ?

Nikita

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lenovo Yoga C630 Embedded Controller.
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description:
> +  The Qualcomm Snapdragon-based Lenovo Yoga C630 has an Embedded Controller
> +  (EC) which handles things such as battery and USB Type-C. This binding
> +  describes the interface, on an I2C bus, to this EC.
> +
> +properties:
> +  compatible:
> +    const: lenovo,yoga-c630-ec
> +
> +  reg:
> +    const: 0x70
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +patternProperties:
> +  '^connector@[01]$':
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c1 {
> +        clock-frequency = <400000>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        embedded-controller@70 {
> +            compatible = "lenovo,yoga-c630-ec";
> +            reg = <0x70>;
> +
> +            interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            connector@0 {
> +                compatible = "usb-c-connector";
> +                reg = <0>;
> +                power-role = "source";
> +                data-role = "host";
> +            };
> +
> +            connector@1 {
> +                compatible = "usb-c-connector";
> +                reg = <1>;
> +                power-role = "source";
> +                data-role = "host";
> +            };
> +        };
> +    };
> +...

