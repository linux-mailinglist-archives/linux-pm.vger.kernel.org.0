Return-Path: <linux-pm+bounces-18112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4EC9D92FD
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 09:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86381639A4
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 08:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0430718D62A;
	Tue, 26 Nov 2024 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TPw8Rb0r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26A143748
	for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608084; cv=none; b=mpuWdj/ihDaF2Terarm2SFJ5lpsrJP20FZAxSchaHkOKp5gNegO2f1Rf8qhR4YJI13o0/EXLCpzZmuofOBviJ27OmzOUXMGpFGsMFf5apsPz5xoZFcUGgj+W5u+MZTHsisXdeIAs6LQjZo6xy/jsVy0zLzkbMCceB7rVnqY58HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608084; c=relaxed/simple;
	bh=jkeljPLfrEpojU1eb20valfuJzKAWnOgVQg12Lj7VQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIT/cjFogWJOBSlBINBsIdjgBDZKz9ALLy4Km00esRqwmoqmVThgSBjmY5B0mJzu4VRzVMDYWsgimYG3E86rT5AyJcXoq8qDPFn6STobaWQIzBweIWmUk+nRfuUPLqW0dAzMabcsfauYV/FFXKKhuXiAdivXxYeCUZMXVaoRo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TPw8Rb0r; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso10692359a12.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2024 00:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732608081; x=1733212881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmcqT3bZQMcjsucg2dQtWpXidNuyx+XXM3544HAZF0U=;
        b=TPw8Rb0rSMzgXGZxIRHZm3ePWcGZVICPEtaYLh3bLpa6G5fjo0BUt4oDCoNEuM1/1Q
         y395Wb0VsB9aAjBOqchrYqXq9wMcpFhV1rvuoo3wv2gwjDT1o4dIE3AVg/6eIPdi7naG
         5oXighgl3CbRQzN7ruaGl8pC3D1cXi8C2PBX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608081; x=1733212881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmcqT3bZQMcjsucg2dQtWpXidNuyx+XXM3544HAZF0U=;
        b=UqhD13x1WuPEchW1GMcw3j0kU4x0bWLn9CwUW019ugpCMGlH48A/ytBuyPEDY4hDzJ
         9JLL0/FS4rDu5bMLK4+mvjKJUySRADZsmUsvPmXqtxun0M6zMbKg48m7BQPoYcRToHH4
         iFTUqck99Xub78yOD9KSNnP4o2ZtO1SI1BuigIamJGNjzCG0mW5DHdqGTxCt7Y938vrD
         8jLOiAqZJYhck9DpUJeU1tDCcVCC0ThnRzTax4FqOjGFU5AS9wOeZniziBO9Eppu+kCS
         XHuaHLVCuEa+lrGHUIhJaDMvzOuYJS+7EJemPY7JmZiCjbaMqL2zrppAPuYKdP00mytl
         GdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDVyh0jAegkKeQQbs0I1RgjusFHJpyoJq9DYeNyo+k2IXUaC/6UORl/jo1BNgKDgWMHZuyvDz/pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9l1Op5uYeFeeSGwbpMMq3hs+p1VqkXkS/7S470npV+8p/dwT
	O/V/OOlwlaVxd/rpMuDOYmQJXddoTsdhvW3qyGQCuW2/Hf4YP50nqokBFnoahDPgzWpdKrzBMJA
	=
X-Gm-Gg: ASbGncsswO3u9h+LszXAG0ahFU+9+vvBZF29CXafA3VTEe6trFODYBPDMJ4AYUhFy/n
	THeUddA8bKSa5EY9T3hPTF/y/tw/s9DSM7a+EpU++Vq0iGujG9fqOdXDUz0W2xWU5RDj8g3/ynm
	XXBfswTexjDSj/NnJg8iqwaHtzTO99zBPZEZr2Ldc1Y/dBIidJKiFB98oXL4A6QQOKxF/jbEXVU
	tTgLYBgVoAKBGQr3b1c+qKrzZIpUtr8wrHPzz3m75ZJUto+2lplo+7RNBkxg00e9U2EOg0ErHxP
	8Ogv98DZYj5pzuEH
X-Google-Smtp-Source: AGHT+IGz7Ya+AWIKVjhHUAXiaWn9yYXRTJHk8pbPDN1+JHv0XePxrnGcnTQZtdGTH8pQhSsdnDaNOg==
X-Received: by 2002:a17:907:3e92:b0:a9a:7b3d:705 with SMTP id a640c23a62f3a-aa5649cefe8mr207261166b.30.1732608080312;
        Tue, 26 Nov 2024 00:01:20 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50a9de1d0sm562597066b.0.2024.11.26.00.01.19
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:01:19 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so4734a12.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2024 00:01:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2vaKcaO7Y+ElxNwlhJQsZorOy2IyF7X1kyPhxCesPHhj+FdalYDcD/d0xko9JMuylx4VZR8Ablw==@vger.kernel.org
X-Received: by 2002:aa7:c48d:0:b0:5cf:c93f:36f3 with SMTP id
 4fb4d7f45d1cf-5d06f511712mr30786a12.7.1732608078885; Tue, 26 Nov 2024
 00:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
In-Reply-To: <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 26 Nov 2024 16:00:42 +0800
X-Gmail-Original-Message-ID: <CAHc4DNKmGA-MjTWdZhKygiaRwN7mHnMCf8UPUxH_V16uZifzFg@mail.gmail.com>
Message-ID: <CAHc4DNKmGA-MjTWdZhKygiaRwN7mHnMCf8UPUxH_V16uZifzFg@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal/drivers/mediatek/lvts: Disable monitor mode
 during suspend
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	=?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:21=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> When configured in filtered mode, the LVTS thermal controller will
> monitor the temperature from the sensors and trigger an interrupt once a
> thermal threshold is crossed.
>
> Currently this is true even during suspend and resume. The problem with
> that is that when enabling the internal clock of the LVTS controller in
> lvts_ctrl_set_enable() during resume, the temperature reading can glitch
> and appear much higher than the real one, resulting in a spurious
> interrupt getting generated.
>
This sounds weird to me. On my end, the symptom is that the device
sometimes cannot suspend.
To be more precise, `echo mem > /sys/power/state` returns almost
immediately. I think the irq is more
likely to be triggered during suspension.


> Disable the temperature monitoring and give some time for the signals to
> stabilize during suspend in order to prevent such spurious interrupts.
>
> Cc: stable@vger.kernel.org
> Reported-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> Closes: https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chrom=
ium.org/
> Fixes: 8137bb90600d ("thermal/drivers/mediatek/lvts_thermal: Add suspend =
and resume")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 36 +++++++++++++++++++++++++++=
++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 1997e91bb3be94a3059db619238aa5787edc7675..a92ff2325c40704adc537af69=
95b34f93c3b0650 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -860,6 +860,32 @@ static int lvts_ctrl_init(struct device *dev, struct=
 lvts_domain *lvts_td,
>         return 0;
>  }
>
> +static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctr=
l *lvts_ctrl, bool enable)
> +{
> +       /*
> +        * Bitmaps to enable each sensor on filtered mode in the MONCTL0
> +        * register.
> +        */
> +       u32 sensor_filt_bitmap[] =3D { BIT(0), BIT(1), BIT(2), BIT(3) };
> +       u32 sensor_map =3D 0;
> +       int i;
> +
> +       if (lvts_ctrl->mode !=3D LVTS_MSR_FILTERED_MODE)
> +               return;
> +
> +       if (enable) {
> +               lvts_for_each_valid_sensor(i, lvts_ctrl)
> +                       sensor_map |=3D sensor_filt_bitmap[i];
> +       }
> +
> +       /*
> +        * Bits:
> +        *      9: Single point access flow
> +        *    0-3: Enable sensing point 0-3
> +        */
> +       writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
> +}
> +
>  /*
>   * At this point the configuration register is the only place in the
>   * driver where we write multiple values. Per hardware constraint,
> @@ -1381,8 +1407,11 @@ static int lvts_suspend(struct device *dev)
>
>         lvts_td =3D dev_get_drvdata(dev);
>
> -       for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++)
> +       for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++) {
> +               lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], fal=
se);
> +               usleep_range(100, 200);
>                 lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
> +       }
>
>         clk_disable_unprepare(lvts_td->clk);
>
> @@ -1400,8 +1429,11 @@ static int lvts_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++)
> +       for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++) {
>                 lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], true);
> +               usleep_range(100, 200);
> +               lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], tru=
e);
> +       }
>
>         return 0;
>  }
>
> --
> 2.47.0
>

