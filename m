Return-Path: <linux-pm+bounces-9957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454B3916B0B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 16:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AF1B26A10
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18616EBF4;
	Tue, 25 Jun 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LoFJl8+t"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69516D4FD;
	Tue, 25 Jun 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327121; cv=none; b=ftPAfHEogewzFapTaHyz9k7Dn4szQ4e4UZTeWr0ms3CVhFWQWnRBVJH/otkwNmFUDNqy+XBckc4ACxIroAO1uZi9YgJBRQFJ3E5pk4rRoakBFQsRjwzQHJ+de5EyuVpa309ldG+kkqAqUaJ5EWh+JasyuX1TlNTxVo/dvwVpIRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327121; c=relaxed/simple;
	bh=JoqWTqCrbpFahu8o+ed8C7pB2idzuicnlVb3Hvo7YX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJJUfEioyjCs6TZu0kx/ytMFI5MFwDiruhu6EOszt0Eikfi4MxDUXfwhtEGy6bRUrfliIfwsQyHPr0e1bEWHNobWZcGstj1wQqoKxTQS9yFMkQPiidE9KBD4DEc6CMafiEHwmTuii8mrbdBwYYO/045tvdDmynNgdOyC1ojtGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LoFJl8+t; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719327117;
	bh=JoqWTqCrbpFahu8o+ed8C7pB2idzuicnlVb3Hvo7YX4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LoFJl8+tL0lnXDqDz4HvwTijUuSmkbuE+NLkZOjaOi7VCLcqq1y1re+8CKRDG5Vki
	 DhuuTw/Kaz5ZFRYJ7slLQuLySI8MjReLJRnXO5nyNsFKrjU3wbEUoL1oPCvEwNgfFG
	 zk1gCqU/OoINZd+/aIsXoND5uV/R8VxawnV7zcS3eDbbjPbpY3giTsPgfoPRVlDarU
	 Sla29TKwdhxp63FRJpRWq1BZVRSij5eC1lP8YvVd2+7L5W0A/8NOjDVfxMb3pSK0pz
	 4spRjEPVpDyOAySNtu0kLVoDiZrpGQvoQDKb02Zo8a1K1BdBIXsrwPJ8f6tcgFQLXW
	 hDfGLOzIKCk4w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A18A7378219B;
	Tue, 25 Jun 2024 14:51:56 +0000 (UTC)
Message-ID: <f855f6ec-f0f7-467a-9823-d19706574408@collabora.com>
Date: Tue, 25 Jun 2024 16:51:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and Regulator knobs
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, keescook@chromium.org,
 gustavoars@kernel.org, henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org, amergnat@baylibre.com,
 djakov@kernel.org
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
 <f7b4cd98-1acf-4f6b-a7e0-57419abadba1@collabora.com>
 <57cf8f9f-4320-4c55-a9f8-a4c1facabfe8@sirena.org.uk>
 <39ed7b8c-b19a-40de-9b30-a731ac83ad20@collabora.com>
 <2e8a9cf2-2bc0-45d8-b6c1-e3a9441d5641@sirena.org.uk>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2e8a9cf2-2bc0-45d8-b6c1-e3a9441d5641@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/06/24 14:50, Mark Brown ha scritto:
> On Tue, Jun 25, 2024 at 01:58:57PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 25/06/24 12:25, Mark Brown ha scritto:
>>> On Tue, Jun 25, 2024 at 10:32:30AM +0200, AngeloGioacchino Del Regno wrote:
> 
>>>> The main issue here is that the main soc/mediatek dvfsrc binding
>>>> dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
>>>> does use the others, so I can't pick this one without the others being present
>>>> or the validation obviously fails.
> 
>>> I can't tell what you want from me here.
> 
>> I'm asking you to pick the regulator patches :-)
> 
>>     dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
>>     regulator: Remove mtk-dvfsrc-regulator.c
>>     regulator: Add refactored mtk-dvfsrc-regulator driver
> 
> Is there no interdependency with the rest of the series?  There was in
> some earlier version at least I think.  If I reviewed the patches it's
> because I wasn't expecting to apply them.

The interdependency is for soc/mediatek commits, which depend on:
  - Interconnect commits (which Georgi picked already); and
  - Regulator commits

And... you reviewed the patch in the previous merge window :-)

Cheers

