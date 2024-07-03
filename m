Return-Path: <linux-pm+bounces-10565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E524A926C51
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 01:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220241C22198
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414C194A5C;
	Wed,  3 Jul 2024 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SuOlLfAO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110621DA313;
	Wed,  3 Jul 2024 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048077; cv=none; b=PPKoQNoANOW9Vx80T8iqME7opMXiFZWLFFFrYW92X7inz03daBaF3hXFfyH88aO3j2g9cUXXQGPzBPgYQzN5zQYlvyx8l3VJFd2EpeL/4w6GMsQMy2DNuGCGjr4VCKRkQoEhoIw48R1DXzE5qe6VjWV2Qct1VAWNMkda4mAJVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048077; c=relaxed/simple;
	bh=vn+sW8ZyjpsUb2fRe3K0pOkAZ+FDvIED2cRcDMheMq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiWXVjP//FzoZG44DjWEPv32K9703UDLOX4xoQBmglLGeXSv7QgfJkou/uSouhEBmx+3Ciu7iit4axFibTgD2/8Zm607rd0qQbJbIz7jgSDUJrSYUExrtldp0BXEZuUri+EaqYGjskGt2Nh9FB+jz9ILurUM8Q541DCU1rV3EZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SuOlLfAO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8DA2D40E021B;
	Wed,  3 Jul 2024 23:07:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dccP64wQ6FMy; Wed,  3 Jul 2024 23:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720048069; bh=vARn0lwb52XcUW8aFdtOgDF06W70NUIa2J+3vdggSvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SuOlLfAOzld19ExePQmgbMX3M01B5Mr4oCwu5IS+rFQ/V7dHagmWjYI4GTej63GYF
	 5tQuwCg+qBMgxjqZEJjjgtZ2YGk9cp6MFLaylP/CaoR9QPlAvni4k1SCPsKfPXkKfh
	 RP0Qe99/Ze4/0cQ/VdfhYhgj3kozxoI8BNuZYFPX05oPw+Ag3I/JRdLKJraWStglGw
	 k2R8nB/08AeBOTEubMm/GMZ3kkpvs2qtRZQqDox7FJglxeybYCyPebOavbbFRUo0z4
	 2gVczO2vfiT26tV5w0F2DgyZEt3f0Ta8V5hqDwUrnu6fJ8BvTB1xUzNTDYRnA2yagu
	 vv1CSenbNmg9D3Df3L/MqsrfWT0BxI99GgEDXejRfMrvPHCbh5CguOXP19dFEfVIhS
	 Zx7AwL4rlFB0Zx9/ZiYj1v2j8X5SzYLp+FPA7q/tnj/7wofU0/VDZjAecwHTEjzTeg
	 aQQGmvL63taD7AivA5PYqVWvcZ5mjfPN23OLTI+IDrGEGbmfQjp3xujFuVKtw8WvZB
	 GZ7HJAfi23Fcwa9qofH5QiIRcUIOQnwQNCfA0wI0FohXxjbo0Vo1RUYxcJGVaYkidG
	 prURk4982zgdBi8TY7qZDMDke1KnZ0F2luZDW2oJFO1FYawkInGaz/279T/JmtElNz
	 9mFxTqQhvy7Q0wmoL1PefuXQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 224E140E0185;
	Wed,  3 Jul 2024 23:07:29 +0000 (UTC)
Date: Thu, 4 Jul 2024 01:07:24 +0200
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
Subject: Re: [PATCH v2 1/9] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20240703230724.GEZoXZrIavchI2Kj-P@fat_crate.local>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-1-f927bde83ad0@linux.intel.com>
 <20240628080305.GEZn5uOSnW40fVgaNA@fat_crate.local>
 <20240628173209.wzpc6pwnw4p6u57h@desk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240628173209.wzpc6pwnw4p6u57h@desk>

On Fri, Jun 28, 2024 at 10:32:09AM -0700, Pawan Gupta wrote:
> On Fri, Jun 28, 2024 at 10:03:05AM +0200, Borislav Petkov wrote:
> > On Thu, Jun 27, 2024 at 01:44:06PM -0700, Pawan Gupta wrote:
> > > The hw_cpu_type is populated in the below debugfs file:
> > > 
> > >   # cat /sys/kernel/debug/x86/topo/cpus/#
> > 
> > What "below debugfs file"? A '#'?
> 
> That is the number of the CPU. If it is causing confusion, I can will
> change it to N, or say # means the number of the CPU.

Or drop that sentence completely.

For some reason lately it seems to me folks feel the need to explain what the
patch does. Even if that is visible from the diff.

> I thought about that, but the other fields are also printed without a
> preceding "0x":
> 
>           seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
>           seq_printf(m, "apicid:              %x\n", c->topo.apicid);
> 	  ...
> 
> I will change those too, probably in a separate patch.

Yes please.

> > > +static void topo_set_hw_cpu_type(struct cpuinfo_x86 *c)
> > > +{
> > > +	c->topo.hw_cpu_type = X86_HW_CPU_TYPE_UNKNOWN;
> > > +
> > > +	if (c->x86_vendor == X86_VENDOR_INTEL && c->cpuid_level >= 0x1a)
> > > +		c->topo.hw_cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
> > > +}
> > 
> > Why isn't this happening in cpu/intel.c? And then you don't need yet
> > another silly function.
> 
> I was preferring to keep the topology related code in one place. Would it
> make sense to keep it in Intel specific leg in parse_topology() as below:

I guess.

Although looking around this code, I wonder why is this hw_cpu_type part of
the topology and not part of cpuinfo_x86 directly?

struct cpuinfo_topology has all the IDs but the type? Feels out of place
there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

