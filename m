Return-Path: <linux-pm+bounces-40786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC8D1D201
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 09:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF4A300A37D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 08:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B737F117;
	Wed, 14 Jan 2026 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oIPu0WZ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97461313E38;
	Wed, 14 Jan 2026 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379567; cv=none; b=pR9BwwMNVZX7cAWtR7xQIu3ZLC4USm7D2vcb7IIJgM/NUGudhtwZzIRZRdZyg7ssLy3J+lwOkXxzzcB6EM+vds7MPXTT0dRbhap2FF5Jjp0T/Uv3Jp+Ka2CyEUV9q78xt9RykTb+KhAngyWtSfjq7olrx97BQyXtYjSnEa/eA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379567; c=relaxed/simple;
	bh=RJ3P574FlAZERZAookuqu7G/qskejska98y0K/BBMrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EzzZU7nSpu5KpMWPk80+H70+4qrEZH5M0sPDy1JvCynmlBe93D/J/R735Z0ywyyJHyT2GCv8Q74Fp7+y0hHdTNNXC/ffhHp7eaBO3Wl6+L54XOqcoQOUO7tlh09My1MAE5BzdDAtZnPg0UigVSH24CI9OZ3vFQVOopFGrenBhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oIPu0WZ4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768379562;
	bh=RJ3P574FlAZERZAookuqu7G/qskejska98y0K/BBMrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oIPu0WZ4g0LaxJFYhidwQ794+AoBt7zpxZ1MTVCOTfFRvyg5JKPv+aRq/+AxJOIYz
	 g7H5bHxO0wX+v3BEBFsRPfa0a/tn6FxoOMPn8JmxCQT5tYZw+KAE824bPHo7NjOqRg
	 nwP5cu/HjRbgbWOozi2YRVsz5hKaenPEEfxYGD3dREko/JWRZTtgPl2Chf67UpfbXm
	 59lqP7spQwl7Qoq8NF5POSvT7OihCTzBJ2FPBiF4Yom+7/sn/gs7Jr9Ad890gJURvy
	 xMSooIW1RGF4e+LW7pKoEisDeR3aeGJloBu9jJLkXYb9kgNETiD0G+PMQ0tdxZ4ukT
	 KqcbqsBxiwDng==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E0B6417E01E7;
	Wed, 14 Jan 2026 09:32:41 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 sen.chu@mediatek.com, sean.wang@mediatek.com, macpaul.lin@mediatek.com, 
 lee@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com, 
 broonie@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com
In-Reply-To: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
References: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH 0/6] Fix dtbs_check warnings for MediaTek
 Helio X10 platform
Message-Id: <176837956184.8998.8649107668672128960.b4-ty@collabora.com>
Date: Wed, 14 Jan 2026 09:32:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 13 Jan 2026 11:59:54 +0100, AngeloGioacchino Del Regno wrote:
> This series fixes various dtbs_check warnings happening on the MediaTek
> Helio X10 platform devicetrees.
> 
> Depending on correctness, either the bindings or the devicetree was
> changed as a dtbs_check warning fix.
> 
> AngeloGioacchino Del Regno (6):
>   dt-bindings: mfd: mediatek,mt8195-scpsys: Add mediatek,mt6795-scpsys
>   dt-bindings: mfd: mediatek: mt6397: Add missing MT6331 regulator
>     compat
>   dt-bindings: regulator: mediatek,mt6331: Add missing ldo-vio28 vreg
>   arm64: dts: mediatek: mt6331: Fix VCAM IO regulator name
>   arm64: dts: mediatek: mt6795: Fix issues in SCPSYS node
>   arm64: dts: mediatek: mt6795-xperia-m5: Rename PMIC leds node
> 
> [...]

Applied to v6.19-next/dts64, thanks!

[4/6] arm64: dts: mediatek: mt6331: Fix VCAM IO regulator name
      commit: 178c08fd8ce53c77910fb16cc99e932049b6c6e8
[5/6] arm64: dts: mediatek: mt6795: Fix issues in SCPSYS node
      commit: aec5445dd7c8c6c84d46f2dbf07967ac54393595
[6/6] arm64: dts: mediatek: mt6795-xperia-m5: Rename PMIC leds node
      commit: a40901fe6f5c27856b7112a6e635b13446ec4c7b

Cheers,
Angelo



