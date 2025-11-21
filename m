Return-Path: <linux-pm+bounces-38376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDEFC7A0BC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1928534A5BD
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DC934CFA1;
	Fri, 21 Nov 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncI78LyG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E13502A7
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733613; cv=none; b=HjZPR8IhDbK9nSNBMn8JopN/gs6vSOkj/hYBIEOkkKoRvG0n1Xjd0i/beLFU2G3zL4SC3HUpBSlC1HqagoHiwdYz6BMD0vz2w/Bo0EnoYtQDnwdjsS+apwoorfaYZxcYwJtwKBl24ZsviiJGaKIhwESPwKc0RQFGUWzOBmu6cK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733613; c=relaxed/simple;
	bh=vU4pYHitsr0hiKsk/HUXzExLHhMPcEsJvVyAtRbwpjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6cJhDH1ihO1f0u7pkEP8U5KhMnxass41/wNImWUrjawQqd4aq3M43gB19YWk43x08CUfPfKKCt38JrwitZMeE5kFf1LDkJlmfh6BfGURg5lTs4wzW1dMAOpXrUIEu57+BeB0QuwHl5qR6ArLb7gL6WaSnZgpWQM3PUMnTOdSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ncI78LyG; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b73545723ebso385459766b.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 06:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763733610; x=1764338410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJL0FJVgKrnVFnqIMVj+hUZotuSnFwRiu+YmMsHAZn0=;
        b=ncI78LyGUPkXjIcDqOGuax6gRooZSEpqQd5UvkFYXhLn9ofour1wfe7DrYxMwKfEOv
         oRj3AG+7qbzs51/YO2UROD5fE+DUCM9obH7awX1ytWswQFJSmw7QRWHp2v2UVuKA1Dnb
         5/59YS0VeI5+pUuxKdo8whhGxoLUZLW8a9XdOIjbBlBecHPi3EyOCFH6mJ32MvUZRdb6
         nAs8TgiuurvfB6pSGB0UTxDRtDB1ljNIJdyml6UT6KiPIobNpB9okVzlKP+tvjpLJeZB
         d4NZh3yr++3mcA9b6qhSFZTgo/hO2ktpdjmyr9xQSfrH8dBen2T4Ff3wfd90MnVtV/bY
         +KWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763733610; x=1764338410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJL0FJVgKrnVFnqIMVj+hUZotuSnFwRiu+YmMsHAZn0=;
        b=OwApZgZXbG0FsXyvsFddzqDR3cqI5dsNme2ZkPAbxTL6+j4e7uEyuR6YA/So9cWBDJ
         +/0cbs6Ko0t8suRW6YECGmQq5q/q4y9SRE3z8bpAknFpjTrEnvXQqigJKWKh5+nEAIaH
         cB7oouCohLSdKDqocWHXe3fk2EAFKVyUO4kKP/kbnFQoN6qMhdRU6NM6ImHrQ9AqVT0I
         aKXzZOggk1dWBOMAl66RQ69AeYSzZ8/0QMWXkbbrq48WGlaVfXkSMotmYgLIw2n0/UOi
         2adkD0yJeX7H7ZZB5zat8G/H3ODViG+kGx6L4o1pmc1z4DCWIEwfK+4AGpTfOn9ksKNt
         QJGg==
X-Forwarded-Encrypted: i=1; AJvYcCWH6ioPLl7UTWTD31lrfv/MGFfhEDJ8JMRrGR/fuYZT922JXA4ZaFZp6WkDmCVkG0f5pHxR+QwuBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw541pnCP1CzBXM3jfz0Ojgvyy8GKi93UDQqQVmCDIPrJF7+n6H
	jPDaXNARu9Him92Ye4lnIyEHUTlhJSPHk3AHj3sO6n5Y1vGlyticKlt8VL6n3ip4PGQsebux02q
	qsMrjg48kUEQSBAKTiZ6Ck1W1iWLMv5EoY+9iRMi6+w==
X-Gm-Gg: ASbGncsZaQcCLXyB3XRj/zA0ZimRCNGWlRVmdOV3mNIJYtZg+nVMhQDhWdTqOHNEHxB
	LpB4PoZGGxcDqnGloLXoS/U6P7OU2snw3/3pP90LcasfWymZ6bO+FbjDg6QwdgUo7ubP04zDuA1
	/GJyA12O+DpGqsfHPnb4okF7BA1jLVPbkhW9QjXgQCLHs3YZ4pKVJPc1zOvFDD6CX/BfrdpAdSo
	3CicHrGTm1913/kTXn1HWig3sPuPCm/Vf+jZ7qkY74ejyT/9UM5vbs/baIRmPdnbbbyqrn5PXyI
	erciqokI0Z1Mfu+GdDX0WyBo
X-Google-Smtp-Source: AGHT+IFAnmvurUyPCUUptc+x0iNJfNhwaQBmwEu4uxZnrH0TRieIGTMUyHGeXO2SOgALfueMMABITJEJzG57A7u8Ohg=
X-Received: by 2002:a17:907:d05:b0:b73:6b24:14b5 with SMTP id
 a640c23a62f3a-b7671a47bafmr272081766b.31.1763733610141; Fri, 21 Nov 2025
 06:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
In-Reply-To: <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 21 Nov 2025 14:59:58 +0100
X-Gm-Features: AWmQ_bmM4o5Z3q1ve2PQdTw2QsE7ykHgVxbu8IqvT3a4hy7EoAQ4fqrzOXFlGbg
Message-ID: <CAKfTPtBBtMysuYgBYZR2EH=WPR7X5F_RRzGmf94UhyDiGmmqCg@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yu-Che Cheng <giver@google.com>, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 04:55, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi Christian,
>
> On (25/11/20 10:15), Christian Loehle wrote:
> > On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > > Hi,
> > >
> > > We are observing a performance regression on one of our arm64 boards.
> > > We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:

You mentioned that you tracked down to linux-6.6.y but which kernel
are you using ?

> > > Rework schedutil governor performance estimation").
> > >
> > > UI speedometer benchmark:
> > > w/commit:   395  +/-38
> > > w/o commit: 439  +/-14
> > >
> >
> > Hi Sergey,
> > Would be nice to get some details. What board?
>
> It's an MT8196 chromebook.
>
> > What do the OPPs look like?
>
> How do I find that out?

In /sys/kernel/debug/opp/cpu*/
or
/sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencies
with related_cpus

>
> > Does this system use uclamp during the benchmark? How?
>
> How do I find that out?

it can be set per cgroup
/sys/fs/cgroup/system.slice/<name>/cpu.uclam.min|max
or per task with sched_setattr()

You most probably use it because it's the main reason for ada8d7fa0ad4
to remove wrong overestimate of OPP

>
> > Given how large the stddev given by speedometer (version 3?) itself is, can we get the
> > stats of a few runs?
>
> v2.1
>
> w/o patch     w/ patch
> 440 +/-30     406 +/-11
> 440 +/-14     413 +/-16
> 444 +/-12     403 +/-14
> 442 +/-12     412 +/-15
>
> > Maybe traces of cpu_frequency for both w/ and w/o?
>
> trace-cmd record -e power:cpu_frequency attached.
>
> "base" is with ada8d7fa0ad4
> "revert" is ada8d7fa0ad4 reverted.

