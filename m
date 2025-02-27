Return-Path: <linux-pm+bounces-23130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A78A487D1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 19:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EC43A2C4F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E21F585B;
	Thu, 27 Feb 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkkOkGnE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3C1E521C;
	Thu, 27 Feb 2025 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680948; cv=none; b=h8Hr9gKF+yAvliYJdqbu7embnoXHfzZLxDRThhA/VL9EaPX+ilHfV9Uu+ou57o0UAMP3aAsGPdW3kTeMSE42cCmEOz/4/cB19qdeMZaRbuf6F3ZnxT1zaOh+O4V4p72QIL/vsluvkd3IEYtuOlPD/1noQ8015TJig0Mq5Hjdw2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680948; c=relaxed/simple;
	bh=sVmoa+4UUba17FV2KXIDm1zoaJ2r3ry/WGxnUkYFfPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myvqSFpVgxasf9UByjsaNBffj4a2aHgSAncACq/FxH72WahWAE8GqfNpwA4b5/hBTghK11G4Of/PkuFc646mNHRHK2nXDKc/uwTq5I6H29FOFp6jPfDXHOkONjromEoALUMfwWzHhpyW54nAj8+rFldqJebPbWiE7AvIKixA0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkkOkGnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB7FC4CEDD;
	Thu, 27 Feb 2025 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740680947;
	bh=sVmoa+4UUba17FV2KXIDm1zoaJ2r3ry/WGxnUkYFfPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkkOkGnEx56q945Szz4n+ofUXjHKm9fq0zgW1UZgiXq3ZkyFT+BNip1rviCNKJnf8
	 RQuKIKgtdjUJ9lITpNTiK9pRPwQvF9PlkKqAEQbEtbOo98XOKgC/XaLjhxLy4Yja4N
	 slBWxxW4f9nvMo2A0gYNIwn/ujKh5yNthy3RrzYWmm2sd6jNR8E3tEZQChALH2zcYZ
	 hVeVwzGivPw6OrdjcOa+GGk2VKBNZWMt5LelAjL9krQ6rJ9/ljN+7fwLLW+RxkeRZl
	 GEqW+QKYLbOYOAOtOXQl+Jjw8tee33S4MEWvvtXSmvKGPePPF0TGDW0td5abjSiq8Z
	 c2Ynw44kbx1yQ==
Date: Thu, 27 Feb 2025 19:28:49 +0100
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
Message-ID: <Z8Cu2VJhDhum9mXd@gmail.com>
References: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>
 <Z8BdVzJKbxheqvme@gmail.com>
 <20250227175129.v23sm56tkxcnlqvz@desk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227175129.v23sm56tkxcnlqvz@desk>


* Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> On Thu, Feb 27, 2025 at 01:40:55PM +0100, Ingo Molnar wrote:
> > 
> > * Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> > 
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > ---
> > > Pawan Gupta (9):
> > >       x86/cpu: Prepend 0x to the hex values in cpu_debug_show()
> > >       cpufreq: intel_pstate: Avoid SMP calls to get cpu-type
> > >       perf/x86/intel: Use cache cpu-type for hybrid PMU selection
> > >       x86/cpu: Remove get_this_hybrid_cpu_*()
> > >       x86/cpu: Name CPU matching macro more generically (and shorten)
> > >       x86/cpu: Add cpu_type to struct x86_cpu_id
> > >       x86/cpu: Update x86_match_cpu() to also use cpu-type
> > >       x86/bugs: Declutter vulnerable CPU list
> > >       x86/rfds: Exclude P-only parts from the RFDS affected list
> > 
> > So it looks like this series, despite being complete, fell between the 
> > cracks during the usual end-of-year distractions.
> > 
> > To get the ball rolling I have applied the first 4 patches to 
> > tip:x86/cpu - the cpufreq one needed a small conflict resolution, and I 
> > have adjusted the debug output of the first one to not break 
> > pre-existing vertical tabulation.
> 
> Thanks for picking this up.
> 
> > Mind double checking the result in tip:x86/cpu and submit the remaining 
> > 5 patches on top of it?
> 
> I had quick look, fixes and merge resolution LGTM. I will submit the
> remaining 5 patches soonish.

Thanks!

	Ingo

