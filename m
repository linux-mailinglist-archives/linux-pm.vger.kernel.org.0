Return-Path: <linux-pm+bounces-27321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A05ABB6B9
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A7E16E2D0
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368732690F0;
	Mon, 19 May 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7ZXRUg2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B512FF6F;
	Mon, 19 May 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641964; cv=none; b=fk57q7EbBMB2DoASPxFhrkS6fTz9L+DtDrqNKvIzKHSXTo8eOx6IpNA/kWgEv4G5fH97x9RgWHpuRrxYvlrJ9uYgozA7EwXn5/7E6WTEPm0XCHvvlLGutySebr/PXJAJPkoexokoTdnvtEyOgjfu6RSYfsWx06VGK/QEVgqx+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641964; c=relaxed/simple;
	bh=vgQ37Wd6NFpayHg0FKFupM/R6G4CWH8d5na8y51Q71w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPyFEM42ZgwDIJAXZ3idZtuNej3AvXfd7BmxIj74Vtnml4N6qIka7DA/2mmTz7qIsRm7Xk/ePBf437hBq4ll/wbMTbeIxmxgsO2GpydVWTHRUk76vwTTlVNonkQDCad763WIL/u7QLLCq2K9IAWHm5qSVfS9x+qxplZq3zg34no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7ZXRUg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D55DC4CEE4;
	Mon, 19 May 2025 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747641963;
	bh=vgQ37Wd6NFpayHg0FKFupM/R6G4CWH8d5na8y51Q71w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7ZXRUg2s42LNUugf/Nb8p03uvNdtBrsT2fIKLWgeYMVZlfiWdq2WLtFSaxiEQhSd
	 +oMonOSb0wiBCVly8cDlp0/gn81NBV+MeBblQljKZJwRp42L4ecslh9HJn+tPtSGu5
	 mC2APPKhHqhO2AkDU30e9mNz7MSg+ptHEt9eefsLe5I+7kogjtNwydK4XWKO2GUJBe
	 NzLkIHcxbcrbVL6X6wzZzySsct1voOxJivxOg831r/FQvKY3r8EieV69TLQGaitfOh
	 u+rCMN+OBrfGu/dEcpgrGypQr8HVoug51WjN5dWf2oBWHfuq9e76hMvr7QSfyN6+wZ
	 tphJGP2oTeLOg==
Date: Mon, 19 May 2025 10:05:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/3] x86/fpu: Don't support kernel-mode FPU when
 irqs_disabled()
Message-ID: <aCrmZnSokvmqfel3@gmail.com>
References: <20250516231858.27899-1-ebiggers@kernel.org>
 <20250516231858.27899-4-ebiggers@kernel.org>
 <aCg2DSYp0nakwX3l@gmail.com>
 <20250517183919.GC1239@sol>
 <aCl_cSO2XqtSQEZT@gmail.com>
 <CAMj1kXGVAbD9zxUQSwwGo=ueadqWWSdaQNDe_-7ZezpFLMJRMA@mail.gmail.com>
 <20250518200114.GA1764@sol>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518200114.GA1764@sol>


* Eric Biggers <ebiggers@kernel.org> wrote:

> > # echo PANIC > /sys/kernel/debug/provoke-crash/DIRECT
> > 
> > Another case that likely executes with IRQs disabled (but I haven't
> > double checked) is reset_system(), which may return with an error, or
> > reboot/poweroff the machine and never return.
> 
> That makes sense to me.  preempt_disable() and preempt_enable() are already
> allowed when IRQs are disabled, and I'm not sure why local_bh_disable() and
> local_bh_enable() are different.

Because local_bh_enable() may run softirq handlers immediately if 
there's pending softirqs, which shouldn't be done in hardirq context.

This is a key optimization of the Linux networking code, which uses 
BH-off/BH-on sections instead of IRQS-off/IRQS-on critical sections, 
for performance reasons.

Thanks,

	Ingo

