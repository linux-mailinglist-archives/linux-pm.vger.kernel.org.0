Return-Path: <linux-pm+bounces-19818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E69FDE23
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 10:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34891616A9
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B5C7083A;
	Sun, 29 Dec 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS7KpQ7c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3A2594AD;
	Sun, 29 Dec 2024 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735463228; cv=none; b=XY5tNEs3rCMZKUcvzp8mJRfDb/CVAhWmAmWKK15XhxtnitJY34d/7+0smQK74qprE8jqD/MCoItDzjOH2hPUHBjQtDtQN9l/8bVRKyJjodTrFqAeAMaqNYjGL3ClL22p2OBZyeE1OLZ2QeC9eqQ/D4kG1fRHpqaYSWJcGs9BIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735463228; c=relaxed/simple;
	bh=96AC8vJOOLWOQS8Fno7mMGr/kpPkeaQSiZdEB74bLms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nL4Thkp4zr2MrxA1Tq3yIYn8j4tH3blXCfadLtFH5hfsI8W3IoSB2LuTR0mThbNY9moajFlj3zIbKPOeAdGHLtcM18xo69GlPGg+VKTug/ajGFp3V4BLaNPXQU8egBrnBYjdGrKgZMfSc5Jqs8Okoipq2v0LUOunT5f9vpvVVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS7KpQ7c; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso10818802a91.0;
        Sun, 29 Dec 2024 01:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735463224; x=1736068024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ky5kxY6CrDWI4dFxBIRtnKurpeFKBUeEmgnG0ubEZE=;
        b=FS7KpQ7cDbuyffo+udU+5GvDduwtTynaNnD+f0ohjUxgEYg5P4b3fGtYAZj5Wxv1aV
         kmjznVDhcjfm1SGcSK8LCbeb5TZgddG2zIBorCOdkHtB/G+Nx9iQUKAY7en3cXq5kOA8
         vEyvxDdf+ZuDmVzVJV6cRbzABbHq/lf5MAksh6Bwb4rK4UPfP4C4URbUHrcKFaxODaYv
         lvaSpGfymcCUm3Hd9xeb0H2KFg7f0Jch9mKOUOgSNcTGAngLDsKviSW/1Vb9WDctf/2l
         d/lDmqCU/a/LeTZfbl/2w0V9jhowM2q9xQfE2gNenHAeWZ0GTjIk7zpzOB/c3ImJ6bu+
         UzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735463224; x=1736068024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ky5kxY6CrDWI4dFxBIRtnKurpeFKBUeEmgnG0ubEZE=;
        b=H+wEvnqylU9xW1PiYYBIAn+/VSYt8yY/lam25N7aHOOjbjInELwbSf11ktMBknbnoa
         Hopw73lwA/bKr6H4Pzw9s218v/QKRQS17rDAsnjck1yPYJp8/DbpGUm12ysKA95YoEXk
         pc3wNLlEBm/PPJ8EFdzDsPJOvlXDaZXoB1ILrnBH7h2wynH85rqnhRu4rolR4J4+p2R+
         PgzfJxZ0i8y7fdW5J2rdMYjeLIEVrzHIXZ+eehOy3JA9iVlQic045q/g6dtB7zV2IP+T
         gB1a1SVFrV8i2W7NTSdwwoDYePULDME70OwlwqMXpLq/kqeAJIyIJlJRpB2b1CBXZWlO
         xcsg==
X-Forwarded-Encrypted: i=1; AJvYcCUFnzX44q0l+0nS7wrgALifa+owHy3PmIyA6d7lcZEQX8iHxsluwu3Ots0H8MKloKv62oJBhUjBhr2qUQ0T1w==@vger.kernel.org, AJvYcCV5CoZ5xWbIKgBgu3YqDK8/1iD9oEhsBbKiRH/feqXiZ3dU1o9+5SR5ZxttTP9L0BxlLc+G78nwaNlp@vger.kernel.org, AJvYcCVLPXCodZtJfs7saP6p8ahwrtGPN32QFgC8iY7rjkja8J0Eanp66oIgntIZ6bTYu5QPXX8JvC2l4QqESUfy@vger.kernel.org, AJvYcCVhemAxqEafV+cKfye4lx47PK7YDFXTR8S9TcxpStMRkuruQNxT90ea3DgbYHFCDFzQkpJQI8S5VMqUbgolxjl82lIqaw==@vger.kernel.org, AJvYcCWLNxdnY1S2kWnXk40fWk1qn9SvgNRs7lCYm81OBs84C74a5FcDtI8hSRcrw8Bl8n/Ig3IQuYccLzw9@vger.kernel.org, AJvYcCWcmo253muXW/ijRDhCFaKiyL/OfGeUrm0yY+IzPs/FgqathSsauS3JAjH0qLDSNC8OnRS+grf1yjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjP7mO8vfrt2JRqRXti6Aj0zq+r+Tm9HPKE0+A79/vRVkU76O+
	WOGl1l/JvzcocsP3Fw8PxHfjzcqM6IUmVBgeKd9PzVdeHAPGCXhm
X-Gm-Gg: ASbGncuGfsuKXzN7/+lWURbXZMAPA91UyuceSpaxWgc5Yy2171Y6nrQ5WBxxcgjpeZg
	I/boWPXQXGWAJkxwLpUNWuKdpjJiCObdVMHSsK7ZOwGDvCE5eE7I5xNHmrSvoSstrJHiVS3bjy0
	TCrO4OwhNlgE7dLD7YjkFeqVstcsTuH5JzRl9zu+3B371k3mDDI1VhraGtyyVdkOwabs4iMAhQT
	wqISHdK2RYeANCbw57lL8+ppG1+0D8ug/r4xv065iY=
X-Google-Smtp-Source: AGHT+IFGKZ/kyJyKNpuO1MOABO2V/J/Zc8Mrf6U0Ht8p3aiicIpXq05yAt+wP8Ajs6HNCEB4/uVqeQ==
X-Received: by 2002:a17:90b:5245:b0:2ee:d958:1b18 with SMTP id 98e67ed59e1d1-2f452f01c34mr41627454a91.36.1735463224175;
        Sun, 29 Dec 2024 01:07:04 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62b30asm20603269a91.12.2024.12.29.01.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2024 01:07:03 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: dmitry.baryshkov@linaro.org
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mitltlatltl@gmail.com,
	nikita@trvn.ru,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH 3/5] usb: typec: ucsi: add Huawei Matebook E Go (sc8280xp) ucsi driver
Date: Sun, 29 Dec 2024 17:05:47 +0800
Message-ID: <20241229090547.51958-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <3q4xpa6gyw5sam4qr7glg2b25bzwgunxwhfqjogqw3wqocphph@5jdbkh6pkxic>
References: <3q4xpa6gyw5sam4qr7glg2b25bzwgunxwhfqjogqw3wqocphph@5jdbkh6pkxic>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Dec 29, 2024 at 12:40 PM Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> On Sat, Dec 28, 2024 at 01:13:51AM +0800, Pengyu Luo wrote:
> > The Huawei Matebook E Go (sc8280xp) tablet provides implements UCSI
> > interface in the onboard EC. Add the glue driver to interface the
> > platform's UCSI implementation.
> >
> > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > ---
> >  drivers/usb/typec/ucsi/Kconfig              |   9 +
> >  drivers/usb/typec/ucsi/Makefile             |   1 +
> >  drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 481 ++++++++++++++++++++
> >  3 files changed, 491 insertions(+)
> >  create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> >
> > diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> > index 680e1b87b..0d0f07488 100644
> > --- a/drivers/usb/typec/ucsi/Kconfig
> > +++ b/drivers/usb/typec/ucsi/Kconfig
> > @@ -78,4 +78,13 @@ config UCSI_LENOVO_YOGA_C630
> >         To compile the driver as a module, choose M here: the module will be
> >         called ucsi_yoga_c630.
> >
> > +config UCSI_HUAWEI_GAOKUN
> > +     tristate "UCSI Interface Driver for Huawei Matebook E Go (sc8280xp)"
> > +     depends on EC_HUAWEI_GAOKUN
> > +     help
> > +       This driver enables UCSI support on the Huawei Matebook E Go tablet.
> > +
> > +       To compile the driver as a module, choose M here: the module will be
> > +       called ucsi_huawei_gaokun.
> > +
> >  endif
> > diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> > index aed41d238..0b400122b 100644
> > --- a/drivers/usb/typec/ucsi/Makefile
> > +++ b/drivers/usb/typec/ucsi/Makefile
> > @@ -22,3 +22,4 @@ obj-$(CONFIG_UCSI_CCG)                      += ucsi_ccg.o
> >  obj-$(CONFIG_UCSI_STM32G0)           += ucsi_stm32g0.o
> >  obj-$(CONFIG_UCSI_PMIC_GLINK)                += ucsi_glink.o
> >  obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)  += ucsi_yoga_c630.o
> > +obj-$(CONFIG_UCSI_HUAWEI_GAOKUN)     += ucsi_huawei_gaokun.o
> > diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> > new file mode 100644
> > index 000000000..84ed0407d
> > --- /dev/null
> > +++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> > @@ -0,0 +1,481 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ucsi-huawei-gaokun - A UCSI driver for HUAWEI Matebook E Go (sc8280xp)
> > + *
> > + * reference: drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> > + *            drivers/usb/typec/ucsi/ucsi_glink.c
> > + *            drivers/soc/qcom/pmic_glink_altmode.c
> > + *
> > + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/bitops.h>
> > +#include <linux/completion.h>
> > +#include <linux/container_of.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/of.h>
> > +#include <linux/string.h>
> > +#include <linux/workqueue_types.h>
> > +
> > +#include <linux/usb/pd_vdo.h>
> > +#include <drm/bridge/aux-bridge.h>
> > +
> > +#include "ucsi.h"
> > +#include <linux/platform_data/huawei-gaokun-ec.h>
> > +
> > +
> > +#define EC_EVENT_UCSI        0x21
> > +#define EC_EVENT_USB 0x22
> > +
> > +#define GAOKUN_CCX_MASK              GENMASK(1, 0)
> > +#define GAOKUN_MUX_MASK              GENMASK(3, 2)
> > +
> > +#define GAOKUN_DPAM_MASK     GENMASK(3, 0)
> > +#define GAOKUN_HPD_STATE_MASK        BIT(4)
> > +#define GAOKUN_HPD_IRQ_MASK  BIT(5)
> > +
> > +#define CCX_TO_ORI(ccx) (++ccx % 3)
> > +
> > +#define GET_IDX(updt) (ffs(updt) - 1)
> > +
> > +/* Configuration Channel Extension */
> > +enum gaokun_ucsi_ccx {
> > +     USBC_CCX_NORMAL,
> > +     USBC_CCX_REVERSE,
> > +     USBC_CCX_NONE,
> > +};
> > +
> > +enum gaokun_ucsi_mux {
> > +     USBC_MUX_NONE,
> > +     USBC_MUX_USB_2L,
> > +     USBC_MUX_DP_4L,
> > +     USBC_MUX_USB_DP,
> > +};
> > +
> > +struct gaokun_ucsi_reg {
> > +     u8 port_num;
> > +     u8 port_updt;
> > +     u8 port_data[4];
> > +     u8 checksum;
> > +     u8 reserved;
> > +} __packed;
> > +
> > +struct gaokun_ucsi_port {
> > +     struct completion usb_ack;
> > +     spinlock_t lock;
> > +
> > +     struct gaokun_ucsi *ucsi;
> > +     struct auxiliary_device *bridge;
> > +
> > +     int idx;
> > +     enum gaokun_ucsi_ccx ccx;
> > +     enum gaokun_ucsi_mux mux;
> > +     u8 mode;
> > +     u16 svid;
> > +     u8 hpd_state;
> > +     u8 hpd_irq;
> > +};
> > +
> > +struct gaokun_ucsi {
> > +     struct gaokun_ec *ec;
> > +     struct ucsi *ucsi;
> > +     struct gaokun_ucsi_port *ports;
> > +     struct device *dev;
> > +     struct work_struct work;
> > +     struct notifier_block nb;
> > +     u16 version;
> > +     u8 port_num;
> > +};
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* For UCSI */
> > +
> > +static int gaokun_ucsi_read_version(struct ucsi *ucsi, u16 *version)
> > +{
> > +     struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> > +
> > +     *version = uec->version;
> > +
> > +     return 0;
> > +}
> > +
> > +static int gaokun_ucsi_read_cci(struct ucsi *ucsi, u32 *cci)
> > +{
> > +     struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> > +     u8 buf[GAOKUN_UCSI_READ_SIZE];
> > +     int ret;
> > +
> > +     ret = gaokun_ec_ucsi_read(uec->ec, buf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     memcpy(cci, buf, sizeof(*cci));
> > +
> > +     return 0;
> > +}
> > +
> > +static int gaokun_ucsi_read_message_in(struct ucsi *ucsi,
> > +                                    void *val, size_t val_len)
> > +{
> > +     struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> > +     u8 buf[GAOKUN_UCSI_READ_SIZE];
> > +     int ret;
> > +
> > +     ret = gaokun_ec_ucsi_read(uec->ec, buf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     memcpy(val, buf + GAOKUN_UCSI_CCI_SIZE,
> > +            min(val_len, GAOKUN_UCSI_DATA_SIZE));
> > +
> > +     return 0;
> > +}
> > +
> > +static int gaokun_ucsi_async_control(struct ucsi *ucsi, u64 command)
> > +{
> > +     struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> > +     u8 buf[GAOKUN_UCSI_WRITE_SIZE] = {};
> > +
> > +     memcpy(buf, &command, sizeof(command));
> > +
> > +     return gaokun_ec_ucsi_write(uec->ec, buf);
> > +}
> > +
> > +static void gaokun_ucsi_update_connector(struct ucsi_connector *con)
> > +{
> > +     struct gaokun_ucsi *uec = ucsi_get_drvdata(con->ucsi);
> > +
> > +     if (con->num > uec->port_num)
> > +             return;
> > +
> > +     con->typec_cap.orientation_aware = true;
> > +}
> > +
> > +static void gaokun_set_orientation(struct ucsi_connector *con,
> > +                                struct gaokun_ucsi_port *port)
> > +{
> > +     enum gaokun_ucsi_ccx ccx;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&port->lock, flags);
> > +     ccx = port->ccx;
> > +     spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +     typec_set_orientation(con->port, CCX_TO_ORI(ccx));
> > +}
> > +
> > +static void gaokun_ucsi_connector_status(struct ucsi_connector *con)
> > +{
> > +     struct gaokun_ucsi *uec = ucsi_get_drvdata(con->ucsi);
> > +     int idx;
> > +
> > +     idx = con->num - 1;
> > +     if (con->num > uec->port_num) {
> > +             dev_warn(uec->ucsi->dev, "set orientation out of range: con%d\n", idx);
> > +             return;
> > +     }
> > +
> > +     gaokun_set_orientation(con, &uec->ports[idx]);
> > +}
> > +
> > +const struct ucsi_operations gaokun_ucsi_ops = {
> > +     .read_version = gaokun_ucsi_read_version,
> > +     .read_cci = gaokun_ucsi_read_cci,
> > +     .read_message_in = gaokun_ucsi_read_message_in,
> > +     .sync_control = ucsi_sync_control_common,
> > +     .async_control = gaokun_ucsi_async_control,
> > +     .update_connector = gaokun_ucsi_update_connector,
> > +     .connector_status = gaokun_ucsi_connector_status,
> > +};
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* For Altmode */
> > +
> > +static void gaokun_ucsi_port_update(struct gaokun_ucsi_port *port,
> > +                                 const u8 *port_data)
> > +{
> > +     unsigned long flags;
> > +     u8 dcc, ddi;
> > +     int offset = port->idx * 2; /* every port has 2 Bytes data */
> > +
> > +     dcc = port_data[offset];
> > +     ddi = port_data[offset + 1];
>
> What is dcc and ddi? Are those just names from the DSDT?
>

Yes, DSDT's inventions. Huawei one uses that.

Some additional information, you can check the following in sc8280xp or
xelite based dsdt.

In UPAN(usbc pinassignment notification), PBUF carries a pan info, which
is a 8B data, {BPID, BORI, BMUX, BVID(2B), BSID(2B), BSSD} which stands for
port_id, orientation of port, mux state, USB-IF vendor id, USB-IF standard id,
I don't know the BSSD, (if linaro know something?)
but according to drivers/soc/qcom/pmic_glink_altmode.c
BSSD is related to pin assignment(mode field), hpd_state, hpd_irq, ddi is
something equivalent to BSSD. dcc is something equivalent to BORI and BMUX.


> > +
> > +     spin_lock_irqsave(&port->lock, flags);
> > +
> > +     port->ccx = FIELD_GET(GAOKUN_CCX_MASK, dcc);
> > +     port->mux = FIELD_GET(GAOKUN_MUX_MASK, dcc);
> > +     port->mode = FIELD_GET(GAOKUN_DPAM_MASK, ddi);
> > +     port->hpd_state = FIELD_GET(GAOKUN_HPD_STATE_MASK, ddi);
> > +     port->hpd_irq = FIELD_GET(GAOKUN_HPD_IRQ_MASK, ddi);
> > +
> > +     switch (port->mux) {
> > +     case USBC_MUX_NONE:
> > +             port->svid = 0;
> > +             break;
> > +     case USBC_MUX_USB_2L:
> > +             port->svid = USB_SID_PD;
> > +             break;
> > +     case USBC_MUX_DP_4L:
> > +     case USBC_MUX_USB_DP:
> > +             port->svid = USB_SID_DISPLAYPORT;
> > +             if (port->ccx == USBC_CCX_REVERSE)
> > +                     port->mode -= 6;
>
> I'd prefer it this were more explicit about what is happening.
>

If orientation is reverse, then we should minus 6, EC's logic.
I will add a comment for it. Actually, this field is unused, I don't
find the mux yet, so I cannot set it with this field. But I don't want
to make things imcomplete, so keep it.

Let me go off the topic, on my device, I can just use drm_aux_hpd_bridge_notify
to enable altmode, usb functions well after I pluged out, I don't need set mode
switch(orientation switch is required if orientation is reverse), which is quiet
similar to Acer aspire 1. Is mux controlled also by QMP combo phy(see [1])?

> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     spin_unlock_irqrestore(&port->lock, flags);
> > +}
> > +
> > +static int gaokun_ucsi_refresh(struct gaokun_ucsi *uec)
> > +{
> > +     struct gaokun_ucsi_reg ureg;
> > +     int ret, idx;
> > +
> > +     ret = gaokun_ec_ucsi_get_reg(uec->ec, (u8 *)&ureg);
> > +     if (ret)
> > +             return -EIO;
> > +
> > +     uec->port_num = ureg.port_num;
> > +     idx = GET_IDX(ureg.port_updt);
> > +
> > +     if (idx >= 0 && idx < ureg.port_num)
> > +             gaokun_ucsi_port_update(&uec->ports[idx], ureg.port_data);
> > +
> > +     return idx;
> > +}
> > +
> > +static void gaokun_ucsi_handle_altmode(struct gaokun_ucsi_port *port)
> > +{
> > +     struct gaokun_ucsi *uec = port->ucsi;
> > +     int idx = port->idx;
> > +
> > +     if (idx >= uec->ucsi->cap.num_connectors || !uec->ucsi->connector) {
> > +             dev_warn(uec->ucsi->dev, "altmode port out of range: %d\n", idx);
> > +             return;
> > +     }
> > +
> > +     /* UCSI callback .connector_status() have set orientation */
> > +     if (port->bridge)
> > +             drm_aux_hpd_bridge_notify(&port->bridge->dev,
> > +                                       port->hpd_state ?
> > +                                       connector_status_connected :
> > +                                       connector_status_disconnected);
>
> Does your platform report any altmodes? What do you see in
> /sys/class/typec/port0/port0.*/ ?
>

/sys/class/typec/port0/port0.0:
active  mode  mode1  power  svid  uevent  vdo

/sys/class/typec/port0/port0.1:
active  mode  mode1  power  svid  uevent  vdo

/sys/class/typec/port0/port0.2:
active  mode  mode1  power  svid  uevent  vdo

/sys/class/typec/port0/port0.3:
active  mode  mode2  power  svid  uevent  vdo

/sys/class/typec/port0/port0.4:
active  mode  mode3  power  svid  uevent  vdo


> > +
> > +     gaokun_ec_ucsi_pan_ack(uec->ec, port->idx);
> > +}
> > +
> > +static void gaokun_ucsi_altmode_notify_ind(struct gaokun_ucsi *uec)
> > +{
> > +     int idx;
> > +
> > +     idx = gaokun_ucsi_refresh(uec);
> > +     if (idx < 0)
> > +             gaokun_ec_ucsi_pan_ack(uec->ec, idx);
> > +     else
> > +             gaokun_ucsi_handle_altmode(&uec->ports[idx]);
> > +}
> > +
> > +/*
> > + * USB event is necessary for enabling altmode, the event should follow
> > + * UCSI event, if not after timeout(this notify may be disabled somehow),
> > + * then force to enable altmode.
> > + */
> > +static void gaokun_ucsi_handle_no_usb_event(struct gaokun_ucsi *uec, int idx)
> > +{
> > +     struct gaokun_ucsi_port *port;
> > +
> > +     port = &uec->ports[idx];
> > +     if (!wait_for_completion_timeout(&port->usb_ack, 2 * HZ)) {
> > +             dev_warn(uec->dev, "No USB EVENT, triggered by UCSI EVENT");
> > +             gaokun_ucsi_altmode_notify_ind(uec);
> > +     }
> > +}
> > +
> > +static int gaokun_ucsi_notify(struct notifier_block *nb,
> > +                           unsigned long action, void *data)
> > +{
> > +     u32 cci;
> > +     struct gaokun_ucsi *uec = container_of(nb, struct gaokun_ucsi, nb);
> > +
> > +     switch (action) {
> > +     case EC_EVENT_USB:
> > +             gaokun_ucsi_altmode_notify_ind(uec);
> > +             return NOTIFY_OK;
> > +
> > +     case EC_EVENT_UCSI:
> > +             uec->ucsi->ops->read_cci(uec->ucsi, &cci);
> > +             ucsi_notify_common(uec->ucsi, cci);
> > +             if (UCSI_CCI_CONNECTOR(cci))
> > +                     gaokun_ucsi_handle_no_usb_event(uec, UCSI_CCI_CONNECTOR(cci) - 1);
> > +
> > +             return NOTIFY_OK;
> > +
> > +     default:
> > +             return NOTIFY_DONE;
> > +     }
> > +}
> > +
> > +static int gaokun_ucsi_get_port_num(struct gaokun_ucsi *uec)
> > +{
> > +     struct gaokun_ucsi_reg ureg;
> > +     int ret;
> > +
> > +     ret = gaokun_ec_ucsi_get_reg(uec->ec, (u8 *)&ureg);
> > +
> > +     return ret ? 0 : ureg.port_num;
> > +}
> > +
> > +static int gaokun_ucsi_ports_init(struct gaokun_ucsi *uec)
> > +{
> > +     u32 port;
> > +     int i, ret, port_num;
> > +     struct device *dev = uec->dev;
> > +     struct gaokun_ucsi_port *ucsi_port;
> > +     struct fwnode_handle *fwnode;
> > +
> > +     port_num = gaokun_ucsi_get_port_num(uec);
> > +     uec->port_num = port_num;
> > +
> > +     uec->ports = devm_kzalloc(dev, port_num * sizeof(*(uec->ports)),
> > +                               GFP_KERNEL);
> > +     if (!uec->ports)
> > +             return -ENOMEM;
> > +
> > +     for (i = 0; i < port_num; ++i) {
> > +             ucsi_port = &uec->ports[i];
> > +             ucsi_port->ccx = USBC_CCX_NONE;
> > +             ucsi_port->idx = i;
> > +             ucsi_port->ucsi = uec;
> > +             init_completion(&ucsi_port->usb_ack);
> > +             spin_lock_init(&ucsi_port->lock);
> > +     }
> > +
> > +     device_for_each_child_node(dev, fwnode) {
> > +             ret = fwnode_property_read_u32(fwnode, "reg", &port);
> > +             if (ret < 0) {
> > +                     dev_err(dev, "missing reg property of %pOFn\n", fwnode);
> > +                     fwnode_handle_put(fwnode);
> > +                     return ret;
> > +             }
> > +
> > +             if (port >= port_num) {
> > +                     dev_warn(dev, "invalid connector number %d, ignoring\n", port);
> > +                     continue;
> > +             }
> > +
> > +             ucsi_port = &uec->ports[port];
> > +             ucsi_port->bridge = devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwnode));
> > +             if (IS_ERR(ucsi_port->bridge)) {
> > +                     fwnode_handle_put(fwnode);
> > +                     return PTR_ERR(ucsi_port->bridge);
> > +             }
> > +     }
> > +
> > +     for (i = 0; i < port_num; i++) {
> > +             if (!uec->ports[i].bridge)
> > +                     continue;
> > +
> > +             ret = devm_drm_dp_hpd_bridge_add(dev, uec->ports[i].bridge);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void gaokun_ucsi_register_worker(struct work_struct *work)
> > +{
> > +     struct gaokun_ucsi *uec;
> > +     struct ucsi *ucsi;
> > +     int ret;
> > +
> > +     uec = container_of(work, struct gaokun_ucsi, work);
> > +     ucsi = uec->ucsi;
> > +
> > +     ucsi->quirks = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_PDOS;
>
> Does it crash in the same way as GLINK crashes (as you've set
> UCSI_NO_PARTNER_PDOS)?
>

Yes, no partner can be detected, I checked. I think it is also handled by
the firmware As you said in [2]
> In some obscure cases (Qualcomm PMIC Glink) altmode is completely
> handled by the firmware. Linux does not get proper partner altmode info.

> > +
> > +     ssleep(3); /* EC can't handle UCSI properly in the early stage */
> > +
> > +     ret = gaokun_ec_register_notify(uec->ec, &uec->nb);
> > +     if (ret) {
> > +             dev_err_probe(ucsi->dev, ret, "notifier register failed\n");
> > +             return;
> > +     }
> > +
> > +     ret = ucsi_register(ucsi);
> > +     if (ret)
> > +             dev_err_probe(ucsi->dev, ret, "ucsi register failed\n");
> > +}
> > +
> > +static int gaokun_ucsi_register(struct gaokun_ucsi *uec)
>
> Please inline
>

I see.

Best wishes
Pengyu

[1] https://elixir.bootlin.com/linux/v6.12.5/source/drivers/phy/qualcomm/phy-qcom-qmp-combo.c#L2679
[2] https://lore.kernel.org/lkml/20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org

