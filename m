Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81E33333A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 03:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCJCm4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 21:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhCJCmg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 21:42:36 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBB0C06174A;
        Tue,  9 Mar 2021 18:42:25 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id f8so9922109otp.8;
        Tue, 09 Mar 2021 18:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2utguLb+xjj3ikHTA8ikx/XcO3Z3cihJ1pa67h6cpt8=;
        b=m0niI2O7cd+ue03+vWQIM4tj5XtEGeV4j3ajNyAtKj9g2jsa+vIrGsqKh1KA+kndec
         QO+jweKJUr7G0iqIAH4to9joHg/7Cjbext8t0vt/hMFxrLqUGXPlz1H4lQPTAZGt6X8w
         2wWjgaoQvb1kv8XpyM/Y1rcK8LR2B4piQ2JnbEF1h35FURTcfSc2qQcSlTI23DGO9a2m
         2EWQXFcjhsC0G0COPVsIzO+A+kmcJQakz5H8W85/MICBRbqVd7lbZi/4b9TmMbCzxHLn
         dGnEozJRRXeh/0dOvcA1HB0h2yhUr4xMvviC9fpnk1hSFQbsnjF6AD33GkhijXuyejpn
         GYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2utguLb+xjj3ikHTA8ikx/XcO3Z3cihJ1pa67h6cpt8=;
        b=jP1TMg9F6mU3WuEHfBicr5/SbV1kDxZUZpLlA2RSGU+tayS45CWgBBIyKcnVNItcjd
         WtXsMYzqY9zXXb4EyHIaEU7BzkBaUtNd5/bjxryPI6W9OXA7e/jqLzMroa4teClitro0
         rkbGvfqfkgbkaBQwMLO+7lRR8rmds6uKdklbbpcDxO0gNbuaFPUOX7NCTnDzxzfOtSdX
         gTpdoRGNUTflUrAB7gGMwfQhHzLkzXGf9c8M5aU9IsIgrhXD5QSMvlAov/kSgE3F1yeU
         WVe+VfPYQ0uEPVs46PDug3SGRackKw3BNSYLp90+s0FIR6pwloBxRETiO2Zg8KsokQCR
         IVEA==
X-Gm-Message-State: AOAM533f2s71+f5IKdbN3MD0eYdkVP/JsxQT/XPjo22OzTZ20mHBKic7
        cOC3N/8CSomypH2ydC3RFPaj1LLrn4L8XgILIoy6O/Te
X-Google-Smtp-Source: ABdhPJy22wFsGgKsa2n3bVCWccuBbSPxClxq2w/X08rHFcc2doIpnuK5khbpeFeams81rsppcyC1wOxmNCU4tyCWWsQ=
X-Received: by 2002:a9d:6c8b:: with SMTP id c11mr1009169otr.52.1615344144282;
 Tue, 09 Mar 2021 18:42:24 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-5-git-send-email-aisheng.dong@nxp.com> <b6de03c9-8744-90b2-11fe-914ef016fa1f@gmail.com>
In-Reply-To: <b6de03c9-8744-90b2-11fe-914ef016fa1f@gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 10 Mar 2021 10:42:23 +0800
Message-ID: <CAA+hA=RbvKSyeLVdJBiqnKwGVJQBzKLJi1z68BHoKHeypjQKCQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] PM / devfreq: bail out early if no freq changes in devfreq_set_target
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

On Tue, Mar 9, 2021 at 11:47 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> > It's unnecessary to set the same freq again and run notifier calls.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   drivers/devfreq/devfreq.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index bf3047896e41..6e80bf70e7b3 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -358,6 +358,9 @@ static int devfreq_set_target(struct devfreq *devfr=
eq, unsigned long new_freq,
> >       else
> >               cur_freq =3D devfreq->previous_freq;
> >
> > +     if (new_freq =3D=3D cur_freq)
> > +             return 0;
> > +
> >       freqs.old =3D cur_freq;
> >       freqs.new =3D new_freq;
> >       devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> > @@ -374,7 +377,7 @@ static int devfreq_set_target(struct devfreq *devfr=
eq, unsigned long new_freq,
> >        * and DEVFREQ_POSTCHANGE because for showing the correct frequen=
cy
> >        * change order of between devfreq device and passive devfreq dev=
ice.
> >        */
> > -     if (trace_devfreq_frequency_enabled() && new_freq !=3D cur_freq)
> > +     if (trace_devfreq_frequency_enabled())
> >               trace_devfreq_frequency(devfreq, new_freq, cur_freq);
> >
> >       freqs.new =3D new_freq;
> >
>
> I'd like you to squash patch4 with patch6 because actually patch6
> is too minor clean-up. I think it is possible.

Got it, will squash when re-send.

Regards
Aisheng

>
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
