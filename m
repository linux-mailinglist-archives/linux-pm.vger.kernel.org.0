Return-Path: <linux-pm+bounces-23287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89B3A4BDC6
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EEA16037C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC91F4E30;
	Mon,  3 Mar 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TYFf6SKl"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9F1F4CBA;
	Mon,  3 Mar 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000134; cv=none; b=hzdc+FVuM8KeJ2rYCqQe5Toov28OWDxXrE0WcoEZ7g0D32cQ/7CYJN4kF1qNp4ErX3GPqLWvYwKMpamF7J1jAckFJGp60XdGBHCBXKQ77sYiyEzRRhJ+Pfbu72UBDzUh/j75wPafjJ2zp88+XKKlndALn7HUKrEwQNLHFIU/QdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000134; c=relaxed/simple;
	bh=U0Tos3mMbe1iGpS/MgjqLP6xsa3P3UW2Uj91/mf+ZQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4r558jvvE8H44E0vPTC3kpapP/uehSklkhKrrz7xdi8yYO0Lm93BZlOGbzfB6HHfcprhtKBxi+D4yYhORHkznIutNW0R/loDj2RUFviCmms+1g+XjZP35lCDZ72xGoUK5ZiHxRuBH5fx4t7uMekGVUrUwOs3nPl8I+7My2zMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TYFf6SKl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000130;
	bh=U0Tos3mMbe1iGpS/MgjqLP6xsa3P3UW2Uj91/mf+ZQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TYFf6SKlzAbTzNorERlOlv2Cj6AT3jZ9vY3bXJXQv4O5mkfqFuQN+AGjHuE3YnTT+
	 dZU9VdG0+X+EmKUJLumiKcmyOqhe6lWyOuXxPwZqE6XRTfpco1mUbApXwDsMLWpUcG
	 uN0UX2Mw1MNs3ZQfx3i/VcApJcVscZJxByTO/13Kc6sNhC/VpA4KGMMKS8onCahXKT
	 9lE4XKgZIrDXEsQ8HwPPKFFJBK47f6qTHk6EJqBxMJTIKouo1P9KJW94NIbq8VHtPX
	 mtggs32TH4anjiE1ZiH0KkKop7lAzTG6iqrMU9vhkExolrK/gj5W/AAemplAj+gHPe
	 V90xI4YKyb+2Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 86C7517E068F;
	Mon,  3 Mar 2025 12:08:49 +0100 (CET)
Message-ID: <0a003d4c-6302-46f1-9f49-7ea8dc7cd049@collabora.com>
Date: Mon, 3 Mar 2025 12:08:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] ASoC: mediatek: mt6359-accdet: Always use EINT0
 IRQ
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
 <20250302-mt6359-accdet-dts-v2-18-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-18-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> The ACCDET block can generate two distinct EINT interrupts: EINT0 and
> EINT1, and which is enabled is currently determined by mediatek,eint-num
> property in DT. However, only EINT0 is used on the boards that are
> known to have working ACCDET. Since there are no current users of the
> property, remove its handling and instead always enable EINT0. The
> property can be properly introduced in the binding in the future if it
> really turns out that other boards require EINT1.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



