Return-Path: <linux-pm+bounces-23279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D7FA4BD85
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F2D188E62B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC01F3BB4;
	Mon,  3 Mar 2025 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F4T2dwhM"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F71EF0AA;
	Mon,  3 Mar 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000039; cv=none; b=kCoT874SFZCRpV9P/uNm+NrahUXoNj5YLqBmwJCAqQM3eBy4jGgt5vnYTxihtZ/QAwtQz/BI5b1C8jwxQK4uP9EbQ7nshYKScR5iHr+3hVEaTvNgYMAjnzChNVHfbh/7dWjxWOTSDQM1+MV6lHk9ewEHb+T/ydv1N9djAH43dUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000039; c=relaxed/simple;
	bh=ejDawKctgXUcBnB7UgkCPWZJM6BS3dCiGuUvJvku9u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAp7w1M7JNutg+n3DWFbDvm3GWYIgJgmkEO3nxQmjcgHXzGLPuT0fQ5LskjPccIOQCARZNXYeLl6p4DKwLYuKqvy8una4dHj/Ns+y+knPkH7dch5zkc+AApgN/H2B2eVUmVEqDN3SDg2UBO2aAzUqTxk0oqSc+KbuPD+SXQvYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F4T2dwhM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000035;
	bh=ejDawKctgXUcBnB7UgkCPWZJM6BS3dCiGuUvJvku9u4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F4T2dwhM4ImI8g4gADFrhc0c41Rndv/7+C84FfLbybfSxzeomdZGxCLIpWAfTDXQv
	 ctxikbFCgLUdi/j+du1G8Bs93ePjsLN/BW4j1dppGJzja0h9+ooj3l0tDSwk1Em9HY
	 krUQH23+mnoSMZeMY0i7Gyz4NyZPLt4bnlPm64+B1Q6xeYoRmjOtpynrKKTXfIGUfG
	 e0dd0BJ52vqXD647mwTVOVayZW5QuGzZsHzPsgym9g6OhsVHC2vLrL5hUsP7WANoRN
	 kyJKaQ7fj4DMCQRmc3mepaZ24Z2i0+4I5lZftEho9Af7ynv2x5qJP0j2pT0DTZA+zV
	 i8GuQZ/sEvpvQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FC1F17E068F;
	Mon,  3 Mar 2025 12:07:14 +0100 (CET)
Message-ID: <d6056fa3-ad3f-4eda-8479-4548eddbdaa6@collabora.com>
Date: Mon, 3 Mar 2025 12:07:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/20] ASoC: mediatek: mt6359-accdet: Drop dead code
 for plugout-debounce
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
 <20250302-mt6359-accdet-dts-v2-10-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-10-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> The mediatek,plugout-debounce property is undocumented in the binding
> and unhandled by the driver. Remove it.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



