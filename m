Return-Path: <linux-pm+bounces-22870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D63FA43C22
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373CD1661AB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDD026561F;
	Tue, 25 Feb 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XppyBFO1"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911A207640;
	Tue, 25 Feb 2025 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480469; cv=none; b=WBOE8YDZzu/HCIYTh4zlGZWr7jc++AMyVsP5tFWQD3GtbN7DB+mGwIwADJzBzh/Gnq+WAg84IbcSquP7t22CStmT4Ivbbj8CxSVW1hprVbdvSSK4GQTHR7NHhnwpUDcDZCpTpAvGOc3MAGXsYur6hDIeK6uxBOzkbYRAFSxMXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480469; c=relaxed/simple;
	bh=/KNAMi38Asr2k99fcPjp85/r0zVkoFead7fJ8kaLyls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pl8K9Qrab2fPgwMeewt3PSh+VryjfD7Cq4LWav2UfkNe/bfR7ojMbFSHcGrvx8Tr3yt1mkXsEyfec3D4Gi6rf0GKeErFX9bwq9kR3VZSgQ+tJEEUXyiEQShuGy9rgN810C3V9NVXzyoAxCRGdDoiJ6Ndt1bbTxPmrtbP78cyRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XppyBFO1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740480465;
	bh=/KNAMi38Asr2k99fcPjp85/r0zVkoFead7fJ8kaLyls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XppyBFO1zrWOk38LONjnkPJFbnC3SR/T47AtqinrOTthalqcfKkLojzzNkWn1mCTB
	 WYaN+Ld3k6nhCSodMoQvHhBYYJ8UKNDSkepKJkQp0fsoh1nihxAcsCXv9XIyO+uAB9
	 mwzdXn5zqNdNnwph2mE6RhpMFRywLpoArNhOp0u1O9D8lGhmaNfsMPkJjDfntGgeM/
	 WpzAK8WpCs4wT9BsqfFRTGdvmc4TAZ9OfEq0YYDJwB2IBh0mg11VMs+rbUsPt1Yaks
	 6uQE2XB/pwWdMdZruzbzMhCMTDPA6d5Gs/0/lXfTzDxGGP8UZ0T3TjBMfrdA66nOns
	 PLGH0y/tgtnag==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BDF2117E09E7;
	Tue, 25 Feb 2025 11:47:43 +0100 (CET)
Message-ID: <1bfe965c-c166-40d6-9cd4-e50fb46fab8f@collabora.com>
Date: Tue, 25 Feb 2025 11:47:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] power: supply: all: switch psy_cfg from of_node to
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
 <20250225-psy-core-convert-to-fwnode-v1-4-d5e4369936bb@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-4-d5e4369936bb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/25 00:21, Sebastian Reichel ha scritto:
> When registering a power-supply device, either a of_node or the more
> recent fwnode can be supplied. Since fwnode can also contain an of_node,
> let's try to get rid of it.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 
#MediaTek

> ---
>   drivers/power/supply/ab8500_charger.c       | 4 ++--
>   drivers/power/supply/acer_a500_battery.c    | 3 ++-
>   drivers/power/supply/act8945a_charger.c     | 2 +-
>   drivers/power/supply/axp20x_ac_power.c      | 2 +-
>   drivers/power/supply/axp20x_battery.c       | 2 +-
>   drivers/power/supply/axp20x_usb_power.c     | 2 +-
>   drivers/power/supply/bd99954-charger.c      | 2 +-
>   drivers/power/supply/bq2415x_charger.c      | 2 +-
>   drivers/power/supply/bq24190_charger.c      | 2 +-
>   drivers/power/supply/bq24735-charger.c      | 2 +-
>   drivers/power/supply/bq2515x_charger.c      | 2 +-
>   drivers/power/supply/bq256xx_charger.c      | 2 +-
>   drivers/power/supply/bq25980_charger.c      | 2 +-
>   drivers/power/supply/bq27xxx_battery.c      | 2 +-
>   drivers/power/supply/cpcap-battery.c        | 2 +-
>   drivers/power/supply/cpcap-charger.c        | 2 +-
>   drivers/power/supply/ds2760_battery.c       | 3 +--
>   drivers/power/supply/generic-adc-battery.c  | 2 +-
>   drivers/power/supply/gpio-charger.c         | 2 +-
>   drivers/power/supply/ingenic-battery.c      | 2 +-
>   drivers/power/supply/ip5xxx_power.c         | 2 +-
>   drivers/power/supply/lego_ev3_battery.c     | 3 ++-
>   drivers/power/supply/lt3651-charger.c       | 2 +-
>   drivers/power/supply/ltc4162-l-charger.c    | 2 +-
>   drivers/power/supply/max17042_battery.c     | 2 +-
>   drivers/power/supply/max77650-charger.c     | 2 +-
>   drivers/power/supply/max8903_charger.c      | 2 +-
>   drivers/power/supply/mm8013.c               | 2 +-
>   drivers/power/supply/mt6360_charger.c       | 2 +-
>   drivers/power/supply/mt6370-charger.c       | 2 +-
>   drivers/power/supply/olpc_battery.c         | 4 ++--
>   drivers/power/supply/pm8916_bms_vm.c        | 2 +-
>   drivers/power/supply/pm8916_lbc.c           | 2 +-
>   drivers/power/supply/qcom_battmgr.c         | 5 +++--
>   drivers/power/supply/qcom_pmi8998_charger.c | 2 +-
>   drivers/power/supply/qcom_smbb.c            | 2 +-
>   drivers/power/supply/rk817_charger.c        | 2 +-
>   drivers/power/supply/rt5033_battery.c       | 2 +-
>   drivers/power/supply/rt5033_charger.c       | 3 ++-
>   drivers/power/supply/rt9455_charger.c       | 2 +-
>   drivers/power/supply/rt9467-charger.c       | 2 +-
>   drivers/power/supply/rt9471.c               | 2 +-
>   drivers/power/supply/sbs-battery.c          | 2 +-
>   drivers/power/supply/sbs-charger.c          | 2 +-
>   drivers/power/supply/sbs-manager.c          | 2 +-
>   drivers/power/supply/sc2731_charger.c       | 2 +-
>   drivers/power/supply/sc27xx_fuel_gauge.c    | 3 +--
>   drivers/power/supply/smb347-charger.c       | 2 +-
>   drivers/power/supply/tps65090-charger.c     | 2 +-
>   drivers/power/supply/tps65217_charger.c     | 2 +-
>   drivers/power/supply/ucs1002_power.c        | 2 +-
>   51 files changed, 58 insertions(+), 56 deletions(-)
> 

