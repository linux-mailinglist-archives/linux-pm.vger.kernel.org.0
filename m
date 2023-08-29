Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2977778CB84
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 19:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbjH2RrH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 13:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbjH2Rqh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 13:46:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2969113
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 10:46:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c4923195dso584671566b.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693331193; x=1693935993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jgu1C3r/JfwEw+3xT0ddR4IdPDnwpgVqd15MZ+FjcQ=;
        b=E3KbYOJ7+CK1EpEjV/Nt/3tXFSn1xoB6HshYRfxKp3nbMZNSbgLwiePpA+3j6XlLxT
         D2FBKeixVsSdOkG73yvNueesghZUktf66Z8wlQqTR8tO0gU7e2NSLrdXgOyxYuPRJ+x1
         FLWYB3CkUiubaSBcq0P1yel6BHIIhd+Wqmqa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693331193; x=1693935993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jgu1C3r/JfwEw+3xT0ddR4IdPDnwpgVqd15MZ+FjcQ=;
        b=iu4oAXPerB1w6iXPuC8OE5iHSdgTNl7x9KBxpZAHRcd9VDWfpYpOi/TDe6C1kuIj4B
         jhMoep/PANXPiQs88w0b3YSFoFe7vyKUvfcSSwjWa8V+D6SjRcSD2mPZnJ75CdM/x07Q
         jxNAnNZEVxdP9W+eG9y9xE3RFEKY4ftYPPP5CbZg6HkYXrHdPuHFt0ZXNj/9/9QwxMOP
         kD0I3kkbASiE8flfJrRwcp9l3zpeFZiNYw8cRr5nbZMXon0xw7aDPvXaz8jKd3V1xjTQ
         gEvAxs8996/iXH5Tt/A4+C5KECWfs2tAtYklyr97U1idJX0SKt5c9fjofocW0J6mQFiK
         Oogw==
X-Gm-Message-State: AOJu0YwW+Px4M6SGALuE8g+hMlT8vWHadLmCDnx/gqwMyJKlT9aCOj+u
        Op0p+kfxTM4VzlYkeMmiMyQN+08qIRXNm3/rtX74lfSl
X-Google-Smtp-Source: AGHT+IGm8zjrEhbOItK8yg1hVMhYyAv55kPdIPWAXmjs8n2wSgua7rpkpDPMqf5wQ7dgCXDhT0/SWQ==
X-Received: by 2002:a17:907:2cf8:b0:9a4:88af:b7b with SMTP id hz24-20020a1709072cf800b009a488af0b7bmr8616260ejc.62.1693331192860;
        Tue, 29 Aug 2023 10:46:32 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id w26-20020a1709064a1a00b009a16975ee5asm6125839eju.169.2023.08.29.10.46.31
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:46:32 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-401da71b7faso6408465e9.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 10:46:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3798:b0:3fe:16c8:65fa with SMTP id
 o24-20020a05600c379800b003fe16c865famr45491wmr.4.1693331191063; Tue, 29 Aug
 2023 10:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230417221610.1507341-1-dnojiri@chromium.org> <20230508123228.pduxcrwylbq73iuj@mercury.elektranox.org>
In-Reply-To: <20230508123228.pduxcrwylbq73iuj@mercury.elektranox.org>
From:   Daisuke Nojiri <dnojiri@chromium.org>
Date:   Tue, 29 Aug 2023 10:46:19 -0700
X-Gmail-Original-Message-ID: <CAC0y+Ah1kLAGzftR8=afm3+uF5U5eH1_E89FwX0--NkZJNVYQg@mail.gmail.com>
Message-ID: <CAC0y+Ah1kLAGzftR8=afm3+uF5U5eH1_E89FwX0--NkZJNVYQg@mail.gmail.com>
Subject: Re: [PATCH] cros_pchg: Sync port status on resume
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian. Friendly ping. Any progress on this? Thanks,


On Mon, May 8, 2023 at 9:37=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Mon, Apr 17, 2023 at 03:16:10PM -0700, Daisuke Nojiri wrote:
> > When a stylus is removed (or attached) during suspend, the device detac=
h
> > (or attach) events can be lost. This patch makes the peripheral device
> > charge driver retrieve the latest status from the EC on resume.
> >
> > BUG=3Db:276414488
> > TEST=3DRedrix
> >
> > Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> > ---
>
> Thanks, queued.
>
> -- Sebastian
>
> >  .../power/supply/cros_peripheral_charger.c    | 25 ++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/p=
ower/supply/cros_peripheral_charger.c
> > index 1379afd9698d..a204f2355be4 100644
> > --- a/drivers/power/supply/cros_peripheral_charger.c
> > +++ b/drivers/power/supply/cros_peripheral_charger.c
> > @@ -227,8 +227,7 @@ static int cros_pchg_get_prop(struct power_supply *=
psy,
> >       return 0;
> >  }
> >
> > -static int cros_pchg_event(const struct charger_data *charger,
> > -                        unsigned long host_event)
> > +static int cros_pchg_event(const struct charger_data *charger)
> >  {
> >       int i;
> >
> > @@ -256,7 +255,7 @@ static int cros_ec_notify(struct notifier_block *nb=
,
> >       if (!(host_event & EC_MKBP_PCHG_DEVICE_EVENT))
> >               return NOTIFY_DONE;
> >
> > -     return cros_pchg_event(charger, host_event);
> > +     return cros_pchg_event(charger);
> >  }
> >
> >  static int cros_pchg_probe(struct platform_device *pdev)
> > @@ -281,6 +280,8 @@ static int cros_pchg_probe(struct platform_device *=
pdev)
> >       charger->ec_dev =3D ec_dev;
> >       charger->ec_device =3D ec_device;
> >
> > +     platform_set_drvdata(pdev, charger);
> > +
> >       ret =3D cros_pchg_port_count(charger);
> >       if (ret <=3D 0) {
> >               /*
> > @@ -349,9 +350,27 @@ static int cros_pchg_probe(struct platform_device =
*pdev)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +static int __maybe_unused cros_pchg_resume(struct device *dev)
> > +{
> > +     struct charger_data *charger =3D dev_get_drvdata(dev);
> > +
> > +     /*
> > +      * Sync all ports on resume in case reports from EC are lost duri=
ng
> > +      * the last suspend.
> > +      */
> > +     cros_pchg_event(charger);
> > +
> > +     return 0;
> > +}
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(cros_pchg_pm_ops, NULL, cros_pchg_resume);
> > +
> >  static struct platform_driver cros_pchg_driver =3D {
> >       .driver =3D {
> >               .name =3D DRV_NAME,
> > +             .pm =3D &cros_pchg_pm_ops,
> >       },
> >       .probe =3D cros_pchg_probe
> >  };
> > --
> > 2.39.2
> >
