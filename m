Return-Path: <linux-pm+bounces-27326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942E6ABB73F
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F8E165C97
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 08:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245D71DEFF3;
	Mon, 19 May 2025 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M//xSjAp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD93FBB3;
	Mon, 19 May 2025 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643534; cv=none; b=luVNjBH7Px5q27/FxtEyE+2vCzm69Ohe/l4+C2g1n+lHTN3TW7uPH/VLQ1a5Y5Oc+4LLqDZ3a9Du1a/tbC+xvjI0NXQcY0gbZB8DIgbSoKcFsYrYCUa4icHTeghDBBZjX1ZEmVJAof4A14jZDksd+vICMCsu+vZ6A0RSz+N/lV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643534; c=relaxed/simple;
	bh=/SCnk4n14OSLgVEhEWxkq9MOcZlqdPW8Sok+wQhHM6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPdIr54qA/MoOVB+FTa8yBpsoJZy0RVQBFAr08f2UNzVePBDI92RzJ3K+YDGJXKlA+6lLnYShPjmLr22rHYKbHpTi9eMhMW/OjFSDepK5H75m1qV3obtEiux9BMol15teNw3pxepylepVI6/GFSIsUVaxtHmRj8dZSg0m81kmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M//xSjAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E888DC4CEE4;
	Mon, 19 May 2025 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747643533;
	bh=/SCnk4n14OSLgVEhEWxkq9MOcZlqdPW8Sok+wQhHM6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M//xSjApTsnhNhbk2bOZOXmgoZoB7kqQ+L1MfhHtmwx0yrC9prPdQ9/6UhYACBK6J
	 VUwI/kmJPQtnmCZgG3I4qegwMIL7406hCezWkEQ1KFazQ7YxmaDhny7RiKLfrQynWc
	 AavXuU7LA/xuh5MJbro92hSXv78h8RXxCRfSXIjQE0i49Jyl6ByDOEsr9YMKvwKTKO
	 dZghwYvpdmHXbDXAqVpSglWz9u3AHsUvGqjEXIgNFJkxQ10aRP3A7ABlEK70TymIab
	 Tgo8wWILdUwv4htWZbF/iHacrrdO1GASFArgBZauJeNrWK0NtfYqm9AkwTdYoa5h2B
	 OBU04Pa20Llrg==
Date: Mon, 19 May 2025 10:32:08 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] x86/fpu: Fix irq_fpu_usable() to return false during CPU
 onlining
Message-ID: <aCrsiPd3u1-tEVd0@gmail.com>
References: <20250518193212.1822-1-ebiggers@kernel.org>
 <aCrrMEN01O7FWY6V@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCrrMEN01O7FWY6V@gmail.com>


> void fpu__init_cpu(void)
> {
>        fpu__init_cpu_generic();
>        fpu__init_cpu_xstate();
> +
> +       /* Start allowing kernel-mode FPU: */
> +       this_cpu_write(kernel_fpu_allowed, true);
> }

BTW., this is the chunk that fixes the crypto crash, right? If yes, 
then could you please split this from the main patch, with the main 
patch setting kernel_fpu_allowed very early, which should make the main 
patch an identity transformation with no (expected) change in behavior.

Likewise, the cpu_disable_common change should similarly replicate the 
current code, and should only be changed in the second patch.

Phasing it in like that should improve bisectability, for the off 
chance of some regression.

Thanks,

	Ingo

