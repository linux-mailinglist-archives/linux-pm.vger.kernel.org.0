Return-Path: <linux-pm+bounces-36865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8637EC0BB49
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 03:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F7E189669A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 02:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31322224B0D;
	Mon, 27 Oct 2025 02:45:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18123211472
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 02:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533119; cv=none; b=ldFpuJQmoJrpEDXh2VKmIBtISkveFol2YS7UZgqZL24gEEC61K45rnt2EyA9i9Xzm6ZOc6rixK1Us3Q+48K1pGasG1ZKcgEdskz8yW32E85VqJdKWFkZCJApCzlsCa5RiLjm5hMCSNs3eqqEqIlkqi3DbBRvT/HUe8LTg6beFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533119; c=relaxed/simple;
	bh=evQekrEcmyRdqKp1jJZClGlbzLxhN98LFdFpjeGdBkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYaL790rudKN3iGvuKuwNVIb8wZSQnfK+12VqsYRlwVjCKo5Tfy0K0XhCr8SgUj64RReoIYPb5B3kFwt5F2PfjKDyq3vIFpLFLC3plKq4Ae7saw/b0kEsse8yFqYvrnukgRQXCif3SMtMSK4/Z6lrLmbLjovoDmQUhqc6kKPF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso846455466b.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 19:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761533115; x=1762137915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0xO3eccx9J1JFeRrYmbh54SIcFbkNO2ChisP5DHSmA=;
        b=Q+DLryZEa+58n3d0G2N+GNr1Z4d77SQcIRLzxa4C/q0P5Z5B3bR0T3mr8dT1zE9mID
         Kr9m3YnbjRx5yS85cb/Xg9oOrQRoXh2kIu6KLoN1BZ3DdOFva4K53LXHnb5IkXVhib+N
         CUf16jaHn9tN1h1cJTz0hxRx7Kifbrougz4umU6fvOvWXxjzFHG67TxyLc7LTEVvWzbx
         shZJB59Q28kefQFlQKdbAa42YIxSGm/AQBoaTgnOHuvUXTvalbSMlWgBKpBbjqARIJo5
         GzWMgUzt/9TxL90PI4D0kss8ZW4xACjbcWrEJACHDqKD498dbNr+svh/VvmTCJYtaTnb
         suyw==
X-Forwarded-Encrypted: i=1; AJvYcCULaCO03eWT5i6Wlm1xNC26rpePsHg5AcS1OWoVauTuCwYX55PJcEekSgG1Fqfgz/iPlZQFXZRdzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwarCzi7tVYRbWUleCLTKf76YUgq8jDCbMediexoGJLtjWNOxbg
	uuv4c44DQ9EHdEmpmbvLRI2w++cww1OdcPjErHBGIqxh1Z+4MsDzzafgg42vfLHyjlA=
X-Gm-Gg: ASbGnctHV3WUfwWW8wjaRWeNoWqj9Nz8Jrt5V8mNdbT0mRGVNgkQj+7tgHoKL4iDEe4
	sv9U83d0IrsgFTGKyKJervemQjDTpoxo1VI8COPW7bUzdAH6hoPwZw4p9rJMkMhPLoibv52gnD0
	UBhzFdrbkJ8HgS9/VRYIwzjbKyQnRAxKUISD1Sx4j5YF5ck3mtxQlOzcRsi0+IdURSw1R2KeA8n
	SqdvUf/gRsPHOEVCQah+gFLEAUOpD+fKui3eF8zuPJCZsDUBp/Vtvy/j964NNwwsiOYcyuql0gX
	Yy/xm4IvaQ0Kjb1etyGXfCrFm+dBwKQmcnR2yloa0kIK9gHqTJI+Xf5WQ6ROm0vIZpK6bzOC+SL
	jLhhEtqjgJUcJLh6oj+zfW6AANOEueqyGCz+M4PL3fwLWebbWYnhA12CeNMk0zKe2dywQsNpC1g
	uxybHxEzDMIhv9wQYMd6iwgMOemyZKmENbgp3yzyM=
X-Google-Smtp-Source: AGHT+IGpu21p5ZtY4g80iL7owSzlarLgLpaWrvGB5qw8+EdR/e+8YF4dWPNInN5vpZhB99qWSAicCQ==
X-Received: by 2002:a17:906:6a12:b0:b40:b6a9:f70f with SMTP id a640c23a62f3a-b6d51aefb9amr1571533466b.4.1761533114767;
        Sun, 26 Oct 2025 19:45:14 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c549fsm621557366b.37.2025.10.26.19.45.14
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 19:45:14 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3c2db014easo913081366b.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 19:45:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyqlFuUsN6NgPhxKScYshV8NzozOck3eslnoQ8OnIzeS4vFbIJk+Js0owzYX3ZHPVSE31Hm+jeFg==@vger.kernel.org
X-Received: by 2002:a05:651c:1509:b0:376:2802:84a8 with SMTP id
 38308e7fff4ca-378d6f87cf1mr39477651fa.46.1761532753914; Sun, 26 Oct 2025
 19:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025043129.160454-1-iuncuim@gmail.com> <20251025043129.160454-3-iuncuim@gmail.com>
In-Reply-To: <20251025043129.160454-3-iuncuim@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 27 Oct 2025 10:39:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v656qzX3YrcuTt++=-r5JCyDKgGB8NYTAM3TpyRtAwdibw@mail.gmail.com>
X-Gm-Features: AWmQ_bltF2M2RvHvljsl22XgW5kEnSwcYVFG9c-kdXV1SwRk_st0sy4RKS89u_w
Message-ID: <CAGb2v656qzX3YrcuTt++=-r5JCyDKgGB8NYTAM3TpyRtAwdibw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] thermal/drivers/sun8i: add gpadc clock
To: iuncuim <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andre Przywara <andre.przywara@arm.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 12:32=E2=80=AFPM iuncuim <iuncuim@gmail.com> wrote:
>
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>
> Some processors (e.g. Allwinner A523) require GPADC clocking activation f=
or
> temperature sensors to work. So let's add support for enabling it.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  drivers/thermal/sun8i_thermal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index 226747906..c02c398b0 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -66,6 +66,7 @@ struct tsensor {
>  };
>
>  struct ths_thermal_chip {
> +       bool            has_gpadc_clk;
>         bool            has_mod_clk;
>         bool            has_bus_clk_reset;
>         bool            needs_sram;

We could optimize this using bit fields instead. This can be done in a late=
r
patch if you want to do it.


ChenYu

> @@ -89,6 +90,7 @@ struct ths_device {
>         struct regmap_field                     *sram_regmap_field;
>         struct reset_control                    *reset;
>         struct clk                              *bus_clk;
> +       struct clk                              *gpadc_clk;
>         struct clk                              *mod_clk;
>         struct tsensor                          sensor[MAX_SENSOR_NUM];
>  };
> @@ -417,6 +419,12 @@ static int sun8i_ths_resource_init(struct ths_device=
 *tmdev)
>         if (ret)
>                 return ret;
>
> +       if (tmdev->chip->has_gpadc_clk) {
> +               tmdev->gpadc_clk =3D devm_clk_get_enabled(&pdev->dev, "gp=
adc");
> +               if (IS_ERR(tmdev->gpadc_clk))
> +                       return PTR_ERR(tmdev->gpadc_clk);
> +       }
> +
>         if (tmdev->chip->needs_sram) {
>                 struct regmap *regmap;
>
> --
> 2.51.0
>
>

