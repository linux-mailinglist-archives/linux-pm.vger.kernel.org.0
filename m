Return-Path: <linux-pm+bounces-16572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E19B3052
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D16281254
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1AB1D934B;
	Mon, 28 Oct 2024 12:33:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D07D1D5CE0;
	Mon, 28 Oct 2024 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118811; cv=none; b=ZxKeAUO/vamOtnOCP/9rqEoq5BxBOlprg5+Bn8aJqvjvH59UyG6WIBACWxXy7kFPkVcuk31Aa+kVpbpLDiKhDwVKslphCJYQ/7Nwr/4/1vNr/uVI8xjFvG5GKJrY23g4WL5M29CIPHykybwmqnbz+3mlKgRe7s8gxASJjyDEMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118811; c=relaxed/simple;
	bh=LUo/4DSAgdM5mhdfwOOB3FQxw3+m/5EaS5mwXq28miw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn/t2QA62dsNGZJzjT05uGCafhHbstZSoQGBVMz8BKYfdPm5tjuCC69ZVj8scfN/Vom3Svuc5/Mriji1+DyXLhCvZjtoGMtni0XR9HF6zKSc8FeCSy+05dVIbcBSMQIGfZ/lBmPo/ETCePVcTwbyqTqiUGTYcWcqFlezq7rI55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F574497;
	Mon, 28 Oct 2024 05:33:58 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F20B43F73B;
	Mon, 28 Oct 2024 05:33:25 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:33:23 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	David Dai <davidai@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Improve VM CPUfreq and task placement behavior
Message-ID: <Zx-Ek7IbpYNDbG9D@bogus>
References: <20240919000837.1004642-1-davidai@google.com>
 <20241001092544.2tlydouyyc7jwuja@vireshk-i7>
 <CAGETcx8GomM0znaYKsS412dRvnUQd7_78pKuV82t2b14VBvKVQ@mail.gmail.com>
 <CAJZ5v0iTLX9NAT0PN804QahQ7D=+=D1uJ7PVnZfk5UrpP5uXpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iTLX9NAT0PN804QahQ7D=+=D1uJ7PVnZfk5UrpP5uXpg@mail.gmail.com>

On Mon, Oct 28, 2024 at 12:39:31PM +0100, Rafael J. Wysocki wrote:
> On Sat, Oct 26, 2024 at 12:26 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Oct 1, 2024 at 2:25 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 18-09-24, 17:08, David Dai wrote:
> > > > Hi,
> > > >
> > > > This patch series is a continuation of the talk Saravana gave at LPC 2022
> > > > titled "CPUfreq/sched and VM guest workload problems" [1][2][3]. The gist
> > > > of the talk is that workloads running in a guest VM get terrible task
> > > > placement and CPUfreq behavior when compared to running the same workload
> > > > in the host. Effectively, no EAS(Energy Aware Scheduling) for threads
> > > > inside VMs. This would make power and performance terrible just by running
> > > > the workload in a VM even if we assume there is zero virtualization
> > > > overhead.
> > >
> > > > David Dai (2):
> > > >   dt-bindings: cpufreq: add virtual cpufreq device
> > > >   cpufreq: add virtual-cpufreq driver
> > > >
> > > >  .../cpufreq/qemu,virtual-cpufreq.yaml         |  48 +++
> > > >  drivers/cpufreq/Kconfig                       |  14 +
> > > >  drivers/cpufreq/Makefile                      |   1 +
> > > >  drivers/cpufreq/virtual-cpufreq.c             | 333 ++++++++++++++++++
> > > >  include/linux/arch_topology.h                 |   1 +
> > > >  5 files changed, 397 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,virtual-cpufreq.yaml
> > > >  create mode 100644 drivers/cpufreq/virtual-cpufreq.c
> > >
> > > LGTM.
> > >
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Rafael/Viresh,
> >
> > Nudge... Any chance this will get pulled into 6.12?
>
> This is not a fix AFAICS, so 6.12 is out of the question.
>
> As for 6.13, Viresh thinks that this change is a good idea (or he
> wouldn't have ACKed it), so it's up to him.  I'm still not convinced
> that it will work on x86 or anything that doesn't use DT.
>

+1, I was about to comment on DT bindings patch, but then I assumed it is
accepted to have a device object with similar CID and CRS(for register address)
in ACPI for example. But yes, the patch itself is not adding support for that
yet. If not is not the way, then we need to come up with a way that works
for both ACPI and DT.

--
Regards,
Sudeep

