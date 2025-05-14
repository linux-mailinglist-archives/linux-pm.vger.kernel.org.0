Return-Path: <linux-pm+bounces-27128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA08CAB673D
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746BB19E7E2F
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4487422B5AA;
	Wed, 14 May 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnmRo8LQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3622759B;
	Wed, 14 May 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214416; cv=none; b=k5NLS+yAj1LY4ycGpiz5K+vK6StfqMUZ584kYA+6EXcsHo3AHpwiN4hjKQ65IjKx4/DKAghaKnwl2rJbavFuW6d+g2+DCpjiJ1QgI30nwbMxR7quN4bR2rt35ZISlGvYoQFJLSosJhZJyjPMjd0aYfiFXnedlXY1Q/fAhQUCvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214416; c=relaxed/simple;
	bh=Te/mzdTJQVi3tOLsA4uKcCRYE3xSnphzXRz0GtFpJg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeJJHrncWv3VhIsC7EToyi/tWplQW43Nr9IiFdZbAXLkNMCArKwQzUi2M6MCUwUrRq0/D0w2uytPlHzPdW3Ax86YnjBk077CfaraTXNi1vQ02imot4AjDg2ySnlBIL8/FT0Ef515fga1G78gu1zA+q7B0+nNSLmRz7wJ+2f/iDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnmRo8LQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9663C4CEEB;
	Wed, 14 May 2025 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747214414;
	bh=Te/mzdTJQVi3tOLsA4uKcCRYE3xSnphzXRz0GtFpJg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnmRo8LQpi5IKxRxe43nTenmpXHv74afXKw2XcytrIf3leNl/Kw2xr6E7ezyc7IyF
	 HBUmsCgO/s76h5HuI41hcfZa/035ub2L04/N4HCR3v6EEybdUsoyRzTyZoyuzGuoOM
	 zfyVSefVKyhr4eARe6kobUD5w34+Q9L6hHWfmQ84fG4CrmpnZPB8mMDLa2qisYw88X
	 DuCU57Qms1U7/VwcX8gtJdwh3/LBkqLbLE1J+59yCLYCwCRcFbQ3ozqC7yOlxC0261
	 0FKrDCVcoexTAG2eRIrTGrnsu23Kj8PDC1vdETTy++c4HZ7O/IsKxVFvNnurCkXHaG
	 TcmgAZfp1pU2w==
Date: Wed, 14 May 2025 11:20:07 +0200
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
Message-ID: <aCRgRxmO6rsR-0k3@gmail.com>
References: <20250514062637.3287779-1-shivankg@amd.com>
 <aCRMT0TlpFvpRGYk@gmail.com>
 <6c4b227e-abdd-4e7f-8abd-d85cae0f0ec3@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c4b227e-abdd-4e7f-8abd-d85cae0f0ec3@amd.com>


* Shivank Garg <shivankg@amd.com> wrote:

> >> @@ -665,6 +665,9 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
> >>  #ifdef CONFIG_X86_5LEVEL
> >>  /**
> >>   * p4d_set_huge - setup kernel P4D mapping
> >> + * @p4d: Pointer to a p4d entry.
> >> + * @addr: Virtual Address associated with p4d.
> >> + * @prot: Protection bits to use.
> > 
> > How about using the same capitalization you already see in this 
> > description?

> Please review the revised patch with suggested changes.

I think you misunderstood: why are you using 'p4d', while a line before 
it's 'P4D'? It's an acronym, and only used lowercase when it's a local 
variable. 'p4d is a pointer to a p4d entry' is doubly confusing in that 
regard ...

Same for PMD/PUD etc.

Thanks,

	Ingo

