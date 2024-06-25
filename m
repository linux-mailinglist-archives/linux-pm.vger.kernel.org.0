Return-Path: <linux-pm+bounces-9941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365749166BC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 13:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86AE28CB78
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 11:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A214BF8B;
	Tue, 25 Jun 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c2REllb/"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B83149DF4;
	Tue, 25 Jun 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316743; cv=none; b=H6ZxmtKoVI2wzzy0Spj56F4E2H1UO5c17DIgyVZ0xMms+fz6/W4Dfb0rpEMX8IQ0RYfW6jdZSduMvoJ/XWhdmKkzkPkGEmooINphSMj8+O1AHBp3B/rIbhDfxSCu9jBxluV/pJIByv8mMj73dthgQi5s72XsITrl/k1Q9ydN/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316743; c=relaxed/simple;
	bh=v0YC4IeTECyIp/iC9IzRXR1jeJv45OgY1qqRU0qP1lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcsPnAELSBrxlXNLk/ykaJBwr8zYQoZGqGCq9QO1WNzIzPq+cBSsCmkfLp2TkDL/7EV/PR10cAKNFG9Zq4fCmOeUHxQ8g8V9515QXLACCEVkxZiDj0xGE0DQN2fUqce4bYdXdzxzw4Lf+wGDV0LS561L6+ocpL98xJeGZrIjIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c2REllb/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719316739;
	bh=v0YC4IeTECyIp/iC9IzRXR1jeJv45OgY1qqRU0qP1lU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c2REllb//m9B0CzKO4teapGYlRuuC5wdlwTQVUxOVNywTkT+Rol6OF9qXOfWt7r7X
	 rK4PSMunCHcnd6aZX+6NV6NG7CZzyJ+oKi3RzRfnGrKCcNGbozfyvopYqfcFZUI2Ds
	 GvhWkJ6XnIOx3wkQGKvTpNZVJOpyqKLRnPuhJlt2VZ97Rrf1eR3wRvWNqs1uqGxaCV
	 srDtzAGvRYORyX4IhYtxICKfBtlU9WG55L24LV0QwAaiycFMr/eiaDDHfwP0zfUkOe
	 4iVX01DULKVcsHp5gJBhMg9bLF3k+l3SAh+GJKjv4cd2MAZW0PRTVoU0jiz/vnSjwL
	 9iI0oH9RLrqhw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5B790378216A;
	Tue, 25 Jun 2024 11:58:58 +0000 (UTC)
Message-ID: <39ed7b8c-b19a-40de-9b30-a731ac83ad20@collabora.com>
Date: Tue, 25 Jun 2024 13:58:57 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <57cf8f9f-4320-4c55-a9f8-a4c1facabfe8@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/06/24 12:25, Mark Brown ha scritto:
> On Tue, Jun 25, 2024 at 10:32:30AM +0200, AngeloGioacchino Del Regno wrote:
> 
>> Mark, I assume that this series is ok from your perspective, since this has got
>> your acks and r-b -- but in order to pick the soc/mediatek stuff I need all of
>> the dependent bindings to be in as well .. and this includes the regulator one!
>>
>> The main issue here is that the main soc/mediatek dvfsrc binding
>> dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
>> does use the others, so I can't pick this one without the others being present
>> or the validation obviously fails.
>>
>> So... gentle ping :-)
> 
> I can't tell what you want from me here.

I'm asking you to pick the regulator patches :-)

    dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
    regulator: Remove mtk-dvfsrc-regulator.c
    regulator: Add refactored mtk-dvfsrc-regulator driver

^^^ These ones.

