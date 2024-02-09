Return-Path: <linux-pm+bounces-3678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B684F213
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 10:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2EC1F2906F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1283065BDE;
	Fri,  9 Feb 2024 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="up3Rlg2C"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E950443F;
	Fri,  9 Feb 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470028; cv=none; b=WeNRhyIThOU4V7M/h2bfuA0Q2BIVRiz55FnOcGBc8TqBxuyJnyJP80N+NkVVIv9e9Ihy5gZzk9Z3FfC2ecYYBuOuXxemHotKrfMwJXcjpVtiXV7cCedVnYargKAVDkKKhK7cD1ESnYxEJx50MRUd5Si3pGs3wDEAhYFpOrZjpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470028; c=relaxed/simple;
	bh=bM1d8kHT075G3SCvCV7Hu/u/EgAsOXV6u29c7fmcHpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KF2Kj6T3SGEmD1GlrQJFAGKRKIu7xlJ9tror/OmvNPDv+fy8CgJJA4hgPq3c44GIMs7hZ0WJ6K0DjWl+hbVEWz/AsE8GjwiXH7IGloVqfxiZsvP1k6Bqrdi1A+MdWY5zYNh9WhcSVeGFkyQN8rB4xpXr43zYukfobzIaTn07tJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=up3Rlg2C; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707470024;
	bh=bM1d8kHT075G3SCvCV7Hu/u/EgAsOXV6u29c7fmcHpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=up3Rlg2CKh+aq9+7EULqx6XeSO5KnyPnRZ82aiHYq2n/E28X9jZIlY+Pndfctv4v2
	 suvnHbydLMpNR1mqtO3Z6pisgFEW6rF3KmJDnQAV8j+dvW2Wha5St6C10vY9se+tCt
	 xKy7lof5zBhmWkQ1doTg5Okf2cAF+LNVLuewBj2pt2HRtQQn7qA+NvyjuGtb7a3qCd
	 FFN2B/S6C1b6gASkdNdX/8FZ96v4Lsy26ZjCKpJXb181JjrEgJXYZjYmnMfzRM+Y8b
	 JhoBfpY7Ojtm/eAfPVgDITpWOHk8t0WBWhLp3LLB6pVrbe5b6XWK1YjImiVBr8v1/f
	 HhskzLUluzJcA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 537B337809D0;
	Fri,  9 Feb 2024 09:13:43 +0000 (UTC)
Message-ID: <17d143aa-576e-4d67-a0ea-b79f3518b81c@collabora.com>
Date: Fri, 9 Feb 2024 10:13:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] dt-bindings: thermal: mediatek,thermal: document
 AUXADC 32k clock
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Daniel Golle <daniel@makrotopia.org>,
 Sam Shih <sam.shih@mediatek.com>
References: <20240209055203.17144-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240209055203.17144-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/02/24 06:52, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> SoCs MT7981 and MT7986 include a newer thermal block (V3) that requires
> enabling one more clock called AUXADC 32k. Require it in binding.
> 
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

So, I've made some research on this matter.. and this is a NACK.

I'll keep it short: you don't really have any 32KHz clock input for the ADC in
the infracfg clock controller (nor others).

What you're trying to say here is that you have a FastRC Oscillator input clock
(in your case, this is CLK_INFRA_ADC_FRC_CK): this clock is responsible for
providing an input clock of either 26MHz or something that is MPLL/16 (I do not
know what MPLL outputs on your platform, but those PLLs are usually giving out
"big numbers").

The FRC osc in the AUXADC will perhaps output a 32KHz clock for internal reference
and/or whatever else, but I'm not even sure that it's really going to be 32k then
internally to the IP block.

(I said "I'll keep it short" btw :-P)

Anyway.

The FRC clock is also required for the INFRA_ADC_26M clock to work correctly and,
in the clock controller driver(s) of both 7981 and 7986, that is parented to....
... surprise surprise ... INFRA_ADC_FRC_CK :-)


Finally, you do *not* need this commit, INFRA does *not* provide an adc_32k clock
to the thermal block, and you do *not* need to add the FRC clock in the devicetree
of 7981, nor 7986.

Mind you - at least in mt7986a.dtsi, there is an adc_32k clock in the thermal node,
so the right way to get your thermal node validated is not to modify the binding,
but to adhere to it by removing the extra, unneeded, clock.

Cheers!
Angelo



