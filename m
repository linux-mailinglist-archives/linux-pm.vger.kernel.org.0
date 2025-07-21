Return-Path: <linux-pm+bounces-31190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D8B0C1A4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004CE189B6C4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E37298CB6;
	Mon, 21 Jul 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKMwD7tk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B8298CB5
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094672; cv=none; b=MP5uKAxCeSqrZy3iSscSYmWZOO0ItaPCi1ck85wM6WHs6o//eJbHmM8MN01JOcGjFLGhE8boqdmyqFypuFBhAowHcSg/wsX4TtH5JfWM/cQmg/GFDNtmEEPp0phr2L0cH8rXNHFFV0lPmTOqt+LeegdQkJ5yAsrI5sWvu1+M7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094672; c=relaxed/simple;
	bh=Jyg9VIduqhzzijMHnSKAC2B6G1xD8WFdq0kn3G+RX/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuAhFUj6oTCjgy8jPqz+y9KQg7mJ/lHXRW8jIKXEEvtsLQF4EaQ8IV2J0hfj8ZOjCC2NJMwQMeGs9HrOmMI1NVNUc25zggbHKe2WrF8Y9KF9jhEgUATKgPrFiWv1tjlM/t8F4Gj3d6Bgup7OVmSqIzcSWPlYL2VfZCmydkQyodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uKMwD7tk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a528243636so2499723f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753094668; x=1753699468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jv8CKZAnBLUK/0fb5CiuD7Hp6E+b8QPJo8tRAQ5ZhDg=;
        b=uKMwD7tkDvM6y1ai4Cu5EVRzwrIwC83suT5zEhID5qe2mwleN7zru6IM8MNu7+SUbd
         vgX4l23PX6jIuXULkaJ+TZ3rQ8DgvCSmsxzitnTo+2P+xR1z05kAhjPbNO6apTwr4DNw
         GmJgdxYa2PqJOo0U+EiI1aiKju5Ov4DsUZBp//Q+IZKwDwDBHfy4Cs5PN/+snhj940Cs
         s+wcZA+nsqI0Ywhwe7pY9zH8/gYB6FboDPs8KArN3fVKdyB6hxVxGyqOE8f/YxHjxS5k
         Qq3uIYladgqRGv6yBgyWOrT1rgbsPT1QMm9kqMQdY3DKEFtIM0h0D4TmxlDxvzaX1xRg
         musA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753094668; x=1753699468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv8CKZAnBLUK/0fb5CiuD7Hp6E+b8QPJo8tRAQ5ZhDg=;
        b=YekcJAcjdwO4ByIsWinnViHlwyuZ2eLvcAwylpS1xLfRIr+zSgYYXsIO5fHECuLbr4
         Eb8faaHUxXh7rc1vNSiwEYn23G1YBd6CmxjjAw2b40oPazc3LVcFHwEnhfIIkx84+G3G
         cjAQs16O+fWK9xNvVWvSgAtmGfiMHGwQ92fAGVRJKB5kPHdWCro8hY1NdQD1C0mBZBIO
         qmrhRTLXTJe8bHp/XPPdroy4OYDuoDLSLOGuNNnUs5BzF7HUTw6Oa+ISAjp4YOouz6Xy
         ZF5ieBMa26UXtjok77k/pDIuzCPsxxUAe+CrnANQOGVcOhPKuI4dgq8F0RcDqMUpNKXI
         dkJg==
X-Forwarded-Encrypted: i=1; AJvYcCXZRyx1Jk1mxqBsbj04Yxqq/rpDR0X05PKTCefqanZWM2McxUvgmP6DVW9EGCjhbkMPAQCTq2O/YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQAue7daITagGZSxKCweYwHh6AmGaeiCCrM57A0WZFm7bulQPJ
	KBgEJCIRDQyJPcxUcGYmombjUBDzXAWCz7T+lTi84kQFEbWjLaSUGWFQFiziDEAEPJQ=
X-Gm-Gg: ASbGnculuU4Iusyg1EcQw8I76HSy1qwwC+Ag/l35Yhh0PK/0ar5q5UyXtH5O71QStN7
	0EObhogM/ayOD/sXHrfmeaS93TXEZcAM79RkSx0zfDVaf9kr1gtblaRXmY1dYluBDb/BpfNgFnU
	0VPuGbUb1INquPwnFTi+ozgqsb5M89Q3AegxxghfyOthe8/Hkfs1SLBcMIFqBu7h3ZWD/x8csjl
	wRe+bNvCTx+3V2wQufKQ7Qx6SUNz58n6Gy/dYRihQnzOy6jqLRO8E9ZwkjOgxg/TL5ZRfHVdzjL
	ZxZf2smLjOCdGegE6ulvYrwhQmmJyfpthuNzcfnmu5xuB6lWrnbV89omIfjfI5ehgh9B0t7D6ay
	XvsBSNOXa+RoikMXLldWjt/xGEdEroqaReuz45BrW9KOWUBYuOKF4/qg/RX8um/ZEz53RVOZPVg
	==
X-Google-Smtp-Source: AGHT+IHsr6BfHmmGvAFEpmk7FK7MXUXtHfZVvvvivtdI5mefMv0lLuRMGQqdMBTcEDjNOnr/mFRYmQ==
X-Received: by 2002:a05:6000:4108:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3b61b22ec16mr7504872f8f.56.1753094668208;
        Mon, 21 Jul 2025 03:44:28 -0700 (PDT)
Received: from [192.168.1.36] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48c40sm10159988f8f.58.2025.07.21.03.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 03:44:27 -0700 (PDT)
Message-ID: <e724e6a2-21a8-436a-8809-ce73c0afa433@linaro.org>
Date: Mon, 21 Jul 2025 12:44:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 sboyd@kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org,
 krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
 <20250721075525.29636-3-angelogioacchino.delregno@collabora.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250721075525.29636-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Angelo,

On 21/07/2025 09:55, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate a SDAM device, internally located in
> a specific address range reachable through SPMI communication.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for SDAM
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.

This is honestly a really nice improvement :D>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/nvmem/qcom-spmi-sdam.c | 41 +++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
> index 4f1cca6eab71..1b80e8563a33 100644
> --- a/drivers/nvmem/qcom-spmi-sdam.c
> +++ b/drivers/nvmem/qcom-spmi-sdam.c
> @@ -9,6 +9,7 @@
>  #include <linux/nvmem-provider.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/spmi.h>
>  
>  #define SDAM_MEM_START			0x40
>  #define REGISTER_MAP_ID			0x40
> @@ -20,7 +21,6 @@
>  struct sdam_chip {
>  	struct regmap			*regmap;
>  	struct nvmem_config		sdam_config;
> -	unsigned int			base;
>  	unsigned int			size;
>  };
>  
> @@ -73,7 +73,7 @@ static int sdam_read(void *priv, unsigned int offset, void *val,
>  		return -EINVAL;
>  	}
>  
> -	rc = regmap_bulk_read(sdam->regmap, sdam->base + offset, val, bytes);
> +	rc = regmap_bulk_read(sdam->regmap, offset, val, bytes);
>  	if (rc < 0)
>  		dev_err(dev, "Failed to read SDAM offset %#x len=%zd, rc=%d\n",
>  						offset, bytes, rc);
> @@ -100,7 +100,7 @@ static int sdam_write(void *priv, unsigned int offset, void *val,
>  		return -EINVAL;
>  	}
>  
> -	rc = regmap_bulk_write(sdam->regmap, sdam->base + offset, val, bytes);
> +	rc = regmap_bulk_write(sdam->regmap, offset, val, bytes);
>  	if (rc < 0)
>  		dev_err(dev, "Failed to write SDAM offset %#x len=%zd, rc=%d\n",
>  						offset, bytes, rc);
> @@ -110,28 +110,47 @@ static int sdam_write(void *priv, unsigned int offset, void *val,
>  
>  static int sdam_probe(struct platform_device *pdev)
>  {
> +	struct regmap_config sdam_regmap_config = {
> +		.reg_bits = 16,
> +		.val_bits = 16,

I believe registers are 8 bits wide, at least on Qualcomm platforms.

Kind regards,
-- 
// Casey (she/her)


