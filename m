Return-Path: <linux-pm+bounces-12560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7A9584E0
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485251F27D12
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607318DF82;
	Tue, 20 Aug 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ebykAl+x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7E18E34B
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150486; cv=none; b=nQ+h/30ky4/g7ykq8oDJiU5ks5mLcFoAezHwy7imBh3EyjhDp3xwpTKPbCC/aPY8oXeJcWxZu/lFlefx446qZY/QlwzkXwYik6NR8ZWICCYxo0HF6ePzVURysAgXvLaad6AX57LHSUSP0svo+2wdplTPP3fAD7Y4f9r38QWxDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150486; c=relaxed/simple;
	bh=zYxhlv93V9RtXmjEL+Ssk+4fO+qgaXyd7TzDWcku2DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUF2CZMFXbt2xvWE3A4q0UqBmg8rmAzFFqtIYK2pGpDlP1Z6p4psoL1E8VWGWGiDNgNMjV8qC5Y1cB0dY7R+Q/cV5dXNzPPokYAMVMLlxlPhb3NFE0wbHxRtYgU6iY2+pQ7Cds3tWMztLF7+uWGosAzTGEfqOj9Ea7YYqf8aMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ebykAl+x; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso4333010a12.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724150483; x=1724755283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGemp3/J4+ZRAtrBZReELh9mp4/tveOz4AeZNo7+1xw=;
        b=ebykAl+xAGn1yz2b6SyzFpJm7VohS8RZnXmGe+PdStxUuUprPk+qF7xDDg9yAx2tE4
         w/PaIUNyhsC9FwL4NGlL2W7NHJT2wTzdYTDnb4pB0F3gYuN8RrV8fw452BU9sf+3nrd6
         i88SEXDjnbrEyHEq0xCEi7GC+L5cBVYp+zdsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724150483; x=1724755283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGemp3/J4+ZRAtrBZReELh9mp4/tveOz4AeZNo7+1xw=;
        b=lGdWDGdvprfvs6xiIGptr/gVdykj7i1LmQqNoFBnqGKkzvIh2uRM8OXD1JeKqK5nuX
         0j+swIE1UJZk/AbxVAridDegkQImo69DzcYGl8+L1LhU2rqsWycjEZpRqXd1C3S0C5+z
         vM0Z1jtPo9KFReVaZIxwRhC2qUmtTZS80me8IF7ezHl7TeiJeWRfIBiFOtv+fv+fYMAg
         q8IXNMLMn4bjyOSIwRrWZZVwfpu5Ijs6vd8ojn2EzoJHQrwwRg7DQBS/DslbwU2kVztI
         3WLwcFQRjCl+D3f2bbuyUoWuw+4dP+2MdSQ/FkIsv22X0sj5nuUaKxoIpD4/rEio2Rhr
         omtw==
X-Forwarded-Encrypted: i=1; AJvYcCX/j05gsOvuSMjXDDnvAiDgPzHh0g6oAi0gzgYXkC6zcLQR3E8mYBa0nP/1LZ8k9C1FUyx2oFqmCHiAc6JTDVRgJrE8wAM/EVc=
X-Gm-Message-State: AOJu0YyMKboZ6+736VLHlSaTtNWh/AD1kwkr5t56NbnypmXRjuLoPBtA
	aUNj+OAD25GqrHu5ii1wLZkWPSqnXTNL5fBaRwFPwDtICMeoip6yApH9yapVi+4gkDdKrnFETYE
	=
X-Google-Smtp-Source: AGHT+IFVqPiPUVX6KJyHXhVZ4p0zpqgdX2AQ3H7pQfcKcAbWwzRhfBjjgA6gYrfTqtnpg9Q7TkFutA==
X-Received: by 2002:a17:907:e622:b0:a77:cf9d:f495 with SMTP id a640c23a62f3a-a8392954070mr1065692666b.40.1724150481960;
        Tue, 20 Aug 2024 03:41:21 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383969e05sm743908166b.191.2024.08.20.03.41.21
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 03:41:21 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8643a6bd55so108771066b.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 03:41:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ6/llSNFABYOtB5Zd6gqXnKIt1GBRVl9NHbAPmDdPYgt5owY9tJg39FttJDWzJ+gRnthxestvFWGf2c6+FB0rJXl0xyXyUwo=
X-Received: by 2002:a17:907:e249:b0:a7a:ab8a:38a with SMTP id
 a640c23a62f3a-a839292ffbdmr1077908166b.27.1724150480979; Tue, 20 Aug 2024
 03:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809-auxadc_thermal-v11-1-af36cc74f3a3@chromium.org> <66f3361b-00f8-4527-aaa8-d1c302c8ea26@linaro.org>
In-Reply-To: <66f3361b-00f8-4527-aaa8-d1c302c8ea26@linaro.org>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 20 Aug 2024 18:40:44 +0800
X-Gmail-Original-Message-ID: <CAHc4DNLsNUE+dk3+Xz97MO9gnyK5ZwUdXxEQiKz0vEzgWe4mQQ@mail.gmail.com>
Message-ID: <CAHc4DNLsNUE+dk3+Xz97MO9gnyK5ZwUdXxEQiKz0vEzgWe4mQQ@mail.gmail.com>
Subject: Re: [PATCH v11] thermal/drivers/mediatek: add another get_temp ops
 for thermal sensors
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

On Mon, Aug 19, 2024 at 6:33=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 09/08/2024 10:44, Hsin-Te Yuan wrote:
> > From: James Lo <james.lo@mediatek.com>
> >
> > Provide thermal zone to read thermal sensor
> > in the SoC. We can read all the thermal sensors
> > value in the SoC by the node /sys/class/thermal/
>
> Please elaborate a bit more the description to stick to the changes.
>
> What is the difference between MT8183 Kukui devices and older ones, for
> instance ?
>
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> > Signed-off-by: James Lo <james.lo@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> > Resurrecting this patch specifically for MediaTek MT8183 Kukui devices.
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
> >   drivers/thermal/mediatek/auxadc_thermal.c | 71 ++++++++++++++++++++++=
+++++----
> >   1 file changed, 63 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/therma=
l/mediatek/auxadc_thermal.c
> > index 9ee2e7283435..8b50d560bbf9 100644
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
>
> Where is used this variable ?
>
This is used by the for loop in this function.
> >       int i;
> >       int tempmax =3D INT_MIN;
> >
> > @@ -866,10 +867,46 @@ static int mtk_read_temp(struct thermal_zone_devi=
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
> > +     if (id < 0)
> > +             return  -EACCES;
>
> This test should not be done here:
>
> 1. EACCES is permission denied
>
> 2. The bank id should be checked at init time
>
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
> > +     if (!mtk_thermal_temp_is_valid(temp)) {
>
> unlikely(!mtk_thermal_temp_is_valid(temp)) ?
>
> > +             temp =3D THERMAL_TEMP_INVALID;
>
> What is the point of assigning this value and return just after ?
>
I'll remove this line.
> > +             return -EAGAIN;
> > +     }
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
> > @@ -1199,6 +1236,7 @@ static int mtk_thermal_probe(struct platform_devi=
ce *pdev)
> >       u64 auxadc_phys_base, apmixed_phys_base;
> >       struct thermal_zone_device *tzdev;
> >       void __iomem *apmixed_base, *auxadc_base;
> > +     struct mtk_thermal_bank *tz;
> >
> >       mt =3D devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
> >       if (!mt)
> > @@ -1285,14 +1323,31 @@ static int mtk_thermal_probe(struct platform_de=
vice *pdev)
> >                       mtk_thermal_init_bank(mt, i, apmixed_phys_base,
> >                                             auxadc_phys_base, ctrl_id);
> >
> > -     tzdev =3D devm_thermal_of_zone_register(&pdev->dev, 0, mt,
> > -                                           &mtk_thermal_ops);
> > -     if (IS_ERR(tzdev))
> > -             return PTR_ERR(tzdev);
> > +     for (i =3D 0; i < mt->conf->num_sensors + 1; i++) {
>
> Why "num_sensors + 1" ?
>
Because we have the one with id 0 which represents the max of all the
temperature and num_sensors real sensors.
> > +             tz =3D devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> > +             if (!tz)
> > +                     return -ENOMEM;
> > +
> > +             tz->mt =3D mt;
> > +             tz->id =3D i;
> > +
> > +             tzdev =3D devm_thermal_of_zone_register(&pdev->dev, i,
> > +                             tz, (i =3D=3D 0) ?
> > +                             &mtk_thermal_ops : &mtk_thermal_sensor_op=
s);
>
> Don't you want to keep the init routine and depending on the platform
> add the loop with the extra sensors ? That may help to make the code
> cleaner instead of doing tests like (i =3D=3D 0) ? &mtk_thermal_ops :
> &mtk_thermal_sensor_ops
>
How about moving the registration with i =3D 0 out of this loop.
Although some platforms don't use those extra sensors, they can read
the temperature from these extra sensors by simply adding thermal
zones in devicetree.
> > +             if (IS_ERR(tzdev)) {
> > +                     if (PTR_ERR(tzdev) =3D=3D -ENODEV) {
> > +                             dev_warn(&pdev->dev, "can't find thermal =
sensor %d\n", i);
> > +                             continue;
> > +                     }
> > +                     if (PTR_ERR(tzdev) !=3D -EACCES)
>
> The id correctness should be checked in this loop, not rely on a EACCES
> returned by a implicit call to thermal_zone_get_temp()
>
Since we use the for loop here, checking the id correctness looks
meaningless. I'll change to return error directly and remove the id
correctness checking from mtk_read_sensor_temp.
> > +                             return PTR_ERR(tzdev);
> > +             }
> >
> > -     ret =3D devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> > -     if (ret)
> > -             dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> > +             ret =3D devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> > +             if (ret)
> > +                     dev_warn(&pdev->dev, "error in thermal_add_hwmon_=
sysfs: %d\n", ret);
> > +     }
> >
> >       return 0;
> >   }
> >
> > ---
> > base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
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

