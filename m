Return-Path: <linux-pm+bounces-18554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D09E3DBB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 16:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E646165333
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396FA20ADDA;
	Wed,  4 Dec 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYZ/tOLM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238541B21BA;
	Wed,  4 Dec 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324809; cv=none; b=a8gLtV2KRSHysxCUcqeGn0eyBkJx2XoH++JyycLQhdEeXjTS5e5hTPWbj8t96pkau3IKC/pZDJCB+k4VR6UpQlgEtHQLZAScLAbv/IIFiHdxDfYVlATxhrb4GxVDqg72wXCGPZ5A2egtewrlSroERl5oGlb1/LshDloJ4vRZs6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324809; c=relaxed/simple;
	bh=HI19w34WI6cqPU47FjTARhORcgDBSvzCxSsLVKHwJwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQys/plU2iAAtzqKmDUrwBsHpqF6lMzndueL78KaqitcsYYM1uUVolvEGhn9r3KE9JQGjErR3mpDrTo95CqzoIiY0xNZPX3Kls8KlEb29cLfPJ0W/wbbIsgvHsqO/h6wBcl0ss2zW7dnppwik/dn7vutKe9+EjP4vDsqM7F9T/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYZ/tOLM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733324807; x=1764860807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HI19w34WI6cqPU47FjTARhORcgDBSvzCxSsLVKHwJwg=;
  b=nYZ/tOLMac++tX9iPyUHX/O1ddoKyfRPU26l6fYveU+zB2/AJ/zVt/aJ
   t+EY9RA/y17CYZY/1juIxyGGLVDvHFxfvkwyXGzh3EIheSAvgRXJe6pRi
   J/EMYVAFy11S19KW+Rg0dVL1xGj9OeSR+Mxbwowam+RgEh4zmyuCRC+19
   TF+Y7Hoo80hqJ66cl/vO896IbQ6rrXZkdhkC7dAiKkF0OhvimyoAJLytY
   obDbYoIRbO1yQdiN5AWWrWQ6m37t4mm1AyOCsQjjZpcGi7jG6PGmza9sZ
   kEolOAwEuNvNzx7hTy0BIvhn4nGgKbgdJvquTpFz4jsBfkjfxSuqqNSxR
   w==;
X-CSE-ConnectionGUID: s5LYzpsCQ2qgOd4hkkSnRA==
X-CSE-MsgGUID: hS+RVtmBTgK4C6CDcmuyVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37256142"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="37256142"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 07:06:46 -0800
X-CSE-ConnectionGUID: zIWZrCt/SZSobVFE+XV57g==
X-CSE-MsgGUID: 8A+/0/u/Sz6SzFvqDI6B0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93471508"
Received: from dgramcko-desk.amr.corp.intel.com (HELO [10.124.223.226]) ([10.124.223.226])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 07:05:14 -0800
Message-ID: <e45dbc7c-5506-4343-b6b1-ba610e5088af@intel.com>
Date: Wed, 4 Dec 2024 07:05:14 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] SRF: Fix offline CPU preventing pc6 entry
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, gautham.shenoy@amd.com, tglx@linutronix.de,
 len.brown@intel.com, artem.bityutskiy@linux.intel.com
References: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/24 06:08, Patryk Wlazlyn wrote:
> Changes since v7:
>   * Doing the s/mwait_play_dead/mwait_play_dead_cpuid_hint/
>           and s/mwait_play_dead_with_hint/mwait_play_dead/
> 
>     as suggested by Gautham. It was a left-over from previous patches.
>     The function(s) got renamed in the patches and I forgot to update
>     the changelog accordingly for patch 4/4.
> 
> Patryk Wlazlyn (4):
>   x86/smp: Allow calling mwait_play_dead with an arbitrary hint
>   ACPI: processor_idle: Add FFH state handling
>   intel_idle: Provide the default enter_dead() handler
>   x86/smp native_play_dead: Prefer cpuidle_play_dead() over
>     mwait_play_dead()
> 
>  arch/x86/include/asm/smp.h    |  3 +++
>  arch/x86/kernel/acpi/cstate.c | 10 ++++++++
>  arch/x86/kernel/smpboot.c     | 46 ++++-------------------------------
>  drivers/acpi/processor_idle.c |  2 ++
>  drivers/idle/intel_idle.c     | 18 ++++++++++++--
>  include/acpi/processor.h      |  5 ++++
>  6 files changed, 41 insertions(+), 43 deletions(-)

Hey Patryk,

I know this series is up to v8 and we all know what it's about. But it
would be much appreciated in the future if you could send along a cover
letter. It's important and really does help reviewers dive into a series
more efficiently.

