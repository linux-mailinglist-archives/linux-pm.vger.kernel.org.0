Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14832196D86
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgC2Mt0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 08:49:26 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35005 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgC2Mt0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 08:49:26 -0400
Received: by mail-ua1-f66.google.com with SMTP id a6so5267935uao.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2020 05:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BKv2gz0DsjMaF/Mz7s/wYq0JAaZxqtaW8p9A6zy8BFw=;
        b=OV6apK94OvbjCTyL09DesQB0SGgOwrppqY2YP/LjETv74YzrTmpIDpOJvWHmExwB5h
         LEoKJC806ZLIUlLPiq3RkMBDaGuD8ZCBKoxvdDFoObgNlAKC0np2EsVRE/zgl3K3wXha
         gyT7VJMqwPu3Q31eiNmUmfT93kaqIlzUT2abneF2X/hIuNkAGpfmJexsRq6+MbVRc4US
         XfzakhQbczj1TwgBERsCHFHtbguGFH5fiSqeXMMym9U5wctQjZJOFfEO6D3rBoLsjQv+
         suHSUhgH38T9k3dspbM2gHSZlz+0qPi1Mjx23D80lVdRUZzJwlggKN525bcgVLQGAYqH
         YMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BKv2gz0DsjMaF/Mz7s/wYq0JAaZxqtaW8p9A6zy8BFw=;
        b=nBxrchVCp8iINpJtdhLCXXiPVvH73EmFEKnLGwMxyKfRVcJkv9S22lJ7G3Z8bLTGDT
         8wJBHRWOXJjKD/UCX2yqJ7O79ohpw58xyBppB4/XEcKlJiOhjitdgr9W4Vhnkp3m0m3X
         dbAZ3NM1PRBgLTpX38gA70aU9XJYfHIi9oyBaVpg3/4oMJ4u9jVAEv5hePflwTvuzU+r
         KKOIRVKpQYMuanUSYZHlPH1ER7iI3OEktHRha6dv7ZaFAODGUx6BtL+xlIMN8nEu74T+
         MohQ08Uo33LdbN2UKtML9Eb8P+AMmGJoZbf7JZ8VfyZAnYa3Km6E1MIPScXmeu6ez1Qe
         i0sw==
X-Gm-Message-State: AGi0PuY8aBpoH3rkSIsPmvV3c1nFWKtIp2HD15ArxfUoOt5JTU1iSepK
        hxRpBSnNLvWRT6VTA5uAfoykN7hPsGahyq5U5EvFt0v5/jR0qQ==
X-Google-Smtp-Source: APiQypIsvN8DwSOa1DIIz7+YdpInfhwNZ+d14wjLvIXeAdQOQVTDA/uPRVxymSqmuAcTfP5nsyfk8CXNY8UbA5IjZWk=
X-Received: by 2002:ab0:2b97:: with SMTP id q23mr4929382uar.74.1585486163437;
 Sun, 29 Mar 2020 05:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200327151951.18111-1-ricardo.canuelo@collabora.com>
 <20200327154345.GA3971@ninjato> <CAGAzgsqJznZi83ijxCgQg463Q4AnwiNX-a0Q9+Og9MW5OJ4Vew@mail.gmail.com>
In-Reply-To: <CAGAzgsqJznZi83ijxCgQg463Q4AnwiNX-a0Q9+Og9MW5OJ4Vew@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sun, 29 Mar 2020 09:49:10 -0300
Message-ID: <CAAEAJfCzquaiCkjxXYOJRH8tpGRkHJBSWnFD--S=C7uAvHwqUg@mail.gmail.com>
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        linux-i2c@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Derek,

On Fri, 27 Mar 2020 at 17:26, dbasehore . <dbasehore@chromium.org> wrote:
>
> On Fri, Mar 27, 2020 at 8:43 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > On Fri, Mar 27, 2020 at 04:19:51PM +0100, Ricardo Ca=C3=B1uelo wrote:
> > > This enables the async suspend property for i2c devices. This reduces
> > > the suspend/resume time considerably on platforms with multiple i2c
> > > devices (such as a trackpad or touchscreen).
> > >
> > > (am from https://patchwork.ozlabs.org/patch/949922/)
> > >
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > Reviewed-on: https://chromium-review.googlesource.com/1152411
> > > Tested-by: Venkateswarlu V Vinjamuri <venkateswarlu.v.vinjamuri@intel=
.com>
> > > Reviewed-by: Venkateswarlu V Vinjamuri <venkateswarlu.v.vinjamuri@int=
el.com>
> > > Reviewed-by: Justin TerAvest <teravest@chromium.org>
> > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > Signed-off-by: Ricardo Ca=C3=B1uelo <ricardo.canuelo@collabora.com>
> > > ---
> >
> > Adding linux-pm to CC. I don't know much about internals of async
> > suspend. Is there a guide like "what every maintainer needs to know
> > about"?
>
> For more details, you can look at the function dpm_resume in the
> drivers/base/power/main.c file and follow from there.
>
> I can't find anything in Documentation/, so here's a short overview:
> Async devices have suspend/resume callbacks scheduled via
> async_schedule at every step (normal, late, noirq, etc.) for
> suspending/resuming devices. We wait for all device callbacks to
> complete at the end of each of these steps before moving onto the next
> one. This means that you won't have a resume_early callback running
> when you start the normal device resume callbacks.
>
> The async callbacks still wait individually for children on suspend
> and parents on resume to complete their own callbacks before calling
> their own. Because some dependencies may not be tracked by the
> parent/child graph (or other unknown reasons), async is off by
> default.
>
> Enabling async is a confirmation that all dependencies to other
> devices are properly tracked, whether through the parent/child
> relationship or otherwise.
>

Have you noticed the async sysfs attribute [1]?

Given this allows userspace to enable the async suspend/resume,
wouldn't it be simpler to just do that in userspace, on the
platforms you want to target (e.g. Apollolake Chromebook devices, and so on=
) ?

Thanks,
Ezequiel

[1] Documentation/ABI/testing/sysfs-devices-power

> >
> > > This patch was originally created for chromeos some time ago and I'm
> > > evaluating if it's a good candidate for upstreaming.
> > >
> > > By the looks of it I think it was done with chromebooks in mind, but
> > > AFAICT this would impact every i2c client in every platform, so I'd l=
ike
> > > to know your opinion about it.
> > >
> > > As far as I know there was no further investigation or testing on it,=
 so
> > > I don't know if it was tested on any other hardware.
> > >
> > > Best,
> > > Ricardo
> > >
> > >  drivers/i2c/i2c-core-base.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.=
c
> > > index cefad0881942..643bc0fe0281 100644
> > > --- a/drivers/i2c/i2c-core-base.c
> > > +++ b/drivers/i2c/i2c-core-base.c
> > > @@ -769,6 +769,7 @@ i2c_new_client_device(struct i2c_adapter *adap, s=
truct i2c_board_info const *inf
> > >       client->dev.of_node =3D of_node_get(info->of_node);
> > >       client->dev.fwnode =3D info->fwnode;
> > >
> > > +     device_enable_async_suspend(&client->dev);
> > >       i2c_dev_set_name(adap, client, info);
> > >
> > >       if (info->properties) {
> > > --
> > > 2.18.0
> > >
