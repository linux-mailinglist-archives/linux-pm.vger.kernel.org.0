Return-Path: <linux-pm+bounces-28201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A90AD063A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 17:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7583ADB09
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AC17C219;
	Fri,  6 Jun 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3OT9DNn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB32A8D0;
	Fri,  6 Jun 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225205; cv=none; b=NUGwLPkTWsz4ehXvfRR09p7eDzwGIWf+jAYIMPhGruMbPaSHnINTqvbGAYeD0VJdIWWL7+sO2sBhMuZOnim65SRUcPwpqrMzTdvi++ZDsgBBzRgnnB/HOjKZDgW1dhGNMW7UqtCI80zYwWC09xykyLyFDffoyI6Hl8pUlE7/HxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225205; c=relaxed/simple;
	bh=ZffmP67iCxIRYWii/TFpM7JL7F9vyh8RFszEdPO/+Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpsM7csr1U7Gw5v+7RfMZG8OUsVZCFJwqRZrIXIU0TgqteGkzOGa3oifoSC3wbYcJUxh7lVwZqrwXMbTYjkUCU+dsnN483XBGW+2FomEjZSiyQbPLJ30ELFng1FJavJOZf7OBN9tqdOAIjX7no7CdQa3LRZOCJU1hp6JMQisELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3OT9DNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C176BC4AF0B;
	Fri,  6 Jun 2025 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749225204;
	bh=ZffmP67iCxIRYWii/TFpM7JL7F9vyh8RFszEdPO/+Hs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b3OT9DNnXO5osD4dJlnoyI4sFZc6IAYmkIkPppRJN9y4+1OfB57nSX9FRApm7m62l
	 PbAZJP4LoUmrIOQPtLxXgcm89KiaOLxuOqQx2qH/BP2wIolqCh9qWnT9spfg7D8BWj
	 8/OxwCNljX3iAThB5iKR7pLM1YDA3aDcb9AHCl8Xqm/j6HTqzI09w+QEidilv7ewYN
	 ai1pEREFmx5Q5EVXTMrdKaO66lSRdW2+ZAVZ8FA/x4h44RPsPM4LsKsxB7+Pljq8K4
	 Xltt9jkNa42MAVJPxnHiwtSeXjR/ldwbgUW3H/H7LkLq4QLXWYdFavAwj9nRQudZke
	 7PHl6AzrFgmTw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-606440d92eeso1047646eaf.2;
        Fri, 06 Jun 2025 08:53:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5sQH6skdmi5lE3tcQQLeM8iPtyf4sL27aEtharf0YYB6pZnn5YtBhB67EyYCxD8KjqRGDa8r3BQ==@vger.kernel.org, AJvYcCXt8miAJVs+yD/MTPfaU43cEyZCs9EU2Qq918Hw7YYIsfsIcIQTX8sxyRrI7OEpZOih2IP0yh3MYiL64M9J5afVcS1c@vger.kernel.org
X-Gm-Message-State: AOJu0YypGi6HCtq2edY9wQB8YnTus/BZ5v8UxmniluQuyLG3sFyrlrVm
	0Uuqy+f6i4umn0RcnYf+TwO6hMXetGSQnyzVECYzhw4nMqW9uxIf96ICGQXbMwZOZnRUiCh1Tb/
	ekxvaC/cXKHl+5bEuo+NPCecsDaKTA3A=
X-Google-Smtp-Source: AGHT+IHBSME4mlhGbIZWonHHrlJr7EgE5rjgS6F7nUJqSApeJe5WcvW3GCMdvtQHJSXOLL/eLJNs6DSTGvoI7zCAw8Y=
X-Received: by 2002:a05:6820:1898:b0:60b:c6c6:f69e with SMTP id
 006d021491bc7-60f3cf1d259mr2209450eaf.6.1749225204064; Fri, 06 Jun 2025
 08:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605162106.1a459dad@gandalf.local.home>
In-Reply-To: <20250605162106.1a459dad@gandalf.local.home>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Jun 2025 17:53:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hd_vCvmX9+__0M=aB437P-dxhYYEFnF2EaMe=XLTQiUw@mail.gmail.com>
X-Gm-Features: AX0GCFsDgwpPXDpz0mMHZAFjnJVZ7FG-ShjXzJgXHh-KI0TNkQ3yTdfKt6UL3sI
Message-ID: <CAJZ5v0hd_vCvmX9+__0M=aB437P-dxhYYEFnF2EaMe=XLTQiUw@mail.gmail.com>
Subject: Re: [PATCH] tracing: PM: Remove unused clock events
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Kajetan Puchalski <kajetan.puchalski@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 10:19=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> The events clock_enable, clock_disable, and clock_set_rate were added bac=
k
> in 2010. In 2011 they were used by the arm architecture but removed in
> 2013. These events add around 7K of memory which was wasted for the last =
12
> years.
>
> Remove them.
>
> Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.h=
ome/
>
> Fixes: 74704ac6ea402 ("tracing, perf: Add more power related events")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  include/trace/events/power.h | 47 ------------------------------------
>  1 file changed, 47 deletions(-)
>
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 9253e83b9bb4..6c631eec23e3 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -337,53 +337,6 @@ DEFINE_EVENT(wakeup_source, wakeup_source_deactivate=
,
>         TP_ARGS(name, state)
>  );
>
> -/*
> - * The clock events are used for clock enable/disable and for
> - *  clock rate change
> - */
> -DECLARE_EVENT_CLASS(clock,
> -
> -       TP_PROTO(const char *name, unsigned int state, unsigned int cpu_i=
d),
> -
> -       TP_ARGS(name, state, cpu_id),
> -
> -       TP_STRUCT__entry(
> -               __string(       name,           name            )
> -               __field(        u64,            state           )
> -               __field(        u64,            cpu_id          )
> -       ),
> -
> -       TP_fast_assign(
> -               __assign_str(name);
> -               __entry->state =3D state;
> -               __entry->cpu_id =3D cpu_id;
> -       ),
> -
> -       TP_printk("%s state=3D%lu cpu_id=3D%lu", __get_str(name),
> -               (unsigned long)__entry->state, (unsigned long)__entry->cp=
u_id)
> -);
> -
> -DEFINE_EVENT(clock, clock_enable,
> -
> -       TP_PROTO(const char *name, unsigned int state, unsigned int cpu_i=
d),
> -
> -       TP_ARGS(name, state, cpu_id)
> -);
> -
> -DEFINE_EVENT(clock, clock_disable,
> -
> -       TP_PROTO(const char *name, unsigned int state, unsigned int cpu_i=
d),
> -
> -       TP_ARGS(name, state, cpu_id)
> -);
> -
> -DEFINE_EVENT(clock, clock_set_rate,
> -
> -       TP_PROTO(const char *name, unsigned int state, unsigned int cpu_i=
d),
> -
> -       TP_ARGS(name, state, cpu_id)
> -);
> -
>  /*
>   * The power domain events are used for power domains transitions
>   */
> --
> 2.47.2
>
>

