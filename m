Return-Path: <linux-pm+bounces-29870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040EEAEEF00
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263A13E0F23
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 06:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05DC25C821;
	Tue,  1 Jul 2025 06:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMwivqhB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37B25BF16;
	Tue,  1 Jul 2025 06:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352106; cv=none; b=oHDVg2IjM59quXIbZjBXoy1HZXOjOpx/WhUgdLTesk0/eK8NaEDgta6K8KoyFj624b2a3jrt6qZ+NuGs05xe6ZQ+0khyJnaP+aTYsHd7O22Uy/qu94mDIiSWJc10ob3VeoRiEOBP36Sqp9P6WIxjowIIAHxdPdRXh+uWXh5sjLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352106; c=relaxed/simple;
	bh=d4M1ipo/BpY2fq2FFDmvRZtLeK+GPtRI5SDJlqTCwgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb46Q1Abzvy4oysxAI0BvyAWGM5IXh/MZWwd1lM/tFNvBVlp0VqNhbrvXDSadqFdh5/tXzk06SPw3R4F/WQvZcztGoMTvEfB9HEfNIPq6N7O/lRfP7JuMYz0JpVwI6qVQEA5uW+tegES43CnHPzfXCLg8KBHLzVEl3h6rM7LwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMwivqhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293A8C4CEEE;
	Tue,  1 Jul 2025 06:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751352106;
	bh=d4M1ipo/BpY2fq2FFDmvRZtLeK+GPtRI5SDJlqTCwgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMwivqhBRxQZvzeiAF6cYrziYyySpvSnAN9nqOZ3tyn7zFJZMCRwYfOtfKRX8Dmt/
	 rv8OOOXQB8aDwqXx4JP+AacsdynnnFrYoKV6ftYOOV/tqCcGnDppocqF3pcaiWhHnR
	 V+yyTfTeiPL9xHhnGRQm3ZTx2oGQ+/iRxnZaIx/Xd1lMb/F/vT49YYUPaHz6h2GGEg
	 HtTGvtTPt2KjJDF6godQRokbsAmUyVkYtzYmhqQpJLaC0nhZX/cpz/iJ1b17ccXeYI
	 xjGWPVyQNhmeS4gJVcQiybqQgpw7UEWPOU6mI8LoTkBh/CCKE+ckAC2qclYbzEvvjh
	 RW4mssWEqSN1w==
Date: Tue, 1 Jul 2025 08:41:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank Wunderlich <frank-w@public-files.de>, 
	Johnson Wang <johnson.wang@mediatek.com>, =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 02/14] dt-bindings: net: mediatek,net: update for
 mt7988
Message-ID: <20250701-rebel-mellow-parrot-fda216@krzk-bin>
References: <20250628165451.85884-1-linux@fw-web.de>
 <20250628165451.85884-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250628165451.85884-3-linux@fw-web.de>

On Sat, Jun 28, 2025 at 06:54:37PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Update binding for mt7988 which has 3 gmac and a sram for dma
> operations.

I asked why you are updating. You claim you update because it has 3
GMAC... but that's irrelevant, because it is easy to answer with: it did
not have 3 GMAC before?

So same question: Provide real reason why you are making updates. That's
why you have commit msg.


> 
> MT7988 has 4 FE IRQs (currently only 2 are used) and 4 IRQs for use

mt7988 or MT7988? gmac or GMAC? SRAM or SRAM? and so on... it is not
easy to read and understand your commit msgs.

> with RSS/LRO later.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v6:
> - split out the interrupt-names into separate patch
> - update irq(name) min count to 4
> - add sram-property
> - drop second reg entry and minitems as there is only 1 item left again
> 
> v5:
> - fix v4 logmessage and change description a bit describing how i get
>   the irq count.
> - update binding for 8 irqs with different names (rx,tx => fe0..fe3)
>   including the 2 reserved irqs which can be used later
> - change rx-ringX to pdmaX to be closer to hardware documentation
> 
> v4:
> - increase max interrupts to 6 because of adding RSS/LRO interrupts (4)
>   and dropping 2 reserved irqs (0+3) around rx+tx
> - dropped Robs RB due to this change
> - allow interrupt names
> - add interrupt-names without reserved IRQs on mt7988
>   this requires mtk driver patch:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20250616080738.117993-2-linux@fw-web.de/
> 
> v2:
> - change reg to list of items
> ---
>  Documentation/devicetree/bindings/net/mediatek,net.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index 6672db206b38..74a139000f60 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -28,7 +28,8 @@ properties:
>        - ralink,rt5350-eth
>  
>    reg:
> -    maxItems: 1
> +    items:
> +      - description: Register for accessing the MACs.

Why making this change? It's redundant and nothing in commit msg
explains that.

Best regards,
Krzysztof


