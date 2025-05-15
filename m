Return-Path: <linux-pm+bounces-27190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A050AB7E58
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1977B082E
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D89297128;
	Thu, 15 May 2025 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq/pCxjf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A6295D89;
	Thu, 15 May 2025 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747292079; cv=none; b=TFvH3PS69wT720Jhd2IPn2FaoWxZzHJ0q9tBVDlhGmo5PdcxyTs3FG+Z1xCrtXD862oQwKse9MY6iqa2GIIhyb7SUklPBFndA6MinuabL8jCJwIpaIanMN3QTfGcq0mC7dHNdnk/exlnPBvWDcCcg+Om2qGwEcCO4u6+UgCfsQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747292079; c=relaxed/simple;
	bh=2W8v5Gdhm+xnSWlzDaIimqr2v2xWvhPz810ej4BlwHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JECi3w5062j6tfRTIcU/KdrPgZ8V/KD5svpfcnNJsTkQgdlIc32K+d3QoPSepH5jaSfJUO9KzYGhBZiZCLkJMJ5fY8MleM5ILJnRXSO/Vwytm4I1v17fMicWgHWvEGKbo5IL+YQLJ7LSbHt20qxj8Xahqtxy49T7Z88DT0vI6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq/pCxjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347FFC4CEE7;
	Thu, 15 May 2025 06:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747292079;
	bh=2W8v5Gdhm+xnSWlzDaIimqr2v2xWvhPz810ej4BlwHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gq/pCxjfX6mGmuXzyMRIfxOX4elFRSCNmBy7cdeJgUJ33gGLHj1HwHR82HMFdDPaF
	 Itmn53oheVwh+KYS3jmmOAQe4tsr6+h1uQLF4DBAHe1gDFuThYW0tyTJHvDakrheX8
	 8EsZ5REZ4rDo8+xFxQ564SyoLpowEL2ap8g068TTp6Mf998kOiDttJYhXPwVlfj+LP
	 W7OPLjs6C5TAveGNsNU0GDNFKdbrFv2WUpRuAf42hUEbnNQ5lUEwiL5N1DFqdEopR8
	 5p2lQLExDhfwP+m1+o2nWxFCyC10Dr9GqeARwrvDI75rx5x2bG02m5r618oEI5osiz
	 WYW52mzq9Oe+w==
Date: Thu, 15 May 2025 08:54:31 +0200
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
Message-ID: <aCWPp4wYwauSuTed@gmail.com>
References: <20250514062637.3287779-1-shivankg@amd.com>
 <aCRMT0TlpFvpRGYk@gmail.com>
 <6c4b227e-abdd-4e7f-8abd-d85cae0f0ec3@amd.com>
 <aCRgRxmO6rsR-0k3@gmail.com>
 <c5ad88e9-434a-4399-8e21-3c41e9295e93@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ad88e9-434a-4399-8e21-3c41e9295e93@amd.com>


* Shivank Garg <shivankg@amd.com> wrote:

> 
> 
> On 5/14/2025 2:50 PM, Ingo Molnar wrote:
> > 
> > * Shivank Garg <shivankg@amd.com> wrote:
> > 
> >>>> @@ -665,6 +665,9 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
> >>>>  #ifdef CONFIG_X86_5LEVEL
> >>>>  /**
> >>>>   * p4d_set_huge - setup kernel P4D mapping
> >>>> + * @p4d: Pointer to a p4d entry.
> >>>> + * @addr: Virtual Address associated with p4d.
> >>>> + * @prot: Protection bits to use.
> >>>
> >>> How about using the same capitalization you already see in this 
> >>> description?
> > 
> >> Please review the revised patch with suggested changes.
> > 
> > I think you misunderstood: why are you using 'p4d', while a line before 
> > it's 'P4D'? It's an acronym, and only used lowercase when it's a local 
> > variable. 'p4d is a pointer to a p4d entry' is doubly confusing in that 
> > regard ...
> > 
> > Same for PMD/PUD etc.
> > 
> 
> Thank you for the clarification. I understand it now.
> I hope the attached patch looks good now.

No. Please re-read your patches and see whether you caught everything, 
not just the things I pointed out ...

>  /**
>   * reserve_top_address - reserves a hole in the top of kernel address space
> - * @reserve - size of hole to reserve
> + * @reserve: size of hole to reserve.

And here the original capitalization in your -v1 patch was better.

>   * p4d_set_huge - setup kernel P4D mapping
> + * @p4d: pointer to a P4D entry.
> + * @addr: virtual Address associated with p4d.
> + * @prot: protection bits to use.

Why is 'address' capitalized here?

>  /**
>   * pud_set_huge - setup kernel PUD mapping
> + * @pud: pointer to a PUD entry.
> + * @addr: virtual Address associated with pud.
> + * @prot: protection bits to use.

s/pud
 /the PUD entry

Also, similar errors are elsewhere as well.

Thanks,

	Ingo

