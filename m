Return-Path: <linux-pm+bounces-21161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F32A237EB
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 00:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432D216236C
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 23:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3911F1532;
	Thu, 30 Jan 2025 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKxSJRTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB1139B;
	Thu, 30 Jan 2025 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738280101; cv=none; b=VqOTj0XHqlszQKErOkK7n4P+YGFGj6au0nFxNbzBdwZP+QH/PuvEkN5Tobig1eqMeOiEVQKJldtkVw9QCkE31eNtAe/IxImzmCDLbn8rTmT2NTyvslXkWakz9bJ7xoFfqtIdgyDLxIsBINqKe1rjsFEgSR9yZnrC/fcq8dVvCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738280101; c=relaxed/simple;
	bh=vhCAXi5gATiTUMD6D3daRi6pgOs0C1CHPFUGunc9oCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKDTSyMImQneO319HAlRgz96aCi7lkDCvq/8M7l/r6U4yr9kmRkVspjIhCHCYJBuVtIr8/Nb3livFrf0UVxAU2vfILVrD9mKGGztIKrsCODOoT4FcPyiYwmnw/peWftpV5mIMRxBdb8vgSAaKq9u/1Rc800sVxYjKgoohws1rfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKxSJRTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911D7C4CED2;
	Thu, 30 Jan 2025 23:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738280100;
	bh=vhCAXi5gATiTUMD6D3daRi6pgOs0C1CHPFUGunc9oCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKxSJRTmiqLshyZAuW7i+DWArHiaKThgo09MstJssF1KXGMwY9uwBAsvlCO835a5Q
	 ORK19yjfzIdV+bR/kSpvChLZgD41hs7VIMyZOJQOgYYVlgKS/gewfe0KavAMWuuv1A
	 qzunCkmpnAHfhRReTSflacNnACpQGFrDob+FSmO1DOUZz1cAfkeSvnS+rg9I9UQltT
	 PMw2DpA4MoiPjSTniKRCEjaTx/oc5rwmVlcg0uvyytF8xygTcLMcIs8zX597+v1LJB
	 1pLQWI0k/UL5i3qwXebK5gV9vAWM2DsEfFEwRKUV4UzYgZVUjV4f9s/p18QOZGBsvP
	 pMhnvdGu5GXrA==
Date: Thu, 30 Jan 2025 17:34:59 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, lee@kernel.org,
	nicolas.ferre@microchip.com, sre@kernel.org, p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org, claudiu.beznea@tuxon.dev,
	linux-rtc@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 03/16] dt-bindings: sram: Add microchip,sama7d65-sram
Message-ID: <173828009922.1871682.9459658667498984650.robh@kernel.org>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
 <e0cdc69ebb34b71135321841a0fe682ede104d79.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0cdc69ebb34b71135321841a0fe682ede104d79.1738257860.git.Ryan.Wanner@microchip.com>


On Thu, 30 Jan 2025 10:33:43 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add microchip,sama7d65-sram compatibility to DT binding documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/sram/sram.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


