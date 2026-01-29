Return-Path: <linux-pm+bounces-41697-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNFfLAqSe2nOGAIAu9opvQ
	(envelope-from <linux-pm+bounces-41697-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 17:59:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1380CB2904
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8DD2303B4DC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3712346766;
	Thu, 29 Jan 2026 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ9zKXPr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49133F8DA;
	Thu, 29 Jan 2026 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705732; cv=none; b=HDFiZsci65vc1mtKoue+dX07YXm5gnLje6EvJuvNDXgfl+jxfcmF06YOPO+7KtZL3Sb0qxeKFvSbV6arEntLE6p7gzgp1wsqg2qcYlRXuF3UKskNBVh7qubatVJKZ6TffcrFFZ+nVEuO/V5nvY0nPHTzWY5FhyuNQqHxP93zPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705732; c=relaxed/simple;
	bh=mZs03WYD4uRFTip8el8/SaAOaPr/KLn2tNNfr3ADzqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDn28Y0Q8gHfRdCQXq9ZdCcEDjc48OsExuYGt+bgAleGOIHm8rk8lmGSjIUj3BrWJjpTweeaMEbwrtBQc5XsEWc8Tw0md+rS3Ab6bTQ2sW4KiWHtMP5ptIf82nP8K47TLtId+f0qL+AqwmeU6zNAaaHEeWAQDc1jcpFYR9OkDzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ9zKXPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2388DC4CEF7;
	Thu, 29 Jan 2026 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769705732;
	bh=mZs03WYD4uRFTip8el8/SaAOaPr/KLn2tNNfr3ADzqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZ9zKXPrUoLdPcQT07k41nF6WLFtAZZe85ruwQmm2Z6RUd7uI19PFYB+1ygycb4+M
	 sNCytqXi9y3Yl5Rb0q7B1wy1J+Zf+bZbyrUT78u17Tt5sefiGwO5vzgAQOZsFmDWt4
	 XopdtXorOrT50Q/a0g3gO2NgU3+P/zLd4y0BZr3B1SiNTxEw2h6ptRyVgpvGLwllX3
	 BhgOzt+uetn51K+48rjGu/HaNDaolUvnMJfo5ufAUzH3x/dkCNxmTSxeg4rMso2fAr
	 /3haGHrGsIPWwslXr3sdWoGcmN2aIIgvJ1QpRE0smIEE4lBIGhJTMYVYznTNnyTr2N
	 aBTvmwwndhT5w==
Date: Thu, 29 Jan 2026 10:55:31 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 01/10] dt-bindings: soc: google: add google,gs101-dtzpc
Message-ID: <20260129165531.GA1269692-robh@kernel.org>
References: <20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org>
 <20260128-gs101-pd-v4-1-cbe7bd5a4060@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128-gs101-pd-v4-1-cbe7bd5a4060@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41697-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1380CB2904
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:10:50PM +0000, André Draszik wrote:
> The Exynos Distributed TruztZone Protection Control (D_TZPC) provides
> an interface to the protection bits that are included in the TrustZone
> design in a secure system. It configures each area of the memory as
> secure or non-secure.

This sounds like what access-controllers binding is for. Does that work 
here?

> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/soc/google/google,gs101-dtzpc.yaml    | 42 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..a8c61ce069d6910c47753bf14a792eb58e6ae182
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/google/google,gs101-dtzpc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos Distributed TruztZone Protection Control.
> +
> +description:
> +  Distributed TrustZone Protection Control (D_TZPC) provides an interface to the
> +  protection bits that are included in the TrustZone design in a secure system.
> +  It configures each area of the memory as secure or non-secure.
> +
> +maintainers:
> +  - André Draszik <andre.draszik@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: google,gs101-dtzpc
> +
> +  clocks:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/google,gs101.h>
> +
> +    dtzpc_hsi0: dtzpc@11010000 {
> +      compatible = "google,gs101-dtzpc";
> +      reg = <0x11010000 0x10000>;
> +      clocks = <&cmu_hsi0 CLK_GOUT_HSI0_D_TZPC_HSI0_PCLK>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a56f8f00aebb938aa765a8a6d66dfeb7f062dac8..98b2ef47c809ac0232e6941c9483b19d7c798bb4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10833,6 +10833,7 @@ P:	Documentation/process/maintainer-soc-clean-dts.rst
>  C:	irc://irc.oftc.net/pixel6-kernel-dev
>  F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
>  F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
> +F:	Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
>  F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
>  F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
>  F:	arch/arm64/boot/dts/exynos/google/
> 
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

