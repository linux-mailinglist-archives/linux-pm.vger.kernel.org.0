Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DE77B155
	for <lists+linux-pm@lfdr.de>; Mon, 14 Aug 2023 08:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjHNGQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Aug 2023 02:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjHNGQi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2023 02:16:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F98F4
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2023 23:16:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe55d70973so4615914e87.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2023 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691993795; x=1692598595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtp1bzCVDFwIiSovncTLXWQtJcUXbRosxyZwqe0vmGs=;
        b=YDpPpXmNzXUlbdG/UEBe8x7JmXGK7eWE++II4MlYs3jd4ooDq7+4xrWE/uz3RVWarW
         X9MKyT7BzZoZQFd7YypPoAau3NpVVvknneEgz5Sos4Qs2eRGxA7eGm6eB+wwEi+Znb2b
         xSluQmB9hDhc+I75zzM4QOJgc0Q4pAcqvEb8QxQ3VJ4vKjQ4XnJCeg5VWRoMdCI2JK5e
         CTePX9wdt/V1Ecneh4tno0VhK+I07wNN1/lBqT/G034Xv2fJgLKTVsh9znST1GKP4Odh
         DvY5tGtIAZHWHFtS7F06t0Kc0YuAn9kfB8BKy7MPRlxUCRJU+X2FBUHixQlcD3VbJDiv
         JKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691993795; x=1692598595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtp1bzCVDFwIiSovncTLXWQtJcUXbRosxyZwqe0vmGs=;
        b=L173dgwkvnfgQi8a3GF/R8oDIGk4fWPdWCst07vXk+aBqLckJss14lTb2GlWLWJHAK
         NLnCjtrB0XGh8UbxAosos2/AlBZiQK4k/rPOoS81Sl2Knoz/159s8iEix3jvI4FWBypO
         UrEZ3eiEa5k10eurGF918KOlbuwiYaVTL1yHiL8nu1tjzjdhVpgbH/TNEpmRScLKx4JQ
         qFXkCS1qMtjauabgj1/UEAJyBQTQUSrVW4+Ct3gBMxs0XSQVr7mNHY+KSy35HAKwVSKN
         I21509bDsNXVNWGIgmYE7WrCWnq6/w1X6iezGLeZP7pHBnD/oj8xXH1wg6DbrlegnNnt
         1mLA==
X-Gm-Message-State: AOJu0Yz4Fho2qiiNoundqC5znVCvwdIJYOpMD2AhU1WeLKV8LOfXjREj
        gZvgjf1/BjUt20iSdFVwUo3Dh9a72bI0vLMC4PkbZA==
X-Google-Smtp-Source: AGHT+IEB803wvl7rL05GuOz87zusd0mp83hEVNoYiEid4k5V2fkib0/LS0E2ZX26IunNIvwK54X/SvavadmoSxcMyr8=
X-Received: by 2002:a05:6512:110d:b0:4fe:8c1a:e9b7 with SMTP id
 l13-20020a056512110d00b004fe8c1ae9b7mr3885743lfg.34.1691993794927; Sun, 13
 Aug 2023 23:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230813190845.49738-1-alex@shruggie.ro> <CAGXv+5F8HZOawAKoDvVCx7+mGmEPsELzp-r-6c5tw64c87Aa_A@mail.gmail.com>
In-Reply-To: <CAGXv+5F8HZOawAKoDvVCx7+mGmEPsELzp-r-6c5tw64c87Aa_A@mail.gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Mon, 14 Aug 2023 09:16:23 +0300
Message-ID: <CAH3L5QpgFzyhru8AXHHnp5DFqb60tGxQ93Kf_+vdm12N5V72tw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/mediatek: remove redundant dev_warn in probe
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        aouledameur@baylibre.com, daniel@makrotopia.org,
        void0red@hust.edu.cn, aboutphysycs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 14, 2023 at 8:20=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Mon, Aug 14, 2023 at 3:09=E2=80=AFAM Alexandru Ardelean <alex@shruggie=
.ro> wrote:
> >
> > There's no need to print any extra messages in the driver if
> > devm_thermal_add_hwmon_sysfs() fails.
> > If this function has any failures, they will already be printed.
> >
> > While looking inside 'drivers/thermal/mediatek/auxadc_thermal.c', the
> > failure will be either be one of:
> >   'Failed to allocate device resource data'
> > or
> >   'Failed to add hwmon sysfs attributes'
> >
> > Also, the failure will be reported on the 'dev' object passed to
> > 'devm_thermal_add_hwmon_sysfs()', so it should be clear which device th=
is
> > error belongs to.
> >
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> > ---
> >  drivers/thermal/mediatek/auxadc_thermal.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/therma=
l/mediatek/auxadc_thermal.c
> > index f59d36de20a0..55f7fde470e5 100644
> > --- a/drivers/thermal/mediatek/auxadc_thermal.c
> > +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> > @@ -1290,11 +1290,7 @@ static int mtk_thermal_probe(struct platform_dev=
ice *pdev)
> >         if (IS_ERR(tzdev))
> >                 return PTR_ERR(tzdev);
> >
> > -       ret =3D devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> > -       if (ret)
> > -               dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs"=
);
> > -
> > -       return 0;
> > +       return devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
>
> You changed the logic here. The original logic is to print a warning
> if the hwmon sysfs stuff failed, but continue to probe the driver. In
> other words, hwmon sysfs failing is a non-fatal error.
>
> Your changes make it fatal.

Ah, right.
My bad

>
> ChenYu
>
> >  }
> >
> >  static struct platform_driver mtk_thermal_driver =3D {
> > --
> > 2.41.0
> >
> >
