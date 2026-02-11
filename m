Return-Path: <linux-pm+bounces-42506-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKD1I8+ijGlhrwAAu9opvQ
	(envelope-from <linux-pm+bounces-42506-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 16:39:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24317125C0C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 16:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A71D3300F105
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD4F308F33;
	Wed, 11 Feb 2026 15:39:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A68307AD5;
	Wed, 11 Feb 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824391; cv=none; b=FY+2+9LpMxme2JVjxw4usrwFxQKVhU4jGQd8vg168el6QxljJ7Afs5uZFk7kDi6S+Lo+WPjOYd+Q/17c43RlIJtwCD8MCoZ8UWleMVG+9PJNzxA20VFzMI4GIFzObJJ+P+n4EZSxpgi7KWuK7gvN77BwGrkcfqq8JlEsXGG31gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824391; c=relaxed/simple;
	bh=9BHZrovdL8pUZkt7tyn1ev0JM5vhLyZTfGxKj2xYcJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgsMTaqnqZZ5L/PMcDTIDLH/hr9D0h4BQV9a+97XyaCW7tSg1hTSIPoGWTxc19DPWiYwt9fG05ph7vbyF3Wu7spHDOvuWpE5fBHQfMSTmuNVRO9dAPQZvcCadrFI2ubzAW4bJpg/FncuNocV5yPfiyn5JRV9uSp07gh70Rb4nxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4F17497;
	Wed, 11 Feb 2026 07:39:42 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45E503F63F;
	Wed, 11 Feb 2026 07:39:45 -0800 (PST)
Date: Wed, 11 Feb 2026 15:39:42 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/12] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Message-ID: <aYyivg-6aYspHIHA@arm.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209023153.2661784-2-ankur.a.arora@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,arndb.de,kernel.org,infradead.org,linux-foundation.org,arm.com,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-42506-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,arm.com:mid,arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arndb.de:email,oracle.com:email]
X-Rspamd-Queue-Id: 24317125C0C
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 06:31:42PM -0800, Ankur Arora wrote:
> Add smp_cond_load_relaxed_timeout(), which extends
> smp_cond_load_relaxed() to allow waiting for a duration.
> 
> We loop around waiting for the condition variable to change while
> peridically doing a time-check. The loop uses cpu_poll_relax() to slow
> down the busy-waiting, which, unless overridden by the architecture
> code, amounts to a cpu_relax().
> 
> Note that there are two ways for the time-check to fail: the usual
> timeout case or, @time_expr_ns returning an invalid value (negative
> or zero). The second failure mode allows for clocks attached to the
> clock-domain of @cond_expr, which might cease to operate meaningfully
> once some state internal to @cond_expr has changed.
> 
> Evaluation of @time_expr_ns: in the fastpath we want to keep the
> performance close to smp_cond_load_relaxed(). To do that we defer
> evaluation of the potentially costly @time_expr_ns to when we hit
> the slowpath.
> 
> This also means that there will always be some hardware dependent
> duration that has passed in cpu_poll_relax() iterations at the time of
> first evaluation. Additionally cpu_poll_relax() is not guaranteed to
> return at timeout boundary. In sum, expect timeout overshoot when we
> exit due to expiration of the timeout.
> 
> The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
> is chosen to be 200 by default. With a cpu_poll_relax() iteration
> taking ~20-30 cycles (measured on a variety of x86 platforms), we expect
> a tim-check every ~4000-6000 cycles.
> 
> The outer limit of the overshoot is double that when working with the
> parameters above. This might be higher or lower depending on the
> implementation of cpu_poll_relax() across architectures.
> 
> Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
> cpu_poll_relax() that is cheaper than polling. This might be relevant
> for cases with a prolonged timeout.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

This series evolved a bit since last time I looked, so going through it
again:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

