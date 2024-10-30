Return-Path: <linux-pm+bounces-16760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8D69B6CEB
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 20:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586BDB2199D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 19:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048C51BD9D3;
	Wed, 30 Oct 2024 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5ioA+1+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC41CBE89;
	Wed, 30 Oct 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730316759; cv=none; b=BTRZXleJNIPcbOFwiFFqz4g17eFNh/XwS88PQRpLw+gNdYN3j7uRQTJEILoKBOgy6C3+MADEXfhss/78mXiM6/oHaXGv31Z0UCTLO0qs13kV4pG8i+FTeAc87a+h1+f+i320CLomtclc6Zp61Bdc0uvJxHwbX/I1e6p8d0/kr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730316759; c=relaxed/simple;
	bh=FMoaAeaVrk5Lr5l4ls6yBKCVbOI5cJZzYqQJi5jPV8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Illh5LQrdk6lXCtWM7LIzhk6sY3VSpcc8ZqbWkasMQc5hs2lcVbkiuFLv3CHCoVhtmqBFMj5HdBiiZLYANSDzsirswkCmYdT2oIY+9Zl92uYskTQFNNJoPd2LMxnuJHKHL64OW6z2FCIpgohIBW+IGx9EZ2MOE82fKGWDHzzcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5ioA+1+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730316758; x=1761852758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FMoaAeaVrk5Lr5l4ls6yBKCVbOI5cJZzYqQJi5jPV8I=;
  b=d5ioA+1+ovgY5BDOyrQuYC/nDCcCAQhG3Pj+9B+m9igwS8J57fMjbMnE
   qYecIwAPzYewppT0z+n/3q3l9pDCn2wQC0kX/OWmqZhIzdQFr1PocbrGB
   C/87Ldcw+YAh0h/ItYAhVBFkKkZZm83cu4rurvttqu0plrYOJfm5KzEJQ
   kQ/3vhRDKZL8ZygDp/1DBzN6aps7WS85LHTTpjrMQ1mGoAnVS2IYboup4
   4oXwolV7RwIUsYIWHCGh6uH++B0mAjDVYnqTARZh5YmhaG1ViOUzIoGwb
   WvpKIMtrAGkXldVVx6FunwK8MvPuB5cv33IYh2G8+yhykqkJzkA4GDWGG
   w==;
X-CSE-ConnectionGUID: p5J/BXT/SXeDUijzzlDMGg==
X-CSE-MsgGUID: tiGL17jIRWy2ds004bBMAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41435707"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41435707"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 12:32:36 -0700
X-CSE-ConnectionGUID: ApOo5EZiSzyS/Qf41FMUOg==
X-CSE-MsgGUID: FBVbtbAMTw2b6vYmvbB8Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="119874707"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.223.155]) ([10.124.223.155])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 12:32:36 -0700
Message-ID: <000fd68e-2b24-4eb3-b2d7-e4856b403212@intel.com>
Date: Wed, 30 Oct 2024 12:32:34 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] x86/smp: Allow forcing the mwait hint for play
 dead loop
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
References: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
 <20241029101507.7188-3-patryk.wlazlyn@linux.intel.com>
 <e332a243-5a98-49ed-81be-b6db305d5dc5@intel.com>
 <35946efe3b8b8b686ba4ea0ed5c9f15c50ca6ef8.camel@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <35946efe3b8b8b686ba4ea0ed5c9f15c50ca6ef8.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 02:58, Artem Bityutskiy wrote:
> On Tue, 2024-10-29 at 11:30 -0700, Dave Hansen wrote:
> 1. Could we at least set up a few rules here?  Like, say what the hints
> are, what values can they have?
> 
> The hints are 8-bit values, lower 4 bits define "sub-state", higher 4 bits
> define the state.
> 
> The state value (higher 4 bits) correspond to the state enumerated by CPUID leaf
> 5 (Value 0 is C0, value 1 is C1, etc). The sub-state value is an opaque number.
> 
> The hint is provided to the mwait instruction via EAX.

OK, so can you distill that down to something succinct and get it in a
comment above the new function, please?

> 2. Where do they come from?
> 
> Hardware C-states are defined by the specific platform (e.g., C1, C1E, CC6,
> PC6). Then they are "mapped" to the SDM C-states (C0, C1, C2, etc). The specific
> platform defines the hint values.
> 
> Intel typically provides the hint values in the EDS (External Design
> Specification) document. It is typically non-public.
> 
> Intel also discloses the hint values for open-source projects like Linux, and
> then Intel engineers submit them to the intel_idle driver.
> 
> Some of the hints may also be found via ACPI _CST table.

What about the mwait_play_dead() loop that calculates the hint?  Doesn't
that derive the hint from CPUID?

> 3. Can this get called more than once?
> 
> It is not supposed to. The idea is that if a driver like intel_idle is used, it
> can call 'set_mwait_play_dead_hint()' and provide the most optimal hint number
> for the offline code.

There are two important nuggets in there:

First, an idle driver can but is not required to set the hint.  This
would be good comment material.

Second, only one thing is supposed to set the hint.  This is a good
thing to WARN() about.

> 4. Does it _need_ to be set?
> 
> No. It is more of an optimization. But it is an important optimization which may
> result in saving a lot of money in a datacenter.
> 
> Typically using a "wrong" hint value is non-fatal, at least I did not see it
> being fatal so far. The CPU will map it to some hardware C-state request, but
> which one - depends on the "wrong" value and the CPU. It just may be sub-
> optimal.

OK, so this tells me we *don't* want some kind of:

	WARN_ON(play_dead_mwait_hint == PLAY_DEAD_MWAIT_HINT_UNSET);

warning.

> 5. What's the behavior when it is not set?
> 
> The offline code will fall-back to the generic non-architectural algorithm,
> which provides correct results for all server platforms I dealt with since 2017.
> It should provide the correct hint for most client platforms, as far as I am
> aware.
> 
> Sierra Forest Xeon is the first platform where the generic algorithm provides a
> sub-optimal value 0x21. It is not fatal, just sub-optimal.

What is the non-architectural algorithm?  Which Linux code are you
referring to?

> Note: I am working with Intel firmware team on having the FW "re-mapping" hint
> 0x21 to hint 0x23, so that "unaware" Linux kernel also ends up with requesting
> the deepest C-state for an offline CPU.

That would be great as well.  Thanks for doing that!

> 6. Who is responsible for calling this?
> 
> The idea for now is that the intel_idle driver calls it.
> 
> But in theory, in the future, any driver/platform code may call it if it "knows"
> what's the most optimal hint, I suppose. I do not have a good example though.

So let's look at how this works:

void native_play_dead(void)
{
...
        mwait_play_dead();
        if (cpuidle_play_dead())
                hlt_play_dead();
}

This _existing_ code has three different ways of playing dead (in this
order of preference):

 1. mwait
 2. cpuidle
 3. hlt

It has (at least) two different mechanisms for telling which of these to
call:

  1. mwait has a bunch of built-in logic that will ensure the CPU
     should use for playing dead.  If not, it does nothing and returns.
  2. cpuidle_play_dead() (only used by acpi_idle_driver as far as I can
     tell) will return an error if it does not support playing dead

If 1 and 2 fail, then hlt_play_dead() gets called.

But the really fun part of this is that idle driver is *called* here.
The driver that is also responsible for overriding the mwait hint.

So this series opts to have the boot code plumb the hint back into a
basically undocumented global variable while also assuming that the
system is *going* to use mwait.  It then does *nothing* with the
callback just adjacent to the code it wants to modify.

Seems rather spaghetti-like to me.

To make it worse, go look at da6fa7ef67f0 ("x86/smpboot: Don't use
mwait_play_dead() on AMD systems").  It hacks AMD-specific code in
mwait_play_dead() just to force the cpuidle code to get called.

What if we did this?  First, introduce a helper:

	bool mwait_play_dead_with_hint(u32 hint)

and then restructure native_play_dead() to look like this:

static mwait_play_dead_generic(void)
{
	u32 hint = get_deepest_mwait_hint();

	return mwait_play_dead_with_hint(hint);
}

void native_play_dead(void)
{
	bool used;

	used = cpuidle_play_dead();
	if (used)
		return;

	used = mwait_play_dead_generic();
	if (used)
		return;

	hlt_play_dead();
}

If the cpuidle drivers want to use mwait with a different hint, they
override the *EXISTING* drv->states[].enter_dead() functionality and
call mwait_play_dead_with_hint() with their new hint.  Then they don't
need to pass anything _over_ to the mwait code.

Wouldn't something like that makes this all much more straightforward?

