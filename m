Return-Path: <linux-pm+bounces-22573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2223A3E504
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCDD27A7FB8
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF383263C91;
	Thu, 20 Feb 2025 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0FpIbMh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB694213E80
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079730; cv=none; b=Qk4SUGXHX0B5xyUdZFyWlbjAGf3RHOabdOdRKbt6v0PAHTVAgQIU82s7uLSD4IZsztJHEa25Ts3Jj74UK6LJ5H0e8YuwizONfM+2Fs27wWuY9ySBhQi9hHsLT5Ote1m4/NqneBFNeSA4+EGzOVIPsLHs7Eb9flSsgFlbBDh27ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079730; c=relaxed/simple;
	bh=WdaQdiQ0yyXNi48lFfn4WEH6A7OC7cqRfFvEbimTBrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/nWh6OvkCrlVInfSLSn0rUtGgZTd6xgqXZSiCvEVJUPDvNjDUKswur5r8TJIUiOqVGBpgMH+GwP52Rjod1M/9ypAF0bJD730zDUWXQxD0zuL4bPS0d0rgtFOF6UTNv6au6+KV+3suyACkz64HZ3suGGc1VwPJjZEpOQl9vyCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0FpIbMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A02C4AF0B
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 19:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740079730;
	bh=WdaQdiQ0yyXNi48lFfn4WEH6A7OC7cqRfFvEbimTBrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J0FpIbMhKO4q8+x7lLhegPQyrqDqp6+3fY2t5zBqN5LmpmlZMzVXlmK4Mv4Ym+VsY
	 VA+rKj3LlDjuEdOGiKkagItmaWi4HCBc7q4iRQL/3FR7nOnyo2ZW2xUfAC/cId7aDz
	 RvGYvli1LzmBGfJw+X+Ak02tlXPRUJXpJBNSjHR85fvwYrs8npW9RNx7xhYN6Goqa6
	 oiWel1ltJYRlrERapOiBYzYlGZm4H62CbYvMSej4foIkrw4wSA3QM9+Yy1ayaO0Yao
	 yLPLlGqH2zbOLvCy6bbzNSXMolTTMzD1yActkuBomNGr1o1xcFkENbI1h5uilCoPaT
	 FcpxS45abOxzw==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f3ffe06107so719599b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 11:28:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXioDN2bIHocdE5eDn8earVcezqm5lZEr7SpuqnlxXm5Kf/BaO0R0F1Cj/XC10lLGjx18wmSVsgxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaniZPzR8CGw6sPWG9hHGo7q9TwS61JtdPbbBX+7vzculwkV2L
	HSKjExVWsaoBPRxqdoKA3oZPGDT5MwbEQNRBHtyydu8H1cYTFX3Eo0xM/I58vZs7TWs3kA7L34u
	FK9UHNecmJmCnhykY2g/NuIxjjCk=
X-Google-Smtp-Source: AGHT+IHlKCXfSRiXlb+Wl6+izflRWr/SKbfTbdAn3oiZDYzvnrLL2lCounB4iadCpQ62AMM3pKni1RASKeDXXhP5Rzo=
X-Received: by 2002:a05:6808:221f:b0:3f4:b29:2407 with SMTP id
 5614622812f47-3f4246df4e5mr487589b6e.17.1740079729481; Thu, 20 Feb 2025
 11:28:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213035510.2402076-1-zhanjie9@hisilicon.com>
 <3965c9ee-c136-bdf2-8384-ed361fc601c1@hisilicon.com> <CAJZ5v0jLTi_nZ8ek-MYtthZtD4oEszhvP=ZBzJmTb7NkB=_rGA@mail.gmail.com>
 <63b99f2f-9446-3119-a653-6ed50ddcf961@hisilicon.com>
In-Reply-To: <63b99f2f-9446-3119-a653-6ed50ddcf961@hisilicon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 20:28:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j04FRTyRAidU1m9q6G3JNs5veotNpVfXPF6HJb0p9dhw@mail.gmail.com>
X-Gm-Features: AWEUYZnd6lBsRIeBCesyvIU5nUzyz9ltrxubnj9wGxeCEq3T2dxawVpOj8LUnC4
Message-ID: <CAJZ5v0j04FRTyRAidU1m9q6G3JNs5veotNpVfXPF6HJb0p9dhw@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: governor: Fix negative 'idle_time' handling
 in dbs_update()
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	yu.c.chen@intel.com, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhenglifeng1@huawei.com, lihuisong@huawei.com, wanghuiqiang@huawei.com, 
	fanghao11@huawei.com, prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:43=E2=80=AFAM Jie Zhan <zhanjie9@hisilicon.com> w=
rote:
>
> Yeah, no problem!  Just in case it's missed.
>
> Thanks.

Now applied as 6.15 material, thanks!

> On 18/02/2025 20:43, Rafael J. Wysocki wrote:
> > On Tue, Feb 18, 2025 at 1:41=E2=80=AFPM Jie Zhan <zhanjie9@hisilicon.co=
m> wrote:
> >>
> >> A kindly ping on this patch.
> >
> > I'll get to it in the next few days, I don't think it is urgent.
> >
> > Thanks!
> >
> >> On 13/02/2025 11:55, Jie Zhan wrote:
> >>> We observed an issue that the cpu frequency can't raise up with a 100=
% cpu
> >>> load when NOHZ is off and the 'conservative' governor is selected.
> >>>
> >>> 'idle_time' can be negative if it's obtained from get_cpu_idle_time_j=
iffy()
> >>> when NOHZ is off.  This was found and explained in commit 9485e4ca0b4=
8
> >>> ("cpufreq: governor: Fix handling of special cases in dbs_update()").
> >>>
> >>> However, commit 7592019634f8 ("cpufreq: governors: Fix long idle dete=
ction
> >>> logic in load calculation") introduced a comparison between 'idle_tim=
e' and
> >>> 'samling_rate' to detect a long idle interval.  While 'idle_time' is
> >>> converted to int before comparison, it's actually promoted to unsigne=
d
> >>> again when compared with an unsigned 'sampling_rate'.  Hence, this le=
ads to
> >>> wrong idle interval detection when it's in fact 100% busy and sets
> >>> policy_dbs->idle_periods to a very large value.  'conservative' adjus=
ts the
> >>> frequency to minimum because of the large 'idle_periods', such that t=
he
> >>> frequency can't raise up.  'Ondemand' doesn't use policy_dbs->idle_pe=
riods
> >>> so it fortunately avoids the issue.
> >>>
> >>> Correct negative 'idle_time' to 0 before any use of it in dbs_update(=
).
> >>>
> >>> Fixes: 7592019634f8 ("cpufreq: governors: Fix long idle detection log=
ic in load calculation")
> >>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> >>> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> >>> ---
> >>> v3:
> >>> - Remove ternary operators.
> >>>
> >>> v2:
> >>> - Avoid type conversion, compare current and previous idle time befor=
e
> >>>   obtaining 'idle_time'.
> >>> - Update the explanation in comments.
> >>>
> >>> Discussions:
> >>> v2: https://lore.kernel.org/linux-pm/20250212081438.1294503-1-zhanjie=
9@hisilicon.com/
> >>> v1: https://lore.kernel.org/linux-pm/20250210130659.3533182-1-zhanjie=
9@hisilicon.com/
> >>> ---
> >>>  drivers/cpufreq/cpufreq_governor.c | 45 +++++++++++++++-------------=
--
> >>>  1 file changed, 23 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpu=
freq_governor.c
> >>> index af44ee6a6430..1a7fcaf39cc9 100644
> >>> --- a/drivers/cpufreq/cpufreq_governor.c
> >>> +++ b/drivers/cpufreq/cpufreq_governor.c
> >>> @@ -145,7 +145,23 @@ unsigned int dbs_update(struct cpufreq_policy *p=
olicy)
> >>>               time_elapsed =3D update_time - j_cdbs->prev_update_time=
;
> >>>               j_cdbs->prev_update_time =3D update_time;
> >>>
> >>> -             idle_time =3D cur_idle_time - j_cdbs->prev_cpu_idle;
> >>> +             /*
> >>> +              * cur_idle_time could be smaller than j_cdbs->prev_cpu=
_idle if
> >>> +              * it's obtained from get_cpu_idle_time_jiffy() when NO=
HZ is
> >>> +              * off, where idle_time is calculated by the difference=
 between
> >>> +              * time elapsed in jiffies and "busy time" obtained fro=
m CPU
> >>> +              * statistics.  If a CPU is 100% busy, the time elapsed=
 and busy
> >>> +              * time should grow with the same amount in two consecu=
tive
> >>> +              * samples, but in practice there could be a tiny diffe=
rence,
> >>> +              * making the accumulated idle time decrease sometimes.=
  Hence,
> >>> +              * in this case, idle_time should be regarded as 0 in o=
rder to
> >>> +              * make the further process correct.
> >>> +              */
> >>> +             if (cur_idle_time > j_cdbs->prev_cpu_idle)
> >>> +                     idle_time =3D cur_idle_time - j_cdbs->prev_cpu_=
idle;
> >>> +             else
> >>> +                     idle_time =3D 0;
> >>> +
> >>>               j_cdbs->prev_cpu_idle =3D cur_idle_time;
> >>>
> >>>               if (ignore_nice) {
> >>> @@ -162,7 +178,7 @@ unsigned int dbs_update(struct cpufreq_policy *po=
licy)
> >>>                        * calls, so the previous load value can be use=
d then.
> >>>                        */
> >>>                       load =3D j_cdbs->prev_load;
> >>> -             } else if (unlikely((int)idle_time > 2 * sampling_rate =
&&
> >>> +             } else if (unlikely(idle_time > 2 * sampling_rate &&
> >>>                                   j_cdbs->prev_load)) {
> >>>                       /*
> >>>                        * If the CPU had gone completely idle and a ta=
sk has
> >>> @@ -189,30 +205,15 @@ unsigned int dbs_update(struct cpufreq_policy *=
policy)
> >>>                       load =3D j_cdbs->prev_load;
> >>>                       j_cdbs->prev_load =3D 0;
> >>>               } else {
> >>> -                     if (time_elapsed >=3D idle_time) {
> >>> +                     if (time_elapsed > idle_time)
> >>>                               load =3D 100 * (time_elapsed - idle_tim=
e) / time_elapsed;
> >>> -                     } else {
> >>> -                             /*
> >>> -                              * That can happen if idle_time is retu=
rned by
> >>> -                              * get_cpu_idle_time_jiffy().  In that =
case
> >>> -                              * idle_time is roughly equal to the di=
fference
> >>> -                              * between time_elapsed and "busy time"=
 obtained
> >>> -                              * from CPU statistics.  Then, the "bus=
y time"
> >>> -                              * can end up being greater than time_e=
lapsed
> >>> -                              * (for example, if jiffies_64 and the =
CPU
> >>> -                              * statistics are updated by different =
CPUs),
> >>> -                              * so idle_time may in fact be negative=
.  That
> >>> -                              * means, though, that the CPU was busy=
 all
> >>> -                              * the time (on the rough average) duri=
ng the
> >>> -                              * last sampling interval and 100 can b=
e
> >>> -                              * returned as the load.
> >>> -                              */
> >>> -                             load =3D (int)idle_time < 0 ? 100 : 0;
> >>> -                     }
> >>> +                     else
> >>> +                             load =3D 0;
> >>> +
> >>>                       j_cdbs->prev_load =3D load;
> >>>               }
> >>>
> >>> -             if (unlikely((int)idle_time > 2 * sampling_rate)) {
> >>> +             if (unlikely(idle_time > 2 * sampling_rate)) {
> >>>                       unsigned int periods =3D idle_time / sampling_r=
ate;
> >>>
> >>>                       if (periods < idle_periods)

