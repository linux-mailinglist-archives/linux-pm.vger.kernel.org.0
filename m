Return-Path: <linux-pm+bounces-14354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB6097ABC2
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 09:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0081C27B59
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6942213BC0E;
	Tue, 17 Sep 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq9vfbO9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256401BF24;
	Tue, 17 Sep 2024 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556474; cv=none; b=fgGCu9ssQyC5cuJLd9XwFHrGfmRk9E9bHolFMncc+QRrjNNdHpW/L0WRpPdnL0Phg9Q499tkhzxsxEz2jdSfDB324d1tCU7aUdPGJfvVY8igtRjxHwRxVWWFiid3Y2heDCP7XFXZ8SrTi41xI/+UzCZq5fm6NTNA/vMJM6j/g4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556474; c=relaxed/simple;
	bh=wL7bb6z2iPwWqy6wScaLnhBW8fFzb85kAzY2JZAjutM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er8bXddGgDdwezuOD/OCzrB5MDaRh1iITGUeWx0NKdYluxunfRS81NqlJ3rI6B0FsJw0LfjcarbzFpc6d97NNj3Eep+gEJpQBo3xFvN6+7XxiSKobUE7RqU1/G1zsx/QFnY1h3lonnVtIAsYmwXHqCzGV9fjgBF34gT+SXmL/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq9vfbO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A480C4CEC6;
	Tue, 17 Sep 2024 07:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726556473;
	bh=wL7bb6z2iPwWqy6wScaLnhBW8fFzb85kAzY2JZAjutM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sq9vfbO9nxUpSGNrYLqj2Q8lgo2euizIAqPcu+2RYfv9Qy3Xi2to2W8G0453aZgEc
	 gyRJPwKRSdpoyxSS3nybDQAy6L0+yiQFLBZwEOKaqFabevwP3eAwvuBkC2PR07sLlc
	 tdfPOcXthy+/W+VBtKl/10ApKOWKuVMlLQbddbD5x79MMNBxJkUEPa9xduBmI2O+4Q
	 10OzeyGNN4KwiGQRZMx8NSk43PUjg2pSgZiF7cgpmecnNknHIG56/r4GwIrHSXI7qX
	 hJZBX1ANS2kKMrC0YgPjonPKpAvKBQIpQnCTAGjsSUUrh22ejpWEeBjoyvk+UbB5uG
	 y0jWIJh4ltyXg==
Date: Tue, 17 Sep 2024 09:01:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Sen Chu <sen.chu@mediatek.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v5 3/3] regulator: dt-bindings: mt6397: move examples to
 parent PMIC mt6397
Message-ID: <ev4kqtbjwglrti3mk2cnayilj4muy7ll7ux2uwlekcwu73dy5e@h4wvpucmyepw>
References: <20240916151132.32321-1-macpaul.lin@mediatek.com>
 <20240916151132.32321-3-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916151132.32321-3-macpaul.lin@mediatek.com>

On Mon, Sep 16, 2024 at 11:11:32PM +0800, Macpaul Lin wrote:
> Since the DT schema of multiple function PMIC mt6397 has been converted,
> move the examples in "mediatek,mt6397-regulator.yaml" to the parent schema
> "mediatek,mt6397.yaml".

Is there any error otherwise? Why this cannot stay here, since it is
already there?

Best regards,
Krzysztof


