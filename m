Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68402EA2A5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 02:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbhAEBFC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 20:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbhAEBFA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 20:05:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ECCC061793;
        Mon,  4 Jan 2021 17:04:20 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m12so68841632lfo.7;
        Mon, 04 Jan 2021 17:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qFB4ga3b6zrVvFzwP/V5lTXbc8XFgjamcrO5+xAYPqw=;
        b=b7Ut1+7RhxE2C+5uJ4pPaldgRxEhf7dgUXA3dGUTFKIW6VKPblbJctgYZsO2Nzcizi
         D99um6830h47LOng+NSvzuMGG6U/D4VkSMrX1UfvJN4magZHPbw+PEcrZbuZJZbkRjYU
         EbH6Cv48rz6vCrZ8dEL88oxglcnGJ70gzg08A2pb6tsoOQJmqGQnXz4rPSuiPArAUP/p
         EmeDd76kPSPThZsLieMxk8+OAHQTNBVg6IZOfjM2y+Hd4mWB01oZKi0dFSLKgz1fqUXW
         x4u5OpaoJ6AThtiocAVvfbAcbMoch+74HwQDioQHKXpRTpOrXOhQVUESTvvL4MAQPCJ8
         Uvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qFB4ga3b6zrVvFzwP/V5lTXbc8XFgjamcrO5+xAYPqw=;
        b=YgAn9ILALiMGvLSoNC2SRns/Mh9DpzlTSLqMRZd703A/nssTPx51bhYqREGJOtP9ov
         75Njc63vLv7BLqlrmqSWYcVc7vV8Yv3rw907xYAzPDlYe4MjoR+12UKldQJJHnVkWbl7
         2rGZ2cvkcB2NxUYJIB4y4YsH6vvwrwfT8ZjLj6TX2Z3wou7A4FfNeQacTskpYTDKun+J
         uc6kYlF5S2wsdF0rAgs4QE2yOnsY0ldPDekEkmroqHnZt3yQIc8u4soYXWKccCLqT1Pu
         KjZBpziSRci0YIO09SFPNwQSmnxhJrYathlG+nco9Enk6vseYG53qTEWxU15nf8sgSmT
         JlwQ==
X-Gm-Message-State: AOAM5336LYoIRl57SrbLqvN/tH4c6gYqDTyGAxB1y66m3gH9NDLQQtMT
        2AHxBW6djgXF9HmwjNBppRWJoTlszJvM6CKRBgotscc3S5E=
X-Google-Smtp-Source: ABdhPJwW/Io3SKZnc0eYxs1ZgLjOrQVY0wjTdlEloc3wKQ8tpUfXLhWfEGh4lCyepO9OBaktZU3rlKqMNtXgFGtbaBA=
X-Received: by 2002:ac2:57c7:: with SMTP id k7mr34708916lfo.20.1609808658013;
 Mon, 04 Jan 2021 17:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20201216022538.7389-1-vichy.kuo@gmail.com> <CAOVJa8FTyX89MWieV3C+NmmDqS4EWi7Aok-j4_Tti_ZmVS050A@mail.gmail.com>
In-Reply-To: <CAOVJa8FTyX89MWieV3C+NmmDqS4EWi7Aok-j4_Tti_ZmVS050A@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 5 Jan 2021 10:03:41 +0900
Message-ID: <CAGTfZH3c18jxC8cXR93Ms8XJeYPTa18oOYUX7WsOvk6G0K=nng@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM / devfreq: Replace devfreq->dev.parent as dev in devfreq_add_device
To:     pierre kuo <vichy.kuo@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 29, 2020 at 12:25 AM pierre kuo <vichy.kuo@gmail.com> wrote:
>
> Hi myungjoo, kyungmin and cw:
> Would you please help to review this patch?
>
> Thanks a lot.
>
> pierre Kuo <vichy.kuo@gmail.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=8816=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:26=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > In devfreq_add_device, replace devfreq->dev.parent
> > as dev to keep code simple.
> >
> > Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
> > ---
> >  drivers/devfreq/devfreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 6aa10de792b3..94cc25fd68da 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -893,13 +893,13 @@ struct devfreq *devfreq_add_device(struct device =
*dev,
> >                 goto err_devfreq;
> >
> >         devfreq->nb_min.notifier_call =3D qos_min_notifier_call;
> > -       err =3D dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->=
nb_min,
> > +       err =3D dev_pm_qos_add_notifier(dev, &devfreq->nb_min,
> >                                       DEV_PM_QOS_MIN_FREQUENCY);
> >         if (err)
> >                 goto err_devfreq;
> >
> >         devfreq->nb_max.notifier_call =3D qos_max_notifier_call;
> > -       err =3D dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->=
nb_max,
> > +       err =3D dev_pm_qos_add_notifier(dev, &devfreq->nb_max,
> >                                       DEV_PM_QOS_MAX_FREQUENCY);
> >         if (err)
> >                 goto err_devfreq;
> > --
> > 2.17.1
> >

Applied it. Thanks.


--=20
Best Regards,
Chanwoo Choi
