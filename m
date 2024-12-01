Return-Path: <linux-pm+bounces-18309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871939DF5A3
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 13:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4532814D8
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0171C6F55;
	Sun,  1 Dec 2024 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e4zwbsvr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jMN7Cj5f"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC518A932;
	Sun,  1 Dec 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057938; cv=none; b=WRct9RtiZoFj2Lv/J5/bWWGHcQep7XaQuU/kPegLf2lpD3YZu3IZjNHVhj+3Jvb3fwyUBu6DsYVImrItmGhpVJFSUP3iUR36qTl2djhXdFBu4bJcS2n93Z71Dl+H6WpD99LP5Iofr+QS6rAoLC58wJCJb9aOT1eHFsWuQ0kyoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057938; c=relaxed/simple;
	bh=vqoBZ2lUTgcHB4SCknzvfuzB8hKb9prwsO4oHV1sr+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lDbN/ihfJVoMmkQRT1DFr/hDrcOoSi04v2TFX1uZB5m+ot+YJwQRZfgRDixGJEOtZGJs2O+j62261OpOh8y7UxxMM0KzjZZz/p9lfd2S8Uz22FIZB6UsddHXYr0UiLpH0SW3OpTp1L6A2bAmvyp9s3vJEwkj6roAj4JHJ/NAars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e4zwbsvr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jMN7Cj5f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733057934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqReeC4uSPSF0w1mSxqpdPoAVgG+54w5BCK3CxpeuCQ=;
	b=e4zwbsvr8TV5RKRYs2w8q9h0cPIXejhUhnXus91iYiyBH2rvY2O/xVf/6AviQ5RhnDF4Ub
	N8le4KSbwv4Y+0s1tAo+j/0z2ro2+14itleABCUeCbC1IlM/RpBpTP/yhypQkQ5G7jcLc5
	rNpXN9d2sU76mbtjSdNJ3wM6fyJ4yvxn+fmxAjy0l8SmNfukzecI1GIiOKg+30iSJhnPob
	jVLFANRAfSueGzdJBjhEvWjgnzxJH4jUwRxG5kb4Y3F/xoZ+OJJGxMgu5GJ4PMSHhBW+sA
	dUFGK8EHYrpXeEuSbsyWJwjBhd8mck8lA9KuS0AAxOuWozZaqUJt0rn24lp0xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733057934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqReeC4uSPSF0w1mSxqpdPoAVgG+54w5BCK3CxpeuCQ=;
	b=jMN7Cj5f0x4R1s1MRJY0gKbIK1fIJe5i0A2YJ1q0s1invMESoOJbTUSephg/XWlPKbOtUZ
	F4Gb5WOfO+kTDMDg==
To: Len Brown <lenb@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Len Brown <len.brown@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
In-Reply-To: <CAJvTdKmi6-nEwhq8edPw5g2b+ME2_HX+ctePpcPFoZPbNcXqhQ@mail.gmail.com>
References: <a4aa8842a3c3bfdb7fe9807710eef159cbf0e705.1731463305.git.len.brown@intel.com>
 <c5f9c185-11b1-4bc8-96be-a81895c2a096@intel.com>
 <CAJZ5v0iCR5ZbNz=OF1MbJUJdhCRh2P8M_MTF7eszPe5uv9_R1w@mail.gmail.com>
 <95c5a803-efac-4d90-b451-4c6ec298bdb7@intel.com>
 <CAJvTdKmi6-nEwhq8edPw5g2b+ME2_HX+ctePpcPFoZPbNcXqhQ@mail.gmail.com>
Date: Sun, 01 Dec 2024 13:58:53 +0100
Message-ID: <877c8jwodu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21 2024 at 05:22, Len Brown wrote:
> On Wed, Nov 20, 2024 at 3:21=E2=80=AFPM Dave Hansen <dave.hansen@intel.co=
m> wrote:
>> I'm not going to lose sleep over it, but as a policy, I think we should
>> backport CPU fixes to all the stable kernels. I don't feel like I have a
>> good enough handle on what kernels folks run on new systems to make a
>> prediction.
>
> FWIW, I sent a backport of a slightly earlier version of this patch,
> but all I got back was vitriol about violating the kernel Documentation on
> sending to stable.
>
> Maybe a native english speaker could re-write that Documentation,
> so that a native english speaker can understand it?

What's so hard to understand?

 There are three options to submit a change to -stable trees:

  1. Add a'stable tag' to the description of a patch you then submit for ma=
inline
     inclusion.

  2. Ask the stable team to pick up a patch already mainlined.

  3. Submit a patch to the stable team that is equivalent to a change
     already mainlined.

Is very clear and understandable english, no?

#1    is the preferred one and only requires a "stable tag"

#2/#3 can only be done once the fix is upstream as they require the
      upstream commit id.

It's clearly spelled out in the detailed descriptions of the three
options.

Thanks,

        tglx

