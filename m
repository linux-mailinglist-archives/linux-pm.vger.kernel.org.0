Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6004D6A4C23
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 21:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjB0URy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 15:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjB0URw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 15:17:52 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2803726B1;
        Mon, 27 Feb 2023 12:17:51 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id f14so3044824iow.5;
        Mon, 27 Feb 2023 12:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0/uUKbeUlMXSZoxUa2qhMyrwjpbehtiHXetc7DLyTE=;
        b=LQDdwcyhlKA8e4El7VCXFQvI81RT0I7RygQKZMLmIqAjqh8CQSVOo/p6gKa8MgjxlT
         iAVwrcUg9Fo8+rroDhKZdNC41HevQRloYo5s9+ZbMFzXJUxgkv2UxpzsdEqDSNtspKfj
         0bTvb+XEd/GP6Qyhdgv0z/YAl3bEgRyUucE/yJletywHJh1IeZaxmXzbL+sShaYESWlG
         s/t7sd2iP+3dqiq+812PD0JqDbitYMgRJJFCs8lpgHDb5LbjIYQjra77o78dNv8GSSWu
         fRBEaF0mXKceKgW0tOj30lM8S3KNDGqdHPaDesp/x7f4Y95RgO71R4P7ljdzZugO7QJY
         HH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0/uUKbeUlMXSZoxUa2qhMyrwjpbehtiHXetc7DLyTE=;
        b=Ab8aZgFvKZ/ZacqTeJTe2TuhA+KIWGyNDaxHNNTUtmR1T78wQpossqodTQGgVVnM2Q
         sn4UUHaWMEHVMr2rzdzLSVdZnqK0goEFS6QlBNii+NTViQzo0JrPVwzaDVftDxwllMis
         kCErpXJrIK8efk0OWKgm9+32jhdmCwIoyY7q5psNZjeF1+MqEAYnR39YSoWyseSiJobA
         /g/dgnYonKgM5zjWpe/bd3Dgg+73VzG5OisWA5b9XBFVzioC9XHvOBDalFPs2NgC5u3e
         EjLLJ8mMP4vYT1kaFt7hhP2AjMnjsbpnR9zb/8uizDgvusZXqkC6Yt4MKloBkHMLDPBc
         e5Rw==
X-Gm-Message-State: AO0yUKVztnBlpu7pLkbY7yB1o1EpSKomEFntR9PmAtBXnGAH59I6Tx0z
        9C+ZtKdpb06br+IfHQ+jaFug5HfZ4UKYfkHMlZr9WBp8
X-Google-Smtp-Source: AK7set9pYv3iw2j7lNB9A+/BF4u3cKIAYeVUT78U8rpH2iDU2ilsazWqMgK2bIRctsIPkzAYT1GXwLUjLk3vI/zg8cA=
X-Received: by 2002:a02:290f:0:b0:3c5:1986:699f with SMTP id
 p15-20020a02290f000000b003c51986699fmr205449jap.0.1677529070502; Mon, 27 Feb
 2023 12:17:50 -0800 (PST)
MIME-Version: 1.0
References: <4927895.GXAFRqVoOG@tool> <20230213202542.aqsw6tzspo4nrq7n@mercury.elektranox.org>
 <CABwr4_sd-kzg90VrQQOw91XsTXOcMq6qkj=TNPy6YQDuA6QQuQ@mail.gmail.com> <20230213212200.fgtcfm333aunrxqo@mercury.elektranox.org>
In-Reply-To: <20230213212200.fgtcfm333aunrxqo@mercury.elektranox.org>
From:   =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?= <dgcbueu@gmail.com>
Date:   Mon, 27 Feb 2023 21:17:39 +0100
Message-ID: <CABwr4_vKxWKJsNDVF9yNeSSk4R3nDov-+qY5=nhp4ggr88EpAw@mail.gmail.com>
Subject: Re: [PATCH] power: reset: linkstation-poweroff: add LS220D/E
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

El lun, 13 feb 2023 a las 22:22, Sebastian Reichel
(<sebastian.reichel@collabora.com>) escribi=C3=B3:
>
> [+cc DT binding people]
>
> Hi,
>
> On Mon, Feb 13, 2023 at 09:38:24PM +0100, Daniel Gonz=C3=A1lez Cabanelas =
wrote:
> > > >  static const struct of_device_id ls_poweroff_of_match[] =3D {
> > > > +     { .compatible =3D "buffalo,ls220d",
> > > > +       .data =3D &linkstation_power_off_cfg,
> > > > +     },
> > > > +     { .compatible =3D "buffalo,ls220de",
> > > > +       .data =3D &linkstation_power_off_cfg,
> > > > +     },
> > > >       { .compatible =3D "buffalo,ls421d",
> > > >         .data =3D &linkstation_power_off_cfg,
> > > >       },
> > >
> > > Where is the patch adding these compatibles to the DT binding
> > > documentation?
> >
> > There is no DT binding at all. So no documentation.
>
> You are referencing a compatible, so there is supposed to be
> a DT binding for it. Note, that you also need DT bindings for
> board level compatible values. See for example:
>
> Documentation/devicetree/bindings/arm/rockchip.yaml
> Documentation/devicetree/bindings/arm/fsl.yaml

Since the driver uses the root compatible string, I don't see any
binding to document at least for the driver itself.  Nor I don't see
where a reference for this driver should be put if I documented the
board compatible strings.

>
> -- Sebastian
