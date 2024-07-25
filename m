Return-Path: <linux-pm+bounces-11381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1693B9E1
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 02:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2829284A33
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F801876;
	Thu, 25 Jul 2024 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dd5HV44l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD128F0
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721868184; cv=none; b=ewfa/tRV7J4KOcb85WqEAfdlAewZV4uDWr/M6AWEtMiM1rmsa/MF9IYDfP7wT16eZRqsU/lIugBHvB8HfgTS/pGFbz4x+C6MhBPodqynHh4GGyG9W5IaNnMVmVG+q28sqQHKbyr9ljItkGSit/TTzBUEe/xVvsSWFKXmVv4+ZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721868184; c=relaxed/simple;
	bh=HzbEhyH6CQSKj5F4Dm9OyKDhIk+BLndEJ2P5QSXbuBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zmb2FGmeSlFQbwPjTilZ+vzhYk5fOAkrSAYkBunELgU1/mtjmMbRTzVYcHdBAt/2PUmVp2l7RimWWTrSIjqweki0pKkXivc/JwyFjb0wz5di/zG0UuJZ/WOtbuKKWVY76n+9FHYK9G3R6N1qgpXRxB3XImeWxJQPhJPKwq/1EY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dd5HV44l; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-66acac24443so4603627b3.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 17:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721868181; x=1722472981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B70bSWuCWRs3nWRGRO/RkaDvHlyVjKHulybl7m4sgL4=;
        b=dd5HV44l564U7Hihb1kaYcnLYEHQTqPyb8gZu16LRQ+9n/coOFfdwypTI35FDAzclm
         vtdvjpCWskCvekdhKk6RbEsKJbHD4CVO/EFHdCpDJkea9Qg09tWPD6BqVRsjMxYZY+B9
         05CQ6AJojyJbO8xV/NXtiNOcoqFs3ievtZSUea9DT310aqOePOMowUQWiIy3DgmJlqh6
         kVmNMOKREEVGqLMXtbDZogywiY28kBT6WqoTvaEA4rSQNtF5ZWarJH/P7wEq8yhCUlRa
         5Ou7FFwIAbae5snWpjwVxyz3VVTsl9twTLchTeBhju5s7aJ9eUm+gzoKidvy/Si63K/x
         L2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721868181; x=1722472981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B70bSWuCWRs3nWRGRO/RkaDvHlyVjKHulybl7m4sgL4=;
        b=wQrUzTDD97O78sGufFM7blcHFFTaJxO7+SSb2KvDDFKGZlKYuxlh7IQW0MBJjrNSnM
         dcbx93hMBv4FDsuRkHknzPJyOSQmnwDS7R8o8j0IpYzwvtdh4OdKbiF8s0lALyDzmqKj
         siWguQnjEnpsLcwrLoUonslGT/3uk1X9BmAWHp0+Tln9jB0q9+vc2kjItich+EhJ1DNd
         bKGVXB1+wVdq3Yial5u0B4xBEvoKR5cMCDeuPV44AvPVbgsu6NkB1qgdd8FoAzDVZrcw
         NGYYXTGk/4WyKaPIeTSw+IPJa1ldig0s7Pn/0Mz+HWgIIEUgErwEG1kXWvp0w6RA04WH
         QS0g==
X-Gm-Message-State: AOJu0YxJq0FJUntPEsjK/G5gxwl+RPqx0Al8ht+GvW5qjtB4rm8pSSGP
	8PvO6wZg7nJwXSzp50uRgWq39GPk/9NhfPLUOVYBWzKgkdb+C8Qb5k4fMJcasXyo6NVoYsGT/U0
	XhPUVcUF75T8XcU1FqNzqWcNXdCQBXyJX0L4vjA==
X-Google-Smtp-Source: AGHT+IF7TiDuCEDbkwAje2qhS79WnbULiVERVV5UlHJQtoQ73YEMnKzJNC/LRpC29OM5Ud1uZxWCLaC1cLUPPwArDFs=
X-Received: by 2002:a81:7c8a:0:b0:65f:7cee:43b with SMTP id
 00721157ae682-675b4f3e950mr2941187b3.19.1721868181502; Wed, 24 Jul 2024
 17:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724153056eucas1p193056deacd26701e60519fa0466269f5@eucas1p1.samsung.com>
 <CAPLW+4katjgDUS+e4+iYt+Cz_pKizLFUxqV4KGnbQ5ekAq9Mvw@mail.gmail.com> <20240724153037.914681-1-m.majewski2@samsung.com>
In-Reply-To: <20240724153037.914681-1-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 24 Jul 2024 19:42:50 -0500
Message-ID: <CAPLW+4mEDJy7hXfQEzLdHuRfTAsRVuHqxh7VC_goR90DVXo3Cg@mail.gmail.com>
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

On Wed, Jul 24, 2024 at 10:30=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> > It feels like there is an error for Exynos7 case there. Take a look at
> > this commit:
> >
> >     aef27b658b43 ("thermal: exynos: use sanitize_temp_error() in
> > exynos7_tmu_initialize()")
> >
> > I think that commit just forgets to update the shift value for Exynos7
> > properly. This code:
> >
> >     data->temp_error1 =3D trim_info & tmu_temp_mask;
> >     data->temp_error2 =3D ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
> >                 EXYNOS_TMU_TEMP_MASK);
> >
> > in case of Exynos7 becomes:
> >
> >     data->temp_error1 =3D trim_info & 0x1ff;    // mask =3D 9 bits
> >     data->temp_error2 =3D (trim_info >> 8) & 0xff;
> >
> > it contradicts itself, because it takes 9 rightmost bits for error1,
> > and then uses 1 of those bits for error2 too. It's obvious that if 9
> > bits are already used for error1, then for error2 it has to be shifted
> > by 9 bits, not 8.
> >
> > That's why I think your patch 2/6 is legit and useful on its own, and
> > it's actually a good catch on your part! But the shift value has to be
> > fixed as well (for Exynos7). It's not ideal you don't have the
> > hardware to test it, but it just screams *bug* to me :) Also, maybe we
> > can ask someone who has Exynos7 hardware to test it for us?
>
> I thought about it for a bit and finally realized that Exynos7 only
> supports one point trimming. That is why in that commit, the original
> exynos7_tmu_initialize did not do anything with temp_error2. So
> temp_error2 will never be used in Exynos7. The real "fix" I guess is to
> only calculate temp_error2 if two point trimming is used, which is
> possible with a very small reordering of exynos7_tmu_initialize. But
> then the shift value will never be reachable in Exynos7 anyway. What do
> you think about this? I feel like it's worth it to change the shift
> value just because the code is a bit confusing anyway.

Good catch! Yes, makes total sense to me. I think it's like you said,
would be better to do both:

1. For 1-point trimming architectures: don't calculate error2, to
avoid confusion
2. For 9-bit temp length architectures: always set the shift variable
to 9, again, to avoid confusion and possible bugs

As I see it, the actual reason why that confusion happened in the
first place, is that the data is not really separated from the code in
this driver. Right now exynos_tmu_match[] table contains SOC_ARCH_*
constants for each compatible, and actual features for each platform
are devised in run-time (e.g. in exynos_map_data_data() switch, and
all other places where data->soc is checked). Because of all those
"ifs" the code looks very non-linear, hard to read, bug prone, and may
even reduce the performance. A better approach would be to extract all
possible data into some const structure containing all features for
each platform, and assign that const structure to corresponding .data
for each compatible. Maybe also add .temp_length field containing 8 or
9 accordingly. Having all that done, all the platform features will be
known at compile time and collected in one place, simplifying the
actual driver's code (most of all those ifs and switches will go
away). One example of such approach is drivers/watchdog/s3c2410_wdt.c.
This way the sanitize function could look something like this:

8<-------------------------------------------------------------------------=
------>8
static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info=
)
{
    data->temp_error1 =3D trim_info & data->tmu_temp_mask;
    if (!data->temp_error1 ||
         data->temp_error1 < data->min_efuse_value  ||
         data->temp_error1 > data->max_efuse_value)
             data->temp_error1 =3D data->efuse_value & data->tmu_temp_mask;

    if (data->cal_type =3D=3D ONE_POINT_TRIMMING)
        return;

    data->temp_error2 =3D (trim_info >> data->tmu_temp_shift) &
data->tmu_temp_mask;
    if (!data->temp_error2)
        data->temp_error2 =3D (data->efuse_value >>
data->tmu_temp_shift) & data->tmu_temp_mask;
}
8<-------------------------------------------------------------------------=
------>8

So this data driven approach doesn't leave much space for mistakes.
Anyways, I'm not asking you to do such rework, it's just my
understanding on the cause of such issues.

Thanks!

