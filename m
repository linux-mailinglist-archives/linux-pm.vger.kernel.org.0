Return-Path: <linux-pm+bounces-27595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32C1AC27E0
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266CB4E2A28
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D64296FAB;
	Fri, 23 May 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvE1PoZr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7122615;
	Fri, 23 May 2025 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018890; cv=none; b=U8MzXVIx93tGPXY6SKrI79A9eYn+0UmJMKsj/M5llJwSQmTu4ggm8FdKgskx5my1EuSaPsiTHjyi5dfoOIwrVoHPauZyQx2lB3wJGTXpwtgrxGmtCqeYW3930a7tQWOiZwNv+AsduKdMNrcz28Tx687jdcqQGyBMpIdXTPw0OPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018890; c=relaxed/simple;
	bh=PZpAHwYrcPuUCRCaGR3Jo/gEvfrWsNn5zlIZCtHLSDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7Ddev5DQxrcfDY40tiMWSidpr/a1UgxqLMtAplfjdwtMro6Ul39ezEpVxOnmkSQrEWwJQqVUrE6fbX1ot9UieWWUMziP/Gb29y7FgKwQGYoukn8QOssZUbGElKAxVgzgyLpoLjmV2cc5UMzxwxAwrW5o4aiOjdVc0zqn2tMVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvE1PoZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B52C4CEE9;
	Fri, 23 May 2025 16:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748018889;
	bh=PZpAHwYrcPuUCRCaGR3Jo/gEvfrWsNn5zlIZCtHLSDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvE1PoZrhCWD723d2BE3uwTJGuU3kvTVAHDTNWgYbget26l0n35rKFf3MJp/ClZWk
	 QYX41hESpbYSuUbUe+WU2o7zTO3sVA+Zo2bBh/6TWq1lenze6hTfidM1OkcGN6QK/+
	 o3Zml1SR5Up87fVhlEhVbsn/OnFzw4+/yV9LjCQk5At1alhFJ6oTPOIAi9VWiCK624
	 wzc3DnJyJGWVv34pojIZxGTz/8bgIyKQ8eMVFqtWNzdOujHbH5nw/TSvdlqGzZspr2
	 pBLnq/Vq1X5LMruN44Ae7PtXyXQCF3rnGBeEaVg6Vv8BblFBo490ZDM0zow1rlVlbF
	 R/feyrR84OYqw==
Date: Fri, 23 May 2025 06:48:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
	viresh.kumar@linaro.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, hannes@cmpxchg.org, surenb@google.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <aDCmyEGIpPv6ggF1@slm.duckdns.org>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523164348.GN39944@noisy.programming.kicks-ass.net>

On Fri, May 23, 2025 at 06:43:48PM +0200, Peter Zijlstra wrote:
> 
> Due to the weird Makefile setup of sched the various files do not
> compile as stand alone units. The new generation of editors are trying
> to do just this -- mostly to offer fancy things like completions but
> also better syntax highlighting and code navigation.
> 
> Specifically, I've been playing around with neovim and clangd.
> 
> Setting up clangd on the kernel source is a giant pain in the arse
> (this really should be improved), but once you do manage, you run into
> dumb stuff like the above.
> 
> Fix up the scheduler files to at least pretend to work.
> 
> (this excludes ext because those include games are worse than average)

Yeah, ext needs to move the stuff that's shared between ext.c and ext_idle.c
into ext.h. cc: Andrea.

Thanks.

-- 
tejun

