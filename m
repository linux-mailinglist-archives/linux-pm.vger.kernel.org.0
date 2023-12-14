Return-Path: <linux-pm+bounces-1131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63289812A54
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 09:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958051C21495
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84A1D683;
	Thu, 14 Dec 2023 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHc06SwI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31E0F5
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 00:29:48 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ba00fe4e94so3852311b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 00:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702542588; x=1703147388; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8j+DyWsWq3rPzqEOsQC4R8gsbQQDhgjXMsOZjWoW7Zg=;
        b=sHc06SwI9GIJFPS0x5UUyUSgZN1rZv1U8PxLNpFZ/UOOPnUapHBPOC8SCWwhTjkGYD
         r0kip++XNWdCWFZqMcjo1abJXscTdyd/hVEfraqAo9Vv7jQtU1a/oUPkkw36/3Ueeu3+
         BZtwm0DVqD4PJtFUrpS3B5OC2kCI5mtoqMkrlISpMpzH1END9vdxdX4Q3Xaw0EoOFqz6
         lbUvrJQ4uCOSwFBWeruH+JLdtAe3VzDcURvQjDITqcOrX06Xg4vv6reBJyVnJLtWtNnG
         nXboT0cxI37Ash9amY8r1C2fGRqVssFXn7JhV9wYiGADIfEIPii7ahr8iFLkCrxhnkLt
         PrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702542588; x=1703147388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j+DyWsWq3rPzqEOsQC4R8gsbQQDhgjXMsOZjWoW7Zg=;
        b=P+nkm1Vho69o2YyBmlLBtBPxQDCjOOXc0Ap2dYBjl/+5GaiDUQvLFMajVDMYGqc/ex
         u3VMkZ9OSwgsFQdwUBAsoDzp9uaWo309YoOBsozx8uy8osnM4WjN7Z8SCSstrKBlpCzB
         yGQG+qK2Dar6FsK5wQhaI+Bz0Wl1DL8DcTb/klg1dNSrAEhbCcXJb9mLOwTOJTMZJf+3
         80WExlO1Z+H6do1sQsbv178uDNFrbbvrXlDc1ZOd/nHSNv06eMetCF2+4yO4XMxS6o0o
         QqY+csekPgXRqX39x3aUO/15zFVXSOCo7Iq7d+kFPXrRzRbfyojhO8UBwg2G0wpJcts8
         NcfA==
X-Gm-Message-State: AOJu0Yy53MUCw8eTkr8nJkyCCe/JmShTRmgVByMW7Ra2oRhec0FU7ftO
	2gRi3Pxx6YOpMpL0dgTvrV/UaNDpszxRJH0JWgM+ag==
X-Google-Smtp-Source: AGHT+IHx34nRT7HgMzHgkjnTUPzLya9tMyqlJCZvo8JOrIxH5qzsdOBtgYG+ga3Gr9xNvM5Ooa8pcFeabLVGZ4xUA8o=
X-Received: by 2002:a05:6808:2019:b0:3b9:d4cd:3498 with SMTP id
 q25-20020a056808201900b003b9d4cd3498mr12216403oiw.28.1702542588167; Thu, 14
 Dec 2023 00:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212142730.998913-1-vincent.guittot@linaro.org> <47b4cbcb-d33d-4699-a148-0108cf734e23@arm.com>
In-Reply-To: <47b4cbcb-d33d-4699-a148-0108cf734e23@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 14 Dec 2023 09:29:37 +0100
Message-ID: <CAKfTPtATWSWdk1dhnMvBqTZigtprv7d_0j0zpf48WfVDfMit5g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Rework system pressure interface to the scheduler
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, 
	linux-trace-kernel@vger.kernel.org, amit.kachhap@gmail.com, 
	daniel.lezcano@linaro.org, mhiramat@kernel.org, vschneid@redhat.com, 
	bristot@redhat.com, mgorman@suse.de, bsegall@google.com, 
	juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	konrad.dybcio@linaro.org, andersson@kernel.org, agross@kernel.org, 
	rui.zhang@intel.com, viresh.kumar@linaro.org, rafael@kernel.org, 
	sudeep.holla@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 09:21, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
> I've been waiting for this feature, thanks!
>
>
> On 12/12/23 14:27, Vincent Guittot wrote:
> > Following the consolidation and cleanup of CPU capacity in [1], this serie
> > reworks how the scheduler gets the pressures on CPUs. We need to take into
> > account all pressures applied by cpufreq on the compute capacity of a CPU
> > for dozens of ms or more and not only cpufreq cooling device or HW
> > mitigiations. we split the pressure applied on CPU's capacity in 2 parts:
> > - one from cpufreq and freq_qos
> > - one from HW high freq mitigiation.
> >
> > The next step will be to add a dedicated interface for long standing
> > capping of the CPU capacity (i.e. for seconds or more) like the
> > scaling_max_freq of cpufreq sysfs. The latter is already taken into
> > account by this serie but as a temporary pressure which is not always the
> > best choice when we know that it will happen for seconds or more.
> >
> > [1] https://lore.kernel.org/lkml/20231211104855.558096-1-vincent.guittot@linaro.org/
> >
> > Vincent Guittot (4):
> >    cpufreq: Add a cpufreq pressure feedback for the scheduler
> >    sched: Take cpufreq feedback into account
> >    thermal/cpufreq: Remove arch_update_thermal_pressure()
> >    sched: Rename arch_update_thermal_pressure into
> >      arch_update_hw_pressure
> >
> >   arch/arm/include/asm/topology.h               |  6 +--
> >   arch/arm64/include/asm/topology.h             |  6 +--
> >   drivers/base/arch_topology.c                  | 26 ++++-----
> >   drivers/cpufreq/cpufreq.c                     | 48 +++++++++++++++++
> >   drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +-
> >   drivers/thermal/cpufreq_cooling.c             |  3 --
> >   include/linux/arch_topology.h                 |  8 +--
> >   include/linux/cpufreq.h                       | 10 ++++
> >   include/linux/sched/topology.h                |  8 +--
> >   .../{thermal_pressure.h => hw_pressure.h}     | 14 ++---
> >   include/trace/events/sched.h                  |  2 +-
> >   init/Kconfig                                  | 12 ++---
> >   kernel/sched/core.c                           |  8 +--
> >   kernel/sched/fair.c                           | 53 ++++++++++---------
> >   kernel/sched/pelt.c                           | 18 +++----
> >   kernel/sched/pelt.h                           | 16 +++---
> >   kernel/sched/sched.h                          |  4 +-
> >   17 files changed, 152 insertions(+), 94 deletions(-)
> >   rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)
> >
>
> I would like to test it, but something worries me. Why there is 0/5 in
> this subject and only 4 patches?

I removed a patch from the series but copied/pasted the cover letter
subject without noticing the /5 instead of /4

>
> Could you tell me your base branch that I can apply this, please?

It applies on top of tip/sched/core + [1]
and you can find it here:
https://git.linaro.org/people/vincent.guittot/kernel.git/log/?h=sched/system-pressure

>
> Regards,
> Lukasz

