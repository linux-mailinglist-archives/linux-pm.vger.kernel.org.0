Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEBF2F0AA4
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 01:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbhAKAj5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 19:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbhAKAj4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2021 19:39:56 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B2DC061794
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 16:39:16 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id d6so3869221vkb.13
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 16:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfW1bXDcu/lByxe5Lzd9326trCLUNqKWrb1d3xD70zE=;
        b=Vcss8DRQLz+AJgqcoiMcwtcRHNY+1FT4m5PO1GpPO7uSSe/h3lptsFESwXv6y/jDPn
         uZeESDldBzFW4P11UXupd8R0iDzHZdVW2iUmfDvnV2JfbnEIKbc1827Nlg2rjywQnJk9
         03bSP87LEsYrhPVKci/2g8cz3XGXrRryTp/58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfW1bXDcu/lByxe5Lzd9326trCLUNqKWrb1d3xD70zE=;
        b=sGTlwsXu3eTvF4XlCQLxJ8eKswVM76xbN/+Nm+aoB1tvdc7nm84A85053v63UfeCgr
         HXIRmGExkQ+jdixlhoKaKttEd1++FcZgpTBrYQdwK0Y9dXuYLvUeqM7m3GC4Daoy9jeO
         gxVaJAAi/jaIGzIk4CjRq6AVMREX50EgpYpzGbb5ob9+JPteqkS/Eq5PlhP14+cG1Kyq
         V6eX6vJScTbIeNUpwumVR4UqmJntjrdr76zI9P4vr6I/PLdvNuluOM7ppPDzjNB1wUBB
         RQ9aFYdeSfBal7y28Fdf50obX53Lz+RqgzxGxRbjKRBMnYEoA54mtttNPWkj+qTzHT1c
         pvDQ==
X-Gm-Message-State: AOAM5307W+AAbgvobufczg5dmY/KqIKuIslsAHyH8Sn34N1vJp8fULeu
        qmermpj0D40ZqDFEJGznXbXzTMAWON6l597IKxc6rw==
X-Google-Smtp-Source: ABdhPJwjiecZEFrsXBirizL7rHJlesi3agn3gpEePPWBsWov8yc+6W5r6tJ9rLrqQ3BMouyiAxKTgevMOKDBth7uO2M=
X-Received: by 2002:ac5:c5b5:: with SMTP id f21mr10963955vkl.13.1610325555144;
 Sun, 10 Jan 2021 16:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20201013102358.22588-1-michael.kao@mediatek.com> <20201013102358.22588-4-michael.kao@mediatek.com>
In-Reply-To: <20201013102358.22588-4-michael.kao@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 11 Jan 2021 08:39:04 +0800
Message-ID: <CANMq1KDAuXtPc_J4Kxt+e=BfJP+cLt70wPStQShO84LQLaOe8A@mail.gmail.com>
Subject: Re: [v5 3/3] thermal: mediatek: add another get_temp ops for thermal sensors
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 6:24 PM Michael Kao <michael.kao@mediatek.com> wrote:
>
> Provide thermal zone to read thermal sensor
> in the SoC. We can read all the thermal sensors
> value in the SoC by the node /sys/class/thermal/
>
> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
> on the first read of sensor that often are bogus values.
>
> This can avoid following warning on boot:
>
>   thermal thermal_zone6: failed to read out thermal zone (-13)
>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/thermal/mtk_thermal.c | 99 +++++++++++++++++++++++++++--------
>  1 file changed, 76 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 0bd7aa564bc2..43c7bdbc147f 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -245,6 +245,11 @@ enum mtk_thermal_version {
>
>  struct mtk_thermal;
>
> +struct mtk_thermal_zone {
> +       struct mtk_thermal *mt;
> +       int id;
> +};
> +
>  struct thermal_bank_cfg {
>         unsigned int num_sensors;
>         const int *sensors;
> @@ -637,6 +642,32 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>                 mutex_unlock(&mt->lock);
>  }
>
> +static u32 _get_sensor_temp(struct mtk_thermal *mt, int id)
> +{
> +       u32 raw;
> +       int temp;
> +
> +       const struct mtk_thermal_data *conf = mt->conf;

nit: You only use conf once, so I'd just use mt->conf->msr[id] below.

(or at least use conf->version instead of mt->conf->version just below)

> +
> +       raw = readl(mt->thermal_base + conf->msr[id]);
> +
> +       if (mt->conf->version == MTK_THERMAL_V1)
> +               temp = raw_to_mcelsius_v1(mt, id, raw);
> +       else
> +               temp = raw_to_mcelsius_v2(mt, id, raw);
> +
> +       /*
> +        * The first read of a sensor often contains very high bogus
> +        * temperature value. Filter these out so that the system does
> +        * not immediately shut down.
> +        */
> +
> +       if (temp > 200000)
> +               return  -EAGAIN;

nit: one space between return and -EAGAIN.

> +       else
> +               return  temp;

ditto.

> +}
> +
>  /**
>   * mtk_thermal_bank_temperature - get the temperature of a bank
>   * @bank:      The bank
> @@ -649,26 +680,10 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>         struct mtk_thermal *mt = bank->mt;
>         const struct mtk_thermal_data *conf = mt->conf;

nit: Since this is now only used once, drop this variable?

>         int i, temp = INT_MIN, max = INT_MIN;
> -       u32 raw;
>
>         for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> -               raw = readl(mt->thermal_base + conf->msr[i]);
> -
> -               if (mt->conf->version == MTK_THERMAL_V1) {
> -                       temp = raw_to_mcelsius_v1(
> -                               mt, conf->bank_data[bank->id].sensors[i], raw);

The new version of the code does this instead:
                       temp = raw_to_mcelsius_v1(mt, i, raw);

What's the difference between conf->bank_data[bank->id].sensors[i] and i?


> -               } else {
> -                       temp = raw_to_mcelsius_v2(
> -                               mt, conf->bank_data[bank->id].sensors[i], raw);
> -               }
>
> -               /*
> -                * The first read of a sensor often contains very high bogus
> -                * temperature value. Filter these out so that the system does
> -                * not immediately shut down.
> -                */
> -               if (temp > 200000)
> -                       temp = 0;
> +               temp = _get_sensor_temp(mt, i);
>
>                 if (temp > max)
>                         max = temp;
> @@ -679,7 +694,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>
>  static int mtk_read_temp(void *data, int *temperature)
>  {
> -       struct mtk_thermal *mt = data;
> +       struct mtk_thermal_zone *tz = data;
> +       struct mtk_thermal *mt = tz->mt;
>         int i;
>         int tempmax = INT_MIN;
>
> @@ -698,10 +714,28 @@ static int mtk_read_temp(void *data, int *temperature)
>         return 0;
>  }
>
> +static int mtk_read_sensor_temp(void *data, int *temperature)
> +{
> +       struct mtk_thermal_zone *tz = data;
> +       struct mtk_thermal *mt = tz->mt;
> +       int id = tz->id - 1;
> +
> +       if (id < 0)
> +               return  -EACCES;

nit: one space after return.

> +
> +       *temperature = _get_sensor_temp(mt, id);
> +
> +       return 0;
> +}
> +
>  static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
>         .get_temp = mtk_read_temp,
>  };
>
> +static const struct thermal_zone_of_device_ops mtk_thermal_sensor_ops = {
> +       .get_temp = mtk_read_sensor_temp,
> +};
> +
>  static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>                                   u32 apmixed_phys_base, u32 auxadc_phys_base,
>                                   int ctrl_id)
> @@ -992,6 +1026,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>         u64 auxadc_phys_base, apmixed_phys_base;
>         struct thermal_zone_device *tzdev;
>         void __iomem *apmixed_base, *auxadc_base;
> +       struct mtk_thermal_zone *tz;
>
>         mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>         if (!mt)
> @@ -1080,11 +1115,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, mt);
>
> -       tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
> -                                                    &mtk_thermal_ops);
> -       if (IS_ERR(tzdev)) {
> -               ret = PTR_ERR(tzdev);
> -               goto err_disable_clk_peri_therm;
> +       for (i = 0; i < mt->conf->num_sensors + 1; i++) {
> +               tz = kmalloc(sizeof(*tz), GFP_KERNEL);

I don't see those structures being freed on error, or on driver unbind.

Maybe use dev_kmalloc instead?

> +               if (!tz)
> +                       return -ENOMEM;
> +
> +               tz->mt = mt;
> +               tz->id = i;
> +
> +               tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i, tz, (i == 0) ?
> +                                                            &mtk_thermal_ops :
> +                                                            &mtk_thermal_sensor_ops);
> +
> +               if (IS_ERR(tzdev)) {
> +                       if (PTR_ERR(tzdev) == -ENODEV) {
> +                               dev_warn(&pdev->dev,
> +                                        "sensor %d not registered in thermal zone in dt\n", i);
> +                               continue;
> +                       }
> +                       if (PTR_ERR(tzdev) == -EACCES) {
> +                               ret = PTR_ERR(tzdev);
> +                               goto err_disable_clk_peri_therm;
> +                       }
> +               }
>         }
>
>         return 0;
> --
> 2.18.0
