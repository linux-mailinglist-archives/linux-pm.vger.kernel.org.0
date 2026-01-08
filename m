Return-Path: <linux-pm+bounces-40436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F51D02ABF
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 13:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 031CE3010D65
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D555445EE8;
	Thu,  8 Jan 2026 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iPc+jDog"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F484418F7;
	Thu,  8 Jan 2026 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864541; cv=none; b=nK6OROcB4oONe/L7Srn0HJ9g9Tq20aHXtN/jNSEsf1fEcmiGPtVkCJYEf6N4yadlcoQ0jNJ17bjYemuEQfU8H7M1U9gb0br1rmd+fGSCCnqlLMYL3DN6xhitcAvGh45mETBiDiG4xknSysu7sh6GznfsRlvSmdJ3DDGo4K15xdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864541; c=relaxed/simple;
	bh=MYQM/u3EY2aksYdZVVDQjWmMTOdhULDevRcaPw5g3Sk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fLA/SuZSUuoYXMiLMx0rRuJmdpMM9OaVpNjHxFkS8hM/2vvwuTARAiLwkwaxFTz7z6MqihjoGOQTYs05XeDc4WxDHZKyLZuxJCGY2mDGN0VAp+8FviynHL8IzWjZ+lHZyqcRoh6+orGaxGKlIGCuBX4O1VwirQXoWQH4rkGVBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iPc+jDog; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1767864530;
	bh=MYQM/u3EY2aksYdZVVDQjWmMTOdhULDevRcaPw5g3Sk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iPc+jDogBmFyzzhHYT7Ep9dE/ld5l0S8ReDISfgBgFcGREHHORiJCcpIJFjRtOgkt
	 IHE5jIQNC7lrcRE7Ct9V4xUY+wc5M6udotNherABvuZlME+FMu9bwij8zpPFIXXYOV
	 YR/Q2GuyLyMC6oZAZHI4fLCNqcx3jTFP6Ptbz/jLN2hEHJhXmsNNCoQBBS65pfvNds
	 Nqp5QPtexTi7+t5h35a9CUYTiZiMlaT1jk97oHZTKH0uOoSYrlfLTzwpq5s51OGvKX
	 z+bBr89wM3t/bxYCOmT/hkp/2YEgGETyDyz+Jaa9Yk4Z3G16RpztdKNCIARA1HhUH9
	 7gco2hkuz9pcA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 073B917E0ED3;
	Thu,  8 Jan 2026 10:28:49 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
In-Reply-To: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
Subject: Re: (subset) [PATCH v2 00/13] MediaTek Interconnect Cleanup and
 MT8196 Enablement
Message-Id: <176786452995.11151.4722650468329780903.b4-ty@collabora.com>
Date: Thu, 08 Jan 2026 10:28:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 24 Nov 2025 12:06:49 +0100, Nicolas Frattaroli wrote:
> This series is a combination of binding changes, driver cleanups and new
> driver code to enable the interconnect on the MediaTek MT8196 SoC.
> 
> This series currently does not add any users of it (i.e., no bandwidth
> requests being made in affected device drivers), as the only one I
> quickly whippd up is in the UFS driver, which is undergoing some major
> refactoring upstream in a different series of mine.
> 
> [...]

Applied to v6.19-next/soc, thanks!

[02/13] dt-bindings: soc: mediatek: dvfsrc: Document clock
        commit: 831ee17036e259da23a6313e28a3cbdda221a88c
[04/13] soc: mediatek: mtk-dvfsrc: Change error check for DVFSRCv4 START cmd
        commit: 23f1b4922a9135515e37d3bbad766e311845071f
[05/13] soc: mediatek: mtk-dvfsrc: Add and propagate DVFSRC bandwidth type
        commit: c2488fecba681d632a3dbb6b2f33c39df2cb7be9
[06/13] soc: mediatek: mtk-dvfsrc: Add a new callback for calc_dram_bw
        commit: ddb5862a43b1f40ca0a5cc16882277d8d07b966a
[07/13] soc: mediatek: mtk-dvfsrc: Write bandwidth to EMI DDR if present
        commit: 7cf9db2aca552f5f537d46f1e52e0ab08ddc2d64
[08/13] soc: mediatek: mtk-dvfsrc: Add support for DVFSRCv4 and MT8196
        commit: 75cf308fee7e4b3038741f96fd90afc3bd871e64
[09/13] soc: mediatek: mtk-dvfsrc: Get and Enable DVFSRC clock
        commit: 39aa8c4e762ea9b00d66cc55957527167ed89435
[10/13] soc: mediatek: mtk-dvfsrc: Rework bandwidth calculations
        commit: 3da293d70005496317d1ff3a49b89c29dd7c21e8

Cheers,
Angelo



