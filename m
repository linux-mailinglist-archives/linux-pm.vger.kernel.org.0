Return-Path: <linux-pm+bounces-23292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D328A4BE25
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D21188C7F7
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707F1EBFE4;
	Mon,  3 Mar 2025 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zp/H58vJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE01F1908;
	Mon,  3 Mar 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000529; cv=none; b=lhDWnUCy44M8IFrJtIjOpddzZ8Qp1Mr2XWEWtYbgiedrn2Uc4sE62j+dGQdqB5Lo1PwX/6hk8prW19Tl0z9O7LOuREfdKxgu7Q/YWxrHEb/2GDPEWvejhQl3QrmmqnVKYUqhDCbXzJxOt+FIvhJ3P/1L1/sqSOEeEGEYEAHprOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000529; c=relaxed/simple;
	bh=zHGCADU56T7A224lF133oGjwzLj/Y9hZrXbv8NOAx1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ld1jtjYLe40kn+MHF3WbqqH4babcSM6eJKeVz2oq4ARciauCIY25HYusrewEydcQiBeeMpsskmdAaMqD5WD+vBMYLHnUlPy2WkB7aIAUnOnsTJRwERxbLtRMBz9qwFQ/QK+PfJl1qO3NgVECNWlweQ9/oMD5IKl3sbsIQO4YZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zp/H58vJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000525;
	bh=zHGCADU56T7A224lF133oGjwzLj/Y9hZrXbv8NOAx1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zp/H58vJ9rjRaEthdrCDdcQWdjaAb1mvE/B2PKHjamT9xW01devW47qz6T+qEtx6b
	 M3E0H2siHWMutWk60bE3BnHGzRW5Eim8AOm7eBhMdBAln/VMk4Dd1OHZ/2MlPGZ+Qc
	 lSfZ4gtN4+f6C/GCTf69DojqEueBPedXBGKiourDxcDKScxW3TnCK7US7PZ/wfq8jA
	 0rGL0bUZkC19Jr6yWljZK6j9C5NpLmhWh1quFmZ3vosaz6I4szPUqLbOl2kFgnYtId
	 SH4Q2ocYXq72C6WtD8FKYVuKSV7P1TeZ8/O75g86GPmSEBk4QVOEsvHyRyWdOEjMov
	 NFjeojr1ZOgBQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7517517E086B;
	Mon,  3 Mar 2025 12:15:24 +0100 (CET)
Message-ID: <ea3cfb5c-bcba-4530-8bd4-6738acfaad90@collabora.com>
Date: Mon, 3 Mar 2025 12:15:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/20] ASoC: mediatek: mt6359-accdet: Implement HP_EINT
 polarity configuration
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
 linux-pm@vger.kernel.org, Andrew Perepech <andrew.perepech@mediatek.com>
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-6-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-6-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> From: Andrew Perepech <andrew.perepech@mediatek.com>
> 
> The driver currently reads the HP_EINT polarity from the Devicetree but
> never actually configures the hardware accordingly.
> 
> Implement the polarity configuration in hardware.
> 
> Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



