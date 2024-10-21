Return-Path: <linux-pm+bounces-16110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F989A6D5A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 16:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E461281178
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432CC1F9EB3;
	Mon, 21 Oct 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f289kk1n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C51D517D;
	Mon, 21 Oct 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522530; cv=none; b=MyWwUpFM1TKrgiMDFemUkEwEikkjiLJdlA4iyX9JZ8AX6kLU3Iq6xLUc+29x9F0zbMcO4puZm7QJ9dHFwhkWXiS7krW0CC/OgHew5f5eaBqyC9nNrEWC/4z2b5hVtS4GKKqAXPusUAE4mfRU3Ls8jJ55tphVitPLWMegablo+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522530; c=relaxed/simple;
	bh=XYYOuKK7N4AhTh521C2sLHl1eimfPwywP5dRv+Qj9CE=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKgylmY7Ra8BgtZyexNA5nCWtEWkUp4v7wshJ8WRCv3EkCpijigRrKdim1xlaRLSTueIKKk+SwkLIzKl67XjiEDFPEnXt6/Db53c2gO3LL8PgrxAyfYZ1ObyNzJsZ4k++cz8ZL+dTnvMvXiShf4h7mpT4+GPYt5Aaib9NbLJ/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f289kk1n; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so5054185e87.2;
        Mon, 21 Oct 2024 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729522526; x=1730127326; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3Rgg0MJCMkfbcr4Si6GxlCe2/XCe13lLM5Bd5Kjvvw=;
        b=f289kk1nu61paxTLE8aFw4xa+9WdF+K+umWg3i7HraVVPdc0EOJBXf4NeEEoW1uZlb
         G6Q3bhMoaGhNcnUEV4pErVf+jhPzzvwPAENUnfwgHIJcvKLYgjtJZyxKKRdHJ3yxhoXV
         4DY8UddODaPJj48jIj9BiZBaL9VdZ4aN6kfqGpAujqOxLvsAMpjosgbBfJhD5hrKu0DD
         uzKCu4kisFEU+4bPmY1NDkDQcakvOEpuVEOsRKn3Fq0QQAbetOz+CSCjWWiIweqdQiHL
         X1LC9b/ITunGS+zRzsBMCe1so8l+VCyiFLgW45EPb4BsNxqdD0Rfw67aaaXEI4s2gfjS
         VgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522526; x=1730127326;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3Rgg0MJCMkfbcr4Si6GxlCe2/XCe13lLM5Bd5Kjvvw=;
        b=rDGYqjLUAMBNiuC9CEFnaQYtOVwUam8EoNZsNw/lVK6rmaQQlQtIAQ4DKdGXJ+Se54
         CL1gah2qJZhuojjHcl+gNPddg7u/uTI+wnXaJQtZs0161b8bYfwDw22jT+CqKv70mSDW
         6wHUwdaZowgV/WczrGpam4GNlMCrfFCmOTIJFan0m4YMpv50d3KHMYRung6t/3QpExKB
         +8wybJdKCuIWArqZ3kfXYPZEBJ0ziTfiAcSTPaNVBT4Fr8nbmaGdlXbtO3dm1/WM7JsO
         Vh4qzY//DfwcqtGAxXcFmpahDkf9h+iK9rk6Hkl/IPLYFUqN9Zie777X3mN7MXBpGNoA
         rkFw==
X-Forwarded-Encrypted: i=1; AJvYcCV3pwNX2ySbwDd0TdD2bZCI7IV9aIHhQz8n0pO+PM7wDh7+XFSn8DI4dW3V4eGXuyNwEX1X37dZ4pEq0JF/@vger.kernel.org, AJvYcCWqb9qAXgj5fMay1x8MxxjXBFrqy8yTU0ku6Ncw/IzvleAqrgKywRpTpa5Mug5Tw99ji6XcI/jIVIysOh0=@vger.kernel.org, AJvYcCXVywrf8Rxlg33SVYlELr53qcEfWQUYWetBjQwrTrMoaXpiccTAJ4XuaC2MoKCivEl879jwKgwURJih@vger.kernel.org, AJvYcCXsPT0XVFH3aIxKmDk+Uj94PTfR4pdjJxqzAiWkM3sAjeHwpkIfPTPotmGz5EpO0pzN2W7ya48+EtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz7BLv5leTpSNxRh4De/LogTLzSz3jVeQyBRp6r9xGw04/4WM1
	Ie+5tIJT+TY7w0jaNtOu/JqyKO6sh5VsODTCZTEzyToeHSuPwUBb
X-Google-Smtp-Source: AGHT+IE+YyScAjvYSe25yG8D2UmU8Xnhqk2eOEorogl+DBh/qWGlnW8rmng8G47tnMj4whqFWuze/w==
X-Received: by 2002:a05:6512:2316:b0:533:711:35be with SMTP id 2adb3069b0e04-53a15229c20mr5991228e87.26.1729522525660;
        Mon, 21 Oct 2024 07:55:25 -0700 (PDT)
Received: from [10.50.4.74] ([95.183.227.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9137053csm210335266b.115.2024.10.21.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:55:21 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:55:12 +0300
From: Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 5/6] regulator: Add driver for MediaTek MT6328 PMIC
 regulators
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones
	<lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, jason-ch chen
	<Jason-ch.Chen@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>, Flora Fu
	<flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Message-Id: <04OPLS.YYQIIIW9J73R3@gmail.com>
In-Reply-To: <4cf5a3d0-97a2-4a43-a91a-0a35aa2bc7e4@collabora.com>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
	<20241018081050.23592-6-y.oudjana@protonmail.com>
	<4cf5a3d0-97a2-4a43-a91a-0a35aa2bc7e4@collabora.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed


On Mon, Oct 21 2024 at 15:24:51 +02:00:00, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 18/10/24 10:10, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>> Add a driver for the regulators on the MT6328 PMIC.
>> 
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   drivers/regulator/Kconfig                  |   9 +
>>   drivers/regulator/Makefile                 |   1 +
>>   drivers/regulator/mt6328-regulator.c       | 479 
>> +++++++++++++++++++++
>>   include/linux/regulator/mt6328-regulator.h |  49 +++
>>   4 files changed, 538 insertions(+)
>>   create mode 100644 drivers/regulator/mt6328-regulator.c
>>   create mode 100644 include/linux/regulator/mt6328-regulator.h
>> 
>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>> index 249933d6388dd..e9b9faff67f3a 100644
>> --- a/drivers/regulator/Kconfig
>> +++ b/drivers/regulator/Kconfig
>> @@ -862,6 +862,15 @@ config REGULATOR_MT6323
>>   	  This driver supports the control of different power rails of 
>> device
>>   	  through regulator interface.
>>   +config REGULATOR_MT6328
>> +	tristate "MediaTek MT6328 PMIC"
>> +	depends on MFD_MT6397
>> +	help
>> +	  Say y here to select this option to enable the power regulator of
>> +	  MediaTek MT6328 PMIC.
>> +	  This driver supports the control of different power rails of 
>> device
>> +	  through regulator interface.
>> +
>>   config REGULATOR_MT6331
>>   	tristate "MediaTek MT6331 PMIC"
>>   	depends on MFD_MT6397
>> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
>> index 9b69546fb3f65..c1a5a44413198 100644
>> --- a/drivers/regulator/Makefile
>> +++ b/drivers/regulator/Makefile
>> @@ -103,6 +103,7 @@ obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
>>   obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
>>   obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
>>   obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
>> +obj-$(CONFIG_REGULATOR_MT6328)	+= mt6328-regulator.o
>>   obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
>>   obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
>>   obj-$(CONFIG_REGULATOR_MT6357)	+= mt6357-regulator.o
>> diff --git a/drivers/regulator/mt6328-regulator.c 
>> b/drivers/regulator/mt6328-regulator.c
>> new file mode 100644
>> index 0000000000000..e15a64404f494
>> --- /dev/null
>> +++ b/drivers/regulator/mt6328-regulator.c
>> @@ -0,0 +1,479 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * MediaTek MT6328 regulator driver
>> + * Based on MT6323 driver.
>> + *
>> + * Copyright (c) 2016 MediaTek Inc.
>> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
>> + */
>> +
> 
> ..snip..
> 
>> +/* The array is indexed by id(MT6328_ID_XXX) */
>> +static struct mt6328_regulator_info mt6328_regulators[] = {
>> +	MT6328_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
>> +		buck_volt_range1, MT6328_VPA_CON9, MT6328_VPA_CON11, 0x3f,
>> +		MT6328_VPA_CON12, MT6328_VPA_CON7),
> 
> Can you please fix the indentation?
> 
> Also, all of those entries do fit in two lines, I checked a couple of 
> those
> and always ended up with less than 90 columns anyway.

I can't seem to fit even the first one in 2 lines in under 90 columns :/
That is unless I don't indent the second line:

	MT6328_BUCK("buck_vpa", VPA, 500000, 3650000, 50000, buck_volt_range1,
	MT6328_VPA_CON9, MT6328_VPA_CON11, 0x3f, MT6328_VPA_CON12, 
MT6328_VPA_CON7),

Which I don't think is what you meant by fixing the indentation. Can 
you show me an example? With 100 columns on the other hand it seems 
like they should fit.
> 



