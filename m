Return-Path: <linux-pm+bounces-23283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C77A4BD9B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAA417115B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952B1F63CD;
	Mon,  3 Mar 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iiNjCRxd"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1C1F584F;
	Mon,  3 Mar 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000049; cv=none; b=qDtUC3r4gRlzBCp8DRGZbA+jiN0HVM6LXXZWjOfUD2pgQAwTAgelyD770B/VPn0AVcOAGPXdr1h192aZSEkFrRvEOYCkEfODZ8B5RbnbJKXXmMIJg5qZ0k6nqWxqWRPJjKOQRb87AduMUKKXsGiniyMuVCP/PlHA0+uQy4l37ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000049; c=relaxed/simple;
	bh=jb48D3BzBib7BYPClrRzu86QT3T/90FWCUr2WKd5IA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0wK7sBxjN3KBTTh/ebwfKxX0g/DGjuXs0PxcNN025SQicLoa79EKAxXsXbp4tzLOcRaH3x3ZUKlWwT72PC0b/5pGjMVt8wEL6+u4DnZb+o8h44kU9abid22ai48Yy1gTZLBCjyDhzf9ggckzRw5cnJmsFJUrCD8e+u8yvJ+uj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iiNjCRxd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000046;
	bh=jb48D3BzBib7BYPClrRzu86QT3T/90FWCUr2WKd5IA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iiNjCRxd4KEx2kt3SU9co2OMsJUbKjvZdxf1iAWuTP0eclA0fI0t4n3hb3ikRUhDL
	 9Qs8Xnj3UcMM2hj3wxEQrS2RLdAr8SwwVhG7El11tYD9p+mYQytowhICs7KrtKiUMe
	 Q3X2BcC1Kay8DFpD6lCa1wMDIEb3ZJ5uI4zdEqHZtQ6y68u0HYUbBvyMA+/Op0B4Bi
	 NJK41tAcxvycpaiRim9UXyC/GNpdxWHeF32iqSL4pbwryUjuDNAf6QDK/FgA94Ty1T
	 3gWSiuvHY2oqj5737l4RGGkjGABnMf2fPO6ZwnZevCyMRQatHu87mwTZlxEA2lPlRW
	 iIeMqDi5+lqkg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE67317E0881;
	Mon,  3 Mar 2025 12:07:24 +0100 (CET)
Message-ID: <bea223a0-505e-473b-ac00-fc311f12a9a6@collabora.com>
Date: Mon, 3 Mar 2025 12:07:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] ASoC: mediatek: mt6359-accdet: Drop dead code
 for EINT/GPIO IRQ handling
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-7-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-7-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> The ACCDET supports two modes for IRQ generation: PMIC EINT or AP GPIO,
> which in principle could be configured through a DT property. However
> this DT property has no user nor is documented in a binding, and the
> driver only implements the PMIC EINT case, so drop the unused code
> intended to handle both cases.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


