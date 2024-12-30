Return-Path: <linux-pm+bounces-19846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBE09FE558
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 11:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14023A197B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B73A1A0BF8;
	Mon, 30 Dec 2024 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC+ZGdHB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14013633F;
	Mon, 30 Dec 2024 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735555530; cv=none; b=rzbRPwkduz6Be57BrO/iTIuSFw0GKatoXCA11XQchsa37SFz8nESVi1bnuvBQv1flv2J4h/H/dpFuNijAWO5/OdRbJjNFCFmzmjwVxQa8Q5AGGrlLlrp3TWz2yU8TYsUhIrGdXHM28+bcoel95fY+tulzjR18O5f8+kmPgHDBvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735555530; c=relaxed/simple;
	bh=L0/ZkxSibT+4mHc0CmZI6VPxe/6USTCaDZxPkpbmd7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dm4qB3l14MHCQZYphYEgKd9opW3Ef94pSKuxE5lppJ8VNchG6ZgmYgWHXD7r+12+2jrcUHXOBB8SA4V/iiHzwXWJueBG6hl7XggM6HluzTl/xuGX8f2Zqff8LDC65C/nFUBHI2i42fWGUPSL1DGXbmgDAJQlgnOtJQLXhaTnrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC+ZGdHB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216634dd574so77800905ad.2;
        Mon, 30 Dec 2024 02:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735555526; x=1736160326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APaYFD30RudnEgnmZHaXtaG597yFzOWoROkKl7BwD44=;
        b=QC+ZGdHB7suEOXaO4bVPKr0C7Zr1jru0HybSqTsyHJl+s0kSpLsN7lAUkp1cTzfXgH
         5nnaXNORDfn99AtaTVDb4gcTwuHpfDxBgqC5riMf6R/A4RGk4EAc9odLamshnYUgrHU4
         EbcFz6px7mk97d0EXXL+x8APLQf76jYm3CCl+KaSvs+14kO36PXWPrRc0WX8IOeGQvXh
         3cIv1kckp3PDED2VJtS3b+K+Kt2bwX+JREBnuS26Zq8kH8poiMzSukQfFyuhrKVOhd7h
         SgOKrCsVKU6eiz+HxWuVfh3eQod4kNorPhCNyOrl0spTOlhvqaylg7iwma0E0phWN9nT
         YiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735555526; x=1736160326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APaYFD30RudnEgnmZHaXtaG597yFzOWoROkKl7BwD44=;
        b=WKHdGOr6RgZwE88wVU52LaBQt0HWPWNkT3pkmOUJB+CBF6KgjvtFyMYGF7DW/venc2
         JzRW494O2U7dnFBhU/7u+pp1xsrVzeTxP7zGnxqLFOGF/mdsUjAM3lZKM8Ff9wczUxZl
         Q47z2nW3hpb40f38DayJBz/Hgm5/3j1/ejhkOdXQBTR0Wm+zm7QNIaoNPTJHF2Fxeeus
         nT0wd7L/WUXwLnv7eOa/Z9/G222slCldQY543TWfQeT+59YYvipg2FgV8+CrFiCqY4m6
         tFEDlFnPZz8dj4K1HVp7+itTwsbl/Gxp74lONyCFGnS2J0Br25dPd0JRg8oRTjJD3qYZ
         Q9Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVapQn7yj83b3Mzset5OWSsytVGHd3376Oc54ZXDt431Rc80ebSh56Xo4XM5NUbx14SwKSfQJBlzck=@vger.kernel.org, AJvYcCVtzlhaZjm53K3dG6Bh5QRisG6VSK/aIVKORRYyF/pjhSsQ9yZC7OaEWIcxilxWdUdnt6rgixdWriB/ZWdd@vger.kernel.org, AJvYcCW9s02EVAeYFdQ/LwXFjxl0LKggf0XDkutVztu8MRDbz7bAU8dS8Qa+QCTYH3rJj3+Yrw979MkHAEfrKh5vIBUyte0nIA==@vger.kernel.org, AJvYcCWLJDw8mcbc0xotcPOc4F42dVvms7em1OQ53eG36vcu64tK3Hwd6jsM2C6IGl/0eKP+BDZOA4zTP7nH@vger.kernel.org, AJvYcCWOPwWiJw4rk+PHYiwy7rZbdwEyy7jvSpSAb4D40R6hia9oQadsC7C9mPhQBy/jzBUkZ3ysDF4ODCYFhiXraQ==@vger.kernel.org, AJvYcCXK+WI2X06YrPfMpRNR0jokeBWSVlLjJQBNygsVcZYMj7VG3TY2yIRURTQg3Hm1n+/Sp0lA4DUwVpWX@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGUm3/QbPPq5GObTkBk4rJEP2glC6r3vyKrViOkxf26sLcn+G
	jBrVVyB546os0NKmPPIvaYgSkx781DsPsQK6jdULOYipNys7KwSw
X-Gm-Gg: ASbGnctwlYjdVgxvLeAf9HV7MF5uN17f0Vzd88mC5nUIkSGLpBqfga0KP8V+c/rzrns
	tDJQnTzQtcIAb0PZvjwiBLJ8aQ98kz60d2wax9dj0FemzDViJeLeZdv0pkZ6ecJQg3F+mbhcSPA
	MXoOPq/xLph50lRA5fHCaL1MCsgmKrWRFc9LYgC9o+7diylm1jmAe2Dg6w1l6WFME2b39m3KaW9
	peGRTZCuKOJ1c2HU70TXV/Pm5rEtns4Ju9jpJB54a0=
X-Google-Smtp-Source: AGHT+IH6yrNe9TzPma0TrHyfew/WREVGdiQnOdhU8EJOBjK4tTim7ABUoAf5J9acdKapFrt6vZdqSA==
X-Received: by 2002:a17:903:2306:b0:205:4721:19c with SMTP id d9443c01a7336-219e6f1448cmr438389625ad.37.1735555525838;
        Mon, 30 Dec 2024 02:45:25 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde7esm175594515ad.152.2024.12.30.02.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 02:45:25 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: quic_aiquny@quicinc.com
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
Date: Mon, 30 Dec 2024 18:44:03 +0800
Message-ID: <20241230104404.184616-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <564fcad7-59d5-44da-8ed7-78fade8e40a8@quicinc.com>
References: <564fcad7-59d5-44da-8ed7-78fade8e40a8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Dec 30, 2024 at 5:04 PM Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
> On 12/28/2024 1:13 AM, Pengyu Luo wrote:
> > There are 3 variants, Huawei released first 2 at the same time.
> > Huawei Matebook E Go LTE(sc8180x), codename should be gaokun2.
> > Huawei Matebook E Go(sc8280xp@3.0GHz), codename is gaokun3.
> > Huawei Matebook E Go 2023(sc8280xp@2.69GHz).

[...]

> > +#include <linux/mutex.h>
> > +#include <linux/version.h>
> > +
> > +#include <linux/platform_data/huawei-gaokun-ec.h>
> > +
> > +#define EC_EVENT             0x06
> > +
> > +/* Also can be found in ACPI specification 12.3 */
>
> It appears that the following EC commands are common to all ACPI-applied
> embedded controllers. Is it possible to standardize these commands and API?
>

No, I mentioned a little in kerneldoc, EC_READ only works for psy
related things.

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
>
> ARRAY_SIZE(msgs) is suggested instead of pure 2.
>

Agree

> > +     usleep_range(2000, 2500);
>
> Why is a sleep needed here? Is this information specified in any datasheet?
>

Have a break between 2 transaction. This sleep happens in acpi code, also
inside a critical region. I rearranged it.

Local7 = Acquire (\_SB.IC16.MUEC, 0x03E8)
...
write ops
...
Sleep (0x02)
...
read ops
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
> Could it be made more readable by specifying the macro names for 0x02
> and 1? This would help in understanding the meaning of these numbers.
>

I really don't know the meaning of master command 0x02, 1 is the size for
the data_seq behind of it. There are many possible sizes. It is not a good
idea to define a macro name for everyone.

> Also, please ensure the actual size of the request buffer is handled
> properly. In gaokun_ec_request(), the req is passed down directly, and
> the i2c_msg.len is used dynamically with req[INPUT_SIZE_OFFSET] +
> REQ_HDR_SIZE. This requires the caller to carefully manage the contents
> to avoid memory over-read, making the code difficult to read.
>
> Creating a defined macro can help you avoid manually defining the size.
> For example:
> #define REQ(size, data_0, data_1, args...) \
> u8 req[REQ_HDR_SIZE + size] = {data_0, data_1, size, args};
>

I think wrapping like this is not recommended, see '5)' in [1]

Best wishes,
Pengyu

[1] https://www.kernel.org/doc/html/v4.10/process/coding-style.html#macros-enums-and-rtl

