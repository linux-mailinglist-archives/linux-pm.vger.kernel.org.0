Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85D033333D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 03:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhCJCnf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 21:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhCJCnM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 21:43:12 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5B1C06174A;
        Tue,  9 Mar 2021 18:43:12 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id u62so1637605oib.6;
        Tue, 09 Mar 2021 18:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F2WtursS9FB/V5aB1Z4wEsHDTwsDtKaqk4kLHb7iNqk=;
        b=Gl4EERA1yednX8DqjmI0QKeto5e6PjZ5bIosfYzxXIBvLkBhdvSQfeqiRpOaziedsr
         LHFjLOui55NBy+ZwKOEd2i/gTUPUN97r52JG1wcFlYeABf7ra9das72cwWaRPgM9WzuF
         RKNXvNBEkQMmk32Rf2+NyVzAazktsXe19nfUzoXYYbfXz8Jjfv9iTyXZ7Dlm8WkFdq+l
         lKvaUtsO0h49ORaDtuRXAucHWtS6KquTtzBcudB7fh/hONhg6v7YaUP/9ASrlCELpPZM
         wH3+FI2uQFi+zXOLUpaQw7uydc+hTstvdFhyukH0oITkyLG3Y33ej+s+evGwfKAnFVcg
         eZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F2WtursS9FB/V5aB1Z4wEsHDTwsDtKaqk4kLHb7iNqk=;
        b=Qr1s9ieVCckpjLyfcyX6l60135DyL9CrRv60nRCNbhamfstu8DP32vl6pUPJ05xSSn
         WXrL0SBc3r6D7eW6TD8XJz8m89jpBPMcthQ811TLKvvycVWQ9azK6vHs8+5YYxkp4LL0
         cxcnwZOrtSF0Xttt3rT+yU91tr7sk6Wue2zUMZfcremxYBkJ5zyhKqsCsWub0tKrvt8q
         Kc+iUYye/Tts+rVTRwSArn1ZaDyLP6O/sjUapyfQ3WBBFMr0wTX1jSwK/V8krSAEmBD5
         oBsWIw9g7vpKJO9hgcxjI7Exnt/5zLFv8AZVxbxbw7CkN0ITne9pElHf2G9I2lOA51oX
         Eclg==
X-Gm-Message-State: AOAM533ad4sDIMoYpwAbIZTEyXhq2SzZOHJV7nSif8UFk/RRINiBY3tJ
        EX2mo6IkrrMwrGTMN+hUTKkwlHSSRZgq+5evXZM=
X-Google-Smtp-Source: ABdhPJxNAuoVvayE+DptArQ5dsyvuGOle2rMzs1MkMj+Gqzo0NcOmx+A8pTSKp8+0e+vHTpiyunyR/ZRb3z+FVJmU90=
X-Received: by 2002:a05:6808:1413:: with SMTP id w19mr935543oiv.20.1615344191728;
 Tue, 09 Mar 2021 18:43:11 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-6-git-send-email-aisheng.dong@nxp.com> <83240e9d-383a-74a9-3222-68cf42d3d0e1@gmail.com>
In-Reply-To: <83240e9d-383a-74a9-3222-68cf42d3d0e1@gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 10 Mar 2021 10:43:11 +0800
Message-ID: <CAA+hA=QpAcu0OVZwm8DuqUsENMem-+59QwOt0Y9cqstuGO5VEw@mail.gmail.com>
Subject: Re: [PATCH 05/11] PM / devfreq: use more accurate returned new_freq
 as resume_freq
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

On Tue, Mar 9, 2021 at 11:53 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> > Use the more accurate returned new_freq as resume_freq.
> > It's the same as how devfreq->previous_freq was updated.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   drivers/devfreq/devfreq.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 6e80bf70e7b3..ce569bd9adfa 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -390,7 +390,7 @@ static int devfreq_set_target(struct devfreq *devfr=
eq, unsigned long new_freq,
> >       devfreq->previous_freq =3D new_freq;
> >
> >       if (devfreq->suspend_freq)
> > -             devfreq->resume_freq =3D cur_freq;
> > +             devfreq->resume_freq =3D new_freq;
> >
> >       return err;
> >   }
> >
>
> This patch fixes the previous patch[1]. So that you need to
> add 'Fixes' tag as following:
>
> Fixes: 83f8ca45afbf0 ("PM / devfreq: add support for suspend/resume of a
> devfreq device")
>

Will add Fixes tag in next version.

> commit 83f8ca45afbf041e312909f442128b99657d90b7
> Refs: v4.20-rc6-2-g83f8ca45afbf
> Author:     Lukasz Luba <lukasz.luba@arm.com>
> AuthorDate: Wed Dec 5 12:05:53 2018 +0100
> Commit:     MyungJoo Ham <myungjoo.ham@samsung.com>
> CommitDate: Tue Dec 11 11:09:47 2018 +0900
>
>      PM / devfreq: add support for suspend/resume of a devfreq device
>
>
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
