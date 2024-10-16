Return-Path: <linux-pm+bounces-15737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBEC9A035A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 09:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3166E286538
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 07:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D91B1CBA16;
	Wed, 16 Oct 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE1nfrPW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168F189F3F;
	Wed, 16 Oct 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065499; cv=none; b=Fv08HjI1GUYpEaxSy2LECth8nogkuMOV02AEhSSqc6gg7JM+Mdqlsf9pONuXNFVjWmJkgt89fUHjtIFEQ9fOC6kAq3Z3FTw51ObQFmeotIBj1yHT09X3v3KtS1yxEzPDgWxBZmgEpPT+ud9WVznGSnx2edak+pVHKI1FBw9DkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065499; c=relaxed/simple;
	bh=nsM60+cNuES1C+fqTbnc5ooJ0hP520KLGK9VFBCBDGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drXepBJETda9u3LJedyxC6BqtTvNmAfhsSYOSPsjxAK99fQvg5ZNPqHEFYCgQ7XQe2Am7dcjou/AhHc/WrkaQLi5ShW4r/EQxpLckZ7YmVrsL2+ybbsSVeCx20UJGACV3TN+p7O4eDXe6V5E32Hw/VK8Kek8OGpjbIrvddYRheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE1nfrPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D67C4CEC5;
	Wed, 16 Oct 2024 07:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729065498;
	bh=nsM60+cNuES1C+fqTbnc5ooJ0hP520KLGK9VFBCBDGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fE1nfrPWvmps83biOQkLKuOrEbyoX9F+oYZZR4MyCkhnTWXLfurI4YDDnEgp3i07b
	 VRYqDkPXIU+qUtKDWJ717mNrRjaZqikw3+etM/jDuz+SlyxnvznHnDKrAlDX0CzJ7e
	 fINBIZ+D9Zp09Ppusrp8Fb0ZqNgnLr3Jdt9Q8ncBHGtElLWB9ESeQ5b5BDNqyqrPHs
	 CtV1sq/qM1ERfGyqIll+x8X3NR+ZGI4q/LTpO0Q+uyL0JEmPhyTYdi0Xyt3NDfgwb3
	 N7NtwUeILsWm6XGFTmTz4KTjWwUil3aV5cQPTDvmG6RV280Yh47SXf5mfG97vA2mxx
	 vkzZ51zg7DMLg==
Date: Wed, 16 Oct 2024 08:58:08 +0100
From: Lee Jones <lee@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
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
Message-ID: <20241016075808.GM8348@google.com>
References: <20241001104145.24054-1-macpaul.lin@mediatek.com>
 <20241001104145.24054-3-macpaul.lin@mediatek.com>
 <5nvshurbpmjkqysphfrfxhekq3c6od6a2uqai4rfxns64mdvf7@ftjvgjnivr3k>
 <20241009155222.GB637580@google.com>
 <vb324yv7s7yew6m74lfvdv6wnuo6e4rxtiu2q7okypttw46ox2@lgfdkie6o3t2>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vb324yv7s7yew6m74lfvdv6wnuo6e4rxtiu2q7okypttw46ox2@lgfdkie6o3t2>

On Tue, 15 Oct 2024, Sebastian Reichel wrote:

> Hi,
> 
> On Wed, Oct 09, 2024 at 04:52:22PM +0100, Lee Jones wrote:
> > On Wed, 02 Oct 2024, Krzysztof Kozlowski wrote:
> > 
> > > On Tue, Oct 01, 2024 at 06:41:45PM +0800, Macpaul Lin wrote:
> > > > Convert the mfd: mediatek: mt6397 binding to DT schema format.
> > > > 
> > > > MT6323, MT6358, and MT6397 are PMIC devices with multiple function
> > > > subdevices. They share a common PMIC design but have variations in
> > > > subdevice combinations.
> > > > 
> > > > Key updates in this conversion:
> > > > 
> > > > 1. RTC:
> > > >    - Convert rtc-mt6397.txt and merge into parent MT6397 PMIC DT schema.
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Everyone okay with me taking this without a pull-request?
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks Sebastian.

I have a bunch of things that depend on this, so I'm going to whip it in.

-- 
Lee Jones [李琼斯]

