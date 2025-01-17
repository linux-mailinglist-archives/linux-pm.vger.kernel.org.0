Return-Path: <linux-pm+bounces-20635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC7DA1532F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCF77A2B35
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9686199939;
	Fri, 17 Jan 2025 15:51:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7317FAC2;
	Fri, 17 Jan 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129086; cv=none; b=WLRrCXJ94/uT5LI3cxr/LC4pD4LeZlQMXSn1g9W+ud18PhbOh38G5bq3TvIcWpYM4WCaI4HuLHgKvABlFYe8AFb8i3EiU7mV5ldew743oZhC2wdpE6ZzF2oZpNYv0wi4zvYHK8RCYHyq13s9ulwEjKc6nWxQb6+88wZE4dDPJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129086; c=relaxed/simple;
	bh=ecR46qWk1nlZTdF4ABcjXQYtIDzHBLhkIIwyRnBugZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSyjOY+srSy1xe/XU9jiCnjc1rbD24UBpDV2uOWfpsfp3RoxEe4ctUgirPhh+6AssftRQ/GrlsCg/yt5K8EzJM4XCLIqGh7d2v4YryGCJOmBrQf9HiGNWEAlihYVDa79SoHYb/R9ihJKZPbXCOnRyaEdq58J6RHBn2CND02xST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC42CC4CEDD;
	Fri, 17 Jan 2025 15:51:24 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:51:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Keita Morisaki <keyz@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lpieralisi@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, aarontian@google.com,
 yimingtseng@google.com
Subject: Re: [PATCH] cpuidle: psci: Add trace for PSCI domain idle
Message-ID: <20250117105132.4122940b@gandalf.local.home>
In-Reply-To: <20250117040132.3237808-1-keyz@google.com>
References: <20250117040132.3237808-1-keyz@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 12:01:32 +0800
Keita Morisaki <keyz@google.com> wrote:

> @@ -74,7 +75,9 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
>  	if (!state)
>  		state = states[idx];
>  
> +	trace_psci_domain_idle(dev->cpu, state, true, s2idle);
>  	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> +	trace_psci_domain_idle(dev->cpu, state, false, s2idle);

Why not make that into two different events:

+	trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
+	trace_psci_domain_idle_exit(dev->cpu, state, s2idle);

>  
>  	if (s2idle)
>  		dev_pm_genpd_resume(pd_dev);
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index d2349b6b531a..82ad8bb1c477 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -62,6 +62,31 @@ TRACE_EVENT(cpu_idle_miss,
>  		(unsigned long)__entry->state, (__entry->below)?"below":"above")
>  );
>  
> +TRACE_EVENT(psci_domain_idle,
> +
> +	TP_PROTO(unsigned int cpu_id, unsigned int state, bool enter, bool s2idle),
> +
> +	TP_ARGS(cpu_id, state, enter, s2idle),
> +
> +	TP_STRUCT__entry(
> +		__field(u32,		cpu_id)
> +		__field(u32,		state)
> +		__field(bool,		enter)
> +		__field(bool,		s2idle)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu_id = cpu_id;
> +		__entry->state = state;
> +		__entry->enter = enter;
> +		__entry->s2idle = s2idle;
> +	),
> +
> +	TP_printk("cpu_id=%lu state=0x%lx type=%s, is_s2idle=%s",
> +		  (unsigned long)__entry->cpu_id, (unsigned long)__entry->state,
> +		  (__entry->enter)?"enter":"exit", (__entry->s2idle)?"yes":"no")
> +);
> +

Then make the above into a DECLARE_EVENT_CLASS:

DECLARE_EVENT_CLASS(psci_domain_idle_template,

	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),

	TP_ARGS(cpu_id, state, s2idle),

	TP_STRUCT__entry(
		__field(u32,		cpu_id)
		__field(u32,		state)
		__field(bool,		s2idle)
	),

	TP_fast_assign(
		__entry->cpu_id = cpu_id;
		__entry->state = state;
		__entry->s2idle = s2idle;
	),

	TP_printk("cpu_id=%lu state=0x%lx type=%s, is_s2idle=%s",
		  (unsigned long)__entry->cpu_id, (unsigned long)__entry->state,
		  (__entry->s2idle)?"yes":"no")
);


DEFINE_EVENT(psci_domain_idle_template, psci_domain_idle_enter,

	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),

	TP_ARGS(cpu_id, state, s2idle),
);

DEFINE_EVENT(psci_domain_idle_template, psci_domain_idle_exit,

	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),

	TP_ARGS(cpu_id, state, s2idle),
);

And then you could easily attach synthetic events to them to get the
timings and such.

-- Steve

