Return-Path: <linux-pm+bounces-16111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E689A6D94
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638911C21C84
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5851F8F14;
	Mon, 21 Oct 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iivwPXPq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D451F4713;
	Mon, 21 Oct 2024 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523095; cv=none; b=XOD0vygVZqKb36G1yEYhZdbibBCifi0awTmhQ54otHWx1XG1WF9R7WJdFD3UN45thrqaAIpqfw+/9sb5OHDlewBOYIlPPzzth3Cg5NUVlDa7jISpxrnDHIhWd/33olbnwH2ti6kYOuJ3is9GBQMfDU1rI9zMDGZOAVtfbUAyX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523095; c=relaxed/simple;
	bh=7RZ2FleI+lwkQBnS71UwBmagAUNQishsx/OuSEHgZXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAZ33Zch/IJdRvS7PYqc3kMkBoXvZIn/IAJylj8olcdiNV9ryiDsG28XC3SGF24o6UwqC6GOuohiml4DCFeUKB8+a4fYYBFWhQriVdGKSMwhr9eHQaWS8hfcMjw3o+5FwwMBdRPYjKqSG5eP1GIan/5wLes0Bc10P877k+dLiB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iivwPXPq; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-715716974baso2685349a34.1;
        Mon, 21 Oct 2024 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729523092; x=1730127892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HkHKVQQZOiFvIJXD4A49RfSsdZno+Y8yFuWG+vCWgIk=;
        b=iivwPXPqOumesGn/zGgkiK9YXzLNePw/YYwj9D6b4qpq5j8/MfWqYtPhv3/PHhPvhK
         B9JmoHIlrC1q0ov9UpsAMyW/+3pBJdkoBjvCrlbS/Sl4leQ3K/UlV4oN8URMnvdUrJ5V
         aUkzB6u5JN+P7nR+a7v0AQLaq3OTYBMKLrLBitUWuW7QjKIhcaCl1+CN69z8JoUi1/jc
         tf1MvkYPmBTdBFvgY/kR9BNXDi+FGUCFKHd5SOlPrvEjoMQ/sqNmulq3THu3/3xF4J/f
         dwoagCv45vg9FLjEmaDKwhLOOAeSw2rKndRvP6/wTHatNfW/0yg0Tj/a4n+YJiz4Lm5i
         Y/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729523092; x=1730127892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkHKVQQZOiFvIJXD4A49RfSsdZno+Y8yFuWG+vCWgIk=;
        b=mPcox/ZNL8Nr5eLWuUf/ZC5WYhrRU6xyaiEOcwwVrmB/asiyN9YAFCwm8Yj0ZAGfnL
         OqX9PW8qikFo1XBlzPDur6D2fpXMxH5ZiVYBm7e9VzlqZ5EF47xUWwn3U4EgCnJ5LYzA
         2mKNDXqYFHMSzSveyAq7aErEKhF8Vz3Cfxm3j0RjvhTuAvOgJX3OEOjjAfOtQnYWrXWR
         CKrs+E7TmmYAd789PiKFFPEZstNL7FTj1CZ0j+H1teMxvwobO2HJjBSkzW8S45tj14Oq
         AEFMP/Q/pU7QSd0jzU/eMAT3xUizzuSXU2gjie6mXukRIMHxGEWhI+HJcPE65gEV2Rz0
         aj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/VHrkIvBGs0hA6tu72v9h6EhCAsG00Sdg5iEPpgjr/fAHSVjwoOMBIHpdTxqpjwBoh4MsFoaohMqeW+vf@vger.kernel.org, AJvYcCW+hQu1Yxf7fqLaJ3/MWdy1df2sHHqTPF44ncg0MyfbafdHAyLdPsD20pT80gUfdbgBYwWN94G+trfF@vger.kernel.org, AJvYcCWMtvaQnUDgHpzPpP5hNo7k04UruYa5agpbSjVtXYcsHqCFZYvDzhAEwmA2YvdjV54KZHZMaVtk0PjBSA==@vger.kernel.org, AJvYcCWlGPJUO/Q9s12G1nlYXRhuG1jmTL389mXfeVSlO25g1wdHpGGaGE3rfhs0QItCFMQ9z8jGrM3pmxufz9w=@vger.kernel.org, AJvYcCX0SCOYnGLFoZQV9eXP/TiKAKGf1DcEMk0nTaee0pkgr96Z31QJwC+UsCmYodI33Bw9M7WMGaAyl38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRu4TjTD3qMg8a6+bzNgz3a5DCxwuuLtifPu6NM1ktVpqVixiV
	V/zxdazLn45aKiPaAlPebxPmIJ17yRgkC0ubBpqbWoeRECffu48BPuLiGodczI28eCerGBhXzwr
	ozbPDy5ntkfUPSyk2prnav+2wS/Q=
X-Google-Smtp-Source: AGHT+IEZIMiuefKxT+GJW54sVo2g5FwsIkVDpDQOvwfStSdupUdcWV8p8l3S3dr51HZ9W73K5w87ivtfmrcvSV3jexA=
X-Received: by 2002:a05:6808:210d:b0:3e5:c7f8:ad7d with SMTP id
 5614622812f47-3e602da0447mr9391319b6e.39.1729523092022; Mon, 21 Oct 2024
 08:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
 <20241007-starqltechn_integration_upstream-v6-3-0d38b5090c57@gmail.com> <20241015140224.GI8348@google.com>
In-Reply-To: <20241015140224.GI8348@google.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 21 Oct 2024 18:04:39 +0300
Message-ID: <CABTCjFBpdMv6Qi3CLYNukMn+J1FwhbAg0hMy075Dt0H-g_hrUw@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] mfd: Add new driver for MAX77705 PMIC
To: Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
> > new file mode 100644
> > index 000000000000..553f20a6cdd5
> > --- /dev/null
> > +++ b/drivers/mfd/max77705.c
> > @@ -0,0 +1,248 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +//
> > +// max77705.c - mfd core driver for the MAX77705
>
(...)
> > +// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
>
> Only the SPDX in C++ comments please.
>
This conflicts with https://patchwork.kernel.org/comment/25898728/
> > +
(...)

> > +++ b/include/linux/mfd/max77705-private.h
> > @@ -0,0 +1,180 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +//
> > +// Maxim MAX77705 definitions.
> > +//
> > +// Copyright (C) 2015 Samsung Electronics, Inc.
> > +// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
>
> No C++ please.

This conflicts with https://patchwork.kernel.org/comment/25898728/

>
> > +
> > +#ifndef __LINUX_MFD_MAX77705_PRIV_H
> > +#define __LINUX_MFD_MAX77705_PRIV_H
> > +
> > +#include <linux/pm.h>
> > +
> > +#define MAX77705_SRC_IRQ_CHG BIT(0)
> > +#define MAX77705_SRC_IRQ_TOP BIT(1)
> > +#define MAX77705_SRC_IRQ_FG  BIT(2)
> > +#define MAX77705_SRC_IRQ_USBC        BIT(3)
> > +#define MAX77705_SRC_IRQ_ALL (MAX77705_SRC_IRQ_CHG | MAX77705_SRC_IRQ_TOP | \
> > +                             MAX77705_SRC_IRQ_FG | MAX77705_SRC_IRQ_USBC)
> > +
> > +// MAX77705_PMIC_REG_PMICREV register
>
> No C++ please.

This conflicts with https://patchwork.kernel.org/comment/25898728/

-- 

Best regards,
Dzmitry

