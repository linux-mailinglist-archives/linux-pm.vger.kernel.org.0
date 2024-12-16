Return-Path: <linux-pm+bounces-19315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47A79F33DC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 15:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5102718847FA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29090481B1;
	Mon, 16 Dec 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXu7Jbhu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A1A45945;
	Mon, 16 Dec 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361102; cv=none; b=rKNSryPOiRak4N55upUNmoyqbmwp7d+pLIgSfgoKRpa4MlYs2knr8QHIQtgc6t4CQ0Kt4/W39LnEpIe0718LjNLf6JQfeQrTg588mj/JxWxQ8m3Oz9l8ewSdBS4PFr2knkZIHJt7z1rIB7IWqrNDPFqBCqjZor8WRPQlcQUQI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361102; c=relaxed/simple;
	bh=C3MVMZgRHAOSpa/URd0wdg3HiGaBzg1E1nQJQEP98x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMGVeQQPy4wojRWqaljIPcUOq2leibwBW1IzfnncDELa/0MUOuR4G1Ldc7mp/3lvToQSCQl+uV4NYAdXTV0ZKoWoo8GK4Yd2zQGPhOD4RW978FuVecvMKjFLJqfOROSXiYlME6VI9AWwMMhxl/fTMhHXtiNQOgGmsxDxM5vHevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXu7Jbhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDDDC4CED7;
	Mon, 16 Dec 2024 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734361101;
	bh=C3MVMZgRHAOSpa/URd0wdg3HiGaBzg1E1nQJQEP98x8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IXu7JbhujYBFY+k3ehibZMGvU6EJdnzu/M9FjlqxUXAwuyDsMCzmnPGXwh/dECRa5
	 /6/PAOQwatrHnA/1uJ2sDgjo4VUVH0fmOnCYheZbWQwFxp7MGQEy8ZHbhR5BQpTxTZ
	 WqP+BGiCBC5/fRlxtEG3+UrJY5I7uq53eb+Mo499EWr+K4wgOn07zh9vV0zGB7L5uD
	 2WWAfLj9a1bvsdb7X2IxHUkbYjUXcF9bsoLDaG7sM3vfGOjUMxQ8Q8e/rzF5NwQoUt
	 44Fllnb0H7f7y/OGTIFm+ld9EmvIkHvemG4PUxE3/mpn8842MzsQD184L2lBF2bmqc
	 0HaC8wTfRYPTw==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eb8bdcac2eso747429b6e.0;
        Mon, 16 Dec 2024 06:58:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAH7BISbdPQaSuWxW3tUPYLixQ2EVHIKLR+HwZye3NwBIKFCRzTyN8uX4LXtzmcE94lrByvmZcuGfbu6E=@vger.kernel.org, AJvYcCVSAAltLDSai/dgHdpZ/wIpG6pHMVidPwQ4MkWmDadW4IvYi1SpWHWmwVdDyW8a+NplEQR6JBnHP4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhp6R9NlR18DiRvRqT/71N2/36UQrSXeEJ5Q8EalzoGdUDAC3r
	IL3mGEkRiS4xWS7dTQCIyONyvubotoOKdsTZVv7Y4KT0NeAL2B3ovQ1MxzucRjG4VIknEXorCRx
	eFT+21Qtk6Iyj/Ex7Gsvu8Jxc9Yw=
X-Google-Smtp-Source: AGHT+IGKgopEcsCmD0qdLr3F0fGuQ5+5rd09OzLSjOeQ2Hgr0Kb8lWmQtQi8w4tWTddESFeKUoxS0/NQNA9VejyH0xQ=
X-Received: by 2002:a05:6808:6385:b0:3eb:4137:53bb with SMTP id
 5614622812f47-3eba693acb5mr6172952b6e.31.1734361100760; Mon, 16 Dec 2024
 06:58:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <2989520.e9J7NaK4W3@rjwysocki.net>
 <7ca98023-df18-4973-8c4f-18ab381b7aba@arm.com>
In-Reply-To: <7ca98023-df18-4973-8c4f-18ab381b7aba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 15:58:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gLv1ybYWM4BfmXoW5cHtZXW3tUL+PoXDKQqSBa2UCj0w@mail.gmail.com>
Message-ID: <CAJZ5v0gLv1ybYWM4BfmXoW5cHtZXW3tUL+PoXDKQqSBa2UCj0w@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for EAS
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 3:49=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 29/11/2024 17:00, Rafael J. Wysocki wrote:
>
> [...]
>
> > @@ -261,11 +262,14 @@ static bool sched_is_eas_possible(const
> >                       }
> >                       return false;
> >               }
> > +             /* Require schedutil or a "setpolicy" driver */
> >               gov =3D policy->governor;
> > +             cpufreq_ok =3D gov =3D=3D &schedutil_gov ||
> > +                             (!gov && policy->policy !=3D CPUFREQ_POLI=
CY_UNKNOWN);
> >               cpufreq_cpu_put(policy);
> > -             if (gov !=3D &schedutil_gov) {
> > +             if (!cpufreq_ok) {
> >                       if (sched_debug()) {
> > -                             pr_info("rd %*pbl: Checking EAS, scheduti=
l is mandatory\n",
> > +                             pr_info("rd %*pbl: Checking EAS, unsuitab=
le cpufreq governor\n",
> >                                       cpumask_pr_args(cpu_mask));
> >                       }
> >                       return false;
>
> build_perf_domains() which calls sched_is_eas_possible() has schedutil
> (4) mentioned in the function header as well:
>
> /*
>  * EAS can be used on a root domain if it meets all the following
> conditions:
>  *    1. an Energy Model (EM) is available;
>  *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarch=
y.
>  *    3. no SMT is detected.
>  *    4. schedutil is driving the frequency of all CPUs of the rd; <-- !
>  *    5. frequency invariance support is present;
>  */
>
> IMHO, his patch should remove the function header since the conditions
> in sched_is_eas_possible() have comments already or are self-explanatory.

Fair enough.

I'm considering a patch moving these checks to cpufreq, then I'll
change all of that.

