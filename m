Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBBB68BC2E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 12:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBFL6z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 06:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBFL6w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 06:58:52 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967001E1C7
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 03:58:50 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-16a10138faeso8458137fac.11
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 03:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsjJ8zWtqAqCXteVrwAfjJmVAVl761/6HQAr4tjPuhI=;
        b=TKAPtX2SilJhVL66SLO1SHBuhN54+HJEgw2WCmD8vU9Aedwhv7btwDb/+MKg/LeOg7
         gtgLPMLNKofVYNS9bhsr3F3o5zW/M+dh0IynQOnu9G70kPr8pj7PLWKOlkzcLzKKWCeA
         8/eKubjqXm5Iqor8u0IrRrE6i+EnnOvh0rFaE1W04v7ASRrsICWEdsxvY6xui1CpcpCK
         rNtKpGonNjMFeGxHlYKkcg6H9KeD3khUFktxl/QXjyO8juS5a/pUTolz3DLrjAddab4G
         NDBPP5bJ3/A7QjmWEJafxm/vUvoi1sty1q8/ZfK9C12VyIMhs844iTeCT3Uw29aI5DJA
         LtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsjJ8zWtqAqCXteVrwAfjJmVAVl761/6HQAr4tjPuhI=;
        b=lRu9eMFxvfovVt18/SV7xYZpceawzH2Usc7G+zCcKxHWOgVpuHNdIlzcGmDPSR1QdF
         YyokeJWsYBp4kTQLnAdsbivCx3sfm0mYSOFE1bc8UCYZO3LMRqTLDlrdjt9ZD5vaDk94
         sCP/WhnYcuSM8fIZkYH0q0zASbirajMHOf+48Ovg3WC1hlfpLgoKUGFsIcIO1FNp1298
         YgVdKDffhEetUU/JO1A4y557v2Zf6fLcVAJkA0OeUAqSAJFScc+go/rlGunEK3xeW8lS
         QSPxYCFhbArm4dF89cuo/P/CagMGGFDdfGkrh1rkmNekn02PfaiWH6RI3SV2GglDksFs
         RToQ==
X-Gm-Message-State: AO0yUKXAI5aJSxxkCnOxnePlrNsAVJamtwIVUx8d8fQppjIZda6JBG2W
        upKrsEXImkYkW80K1MMmGGHIPpONxvWxy2DyVyw=
X-Google-Smtp-Source: AK7set/3znUeSPLyl1q0LejT9IPoEKfT+dIThcBlJZNLbaxiZsO4h2xI/9bA2zEwxWVRv0nlh4CmvVfNKoinZRldMyA=
X-Received: by 2002:a05:6870:214:b0:163:a7a4:6fc6 with SMTP id
 j20-20020a056870021400b00163a7a46fc6mr1753704oad.65.1675684729775; Mon, 06
 Feb 2023 03:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20230206082025.1992331-1-yangyingliang@huawei.com>
 <20230206091329.GA30724@cyhuang-hp-elitebook-840-g3.rt> <97bce9a7-581b-4980-0df6-26c2cb6afa86@huawei.com>
In-Reply-To: <97bce9a7-581b-4980-0df6-26c2cb6afa86@huawei.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 6 Feb 2023 19:58:38 +0800
Message-ID: <CADiBU3_fJf5w0A-T=mrXk4DyCq+axag70JFXqEZ+ZuYJwZ=uDA@mail.gmail.com>
Subject: Re: [PATCH -next] power: supply: rt9471: fix using wrong ce_gpio in rt9471_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org, alina_yu@richtek.com,
        cy_huang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> =E6=96=BC 2023=E5=B9=B42=E6=9C=88=
6=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:47=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> On 2023/2/6 17:13, ChiYuan Huang wrote:
> > Due to the Richtek email rule, YingLiang's mailbox could be blocked.
> > Resend by my personal gmail.
> >
> > Hi, YingLiang:
> >
> > Many thanks for the fix.
> >
> > My original thought is to remove ce_gpio in chip data and make it
> > all by SW control only, not to control by HW pin.
> >
> > Could you help to send v2 patch to remove 'ce_gpio' in chip data?
> > And for the macro IS_ERR(chip->ce_gpio), just change to IS_ERR(ce_gpio)=
.
> Did you mean to change the code like this:
Yes. Thank you.
>
> diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.=
c
> index 5d3cf375ad5c..1ea40876494b 100644
> --- a/drivers/power/supply/rt9471.c
> +++ b/drivers/power/supply/rt9471.c
> @@ -141,7 +141,6 @@ enum {
>
>   struct rt9471_chip {
>          struct device *dev;
> -       struct gpio_desc *ce_gpio;
>          struct regmap *regmap;
>          struct regmap_field *rm_fields[F_MAX_FIELDS];
>          struct regmap_irq_chip_data *irq_chip_data;
> @@ -851,7 +850,7 @@ static int rt9471_probe(struct i2c_client *i2c)
>
>          /* Default pull charge enable gpio to make 'CHG_EN' by SW
> control only */
>          ce_gpio =3D devm_gpiod_get_optional(dev, "charge-enable",
> GPIOD_OUT_HIGH);
> -       if (IS_ERR(chip->ce_gpio))
> +       if (IS_ERR(ce_gpio))
>                  return dev_err_probe(dev, PTR_ERR(ce_gpio),
>                                       "Failed to config charge enable
> gpio\n");
>
> Thanks,
> Yang
> >
> > In patch v2, you can add my Reviewed-by tag.
> > Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>
> >
> > On Mon, Feb 06, 2023 at 04:20:25PM +0800, Yang Yingliang wrote:
> >> Pass the correct 'ce_gpio' to IS_ERR(), and assign it to
> >> the 'chip->ce_gpio', if devm_gpiod_get_optional() succeed.
> >>
> >> Fixes: 4a1a5f6781d8 ("power: supply: rt9471: Add Richtek RT9471 charge=
r driver")
> >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> >> ---
> >>   drivers/power/supply/rt9471.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt94=
71.c
> >> index 5d3cf375ad5c..de0bf484d313 100644
> >> --- a/drivers/power/supply/rt9471.c
> >> +++ b/drivers/power/supply/rt9471.c
> >> @@ -851,10 +851,12 @@ static int rt9471_probe(struct i2c_client *i2c)
> >>
> >>      /* Default pull charge enable gpio to make 'CHG_EN' by SW control=
 only */
> >>      ce_gpio =3D devm_gpiod_get_optional(dev, "charge-enable", GPIOD_O=
UT_HIGH);
> >> -    if (IS_ERR(chip->ce_gpio))
> >> +    if (IS_ERR(ce_gpio))
> >>              return dev_err_probe(dev, PTR_ERR(ce_gpio),
> >>                                   "Failed to config charge enable gpio=
\n");
> >>
> >> +    chip->ce_gpio =3D ce_gpio;
> >> +
> >>      regmap =3D devm_regmap_init_i2c(i2c, &rt9471_regmap_config);
> >>      if (IS_ERR(regmap))
> >>              return dev_err_probe(dev, PTR_ERR(regmap), "Failed to ini=
t regmap\n");
> >> --
> >> 2.25.1
> >>
> > .
