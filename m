Return-Path: <linux-pm+bounces-35117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5DDB8D980
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 13:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191D73A5F30
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 11:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B011C7012;
	Sun, 21 Sep 2025 11:00:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881C0A55;
	Sun, 21 Sep 2025 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758452417; cv=none; b=hk2+kAcieOYO3/mHV3IRLCgl74H+RR0MepGoAI6zGV1Njy8nH5p7mJDI70dmmtjc4SK3RF1d2+O5Xu0i6YBj/BwQJu0Bc+I+xei2eGJVqpYjJJAmCNq7d0lmcC3ZFsslBOLGZZHck9VMBGlxURgec3SAtVUAoNJeHAGCcX24Mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758452417; c=relaxed/simple;
	bh=ENNgxieVUg9rvRDt1ofxT4y+ucu5JSS3gwSSepg5kMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSnMyrf3RFm9B/DmOI+622KLXo2jH2Wk2RQwPpxtXfKZh0cCJi3PcxjmuD9xzU2UA2EFh/gNNsuAx/wzmJAR90fSDkYy4Z16W0Fbi/H2dw9/8AMMUTO1FzVNik4lPfdhRNgtDg5DjSW7+hA04R63t9CAGbeJFW6yKgZtR5Wr6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 602E81516;
	Sun, 21 Sep 2025 04:00:06 -0700 (PDT)
Received: from [10.57.94.196] (unknown [10.57.94.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85AE63F673;
	Sun, 21 Sep 2025 04:00:13 -0700 (PDT)
Message-ID: <d38b03ae-3958-42ae-867c-e08e7a4b3847@arm.com>
Date: Sun, 21 Sep 2025 12:00:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/topology: Implement topology_is_core_online() to
 address SMT regression
To: Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <871polxs9c.ffs@tglx>
 <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
 <CAJZ5v0gsiuK5iFY6cHaqEgP8R1sz_pWGoqac2orYvXqLE2xbDQ@mail.gmail.com>
 <87o6rowrsp.ffs@tglx>
 <CAJZ5v0htmEeivbQaumRc7zw_Zx68GpUy98ksA9L42LupjO6tWA@mail.gmail.com>
 <87ldmqwgjc.ffs@tglx>
 <CAJZ5v0gW+A-eyckySFrHc7=Qr9URdRX6NqvPgkq4gZEvs_uBWg@mail.gmail.com>
 <87cy7k5gl3.ffs@tglx>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <87cy7k5gl3.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 09:56, Thomas Gleixner wrote:
> Christian reported that commit a430c11f4015 ("intel_idle: Rescan "dead" SMT
> siblings during initialization") broke the use case in which both 'nosmt'
> and 'maxcpus' are on the kernel command line because it onlines primary
> threads, which were offline due to the maxcpus limit.
> 
> The initially proposed fix to skip primary threads in the loop is
> inconsistent. While it prevents the primary thread to be onlined, it then
> onlines the corresponding hyperthread(s), which does not really make sense.
> 
> The CPU iterator in cpuhp_smt_enable() contains a check which excludes all
> threads of a core, when the primary thread is offline. The default
> implementation is a NOOP and therefore not effective on x86.
> 
> Implement topology_is_core_online() on x86 to address this issue. This
> makes the behaviour consistent between x86 and PowerPC.
> 
> Fixes: a430c11f4015 ("intel_idle: Rescan "dead" SMT siblings during initialization")
> Fixes: f694481b1d31 ("ACPI: processor: Rescan "dead" SMT siblings during initialization")
> Reported-by: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Christian Loehle <christian.loehle@arm.com>

