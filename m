Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D26633337D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 04:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCJDCx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 22:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhCJDCj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 22:02:39 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F9C06174A;
        Tue,  9 Mar 2021 19:02:28 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id a17so15022032oto.5;
        Tue, 09 Mar 2021 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0l4UeWcZvaSK23sbyoOaV8Z+baEHEhVuF/62t9jEE88=;
        b=lIkG7aiIZLhz3dw8iOQolbW+rPfg7qdkdTuiiNgMFfJctJbavYtIeapw25hQfAVzuX
         8OsUQiRiY29ia5Fle8oiRKMpdnQZXWSWQfrmeuLbx86ONlZA/3ihd4UNAkKr4lVWF6fC
         11xVeE2HVwjEMCuIM9oDyqgKuff7FQMVs+u+7lQ20BTY2QhLtJgQcJx8u7BNjmcDJuVJ
         OwNVAxjxBo6E0pAumM9IOUxAPq+vbF+ZD30gSNOKD1V9OKWJICniO4FhgE3HZQt0uWLM
         3r3xLTJdxfPgiZqEYnzjRAI65zPiuzTrwaKRGhi/E3NFzxCzbBSk81JyBtM8mLl5mzuR
         mY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0l4UeWcZvaSK23sbyoOaV8Z+baEHEhVuF/62t9jEE88=;
        b=nRFBl0nWdDZSoU6zlum0OPU6wNsrb+YUpWg4AaTdHCmrNc1+hiWICjLShVx/eneZv4
         VLwYKOZ5TubTt8ICZzPEgSOyKBuwdfgAjvp40cZI/PP0alxq2Qn7TseLfKB5SqIDDQCi
         kKc75GFwoKOfFT3cQfYszCCWfKorFXggEJst30fNDCAwjQoNG/FhYQVRgwGR8zMuxWjY
         zjN1FjXvW6uGVGvxxYVy5nMLC4qu3D99WDlEQZ49LXrYRoaxxsp4gshKeSZjKZwzvICs
         ADtttNJBxoWoaG5eh2fPT4RjoWnEuVV1g2/sXWSPuChlduULWwFIFIRi9b+13Spy8N+6
         rkSg==
X-Gm-Message-State: AOAM5311ZFJajDsjbIK/nySUTupE/83URO+2kmf/Fv5wy3w55Z8ik0CO
        SWfd5blGQnyPIifxUDYBSRtUCcMcyi+8OjwQCRs=
X-Google-Smtp-Source: ABdhPJww1xmZFsAvN/Z/UNTZDWa2FtxkzLDLMNMXOtpCxekTkhVz/gQ9HFInIJGfD8VytkWeVB7OuNZRrAp47KVpZtw=
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr1017952otk.118.1615345348183;
 Tue, 09 Mar 2021 19:02:28 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-10-git-send-email-aisheng.dong@nxp.com> <4cee7ace-e6b9-fa0c-7cfe-d794ac9deabf@gmail.com>
In-Reply-To: <4cee7ace-e6b9-fa0c-7cfe-d794ac9deabf@gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 10 Mar 2021 11:02:27 +0800
Message-ID: <CAA+hA=QzJrkUB1b2EyYAaej6TKucbH1p9R6bi=HUMvhAv-78=g@mail.gmail.com>
Subject: Re: [PATCH 09/11] PM / devfreq: governor: optimize simpleondemand get_target_freq
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

On Wed, Mar 10, 2021 at 12:09 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> > devfreq_simple_ondemand_data only needs to be initialized once when
> > calling devm_devfreq_add_device. It's unnecessary to put the data
> > check logic in the hot path (.get_target_freq()) where it will be
> > called all the time during polling. Instead, we only check and initiali=
ze
> > it one time during DEVFREQ_GOV_START.
> >
> > This also helps check data validability in advance during DEVFREQ_GOV_S=
TART
> > rather than checking it later when running .get_target_freq().
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   drivers/devfreq/governor_simpleondemand.c | 50 +++++++++++++++-------=
-
> >   1 file changed, 34 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfre=
q/governor_simpleondemand.c
> > index ea287b57cbf3..341eb7e9dc04 100644
> > --- a/drivers/devfreq/governor_simpleondemand.c
> > +++ b/drivers/devfreq/governor_simpleondemand.c
> > @@ -15,15 +15,19 @@
> >   /* Default constants for DevFreq-Simple-Ondemand (DFSO) */
> >   #define DFSO_UPTHRESHOLD    (90)
> >   #define DFSO_DOWNDIFFERENCTIAL      (5)
> > +
> > +static struct devfreq_simple_ondemand_data od_default =3D {
> > +     .upthreshold =3D DFSO_UPTHRESHOLD,
> > +     .downdifferential =3D DFSO_DOWNDIFFERENCTIAL,
> > +};
> > +
> >   static int devfreq_simple_ondemand_func(struct devfreq *df,
> >                                       unsigned long *freq)
> >   {
> >       int err;
> >       struct devfreq_dev_status *stat;
> >       unsigned long long a, b;
> > -     unsigned int dfso_upthreshold =3D DFSO_UPTHRESHOLD;
> > -     unsigned int dfso_downdifferential =3D DFSO_DOWNDIFFERENCTIAL;
> > -     struct devfreq_simple_ondemand_data *data =3D df->data;
> > +     struct devfreq_simple_ondemand_data *od =3D df->data;
> >
> >       err =3D devfreq_update_stats(df);
> >       if (err)
> > @@ -31,16 +35,6 @@ static int devfreq_simple_ondemand_func(struct devfr=
eq *df,
> >
> >       stat =3D &df->last_status;
> >
> > -     if (data) {
> > -             if (data->upthreshold)
> > -                     dfso_upthreshold =3D data->upthreshold;
> > -             if (data->downdifferential)
> > -                     dfso_downdifferential =3D data->downdifferential;
> > -     }
> > -     if (dfso_upthreshold > 100 ||
> > -         dfso_upthreshold < dfso_downdifferential)
> > -             return -EINVAL;
> > -
> >       /* Assume MAX if it is going to be divided by zero */
> >       if (stat->total_time =3D=3D 0) {
> >               *freq =3D DEVFREQ_MAX_FREQ;
> > @@ -55,7 +49,7 @@ static int devfreq_simple_ondemand_func(struct devfre=
q *df,
> >
> >       /* Set MAX if it's busy enough */
> >       if (stat->busy_time * 100 >
> > -         stat->total_time * dfso_upthreshold) {
> > +         stat->total_time * od->upthreshold) {
> >               *freq =3D DEVFREQ_MAX_FREQ;
> >               return 0;
> >       }
> > @@ -68,7 +62,7 @@ static int devfreq_simple_ondemand_func(struct devfre=
q *df,
> >
> >       /* Keep the current frequency */
> >       if (stat->busy_time * 100 >
> > -         stat->total_time * (dfso_upthreshold - dfso_downdifferential)=
) {
> > +         stat->total_time * (od->upthreshold - od->downdifferential)) =
{
> >               *freq =3D stat->current_frequency;
> >               return 0;
> >       }
> > @@ -78,17 +72,41 @@ static int devfreq_simple_ondemand_func(struct devf=
req *df,
> >       a *=3D stat->current_frequency;
> >       b =3D div_u64(a, stat->total_time);
> >       b *=3D 100;
> > -     b =3D div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
> > +     b =3D div_u64(b, (od->upthreshold - od->downdifferential / 2));
> >       *freq =3D (unsigned long) b;
> >
> >       return 0;
> >   }
> >
> > +static int devfreq_simple_ondemand_check_od(struct devfreq *devfreq)
> > +{
> > +     struct devfreq_simple_ondemand_data *od =3D devfreq->data;
> > +
> > +     if (od) {
> > +             if (!od->upthreshold)
> > +                     od->upthreshold =3D DFSO_UPTHRESHOLD;
> > +
> > +             if (!od->downdifferential)
> > +                     od->downdifferential =3D DFSO_DOWNDIFFERENCTIAL;
> > +
> > +             if (od->upthreshold > 100 ||
> > +                 od->upthreshold < od->downdifferential)
> > +                     return -EINVAL;
> > +     } else {
> > +             od =3D &od_default;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
> >                               unsigned int event, void *data)
> >   {
> >       switch (event) {
> >       case DEVFREQ_GOV_START:
> > +             if (devfreq_simple_ondemand_check_od(devfreq))
> > +                     return -EINVAL;
> > +
> >               return devfreq_monitor_start(devfreq);
> >
> >       case DEVFREQ_GOV_STOP:
> >
>
> I'm editing the upthreshold and downdifferential for exposing them
> via sysfs. So that after my work to expose them via sysfs,
> send the patches if you think that need to do more about them.

Thanks for letting me know..
I can rework after your patch merged.

Regards
Aisheng

>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/=
?h=3Ddevfreq-testing&id=3Ddc9e557845c17cee173a6adcc3ae14940da03f44
>
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
