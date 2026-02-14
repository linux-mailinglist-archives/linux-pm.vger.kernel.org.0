Return-Path: <linux-pm+bounces-42637-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE13JxhdkGlzYwEAu9opvQ
	(envelope-from <linux-pm+bounces-42637-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 12:31:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE25F13BC04
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 12:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F84230226A4
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC923815B;
	Sat, 14 Feb 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+veXALJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AB3B1BD
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771068688; cv=none; b=cFwYbcCCvoJz3eqT7VSzoX/llg/Xp62zlw9u7lSetwJBuaEqMR5HvyJ+ARGlGY5rHEWGJaIT2mTAe5uDs0BvxNgrWEZpBUnoaHxs5lJMt2ttAz7zzvADRHpxt0LWJ53j9rcT7/TmOGol/TEuJH9axUYqmSBziyRJ+fs3ACU3iag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771068688; c=relaxed/simple;
	bh=jgsb6aSE7WPnfxKv5PMCEz/G0xsKQZzyhcPwhL0OMgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+VaA9rrOSM5vPljnxr4ZoqmW1YMc6VUsibLBtZNo4BAXPQWY1rmdhe8Fe+qpOzyzdIadlm+vqtWDLrNnRbDk3y0BvC55EZvyYpGk8f+Z4hynuCHXhw53o3vHJkNjEqWEW9txGMEv6R+Y37i5/t/Ta1N8whISxeBRBZDdNF8R/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+veXALJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so13545025e9.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 03:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771068685; x=1771673485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiZwlgtBXqE7LEsN2nlgf0AbHOoRJSUt9gOPy7eO3jU=;
        b=j+veXALJDkt8Dv94RwJ93S6+z5F1N3shcNGHNyUGucVq6CEWAt8DHu6S4lCZzFvwLN
         hR36fbgT0F38L58OaU67n1bpI62qdMJkrbm98OSKNS+TenaUriw14dWxiKYbvtE34ILh
         03oT6oLRRE9jab/l2tDf0WgiTkheAxO9dAYTczezqhuREFn+nNFIG7cqWiM6KVFgBHcr
         Iw5DfMM8WHEB9mFkDLtfJsNYbivZJ829JVUBGmLUVpXI5T3gFFz+jM7v41Jdvkmuk5Dy
         0Ikenfn7STop8Q0TC+1Tf0CzUmfAq2K9AJIZ5SBZT7TDxk+SmfwrkJjcRnwVe8RwOZYK
         kX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771068685; x=1771673485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OiZwlgtBXqE7LEsN2nlgf0AbHOoRJSUt9gOPy7eO3jU=;
        b=d8hs/t2L3/mWCtaVCWHMCbxrf0cHGOUJijD51DN7FHHYfqNKsBjq2Vooqjz+9k0L3M
         r12/0I0qyUTjPtxaw2yf7vuHty9EltbsO4hXyUXZQ2DVj0V+bPABq0bsI9eDKJOyFptu
         x00hjfTDvL2InLpnK6d8adDvLHxvxr8Tq3Rs8KJ1R7eFkfpcM9zc9S7/dtKfU0Q/Xugo
         Z0TAuHfJTbMOiLoxRWA9lLpROZmsbMUPyuVNPLrWdQ66QmD0Q9q8o0omDfGdeZGARLk2
         ewKQjRvHzqEronyKtQ63fq6AY6OclonQWF7dDzf7dmvKR3IT9alUUBoH/Ay/4YxXpgyW
         9o7w==
X-Forwarded-Encrypted: i=1; AJvYcCUv2zDvANSxIbUcK2RaFjVXJiJaJ3H75aI66Yx3jhi7YEMHOeCjLKALyaqHCEgfzuhQI+eHlNW81A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmugcUZuhpMz9CSO7I30GMuDyDGDNq4slnURyuPSsNL2PxfJAj
	6aVosPufXX1IB4LF/WArFyI0codUhBuOBxGhpbggQTHQNAGQCB8eqTIa
X-Gm-Gg: AZuq6aJDFVi4NSU0Zd1IwOrr1E4zOZoAzHy4DoWg9XHHArjWAQLmxVEOg/ThVfnC8vH
	O13dD0Ckk3ulhf6DDwujO1+KN/W9zuSr7gNF4HCkOeEaUwGwcVJShQsakdTKa48lNuTbNDgRWd6
	LT7VckEJr0ugM+LwY4jIarEdXl4dMybz3nh9T1sonIpVv+1F3XNA/HvtfmqIE14sVlEy92MPqG6
	vokdmyyrkcMZBx1O7bCYoNHKKJK4GccGPkPWrh+zzYVTgSIFItjj8r6nMD4uwChDDtlZ7XLUCsk
	XdPj7FWq5Koi0OiTN9qDnsUpCFsfKJ64HyKC7X7pZnPcC5eVmWkuA4QuQNpmWQi4Cg5+wmx+e6v
	8Qchph2f5w2KkSlHy1bQ5dhXmRE95jqRPFwGkU+KQV0mswZGLjrXG5o9bH1+58bDUldi2JPoMh7
	1G5M3Rfu+LGy0GOyM2H+q5drEx/IdypNDDSx1+MyFcFGXWX8cTEEjKIxCPLLzsE117
X-Received: by 2002:a05:600c:3f1b:b0:480:68ed:1e70 with SMTP id 5b1f17b1804b1-48371096d3amr84223035e9.35.1771068685196;
        Sat, 14 Feb 2026 03:31:25 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm237182465e9.3.2026.02.14.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 03:31:24 -0800 (PST)
Date: Sat, 14 Feb 2026 11:31:22 +0000
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
Message-ID: <20260214113122.70627a8b@pumpkin>
In-Reply-To: <87tsvj6hwf.fsf@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
	<20260209023153.2661784-2-ankur.a.arora@oracle.com>
	<20260212095621.4d99317b@pumpkin>
	<87tsvj6hwf.fsf@oracle.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42637-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: EE25F13BC04
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 20:58:08 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> David Laight <david.laight.linux@gmail.com> writes:
...
> > Plus the cost of evaluating cond_expr 200 times.
> > I guess that isn't expected to contain a PCIe read :-)  
> 
> :). Good point. I'll see if I can add something like "when polling on
> a memory address".

I've only timed PCIe reads into an fpga (Cyclone V) target, but those
are about 1 micro-second - which is a lot of clocks.
Hard logic will be somewhat faster - but still slow.

There might be other places where 200 isn't a good value.
Perhaps add an extra #define that drops in the loop count?

	David

