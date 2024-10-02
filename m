Return-Path: <linux-pm+bounces-15042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83F598CCC7
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 07:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CE5284654
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 05:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DE681AD7;
	Wed,  2 Oct 2024 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOhJ05Yp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80D7DA9C;
	Wed,  2 Oct 2024 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727848733; cv=none; b=LLyeOGSDAuVaLripYDVKFTzqpJHFUDEDS+eGgtvhGtwAUgGoy6a1lit4rDGb5upFF5Fqi3cs97qlG26sumHutmJPcK+L7saxYDJxQ47PY8tVMMTtYR8HRnSH0PVc3OvR2XYpvJqKbcHmX2gGE6PbkMvglp4QxTAHclo0VmQxT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727848733; c=relaxed/simple;
	bh=UOTl03DOOV7SlDAksJvetAb0xk40DOwnob6rAZ9l/5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbJNqXNer7RFNiYNKwXYhQFgeUaBYm0a1u93CbHIrad//V/pviBVZGS7yGc7IN/tg53F1gK2PjsiTGaQsjhs3zisO/ruX69A0AQa1owEYxNoCo0yN06nhsw9nVvdFfvj6B6Jusin1JcTbrB9A04094OZzvzXgf0NhEyGoHe85pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOhJ05Yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688A0C4CEC5;
	Wed,  2 Oct 2024 05:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727848733;
	bh=UOTl03DOOV7SlDAksJvetAb0xk40DOwnob6rAZ9l/5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOhJ05Yp2U95NcHq5xvxPz524T5XJsV5gyevoSqlBBh0itjEHf16irh8ZyafHjjGh
	 2A3DpmbsPH64CkqRUKyGSgLf0xciig5zUAaHn1KVHBSelzV6KS3fPrcbl3VayNnJjT
	 lYtWDR++NzQ2/+KGhZ8mxa02trqG+sfiuDKoaFotDg5ypzTpfBk4eBzzUToOv+z7af
	 rhGmViMIEa4WqPUcLNdEE1nzyjDV8F9Eveu3Ud5jlxg6h2StQGESDAHPNqdNOuFage
	 ROkL56BAuEJHTCNbPoiUD5PolPneZdyH7fQmHCj6MSwAxmA7gvLOQa7lkh5wsO+JmE
	 Yn8+ln5kheKhw==
Date: Wed, 2 Oct 2024 07:58:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v8 2/3] ASoC: dt-bindings: mt6358: Convert to DT Schema
Message-ID: <kofbpvthmbzynfq2l4x3sxznuzrfcp6qiy4dddfuomdyjpbons@xoze6bxytw56>
References: <20241001104145.24054-1-macpaul.lin@mediatek.com>
 <20241001104145.24054-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001104145.24054-2-macpaul.lin@mediatek.com>

On Tue, Oct 01, 2024 at 06:41:44PM +0800, Macpaul Lin wrote:
> Convert the MediaTek MT6358 Audio CODEC bindings to DT schema.
> 
> This change implements the following updates:
> 1. Compatible property: Added the const 'mediatek,mt6358-sound'
>    to ensure alignment with the schema in the actual (DTS) file
>    "mt8186-corsola.dtsi" with 'mediatek,mt6366-sound'.
> 2. Example: Removed the example section, as it should be relocated to
>    the MT6397 PMIC file 'mfd/mediatek,mt6397.yaml'.
> 3. Use filename 'mediatek,mt6358-sound.yaml' to align the compatible
>    name.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


