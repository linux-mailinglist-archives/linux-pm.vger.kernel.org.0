Return-Path: <linux-pm+bounces-13233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE972966051
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 13:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9191C22FF2
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD71B2504;
	Fri, 30 Aug 2024 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL8MXJdV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAD1B2502;
	Fri, 30 Aug 2024 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016268; cv=none; b=ncHWBqvTWR4qLeqxR6+r4U4YHX0D8BlNXQdh3PbMrUTrzCT0UgE4lGgrLAOUgQrx2qD19q0v30n6/bxoczVqb3GFDQZmKgnQSroRBJioIGLy54B4GZHjnSEvgbXLmw3x3l8sVNvrAxLdCI2bFuqUeMfXaMhHyd/hfGEyLYDBDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016268; c=relaxed/simple;
	bh=+G3+tmoqKkeMmJ3pmWviq3g+M4BKq/ZOkhZqClXQlIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHZv/D/X77QfCYsfMSLkje4fUU/oU8KXTGq3l/0T0904ACZ2589uDDBwBK0dDkU07M5vx7EnDnJthsFbOGYQiFAX+AdXgYXSN1TWXoQ5Z9lLT3hBqqO7RlFsJPo/Ujt5cnEgjkgaURLytkvVtMrsu7MDtCwPK4eyDillSfrmxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL8MXJdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4132C4CEC4;
	Fri, 30 Aug 2024 11:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725016267;
	bh=+G3+tmoqKkeMmJ3pmWviq3g+M4BKq/ZOkhZqClXQlIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AL8MXJdV3MVFXRQ30vZJM3cVMNt/UnCiuQaJOE8NuLWb0LaqohZRs4R2VQsgPOAI2
	 3Gg/ftaXubbrh74GJoSEBvdjOj3U5iI9iMhRlm1GLhQ8t8lElupmS4Oxw4FBxeu0d7
	 tITLhy2xqPVuiTitvkhDrJv3bEEXeCUt7ujcaZoH6zg8AsmzJuehzqxyYQvJPnKviL
	 COCm3VAi6uhK5y+Msft5/BJA3I+fksVqaYvHnIJXPQpPojgVHcU1YoEZ/dxW688JP7
	 J8N1eb29urynvof3XSAL0Bdj1jud0e4R9y8oJ5qCu8psY8d07ZQyzC3aMKbfly/PHj
	 U076GaOZv3W9w==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5dfb53d4b13so146302eaf.2;
        Fri, 30 Aug 2024 04:11:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlKw0y4OqvUem6QbwU6uMi74Z/yTiVSh69uvxnaA3RQjKftGzN54fOf4lbYm3oOv4wACC9yybICac=@vger.kernel.org, AJvYcCXlObWRvQVCEj1S+6UC8VxP4qgRcvyaLBzVZKK7Zx9noL3G30WnXRln9eEXa1Ao+fk5HT5kuZbo6oTlgZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMO6xkFiGMh7ZgkVXqsQzlf7qPLHvuE+xHq/g6hUiKWNWzyBf+
	FgM7Zc2M8HjS0Xy7bzpL2U2GLi4efe18oekCxOxnkqD+H1wzrMH6xiWPE2Xp0iA7rbLQYNeo9sT
	e2ng8ny/GIwE1vcIlTpgV60hYEms=
X-Google-Smtp-Source: AGHT+IHFOblILYz/GlezAcJ1ZaRStQV8XJXFMOi6YK5c9GJxSnC1raeJLqL2AzPYwvaFIRCvmIA9jAjtqA/qbuIO98Y=
X-Received: by 2002:a05:6820:168d:b0:5da:a06b:c405 with SMTP id
 006d021491bc7-5dfacc1c89cmr2251224eaf.0.1725016267252; Fri, 30 Aug 2024
 04:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3310447.aeNJFYEL58@rjwysocki.net> <1979653.PYKUYFuaPT@rjwysocki.net>
 <6961a047-979b-40c2-bfc6-d8eddd96694c@linux.ibm.com>
In-Reply-To: <6961a047-979b-40c2-bfc6-d8eddd96694c@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Aug 2024 13:10:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hUiWFcu17tJfQcrNra6edBQ2tXTfP8rg7ZjHTdCDoMfw@mail.gmail.com>
Message-ID: <CAJZ5v0hUiWFcu17tJfQcrNra6edBQ2tXTfP8rg7ZjHTdCDoMfw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: intel_pstate: Set asymmetric CPU capacity
 on hybrid systems
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:30=E2=80=AFAM Shrikanth Hegde <sshegde@linux.ibm=
.com> wrote:
>
>
>
> On 8/28/24 17:18, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> [...]
> >
> > +static void hybrid_update_capacity(struct cpudata *cpu)
> > +{
> > +     unsigned int max_cap_perf;
> > +
> > +     mutex_lock(&hybrid_capacity_lock);
> > +
> > +     if (!hybrid_max_perf_cpu)
> > +             goto unlock;
> > +
> > +     /*
> > +      * The maximum performance of the CPU may have changed, but assum=
e
> > +      * that the performance of the other CPUs has not changed.
> > +      */
> > +     max_cap_perf =3D hybrid_max_perf_cpu->capacity_perf;
> > +
> > +     intel_pstate_get_hwp_cap(cpu);
> > +
> > +     hybrid_get_capacity_perf(cpu);
> > +     /* Should hybrid_max_perf_cpu be replaced by this CPU? */
> > +     if (cpu->capacity_perf > max_cap_perf) {
> > +             hybrid_max_perf_cpu =3D cpu;
> > +             hybrid_set_capacity_of_cpus();
> > +             goto unlock;
> > +     }
> > +
> > +     /* If this CPU is hybrid_max_perf_cpu, should it be replaced? */
> > +     if (cpu =3D=3D hybrid_max_perf_cpu && cpu->capacity_perf < max_ca=
p_perf) {
> > +             hybrid_update_cpu_scaling();
> > +             goto unlock;
> > +     }
>
> I assume this CPU capacity is based on freq. It doesnt change based on
> irq, any upper scheduler classes such dl, rt right?

Right.

It is based on how many instructions per cycle the CPU can execute,
which does not change at all, and what its maximum possible frequency
is.

> can capacity_perf change slightly or it can change such that it always
> changes to next possible level? The reason, if it can change slightly,
> but cpu is still hybrid_max_perf_cpu, it would end up accessing all the
> percpu structures and change it, that would be costly on larger systems.

This should only change when the maximum voltage that can be supplied
to the CPU changes, so always to the next level.

