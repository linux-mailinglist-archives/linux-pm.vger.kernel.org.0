Return-Path: <linux-pm+bounces-23274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74960A4BD9F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4043A3954
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05991F2360;
	Mon,  3 Mar 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CPxDhkrg"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1C1EEA54;
	Mon,  3 Mar 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000018; cv=none; b=DwJB1fJXtuVTd0nDQM7fmRZlg2Fw0QQqPyNIgfNPhDEKSBKI4yHbdZfwORB6tmRfIaDWfZ2KP0BsD36vdSDkhra+YT3PX9gluBdTdPmYlqTjaqmcVc3O1+M9B77kAy99DfsRigwLO6hpQ2O51E7CXFTfEoPZWGG3YTle8VfdVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000018; c=relaxed/simple;
	bh=2mMR/ffIZifLi7BsVpihCzekLorj6Q7yZBnc0SUddy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAwaKqMsnFG7A/suQG18XdJ64Z3p6UxyET3Zq9yrqECB6XpQFAqtI0EP7Q408WsYdKr5xCUeLIhg82fI48M5GNX2ABeeSUVvN9rBQUznz24Ew0KvvXlJmiIWKOfhFhaW0R77rIsNvRZ7d+oZK4DU433hKjbazo1i6vnRBF0/JeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CPxDhkrg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000014;
	bh=2mMR/ffIZifLi7BsVpihCzekLorj6Q7yZBnc0SUddy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CPxDhkrgmN5GXKvZ4GjnqUOfTwIM7W1gCMAs8tB8bHNaGd4CGhGVP67J0Y8+THUOH
	 qCY6oELE7AXtztYg6cD9GF7Df7qE+bwnoPgXVGkPUtpCcLKO1Xh4ENPj738g4SF4ta
	 XDYZkIExX1EbI3Z4PLEM+m0PnWwuD0GfPnyNnE6uuCNFvgm+wAbVq0LrCELx79ZW8o
	 yWbqwSPNxYNeFBKG5a+mg1H+loqLdzDffNegaEFRHL0bhBLiapnDQ+juXvNYpei8MU
	 SGtmeo7U6xmf6Ssl1UH9HmN5u1AT4jxf5r+K6SjGz5JrYMP+wwMWTLVfo13flTqBY6
	 v8XStgxapc4hg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D8C617E068F;
	Mon,  3 Mar 2025 12:06:53 +0100 (CET)
Message-ID: <b1087fb6-99e6-4c54-b981-b8553bdecbe6@collabora.com>
Date: Mon, 3 Mar 2025 12:06:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/20] ASoC: mediatek: mt6359-accdet: Always set
 comp-vth to 1.6V
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
 <20250302-mt6359-accdet-dts-v2-17-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-17-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> The driver currently reads a mediatek,eint-comp-vth property from DT to
> determine the voltage threshold of the EINT comparator. Since there are
> no current users of the property and setting it to 1.6V is known to work
> across multiple boards, remove the code handling this property and
> instead always configure it to 1.6V. The property can be properly
> introduced in the binding in the future if it really turns out that
> different boards need different configurations.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



