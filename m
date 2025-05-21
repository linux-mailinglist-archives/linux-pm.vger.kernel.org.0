Return-Path: <linux-pm+bounces-27462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A9ABFA03
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4201BC6B36
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8822156B;
	Wed, 21 May 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBSXWepw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6uCbu5Hg"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0741DDC11;
	Wed, 21 May 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841985; cv=none; b=E4fko2Ianb5tMLKKR5V3k2vBU9jVZkBNd65NUwMdoWlKgAVhmFYTFiIQAea345zllrgy88Fhuxt8mmC4oK/sA8PdzbBJMj3uenGeiZ8QITCgSswq1Za6X3Uh1ZYxo5a1VfR6pm02up4Sr9rdFyzfG8vaOFC7GeU3W2cc0P12yL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841985; c=relaxed/simple;
	bh=56+Ldh4ULNLQNcC6REQ8YVLq/mgCiT7EcjNDnX7Tc90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JvqOPHp51uG+ihuzuglODMCtn52XJuTbIjmpkhzEU27s6w8KgyVTwVys07ry0qs9idcoej7X1tTK3+L/NSz5Vb5fqFkJUlUfjJ+6+RAVu7cC0XM3kGYyoQPFHq6vkaIF11fYA1CCn0TZ3aTIhAPxEMMCM6t5XZj9rHX7CiLP3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBSXWepw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6uCbu5Hg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747841982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmcq2TZqKJFA2G8lP9ur6GmBE9CXTqv+xnC4EorPFrE=;
	b=uBSXWepwy04FZ5OAW+bdMhkVDxZKnRFoFvcSyU26wrzPHHiMR2RIT5eFYMZx9J3K/SSIJL
	tpvYDlWCYrvP4rnlWdFnF/903n3hSVc8aVkKl7l4Igx+Em8pym+h79CY/8mruDq633ZfhA
	R//MLWVainfIYOzLPDMAI7jajRLQ6MEtBRYj3JOo0ITcPfuY+etDUkp3rZsUTBOGF3gpk4
	G2TUKZworQX2Ba8rExYF9JbVdPHCiNILJ9GctemBTGYZchU/+z8y8cnRuV+YrZkos3jfl/
	AGNPi3PggbvjeZnh0HQiThBjIzULPtsO5EwFVAxGFmkM5Z6OwqOl1xLEhxKoCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747841982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmcq2TZqKJFA2G8lP9ur6GmBE9CXTqv+xnC4EorPFrE=;
	b=6uCbu5HgoqffgsRmJ1N1f5ehaBvHv6N15JcyB5LGgN6lW3xKJWe8/72HebdT+vIMRALI9u
	jb1X7ap/5Rs8j2Dg==
To: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pm@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Ayush Jain
 <Ayush.Jain3@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] x86/fpu: Fix irq_fpu_usable() to return false during
 CPU onlining
In-Reply-To: <20250518193212.1822-1-ebiggers@kernel.org>
References: <20250518193212.1822-1-ebiggers@kernel.org>
Date: Wed, 21 May 2025 17:39:41 +0200
Message-ID: <87v7puq8g2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, May 18 2025 at 12:32, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> irq_fpu_usable() incorrectly returned true before the FPU is
> initialized.  The x86 CPU onlining code can call sha256() to checksum
> AMD microcode images, before the FPU is initialized.  Since sha256()
> recently gained a kernel-mode FPU optimized code path, a crash occurred
> in kernel_fpu_begin_mask() during hotplug CPU onlining.
>
> (The crash did not occur during boot-time CPU onlining, since the
> optimized sha256() code is not enabled until subsys_initcalls run.)
>
> Fix this by making irq_fpu_usable() return false before fpu__init_cpu()
> has run.  To do this without adding any additional overhead to
> irq_fpu_usable(), replace the existing per-CPU bool in_kernel_fpu with
> kernel_fpu_allowed which tracks both initialization and usage rather
> than just usage.  The initial state is false; FPU initialization sets it
> to true; kernel-mode FPU sections toggle it to false and then back to
> true; and CPU offlining restores it to the initial state of false.
>
> Fixes: 11d7956d526f ("crypto: x86/sha256 - implement library instead of shash")
> Reported-by: Ayush Jain <Ayush.Jain3@amd.com>
> Closes: https://lore.kernel.org/r/20250516112217.GBaCcf6Yoc6LkIIryP@fat_crate.local
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

