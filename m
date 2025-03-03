Return-Path: <linux-pm+bounces-23282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0669A4BDD0
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A023B9ED4
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7301F582A;
	Mon,  3 Mar 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oskTJkVg"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065311F55FB;
	Mon,  3 Mar 2025 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000046; cv=none; b=FtshjUdo8HmgHS0s8fY4tBcTb09bNobDGoLJZ1XWaB+Le3DfufUoegjMa3GHq4x1gzK9oH/X5kZ9feqvrmefwZXsZ7EXe5E4rCbGPYNWXHKvPqlcdgISxqnevbURjFowORPBGMoy5UjWRzIwQUQEtf3o05GRlN3RKy1uchXvjI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000046; c=relaxed/simple;
	bh=YFi/CQNiPmpq7VS1aEO8k340+7EOj2la8l5QkoY6kNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMiHFOnQJgBuDbNa78RLH65LK36GDtnYDTEk2wGRWKGa4U1P8iYzPJXo8s4NtnefBXlNgl+y31OI/QF+yFnQBLTSlTWzxLe0Yr8rNrxnV/7Y54/5ui2d4JDaXRciExAcLjQ/MpFokrO6DxgD3eN6Aab5Z7syNqnseDKB2g4vZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oskTJkVg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000043;
	bh=YFi/CQNiPmpq7VS1aEO8k340+7EOj2la8l5QkoY6kNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oskTJkVgg0gn8zI8fkmXE4o6td6hBteCpj2dJjhjyONhRmXxb1+ah9X7CezKeuyQy
	 wKnC/Q+8TO8be1qb+TeE8o5Xbl6o3beX7gdFcXTpa0NpkQzEwVvalbs1Lg1t/cI42r
	 I4nivpVg4vd0XfjAVda3gS5JVVkrJMLY9z/Qb3zRaJjs9PRAbEfwi0dMUWtlhFS3DM
	 sfFS09o8jYKiS2XBr5YCqxESgBQmD4cEd2chiE9kLna6VlwI4Rit3WOB029wgt4VvI
	 kFbkKwtuEjOCOpewcTltZiuLM7MXOQe0Hq1T+h7tEg8lZPYfalCQj9FMQ0WUBgyRg0
	 x0yzwNuLFc4Lw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 111B817E068F;
	Mon,  3 Mar 2025 12:07:22 +0100 (CET)
Message-ID: <7bce0cec-3a44-48ce-af55-db20135f696d@collabora.com>
Date: Mon, 3 Mar 2025 12:07:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/20] ASoC: mediatek: mt6359-accdet: Drop dead code
 for button detection
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
 <20250302-mt6359-accdet-dts-v2-9-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-9-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> The button detection functionality depends on a calibration voltage
> value which is currently not updated anywhere in the driver code, and
> hence it doesn't actually do anything. Remove this unused code.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



