Return-Path: <linux-pm+bounces-7946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C94D8C8BB6
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 19:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22611F234C5
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE114037F;
	Fri, 17 May 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orQ+RWOD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F813FD81;
	Fri, 17 May 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967706; cv=none; b=XZIc0waEB+2EUDAnOpk6stVSCNaB2iiEKusvvPWAWopUWNVQRUxWYDpIh6lQUSeWHHGSxOpLAl1gHuapRaZVLGrBfrImIg1DO8bAnGRfAMxIffkFcgrjlpdIuhd562y/HPzBECM8vQCHQJIwuAXhyB/q6ww01+3R4ozsGuRFALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967706; c=relaxed/simple;
	bh=mC1ywOvsKwJqlrV9KUwm4F1IrjKMz9Sv1nAsgzY9tRA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BMclU1derU1+PAG6kDHcpPUzy2ISPQP4ARzqiktDrCkA4YL5Ag5TX2P3iajXvMBmhAr1rJKhEAK1vuGwCbhncfuXNkHpT7SZMOIBcw70AKxipgq16JmpSInQpdr10UDTw+8EScP50IsX8lJUju3jHIqVi3VclHzzvfJia5STftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orQ+RWOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABE1C2BD10;
	Fri, 17 May 2024 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715967705;
	bh=mC1ywOvsKwJqlrV9KUwm4F1IrjKMz9Sv1nAsgzY9tRA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=orQ+RWODE9Epe4j41qe3ySukioq+cxqVXRzWIqYZov0AyB4EwE/V9d0twuR7lo5jd
	 H3hqd7omgHr4yv7IwICfpKBRVZ27zv/F7wxh/pAcgrUbY4Im0BHuPVkrJkFVmgmIUP
	 Wdrwc+AXM+aBL+ixeT4npKfK9L3tibOIafK3/HpQwRz2Zd52GEdUt8E4tyY+/63GHI
	 LdEqeXplyMwjCRZNzvCq1NDZiKf6uXWN2tA8K9w8Wi7XKD1krk6JJaRfhAC4ODaBMs
	 zJkVvlrskTs4N2oxTLlZuEA/0Mc+GxTwpTI/ZZunEmoBHYqacjyIp7Xe/XNzXetfQ/
	 kK9bQvLQEuMpQ==
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
References: <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
	<87h6f4jdrq.fsf@kernel.org> <878r0djxgc.fsf@kernel.org>
	<874jb0jzx5.fsf@kernel.org>
	<feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>
	<20240515072231.z3wlyoblyc34ldmr@desk>
	<529C9374-DA6F-49C8-9B32-91741800F8E4@alien8.de>
	<20240515162747.6shmaoelc4mt7nro@desk> <878r0bhvjq.fsf@kernel.org>
	<20240516070315.swz2golcrfp3uvfd@desk>
	<20240516142513.qqy7wbmja5frizuj@desk>
Date: Fri, 17 May 2024 20:41:41 +0300
In-Reply-To: <20240516142513.qqy7wbmja5frizuj@desk> (Pawan Gupta's message of
	"Thu, 16 May 2024 07:25:13 -0700")
Message-ID: <87a5kofi96.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pawan Gupta <pawan.kumar.gupta@linux.intel.com> writes:

> On Thu, May 16, 2024 at 12:03:22AM -0700, Pawan Gupta wrote:
>> I am running the suspend test now and will update in the morning if I
>> could reproduce the hang.
>
> Completed 500 suspend iterations, but the hang is not reproduced :(
> I have restarted the test.

In a way I'm not surprised as nobody else has reported anything similar.
I guess it's something really specific on my box, so weird.

> BTW, could you please share your /proc/cmdline?

This is the simplified command line with which I can reproduce the bug:

$ cat /proc/cmdline 
BOOT_IMAGE=/boot/vmlinuz-6.9.0 root=UUID=61a268dc-df96-4e69-9272-928240dcc445 ro net.ifnames=0

> Also, was there any workload running with the suspend test?

There is no special workload when I reproduce the bug. This NUC box is
one of our test setups which I use to test ath11k and ath12k wireless
drivers, but when I'm debugging this suspend issue none of the wireless
drivers are not even loaded. I don't normally have a display connected
to the box but I do run netconsole, although I just verified that I see
the bug if I remove netconsole configuration from cmdline.

The distro is Ubuntu 20.04.6 LTS. Oh, but I do have installed a WCN6855
PCI module to the box so that I can test ath11k. That can of course make
a difference. And maybe also BIOS settings?

I think is easiest if I try get more info about with my box first, it
might be quite challenging for you to reproduce it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

