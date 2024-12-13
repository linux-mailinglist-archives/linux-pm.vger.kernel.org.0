Return-Path: <linux-pm+bounces-19207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF499F14DE
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1CF1671CC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600561E570B;
	Fri, 13 Dec 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EcCr8kT5"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF2188A3B;
	Fri, 13 Dec 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114188; cv=none; b=dpAoIhYabjwR4OuT1ZmMsgJHJYnl/y05BGKmrYfrlyR8HQShy9ct3cwnLO9kwuerJyJC15cI3QcBhAV+V/lNKgNmfyDa265WMVv/9lhfGzU91mre8xDLi3JPTzLRTMvpy4n0AdtFEdy+96NBU72KQ33yKsRID45xIo+wGnU0sBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114188; c=relaxed/simple;
	bh=GiqVSUISJqJr5NiO8mWU9AKAaONp+d/mksQ49e50zm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIOsV98XSH/VZdQCUIzcPtXfSh9HWTOEBBldtA/DzdFErtjmg/vO0veMXnsDWMOVd1rDan7+KC63aV/JkTtPuAsZPTYYTxBpzOo1zUGcZxfO6PYTer5A1GBoHOI+hMKy/T6zHKC/nH4p4vlmvC3NFJEuJV3ErpafPtsPMHkRd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EcCr8kT5; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i3YibXlXnh2nxnKraQDFOv5AxvjsQSovo3m91FxIX/E=; b=EcCr8kT5LaBT0fWsCrzlHiDjVM
	wMpYf4dYNpORW0wp2+AlVVBHRZYQrQdLli0jqD5dCV0mCDe9pdbRssQasOALVpAkkX9S82rGvk6Mv
	P3jTVRsraO0MdM0uHxBZ6l3iUNckAA9J1XG3ubEx63BeffX6bGu05/bPSZzD+V7c/eZKHq/3WfP+R
	5RZqWzvdEvDavL7l59FVJmdzO0e0C8fOe1RW5moZErd4uY25TAK6EtzwelXWhYyFW/jyRNM0H8zKr
	GZMk0lSsr5o1X4dYTb+7nZYQZzSydDPM3NnVmd//vHXfdEpIlfyP5cLrfkY20N/BZ/aNRI9bTCWKX
	qPKb6DUg==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tMAJR-0008Ao-8N; Fri, 13 Dec 2024 19:22:53 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, Shimrra Shai <shimrrashai@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 Shimrra Shai <shimrrashai@gmail.com>
Subject:
 Re: [PATCH v2 2/2] dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
Date: Fri, 13 Dec 2024 19:22:52 +0100
Message-ID: <1908542.tdWV9SEqCh@diego>
In-Reply-To: <20241213180855.16472-3-shimrrashai@gmail.com>
References:
 <20241213180855.16472-1-shimrrashai@gmail.com>
 <20241213180855.16472-3-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Freitag, 13. Dezember 2024, 19:08:55 CET schrieb Shimrra Shai:
> Document the compatibles for the new board.
> 
> Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 753199a12..9ee96acdc 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -190,6 +190,11 @@ properties:
>            - const: firefly,firefly-rk3399
>            - const: rockchip,rk3399
>  
> +      - description: Firefly ITX-3588J
> +        items:
> +          - const: firefly,itx-3588j
> +          - const: rockchip,rk3588
> +

looking at the product-page, this is not _one_ complete board. Instead
it seems to be a system-on-module + baseboard design.

It looks like it uses the Core-3588J system-on-module [0].

We already have a number of those in the binding file to take as example
on how to structure that. For example FriendlyElec CM3588-based boards .

So you could do

      - description: Firefly Core-3588J-based boards
        items:
          - enum:
              - firefly,itx-3588j
          - const: firefly,core-rk3588j
          - const: rockchip,rk3588


Thanks
Heiko



[0] https://en.t-firefly.com/product/core/core3588j



