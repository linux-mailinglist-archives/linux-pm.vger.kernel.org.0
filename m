Return-Path: <linux-pm+bounces-15407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56889970DC
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131761C2209E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EAD1E3DF6;
	Wed,  9 Oct 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azT6oxO9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A111E0DF0;
	Wed,  9 Oct 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489153; cv=none; b=BaKd1ajzjtRR+A3YUC9hmd2MoBlpboy/SJ5XYA1ySZElokuEfdIaLg9PutG7GWsZaQMoG/ggYUFt0NM8gDQbIRxD1DpMemZcBdMRytgdlI7TkEZdbtLRJsy5Qt2JYZ0JxBgIwl6dLtAXO8dZRjbGqGItP66IG97/EltdI66wD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489153; c=relaxed/simple;
	bh=3opAzplvKjVglSivCDPrg441vYhzAuPR3tmj9pIPgGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jicJwHVz9dEGsvLxYMifNery/UP2s2by2xhiiqGYCSActwMyTSMGy1qli72V+iK5U98ozYPc2iKamd3K2Zz04liTL86/1kPyUH9SzsgLSGFKJcm8fWZqdsiEGYYZYn7lNiYjaYZfr19YJmELVEcjMnmmGxbyvNjEQqhkWZ+HDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azT6oxO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858BCC4CEC3;
	Wed,  9 Oct 2024 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728489152;
	bh=3opAzplvKjVglSivCDPrg441vYhzAuPR3tmj9pIPgGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azT6oxO9H+KxyL5DtHqGVzaw6VvkwhCRZgi1s6K6jyeWDPYKNq9NU8WNE4Y7aZ/SL
	 UG+VkA3yrXSNOTlFfHz4zK+Lm4pTxmHvfewkwPfhfg3fYwpSSE+83fbfkcd3HpK1vP
	 Xmjx8YBICRi9S1DP9dYVz5AN1Edh1ISqu4+QulIRl5vZCf4SWU4b+fTrh+KanQLlqb
	 Vmyx9hwwbV42F+c4A9yUYZFeFg6d05ibkOE6QMLn6bQ4ir7OERXL79h7LJYHSPZtd/
	 oFM6PIv8M335szmQLptKsy/a99iR75ThRECQ6gcjWw+/lOSTHh9ZjK+o75IJCDI4fn
	 nn3obwpSqL8Dw==
Date: Wed, 9 Oct 2024 16:52:22 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v8 3/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Message-ID: <20241009155222.GB637580@google.com>
References: <20241001104145.24054-1-macpaul.lin@mediatek.com>
 <20241001104145.24054-3-macpaul.lin@mediatek.com>
 <5nvshurbpmjkqysphfrfxhekq3c6od6a2uqai4rfxns64mdvf7@ftjvgjnivr3k>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5nvshurbpmjkqysphfrfxhekq3c6od6a2uqai4rfxns64mdvf7@ftjvgjnivr3k>

On Wed, 02 Oct 2024, Krzysztof Kozlowski wrote:

> On Tue, Oct 01, 2024 at 06:41:45PM +0800, Macpaul Lin wrote:
> > Convert the mfd: mediatek: mt6397 binding to DT schema format.
> > 
> > MT6323, MT6358, and MT6397 are PMIC devices with multiple function
> > subdevices. They share a common PMIC design but have variations in
> > subdevice combinations.
> > 
> > Key updates in this conversion:
> > 
> > 1. RTC:
> >    - Convert rtc-mt6397.txt and merge into parent MT6397 PMIC DT schema.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Everyone okay with me taking this without a pull-request?

-- 
Lee Jones [李琼斯]

