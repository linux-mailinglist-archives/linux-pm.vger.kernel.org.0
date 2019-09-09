Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6CAD7B1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 13:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403947AbfIILNc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 07:13:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45958 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbfIILNc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 07:13:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so12536528qkb.12
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2019 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzbLF6sbAfnYGWD1gps2x+aTn+RTiERXdUTulw6z7hQ=;
        b=Wy9JBMoInEpqgAuxp685QyKa5ze/CdmRctwNIx+YUn3diwI2ekQH827hLTqILdGdpH
         ijLDyH3iJaljZelFRRQpN0VMLFiFqRG7FeEzjWX8yVrdWas01LjLQMvIseG8b818neLa
         PDAylHjNa9xQapcnZV67KChPZj571VnAwAIdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzbLF6sbAfnYGWD1gps2x+aTn+RTiERXdUTulw6z7hQ=;
        b=Gup+cycvC67cIQ82PH32txTVwTBK9A5MihEo46DZmyYF2NBeXLzg9uJETtu3/8cOfc
         AgwhX9Q+fTAhzFbTqrBzQ5rxEm8k51VfFxyk5kJT/2BkQtaFrOpv7gB+uW2Eg9g8iotF
         g3e5F1p20ZxfVp8BHb/AXDlIiweb6f3bO2qDz8xpNxZjdGSplKIoOnQQQgw/KyjompCa
         5uiWyi73XUOEHo1kBmgOI4N5m4fGYQJNpxtHn2eK2J0FMCqKnors3AKKKKQ5uGHp/IFE
         HA3DdTZO5BIIGx44OE4ix93kvbqDyydIsFeYbG8SvoUTqRF0z/PzmRu2tZQh9HhHP4Bx
         mUWw==
X-Gm-Message-State: APjAAAVueL/VPISfpMsdLldj+WC4C3hqVxfyolAcuKsnYXMIgzGPyYef
        aeGrUbb3B29XmCULeJnVEg/544SGFyxBVOt4Ma44PA==
X-Google-Smtp-Source: APXvYqyq3aUpXGkyGgaCMRUaagfPTK6C+li0tdEdPnVUTi7iZ7wtjzbPg5aluymGe3qw3C73YRQ0Nw6f3LWEw1sUDMk=
X-Received: by 2002:a37:9b0e:: with SMTP id d14mr21627093qke.315.1568027611116;
 Mon, 09 Sep 2019 04:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com> <1557494826-6044-8-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1557494826-6044-8-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 9 Sep 2019 19:13:05 +0800
Message-ID: <CAJMQK-jNAX_ADa1jAXBeB-eyqNJKqNLtCJ54nGkB=n1A=fGZxw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] thermal: mediatek: add another get_temp ops for
 thermal sensors
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 10, 2019 at 9:27 PM michael.kao <michael.kao@mediatek.com> wrote:
>
> From: Michael Kao <michael.kao@mediatek.com>
>
> Provide thermal zone to read thermal sensor
> in the SoC. We can read all the thermal sensors
> value in the SoC by the node /sys/class/thermal/
>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/mtk_thermal.c | 68 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 60 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index cb41e46..d5c78b0 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -230,6 +230,11 @@ enum {
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
> @@ -612,7 +617,7 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>                  * not immediately shut down.
>                  */
>                 if (temp > 200000)
> -                       temp = 0;
> +                       temp = -EACCES;
Should we return -EAGAIN here? Otherwise there would be warning:
[    0.344167] thermal thermal_zone5: failed to read out thermal zone (-13)

Since first read is bogus value, I think EAGAIN also makes sense here.
>
>                 if (temp > max)
>                         max = temp;
> @@ -623,7 +628,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>
>  static int mtk_read_temp(void *data, int *temperature)
>  {
> -       struct mtk_thermal *mt = data;
> +       struct mtk_thermal_zone *tz = data;
> +       struct mtk_thermal *mt = tz->mt;
>         int i;
>         int tempmax = INT_MIN;
>
> @@ -636,16 +642,48 @@ static int mtk_read_temp(void *data, int *temperature)
>
>                 mtk_thermal_put_bank(bank);
>         }
> -
>         *temperature = tempmax;
>
>         return 0;
>  }
>
> +static int mtk_read_sensor_temp(void *data, int *temperature)
> +{
> +       struct mtk_thermal_zone *tz = data;
> +       struct mtk_thermal *mt = tz->mt;
> +       const struct mtk_thermal_data *conf = mt->conf;
> +       int id = tz->id - 1;
> +       int temp = INT_MIN;
> +       u32 raw;
> +
> +       if (id < 0)
> +               return  -EACCES;
> +
> +       raw = readl(mt->thermal_base + conf->msr[id]);
> +
> +       temp = raw_to_mcelsius(mt, id, raw);
> +
> +       /*
> +        * The first read of a sensor often contains very high bogus
> +        * temperature value. Filter these out so that the system does
> +        * not immediately shut down.
> +        */
> +
> +       if (temp > 200000)
> +               return  -EACCES;
Same here.
> +
> +       *temperature = temp;
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
> @@ -878,6 +916,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>         struct resource *res;
>         u64 auxadc_phys_base, apmixed_phys_base;
>         struct thermal_zone_device *tzdev;
> +       struct mtk_thermal_zone *tz;
>
>         mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>         if (!mt)
> @@ -959,11 +998,24 @@ static int mtk_thermal_probe(struct platform_device *pdev)
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
> +               if (!tz)
> +                       return -ENOMEM;
> +
> +               tz->mt = mt;
> +               tz->id = i;
> +
> +               tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i,
> +                               tz, (i == 0) ?
> +                               &mtk_thermal_ops : &mtk_thermal_sensor_ops);
> +
> +               if (IS_ERR(tzdev)) {
> +                       if (IS_ERR(tzdev) != -EACCES) {
> +                               ret = PTR_ERR(tzdev);
> +                               goto err_disable_clk_peri_therm;
> +                       }
> +               }
>         }
>
>         return 0;
> --
> 2.6.4
>
