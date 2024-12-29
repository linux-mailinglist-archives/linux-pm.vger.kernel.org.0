Return-Path: <linux-pm+bounces-19830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BAA9FDFDD
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7EA3A112C
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9543B192B95;
	Sun, 29 Dec 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij6oZCRc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017D2594B9;
	Sun, 29 Dec 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735489620; cv=none; b=KVj6F5aSXj5G7YBQpomKcOeUuatuMJXdiu+n02onBZH97hSxdS0UTiucQNZH5ryT4mwEVd9mRwTIHwOhENvTZafcpFl3pi3vp3b4Jc5CToH3gXqzQaNTmx3Xmm3w17xotfGrBFrQVRzt5cLXvYnZRyba6yXBA5LWicXJlvITeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735489620; c=relaxed/simple;
	bh=QTQ2jmtD+5gyI4gnNxwHyQgQFVSA0gS5B4GWPpZKgE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcJ4Fmmu61dJ64zEHWeAga6QEyT1vEbnWDKOGrtFZX4E8FquOUG2Cy6r68u5n5XFt4zF5TrN9MqBY+naAhTySG2QmB3ddhdcHw8zy8OpXG7DZJRcDvFAM+SJ61V7a8r+BiCqvoDDP1bNWjR3bXJj1YIg7DSxpJPAL78efTJMjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij6oZCRc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2156e078563so95601625ad.2;
        Sun, 29 Dec 2024 08:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735489618; x=1736094418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN4I76DkWVAlnSPrmZ4XdJoNZHn6QtqfD+5gzVW6f3I=;
        b=Ij6oZCRcV/RkI3okWQxIlZeQcnM75R5HzT87yXJdmh5bYSZ9RKs+gw9yBkSYkWKX2e
         WoWm/xneYVXsJTPN3UwctId4IWQKAcXhUc+znMxKsa7oUUoU3djmHnJR4JTVCDS5t9S/
         jnpeFZ//l18+jV1osx7YAkJTkQ9+DOTCVIkRXcSmiy0TMuzK/by8ChQr3X8yacY0a+XX
         5Tj+VcVoL6U3kLxLU8NjUmkpXJ0HmGD/iwTp55JXF+KOvGmI1WcXLfzGdRJUHRGB6cJz
         JJRoKrzeqAg+oMICIAvICyOK3OLVadZ8/V6zn1X4R2e6asAC+uC3VqZH0W3CrfduIzgJ
         mtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735489618; x=1736094418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN4I76DkWVAlnSPrmZ4XdJoNZHn6QtqfD+5gzVW6f3I=;
        b=SkCzMUVXoXnHZy1ltQrvGODXDfxCinG7SzxYrBURYi2mhn2/6a6G0b1HacVJ2ivf6k
         bmqD0bJfQPi8T9aR9lam42+aX+gB3mc5fYHPrqwquI2wY0kpcpc94czRP6li8Ep6SxdA
         BkGnScH7Rx7Bp8D38KHnpzU8VcIDfhTJK+CjvcuBtAbJPpScBbrD1mhVBeHfgvuDyFll
         GWeKzoeraXp0c90+97VdHfTWS9QhDjUExcu4I7vEiKJgJ4Wg1/h22QwN1pU+gVJZz9s7
         xse8ycznKdPSLxA77ocQaLlK28Konw8wJuMMc+WQuCrOvoKmBUoe+LyuO08WMTr/fpSm
         JiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNmXNL8bVFdGFk+KfiUiN4YOs4TonjRN14DGklM9Bd8IcBYe1UbPmD+U2DeKZds2k4l2PAK2F3xXIkMXcZ@vger.kernel.org, AJvYcCVrUa+okvpEEm0bOBigcP469f5EIMcLZKq6xe+e/RzP2+0axoTX9jzKOa8XkEX0jT/82xeAovSw6X4=@vger.kernel.org, AJvYcCW5gtYqh6iZoXGmnu3KBwbymSltdUIyMZbp8SSMmXA6Hg6dYkRM5wyek/cbNDDo/0WGcWGd6B3B3lgi6vlcUs0EgfiruA==@vger.kernel.org, AJvYcCWlhzqocqCz/Zy9eHu7QRTMJE/t3iSSkwow66xLgjRoegw5rnFCGyWLFvg6gfPyYvLPNgk/HT4HiKHu@vger.kernel.org, AJvYcCXlbWUEJein+9YTD9zeq2AqvpI8PsgKmWahUlXXvpwfJ+Y/5l+vnkeZrwVr7+D2RMaP4HKV03UdjOcX5oRMTw==@vger.kernel.org, AJvYcCXr6praJWZxv1QxNguUOa9WOuHCVZqCVgzHnxMUPMaV1skxhi6kWeJOAhNVUTapEs4VrarSwODslO0i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6uYo44TOYRJm1DWXPt3NvUbz4GbW8jAmLdk+Ntk/fB+yuRre
	AIDs3q/5XuOt3MC4+yCtXAzgQGpu3pVrlZtG4LXocBdCIb8pIpx9IVDzimVSzOAx4A==
X-Gm-Gg: ASbGnctvnSrPqgDHs/vjXJvFWE2aHD6Uw7AAgNcAe4nmm0iJyQrh7QFDFlyafS7KCXL
	RwTUqj8tZs32snp1SIlOcQUWFUmcrJ8bnwcY428i/ya4NGmjzZCsI5P9c3+BAOTRX8uCRJQkG9X
	+n4f2IOXRgLvW7QtNYxSdmAbZh79FNUOnV8azPR7VPTenUsH8Akzi+RSDi3IAcduf5y4z6zBETC
	aNXoVB7AchzxvixNm9BO1v5QtidT1Y6DdHGDUdAA08=
X-Google-Smtp-Source: AGHT+IHabVzCKVuk6NRsVfxpxbK6V/UiWH6CZXnEGKbkeotn7oJ8gVLThMcuJgUl7Adlw7NwkXO0qA==
X-Received: by 2002:a05:6a21:4986:b0:1e1:b1bb:87a0 with SMTP id adf61e73a8af0-1e606dfe60fmr33420104637.34.1735489617855;
        Sun, 29 Dec 2024 08:26:57 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad6cc885sm17795222b3a.0.2024.12.29.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2024 08:26:57 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: bryan.odonoghue@linaro.org
Cc: andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
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
Date: Mon, 30 Dec 2024 00:25:40 +0800
Message-ID: <20241229162540.95754-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <5310962f-c0d8-4ada-bb95-b727a3c88b00@linaro.org>
References: <5310962f-c0d8-4ada-bb95-b727a3c88b00@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Dec 29, 2024 at 10:52 PM Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
> On 28/12/2024 14:38, Pengyu Luo wrote:
> > On Sat, Dec 28, 2024 at 9:06 PM Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
> >> On 27/12/2024 17:13, Pengyu Luo wrote:
> >>> The Huawei Matebook E Go (sc8280xp) tablet provides implements UCSI
> >>> interface in the onboard EC. Add the glue driver to interface the
> >>> platform's UCSI implementation.
> >>>
> >>> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> >>> ---
> >>>    drivers/usb/typec/ucsi/Kconfig              |   9 +
> >>>    drivers/usb/typec/ucsi/Makefile             |   1 +
> >>>    drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 481 ++++++++++++++++++++
> >>>    3 files changed, 491 insertions(+)
> >>>    create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> >>>
> >>> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> >>> index 680e1b87b..0d0f07488 100644
> >>> --- a/drivers/usb/typec/ucsi/Kconfig
> >>> +++ b/drivers/usb/typec/ucsi/Kconfig
> >>> @@ -78,4 +78,13 @@ config UCSI_LENOVO_YOGA_C630
> >>>          To compile the driver as a module, choose M here: the module will be
> >>>          called ucsi_yoga_c630.
> >>>
> >>> +config UCSI_HUAWEI_GAOKUN
> >>> +     tristate "UCSI Interface Driver for Huawei Matebook E Go (sc8280xp)"
> >>> +     depends on EC_HUAWEI_GAOKUN
> >>> +     help
> >>> +       This driver enables UCSI support on the Huawei Matebook E Go tablet.
> >>> +
> >>> +       To compile the driver as a module, choose M here: the module will be
> >>> +       called ucsi_huawei_gaokun.
> >>> +
> >>>    endif
> >>> diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> >>> index aed41d238..0b400122b 100644
> >>> --- a/drivers/usb/typec/ucsi/Makefile
> >>> +++ b/drivers/usb/typec/ucsi/Makefile
> >>> @@ -22,3 +22,4 @@ obj-$(CONFIG_UCSI_CCG)                      += ucsi_ccg.o
> >>>    obj-$(CONFIG_UCSI_STM32G0)          += ucsi_stm32g0.o
> >>>    obj-$(CONFIG_UCSI_PMIC_GLINK)               += ucsi_glink.o
> >>>    obj-$(CONFIG_UCSI_LENOVO_YOGA_C630) += ucsi_yoga_c630.o
> >>> +obj-$(CONFIG_UCSI_HUAWEI_GAOKUN)     += ucsi_huawei_gaokun.o
> >>> diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> >>> new file mode 100644
> >>> index 000000000..84ed0407d
> >>> --- /dev/null
> >>> +++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> >>> @@ -0,0 +1,481 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * ucsi-huawei-gaokun - A UCSI driver for HUAWEI Matebook E Go (sc8280xp)
> >>> + *
> >>> + * reference: drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> >>> + *            drivers/usb/typec/ucsi/ucsi_glink.c
> >>> + *            drivers/soc/qcom/pmic_glink_altmode.c
> >>> + *
> >>> + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> >>> + */
> >>> +
> >>> +#include <linux/auxiliary_bus.h>
> >>> +#include <linux/bitops.h>
> >>> +#include <linux/completion.h>
> >>> +#include <linux/container_of.h>
> >>> +#include <linux/delay.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/notifier.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/string.h>
> >>> +#include <linux/workqueue_types.h>
> >>> +
> >>> +#include <linux/usb/pd_vdo.h>
> >>> +#include <drm/bridge/aux-bridge.h
> >>
> >> Is there a reason you don't have strict include alphanumeric ordering here ?
> >>
> >
> > These two is dp/alt mode related, so listing them out. Above of them are
> > general things.
>
> OK. Unless there's an include dependency reason you need to, please just
> sort the headers alphanumerically in order
>
> #include <globals_first>
> #include <globals_first_alpha>
>
> #include "locals_next"
> #include "locals_next_alpha_also"
>

I will follow this in v2.

> >>>
> >>> +
> >>> +#include "ucsi.h"
> >>> +#include <linux/platform_data/huawei-gaokun-ec.h>
> >>> +
> >>> +
> >>> +#define EC_EVENT_UCSI        0x21
> >>> +#define EC_EVENT_USB 0x22
> >>> +
> >>> +#define GAOKUN_CCX_MASK              GENMASK(1, 0)
> >>> +#define GAOKUN_MUX_MASK              GENMASK(3, 2)
> >>> +
> >>> +#define GAOKUN_DPAM_MASK     GENMASK(3, 0)
> >>> +#define GAOKUN_HPD_STATE_MASK        BIT(4)
> >>> +#define GAOKUN_HPD_IRQ_MASK  BIT(5)
> >>> +
> >>> +#define CCX_TO_ORI(ccx) (++ccx % 3)
> >>
> >> Why do you increment the value of the enum ?
> >> Seems strange.
> >>
> >
> > EC's logic, it is just a trick. Qualcomm maps
> > 0 1 2 to normal, reverse, none(no device insert)
> > typec lib maps 1 2 0 to that.
>
> I'd suggest making the trick much more obvious.
>
> Either with a comment or just mapping 1:1 between EC and Linux' view of
> this data.
>
> The main reason for that is to make it easier to
> read/understand/maintain/debug.
>

I got it

>
>
> >>> +             port->svid = USB_SID_DISPLAYPORT;
> >>> +             if (port->ccx == USBC_CCX_REVERSE)
> >>> +                     port->mode -= 6;
> >>
> >> why minus six ?
> >> needs a comment.
> >>
> >
> > EC's logic. I don't know why, it is a quirk from Qualcomm or Huawei.
> > I will mention this.
>
> Instead of hard-coding a mapping between the EC's mode and Linux' UCSI
> enum - just make a define or an inline, ideally something with
>
> switch(port->mode)
> case GOAKUN_MODE_0:
> 	val = LINUX_UCSI_MODE_X;
> case GOAKUN_MODE_1:
> 	val = LINUX_UCSI_MODE_Y;
> }
>
> That will make the mapping obvious and also ensure both to yourself and
> to your reviewers that you have accounted for _all_ of the potential
> mappings and if those mappings don't exist then the default: of your
> switch statement should make some noise about it
>
> dev_err(dev, "GOKUN UCSI mode %d unmapped\n"); or something like that.
>

Makes sense

>
> >
> >>> +             break;
> >>> +     default:
> >>> +             break;
> >>> +     }
> >>> +
> >>> +     spin_unlock_irqrestore(&port->lock, flags);
> >>> +}
> >>> +
> >>> +static int gaokun_ucsi_refresh(struct gaokun_ucsi *uec)
> >>> +{
> >>> +     struct gaokun_ucsi_reg ureg;
> >>> +     int ret, idx;
> >>> +
> >>> +     ret = gaokun_ec_ucsi_get_reg(uec->ec, (u8 *)&ureg);
> >>> +     if (ret)
> >>> +             return -EIO;
> >>> +
> >>> +     uec->port_num = ureg.port_num;
> >>> +     idx = GET_IDX(ureg.port_updt);
> >>> +
> >>> +     if (idx >= 0 && idx < ureg.port_num)
> >>> +             gaokun_ucsi_port_update(&uec->ports[idx], ureg.port_data);
> >>
> >> Since you are checking the validity of the index, you should -EINVAL if
> >> the index is out of range.
> >>
> >
> > EC / pmic glink encode every port in a bit
> > 0/1/2/4/... => ???/left/right/some port
> >
> > I remap it to -1/0/1/2, to access specific port exceptions(-1) are not
> > harmful, later in gaokun_ucsi_altmode_notify_ind
> >
> >       if (idx < 0)
> >               gaokun_ec_ucsi_pan_ack(uec->ec, idx);
> >       else
> >               gaokun_ucsi_handle_altmode(&uec->ports[idx]);
> >
> > gaokun_ec_ucsi_pan_ack can handle exceptions.
> >
>
> gaokun_ucsi_refresh() can return
>
> -EIO
> -1
> >=0
>
> Where -EIO and -1 both trigger gaokun_ec_ucsi_pan_ack() in
> gaokun_ucsi_altmode_notify_ind()
>
> So if the index doesn't matter and < 0 => pan_ack() is OK or -EIO is not
> returning meaningful error.
>
> Either way strongly advise against mixing a negative index as having a
> valid meaning with actual -E error codes...
>
> As a reviewer doing a fist-pass this looks suspicous and implies more
> thought/refinement should be done to the flow.
>

Agree, I will drop -EIO to use -1 instead, and define -1 as NO_UPDATE.
It is also resonable when there is a EC transaction error.

Best wishes,
Pengyu

