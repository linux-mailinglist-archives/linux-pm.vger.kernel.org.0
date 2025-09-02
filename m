Return-Path: <linux-pm+bounces-33658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D35BB40B43
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 18:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A97561E2D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E831DDB8;
	Tue,  2 Sep 2025 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jkyy2MsO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786D283C89;
	Tue,  2 Sep 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832183; cv=none; b=oXRoxgQH3puomPzhAK5tgNx9d5SUqtDwh7vfSYjk9JuYVb+npup2pAuQWmeoYf0SuGId+hNh3PFKZfwPoU8W+EBrEhgeQPGDBOs7TssyPy/Q6olnnizKEt9b8/K5O8J//VcqLFNPyD1zssHYHA4D4403+S7jP0bepvFTgtOMiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832183; c=relaxed/simple;
	bh=M2vqCr5I7i3KfPqnsheMASeTdG7RiTSBtyebaD680CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBEV5rPLYLalJxSOvzgJ8kU/T2tcpkavpLfnVXjT+6gqfeJNgxZDY2A4wgTqOKd81OmTHnmQHt9J6VFeGnJZZSJ3y5gZvq65j83PxdFeZflvIPrk6DSaANwQu6oFQ6aUY7pk++ofsMDlKcN+E4IBNKCaHQGjZKg3z77epSVQHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jkyy2MsO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756832182; x=1788368182;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M2vqCr5I7i3KfPqnsheMASeTdG7RiTSBtyebaD680CM=;
  b=Jkyy2MsOSaYtOzI9ZdbOzeu8dgcoT1MppAkhgLmQs0USeTQJtpu1Ve5W
   gowVzNJ+ddNTcoJ3PWZ2gGkfdRKCmZxnntBwr6WoCtSJJrTWcZ9P0tanr
   v/6m3AMPFwLrj1poiRb/+lUcMbhs3r9x/g5T5uWErMMThMIVofPUnmad+
   1wHOZNIFEJLfLlSf2bGZw+14IA2I1AdoRYx98H8hqpvWydC60UQKV7Qrt
   hh2foMvSczo5JHMpL5XqU2d3aXx0I8T5afEvrFuIfibBoaM+CMrEmJQDn
   EiCXqSGuZDVZRUVQgbTev4gxDyR4kbfutX7ca1i1znx0Q7FVot7mduONc
   A==;
X-CSE-ConnectionGUID: BY+DRahsS+WNyMHV00t6EA==
X-CSE-MsgGUID: Ub3E1R7LSSqYSXBgxmZUCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69378994"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69378994"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 09:56:21 -0700
X-CSE-ConnectionGUID: fvnKOAPET8myKCVVkh9zhA==
X-CSE-MsgGUID: UxbMA+rKQayHoMfsrZToQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="176634926"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.109.202]) ([10.125.109.202])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 09:56:21 -0700
Message-ID: <4f340f1e-1cbf-4b50-ae23-a0e50170146c@intel.com>
Date: Tue, 2 Sep 2025 09:56:20 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 the arch/x86 maintainers <x86@kernel.org>
References: <12740505.O9o76ZdvQC@rafael.j.wysocki>
 <CAJZ5v0ik7fRKwH3CnXysvBJkkdJbWP-6iL=zBF0o92rR+nHTKg@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAJZ5v0ik7fRKwH3CnXysvBJkkdJbWP-6iL=zBF0o92rR+nHTKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/25 08:05, Rafael J. Wysocki wrote:
> On Fri, Aug 29, 2025 at 10:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Christian has reported that commit a430c11f4015 ("intel_idle: Rescan
>> "dead" SMT siblings during initialization") broke the use case in

Does "dead" here mean present but offline?

>> which both nosmt and maxcpus were added to the kernel command line
>> because it caused CPUs that were not SMT siblings to be brought
>> online during the intel_idle driver initialization in violation of the
>> maxcpus limit.

How does intel_idle fit in here? I don't immediately see it calling
cpuhp_smt_enable().

>> The underlying reason for this is a missing topology_is_primary_thread()
>> check in cpuhp_smt_enable() which causes that function to put online
>> more CPUs than just the SMT siblings that it is supposed to handle.
>>
>> Add the missing check to address the issue.

We should probably add a bit more checking in cpuhp_smt_enable() to make
sure that it's being called under expected conditions like a:

	WARN_ON_ONCE(cpu_smt_control != CPU_SMT_DISABLED);

and probably also some comments about how it is expected to work.

cpuhp_smt_enable() doesn't _really_ enable SMT. It specifically takes it
from DISABLED=>ENABLED. Thinking about it in that context, enabling
_just_ the secondary (disabled) threads makes a lot of sense.

But that can come later, after the bug fix.

>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -2710,6 +2710,12 @@

No 'diff -p', eh?

>>         cpu_maps_update_begin();
>>         cpu_smt_control = CPU_SMT_ENABLED;
>>         for_each_present_cpu(cpu) {
>> +               /*
>> +                * Avoid accidentally onlining primary thread CPUs that have
>> +                * been taken offline.
>> +                */
>> +               if (topology_is_primary_thread(cpu))
>> +                       continue;
>>                 /* Skip online CPUs and CPUs on offline nodes */
>>                 if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
>>                         continue;
Is there a more generic problem with this not respecting 'maxcpus'? If
maxcpus had forced a primary thread offline, this would still online the
secondary thread, even with the fix. Taking _that_ online might still
bring you over the maxcpus limit.



