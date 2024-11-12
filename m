Return-Path: <linux-pm+bounces-17396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9889C571D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9FD0B2FF53
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C1227BBF;
	Tue, 12 Nov 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKW45k52"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA5215C4A;
	Tue, 12 Nov 2024 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409036; cv=none; b=Pbz5CVu1uCxTIqeBjBqkqaLLILsnjMXuRqUCg+Xad8zVCHOW3fNGhw+Xn0A8cLAs9HhTwYHrxibjCnhFpnS10ufrHeGXKPM3lShQlCNHu4NSC3c3aAKw8qEaWp6VJJ+jrw9FsA+xHff49p9V/0DdWQNdqy72o0aA1yCTAMmJauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409036; c=relaxed/simple;
	bh=D8CLB+QVDoT/dpKFkNC+AMXz7qhNJvRPFViHQQlXINs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQgHg1eFFRaywBfGlqto2nsBKfl8p+pMrdXjbYzJAkL0pr9i3nIIF87Qlb6MnzVXzqfz/rhwx4MSKT+XdF1FD5GoAbRPff5Z2+8HriNzqCrxcxaAGp+Fq95iI1xhPt6QGs/f9xywQZSo68WnfNt+9DVqeh37xIetWaz6bCfQl/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKW45k52; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731409035; x=1762945035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D8CLB+QVDoT/dpKFkNC+AMXz7qhNJvRPFViHQQlXINs=;
  b=KKW45k52df4yNmZ8n3/KKzhqhbHHJWhJpnHqyNlKNaAfqqzd0dT3vYNR
   gMfiH27fw98ehFdPgJLFvvLvfv7/S3o16NyAS4P0WJUafwBQl6C9bB36U
   C1e2yP6U2eL9Ci07p8qWxadXzH83V2Zkam/kqzFSsZOV39Y7AQVZ62EoQ
   VBOjvNPnIMPAaayVh4yonzndDBPGPbfEHylBrACr7HT0Qb1HljOi1Ow5O
   SsXFDeJ1NPRnUDi7noW6J0zMglAaqlc/URjP4wuTVAVzKtigRAdMtS8g3
   LGE8EKMSMZyLAFm3GUA3PCFjRJgOETzIOLBo+7wfpfdqn8B4YtFKGn2rd
   w==;
X-CSE-ConnectionGUID: jldYH1ZPRwecGDDnmRkjmA==
X-CSE-MsgGUID: 2S+NoN5KQHydpTgdIwCNjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31092917"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31092917"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:57:15 -0800
X-CSE-ConnectionGUID: ve61iGykRempLIsm53Qq1w==
X-CSE-MsgGUID: eLMfv8+PRIa9y90PrVyC9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87760186"
Received: from opintica-mobl1 (HELO [10.245.244.216]) ([10.245.244.216])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:57:11 -0800
Message-ID: <ee9b0a70-6f44-4203-bba9-c07d94444ad6@linux.intel.com>
Date: Tue, 12 Nov 2024 11:57:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] intel_idle: Provide enter_dead() handler for SRF
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-4-patryk.wlazlyn@linux.intel.com>
 <b6ab357c-1562-4035-ad3a-2159d2c8c1fa@intel.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <b6ab357c-1562-4035-ad3a-2159d2c8c1fa@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> This series has said multiple times how the old algorithm is wrong.  But
> it never actually _fixed_ the bad algorithm, only worked around it.
>
> Does mwait_play_dead() itself need to get fixed?

I don't think so. The old algorithm gives fairly good heuristic for computing
the mwait hint for the deepest cstate. Even though it's not guaranteed to work,
it does work on most of the platforms that don't early return. I think we should
leave it, but prefer idle_driver.

>> Define the enter_dead() handler for SRF.
>
> This effectively gets the mwait hints from ______ instead of using the
> calculation in mwait_play_dead().

Ok.

>> +static __cpuidle int intel_idle_enter_dead(struct cpuidle_device *dev,
>> +                       int index)
>> +{
>> +    struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>> +    struct cpuidle_state *state = &drv->states[index];
>> +    unsigned long eax = flg2MWAIT(state->flags);
>> +
>> +    /* Retruns only in case of an error. */
>
>        ^ returns?

Yup. Will fix.


