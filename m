Return-Path: <linux-pm+bounces-23288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B4A4BDFB
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21B93A72BE
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552BB1FBC91;
	Mon,  3 Mar 2025 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XAKxN6wV"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9C1FAC59;
	Mon,  3 Mar 2025 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000162; cv=none; b=nHawUDEIbX9nsGc4dCAnMdjabRGeQVf2X59F3Pdaql45h0VAmu0pO+7YqvgmHPIH2JZVFT+5DVpzucCgV1BKhajw0DHs/96mf8q/Nrbz2EitL3YIMIVJJVPkb6SrfSsrAmKrd6r7l/Vti/Ig484vvVf7tJgeOwWqJbYFWGQCen8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000162; c=relaxed/simple;
	bh=ZcX0DHh2Mg8R/p4/TYSQ+SL3z06CIojJdCvj2ypyrc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFGbvre8Z5YbByyDgVWn9nIC7skn0sOLOjP47HAeQf2HA6tQA/BQvjWzUglNXndauZYTbgzPnF6HJjTPhlzl7CjxomNbF9Gk70ueiCrwX+cL7BaIcG7AHbXz0bJ9+l1cnu3t4VRxtxh/ZY+u5anRRAy1zR9H03j2QbpSeMvY4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XAKxN6wV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000158;
	bh=ZcX0DHh2Mg8R/p4/TYSQ+SL3z06CIojJdCvj2ypyrc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XAKxN6wVZoFkpjIJdp3hOdXhAkfHsC8LBHDCcqe9pZd+RBKaQa2b79cTRHuOlNTSr
	 rn91mmh9K2l7J2cODw8LykmW94yFVG40cti3cCqSak5kpTneQ1rs05GBLOg/rSSCfP
	 YgxbkSdZWntoXM6uFRURKfBUzMIYqSFhSlC8pTs/b+MBsrRD25qy5nKehLs7//jVkh
	 xwlzAyiex0Vkn6eSEYX53tAmNY0F2nvxFPCas0oZQaHfcSDkH6osCDT8LD/hHOLHOt
	 3De62TzbjmbyxZEaQohuCscJdjOFD4f3TbmMLwEPoHd8/9C6OugS0rbLlKPGkw5sV2
	 PlvaH9b5wUXOA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2F16E17E068F;
	Mon,  3 Mar 2025 12:09:17 +0100 (CET)
Message-ID: <4c454ee5-6102-4fae-86de-1f562ab9d2b3@collabora.com>
Date: Mon, 3 Mar 2025 12:09:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] arm64: dts: mt6359: Add accessory detect node
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
 <20250302-mt6359-accdet-dts-v2-19-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-19-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> Add audio jack detection node. PMIC accessory detect driver will
> create an input device that will send key events on jack
> insertion/removal or accessory device key presses.
> 
> Co-developed-by: Andrew Perepech <andrew.perepech@mediatek.com>
> Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



