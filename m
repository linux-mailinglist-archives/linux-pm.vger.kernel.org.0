Return-Path: <linux-pm+bounces-22871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78D0A43C26
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2D07A4726
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0CE2673B0;
	Tue, 25 Feb 2025 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BgDo5EVc"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC32254858;
	Tue, 25 Feb 2025 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480470; cv=none; b=eQolSK/0uf2cbYptaWAhosR1PkdDsh61t6VW5wjWhdB4ZScGasIrHjHiArhJRX928GDboCEMtlqwtt1Pai/uZ8AaibUDPhnjs9F9nY5lLaMrRc6vygCqX3Cgh4GQ9/7yRXD1+eNmWzESbRWck5TofwcSay7qvOcCOZ9wWm9chSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480470; c=relaxed/simple;
	bh=Ee3FEgFuqLCisMqY83kVOp2qLpb7WjG85o1mDsEfUqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CF9qZ6MA7QktUwQpTexWmzCw5WQfxfsAMVpeNtXwBL6mhbGJIK2DoGVWM+SuE6hRt32M1fA8zXnfVEy52nD5sGkUQqDJZ6nV8UGOfl0kXWoBjD0Q/oSV95JeRbZ0gByn26s35BUaJL1XoGOi2pOhEPQ26gBRAc++UmcHoPXqT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BgDo5EVc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740480467;
	bh=Ee3FEgFuqLCisMqY83kVOp2qLpb7WjG85o1mDsEfUqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BgDo5EVcS2JzMU/rI1UWVc3xVMHh4/wy2Py1vbzKo48wO1RYtK0ViPnOqYGnFQ4wC
	 /5auWWUkjp1XNI7uk1eKTBxXdhorFyPOhY2LB+4ZUOZqmIxAVACUDFsO+n409LVkZD
	 3vA80Y8IPyaHRL+jsZaKOPcIsLvcMKcpY4kYM9ngbKNFnVOvGxUe3DMF9IuM21QCqB
	 Yo6H7LtgsgrXYwNNrt939NVduid5XjoURht+lM+87Nmg+udEQKlRmifEz31p3OyRU9
	 G7WanBlxa/ai7THuY0g5OoOLHnjUY9Fou13XFYqMHHqOvDcjF96+wtMUYvlr6xndip
	 tUrj2wmjehmZA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B97A917E0B63;
	Tue, 25 Feb 2025 11:47:45 +0100 (CET)
Message-ID: <7a683733-ea2e-4032-9aeb-5498876a92b3@collabora.com>
Date: Tue, 25 Feb 2025 11:47:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] power: supply: core: get rid of of_node
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 Samuel Holland <samuel@sholland.org>, David Lechner <david@lechnology.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-1-d5e4369936bb@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-1-d5e4369936bb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/25 00:21, Sebastian Reichel ha scritto:
> This removes .of_node from 'struct power_supply', since there
> is already a copy in .dev.of_node and there is no need to have
> two copies.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



