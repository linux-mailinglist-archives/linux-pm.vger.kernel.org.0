Return-Path: <linux-pm+bounces-23203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C23A4A4F0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 22:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A5D16D30D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370C1D6DDA;
	Fri, 28 Feb 2025 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjrkcmpq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB761D6DB5;
	Fri, 28 Feb 2025 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777739; cv=none; b=ktMPhrLM1Ag3wVoTiMDUqWseo1E2xuftEWyZ2yXzmXDrCR69+2bjzCGQeuJgFwrS2CPUtUksGd+XsS1xxi/TWtFqn8zq1WhwUfFtAT3vwj5+gn1CMLzA3rYFwAjKunEinJtj4iG/75e0DYpjqOgMbUq9CEDUeBdqRvizxvii9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777739; c=relaxed/simple;
	bh=70t/oj00452ALapCWhpb/eHsdBwPEI85u4GX6Y1AcQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8YwYkkf6LBOKQaP9tSvPKJWHMo59AmC6AXpaFvE4rfX09lhFoyeVtCe1behCaIY7Jj5bL4XhUsIRv6assAHzdRf/y4WXliYvFH7WVNwf1SA8wyi6lcM5Z4SmzF4EwGgoSjRY90bejRf49hoNVrZskIze6v/wk5yrxTx0OIEBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjrkcmpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DC8C4CED6;
	Fri, 28 Feb 2025 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777739;
	bh=70t/oj00452ALapCWhpb/eHsdBwPEI85u4GX6Y1AcQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjrkcmpqky945mPdhuTZQytsXu8HJGALBLiuuU7MUlu/MV8L16JHuxcsFmT6hMGA7
	 2ESYG77gQzgGSypqcLdanLuDRxpHiQiIwGLeeLejkG+Huq+okjhoSpMB4i0RQouiFY
	 8tbyNN7TT90m+bFJDBU7tW3knESkd9jNWche33i8CGebdATFq+JF4bgi/QFT2AKEsH
	 Ry7WGYYLKsmbYVfyNyBE1A5WX4eVRk3ySeJlBK88kPS42GgQommsI5p/jDnknjyzI8
	 h73V6NDwB3BrHRmjVhpDoe0Sggj4kxD9++Mtd3Nr/oZKJtzHZT7pDr0xnXY32kSVtj
	 OEWJLEHzhlx4A==
Date: Fri, 28 Feb 2025 15:22:17 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: linux-pm@vger.kernel.org, conor+dt@kernel.org, linux@armlinux.org.uk,
	alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org,
	claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
	lee@kernel.org, sre@kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v3 02/21] dt-bindings: mfd: syscon: add
 microchip,sama7d65-sfrbu
Message-ID: <174077773610.3738820.3700947387806799800.robh@kernel.org>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <92543fcff4ab35e770b01d4c15d45cc5d55833f4.1740671156.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92543fcff4ab35e770b01d4c15d45cc5d55833f4.1740671156.git.Ryan.Wanner@microchip.com>


On Thu, 27 Feb 2025 08:51:49 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 SFRBU compatible string to DT bindings documentation
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


