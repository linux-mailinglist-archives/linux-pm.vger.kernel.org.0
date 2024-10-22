Return-Path: <linux-pm+bounces-16204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF6F9A9F29
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E90B22639
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC7199FA5;
	Tue, 22 Oct 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oldtT6Yk"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96C1991B9;
	Tue, 22 Oct 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590596; cv=none; b=Lw63zT53p5G9hesMb4d84EIhKXSBt65VJtYEfp0wVspGwBP1GIEFYKHhkbnFxeuxkUwh5Kcw/EVeE+gVL1Q3BaXJmuJ0Ns7iYyFOmUhwS/9Sx2JJTug1tXDnliDev608wtpulFYrIdgtXchVQ5D4yyJ9Dw0Zx3tbffafNts4As4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590596; c=relaxed/simple;
	bh=nCzRJ1LbBCDjOWEeoH9yNZbsyD6ffv5nqZxpGDEu7+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbmCFVbxS55CItMXZYvlVuv+4ddpRIRFe1ARSf83glphfVgaJkStQvyEdLAzeOa8xXvXiOLmLXGggLvGdDuZqf+bechHy/c9PDAEA4FHxxn2InTi//5x70Oalfc6PVevb5T2kIWSSmZtwsSb6fTlD/nzzqqxCXcDPC4YsESj9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oldtT6Yk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729590592;
	bh=nCzRJ1LbBCDjOWEeoH9yNZbsyD6ffv5nqZxpGDEu7+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oldtT6YkN+poyFUM3an948NAQ1vDUR9PXYx8Qgv9gP5MHbb1W1mZu2iAFx14HSKB2
	 rS9EViKhZhwDXQ5qdRG/h217QlNRCqgoZC8TcONj7xsgn+2ZEBXUnVwCeUgdCC+gln
	 KhNNujVzPfCozkAeZoegEdGNwR4xOAK3j7X2iPZYXH3Pu96ixLlioAFsEoUhaOuGSm
	 TJB0NOXo/eLxJiByF4hShfPhZ3By4L5k7r+kViNBZDIh4jBLrC0a1Q+eU/MbsGeM5z
	 f35kokcURoJos2ZG/mk1Sx6gOqCAhzc3bk1cAaHvOpuRyUPsFwFcuVxP8CBGv+xXsy
	 90v9rUIofjJdA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D6F917E139E;
	Tue, 22 Oct 2024 11:49:52 +0200 (CEST)
Message-ID: <52a7c00a-6638-420b-a65b-208491c55074@collabora.com>
Date: Tue, 22 Oct 2024 11:49:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] regulator: Add driver for MediaTek MT6328 PMIC
 regulators
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
 <20241018081050.23592-6-y.oudjana@protonmail.com>
 <4cf5a3d0-97a2-4a43-a91a-0a35aa2bc7e4@collabora.com>
 <04OPLS.YYQIIIW9J73R3@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <04OPLS.YYQIIIW9J73R3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/10/24 16:55, Yassine Oudjana ha scritto:
> 
> On Mon, Oct 21 2024 at 15:24:51 +02:00:00, AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com> wrote:
>> Il 18/10/24 10:10, Yassine Oudjana ha scritto:
>>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>> Add a driver for the regulators on the MT6328 PMIC.
>>>
>>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>> ---
>>>   drivers/regulator/Kconfig                  |   9 +
>>>   drivers/regulator/Makefile                 |   1 +
>>>   drivers/regulator/mt6328-regulator.c       | 479 +++++++++++++++++++++
>>>   include/linux/regulator/mt6328-regulator.h |  49 +++
>>>   4 files changed, 538 insertions(+)
>>>   create mode 100644 drivers/regulator/mt6328-regulator.c
>>>   create mode 100644 include/linux/regulator/mt6328-regulator.h
>>>
>>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>>> index 249933d6388dd..e9b9faff67f3a 100644
>>> --- a/drivers/regulator/Kconfig
>>> +++ b/drivers/regulator/Kconfig
>>> @@ -862,6 +862,15 @@ config REGULATOR_MT6323
>>>         This driver supports the control of different power rails of device
>>>         through regulator interface.
>>>   +config REGULATOR_MT6328
>>> +    tristate "MediaTek MT6328 PMIC"
>>> +    depends on MFD_MT6397
>>> +    help
>>> +      Say y here to select this option to enable the power regulator of
>>> +      MediaTek MT6328 PMIC.
>>> +      This driver supports the control of different power rails of device
>>> +      through regulator interface.
>>> +
>>>   config REGULATOR_MT6331
>>>       tristate "MediaTek MT6331 PMIC"
>>>       depends on MFD_MT6397
>>> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
>>> index 9b69546fb3f65..c1a5a44413198 100644
>>> --- a/drivers/regulator/Makefile
>>> +++ b/drivers/regulator/Makefile
>>> @@ -103,6 +103,7 @@ obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
>>>   obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
>>>   obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
>>>   obj-$(CONFIG_REGULATOR_MT6323)    += mt6323-regulator.o
>>> +obj-$(CONFIG_REGULATOR_MT6328)    += mt6328-regulator.o
>>>   obj-$(CONFIG_REGULATOR_MT6331)    += mt6331-regulator.o
>>>   obj-$(CONFIG_REGULATOR_MT6332)    += mt6332-regulator.o
>>>   obj-$(CONFIG_REGULATOR_MT6357)    += mt6357-regulator.o
>>> diff --git a/drivers/regulator/mt6328-regulator.c b/drivers/regulator/mt6328- 
>>> regulator.c
>>> new file mode 100644
>>> index 0000000000000..e15a64404f494
>>> --- /dev/null
>>> +++ b/drivers/regulator/mt6328-regulator.c
>>> @@ -0,0 +1,479 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * MediaTek MT6328 regulator driver
>>> + * Based on MT6323 driver.
>>> + *
>>> + * Copyright (c) 2016 MediaTek Inc.
>>> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
>>> + */
>>> +
>>
>> ..snip..
>>
>>> +/* The array is indexed by id(MT6328_ID_XXX) */
>>> +static struct mt6328_regulator_info mt6328_regulators[] = {
>>> +    MT6328_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
>>> +        buck_volt_range1, MT6328_VPA_CON9, MT6328_VPA_CON11, 0x3f,
>>> +        MT6328_VPA_CON12, MT6328_VPA_CON7),
>>
>> Can you please fix the indentation?
>>
>> Also, all of those entries do fit in two lines, I checked a couple of those
>> and always ended up with less than 90 columns anyway.
> 
> I can't seem to fit even the first one in 2 lines in under 90 columns :/
> That is unless I don't indent the second line:
> 
>      MT6328_BUCK("buck_vpa", VPA, 500000, 3650000, 50000, buck_volt_range1,
>      MT6328_VPA_CON9, MT6328_VPA_CON11, 0x3f, MT6328_VPA_CON12, MT6328_VPA_CON7),
> 
> Which I don't think is what you meant by fixing the indentation. Can you show me an 
> example? With 100 columns on the other hand it seems like they should fit.

I can get that one specifically to 96 columns... it's okay.
Just don't get over 100 columns please: if a few need 3 lines, they just do.

Anyway, here's an example:

MT6328_BUCK("buck_vpa", VPA, 500000, 3650000, 50000, buck_volt_range1, MT6328_VPA_CON9,
	    MT6328_VPA_CON11, 0x3f, MT6328_VPA_CON12, MT6328_VPA_CON7),

...since I'm not sure that this will render correctly in the outgoing email, here's
another example:

MT6328_BUCK("buck_something", SOMETHING, params, blahblah, thisandthat,
             something_else),

Cheers,
Angelo

>>
> 
> 




