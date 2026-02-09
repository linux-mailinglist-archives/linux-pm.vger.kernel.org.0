Return-Path: <linux-pm+bounces-42323-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMtoExJPiWmb6QQAu9opvQ
	(envelope-from <linux-pm+bounces-42323-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 04:05:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF68710B4CD
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 04:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3666D3009F1B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 03:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A222F6931;
	Mon,  9 Feb 2026 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGqniBRk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649082F5A3D;
	Mon,  9 Feb 2026 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606347; cv=none; b=FJq5quzX/LXyuTbYCu19HOzmsEKs6QF1iN3CLflesnT3cTV7mRUOQ649oB7UHSVZuBZMxe4HBZS3f/TOkzA3eVpdKVe382TxbkMqq0y7cd8gZnL02Mmrm+fJbPHPX1Jg1qEHNSRo74U6Fh8C3Wi7142p+t8nLlfGpsAtXRzwcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606347; c=relaxed/simple;
	bh=vvMHAN6L2tVEAL6dEZf2ykF+FEIUVDPhLofe2WZoOhg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pFqBBXW0ApfAGJE8P9yRUfikwedVM2EwCe/HUzmeTdGYywkDpXmpPHan/lW3mEHxt13onHsaYlfq+el/K4BWY61/MAJRGZT11kxjwQXB/nka1/OOc3zODwIMRxuRhKXNXXwy2Tpm/PpQDmyUWDxH429a5UUnXYvrt+0Qc8xFx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGqniBRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C1CC4CEF7;
	Mon,  9 Feb 2026 03:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770606347;
	bh=vvMHAN6L2tVEAL6dEZf2ykF+FEIUVDPhLofe2WZoOhg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EGqniBRkII1k0v2zEcVrgvvp1RGHn5x1yku3AM9oRO7ltwSd5Hx059aku8TzQeA5W
	 Qech1D2jNbTI4/325eLAAXom6FCOlYZut+9bStgMtdLJOV9O5BhHILXPRU/JaVF6d0
	 AMUp8sVEARuZCxKCUKBocVqb1Aa6yj5ahcuieRxTofBIcolX83w4wZoJCf+TKGqwgS
	 2/Q2gEalcidmAAo3hl0K3PUaqvs4p8eZlUe6CqzRqnNPIpKDO6vEQeO40QBXDdq2XX
	 7f38PNlJA0ANID1SeUCXuf5sBcXt9QOkZ2t0MSuXg7uX92J5oxYIF3knEBsUWh0J5G
	 GKj9WATL7YBlg==
Content-Type: multipart/mixed; boundary="===============6771391642254911456=="
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <48114f7cb5d9dbe88299056f69a43708f29f4f4569aa0c04d4411d5140e932c3@mail.kernel.org>
In-Reply-To: <20260209023153.2661784-10-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-10-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v9 09/12] bpf/rqspinlock: switch check_timeout() to a clock interface
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  9 Feb 2026 03:05:46 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com,iogearbox.net,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-pm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-42323-lists,linux-pm=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[32];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF68710B4CD
X-Rspamd-Action: no action

--===============6771391642254911456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 2fdfa828e3d3..f02b1c5f0222 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c

[ ... ]

> @@ -340,6 +349,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
> {
> 	struct mcs_spinlock *prev, *next, *node;
> 	struct rqspinlock_timeout ts;
> +	s64 timeout_err = 0;
> 	int idx, ret = 0;
> 	u32 old, tail;

[ ... ]

In arch_mcs_spin_lock_contended(), when a waiter in the MCS queue receives
a timeout signal (RES_TIMEOUT_VAL) from the previous waiter:

> 	if (old & _Q_TAIL_MASK) {
> 		int val;
>
> 		prev = decode_tail(old, rqnodes);
>
> 		/* Link @node into the waitqueue. */
> 		WRITE_ONCE(prev->next, node);
>
> 		val = arch_mcs_spin_lock_contended(&node->locked);
> 		if (val == RES_TIMEOUT_VAL) {
> 			ret = -ETIMEDOUT;
> 			goto waitq_timeout;
> 		}

This sets ret = -ETIMEDOUT but does not set timeout_err. When execution
reaches the waitq_timeout label:

> waitq_timeout:
> -	if (ret) {
> +	if (timeout_err < 0) {

The condition evaluates to false since timeout_err is still 0. This causes
the timeout handling to be skipped entirely, and execution falls through
to the lock acquisition path. If the lock is acquired, the function
returns ret (which is -ETIMEDOUT), making the caller believe the lock was
not acquired when it actually was. This appears to be a lock leak.

Should the goto waitq_timeout path also set timeout_err = -ETIMEDOUT?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21810635323

AI-authorship-score: low
AI-authorship-explanation: The commit shows typical human developer patterns including a missed edge case during refactoring, which is a common human error rather than systematic AI-generated code issues.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: Lock leak bug where the function may acquire a lock but return an error code, causing callers to think acquisition failed when it actually succeeded.

--===============6771391642254911456==--

