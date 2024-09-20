Return-Path: <linux-pm+bounces-14520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E397D644
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 15:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE07CB22701
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E8B179965;
	Fri, 20 Sep 2024 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UXs9/D0D"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24617839C;
	Fri, 20 Sep 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839479; cv=none; b=byEwPmUxJC5Uxx1s6g7NyPxJCPqNtY+zEhy2QXbKmX+bzuHe/ggbQAp4MEowNHCL3+xfRTvsdwU8EO1j3IdiGRFchkV9p3l3tMdyQJkNCDYTghv0qN9xhyNFw33aZDx+hgugeniQ18xiLKlSv8KVZz7TPd+wo9mKka2oTeWpza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839479; c=relaxed/simple;
	bh=kgWb5kRwz1iKoDUmfC8iUWF0tLM8l/Q9bdKBzrkGBxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsMcYkCFupkBifFaqzZc2Z1d9+uWpE2of9O39oqxPyjjqrfH48BRxCnltX/tjzHE0EcUqS6+ZZzE7SQ/j8feGPMMdqLeoQ1aNPeMRd9zVuuhXSmbOTtTJ0SB4yeB4cf3fMSpV7Pow+UdRnWdOllYOq7ydRTjZh8UEKN1eeLaBMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UXs9/D0D; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00CCE240003;
	Fri, 20 Sep 2024 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726839473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VlxQbVI6GjsZePKg/GpEB4+lUld/JLjhc7SjBhbTe4Q=;
	b=UXs9/D0DtqVUffHhaaWz9qCOw/YcTM1Da9aftLEfmybPoIbNYYchtTL63Nv0L731M/G8/u
	m/kgvm1ljyop99J/70lQJKwq1y4Ey3TwCNEW51rZ3TLJcb2Efbi6+vblOwv+FlLGcVxJIu
	sR9XtjpZDrhyXa1yPyG6LVN/IVgh1cYd9HbBIF43LtOxYg3geiazifHUSsyCnv61VYijua
	5zmxBLG9zHiaseTmUMaOOege3taJZ7w6TH0KN46RL6i/MgQD/eQWXaOq9JkSBx7HEkZCZe
	g8lOObN72EGjYEwtc9w0du8y50UWLZ5en31dBX8U5NCUNekmjK3goVGk1qJsVA==
Date: Fri, 20 Sep 2024 15:37:50 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
	Sen Chu <sen.chu@mediatek.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Message-ID: <202409201337500284902d@mail.local>
References: <20240918064955.6518-1-macpaul.lin@mediatek.com>
 <20240918064955.6518-2-macpaul.lin@mediatek.com>
 <20240918115151c896f33f@mail.local>
 <20240918115651c1475d36@mail.local>
 <2af0621d-14ac-b7f3-b28d-2df698931121@mediatek.com>
 <d8b90ddf-efbc-4434-9ad0-4be6942d51a5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8b90ddf-efbc-4434-9ad0-4be6942d51a5@collabora.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 20/09/2024 09:31:24+0200, AngeloGioacchino Del Regno wrote:
> Il 18/09/24 16:18, Macpaul Lin ha scritto:
> > 
> > On 9/18/24 19:56, Alexandre Belloni wrote:
> > > 
> > > On 18/09/2024 13:51:51+0200, Alexandre Belloni wrote:
> > > > > Changes for v4:
> > > > >  - Remove "mediatek,mt6357" from PMIC's compatible string since there is a
> > > > >    seperated DT schema for PMIC mt6357.
> > > > > > Changes for v5:
> > > > >  - Rebase to next-20240913 (linux-next/master).
> > > > >  - Fix the "title" (device type) of mfd/mediatek,mt6397.yaml to "PMIC".
> > > > >  - RTC:
> > > > >   - Drop "start-year"
> > > > 
> > > > Maybe, instead of dropping the property, you should add support in the
> > > > driver by setting range_min and range_max.
> > > 
> > > Looking at this even more, the driver can probably be simplified by
> > > setting start_year in probe and dropping RTC_MIN_YEAR_OFFSET.
> > 
> > Thank you for pointing out where and how the driver should be changed.
> > However, I'm wondering if this should be a fix with a separated
> > patchset (bindings and the driver)? The board or SoC's device trees
> > should be reviewed as well. I'll need to get someone's help (permission)
> > inside MediaTek to check those dts and construct the patch for RTC
> > driver.
> > That will take sometime.
> > 
> 
> Alexandre, I definitely agree with you on the fact that the MTK PMIC RTC driver
> can (and needs to) be improved, and that it can make use of some nice cleanup...
> 
> ... but!
> 
> This series performs a conversion to schema, and the previous txt file didn't
> say anything about the start-year property - which was not mandatory to support
> at that time (nor now, afaik?), so adding support for that is out of scope for
> this series.

It is mandatory now. I agree this can be done in a subsequent series.

> 
> Eventually, that can come as a series on top, adding support for that in the
> binding (and, of course, in the driver).
> 
> I should be able to tackle that... most probably next week - but still, the
> improvements would come as a series on top of this one.
> 
> Cheers,
> Angelo

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

