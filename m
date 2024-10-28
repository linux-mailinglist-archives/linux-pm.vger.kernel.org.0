Return-Path: <linux-pm+bounces-16568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3FA9B2F10
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 096BCB20DC5
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 11:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CB41D6199;
	Mon, 28 Oct 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo/Lu7Iu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE26143888;
	Mon, 28 Oct 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115588; cv=none; b=MNcX6zq4SyOWzIne12L4b3TqcD2ctKnDOXtjrIbf/kv5bGm4i/txx5zUGOIrzWBi4SRrAK+uBM4q+WYbQIP4ETDMsNNB0k944UuOTK+2DZjsFfjdti6EyPIwNzl5+K0cGXGH5qs8pyRPbIAfYc3Nr7dx0jOB0254+89feYXEpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115588; c=relaxed/simple;
	bh=SnA2owK3Wh51XGmITR8PBTFZ5GSTlL47esiUlTgErgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/0lDsoB91T2dkxKfwXCqqsoZdjPAehYwbv2Qf9LsCASlibOtCxCemQx/glfhKnO/JTA7O54W0/zjEn64TVdSNEH7LddDnQNjKvau4q1E2khyceF+2IlVuYN8W8+5esnDPaQ6TFiPFdNVY7c5CUy/0N/qUiUqW9L3fO/m/lcV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo/Lu7Iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A17C4CEE8;
	Mon, 28 Oct 2024 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730115588;
	bh=SnA2owK3Wh51XGmITR8PBTFZ5GSTlL47esiUlTgErgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yo/Lu7IuDlYQgr3bDqc6QyInFOtBotCnOnf0q1Layoh3Cw7xKSPNxg9GbTxuzXr1O
	 c9AiPEPsweAssaX1KPch6+yfL77tWOSCJ9sBZ7wWO3zoaEaW0ogNlsHvM70ecTuev9
	 bcRlxF64fhXp7jnHzJgqAvrijxQWT3v6OqD/YuLjYPZEGzDJseIHO7o8kBfON1rFYi
	 QSdOPfmDqZEQAQ+fW1xGHPOI2zON6uoqx1DFnZ+LMCdzfAp1UqMR7hkLF2i5Fvm8a+
	 CUTb6lFv3lOAC73bE5LFF/XNnNV4luKDflqeyrzwCTTCcIif/Qh0BIuMmw21MrCpyB
	 81s4LCPtP8jxA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-28c7f207806so1816441fac.3;
        Mon, 28 Oct 2024 04:39:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrHFzR+IoELb6B7jd/L2Y10cbl7+qC17EFE/coJJsjoPTLXR2ppNkZWp1uwMTMuUqWpMLHhH9Wz5A0ijaE@vger.kernel.org, AJvYcCWXD2T1DsQD0C9ek5BVvXkG5OxwW8oKl+5GLTM0eZsJ6/THppwNFP9tmevvbCKIUjYLIFgQk/MjpNjR@vger.kernel.org, AJvYcCXnRzXuxVJXc9xVLS/b1wu6DDKHLvFg+yqH0z359Ca5HKVCuJSGPkM4FLPcXo4I/V8p1rqJ/bTdtgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2qwCTL7B31LioJG2lLxdIpbJbJum6Sy6Lzt1AfMyq0ayiAQT
	PT93f03la8Zo7oppcq5YPLG6slAkWepqOwrSzwup/z2tbihwFXuXNietixzGIOlzyGGKIQ0XoXa
	OxzfL6k7zq3ynaoFWYuzqfePAKCc=
X-Google-Smtp-Source: AGHT+IFpYNi0n2+EpwfJw+aYg1SZVLsAaWJ0o1EJSLnlNBvj6WIP7nhfCWI+y6q/QZiT/At+3/RZ5OUb5Tw59F2BoTc=
X-Received: by 2002:a05:6870:8186:b0:278:222c:98c4 with SMTP id
 586e51a60fabf-29051bccd06mr6661783fac.21.1730115587412; Mon, 28 Oct 2024
 04:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919000837.1004642-1-davidai@google.com> <20241001092544.2tlydouyyc7jwuja@vireshk-i7>
 <CAGETcx8GomM0znaYKsS412dRvnUQd7_78pKuV82t2b14VBvKVQ@mail.gmail.com>
In-Reply-To: <CAGETcx8GomM0znaYKsS412dRvnUQd7_78pKuV82t2b14VBvKVQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Oct 2024 12:39:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iTLX9NAT0PN804QahQ7D=+=D1uJ7PVnZfk5UrpP5uXpg@mail.gmail.com>
Message-ID: <CAJZ5v0iTLX9NAT0PN804QahQ7D=+=D1uJ7PVnZfk5UrpP5uXpg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Improve VM CPUfreq and task placement behavior
To: Saravana Kannan <saravanak@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Quentin Perret <qperret@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 12:26=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
>
> On Tue, Oct 1, 2024 at 2:25=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
> >
> > On 18-09-24, 17:08, David Dai wrote:
> > > Hi,
> > >
> > > This patch series is a continuation of the talk Saravana gave at LPC =
2022
> > > titled "CPUfreq/sched and VM guest workload problems" [1][2][3]. The =
gist
> > > of the talk is that workloads running in a guest VM get terrible task
> > > placement and CPUfreq behavior when compared to running the same work=
load
> > > in the host. Effectively, no EAS(Energy Aware Scheduling) for threads
> > > inside VMs. This would make power and performance terrible just by ru=
nning
> > > the workload in a VM even if we assume there is zero virtualization
> > > overhead.
> >
> > > David Dai (2):
> > >   dt-bindings: cpufreq: add virtual cpufreq device
> > >   cpufreq: add virtual-cpufreq driver
> > >
> > >  .../cpufreq/qemu,virtual-cpufreq.yaml         |  48 +++
> > >  drivers/cpufreq/Kconfig                       |  14 +
> > >  drivers/cpufreq/Makefile                      |   1 +
> > >  drivers/cpufreq/virtual-cpufreq.c             | 333 ++++++++++++++++=
++
> > >  include/linux/arch_topology.h                 |   1 +
> > >  5 files changed, 397 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,vi=
rtual-cpufreq.yaml
> > >  create mode 100644 drivers/cpufreq/virtual-cpufreq.c
> >
> > LGTM.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Rafael/Viresh,
>
> Nudge... Any chance this will get pulled into 6.12?

This is not a fix AFAICS, so 6.12 is out of the question.

As for 6.13, Viresh thinks that this change is a good idea (or he
wouldn't have ACKed it), so it's up to him.  I'm still not convinced
that it will work on x86 or anything that doesn't use DT.

Viresh, I think that this falls into your bucket.

