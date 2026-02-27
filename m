Return-Path: <linux-pm+bounces-43278-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDgtNaoMoWnKpwQAu9opvQ
	(envelope-from <linux-pm+bounces-43278-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 04:16:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C821B2355
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 04:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBFD3304890F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 03:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF3731618B;
	Fri, 27 Feb 2026 03:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/HKST8Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6331579B;
	Fri, 27 Feb 2026 03:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772162213; cv=none; b=BxBzStAN7ms8Czj+VhSJux2JIjcBrNk87GTYYNfU4ydY/XW5DTHdUELwCLG3wdM86PawAQw+3GKKyA4OV4y/+Gt49lvS+KyVMtPAQ9cUBrOATVxCwP4ZDNt/wcywenF2r+6vB3ixWlwyr+KiRmg06rsbv8Gxh6rJYvlmPv41yps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772162213; c=relaxed/simple;
	bh=l/x+SslV9KD4aN1B2IMBc45O+k7OaTfXrctuTn7I+8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz57DyuQPWecv5Cjb3mLTmViGnZF/WxQfkBhep1wakA0ITtucoURNstI1Sch5RzgrYPgRecUvwdE8JzCP7HJ5c+ChEV8GL/N3quJfVAQZQPoG2MNMUylnG2E8P3iGV6nIgy4R/4VlfbZ9/6GKSXsZ+Y8fhMpJMXAX6LHVclDIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/HKST8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C348DC116C6;
	Fri, 27 Feb 2026 03:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772162213;
	bh=l/x+SslV9KD4aN1B2IMBc45O+k7OaTfXrctuTn7I+8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/HKST8Y6wr3ZSZrfmxHrejzzivf/NjIohwd2a3J9Qqj9mgUwPrCx3pW62RJQUs9q
	 c2OnPCqJvRkqQr+oIApmYN0tHCkrJJ383gLuk2c/rR9I5b6Rind4bjtC+/6ejiU4AE
	 wQSixOtEFiMbBMdBrSw7zrSslZzlwsBlMw1+o2gRee+4pzPomKLn9uRJpN7TE8rCXg
	 fUiN0zaduC9Zt75gHOQ/NXkrvHDVyJVkjD01Syd2oLLFWqsM6s1gdVYq6H3uCJJKWE
	 20MqN53maWu6FL7JlawqZymSl+kWxn9QwM2wk9W++cU41mj0kG23fGJ7OZfP3PCHoc
	 nLIMbyPlQCCPg==
From: Will Deacon <will@kernel.org>
To: maz@kernel.org,
	catalin.marinas@arm.com,
	zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com,
	viresh.kumar@linaro.org,
	rafael@kernel.org,
	beata.michalska@arm.com,
	pierre.gondois@arm.com,
	ionela.voinescu@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Sumit Gupta <sumitg@nvidia.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	treding@nvidia.com,
	jonathanh@nvidia.com,
	bbasu@nvidia.com
Subject: Re: [PATCH v3] arm64: topology: Fix false warning in counters_read_on_cpu() for same-CPU reads
Date: Fri, 27 Feb 2026 03:16:33 +0000
Message-ID: <177213043642.532827.17183331792162476258.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226115911.1664285-1-sumitg@nvidia.com>
References: <20260226115911.1664285-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43278-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm64.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3C821B2355
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 17:29:11 +0530, Sumit Gupta wrote:
> The counters_read_on_cpu() function warns when called with IRQs
> disabled to prevent deadlock in smp_call_function_single(). However,
> this warning is spurious when reading counters on the current CPU,
> since no IPI is needed for same CPU reads.
> 
> Commit 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in
> ticks for non-PCC regs") changed the CPPC Frequency Invariance Engine
> to read AMU counters directly from the scheduler tick for non-PCC
> register spaces (like FFH), instead of deferring to a kthread. This
> means counters_read_on_cpu() is now called with IRQs disabled from the
> tick handler, triggering the warning.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: topology: Fix false warning in counters_read_on_cpu() for same-CPU reads
      https://git.kernel.org/arm64/c/df6e4ab654dc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

