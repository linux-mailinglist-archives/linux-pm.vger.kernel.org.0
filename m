Return-Path: <linux-pm+bounces-27005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367B4AB279A
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 12:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E0E176050
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705D1BD517;
	Sun, 11 May 2025 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WF48+tIE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94524D8D1;
	Sun, 11 May 2025 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746958054; cv=none; b=AJz+MZYT9jJSKbFNhaKE/6gG0AR73ToEKF81GhfdsIp/4HZ6/Xz9mK/oeruEYPADQ3gvdxLfXbeV8q1neZDiNaPdLIEQ5PU9+ssHoe8qT5j8VMgCeoX1napEdUHZpWqZog5M9mCBExgV2EFAMRcr/mdcxxee3Auo8FQTC5K8cUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746958054; c=relaxed/simple;
	bh=V1jNPYr/TZyRJN0kAHvxyfDu0yvFkpnF9UQE83zxJkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tixUkP0LKpYgfFtDJHs9bBLb53AJt//VL1r00oIUV4d0FoFqGBjWbFdXMMiZkAwvULxahPoY3SyDb2fl3bk141U6oo/b5AmYl5yjYLL1n3paHXJrtSomnTE5DgE1SgYgsQudDNULbxQExgVhbXShTJIlqEJYqDpv+u7QCyWjiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WF48+tIE; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746958049; x=1747562849; i=wahrenst@gmx.net;
	bh=CN0O5V+IZ0q5N1/S2ZaMh6s5R0LVHxEQYL797WECSaA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WF48+tIE5DgO07f0Pf3a2wrnwmRkzKaMUwdUN2XUFFfMMQNQojCgdhtweo+6r49N
	 QDQ2OpuJ2NUZZkcmejqZoRiYOazrG/33dpF1Ube7m7yP+CqEHH9vn2spOdyRheW3e
	 8zHqcwErqUvsXoHwwsg3Wh5F39/le9ob/XzdieeEpA8mgd5qcWuBDL2iMpjx4TNwj
	 yTm/vo4pLj86FB1E67wqJIbewr/D1rM8hItw2BrcNXuo2VnIypjT66GM6K3eB8wFK
	 GnQwDRrWOBunzLMewcwvzq1Vy+XXtD1LIBpeRbh7y49fvmKgIMIaM9AY51NTk0/cn
	 FDbdxiiFaSmNy7H7aA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([91.41.216.208]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MplXz-1umWKa1gPF-00o6TN; Sun, 11
 May 2025 12:07:29 +0200
Message-ID: <678528db-67bc-4bb7-a866-7b8aeb4f4510@gmx.net>
Date: Sun, 11 May 2025 12:07:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] power: reset: macsmc-reboot: Add driver for
 rebooting via Apple SMC
To: sven@svenpeter.dev, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
 <20250511-smc-6-15-v5-7-f5980bdb18bd@svenpeter.dev>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250511-smc-6-15-v5-7-f5980bdb18bd@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z8FPqSBn0iAN+Jp67wKOEpFqtfhamLrhOFm81Yp8T3if6bMooSD
 DZ5TtUwyguT5Eu1lxG/b+xzBZYSQPJhEdqZA3DdQKgzS+xOcY/2aPl3BVkiNqOjWUvGvPTr
 GJI1YIyUr6PXi6Bavv+oh+f1SGQa4bU8rzDHL5BH2O2bw3n/BCGBbaqUKjnWEucPhsVxRI1
 WjDuFZ7u5fgnm1aVwNAkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eUVeXrlNwho=;qLOTI09OeU4/WUdYhgQd5zVTy3u
 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

Hi Sven,

Am 11.05.25 um 10:18 schrieb Sven Peter via B4 Relay:
> From: Hector Martin <marcan@marcan.st>
>
> This driver implements the reboot/shutdown support exposed by the SMC
> on Apple Silicon machines, such as Apple M1 Macs.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>   MAINTAINERS                         |   1 +
>   drivers/power/reset/Kconfig         |  11 ++
>   drivers/power/reset/Makefile        |   1 +
>   drivers/power/reset/macsmc-reboot.c | 363 ++++++++++++++++++++++++++++=
++++++++
>   4 files changed, 376 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa3a5f9ee40446bcc725c9eac2a36651e6bc7553..84f7a730eb2260b7c1e0487d=
18c8eb3de82f5206 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2303,6 +2303,7 @@ F:	drivers/mfd/macsmc.c
>   F:	drivers/nvme/host/apple.c
>   F:	drivers/nvmem/apple-efuses.c
>   F:	drivers/pinctrl/pinctrl-apple-gpio.c
> +F:	drivers/power/reset/macsmc-reboot.c
>   F:	drivers/pwm/pwm-apple.c
>   F:	drivers/soc/apple/*
>   F:	drivers/spi/spi-apple.c
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 60bf0ca64cf395cd18238fc626611c74d29844ee..6e8dfff64fdc001d09b6c006=
30cd8b7e2fafdd8e 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -128,6 +128,17 @@ config POWER_RESET_LINKSTATION
>  =20
>   	  Say Y here if you have a Buffalo LinkStation LS421D/E.
>  =20
> +config POWER_RESET_MACSMC
> +	tristate "Apple SMC reset/power-off driver"
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	depends on MFD_MACSMC
> +	depends on OF
> +	help
> +	  This driver supports reset and power-off on Apple Mac machines
> +	  that implement this functionality via the SMC.
> +
> +	  Say Y here if you have an Apple Silicon Mac.
> +
>   config POWER_RESET_MSM
>   	bool "Qualcomm MSM power-off driver"
>   	depends on ARCH_QCOM
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 10782d32e1da39f4b8b4566e8a885f2e13f65130..887dd9e49b7293b69b9429dd=
c0c1571194a153cf 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>   obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
>   obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>   obj-$(CONFIG_POWER_RESET_LINKSTATION) +=3D linkstation-poweroff.o
> +obj-$(CONFIG_POWER_RESET_MACSMC) +=3D macsmc-reboot.o
>   obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
>   obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
>   obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
> diff --git a/drivers/power/reset/macsmc-reboot.c b/drivers/power/reset/m=
acsmc-reboot.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d82339e427886667be4ad2de=
0d1d5c04d2383059
> --- /dev/null
> +++ b/drivers/power/reset/macsmc-reboot.c
> @@ -0,0 +1,363 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple SMC Reboot/Poweroff Handler
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/macsmc.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/slab.h>
> +
> +struct macsmc_reboot_nvmem {
> +	struct nvmem_cell *shutdown_flag;
> +	struct nvmem_cell *pm_setting;
> +	struct nvmem_cell *boot_stage;
> +	struct nvmem_cell *boot_error_count;
> +	struct nvmem_cell *panic_count;
> +};
> +
> +static const char * const nvmem_names[] =3D {
> +	"shutdown_flag",
> +	"pm_setting",
> +	"boot_stage",
> +	"boot_error_count",
> +	"panic_count",
> +};
> +
> +enum boot_stage {
> +	BOOT_STAGE_SHUTDOWN		=3D 0x00, /* Clean shutdown */
> +	BOOT_STAGE_IBOOT_DONE		=3D 0x2f, /* Last stage of bootloader */
> +	BOOT_STAGE_KERNEL_STARTED	=3D 0x30, /* Normal OS booting */
> +};
> +
> +enum pm_setting {
> +	PM_SETTING_AC_POWER_RESTORE	=3D 0x02,
> +	PM_SETTING_AC_POWER_OFF		=3D 0x03,
> +};
> +
> +static const char * const ac_power_modes[] =3D { "off", "restore" };
> +
> +static int ac_power_mode_map[] =3D {
> +	PM_SETTING_AC_POWER_OFF,
> +	PM_SETTING_AC_POWER_RESTORE,
> +};
> +
> +struct macsmc_reboot {
> +	struct device *dev;
> +	struct apple_smc *smc;
> +	struct notifier_block reboot_notify;
> +
> +	union {
> +		struct macsmc_reboot_nvmem nvm;
> +		struct nvmem_cell *nvm_cells[ARRAY_SIZE(nvmem_names)];
> +	};
> +};
> +
> +/* Helpers to read/write a u8 given a struct nvmem_cell */
> +static int nvmem_cell_get_u8(struct nvmem_cell *cell)
> +{
> +	size_t len;
> +	u8 val;
> +	void *ret =3D nvmem_cell_read(cell, &len);
in case this series needs a respin, please rename the pointer (e.g.=20
buf). This is very unusual, because ret is usually of type int.

Regards

