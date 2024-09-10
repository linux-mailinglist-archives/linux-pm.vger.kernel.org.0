Return-Path: <linux-pm+bounces-13973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094A69742A5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123031C26000
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941E1A4B6E;
	Tue, 10 Sep 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="d5doWuWc"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D071A4B9A;
	Tue, 10 Sep 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994228; cv=none; b=HOsrJb9E2ZIaDIh9GhpJVXMrX5AJP9HDfaaf7IjgF2CtfVH2uPl1EDMU5Z38FDK7tShkKWl6Hi2rTDFMzWJbLnlfwmQTccU/DAcU2bbKRVhwhh5G50A9wMdA59uAozx2cog7UxB00CsfdjR+WnWFCO1CgeDV0kDacKPCY56+6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994228; c=relaxed/simple;
	bh=M05YHNvqt/iWPjL5zCqYW5mTrv4K3HGohGCRvgAHV8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tj6alS44KNdPMK7kYrKnZ8/CKivLlxf7ukA/ohDLxgs0Sfhp94SUVqPtoTA5fFFWnyIg7qEJuqsi00hHIAQVnS6zsgIjayQvoKpm7Cv9VjRwJNOFDUWWDqy/DEJrOygcjV/WQthD1mdLy/QFYBNj8b6XzDyFGjyZY27hyJuzYx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=d5doWuWc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sx4FZQB8RHe3sA0KWr5nSPb/p5+LM+1JV9H4EShfOOM=; b=d5doWuWcHSbAkOJjGwQvsnD3Vo
	OTFpvF7F97FHE9ve8FsxD0zuUG2fFhSBoxbpiY6lhFxGAoBqaednIKatNYK91XEVgxHiX8POPvNBZ
	0WjIsH1aqvpa8D9rOO4qA50qKwCyUrHaMvwwPj9CyCbNLDum8x5Z0mMUFRkV1XhdEadZD9Hn6bF+o
	iJk9dyr1xM7dBIE/069+/jT3IjSCeXT/bxIK64Q925tLlT3q6PB67xSr6hsDhCL3gaT2kmdohVQJ8
	BTumjEAukRuoKEb0afjJ2XEpNSDH9/DeuJh8kYaGNe97cNWsOksqRX6spTSxchzXxW9zD6Zvg/fj5
	bA1n7VbA==;
Received: from i53875a02.versanet.de ([83.135.90.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1so5wQ-0007c9-Pq; Tue, 10 Sep 2024 20:50:18 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
 =?ISO-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject:
 Re: [PATCH v1 4/6] dt-bindings: power: rockchip: add regulator support
Date: Tue, 10 Sep 2024 20:52:47 +0200
Message-ID: <2373450.IPqQCg1nHW@diego>
In-Reply-To: <20240910180530.47194-5-sebastian.reichel@collabora.com>
References:
 <20240910180530.47194-1-sebastian.reichel@collabora.com>
 <20240910180530.47194-5-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 10. September 2024, 19:57:13 CEST schrieb Sebastian Reichel:
> Add optional support for a voltage supply required to enable a
> power domain. The binding follows the way it is handled by the
> Mediatek binding to keep things consistent.
> 
> This will initially be used by the RK3588 GPU power domain, which
> fails to be enabled when the GPU regulator is not enabled.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

That we have regulators supplying internal components in the soc
is the case for all Rockchip SoCs, though it looks like thankfully this
hadn't bitten us before.

So having the ability to define those supplies makes a lot of sense

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  .../devicetree/bindings/power/rockchip,power-controller.yaml   | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> index 0d5e999a58f1..0b4c5b174812 100644
> --- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> @@ -131,6 +131,9 @@ $defs:
>            A number of phandles to clocks that need to be enabled
>            while power domain switches state.
>  
> +      domain-supply:
> +        description: domain regulator supply.
> +
>        pm_qos:
>          $ref: /schemas/types.yaml#/definitions/phandle-array
>          items:
> 





