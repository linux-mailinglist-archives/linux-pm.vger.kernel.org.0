Return-Path: <linux-pm+bounces-23412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCBA4E4F3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01C719C79C4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9574280CF6;
	Tue,  4 Mar 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V11NaW9z"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE674286294;
	Tue,  4 Mar 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102893; cv=none; b=Y66rxyDMGaF9aUbuyYzPh49Sua+1Hztb3+1iyVNMjawqD8D9SJ9EFIcZlp1HH9m5Qwwhri5mjUeVO/8PMKuDZH3HZxOtnuzmXxOLMz+gotFOChoaSQZkpdBLl7FyxnPqE250JeFNjIO9pCL9Z6/L/Oy40VdfNSoP1DERff76dwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102893; c=relaxed/simple;
	bh=mvBrY6YFvpRg5GjXOhGlre9ckKrCJg9/70l8HVzjw/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMpo5K/ckG9xNluRlBzduSAFbHuai13T48eYQBfWnBPwmNsnf4pggNIDgMQMpuyt3Z0f808uOHk30JsRuPkSP1DDdw7NGaU54puJXTKXxRDShtMwgrfwrcX2J6yAjrOynnZ5iPKqeSpR/HZ/O8H3MsAoMe6CoFByQPGL2Ahfd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V11NaW9z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741102889;
	bh=mvBrY6YFvpRg5GjXOhGlre9ckKrCJg9/70l8HVzjw/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V11NaW9zfoFsYpy57yvhtH/jd6XnQ6HuD2gTqWIGoy3d7dZeymCxcnGTWVD/QoCRg
	 a5q8Gzn8tMjaTPeAua9SFilwR9UoLGPObKAQeMURsrPZdaN/sVvK58PVlyHS7ABiQU
	 kbQOqIrn4CxpB73Hv0btZ58rhadhw9jkvSziHEDMZ884paz59U9988ObhjcKI8uozx
	 SZPTPUHtEaL5P/vvKfPK8nI04c7lZJCmm4Wm6Whis0bVZfvgz8gspSnTCNoIJrXZA9
	 RDh1phsRPMPg3W6DImkTlO+/5ppOw5kEdP3mJbHz+3N80U2PX3i1EyaLeSFY+yZF2Y
	 P9hnwl8/3zmYg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A7A5A17E087E;
	Tue,  4 Mar 2025 16:41:28 +0100 (CET)
Message-ID: <f9fad64b-963f-4059-9b80-7d1c877525a8@collabora.com>
Date: Tue, 4 Mar 2025 16:41:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] dt-bindings: mfd: mediatek: mt6397: Add accdet
 subnode
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
References: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
 <20250304-mt6359-accdet-dts-v3-2-5b0eafc29f5b@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250304-mt6359-accdet-dts-v3-2-5b0eafc29f5b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/03/25 16:15, Nícolas F. R. A. Prado ha scritto:
> Describe the accdet as a possible subnode of the MT6359 PMIC.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



