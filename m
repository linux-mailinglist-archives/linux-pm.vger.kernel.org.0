Return-Path: <linux-pm+bounces-17511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DB09C78AE
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 17:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD65F1F22A6F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25F137C35;
	Wed, 13 Nov 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AUuiZ1QA"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA7158D93;
	Wed, 13 Nov 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514951; cv=none; b=ndI9GNPeL571BlXdlFfDaIc3IAkWO0XRafBvIjdDZf6FX+YBi6RE8Fji5HxIiVQd5ix9H8g4Stl+rJWuXz3uuzIspDm1sWoKVoBmljEpEr+g5z9Q0qxXBJe/ckyO43xP+01w0wVigKXG4CgtET+CEhZotb+k/JiUrdIh9IeJuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514951; c=relaxed/simple;
	bh=wRXrQyEMIxSaRO7QlWckGwYMTTVH9vgI4BRy4j+ZeSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojuDzV2jJ1y9GrDL8SnGe8hPDAToM4XsgUCXpS7NRU6Ang1SxnGgf5v5GVzvPGUPmxDspurOzdZjCNrvmeUBXTu5hvzq0vYyjXohvwn5u8XRAe5a6gcGqhnn8rw2hkEbhrEQgul+17gkKrqc+OT+xHqfNGRX3GUcz0AEOOtjU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AUuiZ1QA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rz7Jya3dMG2jD7v6BkNvM8DZMoeHNtSrp4WK4Q/pQ9w=; b=AUuiZ1QAnsyHhOh6HqwLF2kpzH
	++q/niIaM/PzR5LE8+cCjsg4TJ7ehyf5VGSiW8iHFPWQg1KUX9ipy0DfUNU4Vpmrc8q+bmJme+OBW
	+gwCujH8L8zpYc5X4gHgEx42fVKMRZoBCZnTt+lSyuNqg8idjzo7QRTvFtT0aCnQkk2elA6v41Xsd
	J1fMkDEXTOzM46jZMmwTJ/deanrXiMQCQuWBlkUGlyki7ft899jB/13vPnaH2QpWgGvHgHjLyChm+
	GHLCJm/YeBmTpXqY/sg2V987o5BbICXjeXugO5SgD2a+5TFv4/xJOA/bSBgA0xGDHbZgysO83vmco
	GRYfELIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBG8N-0000000DMcS-2hrD;
	Wed, 13 Nov 2024 16:22:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63A8F300478; Wed, 13 Nov 2024 17:22:22 +0100 (CET)
Date: Wed, 13 Nov 2024 17:22:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241113162222.GA24625@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net>
 <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>

On Wed, Nov 13, 2024 at 05:11:38PM +0530, Gautham R. Shenoy wrote:

> How about something like this (completely untested)
> 
> ---------------------x8----------------------------------------------------
> 
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index f3ffd0a3a012..bd611771fa6c 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -215,6 +215,24 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
>  }
>  EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
>  
> +static int acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +{
> +       unsigned int cpu = smp_processor_id();
> +       struct cstate_entry *percpu_entry;
> +
> +       /*
> +        * This is ugly. But AMD processors don't prefer MWAIT based
> +        * C-states when processors are offlined.
> +        */
> +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +           boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +               return -ENODEV;

Are there AMD systems with FFh idle states at all?

Also, I don't think this works right, the loop in cpuidle_play_dead()
will terminate on this, and not try a shallower state which might have
IO/HLT on.

> +
> +       percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
> +       return mwait_play_dead_with_hints(percpu_entry->states[cx->index].eax);
> +}
> +EXPORT_SYMBOL_GPL(acpi_processor_ffh_play_dead);

