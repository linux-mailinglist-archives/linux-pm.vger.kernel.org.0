Return-Path: <linux-pm+bounces-10065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DE89189FE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6081C2273F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53FF186E37;
	Wed, 26 Jun 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JWZiz0OF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D517FAAE;
	Wed, 26 Jun 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422462; cv=none; b=KuuMVRnSsIPK/txGSCp6fzIg8jy+GdaG5h8LClHL6xRxHBKZC3fwNEoUrzuHCeO+tIzNUGAaW6E4rchCz+CzDCa2UkbTkQyc7P06NjuzMBxhx2fm09m84qsfpop3/GkeY46e1LC4AS5L+y2tzANFV3OoCdds7n+4vEZ/Nt6hjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422462; c=relaxed/simple;
	bh=LPOu4xLWz0iufE4AOQosfGDmN14Ha0iB0K8zPuR8alA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jegh+iTUQzcn17m3HM+TkItKutLeoIL6uMfrwdsC6mChfKz/B/Je/KIbuG+s9FGVYaKrtV4BAp7g5ktJapKaFpzBehje6/MYtnmHI3chGaZy9vOCqryNbWVaAwbiPiLbLz+bM5Pu/OadAgzz8VlAUDnUS4kY0o9ffJT2Df21lZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JWZiz0OF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1FC3440E0185;
	Wed, 26 Jun 2024 17:14:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iHP5c9MTlWuM; Wed, 26 Jun 2024 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719422082; bh=du9baA4/tM06ftN4VOOSwZJhxvgB1fJD5Bf/wvADGZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWZiz0OFmSHoJHwCwJEyy1t1cPjbvBZ6Zop2rhvgGNQ5oKQwl2ER+QH6Fj5vgpObg
	 X10Z5mZhBkh6CY25fgZyUZtIeCjQoSYksN772LiS3W9qCKAYF1WoGrQxcoF2PuRZeE
	 hW1zAXJW/otdvYxdHghU5cYymsjXJPX0b3mYZQv4WHpnDRaz1IX2QShgMgyEEl+5rc
	 0z2Z/JvYWxZGteCV3e2qVsWrYqero/mukCV0OFZr1FR5dwKtrLE9rYK6NnST4uIAed
	 knMdg3tbhEaawkJPW/CrdovL6E/7Bbt9kUWGLbEy5eP7zr2vS2WQxAM3Kcg2sSjWxH
	 J5+Ck7fdKwizKzu6H1NJypUsoUwHbbfyJLug+RCawxAHmZ6zKLTOBu0moymczjeS7y
	 Jq9UxOB18kb88RaUejmqvr6zMXuOwn0Z9clvNS8302sb8EHG5qrqElc38haqtxQE/Y
	 3Z6WJqZ42w6Y3qZ1GLzH+ZJPQQljR8ImkO8soXrccHqfORVlL7nxy5GWfZ8KPV4/Rw
	 OBolqH0NOmVUrFqkjyVGx07/XaDz6hS3Dv1bXCpcVmhxI2pzyf0T7qEawnV4q56Sdr
	 j0ha4L/26SNbiJeDCk8MpAHghZ+YpVDXUHcfEoK2fCPgQTboJj5juTwoMcwGI/2CR5
	 CpQjz6umQIwTfDKeyIvQt56E=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79FFD40E01D6;
	Wed, 26 Jun 2024 17:14:27 +0000 (UTC)
Date: Wed, 26 Jun 2024 19:14:21 +0200
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
Subject: Re: [PATCH 1/2] x86/cpu/amd: Clarify amd_get_highest_perf()
Message-ID: <20240626171421.GRZnxMbcI83xe1SLtB@fat_crate.local>
References: <20240626042043.2410-1-mario.limonciello@amd.com>
 <20240626042043.2410-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626042043.2410-2-mario.limonciello@amd.com>

On Tue, Jun 25, 2024 at 11:20:42PM -0500, Mario Limonciello wrote:
>  static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
>  {
>  	u32 gprs[8] = { 0 };
> @@ -1194,15 +1198,27 @@ u32 amd_get_highest_perf(void)
>  {
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  
> -	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
> -			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
> -		return 166;
> +	if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
> +		switch (c->x86_model) {
> +		case 0x30 ... 0x40:
> +		case 0x70 ... 0x80:

Well, it was < 0x40 and < 0x80

You're making it <=.

> +			return CPPC_HIGHEST_PERF_DEFAULT;
> +		default:
> +			return CPPC_HIGHEST_PERF_MAX;
> +		}
> +	}
>  
> -	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
> -			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
> -		return 166;
> +	if (cpu_feature_enabled(X86_FEATURE_ZEN3)) {
> +		switch (c->x86_model) {
> +		case 0x20 ... 0x30:
> +		case 0x40 ... 0x70:

Ditto.

Also, ontop:

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 73559db78433..5d496de4e141 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1204,7 +1204,7 @@ u32 amd_get_highest_perf(void)
 		case 0x70 ... 0x80:
 			return CPPC_HIGHEST_PERF_DEFAULT;
 		default:
-			return CPPC_HIGHEST_PERF_MAX;
+			break;
 		}
 	}
 
@@ -1214,7 +1214,7 @@ u32 amd_get_highest_perf(void)
 		case 0x40 ... 0x70:
 			return CPPC_HIGHEST_PERF_DEFAULT;
 		default:
-			return CPPC_HIGHEST_PERF_MAX;
+			break;
 		}
 	}
 
so that you don't have so many redundant returns in the function.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

