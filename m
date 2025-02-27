Return-Path: <linux-pm+bounces-23070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A622A47E07
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 13:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E56C7A1ACB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF3D22B5AA;
	Thu, 27 Feb 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poRx7moo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2002222BA;
	Thu, 27 Feb 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660068; cv=none; b=QIBUywo7o6s/TRilaEzz9VUFuD7/8qfxjS2nQk3VCnf5y2lkCBk6EgCRggW0hs6LRffGq6bB7eSfnXdWA42BjfDTmSgvYfXijnTQxB1E51udLC9Exe8+UdrzbcIy36tIbvSbBOETGvfNdQ6aI3ui+7TCnUBQB7fb9wj/r7hIUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660068; c=relaxed/simple;
	bh=clTY2DhKXaIau5bqN5x95Ml2RvXkljWrTu52oXUq7jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWqSqEimBXnMb/C0oaapUOsW6R+fRkABJAZ1yi5o9Gd9goY6Cxj7MEeEv4bWpzytih+5yGFXhJXw9T73QRZTuU0xvxD7QAkN++utqcpwp63KtpyGalCIuYufP36KIhWgBWbGShtGGEabDd6pJf13SGuWAQEyVSdz/ZCyvaECpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poRx7moo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A41C4CEDD;
	Thu, 27 Feb 2025 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740660068;
	bh=clTY2DhKXaIau5bqN5x95Ml2RvXkljWrTu52oXUq7jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=poRx7mooWeZXdtMsDmxPP24HXIvG/d/MDBCdwVFG8WzeoqUpldtwJcCvAdpKBGccP
	 8h68A3r7yvnhaBBhrPY4JYuiBcU1P/PTPLcF64T5/aSG33ueLCfsSSslQlJqWsueEA
	 xdOl9KlMo45oj5n83E9mMYMcOJmZLfLsKWfJ9CX+yOWlQUcpLNQZ4rAZ3W+0/grBWt
	 YI6Yt4MmjHFpM/qOlAcCsSCsOS9X5ptgv8BFqSdG6a/yDzmcJJp8owDwDU3qzhR8a5
	 QqVolCL8+wMkoc6y2YLezfQuhDfJTWnWuWcOd2ovg55B8bYR/SWO3YM/RZOI8M4Oj8
	 KAsw8SGK4wGoA==
Date: Thu, 27 Feb 2025 13:40:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5 0/9] Utilize cpu-type for CPU matching
Message-ID: <Z8BdVzJKbxheqvme@gmail.com>
References: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>


* Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
> Pawan Gupta (9):
>       x86/cpu: Prepend 0x to the hex values in cpu_debug_show()
>       cpufreq: intel_pstate: Avoid SMP calls to get cpu-type
>       perf/x86/intel: Use cache cpu-type for hybrid PMU selection
>       x86/cpu: Remove get_this_hybrid_cpu_*()
>       x86/cpu: Name CPU matching macro more generically (and shorten)
>       x86/cpu: Add cpu_type to struct x86_cpu_id
>       x86/cpu: Update x86_match_cpu() to also use cpu-type
>       x86/bugs: Declutter vulnerable CPU list
>       x86/rfds: Exclude P-only parts from the RFDS affected list

So it looks like this series, despite being complete, fell between the 
cracks during the usual end-of-year distractions.

To get the ball rolling I have applied the first 4 patches to 
tip:x86/cpu - the cpufreq one needed a small conflict resolution, and I 
have adjusted the debug output of the first one to not break 
pre-existing vertical tabulation.

Mind double checking the result in tip:x86/cpu and submit the remaining 
5 patches on top of it?

Thanks!

	Ingo

