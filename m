Return-Path: <linux-pm+bounces-19808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82AF9FDA9B
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 14:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD23A1119
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B1415A856;
	Sat, 28 Dec 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUbaSkpk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF055156886
	for <linux-pm@vger.kernel.org>; Sat, 28 Dec 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735391211; cv=none; b=gPcFq6A8qsKQ9eOHX4ULsFLPxPXdPptaLTGB6hmNpqp6gDNyEklo5hdJePBfDewzDlz79kok0sJ+snMeDLuIizOfc4hVMCiNiNb2ILHQAF/4OSd9U7KxWrVskiPi1dtf3qojGmobQta4Lnkiw/wXdyXQDlzZivdK/mENrV7Hbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735391211; c=relaxed/simple;
	bh=7pH1FNXPUZur4zvOg5V0+KD1TvcrBhcmk2B7tMhJUSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OySXzT5d/8PAsZbYsOc7BAphpXlDfE2WGw4UoceJ1/jfG2XvJLewUxX1kq/XbYcLIOVy5KfEBMyf9Nf2nFZOqCLDaGTqrjtnZnmFhx3GVPf7GP1+jtmgUiTNE12CT5VumB1hZpvZNSem2+/4Kg9XRAJBDS/RznaPkiX1JhOUF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUbaSkpk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862b364538so4462751f8f.1
        for <linux-pm@vger.kernel.org>; Sat, 28 Dec 2024 05:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735391207; x=1735996007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9Ex08q88jppdYtHuLeppku7Y0JRcskid1tEbDb3tIk=;
        b=cUbaSkpk+Wnd42rdSsAg0BUfG5WX01y0EPyHz+enHzPkVWY/NhB0CrY1ilop3ZA08G
         PR3OKjyqs2Q/Yqgds6ubyFbuvfuQaFE1YTdj6ySX6lb2SN4mM8QuPxk50/ruqjhy8e8k
         tSgiASt163YbhdcRm5rrTxLkXSnBUS3AfJwMWKzYy8m88Z1P7iWejNqFa/tKQntcY1g5
         s178tulo6Ug/jBxKJgTHgUfWJ7Xw+/3MvZ5b42VETAUjYsZ6EH6+OzUvyGFC14F7bGr3
         K9Ql5+/UvIXMEjp+yRrm23YsswYGi6E1eRxWLcR0LLfRbJ7zo3xu6NdldUdUop3E+3gj
         iTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735391207; x=1735996007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Ex08q88jppdYtHuLeppku7Y0JRcskid1tEbDb3tIk=;
        b=B4NSULfZa6ZhmpMrVGvpRIuvmZ/p9QgVBkOqVf0AX6IuhokPGzrfm4HELVCbH+SNgw
         ZKsYhklRlh5Jug0cY74c50N6EgLga6Q96GDhAdNkFagBvMy+EFx+PJWwg0n4riVKKlgz
         Iv8OmFimHH8pLPpeyQnFKAhEAjH2Hx3LQMQ2J7ZhGBtGuNcH7pDD+MNWbPhKHox03Rg3
         g3vKxwWoOjY/2D2PjyL6YMqRHoy+DISoIlMCiLx+A8UiwSfYL6x3k1JlQMuYPgrEJ+mr
         UmC3KYIFFYJSHHRAE8RoJM43JFubRv6wv9ZHZSX+iTJagdlKQdgjJvrWA71xvSBvCQvZ
         hR+w==
X-Forwarded-Encrypted: i=1; AJvYcCW9zEGBikx0vCIkaTOcQR7UQQUiC015rAA+y11k6yM4mPRjFm2/nDv7glFt04nuZtpSBniUwveBCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNc+TenhRvQCxBAHLYdfrfEBZ7csuQrpme6LYId/EGasUF0Mxg
	wi26ucH6qmw9mBDHucvSyd1DVDRlcHN36VYyr19iy5N9o20PJIY1MxgDbjLMcjE=
X-Gm-Gg: ASbGncsPTNm8DeMN2pAh2/oCsBULHdn8POllGfPl7KdFgZqV805b4SkdvV63kQMh4pF
	7zPVY7K9+9yqcBpFz8ZNX9eTbWg9s7/yJR0JRP38DEZXntavJF0Sb+le3ivEdthBSifAHLjsvtc
	tPC2v8wNy7HxAx0cIbqq+v9gm1gk2mUQq3bmZgyn9VfCFPGEv3Js56lwkWM96Y5nmZNaC+pskKq
	snIEy06jz5T/qUYeju+qC18CDtcfdmbKbxJUHOR1twN6dwysifz1UNoTdZ8uDqI1/7lxA==
X-Google-Smtp-Source: AGHT+IFKyQpt7IZTSKfZEwaO4ndZcZS6FH9gyGEc0jzk6x+GEC8VoH1sDPJiw93OnwbF87ehb0KQzQ==
X-Received: by 2002:a5d:47c3:0:b0:386:4a2c:3908 with SMTP id ffacd0b85a97d-38a22a1aa5bmr22460139f8f.17.1735391206986;
        Sat, 28 Dec 2024 05:06:46 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1cesm24453791f8f.64.2024.12.28.05.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2024 05:06:46 -0800 (PST)
Message-ID: <c17372ed-baf0-40a7-b267-25f1ff849cf7@linaro.org>
Date: Sat, 28 Dec 2024 13:06:45 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] usb: typec: ucsi: add Huawei Matebook E Go (sc8280xp)
 ucsi driver
To: Pengyu Luo <mitltlatltl@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Sebastian Reichel <sre@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Nikita Travkin <nikita@trvn.ru>
References: <20241227171353.404432-1-mitltlatltl@gmail.com>
 <20241227171353.404432-4-mitltlatltl@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241227171353.404432-4-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/12/2024 17:13, Pengyu Luo wrote:
> The Huawei Matebook E Go (sc8280xp) tablet provides implements UCSI
> interface in the onboard EC. Add the glue driver to interface the
> platform's UCSI implementation.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>   drivers/usb/typec/ucsi/Kconfig              |   9 +
>   drivers/usb/typec/ucsi/Makefile             |   1 +
>   drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 481 ++++++++++++++++++++
>   3 files changed, 491 insertions(+)
>   create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> 
> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> index 680e1b87b..0d0f07488 100644
> --- a/drivers/usb/typec/ucsi/Kconfig
> +++ b/drivers/usb/typec/ucsi/Kconfig
> @@ -78,4 +78,13 @@ config UCSI_LENOVO_YOGA_C630
>   	  To compile the driver as a module, choose M here: the module will be
>   	  called ucsi_yoga_c630.
>   
> +config UCSI_HUAWEI_GAOKUN
> +	tristate "UCSI Interface Driver for Huawei Matebook E Go (sc8280xp)"
> +	depends on EC_HUAWEI_GAOKUN
> +	help
> +	  This driver enables UCSI support on the Huawei Matebook E Go tablet.
> +
> +	  To compile the driver as a module, choose M here: the module will be
> +	  called ucsi_huawei_gaokun.
> +
>   endif
> diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> index aed41d238..0b400122b 100644
> --- a/drivers/usb/typec/ucsi/Makefile
> +++ b/drivers/usb/typec/ucsi/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
>   obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
>   obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
>   obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)	+= ucsi_yoga_c630.o
> +obj-$(CONFIG_UCSI_HUAWEI_GAOKUN)	+= ucsi_huawei_gaokun.o
> diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> new file mode 100644
> index 000000000..84ed0407d
> --- /dev/null
> +++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> @@ -0,0 +1,481 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ucsi-huawei-gaokun - A UCSI driver for HUAWEI Matebook E Go (sc8280xp)
> + *
> + * reference: drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> + *            drivers/usb/typec/ucsi/ucsi_glink.c
> + *            drivers/soc/qcom/pmic_glink_altmode.c
> + *
> + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/container_of.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/string.h>
> +#include <linux/workqueue_types.h>
> +
> +#include <linux/usb/pd_vdo.h>
> +#include <drm/bridge/aux-bridge.h

Is there a reason you don't have strict include alphanumeric ordering here ?

>
> +
> +#include "ucsi.h"
> +#include <linux/platform_data/huawei-gaokun-ec.h>
> +
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
> +#define CCX_TO_ORI(ccx) (++ccx % 3)

Why do you increment the value of the enum ?
Seems strange.

> +
> +#define GET_IDX(updt) (ffs(updt) - 1)
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
> +	struct work_struct work;
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
> +		dev_warn(uec->ucsi->dev, "set orientation out of range: con%d\n", idx);
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
> +	unsigned long flags;
> +	u8 dcc, ddi;
> +	int offset = port->idx * 2; /* every port has 2 Bytes data */
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
> +	switch (port->mux) {
> +	case USBC_MUX_NONE:
> +		port->svid = 0;
> +		break;
> +	case USBC_MUX_USB_2L:
> +		port->svid = USB_SID_PD;
> +		break;
> +	case USBC_MUX_DP_4L:
> +	case USBC_MUX_USB_DP:
> +		port->svid = USB_SID_DISPLAYPORT;
> +		if (port->ccx == USBC_CCX_REVERSE)
> +			port->mode -= 6;

why minus six ?
needs a comment.

> +		break;
> +	default:
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
> +		return -EIO;
> +
> +	uec->port_num = ureg.port_num;
> +	idx = GET_IDX(ureg.port_updt);
> +
> +	if (idx >= 0 && idx < ureg.port_num)
> +		gaokun_ucsi_port_update(&uec->ports[idx], ureg.port_data);

Since you are checking the validity of the index, you should -EINVAL if 
the index is out of range.

> +
> +	return idx;
> +}
> +
> +static void gaokun_ucsi_handle_altmode(struct gaokun_ucsi_port *port)
> +{
> +	struct gaokun_ucsi *uec = port->ucsi;
> +	int idx = port->idx;
> +
> +	if (idx >= uec->ucsi->cap.num_connectors || !uec->ucsi->connector) {
> +		dev_warn(uec->ucsi->dev, "altmode port out of range: %d\n", idx);
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
> +	idx = gaokun_ucsi_refresh(uec);
> +	if (idx < 0)
> +		gaokun_ec_ucsi_pan_ack(uec->ec, idx);
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
> +static int gaokun_ucsi_get_port_num(struct gaokun_ucsi *uec)
> +{
> +	struct gaokun_ucsi_reg ureg;
> +	int ret;
> +
> +	ret = gaokun_ec_ucsi_get_reg(uec->ec, (u8 *)&ureg);
> +
> +	return ret ? 0 : ureg.port_num;
> +}
> +
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
> +
> +	uec->ports = devm_kzalloc(dev, port_num * sizeof(*(uec->ports)),
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
> +	uec = container_of(work, struct gaokun_ucsi, work);
> +	ucsi = uec->ucsi;
> +
> +	ucsi->quirks = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_PDOS;
> +
> +	ssleep(3); /* EC can't handle UCSI properly in the early stage */

Could you not schedule work for + 3 seconds instead of sleeping here - 
representing the required stall time in some sort of state machine ?

3 seconds is an incredibly long time for a computer to sleep.

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
> +static int gaokun_ucsi_register(struct gaokun_ucsi *uec)
> +{
> +	schedule_work(&uec->work);
> +
> +	return 0;
> +}
> +
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
> +	uec->nb.notifier_call = gaokun_ucsi_notify;
> +
> +	INIT_WORK(&uec->work, gaokun_ucsi_register_worker);
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


