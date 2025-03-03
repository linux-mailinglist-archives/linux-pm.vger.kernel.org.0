Return-Path: <linux-pm+bounces-23285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E369A4BD9D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101AC1895FAB
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9901F78E0;
	Mon,  3 Mar 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WOZ908gj"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FA1F419F;
	Mon,  3 Mar 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000058; cv=none; b=P8nFGNM0STUYfAPp1ThcsFjm4PRSJ2qvZJmdmzyB07yMGJ0Nqj+YJBNR7xSqWkuSIZyxignZia0Qsg1QhcIGu2i4n9KIrQDBEUVkqxPQOFGEvxLtV6QXtZ/WDKuC6R7EgG1VVz/Z8dIko8e2fK+6uYvZjoNy9Mho3OUIb7sZwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000058; c=relaxed/simple;
	bh=OolUssdw8s+8uO15m+LPb/DPhu9schaohRHKsJq3xZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uW0WAyHPfjUwAq4hPxHYQa4biaQOOiVYJGynGlzCVjbKiJwfp6Aw94vpOtUj9uw2XhwVCKKVlTU7OlY8k6t4Pw4NuZ1k3d+litkph67DbXyv9nYgazqMidLoJDStd3kyF/hbpUSmoZGMnyuf/2cJe3MZkg094m56bs3+3ImYFGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WOZ908gj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000054;
	bh=OolUssdw8s+8uO15m+LPb/DPhu9schaohRHKsJq3xZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WOZ908gjvJNY5AxQz60w31MW//POXd5kyBYLJPfJ87zyLdTB6yH67yQzLaYUyHvn4
	 eShfpI4106nlQsia5YLTCg77KfjSmeSK/aiZwGfZ2O99KD5QRbSq8Up5QqVPatfdiO
	 UcJ0O4BDgWO8JR1CQulmRSofD5ud2GNBiSobqnvBkfFkRKYTT0tZWeNyf4ljQqXKvr
	 q0deYDK67my6KHJBMEQ7ofn8NM/K7vm/nuG5yBuFJNmxDycYciGdlvcUjae83WHnH8
	 ITy2W1sgLrqdn9XB44gH0xjLNV5JR8DBMaO+LDy64isf9K//lXojMAw6T3bkFKCbVN
	 6mXp9MotsY5tQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8AAFA17E0881;
	Mon,  3 Mar 2025 12:07:32 +0100 (CET)
Message-ID: <3ab8b2a3-b9de-4c1e-b650-2892be8fc8c9@collabora.com>
Date: Mon, 3 Mar 2025 12:07:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/20] ASoC: mediatek: mt6359-accdet: Handle
 hp-eint-high property
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
 <20250302-mt6359-accdet-dts-v2-5-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-5-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> Now that the dt-binding was introduced, the property that governs the
> eint polarity is a boolean called mediatek,hp-eint-high, while the
> current code handles a u32 property called mediatek,eint-level-pol.
> Update the driver handling accordingly.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



