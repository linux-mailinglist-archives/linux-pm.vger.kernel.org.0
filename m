Return-Path: <linux-pm+bounces-17568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF549C9096
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 18:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D5EB38C2E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF3C188587;
	Thu, 14 Nov 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZ3SCvGM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA117BED0;
	Thu, 14 Nov 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604434; cv=none; b=X48To96Yy6lDOGX7jyAcLZ1XSYbCkO9chPA4xIUiZJtggPeDDaUAulihNh0uHSvZbh2J+8gNDgzdlWlUdbsVxuIBFmUFkrnQHbq6ZYIQZWGB2NmrhdM/wbaR7ChNqtwATf6Y0q+uVW3cYOiWdRf99uuHymSiIH3RRWBHi7hjVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604434; c=relaxed/simple;
	bh=/LZlSOccn1m3pAZvKwPhMaD9G7pEsN/iu8vODiTHqP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Otu4u/31M0Sdv5peXQiIqlhb3YcAgRsnrhjwI08Hu7VQs7dy7qODAQk0mBNokPIYouPyqeNRzrYHIz4WPK8oFG4gw5R+srBUen/l3Jq/Cxf4g46qIWkG5atXI0hbxtUD179mJNvSEbD9jbqwa7P/yhY5T7zLRgq2zpGloC6tqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZ3SCvGM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731604433; x=1763140433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/LZlSOccn1m3pAZvKwPhMaD9G7pEsN/iu8vODiTHqP4=;
  b=FZ3SCvGMd36qfsNCvrnaxNVtPGDN4xg4chzfZifyzC4jdU5hD3R18HVn
   6g/a6/veeVeBmt2B8pHJxCvnVTeKJFbGb8jkceIrX97+41b5qboAo8zrh
   ArNoYeg/CkCydSZ3G5rI60GdacGL5Z4KU9CPLWMYzIL/AEdHGi7XvNGSE
   5l/KEZVLeqkxOCFbkIJrRRausaccBx5zes2fL0R656AUxFR6wkwO7dbMX
   SjddpYV9Obxnz37k9daTL8id+zoiknr5sTQWAByOKWwiP3mC8obCMwQBU
   D/ycK1HGGs4Cegn8S+NJ5Zqx2g2epczIK4YsMmeNR4qm3HQGRbeZ5peF+
   w==;
X-CSE-ConnectionGUID: yFRr4VvbTvqYPd4lbMOHxg==
X-CSE-MsgGUID: 2NKYg+JzR7yCjm/ssEBWnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="31471533"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="31471533"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 09:13:53 -0800
X-CSE-ConnectionGUID: 0uX9F+DhS52CIvl7k1yOwg==
X-CSE-MsgGUID: EunNGp7GSvOC1rF2/IZ2og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="111581703"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.244.40]) ([10.245.244.40])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 09:13:49 -0800
Message-ID: <15d18759-68eb-4683-9255-715545505ed6@linux.intel.com>
Date: Thu, 14 Nov 2024 18:13:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] SRF: Fix offline CPU preventing pc6 entry
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 Peter Zijlstra <peterz@infradead.org>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241112114543.GP22801@noisy.programming.kicks-ass.net>
 <1ee47890-7f19-4c21-9d0d-94834d716159@linux.intel.com> <87o72klylj.ffs@tglx>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <87o72klylj.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> That's not really working:
>
>   1) Regular kexec offlines them again.

But then, they execute hlt loop in the reboot vector right?
I think that's fine. We just don't want to be woken up from the mwait
when the RIP points to garbage.

>   2) Kexec in panic can't do any of that.

Does it make sense to change the kexec, so that every CPU is forced
into the reboot vector, which I believe happens for online CPUs?
We don't have to online them all the way. Maybe minimal bringup just
to be able to send them the IPI?

As a side note, It's not that important for this patchset. I think I
can make it work without simplifying the existing hack, but crossed my
mind at some point that maybe we could do that.


