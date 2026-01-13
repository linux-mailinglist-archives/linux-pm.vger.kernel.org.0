Return-Path: <linux-pm+bounces-40767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9184D1B6C8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 22:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D89263037398
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 21:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E11531DDA4;
	Tue, 13 Jan 2026 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEfwqBsi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B022D7B1;
	Tue, 13 Jan 2026 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340157; cv=none; b=HzvtMivLvVbJDPRAy+EKYPAiXkLbDd4KTjZi60oZoZ5Sqg5PTTAMTgBenljZp5hlNVdeh1mVvOpsbjMgdXl8T16If/tfs5qZrui05TT2Xy3o2wgU2n7VvrG8osYkadq5R6vuoGOw7m2oT+NglbGi3AKRAAAixuZR8moFYq++7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340157; c=relaxed/simple;
	bh=OS4rK1JpIL2tCKHvZYkTq7ert1jUWu/mrzJ2UfQFEoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL9+AIKb6w+gHG7Sv9wSCZJkIARnXZTBuBVdjvBohD7/+oZV8TaaXeshxDcd2PwNhQaZXqBfD2FjbD5Ep7OwEKEgOKULNg9kFdiO4fXdO9JlL+oTsHcH3WHX7je/1LIbpkbVUT7RSWEVHLsyfIL3zuy3DWBTADe+uJpv7Lx9Wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEfwqBsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0369C116C6;
	Tue, 13 Jan 2026 21:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768340157;
	bh=OS4rK1JpIL2tCKHvZYkTq7ert1jUWu/mrzJ2UfQFEoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEfwqBsivmfsVpYNPb4w9WcETiTFSM8PtivcaexoMCZxPCIHO41iEy8WqxeI3RoWB
	 eUiuEHvKrxBFgN8pJ2IB6JcmN+5UnIX+NPh5xapopDD6l8lt5LY/EJjCBfNcpqwnDQ
	 Ur/nVNRinCeRmVK6Qihoa2wTp6NPglxH2xnaofXUXjpjtyH4hZbfPP572xHDT+bP3r
	 Z8757qv5xILqVg6d1siuFQOp+IrzxKH6vBHctU/gkKqJlPuoqS5PHwPrlaW6/gl/fJ
	 cn91Jop/ClGjidwmcXScn7kIuidUvVmV98XZE0dllHlxsOrNiPHQcetgIg8m/QB2aC
	 e5Et9gOzwT2dA==
Date: Tue, 13 Jan 2026 15:35:56 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: macpaul.lin@mediatek.com, linux-arm-kernel@lists.infradead.org,
	broonie@kernel.org, lgirdwood@gmail.com, kernel@collabora.com,
	sean.wang@mediatek.com, krzk+dt@kernel.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	sen.chu@mediatek.com, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	conor+dt@kernel.org, lee@kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: mfd: mediatek: mt6397: Add missing
 MT6331 regulator compat
Message-ID: <176834015357.196719.2715657328472319678.robh@kernel.org>
References: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
 <20260113110000.36953-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113110000.36953-3-angelogioacchino.delregno@collabora.com>


On Tue, 13 Jan 2026 11:59:56 +0100, AngeloGioacchino Del Regno wrote:
> Add the missing mediatek,mt6331-regulator in the compatible string
> list for the regulators subnode.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


