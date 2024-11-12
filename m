Return-Path: <linux-pm+bounces-17426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F2E9C5C28
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A5A281F89
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12914200C94;
	Tue, 12 Nov 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuiP5XBn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A33200C8E;
	Tue, 12 Nov 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426214; cv=none; b=ncPXEIRWX89bm4Sfk3UGsUqYaKUncllJ6JqzUwc+Qhtij/niAuARO2asd2/M4NtePwnbC2EA4eg5BFlKrjqmx38Y6L8TGONxfJ0A/3Ubdzxy9MJRTNOh+0ZE9ptW0Zo3qfl/mhcDwdnHStH7N3gTTmhb/FKbIkseMhg+i262GM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426214; c=relaxed/simple;
	bh=UESrGCkqrZFwghBOTHPayiRJdVVcZiT4F/EtyCIFiWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGGAovCQatw1P1T525QWJVTtLHCf9a2oax8xaFBCcG7IzY7iDLJ7KyGo1arS+a44+Sl6ZBV1eF/rqVFKY3t/RvoTxn+6gnGzd04xWNb3SZLycjwC3Vtiom9URxGqCnQmLunzs/B8U7YlNkEugo/2Hs2+PdHjUD2gxLhDKOh+mT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuiP5XBn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731426212; x=1762962212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UESrGCkqrZFwghBOTHPayiRJdVVcZiT4F/EtyCIFiWs=;
  b=kuiP5XBnu17Fkpx7v2aunP5ynooNLxNnVy2B8Qrxe00Mlo0HMNiVhDtn
   4nxg2DdkWw2WbqU5pbqWFXvce2ESE2/dKCnVkHX6YWGPGDURZIw/TEO7b
   58c9DBPPN7ugOzBqhPEs3YaBfqRq6YY5YfaNOKxZm7yyit8BYKuXOGdbe
   axqIMv80MBl0ujBwl2FCScmTkBK9LIZswQ50LEA9LcnYS4JYA2lHpJXlg
   vXuYNpttLhf/x0+4/wdvgat4OfCztht9xq+Qu/F0TYvQzDcFMxcfUjVNw
   t42hX2GQRPgTslzJ75lYEmheUeNtkl03+X6wIozyFvDrerL1uR3+Q4bCI
   g==;
X-CSE-ConnectionGUID: 3rzbMscpSPOhYhjMpp4iAA==
X-CSE-MsgGUID: wk+arwe+TzaDIazhyrucsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41828506"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41828506"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:43:31 -0800
X-CSE-ConnectionGUID: WAvIgH9fQeSi+TAdPSj2BQ==
X-CSE-MsgGUID: IXcW7vtAToqAYmj+dHpJgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87484230"
Received: from opintica-mobl1 (HELO [10.245.244.216]) ([10.245.244.216])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:43:30 -0800
Message-ID: <1ee47890-7f19-4c21-9d0d-94834d716159@linux.intel.com>
Date: Tue, 12 Nov 2024 16:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] SRF: Fix offline CPU preventing pc6 entry
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241112114543.GP22801@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241112114543.GP22801@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> There's a comment there that explains why this is done. If you don't
> understand this, then please don't touch this code.

/*
 * Kexec is about to happen. Don't go back into mwait() as
 * the kexec kernel might overwrite text and data including
 * page tables and stack. So mwait() would resume when the
 * monitor cache line is written to and then the CPU goes
 * south due to overwritten text, page tables and stack.
 *
 * Note: This does _NOT_ protect against a stray MCE, NMI,
 * SMI. They will resume execution at the instruction
 * following the HLT instruction and run into the problem
 * which this is trying to prevent.
 */

If you are referring to this comment above, I do understand the need to
enter hlt loop before the kexec happens. I thought that I could bring
all of the offlined CPUs back online, effectively getting them out of
the mwait loop.



