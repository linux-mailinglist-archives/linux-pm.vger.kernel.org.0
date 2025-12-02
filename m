Return-Path: <linux-pm+bounces-39036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E7C9A5DC
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 07:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5950345EC6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 06:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274463019C2;
	Tue,  2 Dec 2025 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cumvfgwy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73452302CAE
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657825; cv=none; b=FVfu4iJeh0Nsg2pgGqamjysh1kut6pgZXy9UOg2AKinmSv4FonBDxr51AVyFwjO3SffWlPWWRsJl4DSri+naInIxBVHNZz7FykeUCkzX6JQAJwkbpGfiuiP5uJ2mZnnBBteqXoP8qb0ApUGLXQoAv9S6aAokmr4rKsITofOcApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657825; c=relaxed/simple;
	bh=Jf9gVgouUS6WA1WmAKl+iapmoVqz/JtN0fwXRs+b4qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZEg4h18kGe1eRG7c6EXs/PgOiY7RQxlTJsyjeHPJ2on6cqgRhhAN2raAHSCJfOB70KfM2Sok+uXDZ5CBPzZEDUsji2aR1zdRnxfH4GT7q6lGav5dfF09L7qhWQtyJUFw2Mb/bNkQYO8eDm0E92MxrECxircxgDrdg5vGHPUEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cumvfgwy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297f35be2ffso77056405ad.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 22:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764657821; x=1765262621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htyZzDjpItfBeC/qRXvnJ6nxzkqeSejC8MJ5WVXPcQY=;
        b=CumvfgwykknWCLlGYfxl+aWzXM+wsXYC464qBApiNydWyo/GCG1/7RTtXpXKc+dHrx
         991hAxia7u5AdoccVPsITEX81DXNJZiWLee1gga39SLmNdYh4wvcwVEe6YcYHtDNtmk/
         UhEl3Wa2dAa4we0KkOidLr8rkfrEcU/r/iLX3OS3+dXn4CjlZkw941vAi4dUsmagCMCC
         V3DpQQ/B5cYX8ef5Niy23jwcZGhwC+6mMHvo1IYQVKF8Rl7CqQpTtt5KZ+Ao0Nov0Pj/
         Z2Yd2aCcCtCkf3hZ7KuZbH8rzgvwo5tk8Q23Ip+T/rn6ftht8h1Qxp91cAuTVcu6RQJ8
         N6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764657821; x=1765262621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htyZzDjpItfBeC/qRXvnJ6nxzkqeSejC8MJ5WVXPcQY=;
        b=qr+wnGdDcBXcOCbGAj8oJAiqtt6kx7WSVOE7iSZ2AbbEnTkgieDfI0vwXUcmjuNHnS
         SSUHi2qD+X3TMue6gYyAjTZACmWuNkCsv3N1mMdoavjXOM5vW4BU6hnj7mUmDmFs/lNE
         0nCm6E9Cz63W22Eka6q4CLAObPqiNRWq9lcDvvDlTaoHz/azr+AZLz4nB8oPlJwa9gnH
         vEjsAfnr0+DL2TtnrfMaTA/m+yU7wbd4nwT4MqV6wJo6cu+ilCutGXI0ErX1rI1XRfca
         F/0uRQQcrRlsl6cUz3cvLFX9mNUJX41dGYGpOeTbphJs72z/qEpm0gZ8YQDWsjqffkDK
         XNTw==
X-Forwarded-Encrypted: i=1; AJvYcCWqFKDVT+1UnMOkPhSto9KBZhdmfdSoDnDDUhdjqhgGF41cQUWW4fwS/U/ehKJO5aIa2x/L+YIyKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/y/xMTIeo3OyjJ7dxS11uc/iR4rh/bNBJh274VXDEoOBGb71W
	zIoKs27gtqCnxeTpzND6VEMUwX7r+wxycyXLAc+nELPQroaq2WEHwFEhU1JfWEaL4T4=
X-Gm-Gg: ASbGncsgz753skDxo7Qa/R2G8O/wVd9aYgiQFOwiguFz48hc8P1XTMuw+QJsj0Uhjg5
	vtEdsj4BNk/D5TjIMqejrD0ULfafMo0EauTlatcsI6nm05whF05sibqSji4xZjKgWCPfqDL7nIT
	/kyjp+UeSNqBuOeczqlWI/ncQTxe1nw6PGdNI9kwJbZheBQRHEz2qo0FuA22niyla+O/DEXIn9i
	ABih2z7C2zzl/SuMZqwD+VDeUUg57Ehb6jAsu2E8PmPKB+v5mwaxyi51ZrRuy3NoBIIVt4W5NMB
	vfMRZIMQZXLwmERsYfeAyoc8QgrzQMyB3p5i4UyH0m/h4AekSt7+0NDOEbQqXckhXxEU4IwDoht
	d7CM/DOxsP22Cx7NHDk0ZforHZ55lccHleFVFreQsQp30CUqQVVZshS1Z/M7A+lB5yTG01U4yUh
	pM91JjBpxWDByM0a/jKLc3bA==
X-Google-Smtp-Source: AGHT+IElB/55iOL3pFkt4jDnVftx8SMwzLAFev+IFE16AlTrASn4wJp/yshPqxy/pYWD5aWdbmoY1g==
X-Received: by 2002:a17:903:2b0f:b0:297:e66a:2065 with SMTP id d9443c01a7336-29b6c6d0d46mr435400315ad.56.1764657821143;
        Mon, 01 Dec 2025 22:43:41 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce4418c4sm139899275ad.24.2025.12.01.22.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 22:43:40 -0800 (PST)
Date: Tue, 2 Dec 2025 12:13:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Samuel Wu <wusamuel@google.com>
Cc: Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, christian.loehle@arm.com, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Replace trace_cpu_frequency with
 trace_policy_frequency
Message-ID: <inifvm4pxifvdazsfyi2ppzfwum6ukzujx5sfiux4s2iv55z4p@otoaj35vr47c>
References: <20251201202437.3750901-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201202437.3750901-1-wusamuel@google.com>

On 01-12-25, 12:24, Samuel Wu wrote:
> This series replaces the cpu_frequency trace event with a new trace event,
> policy_frequency. Since by definition all CPUs in a policy are of the same
> frequency, we can emit a frequency change per policy instead of per CPU.
> This saves some compute and memory from the kernel side, while simplifying
> analysis from the post-processing of the trace log side.
> 
> Any process that relied on cpu_frequency trace event needs to switch to the
> new policy_frequency trace event in order to maintain functionality. The
> decision of replacing instead of adding the trace event is intentional. Since
> emitting once per policy instead of once per CPU is anyways a semantics change
> that would require a tooling update, the trace event was also appropriately
> renamed. The presence of the policy_frequency event in a trace log is a clear
> and obvious signal for tooling to determine kernel version and which trace
> event to parse.
> 
> 1/2: Replaces trace_cpu_frequency with trace_policy_frequency
> 2/2: Corresponding documentation patch that updates references to
>      cpu_frequency with policy_frequency
> 
> Changes in v3:
> - Resending v2 properly (accidentally ommited cover letter in v2)
> 
> Changes in v2:
> - Replaced trace_cpu_frequency with trace_policy_frequency (per Christian
>   and Viresh)
> - Updated references to cpu_frequency in documentation with
>   policy_frequency
> - v1 link: https://lore.kernel.org/all/20251112235154.2974902-1-wusamuel@google.com
> 
> Samuel Wu (2):
>   cpufreq: Replace trace_cpu_frequency with trace_policy_frequency
>   cpufreq: Documentation update for trace_policy_frequency
> 
>  Documentation/admin-guide/pm/amd-pstate.rst   | 10 ++++----
>  Documentation/admin-guide/pm/intel_pstate.rst | 14 +++++------
>  Documentation/trace/events-power.rst          |  2 +-
>  drivers/cpufreq/cpufreq.c                     | 14 ++---------
>  drivers/cpufreq/intel_pstate.c                |  6 +++--
>  include/trace/events/power.h                  | 24 ++++++++++++++++---
>  kernel/trace/power-traces.c                   |  2 +-
>  samples/bpf/cpustat_kern.c                    |  8 +++----
>  samples/bpf/cpustat_user.c                    |  6 ++---
>  tools/perf/builtin-timechart.c                | 12 +++++-----
>  10 files changed, 54 insertions(+), 44 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

