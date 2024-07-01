Return-Path: <linux-pm+bounces-10280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7A591E02F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646541C222B8
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5B815AD9C;
	Mon,  1 Jul 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mdq3t+uF"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2C12A14C;
	Mon,  1 Jul 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838965; cv=none; b=i5Fz1jvjj2LDMqyBci27aOAi+F9JCFxRoj5NiBH2JxR1ZPHLHB/UwHzk1rofX485MVQi34Vg0zgIFuwIYo0jvTM6OKoWgxAQ4enDlYO9PafAAMeGhrEb14NmND9/38U8L17EUDC4nbiIYM/29S7G7uM4p5ar/PRxI1ttMLyvaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838965; c=relaxed/simple;
	bh=F44qE1xyCopMZ+8gx105TDnRVx+uvoyWjvGdqpCPTTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpMiWZMj94rZVrZyKL0+xg07NH2Nl7uKl37u/GUfzm3j6Tux5hMHdW70FPvzcTmZJFrOjOFnwkN7T1GxmS346Gg+jESNtggNm7qTV7QqUNA/j055JPTwZ2o6m3itculjycUevCwAOnfWKvySnMl1PgpLHYznXViTfj88z9/XOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mdq3t+uF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=75q3eIPINSpJvc1Nmi5K1mC+gXBktq1nLtEaq5o3P0U=; b=Mdq3t+uFh/odN0qQZgcq2NeqbK
	fAxEbroRD30SayGF29qfZO3fkwZzyBB7uVuycjtXKpBQTtbEdqMV5hYIvpWTGszOYMsXQ4YQymji6
	tgoyiY6vz7C5xQOTLO7tXer05n+ut79mJjV7ea0QZJHIUhL5m1aiynPDf3yjoBR+iEKRzp1vw23Tf
	NJJvFiIJBMqdsbxT+vSRHrgqxN70ZfEUVSp6QglYV5iXu4OrfMqfAoClnmWTBctGNOl9bjxrdFQme
	2PFXGChMSnnbBC2acXdG41HLQQL8xXtXroq7VAZItVBLiJKWUFkP0phIQ4Yr1qO8r5XEVodjrQ01B
	phY3TJEg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOGfx-0000000HLkG-0bDz;
	Mon, 01 Jul 2024 13:02:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2B2A300694; Mon,  1 Jul 2024 15:02:32 +0200 (CEST)
Date: Mon, 1 Jul 2024 15:02:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
	gustavoars@kernel.org, rui.zhang@intel.com,
	oleksandr@natalenko.name, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ananth.narayan@amd.com, gautham.shenoy@amd.com,
	kprateek.nayak@amd.com, ravi.bangoria@amd.com, sandipan.das@amd.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 05/10] perf/x86/rapl: Move cpumask variable to
 rapl_pmus struct
Message-ID: <20240701130232.GH20127@noisy.programming.kicks-ass.net>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
 <20240624055907.7720-6-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624055907.7720-6-Dhananjay.Ugwekar@amd.com>

On Mon, Jun 24, 2024 at 05:59:02AM +0000, Dhananjay Ugwekar wrote:
> This patch is in preparation for addition of per-core energy counter
> support for AMD CPUs.
> 
> Per-core energy counter PMU will need a separate cpumask. It seems like
> a better approach to add the cpumask inside the rapl_pmus struct, instead
> of creating another global cpumask variable for per-core PMU. This way, in
> future, if there is a need for a new PMU with a different scope (e.g. CCD),
> adding a new global cpumask variable won't be necessary.
> 
> No functional change.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  arch/x86/events/rapl.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index e5e878146542..be139e9f9ee0 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -119,6 +119,7 @@ struct rapl_pmu {
>  
>  struct rapl_pmus {
>  	struct pmu		pmu;
> +	cpumask_t		cpumask;
>  	unsigned int		nr_rapl_pmu;
>  	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
>  };

Yikes no, please use cpumask_var_t and alloc_cpumask_var() and friends.

