Return-Path: <linux-pm+bounces-38009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1738EC5B2EF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 04:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4237D343ABA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 03:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947AA2522A7;
	Fri, 14 Nov 2025 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oU/My/0s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708E225485A
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091684; cv=none; b=lvAfKnr/hHjre98BpKDVWUjKq0g8Mr5L4hGHVBLx62IkXZG+0LbRWwygS5Zfd5wnWTyDCDZdh6e44nIKEfPfMYJPj59VWwJIVjV1URXTB1G5FwVit/t85Ss1tys7CtpyPNf9nnob25SPYBZuUaclmepN5mXn8e1jjTz8gi8suRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091684; c=relaxed/simple;
	bh=ryJkv6CXUDKCnzbHfLI8c0ggVF219LhtAYHK8re9Da4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AohVJ5mtQ9orZdk5Lm4xHwnZEZI9EloAv7A+4uDzDQzNVYTys+YEmvhs/AMWiVSfuCZMX/640KdFjDWOC11LtzfKa9aYEWirARtjoW7CPTlHzSEPaLnNc7suCKHax59GOHrvcNtIovl1ihzwMgfLkvX0Is7/6BW3NULxVixbQg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oU/My/0s; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so2562322a12.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 19:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763091680; x=1763696480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFUX25scWe0vWdivCC/Z0SNCPDsp372FpBWwsDMucuc=;
        b=oU/My/0s0O42L35BHoyhQnU2rFUHBQY8UCJn2NYeobFnWdGJVE+8+FAQpu/Gs3L/Uf
         Dq35K5jQauFtGjGzj4cske6Hw9JkdkT2d7BnnK9/Uyyp1k4IHyqqaRhYdpkEJ1xbZupl
         hDfvDChzLIE6S7WxIZ9MuCiZAkSPtcQqaj8KGMksvotAs4UH1fk06FFb7ylxot5c9nZH
         d7Cz/97VZcA7E/S6MwDcNPIti9hewaV1C//HHumyNX9RXPE2EZFlsfREWojJSiU+DPyY
         oV4qsHPWMH6EGz52UwvyWz465zZjQIH+/+6vbBJr68mrhBHbXszmcXKjBCxCteUL3154
         jGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763091680; x=1763696480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YFUX25scWe0vWdivCC/Z0SNCPDsp372FpBWwsDMucuc=;
        b=j/JdCFWgShkdJAdVgtz3g7tQzVkVyKQqyopBOCBv7bc63vYtIfF9Ayid5jNNDluuAq
         BvWfIpO0nCz0HkYQEwaqsHrF89OyD4Y3VW1fp7vZpDYycWhjMOD+210Ypgs3AAETiEpm
         fAuI+mPKnYgLuzpzH6GBoR0ituSUQjgZK/9+M1WdpSpd6F8zogcKaIT3TDvMJuVzsY4D
         /zZrBZLAfEm8dsZha+DQGdZ91HMGkbFy8eiISFJqHTY4P3RseZCL13fx3oGxqE4imYpg
         G3m7sNnTxC5vm58mbSGL7tmKf5HUDTW7NbnwBOmXlG6gonz87v0FtY/GB6hofSVwIMms
         XmWA==
X-Forwarded-Encrypted: i=1; AJvYcCW6vtcWpBJUYfBPf6zCideMlLQ+Ye5XmnEIUmrSvutN0ECvAcmQHti0jA0jO5YItsdf4WrP4xlIZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzddwWmyWDJw31PEqB7cGbFKeLyDWPpDDdydUNFOxC3ZfATyJ
	lP/J2k2cagI4hCl+971CZJDXOIldN49tsfVVj6eOjedn34liy967JGZV+II7hy0LnCNlx7jse6f
	Kk1SgfieMwj3X4aky+oJuDWv3Ch9idepPJRV+KUax
X-Gm-Gg: ASbGncvKStuXqcG2/Us8UzVdqcbfhFUfLm6JgIA0qqfvTFt+RvvgbWgBqt16+sglF+5
	zm1x7GB0ltz6FI5LDVPk3mRgD4vnmWvXS0K5scnAMcZ3jUqJre838n2wIPCpRQLQQbNTIUVEZYp
	iApCTCyj/27NuomjQBhTHnlPYKGOVv9NUn9yMBp4TOQGSbiJLzpDeHc7rU6jlIYOxiScjDhbFv8
	MvuMJqOLqvhcndj+uKpmG2eHsePYLC2sc5iHCqWMwj9qahYpXGkgqRaMfQ/z9Gq+RANpjbpRocS
	BsSBxc8Smy5nHs5g2ClNdNWfVKYP0acpZMBrizxD
X-Google-Smtp-Source: AGHT+IGmXN37NYT5nX9MWTZ/ivh8suRrsT+5MxYlLyGC4+Nt0tPCfIkeO2/qFDCy4N9OVfYMnqUdZ/BFNm6d4PNTQsI=
X-Received: by 2002:a17:907:1c27:b0:b73:3e15:a370 with SMTP id
 a640c23a62f3a-b7367c001f0mr138833066b.57.1763091679591; Thu, 13 Nov 2025
 19:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112235154.2974902-1-wusamuel@google.com> <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
In-Reply-To: <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 13 Nov 2025 19:41:08 -0800
X-Gm-Features: AWmQ_blsgnIrclDDNYVJmf-or7MAjMfT_RTSkXh139GCK3aWgRLgaKjVarod070
Message-ID: <CAG2KctqdJzhaC4pRG9rAgteVKHtKsA8Y7=_MHEUCCeBBhoejWQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: Add policy_frequency trace event
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:45=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 12-11-25, 15:51, Samuel Wu wrote:
> > The existing cpu_frequency trace_event can be verbose, emitting an even=
t
> > for every CPU in the policy even when their frequencies are identical.
> >
> > This patch adds a new policy_frequency trace event, which provides a
> > more efficient alternative to cpu_frequency trace event. This option
> > allows users who only need frequency at a policy level more concise log=
s
> > with simpler analysis.
> >
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> >  drivers/cpufreq/cpufreq.c    |  2 ++
> >  include/trace/events/power.h | 21 +++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 4472bb1ec83c..b65534a4fd9a 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -345,6 +345,7 @@ static void cpufreq_notify_transition(struct cpufre=
q_policy *policy,
> >               pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
> >                        cpumask_pr_args(policy->cpus));
> >
> > +             trace_policy_frequency(freqs->new, policy->cpu);
> >               for_each_cpu(cpu, policy->cpus)
> >                       trace_cpu_frequency(freqs->new, cpu);
>
> I don't see much value in almost duplicate trace events. If we feel that =
a
> per-policy event is a better fit (which makes sens), then we can just dro=
p the
> trace_cpu_frequency() events and print policy->cpus (or related_cpus)
> information along with the per-policy events.

Thank you for the feedback Viresh. Fair enough, I've done some testing
and a single trace event should work and would be cleaner. Please let
me know what you think of this proposal for v2.

We can append a bitmask of policy->cpus field to
trace_cpu_frequency(). This way we maintain backwards compatibility:
trace_cpu_frequency() is not removed, and its pre-existing fields are
not disturbed.

Call flow wise, we can delete all the for_each_cpu() loops, and we
still retain the benefits of the trace emitting once per policy
instead of once per cpu.

