Return-Path: <linux-pm+bounces-19889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 450539FF82C
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488291881E78
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E4F1AAA23;
	Thu,  2 Jan 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fwb850jD"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81819D086;
	Thu,  2 Jan 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735814074; cv=none; b=OE1HbW1w56mjcw0jizR31HoJNX3cyMer3fXQzMoykdgtoryNkA8Hrlylzxnw4HiPIdJqwUNC2Zg2lC0eHNTrxHJIOIk+aO+bSOlNB0fx9sZeQkjwmbpCFI5yu4EYVGosQ7DXv+zDH/ixjEME5t7asSC+jbqMoqr1FSyfykm5guA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735814074; c=relaxed/simple;
	bh=UrA0wl2qAaU7cN7qmWg2X9V+D+uY4VtCKM156+Ohq6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaKRSBSdanwHhQIeYDTV4Fz+ni3WRrkC/SsrMIbtbv/NZCamvvSV01qHSXJcgtDr2l+9/xzOp/lQ8SgLiJbfdfz7Udi9r70mdsxwTTAOrrweQRhf+WTXt2PTt/dXjGNMYmjxpJ5QfDMVOYbIY4RtJA14Kudq5IdxImDUPI49vmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fwb850jD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735813560;
	bh=UrA0wl2qAaU7cN7qmWg2X9V+D+uY4VtCKM156+Ohq6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fwb850jDkO/T5St9QFlcSuaPEgZ+VZIrw8WO9TCWTBYP1kheL7Zx8FSPIEU+A1OBA
	 xeEhOz0T+s6ViP9xwekM5mcR8UwcrPCChPOmVYdTIwsulq4t+fYUwOYOVlAf4szaoE
	 VhyKMPKhJv4UNExQNGnjQpFbYjS+WSwD/iOc5gSkvcFsKpnniHvO+LDte5YbfEnr2D
	 /xXDpG6rbJxOTQ7SQ+9fbsnS1qrTeX2/DmMmBF0uzOG0woOKGB+Fx57dODbp0lAwsO
	 +jQP6BdKr/3GLPUEvv2Db8CuSluGtzBb6jQJbf6hLP5c69qYO+OpUYe3nLYSywHYHO
	 xEinuB4Od5clA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F076D17E1551;
	Thu,  2 Jan 2025 11:25:58 +0100 (CET)
Message-ID: <b7d54b9a-9cea-45f2-b410-09306b113d45@collabora.com>
Date: Thu, 2 Jan 2025 11:25:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] regulator: mt6392: Add support for MT6392 regulator
To: Val Packett <val@packett.cool>
Cc: Fabien Parent <parent.f@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-7-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241226050205.30241-7-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/12/24 05:58, Val Packett ha scritto:
> From: Fabien Parent <parent.f@gmail.com>
> 
> The MT6392 is a regulator found on boards based on the MediaTek
> MT8167, MT8516, and probably other SoCs. It is a so called PMIC and
> connects as a slave to a SoC using SPI, wrapped inside PWRAP.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Co-developed-by: Val Packett <val@packett.cool>
> Signed-off-by: Val Packett <val@packett.cool>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


