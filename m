Return-Path: <linux-pm+bounces-22872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F4FA43C37
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4B43AB0A3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E109D266B61;
	Tue, 25 Feb 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fj23EPUc"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE2254858;
	Tue, 25 Feb 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480580; cv=none; b=h+u8tdJFcQlJIyYd2tBGMHOh1GWBzr74qyI4cd8+JDlT1awREv2jHr1yHXYIyG1s9CIZK6PyAtk7dIP371PGvc8dPziLjxEL3kQTiEDDRt7Sk/U2j7Xh3A6FPY3RAYIcMsgxnMpHJI80AqKDTiIdOI6QPxNRpAwGasjnwUOTlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480580; c=relaxed/simple;
	bh=EbYmTPXeyBA9afwPUrOtUARGZ82uqmoXuJddXihYSHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHhnkOfwexbSJi3QRfJZ3l41YWAW6wR4ox/1iCl+BvhcaLbxTUZq3S29L/55dtO5T2ZtzPxhPXHUPIX9IyCKx9FZhW/FUI4OrreAl6Y4XEc48Ivh9d7Lmv1f10y6j15JivG8i0V4afhW+c4+1k2eZaIja1xb/K/VbU7zxJ/C5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fj23EPUc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740480577;
	bh=EbYmTPXeyBA9afwPUrOtUARGZ82uqmoXuJddXihYSHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fj23EPUcpbG44NrLwzMsMkxuydg64/Fo1b/CnjXbkf67jy3P+5SRS8t9cFqcbta/T
	 LvSzBBPjOLnsLVLQIjb272/TxyvhHZjpFKyA9ZgHxpSi5lw9WVE4UjCUmmVGkjuGfj
	 RhiZr7CADGnHt5rufxDpd3yME/jKHHj+y7Eod7zh/1MJKGAUU+AGxA+YNHgVRlubU9
	 RNeTkRdcGrFixhimJ378JK8fZGLa0XORZOu3Gj0jGZvGZuovzgFCJbg/x1hiNyPslJ
	 XCXenJPITLfkWaHfjZqYD8hFshbRhyQ32bT8f+/PwxZH8WkMWyvZBv3GSaL71UTmYI
	 LTowy6FThgVOQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E159F17E09B8;
	Tue, 25 Feb 2025 11:49:35 +0100 (CET)
Message-ID: <c995c148-d27f-4f09-880a-4680810610ac@collabora.com>
Date: Tue, 25 Feb 2025 11:49:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] power: supply: core: remove of_node from
 power_supply_config
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
 <20250225-psy-core-convert-to-fwnode-v1-5-d5e4369936bb@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-5-d5e4369936bb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/25 00:21, Sebastian Reichel ha scritto:
> All drivers have been migrated from .of_node to .fwnode,
> so let's kill the former.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



