Return-Path: <linux-pm+bounces-20164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B794EA0833B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 00:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59643A364B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 23:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9011C205E1A;
	Thu,  9 Jan 2025 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oBB+UDtl"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF469204F98;
	Thu,  9 Jan 2025 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736463792; cv=none; b=afJ1G0uUa2nmcs0bc/ZidQN9js1f66DkXLzZ0C5qzQPjzHH32UuKEKyZozLeETF5FtkmfWte2ainr0Hh/jGaRY1349pWIme/C1U+2N5ojzDQ5KEq7CqD70RHUsdZbZzCUxie+3YhnH/hVeAWHIqOIpCe7kvZqwQvJPAIE/4s91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736463792; c=relaxed/simple;
	bh=J5pbfu2P0SRouzuCOwQ6Fg1ZXF6bjH6Vvi/1m3tza4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJ5eNXRMGAw+G1nrvag1Cqt8TDfGq23Ak7L/O7v31qClRs8jAeWvLGLGre9fuYfbv1FdAqY9U2C1XqV3jbDXn/mU4/NaP/4ahXZSdWHQhxv56lJgYQF3uS6/KYFdNXjT85OPzbO+B2OX3E+SrRqkIfcAJIMPodwmYf7Mm0oDpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oBB+UDtl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2Hc9m1dPBDPuWb47dArImrMSzilYfkcFH6qpnwe202U=; b=oBB+UDtlo9fsDTebtDxQhn7Nwm
	VKSxQCiJa5SPi0oW7hlItnioj/0wI8JwrcvxDaLtvGdFsFHWCb5KOmX7ClMseKRNv7Wz63nrRA0aH
	v9GacM01qGUr/QxcjQwfkp7Y7XLFORZnvt2BMrkKHhn5lE/NjizZY/zciikJcplKNCH4Gqb2jW4Js
	9g+Wf9Q5SPYl6g4p07DZfTvBgM7q6lxACDf5rVl4z3IB41nRugDEzZGKSptD3xK+Y0sPEXwJFlmHs
	MAoEso/qR+dr0XXBcvPh3vi+gcLHCzPFip6DsShz/68IY+aH7PGIcl28OYAG94aKMU+1YdvSfcUr1
	UagzyiLQ==;
Received: from i5e860d05.versanet.de ([94.134.13.5] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tW1YT-0005pB-Aj; Fri, 10 Jan 2025 00:03:09 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, Shimrra Shai <shimrrashai@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh@kernel.org,
 Shimrra Shai <shimrrashai@gmail.com>
Subject:
 Re: [PATCH v4 1/2] dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
Date: Fri, 10 Jan 2025 00:03:08 +0100
Message-ID: <2999810.o0KrE1Onz3@diego>
In-Reply-To: <20241216214152.58387-2-shimrrashai@gmail.com>
References:
 <20241216214152.58387-1-shimrrashai@gmail.com>
 <20241216214152.58387-2-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 16. Dezember 2024, 22:41:51 CET schrieb Shimrra Shai:
> Document board compatible bindings.
> 
> Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 753199a12..fc7ee86e2 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -167,6 +167,13 @@ properties:
>            - const: engicam,px30-core
>            - const: rockchip,px30
>  
> +      - description: Firefly Core-3588J-based boards
> +        items:
> +          - enum:
> +              - firefly,itx-3588j
> +          - const: firefly,core-3588j
> +          - const: rockchip,rk3588
> +
>        - description: Firefly Core-PX30-JD4 on MB-JD4-PX30 baseboard
>          items:
>            - const: firefly,px30-jd4-core-mb
> 

In v3 [0] the board dt-binding got an

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

so Krzysztof already noted, please carry those forward into new versions.


[0] https://lore.kernel.org/linux-arm-kernel/x7y24y3bkbj5fzx5pdprjr5umg6egxsy2xscfbj3xgzgzubvdk@ppncjiqoekk7/



