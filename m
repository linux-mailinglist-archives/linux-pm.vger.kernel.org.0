Return-Path: <linux-pm+bounces-16714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4600E9B5F97
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 11:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C2A2812E4
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7233D1E2822;
	Wed, 30 Oct 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TE56r/+/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5351E261A;
	Wed, 30 Oct 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282299; cv=none; b=q9dfRzbMQShOOVx7a46RkqYjYr/Yt+nUhEM9Up2QdW2El2Fyb0NzwY8GjnPIfJkI8DH3fimdfvOV5ZLsALPc9OooRpaJCc/gu+ub+FIFrs3ghSvEDbeFmB7M3Yy2O8pOa3skPPD/WhU62gWuuz13MGhJraSN5AEJNB8r0J2poAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282299; c=relaxed/simple;
	bh=mpF96gC+u0JV8/EfergvM3ORViWhy5jxXF5QKnaKLxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkRCS5RFfGMInSVK/8Ea1eFrrkJbWms6/4eQk1tw/c4pfS4Jtx7nc/hTcj8/1AFdDCkMdbzuiKeOmqxZYNgkKy8HN/H2vTUSFz2vvVeRcs2QQZFvRAftP2z9UyayWzArs07W4HTdf86g4Cu3NYlHz07NlLH7x1SLpE2Pu+2qMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TE56r/+/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730282297; x=1761818297;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mpF96gC+u0JV8/EfergvM3ORViWhy5jxXF5QKnaKLxU=;
  b=TE56r/+/BSO6KkxlUHpFBpJDl40vBKSOsG4al2m4NzwEcooqD1/U4u4N
   UybUrjqvQisiUWAeFv1aRqgsFkjBHLI3lii/3xvZs/33F2Zc9V8STWn7J
   mhvKyP3B9CNtK75lfwRGhuWxcPNL0oKIoDq6lUx7ELTi/5slRxtqY1eY0
   xCD6h5k48Fhp23DOOHXrV2aOA3HCg83yJEJPgRhG47agAqAKIUwIbvaX/
   dUUnkEs9kfZ/YOMMqBECm1NIdJdgw2FSlb6S6VR15TO3iVp/dthMmZaZn
   /PhINrjKbJcDIqlQlwbN/VqaBG4SIrneAEdl9sM2iaO+tnOvsU7h0vB+B
   w==;
X-CSE-ConnectionGUID: /a49rxMOS+2uZnV7oJPbsQ==
X-CSE-MsgGUID: uaICdWKcRmWNyBf2klbYBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="41374589"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="41374589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 02:58:16 -0700
X-CSE-ConnectionGUID: 7GyPLZY8TiaYdX5e04Z4cA==
X-CSE-MsgGUID: rdXIpNdtT02qyqCdjJ2KBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="86204713"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 02:58:15 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id 6D95820B5782;
	Wed, 30 Oct 2024 02:58:13 -0700 (PDT)
Message-ID: <35946efe3b8b8b686ba4ea0ed5c9f15c50ca6ef8.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/3] x86/smp: Allow forcing the mwait hint for play
 dead loop
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Patryk Wlazlyn
	 <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
Date: Wed, 30 Oct 2024 11:58:12 +0200
In-Reply-To: <e332a243-5a98-49ed-81be-b6db305d5dc5@intel.com>
References: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
	 <20241029101507.7188-3-patryk.wlazlyn@linux.intel.com>
	 <e332a243-5a98-49ed-81be-b6db305d5dc5@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-29 at 11:30 -0700, Dave Hansen wrote:
> On 10/29/24 03:15, Patryk Wlazlyn wrote:
> > +void smp_set_mwait_play_dead_hint(unsigned int hint)
> > +{
> > +	WRITE_ONCE(play_dead_mwait_hint, hint);
> > +}
>=20
> This all feels a bit hacky and unstructured to me.
>=20
> Could we at least set up a few rules here?=C2=A0 Like, say what the hints
> are, what values can they have?=C2=A0 Where do they come from?=C2=A0 Can =
this get
> called more than once?=C2=A0 Does it _need_ to be set?=C2=A0 What's the b=
ehavior
> when it is not set?=C2=A0 Who is responsible for calling this?
>=20
> What good does the smp_ prefix do?=C2=A0 I don't think _callers_ care whe=
ther
> this is getting optimized out or not.
>=20

The goal of 'get_deepest_mwait_hint()' is to find the mwait hint of the dee=
pest
available C-state, in order to request it for the offline CPU. On Intel CPU=
s,
the C-states and their mwait hint values are platform-specific.

Generally, there is no architectural way for enumerating mwait hints on Int=
el
CPUs. In the idle path (different to the CPU offline path), idle drivers (i=
f
enabled) enumerate and request C-states using either ACPI mechanisms or a
compiled-in, per-platform custom C-states table, provided by Intel for spec=
ific
platforms.

In the CPU offline path, only the deepest C-state hint is needed. Historica=
lly,
it was determined using a simple algorithm, which happened to provide the
correct result on most Intel platforms. This algorithm is based on scanning
CPUID leaf 5 EDX bits and building the hint value from the C-state and sub-=
state
numbers.=C2=A0

Generally speaking, mwait hints are opaque numbers, and the algorithm is no=
t
architectural. While it produces the correct results for most Intel CPUs, i=
t
produces sub-optimal result for some CPUs. For example Intel Sierra Forest =
Xeon
CPU,=C2=A0the algorithm=C2=A0produces hint 0x21, while the actual deepest C=
-state hint is
0x23. If hint 0x21 is used, the result is that the offline CPU does not ent=
er
the deepest available C-state. While this is not fatal, the CPU ends up sav=
ing
less energy than it could have saved.

The 'set_mwait_play_dead_hint()' function provides a mechanism for defining=
 the
mwait hint for the offline CPU, and can be used for platforms where the gen=
eric
non-architectural algorithm provides a sub-optimal result.

Q&A.

1. Could we at least set up a few rules here?  Like, say what the hints
are, what values can they have?

The hints are 8-bit values, lower 4 bits define "sub-state", higher 4 bits
define the state.

The state value (higher 4 bits) correspond to the state enumerated by CPUID=
 leaf
5 (Value 0 is C0, value 1 is C1, etc). The sub-state value is an opaque num=
ber.

The hint is provided to the mwait instruction via EAX.

2. Where do they come from?

Hardware C-states are defined by the specific platform (e.g., C1, C1E, CC6,
PC6). Then they are "mapped" to the SDM C-states (C0, C1, C2, etc). The spe=
cific
platform defines the hint values.

Intel typically provides the hint values in the EDS (External Design
Specification) document. It is typically non-public.

Intel also discloses the hint values for open-source projects like Linux, a=
nd
then Intel engineers submit them to the intel_idle driver.

Some of the hints may also be found via ACPI _CST table.

3. Can this get called more than once?

It is not supposed to. The idea is that if a driver like intel_idle is used=
, it
can call 'set_mwait_play_dead_hint()' and provide the most optimal hint num=
ber
for the offline code.

4. Does it _need_ to be set?

No. It is more of an optimization. But it is an important optimization whic=
h may
result in saving a lot of money in a datacenter.

Typically using a "wrong" hint value is non-fatal, at least I did not see i=
t
being fatal so far. The CPU will map it to some hardware C-state request, b=
ut
which one - depends on the "wrong" value and the CPU. It just may be sub-
optimal.

5. What's the behavior when it is not set?

The offline code will fall-back to the generic non-architectural algorithm,
which provides correct results for all server platforms I dealt with since =
2017.
It should provide the correct hint for most client platforms, as far as I a=
m
aware.

Sierra Forest Xeon is the first platform where the generic algorithm provid=
es a
sub-optimal value 0x21. It is not fatal, just sub-optimal.

Note: I am working with Intel firmware team on having the FW "re-mapping" h=
int
0x21 to hint 0x23, so that "unaware" Linux kernel also ends up with request=
ing
the deepest C-state for an offline CPU.

6. Who is responsible for calling this?

The idea for now is that the intel_idle driver calls it.

But in theory, in the future, any driver/platform code may call it if it "k=
nows"
what's the most optimal hint, I suppose. I do not have a good example thoug=
h.

Artem.

