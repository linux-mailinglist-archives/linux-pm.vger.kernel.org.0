Return-Path: <linux-pm+bounces-42326-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FN1G11piWks8gQAu9opvQ
	(envelope-from <linux-pm+bounces-42326-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 05:58:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6310BAC1
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 05:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35B9B3001476
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 04:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71125DB12;
	Mon,  9 Feb 2026 04:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ai7OIfxj"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB719A288;
	Mon,  9 Feb 2026 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770613079; cv=none; b=Ny1lBv5PovXDh98jVXZ2VYBzodowQ1xn/s0uaSens6oaCcKn5u3BqiTynJ++itmuR07+3Un3Pxmx/GYQZmyrROqq2diN/1whQOeovBjDltU1RSI9C15wEMgodawW7mkDJFQe7FdNgrs49QBf6kaX2rYYdGuY1w7HvKb3ujuYG34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770613079; c=relaxed/simple;
	bh=9x9+JFiBtU9fVVNKicjmNwKuYIVND/FdpOrv/7OJM/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTptO0QL5oFieraKoF29K8gQVMfenNfmy5hFPJhQM4JWYiH6EWR3qfZ2zV9UrUTvasae6Ue/oBKWF1DK2lMJD9edDD9Kw8O5R3+rsTEe7H/mGZ89aTWX92TVIMLo7XSIoyqpZyj9N4C7vuefF4C5deE8ZSgAQpiZxyFvprm/b8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ai7OIfxj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FNs90UWUFg7F1Jb2HJimlsZX6woxU5aTVOhpGX9WvCk=; b=ai7OIfxjxCh8hdXnJ7YJ6JfSe8
	Z1xLIHez0yo5+Jqtxi7AyZLjhUd741CQLhmMcy/K+qksVjDP3XLZx/N2cQseoNs3hGFUT79/WP+j+
	Pq9hxm0MuE6ZJRaXtY8KmeQWBCW78NEKIHPZ587dSRG/lZ9KzEPSdzTdpYaZXtY4vf+SBDxHBnFVs
	ZPl+vgJQquhZnZ6DIr7M1oRdjSEQSvTNZluCja6r2mssF5fbV1BKk/Nomugvu//n1qN7rI3+Rc7MN
	nymEHd+XspNYKeu5JlbiHg1aIB5o5HKE2QWhA44kRRrSNFJkk/NKyVnW5sdK8JBAhGMrHLogZMtT2
	1nrxf+wA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpJLL-0000000EpXA-3g1G;
	Mon, 09 Feb 2026 04:57:51 +0000
Message-ID: <9414714a-ba13-4d17-8b4f-97a03b90d6c1@infradead.org>
Date: Sun, 8 Feb 2026 20:57:50 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/12] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
 harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-2-ankur.a.arora@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260209023153.2661784-2-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42326-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: C2B6310BAC1
X-Rspamd-Action: no action




> +/**
> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on.
> + * @cond: boolean expression to wait for.

s/cond/cond_expr/

> + * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
> + *  on failure, returns a negative value.
> + * @timeout_ns: timeout value in ns
> + * Both of the above are assumed to be compatible with s64; the signed
> + * value is used to handle the failure case in @time_expr_ns.
> + *
> + * Equivalent to using READ_ONCE() on the condition variable.
> + *
> + * Callers that expect to wait for prolonged durations might want to
> + * take into account the availability of ARCH_HAS_CPU_RELAX.
> + */
> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\


-- 
~Randy


