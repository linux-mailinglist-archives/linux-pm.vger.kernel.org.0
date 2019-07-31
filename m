Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3617B918
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 07:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfGaFiY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 01:38:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43403 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfGaFiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 01:38:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so31184798pfg.10
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TSeu1DhyaOIFQSAHZYOAVKMNovlOrU6xzHbF1lgB4I=;
        b=BT5FgT8Zn+wGKhAqBLPZLffaJWP58As3cP2B6/fhh8Ks+jwpBg4HYS23k/K3cSv1v1
         uuslhPa0DP3TU9j34PUX7Joum4USeHLF2nHL/Vv2r/dR3v9k5TtPb3FqlF9HeNaAjq2V
         rQhqzZwo0y6oHzH/mVI60H2OLgA9bITfHjPM+pQm1nH/8gVfqfly/p1O6bEfnoWs/tnS
         1Ux1XlAGACX2Y0vNs6asLshBj2581h+NBMnSxGMSpfBprSzjZIY4dMiSl7s3pPyDs45L
         WpIOqAhqrRfnfL8fUBOU9Lll19IuJkVvmUKYX3U4IrK8Piut3HoEqoqDoJNk5s1YNukg
         RbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TSeu1DhyaOIFQSAHZYOAVKMNovlOrU6xzHbF1lgB4I=;
        b=F7qMiQ3EUcPui8L9PaSqxM0sDh2DTnrOYw4kuPmQL3lUqck07hFTjDKdgX4npV1J5A
         tfW0CKf//nkR4cTmos83/L1vZWMjQvtH+z2h1FaHiDymdGFVamPlDj03Ekv8xqnnHzMp
         0NPp8sm5l/QwcjHHkPaU4wpOTtyybbFn3wBNwyYU5ujAmFkD+yihXX1f8hiumLgroBci
         dOFjbnFL7zwJ3rlO2DY/b2LQcboy5xXRWCxHnvZBMvKjlQjgrIy6uiAfnt3A7IZ/ROW9
         O6gc9rBBz/RY13iqYNuyNV0AEEd/CLB3SR+5ChOi8lERZ9n7/gGgLL/dtF3v+dA8n2ut
         +bHQ==
X-Gm-Message-State: APjAAAXtizrYaC9hglzTwtRnpWzJ49LRMzj4rnChhJrOEF+VxkCTjXQa
        ZBvGJioKKmDzWK0eSgxA3hwqAJ4x
X-Google-Smtp-Source: APXvYqxOKlGwzoU1AaaxZ/JRPY4tcZaGrrG3cgaSPHSmFlU2qf1Htc23wvqZPBIpCccKAoFebVwhsg==
X-Received: by 2002:a62:5344:: with SMTP id h65mr46050292pfb.32.1564551503398;
        Tue, 30 Jul 2019 22:38:23 -0700 (PDT)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id q1sm89405667pfn.178.2019.07.30.22.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 22:38:23 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:38:08 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] PM / devfreq: Drop the name check to request module in
 try_then_request_governor()
Message-ID: <20190731133808.00006f5b.zbestahu@gmail.com>
In-Reply-To: <8e5efa9c-96c4-0c2c-b92a-d72ee598838c@samsung.com>
References: <CGME20190730100844epcas4p14dfa39fff2636e89c94033f154240db0@epcas4p1.samsung.com>
        <20190730100819.8056-1-zbestahu@gmail.com>
        <8e5efa9c-96c4-0c2c-b92a-d72ee598838c@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 31 Jul 2019 09:33:06 +0900
Chanwoo Choi <cw00.choi@samsung.com> wrote:

> On 19. 7. 30. =EC=98=A4=ED=9B=84 7:08, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> >=20
> > No need to check specific governor name of `simple_ondemand` to request
> > module, let's change the name string to `simpleondemand` to keep the
> > consistency on loading module if needed. =20
>=20
> NACK.
>=20
> hmm.... It is impossible to change the devfreq governor name
> because there are many reason.
>=20
> The devfreq governor could be changed through the sysfs interface
> on runtime. For a long time, many users or platforms change
> the devfreq governor with the defined governor name through sysfs.
> If it is just changed, it breaks ABI interface and cannot support
> the compatibility. It is very critical problem. Please drop it.

Yes, needs update also if using sysfs. it's problem indeed.

>=20
>=20
> Maybe, you didn't check the usage of devfreq device driver
> in the mainline kernel. Almost devfreq device using simple_ondemand
> governor have to add the governor name with devfreq_add_device().
> If changed the governor name, it cause the fault of device driver
> using the devfreq framework with simple_ondemand.

Currently, seems no devfreq users use the simple_ondemand directly in
mainline kernel.

Maybe we can rename the governor file name to governor_simpleondemand.c,
just not compatible to module name compared with this change.

Thanks.

>=20
>=20
> >=20
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/devfreq/devfreq.c | 6 +-----
> >  include/linux/devfreq.h   | 2 +-
> >  2 files changed, 2 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 784c08e..baff682 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -246,11 +246,7 @@ static struct devfreq_governor *try_then_request_g=
overnor(const char *name)
> >  	if (IS_ERR(governor)) {
> >  		mutex_unlock(&devfreq_list_lock);
> > =20
> > -		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
> > -			     DEVFREQ_NAME_LEN))
> > -			err =3D request_module("governor_%s", "simpleondemand");
> > -		else
> > -			err =3D request_module("governor_%s", name);
> > +		err =3D request_module("governor_%s", name);
> >  		/* Restore previous state before return */
> >  		mutex_lock(&devfreq_list_lock);
> >  		if (err)
> > diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> > index 2bae9ed..41e8792 100644
> > --- a/include/linux/devfreq.h
> > +++ b/include/linux/devfreq.h
> > @@ -17,7 +17,7 @@
> >  #define DEVFREQ_NAME_LEN 16
> > =20
> >  /* DEVFREQ governor name */
> > -#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
> > +#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simpleondemand"
> >  #define DEVFREQ_GOV_PERFORMANCE		"performance"
> >  #define DEVFREQ_GOV_POWERSAVE		"powersave"
> >  #define DEVFREQ_GOV_USERSPACE		"userspace"
> >  =20
>=20
>=20

