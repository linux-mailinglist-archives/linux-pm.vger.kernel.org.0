Return-Path: <linux-pm+bounces-30876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08819B06479
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 18:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41AD17CED6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2A8278774;
	Tue, 15 Jul 2025 16:38:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615024E4C3;
	Tue, 15 Jul 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597535; cv=none; b=GrtFsc4l8RJgRJFYyOUHmY32/8ggMazAF/L6YG2h05VsNhACTADPKW/xF1N6bmp4w7AGuTpI5wvq4A47w6T8Qcz0cUNTu/qVBZZDSd6xYiiMLmdkXOwEMzJPXbjYp+c+Z8OIH2S069U9AVtzBZGYNSCOjI7LX9meIny8MtjG7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597535; c=relaxed/simple;
	bh=yTNkTrNSuD5rMxG9KZhP2kLWVi6ZwlCkFnteRCfsMnQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CAIq7LKpkoAt1YbyHn5Uukjhz6VM/NjDh4CQYB8Gc03Acpktub3E6JLYZtmgQNwfsc/miyYHFGoHZB6hFhJ+Z3kMaM6vDfWhzU/aSZ28t+FbrjBR2j921TSw89go/fq56LwboqVS//A+wi3EeGC5Fv4hV0A8Z068F4kaL6+txKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31492C4CEF4;
	Tue, 15 Jul 2025 16:38:55 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id C986F5F7BF;
	Wed, 16 Jul 2025 00:38:51 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20250712074021.805953-1-wens@kernel.org>
References: <20250712074021.805953-1-wens@kernel.org>
Subject: Re: (subset) [PATCH v3 0/5] allwinner: a523: Add power controllers
Message-Id: <175259753164.2390274.11809107564152769710.b4-ty@csie.org>
Date: Wed, 16 Jul 2025 00:38:51 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sat, 12 Jul 2025 15:40:16 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi folks,
> 
> This is v3 of my A523 power controllers series.
> 
> Changes since v2:
> - pck600 driver:
>   - Fixed whitespace issue
>   - Added explanation about possible PCK-600 lineage and document
>     references to driver
>   - Changed Kconfig option to tristate
>   - Rewrote Kconfig option help text to make it clear that the driver
>     is required for certain peripherals to work
>   - Made it depend on ARCH_SUNXI or COMPILE_TEST
>   - Made it enabled by default for ARCH_SUNXI
>   - Renamed PPU_PWSR_PWR_STATUS to PPU_PWR_STATUS, and added a comment
>     to note the macro is shared between two registers
> - New patch changing sun20i-ppu driver to tristate, and enable by
>   default for ARCH_SUNXI
> - Fixed pck-600 header path in dtsi file
> - Link to v2:
>   https://lore.kernel.org/all/20250709155343.3765227-1-wens@kernel.org/
> 
> [...]

Applied to sunxi/dt-for-6.17 in local tree, thanks!

[5/5] arm64: dts: allwinner: a523: Add power controller device nodes
      commit: 3b430dce33a8b48ddcae4e26991b2516e0431e84

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


