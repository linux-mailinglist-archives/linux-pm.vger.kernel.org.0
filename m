Return-Path: <linux-pm+bounces-11347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B67F93A3B3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 17:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265DC1F24086
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953C156F4D;
	Tue, 23 Jul 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9dN8cXq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B823153BE3
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748229; cv=none; b=QtR+lA3721fGU1V1XMcfC5Ckciz1PEfZKdZ5l72JrGBcdVkMC+qFezUOMCAr3gFWNHUlSBDhKjaF8poCueXIlbmDoyk7tfj3tNFNb27U8wUgU3wNxFNIDu4vu7f7DGKkHUNZwPsXsqQ8f4phkm5qOTfm8R/v5jfNaOBMehqDeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748229; c=relaxed/simple;
	bh=9a1m8wCw15p882FhgcOXJOX77YRxNGDibajWEZXzWeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6iDuBJCNBhahCBjIBp+WgI8myW+N5FyA7ocdlTrvsdV7xKb9CVmni0neqZIIESazNQwRWyBfj1OSkkjyugH2IPHY51yy/ra95iNazxVrakKI+6yZwpyLlUXKvPYFvqHtbzYV664hOk/iBjy4t6/3ZFuZvPax4f+p+xuhEgyTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o9dN8cXq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-654cf0a069eso57737627b3.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721748227; x=1722353027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmjktW+fy8V0urjYafMHY3WUuL7GfZ0ePI4CjTduJBY=;
        b=o9dN8cXqCy5OTESuTSiJ/RYVgTDh6U+j79QlcdGzJgY0fhb6kC1jO5paz+0etJwpIy
         v4X1Ig7uQPDTYbv6mb3rA/817S5DRyjHiq83hUA+Fspwvw8KfISXmaW9y3cj82vglYRH
         so4bwZNumbrMvHX7IqmClMQB2k4YRsptkEn+Xwe1dtWMqM14yjG5m3eRcriZOS6pTOtS
         PvLgTd1zvuNnitCUTj199NHR7JMIy7QmjGlXvYd9IbIWYtcIrkR5WI039wIngu8N0k26
         Zf27uvZEEi3yvIeW1TZX/jEh+NLQmlxvoHcOrE1TBAq3/8+qoW4aDeKhztbfLVcAyxcQ
         oWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721748227; x=1722353027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmjktW+fy8V0urjYafMHY3WUuL7GfZ0ePI4CjTduJBY=;
        b=sz4f7HhjytxdHSu+l55bIjn6kMH/ZCSYgE8Xwp3NFafY++uOHijUmhrH/oZpORV7vU
         4lwZH2yMxBwKk1ZmYa95q9veI6dKNfuQr8yiYE7pft07pozJBTQ0qZdJBF4avW2x/5sl
         6ZkdnEyk2fdbXz19rSPObpmRgtiez+tquEi49qPwZvnLfT87oXQBDJJl6F7DQEksIRwO
         UCmJK2NPL0XLKmhZWOmjfJeJsqSjHroudD4L1bHdDD0ene1LOWjUdXpsqPJC9mxlG0qW
         Pvm30JIyQqIEW9DE0NCAoRQ+DdZwSgIDZTfLV1OwLFw13DI3IEN6oAwDX5hOss9/wAlc
         8hRw==
X-Gm-Message-State: AOJu0Yy34uzT+/l0t1XsgLRrWKoNt+ktVSa1x4yC4KNdsCDvrrLR6yw0
	Wu4o8OOPuN1/dWW5ZQgK5myFfvuGjxZuDQmxGKemvyutK0CRsCLJywhQ+Nv1tQ28daApLVOEKkZ
	A3WxPVEcqXWxSFRYQucnk0YmeXfg7xchBp7urWw==
X-Google-Smtp-Source: AGHT+IFNhYPefrkyhvZ5EiwckdgofM6l9C3j+l80SPqYeQxgCB1HTAyW3/snR2cX8yS7q1mpdKGAE7N7Tba1WvQLuX4=
X-Received: by 2002:a05:690c:2886:b0:65f:86a2:b4c5 with SMTP id
 00721157ae682-66ada72f761mr103148437b3.31.1721748227226; Tue, 23 Jul 2024
 08:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240723141705eucas1p1bbe72a6d543031a41efdbe81d1b03ac3@eucas1p1.samsung.com>
 <CAPLW+4n6XB3fm8KQA=6_2z8ay9pDPtu-VFgAaW5imZkRH2ywkg@mail.gmail.com> <20240723141658.374755-1-m.majewski2@samsung.com>
In-Reply-To: <20240723141658.374755-1-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jul 2024 10:23:36 -0500
Message-ID: <CAPLW+4katjgDUS+e4+iYt+Cz_pKizLFUxqV4KGnbQ5ekAq9Mvw@mail.gmail.com>
Subject: Re: [PATCH 5/6] drivers/thermal/exynos: add initial Exynos 850 support
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 9:17=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> > Do you know what are the possible implications of not using ACPM? As I
> > understand, ACPM is a Samsung's downstream framework which uses APM
> > (Active Power Management) IP block internally to act as an IPC
> > mechanism, which makes it possible to offload any PM related
> > operations (which might get quite heavy, if we are to belive the TRM
> > description of APM) from CPU to APM. I'm not against the direct
> > registers access based implementation (in fact, I'm not sure how that
> > APM/ACPM thing can be implemented in upstreamable way and if it's
> > worth it at all). Just curious if we understand what we are
> > potentially missing out, and if at some point we'll be forced to
> > implement that ACPM thing anyway (for something else)?
>
> Not sure honestly. The downstream v4.10 driver does many operations on
> registers anyway...?
>
> > Not sure if that's true, as already discussed in my comments for the
> > previous patches. Looks like one clock is still needed, which is the
> > PCLK bus clock (to interface registers) which might simultaneously act
> > as an operating (functional) clock.
>
> The code seems to be working correctly without this clock, both register
> reads and writes. Maybe the support for extra sensors, which I couldn't
> get to work, would require this clock?
>

Chances are that clock was enabled by the bootloader for us (or it's
just enabled by default) and it just keeps running. If that's so, I'd
say it must be described in dts and controlled by the driver. Because
otherwise it might get disabled at any point in future, e.g. kernel
may disable it during startup as an unused clock (when it's added to
the clock driver), etc. Let me enable that clock for you, and then you
can use /sys/kernel/debug/clk/ files to disable it manually and see if
it actually affects TMU driver.

> > Exynos850 TRM says AVG_CONTROL offset is 0x38, and 0x58 is actually
> > for THRESHOLD0_TEMP_RISE3_2 register.
>
> Thank you so much! Will fix in v2. Though writing to the right place
> doesn't seem to change much in practice, probably just means that the
> correct mode is being used.
>
> > Something seems off to me here. How come the shift value for EXYNOS7
> > case is 8, but the mask is actually 9 bits long? Does it mean the
> > first error field is 8 bits long, and the second error field is 9 bits
> > long for EXYNOS7? I don't have the Exynos7 manual, so it's just a
> > hunch. But if it's true, maybe this shift value has to be added in
> > your [PATCH 2/6] to fix Exynos7 case?
>
> I did not really want to mess with Exynos7 code, as we don't have an
> Exynos7 board sadly. Honestly I feel like I should drop the 2/6 patch
> completely and only modify the code to run on 850 correctly.
>

It feels like there is an error for Exynos7 case there. Take a look at
this commit:

    aef27b658b43 ("thermal: exynos: use sanitize_temp_error() in
exynos7_tmu_initialize()")

I think that commit just forgets to update the shift value for Exynos7
properly. This code:

    data->temp_error1 =3D trim_info & tmu_temp_mask;
    data->temp_error2 =3D ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
                EXYNOS_TMU_TEMP_MASK);

in case of Exynos7 becomes:

    data->temp_error1 =3D trim_info & 0x1ff;    // mask =3D 9 bits
    data->temp_error2 =3D (trim_info >> 8) & 0xff;

it contradicts itself, because it takes 9 rightmost bits for error1,
and then uses 1 of those bits for error2 too. It's obvious that if 9
bits are already used for error1, then for error2 it has to be shifted
by 9 bits, not 8.

That's why I think your patch 2/6 is legit and useful on its own, and
it's actually a good catch on your part! But the shift value has to be
fixed as well (for Exynos7). It's not ideal you don't have the
hardware to test it, but it just screams *bug* to me :) Also, maybe we
can ask someone who has Exynos7 hardware to test it for us?

> > Also, just an idea: those values (and other similar values) could be
> > pre-calculated somewhere during the probe, stored in some struct (e.g.
> > _variant or _chip) and then just used here.
>
> sanitize_temp_error is only called one per probe and once per resume, so
> probably little to gain?
>

Sure, it was just a minor suggestion to make the code look more linear
so to speak. It can be totally skipped.

> Will also do all other.

