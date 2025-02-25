Return-Path: <linux-pm+bounces-22874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB3A43C43
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741AA19C317B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984F32676F3;
	Tue, 25 Feb 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Sc2M8tp3"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2E266F1B;
	Tue, 25 Feb 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480602; cv=none; b=B+4Rr+K/KyEXHUOYZrmv3M741SrcL/vkc5kzrfrqhCIwfhmWgn3Agt1fF5z9aCsYa17sAh4nqfB4deHukRr0rcIiI8tFmi6baoPGio7w2LY44hDCSr+WXgGVHzsUOxd8q4FOzF3SRJv7YzjvQxEL//kCRnx+n67LY5VsiPHqa8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480602; c=relaxed/simple;
	bh=5dRJce2HaeIMHMT1TAJmxAiAjglj4zMuB0fEtmUG510=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a03Amb/Wl8FwM2YAZLSFDjVmS54iPhXGrN7rCRdj9sECiGXDOAG+9OxNOa9bDZno4eJ0nPp74o3O0AY/7UoUbsMpJJzfzevz6eGemNecot7Osj4cT8BIdEuXIojeCqrOiATN672YPQ0i+Eg9pm1TNHf2r6CK0d0Nnqt68RKGSfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Sc2M8tp3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740480599;
	bh=5dRJce2HaeIMHMT1TAJmxAiAjglj4zMuB0fEtmUG510=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sc2M8tp3MKr5crseitTfVLonxMtclEf9hvXCB1Ry+t9M3P+lffMQ0okk/ObToYvaq
	 JJt6zhtz64r+mCxc0qIiTZtrvHaUYOpvDcDJlSp/oyrg8QUDNo+hYL+USORwirVIhM
	 MnjrHZfofv9m90RDhHev8xFwDxs75yAtKZvRcy/UKk4fccR/CWUMYTOoNUM8yzQ6Rq
	 jbgiuod4QsUdpP2jDTwHdrYidZknTs7g/WFdGD+BMMm18zxy0W44E8AOyOgfgwq953
	 237UyBQAML5KdK6r6hXoo2HuWH2E+TwTYWsPiTOoeDWrUxHDZ6IkpLFVZ/rFHvzCQr
	 3IxWugsKltmUA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AF95617E1073;
	Tue, 25 Feb 2025 11:49:57 +0100 (CET)
Message-ID: <3f694939-0c5f-402a-8378-471296213d35@collabora.com>
Date: Tue, 25 Feb 2025 11:49:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] power: supply: core: battery-info: fully switch to
 fwnode
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
 <20250225-psy-core-convert-to-fwnode-v1-6-d5e4369936bb@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-6-d5e4369936bb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/25 00:21, Sebastian Reichel ha scritto:
> Also use fwnode based parsing for "ocv-capacity-celsius" and
> "resistance-temp-table", so that any DT specific bits are
> removed from the power-supply core.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


