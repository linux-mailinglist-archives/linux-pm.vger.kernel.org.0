Return-Path: <linux-pm+bounces-41097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA85D3A8D3
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 381CA30A5983
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247835B13C;
	Mon, 19 Jan 2026 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUJo4cYk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA8E35B138
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825822; cv=none; b=lhR4TcjLA4ucAGPpGBZvR/UCW4PkcdrBp5fzQC5b4wFYzTGq9KmTkkA1eDQiPUdHRf0KHNARLc6efLCZZM0IygkGrsa4ouRKYuKwl+8SqQeQZ6+JQltqIn0vkaPnqbshSxRIU0mE6cqrSDjr4NSYJVKUC9A013GQtIFaIZylWPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825822; c=relaxed/simple;
	bh=AGiSWdIjqcCkIzUWZ+e2XIl/XdcoubBgfAl3S0l0Yy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyFPkQ4Rk8HfYIVpCvWBbPrqLfZpn2FKfeIqtY5Gy39oXG1L4fvy8VkSWAWEh4Ta7mjqVV0OqVJ1PcBmrah85wqmiJx65ES5LT1bgevK8zf2E7zUOWTyMdu5CBhZTfysL2qFTkdYjWNElMaKT3zw82xOM9fctjTndrRxO3nw+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUJo4cYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C8AC2BC86
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768825821;
	bh=AGiSWdIjqcCkIzUWZ+e2XIl/XdcoubBgfAl3S0l0Yy4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BUJo4cYknabYZtdBbL+/mLHuuDSar6nIIwS1EvDKN3SwsYO7sZET9/lQywm1vdesA
	 OhPiVl7AYa1DO85LIiYFx6ee7r/TzQ7EE+VZtijohfZ4Ec4iFcfRhGWc79gqHwPN+X
	 IeqXTb9HEwq0wsq3eRGy1DWh3ovF8HFIZkUXNNYMOjcBo/rP8OJQ7z+c2NoL/C8Plv
	 srVRkJhugAjIPHV7HfCGpiOWlrh1n+De9/CZZ3DwBDiOxtWWIyWtYjIzl1NuttS9CE
	 r1c+zinZVYu6/oMs6jNjauvLcFmTPUuUXW5n/Tt13c9Gk1twM4dLtaWwlmLIcQFZWG
	 zgCOvQvcFhteA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6611ca93e45so1495584eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 04:30:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzYJ8w2W3u+u1pL2NZDqjhsYtlAib8aOiX+kXQcIMiHHORPYQDL6iScwmiENePb6znL8UyX/1+Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaJPfgRkvuUmgmf50Dcmm1P5bKOuiycjpK/grCIU7u8vVumbZS
	cff/yq00p1PyJZCVfCcYF0cd8Q07o/rWX02zM2/+zSHaA7y+UKDvHofBAhH63yCOFxwgesWgrPn
	zAeElUYAYhdqPLWDwYOBV2Wz8foeWs+0=
X-Received: by 2002:a05:6820:625:b0:661:ae2:95ed with SMTP id
 006d021491bc7-661189adbd2mr4500479eaf.60.1768825820390; Mon, 19 Jan 2026
 04:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116145208.87445-1-frederic@kernel.org> <20260116145208.87445-8-frederic@kernel.org>
In-Reply-To: <20260116145208.87445-8-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Jan 2026 13:30:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hn81J_0N0Hy6QYtc3655w-9hDqVgWWY1BVhW=DT56Deg@mail.gmail.com>
X-Gm-Features: AZwV_QijNtZmi1zR4iwR07o__vPOI-DD5wfQBm2ysAJARvjnZxZ46W3q48jp7lk
Message-ID: <CAJZ5v0hn81J_0N0Hy6QYtc3655w-9hDqVgWWY1BVhW=DT56Deg@mail.gmail.com>
Subject: Re: [PATCH 07/15] cpufreq: ondemand: Simplify idle cputime
 granularity test
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Kieran Bingham <kbingham@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Mel Gorman <mgorman@suse.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Valentin Schneider <vschneid@redhat.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Xin Zhao <jackzxcui1989@163.com>, 
	linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 3:53=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
> accounting has a nanoseconds granularity.
>
> Use the appropriate indicator instead to make that deduction.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

or please let me know if you want me to take this patch.

> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq=
_ondemand.c
> index a6ecc203f7b7..2d52ee035702 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -334,17 +334,12 @@ static void od_free(struct policy_dbs_info *policy_=
dbs)
>  static int od_init(struct dbs_data *dbs_data)
>  {
>         struct od_dbs_tuners *tuners;
> -       u64 idle_time;
> -       int cpu;
>
>         tuners =3D kzalloc(sizeof(*tuners), GFP_KERNEL);
>         if (!tuners)
>                 return -ENOMEM;
>
> -       cpu =3D get_cpu();
> -       idle_time =3D get_cpu_idle_time_us(cpu, NULL);
> -       put_cpu();
> -       if (idle_time !=3D -1ULL) {
> +       if (tick_nohz_enabled) {
>                 /* Idle micro accounting is supported. Use finer threshol=
ds */
>                 dbs_data->up_threshold =3D MICRO_FREQUENCY_UP_THRESHOLD;
>         } else {
> --
> 2.51.1
>
>

