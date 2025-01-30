Return-Path: <linux-pm+bounces-21160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AC4A237E7
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 00:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CEA18867A3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 23:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A21F151A;
	Thu, 30 Jan 2025 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi7bTeRG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B06512C499;
	Thu, 30 Jan 2025 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738280073; cv=none; b=LA/+GXjsQzbx0xxc3+xh+lr6E7sNEBzahiccuHt7X7AQhk01rWZT5Jgr+sVre1cjyb6UAXEwuDwEQGTXAhVBom2EkH5gOQqqouYfnGuDaypa3xKuSxPtmh4RuKQk1K2gOWJZuD0S8njLPtiisKl4OG5btNfNK2hc3Eu31ecA60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738280073; c=relaxed/simple;
	bh=SvCKCtR7UGZ+Y1cMYy78mpUqp9lj38t6CeQBwFBsKXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4DPFZdJj3bRZeGKydvgCVuXO0qnluJsbgGYCUPjvqE6gNFkXyg8ODdZYGdMto4NKUUncuWNOlGMfB7HDmrd20MkSF8vqPYt7kl2P/sp+k1f3Tl2dyD14iOTrgQ/BcpjibBIcugQ155LZdcRDGKi6gWAnaB79x34NtvkXOCvSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi7bTeRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FEBC4CED2;
	Thu, 30 Jan 2025 23:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738280073;
	bh=SvCKCtR7UGZ+Y1cMYy78mpUqp9lj38t6CeQBwFBsKXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oi7bTeRGYhjjZ18m4ZMzEz8+kPluUSawHBr+KPFE+gJJnmbYesxr0DXPv30bzsLJ0
	 eL+632A5bvWYQqaSCPjYFFa/VHR6/ZTTBHO1fbaC7vqsTn7knmvoJNu6B9e0+vVF3s
	 U+THBvtXeADJ8FYCc9lwafYCa6XrBKoplVvusiwDmwZSDCVJZ7+NaYiLjj6COcDcnv
	 TDHYwsohbBDzJ58jqF/ug4KlucIOeugF01zvriktmuGRN75wPiG4qR4H9oKwOZtA6P
	 1FdU8innTFD0HPzJ8xFMRfduXI62PlGdgp1X8mRRSpsO13AB3AMCkxosHeCGVVcevv
	 VHi3gGxi2EY+A==
Date: Thu, 30 Jan 2025 17:34:31 -0600
From: Rob Herring <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	claudiu.beznea@tuxon.dev, sre@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 02/16] dt-bindings: mfd: syscon: add
 microchip,sama7d65-sfrbu
Message-ID: <20250130233431.GB1868322-robh@kernel.org>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
 <c3f6fdf6a5b9e443e9ebbfbadd42f6d03a1190ec.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f6fdf6a5b9e443e9ebbfbadd42f6d03a1190ec.1738257860.git.Ryan.Wanner@microchip.com>

On Thu, Jan 30, 2025 at 10:33:42AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 SFRBU compatible string to DT bindings documentation
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 54a6d5957e13a..25c4ed6cbf5d1 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -90,6 +90,7 @@ select:
>            - microchip,lan966x-cpu-syscon
>            - microchip,mpfs-sysreg-scb
>            - microchip,sam9x60-sfr
> +          - microchip,sama7d65-sfrbu
>            - microchip,sama7g5-ddr3phy
>            - mscc,ocelot-cpu-syscon
>            - mstar,msc313-pmsleep
> @@ -188,6 +189,7 @@ properties:
>            - microchip,lan966x-cpu-syscon
>            - microchip,mpfs-sysreg-scb
>            - microchip,sam9x60-sfr
> +          - microchip,sama7d65-sfrbu
>            - microchip,sama7d65-ddr3phy

Alphabetical order.

>            - microchip,sama7g5-ddr3phy
>            - mscc,ocelot-cpu-syscon
> -- 
> 2.43.0
> 

