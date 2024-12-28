Return-Path: <linux-pm+bounces-19800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1789FD90F
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 06:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB8F3A2604
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 05:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA1E433C0;
	Sat, 28 Dec 2024 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8kYW/NR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489079FD;
	Sat, 28 Dec 2024 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735364658; cv=none; b=R1y5icKBib5kYfdl+RAJ2RGkrgjaRKgvVndG7roramCdTI5uVMj2zP6srtzNQlfri6Wq3v8B7VN1l6cWd/eiPJkz+upcD0dkdpFef9GkOr6Fu7xhfNacCEOKczlBNl3X8bXj/MIpz7sjXD0Jzh43KSIa8jdDqaMcYheqeEf83ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735364658; c=relaxed/simple;
	bh=c/UXqWsZkZJ3mZej5WZjmOI/dNhoGUeYeb3AleGkiVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1Ko1ZeEMsGjfXfMA48qTWsZF3rFUpY8BUeULih27SNmr3Hjq14r+25kI5FSFhxy2E1RK5v0rDknO6D0xLuz9D4R5UtKtFt2voeU+gjbNOMevF0gPslc99gzHpXW6sEreVyp6yYE7GzA97jWyA3ZMteJmJ8sGZziGWwmOAnswT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8kYW/NR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21670dce0a7so32402795ad.1;
        Fri, 27 Dec 2024 21:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735364656; x=1735969456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nkey3SXPBL8KVxQHG56h9FLqPjdWTDEcnVzd/E3a52w=;
        b=G8kYW/NRwZwtoj7nZnqjD+zS0R0HR2cUUHwfOrFy62A2c+riGmqlTdRLBgpZGlZh5u
         zA2BtHQpyACZWJV13zUa7YUdvsz3z0gJ/g16NK4DCmsSSjfL0qLuuB1dPF86ZOctXuZm
         ZykLQvVTBbjRJtLaJBeXFlDQRI2OQpxxyh1nXKOPN4BaInvHHxRnPX3igKmv/YY0hkFQ
         eD0ocDfpMRBYvMiouYZS7Nwbt5VhEfD9o4iz+7vYZIcYHoQA0mjyog7eMM0+nertPdwm
         toOfBMQu1vlRUNAnp0oX/WNau2TknkxQZ1EeAEOGKYDmJFM9OBoa14cJv7GpMEs3/btm
         0KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735364656; x=1735969456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nkey3SXPBL8KVxQHG56h9FLqPjdWTDEcnVzd/E3a52w=;
        b=VfRQabUyWnextu0FZpI0evkr+dEVkJEhXn/gGJ8HOsjx8NeN4fzfbHPrI7pjbjfbRp
         LV3hvagrhZgdO+sCpP23r2QRC/LNsbHOgWhLIvlPQ8xWxFajsXA0yqqXGR3IroBLv+zG
         JlUNob/ZHp0shoNbZtOENObrgtVBRnupUt3Q7pUsBcN/NKaSX13VGu2Y2EJf686d9jSC
         olStFjOTtD9aQg5bsMay/giSMn3u+UX/EtkCJEJCo8s65dLJePFAMlInPMFdTUer/fXz
         QCbos9X7N0LGArbe/lYdOI0hI6Fk3uR/WO08wo42BiAG9rsNJQ3YZL1GySfWvcWnQ5lk
         TqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYRVYKpHY01b5RhI+zH9dS0dpKOK/79G8/CyBYQbmQkbn8ozSmJBq+uEwvcX5f93ejGfgIpTLdw8tNW37qvcgLOJ6S1w==@vger.kernel.org, AJvYcCVHFFOci+8tttKLzY0z/iXgUHo2r44WDDTjlArqXcQQPoz1uN/JjHlnzVPKlxoYvpFk3/1Q2kPFOlBa@vger.kernel.org, AJvYcCW4Nx1miMDSZOhHpogy/70WB2UYl+sQAGPNrHKfCNNsNlcObw+gG+3Yalc3ZfJcNoxUNlewCNU6IXc=@vger.kernel.org, AJvYcCWEQGELoSpFew89/Ocm/7TUkpwkhIOvo0+oecRO8F74h7Dj+dp0flYF3DXxCoRC961KggwnxhVe+o5MV+Bl@vger.kernel.org, AJvYcCXZPjM8lEUGAd+YzmNvJwB0AuON8MC3hqDARK0Z76rCKlXUrzQBH3Em+mhHcGOeIX8TxliVlerSVtctnjqi5Q==@vger.kernel.org, AJvYcCXvjSEuEqKBp1UmUPItZGLkFVUUklE35Npr9m0f6hJ2/V/AoAPWABCO6DHCuwKtG7uPyUjwdKNfyzAU@vger.kernel.org
X-Gm-Message-State: AOJu0YziTnMMW6TQscGJLFgA891MDxBwzZqvO58JXNlJJBs4QXzg6udp
	GI6RFaTKFLCqGfVhvt4jzt8pCnwOcZiX3ic5VJjffK6qXPk9kM3y
X-Gm-Gg: ASbGnctSv8DXWgqr8i0fgpR/japKHmx7N9ioq0v8dn9E1CWceXlDolemy1phe4c6EbZ
	RKzv7jnEUxuV3qcJZZGhzlpcWqjBWOZ1O/Ymn1jrTMLdYBhaTmTaKMhUAzXI3cydVqWT1dvf3tp
	2wSNopdHZBpTN77Oa6BviHU1KqFsBMo88k5ublBaKV/EfKQniL2PcBanCWczrkTft6JRRhvYYUe
	pUB0/t+f5XhqEqz0MPn6kRZzMq3H/CwEiAPVn0xlx4=
X-Google-Smtp-Source: AGHT+IEHyEfIdsHGIJJ+lP2XCN3DQ5dlE3X6F8MNeuKTuN0tlLHkiG12h1jNL4JmMAQ9FeT7Bu44OA==
X-Received: by 2002:a05:6a00:410d:b0:725:f376:f4ff with SMTP id d2e1a72fcca58-72abde0b086mr42975235b3a.13.1735364655875;
        Fri, 27 Dec 2024 21:44:15 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fccd5sm15548149b3a.168.2024.12.27.21.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 21:44:15 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: maccraft123mc@gmail.com
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
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
Date: Sat, 28 Dec 2024 13:42:57 +0800
Message-ID: <20241228054259.485044-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAO_MupKJyHbEb6RQ0B4gHwPQCrB=NfHJ-odY6R+DaSwOaSfnGw@mail.gmail.com>
References: <CAO_MupKJyHbEb6RQ0B4gHwPQCrB=NfHJ-odY6R+DaSwOaSfnGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On Sat, Dec 28, 2024 at 2:21 AM Maya Matuszczyk <maccraft123mc@gmail.com> wrote:
> Good to see someone else doing EC drivers for arm64 laptops!
>

Yeah, I have worked on it for a while. I really don't know why don't some
mechines use a pmic glink. AFAIK, there are some WOA devices without EC.
Mechines can definitely work without it in a way.

I am also glad that you are reviewing my code.

> pt., 27 gru 2024 o 18:16 Pengyu Luo <mitltlatltl@gmail.com> napisał(a):
> >
> > There are 3 variants, Huawei released first 2 at the same time.
> > Huawei Matebook E Go LTE(sc8180x), codename should be gaokun2.
> > Huawei Matebook E Go(sc8280xp@3.0GHz), codename is gaokun3.
> > Huawei Matebook E Go 2023(sc8280xp@2.69GHz).
> >
> > Adding support for the latter two variants for now, this driver should
> > also work for the sc8180x variant according to acpi table files, but I
> > don't have the device yet.
> >
> > Different from other Qualcomm Snapdragon sc8280xp based machines, the
> > Huawei Matebook E Go uses an embedded controller while others use
> > something called pmic glink. This embedded controller can be used to
> > perform a set of various functions, including, but not limited:
> >
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
> >
> > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > ---
> >  drivers/platform/arm64/Kconfig                |  19 +
> >  drivers/platform/arm64/Makefile               |   2 +
> >  drivers/platform/arm64/huawei-gaokun-ec.c     | 598 ++++++++++++++++++
> >  drivers/platform/arm64/huawei-gaokun-wmi.c    | 283 +++++++++
> >  .../linux/platform_data/huawei-gaokun-ec.h    |  90 +++
> >  5 files changed, 992 insertions(+)
> >  create mode 100644 drivers/platform/arm64/huawei-gaokun-ec.c
> >  create mode 100644 drivers/platform/arm64/huawei-gaokun-wmi.c
> >  create mode 100644 include/linux/platform_data/huawei-gaokun-ec.h

[...]

> > +/* -------------------------------------------------------------------------- */
> > +/* API For PSY */
> > +
> > +int gaokun_ec_psy_multi_read(struct gaokun_ec *ec, u8 reg,
> > +                            size_t resp_len, u8 *resp)
> > +{
> > +       int i, ret;
> > +       u8 _resp[RESP_HDR_SIZE + 1];
> > +       u8 req[REQ_HDR_SIZE + 1] = {0x02, EC_READ, 1, };
> > +
> > +       for (i = 0; i < resp_len; ++i) {
> > +               req[INPUT_DATA_OFFSET] = reg++;
> > +               ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> > +               if (ret)
> > +                       return -EIO;
> > +               resp[i] = _resp[DATA_OFFSET];
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_psy_multi_read);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* API For WMI */
> WMI is in ACPI, this laptop doesn't boot with ACPI so why are things
> handled in WMI separate from rest of the driver?
>

This driver reimplemented WMI functoins, and it perform a lot of
operations, to avoid naming it, just call it WMI, make life easier.

Once I considered keeping WMI things in this file, but it makes this file
bloated. Then I splitted every part into a module.

> > +
> > +/* Battery charging threshold */
> > +int gaokun_ec_wmi_get_threshold(struct gaokun_ec *ec, u8 *value, int ind)
> > +{
> > +       /* GBTT */
> > +       return gaokun_ec_read_byte(ec, (u8 []){0x02, 0x69, 1, ind}, value);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_threshold);
> > +
> > +int gaokun_ec_wmi_set_threshold(struct gaokun_ec *ec, u8 start, u8 end)
> > +{
> > +       /* SBTT */
> > +       int ret;
> > +       u8 req[REQ_HDR_SIZE + 2] = {0x02, 0x68, 2, 3, 0x5a};
> > +
> > +       ret = gaokun_ec_write(ec, req);
> > +       if (ret)
> > +               return -EIO;
> > +
> > +       if (start == 0 && end == 0)
> > +               return -EINVAL;
> > +
> > +       if (start >= 0 && start <= end && end <= 100) {
> > +               req[INPUT_DATA_OFFSET] = 1;
> > +               req[INPUT_DATA_OFFSET + 1] = start;
> > +               ret = gaokun_ec_write(ec, req);
> > +               if (ret)
> > +                       return -EIO;
> > +
> > +               req[INPUT_DATA_OFFSET] = 2;
> > +               req[INPUT_DATA_OFFSET + 1] = end;
> > +               ret = gaokun_ec_write(ec, req);
> > +       } else {
> > +               return -EINVAL;
> > +       }
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_threshold);

[...]

> > +/* -------------------------------------------------------------------------- */
> > +/* EC */
> > +
> > +static irqreturn_t gaokun_ec_irq_handler(int irq, void *data)
> > +{
> > +       struct gaokun_ec *ec = data;
> > +       u8 req[REQ_HDR_SIZE] = {EC_EVENT, EC_QUERY, 0};
> > +       u8 status, id;
> > +       int ret;
> > +
> > +       ret = gaokun_ec_read_byte(ec, req, &id);
> > +       if (ret)
> > +               return IRQ_HANDLED;
> The error should probably be logged instead of silently ignored
>

Generally, one or two I/O errors don't crash anything, but actually if we
just do as ACPI methoda did, there should not be any error. It may be
necessary for debugging at the early stage of developemnt. If you suggest,
then we can add a report to the lower function (gaokun_ec_request) to check
every transaction. BTW, lenovo c630 also ignored them.

> > +
> > +       switch (id) {
> > +       case 0x0: /* No event */
> > +               break;
> > +
> > +       case EC_EVENT_LID:
> > +               gaokun_ec_psy_read_byte(ec, EC_LID_STATE, &status);
> > +               status = EC_LID_OPEN & status;
> > +               input_report_switch(ec->idev, SW_LID, !status);
> > +               input_sync(ec->idev);
> > +               break;
> > +
> > +       default:
> > +               blocking_notifier_call_chain(&ec->notifier_list, id, ec);
> > +       }
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +

[...]

> > diff --git a/drivers/platform/arm64/huawei-gaokun-wmi.c b/drivers/platform/arm64/huawei-gaokun-wmi.c
> > new file mode 100644
> > index 000000000..793cb1659
> > --- /dev/null
> > +++ b/drivers/platform/arm64/huawei-gaokun-wmi.c
> > @@ -0,0 +1,283 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * huawei-gaokun-wmi - A WMI driver for HUAWEI Matebook E Go (sc8280xp)
> Just because in ACPI it's done by WMI stuff doesn't mean the non-ACPI
> driver has to reflect this
>

As I just said, and the WMI stuffs are all implemented by wrapping a EC
transaction in ACPI, at least in this machine.

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
> >

[...]

> >
>
> Best Regards,
> Maya Matuszczyk

Best Wishes,
Pengyu

