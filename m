Return-Path: <linux-pm+bounces-19817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB6D9FDE21
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 10:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2FC7A11A9
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4E87081B;
	Sun, 29 Dec 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ4/GecK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E717E2594AD;
	Sun, 29 Dec 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735463174; cv=none; b=MtmyP+5bZEXK62hn8TFFdrc2EByY1WTkTfarThnYdQk1+UdGY3EZogSgQDJnfxgXkOG19FijnKjLqOsPIH+nIk1m7qGRgfKeM0ECmVxyTsxYkQYsDcxelGqP3Hc4QbBWKR2/6/W9/OpFAJXaDKWNJSjPQE1lh1uqBl00+EtJagI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735463174; c=relaxed/simple;
	bh=aZPfQj9uZyeyhd4zFnyQbN3lJ2yFjhnv0UwIDV2ABfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ju6d3ZySpYsI05epIi7IZv7Vy/LL3Wao6ddBeCwJm41wnaxYH2I0BxQvx0xtXGoMQNHP1ZD3oBUxrxXc89LjzNkDGRxfU8P6/0RhgZJLInBGn4281Eg/8+BgNbW0wkaCBbwOzJiHvsGY6eYLRrAqyD+iqTyVf63wfvr8ErLFTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ4/GecK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166f1e589cso128312065ad.3;
        Sun, 29 Dec 2024 01:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735463172; x=1736067972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mmyv3bnllxWpEOmcXknvi6fDfXra5qguuCPvvE1qHW4=;
        b=RQ4/GecKA2z5HRU/eYa/LaVh1X62AqgbPMt/tPFbvHSM3uwwwAc2ngjOZ8qnNNdDYa
         sOIU5GRnhwmRjJ7/9YoUxH+2NdX6ZtbTpXcUukOYt30tWyKJ73bNbukrSmGsw8VF6HAd
         H0SYLP7iIg1M/1nKx0a6TIdk0Sue6gu0sVCeoAl2wd8BQnEiFXVVIEsb7cW0VgGIMRiJ
         t47FU7WbMI4ibKvVnq0a8TSHbFwEqvTdq32R3AJhIN8A/4N0JGJ3UcRROlng8QtObzKy
         UHlqb1QUzkC4qS3yi8pbHGUzdd44femQh7rPaMhjImqDA48IyDhx5UxrMPM8tuzpZH/O
         mE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735463172; x=1736067972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mmyv3bnllxWpEOmcXknvi6fDfXra5qguuCPvvE1qHW4=;
        b=WGveZCiXS5orHqHiTc0GB4n1tx8pAOwBCDk3Cn0JQdLtkN0kjQ+FqlY23cROtqo5ht
         2saZJN5H60o4sAVtZqdR86NRCm/IsEeXmxJWPEOvyNJkLn+j2hhGMPMsHRBBV9EPeVnV
         TP9qeVajpc5pk+Ih0pMvL7y+SHqe+637FbRbs5w0Jf5jOxR6Bg/MS/U1xn73G7b6ac1s
         W29UrkIw0sUXObAUrgI9nRmTYrUaoGWFrpjh7GCuXZvbFzU1ITV9x2VcUIx3lQAERCJC
         c0WNmb3v04K5oboRg4y+/5j9D5e13OmoJVwcg8Gxv+86FUt2zTPUj+LUwlt5OzHyeL2U
         ZklA==
X-Forwarded-Encrypted: i=1; AJvYcCUb9ZcDmaCINWUiIzxA9T4huIawlLRy4nCL9MZ05g4FAo86ERjmqT6mxKGxxphFGzMlEiRDlFpo55/U@vger.kernel.org, AJvYcCVBX+jCpVo/DAiJGD9DUotiE1tlf9AC/iYYGF07XK79MIixmIjImEEy9jHkqbC3KDAMOcpCUX3WMpiS@vger.kernel.org, AJvYcCWQ2Y/XwkJ00XmB7Eyo0AnfrhDvHghduxlDQGfipjrLWASR72Z+K8ROgBgjmc90CCkKWmMtmm8o1q8rC2hNeakmPXa5NQ==@vger.kernel.org, AJvYcCWs5aW0frrG0mNUH7vGNI5MeQphH9WumqKpCOejO4HdORCZBUENMpEWT/GqtKCHbaAXSKQaKSZDPPw=@vger.kernel.org, AJvYcCWxj51/siXDees8Kp7uVYzGN2P7wTVW6ZtoOY4SbZnkjG1q+ZLook4ZdY4XBGNwbS7YIjwqLtb50w0PJly6@vger.kernel.org, AJvYcCXpDUhfJmI9gfkafyz0dlst1f6RIPyu/BXbjfz2TGjj2LyMQbcKIHdMizQ9cVRJmLTMun5s6dn0KiZIilWzSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvtfnq9QbHvYNYzE3329rOSgWHv0MmhPYr6Dguqpe7qWypib5h
	GC7MPl/K5+ArKVbX03c4s6jQ6dhUNIqWyq6ID5TE0LkqUWa0tXad
X-Gm-Gg: ASbGncthwUix2MdDTAy65BBa0x55vFki94oCKnSqCAX/vODHqA1s4r1emxLQePNKOlD
	3o4Ql7XeyyQgMx0eRZ+n6U5guMnl44qqGUBT1i4L8mL1XlgMiKyNKzWvTINhVuIbpJSbv2cmAkF
	XhW3sMbHGCUiO1pAYVp6aBnB+ad9aF0NDBpDYYOMoMlSpjXEM+0WlU7LvemwTUYkJqY+AgfCrdj
	8wbC40xQOma1GQNKBA7aAbD30A8iqpN/2HWgisKQHA=
X-Google-Smtp-Source: AGHT+IFwX9OvbLbQv21l5BOtuzLnDwPok95NP/ZAWXPIwbglS124i6VyQIj40KtX+19TAu5MdqfI6A==
X-Received: by 2002:a05:6a21:3998:b0:1dc:2a02:913b with SMTP id adf61e73a8af0-1e5e0459dbemr49383501637.15.1735463172035;
        Sun, 29 Dec 2024 01:06:12 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90b32dsm17228311b3a.173.2024.12.29.01.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2024 01:06:11 -0800 (PST)
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
	krzk@kernel.org,
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
Date: Sun, 29 Dec 2024 17:04:54 +0800
Message-ID: <20241229090455.51838-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <xiwaq7fapkkmohg743v36uzpxv4ib4o6upibh7fgvmfjiupy2k@zqxw53prsith>
References: <xiwaq7fapkkmohg743v36uzpxv4ib4o6upibh7fgvmfjiupy2k@zqxw53prsith>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Dec 29, 2024 at 12:08 PM Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> On Sat, Dec 28, 2024 at 07:34:37PM +0800, Pengyu Luo wrote:
> > > On Sat, Dec 28, 2024 at 5:58 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > On 27/12/2024 18:13, Pengyu Luo wrote:
> > > > +
> > > > +#include <linux/platform_data/huawei-gaokun-ec.h>
> > > > +
> > > > +#define EC_EVENT             0x06
> > > > +
> > > > +/* Also can be found in ACPI specification 12.3 */
> > > > +#define EC_READ                      0x80
> > > > +#define EC_WRITE             0x81
> > > > +#define EC_BURST             0x82
> > > > +#define EC_QUERY             0x84
> > > > +
> > > > +
> > > > +#define EC_EVENT_LID         0x81
> > > > +
> > > > +#define EC_LID_STATE         0x80
> > > > +#define EC_LID_OPEN          BIT(1)
> > > > +
> > > > +#define UCSI_REG_SIZE                7
> > > > +
> > > > +/* for tx, command sequences are arranged as
> > >
> > > Use Linux style comments, see coding style.
> > >
> >
> > Agree
> >
> > > > + * {master_cmd, slave_cmd, data_len, data_seq}
> > > > + */
> > > > +#define REQ_HDR_SIZE         3
> > > > +#define INPUT_SIZE_OFFSET    2
> > > > +#define INPUT_DATA_OFFSET    3
> > > > +
> > > > +/* for rx, data sequences are arranged as
> > > > + * {status, data_len(unreliable), data_seq}
> > > > + */
> > > > +#define RESP_HDR_SIZE                2
> > > > +#define DATA_OFFSET          2
> > > > +
> > > > +
> > > > +struct gaokun_ec {
> > > > +     struct i2c_client *client;
> > > > +     struct mutex lock;
> > >
> > > Missing doc. Run Checkpatch --strict, so you will know what is missing here.
> > >
> >
> > I see. A comment for mutex lock.
> >
> > > > +     struct blocking_notifier_head notifier_list;
> > > > +     struct input_dev *idev;
> > > > +     bool suspended;
> > > > +};
> > > > +
> > >
> > >
> > >
> > > ...
> > >
> > > > +
> > > > +static DEVICE_ATTR_RO(temperature);
> > > > +
> > > > +static struct attribute *gaokun_wmi_features_attrs[] = {
> > > > +     &dev_attr_charge_control_thresholds.attr,
> > > > +     &dev_attr_smart_charge_param.attr,
> > > > +     &dev_attr_smart_charge.attr,
> > > > +     &dev_attr_fn_lock_state.attr,
> > > > +     &dev_attr_temperature.attr,
> > > > +     NULL,
> > > > +};
> > >
> > >
> > > No, don't expose your own interface. Charging is already exposed by
> > > power supply framework. Temperature by hwmon sensors. Drop all these and
> > > never re-implement existing kernel user-space interfaces.
> > >
> >
> > I don't quite understand what you mean. You mean I should use hwmon
> > interface like hwmon_device_register_with_groups to register it, right?
> > As for battery, get/set_propery allow us to handle charging thresholds
> > things, but there are smart_charge_param, smart_charge and fn_lock to handle.
>
> Please push the smart_* to the PSY driver. At least it makes sense to
> move those. I'm not sure about the fn_lock one. If you have a separate
> EC-based input device, it should go to it. If not, let's keep it in the
> base device.
>

I see, so can I fix it in v2 like this?
- Using device_add_groups to register smart_* sysfs in PSY
- Using hwmon_device_register_with_groups to register thermal related sysfs in base driver

> >
> > >
> > > > diff --git a/include/linux/platform_data/huawei-gaokun-ec.h b/include/linux/platform_data/huawei-gaokun-ec.h
> > > > new file mode 100644
> > > > index 000000000..a649e9ecf
> > > > --- /dev/null
> > > > +++ b/include/linux/platform_data/huawei-gaokun-ec.h
> > > > @@ -0,0 +1,90 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/* Huawei Matebook E Go (sc8280xp) Embedded Controller
> > > > + *
> > > > + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> > > > + *
> > > > + */
> > > > +
> > > > +#ifndef __HUAWEI_GAOKUN_EC_H__
> > > > +#define __HUAWEI_GAOKUN_EC_H__
> > > > +
> > > > +#define GAOKUN_UCSI_CCI_SIZE 4
> > > > +#define GAOKUN_UCSI_DATA_SIZE        16
> > > > +#define GAOKUN_UCSI_READ_SIZE        (GAOKUN_UCSI_CCI_SIZE + GAOKUN_UCSI_DATA_SIZE)
> > > > +#define GAOKUN_UCSI_WRITE_SIZE       0x18
> > > > +
> > > > +#define GAOKUN_TZ_REG_NUM    20
> > > > +#define GAOKUN_SMART_CHARGE_DATA_SIZE        4 /* mode, delay, start, end */
> > > > +
> > > > +/* -------------------------------------------------------------------------- */
> > > > +
> > > > +struct gaokun_ec;
> > > > +struct notifier_block;
> > >
> > > Drop, include proper header instead.
> > >
> >
> > I agree, I copy 'struct notifier_block;' from
> > include/linux/platform_data/lenovo-yoga-c630.h
>
> Please don't pollute header files with extra dependencies. It's usually
> better to just forware-declare the struct instead of adding unnecessary
> include.
>

Both of you are resonable. So how?

BTW, Krzysztof said

> > You need kerneldoc, in the C file, for all exported functions.

So Dmitry is here, I want to check again, should I add kerneldoc for all
exported functions? C630 one never added all kerneldocs. In my driver,
some function names have already indicated many things, some complex
functions have been doced.


Best wishes,
Pengyu

