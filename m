Return-Path: <linux-pm+bounces-37191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDEAC2556E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05293345EE5
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61572D3A7C;
	Fri, 31 Oct 2025 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQQwEpWW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F726B96A
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918488; cv=none; b=MHN/FebyupvnE8C9UVM5AqmT4rSe6/qh0lIYLcTVmXgEVOqUGuvp1REPXHzuumruhFyI47ICUoFfjCE0EWTh2zeZHgWM6jLRFO2Ty7t0NKHfmJ30hqLcylxRFt9vrbh+lKX+SSprcQP3/YR9FmKIuZfVBgkjVBJ8qmWzKHvkGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918488; c=relaxed/simple;
	bh=m4d0TEVEKPm8SxpLnu/gK8YS9LXAMy6B2RvDA6hQIcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhUDoYBuwvt90HH6tza82eT6OMWz3lWUXZvmH6zk4C2WACXXL+M8uF6Js87ZcvSR0CgMibTW/Ga6RdFRt6B++fmjnfcjRcJbZKkIZ9p0G2rlZRDB6Ff7tyXUe8SKxxawsoLJtIHCgi+jwRDZXVRVLh5SVhx7ZLkILphML0XijPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQQwEpWW; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63e16fbdd50so2174411d50.2
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761918485; x=1762523285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9IKMsypE+yNRUurFmetSHUW8DIToelSK2hDWwm/+SOg=;
        b=eQQwEpWWCjo3DTyh7AnsJMlLnAE1zTc3nR+9purxkZvLfKTFuDBKqYxGW/GhA4Quux
         GAI6VSbsr0AtZKEkRm+CUCsTGaQ9zBLRfo+1bDHtIHO9zrSdag1rX7wcIyqhIi9GcdM6
         NoPzD7DkF/qLMBQZApBj1Zf5lW6m71AZ3Hju+ws7IUnqLAnB3fyIwlR6Z7/VkC5ILwtI
         yyYICYUEKGGLL7787t66IUE2/y8BMk4nN4+TNpLJqBKiEhF5Fu2JsqO4Bnp0vpXMgrhx
         ltBvCWGD9wNXm1xbAXVkxReLEwIKM5ClE+5ENYSWG72lMXcdBeJFeO5lJQ7bI1/eKkN5
         z4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918485; x=1762523285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IKMsypE+yNRUurFmetSHUW8DIToelSK2hDWwm/+SOg=;
        b=NmTV08Svw2B6ukNGcAX5B/CcDt6OElhk8yyL32hWisZUf6l3/0XsCRgaEemGReXB4G
         cOyo/99LqO7fPfI6uB4zU/sBtt4W0NS5V2UflY7UK0Zqfuh6QFVFnvfCaHnarDDkONyH
         T+4haY23v7N3b4SE0MgOACIX1zrvcooSCqIe+j/Mes5CwcJm+BsmzUgB3zREHKm+2/ug
         0eVL0znnqhpylGC499kDrHZEVT4r95Ucb205CYX+HitiQiVtkV+ZJ0UkH1WuinE9g7I0
         JOdkbop5gFavh36VQMwfR2OIwyuYUKs7l7mSaHXyjERSz621kTJUfhEL9ZfZ5M0j2AjW
         bwXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoky8j1nC4kirskVwmzJr5ss5f+eviGYp3XYWEkO+jXkz90Vhbxvppi/GC/mIewN5hKgspEXW3GA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrGUW8mrhRn8NL5KaiCJ1O8wN5LKN5rS456z+mTfdVomsA2wx
	nLtOst4KZSoCOMRaqDlNqgbzonYqgpf124EfT6ednKxSRflS2i8gFirj6CoXnCG4ACQVu3FSwJU
	2OoNFhL/1HsSgZEaFiEgshbrCA3BIiHD0iQv7s7US8Q==
X-Gm-Gg: ASbGncs2Hr3Jb79FhYxAYCw/Req0GBQGRwttipu6AhdcNFBQA//qM/+QTkEXPXVfO/j
	uutzqjvHos7drBBoxBKYDGuQiQlFbJyTMwISsxU8vVTE7LFEZL1+Td0ajrs6DjpymbnEpxAgSBU
	+x+3Tnqi1D8yBDdrKoMX09Lw7+LtKIfJi1i3aLgVCjtFSowYEiNIFZlxnQ3KxkQQugJN8HR0LTq
	pUZGVA/nGMusuWRwDJKUzzYBbOu7/g7M7O6Emlp0j5a6OmsC9cyyz5J6pPvYw==
X-Google-Smtp-Source: AGHT+IGVcGqzFiIeaGUMTxGjSBMNFcrT+skyvR/Zq38w4b0meGhVP0vyEmyQ6O9HNiJoistD3h5W4kD1DiETyutaiP0=
X-Received: by 2002:a53:d018:0:b0:63f:556b:5b6 with SMTP id
 956f58d0204a3-63f922eff6emr2519034d50.39.1761918484805; Fri, 31 Oct 2025
 06:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-2-ulf.hansson@linaro.org> <20251029081014.443psmqznd2pqm4i@lcpd911>
 <CAJZ5v0gcRQgj-3Yve_3OMsRJppdVmtWpBq51H5dk3JgTvSGLZw@mail.gmail.com> <20251030164542.atnhs4wgk6ggmmly@lcpd911>
In-Reply-To: <20251030164542.atnhs4wgk6ggmmly@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 31 Oct 2025 14:47:29 +0100
X-Gm-Features: AWmQ_bkXYtLkHgQjUQNJqO9va0xDnvSagkeSDoJ8ysCheRg4L2MKvBY7iRS11PA
Message-ID: <CAPDyKFqTS6-69QfqdPtRrbkSqwxEnO1CPXLnRvM6WsOKNZgyQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> >
> > > It seems an overkill to me that a userspace program be required to hold
> > > open this file just to make sure the constraints are honoured for the
> > > lifetime of the device. We should definitely give the freedom to just be
> > > able to echo and also be able to cat and read back from the same place
> > > about the latency constraint being set.
> >
> > So you'd want a sysfs attribute here, but that has its own issues (the
> > last writer "wins", so if there are multiple users of it with
> > different needs in user space, things get tricky).
>
> sysfs makes sense, then would it make sense to have something like a
> /sys/devices/system/cpu/cpu0/power/cpu_wakeup_latency entry?
>
> IMHO userspace should decide accordingly to manage it's users and how/whom to allow to
> set the latency constraint.
> We already have CPU latency QoS entry for example which is sysfs too.
>
> >
> > > One other thing on my mind is - and probably unrelated to this specific
> > > series, but I think we must have some sysfs entry either appear in
> > > /sys/.../cpu0/cpuidle or s2idle/ where we can show next feesible s2idle
> > > state that the governor has chosen to enter based on the value set in
> > > cpu_wakeup_latency.
> >
> > Exit latency values for all states are exposed via sysfs.  Since
> > s2idle always uses the deepest state it can use, it is quite
> > straightforward to figure out which of them will be used going
> > forward, given a specific latency constraint.
>
> I disagree regarding the straightforward part. There could be
> multiple domain heirarchy in a system for eg. and all these multiple
> domains would have their own set of domain-idle-states. All of them having their own
> entry, exit, and residency latencies. I myself while testing this series
> have been thoroughly confused at times what idle-state did the kernel
> actually pick this time, and had to add prints just to figure that out.

If I understand correctly, most of that confusion is because of the
misunderstanding of including the residency in the state selection in
regards to QoS.

Residency should not be accounted for, but only enter+exit latencies.

>
> When implementing these things for the first
> time, especially when one has complex and many a domain idle-states it
> would indeed help alot if the kernel could just advertise somewhere what
> the governor is going to pick as the next s2idle state.

The problem with advertising upfront is that the state selection is
done dynamically. It simply can't work.

>
> Also, I am not quite sure if these latencies are exposed in the
> domain-idle-states scenario ...
> I tried checking in /sys/kernel/debug/pm_genpd/XXX/ but I only see
> these:
> active_time  current_state  devices  idle_states  sub_domains  total_idle_time
>
> Maybe an additional s2idle_state or something appearing here is what I
> was inclined toward.

That sounds like an idea that is worth exploring, if what you are
suggesting is to extend the idle state statistics. In principle we
want a new counter per idle state that indicates the number of times
we entered this state in s2idle, right?

While I was testing this feature, I used trace_printk - and afterward
it's easy to digest the trace buffer to see what happened.

Kind regards
Uffe

