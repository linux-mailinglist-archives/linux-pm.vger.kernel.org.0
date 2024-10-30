Return-Path: <linux-pm+bounces-16737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABE9B6430
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 14:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B071C21396
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9ED1EC019;
	Wed, 30 Oct 2024 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hddpBxgF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8681EBA16;
	Wed, 30 Oct 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295233; cv=none; b=Ve1hwrWbc3rdKWAtEcgKcFePRapgU7EcehOznaBUCE6tvAVZVCo539D6EUF95EW/3K5GV4u11VzLUQjbYWQdF5f3/0lGHneQ0P8iQwCNcSr9y3KRv1bGEAETKmGeKttXpCUNgelZwch+ggOSMx27lO0w1LFxPrJbEzq/wvCmGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295233; c=relaxed/simple;
	bh=VTEgTYA6sgpsr3ySzrt1Dq/bsgM4F9WzEu+pngiVvnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6V0AUwXkdMfmOrUkZlVhElgW5ksQqWUBGsiCNi9tQs0yKifmO0ipEd1gzVpjkCh6LzMl6HfTapG6jQlCL1RiPjUIvx36aGngF3KhdW0VIOVhkdNFh2DsKsbrrT3J3ofVK+Tp/o0evtLWGo4uk5rfH9794JZZIpQOVJSubZF9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hddpBxgF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730295232; x=1761831232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VTEgTYA6sgpsr3ySzrt1Dq/bsgM4F9WzEu+pngiVvnU=;
  b=hddpBxgFmOWFaZNGKtheFwuwPFo4bDqbMFohxS5TSyi3CvvyONnR+t03
   zzgMXPJxQQdZ3AFph1juZkz8dZAT5UdQqgesMFgDkRYbjlpVutD1aWaUj
   z+thmdnYXBag+qQC63C7nKD7UDA4NyOwRlxjyZq0I/rd/ofQK/5rev4Az
   g7ERR8nyGTeBtX5DduqQkrwgxjw9PRBzUSa+V5JpPWthqPlmhJmGnjQ4m
   hFsvwgSp3H+/9rwNrpxQSqRNom1NiufrL1v9wDLp8DWYAT43/Khyk/QZr
   pltoA3XpWKv6HH0Mjs69A61H2rU9bUxBJvbDeEUHOITQtCx9qeFKPMEZt
   w==;
X-CSE-ConnectionGUID: dXNVfxqnTR6ZcLN1XRxCxg==
X-CSE-MsgGUID: 75D4mzFrS1OOGDQZPqlYjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41095881"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41095881"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 06:33:46 -0700
X-CSE-ConnectionGUID: Z9l4bGpbQKC/PBdy3zs/Gg==
X-CSE-MsgGUID: KRDy3Qs8Q36Vsw+faOgV2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="119774212"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.244.247]) ([10.245.244.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 06:33:42 -0700
Message-ID: <0a767d20-624d-494e-96b9-5e2a379550fc@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] x86/smp: Allow forcing the mwait hint for play
 dead loop
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
References: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
 <20241029101507.7188-3-patryk.wlazlyn@linux.intel.com>
 <e332a243-5a98-49ed-81be-b6db305d5dc5@intel.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <e332a243-5a98-49ed-81be-b6db305d5dc5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> +void smp_set_mwait_play_dead_hint(unsigned int hint)
>> +{
>> +    WRITE_ONCE(play_dead_mwait_hint, hint);
>> +}
>
> This all feels a bit hacky and unstructured to me.
>
> Could we at least set up a few rules here?  Like, say what the hints
> are, what values can they have?  Where do they come from?  Can this get
> called more than once?  Does it _need_ to be set?  What's the behavior
> when it is not set?  Who is responsible for calling this?

The other idea is to first check if currently loaded idle driver provides
enter_dead() callback first and leave the current, deepest mwait hint
computation code as a fallback.

Does that sound less hacky?

Unfortunately, it comes with a little problem. In case of kexec, we need to
have a way to exit from the mwait loop and enter hlt to prevent offlined CPU
from crashing when the old memory is being overwritten.

I think, we can solve it by bringing the CPU back online before we proceed
with kexec, but I would appreciate some feedback from someone who is more
familiar with kexec, before merging that.

We may also signal that by touching the resched flag on which enter_dead()
code will monitor in case of mwait and enter hlt right after, but that's a
bit hackier IMO.


> What good does the smp_ prefix do?  I don't think _callers_ care whether
> this is getting optimized out or not.

The prefix makes it a little bit cleaner by not exporting new global symbol
with "set_mwait_play_dead_hint" name.

