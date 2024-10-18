Return-Path: <linux-pm+bounces-15998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7859F9A47FB
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 22:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378E2285278
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B44D2040AD;
	Fri, 18 Oct 2024 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7LY96X4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423F17BB0D;
	Fri, 18 Oct 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283466; cv=none; b=nftIuklyInIPRYo3BWoZp7hAPmexem/wvnp+5yhl9kKksN7oIaKkmpMQEDlTLn4e3lGsYdLmt7q6I/4VvFiKDTw/F1kn0c9yDqQkKEnSTlYBizVFonuuIiCzhsiljUZ8EH62353mJZOgN8vhntaIXeKLtJIh/BzFTX1eEn3K5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283466; c=relaxed/simple;
	bh=DDNmL8tvVOoBT6fJAABXhTxzRTimVNhJ+y3KpUF68Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1JnzL/cy7CY29ZCg1IxaDyQOCb5ugQd/QRsNiIBC5T9hb8tmdwZCLGdlfbHfQN2hW/0QIBmh6CqTKcFK+a1T/kIJOSOv2jCbIFc687kiqqiz63Wpkm/7FYFSlvd1V903ySsXTlPJmwlooEshWMDB+A31y3PSwF9ngXEI/D9FIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7LY96X4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729283465; x=1760819465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DDNmL8tvVOoBT6fJAABXhTxzRTimVNhJ+y3KpUF68Vo=;
  b=C7LY96X44yzK4NT9FcD6qIes0oXTd7aEAe7AY4S8ohVTqLvev6xXQ4C9
   4TosxqmJC/h/dRxACPf0XWMkViBzVWC8PabqvJKItK0NKIPsADyZHug2b
   JBPhVa+czpL7wbCv0Tjwf06mmmsbob5jK37494KJyK5p6K1UPobL4Jzt9
   vMoKrkTmcxDvZrWdZzBD9KdZCX8qF+HPpF5a3MnQuyv0dirOggbdBJpJm
   /NAWtc9NP252wZThuYgNImcn4BPCd731ffDYoFNQWr5wEqdDcTEz7PRy5
   uhvNrIoeYkGn8kFCEKwOSVRhXmd9ISM9MzH00/ToIDLPFiNmEl9tnhsyb
   A==;
X-CSE-ConnectionGUID: 4rmz1b+eS7yoJxYHo+ZJqg==
X-CSE-MsgGUID: 7TVW2SVAQTmZscnp2shqmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39381801"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39381801"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 13:31:04 -0700
X-CSE-ConnectionGUID: kHKCqmdSTMizBJKbSAVRSg==
X-CSE-MsgGUID: 4F6PttTRRy6ypKFOUdWFFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="102267390"
Received: from bdomingu-mobl1.amr.corp.intel.com (HELO desk) ([10.125.148.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 13:31:02 -0700
Date: Fri, 18 Oct 2024 13:30:53 -0700
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
Subject: Re: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20241018203053.2x6oyws3dkxfw6rm@desk>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
 <20241018161956.GCZxKKrLeTg0VTdfWA@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018161956.GCZxKKrLeTg0VTdfWA@fat_crate.local>

On Fri, Oct 18, 2024 at 06:19:56PM +0200, Borislav Petkov wrote:
> On Mon, Sep 30, 2024 at 07:47:24AM -0700, Pawan Gupta wrote:
> > Subject: Re: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct...
> 
> x86/cpu: ...
> 
> is enough.

Ok.

> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 4a686f0e5dbf..61c8336bc99b 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -105,6 +105,17 @@ struct cpuinfo_topology {
> >  	// Cache level topology IDs
> >  	u32			llc_id;
> >  	u32			l2c_id;
> > +
> > +	// Hardware defined CPU-type
> > +	union {
> > +		u32		hw_cpu_type;
> > +		struct {
> > +			/* CPUID.1A.EAX[23-0] */
> 
> Might as well stick to only // comments as we do those in headers now.

Will do.

> > +			u32	intel_core_native_model_id:24;
> 
> wow, that needs a whole breath to speak: "intel_core_native_model_id".

Yes, it needs to be shortened.

> "core" and "native" look like they wanna go. What is that field supposed to
> mean even?

In combination with core_type, this field can be used to uniquely identify
the microarchitecture.

I will drop "core", but can we keep "native"? "native" is used in SDM to
define this field. Also model_id could be confused with model number.

  From Intel SDM Vol. 2A:

  Bits 23-00: Native model ID of the core. The core-type and native model
  ID can be used to uniquely identify the microarchitecture of the core.
  This native model ID is not unique across core types, and not related to
  the model ID reported in CPUID leaf 01H, and does not identify the SOC.


> > +			/* CPUID.1A.EAX[31-24] */
> > +			u32	intel_core_type:8;
> > +		};
> > +	};
> >  };
> 
> ...
> 
> > +enum x86_topology_hw_cpu_type topology_hw_cpu_type(struct cpuinfo_x86 *c)
> > +{
> > +	if (c->x86_vendor == X86_VENDOR_INTEL)
> > +		return c->topo.intel_core_type;
> > +
> > +	return c->topo.hw_cpu_type;
> 
> Huh, the other vendors are not enabled. This should return
> TOPO_HW_CPU_TYPE_UNKNOWN then.
> 
> I know, it does but make explicit pls.

Yes, topo.hw_cpu_type is initialized to TOPO_HW_CPU_TYPE_UNKNOWN. We should
not ideally need the vendor check at all. As long as topo.hw_cpu_type has
the core type, returning it should be enough here. For Intel hw_cpu_type
also has the native_model_id, that is why we need the vendor check.

If AMD or other vendors have similar use case, it makes sense to add the
explicit vendor check. Please let me know if thats the likely case.

