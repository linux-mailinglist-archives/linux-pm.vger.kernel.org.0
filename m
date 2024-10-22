Return-Path: <linux-pm+bounces-16229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8689AB1DF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56EB2B20FBB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351D1A2C21;
	Tue, 22 Oct 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z9BmMrqz"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89151A2562;
	Tue, 22 Oct 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610443; cv=none; b=XxvjkgGUUImK7PFY1VcupaVfloPOwMb2kUmOK5CmuaX/qeN9BjlGGf7bcwHL4i2JTU1Y4TCj78KoGbs4jR9vj9sMkQ4ioogZh1cNWSpqgNWasuSK5jMnp2IDzPSnbBJ9Su00jNvQEpzO2YVMLNfF5Ymp8b9Vfpn1IhUNAclRx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610443; c=relaxed/simple;
	bh=TwfpQeZmZ+rcslK8qsLTLEO2Zb35RXe/CpYrY92DukQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsaCQAjg8GIiMlGFkAE3PxSCpS1UP3bPctOkxWu2Y3cOLCT2ZGyABVSzw1vkekMp16eTjCQVzQItnAl8F5n3y9sbrGDQYVdtp5+FWZwdMLFhjG2xLrU/d2UpDviifuMfAGQ4STaX55SOh8gR4AwjfgJzXIXxSQ6LxkMERSmjL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z9BmMrqz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729610439;
	bh=TwfpQeZmZ+rcslK8qsLTLEO2Zb35RXe/CpYrY92DukQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z9BmMrqz50fGNS5L5EZg84WndU6dfFmORLG4UVGVhYyaoAwMPcXrxeZ77dd0FUVcx
	 ndhCjwhf5loUo7eoYwmiLdKFW3QATT5aFJAwwy0IPYV8ZYJ9uJQNh0p+DFF94ktRhk
	 gNYY05w7PF217d5S1cf0TwBwGXbv+JUnRXbVbPEIyZ1zdWsMeYgdLpsEq5peKgOOOW
	 hrEgnGteGgmLxghAwZEVNQOG3slilWGwzbXqcP9KqaWbgmuPrdfiSqgzz7m1AbO7yM
	 342Cl26waHV8rgqYG96HoiwLQHouMe8aoEjRSF/DqlACsG8ztoMpxdAowqz9MDqb0/
	 n3U0o10WfBU1w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CBB1B17E362C;
	Tue, 22 Oct 2024 17:20:38 +0200 (CEST)
Message-ID: <74f0a0ac-4236-45d4-bd1b-327227341230@collabora.com>
Date: Tue, 22 Oct 2024 17:20:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mfd: mt6397: Add initial support for MT6328
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Chen Zhong <chen.zhong@mediatek.com>, Flora Fu <flora.fu@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-5-y.oudjana@protonmail.com>
 <9fbe6e8e-623a-4c8c-b6ea-c3aea8a5a56d@collabora.com>
 <CENPLS.CE17IF58CL3J@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CENPLS.CE17IF58CL3J@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/10/24 16:39, Yassine Oudjana ha scritto:
> 
> On Mon, Oct 21 2024 at 15:24:54 +02:00:00, AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com> wrote:
>> Il 18/10/24 10:10, Yassine Oudjana ha scritto:
>>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>> The MT6328 PMIC is commonly used with the MT6735 SoC. Add initial
>>> support for this PMIC.
>>>
>>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> You're sending this from another email... and you have to add or change the signoff
>> to the other email....
> 
> I was using that email for a while to send patches but then I started having issues 
> with it so I switched to the current email. Since I already had the old email in a 
> few places in MAINTAINERS and I was always signing off with it I kept doing so 
> while sending with the new email. I had this conversation with another maintainer 
> when I first switched and they suggested that I add the From tag with the same 
> email as the signoff, and I've been doing that ever since and it has been fine.
> 

Fine then :-)

Cheers,
Angelo

