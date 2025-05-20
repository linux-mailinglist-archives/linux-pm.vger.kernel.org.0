Return-Path: <linux-pm+bounces-27398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DF1ABD36F
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 11:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621DE17FE93
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AD825DCE2;
	Tue, 20 May 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCP0vsga"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B51DE4FB;
	Tue, 20 May 2025 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733604; cv=none; b=i6SMcdqlctfsIaP00r3Nqt5pYI4x/JqfiAOWjAuPYoA4CajxOluHwy9F2oQbqG0w6JJNO/oYggO2u652chpONrYNSPyQY5VndfTmUDtgfpLIXfiAzjWGj2e5gsveC10P7AwE26vtsD+MZyiSOWfbhesl0Mh1yo4rc5V2Ka0KWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733604; c=relaxed/simple;
	bh=y2sAie8SMNxXSJerFLLYI36mv/9e3bmUKs1y+Iv8YFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDhUO2eh2/YDM0AlQ9qrXb9T1lmJwlBz+bLyEmVIiAhCSvXlJhngf2ge3E4KrERkoNc/pselU1Arwct5Ff3OOPQ38AZ25qY0w71975Stha1Kj9ow5j5XB6+N1kSbpsInH0H55iXyVOxN7q9kODbTKgIbxhLeT142/WIGkh+CKh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCP0vsga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19645C4CEE9;
	Tue, 20 May 2025 09:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747733603;
	bh=y2sAie8SMNxXSJerFLLYI36mv/9e3bmUKs1y+Iv8YFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCP0vsga3zMpbh4C8N4Xh0qWxmkoySavkRLrZKi3PNgicTCU+iSiV0V0pYzsk1zaf
	 mPIgfptr64u//15s62akX5F9hRpto5jy7qxPHnrfQc20c+HkN8CbMZ7VkgVgbRqOio
	 n6I7Rb9eEJi7M2wK4uXlIdnX9LEDLnnfZuLuDqOrUcTJqq0T/kXg58rU8oVrjlOEbG
	 /GD7rJwhqvU9JuRodAilzwYdnyV+tjqwhEKChPD+WFPW+EOwWupsBmYg+cUVrRVma2
	 7Do56D4e5hEOs2TA8uTbYBVt3Ak33/QjZAVjDkkwcLICgByMUqGLLe8RpDIe+YWj3z
	 tDh/W3VykpXPA==
Date: Tue, 20 May 2025 11:33:18 +0200
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
Message-ID: <aCxMXqQmHGU06l-O@gmail.com>
References: <20250518193212.1822-1-ebiggers@kernel.org>
 <aCrrMEN01O7FWY6V@gmail.com>
 <aCrsiPd3u1-tEVd0@gmail.com>
 <20250519170425.GA1243@sol>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519170425.GA1243@sol>


* Eric Biggers <ebiggers@kernel.org> wrote:

> Or we could use DEFINE_PER_CPU() = true in patch 1, then revert that 
> in patch 2 and replace it with the line in fpu__init_cpu().  But 
> again I think the split would be more likely to create problems than 
> solve them.

Well, my request would be for the first patch to simply mimic current 
(and buggy) behavior as much as reasonably possible (obviously the 
effects of BSS zeroing shouldn't be mimiced 100%) - and the second 
patch to fix the initialization-ordering bug.

Thanks,

	Ingo

