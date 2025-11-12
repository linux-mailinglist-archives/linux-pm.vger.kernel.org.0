Return-Path: <linux-pm+bounces-37800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEDAC5074E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 04:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6AF6349C7B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 03:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E312C11D5;
	Wed, 12 Nov 2025 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h2VeDbcO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52032207A20
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 03:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919844; cv=none; b=od/hkyrhsf1svotNNxfoHRal88yGS0/sZdtRUDJ8QoqPGEZ/AkKCdelD4YSdOoEw46luHzja8jZ9SNjJ9rrb/NCimEWT0Vtm6nMXG0b0ur/r8DWA75NeNBTTjiVmv8n7CeIp53V31j98quynwvKVFB93f9l4AulUU08UYLjh1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919844; c=relaxed/simple;
	bh=8UrXATVEOSkpcOqAwYDPjZ/LwNgFCgVkt2cRW5OlIyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlme7WeTSdvL+rLSiu8cZlAOTghsiQJcS+BbiIHT8GzVLa4JshXN4GYJi2L5m9oMJe/AI8OhYG8h8G7tVeVX2E0E6QXfaj2cVT63JD02kLIyydnSogzR5UhVn1gS9Tg0JIK6MKtXLAgP/bOOKMULKE/kKG6tlZ3D5li+zodFx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h2VeDbcO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so301531a91.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 19:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762919842; x=1763524642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovVpRNi0EQ6lOoutzsikI7movk3CjwrYn04Q7//VyJg=;
        b=h2VeDbcOJy+eyCjz9XR4Itw7E2lmCnI66r6HIVx7hECtt7bnN/VUstgHH02rAqpNh2
         n3ed9max9IEh/itP+BR5XkTc4i0QVn+/1TsYBxUrrigO4l6jbR1jIBVBvK9k8INgXsV3
         t3goUFHASs3xp0HS5JzrBd13qYyB2TLUuaWCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762919842; x=1763524642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovVpRNi0EQ6lOoutzsikI7movk3CjwrYn04Q7//VyJg=;
        b=H5liwMZtg0P7zYUz9CPocXQ2Yng7mC6w0Is39mGhK7qoYGtpKvvLQrLdoNR1zktVK/
         fTmGIP+1HBrB4KoBh3HhQIK3xAAPCx7pa9BNYwC5eVAeBGvRkici10CS8kZF4UhtNTCR
         uwZFUL/ZplE+7ZMu0FmsaweTMZccCrUiKiTbBa0tu67CdHrTWdtH6T+2nPZzOJBBp0cK
         KjPL2OTLLdSkaUGjt9QFnnUVrXEAKFsviUEdnSMo2OpcKIIX74FQ7FEuqArMEvYlZpdH
         vmhHBLU0DMzLCFhyqTy4BEqTaRssU576QTJznjCY7+/mNygDzCEBtYjHOC2NByvgqDwC
         jv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY2ckpEok+X/kC9mvj6o6/SEuIPmv9IB7fzDwPSv0trwv/vaJ65gooLo0hGaEHWlFL5ZTTa+erGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWsoVmNg31uyixImpteJ9gf4X6vOffT01VnZxVK91gtj9/UfE1
	xlEOXj5oJlYIWOUhNNdOuW4OrS+h7dH0BlsrnCxAPw47yKGSh0tPYmm9KPJjS2cdRA==
X-Gm-Gg: ASbGnct15PnOpSBFE5F4+Q9AQDopEQsoCiUGafdcEkM6G6+n9UB/3u1p5zRK0tHOY1F
	NmbnwmqSBfHUdYeT/TPfWdMq3qIjIFVdHst2BDC+DLMcQJM++8b7G0eNAhlbgeZrbFTGUk0CMFL
	3XiTpQzfDf99GSPybfGzJCO5awGgcfiEVNtCWAb4LFcCtlr09/Q+lda+eoHQBKN6NA1vJnLicFM
	/QVrk7Sjb2mU/8I/eJoV4Afm9UTuGXpwzvTgtoMwmIhWybDvdIocHnnmkJpV5N4ze8twpuCYTRX
	zjcdHDDGN6+zomSkQBfQlQSgwWGVsbQ5jIx/GH2vLpAE7ZGxR/qz/OSiEoC3TztYPXxOxyWbWmp
	nHqfyaroUr6WdEtnzAZbE7zxRALhtvLXbmQXBaDBJe3iK5q767+VmBlGW+u+XZ2+X+/r7QmGeZI
	m9MJmxZdgMPBZ+8SoNjwgrnz4TBwuJHNXw
X-Google-Smtp-Source: AGHT+IFuC7JCagvpoSYGItHOD5crq2vbUP/LygFRR5OO11qZWWEU7YvPgPRxAneMXyaEw4LK8Np9Xg==
X-Received: by 2002:a17:90b:1fc5:b0:340:6f9c:b25b with SMTP id 98e67ed59e1d1-343dde030a0mr2130204a91.11.1762919841636;
        Tue, 11 Nov 2025 19:57:21 -0800 (PST)
Received: from google.com ([2a00:79e0:201d:8:8b66:5f0b:945c:64eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b783087c08sm1168218b3a.3.2025.11.11.19.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 19:57:21 -0800 (PST)
Date: Wed, 12 Nov 2025 11:57:17 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <20251112035717.GA3363355@google.com>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>

On Sat, Nov 08, 2025 at 08:53:19AM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> provides interfaces like PCIe and SATA to attach the Solid State Drives
> (SSDs) to the host machine along with additional interfaces like USB, and
> SMB for debugging and supplementary features. At any point of time, the
> connector can only support either PCIe or SATA as the primary host
> interface.
> 
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
> 
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..be0a3b43e8fd2a2a3b76cad4808ddde79dceaa21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key M Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
> +  connector. The Mechanical Key M connectors are used to connect SSDs to the
> +  host system over PCIe/SATA interfaces. These connectors also offer optional
> +  interfaces like USB, SMB.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-m-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vio1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.

FYI I just added vpcie1v8-supply to the core DT schema [1]. vpcie1v8
instead of vio1v8 was requested by Rob.

[1] https://github.com/devicetree-org/dt-schema/pull/176

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on the
> +      connector. Since a single connector can have multiple interfaces, every
> +      interface has an assigned OF graph port number as described below.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: PCIe/SATA interface
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB interface
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: SMB interface
> +
> +    required:
> +      - port@0
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> +      more details.
> +    maxItems: 1
> +
> +  pedet-gpios:
> +    description: GPIO controlled connection to PEDET signal. This signal is used
> +      by the host systems to determine the communication protocol that the M.2
> +      card uses; SATA signaling (low) or PCIe signaling (high). Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.3.4.2 for more details.
> +    maxItems: 1
> +
> +  led1-gpios:
> +    description: GPIO controlled connection to LED_1# signal. This signal is
> +      used by the M.2 card to indicate the card status via the system mounted
> +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> +      details.
> +    maxItems: 1
> +
> +  viocfg-gpios:
> +    description: GPIO controlled connection to IO voltage configuration
> +      (VIO_CFG) signal. This signal is used by the M.2 card to indicate to the
> +      host system that the card supports an independent IO voltage domain for
> +      the sideband signals. Refer, PCI Express M.2 Specification r4.0, sec
> +      3.1.15.1 for more details.
> +    maxItems: 1
> +
> +  pwrdis-gpios:
> +    description: GPIO controlled connection to Power Disable (PWRDIS) signal.
> +      This signal is used by the host system to disable power on the M.2 card.
> +      Refer, PCI Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
> +    maxItems: 1
> +
> +  pln-gpios:
> +    description: GPIO controlled connection to Power Loss Notification (PLN#)
> +      signal. This signal is use to notify the M.2 card by the host system that
> +      the power loss event is expected to occur. Refer, PCI Express M.2
> +      Specification r4.0, sec 3.2.17.1 for more details.
> +    maxItems: 1
> +
> +  plas3-gpios:
> +    description: GPIO controlled connection to Power Loss Acknowledge (PLA_S3#)
> +      signal. This signal is used by the M.2 card to notify the host system, the
> +      status of the M.2 card's preparation for power loss.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  # PCI M.2 Key M connector for SSDs with PCIe interface
> +  - |
> +    connector {
> +        compatible = "pcie-m2-m-connector";
> +        vpcie3v3-supply = <&vreg_nvme>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                endpoint {
> +                    remote-endpoint = <&pcie6_port0_ep>;
> +                };
> +            };
> +        };
> +    };
> 
> -- 
> 2.48.1
> 

