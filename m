Return-Path: <linux-pm+bounces-22895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D32BA443A4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 15:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA421883F06
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C7269CF4;
	Tue, 25 Feb 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nniS8Ylf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4E21ABC7;
	Tue, 25 Feb 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495176; cv=none; b=kJ+oBHYxoh0sY3H7g3NlXLzrvUJM60Pckn5Gl45Dj9nVS7V1N+J7it/nx+o6lQwhFb1Ed94B+UQalNhlN43yzKnXHO3MZ86WvxJzqZwrXXr2K3dWaRhYKPPELXrQ+QU5IcKrC+P7qAEt0gj2hUDbIOk1hzJ3GHlFoN47ogsFyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495176; c=relaxed/simple;
	bh=9C5oZ34+32K1qOoiP/odmBMxPo1y7u2d3iAaqcJQqhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xss3VkNkcHoymxf3Lc6yOAoy8qCTkvbg7mddGNI6b2sfycfPrdOlR6evja02SE0M9TDFUFdfjUY7TXAqVoFd0bB7T+8Sdvoc0NeEOvaeBDYh8Au47idxU486WtMEX62qYAJJwZBls2vZZTdmRe6GWeXb60z5MevRFfFcHIagSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nniS8Ylf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55A7C4CEDD;
	Tue, 25 Feb 2025 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740495176;
	bh=9C5oZ34+32K1qOoiP/odmBMxPo1y7u2d3iAaqcJQqhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nniS8Ylf0dMMCUmZyFFlrxUqtB/4nEuBBDOKSb2OukGdLPfst0NMG6qXCMbdBzdH8
	 HZHY9wlPcJS58E4+vFSZKUwd2+FODlZ56AkpvHLitB3jlw/ESa8gsFi6Xq4/MVjbmZ
	 jNQ0j6ZVf9PJS6/xsGXgbyOQJh4TdLdEalRnix6pv3LMz+qTewWMqmhQKs+Q/VaZ8n
	 Sawyr7ETjhek+V9WX//mOuZCRU8R1kfnLOs1ThvaZQlWT/MQ7PCpJQa8y8gnFbffPI
	 2fTYOgjKcBoYQKmvXAV4qNA0PamytmpOgQ7fJg0AAHHsYxfq5FJb8Uju9GkhXetzzz
	 m6Gs2RSmY4azA==
Date: Tue, 25 Feb 2025 08:52:54 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB
 subnode into schema and example
Message-ID: <20250225145254.GA2361434-robh@kernel.org>
References: <20250224142831.485159-1-alexander.stein@ew.tq-group.com>
 <20250224142831.485159-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224142831.485159-3-alexander.stein@ew.tq-group.com>

On Mon, Feb 24, 2025 at 03:28:23PM +0100, Alexander Stein wrote:
> Document the LDB bridge subnode and add the subnode into the example.
> For the subnode to work, the block control must scan its subnodes and
> bind drivers to them, do not misuse either simple-bus or simple-mfd
> here.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> index b3554e7f9e76d..d914dea6ecbb5 100644
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
> +      ranges;

Given the address below is 0x20, this looks wrong unless the parent 
address is 0.

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
> +        };
>      };
> -- 
> 2.43.0
> 

