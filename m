Return-Path: <linux-pm+bounces-10202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA4091C4EF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 19:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68F3B22D35
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A71CB310;
	Fri, 28 Jun 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOdjasbp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6B1C8FA6;
	Fri, 28 Jun 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595939; cv=none; b=jM3jJJpKsU6fjtJrRN9qIw1aXN20w2NQRp5va2abUiLMTeEK3lYRHkt+x16kBW9W9LanzJrXR8OUE32OFyFqcmUOFKO9Jh5EroAgDsDE9r6cLU7qRdN+T3Wh/+RApxY7cZf8qzSyMeqskTZzehsLReXhISXuTh/Qp1eUMLada6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595939; c=relaxed/simple;
	bh=yD189zsTNT0ABb8plWe5Vq3zbuVs6MhAq8A7Ux/AVjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioahcwfNCPpQE89GUgaX36yBkVimF1TikfIaHSkQDtBGYLHQOCp2wS/pe+ZmeynSdhOyni+nT6u4rwwteFK9aGPp1Z6DvCtudv4WFFdPtamTMug9iBJ4dkb+RA5Kok4bP7lW6e87kuGyJJuD+Df+rFoCHAitSTkSm89tNktiu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOdjasbp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719595937; x=1751131937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yD189zsTNT0ABb8plWe5Vq3zbuVs6MhAq8A7Ux/AVjI=;
  b=BOdjasbpJriLymOVE4ig73Eo2CTp+S9xO26Geyikdfla0N4JLExwW1kJ
   7Hu8vxW5Ypw7Kd91wzQNfuJocLH7wgt9tKMcjpbu6XW+DSasrHVMKOZgA
   0vLtuU6UkwZsVut5YwBaOi/SHvUisBmcVj0yAi5B/td1t8EbxRbxCgKl1
   Znz0digjrYdEA9TRbwqLSTTxczShbIx4dYLH/eq8t8XV9r/C2ovoTH82x
   rtxlMzfp1f2WpObnZJ32DMecEQjsO4pzM4y/UvXYyu1mtUeQfn1PsSIsB
   ihbXtw2eULI9yjTAPQhsE8Fsb43LelLob92uLEA73ruKzcW2C310tsGcT
   A==;
X-CSE-ConnectionGUID: SPTqdt1OTq6MaH5YAEXV+w==
X-CSE-MsgGUID: 6k2Zy04hS5aV1753ExoaRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20605740"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="20605740"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 10:32:17 -0700
X-CSE-ConnectionGUID: Lo1wr3RcRfyp5z0eO/BfNQ==
X-CSE-MsgGUID: bCwUw97FQYumlfVRsyV2HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="49141956"
Received: from tensaeke-mobl1.amr.corp.intel.com (HELO desk) ([10.209.8.52])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 10:32:16 -0700
Date: Fri, 28 Jun 2024 10:32:09 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
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
Subject: Re: [PATCH v2 1/9] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20240628173209.wzpc6pwnw4p6u57h@desk>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-1-f927bde83ad0@linux.intel.com>
 <20240628080305.GEZn5uOSnW40fVgaNA@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628080305.GEZn5uOSnW40fVgaNA@fat_crate.local>

On Fri, Jun 28, 2024 at 10:03:05AM +0200, Borislav Petkov wrote:
> On Thu, Jun 27, 2024 at 01:44:06PM -0700, Pawan Gupta wrote:
> > The hw_cpu_type is populated in the below debugfs file:
> > 
> >   # cat /sys/kernel/debug/x86/topo/cpus/#
> 
> What "below debugfs file"? A '#'?

That is the number of the CPU. If it is causing confusion, I can will
change it to N, or say # means the number of the CPU.

> > diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
> > index 3baf3e435834..8082e03a5976 100644
> > --- a/arch/x86/kernel/cpu/debugfs.c
> > +++ b/arch/x86/kernel/cpu/debugfs.c
> > @@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
> >  	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
> >  	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
> >  	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
> > +	seq_printf(m, "hw_cpu_type:         %x\n", c->topo.hw_cpu_type);
> 
> Yeah, no, we're not going to perpetuate this silliness of printing hex
> values without a preceding "0x".

I thought about that, but the other fields are also printed without a
preceding "0x":

          seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
          seq_printf(m, "apicid:              %x\n", c->topo.apicid);
	  ...

I will change those too, probably in a separate patch.

> > +static void topo_set_hw_cpu_type(struct cpuinfo_x86 *c)
> > +{
> > +	c->topo.hw_cpu_type = X86_HW_CPU_TYPE_UNKNOWN;
> > +
> > +	if (c->x86_vendor == X86_VENDOR_INTEL && c->cpuid_level >= 0x1a)
> > +		c->topo.hw_cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
> > +}
> 
> Why isn't this happening in cpu/intel.c? And then you don't need yet
> another silly function.

I was preferring to keep the topology related code in one place. Would it
make sense to keep it in Intel specific leg in parse_topology() as below:

---
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 8b47bd6b0623..c8869e75365f 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -87,6 +87,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 		.cu_id			= 0xff,
 		.llc_id			= BAD_APICID,
 		.l2c_id			= BAD_APICID,
+		.hw_cpu_type		= X86_HW_CPU_TYPE_UNKNOWN,
 	};
 	struct cpuinfo_x86 *c = tscan->c;
 	struct {
@@ -132,6 +133,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	case X86_VENDOR_INTEL:
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
+		if (c->cpuid_level >= 0x1a)
+			c->topo.hw_cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
 		break;
 	case X86_VENDOR_HYGON:
 		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))

