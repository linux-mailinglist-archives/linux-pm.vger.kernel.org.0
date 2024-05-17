Return-Path: <linux-pm+bounces-7943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA48C8AE6
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 19:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8936A1C2154B
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A285E13DDAF;
	Fri, 17 May 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB/SYknI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB413DBBB;
	Fri, 17 May 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966638; cv=none; b=DBCu7BIwJAsrllDiu3tX/uNwkX9visQVaAycPB5VI2ofd3Whj2oDjkBucEN2vZV6vKh0wbf78FuYDP/y+an/7eo+mjEQ53tJnfZD7/WqEciumw2AS991YFMA35aNixJF+sN8SydZjb5C3f9HzfcKbyY3uFeWm/2iFIUylRE9lH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966638; c=relaxed/simple;
	bh=TZU3z8IWnx7CUMuj79eonsqv+gjyOnE3Wi/7eRQVMV8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FebMrFfmRO6hoxuwvY4xYAbPIg1Dd7qkezUCW21BzYbMZ6a9uKY9eAahv2iIDGJE+dA6r2/DGHy24xckrBojozco2Jo3yMwm8WNQlSBUuyrB/s+XuyriekuoPNBCdNxrapV1zIpN7y8DId96HjnW8umWCXlqywGQKOskf9yTOp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB/SYknI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DED1C32781;
	Fri, 17 May 2024 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715966638;
	bh=TZU3z8IWnx7CUMuj79eonsqv+gjyOnE3Wi/7eRQVMV8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gB/SYknIfX9sI4KFtCfwEgWuqQGrimVZmGjZQHRaW3A+VyvlafCF9LF/uWJhxRRR+
	 OT/WiL+wwMkEv8ztFZ7uO98Lx+Qg+RSasTD8ucxZxxmVJhjfPw0KwEjhdPDbX4G+zf
	 PmDfZ1HnhrQE88VUwYCXFnKbCMIP5w/k/EIIP1kEAraC+T8ctXAqNTEDjHIEfGz8GV
	 eWkDYty8VCkwLU8X5qoeF+NgsESdbdmjf3dtzD/yFO/ASpd54/Yf+s9n7FyH4lVNJm
	 9PwinlTjoYe8kKUBG+z2QPd3qijcOrj3OhXYw8jGsgiCRlaU1X51Bg7XEQ+s1kVB3z
	 WuCKF5jMLhDtQ==
From: Kalle Valo <kvalo@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@intel.com>,
  Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Dave Hansen <dave.hansen@linux.intel.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  x86@kernel.org,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  regressions@lists.linux.dev,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  Daniel Sneddon
 <daniel.sneddon@linux.intel.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
References: <87o79cjjik.fsf@kernel.org>
	<20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
	<20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
	<87h6f4jdrq.fsf@kernel.org> <878r0djxgc.fsf@kernel.org>
	<874jb0jzx5.fsf@kernel.org>
	<feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>
	<20240515072231.z3wlyoblyc34ldmr@desk>
	<529C9374-DA6F-49C8-9B32-91741800F8E4@alien8.de>
	<20240515162747.6shmaoelc4mt7nro@desk>
Date: Fri, 17 May 2024 20:23:53 +0300
In-Reply-To: <20240515162747.6shmaoelc4mt7nro@desk> (Pawan Gupta's message of
	"Wed, 15 May 2024 09:27:47 -0700")
Message-ID: <87eda0fj2u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pawan Gupta <pawan.kumar.gupta@linux.intel.com> writes:

> On Wed, May 15, 2024 at 09:44:42AM +0200, Borislav Petkov wrote:
>> On May 15, 2024 9:22:31 AM GMT+02:00, Pawan Gupta
>> <pawan.kumar.gupta@linux.intel.com> wrote:
>> > Other interesting thing to try is cmdline
>> >"dis_ucode_ldr".
>> 
>> Right, is his microcode revision 0xf4 the right one for that model?
>
> 0xf4 microcode is not the latest one, the latest is 0xf8:
>
> https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/blob/main/intel-ucode/06-9e-09
>
> Kalle, can you please try with 0xf8 and see if the issue is still present?

I updated to this version:

[   11.907565] microcode: Current revision: 0x000000f8
[   11.907614] microcode: Updated early from: 0x000000ea

But unfortunately no luck, the suspend still fails after 29 loops.

