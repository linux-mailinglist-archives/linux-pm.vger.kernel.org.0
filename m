Return-Path: <linux-pm+bounces-30245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADE7AFABF2
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 08:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14AE3A37C5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 06:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807DA27991E;
	Mon,  7 Jul 2025 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNVts38q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6D2750FD;
	Mon,  7 Jul 2025 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751870019; cv=none; b=C7dfWE7XI0Y7giVSqqmZPJ0OVHJ3jed1XiLnWtd0IbRu6IfIFBBtxdsXKj6Li1xpcERUROom5cCX1YvjlF+pUYeexeEm+yb0PiI6hdrQ96NfdzG3FPaMuzgnVHCKjD6FeX+pYXkz0K5Dsp2di5nN/AtT/jV9PeXWw/CVi/H+l7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751870019; c=relaxed/simple;
	bh=h24qSJ8Oi8rLBWzEyRk9kWuH5HysbbgpfVyMwQU3sDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1kK0gtTi0r03806iiyDluklv42l6uTMxUYmsO7duins8BmjN3GxuxjOhokJGu+0PrUUDBj8ub+uIC3RZvqsEDpOLbsWQn0W1Q6EI6r/rbfnLL3Xr6Mnk8bDVq2Fu9S7yOVrEzJcjLrwACPpcULTlGHA9xVeeFCtmczejY+ZYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNVts38q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E327C4CEE3;
	Mon,  7 Jul 2025 06:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751870018;
	bh=h24qSJ8Oi8rLBWzEyRk9kWuH5HysbbgpfVyMwQU3sDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNVts38qKFiTktRXWRXh6+TlqSdyDKDvCa2/ImWYK0/XxpNZsykfGB7JAQ20u1kRV
	 5EP+uNwiFYIFBVDX8fo6U5cWii2AKx0S9qBMhTmAc6QUsjnEv+vr4kYn4Bqi4ZkzlT
	 MH3efX8fVmTsr6/tqCPYnxOv8vyuW4zBZZPO1Th3LSd9pbceYxdgmkLIlrtPDjxBne
	 oxuosy7fbK1EragWHWFY2PNmm0zpGs88gg8mIRTabCuDkqvGRLnaW2Fi+NxCQ+m96W
	 jPrKdtxC7rgg7cl9C1pOQX/LcFJSgM1tsQNoEXmYw87DfUgxr0iNri7SeOk19+aGGi
	 raLJ94KvYDJDw==
Date: Mon, 7 Jul 2025 08:33:36 +0200
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
Subject: Re: [PATCH v8 04/16] dt-bindings: net: mediatek,net: add sram
 property
Message-ID: <20250707-masked-ambrosial-pegasus-2ff8fc@krzk-bin>
References: <20250706132213.20412-1-linux@fw-web.de>
 <20250706132213.20412-5-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250706132213.20412-5-linux@fw-web.de>

On Sun, Jul 06, 2025 at 03:21:59PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Meditak Filogic SoCs (MT798x) have dedicated MMIO-SRAM for dma operations.

You need "sram: false" for other variants.

Best regards,
Krzysztof


