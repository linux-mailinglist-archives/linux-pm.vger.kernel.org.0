Return-Path: <linux-pm+bounces-43797-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MIbGhWxqmluVQEAu9opvQ
	(envelope-from <linux-pm+bounces-43797-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:48:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BCA21F1D6
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78DAC30107CF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5EE371D0D;
	Fri,  6 Mar 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A7yjEwi+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5F34A794;
	Fri,  6 Mar 2026 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793983; cv=none; b=CDV3S2J17KDN5Z71gkocyURYo7vVy1YhQtUqv3RqoNr4+lnP35AtTVGLzqG85xNTCnxq0CNNT6W3XyX1Y55yHDu74+J9JaIucoId5gP+bGWXXwzf+ALWAmC2ao7xv5b2sgAscVO8eoH5x3rMwfCh1I1AzKIS8rLl4NVV8N93yc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793983; c=relaxed/simple;
	bh=DytPJVWYAm4Wg2/XbzEmYMNnO3h8berMMtkHIDxewNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVz0d+1pBcV0cOQzTPgVHMGRzNJ7YUyNl8W2GrCjoZQIELCft2Cur7K4vzDmkBoRzNh0Rx+3vJTHidMgKUwnbhR660b+yalusPrE0AE44hAYkjNrhb8EGvKHZq2LKfYBNsh1b6yRVL0fhCDDASl0YrDmt71o8/zM3jiiYf29IRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A7yjEwi+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E0E3140E0163;
	Fri,  6 Mar 2026 10:46:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4e4XMhoLWWGS; Fri,  6 Mar 2026 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772793967; bh=fJtwjIlBAjA3TEbIna0Icg3uhOYjYdlUmgEG9ABfNCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7yjEwi+/R7cEWbrAq8fgpwufGy5PswIB068+ZAmiIWH+q4IEzF+GdGNT07pkoGAo
	 vVOV+1xOMSPiaeUFW1fekxRz4QngvsPr2HQKBhvdYbBv+ItQbSWRr3SPGJ2qKOu3J6
	 1OVmigcJ1puHeNJb8Bemo2Bayath7IVWTYZBf4KqdIwyAaZ4LUOTpp908GELFn6eA0
	 Q4W2ozGOgvjMM75IPBsq/cIzqxHmZyy3v8YcpT1EZQQDbTgnn2TjOyXVwD4UtfDA7p
	 yft3WtVVf2wJcyv0eTmlX4pVL5K3COPjwjuZPdSXxdiCLqRRWDOk7ARgCIyztzNQMP
	 ONnP2zl04ECtczW00xiBiXVrgAK7e+o6R5DlpoyK0tT+oJIIaO67jAerRAY4X9cGgg
	 n4RSHsRlLPrhwuF1jX0LPCQJAnccqKbKlWoq1XGqf8ivIj5xGn7250Ah227kdIZt6a
	 oeIIE6x3C6GfmtNAt14A/PN7sWsQJO/Oa2RvFhgKgi0Y+aKC6miw8MbA51kJJLxiPe
	 +vbnzlX8ZsnESFG0ZVorFCSD2vwNxnHF7y0Dg+tByo53RvoKGivQA2cRUaMZREMRFn
	 B+Wube5jqSD9XA4nuAOtokDiVn46hml0Lc9rzO+2uE6haXTg2rh4egVEOt0rOiaKDb
	 li7xJC+RL2fGj/2bZ3GlWBj8=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 41CF240E0031;
	Fri,  6 Mar 2026 10:45:55 +0000 (UTC)
Date: Fri, 6 Mar 2026 11:45:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org
Subject: Re: [PATCH 4/9] x86/cpufeatures: Add AMD CPPC Performance Priority
 feature.
Message-ID: <20260306104548.GCaaqwXNcglOEfp5D2@fat_crate.local>
References: <20260306095753.17155-1-gautham.shenoy@amd.com>
 <20260306095753.17155-5-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306095753.17155-5-gautham.shenoy@amd.com>
X-Rspamd-Queue-Id: 57BCA21F1D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43797-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alien8.de:dkim,alien8.de:email,amd.com:url,amd.com:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 03:27:48PM +0530, Gautham R. Shenoy wrote:
> Some future AMD processors have feature named "CPPC Performance
> Priority" which lets userspace specify different floor performance
> levels for different CPUs. The platform firmware takes these different
> floor performance levels into consideration while throttling the CPUs
> under power/thermal constraints. The presence of this feature is
> indicated by bit 16 of the EDX register for CPUID leaf
> 0x80000007. More details can be found in AMD Publication titled "AMD64
> Collaborative Processor Performance Control (CPPC) Performance
> Priority" Revision 1.10.
> 
> Define a new feature bit named X86_FEATURE_CPPC_PERF_PRIO to map to
> CPUID 0x80000007.EDX[16].
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
> Link to AMD publication describing this feature: https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB
> 
>  arch/x86/include/asm/cpufeatures.h       | 2 +-
>  arch/x86/kernel/cpu/scattered.c          | 1 +
>  tools/arch/x86/include/asm/cpufeatures.h | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

