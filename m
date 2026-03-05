Return-Path: <linux-pm+bounces-43668-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFiKGXhVqWng5gAAu9opvQ
	(envelope-from <linux-pm+bounces-43668-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:05:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 473ED20F564
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5A6C3072C1C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9F3803F4;
	Thu,  5 Mar 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc38H1iA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388037CD43
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704949; cv=none; b=F3cUh4YxVfsNLXOuX3R4POlOc5IGvsZydNynL7jnQFEm4LaZNFOVSuwAC5yIwvhgq57xjffiIz7WmEvHByvWENt0NUWxoB4LXkc4VZkYUvsvRv4DkV4AhxYCZd0mlFhQKjX5d1uWsA0FUuOm1iQVrLE/e4LUm2iiCWixT6ypet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704949; c=relaxed/simple;
	bh=qancUPGQlWGf8hQxZmA2OZYFGJe2twK4fVy4hczDVK8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Adz+iycrsXW4lHoIQzeVpElVX+z2A+xTbdckVUjNwSLuOt107RX5Om5SCWslmBQcP++xYsxiI7whyK3cfLoZiK1ETU76J/9piYtxHri1GzY69WwEEJuMwf6pdyvb5wIZEfyIS4TH8XpXKbLuE/Lz5tPjVc4iT7XA1Rkb2YzAVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc38H1iA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909EBC19425
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 10:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772704949;
	bh=qancUPGQlWGf8hQxZmA2OZYFGJe2twK4fVy4hczDVK8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Kc38H1iAv9fLqRNrQYjFQV/jfuvCSyDroN7z6gupuUQ2S33kswfJalFOuU/xd3vZN
	 uiRd1zMshnhrfwemnIHd8aW8Y3c2miVrw6/MYstXe/f6Z7jN7ttOK589C9RhQjRG2u
	 X5sZFUcrkutBve7vN5bXPCaTl6W8kU9Se+AW5CrQB599KuLDMMXuyvMgD2q30iXbNc
	 +OjCKpcCWhNzARCiCwIQuk6H8V1HIeTNyH82u6uT1rvoUMj/QqcLlLhRSrx73bFsL6
	 YDKFSFVd4TGkglXomapJE+IcAz4luQ3qAPuBwJig1EIpIPGU6Ph0KDAz51iyGqocRO
	 mtU176lxxg7UQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a13323ba85so624421e87.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 02:02:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVk3zqKwkXh06piJ1wg5cBnBE6oN8Foy1IAjEV9Vf0khOuD24a0uApNgsyq1wNvPrGOMlBXjE1W+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjx47hahawcv45aEgL77nvjr1NgR3rdKRAN+iFc1uOdiBPfSWy
	0ck1/3lxNWXfTm4UznlsQEdnrsq0yKKzoEKEBUresKsHX1suAePdxdTA6BnLKZb3hcT8hjdlIpz
	iX8KlEGjYLxZwxTWJC8bcEkH+T+UNhz2v+ZvpxKM4Vw==
X-Received: by 2002:a05:6512:24c4:20b0:5a1:2f0d:f31b with SMTP id
 2adb3069b0e04-5a12f0df52cmr468009e87.21.1772704946649; Thu, 05 Mar 2026
 02:02:26 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 02:02:25 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 02:02:24 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260304-arm-psci-system_reset2-vendor-reboots-v20-6-cf7d346b8372@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
 <20260304-arm-psci-system_reset2-vendor-reboots-v20-6-cf7d346b8372@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 02:02:24 -0800
X-Gmail-Original-Message-ID: <CAMRc=MewwLTsaHCOR2iVYZRM6kWptQfZuTe=2i_pfpTwjFKEpQ@mail.gmail.com>
X-Gm-Features: AaiRm50EHWCJJDWv4SLBavCKeEqVwYW6a5qLRhI6LypsfduB5BiXJsaabZSs-7g
Message-ID: <CAMRc=MewwLTsaHCOR2iVYZRM6kWptQfZuTe=2i_pfpTwjFKEpQ@mail.gmail.com>
Subject: Re: [PATCH v20 06/10] power: reset: Add psci-reboot-mode driver
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, John Stultz <john.stultz@linaro.org>, 
	Moritz Fischer <moritz.fischer@ettus.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 473ED20F564
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43668-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,oss.qualcomm.com,linaro.org,vger.kernel.org,lists.infradead.org,arndb.de,arm.com,rock-chips.com,gmail.com,ettus.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 19:03:06 +0100, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> PSCI supports different types of resets like COLD reset, ARCH WARM
> reset, vendor-specific resets. Currently there is no common driver that
> handles all supported psci resets at one place. Additionally, there is
> no common mechanism to issue the supported psci resets from userspace.
>
> Add a PSCI reboot mode driver and define two types of PSCI resets in the
> driver as reboot-modes: predefined resets controlled by Linux
> reboot_mode and customizable resets defined by SoC vendors in their
> device tree under the psci:reboot-mode node.
>
> Register the driver with the reboot-mode framework to interface these
> resets to userspace. When userspace initiates a supported command, pass
> the reset arguments to the PSCI driver to enable command-based reset.
>
> This change allows userspace to issue supported PSCI reset commands
> using the standard reboot system calls while enabling SoC vendors to
> define their specific resets for PSCI.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/Kconfig            |  10 +++
>  drivers/power/reset/Makefile           |   1 +
>  drivers/power/reset/psci-reboot-mode.c | 119 +++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index f6c1bcbb57deff3568d6b1b326454add3b3bbf06..529d6c7d3555601f7b7e6199acd29838030fcef2 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -348,6 +348,16 @@ config NVMEM_REBOOT_MODE
>  	  then the bootloader can read it and take different
>  	  action according to the mode.
>
> +config PSCI_REBOOT_MODE
> +	bool "PSCI reboot mode driver"
> +	depends on OF && ARM_PSCI_FW
> +	select REBOOT_MODE
> +	help
> +	  Say y here will enable PSCI reboot mode driver. This gets
> +          the PSCI reboot mode arguments and passes them to psci
> +	  driver. psci driver uses these arguments for issuing
> +	  device reset into different boot states.
> +
>  config POWER_MLXBF
>  	tristate "Mellanox BlueField power handling driver"
>  	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 0e4ae6f6b5c55729cf60846d47e6fe0fec24f3cc..49774b42cdf61fd57a5b70f286c65c9d66bbc0cb 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -40,4 +40,5 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
> +obj-$(CONFIG_PSCI_REBOOT_MODE) += psci-reboot-mode.o
>  obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
> diff --git a/drivers/power/reset/psci-reboot-mode.c b/drivers/power/reset/psci-reboot-mode.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..86bef195228b0924704c2936b99f6801c14ff1b1
> --- /dev/null
> +++ b/drivers/power/reset/psci-reboot-mode.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/device/faux.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/psci.h>
> +#include <linux/reboot.h>
> +#include <linux/reboot-mode.h>
> +#include <linux/types.h>
> +
> +/*
> + * Predefined reboot-modes are defined as per the values
> + * of enum reboot_mode defined in the kernel: reboot.c.
> + */
> +static struct mode_info psci_resets[] = {
> +	{ .mode = "warm", .magic = REBOOT_WARM},
> +	{ .mode = "soft", .magic = REBOOT_SOFT},
> +	{ .mode = "cold", .magic = REBOOT_COLD},
> +};
> +
> +static void psci_reboot_mode_set_predefined_modes(struct reboot_mode_driver *reboot)
> +{
> +	INIT_LIST_HEAD(&reboot->predefined_modes);
> +	for (u32 i = 0; i < ARRAY_SIZE(psci_resets); i++) {
> +		/* Prepare the magic with arg1 as 0 and arg2 as per pre-defined mode */
> +		psci_resets[i].magic = REBOOT_MODE_MAGIC(0, psci_resets[i].magic);
> +		INIT_LIST_HEAD(&psci_resets[i].list);
> +		list_add_tail(&psci_resets[i].list, &reboot->predefined_modes);
> +	}
> +}
> +
> +/*
> + * arg1 is reset_type(Low 32 bit of magic).
> + * arg2 is cookie(High 32 bit of magic).
> + * If reset_type is 0, cookie will be used to decide the reset command.
> + */
> +static int psci_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
> +{
> +	u32 reset_type = REBOOT_MODE_ARG1(magic);
> +	u32 cookie = REBOOT_MODE_ARG2(magic);
> +
> +	if (reset_type == 0) {
> +		if (cookie == REBOOT_WARM || cookie == REBOOT_SOFT)
> +			psci_set_reset_cmd(true, 0, 0);
> +		else
> +			psci_set_reset_cmd(false, 0, 0);
> +	} else {
> +		psci_set_reset_cmd(true, reset_type, cookie);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int psci_reboot_mode_register_device(struct faux_device *fdev)
> +{
> +	struct reboot_mode_driver *reboot;
> +	int ret;
> +
> +	reboot = devm_kzalloc(&fdev->dev, sizeof(*reboot), GFP_KERNEL);

Have you verified that the faux device is actually getting bound? This is not
probe(), you don't supply any faux operations when calling faux_device_create().

You should pass the address of this function in faux_device_ops instead of
calling it directly.

Bartosz

> +	if (!reboot)
> +		return -ENOMEM;
> +
> +	psci_reboot_mode_set_predefined_modes(reboot);
> +	reboot->write = psci_reboot_mode_write;
> +	reboot->dev = &fdev->dev;
> +
> +	ret = devm_reboot_mode_register(&fdev->dev, reboot);
> +	if (ret) {
> +		dev_err_probe(&fdev->dev, ret, "devm_reboot_mode_register failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init psci_reboot_mode_init(void)
> +{
> +	struct device_node *psci_np;
> +	struct faux_device *fdev;
> +	struct device_node *np;
> +	int ret;
> +
> +	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
> +	if (!psci_np)
> +		return -ENODEV;
> +	/*
> +	 * Look for reboot-mode in the psci node. Even if the reboot-mode
> +	 * node is not defined in psci, continue to register with the
> +	 * reboot-mode driver and let the dev.ofnode be set as NULL.
> +	 */
> +	np = of_find_node_by_name(psci_np, "reboot-mode");
> +
> +	fdev = faux_device_create("psci-reboot-mode", NULL, NULL);
> +	if (!fdev) {
> +		ret = -ENODEV;
> +		goto error;
> +	}
> +
> +	device_set_node(&fdev->dev, of_fwnode_handle(np));
> +	ret = psci_reboot_mode_register_device(fdev);
> +	if (ret)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	of_node_put(np);
> +	if (fdev) {
> +		device_set_node(&fdev->dev, NULL);
> +		faux_device_destroy(fdev);
> +	}
> +
> +	return ret;
> +}
> +device_initcall(psci_reboot_mode_init);
>
> --
> 2.34.1
>
>

