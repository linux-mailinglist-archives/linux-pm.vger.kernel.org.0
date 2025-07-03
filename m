Return-Path: <linux-pm+bounces-30041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF30EAF75D0
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5575675A1
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4902E3398;
	Thu,  3 Jul 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqPzRx1r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FB2E03F4;
	Thu,  3 Jul 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549704; cv=none; b=kmedMZQAPN6cCKZoW5HSQehSOoQ2NrkWiNr2ylSH8pMvmi1e4U1dP804OmQRpTliCx2XkKujSJ5OnPjv5pIa/a6t1+lt6uv12BB/iS7q75lFUpAsKVKdsZl50GsRukei2yFOMMLNll8QgVMvY0nvyh3e7VQs3P9MbYkLTD2aE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549704; c=relaxed/simple;
	bh=WVh03UrKKMZebFsj28jXXmaKIXAvdki6/0YMrcBckWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zi8HJ/nUIMNVoHRg6ubGqlEUBPO+Z4oja+qKfwmZLG7YfmL4XEKBK5E8avJaqNh4amLFooSIo/63Q5oxxxAcDrSv7TXI23qJYN0g1aq5XjgxBNSX+eSbswM3h34wzamKHPH52ob6jzLocVz0swHojAtM38l0WiueIzgMmjH1uco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqPzRx1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C778FC4CEE3;
	Thu,  3 Jul 2025 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751549703;
	bh=WVh03UrKKMZebFsj28jXXmaKIXAvdki6/0YMrcBckWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iqPzRx1rrUSaHtuwZ6DJdTYB4GQ8FkakwKL7eBHFP2oehlq+8Nov6LTzI/Tg1Z+Bi
	 U1Wk7TKZ43JEscCnyQSP//4x/umWagmt6mZL4g8ihF46qG/rAlBQuXKqcrJvDUbUOM
	 /P18XaYsiwTr8aZBWMftAC0fI7pMsMr5T32ksODQvTWWXEYZ1/+R++z1gDkNk8NsQS
	 p3lvKj2/JIRESxM8SRQYnlp/w1/pbF6sIxw/kuTSHUheZbU4G2gV5X5SwvRHYYajhZ
	 g6yDDuLDW+YJ2McJcemnXp4Pwq4Q+e/nmkYMiID3987fADkBz6QY6IKGbrLVJkhw4L
	 CgH+9by2T3vOg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-611b246727cso2843307eaf.0;
        Thu, 03 Jul 2025 06:35:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAWiFLEzhLFYvFzYxMkrRjr1AI1LjOeKfi4m8IRVTV8hwF5Po2gQwfiZ5taAEn2dzKLhtRlXIT4LTf942z3ZPF6kgn@vger.kernel.org, AJvYcCVlkxsOB8FrgRH/0u8yFqh2QAchvdlsb47ve3qSkp5zlXXVUiqsXPfyHaqeBlFPtSPSl1ZRi4EP6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3u1wpG02eNGwbbw4wlSlcrYoBw4CHGoKKNybg1smw2F6IXLRe
	9df5mM46RLAm6kdM2kAo0jAVwSj9DXAjI2lGBwERn3d9pcu2zcvqlWnZtYWcl1UfmUO+g6WCgZ8
	puifWlSzDrnD6/rnaolak98boPNGnLYg=
X-Google-Smtp-Source: AGHT+IFXCo3QjWMLEfAx2AHr/+WcA8i4kKNZBECRqwWrpQd2bXdgx/R657LBUV+shBDZm70G215NOPFVkIIseBbBgRw=
X-Received: by 2002:a05:6820:218:b0:612:c547:7984 with SMTP id
 006d021491bc7-612c54780dbmr3207808eaf.1.1751549703080; Thu, 03 Jul 2025
 06:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611032310.10610-1-qiwu.chen@transsion.com>
In-Reply-To: <20250611032310.10610-1-qiwu.chen@transsion.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 15:34:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-7ZrnKO5s--zXmaA+M07tiLBy1x-hsw4JqLPvCtt4aQ@mail.gmail.com>
X-Gm-Features: Ac12FXwcnbbdlK2F_TNpx83OutHKwJ5zPO-Qu4_o-BgPDR5aZCj7-ZW1Q4QnlV8
Message-ID: <CAJZ5v0g-7ZrnKO5s--zXmaA+M07tiLBy1x-hsw4JqLPvCtt4aQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] cpuidle: Add find_deepest_state trace event
To: "qiwu.chen" <qiwuchen55@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, "qiwu.chen" <qiwu.chen@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:23=E2=80=AFAM qiwu.chen <qiwuchen55@gmail.com> wr=
ote:
>
> Add a new trace event namely cpuidle_find_deepest_state to trace
> the found deepest idle state during CPUidle flow.
>
> The new trace event will help developers debug CPUidle issues by
> providing more detailed information about the CPUidle states.

I wonder what exactly this is needed for.

The function being traced is used mostly during suspend-to-idle, so is
this what you have in mind or something else?

In any case, the changelog needs to be more specific about the reason
why the new trace event is needed.

> Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>
> ---
>  drivers/cpuidle/cpuidle.c    |  2 ++
>  include/trace/events/power.h | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0835da449db8..9065aa396892 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -103,6 +103,8 @@ static int find_deepest_state(struct cpuidle_driver *=
drv,
>                 latency_req =3D s->exit_latency_ns;
>                 ret =3D i;
>         }
> +       trace_cpuidle_find_deepest_state(dev->cpu, s2idle, ret);
> +
>         return ret;
>  }
>
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 9253e83b9bb4..82b5ac8c46e6 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -62,6 +62,30 @@ TRACE_EVENT(cpu_idle_miss,
>                 (unsigned long)__entry->state, (__entry->below)?"below":"=
above")
>  );
>
> +TRACE_EVENT(cpuidle_find_deepest_state,
> +
> +       TP_PROTO(unsigned int cpu_id, bool s2idle, unsigned int deepest_s=
tate),
> +
> +       TP_ARGS(cpu_id, s2idle, deepest_state),
> +
> +       TP_STRUCT__entry(
> +               __field(u32,            cpu_id)
> +               __field(bool,           s2idle)
> +               __field(u32,            deepest_state)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->cpu_id =3D cpu_id;
> +               __entry->s2idle =3D s2idle;
> +               __entry->deepest_state =3D deepest_state;
> +       ),
> +
> +       TP_printk("cpu_id=3D%lu is_s2idle=3D%s deepest_state=3D%lu",
> +                (unsigned long)__entry->cpu_id,
> +                (__entry->s2idle)?"yes":"no",
> +                (unsigned long)__entry->deepest_state)
> +);
> +
>  DECLARE_EVENT_CLASS(psci_domain_idle,
>
>         TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
> --
> 2.25.1
>

