Return-Path: <linux-pm+bounces-21981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6870BA3301C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 20:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F23A8806
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 19:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1721FFC6F;
	Wed, 12 Feb 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDCU/WkE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC41FF7BE
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389782; cv=none; b=rgLOWajsOzVfdxNyN6UesmiHjHrIkFX5jnyo7AGv46PhYQpJp1ri4g3Jn+o/1aknmYKjUMvUY+pgzNAsEq8Rx13+/dZdwOQDmYXUyrqz1abJRFphiVa0PWM88D2zYJj66iP0ENQy0Bd0pQ2WEAl0wTvSjCvAq2MqrlzYYfVe8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389782; c=relaxed/simple;
	bh=IVYa5QhiRJz1bsf9br1HoErdkI/nGBb4LqLyq5wNMp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLxgWfI/kP3X7etWXRAvnxLCocKuLnYUhXDsUWGERHwgMBmQ6MDHXFPRB+5AW26qHGT6lVi4LDqoTjhhlgyWj+ewfgOZ0S3ymXP/11rYaCN98gbt3cUiD9k+ao+v37fqeEjzngdvnVkK6DHSq/dTJiulrBqKUFI/zvqYhuxNVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDCU/WkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66179C4CEDF
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739389781;
	bh=IVYa5QhiRJz1bsf9br1HoErdkI/nGBb4LqLyq5wNMp0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VDCU/WkEBkywGbFU7NLHAhcfIHLQDp4KDAGaWoBf708NxhlquWlwF7whRr+FExd2X
	 sOVTk+9mtMz4+8/ae7frf419eTBXUIp+CZZVaT6lWwACRqTFMJxLOPniEsWTFUTxfI
	 QB6yV9i7dKEp7RBLfkv+YG09RUUcqDrb2nRx/seBAUulcQRW7rzCR+aPuiOCj1T3kH
	 nteAeO/TE89PXKQ/f+unX8DV2xVxAzW49aZ7UFCpqEFW47eZzjifc6Wxi1gx9UDbIK
	 Yoia/58isFhQuiT2r8HLMNguMBGWvHRnep5KCYPpIVd0yhMQ1cPVTB1BTU8wieskKC
	 TN048gYIfS8pA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fa2685c5c0so64915eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 11:49:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6a1cHCGqg5woUAaeSVXNgsK4R2rmCRY8KlVZ7ef/0B/VezwL61HE1uzaDO/LByaEGZ3ysCcDNWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjPtG9FhaplS0RWEg/tsKTWELy7gEfStOPtR13lumIazU9P2b
	iE+eDq/ol4HrAMXp0LVnjbr5RGsPL0vOJYJ5e3Hrm5+Qfb0Oa6ln0yoOpNbrV2zgW74aVOSQmcw
	ecTrAZ1RFP4i1h8+C8UvxXeFlx3Q=
X-Google-Smtp-Source: AGHT+IEBNi8F1oWA0DO1/8JRmO1IXJBHT5o6AxCNArq5i0JxnlsBytffK/86SP5wykUclQ8o1P2Q7SWtVr1OmZbYVYk=
X-Received: by 2002:a05:6870:b523:b0:2a3:8331:717c with SMTP id
 586e51a60fabf-2b8d64e0eebmr3177445fac.10.1739389780725; Wed, 12 Feb 2025
 11:49:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212081438.1294503-1-zhanjie9@hisilicon.com>
In-Reply-To: <20250212081438.1294503-1-zhanjie9@hisilicon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 20:49:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jBs-qNyz2kSkVVh2qmWqfsx_Hs9=V1+JXkd0LHEBA8bQ@mail.gmail.com>
X-Gm-Features: AWEUYZmhqjapfODonYgYbyTPDhTx41tZrvqmvjtooH1WS3kB0Yw5SApx3ITIEps
Message-ID: <CAJZ5v0jBs-qNyz2kSkVVh2qmWqfsx_Hs9=V1+JXkd0LHEBA8bQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: governor: Fix negative 'idle_time' handling
 in dbs_update()
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	yu.c.chen@intel.com, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhenglifeng1@huawei.com, lihuisong@huawei.com, wanghuiqiang@huawei.com, 
	fanghao11@huawei.com, prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 9:22=E2=80=AFAM Jie Zhan <zhanjie9@hisilicon.com> w=
rote:
>
> We observed an issue that the cpu frequency can't raise up with a 100% cp=
u
> load when nohz is off and the 'conservative' governor is selected.

NOHZ

>
> 'idle_time' can be negative if it's obtained from get_cpu_idle_time_jiffy=
()
> when nohz is off.  This was found and explained in commit 9485e4ca0b48
> ("cpufreq: governor: Fix handling of special cases in dbs_update()").
>
> However, commit 7592019634f8 ("cpufreq: governors: Fix long idle detectio=
n
> logic in load calculation") introduced a comparison between 'idle_time' a=
nd
> 'samling_rate' to detect a long idle interval.  While 'idle_time' is
> converted to int before comparison, it's actually promoted to unsigned
> again when compared with an unsigned 'sampling_rate'.  Hence, this leads =
to
> wrong idle interval detection when it's in fact 100% busy and sets
> policy_dbs->idle_periods to a very large value.  'conservative' adjusts t=
he
> frequency to minimum because of the large 'idle_periods', such that the
> frequency can't raise up.  'Ondemand' doesn't use policy_dbs->idle_period=
s
> so it fortunately avoids the issue.
>
> Correct negative 'idle_time' to 0 before any use of it in dbs_update().
>
> Fixes: 7592019634f8 ("cpufreq: governors: Fix long idle detection logic i=
n load calculation")
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
> v2:
> - Avoid type conversion, compare current and previous idle time before
>   obtaining 'idle_time'.
> - Update the explanation in comments.
>
> Discussions:
> v1: https://lore.kernel.org/linux-pm/20250210130659.3533182-1-zhanjie9@hi=
silicon.com/
> ---
>  drivers/cpufreq/cpufreq_governor.c | 42 ++++++++++++++----------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq=
_governor.c
> index af44ee6a6430..c140e3f8d4f9 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -145,7 +145,20 @@ unsigned int dbs_update(struct cpufreq_policy *polic=
y)
>                 time_elapsed =3D update_time - j_cdbs->prev_update_time;
>                 j_cdbs->prev_update_time =3D update_time;
>
> -               idle_time =3D cur_idle_time - j_cdbs->prev_cpu_idle;
> +               /*
> +                * cur_idle_time could be smaller than j_cdbs->prev_cpu_i=
dle if
> +                * it's obtained from get_cpu_idle_time_jiffy() when NO_H=
Z is
> +                * off, where idle_time is calculated by the difference b=
etween
> +                * time elapsed in jiffies and "busy time" obtained from =
CPU
> +                * statistics.  If a CPU is 100% busy, the time elapsed a=
nd busy
> +                * time should grow with the same amount in two consecuti=
ve
> +                * samples, but in practice there could be a tiny differe=
nce,
> +                * making the accumulated idle time decrease sometimes.  =
Hence,
> +                * in this case, idle_time should be regarded as 0 in ord=
er to
> +                * make the further process correct.
> +                */
> +               idle_time =3D cur_idle_time > j_cdbs->prev_cpu_idle ?
> +                           cur_idle_time - j_cdbs->prev_cpu_idle : 0;

Please avoid using the ternary operator in new code.

>                 j_cdbs->prev_cpu_idle =3D cur_idle_time;
>
>                 if (ignore_nice) {
> @@ -162,7 +175,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy=
)
>                          * calls, so the previous load value can be used =
then.
>                          */
>                         load =3D j_cdbs->prev_load;
> -               } else if (unlikely((int)idle_time > 2 * sampling_rate &&
> +               } else if (unlikely(idle_time > 2 * sampling_rate &&
>                                     j_cdbs->prev_load)) {
>                         /*
>                          * If the CPU had gone completely idle and a task=
 has
> @@ -189,30 +202,13 @@ unsigned int dbs_update(struct cpufreq_policy *poli=
cy)
>                         load =3D j_cdbs->prev_load;
>                         j_cdbs->prev_load =3D 0;
>                 } else {
> -                       if (time_elapsed >=3D idle_time) {
> -                               load =3D 100 * (time_elapsed - idle_time)=
 / time_elapsed;
> -                       } else {
> -                               /*
> -                                * That can happen if idle_time is return=
ed by
> -                                * get_cpu_idle_time_jiffy().  In that ca=
se
> -                                * idle_time is roughly equal to the diff=
erence
> -                                * between time_elapsed and "busy time" o=
btained
> -                                * from CPU statistics.  Then, the "busy =
time"
> -                                * can end up being greater than time_ela=
psed
> -                                * (for example, if jiffies_64 and the CP=
U
> -                                * statistics are updated by different CP=
Us),
> -                                * so idle_time may in fact be negative. =
 That
> -                                * means, though, that the CPU was busy a=
ll
> -                                * the time (on the rough average) during=
 the
> -                                * last sampling interval and 100 can be
> -                                * returned as the load.
> -                                */
> -                               load =3D (int)idle_time < 0 ? 100 : 0;
> -                       }
> +                       load =3D time_elapsed > idle_time ?
> +                              100 * (time_elapsed - idle_time) / time_el=
apsed :
> +                              0;
>                         j_cdbs->prev_load =3D load;
>                 }
>
> -               if (unlikely((int)idle_time > 2 * sampling_rate)) {
> +               if (unlikely(idle_time > 2 * sampling_rate)) {
>                         unsigned int periods =3D idle_time / sampling_rat=
e;
>
>                         if (periods < idle_periods)
> --

