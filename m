Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5508C1F2
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 22:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfHMUM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 16:12:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43798 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfHMUMz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 16:12:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so16450864qkd.10
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3lqf1BvRkrT0zFoMbdtExl8EI7GsnY3Mh1uu1vtSvfE=;
        b=PaRWVR3er7psEDVsOhRlEoF2QZxAWb5s5r09Y9Y2D3p6C5+NPwM/XkzbD90RUEphLI
         +Syn0GpMuCP0e0TN8DzZF3M0qmT10UKIkF7EBPHpVoZSNw4Cc0zogjYfN25CuTyeL3Jw
         AClxM8m+Ygb0KlbUKWQtvAvKT/uEZAqndaE7aMuVXuKQ/tH9StsaN5Yn/ssDTkHPDwni
         ne0yGHx8Wtp4S+FiahuEd09kqdMqWt2SS5umyL5a3BEYTp7KhrR7JFHdgVkYCerJdOvU
         DRmdFGNJPTW+6eJmRO21zU8ONhPl1PEKDesxLD779RIybT9NkvjLlK5DXv2S//RbgyYJ
         ylBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3lqf1BvRkrT0zFoMbdtExl8EI7GsnY3Mh1uu1vtSvfE=;
        b=VVW3pLnEJcFTwD+4MgXs99jlnOyJefv/hjowp61/eND5HwbCxiH0U/JrvKwUVLiUDc
         l0/6Z8lO7zkAGTV/LVeAZTbFVlPTSOATqRfZR1vr7yYO7yT7SIsJ9XKgOIgsiZ0t561i
         EuHLIbXEXXWAqKRMBDnxPBr5CE1GkJWrox3cRPU8AUb+gItDvxtdZ4L6jKFdE3RvK8MQ
         RmyThQmFag0sLkAy1gZ/Fbn8DF7Ymb+EMM0126HzThmpT+ITN2v6TDizMKx4gVOpi+zR
         8Z2lpggl9bRz5KhJvj/OULpacDmlnPYZyEov6+X5kD3LH1bHKX20a2DJedlK0cAfR17Z
         /Ulw==
X-Gm-Message-State: APjAAAUZlEJoVttwdsjwb3TRzuGbXwVXBXA5KZTyVuJby3jpYlPE6Pc2
        cjwSD64ZlHsckkH5ZVZ0HFB8HnuSfOEG6NKm4qsbWw==
X-Google-Smtp-Source: APXvYqyV/U0/+1MmPT+TGcVVYBP8Z8kW3m0SU/rhcx34vlDtB4WZg+oKZevkLnpngK5MGs7yUagnSRz+9Q5MEL08rU8=
X-Received: by 2002:ae9:ec06:: with SMTP id h6mr12020396qkg.221.1565727174451;
 Tue, 13 Aug 2019 13:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190613211228.34092-1-nhuck@google.com> <fd8b8a48-dfb7-1478-2d8d-0953acee39d3@linaro.org>
In-Reply-To: <fd8b8a48-dfb7-1478-2d8d-0953acee39d3@linaro.org>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Tue, 13 Aug 2019 13:12:43 -0700
Message-ID: <CAJkfWY6U3RF=2X4geFsUhFADf9x0GO8s28KQmR7TvnVgo_WTig@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Fix Wshift-negative-value
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I'm not familiar enough with the code to rewrite these parts of the
driver. Silencing the warnings while maintaining the same
functionality was the goal of this patch.

On Fri, Jun 14, 2019 at 3:52 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Nathan,
>
> On 13/06/2019 23:12, Nathan Huckleberry wrote:
> > Clang produces the following warning
> >
> > vers/thermal/rcar_gen3_thermal.c:147:33: warning: shifting a negative
> > signed value is undefined [-Wshift-negative-value] / (ptat[0] - ptat[2]=
)) +
> > FIXPT_INT(TJ_3); ^~~~~~~~~~~~~~~ drivers/thermal/rcar_gen3_thermal.c:12=
6:29
> > note: expanded from macro 'FIXPT_INT' #define FIXPT_INT(_x) ((_x) <<
> > FIXPT_SHIFT) ~~~~ ^ drivers/thermal/rcar_gen3_thermal.c:150:18: warning=
:
> > shifting a negative signed value is undefined [-Wshift-negative-value]
> > tsc->tj_t - FIXPT_INT(TJ_3)); ~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> >
> > Upon further investigating it looks like there is no real reason for
> > TJ_3 to be -41. Usages subtract -41, code would be cleaner to just add.
>
> All the code seems broken regarding the negative value shifting as the
> macros pass an integer:
>
> eg.
>         tsc->coef.a2 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
>                                  tsc->tj_t - FIXPT_INT(ths_tj_1));
>
> thcode[1] is always < than thcode[0],
>
> thcode[1] - thcode[0] < 0
>
> FIXPT_INT(thcode[1] - thcode[0]) is undefined
>
>
> Is it done on purpose FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]) ?
>
> Try developing the macro with the coef.a2 computation ...
>
> The code quality of this driver could be better, it deserves a rework
> IMHO ...
>
> I suggest to revert:
>
> 4eb39f79ef443fa566d36bd43f1f578d5c140305
> bdc4480a669d476814061b4da6bb006f7048c8e5
> 6a310f8f97bb8bc2e2bb9db6f49a1b8678c8d144
>
> Rework the coefficient computation and re-introduce what was reverted in
> a nicer way.
>
>
> > Fixes: 4eb39f79ef44 ("thermal: rcar_gen3_thermal: Update value of Tj_1"=
)
> > Cc: clang-built-linux@googlegroups.com
> > Link: https://github.com/ClangBuiltLinux/linux/issues/531
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> >  drivers/thermal/rcar_gen3_thermal.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar=
_gen3_thermal.c
> > index a56463308694..f4b4558c08e9 100644
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -131,7 +131,7 @@ static inline void rcar_gen3_thermal_write(struct r=
car_gen3_thermal_tsc *tsc,
> >  #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
> >
> >  /* no idea where these constants come from */
> > -#define TJ_3 -41
> > +#define TJ_3 41
> >
> >  static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc =
*tsc,
> >                                        int *ptat, const int *thcode,
> > @@ -144,11 +144,11 @@ static void rcar_gen3_thermal_calc_coefs(struct r=
car_gen3_thermal_tsc *tsc,
> >        * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
> >        */
> >       tsc->tj_t =3D (FIXPT_INT((ptat[1] - ptat[2]) * 157)
> > -                  / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
> > +                  / (ptat[0] - ptat[2])) - FIXPT_INT(TJ_3);
> >
> >       tsc->coef.a1 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
> > -                              tsc->tj_t - FIXPT_INT(TJ_3));
> > -     tsc->coef.b1 =3D FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
> > +                              tsc->tj_t + FIXPT_INT(TJ_3));
> > +     tsc->coef.b1 =3D FIXPT_INT(thcode[2]) + tsc->coef.a1 * TJ_3;
> >
> >       tsc->coef.a2 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
> >                                tsc->tj_t - FIXPT_INT(ths_tj_1));
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
