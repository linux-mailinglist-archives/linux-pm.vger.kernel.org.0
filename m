Return-Path: <linux-pm+bounces-17467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB4C9C683B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 05:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA7E2851BC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 04:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4702C15A858;
	Wed, 13 Nov 2024 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGfu7bkX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068BE17C
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 04:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731473490; cv=none; b=cJr6VTvUxqMXkYimTqATCmPRlPjjDwXEoXVnoor6s8bC4jdmDrZtEYpItPBzzBqYBxkWEHTf3Y2W+Za00AGMXviw96VjGP+AWdwH2qjd+vp4qFS94gdtFZwDFZPcPwmB9Y1uTkrjClrEBETKCocpXFCvVyxBUWqWZx/HzYiguEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731473490; c=relaxed/simple;
	bh=l0c4oi/lRVU0xacNIBmUnJ8MqVpO06c6BsKZLfNXWao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AliUnOfdnw8pS7dVqo/R9XVq385HyHSeu6emeCnxjzAZBAA3RoRYBZJG1n0kDJYC+wkGZQiuHSDVo7UFruX6RKBhURGt7ZuY98JToRFQKSy0ORuf3qR4ZNY0H2GpPkNrU8/w/C/Rd/zdbac5YIXI39wUJaaJyFArpMssSGczXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PGfu7bkX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so7668565a12.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 20:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731473486; x=1732078286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpLXALlzKEchFhHx055mxHWuvzO7Fxzz+fkVfPWjj3A=;
        b=PGfu7bkXeWaIMV60tbxMOvwEAUB2V78xNw9kRILVc5yDJ24G4Ojtykvk1B3R1c5e5R
         JBvj8KOn3nJ0C7QKggGHkoAJbqfUVHORkM3CZ0iXYhZEX0AIhExU80EjCLH0J0xn+beC
         mAG/NJCsQJzychAonFf3hq2fluTWQ5PO0fr2TS3rO5yMXz5SVY9GPPoJiD4rAiPsQ96N
         Fa1U3DBEyXqo9Za96VOyWPzYiEtHb75q8MDHq8ynmlB54NNLCND8hNYyMq3NfIEQEvUX
         ejfasMLCr4ZFsy7T5ia2q3g3h35ULUueYPfwuG21h7pQLRAHOPMpTTnK0LzmU3phrfb9
         MUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731473486; x=1732078286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpLXALlzKEchFhHx055mxHWuvzO7Fxzz+fkVfPWjj3A=;
        b=gOl3euo+hK6vKGU7TOK7uXIMFqAiltbR3GDwEvr42xOljeOtw0nnQ02g2laY9ZQPJr
         dcn9do5RWNgXNcxYkepwtNwA5wmslVdMAWZI7yo5Q9fvyAXUfEso2IjDdmmI/cLYT69+
         CSC/qW+sjfyxKtUrbK+eLVQJhwDUYYz3hiTlFLIPWCh1guJZR5wt92tfQWuP7WwpemJz
         zPx/SGrCEStHzQ6VfazGtkANNC8PZLhS6JhN/z2c7nxWI788qx2I+D/00HvurE5htxuM
         WYsejtaMBTuAFS3ijgPsurnr7ln29JtKBuFJQcuHfiOxGBvJ5jCd7DUns2RdgxDYpOyP
         DfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmSFynqvxKL0mw+Zi4u3AuhX0XDuL2dyKxmgjUxA0pB+Bv0FQO7/qUP0E7Ki8l8BRgFTJRKIK/1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoaNXtVFHHQ6Sdxq8zC7kf9xF3Bnoec+RcPCg8RzQzzEq+PJ9O
	9C6Czt+8dSxJ1ohVkXSXRKv1nOti+jmvAaUQEYQj5+dCgLmC1QpgpeusdpZH3JVwvyXHjlI4sTb
	qlwvVgjruHvYSj4HEaqixvKv9CQwmuNC00x0=
X-Google-Smtp-Source: AGHT+IEuMJK/b6RMPc2Z5S8NSxqpfpKwrEjaoecAxmYJnqCdahkftPa9sU7FbYEMc13TpQneZMMHWPiTo/Zlopl5vkM=
X-Received: by 2002:a17:906:6a20:b0:a99:529d:81ae with SMTP id
 a640c23a62f3a-a9ef00239c8mr1839737466b.55.1731473486274; Tue, 12 Nov 2024
 20:51:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820163512.1096301-1-qyousef@layalina.io> <20240820163512.1096301-6-qyousef@layalina.io>
In-Reply-To: <20240820163512.1096301-6-qyousef@layalina.io>
From: John Stultz <jstultz@google.com>
Date: Tue, 12 Nov 2024 20:51:15 -0800
Message-ID: <CANDhNCrU3uuA137Udvh+RfC9ELhc7scjR=Oacosbyw+b68AR3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 05/16] sched: cpufreq: Remove magic 1.25 headroom from sugov_apply_dvfs_headroom()
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 9:35=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 575df3599813..303b0ab227e7 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -187,13 +187,28 @@ static unsigned int get_next_freq(struct sugov_poli=
cy *sg_policy,
>   * to run at adequate performance point.
>   *
>   * This function provides enough headroom to provide adequate performanc=
e
> - * assuming the CPU continues to be busy.
> + * assuming the CPU continues to be busy. This headroom is based on the
> + * dvfs_update_delay of the cpufreq governor or min(curr.se.slice, TICK_=
US),
> + * whichever is higher.
>   *
> - * At the moment it is a constant multiplication with 1.25.
> + * XXX: Should we provide headroom when the util is decaying?
>   */
> -static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util=
)
> +static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util=
,  int cpu)
>  {
> -       return util + (util >> 2);
> +       struct rq *rq =3D cpu_rq(cpu);
> +       u64 delay;
> +
> +       /*
> +        * What is the possible worst case scenario for updating util_avg=
, ctx
> +        * switch or TICK?
> +        */
> +       if (rq->cfs.h_nr_running > 1)
> +               delay =3D min(rq->curr->se.slice/1000, TICK_USEC);

Nit: this fails to build on 32bit due to the u64 division.

Need something like:
       if (rq->cfs.h_nr_running > 1) {
               u64 slice =3D rq->curr->se.slice;

               do_div(slice, 1000);
               delay =3D min(slice, TICK_USEC);
       } else
...

thanks
-john

