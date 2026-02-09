Return-Path: <linux-pm+bounces-42322-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNbPIU9PiWm66QQAu9opvQ
	(envelope-from <linux-pm+bounces-42322-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 04:06:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE8C10B540
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 04:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20457300A391
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 03:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415642EC559;
	Mon,  9 Feb 2026 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG+sAeWy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA042EAD10;
	Mon,  9 Feb 2026 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606346; cv=none; b=jZFZ6CU3lzDxhYfbM+jzgt8I9YJQ/IJ22+UmHOYX4lm84KM0CfRUEEqGrPERq9M9XfFvqEJjJcPJbJQqmJoNBZspBPTAIJaGGV2hKWdFlYMhi0tXlnyplOD85nRakCvToxco/ltz+yMXw/ZhKoWUpjZH93whi6DeeotlzRZYrPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606346; c=relaxed/simple;
	bh=Bi0BkSU0X7luO/eNKUDTo3OAk9c0hNwnUFQEUKPEsfw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DXZuBi1BfyPBXXhrKZQOpZ3ovP9f9KnHKbACzYjnvjEd6X9wBdLIuYQxH0xWTZH7xMFcwqucdL7aDVXiMc0kEAi/yX9xL+JsZczBXpBc2oVsu0GiKnu34m28sGlmD/H67wiK3osA7/YfjAikuT826XUIOC5QxBcibPiUEYRpD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG+sAeWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C193C4CEF7;
	Mon,  9 Feb 2026 03:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770606345;
	bh=Bi0BkSU0X7luO/eNKUDTo3OAk9c0hNwnUFQEUKPEsfw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cG+sAeWyJWGwC/Aap7um1mW3FVa/saSM/1E0r2PdRfdLfatSgunijyvKcqeRKABt1
	 9whi9FzkNVfIQ+TvxlYTn5HAgF+pnqN7B8G8sc+cq0+vrZ+IEjN+w4XE6xDPQAIE76
	 VCBslV3UB40R6f+l6hQkpoi7dGX88W9ej+jud/nTyIyGgpW5ZUQ7/KHhJRu8mS6Qpp
	 EnokLaUHyDKEkGtmoD/kh+zpbfxMklkxNIbByo8g1VXDH13xuzaw1WlHs/rN/ouozD
	 p1xmIGCBlZlHOlA081oGTvSijWr3XLkgIlwuC/KeTiuT9PICZR1onuWPwB2nPtMzR5
	 uvHk2B6DOXtIA==
Content-Type: multipart/mixed; boundary="===============3409934204227450896=="
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7d3944c1d8ffe5ee6d52907d7227f8eb8b91f5aa2b705fe3eb0af23454b8b072@mail.kernel.org>
In-Reply-To: <20260209023153.2661784-12-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-12-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v9 11/12] sched: add need-resched timed wait interface
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ankur.a.arora@oracle.com,mingo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  9 Feb 2026 03:05:44 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com,iogearbox.net,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-pm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-42322-lists,linux-pm=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[33];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 1DE8C10B540
X-Rspamd-Action: no action

--===============3409934204227450896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The wait is implemented via smp_cond_load_relaxed_timeout().
>
> smp_cond_load_acquire_timeout() essentially provides the pattern used
> in poll_idle() where we spin in a loop waiting for the flag to change
> until a timeout occurs.

This isn't a bug, but the commit message mentions smp_cond_load_acquire_timeout()
when describing the poll_idle() pattern.

However, the code uses smp_cond_load_relaxed_timeout(), and the subsequent
poll_idle() conversion (patch 12/12) also uses the relaxed variant via
tif_need_resched_relaxed_wait().

Should this say smp_cond_load_relaxed_timeout() instead of
smp_cond_load_acquire_timeout() for consistency with the implementation?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21810635323

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard kernel style with iterative improvements across 9 versions and reviewer feedback, consistent with human authorship.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor commit message inaccuracy referencing wrong function name, no impact on code correctness or runtime behavior.

--===============3409934204227450896==--

