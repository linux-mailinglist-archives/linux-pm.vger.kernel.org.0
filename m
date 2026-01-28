Return-Path: <linux-pm+bounces-41614-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMnbL2kJemkK2AEAu9opvQ
	(envelope-from <linux-pm+bounces-41614-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 14:04:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC23A1C61
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 14:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CB18300DD78
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CBD2EC57F;
	Wed, 28 Jan 2026 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFA5ETdw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C32D780C;
	Wed, 28 Jan 2026 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605464; cv=none; b=kZ38h7Ab112EKxbh8z340RERf52TopcFg0fL86lq9X1xT8C+9HeKEBGgdjep3ckbWDn1Yk5FQzApAlOIdVV3fMifBLcT8iLPD7RpQexQuYkf2gJF3UqKn5dz14Yd4JWR34aIBncA05k6yFjizxgkZlNiy0/HY1rOe0qSwVfIh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605464; c=relaxed/simple;
	bh=xE4iu5iJ6zbcF/HPfqdjVHU/BxKxQM4masrNQBgrmsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j100GUE04u50hhCuPRmoJLa8yqX8UGYZhZwOZtOUQmIk0YsMC1dgCDgH5AR45lWu6/DkMSaEnNNejlpAc5tQwfOElRC1QY/61DvX1I2UvBNyidsHWuhRkFzIpwfTymGr2Ovx6AtCbOgryjck1ecG+WIyxUJKxHP7A20WEgJol38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFA5ETdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5123C4CEF1;
	Wed, 28 Jan 2026 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769605463;
	bh=xE4iu5iJ6zbcF/HPfqdjVHU/BxKxQM4masrNQBgrmsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFA5ETdwvJ0U9pyb9idC0lLtra94o6Jh1gMklmr1DJMd2IrIVz/BLzGF9hKz1CAHo
	 MPufivEwXiyFoxslljmNmMYZKKq2fnX4JY+LlsuNQ59P/Ce4ky4qomb7rwM4x6wlPt
	 KD1hYpmcS4bmgMJnOP3Pjj3Hq+4HWQesJIDNP753V5ByihljUbBxxp5AUJSXqAN/Q/
	 +Gisk9UH4Jxm7G/xCVXoG5cgxRP7Uw+rJXzb54A5s/JWfJOGNuKdeuldp/uBjX/UGa
	 BcCXYLAcPngOozhGonxzxhrQCRJ2/CcH8bcxjA8evYOmJwSQDzYHtQNxTivdetu69T
	 O282PvT1er2Nw==
Date: Wed, 28 Jan 2026 13:04:17 +0000
From: Will Deacon <will@kernel.org>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Sumit Gupta <sumitg@nvidia.com>, catalin.marinas@arm.com,
	zhenglifeng1@huawei.com, viresh.kumar@linaro.org, rafael@kernel.org,
	beata.michalska@arm.com, pierre.gondois@arm.com,
	ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH] arm64: topology: Fix false warning in
 counters_read_on_cpu() for same-CPU reads
Message-ID: <aXoJUYDrhuJgkXEr@willie-the-truck>
References: <20260127080700.3565546-1-sumitg@nvidia.com>
 <3c6d58b2-b4c9-4dc7-a705-b7626e127f33@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6d58b2-b4c9-4dc7-a705-b7626e127f33@hisilicon.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41614-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,hisilicon.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EC23A1C61
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 06:50:42PM +0800, Jie Zhan wrote:
> On 1/27/2026 4:07 PM, Sumit Gupta wrote:
> > The counters_read_on_cpu() function warns when called with IRQs disabled
> > to prevent deadlock in smp_call_function_single(). However, this warning
> > is spurious when reading counters on the current CPU since no IPI is
> > needed for same-CPU reads.
> > 
> > Commit 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks
> > for non-PCC regs") changed the CPPC Frequency Invariance Engine to read
> > AMU counters directly from the scheduler tick for non-PCC register
> > spaces (like FFH), instead of deferring to a kthread. This means
> > counters_read_on_cpu() is now called with IRQs disabled from the tick
> > handler, triggering the warning:
> > 
> > | WARNING: arch/arm64/kernel/topology.c:410 at counters_read_on_cpu
> > | ...
> > | Call trace:
> > |  counters_read_on_cpu+0x88/0xa8 (P)
> > |  cpc_read_ffh+0xdc/0x148
> > |  cpc_read+0x260/0x518
> > |  cppc_get_perf_ctrs+0xf0/0x398
> > |  __cppc_scale_freq_tick+0x4c/0x148 [cppc_cpufreq]
> > |  cppc_scale_freq_tick+0x44/0x88 [cppc_cpufreq]
> > |  topology_scale_freq_tick+0x34/0x58
> > |  sched_tick+0x58/0x300
> > |  update_process_times+0xcc/0x120
> > |  tick_nohz_handler+0xa8/0x260
> > |  __hrtimer_run_queues+0x154/0x360
> > |  hrtimer_interrupt+0xf4/0x2b0
> > |  arch_timer_handler_phys+0x4c/0x78
> > |  ....
> > |  CPPC Cpufreq:__cppc_scale_freq_tick: failed to read perf counters
> > |  ....
> > 
> > Fix this by calling the counter read function directly for same-CPU
> > case, bypassing smp_call_function_single() entirely. Use get_cpu() to
> > disable preemption as the counter read functions call this_cpu_has_cap()
> > which requires a non-preemptible context.
> > 
> > Fixes: 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs")
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> 
> Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> 
> Looks fine for me except for the minor comment wrapping.
> 
> Thanks for spotting this.
> I may have missed the warning log in the FFH test.
> 
> This happens during the short window in cpufreq_policy_online() between
> driver->init() and the CREATE_POLICY notifier that gets AMU FIE ready.
> After that, CPPC FIE will be stopped.
> 
> Ideally this can be merged together with Viresh's PR since the CPPC FIE
> changes are there.
> https://lore.kernel.org/all/j4qdid7iqmng4gzb5ozefemjkep3wx2b5z2yki5tnqc3vzvzf4@kvrnarvdod5p/

Right, looks like this should go via Rafael but if it doesn't make the merge
window then I can pick it up at -rc1 (please remind me :)

Will

