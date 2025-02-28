Return-Path: <linux-pm+bounces-23206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE80A4A4FD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 22:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397707A4AFF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2511D7E5F;
	Fri, 28 Feb 2025 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCerUwiq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8781CAA74;
	Fri, 28 Feb 2025 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777787; cv=none; b=O8Gapm3pvAsh/95PtB0I32Do7C35C4OjGmT8W4S6xl709tydU6B2FZaGi5hc4QpCz7DIzrn+sLu2VKbz62ZhJ93vf6+Xv2ZXk2UrWzNTBcOsH60gpTL+zd7R3EClSE3Bd+FzaCzh8XhW9ySjeYU77yiJ7UJJkW70AAC8qSYQRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777787; c=relaxed/simple;
	bh=pPhg3oNE6NxT4rC2ot9DW+HPkCoU/NwpAONXXchEa5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdMWXiMOnw0g29UJeQAB/SvILiby9DkF7eijX4ccckQ94feU6JlF6/4RfR5ozlkT5LpzuROOorJZv4nmNpJeyxohL2VpwtqqN0fu2Xr+X4qtFWnnC+YyZ4uI1Mow/CXxkvoFufvlb+WAKcbAFxA8EIVTfD7KrwVB/PwyH2a3Rdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCerUwiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C923C4CED6;
	Fri, 28 Feb 2025 21:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777786;
	bh=pPhg3oNE6NxT4rC2ot9DW+HPkCoU/NwpAONXXchEa5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCerUwiqo50WYbj+/EYFOBQtg3Hw8hKteAoVF2mEuBYCNynj8Zjsu6/2Tc7niJ/Bv
	 a5wm53RvhGQf3yyteNZcQZ718t9Wc7wQXPyrXEzMG76MZBD2m/fBd5bE6Ofkr6/IBv
	 Xp2nu9jrU8uJlGrehp8hrQz2XAlo6LiJRWpisXsMgyHXQixP2IRaixz3PbCAmkEu1Z
	 40jDLCj4QJS0OkvjZ+XDilgbEfzuu+zt7+f2JRbzLg9qqRN5Y7Hv3q3I9evHGhxmDx
	 Nb4Yc8iMwu9CdEI2Jzsx4FZU45TTzJ1fdem/zKlHCi+UpEwipToaTDi8GJQDEYlBDm
	 lZyRhI5G+4+8Q==
Date: Fri, 28 Feb 2025 15:23:04 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, krzk+dt@kernel.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	sre@kernel.org, devicetree@vger.kernel.org,
	nicolas.ferre@microchip.com, linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev, conor+dt@kernel.org,
	linux@armlinux.org.uk, p.zabel@pengutronix.de,
	alexandre.belloni@bootlin.com
Subject: Re: [PATCH v3 07/21] dt-bindings: at91rm9260-rtt: add
 microchip,sama7d65-rtt
Message-ID: <174077778429.3739910.8784445067469354265.robh@kernel.org>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <5b365a63d2124ebf27aebb0ec8395b1946e6c070.1740671156.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b365a63d2124ebf27aebb0ec8395b1946e6c070.1740671156.git.Ryan.Wanner@microchip.com>


On Thu, 27 Feb 2025 08:51:54 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RTT compatible to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


