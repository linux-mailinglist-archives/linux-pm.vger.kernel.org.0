Return-Path: <linux-pm+bounces-18143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E39A9DA3FE
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 09:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E952280F28
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC201865E2;
	Wed, 27 Nov 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFhhgZXB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F0C133;
	Wed, 27 Nov 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696385; cv=none; b=AmggJWCnLgYWiRb41C6NGpBnwvsf3mn/JWBA0U9MG8BWME23mkzOYOVfB+C5u5tRbjbZi1TgcLJavXi11x0LpjOAYrQlL6cBSPZpK9oiA/5A9/v1ej7hzq3sOaANukKMxH0nzavEFte+WyK8AVN4TAB6neQQKdtdxKoKIuw2KR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696385; c=relaxed/simple;
	bh=M00Qhe2c1TyxMErLdNGS0w3/e24/ozEJ+9La09g5Ny4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kReCpjbpwzOJ7SO/d+OXofwKWZAcnvHDCHtIL6GywGUAPrg9BWHP7BdUetkl/qLPjQsoZ3TPNXN++dZ3HdsUJ6/P2tnGAJwjSkpI6U2ZlNK56hbS0fPz2lPixMBjYTAVuMiUnNH0oMcnctypI3EJGc+qZGkKzfPhB7g0VfwOODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFhhgZXB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732696385; x=1764232385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M00Qhe2c1TyxMErLdNGS0w3/e24/ozEJ+9La09g5Ny4=;
  b=gFhhgZXBHuLLGQV/uv+jEzpOxAZWFLmO84nYIDlYNGgzyxd7+VuFyzXE
   B30FzBBKzXvCm3/Ad5kfzNq6rF6d+Mj3ZSqumc797o4isI5+WiVF3n/V8
   PV6GHPbortEGaYxtN2AVKtNgnoOoi4JFPQ5Tz1sRoH2UpNeWwtbwovTHl
   jw0WvAGTfBxlo71fBZt9Zq9t6yZOGFVk/5YTDLc9O4EBE48vLwm6kufx3
   Aq5sRAxttpH3qTT8HkaKDABVjsibWbLziPF745ZAjfFGWkhI6F0UaKDaR
   EG87izjNlleF9JA5O/G2sd4+3GqghtgoFZxFWeJJiXGqf2hVOfxGwe9hv
   Q==;
X-CSE-ConnectionGUID: EXBRFwfzSTqblG4wnO2S2w==
X-CSE-MsgGUID: Ys8N09OgQ5yBXYVaS8cE3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="44270137"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="44270137"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 00:33:04 -0800
X-CSE-ConnectionGUID: tA1MtW3XQ9amREhmESy8GA==
X-CSE-MsgGUID: yNROq1b9Se2bQqSJsIorQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="92186043"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.42]) ([10.245.244.42])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 00:33:01 -0800
Message-ID: <9a918226-4f93-4ee5-8673-20d82802f126@linux.intel.com>
Date: Wed, 27 Nov 2024 09:32:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] x86/smp: Allow calling mwait_play_dead with an
 arbitrary hint
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, tglx@linutronix.de, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com
References: <20241126201539.477448-1-patryk.wlazlyn@linux.intel.com>
 <20241126201539.477448-2-patryk.wlazlyn@linux.intel.com>
 <Z0a0JNRPuRYaVrcI@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <Z0a0JNRPuRYaVrcI@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Hello Patryk,
>
> Apologies for what may appear as bikeshedding, after this patch, the
> cpuidle code still won't call any mwait based play dead loop since the
> support for enter_dead for FFh based idle states in acpi_idle and
> intel_idle only gets added in Patches 2 and 3.
>
> Does it make sense to split this Patch 1 into 2 patches : 1/4 and 4/4
>
> 1/4 just introduces the mwait_play_dead_with_hint() helper which will
> be used by patches 2 and 3.
>
> 4/4 get rids of the of logic to find the deepest state from
> mwait_play_dead() and modifies native_play_dead() to call
> cpuidle_play_dead() followed by hlt_play_dead() thus removing any
> reference to mwait_play_dead(). Optionally you can even rename
> mwait_play_dead_with_hints() to mwait_play_dead().
>
> That way the changelog that you have for this patch can be used in 4/4
> since with the addition of play_dead support for FFh states in both
> acpi_idle and intel_idle via patches 2 and 3, the logic to find the
> deepest ffh state in mwait_play_dead() is no longer required.
>
> Thoughts ?

Yeah, makes sense. I just wanted to simplify, but at some point crossed my mind
that submitting it like you suggested may be better. I am going to split that
if I don't see any objections.


