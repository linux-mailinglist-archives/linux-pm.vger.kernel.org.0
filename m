Return-Path: <linux-pm+bounces-27591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A76AC2654
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013159E7434
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE3A2206B1;
	Fri, 23 May 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj8DgWq8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA0625
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013663; cv=none; b=NFmm7cAaIPh8IefKjV/3Kp4oK2mTW2nzuLU69vaUgFkgDUkG6xevOesioeTAtCyD1ivlh4ymlhXawGouchUVfLN3MkGOj0VOE/N4YZ8LK/lvc5ldcK49hXDowrJBLPCZGAk5ehIfoPoYGmm07VNXiqYzczTZBJyyCBIhgqZx9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013663; c=relaxed/simple;
	bh=ysgiaY1YgmJPIosEWI4Gee0/4cvqR8zWZVxc7c8KAhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ei3256Cl71FscWODNDhxkbedkS2TkVMKAmerE9M6F3AFcQG0xnbfTBFriCnxZ4JinU+vRF1UgYZo2hvIqMdRrTRY16mwanDY5Yap/T9e+oqoosUV7fqc36NHUZCd0mPytxUWDcubkR0CygVXnulxqMnYhHxKY3LMW2jHr0hqKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj8DgWq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66424C4CEF3
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748013663;
	bh=ysgiaY1YgmJPIosEWI4Gee0/4cvqR8zWZVxc7c8KAhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bj8DgWq80XHMGnhrcNkIEgv95Ao9YDOaN6G5nDCTQrpye+VXEy9rUztkhQzWKkVIX
	 nxr08XAwVcKfc2n0eDvOhE0Nm5aHQG/pzlWR34a4iA83nzUsJAZWx3+95DXrmXMWUj
	 +kkTIAFZBvJKczIY7MHpJ/w7hfxDMKeQj+cQyMQMDkwQymUPVGVdfF4EznmGPmjKgH
	 92F2oNHQ5Iw4teuQkTIClD1/AzODnrs4DyjWo5XOupRpY0Dyp4A26MZGGUrmkRxzW0
	 hjpZTMgm5HeAYQUeTRD4KduoH2PstpFPbZgw4Lmnr+g1rZkqPDgUI39WgYWFWJDwTv
	 E6H3WYbsc5OXQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f6a92f234dso36690b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 08:21:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBcczahN+LNaimX13/tgkzA70i+oe0+mLJjo82sI2LV3J7VGM2UyWQKc7SQ1c0gkHpjo3rGGu2mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3ebRILgZPZe9yR42s/Dgyi7beZrJtEY3zjTmLbEBkO+4NkX1
	a93tGc6KzfyKc/XDOVfgG3khG73omLVAxiKYCSqdSccRRDH9Ngq9xEwhDXwABH/W3xG/rAdehZd
	yNPk43DCqRDODiWAC+HSzqm6xK5lCv3k=
X-Google-Smtp-Source: AGHT+IHW0VMRAoHbOS4siw7ekm0MN8Vkx9hh/7FT9B7Bb/fsjTOo/vFaZr1vxex4MyzDhWSjew/4Tb40sOfXCMPCLnM=
X-Received: by 2002:a05:6808:4447:b0:3fe:ab15:5ecb with SMTP id
 5614622812f47-404da713fc8mr20288341b6e.9.1748013662722; Fri, 23 May 2025
 08:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082811.92279-1-qiwu.chen@transsion.com>
In-Reply-To: <20250519082811.92279-1-qiwu.chen@transsion.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 17:20:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jnA0sCMs5JCmQszrp2ys=m5Pz-q=vHAP7YP5xttRBDOA@mail.gmail.com>
X-Gm-Features: AX0GCFvzC2Zh9Wk3AtVe_ka1PGZh8mFZDEQ35xGakLsonoXih0DwqfRaP0wp39U
Message-ID: <CAJZ5v0jnA0sCMs5JCmQszrp2ys=m5Pz-q=vHAP7YP5xttRBDOA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Add find_deepest_state trace event
To: "qiwu.chen" <qiwuchen55@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, chmathieu.desnoyers@efficios.com, 
	linux-pm@vger.kernel.org, "qiwu.chen" <qiwu.chen@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 10:28=E2=80=AFAM qiwu.chen <qiwuchen55@gmail.com> w=
rote:
>
> Add a new trace event namely cpuidle_find_deepest_state to trace
> the found deepest idle state during CPUidle flow.
>
> The new trace event will help developers debug CPUidle issues by
> providing more detailed information about the CPUidle states.
>
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

This is a bit too late for 6.16, please resubmit when 6.16-rc1 is out.

Thanks!

