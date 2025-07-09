Return-Path: <linux-pm+bounces-30475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2CEAFE80D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D2E486D1D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62FF293B5F;
	Wed,  9 Jul 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="of0ESy9t"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B42D6631;
	Wed,  9 Jul 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061573; cv=none; b=MVKH5RWlFZW9bWHtUOt8QGh2h741zOQLavYkJXYPBSWM7xxg7Iu95aLnqwpf0PWxMcKzQyghX6sVtB88JjcoKAv5z4drULe58RI7CwIlAtpuPP+52TrwGttg+AqW6YXicYb++/ivg+/C8nExn3R8u8vDHoHjJmp1oj3qSuLm/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061573; c=relaxed/simple;
	bh=uq4UpVskpKbhmoV00LTVEDbec/v4DfnlwbjqA08nMS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvQiakcrG/fRDKTGShjPl/R1h7lgJBkFY9ZFTDY8Y6+BmYDpcUbhouGua3IvYLRl54XECnCdaicixtKFPteYMUkLLcVl+L+M8nWkXoSXQoI/N/Iu7WQy1qaQLmYCE8DD8U6Be4wpABcqy4M8gRN8OtaJQvCphO6/hCWjt5WR9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=of0ESy9t; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XvhQ5ICy3rxiHubpxE0vtAH0tzROu3Gr0Lu954QIDBg=; b=of0ESy9tooae3SCd13vLoosQY+
	H7Y3nHO3ZpaPCCekYGkKGqxTZmoi3p0mT1d00EDMcm3q7+iU1Ea6jnV8eX0rPweyIiiNoa9O5cYuS
	yLRlHaqUipTzYvX2J2TE/Z6QgnMglmQizBjVe+Y82Crpe8gl29irmrZosjJFw9hcfxJUMLSTwnJz3
	TiUNd34YMt476pdXBqBfS5MMTdjSljpX0WHRhxW7UMMHDriJQ4F3ZpX8pGqibE5YQFwGnPwdHabXO
	74xY2Ug4JBPZuB+FK//NjxTAzI1ISqNi/R8BKZB/1OK3fV7ljOonlu87UwrZzQr3/SUb/GyBwdaMs
	rJihTdcQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZTFX-00000008rbo-4Bqz;
	Wed, 09 Jul 2025 11:46:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A575030029B; Wed, 09 Jul 2025 13:46:06 +0200 (CEST)
Date: Wed, 9 Jul 2025 13:46:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v1] x86/sched: Print debug messages on hybrid asym
 capacity changes
Message-ID: <20250709114606.GJ1613200@noisy.programming.kicks-ass.net>
References: <4664631.LvFx2qVVIh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4664631.LvFx2qVVIh@rjwysocki.net>

On Wed, Jul 09, 2025 at 12:47:17PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] x86/sched: Print debug messages on hybrid asym capacity changes
> 
> Make arch_set_cpu_capacity() print a debug message including the
> capacity and maximum frequency ratio used in scale-invariant utilization
> computations for a given CPU and in capacity-aware scheduling (CAS) or
> energy-aware scheduling (EAS).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/kernel/cpu/aperfmperf.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -416,6 +416,10 @@
>  			   div_u64(cap << SCHED_CAPACITY_SHIFT, max_cap));
>  		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio,
>  			   div_u64(cap_freq << SCHED_CAPACITY_SHIFT, base_freq));
> +
> +		pr_debug("CPU%d: capacity = %lu, freq_ratio = %lu\n", cpu,
> +			 per_cpu_ptr(arch_cpu_scale, cpu)->capacity,
> +			 per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio);
>  	} else {
>  		WARN_ONCE(1, "Hybrid CPU capacity scaling not enabled");
>  	}

There's already a printk in the calling function
hybrid_set_cpu_capacity(), so now we get _2_ prints per CPU. That's a
bit excessive, no?

Also, should this print be conditional on sched_debug_verbose?

