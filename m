Return-Path: <linux-pm+bounces-42546-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF9XAPSjjWlh5gAAu9opvQ
	(envelope-from <linux-pm+bounces-42546-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 10:57:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E38C12C1D0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F969300E15F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F5E2E8B82;
	Thu, 12 Feb 2026 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBX1+q3s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253072E6CD9
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890188; cv=none; b=rkBjsGLZgsrJLjJ9YH5cp2ZmQPxX4OJUUcHzjhBLdMzcQacuxRag8v5/QOq8h5Se+Ky4Ls21ofXBU5lF0tBLnBk1J0W4jGDuKzX69sHBbqfw7+mBk1mzFFFCNpd/iyb+zIT+Nzq+THXOOGVCUTC3ldKSqNpJwha54jZ/tZKi1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890188; c=relaxed/simple;
	bh=bm5c2DB94uUyrmyglOpsvupAxM8sAv2B1xXqGM1GJFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MueCfZiUh2cm916C/KzM5e7kaWEVzz3K+ouKMUSCHDmRTKF3fxymSkYjZ8RjyPtSLsi3lU5OTMOQirruf1yqlw2bc9fuBmXPgsLqd1aNhg6P7s8RXHiUlATwVF0ZiJNnZs5G4jkrDTdwgjF5IyhP0qmmcOHqY0A8oaCPBnWF0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBX1+q3s; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so49374265e9.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 01:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890183; x=1771494983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Phtp8Z4ei388aKllZFARYn5zwlBsIT6J1/fUx6EVP8E=;
        b=NBX1+q3sG3mz5yo+4PTok6RS0Rp9dEpR09+Y/JRk3u6e/64D04ue1Vm9XVkCusdVXu
         NU3WJvXA/Q+dK+oBZz+2re44DDJ0aNRgUR8oq0glWiZvELc11mKMFW0ZNXaRiz1FwbDl
         3kum0bbwFJHel7oltVfP+rxyeZEgtlPDoU9m4kCOJ1mKK/Rx/N9WnOd74jf+d8M7g2au
         yscatCcL8N2Ntt7JN2wdoT5baluHz8sx6Y751dwHYyRknl84qrPr/ABBiYzpydA2evGn
         5l4w9ak5lIPOuSfe8gbBTLD9GwhQ7CX8KHMX2+xVE9uTBBISVe4xnzhgArj9Ln1esdZF
         yFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890183; x=1771494983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Phtp8Z4ei388aKllZFARYn5zwlBsIT6J1/fUx6EVP8E=;
        b=WalEm7Yk1/ccpHd3AnMXn4qy3R6+jN37GjUpaG2HOWWcXinuRklBvm/7Vb9GyGwvyK
         z0XpzV+QvrtGMPsI5x281UDkUQtdJSkRQP+F6QPDqdPv4+uMo7EP1jfWCLv5WoL8hEom
         IPcBtVC91+E+lPH1NpIs1/AXbC2VEBSRSMAPW5DLyZDtSQ0AolJdeGKt6135+OphASvQ
         0Xsddn1NO3VxfjiZFSq74qo7kH1IQ7cHJz0F7a7cGpLW4IUUoBZ1f7SWpGtxGTZwLXSO
         27uYxZao4itzg3FY+hua4DsAa3UToEZ4xTANtB1hQWgdQUx7+VUI448poF7X6Gwa/J9Y
         RrSA==
X-Forwarded-Encrypted: i=1; AJvYcCXekQ5B/V3MyZ/JR8zVyfeKPTAypirIz+Z+qse8sFXayFXII/TdQZVz1TiFi6Iu5cKt+vn88MU/yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnhYBeFuXHwtctxOjVZRqWH+oIwvxQQJ2O5yj5NsUqmEqwuXh
	Micf7Sbb0rHhqAljrOaWZDhPp0RMJo6Vmaid3UIvJ5WjfFaTVyR0c9JJ
X-Gm-Gg: AZuq6aIUQ30MuSoJzyuVa+nDCKi8pCcuK4KYEM2gKMZ69pHHzHfCKi/qTRrkC0osgLG
	1SA+Uv/Pmhqr3HrMtTt/NmzqsJUiZ5Vobl3z3pKKhNEnMhKAfGJIavhhEzIMyUhe3ugy5TWKxHo
	TKd/rjG8l7czm740DWwYXFuDHOxNkax96AKpDThcH9BL5+3E8lZ0oDAETC1ovfK9EX2FrJbTxFr
	IDlLD1jRyVQUM572a4KgaDmP4iRz4b1dUWGLfz0Vxsyy0HSsOvoCZUStdgaB8ssdsZkRDnJSmn2
	gfikUfiDwgSRi5d5k+aDtP8lUZfxdGI/bbFX8n8g2NUHMh6RvZVOwYFuAH+pLNJSMK/SI71Lp/2
	AxXXobHd6MmpsJATWjfnSx8Qym5c26ZPbZX623tIK2KPTKX1KHSE6YY50nl6EYoUZ66LczWZIO1
	NuQp+hizmgyZWanbZpoSJTew5AXc3K+p/fvWD3bHolIZwd1w2OBpytN3OlqL+KyzeJ
X-Received: by 2002:a05:600c:4fcb:b0:480:1a9a:e571 with SMTP id 5b1f17b1804b1-4836570e48amr25658585e9.22.1770890183038;
        Thu, 12 Feb 2026 01:56:23 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4c4sm330608855e9.10.2026.02.12.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 01:56:22 -0800 (PST)
Date: Thu, 12 Feb 2026 09:56:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
 will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
 zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/12] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Message-ID: <20260212095621.4d99317b@pumpkin>
In-Reply-To: <20260209023153.2661784-2-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
	<20260209023153.2661784-2-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42546-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email,oracle.com:email]
X-Rspamd-Queue-Id: 6E38C12C1D0
X-Rspamd-Action: no action

On Sun,  8 Feb 2026 18:31:42 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

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
    ^ time-check

Plus the cost of evaluating cond_expr 200 times.
I guess that isn't expected to contain a PCIe read :-)

	David

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
> ---
> Notes:
>   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
>   - This also helps get rid of the labelled gotos which were used to
>     handle the early failure case (since now there's no early init
>     to be concerned with.)
>   - Add a comment mentioning that the cpu_poll_relax() implementation
>     is better than polling if ARCH_HAS_CPU_RELAX.
> 
>  include/asm-generic/barrier.h | 72 +++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21d..2738fe35c1df 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,68 @@ do {									\
>  })
>  #endif
>  
> +/*
> + * Number of times we iterate in the loop before doing the time check.
> + */
> +#ifndef SMP_TIMEOUT_POLL_COUNT
> +#define SMP_TIMEOUT_POLL_COUNT		200
> +#endif
> +
> +/*
> + * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
> + * that is expected to be cheaper (lower power) than pure polling.
> + */
> +#ifndef cpu_poll_relax
> +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
> +#endif
> +
> +/**
> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on.
> + * @cond: boolean expression to wait for.
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
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
> +	s64 __timeout = (s64)timeout_ns;				\
> +	s64 __time_now, __time_end = 0;					\
> +									\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr) 						\
> +			break;						\
> +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
> +		if (++__n < __spin)					\
> +			continue;					\
> +		__time_now = (s64)(time_expr_ns);			\
> +		if (unlikely(__time_end == 0))				\
> +			__time_end = __time_now + __timeout;		\
> +		__timeout = __time_end - __time_now;			\
> +		if (__time_now <= 0 || __timeout <= 0) {		\
> +			VAL = READ_ONCE(*__PTR);			\
> +			break;						\
> +		}							\
> +		__n = 0;						\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})
> +#endif
> +
>  /*
>   * pmem_wmb() ensures that all stores for which the modification
>   * are written to persistent storage by preceding instructions have


