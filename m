Return-Path: <linux-pm+bounces-30244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A166AFABED
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 08:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7701899CE0
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 06:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C342727702E;
	Mon,  7 Jul 2025 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVqZknEw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929502F50;
	Mon,  7 Jul 2025 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751869874; cv=none; b=jFDzqwRJseMFdBnOgRCfTHTxB/LwL3S+U1uYJ4orkFfoUVUl+LjXYJZ2jPYxzcBxrZoGbauXNfWvVxGVmJpzc60j12csCxqdvgKD8R/BQGme/MXQQZCzxL6egJFHQs/2kiCubYgpQmYZkiJU2YFX4R5GuOpninLDTUkxlHqrJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751869874; c=relaxed/simple;
	bh=Dp4PB4uQ9UlsKQjhR6+p8KTy4sduZM+pc6pwopcw86s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJ925Pu5qZTx862GEP9u0NTyDy18aLDLjPu4JLh0cTPBPdwHemO+KH1qOSNeTYSS6/mh7S7x1a7cXvqy8TTUess71C0/ioOyCblkaCiz0Dvqb44mMbhx63vkG45t3kOtCFzNZfniZDSEDR46Cc4bXIZ+HMVYvEZUEGrhU/KhwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVqZknEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935BFC4CEE3;
	Mon,  7 Jul 2025 06:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751869874;
	bh=Dp4PB4uQ9UlsKQjhR6+p8KTy4sduZM+pc6pwopcw86s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVqZknEwQSsVOljR/z6LzhmwxegK6GNwiBbGAEIzG7igrT9cSHrxzGfMN2dr2OkjW
	 /MvE9fKZPCkwj8a8gmgm+J0C2/PX0C3tmE1vqIFI05Pe5TfOWpnvU8T7eB6/k4sP+a
	 sbncJaX8mYRz6x2IHd+89sSvNQqOv0rq9crRbFDjMmmWpIsBXmINIQYSSAF8d5QIzw
	 0moFrfrFrmvRdI/lgT3Tzo0zcAgB5u9KHySi/7jb7WpFXc23zldnP5GeSkDco6w9WW
	 snp+yrJNENBQiywM+iIS/OtE0q96OpNQ/tqmRYtJQVtAQYRWTorYmtkuW4ky4ORO9t
	 bbunM7VxZQilg==
Date: Mon, 7 Jul 2025 08:31:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Johnson Wang <johnson.wang@mediatek.com>, 
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Felix Fietkau <nbd@nbd.name>, Frank Wunderlich <frank-w@public-files.de>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 02/16] dt-bindings: net: mediatek,net: allow up to 8
 IRQs
Message-ID: <20250707-modest-awesome-baboon-aec601@krzk-bin>
References: <20250706132213.20412-1-linux@fw-web.de>
 <20250706132213.20412-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250706132213.20412-3-linux@fw-web.de>

On Sun, Jul 06, 2025 at 03:21:57PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Increase the maximum IRQ count to 8 (4 FE + 4 RSS/LRO).

Because? Hardware was updated? It was missing before?

> 
> Frame-engine-IRQs (max 4):
> MT7621, MT7628: 1 IRQ
> MT7622, MT7623: 3 IRQs (only two used by the driver for now)
> MT7981, MT7986, MT7988: 4 IRQs (only two used by the driver for now)

You updated commit msg - looks fine - but same problem as before in your
code. Now MT7981 has 4-8 interrupts, even though you say here it has only
4.

> 
> Mediatek Filogic SoCs (mt798x) have 4 additional IRQs for RSS and/or
> LRO.

Although I don't know how to treat this. Just say how many interrupts
are there (MT7981, MT7986, MT7988: 4 FE and 4 RSS), not 4 but later
actually 4+4.

I also do not understand why 7 interrupts is now valid... Are these not
connected physically?

Best regards,
Krzysztof


