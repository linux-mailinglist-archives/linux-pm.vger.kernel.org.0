Return-Path: <linux-pm+bounces-23280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB270A4BDC5
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADA83A4AEA
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57F31F4CA2;
	Mon,  3 Mar 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZxjwzTn9"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3B1EBFF0;
	Mon,  3 Mar 2025 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000040; cv=none; b=HYqvIITFm1zAwavL/ADtES4TMlibhBsWU75YpKvoj593d3bM+B9uNPRTo2YhOeE4wq/cO2AQrCge9OHcoOb00DNyTGpi6ZZtE+hCMnojvEoQORQa48OmU+zacWg2LIyHvvxgc116ZN8Bh9ivwPJtsbrZq2S9IvCFShicBoy5bOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000040; c=relaxed/simple;
	bh=ydv0dj1ouNGeLIsMSrdmifpN8XSR2k+C1xJp556epXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfjbUYgEwox2s/9x+Z4AG6EoSw0mr3RE5UmFeoxl8K5jA+cWVHQPwF0CLGeySTArD1w6sZo1zpIjSr9IO19rpqiakVTEazJMvaV34Ox2/pSW4LwBUXZtL7kSkezhGcWXHBH+fMVIjO2b0II21Pd6P1PIj8Xgvsoq3sSmnVeLapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZxjwzTn9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000037;
	bh=ydv0dj1ouNGeLIsMSrdmifpN8XSR2k+C1xJp556epXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZxjwzTn9DG1Pr5gPvxeMA7NkqV9WlwenNxppxHdRieVmqAV2Jk9E87NVFkMNauokQ
	 huaeMbWKcT3YA7rLwlLJiJFbzNF0a+3ovxRSOLGV1eJtK0qZBWMuHgjmCfI6gBUd9P
	 VxQkgsYGRL+Jlt9Mx8C4FkiB8sd6VonRq+tyKL6+w8RCrcN5+7Azv1SMlTOB6Ok56Y
	 QQp4VUWFQtNz3zFr/GSyiBzuY3ZKIEsLxiSsuRKGvwJQz0cG9wVCdC/00voSEsShAy
	 Ha5QBufSL3pb+DAL6KDcIwNr8myT0qk1dnPEouxXVhP3h7APf+wUPJIZKmR+CgMrTI
	 RJ/J1ZWPQCv2Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3820C17E0881;
	Mon,  3 Mar 2025 12:07:16 +0100 (CET)
Message-ID: <ddd4b401-68ff-4b6b-8335-1feb29bfc243@collabora.com>
Date: Mon, 3 Mar 2025 12:07:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/20] ASoC: mediatek: mt6359-accdet: Always use eint
 detect mode 4
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
 <20250302-mt6359-accdet-dts-v2-14-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-14-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> The driver currently reads a mediatek,eint-detect-mode property from DT,
> which determines certain register configurations. Since there are no
> users of the property, it doesn't directly describe the hardware, and
> the default value (4) is known to work across multiple boards, remove
> the handling for this property and always assume mode 4 is used. The
> property can be properly introduced in the binding in the future if
> different boards actually need different configurations.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Same as the internal resistor one, can't find usage of this property, not even
in downstream devicetrees for dimensity chips..... so it's safe to remove.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



