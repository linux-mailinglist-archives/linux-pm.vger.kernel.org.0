Return-Path: <linux-pm+bounces-20419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F06CA109F7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 15:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B63A1887E06
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E69614EC55;
	Tue, 14 Jan 2025 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoKaRLB0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8614A0BC;
	Tue, 14 Jan 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866422; cv=none; b=YXypqJlvbUI6yohbqN3sn3hUzi9RbrZD/2yPZz43V0P+O4qiC2hVTJ29SGdEYlUsS1hG2fduNr3wkIrWb8wmLyVxULgpxfWQ0pewjTPfymJ4G7LG4CgsP1A2Yw1osb1iYXvBe9iZO151JvTchHXAkwJEue47zRbUtNekpeF0Z0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866422; c=relaxed/simple;
	bh=+c5ZmolFTCQUiDo2UMW4qYpZjljqQpskKCpW5AbBIqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELTdPZbO4G/xollXGbxBlaQpOXiyLl1dsGnvTpEbbHWDVgOFVAQ2F5QWQDvnmUvwRjm55CngJ7QTJzlasrvPwMQOx8jaruOcD7hJ5QUSiVlqfTt3WTte40RMCSOHtICHpMX27h0YqZa0jO5kC15i6bjpv0KBU66g2TZI3dgp0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoKaRLB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8649C4CEE6;
	Tue, 14 Jan 2025 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736866421;
	bh=+c5ZmolFTCQUiDo2UMW4qYpZjljqQpskKCpW5AbBIqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EoKaRLB0y1P6mJ9RrfHec5GcOXxgZGCmH0FzC+OefKvs2dzeWJgHy1RVTw+rM/Bqn
	 HteKl43GzX3qpw4UGxGrgofZIzoLekAaQdm+5zlYc7Lryxq4sdSzMkA/6AZCe0qFwp
	 gRc1CMofsGUzdu4Icc0a85u7EDEVQggsQy8C3ntBNJuBsU+JUIVurS2Me9cJ5I0Uo5
	 q4/QvHn+MVgEFoOilJDYjhXIlo+XyeaRGuGNQN95/fXU1jwtTm3kvJAI3bOJngfsAu
	 L/XsWYe77b4139t5XXfkX3rIdp0KQK/3Nz0B91Wkj9hsPbMdpGcW0bmlblGH1Lrl5B
	 HOYV3DzvTs/pA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2aa179a8791so3614128fac.1;
        Tue, 14 Jan 2025 06:53:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3M7bYl4WqG5UrEbNJxTCA6MNUexMRfhAKxL+Le1rAb0tzLLueQF3hEI71v86pAgfIGnIN4BHftA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQOoCt7lFJlL8HSUiwYezEKWHIL//fkKxra+xH6U1jclvIAAK
	1DhvtESByA27ior/Slpo5PC37FXXxyCVWeCMNDTuteDp+BrxMCZuFyCqh/vSihuFnPLMOodiwXN
	ejPew5rhxU67h6O9SMHQL+3HDlgE=
X-Google-Smtp-Source: AGHT+IHRFZTM1TjkIC3TGqdQ8TfP3DeZAjksH30gxT/oNJzLL9oXqYnKcyqZxk+8LDa7T2J0RZ2ODX90drHZY9kyuUk=
X-Received: by 2002:a05:6870:1710:b0:29e:1325:760a with SMTP id
 586e51a60fabf-2aa06668e92mr13736916fac.8.1736866420902; Tue, 14 Jan 2025
 06:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102150201.21639-1-frederic@kernel.org> <20250102150201.21639-6-frederic@kernel.org>
In-Reply-To: <20250102150201.21639-6-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 15:53:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h3O_q=Kjyp3X5-iAjAjPFBdRSZX4MJaqCGZmgRDHV9jg@mail.gmail.com>
X-Gm-Features: AbW1kvZUWPVjbVbvcOhvPgZmNUVat2CDLK0mF9UusfJqZPNmoFPTfqrW8qhxp7M
Message-ID: <CAJZ5v0h3O_q=Kjyp3X5-iAjAjPFBdRSZX4MJaqCGZmgRDHV9jg@mail.gmail.com>
Subject: Re: [PATCH 5/6] cpuidle: Remove call_cpuidle_s2idle()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 4:02=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> This middle call is unecessary, especially now that its counterpart

unnecessary (one 'n' is missing)

> call_cpuidle() has been removed.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

For the code change

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/sched/idle.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 9eece3df1080..86b902eb24fe 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -126,19 +126,6 @@ void __cpuidle default_idle_call(void)
>         instrumentation_end();
>  }
>
> -static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
> -                              struct cpuidle_device *dev)
> -{
> -       int ret;
> -
> -       if (current_clr_polling_and_test())
> -               return -EBUSY;
> -
> -       ret =3D cpuidle_enter_s2idle(drv, dev);
> -       __current_set_polling();
> -       return ret;
> -}
> -
>  /**
>   * cpuidle_idle_call - the main idle function
>   *
> @@ -184,10 +171,12 @@ static void cpuidle_idle_call(void)
>                 u64 max_latency_ns;
>
>                 if (idle_should_enter_s2idle()) {
> -
> -                       entered_state =3D call_cpuidle_s2idle(drv, dev);
> -                       if (entered_state > 0)
> -                               goto exit_idle;
> +                       if (!current_clr_polling_and_test()) {
> +                               entered_state =3D cpuidle_enter_s2idle(dr=
v, dev);
> +                               __current_set_polling();
> +                               if (entered_state > 0)
> +                                       goto exit_idle;
> +                       }
>
>                         max_latency_ns =3D U64_MAX;
>                 } else {
> --
> 2.46.0
>

