Return-Path: <linux-pm+bounces-18407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1306F9E145A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD2316450C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5625818B463;
	Tue,  3 Dec 2024 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBqtLs5n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C82500BD;
	Tue,  3 Dec 2024 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211363; cv=none; b=inV9eEFYcUNYbL4u4MQaYzSnmkvm7PFG/+1nyhnq1zeI8lmBqslFOioz4VEmyGkZQGrZaHHijvEp1k4BD0Y5b+5z/al+iy26ZWB1mtXXLlZqo4a+knHQ1SQKfe61NQ67X9sC6BZlJgBSqeN28UQkahxKDoInGcY/1cqxQyibcEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211363; c=relaxed/simple;
	bh=kUIiMwsYf+9N70GWErL+9fR1jC5ipa81I88dPMp4Vl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsvfcweiziQKvcfLb2WAFHS9VPQqloZajkho4vVP8f5zB8qglvXFQ+UaOVW7Pze0YXNUdjkVpSbffmfl+TESKQOn0aD9EjnMCV9C117IC9HUcbpcZ8ah1LboVNz23wvljj/XYUE6g5f/6Bk9LgYTY2/fLjewNcgGNGmTahxwn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBqtLs5n; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so1728458f8f.0;
        Mon, 02 Dec 2024 23:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733211360; x=1733816160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/nDXf9cEZNcrU2bKSXIPLr1H7Y3bQK4ZXvIbat3oFo=;
        b=lBqtLs5noIcnZ6ybPH/agQ1QO7FAqrCoqguFQ/9hPEZgHvfoQ2jqGoZ3BLMb8zSDgw
         G85jJQO1R7oUpAbrlbMoXg4TeZR0132H9iHtQ9GcWEQHtsP32orUwI/DTuTzUKCPV2a7
         AMHJ6wtUazUA5fy/Rz3IwyNZxEr/iKFNd6ZXhF7ewIuXjjATbPrziA9X9P3Nfi1AiKBM
         z/PmJjyQfJMrCIo1EcJxCqSG0dC5/dFo2nE7IpbNfnvs9jMi10rz1fzLn3SyySU/80jq
         DCQkAqR4L1g6lkHNxDBj+ef//V7nuL8ORZKvH7IEf5k0N0+KPnUObbngPLIHjmnH18k6
         Fu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211360; x=1733816160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/nDXf9cEZNcrU2bKSXIPLr1H7Y3bQK4ZXvIbat3oFo=;
        b=XSe2dsveCEDgLHscXzKll1OFpuXaeX7uPAVt1CZMeo6KvNrYPx8LcKFLUSbwidQMYB
         7IL33GytrXF0LkOzlXEJ8k3upzLmpjErcJKHQ4FnPX7tK7ekGSx7OzuuMNmSzsW+NAs0
         xxPqELPg5rTMchfYNjpyql77xQ2U0BFjf9TlEGo1StvStuq1hhiNFE5QN2j73CHlefhT
         G9+aEzKBfTsdapC2Nm8Ev7n/6UiRVNmMDxsrG7vy4S8TMmOK06A89ZPNMs1EqgwELu/f
         6k0NFkujKTLYSaFCE3PNLnpQt2xapqRonyIgkGMTEzdEDySdAgwqtGW4P8qlBibCFsbG
         WYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Mha4R3H9EdLnvCRzkyG1aLSklYdfr8tV2sWFdIwt6OH3D+UzGCRPNytjOTqn9NqS9PuP9x2T3oVO@vger.kernel.org, AJvYcCUEYFBxqacg8PyTiOVcuUk31wpflB1HFrzzkWvGI7pb9pNVfShqjKfIeHSWe4FeVq6xrhG8y02DhhlmdclY@vger.kernel.org, AJvYcCVAfpfF6/13szuGrkjl2qYim02iupxWiJsS7X8Zi8lItTmwqhlll/KJkRcTHXJ6rEaxuCmeC0NM/juyrHn30S4u6lY=@vger.kernel.org, AJvYcCXtOpRFvGLtPMq2RCUtWIceLYA4lYhKA+8AN1/AMctM3MWtZmwAGl+ItNjLQN6IaK/x6Wd1Bwx/P3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWbjjFD0k513aBTizTya2zc7LHiJYHHp9j9F9otP2hnghMGrSB
	esudxOSczUURVKd9qOiScCnxhNWo7CGAnboP5vxaxeaASyvYa4+c
X-Gm-Gg: ASbGncuunLllev6wSK5KlJBLwo2j3Co/fbPT5bpl3niib+dobBn574undAsdp2P20cp
	n/vl4pKLrKPKwB3Yazy4+1B4mmHfdmPgiOGW7Ukr+7x+VoXNzZI7ivh0kkIx8N4Cf9ipfPoS4EG
	duZtophqWuBetsgo5SU3nVf0VOhRXbH7CzGwqtRt2+phm55EuptcMTLSfHty4o1gYEtTUEzMvKt
	aqVtF25HSvl5MxmPBvp51TmI/wubwNHpI2KaPy+ZGtHug==
X-Google-Smtp-Source: AGHT+IH3MGbhTuI1FbARZl3vLVS1C9R/JP4x30AOvtcPiId8Pg7qUuDnHa1haYpOhfTLgsrRi8Fy+Q==
X-Received: by 2002:a05:6000:1446:b0:385:ee3f:5cc6 with SMTP id ffacd0b85a97d-385fd4395c7mr1016165f8f.58.1733211359516;
        Mon, 02 Dec 2024 23:35:59 -0800 (PST)
Received: from debian ([2a00:79c0:61a:d00:767b:89df:6940:5136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8783843sm8848706f8f.4.2024.12.02.23.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:35:58 -0800 (PST)
Date: Tue, 3 Dec 2024 08:35:56 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: t.antoine@uclouvain.be
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] power: supply: add support for max77759 fuel gauge
Message-ID: <20241203073556.GA3936@debian>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
 <20241202-b4-gs101_max77759_fg-v1-1-98d2fa7bfe30@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-b4-gs101_max77759_fg-v1-1-98d2fa7bfe30@uclouvain.be>

Hi Antoine,

Am Mon, Dec 02, 2024 at 02:07:15PM +0100 schrieb Thomas Antoine via B4 Relay:
> From: Thomas Antoine <t.antoine@uclouvain.be>
> 
> The Maxim max77759 fuel gauge has the same interface as the Maxim max1720x
> except for the non-volatile memory slave address which is not available.
> No slave is available at address 0xb of the i2c bus, which is coherent
> with the following driver from google: line 5836 disables non-volatile
> memory for m5 gauge.
> 
> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
> 
> Add support for the max77759 by allowing to use the non-volatile
> memory or not based on the chip. Value for RSense comes from the following
> stock devicetree:
> 
> Link: https://android.googlesource.com/kernel/devices/google/gs101/+/33eca36d43da6c2b6a546806eb3e7411bbe6d60d/dts/gs101-raviole-battery.dtsi
> 
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
>  drivers/power/supply/max1720x_battery.c | 71 +++++++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
> index 33105419e2427bb37963bda9948b647c239f8faa..faf336938dd4306dd2ceeb0a84b90ca80ad41a9f 100644
> --- a/drivers/power/supply/max1720x_battery.c
> +++ b/drivers/power/supply/max1720x_battery.c
> @@ -13,6 +13,7 @@
>  #include <linux/nvmem-provider.h>
>  #include <linux/power_supply.h>
>  #include <linux/regmap.h>
> +#include <linux/types.h>
>  
No need to include it, it is done by <linux/i2.c> which includes
<linux/device.h> which includes <linux/types.h>
>  #include <linux/unaligned.h>
>  
> @@ -39,6 +40,7 @@
>  #define MAX172XX_DEV_NAME_TYPE_MASK	GENMASK(3, 0)
>  #define MAX172XX_DEV_NAME_TYPE_MAX17201	BIT(0)
>  #define MAX172XX_DEV_NAME_TYPE_MAX17205	(BIT(0) | BIT(2))
> +#define MAX172XX_DEV_NAME_TYPE_MAX77759	0
>  #define MAX172XX_QR_TABLE10		0x22
>  #define MAX172XX_BATT			0xDA	/* Battery voltage */
>  #define MAX172XX_ATAVCAP		0xDF
> @@ -46,6 +48,7 @@
>  static const char *const max1720x_manufacturer = "Maxim Integrated";
>  static const char *const max17201_model = "MAX17201";
>  static const char *const max17205_model = "MAX17205";
> +static const char *const max77759_model = "MAX77759";
>  
>  struct max1720x_device_info {
>  	struct regmap *regmap;
> @@ -54,6 +57,21 @@ struct max1720x_device_info {
>  	int rsense;
>  };
>  
> +struct chip_data {
> +	u16 default_nrsense; /* in regs in 10^-5 */
> +	u8 has_nvmem;
> +};
> +
> +static const struct chip_data max1720x_data  = {
> +	.default_nrsense = 1000,
> +	.has_nvmem = 1,
> +};
> +
> +static const struct chip_data max77759_data = {
> +	.default_nrsense = 500,
> +	.has_nvmem = 0,
> +};
> +
You can get rid of chip_data by reading rsense from DT and moving
has_nvmem to max1720x_device_info. By doing so you don't have to rely on
default values. Either it is specified by DT or by rsense value in
nvmem.

Best regards,
Dimitri Fedrau

