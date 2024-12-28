Return-Path: <linux-pm+bounces-19806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D589FDA2C
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 12:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29C51883596
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549C15350B;
	Sat, 28 Dec 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSHg9OdW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE594C62E;
	Sat, 28 Dec 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735385759; cv=none; b=dwQ9fAMePexVGj9v9q6h66lg+2eAGqK8rceoGPRb1WjghH8m+OIblp1csjWlgz9CGmJAX8xH+sj1eGDS2jumYMEk/l/tLwTZdmG8qhIh7eNB6oMbFWlK0dn192k7yCxbT2uRbfy9caLHDrE7Nwu/TKkxpB5SdHSXXrQOX6kvyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735385759; c=relaxed/simple;
	bh=UTL48/8/QWekBUT1m3b7xoPVUOV0/2/gh/jUOyDHSo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFuLFrdavGK6KMzg+hTcYs8SsdXcnoy4pquI7lriVxzfGYF+Ibv83aogWPbbM6m1kuB1i1YXrHFeP+18eqHnHfmvwbbYRUCqW/xKS0D5jgYAjUdIXEo+eAF0zP+ZArxbpRrvD54E8hje0IyXGW8Bs/pMqs/ZhY/b9KC307W3WVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSHg9OdW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21680814d42so87058625ad.2;
        Sat, 28 Dec 2024 03:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735385757; x=1735990557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxjuQXLL5v3IOrWzQlPRNZYnWRhMtcxT+eYpmkHFYZk=;
        b=FSHg9OdWSpDkUfBAebVCy/NHBfZZwFzwkh3m2rGUXpfVeweoFTfqpz7IWWWYX3e5gE
         /jTa2jnObANiinSttNC73kAj7SCWVbqQ3HUU2huP6jzDrn69md/JeA9uWU3XLHUuuRKl
         MWHxn/RdnI4maSwi6JiyWbFGdjLdGZfd7sC+AiN6LybCCjtKYecXZ+yZBfeN8vOpEy6t
         WDVt6xP7WavUhVC6cxrK3DCw1MEMFmvwsmY6jmR5NbNdeW5YRUN7gJwARESPswTottme
         OrXBZQYrycHPXuiFFWdLbPcNDisCcPhqbyFsAlZS4ZACsC9isxNLuMjlAHS2vsQOXnM7
         PdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735385757; x=1735990557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxjuQXLL5v3IOrWzQlPRNZYnWRhMtcxT+eYpmkHFYZk=;
        b=Cp7f9p8izony6vzbPRUeLq4UVQH/TOEMc6gRJIkQfrZtcneVf1SHiGjK0NM04PppoW
         M+58UYh1+eXaAEfPVFoUx8EqTRQOxFXXDNZhh0OdFf2twK7AZFeLRcgUoNEqHNRbiJtF
         5dZQJ3iPTbWuU/5prjgPe26ZbycLsReAiqNQ2cqMfM8zdJSIGe+rq5hWmYzAULGgNWj5
         AWMvUpW+NabkS9sjW/wRIHlfLZY3+amNvwfT110fLLUIZf9gisb/tuxExSabC9JMNSyw
         9ynW3wT6u3w836yYMYM5KEWELcqAm8uktL+MuljJlnsid5vftsOTJfi3kg09X5MYMViC
         Rxjg==
X-Forwarded-Encrypted: i=1; AJvYcCUOognMwV3BB81LmSZ5QjbxvKg/VgfzOjBnfvaCkwm48VZVn8R09QtyUCm2EBPjq23rB2dJg9YU+NfKilqZdQ==@vger.kernel.org, AJvYcCUQHugftA96NjLEmkxbWTx7ksafh1gQZp/tPhNiBp7hD6pH/IVxhTYPPMOx1fu0dCFWST5OGVjfw0vG65GXZJ16yEiBhA==@vger.kernel.org, AJvYcCUpSxzGqRoxoYaT2cQp8f2fq3WYgIqMTYCw3ug5mBxR88j2fDuClDCinabzmD78zeCPWNIqh0RvIkBs@vger.kernel.org, AJvYcCVjzFHW8/ICEIxvwDWCaEVU77253ONuk9dleAe6DlR/UHm5w5zPmL99HzIKXgYnfTe8/JHsawcaby8=@vger.kernel.org, AJvYcCVtXljsK2+ZPcbyUuTK0WEl04IaCBY7ylMJ7BekYcjN3sHxM4qDjR+cQRnwWtjTVc6i3JeM9BIklsHq@vger.kernel.org, AJvYcCWIfrrHfiRCIyszyx3ofjIs0phA7/7AlUUVggDEvOspQuIdYz2Xw687b/GjJbkzZUev54rPVVd1sHDCjY3w@vger.kernel.org
X-Gm-Message-State: AOJu0YySKLraX4Sjh6SjsXIYg9MPMVtVy9dPo6rE+mN6BHSonleEGT6R
	08B282ZAUXJ0piBkYC1tTJPsMsnNzVcvoTt/DeTqKgFq/3lGMDiBk/9TuuTA4b2tomzM
X-Gm-Gg: ASbGncs2DcHVyYjPP4cDKf4wCHfXOpE8ulR/MANVYSjltir0B26wTByJJbncwOYKETl
	N1IYHhuW/emZdamvko7PfZw3/EzI4BKWs64etyAl49YBMalt2uJQfXS9SbHCBo366X6MvIt6E00
	AIT7DAniCPYvzzMlYKjJqhuURTIeRnNibWxYEkPpOPJZdBKK9P0RZHQgipg6MnxCD9pegWoWV8S
	LGvyW5lONGB082v4MOSrgSGuwKHHRn87PvgobA0qGI=
X-Google-Smtp-Source: AGHT+IEvHHLAoL0rQKTX8Cmq7nX5QwtvMoE6jSEq4VPP8x/RxBVGGrTpMKiGvXDKDS4pFXPen0TeVw==
X-Received: by 2002:a17:902:f693:b0:216:1367:7e48 with SMTP id d9443c01a7336-219e6ccdcb2mr417104425ad.0.1735385757455;
        Sat, 28 Dec 2024 03:35:57 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d9481sm148178955ad.135.2024.12.28.03.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 03:35:57 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: krzk@kernel.org
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
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
Date: Sat, 28 Dec 2024 19:34:37 +0800
Message-ID: <20241228113438.591254-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <53da6468-501c-4c0f-a73b-4eac99c72b8c@kernel.org>
References: <53da6468-501c-4c0f-a73b-4eac99c72b8c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On Sat, Dec 28, 2024 at 5:58 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 27/12/2024 18:13, Pengyu Luo wrote:
> > +
> > +#include <linux/platform_data/huawei-gaokun-ec.h>
> > +
> > +#define EC_EVENT             0x06
> > +
> > +/* Also can be found in ACPI specification 12.3 */
> > +#define EC_READ                      0x80
> > +#define EC_WRITE             0x81
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
>
> Use Linux style comments, see coding style.
>

Agree

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
>
> Missing doc. Run Checkpatch --strict, so you will know what is missing here.
>

I see. A comment for mutex lock.

> > +     struct blocking_notifier_head notifier_list;
> > +     struct input_dev *idev;
> > +     bool suspended;
> > +};
> > +
>
>
>
> ...
>
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
>
>
> No, don't expose your own interface. Charging is already exposed by
> power supply framework. Temperature by hwmon sensors. Drop all these and
> never re-implement existing kernel user-space interfaces.
>

I don't quite understand what you mean. You mean I should use hwmon
interface like hwmon_device_register_with_groups to register it, right?
As for battery, get/set_propery allow us to handle charging thresholds
things, but there are smart_charge_param, smart_charge and fn_lock to handle.

>
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
>
> Drop, include proper header instead.
>

I agree, I copy 'struct notifier_block;' from
include/linux/platform_data/lenovo-yoga-c630.h

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
>
>
> You need kerneldoc, in the C file, for all exported functions.
>

I got it.

>
>
> Best regards,
> Krzysztof

Best Wishes,
Pengyu

