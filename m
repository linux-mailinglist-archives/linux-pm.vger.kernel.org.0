Return-Path: <linux-pm+bounces-16219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2279AA251
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 14:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8BA281EFD
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 12:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694919D88F;
	Tue, 22 Oct 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XzP8g4hS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FF51537D9;
	Tue, 22 Oct 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600943; cv=none; b=YPd2bMduKA3FtHAuy25dMlzHqTYG35cixJaJCXSdfV0HT5Rd0XvB9Hbwfr6Qtp9pbySwRWKybK36ElHE77Iryj9yvpy46MFQz8n6wCAs191WlNFOGnHsCcwVyVcYwYiDhGZ4qGvLoMDCi5OCBlD9/o1s33BkVYp2G+gnVNNyAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600943; c=relaxed/simple;
	bh=1kQcfUKxnnRlmnXvyy6slBbu3vdl2jGdNZ3GxflNNj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlHnCkodf5JVXauATxhUSKQoC/NqyehqMCtQWzn2zsWfkn+J5THcUlgG0boptWm6hu2+t/f1OmtT3PKnKGUu8vhDQE7oBc4y+j5394UyHbA5C+Sl1GV5UCLWUS/uQsdZnkwJP20Rry1+3wqj7Sr769/MsHJBo5t3ZC7GBbBvfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XzP8g4hS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1AC1440E01A5;
	Tue, 22 Oct 2024 12:42:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Fi1L2bCWqXrK; Tue, 22 Oct 2024 12:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729600934; bh=uJxSCGPq7YQbdE9Mu+T0q3ngzH3IdmXGlttiNKCmW8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzP8g4hSMY1EmnKgb9ZZeetJc2ihXoFpzd73W7opMH+3l4zvYJ6I3kGQ++KKmXSeQ
	 ruT21Kf2LwziCkVW8lB3jdVo9tQueJFHPwMLZdbhWWZCSeSXJRojFMqT71HwJfRrUE
	 Qb7MdLhzkjPdqh9wnx+3FgTHoNXWYVT8hJDV6pubpyfK2cx7DkEAUIuFjmVtZ1VC9s
	 UZtlehVA9DXgU5J2i9DfDX8QzDCaGhrEhy33yAts3KvJaHaTw7VjBm8b0So+ostCvm
	 Hh6HZgOhyza+BJ0/IvpUm23vAQZwt0wZY1/0TPjMg4sgghgaTu2Owi0C9o2rR5KROX
	 oylOIqozOGtq3CfjUTJAgxS8l9XqAZuugmXnykrh7bMn4C1iDytx6YEoEWFxJ3luTA
	 vKLPapd7IFxmodLt1IA5gIMYbiXygliKDCH4TthDemIAiyYb5IBz1wp2ZmFZqTg21g
	 HDSAr7XHL7Foqs3DcxvTZvGgKVx5GNnTOmAkrc/VeEIif0Of1Er3lVHEZbAa9a3rUZ
	 HM4mABNujdYR1VhAOVs0DOLkJsdb6NKFP1RkEZfYSFP+KDoll/HKRmP5qaxv/D6bUx
	 yJZkYDN66vjZ1ihKEDTkIzX409qfGp7n+k1tHtFntl//BzUHY7mtti8zq3pcX54uJF
	 4OKQj91xkXdlDWO0DzGaYM+k=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D47140E0198;
	Tue, 22 Oct 2024 12:42:03 +0000 (UTC)
Date: Tue, 22 Oct 2024 14:42:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v3 03/14] x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS
 feature bit
Message-ID: <20241022124202.GHZxedmqPeFd5F3sL3@fat_crate.local>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
 <20241015213645.1476-4-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015213645.1476-4-mario.limonciello@amd.com>

On Tue, Oct 15, 2024 at 04:36:34PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> Add new feature bit that indicates support for workload based
> heuristic feedback to OS for scheduling decisions.
> When the bit set, threads are classified during runtime into
> enumerated classes. The classes represent thread performance/power
> characteristics that may benefit from special scheduling behaviors.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index cea1ed82aeb4..3e8e67b8ec7a 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -474,6 +474,7 @@
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>  #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
>  #define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */
> +#define X86_FEATURE_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */

As already discussed: X86_FEATURE_AMD_WORKLOAD_CLASS

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

