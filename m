Return-Path: <linux-pm+bounces-16779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C0D9B7019
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 23:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B3B282387
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A821E04AE;
	Wed, 30 Oct 2024 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ML/yTSS2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AEA1CF5E0;
	Wed, 30 Oct 2024 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328917; cv=none; b=G7lnIz97c0EV8Au12LdLmB/BeCdjAHid0psSSphYGWxRQNBLTcEK/nxigIS4Obh7WsnIFLUo1lvO6uLSeerwVPsYhmOfsCNtS23Bc1QO9Hg0fWjjhP3hyrGyUK0lMOnpCFfZx+B8w35RCBRCKyTfV5US+yxvLeb7EZgtgLqEatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328917; c=relaxed/simple;
	bh=ApKRKkEuiqj4Fr3LVlwiC2tBnFMiDyBorKsWI/gS4rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ci5J3ClxwWq4iG4+NYNjZKQOiyANUgAtio3VIdNkPik//fuHC1Rpo1B8UpCzFPgDuhEVgHe6/EttZ8w/8nA3xInkGGDq3zmfqi3iEckqmrF0ivj/yesU05K/s37yANS0hyTndj/8/F9AOwRTjP8ZYoJCF+bQkZg7r8vGw9Q2Heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ML/yTSS2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730328915; x=1761864915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ApKRKkEuiqj4Fr3LVlwiC2tBnFMiDyBorKsWI/gS4rw=;
  b=ML/yTSS2n/6pWZvg36ktzMYFXpoVTWpWv4318hV5h1hD2wJezhoCCH4e
   hiEgdQTKaW0eMUrfla496uMGYhsJhtTbIt6Lu5L1Bv9nKw7sqL6v13D/V
   ovOC2NBdTgVX1uHzO2hsi9e0oGixmrz03y1MPKw6dycLZdXNzZ5cI7W8o
   MEB3Uu+VZh8cVG61QLjT6pf/sRQhBYIAVlv1fEZ0JwXmv3lUagURo2NbA
   64KvTzpoVL8xTE624RbjB0evPfEXQvXe1iBcZgGZZFbao4KN9VTTgE26x
   kSnjOrN2aNMKzevxg2cdMXo/x/saECSYhdEu6KD1d89gdNRjlKWm2Q7Ln
   g==;
X-CSE-ConnectionGUID: 1k4R44jsR+OGmKXHh+Muyg==
X-CSE-MsgGUID: ROp9ZDaXRMyH7phQNZDxnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30208303"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30208303"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 15:55:14 -0700
X-CSE-ConnectionGUID: k1WnlkV2T/e9lIC3edTOIQ==
X-CSE-MsgGUID: XAAYTiaARbGSFmfCUN61hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="105777001"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.223.155]) ([10.124.223.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 15:55:13 -0700
Message-ID: <63f7dbbc-831f-4c16-9f11-5cf2c36996d0@intel.com>
Date: Wed, 30 Oct 2024 15:55:12 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] x86/smp: Allow forcing the mwait hint for play
 dead loop
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
References: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
 <20241029101507.7188-3-patryk.wlazlyn@linux.intel.com>
 <e332a243-5a98-49ed-81be-b6db305d5dc5@intel.com>
 <0a767d20-624d-494e-96b9-5e2a379550fc@linux.intel.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <0a767d20-624d-494e-96b9-5e2a379550fc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/24 06:33, Patryk Wlazlyn wrote:
>>> +void smp_set_mwait_play_dead_hint(unsigned int hint)
>>> +{
>>> +    WRITE_ONCE(play_dead_mwait_hint, hint);
>>> +}
>>
>> This all feels a bit hacky and unstructured to me.
>>
>> Could we at least set up a few rules here?  Like, say what the hints
>> are, what values can they have?  Where do they come from?  Can this get
>> called more than once?  Does it _need_ to be set?  What's the behavior
>> when it is not set?  Who is responsible for calling this?
> 
> The other idea is to first check if currently loaded idle driver provides
> enter_dead() callback first and leave the current, deepest mwait hint
> computation code as a fallback.
> 
> Does that sound less hacky?

Yes.

> Unfortunately, it comes with a little problem. In case of kexec, we need to
> have a way to exit from the mwait loop and enter hlt to prevent offlined CPU
> from crashing when the old memory is being overwritten.

Why is this a problem?  Like I mentioning to Rafael, just *call*
mwait_play_dead() from the idle driver.

mwait_play_dead() could probably also use some refactoring because it
has 3 pieces:

	1. Should the code run at all or defer to another play dead
	   implementation?
	2. Calculating the hint (obviously not needed in your new case)
	3. Actually running mwait (including the kexec hack)

The "should the code run?" bit is superfluous but harmless if called
from the idle driver.  Ditto on the hint calculation, but you already
factored it out.  That leaves the "actually run mwait" bit which you
100% need.

> I think, we can solve it by bringing the CPU back online before we proceed
> with kexec, but I would appreciate some feedback from someone who is more
> familiar with kexec, before merging that.
> 
> We may also signal that by touching the resched flag on which enter_dead()
> code will monitor in case of mwait and enter hlt right after, but that's a
> bit hackier IMO.

That route is also fine with me, but I'm not sure it's necessary.

>> What good does the smp_ prefix do?  I don't think _callers_ care whether
>> this is getting optimized out or not.
> 
> The prefix makes it a little bit cleaner by not exporting new global symbol
> with "set_mwait_play_dead_hint" name.

I'm not following.

