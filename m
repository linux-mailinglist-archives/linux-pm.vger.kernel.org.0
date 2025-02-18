Return-Path: <linux-pm+bounces-22302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F16A39C65
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 13:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAE13A267A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0561248177;
	Tue, 18 Feb 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrighiw2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC7238D25
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882633; cv=none; b=TltnxKAlN2GqzEGWqFrxhWw5tTXL1+4AxAbKpll7wqtamvgXuDF3A/LRRzjicfEz+bkmkz52NATwU61SBvilGxx2MCdaw3P6TyuQhhB4Qa+4OmluuPEQ3Uo8D16ng9W7gmF5v7nXJHUnJhKL9eGgZSTlFVZWpUYAQD5hozXXDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882633; c=relaxed/simple;
	bh=o5HemGqVqrzuLx+A/HRgFduyQjX9Xm9ThMTQVwCCVys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yx/0aauhzHl6Gcl3VJFQLowmUA079HDsfJlSZLAHXsQcXRBzGhWyfjsXzET1bgUzgjDXZAw+R0q8RffGbjTJlCBc9UZ2Mmw36chT62XxfLEAfFYc+mUEApG94DKbtVx6WG7gcwael4ROfOIgQfaWgC6Bh0+ZmU/Fn6xWteFFK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrighiw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D534C4CEE8
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739882633;
	bh=o5HemGqVqrzuLx+A/HRgFduyQjX9Xm9ThMTQVwCCVys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mrighiw2BsubIc0NmcNRgY1OONDAeMIZDzJAV/S6+Q7mWcIqG3K1vIh5fbeSJaInZ
	 sEtoSFc/uh41Vvw6C84Mzhgfbj4rQ48ZsWtDwC4bwyDEVJUgqDd82KG5zJwdAQNKSr
	 PbfD0GPirxa3KYoGwS9MB5XceroViNyol6GYdXnyHAgpnu73sWXdViGXwZb/Kua1Ds
	 TqNHi3aWD/iI5onN5UIjHw4UEPLZagKOiIDSaVOibSmhmrwvN1VpHJvIFjsmzeYk7m
	 Up2fpdQo8tRZmfeIHlMj7kfxkxgDkEDnsNkPhM1AJFh0GKsSz3agHTA7BrUcsjbJKv
	 k715exDOzGHww==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f3e50bf56bso939543b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 04:43:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4Avt2r/1nYAc757TcXiTkui2usOOpFVacOYqbs9mTIVm54WqOOY9nPwzJyZq3SXtkbcPwMOLzoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIZlRSknmrYi6DqclYHKe4TFqwadzmNOgDtSnpi/1pl3gAGWf
	3pgIhhBR00Hfwf4looRDVq8RuBNVcuL8pEmblaoPTp/XT7a3UDNfJxgtyLBoEFzi9uTV9WBntyu
	jS8TK/kcb/AKgAeIym33q4W8TypI=
X-Google-Smtp-Source: AGHT+IESQCdL2InXAXu1I4bdmo/jTmWa5mDeyLhhdGyQQUVSp0UDiMau4/X9cNM1R+dK273KldEHXWFeP3W5qLRBX88=
X-Received: by 2002:a05:6808:4490:b0:3f4:ad6:519e with SMTP id
 5614622812f47-3f40ad6532cmr1152315b6e.31.1739882632918; Tue, 18 Feb 2025
 04:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213035510.2402076-1-zhanjie9@hisilicon.com> <3965c9ee-c136-bdf2-8384-ed361fc601c1@hisilicon.com>
In-Reply-To: <3965c9ee-c136-bdf2-8384-ed361fc601c1@hisilicon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 13:43:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jLTi_nZ8ek-MYtthZtD4oEszhvP=ZBzJmTb7NkB=_rGA@mail.gmail.com>
X-Gm-Features: AWEUYZmFlSG8wgaD7xbm09PGLl9NN1ZTVzyn-hkabXnwnttIvHqseyEZL9E9KeY
Message-ID: <CAJZ5v0jLTi_nZ8ek-MYtthZtD4oEszhvP=ZBzJmTb7NkB=_rGA@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: governor: Fix negative 'idle_time' handling
 in dbs_update()
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	yu.c.chen@intel.com, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhenglifeng1@huawei.com, lihuisong@huawei.com, wanghuiqiang@huawei.com, 
	fanghao11@huawei.com, prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 1:41=E2=80=AFPM Jie Zhan <zhanjie9@hisilicon.com> w=
rote:
>
> A kindly ping on this patch.

I'll get to it in the next few days, I don't think it is urgent.

Thanks!

> On 13/02/2025 11:55, Jie Zhan wrote:
> > We observed an issue that the cpu frequency can't raise up with a 100% =
cpu
> > load when NOHZ is off and the 'conservative' governor is selected.
> >
> > 'idle_time' can be negative if it's obtained from get_cpu_idle_time_jif=
fy()
> > when NOHZ is off.  This was found and explained in commit 9485e4ca0b48
> > ("cpufreq: governor: Fix handling of special cases in dbs_update()").
> >
> > However, commit 7592019634f8 ("cpufreq: governors: Fix long idle detect=
ion
> > logic in load calculation") introduced a comparison between 'idle_time'=
 and
> > 'samling_rate' to detect a long idle interval.  While 'idle_time' is
> > converted to int before comparison, it's actually promoted to unsigned
> > again when compared with an unsigned 'sampling_rate'.  Hence, this lead=
s to
> > wrong idle interval detection when it's in fact 100% busy and sets
> > policy_dbs->idle_periods to a very large value.  'conservative' adjusts=
 the
> > frequency to minimum because of the large 'idle_periods', such that the
> > frequency can't raise up.  'Ondemand' doesn't use policy_dbs->idle_peri=
ods
> > so it fortunately avoids the issue.
> >
> > Correct negative 'idle_time' to 0 before any use of it in dbs_update().
> >
> > Fixes: 7592019634f8 ("cpufreq: governors: Fix long idle detection logic=
 in load calculation")
> > Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> > Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v3:
> > - Remove ternary operators.
> >
> > v2:
> > - Avoid type conversion, compare current and previous idle time before
> >   obtaining 'idle_time'.
> > - Update the explanation in comments.
> >
> > Discussions:
> > v2: https://lore.kernel.org/linux-pm/20250212081438.1294503-1-zhanjie9@=
hisilicon.com/
> > v1: https://lore.kernel.org/linux-pm/20250210130659.3533182-1-zhanjie9@=
hisilicon.com/
> > ---
> >  drivers/cpufreq/cpufreq_governor.c | 45 +++++++++++++++---------------
> >  1 file changed, 23 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index af44ee6a6430..1a7fcaf39cc9 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -145,7 +145,23 @@ unsigned int dbs_update(struct cpufreq_policy *pol=
icy)
> >               time_elapsed =3D update_time - j_cdbs->prev_update_time;
> >               j_cdbs->prev_update_time =3D update_time;
> >
> > -             idle_time =3D cur_idle_time - j_cdbs->prev_cpu_idle;
> > +             /*
> > +              * cur_idle_time could be smaller than j_cdbs->prev_cpu_i=
dle if
> > +              * it's obtained from get_cpu_idle_time_jiffy() when NOHZ=
 is
> > +              * off, where idle_time is calculated by the difference b=
etween
> > +              * time elapsed in jiffies and "busy time" obtained from =
CPU
> > +              * statistics.  If a CPU is 100% busy, the time elapsed a=
nd busy
> > +              * time should grow with the same amount in two consecuti=
ve
> > +              * samples, but in practice there could be a tiny differe=
nce,
> > +              * making the accumulated idle time decrease sometimes.  =
Hence,
> > +              * in this case, idle_time should be regarded as 0 in ord=
er to
> > +              * make the further process correct.
> > +              */
> > +             if (cur_idle_time > j_cdbs->prev_cpu_idle)
> > +                     idle_time =3D cur_idle_time - j_cdbs->prev_cpu_id=
le;
> > +             else
> > +                     idle_time =3D 0;
> > +
> >               j_cdbs->prev_cpu_idle =3D cur_idle_time;
> >
> >               if (ignore_nice) {
> > @@ -162,7 +178,7 @@ unsigned int dbs_update(struct cpufreq_policy *poli=
cy)
> >                        * calls, so the previous load value can be used =
then.
> >                        */
> >                       load =3D j_cdbs->prev_load;
> > -             } else if (unlikely((int)idle_time > 2 * sampling_rate &&
> > +             } else if (unlikely(idle_time > 2 * sampling_rate &&
> >                                   j_cdbs->prev_load)) {
> >                       /*
> >                        * If the CPU had gone completely idle and a task=
 has
> > @@ -189,30 +205,15 @@ unsigned int dbs_update(struct cpufreq_policy *po=
licy)
> >                       load =3D j_cdbs->prev_load;
> >                       j_cdbs->prev_load =3D 0;
> >               } else {
> > -                     if (time_elapsed >=3D idle_time) {
> > +                     if (time_elapsed > idle_time)
> >                               load =3D 100 * (time_elapsed - idle_time)=
 / time_elapsed;
> > -                     } else {
> > -                             /*
> > -                              * That can happen if idle_time is return=
ed by
> > -                              * get_cpu_idle_time_jiffy().  In that ca=
se
> > -                              * idle_time is roughly equal to the diff=
erence
> > -                              * between time_elapsed and "busy time" o=
btained
> > -                              * from CPU statistics.  Then, the "busy =
time"
> > -                              * can end up being greater than time_ela=
psed
> > -                              * (for example, if jiffies_64 and the CP=
U
> > -                              * statistics are updated by different CP=
Us),
> > -                              * so idle_time may in fact be negative. =
 That
> > -                              * means, though, that the CPU was busy a=
ll
> > -                              * the time (on the rough average) during=
 the
> > -                              * last sampling interval and 100 can be
> > -                              * returned as the load.
> > -                              */
> > -                             load =3D (int)idle_time < 0 ? 100 : 0;
> > -                     }
> > +                     else
> > +                             load =3D 0;
> > +
> >                       j_cdbs->prev_load =3D load;
> >               }
> >
> > -             if (unlikely((int)idle_time > 2 * sampling_rate)) {
> > +             if (unlikely(idle_time > 2 * sampling_rate)) {
> >                       unsigned int periods =3D idle_time / sampling_rat=
e;
> >
> >                       if (periods < idle_periods)

