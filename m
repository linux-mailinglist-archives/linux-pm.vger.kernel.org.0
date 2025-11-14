Return-Path: <linux-pm+bounces-38012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D7CC5B5ED
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 06:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E00A4E5B01
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 05:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF8D26E179;
	Fri, 14 Nov 2025 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2d7BQOp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C32D320E
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 05:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763097069; cv=none; b=d1uRi140yMcUNos9fjBP29h8wIbJHm+6fOEtDJRZiApiLT6cR1GFNWCBpWCQF6FNxemATHDXhUaFYPkcKlwdqSCnes54CK64sB+ePogj+9drqIxcDYwBlxoP9bnGmSYOd23yXi+k5ipCJ4B9ppnZ2llpiYYdBXq+uaqFjf/U4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763097069; c=relaxed/simple;
	bh=VDRfarJF+3U5Aetyq0P+8gmVWOWRsfQtOVKokJa2PRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8db8HHA3TO/ofa5gASlhUcnlDBPw+0SRi0qPXQ/yMyZ3XzfNkCboGDBM3SIhJQ+DjgGpzNbbhZ8A9gvvQO8VH6FkvCwZn1dxU6pEfiOxMUg6GRoBjZwvUyb2QkOJlcgxPuw4PMsW/+HRo9BJEhyMrB5dSW2vDYkhU91xLESmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f2d7BQOp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2953e415b27so15129555ad.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 21:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763097067; x=1763701867; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SsBGcCiz3WCLrT7j0Nta57r0BhtlxHqhVrvzURlT4hY=;
        b=f2d7BQOptmnbAMamPzNdKpp3djS5Dxc1G5d09XJuNi8TKKnzUjPr5/hjVpTSJOv16l
         V2FlpJvHaJDCBJHZ0cIvP0eadjcvtAOpHx5uP6csAC0eLr4kSdFE1Rin7np/KgBuH36a
         B8jALDJcadAQaHmO/1es8JrA24DhRf9pSiB0dLBtAlF4Vl4nhNx1PQbfedLe2ozspsst
         omM7VMFkMUf8J55o43f2y0IUEOhavvtFKQ6TpklLQskPmohHd9c/KIL1x0bc6Ta4bMCS
         KrqOmxVXj3HamPAkgckumuV4SjDXN4bQQzNZiEaoIZZ8maWpn1KIoqAfFD8VdOKfeiyH
         j+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763097067; x=1763701867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsBGcCiz3WCLrT7j0Nta57r0BhtlxHqhVrvzURlT4hY=;
        b=ctcn78bnazIqwRb9yAc5P8banN7t3yw68xja4bIMxspf/0IY/C0EHahrMRH9VHqfjn
         1BXK0eM+eCOZlc1FQQg2L4DAJTkkozmBa2WxnF9bYRfxKtolkuQUTCWgwVLqngb7wAsO
         SrsfgY4+6a09gpvcj6PGUHXO1Wdh1aLs8Btl5U4v0BzvzKBu9cm3ignX2aTf5rGyFueX
         jGXKjt9xYA2Y2Il4rixmJSF4FXLjld/qiY3SonYlM0R7+fTEvIUoCsNTWoFHe2wJ6Yji
         1FdrnqqJBcbUZV2MnVJnBxUHD3xLFTWYMEta2paozEnhRfxJRKdVP3/Yi6XSjOMs81em
         hQMA==
X-Forwarded-Encrypted: i=1; AJvYcCVNEwqphBvSaWGFC/bSDlEsZ8PdwIjXZDBQQQSsD6bzwnuHNuIrlHo9OyQEyYScSgAh3C5T/bpK/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5FzQgY6N+XTlRiMPBWYl/5VmqvpcIrTYNtOU1ZOcMI8Lslua/
	9aDAOiNgrOosROJP+q8AgFdys4nsAk5g0qOeOTeo5ImUqmoJ184pYLWDuPjOBR1r2l4=
X-Gm-Gg: ASbGncsUzBctMLCZRRUFID2UxdhQhtJsU2lf14EkI5Trj1Yettm0vOBtK/jXHjiFxPu
	zVzx2YdMmQ0HzvKo8DStS00/mh8aanEfu83uCev2YQqiFTd9RUwVte3X2rxulnLqLaqs8cic/uG
	TfIqcPRqCdkDO8Lsa7W8IVHB8CNS32rN8W9GuDSCVEcsCRTooVoXjyMYctshirOYwx+3ygONwmA
	fe98bobIdSNTUSzkLJ8R9T/xMuw/71SJbGCCohYCoUPOH4dNq7DjVE64oF/rVvWxGRK6+BfP8J/
	Akoah+t5TZxdVAbDojJI4qpiCLaCCty2vkEm/5RKWiU1hHANlWqM4pRVI6K5gGhs1ZPxdY3lC8v
	0AERxbKLe0ehWhj3pHxJlYk+0/t29gLk5j98qL+zS1VUcWf/KsDtW9mVMnQOGVnqWMfYZwASvzH
	Q5
X-Google-Smtp-Source: AGHT+IHK3glqlR+Y94++dOJU6BWTmSCTX38wLmtdNb6tG6CAcPvZ3ICP81xPkge9KCI41/KwV9HdVQ==
X-Received: by 2002:a17:902:e84c:b0:295:9e4e:4092 with SMTP id d9443c01a7336-2986a76b624mr21805015ad.56.1763097066392;
        Thu, 13 Nov 2025 21:11:06 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b1055sm41351205ad.59.2025.11.13.21.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 21:11:05 -0800 (PST)
Date: Fri, 14 Nov 2025 10:41:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Samuel Wu <wusamuel@google.com>, peterz@infradead.org, 
	vincent.guittot@linaro.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: Add policy_frequency trace event
Message-ID: <5pv5tqf24p6ttpydpdegyhyod3m2hmpwbfrzl6otsq3q2gvb2s@gsgcgbcvin3u>
References: <20251112235154.2974902-1-wusamuel@google.com>
 <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
 <CAG2KctqdJzhaC4pRG9rAgteVKHtKsA8Y7=_MHEUCCeBBhoejWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG2KctqdJzhaC4pRG9rAgteVKHtKsA8Y7=_MHEUCCeBBhoejWQ@mail.gmail.com>

On 13-11-25, 19:41, Samuel Wu wrote:
> On Wed, Nov 12, 2025 at 10:45 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 12-11-25, 15:51, Samuel Wu wrote:
> > > The existing cpu_frequency trace_event can be verbose, emitting an event
> > > for every CPU in the policy even when their frequencies are identical.
> > >
> > > This patch adds a new policy_frequency trace event, which provides a
> > > more efficient alternative to cpu_frequency trace event. This option
> > > allows users who only need frequency at a policy level more concise logs
> > > with simpler analysis.
> > >
> > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c    |  2 ++
> > >  include/trace/events/power.h | 21 +++++++++++++++++++++
> > >  2 files changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 4472bb1ec83c..b65534a4fd9a 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -345,6 +345,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
> > >               pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
> > >                        cpumask_pr_args(policy->cpus));
> > >
> > > +             trace_policy_frequency(freqs->new, policy->cpu);
> > >               for_each_cpu(cpu, policy->cpus)
> > >                       trace_cpu_frequency(freqs->new, cpu);
> >
> > I don't see much value in almost duplicate trace events. If we feel that a
> > per-policy event is a better fit (which makes sens), then we can just drop the
> > trace_cpu_frequency() events and print policy->cpus (or related_cpus)
> > information along with the per-policy events.
> 
> Thank you for the feedback Viresh. Fair enough, I've done some testing
> and a single trace event should work and would be cleaner. Please let
> me know what you think of this proposal for v2.
> 
> We can append a bitmask of policy->cpus field to
> trace_cpu_frequency(). This way we maintain backwards compatibility:
> trace_cpu_frequency() is not removed, and its pre-existing fields are
> not disturbed.
> 
> Call flow wise, we can delete all the for_each_cpu() loops, and we
> still retain the benefits of the trace emitting once per policy
> instead of once per cpu.

Fine by me. I have added Scheduler maintainers in the loop to see if they have a
different view.

-- 
viresh

