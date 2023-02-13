Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4AC695207
	for <lists+linux-pm@lfdr.de>; Mon, 13 Feb 2023 21:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBMUii (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 15:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMUih (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 15:38:37 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A71919F37
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 12:38:36 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id a10so4979676iod.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 12:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoB95z68lJ/xA3k7l6QvtSo56NIpxovHD6PN1JU4BOg=;
        b=Annw4bmrZfXP0w3OGFgA+FbaCGKDLSwdhzGeLINx78aPPDpwNSvxkLWi8GfSRV6WSt
         DYSIXKLW4ShPPntzcB4XXf7AaRj7tfBzCHlbtTJqk/txru+AaYO0E761DeW4UHX4fP2W
         PNYyeMnUKW36g2GcVQNaLxn7xEeCzlv9mEnGl83BlDo8dtVNbh8nXDeH2a6SKv+Jjp/k
         6eGgo2Yi9wFU8pqcDtIzMP1nN0Yov01p5wkJciBUW7i2OGjX2Vl6CTBfGmFGqt3zqIAn
         xPVELHBU/VKx522ntn7ZM8vxNASMXUDQlM5l8bqTyfmRd0jx8iWzt01N6X3a4Iqzoapq
         0GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoB95z68lJ/xA3k7l6QvtSo56NIpxovHD6PN1JU4BOg=;
        b=jtWW8DNWqdQYjMLs3DaegOxx3BHOUrfA1bjP57khTi3sJhkK3zTjFO3hjrcnfxYaKo
         AJSUZHzqboItE15MCPP7y0qqS9sLx6eHjbiZX3tbPhnhB//NYSQlRptxXg4aj1OwFnjJ
         rvP5A1ggy5Jn+0qcB8DaR64sS0nfVb2s9gVY/7mA+kF+4p6aKoV3fMZ5d+/NcpMyipi1
         ISHa1bqyjy/ef7TR5K4lTtkFF9c9K0Klkv34MqvLIY2pLwr0an9paX06zNGvs++mWHQr
         zeKBXl7D2JO381fFzWS8wHwhy2YYzsfVI3zmS8ZV06eOqOV/PcyeFTSfFYR4w1SKND2U
         uypA==
X-Gm-Message-State: AO0yUKVv9PtS3nfxHALwmMistul5I2Oy2/zLmU5XOwepJj7t0ofj9U+B
        oa3E3F7m5e2F4V+DqiT2bHsZRfWJ9dxOfWODthFFUTpj8Fg=
X-Google-Smtp-Source: AK7set9gNN7iQOeOC9Is2Cw2kM8JddWdoHiNehlRDALIDkCQzRK1VaKHa8taE0Sxny0nSwep5IsujGWCBBilSANUElg=
X-Received: by 2002:a02:63c8:0:b0:3c2:b6d3:ed94 with SMTP id
 j191-20020a0263c8000000b003c2b6d3ed94mr98552jac.0.1676320715377; Mon, 13 Feb
 2023 12:38:35 -0800 (PST)
MIME-Version: 1.0
References: <4927895.GXAFRqVoOG@tool> <20230213202542.aqsw6tzspo4nrq7n@mercury.elektranox.org>
In-Reply-To: <20230213202542.aqsw6tzspo4nrq7n@mercury.elektranox.org>
From:   =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?= <dgcbueu@gmail.com>
Date:   Mon, 13 Feb 2023 21:38:24 +0100
Message-ID: <CABwr4_sd-kzg90VrQQOw91XsTXOcMq6qkj=TNPy6YQDuA6QQuQ@mail.gmail.com>
Subject: Re: [PATCH] power: reset: linkstation-poweroff: add LS220D/E
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org
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

Hi

El lun, 13 feb 2023 a las 21:25, Sebastian Reichel
(<sebastian.reichel@collabora.com>) escribi=C3=B3:
>
> Hi,
>
> On Sun, Feb 12, 2023 at 05:37:38PM +0100, Daniel Gonz=C3=A1lez Cabanelas =
wrote:
> > Add 2 new devices to the compatible list:
> >   - Buffalo Linkstation LS220D
> >   - Buffalo Linkstation LS220DE
> >
> > Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > ---
> >  drivers/power/reset/linkstation-poweroff.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power=
/reset/linkstation-poweroff.c
> > index 02f5fdb8f..cfee2efd9 100644
> > --- a/drivers/power/reset/linkstation-poweroff.c
> > +++ b/drivers/power/reset/linkstation-poweroff.c
> > @@ -142,6 +142,12 @@ static void linkstation_poweroff(void)
> >  }
> >
> >  static const struct of_device_id ls_poweroff_of_match[] =3D {
> > +     { .compatible =3D "buffalo,ls220d",
> > +       .data =3D &linkstation_power_off_cfg,
> > +     },
> > +     { .compatible =3D "buffalo,ls220de",
> > +       .data =3D &linkstation_power_off_cfg,
> > +     },
> >       { .compatible =3D "buffalo,ls421d",
> >         .data =3D &linkstation_power_off_cfg,
> >       },
>
> Where is the patch adding these compatibles to the DT binding
> documentation?

There is no DT binding at all. So no documentation.

BTW I'm thinking to rework the driver again for adding DT bindings and
therefore rid of the dependeny of adding new devices to the driver,
every time a new compatible device appears. My first versions of this
driver had DT-bindings but the DT documentation maintainer rejected
them. He said there was no need to add any DT binding. So we ended
with this no sense. Let's see if the next time we have a bit more
luck.

Regards


>
> -- Sebastian
