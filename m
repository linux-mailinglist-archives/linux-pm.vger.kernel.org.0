Return-Path: <linux-pm+bounces-23275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33346A4BD7E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BEA166D39
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9411F3BA8;
	Mon,  3 Mar 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jWi1jIQE"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2F1F0E28;
	Mon,  3 Mar 2025 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000019; cv=none; b=SsqFgv9htzU2+hJqSj4kupLISGMkQ46oAUlDfY8o7cvsbpleQ7zxpqQZ09NrMEqtUqoMNQuj45KyEHVUYmA/zFF2IDq3PrmwDLzXnjuNYCTllg33MUrUMegJALP+UjajEthxime5my8I4lsf9j4vKw7P7+x3jXQJsOr6cH292kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000019; c=relaxed/simple;
	bh=7x29ALLJGLsAxdzXWmZzfzjZ0OENp/QhL5O8ZxSNDmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A12y5HZjx+vOrncbxuBENs9TqAF8M+r8hFyXCXC7/5FhcCk/NX7xIdeN9TimuXZTEU1N/bp9rJ/lcAiBMqzDCIt+ydzEXpjy3VMAV2r8dXg44TQCmRGblSWJMM2I+SYXTN+lUeaAwnPsJj5QNtQVGY0kLLseceo7d/vQcvtmnO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jWi1jIQE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000016;
	bh=7x29ALLJGLsAxdzXWmZzfzjZ0OENp/QhL5O8ZxSNDmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jWi1jIQEj98Jm/972q0KLg1fmnX9nh0ecBVHUos7KYiNd2OFkRQQ8y8raJdJiYPrQ
	 Gd8pqESSfAlbs7uBAzCz3JMJAVwf7evTwUob3kbRL4T8CYc5P0oZ0YZzZTEyhXPcKS
	 05HEG3lGEzwjeRMY2mhkFH3xKI2ey67o3nToPYGUYuKjeauXVBOF0mz8DWzrWsKVAL
	 C/yDk1CdFcmZIS8CuKLDUq5VZLcwS3Hf5mTT7H+leB1TbulFZzBKyZ3erhX/Z5g05F
	 KBoWfF4530PVqNIcSbBNTbud7kJoeKo0ikrEdoVy6CUvvpixOo3Kwo3dBm1Gtt12hO
	 KDAqbRtO0hBfg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C43AA17E0E8E;
	Mon,  3 Mar 2025 12:06:54 +0100 (CET)
Message-ID: <925415fd-0415-491c-8e32-14dbd326f2a7@collabora.com>
Date: Mon, 3 Mar 2025 12:06:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] ASoC: mediatek: mt6359-accdet: Always configure
 hardware as mic-mode 2
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
 <20250302-mt6359-accdet-dts-v2-16-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-16-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> The driver currently reads a mediatek,mic-mode property from DT to
> determine certain register configurations. Since there are no current
> users of the property, the property doesn't directly reflect the
> hardware  and the default value (2) is known to work on
> multiple boards, remove the code handling this property and instead
> always configure the hardware according to the known to work default.
> This property can be properly introduced in the binding in the future
> if it really turns out that different boards need different
> configurations.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



