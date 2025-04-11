Return-Path: <linux-pm+bounces-25287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B28A86522
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 19:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FBC4C42BF
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0045258CC8;
	Fri, 11 Apr 2025 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQL8jzqT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC52586EA;
	Fri, 11 Apr 2025 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394252; cv=none; b=bWP8Ho90u1xiy3U7X8Mnj3KuRyZ2NQJKHsSnpgSr4yKCaOIhXj82qw5ahysfaRjmWzSzFBh1aG1wXH1rwuE2oC48g5QMoRq1DjxklGm2IW6HgEuplTBX6BnSh6Ho6h028RP45po/xFoD3RjtZBilKjNgv3E4abLQ1pBsNVEfqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394252; c=relaxed/simple;
	bh=1/CULNrp6gAuXONzF0vqUued6nOAitWEc5QO9k0BcfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njuFd64YES7ExutJKF7BzzS90a7tRth+Ub9lSXzjkdwvv53PZmV5dUslPynaJ6fuejwYBL9nfmdc6eF+8dUl+Xdg8QqLknYFROhEfE+EsyVIYXPTy2lxAMRM49wmZc+QYzxQlvTw6NDwezOVPm2/ggffwqt5m7aHIzShs7IyktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQL8jzqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAA8C4CEE2;
	Fri, 11 Apr 2025 17:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744394251;
	bh=1/CULNrp6gAuXONzF0vqUued6nOAitWEc5QO9k0BcfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQL8jzqTq0Mt9e5/JneJadi8HlMfBW1lUfP29jeKA7AXF17GrRL7EGjSF+OcxDTT+
	 Q50Le5Uho9FyrtY+DS4gnwRNTMhp/OUFgUvRVrNTKuE3RBQ/08g1tBRNipNXvacs4I
	 ftH0qnbINyOjg7oXIJ/ksRpF0whK+c8FL3a01Hjcl5BJrCbccsmdBbUemLNby+jJeM
	 mf2OPQgQV7mxABw09VRCzxGJhc+rCD5IUckA9shSmPoerGfaMXVpjTtVhGXwnVRj8X
	 xoKkQgPqQ3GtFcbeilxBgRG+WI2yZ4YZvo8719+bMdMHD8AqcjXj1QkjBycLBEidbx
	 49MTgDL6i9Qfw==
Date: Fri, 11 Apr 2025 12:57:30 -0500
From: Rob Herring <robh@kernel.org>
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
	quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
	quic_shazhuss@quicinc.com, Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH v1 2/9] dt-bindings: serial: describe SA8255p
Message-ID: <20250411175730.GA3642862-robh@kernel.org>
References: <20250410174010.31588-1-quic_ptalari@quicinc.com>
 <20250410174010.31588-3-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410174010.31588-3-quic_ptalari@quicinc.com>

On Thu, Apr 10, 2025 at 11:10:03PM +0530, Praveen Talari wrote:
> From: Nikunj Kela <quic_nkela@quicinc.com>
> 
> SA8255p platform abstracts resources such as clocks, interconnect and
> GPIO pins configuration in Firmware. SCMI power and perf protocols are
> used to send request for resource configurations.
> 
> Add DT bindings for the QUP GENI UART controller on sa8255p platform.
> 
> Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>

Your tags go last because you touched this last (I assume). The order 
here would be correct if you were the original author, but Nikunj made 
significant enough changes to change the author and also sent the 
patches. The sender always has the last S-o-b (until the maintainer 
adds their's when applying).

> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>  .../serial/qcom,sa8255p-geni-uart.yaml        | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
> new file mode 100644
> index 000000000000..0dbfbfa1d504
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/qcom,sa8255p-geni-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Geni based QUP UART interface
> +
> +maintainers:
> +  - Praveen Talari <quic_ptalari@quicinc.com>
> +
> +allOf:
> +  - $ref: /schemas/serial/serial.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sa8255p-geni-uart
> +      - qcom,sa8255p-geni-debug-uart
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: UART core irq
> +      - description: Wakeup irq (RX GPIO)

If this is a wakeup source, then you should have interrupt-names with 
'wakeup' for the 2nd irq.

> +
> +  power-domains:
> +    minItems: 2
> +    maxItems: 2
> +
> +  power-domain-names:
> +    items:
> +      - const: power
> +      - const: perf
> +
> +  reg:
> +    maxItems: 1

'reg' goes after compatible.

> +
> +required:
> +  - compatible
> +  - interrupts
> +  - reg
> +  - power-domains
> +  - power-domain-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    serial@990000 {
> +        compatible = "qcom,sa8255p-geni-uart";
> +        reg = <0x990000 0x4000>;
> +        interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains = <&scmi0_pd 0>, <&scmi0_dvfs 0>;
> +        power-domain-names = "power", "perf";
> +    };
> +...
> -- 
> 2.17.1
> 

