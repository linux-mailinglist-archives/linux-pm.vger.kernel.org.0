Return-Path: <linux-pm+bounces-13555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C561896BA8B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 13:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80804285A3A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775FC1D5888;
	Wed,  4 Sep 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNufZ6Re"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB01D0DC5;
	Wed,  4 Sep 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449062; cv=none; b=Xv40ptJJ0kCcj3PXQbEZTtxBfJ04BV9DiBZ/GwZGjY5aA/uGGzGexUL6IjJuUesBwWebLbMH5AZSHlUz3ed6fJ/rXD3BYSV8p6fJGmtcc9kNCMEl9jf5jC6n55mZfRSvl1UNmbdzDYHFBima1WbctiKt2dcZdVV/NK7PFOuE7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449062; c=relaxed/simple;
	bh=x9Wj3NKCBVX2Jxy+RPYDCpkZ8gGV9skmqyYCNT65hyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okf6gaySS+3VvioZNQBUuK5EC0+CEuK/y6ZfxO9fnb8dZWTzYtkhGPUV7WFgns+tFU1iBeBK7ePhDXrpGc8J2miVY3i4A14AsTjqo2SZz56gj9y2CbQSY+qRcCFWr2LTn3JsqI+zU/tm8kVnvtV6VhZSvRREXhwT90cPsbjurEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNufZ6Re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA52FC4CECE;
	Wed,  4 Sep 2024 11:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725449061;
	bh=x9Wj3NKCBVX2Jxy+RPYDCpkZ8gGV9skmqyYCNT65hyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HNufZ6Rezk2QAruWxNn00mlXlHMSnLTHdhZIstQJI/Hm+2DgXyTIt8tfrTbxoMOnw
	 XGuvufzMfZFgWKNvBln3zaGABAYIva3Ew+ZJZTHACNhzS/s/d329+re8ofbAIILRJ+
	 f37z4k0qtFoECigUTAkiYFYIhnOsmlAN/M3A/nJgU1Qx+zkqmLC09iKgJ7BdnRrSFk
	 DkzKGzMktLNdTEQjT3iGgD+H9DmMjo7Hne2zAIMe7xEpCEUMu4wymyZ1fXsQ23SeDL
	 FqlCiZ/QmOsy0rUKhprvvtX1a+oSpC8HNDZ1sD+JFhRLDVQcZaDHO0P3wS3TlChS9O
	 4FAGwIfXSwqsA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-260e6298635so288671fac.1;
        Wed, 04 Sep 2024 04:24:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVW4xSY5HQsoV2qCqpluuhYwYs6WyOiObfe7o8I13ztP6E6bTe7WWZ3QAHpuAqUCdXnvkfxE6+uoKcIEfk=@vger.kernel.org, AJvYcCW6R5b//RGHRDni283YH3tlOCdgSJAwtO4jMusc4yRK3LRMISySE9w6ndPOTSLWw1A9mfib5IKNbLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqiS++7F4Vy4XJ/5Ci2DQEtjYQ019m3zLCxDflclRpF0NIKH1G
	1ESnWtow46iktR/gTLuIzU8A2ywfQRbavx4/D31MXHdMUMMt0pjNmHBNkgnqjxrRb8axYDccHXE
	72hzaSxlp2+X1C+yVDbiZS3hFgjk=
X-Google-Smtp-Source: AGHT+IFiW4HnFOm6hpTX9f9KiC1lu44dAHa+myos7dCCBdRDEe6xaVJ+kEGpB1ixNFpqP1Py9u5oWiWBZxOtYrBXuyk=
X-Received: by 2002:a05:6870:e24a:b0:278:a71:2659 with SMTP id
 586e51a60fabf-27b4a00b184mr742386fac.14.1725449061104; Wed, 04 Sep 2024
 04:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3310447.aeNJFYEL58@rjwysocki.net> <10523497.nUPlyArG6x@rjwysocki.net>
 <20240904062244.GA3614@ranerica-svr.sc.intel.com>
In-Reply-To: <20240904062244.GA3614@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Sep 2024 13:24:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hh=anBCtCFEfxQ0WJ5Zm8XuXA4UHFWZNhm9m7NSYNCQA@mail.gmail.com>
Message-ID: <CAJZ5v0hh=anBCtCFEfxQ0WJ5Zm8XuXA4UHFWZNhm9m7NSYNCQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/sched: Add basic support for CPU capacity scaling
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:17=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Wed, Aug 28, 2024 at 01:47:25PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In order be able to compute the sizes of tasks consistently across all
> > CPUs in a hybrid system, it is necessary to provide CPU capacity scalin=
g
> > information to the scheduler via arch_scale_cpu_capacity().  Moreover,
> > the value returned by arch_scale_freq_capacity() for the given CPU must
> > correspond to the arch_scale_cpu_capacity() return value for it, or
> > utilization computations will be inaccurate.
> >
> > Add support for it through per-CPU variables holding the capacity and
> > maximum-to-base frequency ratio (times SCHED_CAPACITY_SCALE) that will
> > be returned by arch_scale_cpu_capacity() and used by scale_freq_tick()
> > to compute arch_freq_scale for the current CPU, respectively.
> >
> > In order to avoid adding measurable overhead for non-hybrid x86 systems=
,
> > which are the vast majority in the field, whether or not the new hybrid
> > CPU capacity scaling will be in effect is controlled by a static key.
> > This static key is set by calling arch_enable_hybrid_capacity_scale()
> > which also allocates memory for the per-CPU data and initializes it.
> > Next, arch_set_cpu_capacity() is used to set the per-CPU variables
> > mentioned above for each CPU and arch_rebuild_sched_domains() needs
> > to be called for the scheduler to realize that capacity-aware
> > scheduling can be used going forward.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3:
> >    * Rebase after dropping patch [1/3].
> >    * Rename arch_set_cpu_capacity() arguments.
> >    * Add empty line to arch_enable_hybrid_capacity_scale().
> >    * Declare local variables in scale_freq_tick() on one line.
> >
> > v1 -> v2:
> >    * Replaces WARN_ON_ONCE() with WARN_ONCE() (2 places)
> >    * Fix arch_enable_hybrid_capacity_scale() return value when hybrid
> >      capacity scaling is already enabled.
> >    * Allow arch_enable_hybrid_capacity_scale() to succeed when
> >      frequency-invariance is not enabled.
> >    * Fix arch_set_cpu_capacity() kerneldoc comment
> >    * Do not disable capacity scaling in disable_freq_invariance_workfn(=
).
> >    * Relocate arch_hybrid_cap_scale_key definition.
> >
> > ---
>
> Only one minor comment below...
>
> FWIW:
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> # scale i=
nvariance

Thanks!

> [...]
>
> > +
> > +static struct arch_hybrid_cpu_scale __percpu *arch_cpu_scale;
> > +
> > +/**
> > + * arch_enable_hybrid_capacity_scale - Enable hybrid CPU capacity scal=
ing
>
> This looks to me like a kernel-doc comment. The function name should have=
 ().

Well, there are quite a few function kerneldoc comments without the
parens at the end of the name, but sure.

> [...]
> > +/**
> > + * arch_set_cpu_capacity - Set scale-invariance parameters for a CPU
>
> Same here.

