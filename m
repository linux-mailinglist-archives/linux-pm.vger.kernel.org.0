Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924C54B41EC
	for <lists+linux-pm@lfdr.de>; Mon, 14 Feb 2022 07:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbiBNGXM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Feb 2022 01:23:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbiBNGXL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 01:23:11 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47754F9D6
        for <linux-pm@vger.kernel.org>; Sun, 13 Feb 2022 22:23:04 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id c6so43133656ybk.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Feb 2022 22:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HOKQamnEatvNz5tDze7CUgOE6fsxPpqYhwtuBNAx5e0=;
        b=qtoljcEEeKcXXL1ZsglPfgyg5u5EsImMYhoOyNaP9CJpI7jko3OPrdyov0sMNN4bI+
         yIe4sOFAL9582aAQ6h5VEcUU/tHKsgMXgi7wf7MH7p1jjm86vEbxpK17nTXmxRG88SzO
         7mnMrkJDLO9SueRauGNtW2Lk4LqK5+zzOpfzoegxWT+kmMqKuMQAtQ1501ddvM5xmKft
         N6Hi79f4xHLrefK1gmEA2Llql0zrz2/jpBgR5NI26M+D0pzptnihKpDVQAamvhioYZtf
         fifEGMM+uitiUjIaLhT3+W/FLPlhgLMU3ZrLo6zOG4wb0n3cK34d6BvetP+FNHzuZ8/C
         Mhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HOKQamnEatvNz5tDze7CUgOE6fsxPpqYhwtuBNAx5e0=;
        b=clsFPSbeoyDLzqM/PyuSxM4sVAy+8V5dfCcZXSJ2PSvxRO3XIzGPm4g5SHOmDqrZ2s
         SUu6Mk4B7lKcDiiXRzyfukW5TncvgjmnyMyDW8IeVQZzJhhqFJEO8uUe3yQwpCgM+Blg
         6Obqu4RTEZNcrCqghcsk491p88EYtc8EzJ+nVTbOZoQw/VIzN//ryQgzAysMv9dqYNxZ
         Yx8QcyURhovOz0cJldKnLAluct99EUgCIlVY57Wqq8fkTZIeLuZRm9UYMVdgh/ZZprR0
         3cj4O5J/c4PYogiFzNKm7oQVdN3dRIg75jmbGeB9QYdLjKLNRoKYRkmDz1q97WS/u7Ea
         Cp0w==
X-Gm-Message-State: AOAM532hX97i2cWohSZngTuUuVmUnH0lOygrl3LxvEzmip2f3VjBShN4
        QrD9BVi8fteBl66S3ePYe1zxnamufqgf69P3NEfEDQ==
X-Google-Smtp-Source: ABdhPJxAtN5l2vBqRI/8HiizlplPbM/iSSCIwz05toazt9QbDrX6ydk6JvxcHsjYt+xrzEZxX4yzYlBJ78KIgh6uY0E=
X-Received: by 2002:a25:2155:: with SMTP id h82mr10846482ybh.606.1644819783722;
 Sun, 13 Feb 2022 22:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20220104122500.338870-1-wjack@google.com> <CAHnoD8CtN6QMUDnd+A+WqG__CL0njSqYvgCu0oKTiieQGaE88g@mail.gmail.com>
In-Reply-To: <CAHnoD8CtN6QMUDnd+A+WqG__CL0njSqYvgCu0oKTiieQGaE88g@mail.gmail.com>
From:   Jack Wu <wjack@google.com>
Date:   Mon, 14 Feb 2022 14:22:52 +0800
Message-ID: <CAHnoD8DPRvBXP04H3zzBsefvzvfzVuk271-+WAtYV_2KJBbFEw@mail.gmail.com>
Subject: Re: [PATCH v1] power: supply: add dock type
To:     Sebastian Reichel <sre@kernel.org>
Cc:     kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, AleX Pelosi <apelosi@google.com>,
        Vincent Wang <vincentwang@google.com>,
        Ken Yang <yangken@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Ken

Jack Wu <wjack@google.com> =E6=96=BC 2022=E5=B9=B41=E6=9C=887=E6=97=A5 =E9=
=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8811:37=E5=AF=AB=E9=81=93=EF=BC=9A
>
> + Alex and Vincent
>
> Jack Wu <wjack@google.com> =E6=96=BC 2022=E5=B9=B41=E6=9C=884=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:25=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Add dock power_supply_type for the drivers which supports dock can
> > register a power supply class device with POWER_SUPPLY_TYPE_DOCK.
> >
> > Signed-off-by: Jack Wu <wjack@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 2 +-
> >  drivers/power/supply/power_supply_sysfs.c   | 1 +
> >  include/linux/power_supply.h                | 1 +
> >  3 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentatio=
n/ABI/testing/sysfs-class-power
> > index f7904efc4cfa..854299a0d36f 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -34,7 +34,7 @@ Description:
> >                 Describes the main type of the supply.
> >
> >                 Access: Read
> > -               Valid values: "Battery", "UPS", "Mains", "USB", "Wirele=
ss"
> > +               Valid values: "Battery", "UPS", "Mains", "USB", "Wirele=
ss", "Dock"
> >
> >  **Battery and USB properties**
> >
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/=
supply/power_supply_sysfs.c
> > index c3d7cbcd4fad..53494b56bbb4 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] =
=3D {
> >         [POWER_SUPPLY_TYPE_USB_PD_DRP]          =3D "USB_PD_DRP",
> >         [POWER_SUPPLY_TYPE_APPLE_BRICK_ID]      =3D "BrickID",
> >         [POWER_SUPPLY_TYPE_WIRELESS]            =3D "Wireless",
> > +       [POWER_SUPPLY_TYPE_DOCK]                =3D "Dock",
> >  };
> >
> >  static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =3D {
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.=
h
> > index 9ca1f120a211..fa80eaa54242 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -187,6 +187,7 @@ enum power_supply_type {
> >         POWER_SUPPLY_TYPE_USB_PD_DRP,           /* PD Dual Role Port */
> >         POWER_SUPPLY_TYPE_APPLE_BRICK_ID,       /* Apple Charging Metho=
d */
> >         POWER_SUPPLY_TYPE_WIRELESS,             /* Wireless */
> > +       POWER_SUPPLY_TYPE_DOCK,                 /* Dock Charging */
> >  };
> >
> >  enum power_supply_usb_type {
> > --
> > 2.34.1.448.ga2b2bfdf31-goog
> >
