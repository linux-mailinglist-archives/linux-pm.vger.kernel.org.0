Return-Path: <linux-pm+bounces-15738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9801B9A0372
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88DE1C2174F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522B11B21AE;
	Wed, 16 Oct 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1xcPC1F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1553F165F1A;
	Wed, 16 Oct 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065705; cv=none; b=quVMVq/37/z/nGyYbr7Q7X6SBmYN40Tr6zqTju8PCt52X3Kv3lITxSxzKE68SO+dsLX+OJuCooblAdlbfuHN4ou0oiYdL1HuYHeTefQk4ZX12fDtfgtGPmrYefhKUv9HmHPKXm1k8coQ7WHERaHfVvmpqef75cZZ2gUJ9vEVJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065705; c=relaxed/simple;
	bh=pgnglVAzXGWeon4rHJ4Kx6rcYL2QifFuXYmp+TSwhZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kzlj7Lou4BtJdWfo1YUkixzeIMp/+/wirCdMw5I7EpOKkDe3hafsLxznRKCTnoMHUFkZrdJ/kpJ26z/QfuehpQDgGAblkvGaXfNzvy4o7DVJmd+Msx0fPK/0vWZF7ZhqweKAktUI64dnBl9sd90IIx47h//dWDGQKejVjNbbpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1xcPC1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F72C4CEC5;
	Wed, 16 Oct 2024 08:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729065704;
	bh=pgnglVAzXGWeon4rHJ4Kx6rcYL2QifFuXYmp+TSwhZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i1xcPC1FYoDnq2vDB6Dn8+VXcxT6fsXr3uXUs6SupvmWvwUHhEinGQfkNJ/y8V/Cl
	 SeAkmvm0WMnu0rUpBLsazdxlxraBnjvVCq3a1gtxFBnuIsT2sre1xyukHqBaoBPmij
	 qelxExb1jKt4xXvNjZZkm5s3D+WRcZD4Rv1aVJnuoEULMbfO90G0XfytM9ONOsqCJp
	 FmIyYoiHVGvWa8G3k5Ba7QzE/BCdPlrTY3g6rfqwQE3XVK2dKFsRcN59/Z50vMK+vo
	 uLJgO+AsxsIzQHWqq5hUNvFJttccJfWdEMcjyjl+WsqUis6PMuuhPnnlhN78o54fVs
	 q5q+ZbigrgHVg==
From: Lee Jones <lee@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Sebastian Reichel <sre@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-sound@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20241001104145.24054-3-macpaul.lin@mediatek.com>
References: <20241001104145.24054-1-macpaul.lin@mediatek.com>
 <20241001104145.24054-3-macpaul.lin@mediatek.com>
Subject: Re: (subset) [PATCH v8 3/3] dt-bindings: mfd: mediatek: mt6397:
 Convert to DT schema format
Message-Id: <172906569700.1146121.13634550536849127452.b4-ty@kernel.org>
Date: Wed, 16 Oct 2024 09:01:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 01 Oct 2024 18:41:45 +0800, Macpaul Lin wrote:
> Convert the mfd: mediatek: mt6397 binding to DT schema format.
> 
> MT6323, MT6358, and MT6397 are PMIC devices with multiple function
> subdevices. They share a common PMIC design but have variations in
> subdevice combinations.
> 
> Key updates in this conversion:
> 
> [...]

Applied, thanks!

[3/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT schema format
      commit: 6e357f572638547e9c9e8d8abb7dc572c12032f3

--
Lee Jones [李琼斯]


