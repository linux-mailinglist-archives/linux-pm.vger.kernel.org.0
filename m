Return-Path: <linux-pm+bounces-10064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E99189F5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 19:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5EB1C22BB8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68518132B;
	Wed, 26 Jun 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZjhWgtUc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A74770EC;
	Wed, 26 Jun 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422315; cv=none; b=KM52UOO0Qn9LXaz7on0faZ8P6cDwWGAVZPQVjNlqozPhpHf5WbqPE7+L0CYYQkf1S3NgnWWRGHg1hr1zxCwGrcPWo0X4kaYv5KWqC+BJMOwCQRwpzlocBOrny0BFhXkDnayGd2Lq36X6ajE2LRi9g7k6WYNFETWE67JJFJ7guag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422315; c=relaxed/simple;
	bh=SexFv5uvmCnWZaonBJUzyDrpCZDiC/KDCHgeqXmYB70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwAZ9VoY63Z6WSvHKO2HJCimUWiQD9oCbZYy3H7JH/B/Doa8dAaR9YKkojfnv1xhAr5kUh74Nds3f7XK3EAW1wK0LsbXIRQBhT4xpJ/5dGg4bC+XaReEZF/7xhfY6l412aEMmErfYW/W1XlnvVHvb3FgZeaQMvlnMEqG403c5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZjhWgtUc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 287FB40E01D6;
	Wed, 26 Jun 2024 17:18:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DavOxnawIa1E; Wed, 26 Jun 2024 17:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719422306; bh=7B8XJHM0RLyNMSzggydaxYMecePsxUD/trZ6AyYpoXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZjhWgtUc6GU0pO03XDfJZDa3F40IM8FPCkiO5RxdYKV0/BfoOdHbya5QTjzsJDihz
	 uo9jssPDUxUUm0e2xbKwqMngXUAyxcGyABYzmjdc3V8yCBrzCrP6U3Kq8456moTO8c
	 CIUB5kkobih26gMMJm1RZk4veMOZRuHv9q1Qp8Zrp2nEUNNWQ1aR56nUPru+q7qYng
	 1ZAGxWWM/eZD5YiszOhTJc7XK5MBEusGwPSySEbf3cBaMjUOar7lWVyYSlL1I1WRVL
	 z9558Fp5ksAxtPbEogC+a/FEvm9qfFEG9e1SRaGSn6NWqWvasv4zrDjjNfDzWphAKa
	 dlcO8uGuzRt0UbyufioeP8CJFtNKBexkqcVgW3gEgeWSUdaiAGY6X+xouZM1aPUxmg
	 WB89zXNeWPSGtyDCwMqKZGkMFsmMZb9yUIwsUtIkHgdjeyIh+RRy8kGCbgLWQXVXWU
	 4sULKimP3RJd1vCrpyfnIZwkg5dAWuXMZ/INtVYnP6EQA7rNGL6Vfu/i14MFu5IgMg
	 W7xA+Km5b6l8xOmUO0SZQCo8/sbscbiBtFv/+hdGsPqnh9lLGeB3E61of0V0V8Ol6u
	 wvcx2qqVMk85dyMsDvEO+rE+pPoGqXJ09Pa/LXwkpYmFI1zEET5oEfK8LirEGI5vfI
	 J4r4B5ApwCwLDZpxvrRaleko=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D821440E021D;
	Wed, 26 Jun 2024 17:18:10 +0000 (UTC)
Date: Wed, 26 Jun 2024 19:18:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] cpufreq: amd-pstate: Use amd_get_highest_perf() to
 lookup perf values
Message-ID: <20240626171809.GSZnxNUd4tcRT4IB_k@fat_crate.local>
References: <20240626042043.2410-1-mario.limonciello@amd.com>
 <20240626042043.2410-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626042043.2410-3-mario.limonciello@amd.com>

On Tue, Jun 25, 2024 at 11:20:43PM -0500, Mario Limonciello wrote:
> +	/*
> +	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
> +	 * the highest performance level is set to 196.
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
> +		switch (c->x86_model) {
> +		case 0x70 ... 0x7f:

Aha, so here it is non-inclusive - "<" and not "<=".

So you need to check the model ranges first.

> +			return CPPC_HIGHEST_PERF_PERFORMANCE;
> +		default:
> +			return CPPC_HIGHEST_PERF_DEFAULT;

As for patch 1.

> +		}
> +	}
> +
> +	return CPPC_HIGHEST_PERF_DEFAULT;
>  }
>  EXPORT_SYMBOL_GPL(amd_get_highest_perf);
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 80eaa58f1405..f468d8562e17 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -52,8 +52,6 @@
>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
>  #define AMD_PSTATE_TRANSITION_DELAY	1000
>  #define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
> -#define CPPC_HIGHEST_PERF_PERFORMANCE	196
> -#define CPPC_HIGHEST_PERF_DEFAULT	166
>  
>  #define AMD_CPPC_EPP_PERFORMANCE		0x00
>  #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80

This already doesn't apply:

checking file arch/x86/kernel/cpu/amd.c
checking file drivers/cpufreq/amd-pstate.c
Hunk #1 FAILED at 52.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

