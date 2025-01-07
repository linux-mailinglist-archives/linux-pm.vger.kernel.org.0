Return-Path: <linux-pm+bounces-20040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E595BA03F21
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 13:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562F93A27EE
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EEB1F03C7;
	Tue,  7 Jan 2025 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftXJPCq7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDF1E9B39;
	Tue,  7 Jan 2025 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253038; cv=none; b=RCB1msi6VEK/QY/2tomA42XEVG9wHAFwPZidosH081YjLWBKNeoZv+SoNDvYYHpbAogAg4LGWy9Y6Vp6sC57MDpHa3nZ/EsEcLGxuNFU1sgalBEJGx1iccQXjUvOUz08gx7b7LsYa0d0hJam9FnRQY/OgaYeNQOXvutJcZUuaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253038; c=relaxed/simple;
	bh=EFqSCzd5v2Gld3g1FW1U/UHjDj5HxerwE3IJ+FqZM2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCODsCOvOyHo9rNwFwy8YFdBt2GlxTD+w0PCWGPhPXraCX4/3QUfYNOMf+FUA2K4EtuQb9d1Y/YZFwow/nE6wwVfOjdnyRuMFBfz/cH9Az7Y9aTVG2+ZsQG+AmsDMEgRTM6UVcBwmDzLOHXFQzg32h+aoaUebvFFEsO9jRHODlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftXJPCq7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736253034; x=1767789034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EFqSCzd5v2Gld3g1FW1U/UHjDj5HxerwE3IJ+FqZM2g=;
  b=ftXJPCq7Y5NGXH37+GpFanRe2Fhd5d/x2JGK/rX64fFncTNkdQj+TuDU
   zH+KL7hIzcOZc8FAAsgqRmxtah3ZKweVrlUw0/BT+M9KZ4KIMlRRNrXaP
   7x7QEii5hXOuSPq/lk8ZxfnY3Abqt5QBcN2GOAqnn8ujTpg1TNJWFf2eO
   UPbSKtkQHSI7mCwge9pUVUIdV8jSxdckAZ6f/FINUMJ9J94GjiZ/WPREE
   Ch8JOuxas3vTvZ7jBM+shGPrUj+TJn4QdunIAaJt9UWFMlY7Ee44Hwj0q
   9KaVsdUv24i5BqIfnxtB0MmXgn5qy5JuZQguPThbBdZgKGiem9XycBcAJ
   Q==;
X-CSE-ConnectionGUID: 6D8uDw8LSc+2fzzX/jFARA==
X-CSE-MsgGUID: +cPjFAEPTGa0PMtunsagWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40104615"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="40104615"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 04:30:30 -0800
X-CSE-ConnectionGUID: i18lxXtXSlCTxbaY8oKubA==
X-CSE-MsgGUID: SQqy/uwbQOWfJL+/vu8YDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107375946"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa005.fm.intel.com with SMTP; 07 Jan 2025 04:30:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 07 Jan 2025 14:30:23 +0200
Date: Tue, 7 Jan 2025 14:30:23 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 3/5] usb: typec: ucsi: add Huawei Matebook E Go ucsi
 driver
Message-ID: <Z30eX_s9p5ql-9cx@kuha.fi.intel.com>
References: <20250105174159.227831-1-mitltlatltl@gmail.com>
 <20250105174159.227831-4-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105174159.227831-4-mitltlatltl@gmail.com>

Hi,

On Mon, Jan 06, 2025 at 01:41:57AM +0800, Pengyu Luo wrote:
> The Huawei Matebook E Go tablet implements the UCSI interface in the
> onboard EC. Add the glue driver to interface with the platform's UCSI
> implementation.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  drivers/usb/typec/ucsi/Kconfig              |  10 +
>  drivers/usb/typec/ucsi/Makefile             |   1 +
>  drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 524 ++++++++++++++++++++
>  3 files changed, 535 insertions(+)
>  create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c

This did not apply cleanly anymore, but I guess you'll be rebasing in
any case. A few nitpicks below.

> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> index 680e1b87b..8a73df84a 100644
> --- a/drivers/usb/typec/ucsi/Kconfig
> +++ b/drivers/usb/typec/ucsi/Kconfig
> @@ -78,4 +78,14 @@ config UCSI_LENOVO_YOGA_C630
>  	  To compile the driver as a module, choose M here: the module will be
>  	  called ucsi_yoga_c630.
>  
> +config UCSI_HUAWEI_GAOKUN
> +	tristate "UCSI Interface Driver for Huawei Matebook E Go"
> +	depends on EC_HUAWEI_GAOKUN
> +	help
> +	  This driver enables UCSI support on the Huawei Matebook E Go tablet,
> +	  which is a sc8280xp-based 2-in-1 tablet.
> +
> +	  To compile the driver as a module, choose M here: the module will be
> +	  called ucsi_huawei_gaokun.
> +
>  endif
> diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> index aed41d238..0b400122b 100644
> --- a/drivers/usb/typec/ucsi/Makefile
> +++ b/drivers/usb/typec/ucsi/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
>  obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
>  obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
>  obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)	+= ucsi_yoga_c630.o
> +obj-$(CONFIG_UCSI_HUAWEI_GAOKUN)	+= ucsi_huawei_gaokun.o
> diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> new file mode 100644
> index 000000000..044545b44
> --- /dev/null
> +++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ucsi-huawei-gaokun - A UCSI driver for HUAWEI Matebook E Go
> + *
> + * reference: drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> + *            drivers/usb/typec/ucsi/ucsi_glink.c
> + *            drivers/soc/qcom/pmic_glink_altmode.c
> + *
> + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> + */
> +
> +#include <drm/bridge/aux-bridge.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/container_of.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/platform_data/huawei-gaokun-ec.h>
> +#include <linux/string.h>
> +#include <linux/usb/pd_vdo.h>
> +#include <linux/usb/typec_altmode.h>
> +#include <linux/usb/typec_dp.h>
> +#include <linux/workqueue_types.h>
> +
> +#include "ucsi.h"
> +
> +#define EC_EVENT_UCSI	0x21
> +#define EC_EVENT_USB	0x22
> +
> +#define GAOKUN_CCX_MASK		GENMASK(1, 0)
> +#define GAOKUN_MUX_MASK		GENMASK(3, 2)
> +
> +#define GAOKUN_DPAM_MASK	GENMASK(3, 0)
> +#define GAOKUN_HPD_STATE_MASK	BIT(4)
> +#define GAOKUN_HPD_IRQ_MASK	BIT(5)
> +
> +#define GET_IDX(updt) (ffs(updt) - 1)
> +
> +#define CCX_TO_ORI(ccx) (++ccx % 3) /* convert ccx to enum typec_orientation */
> +
> +/* Configuration Channel Extension */
> +enum gaokun_ucsi_ccx {
> +	USBC_CCX_NORMAL,
> +	USBC_CCX_REVERSE,
> +	USBC_CCX_NONE,
> +};
> +
> +enum gaokun_ucsi_mux {
> +	USBC_MUX_NONE,
> +	USBC_MUX_USB_2L,
> +	USBC_MUX_DP_4L,
> +	USBC_MUX_USB_DP,
> +};
> +/* based on pmic_glink_altmode_pin_assignment */
> +enum gaokun_ucsi_dpam_pan {	/* DP Alt Mode Pin Assignments */
> +	USBC_DPAM_PAN_NONE,
> +	USBC_DPAM_PAN_A,	/* Not supported after USB Type-C Standard v1.0b */
> +	USBC_DPAM_PAN_B,	/* Not supported after USB Type-C Standard v1.0b */
> +	USBC_DPAM_PAN_C,	/* USBC_DPAM_PAN_C_REVERSE - 6 */
> +	USBC_DPAM_PAN_D,
> +	USBC_DPAM_PAN_E,
> +	USBC_DPAM_PAN_F,	/* Not supported after USB Type-C Standard v1.0b */
> +	USBC_DPAM_PAN_A_REVERSE,/* Not supported after USB Type-C Standard v1.0b */
> +	USBC_DPAM_PAN_B_REVERSE,/* Not supported after USB Type-C Standard v1.0b */
> +	USBC_DPAM_PAN_C_REVERSE,
> +	USBC_DPAM_PAN_D_REVERSE,
> +	USBC_DPAM_PAN_E_REVERSE,
> +	USBC_DPAM_PAN_F_REVERSE,/* Not supported after USB Type-C Standard v1.0b */
> +};
> +
> +struct gaokun_ucsi_reg {
> +	u8 port_num;
> +	u8 port_updt;
> +	u8 port_data[4];
> +	u8 checksum;
> +	u8 reserved;
> +} __packed;
> +
> +struct gaokun_ucsi_port {
> +	struct completion usb_ack;
> +	spinlock_t lock;
> +
> +	struct gaokun_ucsi *ucsi;
> +	struct auxiliary_device *bridge;
> +
> +	int idx;
> +	enum gaokun_ucsi_ccx ccx;
> +	enum gaokun_ucsi_mux mux;
> +	u8 mode;
> +	u16 svid;
> +	u8 hpd_state;
> +	u8 hpd_irq;
> +};
> +
> +struct gaokun_ucsi {
> +	struct gaokun_ec *ec;
> +	struct ucsi *ucsi;
> +	struct gaokun_ucsi_port *ports;
> +	struct device *dev;
> +	struct delayed_work work;
> +	struct notifier_block nb;
> +	u16 version;
> +	u8 port_num;
> +};
> +
> +/* -------------------------------------------------------------------------- */
> +/* For UCSI */
> +
> +static int gaokun_ucsi_read_version(struct ucsi *ucsi, u16 *version)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> +
> +	*version = uec->version;
> +
> +	return 0;
> +}
> +
> +static int gaokun_ucsi_read_cci(struct ucsi *ucsi, u32 *cci)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	u8 buf[GAOKUN_UCSI_READ_SIZE];
> +	int ret;
> +
> +	ret = gaokun_ec_ucsi_read(uec->ec, buf);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(cci, buf, sizeof(*cci));
> +
> +	return 0;
> +}
> +
> +static int gaokun_ucsi_read_message_in(struct ucsi *ucsi,
> +				       void *val, size_t val_len)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	u8 buf[GAOKUN_UCSI_READ_SIZE];
> +	int ret;
> +
> +	ret = gaokun_ec_ucsi_read(uec->ec, buf);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(val, buf + GAOKUN_UCSI_CCI_SIZE,
> +	       min(val_len, GAOKUN_UCSI_DATA_SIZE));
> +
> +	return 0;
> +}
> +
> +static int gaokun_ucsi_async_control(struct ucsi *ucsi, u64 command)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	u8 buf[GAOKUN_UCSI_WRITE_SIZE] = {};
> +
> +	memcpy(buf, &command, sizeof(command));
> +
> +	return gaokun_ec_ucsi_write(uec->ec, buf);
> +}
> +
> +static void gaokun_ucsi_update_connector(struct ucsi_connector *con)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(con->ucsi);
> +
> +	if (con->num > uec->port_num)
> +		return;
> +
> +	con->typec_cap.orientation_aware = true;
> +}
> +
> +static void gaokun_set_orientation(struct ucsi_connector *con,
> +				   struct gaokun_ucsi_port *port)
> +{
> +	enum gaokun_ucsi_ccx ccx;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	ccx = port->ccx;
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	typec_set_orientation(con->port, CCX_TO_ORI(ccx));
> +}
> +
> +static void gaokun_ucsi_connector_status(struct ucsi_connector *con)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(con->ucsi);
> +	int idx;
> +
> +	idx = con->num - 1;
> +	if (con->num > uec->port_num) {
> +		dev_warn(uec->dev, "set orientation out of range: con%d\n", idx);
> +		return;
> +	}
> +
> +	gaokun_set_orientation(con, &uec->ports[idx]);
> +}
> +
> +const struct ucsi_operations gaokun_ucsi_ops = {
> +	.read_version = gaokun_ucsi_read_version,
> +	.read_cci = gaokun_ucsi_read_cci,
> +	.read_message_in = gaokun_ucsi_read_message_in,
> +	.sync_control = ucsi_sync_control_common,
> +	.async_control = gaokun_ucsi_async_control,
> +	.update_connector = gaokun_ucsi_update_connector,
> +	.connector_status = gaokun_ucsi_connector_status,
> +};
> +
> +/* -------------------------------------------------------------------------- */
> +/* For Altmode */
> +
> +static void gaokun_ucsi_port_update(struct gaokun_ucsi_port *port,
> +				    const u8 *port_data)
> +{
> +	struct gaokun_ucsi *uec = port->ucsi;
> +	int offset = port->idx * 2; /* every port has 2 Bytes data */
> +	unsigned long flags;
> +	u8 dcc, ddi;
> +
> +	dcc = port_data[offset];
> +	ddi = port_data[offset + 1];
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	port->ccx = FIELD_GET(GAOKUN_CCX_MASK, dcc);
> +	port->mux = FIELD_GET(GAOKUN_MUX_MASK, dcc);
> +	port->mode = FIELD_GET(GAOKUN_DPAM_MASK, ddi);
> +	port->hpd_state = FIELD_GET(GAOKUN_HPD_STATE_MASK, ddi);
> +	port->hpd_irq = FIELD_GET(GAOKUN_HPD_IRQ_MASK, ddi);
> +
> +	/* Mode and SVID are unused; keeping them to make things clearer */
> +	switch (port->mode) {
> +	case USBC_DPAM_PAN_C:
> +	case USBC_DPAM_PAN_C_REVERSE:
> +		port->mode = DP_PIN_ASSIGN_C; /* correct it for usb later */
> +		break;
> +	case USBC_DPAM_PAN_D:
> +	case USBC_DPAM_PAN_D_REVERSE:
> +		port->mode = DP_PIN_ASSIGN_D;
> +		break;
> +	case USBC_DPAM_PAN_E:
> +	case USBC_DPAM_PAN_E_REVERSE:
> +		port->mode = DP_PIN_ASSIGN_E;
> +		break;
> +	case USBC_DPAM_PAN_NONE:
> +		port->mode = TYPEC_STATE_SAFE;
> +		break;
> +	default:
> +		dev_warn(uec->dev, "unknow mode %d\n", port->mode);
> +		break;
> +	}
> +
> +	switch (port->mux) {
> +	case USBC_MUX_NONE:
> +		port->svid = 0;
> +		break;
> +	case USBC_MUX_USB_2L:
> +		port->svid = USB_SID_PD;
> +		port->mode = TYPEC_STATE_USB; /* same as PAN_C, correct it */
> +		break;
> +	case USBC_MUX_DP_4L:
> +	case USBC_MUX_USB_DP:
> +		port->svid = USB_SID_DISPLAYPORT;
> +		break;
> +	default:
> +		dev_warn(uec->dev, "unknow mux state %d\n", port->mux);
> +		break;
> +	}
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static int gaokun_ucsi_refresh(struct gaokun_ucsi *uec)
> +{
> +	struct gaokun_ucsi_reg ureg;
> +	int ret, idx;
> +
> +	ret = gaokun_ec_ucsi_get_reg(uec->ec, (u8 *)&ureg);
> +	if (ret)
> +		return GAOKUN_UCSI_NO_PORT_UPDATE;
> +
> +	uec->port_num = ureg.port_num;
> +	idx = GET_IDX(ureg.port_updt);
> +
> +	if (idx < 0 || idx >= ureg.port_num)
> +		return GAOKUN_UCSI_NO_PORT_UPDATE;
> +
> +	gaokun_ucsi_port_update(&uec->ports[idx], ureg.port_data);
> +	return idx;
> +}
> +
> +static void gaokun_ucsi_handle_altmode(struct gaokun_ucsi_port *port)
> +{
> +	struct gaokun_ucsi *uec = port->ucsi;
> +	int idx = port->idx;
> +
> +	if (idx >= uec->ucsi->cap.num_connectors) {
> +		dev_warn(uec->dev, "altmode port out of range: %d\n", idx);
> +		return;
> +	}
> +
> +	/* UCSI callback .connector_status() have set orientation */
> +	if (port->bridge)
> +		drm_aux_hpd_bridge_notify(&port->bridge->dev,
> +					  port->hpd_state ?
> +					  connector_status_connected :
> +					  connector_status_disconnected);
> +
> +	gaokun_ec_ucsi_pan_ack(uec->ec, port->idx);
> +}
> +
> +static void gaokun_ucsi_altmode_notify_ind(struct gaokun_ucsi *uec)
> +{
> +	int idx;
> +
> +	 if (!uec->ucsi->connector) { /* slow to register */
> +		 dev_err(uec->dev, "ucsi connector is not initialized yet\n");
> +		 return;
> +	 }
> +
> +	idx = gaokun_ucsi_refresh(uec);
> +	if (idx == GAOKUN_UCSI_NO_PORT_UPDATE)
> +		gaokun_ec_ucsi_pan_ack(uec->ec, idx); /* ack directly if no update */
> +	else
> +		gaokun_ucsi_handle_altmode(&uec->ports[idx]);
> +}
> +
> +/*
> + * USB event is necessary for enabling altmode, the event should follow
> + * UCSI event, if not after timeout(this notify may be disabled somehow),
> + * then force to enable altmode.
> + */
> +static void gaokun_ucsi_handle_no_usb_event(struct gaokun_ucsi *uec, int idx)
> +{
> +	struct gaokun_ucsi_port *port;
> +
> +	port = &uec->ports[idx];
> +	if (!wait_for_completion_timeout(&port->usb_ack, 2 * HZ)) {
> +		dev_warn(uec->dev, "No USB EVENT, triggered by UCSI EVENT");
> +		gaokun_ucsi_altmode_notify_ind(uec);
> +	}
> +}
> +
> +static int gaokun_ucsi_notify(struct notifier_block *nb,
> +			      unsigned long action, void *data)
> +{
> +	u32 cci;
> +	struct gaokun_ucsi *uec = container_of(nb, struct gaokun_ucsi, nb);
> +
> +	switch (action) {
> +	case EC_EVENT_USB:
> +		gaokun_ucsi_altmode_notify_ind(uec);
> +		return NOTIFY_OK;
> +
> +	case EC_EVENT_UCSI:
> +		uec->ucsi->ops->read_cci(uec->ucsi, &cci);

I think it would be more clear here to just call
gaokun_ucsi_read_cci() directly here.

> +		ucsi_notify_common(uec->ucsi, cci);
> +		if (UCSI_CCI_CONNECTOR(cci))
> +			gaokun_ucsi_handle_no_usb_event(uec, UCSI_CCI_CONNECTOR(cci) - 1);
> +
> +		return NOTIFY_OK;
> +
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}
> +
> +static inline int gaokun_ucsi_get_port_num(struct gaokun_ucsi *uec)
> +{
> +	struct gaokun_ucsi_reg ureg;
> +	int ret;
> +
> +	ret = gaokun_ec_ucsi_get_reg(uec->ec, (u8 *)&ureg);
> +
> +	return ret ? 0 : ureg.port_num;
> +}

This function does not look like it's necessary to me.

> +static int gaokun_ucsi_ports_init(struct gaokun_ucsi *uec)
> +{
> +	u32 port;
> +	int i, ret, port_num;
> +	struct device *dev = uec->dev;
> +	struct gaokun_ucsi_port *ucsi_port;
> +	struct fwnode_handle *fwnode;
> +
> +	port_num = gaokun_ucsi_get_port_num(uec);
> +	uec->port_num = port_num;

struct gaokun_ucsi_reg ureg = { };

gaokun_ec_ucsi_get_reg(uec->ec, &ureg);
port_num = ureg->port_num;

(Btw. port_num here is confusing IMO, because you are not talking
about the number of a port, but instead number of all ports. So
something like num_ports or nports would be better).

> +	uec->ports = devm_kcalloc(dev, port_num, sizeof(*(uec->ports)),
> +				  GFP_KERNEL);
> +	if (!uec->ports)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < port_num; ++i) {
> +		ucsi_port = &uec->ports[i];
> +		ucsi_port->ccx = USBC_CCX_NONE;
> +		ucsi_port->idx = i;
> +		ucsi_port->ucsi = uec;
> +		init_completion(&ucsi_port->usb_ack);
> +		spin_lock_init(&ucsi_port->lock);
> +	}
> +
> +	device_for_each_child_node(dev, fwnode) {
> +		ret = fwnode_property_read_u32(fwnode, "reg", &port);
> +		if (ret < 0) {
> +			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
> +			fwnode_handle_put(fwnode);
> +			return ret;
> +		}
> +
> +		if (port >= port_num) {
> +			dev_warn(dev, "invalid connector number %d, ignoring\n", port);
> +			continue;
> +		}
> +
> +		ucsi_port = &uec->ports[port];
> +		ucsi_port->bridge = devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwnode));
> +		if (IS_ERR(ucsi_port->bridge)) {
> +			fwnode_handle_put(fwnode);
> +			return PTR_ERR(ucsi_port->bridge);
> +		}
> +	}
> +
> +	for (i = 0; i < port_num; i++) {
> +		if (!uec->ports[i].bridge)
> +			continue;
> +
> +		ret = devm_drm_dp_hpd_bridge_add(dev, uec->ports[i].bridge);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void gaokun_ucsi_register_worker(struct work_struct *work)
> +{
> +	struct gaokun_ucsi *uec;
> +	struct ucsi *ucsi;
> +	int ret;
> +
> +	uec = container_of(work, struct gaokun_ucsi, work.work);
> +	ucsi = uec->ucsi;
> +	/* This may be a problem specific to sc8280xp-based machines */
> +	ucsi->quirks = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_PDOS;
> +
> +	ret = gaokun_ec_register_notify(uec->ec, &uec->nb);
> +	if (ret) {
> +		dev_err_probe(ucsi->dev, ret, "notifier register failed\n");
> +		return;
> +	}
> +
> +	ret = ucsi_register(ucsi);
> +	if (ret)
> +		dev_err_probe(ucsi->dev, ret, "ucsi register failed\n");
> +}
> +
> +static inline int gaokun_ucsi_register(struct gaokun_ucsi *uec)
> +{
> +	/* EC can't handle UCSI properly in the early stage */
> +	schedule_delayed_work(&uec->work, 3 * HZ);
> +
> +	return 0;
> +}

This whole function is unnecessary.

> +static int gaokun_ucsi_probe(struct auxiliary_device *adev,
> +			     const struct auxiliary_device_id *id)
> +{
> +	struct gaokun_ec *ec = adev->dev.platform_data;
> +	struct device *dev = &adev->dev;
> +	struct gaokun_ucsi *uec;
> +	int ret;
> +
> +	uec = devm_kzalloc(dev, sizeof(*uec), GFP_KERNEL);
> +	if (!uec)
> +		return -ENOMEM;
> +
> +	uec->ec = ec;
> +	uec->dev = dev;
> +	uec->version = 0x0100;

Please add a definition for UCSI v1.0 to ucsi.h (separate patch).

> +	uec->nb.notifier_call = gaokun_ucsi_notify;
> +
> +	INIT_DELAYED_WORK(&uec->work, gaokun_ucsi_register_worker);
> +
> +	ret = gaokun_ucsi_ports_init(uec);
> +	if (ret)
> +		return ret;
> +
> +	uec->ucsi = ucsi_create(dev, &gaokun_ucsi_ops);
> +	if (IS_ERR(uec->ucsi))
> +		return PTR_ERR(uec->ucsi);
> +
> +	ucsi_set_drvdata(uec->ucsi, uec);
> +	auxiliary_set_drvdata(adev, uec);
> +
> +	return gaokun_ucsi_register(uec);
> +}
> +
> +static void gaokun_ucsi_remove(struct auxiliary_device *adev)
> +{
> +	struct gaokun_ucsi *uec = auxiliary_get_drvdata(adev);
> +
> +	gaokun_ec_unregister_notify(uec->ec, &uec->nb);
> +	ucsi_unregister(uec->ucsi);
> +	ucsi_destroy(uec->ucsi);
> +}
> +
> +static const struct auxiliary_device_id gaokun_ucsi_id_table[] = {
> +	{ .name = GAOKUN_MOD_NAME "." GAOKUN_DEV_UCSI, },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, gaokun_ucsi_id_table);
> +
> +static struct auxiliary_driver gaokun_ucsi_driver = {
> +	.name = GAOKUN_DEV_UCSI,
> +	.id_table = gaokun_ucsi_id_table,
> +	.probe = gaokun_ucsi_probe,
> +	.remove = gaokun_ucsi_remove,
> +};
> +
> +module_auxiliary_driver(gaokun_ucsi_driver);
> +
> +MODULE_DESCRIPTION("HUAWEI Matebook E Go UCSI driver");
> +MODULE_LICENSE("GPL");

thanks,

-- 
heikki

