Return-Path: <linux-pm+bounces-23289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD13A4BDDE
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FB5169142
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28B1FBE8C;
	Mon,  3 Mar 2025 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qpfo1opY"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513931FBCBA;
	Mon,  3 Mar 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000169; cv=none; b=ZknzeW2UG0OTBmx/X0MiVz/s6GMP+T6ZyHSKYj09FRLAVWb9q/ytjafNgaJ1s70Xs1MbFoox/KrvgTv6upSbYaS5XYSVLCnLpkHMNW9GNfwpL4g7BkCXAdSNqx+gu1W5WuxrVgtvsA8cl957bFQKKk656D8nxNkprxGZDRadXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000169; c=relaxed/simple;
	bh=UlYDQTcQHBFCTW4vDwKseNxVoKFZraiVmwlJtLTanV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFNluhPs0OfnzTNe6Bk/ZD/Rw1mwZ+zoCz94+ChlRBxc/AeN6Mo1dm4CIbfA6yKRy1jWnAhZbPqjm2XrjMzaZVEs8OIMrZp7Oruk6Eww7psrF3Oe28mnyVVt0CWeCVw6MOukLMjdgHLSL4MfYy4iWOI6I+q+MJA0dl4iY7Ha5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qpfo1opY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000165;
	bh=UlYDQTcQHBFCTW4vDwKseNxVoKFZraiVmwlJtLTanV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qpfo1opYNbKxaBM0tLBtIm92R21KRGzSajcyvY7e7PDCArZlL2NRYjiLvLfggs/wJ
	 kdCpUbbMisG4C/XISDP2x3ZBTU5zXexEts3gJO0HVsTUl0XzVKVOgef7t0XOwaIZ0H
	 CDKzpHrTA9ceWzo+iTyJcYbWSxKT5I42qOL6q4DXEq3Ysz0sxNt9uxWNS13bltN7KE
	 ToYaayPfGwK4lkjmTdq17elmoOQDprYmiSkqHAf2WOKrceTnvZ692ojJIdHyyu13eJ
	 2aUGmNbl8MIy+pkbuWNVQRA2fZycSY3jejECB09xG7EdMCzr/lKJ9DCiiZVMm7/VlD
	 +T8JgG7xbuWpw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ECA1317E068F;
	Mon,  3 Mar 2025 12:09:23 +0100 (CET)
Message-ID: <746eaa07-6682-4088-ab20-f1536e4cb106@collabora.com>
Date: Mon, 3 Mar 2025 12:09:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/20] arm64: defconfig: Enable MT6359 ACCDET
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
 <20250302-mt6359-accdet-dts-v2-20-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-20-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> Enable support for the ACCDET block in the MT6359 PMIC, which provides
> jack detection capabilities to MediaTek platforms.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



