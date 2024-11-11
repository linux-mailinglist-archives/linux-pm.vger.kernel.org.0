Return-Path: <linux-pm+bounces-17333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C91BA9C4288
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 17:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8209A1F25165
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF5E1A071C;
	Mon, 11 Nov 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffZqlbSr"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91A19D093;
	Mon, 11 Nov 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342202; cv=none; b=QhHYRHyZZZ5UqeeIOF6bROZRt2rtRnfSgkINrzg06t1sMUVeFmt97fbTfeUQULSJvvBPRdLbf6fLe8y4N93L1RxB45bADXUELe8q6EzW1J3aeIda+/PN1Q5Hw5yE8al5UmSc1o/tJihxcIuKTlv6o8hOyflgOk+COc8ELrObMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342202; c=relaxed/simple;
	bh=mOsEI5TgGsY/iTmPy8plG4NjX8Giqup3gPPNIlVfrWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HENvG+y2crFVqrvBZXdyXC9jxoFNsfa79xX7NdlVAQIl4F/3bmkFMW2AIpXJlnRFRCTazayl4PmcBXun8JNTRsFAzBqzwZ2xcHQ5ywhsY6HlBcIJ88ee7XAs73UKB5tZnsn60KBzZsaSK3cadlF6TXspVlD5EwAn29tEfYDdfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ffZqlbSr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qYKvXZTHxl7ZZR+yc9qocIeS0oa6t4JePHHwhcsDG4U=; b=ffZqlbSr8U/pTWAqDGgXuWMmuz
	lKWd5R6KeNETzpevPZ7BvugxL69EjhiRfdlaDNQT/LR9f0fKAIcVWITf3UbCPd+GRW6O4UxeHP2n7
	NfGmfMGWZowq5Fft8SO08ICSlYy88L5bnG9q9lXAmBfx16iJxkKVdZVG3xj/+PKLPtsID/iF5A4Tp
	PijwcvPX++BPV7nbLjGmaDgmz8IC/q5wi6SqyA9UG5JXZ5p/vhopc8e0aKh7jN8KBzuHwYlhr450m
	DRFBvSlxM7g13DJZNNEtWiCW+Zv32AtIFGy5240XhkPslyInQCh9TqvhGGBVIpA7CnPE/SBg7DL3v
	ZBnkoeQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAXC9-0000000CsBb-2L4c;
	Mon, 11 Nov 2024 16:23:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DAB6D300472; Mon, 11 Nov 2024 17:23:16 +0100 (CET)
Date: Mon, 11 Nov 2024 17:23:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
Message-ID: <20241111162316.GH22801@noisy.programming.kicks-ass.net>
References: <20241108135206.435793-1-lenb@kernel.org>
 <20241108135206.435793-3-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108135206.435793-3-lenb@kernel.org>

On Fri, Nov 08, 2024 at 08:49:31AM -0500, Len Brown wrote:
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 766f092dab80..910cb2d72c13 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1377,6 +1377,9 @@ void smp_kick_mwait_play_dead(void)
>  		for (i = 0; READ_ONCE(md->status) != newstate && i < 1000; i++) {
>  			/* Bring it out of mwait */
>  			WRITE_ONCE(md->control, newstate);
> +			/* If MONITOR unreliable, send IPI */
> +			if (boot_cpu_has_bug(X86_BUG_MONITOR))
> +				__apic_send_IPI(cpu, RESCHEDULE_VECTOR);
>  			udelay(5);
>  		}

Going over that code again, mwait_play_dead() is doing __mwait(.exc=0)
with IRQs disabled.

So that IPI you're trying to send there won't do no nothing :-/

Now that comment there says MCE/NMI/SMI are still open (non-maskable
etc.) so perhaps prod it on the NMI vector?

This does seem to suggest the above code path wasn't actually tested.
Perhaps mark your local machine with BUG_MONITOR, remove the md->control
WRITE_ONCE() and try kexec to test it?

Thomas, any other thoughts?

