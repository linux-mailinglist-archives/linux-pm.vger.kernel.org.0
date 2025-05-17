Return-Path: <linux-pm+bounces-27258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4DABA792
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 03:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B153BAF29
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD0B2AD21;
	Sat, 17 May 2025 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js5fK9Ib"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF653FC0A;
	Sat, 17 May 2025 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747445432; cv=none; b=hOj/qD/birQsGUU6HPAcPPr+mP5GTOu44nqdwAXt7xSjDCaariAftidRbI4V/LjkI/tASF90qyH8s3aMaHTRB66kJo5lKUrtZos5nXG1NMbEZ6AkQ8T5YvY8eAjxCppJVBDMXQsMCBDfw3hYM4IfuD9+OiB+aFfuV4B66MT+gGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747445432; c=relaxed/simple;
	bh=sD5DXr91JuiQh2HVBdc+MBupWujyMGyLfWDqGiTS5Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di8juNaesApiGyqgLSN9zC0orHW5BwimIWVgniYcPsmBLzuHPIJus/VvT41AaIkj+YF+q8/veAdNusyxy404oXP97sZcj575e2lzNBu/RgfKCwHbnP8KWLSJmC+XasTaAMTJqLTgPFllVLFg1lLkirgQ/yAdMDPFgmNGUoa55ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js5fK9Ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75C1C4CEE4;
	Sat, 17 May 2025 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747445432;
	bh=sD5DXr91JuiQh2HVBdc+MBupWujyMGyLfWDqGiTS5Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=js5fK9Ibe7/UuoQw+NClh216yLdx1G2lUumNmCflI119ZCrrzPffU0uxWhNt5H32U
	 FTd3wt/UqySxDT+6OHcaF2JAXwRRsBc9TFfegMt+QwkfQ103ACP8V4PXwjQTXgRrqU
	 bPtrOunntddED3YWlohnKP0VxvP+qtJmtMYd5Sv7owPEykJHI8aHp0Ya71WRjwpNT+
	 vJDW/7qFTdCq+Lcds7+0EypOH+zj2OLFh+Ln9aFINTjGP84nYUueB7z36vk8bF38Ts
	 2iY4KpbkmEKJoe1cpXK/uHVpX2ls3pK16w5Lgg1ihQK9kHDPPCWBae2OQPp/gQuIX4
	 25lvx7Dfk9FaA==
Date: Fri, 16 May 2025 18:30:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 0/3] x86: Don't support kernel-mode FPU with hardirqs
 disabled
Message-ID: <20250517013022.GB1220@sol>
References: <20250516231858.27899-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516231858.27899-1-ebiggers@kernel.org>

On Fri, May 16, 2025 at 04:18:55PM -0700, Eric Biggers wrote:
> This series returns to my earlier suggestion to make x86 not support
> kernel-mode FPU when hardirqs are disabled, aligning it with arm64
> (https://lore.kernel.org/r/20250220051325.340691-2-ebiggers@kernel.org).
> To make this possible despite the use of the kernel-mode FPU functions
> by __save_processor_state() (which I mentioned at
> https://lore.kernel.org/r/20250228035924.GC5588@sol.localdomain), I've
> changed __save_processor_state() to use a new function instead of
> (mis)using the kernel-mode FPU functions.
> 
> This slightly reduces the overhead of kernel-mode FPU (since the result
> is fewer checks), and it fixes the issue reported at
> https://lore.kernel.org/r/20250516112217.GBaCcf6Yoc6LkIIryP@fat_crate.local/
> where irq_fpu_usable() incorrectly returned false during CPU
> initialization, causing a crash in the SHA-256 library code.
> 
> Eric Biggers (3):
>   x86/fpu: Add fpu_save_state() for __save_processor_state()
>   x86/pm: Use fpu_save_state() in __save_processor_state()
>   x86/fpu: Don't support kernel-mode FPU when irqs_disabled()
> 
>  arch/x86/include/asm/fpu/api.h |  1 +
>  arch/x86/kernel/fpu/core.c     | 92 ++++++++++++++++++++--------------
>  arch/x86/power/cpu.c           | 18 +++----
>  3 files changed, 62 insertions(+), 49 deletions(-)

I realized I forgot about EFI again.  Ard had mentioned that earlier.

I think we'll need a !irq_disabled()-safe solution for efi_fpu_begin().  It
could be a different function from the regular kernel_fpu_begin(), though.

- Eric

