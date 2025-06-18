Return-Path: <linux-pm+bounces-28998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9BBADF40A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 19:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C7D1BC18C9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683802F4A14;
	Wed, 18 Jun 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy4wyw7Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390922F2C6B;
	Wed, 18 Jun 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268289; cv=none; b=PfWS3plkmZCI9ynFfGu2ipBU+gDdOJZY3xqGCruOJjjwUd0KatXwiN/AMt0GFpYot/WbuU2DAzNXefZAi2z/Y8UwKYq17ev5WmAlR/yQaFfNXjfK3hdsL/sk5HJhv7+RaRrlyRxoizDRvi2BYKiQ9lWYNuyqIuCBiixeVslJQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268289; c=relaxed/simple;
	bh=i76VuE3Aq3hkZ2sq2815FwgqFtHsSev/sM8xJboxVA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEfeSozqAdK9S5cJwVTm260y4yqXOtKuiDeX2YLaNwwBa/q+//IvHM8sXKJH0YKxbYOIa4P2DdI7cbzaR+YoNfxTFFpX/ngK0n/kt8amSt5v3XkXlvrd3KDjCcM1sI6UVeaRL5NsA0sqETQF+2hM5byVs7p28DlkTv0ST6ii2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy4wyw7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640D9C4CEEF;
	Wed, 18 Jun 2025 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750268288;
	bh=i76VuE3Aq3hkZ2sq2815FwgqFtHsSev/sM8xJboxVA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gy4wyw7Y974jROrWoiVVP96W7MZfhfIw26Rom0+USF/ynDOVUyhqKUnvQnPHJRnJX
	 h9hkcAVWDmBqr6TbFW9u5tuscOsfQGmBfBsVzL3higBrMyKjGt4XMyyI2/HKnAMOHl
	 HyKkYg3mn+1yv778lVizhJZGsODXA/gPUMhgeuWn+xFUeoczWAn7rFYBH277UjiM2e
	 jq8XzslfshPrL7m4JM+Al4ry31QX0n5EJW+S/5YiGxlmv0eqtE1uY75IQQEgUwHqxc
	 y/qhRviqh/RTh26cf7OpNuWbhs0k0kihiHk9N/je41BR7VYiNzFaY4zwfoY8MM9vU4
	 NwSVJi031yZBw==
Date: Wed, 18 Jun 2025 12:38:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: DENG Qingfang <dqfext@gmail.com>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Georgi Djakov <djakov@kernel.org>, linux-kernel@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Johnson Wang <johnson.wang@mediatek.com>
Subject: Re: [PATCH v4 01/13] dt-bindings: net: mediatek,net: update for
 mt7988
Message-ID: <175026826312.2322513.8876769837630455596.robh@kernel.org>
References: <20250616095828.160900-1-linux@fw-web.de>
 <20250616095828.160900-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616095828.160900-2-linux@fw-web.de>


On Mon, 16 Jun 2025 11:58:11 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Update binding for mt7988 which has 3 gmac and 2 reg items.
> 
> With RSS-IRQs the interrupt max-items is now 6. Add interrupt-names
> to make them accessible by name.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v4:
> - increase max interrupts to 8 because of RSS/LRO interrupts
> - dropped Robs RB due to this change
> - allow interrupt names
> - add interrupt-names without reserved IRQs on mt7988
>   this requires mtk driver patch:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20250616080738.117993-2-linux@fw-web.de/
> 
> v2:
> - change reg to list of items
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml | 28 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


