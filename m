Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0F77B0B8
	for <lists+linux-pm@lfdr.de>; Mon, 14 Aug 2023 07:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjHNFU4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Aug 2023 01:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjHNFU0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2023 01:20:26 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DC3E77
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2023 22:20:25 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-48719fc6b18so1369187e0c.1
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2023 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691990425; x=1692595225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldE8qOBwh1y7PWVjhUoFCaGJK1VblQjo0GJwUi6utEY=;
        b=Zbtk6rkBw8HM6+xKzgvCmJLkqWs+ewglI5SUHNv17MdQhmreyFIw7dHqD2kGNX7yr7
         z9CInA4M3PZ6HSN71ANoj9zNdZnufXAS1ZqHdqjN94dSeKWq7PN36/3646znxNolzXKl
         cG8590x91xXbknAoO+U+YJatb85wyn92GqGxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691990425; x=1692595225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldE8qOBwh1y7PWVjhUoFCaGJK1VblQjo0GJwUi6utEY=;
        b=eQHp8GndxCmVmX8xHWvwqz+WSFxzHQ7RuKnwEbJo4v72rij671zHsybdObFh7hqQUQ
         h6vWkmS8iaonbPcrYofcNY+HsuBfXZLOcLwB+Gr4N7Tnd+JFoXt6dKQ0Lz/JFbaDhne3
         N/cCLMxQZmcCW3eETXeoFGv5YLGE+l0GpkUw/kiASldxqtRaxL8UvUxWwfnUyO6avFmB
         tPxUd6bhR5cQZrKMewyfX6AWY4Kv43BX9di8czuzyOxPBGRqBjcFLFUdKqxqz/9vJSOw
         RbW7GXAcTog/DnHE6TjmdsKVYo65tvTHoHgfR/zDOR6Moq43tjeZlD5bLCikf6+G4IJV
         wWjw==
X-Gm-Message-State: AOJu0YzruQo3d/ZZufmbSHTVrYokHSqWNCX/2vMhuwlgJ/cbmrrCX5Da
        gM5HgCqzZlnGTOADf5DwPlmeu9KfoPrtEPzPJO8XnA==
X-Google-Smtp-Source: AGHT+IH/yH76PlnuVqLFpXQ7PucJ3pxTFjkPU6MLyXBUxtaUIJbcdk1Yo71+F/jREDnYnK7jfoaaiGen2gwtpA9rPdo=
X-Received: by 2002:a67:eb57:0:b0:443:8eab:c664 with SMTP id
 x23-20020a67eb57000000b004438eabc664mr8438403vso.13.1691990424769; Sun, 13
 Aug 2023 22:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230813190845.49738-1-alex@shruggie.ro>
In-Reply-To: <20230813190845.49738-1-alex@shruggie.ro>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 14 Aug 2023 13:20:13 +0800
Message-ID: <CAGXv+5F8HZOawAKoDvVCx7+mGmEPsELzp-r-6c5tw64c87Aa_A@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/mediatek: remove redundant dev_warn in probe
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        aouledameur@baylibre.com, daniel@makrotopia.org,
        void0red@hust.edu.cn, aboutphysycs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 14, 2023 at 3:09=E2=80=AFAM Alexandru Ardelean <alex@shruggie.r=
o> wrote:
>
> There's no need to print any extra messages in the driver if
> devm_thermal_add_hwmon_sysfs() fails.
> If this function has any failures, they will already be printed.
>
> While looking inside 'drivers/thermal/mediatek/auxadc_thermal.c', the
> failure will be either be one of:
>   'Failed to allocate device resource data'
> or
>   'Failed to add hwmon sysfs attributes'
>
> Also, the failure will be reported on the 'dev' object passed to
> 'devm_thermal_add_hwmon_sysfs()', so it should be clear which device this
> error belongs to.
>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  drivers/thermal/mediatek/auxadc_thermal.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/=
mediatek/auxadc_thermal.c
> index f59d36de20a0..55f7fde470e5 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -1290,11 +1290,7 @@ static int mtk_thermal_probe(struct platform_devic=
e *pdev)
>         if (IS_ERR(tzdev))
>                 return PTR_ERR(tzdev);
>
> -       ret =3D devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> -       if (ret)
> -               dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> -
> -       return 0;
> +       return devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);

You changed the logic here. The original logic is to print a warning
if the hwmon sysfs stuff failed, but continue to probe the driver. In
other words, hwmon sysfs failing is a non-fatal error.

Your changes make it fatal.

ChenYu

>  }
>
>  static struct platform_driver mtk_thermal_driver =3D {
> --
> 2.41.0
>
>
