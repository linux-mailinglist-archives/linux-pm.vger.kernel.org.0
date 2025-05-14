Return-Path: <linux-pm+bounces-27117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EA6AB64EA
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 09:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD75168094
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F250720C46B;
	Wed, 14 May 2025 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm47hsLV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCF83A14;
	Wed, 14 May 2025 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209303; cv=none; b=VZIDnsrRA2NbCiSrNWEbrkQgiCb8FstaZKsMsjTFI1i2VKrikDcFf85YAFme4hQYALKqsbiOy0gQ284bL+wA9EZN9zLQUQrmIMjE6RPtELSaW39ODzkYnaWzheZQb1hw8vZVNO1iumOUXph1S2LX7L20AAnSnHakv/5QF05qzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209303; c=relaxed/simple;
	bh=Ee7p0wfpb95gVJiPmJV8YsUQr2NDPZZTeHdvJQoBqSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft0QJw4yRC20PqJ1/C7YQgZFjruZ0bADmnOnFXCv0airIU752URVUbXR1WGEHded/MMMgZL4iNU1+x2DRwM/xZcMgMuCvgMeedpFGjsWOkEcHNnUsyRBybmESgdpm2tSfpVW+w5hm1yb4Ud6zLs9inZgE1eKH+RMvC0REibvkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm47hsLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBB6C4CEE9;
	Wed, 14 May 2025 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747209303;
	bh=Ee7p0wfpb95gVJiPmJV8YsUQr2NDPZZTeHdvJQoBqSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lm47hsLVvpnHCy/mtp9dakLGGxoV40cZJ+tdRhgM3Y+ByJ8dan/9upaqA4Q0T2RcP
	 7AqMcudXjIm55O/8lfObGjo18CVI1bVpTzSmU9H9If+I5+O681IB3c5nPPuvEK7+/g
	 nzlGuRxnQPkI1ggAjDPSBThc2qRNYM3yzteJ3ikCzZ4S8iALfi3iVjah62E+NPKVSs
	 PTnVphuohzp7RPQQgPLTivSz+Xb7fxz/EP8QnkYgAWtkpB6tioypTcu6KYE6sQ1h+r
	 h562fJTDY2dMslo0K2Ep17FeVKCwhnb3ZLO4bCpsy8SdDDwQ7nbbzJoH5GfraOR70x
	 mWK3EmvgLBuxQ==
Date: Wed, 14 May 2025 09:54:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Shivank Garg <shivankg@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	luto@kernel.org, peterz@infradead.org, rafael@kernel.org,
	pavel@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	sohil.mehta@intel.com, rui.zhang@intel.com, yuntao.wang@linux.dev,
	kai.huang@intel.com, xiaoyao.li@intel.com, peterx@redhat.com,
	sandipan.das@amd.com, ak@linux.intel.com, rostedt@goodmis.org
Subject: Re: [PATCH RESEND 1/4] x86/mm: pgtable: Fix W=1 build kernel-doc
 warnings
Message-ID: <aCRMT0TlpFvpRGYk@gmail.com>
References: <20250514062637.3287779-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514062637.3287779-1-shivankg@amd.com>


* Shivank Garg <shivankg@amd.com> wrote:

> Warnings generated with 'make W=1':
> arch/x86/mm/pgtable.c:623: warning: Function parameter or struct member 'reserve' not described in 'reserve_top_address'
> arch/x86/mm/pgtable.c:672: warning: Function parameter or struct member 'p4d' not described in 'p4d_set_huge'
> arch/x86/mm/pgtable.c:672: warning: Function parameter or struct member 'addr' not described in 'p4d_set_huge'
> ... so on
> 
> Add missing parameter documentation in page table functions to
> fix kernel-doc warnings.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  arch/x86/mm/pgtable.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index f7ae44d3dd9e..8a5bc4545ad3 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -614,7 +614,7 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  
>  /**
>   * reserve_top_address - reserves a hole in the top of kernel address space
> - * @reserve - size of hole to reserve
> + * @reserve: Size of hole to reserve.
>   *
>   * Can be used to relocate the fixmap area and poke a hole in the top
>   * of kernel address space to make room for a hypervisor.
> @@ -665,6 +665,9 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
>  #ifdef CONFIG_X86_5LEVEL
>  /**
>   * p4d_set_huge - setup kernel P4D mapping
> + * @p4d: Pointer to a p4d entry.
> + * @addr: Virtual Address associated with p4d.
> + * @prot: Protection bits to use.

How about using the same capitalization you already see in this 
description?

>  /**
>   * p4d_clear_huge - clear kernel P4D mapping when it is set
> + * @p4d: Pointer to the p4d entry to clear.

Ditto.

>   * pud_set_huge - setup kernel PUD mapping
> + * @pud: Pointer to a pud entry.
> + * @addr: Virtual Address associated with pud.
> + * @prot: Protection bits to use.

Ditto.

>   * pmd_set_huge - setup kernel PMD mapping
> + * @pmd: Pointer to a pmd entry.
> + * @addr: Virtual Address associated with pmd.
> + * @prot: Protection bits to use.

Ditto.

> @@ -745,6 +755,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
>  
>  /**
>   * pud_clear_huge - clear kernel PUD mapping when it is set
> + * @pud: Pointer to the pud entry to clear.

Ditto.

>   * Returns 1 on success and 0 on failure (no PUD map is found).
>   */
> @@ -760,6 +771,7 @@ int pud_clear_huge(pud_t *pud)
>  
>  /**
>   * pmd_clear_huge - clear kernel PMD mapping when it is set
> + * @pmd: Pointer to the pmd entry to clear.

Ditto.

Thanks,

	Ingo

