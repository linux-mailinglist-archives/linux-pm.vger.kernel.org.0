Return-Path: <linux-pm+bounces-18190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F139DB13D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 02:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66DA2825BB
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 01:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1064EB38;
	Thu, 28 Nov 2024 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLXvSkg7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AD537F8
	for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732758451; cv=none; b=jlMD91yYrR+1QT0+zoUrt2eU3g1+HaLmFVR5I5445/71JEVbcfUX2/oC505sSjD1cLEHrA1jMAwmiy6+Pv68IGUZcZmfH8m1dZiNLTUl6xlCIC2yFP1PFVzxcBM5RPGd0NlD/urAjNPg+o69ClZVzE89hKTjO1Ehnh7p1O6h8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732758451; c=relaxed/simple;
	bh=a2ANOdfmWaxFZ1FDkgIhRpyah2x2oQvukswllKt3SmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VY7q2Qrum9Lk1Tmn64wL5GtGzlZ745veJtj9yak4Bu38ecbs7fwTmTXM/4bCTMg6Iie2dn5XZvn7MTyxBGpUEJn6z355oPQZh2lyXQSqrw3bi1borDTNsqQboPG5QTr3YEXlhOpqQ3mxA61XifFyEJo8yWuE6F6DKVRXvfoGuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLXvSkg7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so52857666b.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2024 17:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732758448; x=1733363248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDYZxnvQSCUs7/URW7u5aFatw24C1MEYIz5QO3pahVo=;
        b=sLXvSkg7sNLK4md1AeVgIgXFA83X0i9SxkDGVXqTYlBcBEnkLoWFz5VpbttKdghzPt
         eWBxIGvg3MamUYUub1si6F5FdPi7Zp0TczIIJPK+zbL/kdvZx5kCHoV/NJEXssz1O4mg
         125DjpALOycTLo3pXpg/C3OI8W6BPRw/XxtO7lWgZ1GOlw+NOXHBijfhmjaBTCopb7qa
         yAfI+7BqSDusA2iKQxXF3sOVS55ryYxQb0jusOotFNpp0S+Vm/FCN07OI5AsZ9E6qnWJ
         UnsboohkByUDAdjtCtt8eq4uKUEmyyOsbVfP2bFoSqZejCY0xT3ydxFuGxiUne2BoIDf
         fJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732758448; x=1733363248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDYZxnvQSCUs7/URW7u5aFatw24C1MEYIz5QO3pahVo=;
        b=sy0cC+CKHmZ7kzBHYQsX4dHTB2GNTKbd9k1JicCZZf6G/OssI0WcsBrWjiT8JXlc0v
         ta9+2g+70V7MJ3PfS7UkWw7+AfNnMAIEQq/Huly5gEvWfFYtAZY0HbGUx8qfIKuPRKWF
         cHjrF98lkiGUt+4MpCxCMzSTpHzEjf3CMrpBm0SyZ6gZB2kcKPr+l/LIGnB37YgizRRP
         PX+tRbdwrOdwlAmCsBZjSZ1MaaiMBdn4wWU/vTONNK2BbR1PXiidPzt1iROSoqrgK0Uh
         HNzcwL2+Sqw8y4IP+IccQxiDNK2dnTJAsEw1eD8FWkZq/WHLFs95fKyvEZ0szsIDEXmo
         YX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnSOK271xo0MdwHED8PiRiHu/iw8KXRu8ePDWjj+J2jbODc7YEJyh/TtD4c3PflL1XAX8ZdiFtzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7wiv6o6krtQxDhAnswK09ylqrzYeMjyIRfkt94KU0LosYM5g
	jGRAyAgj4Fm37uPWbRuM5bTVZdNB1h9a28++1y40N27KndWgLTmeRbAaNsKQDweLwJ/aLVa9GpH
	hIpc0/ljqchIhRbPJ5Ivd7nh6gav7hiSZWWU=
X-Gm-Gg: ASbGncsg2MKp7FbilVUedIaaIbfzvkA+kvdK0ZwrgYvi/jIaqgLoBT8gEhUPqiW4qWN
	GPDE5YJO7XsU4KQE1RanjhVLVxoLCGGMvxCdwSjqDrQTfe4bz/9ttK7zE7cUm
X-Google-Smtp-Source: AGHT+IGSYlJ14Wcq/1LY00BqQ/ETFskHaspi5ZfN1q1HEHggR4TBAntDhsD0VFjxBva+v7FsMZmlprLmPi/C0GrZd2I=
X-Received: by 2002:a17:907:2cc9:b0:aa5:49a4:9189 with SMTP id
 a640c23a62f3a-aa580f5753emr502352166b.33.1732758447564; Wed, 27 Nov 2024
 17:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820163512.1096301-1-qyousef@layalina.io> <20240820163512.1096301-11-qyousef@layalina.io>
In-Reply-To: <20240820163512.1096301-11-qyousef@layalina.io>
From: John Stultz <jstultz@google.com>
Date: Wed, 27 Nov 2024 17:47:16 -0800
Message-ID: <CANDhNCpdScf4g9se69t-qcidP-ac0S2=hnUSN76BvszqdmvWTA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/16] sched/qos: Add a new sched-qos interface
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 9:36=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> The need to describe the conflicting demand of various workloads hasn't
> been higher. Both hardware and software have moved rapidly in the past
> decade and system usage is more diverse and the number of workloads
> expected to run on the same machine whether on Mobile or Server markets
> has created a big dilemma on how to better manage those requirements.
>
> The problem is that we lack mechanisms to allow these workloads to
> describe what they need, and then allow kernel to do best efforts to
> manage those demands based on the hardware it is running on
> transparently and current system state.
>
> Example of conflicting requirements that come across frequently:
>
>         1. Improve wake up latency for SCHED_OTHER. Many tasks end up
>            using SCHED_FIFO/SCHED_RR to compensate for this shortcoming.
>            RT tasks lack power management and fairness and can be hard
>            and error prone to use correctly and portably.
>
>         2. Prefer spreading vs prefer packing on wake up for a group of
>            tasks. Geekbench-like workloads would benefit from
>            parallelising on different CPUs. hackbench type of workloads
>            can benefit from waking on up same CPUs or a CPU that is
>            closer in the cache hierarchy.
>
>         3. Nice values for SCHED_OTHER are system wide and require
>            privileges. Many workloads would like a way to set relative
>            nice value so they can preempt each others, but not be
>            impact or be impacted by other tasks belong to different
>            workloads on the system.
>
>         4. Provide a way to tag some tasks as 'background' to keep them
>            out of the way. SCHED_IDLE is too strong for some of these
>            tasks but yet they can be computationally heavy. Example
>            tasks are garbage collectors. Their work is both important
>            and not important.
>
>         5. Provide a way to improve DVFS/upmigration rampup time for
>            specific tasks that are bursty in nature and highly
>            interactive.
>
> Whether any of these use cases warrants an additional QoS hint is
> something to be discussed individually. But the main point is to
> introduce an interface that can be extendable to cater for potentially
> those requirements and more. rampup_multiplier to improve
> DVFS/upmigration for bursty tasks will be the first user in later patch.
>
> It is desired to have apps (and benchmarks!) directly use this interface
> for optimal perf/watt. But in the absence of such support, it should be
> possible to write a userspace daemon to monitor workloads and apply
> these QoS hints on apps behalf based on analysis done by anyone
> interested in improving the performance of those workloads.
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
...
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/p=
erf/trace/beauty/include/uapi/linux/sched.h
> index 3bac0a8ceab2..67ef99f64ddc 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/sched.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/sched.h
> @@ -102,6 +102,9 @@ struct clone_args {
>         __aligned_u64 set_tid_size;
>         __aligned_u64 cgroup;
>  };
> +
> +enum sched_qos_type {
> +};
>  #endif
>
>  #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
> @@ -132,6 +135,7 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS         0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN      0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX      0x40
> +#define SCHED_FLAG_QOS                 0x80
>

Hey Qais,
  Just heads up, It seems this needs to be added to SCHED_FLAG_ALL for
the code in later patches to be reachable.

thanks
-john

