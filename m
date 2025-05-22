Return-Path: <linux-pm+bounces-27513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E80AC0C3D
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A229E6AA8
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 13:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B756F28BA90;
	Thu, 22 May 2025 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="WCkbBfOo"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB511D618A;
	Thu, 22 May 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919264; cv=pass; b=LWQ7gwubhdsu/LmmGrOok5BpCp6tS9KcIizERr08WOXpu4zR0np5AonPh08+C65v4APY4JKPzoGiNqtwPZAPh8nik45RXqyKsv+kw4bKW4w7Lna8IEV9V4TUtDIeSM0JPIrMMP6FZkh+TYn3cC6fVWpEkOD1Y7GqIvh8jR8j3tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919264; c=relaxed/simple;
	bh=jQxDuZ9R0b9bBZwRehtck9j87R5IEI5aBPwGzbcQZvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtAVMSs37y2mn5HAslEjwQab+bh+DXLB1MOuJsfoX5lryXuqbB/5IOXB3+DfDAzqfJEA4v0+mECxYoFCgzGT6LZrCCMQCuvJYKMbSsuOiEBzraueMjmA4VoXOBGBU9mrbM7J7epxxMdFJHJ6OMGbl1Tk5WJkedxbQ+HtWNwYibs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=WCkbBfOo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747919210; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ck0TM/HURCzQNfkC0FfntaPkefppCNGhvOZ5Fx6N1J+bifj1K6/xYSI2wfiPVjtH3gYpsK8rX4M6CFBgv0yEzSm608QZgl7PFzYiWYB1iIKvrdTDQRW+qCIZOZr2zu4fBq4myeGF0xsurLKJMVS7jEbr29kOl1mNIt6VXJrmOuE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747919210; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pURki4Th1hWSWrG4hgjSsahdcAd/g4lCRi+SNl0XRG8=; 
	b=PVrKy7W3wQZKNlyh0rIrgBSyCcDJ/ZQY90Q8Fcj+QxKlgtbV+C+frcXtA4JuMwm67oxi9CF2fx4mBp0dF9f/io7gGOYPCKOCSvayByvtzNA0s/JNchU4ZLJrpTcS/B7gIiBI2AdOx7xTj+FTohrPN1a7AF2LPzrPYdwQa6yboVo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747919210;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=pURki4Th1hWSWrG4hgjSsahdcAd/g4lCRi+SNl0XRG8=;
	b=WCkbBfOoxC5L2F1NcYEheBzpXz13jGbIZjmI8hcGzWiAqrNmUvA4x3T8tbOnH33k
	77sRh9ccUqDTwoB8Oz2lqlhF1Ecvzbr6Na7NKRBEUIBeYwuWDPAS/QsYHhQFz0yBAb5
	3FkQQAVAUmgIaaqrffzm72cHzHqQUyN6xUFPBLqw=
Received: by mx.zohomail.com with SMTPS id 1747919207079181.66547867456336;
	Thu, 22 May 2025 06:06:47 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id A5D9E1807A4; Thu, 22 May 2025 15:06:42 +0200 (CEST)
Date: Thu, 22 May 2025 15:06:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 07/10] power: reset: macsmc-reboot: Add driver for
 rebooting via Apple SMC
Message-ID: <gk656zq44i6ls6bbcb6qpd42typzkw3hqbft6b6rvfaw5aocsd@2fsiokbcnbtf>
References: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
 <20250515-smc-6-15-v6-7-c47b1ef4b0ae@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c4k7uzu7ifiuep5j"
Content-Disposition: inline
In-Reply-To: <20250515-smc-6-15-v6-7-c47b1ef4b0ae@svenpeter.dev>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/245.114.34
X-ZohoMailClient: External


--c4k7uzu7ifiuep5j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 07/10] power: reset: macsmc-reboot: Add driver for
 rebooting via Apple SMC
MIME-Version: 1.0

Hi,

On Thu, May 15, 2025 at 06:21:19AM +0000, Sven Peter via B4 Relay wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> This driver implements the reboot/shutdown support exposed by the SMC
> on Apple Silicon machines, such as Apple M1 Macs.
>=20
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/power/reset/Kconfig         |   9 ++
>  drivers/power/reset/Makefile        |   1 +
>  drivers/power/reset/macsmc-reboot.c | 294 ++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 305 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa3a5f9ee40446bcc725c9eac2a36651e6bc7553..84f7a730eb2260b7c1e0487d1=
8c8eb3de82f5206 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2303,6 +2303,7 @@ F:	drivers/mfd/macsmc.c
>  F:	drivers/nvme/host/apple.c
>  F:	drivers/nvmem/apple-efuses.c
>  F:	drivers/pinctrl/pinctrl-apple-gpio.c
> +F:	drivers/power/reset/macsmc-reboot.c
>  F:	drivers/pwm/pwm-apple.c
>  F:	drivers/soc/apple/*
>  F:	drivers/spi/spi-apple.c
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 60bf0ca64cf395cd18238fc626611c74d29844ee..82b9391307cf1a7bedafaa9e0=
b8e9501e64449aa 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -128,6 +128,15 @@ config POWER_RESET_LINKSTATION
> =20
>  	  Say Y here if you have a Buffalo LinkStation LS421D/E.
> =20
> +config POWER_RESET_MACSMC
> +	tristate "Apple SMC reset/power-off driver"
> +	depends on MFD_MACSMC
> +	help
> +	  This driver supports reset and power-off on Apple Mac machines
> +	  that implement this functionality via the SMC.
> +
> +	  Say Y here if you have an Apple Silicon Mac.
> +
>  config POWER_RESET_MSM
>  	bool "Qualcomm MSM power-off driver"
>  	depends on ARCH_QCOM
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 10782d32e1da39f4b8b4566e8a885f2e13f65130..887dd9e49b7293b69b9429ddc=
0c1571194a153cf 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_LINKSTATION) +=3D linkstation-poweroff.o
> +obj-$(CONFIG_POWER_RESET_MACSMC) +=3D macsmc-reboot.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
> diff --git a/drivers/power/reset/macsmc-reboot.c b/drivers/power/reset/ma=
csmc-reboot.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..5cfbf56282452bab8d06ed7e9=
7e9d2405d7b30c0
> --- /dev/null
> +++ b/drivers/power/reset/macsmc-reboot.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple SMC Reboot/Poweroff Handler
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/macsmc.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/slab.h>
> +
> +struct macsmc_reboot_nvmem {
> +	struct nvmem_cell *shutdown_flag;
> +	struct nvmem_cell *boot_stage;
> +	struct nvmem_cell *boot_error_count;
> +	struct nvmem_cell *panic_count;
> +};
> +
> +static const char * const nvmem_names[] =3D {
> +	"shutdown_flag",
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
> +	void *bfr;
> +	u8 val;
> +
> +	bfr =3D nvmem_cell_read(cell, &len);
> +	if (IS_ERR(bfr))
> +		return PTR_ERR(bfr);
> +
> +	if (len < 1) {
> +		kfree(bfr);
> +		return -EINVAL;
> +	}
> +
> +	val =3D *(u8 *)bfr;
> +	kfree(bfr);
> +	return val;
> +}
> +
> +static int nvmem_cell_set_u8(struct nvmem_cell *cell, u8 val)
> +{
> +	return nvmem_cell_write(cell, &val, sizeof(val));
> +}
> +
> +/*
> + * SMC 'MBSE' key actions:
> + *
> + * 'offw' - shutdown warning
> + * 'slpw' - sleep warning
> + * 'rest' - restart warning
> + * 'off1' - shutdown (needs PMU bit set to stay on)
> + * 'susp' - suspend
> + * 'phra' - restart ("PE Halt Restart Action"?)
> + * 'panb' - panic beginning
> + * 'pane' - panic end
> + */
> +
> +static int macsmc_prepare_atomic(struct sys_off_data *data)
> +{
> +	struct macsmc_reboot *reboot =3D data->cb_data;
> +
> +	dev_info(reboot->dev, "Preparing SMC for atomic mode\n");
> +
> +	apple_smc_enter_atomic(reboot->smc);
> +	return NOTIFY_OK;
> +}
> +
> +static int macsmc_power_off(struct sys_off_data *data)
> +{
> +	struct macsmc_reboot *reboot =3D data->cb_data;
> +
> +	dev_info(reboot->dev, "Issuing power off (off1)\n");
> +
> +	if (apple_smc_write_u32_atomic(reboot->smc, SMC_KEY(MBSE), SMC_KEY(off1=
)) < 0) {
> +		dev_err(reboot->dev, "Failed to issue MBSE =3D off1 (power_off)\n");
> +	} else {
> +		mdelay(100);
> +		WARN_ONCE(1, "Unable to power off system\n");
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int macsmc_restart(struct sys_off_data *data)
> +{
> +	struct macsmc_reboot *reboot =3D data->cb_data;
> +
> +	dev_info(reboot->dev, "Issuing restart (phra)\n");
> +
> +	if (apple_smc_write_u32_atomic(reboot->smc, SMC_KEY(MBSE), SMC_KEY(phra=
)) < 0) {
> +		dev_err(reboot->dev, "Failed to issue MBSE =3D phra (restart)\n");
> +	} else {
> +		mdelay(100);
> +		WARN_ONCE(1, "Unable to restart system\n");
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int macsmc_reboot_notify(struct notifier_block *this, unsigned lo=
ng action, void *data)
> +{
> +	struct macsmc_reboot *reboot =3D container_of(this, struct macsmc_reboo=
t, reboot_notify);
> +	u8 shutdown_flag;
> +	u32 val;
> +
> +	switch (action) {
> +	case SYS_RESTART:
> +		val =3D SMC_KEY(rest);
> +		shutdown_flag =3D 0;
> +		break;
> +	case SYS_POWER_OFF:
> +		val =3D SMC_KEY(offw);
> +		shutdown_flag =3D 1;
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	dev_info(reboot->dev, "Preparing for reboot (%p4ch)\n", &val);
> +
> +	/* On the Mac Mini, this will turn off the LED for power off */
> +	if (apple_smc_write_u32(reboot->smc, SMC_KEY(MBSE), val) < 0)
> +		dev_err(reboot->dev, "Failed to issue MBSE =3D %p4ch (reboot_prepare)\=
n", &val);
> +
> +	/* Set the boot_stage to 0, which means we're doing a clean shutdown/re=
boot. */
> +	if (reboot->nvm.boot_stage &&
> +	    nvmem_cell_set_u8(reboot->nvm.boot_stage, BOOT_STAGE_SHUTDOWN) < 0)
> +		dev_err(reboot->dev, "Failed to write boot_stage\n");
> +
> +	/*
> +	 * Set the PMU flag to actually reboot into the off state.
> +	 * Without this, the device will just reboot. We make it optional in ca=
se it is no longer
> +	 * necessary on newer hardware.
> +	 */
> +	if (reboot->nvm.shutdown_flag &&
> +	    nvmem_cell_set_u8(reboot->nvm.shutdown_flag, shutdown_flag) < 0)
> +		dev_err(reboot->dev, "Failed to write shutdown_flag\n");
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void macsmc_power_init_error_counts(struct macsmc_reboot *reboot)
> +{
> +	int boot_error_count, panic_count;
> +
> +	if (!reboot->nvm.boot_error_count || !reboot->nvm.panic_count)
> +		return;
> +
> +	boot_error_count =3D nvmem_cell_get_u8(reboot->nvm.boot_error_count);
> +	if (boot_error_count < 0) {
> +		dev_err(reboot->dev, "Failed to read boot_error_count (%d)\n", boot_er=
ror_count);
> +		return;
> +	}
> +
> +	panic_count =3D nvmem_cell_get_u8(reboot->nvm.panic_count);
> +	if (panic_count < 0) {
> +		dev_err(reboot->dev, "Failed to read panic_count (%d)\n", panic_count);
> +		return;
> +	}
> +
> +	if (!boot_error_count && !panic_count)
> +		return;
> +
> +	dev_warn(reboot->dev, "PMU logged %d boot error(s) and %d panic(s)\n",
> +		 boot_error_count, panic_count);
> +
> +	if (nvmem_cell_set_u8(reboot->nvm.panic_count, 0) < 0)
> +		dev_err(reboot->dev, "Failed to reset panic_count\n");
> +	if (nvmem_cell_set_u8(reboot->nvm.boot_error_count, 0) < 0)
> +		dev_err(reboot->dev, "Failed to reset boot_error_count\n");
> +}
> +
> +static int macsmc_reboot_probe(struct platform_device *pdev)
> +{
> +	struct apple_smc *smc =3D dev_get_drvdata(pdev->dev.parent);
> +	struct macsmc_reboot *reboot;
> +	int ret, i;
> +
> +	/* Ignore devices without this functionality */
> +	if (!apple_smc_key_exists(smc, SMC_KEY(MBSE)))
> +		return -ENODEV;

Is that a leftover? I would expect that you do not have the
'apple,smc-reboot' sub-device described in DT for such a case.

Otherwise

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> +
> +	reboot =3D devm_kzalloc(&pdev->dev, sizeof(*reboot), GFP_KERNEL);
> +	if (!reboot)
> +		return -ENOMEM;
> +
> +	reboot->dev =3D &pdev->dev;
> +	reboot->smc =3D smc;
> +
> +	platform_set_drvdata(pdev, reboot);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(nvmem_names); i++) {
> +		struct nvmem_cell *cell;
> +
> +		cell =3D devm_nvmem_cell_get(&pdev->dev,
> +					   nvmem_names[i]);
> +		if (IS_ERR(cell)) {
> +			if (PTR_ERR(cell) =3D=3D -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			dev_warn(&pdev->dev, "Missing NVMEM cell %s (%ld)\n",
> +				 nvmem_names[i], PTR_ERR(cell));
> +			/* Non fatal, we'll deal with it */
> +			cell =3D NULL;
> +		}
> +		reboot->nvm_cells[i] =3D cell;
> +	}
> +
> +	/* Set the boot_stage to indicate we're running the OS kernel */
> +	if (reboot->nvm.boot_stage &&
> +	    nvmem_cell_set_u8(reboot->nvm.boot_stage, BOOT_STAGE_KERNEL_STARTED=
) < 0)
> +		dev_err(reboot->dev, "Failed to write boot_stage\n");
> +
> +	/* Display and clear the error counts */
> +	macsmc_power_init_error_counts(reboot);
> +
> +	reboot->reboot_notify.notifier_call =3D macsmc_reboot_notify;
> +
> +	ret =3D devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OF=
F_PREPARE,
> +					    SYS_OFF_PRIO_HIGH, macsmc_prepare_atomic, reboot);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to register power-off prepare handler\n");
> +	ret =3D devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OF=
F, SYS_OFF_PRIO_HIGH,
> +					    macsmc_power_off, reboot);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to register power-off handler\n");
> +
> +	ret =3D devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART_=
PREPARE,
> +					    SYS_OFF_PRIO_HIGH, macsmc_prepare_atomic, reboot);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to register restart prepare handler\n");
> +	ret =3D devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,=
 SYS_OFF_PRIO_HIGH,
> +					    macsmc_restart, reboot);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to register restart hand=
ler\n");
> +
> +	ret =3D devm_register_reboot_notifier(&pdev->dev, &reboot->reboot_notif=
y);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to register reboot notif=
ier\n");
> +
> +	dev_info(&pdev->dev, "Handling reboot and poweroff requests via SMC\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id macsmc_reboot_of_table[] =3D {
> +	{ .compatible =3D "apple,smc-reboot", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, macsmc_reboot_of_table);
> +
> +static struct platform_driver macsmc_reboot_driver =3D {
> +	.driver =3D {
> +		.name =3D "macsmc-reboot",
> +		.of_match_table =3D macsmc_reboot_of_table,
> +	},
> +	.probe =3D macsmc_reboot_probe,
> +};
> +module_platform_driver(macsmc_reboot_driver);
> +
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_DESCRIPTION("Apple SMC reboot/poweroff driver");
> +MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
>=20
> --=20
> 2.34.1
>=20
>=20

--c4k7uzu7ifiuep5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgvIVsACgkQ2O7X88g7
+ppuTQ//Q0fURHIz1nalMSnA+ta9JGOTUXBHAiWH9IBycwPQwsxRwA0uupTshWxe
bGvYu6eRxQ1flcPmhAAKvT1wkzPjoBh31qhAPLHp9yVkpqTH61JY5r1Vhei6rJn/
0D4NVTvoofdLVgKh8Nbxt4rjU0JcF/j068HBu+MFwjBgSyGumOFp2IwvJu+pvI2F
ngVQaKtZpwEovGxMC9T9MRS4D1SS2nK6HA8bZr6kuboTOlsh/0rc86suO7hjUs3X
c3RcUV7kYhii4FKkfCkHRUJC0+AHc+89X/X2TwgyVzQtSqQZedS0uQ+S7Okghlzu
zp6S5Pw7FENx7VQkRrlWSkJGB3IA6LtEozvgBQGhU6xsh94sjQD73HeNBy2F0mZs
YnbZPp8HEz/b3/s3Dx4SrQD2FuCjuPAV9CMPGIWnM3bPfecpeEe4oEHv8AfndXMp
B8ZiErNEAcsR0nErbxPk6rGNYsnMg1rsaRCIRcJdM/u19mdQ1dQxZHMwfpVtXLAK
fEJxPYwAol5m70pLffBViSweneZaquZAk4ijZTUqraQOVfSrN1fSqXIILYQtv7eg
FJaR6l3xuFvxiu1JQPHuy53y2kqK7CiMVEQT+PBDwytB534Jfk/hKGeEf4ULOB2O
a7dPj+q71C0QO519GW4XN10DqmhkZrTLtqQKdMaeqtnMkPPlJTA=
=bmnZ
-----END PGP SIGNATURE-----

--c4k7uzu7ifiuep5j--

