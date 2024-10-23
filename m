Return-Path: <linux-pm+bounces-16278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E529ABDAC
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 07:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0FF1F24177
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 05:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4BA13D276;
	Wed, 23 Oct 2024 05:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKrTQYGx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1233E7482;
	Wed, 23 Oct 2024 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660350; cv=none; b=AJHoAAACkQfhHSBbVqXYkzXKV2GRp0yNmwwuRDooF6q65FTf8keWNCs06MJ+7gLT7koAAEtdvwBaHCeGQQulAz+Dhzg/wr7rArq7k8wQo3PVKgX/SNwz1TSSxnnklv2HRUqD6QZPc2trjwHrWXjmxQBoL6kHxQgQYiLlb0w3etA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660350; c=relaxed/simple;
	bh=q1SzjfyDUqXTFJ8ANykxGho3lrGhh+OK/KZR6BD3ocg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPyxCX0oO1NXFpDH2TnbLw6J8uU17GaSZufx1DOAndAGQJROeG8gAIO+wtPCyFG/zxnEcTQzVfUsPlVw1HI1TEm6a9FI8dSRw8R7lerz5yh0Z7aIHcClvK6UytXFXKiaQu5xfIlIVwuyZs1lx4aoXFubrMwoMxntT7hTC8Lro/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKrTQYGx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729660348; x=1761196348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q1SzjfyDUqXTFJ8ANykxGho3lrGhh+OK/KZR6BD3ocg=;
  b=HKrTQYGxdopPZ4Ocdy6SH2BRBb9NIiP513eolWYvdxvp4oT98g0a8xey
   CXY6sbz1uLmWOZQyiUWs4rPP2+qR5j9FGVL6QnF4KKREC84iL6cofUyY3
   /ihRokxdz5kTH3y4+6hVhoTMTSEoVHZLu+Kc58txzLSSWA9hd+8kVZ4AW
   AdAjz22Eu1vzHhBQ80LPVa9d/7cDgojMyAfEJP0isXAkQsntqqwVq0H1z
   t/7CQMu81pVsdfCxAFPavIXoUEQHBqQFf2JF3eofaQgzLGw9uaSkQ6NGa
   QwqtEnEyk9boROHKutfeAoDk7VBn/rlmcBxpgpkaGFWMrOmPxdtOjeDMm
   g==;
X-CSE-ConnectionGUID: D11pabiTQ/y8Of5vjqfgBA==
X-CSE-MsgGUID: QEZS/ZSZT/OHk6zFIRc/YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="39806559"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="39806559"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 22:12:25 -0700
X-CSE-ConnectionGUID: tJRGyc9lR+O3cFVIgZC7PA==
X-CSE-MsgGUID: 710md+vERMGX5DWxINm0kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80020677"
Received: from jwolwowi-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.24])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 22:12:24 -0700
Date: Tue, 22 Oct 2024 22:12:10 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20241023051210.fjpuyxhzzima4iu7@desk>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
 <1a96323d-f6e9-4a59-97c4-8cab149a7b31@amd.com>
 <20241018211139.wvvfn7az3gp35lwe@desk>
 <c54a76d9-414d-45c2-9bb6-4250a31cdd5f@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54a76d9-414d-45c2-9bb6-4250a31cdd5f@amd.com>

On Tue, Oct 22, 2024 at 09:42:37AM -0500, Mario Limonciello wrote:
> On 10/18/2024 16:11, Pawan Gupta wrote:
> > On Fri, Oct 18, 2024 at 11:28:31AM -0500, Mario Limonciello wrote:
> > > On 9/30/2024 09:47, Pawan Gupta wrote:
> > > > Sometimes it is required to take actions based on if a CPU is a performance
> > > > or efficiency core. As an example, intel_pstate driver uses the Intel
> > > > core-type to determine CPU scaling. Also, some CPU vulnerabilities only
> > > > affect a specific CPU type, like RFDS only affects Intel Atom. Hybrid
> > > > systems that have variants P+E, P-only(Core) and E-only(Atom), it is not
> > > > straightforward to identify which variant is affected by a type specific
> > > > vulnerability.
> > > > 
> > > > Such processors do have CPUID field that can uniquely identify them. Like,
> > > > P+E, P-only and E-only enumerates CPUID.1A.CORE_TYPE identification, while
> > > > P+E additionally enumerates CPUID.7.HYBRID. Based on this information, it
> > > > is possible for boot CPU to identify if a system has mixed CPU types.
> > > > 
> > > > Add a new field hw_cpu_type to struct cpuinfo_topology that stores the
> > > > hardware specific CPU type. This saves the overhead of IPIs to get the CPU
> > > > type of a different CPU. CPU type is populated early in the boot process,
> > > > before vulnerabilities are enumerated.
> > > > 
> > > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > > ---
> > > >    arch/x86/include/asm/cpu.h            |  6 ++++++
> > > >    arch/x86/include/asm/processor.h      | 11 +++++++++++
> > > >    arch/x86/include/asm/topology.h       |  8 ++++++++
> > > >    arch/x86/kernel/cpu/debugfs.c         |  1 +
> > > >    arch/x86/kernel/cpu/intel.c           |  5 +++++
> > > >    arch/x86/kernel/cpu/topology_common.c | 11 +++++++++++
> > > >    6 files changed, 42 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> > > > index aa30fd8cad7f..2244dd86066a 100644
> > > > --- a/arch/x86/include/asm/cpu.h
> > > > +++ b/arch/x86/include/asm/cpu.h
> > > > @@ -32,6 +32,7 @@ extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
> > > >    extern bool handle_guest_split_lock(unsigned long ip);
> > > >    extern void handle_bus_lock(struct pt_regs *regs);
> > > >    u8 get_this_hybrid_cpu_type(void);
> > > > +u32 intel_native_model_id(struct cpuinfo_x86 *c);
> > > >    #else
> > > >    static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
> > > >    static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> > > > @@ -50,6 +51,11 @@ static inline u8 get_this_hybrid_cpu_type(void)
> > > >    {
> > > >    	return 0;
> > > >    }
> > > > +
> > > > +static u32 intel_native_model_id(struct cpuinfo_x86 *c)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > >    #endif
> > > >    #ifdef CONFIG_IA32_FEAT_CTL
> > > >    void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
> > > > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > > > index 4a686f0e5dbf..61c8336bc99b 100644
> > > > --- a/arch/x86/include/asm/processor.h
> > > > +++ b/arch/x86/include/asm/processor.h
> > > > @@ -105,6 +105,17 @@ struct cpuinfo_topology {
> > > >    	// Cache level topology IDs
> > > >    	u32			llc_id;
> > > >    	u32			l2c_id;
> > > > +
> > > > +	// Hardware defined CPU-type
> > > > +	union {
> > > > +		u32		hw_cpu_type;
> > > > +		struct {
> > > > +			/* CPUID.1A.EAX[23-0] */
> > > > +			u32	intel_core_native_model_id:24;
> > > > +			/* CPUID.1A.EAX[31-24] */
> > > > +			u32	intel_core_type:8;
> > > > +		};
> > > > +	};
> > > >    };
> > > >    struct cpuinfo_x86 {
> > > > diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> > > > index aef70336d624..faf7cb7f7d7e 100644
> > > > --- a/arch/x86/include/asm/topology.h
> > > > +++ b/arch/x86/include/asm/topology.h
> > > > @@ -114,6 +114,12 @@ enum x86_topology_domains {
> > > >    	TOPO_MAX_DOMAIN,
> > > >    };
> > > > +enum x86_topology_hw_cpu_type {
> > > > +	TOPO_HW_CPU_TYPE_UNKNOWN	= 0,
> > > > +	TOPO_HW_CPU_TYPE_INTEL_ATOM	= 0x20,
> > > > +	TOPO_HW_CPU_TYPE_INTEL_CORE	= 0x40,
> > > > +};
> > > 
> > > This isn't exactly generic.  Unless you have a strong need to know "Atom"
> > 
> > The goal was not to have generic cpu_type here, but the actual CPU type
> > that hardware enumerates. I was asked to prepend "hw_" to cpu_type to make
> > is clear that this is hardware defined, and to leave scope for generic
> > cpu_type, if we add those in future.
> > 
> > > instead of "Efficient" or "Core" instead of "Performance" I think it would
> > > be better to do this as:
> > > 
> > > enum x86_topology_hw_core_type {
> > > 	TOPO_HW_CORE_TYPE_UNKNOWN	= 0,
> > > 	TOPO_HW_CORE_TYPE_PERFORMANT,
> > > 	TOPO_HW_CORE_TYPE_EFFICIENT,
> > > };
> > > 
> > > Then you can do the mapping of 0x20 = Efficient and 0x40 = performant in the
> > > Intel topology lookup function.
> > 
> > I can add a lookup function, but I wanted to understand the use case of
> > generic cpu_type. If we always have to lookup and map the cpu_type, then
> > why not have the actual cpu_type in the first place?
> > 
> > One case where generic cpu_type can be useful is when we expose them to
> > userspace, which I think is inevitable. Overall I am fine with adding generic
> > cpu type. It may also make sense to have separate accessors for generic and
> > and hardware defined cpu_type, and the generic ones when we actually have a
> > use case. Thoughts?
> > 
> > > After you land the series we can do something similar to move AMD code
> > > around and map it out to the right generic mapping.
> 
> I took your patch and made the modifications that I thought made sense for a
> generic type while adding the matching AMD code and sent it out (you're on
> CC).  Can you take a look and see what you think?  Boris already provided
> some feedback that I'm going to spin it again.
> I think if we can align on that one we can land that patch and you can
> rebase the rest of the series on it.

I left some feedback on that series. Overall it looks good. For Intel's use
case it needs to add accessor for hardware defined cpu_type. This is needed
for cpu-type matching in affected processor list.

