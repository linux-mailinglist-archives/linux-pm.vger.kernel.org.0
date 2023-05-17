Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF3706F2E
	for <lists+linux-pm@lfdr.de>; Wed, 17 May 2023 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjEQRRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 May 2023 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEQRRo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2023 13:17:44 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83B272B
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 10:17:43 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-192b330a577so410921fac.3
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684343863; x=1686935863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OOyta/hddAeQOiPneG+F0hrS7BHOoJYBe4jmIKtizw=;
        b=jDwKqmlfR8p3U2p3weKfZxagtW4VbLIdQuRjpNVtYYOO/H7F6JAdw+KOjDYY19W9LQ
         5tO9QlsbvNaNQ0ZOSD5kI6vGzMaOxdtFw7IGNevB6D2olW9s2vg+c5ShMce2lPZjViai
         yZtoBdFj6H/GdhSf5TxahHdon8xaTj/ep2KdOJgfDbe5EOuZMn91k4JjIqVbDssBZyIn
         XLDRJ9YhxcfuhJxcFMBda9Ow1sBWuTrcO2L4GtemOPE6hKcD+93yZMroXhojGwDh4gJc
         Tflmvpyo8Z4Hmh5hvaAnyN8b2b/bPaim+y1HfMKsrVtiVkytgdlNG2X1HfmX9828xGlQ
         OBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684343863; x=1686935863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OOyta/hddAeQOiPneG+F0hrS7BHOoJYBe4jmIKtizw=;
        b=FJiwFamkaHk/SkFToRaB2J3PqFxu0Us+E48t/IJMeXQ7cesjePMtDh3soWYYkOnKnW
         m5qXtvX9A7WUbW2/5fCnFoJbI1eMpCHbcs7+sigLSt8+qhYREQwdvMziimValZH8hS7G
         IeXtohuW01lpuDrTR+yQ4Gh3T/I96siyxgHIKLjvPOh+EdB6ACWbW0EpeBlG61DXiHCd
         ehV5TRT+omP/B0zO7j55baytmGIoXXlI7VhM2GfrVt8TWS6bB4R2qhQxYJ7vywnuS3jS
         JJqLLW7rO7L+hgG1O8opHtaOgfNo1BsQdUTAdxv/l+9Xrs06asCjtrfq84QQGfWACYOa
         7Esw==
X-Gm-Message-State: AC+VfDx46ahG11YJuWeVPKZrlL6uM3B51Y+HMUI8jjbfs+AbaC8SJG6e
        nTs/mj9KXsoFXmUvIj9kiIeaMNVcfaXeKKlP5Xthvxheo5A=
X-Google-Smtp-Source: ACHHUZ58jipsXh40/P6qEAhyimJfk7WVyx3fCRb3OvfONAapPWQk2xZlZOkVZjS0IZcmo3kldchLsVMNfqZnDv82NwU=
X-Received: by 2002:a05:6870:a607:b0:18b:767:c366 with SMTP id
 e7-20020a056870a60700b0018b0767c366mr18144101oam.32.1684343863102; Wed, 17
 May 2023 10:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain>
 <SN6PR06MB534254918F9D84F996BFD2ACA5719@SN6PR06MB5342.namprd06.prod.outlook.com>
 <7ffee6ca-00fb-4fdb-8741-8f9163bfa75b@kili.mountain> <SN6PR06MB53428AF7C7CB29DD6EE243FAA5789@SN6PR06MB5342.namprd06.prod.outlook.com>
 <fa8e551c-ee7e-4f35-8592-7c9b4f4ccbd5@kili.mountain>
In-Reply-To: <fa8e551c-ee7e-4f35-8592-7c9b4f4ccbd5@kili.mountain>
From:   Chris Morgan <macroalpha82@gmail.com>
Date:   Wed, 17 May 2023 12:17:32 -0500
Message-ID: <CADcbR4JmztaqZD4k1eKu=4c3ACMxpeQaydH7-Cs_qrfULcQtmQ@mail.gmail.com>
Subject: Re: [bug report] power: supply: Add charger driver for Rockchip RK817
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Chris Morgan <macromorgan@hotmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry, meant to say my "temporary" fix. Again just wanted to recreate
the problem first.

Thank you.

On Wed, May 17, 2023 at 5:55=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Mon, May 15, 2023 at 11:49:07AM -0500, Chris Morgan wrote:
> > On Tue, May 09, 2023 at 07:19:44AM +0300, Dan Carpenter wrote:
> > > On Mon, May 08, 2023 at 01:46:53PM -0500, Chris Morgan wrote:
> > > > On Thu, May 04, 2023 at 01:58:31PM +0300, Dan Carpenter wrote:
> > > > > Hello Chris Morgan,
> > > > >
> > > > > The patch 11cb8da0189b: "power: supply: Add charger driver for
> > > > > Rockchip RK817" from Aug 26, 2022, leads to the following Smatch
> > > > > static checker warning:
> > > > >
> > > > > drivers/power/supply/rk817_charger.c:1198 rk817_charger_probe()
> > > > > warn: inconsistent refcounting 'node->kobj.kref.refcount.refs.cou=
nter':
> > > > >   inc on: 1088,1105,1115,1124,1130,1136,1146,1160,1166,1170,1177,=
1186,1193
> > > > >   dec on: 1067
> > > > >
> > > > > drivers/power/supply/rk817_charger.c
> > > > >     1048 static int rk817_charger_probe(struct platform_device *p=
dev)
> > > > >     1049 {
> > > > >     1050         struct rk808 *rk808 =3D dev_get_drvdata(pdev->de=
v.parent);
> > > > >     1051         struct rk817_charger *charger;
> > > > >     1052         struct device_node *node;
> > > > >     1053         struct power_supply_battery_info *bat_info;
> > > > >     1054         struct device *dev =3D &pdev->dev;
> > > > >     1055         struct power_supply_config pscfg =3D {};
> > > > >     1056         int plugin_irq, plugout_irq;
> > > > >     1057         int of_value;
> > > > >     1058         int ret;
> > > > >     1059
> > > > >     1060         node =3D of_get_child_by_name(dev->parent->of_no=
de, "charger");
> > > > >     1061         if (!node)
> > > > >     1062                 return -ENODEV;
> > > > >     1063
> > > > >     1064         charger =3D devm_kzalloc(&pdev->dev, sizeof(*cha=
rger), GFP_KERNEL);
> > > > >     1065         if (!charger) {
> > > > >     1066                 of_node_put(node);
> > > > >
> > > > > This error path calls of_node_put() but probably they all should.
> > > >
> > > > Thank you for pointing this out. So I should probably just add a "g=
oto"
> > > > that puts the node at the end, and direct every error to this? Just
> > > > want to confirm.
> > > >
> > >
> > > Yes, please.
> > >
> > > regards,
> > > dan carpenter
> > >
> >
> > Would it be possible to get details on how the error was generated with=
 smatch?
> > I tried based on the instructions from https://smatch.sourceforge.net/ =
but I
> > was not able to generate the error prior to attempting my fix. For my f=
ix I
> > was just going to do an of_node_put(node) right after I set
> > `pscfg.of_node =3D node` and I want to make sure that solves the proble=
m.
> >
> > Thank you.
>
> Hi Chris,
>
> This warning relies on the cross function DB.  It's not hard to build
> the cross function DB, but it just takes like 8 hours or something.
>         smatch_scripts/build_kernel_data.sh
>
> Your patch would silence the warning, but I had assumed we would want to
> hold the reference for the lifetime of the driver...
>
> regards,
> dan carpenter
>
>
>
