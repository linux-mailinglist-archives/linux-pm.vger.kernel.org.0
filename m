Return-Path: <linux-pm+bounces-19828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ECF9FDFCD
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 16:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB407A1916
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 15:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA8189BB3;
	Sun, 29 Dec 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Letu+Jnb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DC158558;
	Sun, 29 Dec 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735487830; cv=none; b=Od09pZQdtr/2or/XolQNfFnUSKifS8DH9NJBVyZ4duXb1oM2ZFAuf72uTpzpC85XDU6pPsfFRPRU4qA+PJmKkBccs3VsIIhpJe0g1qznHEI9gPEqYokQcYo/ppERWYu1o1k9B82U4PBcMwMx3U6egSmieOIyNJs+Ekx8gBHiSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735487830; c=relaxed/simple;
	bh=G16g7KhEhjfIaudKqWTvS9Wi3zg//U58BvnfaCgV9EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d84nDTE+lrT0bD2mjRxHsLlynkygFkL8EsZFNnl6Nr505wVKS9l846GfHWUI3Z0PX6usNu2cVuHluMocbEs6LW4zHpVPCWdXv9t9li1a8vGyw71I/z3fQDTKhN5/LOn+LyL0TyTqtScnFdOL2hc2lXunbi62zek5WD14ZMgyg3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Letu+Jnb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21654fdd5daso101914245ad.1;
        Sun, 29 Dec 2024 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735487828; x=1736092628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ro8nEOno/QbT8NzwPYno2ZIV4TEwLo2uUCFVPIvSrs=;
        b=Letu+JnbDoFrdinF9HWadB1OuvyCiISJtjM8jApV4QusmfCth0+gXLhFUJaSWNCiX7
         oqc3JkhLmT08y+v1+RPuaf+wTxUl2YmU8BDxFDnyPEoYXdaxWH2pbz1HGSkZoi7q3kH4
         +/FRogLn7vBbiaGU8xJOL21b8wQ1KTKvYhH9D0kAHICC//x6sbFL/A9Vfn/3oH64Gz+T
         9zYt2hcJJEjo/iDy0JKASSriBkxM/T1JAGoo0XejwrZ4W9GYAUcFmKOvkI5mCOZ0H5J8
         BhNR8KdDzRbluxE/+MUr+1uv/caVTyt805pqUZGU2yr8yM293Kq29i+fdiopPYOR57mL
         oiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735487828; x=1736092628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ro8nEOno/QbT8NzwPYno2ZIV4TEwLo2uUCFVPIvSrs=;
        b=fI6jdIb3UlixoFH56CvnaMrY7dzL1/pdY5lC6Iisf3js7iWIfdrxqd++mGeQuaf+Pz
         AEnadvG3kAu9BYpOEHE5l6+PdrrHsHKpmHQ7iWUJBuB9dVqwHzVRYw3kZEcgfU43cdK4
         t1VxV0StfR2UBzz/wUxpXhTDzwTyBGJ9/u7Wx0cf1UShvRl/2xngfHE0iSQYqBpz6nHP
         UulqGRDljm6ykCBduBFEtcFGWUI9K1ESQ/5YRvR0B3MCaUAdoaxQ/6D0zncRQKCh4G/7
         IHThAS0oyrALf4yU116flNfKSjnI8LCZzcm5JQVkdOmrbCAOj18r2wJb3TkuIjVP16lK
         rWYA==
X-Forwarded-Encrypted: i=1; AJvYcCU/1o+fBWAAICEjEpjefpQstq3XkZFKDiKii5KHVT4lXgAQI4EL2bZ5i2mFBAt3Kb5PL1fuCtIwukN+/Viplg==@vger.kernel.org, AJvYcCUvMITJshBvDAOj6PRud7fPxBjBbXlD1DuRzGcQfrz11ywtt+dgH6UBlPQwAl+Z8dM4RAY3umNJDqvz@vger.kernel.org, AJvYcCVsK7E+ZTDDakAPA0cS+aM3ox/yiuRhYzIc7rvzGJAviySOP4hANFfwPSBtEarQSYQGmMAOYeGF7JM=@vger.kernel.org, AJvYcCVtEb0pN58t73Nh1guP4NxhjxAykWVnFgKkEHdAVvnDHk00dVLLZTh6Xtm35b1k+CujD6Sg6T+kWO/U@vger.kernel.org, AJvYcCVzRceAdhodz6whP1pKNdHFyYHz6Ae/CUhRc3g/EW6mHYTVQW2XKCCsDAc+UOng3JltGrNASvwmUa68JjuY@vger.kernel.org, AJvYcCX2+/sqjKF7y+UZPiSwC7Z0YcKf/NveGilAvnWJD2RCR4Q1uQZUMUBFdKnhjeoGR4AkRU7c+q9hJJCibv13maUU0yrCIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tGL6aJ9IFBT1occF4SuGZt0m6YndmemFCEzLDgu/nTvVidpI
	AKwDxNb0U+1FLD+5SB9JeSXn204ZIu4CMPA+BmayACt3A5rC5wA/
X-Gm-Gg: ASbGncsFMQBXOZhxBPe1jOyD9Be/gWZh52mTS6sqGi+P4ubLgyM3pzCUV49t6Kg2O31
	M+2qd4K+MtI8nWxcf7Fka0OrYqw2jacC1p8qink5B9KJb9g/ykHUgjYjmjq8yh6uuHJdUmWWnFC
	A/43VICZOJgKUlZ4N/Im6iCM+x+5paJfkA/oZNWcrKcjoaaKv9vChFCsjPqb0Rpgww1PxhnEPSR
	15t0HQWH4w17dAKy7hyJPfiHFeDgYfr1HUejnhe5Ik=
X-Google-Smtp-Source: AGHT+IF6r2x7M7+0yQmWqW6UcsDaYxKqFljH8VIFuOI28HDoZuK/ySWlmbqUnoC1M5YPTSTGqZ/pww==
X-Received: by 2002:a17:902:ec8e:b0:216:7926:8d69 with SMTP id d9443c01a7336-219e6f42b41mr410920845ad.47.1735487827828;
        Sun, 29 Dec 2024 07:57:07 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a267dc09bsm35062135ad.169.2024.12.29.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2024 07:57:07 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	heikki.krogerus@linux.intel.com,
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
Date: Sun, 29 Dec 2024 23:55:51 +0800
Message-ID: <20241229155551.92070-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <41e8cc85-6978-49b0-7216-3ce715d48101@linux.intel.com>
References: <41e8cc85-6978-49b0-7216-3ce715d48101@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Dec 29, 2024 at 11:33 PM Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> On Sat, 28 Dec 2024, Pengyu Luo wrote:
> > On Sat, Dec 28, 2024 at 8:33 PM Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
> > > On 27/12/2024 17:13, Pengyu Luo wrote:
> > > > There are 3 variants, Huawei released first 2 at the same time.
> > >
> > > There are three variants of which Huawei released the first two
> > > simultaneously.

[skipped]

> > > > +/* Thermal Zone */
> > > > +/* Range from 0 to 0x2C, partial valid */
> > > > +static const u8 temp_reg[] = {0x05, 0x07, 0x08, 0x0E, 0x0F, 0x12, 0x15, 0x1E,
> > > > +                           0x1F, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26,
> > > > +                           0x27, 0x28, 0x29, 0x2A};
> > > > +
> > > > +int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 temp[GAOKUN_TZ_REG_NUM])
> > >
> > > int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 *temp, size_t
> > > temp_reg_num)
> > >
> > >
> > > > +{
> > > > +     /* GTMP */
> > > > +     u8 req[REQ_HDR_SIZE] = {0x02, 0x61, 1,};
> > > > +     u8 resp[RESP_HDR_SIZE + sizeof(s16)];
> > > > +     int ret, i = 0;
> > > > +
> > > > +     while (i < GAOKUN_TZ_REG_NUM) {
> > > while (i < temp_reg_num)
> > >
> >
> > It is a constant. But later, as Krzysztof suggested, I will use interfaces
> > from hwmon, then reading one at a time.
> >
> > > > +             req[INPUT_DATA_OFFSET] = temp_reg[i];
> > > > +             ret = gaokun_ec_read(ec, req, sizeof(resp), resp);
> > > > +             if (ret)
> > > > +                     return -EIO;
> > > > +             temp[i++] = *(s16 *)(resp + DATA_OFFSET);
> > >
> > > What's the point of the casting here ?
> > >
> > > memcpy(temp, resp, sizeof(s16));
> > > temp++;
> >
> > A 2Bytes symbol number in little endian, ec return it like this, so
> > casting.
>
> You should use __le16 and proper endianess conversion function then.
>

Agree

> It's bit confusing that in the declaration you used RESP_HDR_SIZE and here
> you do it with DATA_OFFSET instead. It feels DATA_OFFSET is unnecessary
> duplicate of RESP_HDR_SIZE and will easily lead confusing variation such
> as above.
>

I totally agree with you, it is duplicated.
In declaration, u8 resp[RESP_HDR_SIZE]; RESP_HDR_SIZE indicates the size.
When assigning, val = resp[DATA_OFFSET]; let us know we are extracting a
data from a response without thinking, so I added an alias. Removing it
is also fine for me.

Best wishes,
Pengyu

