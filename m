Return-Path: <linux-pm+bounces-30046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA2AF76C5
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90026188758B
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B142E7F13;
	Thu,  3 Jul 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezzHQiRF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B01AF0B4
	for <linux-pm@vger.kernel.org>; Thu,  3 Jul 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551684; cv=none; b=kzlF5pPsONGOsLV8YPnSuGdJwQvEPHqLeinSf66DEtnvXAcffykuF2WM4qErQFiCgDKSubPwxoR+FxnhrIhF5rvh64Bj7Cmx1Tk1Zz8J8RlevzVWU19WCUcByUZkdVhz/wsKM66eu5a1pKjnZXQvb76DrpbHwpI61eW5kdV8pUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551684; c=relaxed/simple;
	bh=7UebGjlrjqkNzfBK8OaZbqR7xQUhmgIfpAI/WYYa0pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR66Dz4LK9wlmqrvkKFrAVbK/1ZoMbjpH7xZPTIReSwf/u7TylI8aryKdafTZ5rOmS7tMC40YLS/BehFZr/U8a1wPrGcHPov5pE0wFC7h6J58/vZW/q0QbR4KXBzzhY2oQDyXdmBVoA9S8Q3tIrtlVC0PJRTmqFNs6RHmc12MI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezzHQiRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3322EC4CEED
	for <linux-pm@vger.kernel.org>; Thu,  3 Jul 2025 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751551684;
	bh=7UebGjlrjqkNzfBK8OaZbqR7xQUhmgIfpAI/WYYa0pE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ezzHQiRFm2uOQrfLBLn09Sq+hhXFcjjvmH/U3yfLXwwdlEg7Smi3SKrN25U7zsOX0
	 PbNbuLkVYJ2ILuzqMlePL7OKjU0YSsI8Nw7FtUrtGnrIIs9qESlxG/vuMuAqSWxBBD
	 3EpmjvXwR3ABEVQUm75KtU7zH/+OqzzptGtf+XyrUp0m5gwCf+c26xD4o2LjYrw+XD
	 Bx9zgm8LXtej/r4msHsT53YOg9RWWlLd59yKuRnycVPEXimBO+jqbRQB/Xf00QG5Gm
	 5bhGtJYiE1tjvjK2uqazey9cooSFfnAhagBuZc1Ylo8n1OxlClQLRj2MZkrbwo82DA
	 aWRa6e4mRq/qw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40b71debe9aso1440316b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Jul 2025 07:08:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHMJZL6UCib4kJ+XLIoSMoBvfDfKJSSyfSymrzDO7gZzj4RgsYfjTPR4lJAUuwWCQQbdZwdSP+NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyiwHO2ROfwtNr8RLEkZmWVPpknvyYtXZsZXQoDSvVrni4B+ke
	M5vwl4yp0YmCxcbehFtdupm3k+sY5R4GW+uYNVoWfbWGcQFqjslQXQfcyBeL1DT5JNb0sr7641l
	dUTsPbNwFilZmY++/qPKeJpi9u4VQ6xw=
X-Google-Smtp-Source: AGHT+IE2cKPWtk9w0YYlOnaSxsGlsd37E10N+z5Riomah+RUoW1Op0qDuO/SeiiKTmwXCvGlYj8t5lAN7i1F8cMnlMg=
X-Received: by 2002:a05:6808:1487:b0:408:fd16:83b with SMTP id
 5614622812f47-40b887870bcmr5806330b6e.15.1751551683488; Thu, 03 Jul 2025
 07:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611032438.10895-1-qiwu.chen@transsion.com>
In-Reply-To: <20250611032438.10895-1-qiwu.chen@transsion.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:07:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPC2trONuReHmrNo6DO=cR=o6rqKpJ_QW9pC7wFhzWww@mail.gmail.com>
X-Gm-Features: Ac12FXxW0LCvqhorRN5WfjImWnBzxxeSIX7I_PeKwnlUU1RekNW7TKOOsUKvNOg
Message-ID: <CAJZ5v0gPC2trONuReHmrNo6DO=cR=o6rqKpJ_QW9pC7wFhzWww@mail.gmail.com>
Subject: Re: [RESEND PATCH] cpuidle: add tracepoint for s2idle flow
To: "qiwu.chen" <qiwuchen55@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	"qiwu.chen" <qiwu.chen@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:24=E2=80=AFAM qiwu.chen <qiwuchen55@gmail.com> wr=
ote:
>
> Add the tracepoint cpu_idle in enter_s2idle_proper() for tracing
> the s2idle enter and exit events with a determined idle state.
>
> Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>

What exactly does this tracing allow you to do which is not already
possible by other means?

In any case, this information should be there in the patch changelog.

> ---
>  drivers/cpuidle/cpuidle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0835da449db8..9dca6a63e4ad 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -149,6 +149,7 @@ static noinstr void enter_s2idle_proper(struct cpuidl=
e_driver *drv,
>
>         instrumentation_begin();
>
> +       trace_cpu_idle(index, dev->cpu);
>         time_start =3D ns_to_ktime(local_clock_noinstr());
>
>         tick_freeze();
> @@ -174,6 +175,7 @@ static noinstr void enter_s2idle_proper(struct cpuidl=
e_driver *drv,
>         start_critical_timings();
>
>         time_end =3D ns_to_ktime(local_clock_noinstr());
> +       trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
>
>         dev->states_usage[index].s2idle_time +=3D ktime_us_delta(time_end=
, time_start);
>         dev->states_usage[index].s2idle_usage++;
> --
> 2.25.1
>

