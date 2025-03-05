Return-Path: <linux-pm+bounces-23466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED31A4F7B3
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 08:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D06416EF22
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 07:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649A1EA7DB;
	Wed,  5 Mar 2025 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+/l0hOb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EB33993;
	Wed,  5 Mar 2025 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158788; cv=none; b=D84KA3/NLGRcEcQXBBaZQuhoYeEZdTrHE5zbSFbhkJ+00q0Xg8zH23H8IzSe4BQRR0jpoFKtRW1McbU+8uNpLVCx1nExp64XaArTMnbv9AbDWHfBMG+U5Jv/3M3aDv7BL/CS39NtTd7DEmbfsLAY0X1nFztTx3zHiDR8R94XlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158788; c=relaxed/simple;
	bh=XALvqM3rTWffhLsWC4ScvJKu3JsXVYqY3UUNekYl9No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJl+XPitl8GA96RdUtagqjyH9STmNkPoOewlrTvGkZnvCx5wo17NHm+4FnJXe3gYKJLfVdFybDXOXFDT0WQQ1jGlE+IyWi4Qn56FbqTAoQ1/jGmcgkjtMJaAESI5eyjiKCm6vRmkcdfgkg0BQkO8dpl9k06VNiLaeDli5GTXpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+/l0hOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F00C4CEEA;
	Wed,  5 Mar 2025 07:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741158788;
	bh=XALvqM3rTWffhLsWC4ScvJKu3JsXVYqY3UUNekYl9No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+/l0hObN4qKsYWxBrpFijsi02TehWWysBo4MjWPA8ItPzuoALg9Uaez6f5FmwXY+
	 EOMyRWxseN3yrkKFDCbKFYldEFyWxReQhqsaJQcNeAXHtyAGu7bPgpgmAh3u468eiF
	 2ddsAG64Ft1sBD8NwU6gOfhdP6qO4r42pBdbe7ys41rmbi4NmTSTP3Z5r9WFKJjkAC
	 +cTk7qkt+mDJmmEcuHaOC+jASwD1KrY8LtfnY7PWy6Q8Nh6zITlyAmAvKWMAKIwAFZ
	 GAv8p+Mqg3Czhe5X3OLm2S59GThK88/bPQrG06wjar9NNJHdE9lDyVOS+4cYPqcuGV
	 l1HqCvQPSZdDg==
Date: Wed, 5 Mar 2025 08:13:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB
 subnode into schema and example
Message-ID: <20250305-dandelion-axolotl-of-excitement-05fa70@krzk-bin>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
 <20250304154929.1785200-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304154929.1785200-3-alexander.stein@ew.tq-group.com>

On Tue, Mar 04, 2025 at 04:49:21PM +0100, Alexander Stein wrote:
> Document the LDB bridge subnode and add the subnode into the example.
> For the subnode to work, the block control must scan its subnodes and

Don't describe drivers, but describe the hardware.


> bind drivers to them, do not misuse either simple-bus or simple-mfd
> here.

I don't understand that simple-bus or simple-mfd statement. There are no
such compatibles here.

> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> index b3554e7f9e76d..cd785111928bf 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> @@ -24,6 +24,14 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
>    '#power-domain-cells':
>      const: 1
>  
> @@ -46,9 +54,20 @@ properties:
>        - const: csi
>        - const: dsi
>  
> +  bridge@20:

@20 looks wrong. Use 'ranges;' and try again your DTS...

Binding is supposed to be complete. We have several examples when people
added children one-by-one, everytime with different reasoning about
child addressing.

So please confirm: this is complete and no other children will ever be
added here... or you are 100% sure that all future children will be
unit-addressable (will have unit address and appropriate properties).

BTW, I don't quite get why this is both syscon and has translation for
child addresses. Does it mean your child does not use the same MMIO as
parent, thus leading to unsynchronized reg access?

> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        contains:
> +          const: fsl,imx93-ldb
> +
>  required:
>    - compatible
>    - reg
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
>    - power-domains
>    - clocks
>    - clock-names
> @@ -77,4 +96,36 @@ examples:
>                 clock-names = "apb", "axi", "nic", "disp", "cam",
>                               "pxp", "lcdif", "isi", "csi", "dsi";
>        #power-domain-cells = <1>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0x0 0x4ac10000 0x10000>;
> +
> +      bridge@20 {
> +          compatible = "fsl,imx93-ldb";
> +          reg = <0x20 0x4>, <0x24 0x4>;
> +          reg-names = "ldb", "lvds";
> +          clocks = <&clk IMX93_CLK_LVDS_GATE>;
> +          clock-names = "ldb";
> +
> +          ports {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              port@0 {
> +                  reg = <0>;
> +
> +                  ldb_from_lcdif2: endpoint {
> +                      remote-endpoint = <&lcdif2_to_ldb>;
> +                  };
> +              };
> +
> +              port@1 {
> +                  reg = <1>;
> +
> +                  ldb_lvds: endpoint {
> +                      remote-endpoint = <&ldb_to_panel>;
> +                  };
> +              };
> +          };

Messed indentation.

> +        };

Best regards,
Krzysztof


