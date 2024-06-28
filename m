Return-Path: <linux-pm+bounces-10168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CCC91B953
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 10:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC43A1C229A0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 08:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB41474C3;
	Fri, 28 Jun 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GCLgh/3S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E514375A;
	Fri, 28 Jun 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561793; cv=none; b=joD+uo8j55Yb2FDj00CwgLJlWwa5ggsnCFKMMlgjq1Kyboumzf+fngZXIY3eC73VZ0eQINTbNsWQ6TJ+1EVkwXvqze2cf2MRP+vPbIzEZT8PRqdtMg9gi7+B+T2ervKQpQeHfU1+NDaP7EBtfKegtDzOiJXmcPnForyYSI/fJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561793; c=relaxed/simple;
	bh=yPCtwntitwnq3P1LKmfs4zz3mc8+InZdnuHc3hi9Ylk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXZ8lvDpMH+IeW+uKKWHihg+X1hEB5UQXbPO6rpugLcw957FA30X37if9kMAHmRk3I/5QvAcehL1IatKh5V34eQE7bfE+iVS4DPQXRZe1M0+HuRj0bx38HsD+QTfpHkYEkdZc1k03ssAPTKJbBVqSDt6qp5HerjhCXxcIlUTv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GCLgh/3S; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 728DB40E021A;
	Fri, 28 Jun 2024 08:03:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JE-v6gqwM-Fi; Fri, 28 Jun 2024 08:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719561786; bh=cVfSEJoYI9K0X4J37xQ+u9NuE3Ao5q+TdjlnQbav5uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCLgh/3SKA7iIa6OISo/2RyK4dTZnRR1eaus1F4iNpS0fGSrj95b9hJYqTZTKgkXz
	 /2oZRRnzy3Ga6cUnjGEcQyXSdtHOV9opsrWvl2dRvgdkfg/ZvK1bN9/zSA9aBTmoi3
	 +W64B7IZbySGJJefzyFJ2/L+FHoECPjkyr9yx76MLv7Rxb3pDcpsoeQicY3vhMwdXd
	 4Q5VykYuRSmpE9ZrmK44aoNHdUFF83D9BQFKDUEeJsZO682rkNlPLDsbSpjVSIuZXv
	 afFrbfUTlpKIM6oawmgpuRuXf/ql/mds8ZmQ+32l4zm0bIsec7ARNz1DGDnBbXvbYQ
	 JSPeKQDLZaHGjWoIbCGjQ7t2+ZWCmpk21XbcGQG4zNqttTBZdOPUH5hrYa58gGIHVJ
	 HI9vmI/F40jN9LRqOun6xbX0Xruqcr0/mnwS7EPXqfI7JKaLf2PaMkDfTx5onrD+8c
	 N967Y8tDCxQhNoaUnRKjD/YL6I38NScreg2i3zHZe3pbQcHK6du8rlAfKD/lkp12f2
	 vCJ8OLmWenLMP7RvUn7lfiFSdV99yr5adTmAlMGLlFbikTcpZsdc/lZeqWcm2iCagU
	 QQqax4fFN7CSdzzKvOUouemsQXWBBj48nR5JCU1/Zyqb+7Bs3gQEn5TlXq1d6+fLNa
	 9Xeg1iUIeJYEZPkq+jC0Om5E=
Received: from nazgul.tnic (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D935140E0219;
	Fri, 28 Jun 2024 08:02:45 +0000 (UTC)
Date: Fri, 28 Jun 2024 10:03:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH PATCH v2 1/9] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20240628080305.GEZn5uOSnW40fVgaNA@fat_crate.local>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-1-f927bde83ad0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627-add-cpu-type-v2-1-f927bde83ad0@linux.intel.com>

On Thu, Jun 27, 2024 at 01:44:06PM -0700, Pawan Gupta wrote:
> The hw_cpu_type is populated in the below debugfs file:
> 
>   # cat /sys/kernel/debug/x86/topo/cpus/#

What "below debugfs file"? A '#'?

> diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
> index 3baf3e435834..8082e03a5976 100644
> --- a/arch/x86/kernel/cpu/debugfs.c
> +++ b/arch/x86/kernel/cpu/debugfs.c
> @@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
>  	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
>  	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
>  	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
> +	seq_printf(m, "hw_cpu_type:         %x\n", c->topo.hw_cpu_type);

Yeah, no, we're not going to perpetuate this silliness of printing hex
values without a preceding "0x".

>  	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
>  	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
>  	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> index 9a6069e7133c..8b47bd6b0623 100644
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -140,6 +140,14 @@ static void parse_topology(struct topo_scan *tscan, bool early)
>  	}
>  }
>  
> +static void topo_set_hw_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	c->topo.hw_cpu_type = X86_HW_CPU_TYPE_UNKNOWN;
> +
> +	if (c->x86_vendor == X86_VENDOR_INTEL && c->cpuid_level >= 0x1a)
> +		c->topo.hw_cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
> +}

Why isn't this happening in cpu/intel.c? And then you don't need yet
another silly function.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

