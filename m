Return-Path: <linux-pm+bounces-18341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5D9E00B3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 12:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4892A162515
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6751FA244;
	Mon,  2 Dec 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ITYYuTg+"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF41FC7C7;
	Mon,  2 Dec 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139193; cv=none; b=tinn1CUAXJIPEdUh5ltYdVUmUIlHh21bMktRW39loX2DP2RuS4yDMMv++71MsVWk+loDhZXG5YJ8d4IpUaJXyvlrIdiN5epambfLAvGiNGXXfclGAxDlpEehEHtUo1GgAJPoRVHM5TfSa6CZMvHYvsjTwssa6tdnX3UlzuRgI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139193; c=relaxed/simple;
	bh=Jsl069Z7B15EOI+tkFE003qkYdLsc0cZrKK5DwfnEcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9TWtj0tc5xpm8f4Gjnoen0NU92F4ChmVzeq6oHSWZXBL9MYdgxdrzD8imrSjfdC9fZ2mb3pEKt/ZsXsmxqV6pZJYmbjDPbqISSl/86W0iZ6PvsAnGIYEKfHtDGZkBWQ/9vs3ZSJLVZREjTIIAT+xcj6UILszfP9WFRvZKLZHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ITYYuTg+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733139189;
	bh=Jsl069Z7B15EOI+tkFE003qkYdLsc0cZrKK5DwfnEcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ITYYuTg+SxY9g0kPy84cu0XpYjv4mjm0R/MclZQ3GPtgBIs3K2ogTX8hhXxZ2SzXQ
	 kuau5iLXO+nHJZkz15FOaBmtxgFTO0yV28U2oZL78xV65xYo1TVx6SqvYH3rBthTzA
	 bE7LeGSKnKwsRH0xxDkV6lLMwqfSu01o0sS9smtJ/d0RKVaQHkNPxx7I9cp9j0CWCI
	 BKe0+8s/n2wXhoJt21LhfGX9zVwjiHBHJ5173wmzKc4Ha4Cuxgo1auxdEhxqLvRMc5
	 Qolf5xPUBepQmMDRJJXZbT8SljiviLED/e56iLx9QQ9HTFOfZYGghjEnGgjuaFIdig
	 jKn5qTyYlrsPQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 35DC017E3626;
	Mon,  2 Dec 2024 12:33:09 +0100 (CET)
Message-ID: <000cf951-1afc-4bcf-9f72-c484dcfa1b2d@collabora.com>
Date: Mon, 2 Dec 2024 12:33:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devfreq: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20241130135813.895628-2-u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241130135813.895628-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 30/11/24 14:58, Uwe Kleine-König ha scritto:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/devfreq to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> While touching these drivers, make the alignment of the touched
> initializers consistent.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

For MediaTek

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



