Return-Path: <linux-pm+bounces-30555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 961ECAFFE80
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9708B1C81D0A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93C62D4B79;
	Thu, 10 Jul 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5BWyxpH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D32D3EEA;
	Thu, 10 Jul 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141156; cv=none; b=sByRwWSkZ71xFGDNkQJkafu/MboZfaTR0CDioy4/iiuuSv+vAxI8FREA+LTHrZ7BluzaVh+l0wBGN7TsI5iemDrugh7I1I/3yiyMnkXWwQrl+bnXbmVGLWOXI10eoy9UCeR5rWIABS9AEYxi/sYMlG52uM3ByTNmrJwSd1JM6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141156; c=relaxed/simple;
	bh=/HJYYChAy20DN1nkebvN+gQiiYH8PgHrzFXUdHv1QKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8noZ7zL2qeC3EtD2cwk+WaShpTZYfVM/7QgngVEJHjuFpBAVeIwqU4dkYw6WjZq8EH1SsTJwdmWSuV8HP7hUAyQnWbxpElW8lCBgi2rg4hdtmuPneeSWdi3M74liCByCm8jOKbpv+4avl6cS62Y6a4TQz8kituYmSO1VEvPaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5BWyxpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9595C4CEE3;
	Thu, 10 Jul 2025 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752141156;
	bh=/HJYYChAy20DN1nkebvN+gQiiYH8PgHrzFXUdHv1QKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5BWyxpHwKCnatmuyA0n/neImgZGYGMGy2RhjjVP8r9hJ60tyjc53VqlbIcspNnhR
	 qHrjedu2jDjzVOa0Rs7z7QKD/k5GDHr34HAdmuBm/JN52DTMSF0yNQFmNy9haNa1Ov
	 2xgc4xh1MHaTDf3aEHsN7Egt0qJ82vlvS17nSv86quml+wwcVVp1PaChwjhipZ26Df
	 F99+QMGldthrABMOQ7wJyKoEWY6Eg5SgEnaQcQy/GRoh3tzecGYtyR7SwhyW3aTXje
	 HtD7ULTPrjRTISSkrdwQjv2e/Lkyl7f5V7hniWLnCtKee+CXNsuBcZ0PYY+f+iQeqO
	 r7Im83PPJgYDQ==
Date: Thu, 10 Jul 2025 11:52:32 +0200
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
Subject: Re: [PATCH v9 04/13] dt-bindings: net: mediatek,net: add sram
 property
Message-ID: <20250710-masked-intelligent-dalmatian-caccbc@krzk-bin>
References: <20250709111147.11843-1-linux@fw-web.de>
 <20250709111147.11843-5-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709111147.11843-5-linux@fw-web.de>

On Wed, Jul 09, 2025 at 01:09:40PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Meditak Filogic SoCs (MT798x) have dedicated MMIO-SRAM for dma operations.
> 
> MT7981 and MT7986 currently use static offset to ethernet MAC register
> which will be changed in separate patch once this way is accepted.
> 
> Add "sram" property to map ethernet controller to dedicated mmio-sram node.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


