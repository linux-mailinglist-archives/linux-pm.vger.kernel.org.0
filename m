Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27D1333374
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 04:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhCJDAq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 22:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhCJDAV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 22:00:21 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3EC06174A;
        Tue,  9 Mar 2021 19:00:10 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id o22so7733822oic.3;
        Tue, 09 Mar 2021 19:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=URr+he47yRCbz6sLVAoi+oxouHEvlImerGdPlTo7EsE=;
        b=IWiTDWTCKD73NZmT16HGnbl6AGoPgsr+7e+o08HsHDM+1NYOZIvwY3geT93wkESK37
         uYcTfQmOjshtkRb+anhAwx6yT2VLVqRmDLFjf7D+tLRfEiWkm+aCcn+KKcfyjIYlqCwW
         gT9s53EjwiyNGMTTXM/RMIByf/12JHP5UEVXONbZBLYuMb/XKcU9fXkV2dgHhH/VY5zj
         KAoxGrXAc3WCH1useYlYfMJn5Mhx6TlhRWk0hkrY2VtgGPQON5Os39+8Eg9KTJJB4K8H
         LMAMeLl87UfOTJIZEjROe7lVtntvGssJemM4NvEIgxJXVMVMdKdqlGM+cqc3nSWK3ATX
         aE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=URr+he47yRCbz6sLVAoi+oxouHEvlImerGdPlTo7EsE=;
        b=aSJ8KWmARFUeZ/Rm/FSiRYWrWJRUjjRxi6NXHPtvOHW6E0ZBet7DesK89nk0zslGfc
         P4d33wNF3PSfJ6qbCnzpl3vKlntB0T8wjv5Xur08CxEhjcAkaEOJvTXVbZENbWetoihe
         YXEnHSHw07pU3JolFaDr6XMqonCi4ciSTKtMgoOoAhME7w3mIPyrfc7sl1V6iDFhk8s5
         Nl3l2ELI8VbbJOBaMeJLFbHj8P4DTVDjAsJjkvXTCxAAW9dOH/0j2X4qiBJrOXn20PrQ
         qIXmzoSMsJCPVzjQqU/L1GpGE0C3Hogt16a4CzycVsQ+7jXNmTYCv9ojJ4cjq3EjW6vv
         bTaA==
X-Gm-Message-State: AOAM5304HMj1mf8wWQeCgo+SC60GWJwMAx477DI3UPJoX0iwrj0RVYKM
        iktK5hLUe21cs5+D2SsvBPGW0q3luL/Rpf1chLk=
X-Google-Smtp-Source: ABdhPJwAiLKPfQtpMX8yE4MQvva4ZzQf187nhgYatRXZ6EctasmIQbyXzJ+Lmboo2+vHs/9tep6Drj43jI7qpJM6DL8=
X-Received: by 2002:a05:6808:1413:: with SMTP id w19mr969481oiv.20.1615345209828;
 Tue, 09 Mar 2021 19:00:09 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-9-git-send-email-aisheng.dong@nxp.com> <0b6ceb75-040f-8e1c-73ea-9d60344b9918@gmail.com>
In-Reply-To: <0b6ceb75-040f-8e1c-73ea-9d60344b9918@gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 10 Mar 2021 11:00:09 +0800
Message-ID: <CAA+hA=T8qezc_oL8KmoWQXg9+3MzykFxh0kW2044hBxcVpmb+g@mail.gmail.com>
Subject: Re: [PATCH 08/11] PM / devfreq: check get_dev_status in devfreq_update_stats
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 10, 2021 at 12:20 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> > Check .get_dev_status() in devfreq_update_stats in case it's abused
> > when a device does not provide it.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   drivers/devfreq/governor.h | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> > index 31af6d072a10..67a6dbdd5d23 100644
> > --- a/drivers/devfreq/governor.h
> > +++ b/drivers/devfreq/governor.h
> > @@ -89,6 +89,9 @@ int devfreq_update_target(struct devfreq *devfreq, un=
signed long freq);
> >
> >   static inline int devfreq_update_stats(struct devfreq *df)
> >   {
> > +     if (!df->profile->get_dev_status)
> > +             return -EINVAL;
> > +
>
> I'm considering the following method instead of returning the error
> when .get_dev_status is NULL.
>
>         if (!df->profile->get_dev_status) {
>                 df->last_status.total_time =3D 0;
>                 df->last_status.busy_time =3D 0;
>                 df->last_status.current_frequency =3D 0;
>                 return 0;
>         }

I might  suggest not cause it's meaningless for ondemand governor but
introducing confusing. Simply return error could make the life a bit easier=
.
does it make sense to you?

Regards
Aisheng

>
> >       return df->profile->get_dev_status(df->dev.parent, &df->last_stat=
us);
> >   }
> >   #endif /* _GOVERNOR_H */
> >
>
>
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
