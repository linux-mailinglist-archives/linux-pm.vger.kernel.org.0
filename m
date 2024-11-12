Return-Path: <linux-pm+bounces-17395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E19C562A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BDF1F207C2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D3226B60;
	Tue, 12 Nov 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qz38Ai9X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028662259F4;
	Tue, 12 Nov 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408963; cv=none; b=F/Ka0wCLHQxJxmtVoTMdAc5y8oa9U5ibTyu3wS3wfUtvxSeEOC0vIk2t6JCxL/dbVnXxlssXuVzwt8hn0As8DOuoAE/lDuaZuaIFKyqawTlx5BBDpwIR/vAevn+4PEM0GX2tzhn3D/UuihyQZ0uew+xJ9WFzd/GXnhPNLbIuaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408963; c=relaxed/simple;
	bh=EpeEtjlHWVXs+suvJz/GrveenUpZ/Qy+eXbgaVF7xhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmmSWzrWR/lNQ4UBUDoADeoNSXvgbnrc5rLFSpCZcnYQUeSui0Fm9WNHwyLI2ss4xTnn7lgk2Qma9prL3GdUwhkFft1izkc2tIakDee5NTgKuOXRL7ahLlqH8YdBpHtfVGOGf/ZnszopfaqcaOs0dvLn/clVRT7MO7RYNEQM+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qz38Ai9X; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731408962; x=1762944962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EpeEtjlHWVXs+suvJz/GrveenUpZ/Qy+eXbgaVF7xhE=;
  b=Qz38Ai9XaaED5Ukrd9hpAsrxTQlzNGNbPkatA2a0diF4h5hIEbJlusc4
   sKggr7C17cgBL/ZBY9UNEFl+BKinn7Qmbf8V5OGeykSyHeJAT99BH/n5Q
   EFQozD9DukETJvXLHP7gTi9Jm/vJHK4d9QZcDIgES6eGDFEEeHWY/MJBj
   DHTr1wEPmn/ZyQotuN4sFIyqSWi1ggGyiQ5pZPZpyZdt2aztNJKyDFKV1
   ySi2iWiZmcHwRwWrREvBGSuywXoWsTbWXEeyOifmJfT20ZiH2yJXP234d
   xwyCI8aJdE0Xt6D7uCns7JllG66GadxAIwSEISpGUBNOXv23s8tzpAS5P
   w==;
X-CSE-ConnectionGUID: wfhhrVZ/RhK0poey7VxZmg==
X-CSE-MsgGUID: gZKeUisGS9y74DLKV8BwUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="56625962"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="56625962"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:56:01 -0800
X-CSE-ConnectionGUID: swth+WH1Swy8eqchNE7NAg==
X-CSE-MsgGUID: mSgjhOocS3GumrYuqkQtRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="118337284"
Received: from opintica-mobl1 (HELO [10.245.244.216]) ([10.245.244.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:55:59 -0800
Message-ID: <89ebe611-a9b8-43f5-bb52-e8a299f79188@linux.intel.com>
Date: Tue, 12 Nov 2024 11:55:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <394fa854-41a9-4ad1-880b-629108d52b41@intel.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <394fa854-41a9-4ad1-880b-629108d52b41@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I don't think the bug has anything to do with this patch, really.
> There's no need to rehash it here.
>
> The issue here is that the only way to call mwait today is via
> mwait_play_dead() directly, using its internally-calculated hint.
>
> What you want is for a cpuidle-driver-calculated hint to be used.  So,
> you're using the new hint function via the cpuidle driver.  But you just
> need the cpuidle driver to be called first, not the old
> mwait_play_dead()-calculated hint.  The new code will still do mwait,
> just via a different path and with a different hint.

Ok. I'll just say that we change the order because idle driver may know better.

> The thing this doesn't mention is what the impact on everyone else is.
> I _think_ the ACPI cpuidle driver is the only worry.  Today, if there's
> a system that supports mwait and ACPI cpuidle, it'll use mwait.  After
> this patch, it'll use ACPI cpuidle.
>
> The changelog doesn't mention that behavior change or why that's OK.

True, but I think the mwait_play_dead() is exclusively for Intel. Other target
platforms get an early return. I'll include that in the commit message.

> Also, looking at this:
>
>> -    mwait_play_dead();
>>      if (cpuidle_play_dead())
>> -        hlt_play_dead();
>> +        mwait_play_dead();
>> +    hlt_play_dead();
>
> None of those return on success, right?
>
> Is there any reason this couldn't just be:
>
>     /* The first successful play_dead() will not return: */
>     cpuidle_play_dead();
>     mwait_play_dead();
>     hlt_play_dead();
>
> That has the added bonus of not needing to return anything from
> mwait_play_dead() and the resulting churn from the last patch.

mwait_play_dead may return if mwait_play_dead_with_hint returns and it only does
on non-smp builds. That being said, we do ignore the return value right now,
because in either case we want to enter hlt_play_dead() as a fallback, so I
guess we can make mwait_play_dead return void, but leave
mwait_play_dead_with_hint returning int or add ifdef CONFIG_SMP guards in
intel_idle.

When going with the return types proposed in this patch set, on non-smp builds
intel_idle would call mwait_play_dead_with_hint() which would "return 1"; and
propagate through cpuidle_play_dead().


