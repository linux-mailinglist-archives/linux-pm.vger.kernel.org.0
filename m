Return-Path: <linux-pm+bounces-19809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947619FDACB
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 14:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3793A1387
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 13:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5315B547;
	Sat, 28 Dec 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrCVK2cR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22676AA1;
	Sat, 28 Dec 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735393949; cv=none; b=AqZNTz15QgptjGkcCzrvPZbjSouaDNZYbqxF+t6u+xdrK0GMLpo1xDW7YZJUOgDvQ+vFLZss0XM8fGWyuPf/CseIs74WxAh+pEahgxpMdWblywxhvOFortrGGzxwwQi1dRhRgIoNS5Ia8WJ5QxJ7vZEdBzInMG2B4SpMpKUyTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735393949; c=relaxed/simple;
	bh=yaVmS5eBtyu65HqjoYLyjrrgU21NrbyB9+jPJ0B+sKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdRRb4TaIb30jg8+dlCMYSYJKC3ZTq3jqHGS94VlO0WNgsUj9+N1XT7TQ/tQKkIbxElVgHpq21Hd2B8spfS536ki+NHyDSIwadifb0StGoz8k2IJCXQ80QqepIXVbpaxt/R6KGgTM5LhicT4+a1VUrziwXelgpZLMbHcvw7iRNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrCVK2cR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2156e078563so88318985ad.2;
        Sat, 28 Dec 2024 05:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735393945; x=1735998745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oPIS3ly3ihr7PVbCw9YwRZQnyXKLJGz/dypLY5NAWs=;
        b=UrCVK2cRK/8E8WhJby/mjWR98v49AeVXzB+R17WekzFtsW4rn0h2nbNGCTXYHiJGi3
         RQklD5zupo0lSafGQvDU8/E7RLTM8wUjeRtVzmXfhQTMS4A8Ir83kzl++37hxm35Kpbv
         jHTkOjBOdphlX8UM4FijLkYHQgvMznNSrL14eqq0bVuy0OEh6A7xo/TuqkFILtWM2D+6
         ul0JWzxkuIov8PAhlkfOZehDUakFA+epcRN5aZg1EPQC8NEI56JsUg1a91E0Lm8ITwvS
         6DLh3nYKUYu9dRkQmu/GyO9hZNcj5NmQWi3yQ7i0D7E5aLmd4q6gfz4eSZbJx/kq/mKO
         IHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735393945; x=1735998745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oPIS3ly3ihr7PVbCw9YwRZQnyXKLJGz/dypLY5NAWs=;
        b=DXf3kgmxpVw4Pi2dGEm7W/8fTJYNzpnlApnxVnc9wOSzMM7KFg1EFp7xzU5oFod4y8
         hJeZY0tzCj7VKpEWv7MuAhYGvz/gAvRmoncm1/SLbU5eTr5uPQ9i8ZvVvswI6xCml/88
         xUGZzTmd0EZxHSSR3+w/pyBTtIfJvL+WQBpz1S5v0CjWqZr8p3kLLOu1ehMYKjUfmjYI
         2gpPpNuYS7EkpvTUV9Olf5q2Qxo7na//D2uiIBXsuUsaRSYvXAmwSoO9VALsaWi0wR/c
         6omhejN4biG7A1Y8CGgFi+pTdlKkIdR0QLU57orLHTlqAVUzxbyZg9xHGPJobsOxGVxD
         zetw==
X-Forwarded-Encrypted: i=1; AJvYcCVHc8k0cbkuYierIQDMdsAsrEsqEiGVswWZC51VGnRJXwNX3Qpjqey2a4X1SfRze69fq+BMDJljBazMnPIW@vger.kernel.org, AJvYcCVN/Kr2f8IrzLebT7FXPxmUJdGPCYtbGTJDKnyV/8z/v3CKdZQGkhlVwgJ2gHvEiC4+EJobwiqQh6Rn@vger.kernel.org, AJvYcCVVYc++jFsJL+60cVFuuG7mli236qabMk+S7Psaog9YhoZjAMMfa/N6U8cMRH56bFzhG8eh+EQLPyY=@vger.kernel.org, AJvYcCWGqxzAlrxpNanth9T+57EAmxX4qkj6wlQYQGUIFdNooN1nJmgyxbQaawUGTryg2gM7HggeBmiRcxnZ@vger.kernel.org, AJvYcCXCvLvPXsvN13fLlhUnREnAvbaZTYpDdJZlXqibqkgI86gYJlFI4EYKaq4GJILPf8LlkMOnFU8j9oTpZhv607VTd41rQQ==@vger.kernel.org, AJvYcCXQfGkUormtzAzdrqTOiKBokzk+8VNCydErVE+OnFwkOrDeSHUwai67WpRCqIfqTqekDUY6GzNykeM976u+nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUPgDdx6dMwFumv8puhk+EGEnoC44FHlYeA2xyGaSD3Wx5iP7
	K8121kD+0Q9uHs85k7vOnOGNfX1mvDZ2dg2mD7S1RA6oDJ6wa+x+DpZmxseMMSgFyv/t
X-Gm-Gg: ASbGnctb7lhWuCNfiLY51TuDTWOzbRRJHyBc5Fo/YvnThimEJcgIqFNSIxi2Rsxa+gB
	G4oXxk9aCU8iCddL0uQUDK49vpKUxZAhY/LqlGt/2Ads5/+PGE0abjGLQm3iByqhmV67zgSFaHc
	b4lRuUx3r6/3SVXlEt186O9gys7Fdilof4QwkmoM8s1lNsXPnxiRKsRSsrtFlccg0v1Kig7Xr36
	LiTT7mShBDRSX65w188VdC+3xHzuKSO/ZTogYxgTXc=
X-Google-Smtp-Source: AGHT+IHW+vEU7BCvFsarOIm6iKBZuQ2lunDWFVHw4HmhE8I+1vWdVxoaL+G0BJLkg6Qv8A+/PqD5Qg==
X-Received: by 2002:a17:903:11cf:b0:216:4cc2:b1e0 with SMTP id d9443c01a7336-219e6e9df19mr429772405ad.20.1735393944607;
        Sat, 28 Dec 2024 05:52:24 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f6922sm151355795ad.223.2024.12.28.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 05:52:24 -0800 (PST)
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
Subject: Re: [PATCH 2/5] platform: arm64: add Huawei Matebook E Go (sc8280xp) EC driver
Date: Sat, 28 Dec 2024 21:51:06 +0800
Message-ID: <20241228135107.608204-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <597a3374-311c-45e7-8c3b-8d9a18a20062@linaro.org>
References: <597a3374-311c-45e7-8c3b-8d9a18a20062@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Dec 28, 2024 at 8:33 PM Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
> On 27/12/2024 17:13, Pengyu Luo wrote:
> > There are 3 variants, Huawei released first 2 at the same time.
>
> There are three variants of which Huawei released the first two
> simultaneously.
>

You have mentioned many grammar and code issues.
So I explain something, I taught myself C, writing code is just my hobby.
I am also not a native speaker, I have never lived in an English
environment. Sometime I may use inappropriate words to express. I try my
best to express my idea clearly. I hope you can understand.

> > Huawei Matebook E Go LTE(sc8180x), codename should be gaokun2.
> > Huawei Matebook E Go(sc8280xp@3.0GHz), codename is gaokun3.
>
> Choose either "codename should be" or "codename is"
>
> > Huawei Matebook E Go 2023(sc8280xp@2.69GHz).
>
> Maybe say here "codename unknown"
>

should be, I want to express I am guessing.
I guess the last one is also gaokun3. But anyways, this driver works
for the latter two.

> > Adding support for the latter two variants for now, this driver should
> > also work for the sc8180x variant according to acpi table files, but I
> > don't have the device yet.
> >
> > Different from other Qualcomm Snapdragon sc8280xp based machines, the
> > Huawei Matebook E Go uses an embedded controller while others use
> > something called pmic glink. This embedded controller can be used to
> > perform a set of various functions, including, but not limited:
>
> "but not limited to":
>
> > - Battery and charger monitoring;
> > - Charge control and smart charge;
> > - Fn_lock settings;
> > - Tablet lid status;
> > - Temperature sensors;
> > - USB Type-C notifications (ports orientation,  DP alt mode HPD);
> > - USB Type-C PD (according to observation, up to 48w).
> >
> > Add the driver for the EC, that creates devices for UCSI, wmi and power
> > supply devices.
>
> I'm a terrible man for the "," dropped all about the place but you're
> going too mad with the commans there ->
>
> "Add a driver for the EC which creates devices for UCSI, WMI and power
> supply devices"
>

This was copied from C630 patches, replaced with my devices.

> >
> > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > ---
> >   drivers/platform/arm64/Kconfig                |  19 +
> >   drivers/platform/arm64/Makefile               |   2 +
> >   drivers/platform/arm64/huawei-gaokun-ec.c     | 598 ++++++++++++++++++
> >   drivers/platform/arm64/huawei-gaokun-wmi.c    | 283 +++++++++
> >   .../linux/platform_data/huawei-gaokun-ec.h    |  90 +++
> >   5 files changed, 992 insertions(+)
> >   create mode 100644 drivers/platform/arm64/huawei-gaokun-ec.c
> >   create mode 100644 drivers/platform/arm64/huawei-gaokun-wmi.c
> >   create mode 100644 include/linux/platform_data/huawei-gaokun-ec.h
> >
> > diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> > index f88395ea3..eb7fbacf0 100644
> > --- a/drivers/platform/arm64/Kconfig
> > +++ b/drivers/platform/arm64/Kconfig
> > @@ -33,6 +33,25 @@ config EC_ACER_ASPIRE1
> >         laptop where this information is not properly exposed via the
> >         standard ACPI devices.
> >
> > +config EC_HUAWEI_GAOKUN
> > +     tristate "Huawei Matebook E Go (sc8280xp) Embedded Controller driver"
>
> Krzysztof already mentioned this but the "sc8280xp" is questionable, you
> should probably drop mention of qcom and sc8280xp from your compat and
> tristate here.
>

Agree, how about using sc8280xp-based for tristate?

> > +     depends on ARCH_QCOM || COMPILE_TEST
> > +     depends on I2C
> > +     depends on DRM
> > +     depends on POWER_SUPPLY
> > +     depends on INPUT
> > +     help
> > +       Say Y here to enable the EC driver for Huawei Matebook E Go 2in1
> > +       tablet. The driver handles battery(information, charge control) and
> > +       USB Type-C DP HPD events as well as some misc functions like the lid
> > +       sensor and temperature sensors, etc.
> > +
> > +       This driver provides battery and AC status support for the mentioned
> > +       laptop where this information is not properly exposed via the
> > +       standard ACPI devices.
> > +
> > +       Say M or Y here to include this support.
>
> OTOH the help text is where you could mention the sc8280xp class of
> laptops/tablets.
>

I see

> > +
> >   config EC_LENOVO_YOGA_C630
> >       tristate "Lenovo Yoga C630 Embedded Controller driver"
> >       depends on ARCH_QCOM || COMPILE_TEST
> > diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
> > index b2ae9114f..ed32ad6c0 100644
> > --- a/drivers/platform/arm64/Makefile
> > +++ b/drivers/platform/arm64/Makefile
> > @@ -6,4 +6,6 @@
> >   #
> >
> >   obj-$(CONFIG_EC_ACER_ASPIRE1)       += acer-aspire1-ec.o
> > +obj-$(CONFIG_EC_HUAWEI_GAOKUN)       += huawei-gaokun-ec.o
> > +obj-$(CONFIG_EC_HUAWEI_GAOKUN)       += huawei-gaokun-wmi.o
> >   obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
> > diff --git a/drivers/platform/arm64/huawei-gaokun-ec.c b/drivers/platform/arm64/huawei-gaokun-ec.c
> > new file mode 100644
> > index 000000000..c1c657f7b
> > --- /dev/null
> > +++ b/drivers/platform/arm64/huawei-gaokun-ec.c
> > @@ -0,0 +1,598 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * huawei-gaokun-ec - An EC driver for HUAWEI Matebook E Go (sc8280xp)
> > + *
> > + * reference: drivers/platform/arm64/acer-aspire1-ec.c
> > + *            drivers/platform/arm64/lenovo-yoga-c630.c
> > + *
> > + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/notifier.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/version.h>
> > +
> > +#include <linux/platform_data/huawei-gaokun-ec.h>
> > +
> > +#define EC_EVENT             0x06
> > +
> > +/* Also can be found in ACPI specification 12.3 */
> > +#define EC_READ                      0x80
> > +#define EC_WRITE             0x81
>
> Is this odd indentation ?
>

No, apply it then check the source, it is normal.

> > +#define EC_BURST             0x82
> > +#define EC_QUERY             0x84
> > +
> > +
> > +#define EC_EVENT_LID         0x81
> > +
> > +#define EC_LID_STATE         0x80
> > +#define EC_LID_OPEN          BIT(1)
> > +
> > +#define UCSI_REG_SIZE                7
> > +
> > +/* for tx, command sequences are arranged as
> > + * {master_cmd, slave_cmd, data_len, data_seq}
> > + */
> > +#define REQ_HDR_SIZE         3
> > +#define INPUT_SIZE_OFFSET    2
> > +#define INPUT_DATA_OFFSET    3
> > +
> > +/* for rx, data sequences are arranged as
> > + * {status, data_len(unreliable), data_seq}
> > + */
> > +#define RESP_HDR_SIZE                2
> > +#define DATA_OFFSET          2
> > +
> > +
> > +struct gaokun_ec {
> > +     struct i2c_client *client;
> > +     struct mutex lock;
> > +     struct blocking_notifier_head notifier_list;
> > +     struct input_dev *idev;
> > +     bool suspended;
> > +};
> > +
> > +static int gaokun_ec_request(struct gaokun_ec *ec, const u8 *req,
> > +                          size_t resp_len, u8 *resp)
> > +{
> > +     struct i2c_client *client = ec->client;
> > +     struct i2c_msg msgs[2] = {
> > +             {
> > +                     .addr = client->addr,
> > +                     .flags = client->flags,
> > +                     .len = req[INPUT_SIZE_OFFSET] + REQ_HDR_SIZE,
> > +                     .buf = req,
> > +             }, {
> > +                     .addr = client->addr,
> > +                     .flags = client->flags | I2C_M_RD,
> > +                     .len = resp_len,
> > +                     .buf = resp,
> > +             },
> > +     };
> > +
> > +     mutex_lock(&ec->lock);
> > +
> > +     i2c_transfer(client->adapter, msgs, 2);
> > +     usleep_range(2000, 2500);
>
> What is this sleep about and why are you doing it inside of a critical
> section ?
>

Have a break between 2 transaction. This sleep happens in acpi code, also
inside a critical region. I rearrange it. We can sleep when using mutex
lock instead of spinlock.

Local7 = Acquire (\_SB.IC16.MUEC, 0x03E8)
...
read ops
...
Sleep (0x02)
...
write ops
...
Release (\_SB.IC16.MUEC)

> > +
> > +     mutex_unlock(&ec->lock);
> > +
> > +     return *resp;
> > +}
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Common API */
> > +
> > +/**
> > + * gaokun_ec_read - read from EC
> > + * @ec: The gaokun_ec
> > + * @req: The sequence to request
> > + * @resp_len: The size to read
> > + * @resp: Where the data are read to
> > + *
> > + * This function is used to read data after writing a magic sequence to EC.
> > + * All EC operations dependent on this functions.
>
> depend on this
>

mistyping

> > + *
> > + * Huawei uses magic sequences everywhere to complete various functions, all
> > + * these sequences are passed to ECCD(a ACPI method which is quiet similar
> > + * to gaokun_ec_request), there is no good abstraction to generalize these
> > + * sequences, so just wrap it for now. Almost all magic sequences are kept
> > + * in this file.
> > + */
> > +int gaokun_ec_read(struct gaokun_ec *ec, const u8 *req,
> > +                size_t resp_len, u8 *resp)
> > +{
> > +     return gaokun_ec_request(ec, req, resp_len, resp);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_read);
> > +
> > +/**
> > + * gaokun_ec_write - write to EC
> > + * @ec: The gaokun_ec
> > + * @req: The sequence to request
> > + *
> > + * This function has no big difference from gaokun_ec_read. When caller care
> > + * only write status and no actual data are returnd, then use it.
> > + */
> > +int gaokun_ec_write(struct gaokun_ec *ec, u8 *req)
> > +{
> > +     u8 resp[RESP_HDR_SIZE];
> > +
> > +     return gaokun_ec_request(ec, req, sizeof(resp), resp);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_write);
> > +
> > +int gaokun_ec_read_byte(struct gaokun_ec *ec, u8 *req, u8 *byte)
> > +{
> > +     int ret;
> > +     u8 resp[RESP_HDR_SIZE + sizeof(*byte)];
> > +
> > +     ret = gaokun_ec_read(ec, req, sizeof(resp), resp);
> > +     *byte = resp[DATA_OFFSET];
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_read_byte);
> > +
> > +int gaokun_ec_register_notify(struct gaokun_ec *ec, struct notifier_block *nb)
> > +{
> > +     return blocking_notifier_chain_register(&ec->notifier_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_register_notify);
> > +
> > +void gaokun_ec_unregister_notify(struct gaokun_ec *ec, struct notifier_block *nb)
> > +{
> > +     blocking_notifier_chain_unregister(&ec->notifier_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_unregister_notify);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* API For PSY */
> > +
> > +int gaokun_ec_psy_multi_read(struct gaokun_ec *ec, u8 reg,
> > +                          size_t resp_len, u8 *resp)
> > +{
> > +     int i, ret;
> > +     u8 _resp[RESP_HDR_SIZE + 1];
> > +     u8 req[REQ_HDR_SIZE + 1] = {0x02, EC_READ, 1, };
>
> Instead of constructing your packet inline like this, suggest a
> dedicated function to construct a request packet.
>
> For example 1 @ INPUT_SIZE_OFFSET => the size of data a dedicated
> function will make the "stuffing" of the request frame more obvious to
> readers and make the construction of packets less error prone.
>

I will try to do it, but there are many magic sequences in any size, I
need pass them anyways.

> > +
> > +     for (i = 0; i < resp_len; ++i) {
> > +             req[INPUT_DATA_OFFSET] = reg++;
> > +             ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> > +             if (ret)
> > +                     return -EIO;
> > +             resp[i] = _resp[DATA_OFFSET];
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_psy_multi_read);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* API For WMI */
> > +
> > +/* Battery charging threshold */
> > +int gaokun_ec_wmi_get_threshold(struct gaokun_ec *ec, u8 *value, int ind)
> > +{
> > +     /* GBTT */
> > +     return gaokun_ec_read_byte(ec, (u8 []){0x02, 0x69, 1, ind}, value);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_threshold);
> > +
> > +int gaokun_ec_wmi_set_threshold(struct gaokun_ec *ec, u8 start, u8 end)
> > +{
> > +     /* SBTT */
> > +     int ret;
> > +     u8 req[REQ_HDR_SIZE + 2] = {0x02, 0x68, 2, 3, 0x5a};
> > +
> > +     ret = gaokun_ec_write(ec, req);
> > +     if (ret)
> > +             return -EIO;
> > +
> > +     if (start == 0 && end == 0)
> > +             return -EINVAL;
> > +
> > +     if (start >= 0 && start <= end && end <= 100) {
>
> if start >= 0
>
> is redundant no ? start is a u8 it can _only_ be >= 0 ..
>

Yeah, this code was written with int. Later, I used u8 since one byte is
convenient for EC transaction(we don't need clear other 3 Bytes). After
chaging, I forgot to revaluate it.

>
> > +             req[INPUT_DATA_OFFSET] = 1;
> > +             req[INPUT_DATA_OFFSET + 1] = start;
> > +             ret = gaokun_ec_write(ec, req);
> > +             if (ret)
> > +                     return -EIO;
> > +
> > +             req[INPUT_DATA_OFFSET] = 2;
> > +             req[INPUT_DATA_OFFSET + 1] = end;
>
> again a function to construct a packet gets you out of the business of
> inlining and "just knowing" which offset is which within any give
> function which indexes an array.
>
> > +             ret = gaokun_ec_write(ec, req);
> > +     } else {
> > +             return -EINVAL;
> > +     }
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_threshold);
> > +
> > +/* Smart charge param */
> > +int gaokun_ec_wmi_get_smart_charge_param(struct gaokun_ec *ec, u8 *value)
> > +{
> > +     /* GBAC */
> > +     return gaokun_ec_read_byte(ec, (u8 []){0x02, 0xE6, 0}, value);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_smart_charge_param);
> > +
> > +int gaokun_ec_wmi_set_smart_charge_param(struct gaokun_ec *ec, u8 value)
> > +{
> > +     /* SBAC */
> > +     if (value < 0 || value > 2)
>
> value < 0 can never be true
>
> > +             return -EINVAL;
> > +
> > +     return gaokun_ec_write(ec, (u8 []){0x02, 0xE5, 1, value});
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_smart_charge_param);
> > +
> > +/* Smart charge */
> > +int gaokun_ec_wmi_get_smart_charge(struct gaokun_ec *ec,
> > +                                u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE])
> > +{
> > +     /* GBCM */
> > +     u8 req[REQ_HDR_SIZE] = {0x02, 0xE4, 0};
> > +     u8 resp[RESP_HDR_SIZE + 4];
> > +     int ret;
> > +
> > +     ret = gaokun_ec_read(ec, req, sizeof(resp), resp);
> > +     if (ret)
> > +             return -EIO;
> > +
> > +     data[0] = resp[DATA_OFFSET];
> > +     data[1] = resp[DATA_OFFSET + 1];
> > +     data[2] = resp[DATA_OFFSET + 2];
> > +     data[3] = resp[DATA_OFFSET + 3];
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_smart_charge);
> > +
> > +int gaokun_ec_wmi_set_smart_charge(struct gaokun_ec *ec,
> > +                                u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE])
> > +{
> > +     /* SBCM */
> > +     u8 req[REQ_HDR_SIZE + GAOKUN_SMART_CHARGE_DATA_SIZE] = {0x02, 0XE3, 4,};
> > +
> > +     if (!(data[2] >= 0 && data[2] <= data[3] && data[3] <= 100))
> > +             return -EINVAL;
>
> Repeat of the clause above which was checking u8 >= 0 for the same
> values in the rest of the clause - including checking <= 100.
>
> Certainly a candidate for functional decomposition, inline function or a
> define.
>
> > +
> > +     memcpy(req + INPUT_DATA_OFFSET, data, GAOKUN_SMART_CHARGE_DATA_SIZE);
> > +
> > +     return gaokun_ec_write(ec, req);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_smart_charge);
> > +
> > +/* Fn lock */
> > +int gaokun_ec_wmi_get_fn_lock(struct gaokun_ec *ec, u8 *on)
> > +{
> > +     /* GFRS */
> > +     int ret;
> > +     u8 val;
> > +     u8 req[REQ_HDR_SIZE] = {0x02, 0x6B, 0};
>
> Reverse Christmas tree
>
> u8 req[REQ_HDR_SIZE];
> int ret;
> u8 val;
>
> Not required but nice to look at.
>

Agree

> > +
> > +     ret = gaokun_ec_read_byte(ec, req, &val);
> > +     if (val == 0x55)
> > +             *on = 0;
> > +     else if (val == 0x5A)
> > +             *on = 1;
> > +     else
> > +             return -EIO;
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_fn_lock);
> > +
> > +int gaokun_ec_wmi_set_fn_lock(struct gaokun_ec *ec, u8 on)
> > +{
> > +     /* SFRS */
> > +     u8 req[REQ_HDR_SIZE + 1] = {0x02, 0x6C, 1,};
> > +
> > +     if (on == 0)
> > +             req[INPUT_DATA_OFFSET] = 0x55;
> > +     else if (on == 1)
> > +             req[INPUT_DATA_OFFSET] = 0x5A;
> > +     else
> > +             return -EINVAL;
>
> Why not use a bool for on ?
>

Yes, we can.

> > +
> > +     return gaokun_ec_write(ec, req);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_fn_lock);
> > +
> > +/* Thermal Zone */
> > +/* Range from 0 to 0x2C, partial valid */
> > +static const u8 temp_reg[] = {0x05, 0x07, 0x08, 0x0E, 0x0F, 0x12, 0x15, 0x1E,
> > +                           0x1F, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26,
> > +                           0x27, 0x28, 0x29, 0x2A};
> > +
> > +int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 temp[GAOKUN_TZ_REG_NUM])
>
> int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 *temp, size_t
> temp_reg_num)
>
>
> > +{
> > +     /* GTMP */
> > +     u8 req[REQ_HDR_SIZE] = {0x02, 0x61, 1,};
> > +     u8 resp[RESP_HDR_SIZE + sizeof(s16)];
> > +     int ret, i = 0;
> > +
> > +     while (i < GAOKUN_TZ_REG_NUM) {
> while (i < temp_reg_num)
>

It is a constant. But later, as Krzysztof suggested, I will use interfaces
from hwmon, then reading one at a time.

> > +             req[INPUT_DATA_OFFSET] = temp_reg[i];
> > +             ret = gaokun_ec_read(ec, req, sizeof(resp), resp);
> > +             if (ret)
> > +                     return -EIO;
> > +             temp[i++] = *(s16 *)(resp + DATA_OFFSET);
>
> What's the point of the casting here ?
>
> memcpy(temp, resp, sizeof(s16));
> temp++;
>

A 2Bytes symbol number in little endian, ec return it like this, so
casting.

> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_temp);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* API For UCSI */
> > +
> > +int gaokun_ec_ucsi_read(struct gaokun_ec *ec,
> > +                     u8 resp[GAOKUN_UCSI_READ_SIZE])
> > +{
> > +     u8 req[REQ_HDR_SIZE] = {0x3, 0xD5, 0};
> > +     u8 _resp[RESP_HDR_SIZE + GAOKUN_UCSI_READ_SIZE];
> > +     int ret;
> > +
> > +     ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     memcpy(resp, _resp + DATA_OFFSET, GAOKUN_UCSI_READ_SIZE);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_read);
> > +
> > +int gaokun_ec_ucsi_write(struct gaokun_ec *ec,
> > +                      const u8 req[GAOKUN_UCSI_WRITE_SIZE])
> > +{
> > +     u8 _req[REQ_HDR_SIZE + GAOKUN_UCSI_WRITE_SIZE];
> > +
> > +     _req[0] = 0x03;
> > +     _req[1] = 0xD4;
> > +     _req[INPUT_SIZE_OFFSET] = GAOKUN_UCSI_WRITE_SIZE;
> > +     memcpy(_req + INPUT_DATA_OFFSET, req, GAOKUN_UCSI_WRITE_SIZE);
> > +
> > +     return gaokun_ec_write(ec, _req);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_write);
> > +
> > +int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec, u8 *ureg)
> > +{
> > +     u8 req[REQ_HDR_SIZE] = {0x03, 0xD3, 0};
> > +     u8 _resp[RESP_HDR_SIZE + UCSI_REG_SIZE];
> > +     int ret;
> > +
> > +     ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     memcpy(ureg, _resp + DATA_OFFSET, UCSI_REG_SIZE);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_get_reg);
> > +
> > +int gaokun_ec_ucsi_pan_ack(struct gaokun_ec *ec, int port_id)
> > +{
> > +     u8 req[REQ_HDR_SIZE + 1] = {0x03, 0xD2, 1, 0};
> > +
> > +     if (port_id >= 0)
> > +             req[INPUT_DATA_OFFSET] = 1 << port_id;
> > +
> > +     return gaokun_ec_write(ec, req);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_pan_ack);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Modern Standby */
> > +
> > +static int gaokun_ec_suspend(struct device *dev)
> > +{
> > +     struct gaokun_ec *ec = dev_get_drvdata(dev);
> > +     u8 req[REQ_HDR_SIZE + 1] = {0x02, 0xB2, 1, 0xDB};
> > +     int ret;
> > +
> > +     if (ec->suspended)
> > +             return 0;
> > +
> > +     ret = gaokun_ec_write(ec, req);
> > +
> > +     if (ret)
> > +             return ret;
> > +
> > +     ec->suspended = true;
> > +
> > +     return 0;
> > +}
> > +
> > +static int gaokun_ec_resume(struct device *dev)
> > +{
> > +     struct gaokun_ec *ec = dev_get_drvdata(dev);
> > +     u8 req[REQ_HDR_SIZE + 1] = {0x02, 0xB2, 1, 0xEB};
> > +     int ret;
> > +     int i;
> > +
> > +     if (!ec->suspended)
> > +             return 0;
> > +
> > +     for (i = 0; i < 3; i++) {
> > +             ret = gaokun_ec_write(ec, req);
> > +             if (ret == 0)
> > +                     break;
> > +
> > +             msleep(100);
> > +     };
>
> Write three times with a 100 millisecond sleep ?
>

After resueming from suspend, it should write somting to EC, but EC may
not resume, if not, then retry after a break.

> Deserves a comment at least.
>

I see.

> > +
> > +     ec->suspended = false;
> > +
> > +     return 0;
> > +}
> > +
> > +static void gaokun_aux_release(struct device *dev)
> > +{
> > +     struct auxiliary_device *adev = to_auxiliary_dev(dev);
> > +
> > +     kfree(adev);
> > +}
> > +
> > +static void gaokun_aux_remove(void *data)
> > +{
> > +     struct auxiliary_device *adev = data;
> > +
> > +     auxiliary_device_delete(adev);
> > +     auxiliary_device_uninit(adev);
> > +}
> > +
> > +static int gaokun_aux_init(struct device *parent, const char *name,
> > +                        struct gaokun_ec *ec)
> > +{
> > +     struct auxiliary_device *adev;
> > +     int ret;
> > +
> > +     adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> > +     if (!adev)
> > +             return -ENOMEM;
> > +
> > +     adev->name = name;
> > +     adev->id = 0;
> > +     adev->dev.parent = parent;
> > +     adev->dev.release = gaokun_aux_release;
> > +     adev->dev.platform_data = ec;
> > +     /* Allow aux devices to access parent's DT nodes directly */
> > +     device_set_of_node_from_dev(&adev->dev, parent);
> > +
> > +     ret = auxiliary_device_init(adev);
> > +     if (ret) {
> > +             kfree(adev);
> > +             return ret;
> > +     }
> > +
> > +     ret = auxiliary_device_add(adev);
> > +     if (ret) {
> > +             auxiliary_device_uninit(adev);
> > +             return ret;
> > +     }
> > +
> > +     return devm_add_action_or_reset(parent, gaokun_aux_remove, adev);
> > +}
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* EC */
> > +
> > +static irqreturn_t gaokun_ec_irq_handler(int irq, void *data)
> > +{
> > +     struct gaokun_ec *ec = data;
> > +     u8 req[REQ_HDR_SIZE] = {EC_EVENT, EC_QUERY, 0};
> > +     u8 status, id;
> > +     int ret;
> > +
> > +     ret = gaokun_ec_read_byte(ec, req, &id);
> > +     if (ret)
> > +             return IRQ_HANDLED;
> > +
> > +     switch (id) {
> > +     case 0x0: /* No event */
> > +             break;
> > +
> > +     case EC_EVENT_LID:
> > +             gaokun_ec_psy_read_byte(ec, EC_LID_STATE, &status);
> > +             status = EC_LID_OPEN & status;
> > +             input_report_switch(ec->idev, SW_LID, !status);
> > +             input_sync(ec->idev);
> > +             break;
> > +
> > +     default:
> > +             blocking_notifier_call_chain(&ec->notifier_list, id, ec);
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int gaokun_ec_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev = &client->dev;
> > +     struct gaokun_ec *ec;
> > +     int ret;
> > +
> > +     ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> > +     if (!ec)
> > +             return -ENOMEM;
> > +
> > +     mutex_init(&ec->lock);
> > +     ec->client = client;
> > +     i2c_set_clientdata(client, ec);
> > +     BLOCKING_INIT_NOTIFIER_HEAD(&ec->notifier_list);
> > +
> > +     /* Lid switch */
> > +     ec->idev = devm_input_allocate_device(dev);
> > +     if (!ec->idev)
> > +             return -ENOMEM;
> > +
> > +     ec->idev->name = "LID";
> > +     ec->idev->phys = "gaokun-ec/input0";
> > +     input_set_capability(ec->idev, EV_SW, SW_LID);
> > +
> > +     ret = input_register_device(ec->idev);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to register input device\n");
> > +
> > +     ret = gaokun_aux_init(dev, "psy", ec);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = gaokun_aux_init(dev, "wmi", ec);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = gaokun_aux_init(dev, "ucsi", ec);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = devm_request_threaded_irq(dev, client->irq, NULL,
> > +                                     gaokun_ec_irq_handler, IRQF_ONESHOT,
> > +                                     dev_name(dev), ec);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to request irq\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct i2c_device_id gaokun_ec_id[] = {
> > +     { "gaokun-ec", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, gaokun_ec_id);
> > +
> > +static const struct of_device_id gaokun_ec_of_match[] = {
> > +     { .compatible = "huawei,gaokun-ec", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, gaokun_ec_of_match);
> > +
> > +static const struct dev_pm_ops gaokun_ec_pm_ops = {
> > +     NOIRQ_SYSTEM_SLEEP_PM_OPS(gaokun_ec_suspend, gaokun_ec_resume)
> > +};
> > +
> > +static struct i2c_driver gaokun_ec_driver = {
> > +     .driver = {
> > +             .name = "gaokun-ec",
> > +             .of_match_table = gaokun_ec_of_match,
> > +             .pm = &gaokun_ec_pm_ops,
> > +     },
> > +     .probe = gaokun_ec_probe,
> > +     .id_table = gaokun_ec_id,
> > +};
> > +module_i2c_driver(gaokun_ec_driver);
> > +
> > +MODULE_DESCRIPTION("HUAWEI Matebook E Go EC driver");
> > +MODULE_AUTHOR("Pengyu Luo <mitltlatltl@gmail.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/platform/arm64/huawei-gaokun-wmi.c b/drivers/platform/arm64/huawei-gaokun-wmi.c
> > new file mode 100644
> > index 000000000..793cb1659
> > --- /dev/null
> > +++ b/drivers/platform/arm64/huawei-gaokun-wmi.c
> > @@ -0,0 +1,283 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * huawei-gaokun-wmi - A WMI driver for HUAWEI Matebook E Go (sc8280xp)
> > + *
> > + * reference: drivers/platform/x86/huawei-wmi.c
> > + *
> > + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/version.h>
> > +
> > +#include <linux/platform_data/huawei-gaokun-ec.h>
> > +
> > +struct gaokun_wmi {
> > +     struct gaokun_ec *ec;
> > +     struct device *dev;
> > +     struct platform_device *wmi;
> > +};
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Battery charging threshold */
> > +
> > +enum gaokun_wmi_threshold_ind {
> > +     START   = 1,
> > +     END     = 2,
> > +};
> > +
> > +static ssize_t charge_control_thresholds_show(struct device *dev,
> > +                                           struct device_attribute *attr,
> > +                                           char *buf)
> > +{
> > +     int ret;
> > +     u8 start, end;
> > +     struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
> > +
> > +     ret = gaokun_ec_wmi_get_threshold(ecwmi->ec, &start, START)
> > +             || gaokun_ec_wmi_get_threshold(ecwmi->ec, &end, END);
> > +     if (ret)
> > +             return ret;
>
> ick ouch.
>
> Please call these two functions and evaluate their result codes
> individually.
>

Agree

> > +
> > +     return sysfs_emit(buf, "%d %d\n", start, end);
> > +}
> > +
> > +static ssize_t charge_control_thresholds_store(struct device *dev,
> > +                                            struct device_attribute *attr,
> > +                                            const char *buf, size_t size)
> > +{
> > +     int ret;
> > +     u8 start, end;
> > +     struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
> > +
> > +     if (sscanf(buf, "%hhd %hhd", &start, &end) != 2)
> > +             return -EINVAL;
> > +
> > +     ret = gaokun_ec_wmi_set_threshold(ecwmi->ec, start, end);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return size;
> > +}
> > +
> > +static DEVICE_ATTR_RW(charge_control_thresholds);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Smart charge param */
> > +
> > +static ssize_t smart_charge_param_show(struct device *dev,
> > +                                    struct device_attribute *attr,
> > +                                    char *buf)
> > +{
> > +     int ret;
> > +     u8 value;
> > +     struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
> > +
> > +     ret = gaokun_ec_wmi_get_smart_charge_param(ecwmi->ec, &value);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return sysfs_emit(buf, "%d\n", value);
> > +}
> > +
> > +static ssize_t smart_charge_param_store(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     const char *buf, size_t size)
> > +{
> > +     int ret;
> > +     u8 value;
> > +     struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
> > +
> > +     if (kstrtou8(buf, 10, &value))
> > +             return -EINVAL;
> > +
> > +     ret = gaokun_ec_wmi_set_smart_charge_param(ecwmi->ec, value);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return size;
> > +}
> > +
> > +static DEVICE_ATTR_RW(smart_charge_param);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Smart charge */
> > +
> > +static ssize_t smart_charge_show(struct device *dev,
> > +                              struct device_attribute *attr,
> > +                              char *buf)
> > +{
> > +     int ret;
> > +     u8 bf[GAOKUN_SMART_CHARGE_DATA_SIZE];
> > +     struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
> > +
> > +     ret = gaokun_ec_wmi_get_smart_charge(ecwmi->ec, bf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return sysfs_emit(buf, "%d %d %d %d\n",
> > +                       bf[0], bf[1], bf[2], bf[3]);
> > +}
> > +
> > +static ssize_t smart_charge_store(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               const char *buf, size_t size)
> > +{
> > +     int ret;
> > +     u8 bf[GAOKUN_SMART_CHARGE_DATA_SIZE];
> > +     struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
> > +
> > +     if (sscanf(buf, "%hhd %hhd %hhd %hhd", bf, bf + 1, bf + 2, bf + 3) != 4)
> > +             return -EINVAL;
> > +
> > +     ret = gaokun_ec_wmi_set_smart_charge(ecwmi->ec, bf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return size;
> > +}
> > +
> > +static DEVICE_ATTR_RW(smart_charge);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Fn lock */
> > +
> > +static ssize_t fn_lock_state_show(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               char *buf)
> > +{
> > +     int ret;
> > +     u8 on;
> > +     struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
> > +
> > +     ret = gaokun_ec_wmi_get_fn_lock(ecwmi->ec, &on);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return sysfs_emit(buf, "%d\n", on);
> > +}
> > +
> > +static ssize_t fn_lock_state_store(struct device *dev,
> > +                                struct device_attribute *attr,
> > +                                const char *buf, size_t size)
> > +{
> > +     int ret;
> > +     u8 on;
> > +     struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
> > +
> > +     if (kstrtou8(buf, 10, &on))
> > +             return -EINVAL;
> > +
> > +     ret = gaokun_ec_wmi_set_fn_lock(ecwmi->ec, on);
>
> I mentioned already you should pass on as a bool and then decide here in
> the input function if "on" as passed is a reasonable boolean state.
>

I see

> > +     if (ret)
> > +             return ret;
> > +
> > +     return size;
> > +}
> > +
> > +static DEVICE_ATTR_RW(fn_lock_state);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Thermal Zone */
> > +
> > +static ssize_t temperature_show(struct device *dev,
> > +                             struct device_attribute *attr,
> > +                             char *buf)
> > +{
> > +
> > +     int ret, len, i;
> > +     char *ptr = buf;
> > +     s16 value;
> > +     s16 temp[GAOKUN_TZ_REG_NUM];
> > +     struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
> > +
> > +     ret = gaokun_ec_wmi_get_temp(ecwmi->ec, temp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     i = 0;
> > +     len = 0;
> > +     while (i < GAOKUN_TZ_REG_NUM) {
> > +             value = temp[i++];
> > +             if (value < 0) {
> > +                     len += sprintf(ptr + len, "-");
>
> Have you ever seen a negative temperature value in running silicon ?
> Looks suspicious to me.
>

EC's logic, it handles them as symbol numbers, and dealing negative with
bit ops. And I think not all sensors are for silicon.

{
	BUF1 = \_SB.IC16.ECCD (0x02, 0x61, One, ISNB, 0x04)
	TEMP [Zero] = DerefOf (BUF1 [0x02])
	TEMP [One] = DerefOf (BUF1 [0x03])
	Local1 = TEMP /* \GTMP.TEMP */
	Local2 = DerefOf (TEMP [Zero])
	Local3 = DerefOf (TEMP [One])
	If ((Local2 == 0xFF))
	{
	TEMP = Zero
	STAT = One
	}
	Else
	{
	Local4 = (Local3 << 0x08)
	Local1 = (Local4 | Local2)
	Local4 = (Local3 & 0x80)
	If (Local4)
	{
		TFLG = One
		Local5 = (Local1 - One)
		Local1 = ~Local5
	}

	Divide (Local1, 0x0A, Local4, Local5)
	TMPD = Local4
	TMPI = Local5
	STAT = Zero
	}
}

> > +                     value = -value;
> > +             }
> > +             len += sprintf(ptr + len, "%d.%d ", value / 10, value % 10);
> > +     }
> > +     len += sprintf(ptr + len, "\n");
> > +
> > +     return len;
> > +}
> > +
> > +static DEVICE_ATTR_RO(temperature);
> > +
> > +static struct attribute *gaokun_wmi_features_attrs[] = {
> > +     &dev_attr_charge_control_thresholds.attr,
> > +     &dev_attr_smart_charge_param.attr,
> > +     &dev_attr_smart_charge.attr,
> > +     &dev_attr_fn_lock_state.attr,
> > +     &dev_attr_temperature.attr,
> > +     NULL,
> > +};
> > +ATTRIBUTE_GROUPS(gaokun_wmi_features);
> > +
> > +static int gaokun_wmi_probe(struct auxiliary_device *adev,
> > +                         const struct auxiliary_device_id *id)
> > +{
> > +     struct gaokun_ec *ec = adev->dev.platform_data;
> > +     struct device *dev = &adev->dev;
> > +     struct gaokun_wmi *ecwmi;
> > +
> > +     ecwmi = devm_kzalloc(&adev->dev, sizeof(*ecwmi), GFP_KERNEL);
> > +     if (!ecwmi)
> > +             return -ENOMEM;
> > +
> > +     ecwmi->ec = ec;
> > +     ecwmi->dev = dev;
> > +
> > +     auxiliary_set_drvdata(adev, ecwmi);
> > +
> > +     /* make it under /sys/devices/platform, convenient for sysfs I/O,
> > +      * while adev is under
> > +      * /sys/devices/platform/soc@0/ac0000.geniqup/a9c000.i2c/i2c-15/15-0038/
> > +      */
> > +     ecwmi->wmi = platform_device_register_simple("gaokun-wmi", -1, NULL, 0);
> > +     if (IS_ERR(ecwmi->wmi))
> > +             return dev_err_probe(dev, PTR_ERR(ecwmi->wmi),
> > +                                  "Failed to register wmi platform device\n");
> > +
> > +     platform_set_drvdata(ecwmi->wmi, ecwmi);
> > +
> > +     return device_add_groups(&ecwmi->wmi->dev, gaokun_wmi_features_groups);
> > +}
> > +
> > +static void gaokun_wmi_remove(struct auxiliary_device *adev)
> > +{
> > +     struct gaokun_wmi *ecwmi = auxiliary_get_drvdata(adev);
> > +     struct platform_device *wmi = ecwmi->wmi;
> > +
> > +     device_remove_groups(&wmi->dev, gaokun_wmi_features_groups);
> > +     platform_device_unregister(ecwmi->wmi);
> > +}
> > +
> > +static const struct auxiliary_device_id gaokun_wmi_id_table[] = {
> > +     { .name = GAOKUN_MOD_NAME "." GAOKUN_DEV_WMI, },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(auxiliary, gaokun_wmi_id_table);
> > +
> > +static struct auxiliary_driver gaokun_wmi_driver = {
> > +     .name = GAOKUN_DEV_WMI,
> > +     .id_table = gaokun_wmi_id_table,
> > +     .probe = gaokun_wmi_probe,
> > +     .remove = gaokun_wmi_remove,
> > +};
> > +
> > +module_auxiliary_driver(gaokun_wmi_driver);
> > +
> > +MODULE_DESCRIPTION("HUAWEI Matebook E Go WMI driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/platform_data/huawei-gaokun-ec.h b/include/linux/platform_data/huawei-gaokun-ec.h
> > new file mode 100644
> > index 000000000..a649e9ecf
> > --- /dev/null
> > +++ b/include/linux/platform_data/huawei-gaokun-ec.h
> > @@ -0,0 +1,90 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Huawei Matebook E Go (sc8280xp) Embedded Controller
> > + *
> > + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> > + *
> > + */
> > +
> > +#ifndef __HUAWEI_GAOKUN_EC_H__
> > +#define __HUAWEI_GAOKUN_EC_H__
> > +
> > +#define GAOKUN_UCSI_CCI_SIZE 4
> > +#define GAOKUN_UCSI_DATA_SIZE        16
> > +#define GAOKUN_UCSI_READ_SIZE        (GAOKUN_UCSI_CCI_SIZE + GAOKUN_UCSI_DATA_SIZE)
> > +#define GAOKUN_UCSI_WRITE_SIZE       0x18
> > +
> > +#define GAOKUN_TZ_REG_NUM    20
> > +#define GAOKUN_SMART_CHARGE_DATA_SIZE        4 /* mode, delay, start, end */
> > +
> > +/* -------------------------------------------------------------------------- */
> > +
> > +struct gaokun_ec;
> > +struct notifier_block;
> > +
> > +#define GAOKUN_MOD_NAME                      "huawei_gaokun_ec"
> > +#define GAOKUN_DEV_PSY                       "psy"
> > +#define GAOKUN_DEV_WMI                       "wmi"
> > +#define GAOKUN_DEV_UCSI                      "ucsi"
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Common API */
> > +
> > +int gaokun_ec_register_notify(struct gaokun_ec *ec,
> > +                           struct notifier_block *nb);
> > +void gaokun_ec_unregister_notify(struct gaokun_ec *ec,
> > +                              struct notifier_block *nb);
> > +
> > +int gaokun_ec_read(struct gaokun_ec *ec, const u8 *req,
> > +                size_t resp_len, u8 *resp);
> > +int gaokun_ec_write(struct gaokun_ec *ec, u8 *req);
> > +int gaokun_ec_read_byte(struct gaokun_ec *ec, u8 *req, u8 *byte);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* API For PSY */
> > +
> > +int gaokun_ec_psy_multi_read(struct gaokun_ec *ec, u8 reg,
> > +                          size_t resp_len, u8 *resp);
> > +
> > +static inline int gaokun_ec_psy_read_byte(struct gaokun_ec *ec,
> > +                                       u8 reg, u8 *byte)
> > +{
> > +     return gaokun_ec_psy_multi_read(ec, reg, 1, byte);
> > +}
> > +
> > +static inline int gaokun_ec_psy_read_word(struct gaokun_ec *ec,
> > +                                       u8 reg, u16 *word)
> > +{
> > +     return gaokun_ec_psy_multi_read(ec, reg, 2, (u8 *)word);
> > +}
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* API For WMI */
> > +
> > +int gaokun_ec_wmi_get_threshold(struct gaokun_ec *ec, u8 *value, int ind);
> > +int gaokun_ec_wmi_set_threshold(struct gaokun_ec *ec, u8 start, u8 end);
> > +
> > +int gaokun_ec_wmi_get_smart_charge_param(struct gaokun_ec *ec, u8 *value);
> > +int gaokun_ec_wmi_set_smart_charge_param(struct gaokun_ec *ec, u8 value);
> > +
> > +int gaokun_ec_wmi_get_smart_charge(struct gaokun_ec *ec,
> > +                                u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE]);
> > +int gaokun_ec_wmi_set_smart_charge(struct gaokun_ec *ec,
> > +                                u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE]);
> > +
> > +int gaokun_ec_wmi_get_fn_lock(struct gaokun_ec *ec, u8 *on);
> > +int gaokun_ec_wmi_set_fn_lock(struct gaokun_ec *ec, u8 on);
> > +
> > +int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 temp[GAOKUN_TZ_REG_NUM]);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* API For UCSI */
> > +
> > +int gaokun_ec_ucsi_read(struct gaokun_ec *ec, u8 resp[GAOKUN_UCSI_READ_SIZE]);
> > +int gaokun_ec_ucsi_write(struct gaokun_ec *ec,
> > +                      const u8 req[GAOKUN_UCSI_WRITE_SIZE]);
> > +
> > +int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec, u8 *ureg);
> > +int gaokun_ec_ucsi_pan_ack(struct gaokun_ec *ec, int port_id);
> > +
> > +
> > +#endif /* __HUAWEI_GAOKUN_EC_H__ */
>


Best Wishes,
Pengyu

