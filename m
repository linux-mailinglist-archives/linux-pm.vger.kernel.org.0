Return-Path: <linux-pm+bounces-14359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4284497AD83
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 11:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D6F2831BF
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CEF158D6A;
	Tue, 17 Sep 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S5RMeAyL"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B50150990;
	Tue, 17 Sep 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563881; cv=none; b=CYyON8CekeyrDP76HlJBp7l5++G+vONTwY8B5hc0cX4rfWG12VhjU7kclQHeDanaJybEf5v0T6J0D9bFyNAjD/3h6APpW7U4bLR8piGKKMgNFchAliMnhtAPY3AiPOegPiWhf7xeKVmcow2u+QDXNDFZtufEyZSJwcuR5kzdDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563881; c=relaxed/simple;
	bh=5NCGPiERJ+Jw5qTfwSzmHF6iCdF89H70h6XEILDhTIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/Pnp9DC411k1ssPzZJK3nXdGPGila/tMSTbGu9N2R/Tm8jrsVraFkFYhkfQz55a804Moh2E0iwt2UbBEiaJWD381/OTFfupR7Skz4ELc21HtcNCdYAPFP6TofbLhbGK1VYMzuFZ5qqifXVwcXsmfhshxK4IpO+jOjs/pOdtUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S5RMeAyL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726563878;
	bh=5NCGPiERJ+Jw5qTfwSzmHF6iCdF89H70h6XEILDhTIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S5RMeAyLuLMXAZ2qIVHPpQd+yUU7hN6A9HmCHPyK3f/Qm4sqiXA2P5IDtgTO6x+CA
	 gY9CznaCeUisJIeO7nOfj9MvveNWSI96sSPNWHDMTf3HO1lOXXEQRXgs5Yqo/VIw5X
	 3EzWC/6RCGN4xCicPAKEqbaYzsy4XIpR/EkE432JijXfSsEhiXKuuC9+tPDNxLdUP9
	 P2OUxIR7t8sYk+AtNUm9IrY+oLh5bnYHNEyiwHQBNPsef5b7lGbZhtNkygfnOFy3FJ
	 TBSgxGOyL/YUvetV7okyLSdFBN4RSsA5Dt9gxfphjhOQY1Y6C7zN9zLm2AD/oWg5TP
	 R4jGK++Gne67w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ADEF717E107A;
	Tue, 17 Sep 2024 11:04:34 +0200 (CEST)
Message-ID: <08bdcc19-023b-4c7d-9e01-2b04cac00a08@collabora.com>
Date: Tue, 17 Sep 2024 11:04:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] regulator: dt-bindings: mt6397: move examples to
 parent PMIC mt6397
To: Macpaul Lin <macpaul.lin@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sean Wang <sean.wang@mediatek.com>, Sen Chu <sen.chu@mediatek.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240916151132.32321-1-macpaul.lin@mediatek.com>
 <20240916151132.32321-3-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240916151132.32321-3-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/09/24 17:11, Macpaul Lin ha scritto:
> Since the DT schema of multiple function PMIC mt6397 has been converted,
> move the examples in "mediatek,mt6397-regulator.yaml" to the parent schema
> "mediatek,mt6397.yaml".
> 

You can instead just keep a reference to mediatek,mt6397-regulator.yaml in the
"MFD" (pmic) schema instead.

It's true that for MT6397 you can possibly have only MT6397's regulator and not
others, but still, the logic is to:
  - Say that MT6397 supports regulator subnode(s) in mediatek,mt6397.yaml
    - Refer to the regulator schema (mediatek,mt6397-regulator.yaml)
  - Keep the regulator schema (providing only regulator HW specific info)
    in the regulator folder.

Besides that, this also makes the main mediatek,mt6397.yaml schema a bit more
human readable... :-)

Cheers,
Angelo



