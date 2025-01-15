Return-Path: <linux-pm+bounces-20460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0EA11B4D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F253188ADB0
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD1D2361DA;
	Wed, 15 Jan 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvx066fL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90419234CEA;
	Wed, 15 Jan 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927514; cv=none; b=FhWsXpaQtEgmnSe7INiHv7jAhi7oqr5xgMdh0q4haRqILBCcIonYEb0+GIDvhSaD5OjsBWcgF4OnmpGaNSEHq8rW6XjVGSTwPg4b0AL+SG9RASVU6rwyPQdp3UUAsxnsEjvjUTIZkvBEkiK6Ap6eplvedS8z1gWqc1IGi5VKoK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927514; c=relaxed/simple;
	bh=S+Nj9hWyHRIvjq4/IofNhfaffIn9jAcgTDLhxg1rvvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvfv3MvOH+gPhzWGM/Qeexx0DdrrzK19AcsThyetIuKXSgSoY/oWbfZhHyb7d3aebPEb9wGb5CZuWH7ywhGewNXDqIDTeKHgJ1Ls4+qu7ZxNyr7HRrnRnKbVZARF0f2E6Tuv5c12lPBa57AixP4oV1Q+9BJRg2hdLAz9zO0v3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvx066fL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6238DC4CEE1;
	Wed, 15 Jan 2025 07:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736927514;
	bh=S+Nj9hWyHRIvjq4/IofNhfaffIn9jAcgTDLhxg1rvvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uvx066fLqOkq2FDBqACzgccc8KScMXLxd3zQL2qcA9RJrLq4iZ/CHhD78v5CxM1Yk
	 Djx0jQGp96X5lQlvUP/UMAnHU6y8YWZWhkQ0jiP83h6FUNw8+AGjQi08OFNboPk2Hs
	 0AO8kCkJFJuAOQC0W49As/pvzkQ89cPY+6YkcOt6MHq9EegqjowGZfWmoGY1v4uHLY
	 AmaiUoDl8d4P1UklxcvjU9PA2McMP6jve23VVlvkHcY3PJ9YU7EkpQXB3qUuPF9B2e
	 ocVh3yQEiLF2ZYFdFtwfkeyqbU2AmmaF7GBaUKjISO7EjPfLW/kIUsqxgw2Hii+OH4
	 s+dpNfCHXZOhQ==
Date: Wed, 15 Jan 2025 07:51:50 +0000
From: Vinod Koul <vkoul@kernel.org>
To: Andras Szemzo <szemzo.andras@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 10/12] dt-bindings: phy: allwinner: add v853 usb phy
Message-ID: <Z4dpFqffMJ31ml2y@vaman>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-11-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110123923.270626-11-szemzo.andras@gmail.com>

On 10-01-25, 13:39, Andras Szemzo wrote:
> Document Allwinner v853 USB phy.
> 
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> ---
>  .../phy/allwinner,sun8i-v853-usb-phy.yaml     | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
> new file mode 100644
> index 000000000000..773c3f476db8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/allwinner,sun8i-v853-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner V853 USB PHY
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +properties:
> +  "#phy-cells":
> +    const: 1
> +
> +  compatible:
> +    const:
> +	- allwinner,sun8i-v853-usb-phy

Does this really need a new binding document, if so why... Cant this be
added to one of the existing docs which driver uses?

-- 
~Vinod

