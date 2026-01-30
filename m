Return-Path: <linux-pm+bounces-41803-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA2rINEofWk0QgIAu9opvQ
	(envelope-from <linux-pm+bounces-41803-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:55:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3824BEE94
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF5AA300A510
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 21:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF62C3469F1;
	Fri, 30 Jan 2026 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="V54xX0yT"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-g122.zoho.com (sender4-pp-g122.zoho.com [136.143.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B51274FEB;
	Fri, 30 Jan 2026 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810126; cv=pass; b=sNRgDbjINlpeySfZBGEj+zYhWQEv2IJVv0z60yjWtWoUunJJ8fqo4v9xT+zq8UyO6BMOOxf1s2LRiIVpajca6xk/kx9ijHJt4Qd1U8xezPKybujm0irjjMsQn/+eA0YvZLY0ZcuWgV2UoHIHpo+2OTp6uhzogtMKfg54G2Ich5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810126; c=relaxed/simple;
	bh=f/ioZsDfsMv6gqZoKdcHXoE+WgqS/5R1QqEDb8CN4Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKUz57svprUB7ADExgUYsSpv+Nf1PjnbaoA42IyTyXIEfHOvTB51sa0oYTeTCWAtV44WoM/Ci3a/OVNIGYb32jbEchaTmFOuN5/3DB5R92IyLnBZ6g6ecS3g9FpWsrrV1rOnaaHtHqhsJeYCk8nJylEuj66I20rN2bFsKgp1ohI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=V54xX0yT; arc=pass smtp.client-ip=136.143.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1769810110; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m3/AihjscZDWWtbWW2DQr47E1F29oZx1IJHlx+z2pNZ7VaKHRPxLzYLbbVQeMPTr0dy1GbnOZzx1vCjbPd+MZobQgriZOuW0LhkuZHuSJwWuc4ix7IJNpZjNB9eskla/PV6+fIzSqcvXInaqpSFEDq4NmW+Ww1IkmKKREf+fsMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769810110; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aPD4oMdEco4XFgVOznBWvTfVRBU8KX3sxYf1g6Ve5yM=; 
	b=Wp5FAdjWvv7e9vu/c6rRO78b/+yq61ceK2Yu7O9tJyy9ee6uJfh/rWajzeWRTplxfdhKDqZ7HgVUd3hd+4EswttnvBG29ZOiZ4kJ5RAINSVQkTW+monq31ZYzpsZS1YiCKZhv1MG7aI1UYHFjyBFMXp/YNy/EeQYDSEtQaqqLL0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769810110;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=aPD4oMdEco4XFgVOznBWvTfVRBU8KX3sxYf1g6Ve5yM=;
	b=V54xX0yTlnvgCp7+42aAeArmv9qA55zo5ouvHpKTAhvVxJQAlb6USC60f5JGfFEO
	kgTdeXWv988uvmcusal6gbcBbI6wSOdVy+B4kL2hXY8sChJnwgIC8egB1KMf3XITMki
	+nnFb9hgddPLjDS3RqSlqLFnbUhMHSWHIOHlcXfw=
Received: by mx.zohomail.com with SMTPS id 1769810107734190.12515268098207;
	Fri, 30 Jan 2026 13:55:07 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id BE68B18050E; Fri, 30 Jan 2026 22:55:00 +0100 (CET)
Date: Fri, 30 Jan 2026 22:55:00 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: geert@linux-m68k.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] power: reset: Add QEMU virt-ctrl driver
Message-ID: <aX0nCEOFCGhSTV1q@venus>
References: <20260112182258.1851769-1-visitorckw@gmail.com>
 <20260112182258.1851769-2-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dxdfocqzfegfbwga"
Content-Disposition: inline
In-Reply-To: <20260112182258.1851769-2-visitorckw@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/269.789.21
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-m68k.org,ccns.ncku.edu.tw,gmail.com,vger.kernel.org,lists.linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-41803-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3824BEE94
X-Rspamd-Action: no action


--dxdfocqzfegfbwga
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] power: reset: Add QEMU virt-ctrl driver
MIME-Version: 1.0

Hi,

On Mon, Jan 12, 2026 at 06:22:56PM +0000, Kuan-Wei Chiu wrote:
> Add a new driver for the 'virt-ctrl' device found on QEMU virt machines
> (e.g. m68k). This device provides a simple interface for system reset
> and power off [1].
>=20
> This driver registers a restart handler for system reboot and sets the
> global pm_power_off callback for system shutdown. It is designed to be
> generic and can be reused by other architectures utilizing this QEMU
> device.
>=20
> Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ct=
rl.c [1]
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  MAINTAINERS                          |  6 ++
>  drivers/power/reset/Kconfig          | 10 +++
>  drivers/power/reset/Makefile         |  1 +
>  drivers/power/reset/qemu-virt-ctrl.c | 98 ++++++++++++++++++++++++++++
>  4 files changed, 115 insertions(+)
>  create mode 100644 drivers/power/reset/qemu-virt-ctrl.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d044a58cbfe..2586e4162304 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21179,6 +21179,12 @@ S:	Maintained
>  F:	drivers/firmware/qemu_fw_cfg.c
>  F:	include/uapi/linux/qemu_fw_cfg.h
> =20
> +QEMU VIRT MACHINE SYSTEM CONTROLLER DRIVER
> +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/power/reset/qemu-virt-ctrl.c
> +
>  QLOGIC QL41xxx FCOE DRIVER
>  M:	Saurav Kashyap <skashyap@marvell.com>
>  M:	Javed Hasan <jhasan@marvell.com>
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index f6c1bcbb57de..1ca1c2913cbc 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -354,4 +354,14 @@ config POWER_MLXBF
>  	help
>  	  This driver supports reset or low power mode handling for Mellanox Bl=
ueField.
> =20
> +config POWER_RESET_QEMU_VIRT_CTRL
> +	bool "QEMU Virt Machine System Controller"
> +	depends on HAS_IOMEM
> +	help
> +	  This driver supports the system reset and power off functionality
> +	  provided by the QEMU 'virt-ctrl' device.
> +
> +	  Say Y here if you are running Linux on a QEMU virtual machine that
> +	  provides this controller, such as the m68k virt machine.
> +
>  endif
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 0e4ae6f6b5c5..d7ae97241a83 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -41,3 +41,4 @@ obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mod=
e.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
>  obj-$(CONFIG_POWER_MLXBF) +=3D pwr-mlxbf.o
> +obj-$(CONFIG_POWER_RESET_QEMU_VIRT_CTRL) +=3D qemu-virt-ctrl.o
> diff --git a/drivers/power/reset/qemu-virt-ctrl.c b/drivers/power/reset/q=
emu-virt-ctrl.c
> new file mode 100644
> index 000000000000..f1acd22172ce
> --- /dev/null
> +++ b/drivers/power/reset/qemu-virt-ctrl.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * QEMU Virt Machine System Controller Driver
> + *
> + * Copyright (C) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +
> +/* Registers */
> +#define VIRT_CTRL_REG_FEATURES	0x00
> +#define VIRT_CTRL_REG_CMD	0x04
> +
> +/* Commands */
> +#define CMD_NOOP	0
> +#define CMD_RESET	1
> +#define CMD_HALT	2
> +#define CMD_PANIC	3
> +
> +struct qemu_virt_ctrl {
> +	void __iomem *base;
> +	struct notifier_block restart_nb;
> +};
> +
> +static void __iomem *qemu_virt_ctrl_base;
> +
> +static void qemu_virt_ctrl_power_off(void)
> +{
> +	if (qemu_virt_ctrl_base)
> +		iowrite32be(CMD_HALT, qemu_virt_ctrl_base + VIRT_CTRL_REG_CMD);
> +}
> +
> +static int qemu_virt_ctrl_restart(struct notifier_block *nb, unsigned lo=
ng action,
> +				  void *data)
> +{
> +	struct qemu_virt_ctrl *vc =3D container_of(nb, struct qemu_virt_ctrl, r=
estart_nb);
> +
> +	iowrite32be(CMD_RESET, vc->base + VIRT_CTRL_REG_CMD);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int qemu_virt_ctrl_probe(struct platform_device *pdev)
> +{
> +	struct qemu_virt_ctrl *vc;
> +	int ret;
> +
> +	vc =3D devm_kzalloc(&pdev->dev, sizeof(*vc), GFP_KERNEL);
> +	if (!vc)
> +		return -ENOMEM;
> +
> +	vc->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(vc->base))
> +		return PTR_ERR(vc->base);
> +
> +	qemu_virt_ctrl_base =3D vc->base;
> +
> +	vc->restart_nb.notifier_call =3D qemu_virt_ctrl_restart;
> +	vc->restart_nb.priority =3D 128;
> +
> +	ret =3D register_restart_handler(&vc->restart_nb);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot register restart handler\n");

Please use devm_register_sys_off_handler().

> +	if (!pm_power_off)
> +		pm_power_off =3D qemu_virt_ctrl_power_off;

same.

> +	platform_set_drvdata(pdev, vc);
> +
> +	return 0;
> +}
> +
> +static void qemu_virt_ctrl_remove(struct platform_device *pdev)
> +{
> +	struct qemu_virt_ctrl *vc =3D platform_get_drvdata(pdev);
> +
> +	unregister_restart_handler(&vc->restart_nb);
> +
> +	if (pm_power_off =3D=3D qemu_virt_ctrl_power_off)
> +		pm_power_off =3D NULL;
> +}
> +
> +static struct platform_driver qemu_virt_ctrl_driver =3D {
> +	.probe =3D qemu_virt_ctrl_probe,
> +	.remove =3D qemu_virt_ctrl_remove,
> +	.driver =3D {
> +		.name =3D "qemu-virt-ctrl",
> +	},
> +};
> +module_platform_driver(qemu_virt_ctrl_driver);
> +
> +MODULE_AUTHOR("Kuan-Wei Chiu <visitorckw@gmail.com>");
> +MODULE_DESCRIPTION("QEMU Virt Machine System Controller Driver");
> +MODULE_LICENSE("GPL");

You mark this as module_platform_driver() and add MODULE_*, but the
Kconfig option is bool. To be usable as a module it is missing setup
of .id_table in the platform_driver struct for auto-loading.

Greetings,

-- Sebastian

--dxdfocqzfegfbwga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAml9KLEACgkQ2O7X88g7
+pqFhw/9EqvDetKzSO5FMxKDgybRNnz69sGBWYuh7L2geGJp2uzYf9jbmU7eDV13
xR/PGOCyIhPI2FSLfT0TZAq/yEavFUxCDTBg4bdt4w1t3FOSpmRVR2hC1eVZWjVx
Bpo6rggkVC32DCc0yXBFTqRuTPNj6hiV2healG8MZrvjkbIjA3p59yk6SgNybIIb
zt4czYVuP3wzY+PMqO5ayKFT8UHqZsSvfit8lNEWew+6VYkQZh15S/VHwVw6yPPF
dn27TipdYNyJEAttfwkX9/4hqcxqpAMM8yjBIONZ6VHbcpI7N0zqWs1gxgq9hUyl
uHRmzh+F9NhWhouE8PYLFqksct8NPUBTEmMjdUpIkMVilP1d5mkXMWL3v6mS9q4z
b7y1GVDDglpxafYcPhiJcQ1dLPWNnznWdk4uHKLYDUGj2qoazNSi23omI33hUqGI
HBTdhr/IMA2Imo6+3S5gmnMtZIVn90pyNDAzDFIWTBindXF2/aA2Dhmt/6e4vJY8
xW9nfcUWJ18tlnYoQZnysy0CLLnlXTdNCFdQbNma9pp/lQ/WKr11rIvnQps6vrE+
6MeF/Bxd4n/Jq7c9nnYxcQWYpva/ydRomufN+Y05ghd3zI1Ag954VnKnCmd9OnyL
8Fst+zelxUPFl2lc5AFFcZjcKMzRnJ58NO/tjfVeCMzxxRLdKQk=
=7oqZ
-----END PGP SIGNATURE-----

--dxdfocqzfegfbwga--

