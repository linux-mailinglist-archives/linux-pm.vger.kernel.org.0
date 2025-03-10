Return-Path: <linux-pm+bounces-23758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F656A591DB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 11:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFDA3AE765
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9C722A7EF;
	Mon, 10 Mar 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jr1ZkYkJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36722A7EA;
	Mon, 10 Mar 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603761; cv=none; b=ZqldcqDmfJIfMZAiWPrm1kq3XZvbBAV3ZzJ2QfzPAGep8o9WgR+boctw+Eq5RmezUu1fLBWYy5eaMj1b0hDehR8Z+sWwGilF8BCvg/8bkRiN5oDvF9pPiT2H/YstoJRJ+KCjF/y68rjTBzM5lsxmcGBz/K2SPSX5iGmTAqnY+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603761; c=relaxed/simple;
	bh=8OTdGJQCtFjQymUwSNIHy++1HlxocMtdJ+1/0VU2Id8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8yEKjv+5yTpXloSI1rjvtZKDNJEDBW6OK8MN4430xEObGE5okmtUcDjtwve8yyZm8gJHpvIqDvClRdcHJXCyphEBCkwclBN9xgBop2ImZTZoZFdBWLufCP98LIvTE1G16snUDncgpNEvERoE37MgI/P+vwhmhIcZzinJMr35do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jr1ZkYkJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 16E9F40E0202;
	Mon, 10 Mar 2025 10:49:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kiTctQKvuhkz; Mon, 10 Mar 2025 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741603752; bh=LreVgI+fx8En+wOY6PpZOizm2j4hFPvgajwvgyqZjvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jr1ZkYkJODuKKKz3ecmLV/cToLxxR+jcoEw908mhdRAHWsYl+QXE7iTeasvMKekWW
	 6/VKPweooryO7m6pG3OE+RCL2SluTzifafzMHw2IXeEqs50Y0W7K59WP87x9R8tCy9
	 nIs/q1flM6Io/S2D7EQl78Lg6EgKyjC9GvsZZ5ULffc7HvzyBp9TNU4G7MLeefHPwi
	 4BPIatkELStcsTgirh8zgm7eMuSYHYmBoue9G5qF+0i3/h0TgT7Ymcvdda0TH52jL+
	 LZJnMBD4DNO83NK1rJUAbo1iaq3+E/ouL8iWwfTCGv4ygTqKP4CinxRCOMiL2iaehV
	 3BtKOoMGNmdMmlmbP6ZA5f6Cj3z2OC0bz3aJIsSsK3c1zNXBEqbfwmQ1Q8QAvLqC2X
	 FlHHiz5X+yZIXP4i4oC7GpmK0PKOM2g4zw4aXSiUGCqdpV4fLGap+Nnwj7QXNkx+fh
	 pgtDIznhegSFGLpDZVDQotdSy5qituCGbDJLpsDTBxkv8m2NIQIyvvyxdau+X47XKt
	 Lv8Q8rVPSNVr+ItXiZyRC5+Y5ENxEm7PSqNa11df/60Wk/hdUQ+Sr6Tv3VzsTpcnOI
	 JnMitX3W/NBWedocm/fdWJK3MvY5y7QtVbwZm6GoQRNimTPtB2vBQOCZoo89Sdua+f
	 I3AogolXHzuv7Yy3p8oDgvoI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E0FC40E0176;
	Mon, 10 Mar 2025 10:48:52 +0000 (UTC)
Date: Mon, 10 Mar 2025 11:48:44 +0100
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
Subject: Re: [PATCH v7 3/4] x86/cpu: Update x86_match_cpu() to also use
 cpu-type
Message-ID: <20250310104844.GDZ87DjFQef8GaREqg@fat_crate.local>
References: <20250306-add-cpu-type-v7-0-f903fb022fd4@linux.intel.com>
 <20250306-add-cpu-type-v7-3-f903fb022fd4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250306-add-cpu-type-v7-3-f903fb022fd4@linux.intel.com>

On Thu, Mar 06, 2025 at 06:18:36PM -0800, Pawan Gupta wrote:
> +static bool x86_match_vendor_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id *m)
> +{
> +	if (m->cpu_type == X86_CPU_TYPE_ANY)
> +		return true;
> +
> +	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
> +	if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))

check_for_deprecated_apis: WARNING: arch/x86/kernel/cpu/match.c:25: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

> +		return true;
> +
> +	if (c->x86_vendor == X86_VENDOR_INTEL)
> +		return m->cpu_type == c->topo.intel_type;
> +	if (c->x86_vendor == X86_VENDOR_AMD)
> +		return m->cpu_type == c->topo.amd_type;
> +
> +	return false;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

