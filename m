Return-Path: <linux-pm+bounces-19752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ECE9FC99E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 09:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215BF162017
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E151CEAC7;
	Thu, 26 Dec 2024 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C795e/Nz"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77B42A87;
	Thu, 26 Dec 2024 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735200786; cv=none; b=qlh0KESG+Mj04pV8wugQQiHSV+ndgJSRo5wuTSSXK3dApdVANPvrIxUT1zjZs9zk6GNwB7iSYCi7OsYfea1oK1Df0FLzyEYD3TMc4DlXIgPfbd8zHUksliI39eB0zOB/ine/G0V0eMJ62pzc0ybfGCzBIjem4sCIuS/Cilrp9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735200786; c=relaxed/simple;
	bh=2+EB8IfsdOAAITam7PIsQ7kX1XNi1VZH/Xtl0oSaYyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vie3KWdBxEjEuB5qeQQheu9nTADyDsLD/N4coOaJRLj/8XpwFiHnFOn+PnDYD2tfrARhnDAiEAyGHzngxXdCvwU/LGsgfud/CJTp++Ol5mN9TdX2plW1Vbq/Do+RVDpkkijEWY8yooFJME50ZVNZDBhRMsXZ9fV/XpsxCSOOlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C795e/Nz; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3FCE20003;
	Thu, 26 Dec 2024 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735200775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jRLLDqrlbPXEKICsvAwtwaBpDU3ufkWk/NXlNBOvtWY=;
	b=C795e/NznBHV8+JxDmoiOpaLAzDOSvu41rz1dgVWL3FkOaUy3+p0uED+cYFYy3TUEO5/J9
	c9itEWdsMuDh0dwqjsw8CNKGz7YVrEMC3T9MY9MpnSjBJHRBBcSV9Q1k95PQH5ce/TSzV2
	daelh+bTVEodiiilT4SOQfddBqbN9a5eKCdvfURt3M/FtVFs+ZjvyNGT6Z9k9M30thYfhf
	41QrUjxKR0wYHAZtj+RxUbtL1i0MS4Ce+yFvwrdthPQzW8dSLqO+Mvk+Ia5Q1CHojtF/IO
	82GEUfGLkf4rWs9riKTpk3bSByZNLZdM2wGAjyVw7kLyyR5kN/7uAzM6GrLUiA==
Date: Thu, 26 Dec 2024 09:12:53 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Val Packett <val@packett.cool>
Cc: Fabien Parent <parent.f@gmail.com>, Rob Herring <robh@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: mfd: mt6397: Add bindings for MT6392
 PMIC
Message-ID: <20241226081253fbc6285c@mail.local>
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-2-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226050205.30241-2-val@packett.cool>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

On 26/12/2024 01:58:01-0300, Val Packett wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the currently supported bindings for the MT6392 PMIC.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Your SoB is missing.

> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 86451f151a6ae..73103922978f7 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -38,6 +38,7 @@ properties:
>            - mediatek,mt6331 # "mediatek,mt6331" for PMIC MT6331 and MT6332.
>            - mediatek,mt6358
>            - mediatek,mt6359
> +          - mediatek,mt6392
>            - mediatek,mt6397
>        - items:
>            - enum:
> @@ -66,6 +67,7 @@ properties:
>                - mediatek,mt6323-rtc
>                - mediatek,mt6331-rtc
>                - mediatek,mt6358-rtc
> +              - mediatek,mt6392-rtc
>                - mediatek,mt6397-rtc
>            - items:
>                - enum:
> -- 
> 2.47.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

