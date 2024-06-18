Return-Path: <linux-pm+bounces-9513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBBE90DE65
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 23:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A061C2268E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B71E1849E6;
	Tue, 18 Jun 2024 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b1k1fwYz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B331741F0;
	Tue, 18 Jun 2024 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746107; cv=none; b=FS7fuLgsLHGugVvnooTd0bqa7qYllQGTgXF76GU1/1aAx6geET5LCEO/XznU24Lqqcz9C4tM3EuFAtcgCnRW5JF9lVdA17hv+AYW+MKrNk63ej5lYA3+WlX4Fkw3TsMce4gGhTV6JWmYtxjjRzEu0w7n+jgEr83gQZUd+ds0b0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746107; c=relaxed/simple;
	bh=oTOAK09bNCyzhYFed+xZ2W4HwUAk3QUtPWy3QMiakj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX2ubtydthET03AUntUgOVZvnjhaUtkIBvfXJkawXk0EWyL/CW/BI6o3xXm8gfLdQCWeMZMc+0ShtmPeQco4I2wEWWIbX905wHwTrMIQ8wYOlHczzBbQ2E+gvw/7kpZngIp8MqMjGK42RCcaVwK0KnAKCr1zrMUWpD6fTIen7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b1k1fwYz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC36B40E01A5;
	Tue, 18 Jun 2024 21:28:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NQ5p4vALchMD; Tue, 18 Jun 2024 21:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718746098; bh=vLq5vs7BzLPqxRinH41WctjbHEiIy7UiVfSMF4sqnnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1k1fwYzG8/DzCzvVgIHOz+OZ6EoeZd6T20Bbt+ENQ+49MpDVtN/2xoh11FQheHid
	 Srs5J23bB7sPXOb1wYPc1rL0RrPDj+0F8DFrTFirHvk9F+mkZmLFDJkg5I9R4AAENS
	 pxKyOfew3b//6fQpupHA+99K+HAbtLYJNTAekOayWOKNOKQNB2ocBT4/M/16mmE7v5
	 9tsc/MC7VS/KgZ4mOPD7eLU4g+7MUoE8favcE9Ej03zg++oZx4C6WObRINliXvVLdJ
	 q7lBxIRAsqKqUgaTnlU8vBanHyiqqWl8Pefw2Vw+x/bBLTdAZw8BXB57BZWhLmkNrc
	 xXZOKUYkuiSi5Sp0vfYnxg9AcOOmTqhcX0VLY/ju8AzdAfBJz4x6Sx1zKVmazj+mgn
	 Txdw+Q+jW1gGAfwCGAGoqbzxpSpCESM9NOzmHC7S4uj0HAaYDcRaUo/+3nn6dWCIE6
	 iA+NnI5XeJxrc+vs7Hh6oQzeJL1kacXFVxq4gTRyktiysZTkdks+pWZyR7oZ+BuCE/
	 YHSihyWumSL89r5cOnGL6U6v1GrJEPBZdQKj91+uAH1O58e0UM1Ds2ir8oFxmhrxuI
	 +QsXcSxJIm18oaHFXsu0cBzoqrEnMlhwCvwgECc/Z6KnKeUrov20/DfJcGmcgN5wtP
	 AXmIbT4GJrV7MMCpBDKKYUmo=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 611B440E0219;
	Tue, 18 Jun 2024 21:28:02 +0000 (UTC)
Date: Tue, 18 Jun 2024 23:28:01 +0200
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
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct
 cpuinfo_topology
Message-ID: <20240618212801.GJZnH74Q4yknT-4X12@fat_crate.local>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>

On Mon, Jun 17, 2024 at 02:11:26AM -0700, Pawan Gupta wrote:
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -95,6 +95,9 @@ struct cpuinfo_topology {
>  	// Core ID relative to the package
>  	u32			core_id;
>  
> +	// CPU-type e.g. performance, efficiency etc.
> +	u8			cpu_type;
> +
>  	// Logical ID mappings
>  	u32			logical_pkg_id;
>  	u32			logical_die_id;
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index abe3a8f22cbd..b28ad9422afb 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -41,6 +41,14 @@
>  /* Mappings between logical cpu number and node number */
>  DECLARE_EARLY_PER_CPU(int, x86_cpu_to_node_map);
>  
> +#define X86_CPU_TYPE_INTEL_SHIFT	24
> +
> +enum x86_topo_cpu_type {
> +	X86_CPU_TYPE_UNKNOWN		= 0,
> +	X86_CPU_TYPE_INTEL_ATOM		= 0x20,
> +	X86_CPU_TYPE_INTEL_CORE		= 0x40,

Can we unify those core types and do our own (our == Linux) defines instead of
using Intels or AMDs?

There will be AMD variants too soon:

https://lore.kernel.org/r/7aad57a98b37fa5893d4fe602d3dcef5c3f755d5.1718606975.git.perry.yuan@amd.com

so can we have generic defines like

PERF_CORE
EFF_CORE
bla_CORE

and so on

?

And then map each vendor's types to the Linux types?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

