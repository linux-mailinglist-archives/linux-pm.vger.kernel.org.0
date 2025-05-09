Return-Path: <linux-pm+bounces-26937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4573AB1476
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B76C16B426
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7982A29186B;
	Fri,  9 May 2025 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="zWGd0EQ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F228EA45
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796321; cv=none; b=kslmF/FYnZ+HC9KyZ7+wgaHc6IJRn63nhRmMZ6dBkZF8dj8rsj42eSgx+YkAh4yANdbXF4aJ6pXourhCTYbwFq2q4BtgBxwwff+ZBi0WPKizaOcWiDF/MWv27mSNoBhve6jUdY1wleHD2c4gFGz1gOCMIkPkTPF3InonY/oanEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796321; c=relaxed/simple;
	bh=swVxJzXYBgibN2+WwRuJkr2E8ElbwunBdcTLYqq3KSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxT4aSJwmBnRa3mluhfdJjpRMkNYjsEAPtzrifYioGoOUkZ8Ypp7MOhxIo3dU+sHUSOX8ZynncgBzjHFqRAa/L8wDnisEuU58nYtobqcBBPLqSSRMXFE3mP2iLhjEnaX+CZo4qJZQZBCjTNq/11HJjRxgkP2bjLK0tsciIU5lcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=zWGd0EQ+; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Fri, 9 May 2025 09:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1746796317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cODXcFGpa9GJFjzICuWLyHSlxQKolQxsmG+8RFxJT0o=;
	b=zWGd0EQ+8vwKEEyyvYLpMj3w6+t+dVUvx+YxYEje5TTjAKGyvwHo56Dq0FM+ydfl4ear/w
	Yazo/NFZdnpNRn2m/a8/IJ6uHYDqVOyPs03uuabxbB44XGKCfxdfrFy980HCw7O1XQ6bkA
	dWzLb0cmlUch88AfOQa3fYufS22+gOk52D8iJ8P3KdA8UjT7cDLx8BceHL7N8Q7ugqlFcx
	NkbpkaH9bnnpAQfiz1y24McCjKDUMHQziyz0CGiapGPtv6fbwOi7kl9LAtBMuuTf1RjUMS
	nXp6fkLAaZ3FAB+fGva2BRQSBzkT1yutZQHb/moew7rpLTF4S4FGcJdJzmTcdw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/9] dt-bindings: power: reboot: Add Apple Mac SMC
 Reboot Controller
Message-ID: <aB3_GaSrJFKgxNXO@blossom>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
 <20250503-smc-6-15-v4-2-500b9b6546fc@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250503-smc-6-15-v4-2-500b9b6546fc@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Sat , May 03, 2025 at 10:06:49AM +0000, Sven Peter via B4 Relay a écrit :
> From: Sven Peter <sven@svenpeter.dev>
> 
> On Apple Silicon machines a clean shutdown or reboot requires
> talking to SMC and writing to NVMEM cells. Add a binding for
> this MFD sub-device.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/power/reset/apple,smc-reboot.yaml     | 52 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml b/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..e55e524914c2f57f7acf239fdefcbdc7a993b69f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/apple,smc-reboot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SMC Reboot Controller
> +
> +description: |
> +  The Apple System Management Controller (SMC) provides reboot functionality
> +  on Apple Silicon SoCs. It uses NVMEM cells to store and track various
> +  system state information related to boot, shutdown, and panic events.
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +properties:
> +  compatible:
> +    const: apple,smc-reboot
> +
> +  nvmem-cells:
> +    items:
> +      - description: Flag indicating shutdown (as opposed to reboot)
> +      - description: Stage at which the boot process stopped (0x30 for normal boot)
> +      - description: Counter for boot errors
> +      - description: Counter for system panics
> +      - description: Power management settings
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: shutdown_flag
> +      - const: boot_stage
> +      - const: boot_error_count
> +      - const: panic_count
> +      - const: pm_setting
> +
> +required:
> +  - compatible
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    reboot {
> +      compatible = "apple,smc-reboot";
> +      nvmem-cells = <&shutdown_flag>, <&boot_stage>,
> +                    <&boot_error_count>, <&panic_count>, <&pm_setting>;
> +      nvmem-cell-names = "shutdown_flag", "boot_stage",
> +                         "boot_error_count", "panic_count", "pm_setting";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f91f0225133490607ba0d79ad4225892ef31a66..d85d9d9065db4dc5869788f8a81d9d9a425d7ce3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2282,6 +2282,7 @@ F:	Documentation/devicetree/bindings/nvmem/apple,spmi-nvmem.yaml
>  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
>  F:	Documentation/devicetree/bindings/power/apple*
> +F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
>  F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
>  F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
>  F:	Documentation/devicetree/bindings/spmi/apple,spmi.yaml
> 
> -- 
> 2.34.1
> 
> 

