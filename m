Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E020177AACC
	for <lists+linux-pm@lfdr.de>; Sun, 13 Aug 2023 21:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjHMTJd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Aug 2023 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjHMTJd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Aug 2023 15:09:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160E8170A
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2023 12:09:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe655796faso5748073e87.2
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2023 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691953771; x=1692558571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/QpMYkfVylryD6M2iD+mLrIio7qI2AYgvZNai1CJhk=;
        b=soOd+1vSrhK2mf/08qrspicdh90zc4DlbhYi/wPIXH6/6MoCB0kYnhIMcELA64rPSZ
         iDzaJnKDRzAvJcl2plGatNlfW5j7ecuZuV4ZDc2a8tO8dsxarEZYa/W8Fr4aTwlWnI+F
         idjkzpdkBYp4cMm1hBSJI8Pwg4GAmZnPLIcN+vVa0v1TwcTVPjXf0koweN72zf7vtrRJ
         gQjTIQj9CPzFUSXUlMLGlR2LQb9ktm9zgDEhOKQOxIwy6mLR4purJeJYQ8iaLgwSPiSN
         x8wyRsYOEHUopNOLPablk6b2ncpow9hG7S8OIy+Wrh4zXltRRTiXWxHsiNcdCA/UA99b
         hIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953771; x=1692558571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/QpMYkfVylryD6M2iD+mLrIio7qI2AYgvZNai1CJhk=;
        b=U1JKSzTdlGlf7uYKv9vBF4PHwqVB0uFnu3G1lcgRnS9hXzWg7+s5O6r7DTVpacMBjz
         xMB1JunSFOEzoRi6n9TwRpvhneh75j5uyFDjVP+LSkx596eGpDJOKbwtq1yiyH7DEgQv
         I+zA0bg2BUi/irtjJ6zvJIUyWk1BmzbgP0RzKXFGLLe91rldOBP/NRDrSOsJrDoGB6z9
         2h6KszAarDHt0aiiJgsUyytBZjgM6pTpIscEPWTJBcQaXedzCp8+UsRgLrTnRFkAOhHk
         HG2oOEDwSPoWNsfWd9L4pgYpdWQYmRlDb9DINAbXafzH/RflmUaTHowvlVZusohmB07a
         AXpg==
X-Gm-Message-State: AOJu0Yw/bVlaGvyVILoFGo3sthxYMum5TR6eVaUG3IXRvsxVAxGvsFU+
        pDn4uxW3qyFPg+HWDQVTPrVnpGPYqmgWzJACQ72Lvw==
X-Google-Smtp-Source: AGHT+IFlUyxaaLEci+vedVpOU8DF0eK43GJvsF1qRq+YiT52L6g7e/7RILrtTfKINodPhJ3JYwkCwV8j+PIEdkhs1WE=
X-Received: by 2002:a05:6512:1cf:b0:4fe:5680:db1f with SMTP id
 f15-20020a05651201cf00b004fe5680db1fmr4523365lfp.53.1691953771228; Sun, 13
 Aug 2023 12:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230811192847.3838-1-aboutphysycs@gmail.com>
In-Reply-To: <20230811192847.3838-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Sun, 13 Aug 2023 22:09:20 +0300
Message-ID: <CAH3L5Qr1SCXq_Uiz=dn1u49So0Jey0r8XqwRg7GcjgcCs31orA@mail.gmail.com>
Subject: Re: [PATCH] thermal: mediatek: auxadc_thermal: removed call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rdunlap@infradead.org,
        void0red@hust.edu.cn, daniel@makrotopia.org, bchihi@baylibre.com,
        aouledameur@baylibre.com, angelogioacchino.delregno@collabora.com,
        matthias.bgg@gmail.com, rui.zhang@intel.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 11, 2023 at 10:28=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail=
.com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/thermal/mediatek/auxadc_thermal.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/=
mediatek/auxadc_thermal.c
> index f59d36de20a0..99a1c35c68e7 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -1283,8 +1283,6 @@ static int mtk_thermal_probe(struct platform_device=
 *pdev)
>                         mtk_thermal_init_bank(mt, i, apmixed_phys_base,
>                                               auxadc_phys_base, ctrl_id);
>
> -       platform_set_drvdata(pdev, mt);
> -
>         tzdev =3D devm_thermal_of_zone_register(&pdev->dev, 0, mt,
>                                               &mtk_thermal_ops);
>         if (IS_ERR(tzdev))
> --
> 2.34.1
>
