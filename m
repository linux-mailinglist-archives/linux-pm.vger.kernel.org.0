Return-Path: <linux-pm+bounces-9192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE93908C17
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 14:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C97283DBD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 12:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E05199EB1;
	Fri, 14 Jun 2024 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="e/sNUWPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkAY6ikA"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow6-smtp.messagingengine.com (flow6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B8199247;
	Fri, 14 Jun 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369652; cv=none; b=tWAyftH6uu4grbUbbr2p7vCgoEFsvtHY1DuJe2LQ6UdCgjaXb5/oqy0cloUydqB7PoRqBCWCGN2TIYSJNbXImRSy9oYY7KD7SFU90DNGShJ0C1c9Empw9Q3jOtyPpRus5p8jML80x2YWzKoCSIbbJMAyGUYO5dPvX3gTgRO7FuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369652; c=relaxed/simple;
	bh=8S17m0g/GRM52gnnBJ2eIixlqDKuO32wjIb3d+7vdnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5+f3JV2KMF+U8c96AuU6tGYV3m8xgl35LMMC/utfE927oT5PAIdQtGAG7im7ztvv3W8p/W84um34Vd5jLOpweW7B6RWfGnbqef2Qcwz0vhOCqbIYyV/JUV1rt6fW9hWHgyJzdX7fFkWBXg1CuuUjOcB301bBYTCNF6xC2DFJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=e/sNUWPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fkAY6ikA; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.nyi.internal (Postfix) with ESMTP id 448CD20036F;
	Fri, 14 Jun 2024 08:54:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 14 Jun 2024 08:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718369647;
	 x=1718376847; bh=kzkq65OIpuCs3ZdNQe9hETg6fCuxaq6pJOhxp3W4MzU=; b=
	e/sNUWPzt41ZDlEJ0rbaHgsDAM6/Psb18uSYQwdiX0fvKqE47ANccOOWPj1FonOQ
	N3piZ2RgrxAxEjJLHD/Tjg484eOsFcuuVq5Lcr70+sIdjPfPrUAW50u5y3sYMYwt
	Trz5xVZ4smlNoFkAnnSsSDyXF5f/w9sxJ/aBOlaFkAnTbivmMXznJTEcaPN5esst
	zyZ/mgTiM4RmKRGUwkRbrpD6HKOXu8Yttwi2uS/vWjJZ9+UfahWXIda2sjBXSeur
	U0rI/xNHRV/jZzvLlSDHtRPC5Gz7cllMYqgOp6vzbyaXA0palhobbG5bGWRylVxS
	oDrqU1xuVwRQ6gq/YrP6Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718369647; x=
	1718376847; bh=kzkq65OIpuCs3ZdNQe9hETg6fCuxaq6pJOhxp3W4MzU=; b=f
	kAY6ikA50Nntgl2wgpRJZ9Ew6563PdZDxBLtifDJkORDnS00MMuwwyv9AsspdeUg
	/HTOJFa71y+TfuEXFBHZaBOJPq0OyU1UrM4fJxxdMVCWfGMPFaxLdgJ2+0SjQ2/q
	ZfO6pl1ptKLd43UMIp4LQA4sXKJv2FsHukJsNNgMErq1IwjgucZOmMiZE5f3QKHB
	ZTyXQEVhj+6eVMMLiVIoEMnKsg2LYlP5j8ffsbsSXJNToBxvOCxvch6Gr1PemQdD
	fL5hHJ2eGvyzxBLi5FrMgq0SawjdEbzWq+ultnPkAFTXQWqoJBF2gvN7ScwuaDKh
	IjX5kLwAzcFwByEYbetyQ==
X-ME-Sender: <xms:aj1sZm0YAf0zlUT593horrfn2ipIf6acHvfVQfKnkssTGEoa8Om9BA>
    <xme:aj1sZpFw2wf-iUC0IxtB5DWqqMMCnfD5VwYNAWttsFCic6kzrQpS8fxftg6pDABVX
    gMRKaPwKQJK1IO1REM>
X-ME-Received: <xmr:aj1sZu6LnfoPNVf1i1OoOxnLt75iGeJAKkFzz6DKNOFoFPlHciJ07OnW_Ab6ov50yRtvLYs0artd5qzgETjo3Il5sf7KbpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduledgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrgh
    hnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeef
    heetheekkeegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnugesrhgr
    ghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:aj1sZn3UF-l6IfHHyHpli8od0E7EfKnMJHiNOP4rjDLANiOlZP9VuA>
    <xmx:aj1sZpGLjS1pUc8dzhTkicRu4rXw6-BHkx_QDjbMnwIN4RldTwsGMQ>
    <xmx:aj1sZg9PO3n30TtGNYeLy_c9dRoyMDheA8jU9Iue3Y71RDgWVAyCcg>
    <xmx:aj1sZum0uT3bn8S6g2d5fDuzN3HqD3y4vwBY3flT8LVQkY6RHWszlw>
    <xmx:bz1sZrA4KYFKicBY-9XPwZyWW4hVJJyQ9KBkWa4ddbDjdQZY1aBRj8Ry>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 08:54:01 -0400 (EDT)
Date: Fri, 14 Jun 2024 14:53:59 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,	Anson Huang <Anson.Huang@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Biju Das <biju.das.jz@bp.renesas.com>,	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Pascal Paillet <p.paillet@foss.st.com>, Keerthy <j-keerthy@ti.com>,
	Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,	linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,	linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,	linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev,	linux-tegra@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 13/22] dt-bindings: thermal: rcar-gen3: reference
 thermal-sensor schema
Message-ID: <20240614125359.GH382677@ragnatech.se>
References: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org>
 <20240614-dt-bindings-thermal-allof-v1-13-30b25a6ae24e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614-dt-bindings-thermal-allof-v1-13-30b25a6ae24e@linaro.org>

Hi Krzysztof,

Thanks for your work.

On 2024-06-14 11:46:12 +0200, Krzysztof Kozlowski wrote:
> Device is a thermal sensor and it requires '#thermal-sensor-cells', so
> reference the thermal-sensor.yaml to simplify it and bring the
> common definition of '#thermal-sensor-cells' property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> index 6a81cb6e11bc..d92e882c9e8d 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> @@ -15,6 +15,8 @@ description:
>  maintainers:
>    - Niklas Söderlund <niklas.soderlund@ragnatech.se>
>  
> +$ref: thermal-sensor.yaml#
> +
>  properties:
>    compatible:
>      enum:
> @@ -57,7 +59,6 @@ required:
>    - clocks
>    - power-domains
>    - resets
> -  - "#thermal-sensor-cells"
>  
>  if:
>    properties:
> @@ -96,7 +97,7 @@ else:
>      required:
>        - interrupts
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> 
> -- 
> 2.43.0
> 

-- 
Kind Regards,
Niklas Söderlund

