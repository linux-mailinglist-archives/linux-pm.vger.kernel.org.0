Return-Path: <linux-pm+bounces-17741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1509D20DA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 08:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 941CBB20BD7
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609C21531D2;
	Tue, 19 Nov 2024 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XgwfimD4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3E1531C2
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001966; cv=none; b=An6qXWhSNtxqeMF3x4WXyafZgYVOn12myNnkBKBIGHxbnf5IMYt9gYOL/EUfDbbf9M4I0Wq8+xhlICMLiLJoDiQWCNKc+7j4bLX6GyFOvJ+UoFhQffQuSiZszudn3kmxULBoGxZxRromE7WBJkunYMH25Dp2+jwnCiAd9iB1zFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001966; c=relaxed/simple;
	bh=1SBkHeUckINUsh1o5SJZ1ffsQfjtudbps0hw16i4xrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTaFi1Mu0XOqPg+G6YNkNasK714RyIu36VDmQhg95k2s1HgQM/KiIKf9BOS4f8d3Hhau9I7hD2jThghB44Kdwic/+r6GhJZ4A3wuWvPTEkQk3Hxcw1ySJUiF9mUCjfZvik1JEuD37TDNKKUajlFfW/A8Kao0ZuoCKP1Mxd7+FDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XgwfimD4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa20944ce8cso913908866b.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 23:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732001962; x=1732606762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc03VgYQIOfXdNIZNxM20U/iHVBib0CYjcHbGag74lQ=;
        b=XgwfimD46Q5YG41GgjT57M8/xnfHR+qEAUMYNhbakAwxEv2c3d9SaQwRueq9FduCaW
         rQxSDfnVRmgj84pjzYFqj8FQp8tmFgsszi2AePv5DoHR2msKBQKleLsR+HAsw46ttOJi
         akXMFSJSUCEu/LB4F99SckuFJzeTvCYT/EaQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732001962; x=1732606762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gc03VgYQIOfXdNIZNxM20U/iHVBib0CYjcHbGag74lQ=;
        b=pQlgY0dpb/D7JeHfjA8E8D0ICw/BXvY+61jY5qUu1fapxpqH4eO5eResveoVjAa8QL
         m6WPFafmmH0fhBRo3YAFB2prG3u7dsFK7ox4t+XkRPGOZaxvsCPGg6U6HyvQnKZNglOo
         VdW2Kn4eoyayoY/KHodpCO+uWXsRA2Ki6AMUcGl5Es9nEe6/UZus4fG67Tsrjglf05+9
         NakoD18DIiER/A+jjaXnYKwx3SPEn0faf6sgrXP7eC3OG7u6P6ctzQtwROYG5bNr3OFX
         IoCxyT5cBxL2I4jiNPUigHTTeXRyWdQsQ9XQqlF9GIvZZ9hyLAY3tYmYnni+nCJVZvJP
         V21w==
X-Forwarded-Encrypted: i=1; AJvYcCVfQ4ZnqhOIJjtu81GtjI3QCkGPXslDiw88ioyffGdhwlsE65lBj5zwAhwHOlD8VV+RJuVmgBTHBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo0XKc6IEw2lBub9XqyRTNupB4z5GoJ4xa+Dfd5tHq4CJNrpO/
	1/Qrc3znm4WHLCN1GlVn6ztxPu8G/GN04HepyZZM9LVyhr23l/ydLv8cu+NKAiVGRm9kd+pDgKd
	UWg==
X-Google-Smtp-Source: AGHT+IFRlIleDMrVVmnB4E/jzKZtD+6HxZgbS2Ik2bHcS71tkr/Yo+/+u0PPW5TM+gtTk2YRFqJfOQ==
X-Received: by 2002:a17:907:c05:b0:a9a:597:8cc9 with SMTP id a640c23a62f3a-aa4c7e25648mr222124966b.12.1732001962244;
        Mon, 18 Nov 2024 23:39:22 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e044b59sm614863566b.143.2024.11.18.23.39.21
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:39:21 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so4042a12.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 23:39:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlpVJ0dbsHLB2v2yufyMtOOKIr/JIc+V6IOCREyk7ZD5OcuFnUMxL8ipapYX8yipyV5Ij1cVvvXA==@vger.kernel.org
X-Received: by 2002:a50:eb07:0:b0:5cf:c33b:c1eb with SMTP id
 4fb4d7f45d1cf-5cfe19be25bmr29406a12.3.1732001961040; Mon, 18 Nov 2024
 23:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-auxadc_thermal-v14-1-96ab5b60c02e@chromium.org> <5dd2d2a3-6eff-45fb-8af8-593945235dd3@linaro.org>
In-Reply-To: <5dd2d2a3-6eff-45fb-8af8-593945235dd3@linaro.org>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 19 Nov 2024 15:38:44 +0800
X-Gmail-Original-Message-ID: <CAHc4DNKSsrdSjqunhk+oyWw_+oKY9BgzPcqag5QrmLJqjVsE1Q@mail.gmail.com>
Message-ID: <CAHc4DNKSsrdSjqunhk+oyWw_+oKY9BgzPcqag5QrmLJqjVsE1Q@mail.gmail.com>
Subject: Re: [PATCH v14] thermal/drivers/mediatek/auxadc_thermal: expose all
 thermal sensors
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, James Lo <james.lo@mediatek.com>, 
	Michael Kao <michael.kao@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Ben Tseng <ben.tseng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 12:48=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi,
>
> On 25/10/2024 14:05, Hsin-Te Yuan wrote:
> > From: James Lo <james.lo@mediatek.com>
> >
> > Previously, the driver only supported reading the temperature from all
> > sensors and returning the maximum value. This update adds another
> > get_temp ops to support reading the temperature from each sensor
> > separately.
> >
> > Especially, some thermal zones registered by this patch are needed by
> > MT8183 since those thermal zones are necessary for mtk-svs driver.
>
> The DT for the mt8183 describes the sensor id =3D 0 as the CPU. On this,
> there is a cooling device with trip points.
>
> The driver registers the id=3D0 as an aggregator for the sensors which
> overloads the CPU thermal zone above.
>
> Why do you need to aggregate all the sensors to retrieve the max value ?
>
> They are all contributing differently to the heat and they should be
> tied with their proper cooling device.
>
> I don't think the thermal configuration is correct and I suggest to fix
> this aggregator by removing it.
>
>
>
 As far as I know the thermal design of Mediatek's board is based on
the highest temperature of the whole board. Also, removing the
aggregator will break all the boards using this driver.
By the way, I heard that baylibre is working on multi-sensor
aggregation support, which can be the alternative solution for the
aggregator in this driver, but that should be another story and is
unrelated to this patch.

> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> > Signed-off-by: James Lo <james.lo@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> > Changes in v14:
> > - Remove redundant error message.
> > - Link to v13: https://lore.kernel.org/r/20241025-auxadc_thermal-v13-1-=
a5231c52dccb@chromium.org
> >
> > Changes in v13:
> > - Make subject and commit message more clear.
> > - Make error message more clear.
> > - Link to v12: https://lore.kernel.org/r/20241016-auxadc_thermal-v12-1-=
c0433e9f61af@chromium.org
> >
> > Changes in v12:
> > - Remove unnecessary check and unused variable assignment in mtk_read_s=
ensor_temp.
> > - Add more about what this patch achieves in the commit message.
> > - Link to v11: https://lore.kernel.org/r/20240809-auxadc_thermal-v11-1-=
af36cc74f3a3@chromium.org
> >
> > Changes in V11:
> >      - Rebase on kernel v6.11-rc2
> >      - Use mtk_thermal_temp_is_valid in mtk_read_sensor_temp just like
> >        mtk_thermal_bank_temperature
> >      - Change the error handling of devm_thermal_of_zone_register retur=
n
> >        value
> >      - link to V10: https://lore.kernel.org/lkml/20220519101044.16765-1=
-james.lo@mediatek.com/
> >
> > Changes in V10:
> >      - Rebase to kernel-v5.18-rc7
> >      - Resend
> >
> > Changes in V9:
> >      - Rebase to kernel-v5.14-rc1
> >      - Bind raw_to_mcelsius_v1 or raw_to_mcelsius_v2 to compatible
> >        data of struct mtk_thermal_data
> >      - Remove duplicate struct 'mtk_thermal_bank'
> >      - Remove unnecessary if condition check
> >      - Return error if any thermal zone fail to register
> >
> > Changes in V8:
> >      - Rebase to kernel-v5.13-rc1
> >      - Resend
> >
> > Changes in v7:
> >      - Fix build error in v6.
> >
> > Changes in v6:
> >      - Rebase to kernel-5.11-rc1.
> >      - [1/3]
> >          - add interrupts property.
> >      - [2/3]
> >          - add the Tested-by in the commit message.
> >      - [3/3]
> >          - use the mt->conf->msr[id] instead of conf->msr[id] in the
> >            _get_sensor_temp and mtk_thermal_bank_temperature.
> >          - remove the redundant space in _get_sensor_temp and
> >            mtk_read_sensor_temp.
> >          - change kmalloc to dev_kmalloc in mtk_thermal_probe.
> >
> > Changes in v5:
> >      - Rebase to kernel-5.9-rc1.
> >      - Revise the title of cover letter.
> >      - Drop "[v4,7/7] thermal: mediatek: use spinlock to protect PTPCOR=
ESEL"
> >      - [2/2]
> >          -  Add the judgement to the version of raw_to_mcelsius.
> >
> > Changes in v4:
> >      - Rebase to kernel-5.6-rc1.
> >      - [1/7]
> >          - Squash thermal zone settings in the dtsi from [v3,5/8]
> >            arm64: dts: mt8183: Increase polling frequency for CPU therm=
al zone.
> >          - Remove the property of interrupts and mediatek,hw-reset-temp=
.
> >      - [2/7]
> >          - Correct commit message.
> >      - [4/7]
> >          - Change the target temperature to the 80C and change the comm=
it message.
> >      - [6/7]
> >          - Adjust newline alignment.
> >          - Fix the judgement on the return value of registering thermal=
 zone.
> >
> > Changes in v3:
> >      - Rebase to kernel-5.5-rc1.
> >      - [1/8]
> >          - Update sustainable power of cpu, tzts1~5 and tztsABB.
> >      - [7/8]
> >          - Bypass the failure that non cpu_thermal sensor is not find i=
n thermal-zones
> >            in dts, which is normal for mt8173, so prompt a warning here=
 instead of
> >            failing.
> >
> >      Return -EAGAIN instead of -EACCESS on the first read of sensor tha=
t
> >          often are bogus values. This can avoid following warning on bo=
ot:
> >
> >            thermal thermal_zone6: failed to read out thermal zone (-13)
> >
> > Changes in v2:
> >      - [1/8]
> >          - Add the sustainable-power,trips,cooling-maps to the tzts1~tz=
tsABB.
> >      - [4/8]
> >          - Add the min opp of cpu throttle.
> > ---
> >
> > ---
> >   drivers/thermal/mediatek/auxadc_thermal.c | 70 ++++++++++++++++++++++=
+++++----
> >   1 file changed, 62 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/therma=
l/mediatek/auxadc_thermal.c
> > index 9ee2e7283435acfcbb1a956303b6122a08affecc..9a9079d559a3abe9e3823f7=
44d4c9a159a8666bd 100644
> > --- a/drivers/thermal/mediatek/auxadc_thermal.c
> > +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> > @@ -847,7 +847,8 @@ static int mtk_thermal_bank_temperature(struct mtk_=
thermal_bank *bank)
> >
> >   static int mtk_read_temp(struct thermal_zone_device *tz, int *tempera=
ture)
> >   {
> > -     struct mtk_thermal *mt =3D thermal_zone_device_priv(tz);
> > +     struct mtk_thermal_bank *bank =3D thermal_zone_device_priv(tz);
> > +     struct mtk_thermal *mt =3D bank->mt;
> >       int i;
> >       int tempmax =3D INT_MIN;
> >
> > @@ -866,10 +867,41 @@ static int mtk_read_temp(struct thermal_zone_devi=
ce *tz, int *temperature)
> >       return 0;
> >   }
> >
> > +static int mtk_read_sensor_temp(struct thermal_zone_device *tz, int *t=
emperature)
> > +{
> > +     struct mtk_thermal_bank *bank =3D thermal_zone_device_priv(tz);
> > +     struct mtk_thermal *mt =3D bank->mt;
> > +     const struct mtk_thermal_data *conf =3D mt->conf;
> > +     int id =3D bank->id - 1;
> > +     int temp =3D INT_MIN;
> > +     u32 raw;
> > +
> > +     raw =3D readl(mt->thermal_base + conf->msr[id]);
> > +
> > +     temp =3D mt->raw_to_mcelsius(mt, id, raw);
> > +
> > +     /*
> > +      * The first read of a sensor often contains very high bogus
> > +      * temperature value. Filter these out so that the system does
> > +      * not immediately shut down.
> > +      */
> > +
> > +     if (unlikely(!mtk_thermal_temp_is_valid(temp)))
> > +             return -EAGAIN;
> > +
> > +     *temperature =3D temp;
> > +
> > +     return 0;
> > +}
> > +
> >   static const struct thermal_zone_device_ops mtk_thermal_ops =3D {
> >       .get_temp =3D mtk_read_temp,
> >   };
> >
> > +static const struct thermal_zone_device_ops mtk_thermal_sensor_ops =3D=
 {
> > +     .get_temp =3D mtk_read_sensor_temp,
> > +};
> > +
> >   static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
> >                                 u32 apmixed_phys_base, u32 auxadc_phys_=
base,
> >                                 int ctrl_id)
> > @@ -1199,6 +1231,7 @@ static int mtk_thermal_probe(struct platform_devi=
ce *pdev)
> >       u64 auxadc_phys_base, apmixed_phys_base;
> >       struct thermal_zone_device *tzdev;
> >       void __iomem *apmixed_base, *auxadc_base;
> > +     struct mtk_thermal_bank *tz;
> >
> >       mt =3D devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
> >       if (!mt)
> > @@ -1285,14 +1318,35 @@ static int mtk_thermal_probe(struct platform_de=
vice *pdev)
> >                       mtk_thermal_init_bank(mt, i, apmixed_phys_base,
> >                                             auxadc_phys_base, ctrl_id);
> >
> > -     tzdev =3D devm_thermal_of_zone_register(&pdev->dev, 0, mt,
> > -                                           &mtk_thermal_ops);
> > -     if (IS_ERR(tzdev))
> > -             return PTR_ERR(tzdev);
> > +     for (i =3D 0; i <=3D mt->conf->num_sensors; i++) {
> > +             tz =3D devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> > +             if (!tz)
> > +                     return -ENOMEM;
> > +
> > +             tz->mt =3D mt;
> > +             tz->id =3D i;
> > +
> > +             tzdev =3D devm_thermal_of_zone_register(&pdev->dev, i,
> > +                                                   tz, (i =3D=3D 0) ?
> > +                                                   &mtk_thermal_ops
> > +                                                   : &mtk_thermal_sens=
or_ops);
> > +
> > +             if (IS_ERR(tzdev)) {
> > +                     ret =3D PTR_ERR(tzdev);
> > +                     if (ret =3D=3D -ENODEV) {
> > +                             dev_warn(&pdev->dev,
> > +                                      "Can't find thermal zone for sen=
sor %d; sensor skipped.\n", i);
> > +                             continue;
> > +                     }
> > +                     return dev_err_probe(&pdev->dev, ret,
> > +                                          "Failed to register thermal =
zone %d.\n", i);
> > +             }
> >
> > -     ret =3D devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> > -     if (ret)
> > -             dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> > +             ret =3D devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> > +             if (ret)
> > +                     dev_warn(&pdev->dev,
> > +                              "Sensor %d: Error in thermal_add_hwmon_s=
ysfs: %d\n", i, ret);
> > +     }
> >
> >       return 0;
> >   }
> >
> > ---
> > base-commit: b589839414be04b2b37e4bf6f84af576c99faf64
> > change-id: 20240809-auxadc_thermal-9be338ec8b1c
> >
> > Best regards,
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

