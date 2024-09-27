Return-Path: <linux-pm+bounces-14857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D5988192
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 11:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758691C21D17
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 09:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C6D1BD007;
	Fri, 27 Sep 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2Av3ebH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464721B0120;
	Fri, 27 Sep 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430154; cv=none; b=gmdcGJgv9leyZT01aVh2zyGlAooj8lywWnSYDc8mEiPyrWGWRa48jfKna9QgcqZrJL7504AP6d2EeJc4iZfh27B7K/dDnqas/Lm8vSJcLqF00fH7Ft27cFWYnvn7p5+UB5s09lG0d9ZxZYb7J1K5EBGgVX8h6z3Pve78iHEpD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430154; c=relaxed/simple;
	bh=TST2aU00V+a/b6WJK9LCwWG80Mq75dZu+SmOHyfGhDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sh2c8MX949/8aR7Vu9AMev7yHy08zfIeUmTdqOXF/LyYxld6NL9VvWq9fwgGP5kES6fUVBx7PKfV7y/kXjt+RclsDGOi1aexaAjBuZRsqeFo4ytafP6MXNa4ozo6ifBtP/tYpf9xoBTJRMACmQzXN9wEUJMmpXPTgSfR9UNdHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2Av3ebH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C71EC4CEC9;
	Fri, 27 Sep 2024 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727430153;
	bh=TST2aU00V+a/b6WJK9LCwWG80Mq75dZu+SmOHyfGhDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2Av3ebHVSl6qmxEGQZKjs86KC6ZaA6DIYPXM79Z6t6ndEl6tL6O7q8ePXtYVBCz8
	 NFDA7kMcX2J/JBk0DLWyxK+CHpSt0xM8kXlHqSyvjyeJNwSfhbXGGyJCqHh7mc/AqU
	 YBhz9hNlH/2nzaDLCSrtg3SHW3Ns9MeFQjlxw6SMRcj1L+rUfKVK/EpLVz64LgBcTH
	 mW6dimPJMBckLxty4HXgLoeT24s1mWNhjwjJhI9fusH43oJz7W3EZPmsbAfm7kTqQN
	 iTP7t4Eyp85G+qpzHpjA5TxQ/23G4wQQ6tB0BZV/7QS8tPH6kuXFm68xcnB2DzHHAG
	 xg8NPMi43ymDQ==
Date: Fri, 27 Sep 2024 11:42:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Conor Dooley <conor@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Eason Yen <eason.yen@mediatek.com>, 
	Jiaxin Yu <jiaxin.yu@mediatek.com>, Shane Chien <shane.chien@mediatek.com>, 
	Hui Liu <hui.liu@mediatek.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: mediatek: mt6397: add compatible
 for mt6359-codec
Message-ID: <z5zehicgqqsbgsjz5nrjlqrkpqll57gb26jdc3ctpeajtlfusm@b2s5vrbuv3es>
References: <20240926092519.6556-1-macpaul.lin@mediatek.com>
 <20240926092519.6556-2-macpaul.lin@mediatek.com>
 <20240926-smokeless-clobber-0fb8a1cdc7ab@spud>
 <78381b10-eae6-1414-6913-994e1ed03410@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78381b10-eae6-1414-6913-994e1ed03410@mediatek.com>

On Fri, Sep 27, 2024 at 03:57:58PM +0800, Macpaul Lin wrote:
> On 9/27/24 00:04, Conor Dooley wrote:
> > On Thu, Sep 26, 2024 at 05:25:18PM +0800, Macpaul Lin wrote:
> > > This patch updates the audio-codec properties includes:
> > >   - compatible:
> > >    - Re-order the supported device items.
> > >    - Add 'mt6359-codec' to compatible since MT6359 PMIC has been included
> > >      in this DT Schema.
> > 
> > >    - Set 'additionalProperties: true' for 'mt6359-codec'.
> > 
> > Why?
> 
> The mt6359-codec support these 3 properties:
> mediatek,mic-type0, mediatek,mic-type-1, mediatek-mic-type2.
> While mt6358-sound and mt6397-codec don't (at least, I didn't find
> these 3 properties in driver codes.
> 
> Set 'additionalProperties: true' is also required to fix the following
> dtbs_check errors:
> pmic: audio-codec: 'mediatek,mic-type-0', 'mediatek,mic-type-1',
>       'mediatek,mic-type-2' do not match any of the regexes:
>       'pinctrl-[0-9]+'

Why is this a correct fix? Aren't you allowing "pink-pony" property as
well?

> 
> > > 
> > > Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> > > ---
> > >   Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 5 +++--

There is no such file.

Best regards,
Krzysztof


