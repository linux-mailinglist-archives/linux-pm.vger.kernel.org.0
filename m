Return-Path: <linux-pm+bounces-23277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44493A4BDB3
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B2E3B301F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095CA1F4614;
	Mon,  3 Mar 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KNt5cB6E"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7E1F4261;
	Mon,  3 Mar 2025 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000024; cv=none; b=O7SRFjRA1cgK33piFoslljgbnkRzcpN9G2OGevN/KxPTk3PiJOe/UEnsY4csO8/D/veQXlCAaHFVvhZpY+t52iAdMNbw7oidBbONlHHUrnr/1ysbH0xWA8x4+lXX/sE6YZtZFp2LhiUb4C6h8lwvV8wGAqf7zpGBkWTNYMGr0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000024; c=relaxed/simple;
	bh=CuLBO8WEfBYQo9g1568escIyXpzN1KWlf5T5E7ZWKe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJkKUzsMA8Lh2VdEuTtwHbIlOZP6AdVdbXlGibyB/Z9WA+Kf9RrYsiTAOGsDWRG6UAPiwx1xYxbxK9btQrfo78SpnXS7E15QmRUyKtPWMnmizLYieT9Sec3im0u0y0nAaIkn/47n3MCKwyNFYpGSOygJoXGicyGrl+dX6JNRfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KNt5cB6E; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000021;
	bh=CuLBO8WEfBYQo9g1568escIyXpzN1KWlf5T5E7ZWKe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KNt5cB6E3tkRk+KKq5J3Wa/5X0IpYAsoezW4HlQh4DGPzZv5msphj0aJ25cZ+FC42
	 YfXxZ8N/aZEyhL2QCYB8Q4seia6L1TOdC7Hx+jjukIAjt84SKAMOLXUWsTjEeJjVNe
	 GV2exr4OBpRnWotJOqs7uTK9mULIc3wigF3uxPtpJyluKe5FlVz10Sb2olWnpyWY1z
	 05DBQ83fmv2tQg1JBVhqDWfWGohD5PRTbASI31pfFcLZPFeh0cy/wgTTbZcsGV3rWc
	 DrpNZnK7pPLCiv7uaKXpqzm8DwiTN8T7oHHJxE2+UcfJ63UaVjIGj5Fq/2ErIru1h+
	 aVvnltR/+o4Ag==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D3BDC17E0F3D;
	Mon,  3 Mar 2025 12:06:59 +0100 (CET)
Message-ID: <8af68114-82cd-45b3-a0a9-baa46d64c936@collabora.com>
Date: Mon, 3 Mar 2025 12:06:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] ASoC: mediatek: mt6359-accdet: Always use
 internal resistor
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
 <20250302-mt6359-accdet-dts-v2-12-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-12-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> The code currently reads a property mediatek,eint-use-ext-res with
> values ranging between 0 and 4. Not only should this be a boolean
> property, but there's no need for it to even be a DT property, seeing as
> all current boards will use the internal resistor anyway. Since there's
> no current dt-binding or Devicetree user of this property, remove its
> handling and make the driver always configure the internal resistor.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Adding up to this - I even checked a few downstream smartphone devicetrees, and
not even those are ever using external resistor. This won't ever be needed.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



