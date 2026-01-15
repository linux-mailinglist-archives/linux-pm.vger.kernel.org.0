Return-Path: <linux-pm+bounces-40956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A92CD29448
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 00:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 042983035CC1
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D015330D29;
	Thu, 15 Jan 2026 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mzt+qbtJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF332E6BC
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520137; cv=none; b=EoiWGjyV1I/9poG5mKa76MWnjwNvUbkxlP9X0qLrJhwScMhD+McSBx4lHs6olFgd6LcjT9/mruIhnfdW3543rNPJzxCh+jL/QfDSj85IYiuygKt3Yq46nJnXK84iWa5uPa4ftutF7zE38k57uf2CagkadN0WVgztPpYvC3NRDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520137; c=relaxed/simple;
	bh=Sd5u1m4hBvY3ac+Xo0S7P6bC5jfOmx5rGLi7Jyx41H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsbyaSe+PBLbfdG9BHEbx+PQ4bQrOtIgn7m20kDgNHS74g8TIs3mVQHgi18443VlVVh26vpnhix62PZKykOU/8tddi6qrtq4roOW4kDKxEYZyUW8gj3B23XUDDaiQ9nIe27LLawXji5he1vB57LA0yd3twxzGUICc4nIPny2DGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mzt+qbtJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b871cfb49e6so256560266b.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 15:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768520134; x=1769124934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd5u1m4hBvY3ac+Xo0S7P6bC5jfOmx5rGLi7Jyx41H0=;
        b=Mzt+qbtJ10hAeqYHRFXJUHvk2GtxJzcoPJozj+fg//Ci+xE1EKsS0ZwbNiWBg32nwf
         KocUAGWC5B8evL1gny5lPBAxnq/aNZjWxYn5dYmMAFJzksR9VOtW51ynVxA5duGgWSFH
         CHajMKJSk5Zgl23ZrhQkSIHnDahRkVqf0OxArPMDPZPdTgzVFYkb9a18aeXm9yGiKaxi
         rtMN6h7DZLrizD+mdHvu7hmLyZmSvQCZfWIyj5H6m9QLDxKYmRAOQkZw/WuIZt3z2XDB
         WgCx6AlKc9scIS4pJNr2Nou5hwE0FNnddY5pRnEBLRw0g6XnPghrMME1MyPbefANUcNH
         zneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768520134; x=1769124934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sd5u1m4hBvY3ac+Xo0S7P6bC5jfOmx5rGLi7Jyx41H0=;
        b=H8SRO9x3mdWX2oDWs+J46ZTR1qcPQfRn3Z5xZB8Nb6VqQVZSJ0Ejzzee5q9QJkDiM2
         Z2fOUsWwgoKDLiD0yg1yKT8Rze2oMyteIFBq7tnpELomcNun6QixAwNwcKk/uMX5sSn3
         tGcPaKkRhlCgKfeWCM7JktXGf6FqhhvJ65T9lr9NajpTAarigmneHOARyj43/6svcEbD
         nIa50CO6/317XK7ygRxX+DljyCEuwbyD8X5ablbqcLkLfPryPNSkiUjMiEku+Bvq3DQ9
         leZBej6lNl74zPtadzmaLlfIgA4Hf3Y09fxDjLkESdS4xOJYUBMA0g/JTe3b7U5mK6+v
         xh5w==
X-Forwarded-Encrypted: i=1; AJvYcCUyLJGOohTsvU6X/L1au+1BcrzhGRg6Y9xchmpG1tmOg3WDZnbSCSaPJkSEwkKG3yeyZvdLU6Kg9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9v6lZauRtzMG8whNmIId07hPMkAhU3wLTg7PdgzWS7b6sULRK
	w6nRDKIne7g7KhrjI83c23Xhqm5TJAlSx1qxr2nGbG64mtv3JFfiX+3XVs2IH2Z5tYV+LzlDkT+
	6vM0mXmVqYe/6cX6gb0x8vxLKrxoTDow0XrPK79fc
X-Gm-Gg: AY/fxX4G3NBLCwuDXk1fj1s7OkgLdR8wDDG9nWSETk6bMw529ootoaqxrKC71cmvas6
	+YvvO4lvVxUa5Gym/Ainwthz/Cx3zkuXqPSnpol9Azq922mS3dmQAiYFafXO6yezwvu0Kbxvu7/
	3wsCFCY6lhqCSjHiclh78U6gSkdtifyNUFKAYz+Dro1q0v1fDr/PlPqdLqODtQPpwlez0OvJksT
	w3pNAjIC5fCWK40NU4+XIQ3RRBcJAWxcuYmzWBH5OwYBAOO/QQL3nWly3TZBu0FsjKNzlSR2A6S
	0DwqZO61HVO9GMbXBJ48/K7cyg==
X-Received: by 2002:a17:907:7ba0:b0:b87:701d:341a with SMTP id
 a640c23a62f3a-b879691c97dmr60702466b.25.1768520133853; Thu, 15 Jan 2026
 15:35:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201202437.3750901-1-wusamuel@google.com> <20251201202437.3750901-2-wusamuel@google.com>
 <f28577c1-ca95-43ca-b179-32e2cd46d054@arm.com> <CAJZ5v0hAmgjozeX0egBs_ii_zzKXGPsPBUWwmGD+23KD++Rzqw@mail.gmail.com>
 <20251204114844.54953b01@gandalf.local.home> <CAJZ5v0irO1zmh=un+8vDQ8h2k-sHFTpCPCwr=iVRPcozHMRKHA@mail.gmail.com>
 <20251229165212.5bd8508d@gandalf.local.home> <20251229170021.71cc5425@gandalf.local.home>
In-Reply-To: <20251229170021.71cc5425@gandalf.local.home>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 15 Jan 2026 15:35:22 -0800
X-Gm-Features: AZwV_Qjrxjv68dd8vV8YximCsepNvBfmIJ1YNLb9adYYh_EA_LMsFGVBQLimKwc
Message-ID: <CAG2KctqvAKUYwWex=8vDeMvAaDEUJ0D4gEoAZczapnpeM5p-SQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq: Replace trace_cpu_frequency with trace_policy_frequency
To: Steven Rostedt <steven@rostedt.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 2:00=E2=80=AFPM Steven Rostedt <steven@rostedt.org>=
 wrote:
>
> On Mon, 29 Dec 2025 16:52:12 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Thu, 4 Dec 2025 18:24:57 +0100
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > My concern is that the patch effectively removes one trace point
> > > (cpu_frequency) and adds another one with a different format
> > > (policy_frequency), updates one utility in the kernel tree and expect=
s
> > > everyone else to somehow know that they should switch over.
> > >
> > > I know about at least several people who have their own scripts using
> > > this tracepoint though.
> >
> > Hi Rafael,
> >
> > Can you reach out to those that have scripts that use this trace event =
to
> > see if it can be changed?
> >
> > Thanks,
>
> I got a bunch of "Undelivered Mail Returned to Sender". It seems that gma=
il
> thinks my goodmis.org account is now spam :-p
>
> -- Steve
>
Hi Rafael,

Bumping thread since it's unclear if Steven's email has gone through.

Are you able to reach out to those with the scripts using this
tracepoint to see if they can be changed? Hopefully this update can be
proactive, but I'm optimistic even a reactive update would be
straightforward.

-- Sam

