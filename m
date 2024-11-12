Return-Path: <linux-pm+bounces-17409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69E9C5A68
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D76B3F2F1
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65B70811;
	Tue, 12 Nov 2024 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAZ04Y7y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA657CBE;
	Tue, 12 Nov 2024 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415660; cv=none; b=lvOTSFzCv7cvrmLjpuobaFAjn9RXlD7qmOTA+alHS/MngY9MSvPv90hoKB33Zrie9HvBWwLuWli2jB47PIJA514lo5C3yKq4M5Q/XJ2XLYLy8QwR1WWbadaR97x+ekIXjf2qpYNxPwFI/ZJ7pozPqT8PtvNAezCLJ6aWaPZEDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415660; c=relaxed/simple;
	bh=nE2fw62JHHUbcGQ+Vfxe3F1Und3a6DrOnoDJmNZMKN0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qfEcTBcPBEz+T3p5fw8uQ02YbrQOheWhiRet8bzkvqm0uBYNalSrnqTYzqoMd3U7jSvNDzrMf1JVJs0OJOH+CJmHEEvof9pS+zFsJatR9c7QXgSGcMTbpj1SFw9iz8ZMILeq617w0MxCIEUMn8SDtjTgdOEsvPT7FQd3oZqjr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAZ04Y7y; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731415659; x=1762951659;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nE2fw62JHHUbcGQ+Vfxe3F1Und3a6DrOnoDJmNZMKN0=;
  b=TAZ04Y7y852Z2fI3HQtOFFqVWCZ7mlNCBzDdk33xE7NV+6Zk3cEylyfu
   UWGXJ9seGZtdAtmHldpvnadALHWR2TtIM8V5fdEjSNTh8gpsk4r8WJvto
   AleQ4ezVZ0uxxpYDKt7reXrWmzf7q151M7lwL2R5OhXWqEEdJJFdbHW/3
   IYJRy1b6SlnaRqDQSISvLonTITaz4yx2FwE5odRInZLFIdyiGPJiGB2vH
   GFBMBrpGXj/z8yQ5fdCkUOFEiwmU5v3knQBw4Qy3Rb5a45VdGMqZj07yR
   t1CGu0/sMJKM5a8NtGSK+irqaBb0EsxPsOmLl9FK1vFCaLJfL2en4gvF4
   g==;
X-CSE-ConnectionGUID: vz41s1ZdSxmybNApL+Nmtg==
X-CSE-MsgGUID: kfUsodqGTD+CkZ7FITsvFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="35032534"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="35032534"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 04:44:55 -0800
X-CSE-ConnectionGUID: RbUKDArJRICOj4ph/sDz/Q==
X-CSE-MsgGUID: qbVOZSI4RX6hRAbxs2KkYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87353736"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 04:44:54 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id 1D51620B5703;
	Tue, 12 Nov 2024 04:44:50 -0800 (PST)
Message-ID: <0ecea0e5be59e63b7827f4db368f2aa3322fb71d.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
	 <rafael@kernel.org>
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
Date: Tue, 12 Nov 2024 14:44:49 +0200
In-Reply-To: <20241112121843.GF6497@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
	 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
	 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
	 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
	 <20241112121843.GF6497@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-12 at 13:18 +0100, Peter Zijlstra wrote:
> But on Intel we really don't want HLT, and had that MWAIT, but that has
> real problems with KEXEC. And I don't think we can rely on INTEL_IDLE=3Dy=
.

If INTEL_IDLE is not set, then we'll just use existing mwait creation algor=
ithm
in 'mwait_play_dead()', which works too, just not ideal.


> Anyway, ideally x86 would grow a new instruction to offline a CPU, both
> MWAIT and HLT have problems vs non-maskable interrupts.
... snip ...
> But as said, we need a new instruction.

FYI, I already started discussing a special "gimme the deepest C-state" mwa=
it
hint - just a constant like 0xFF. CPUID leaf 5 has many reserved bits, one =
could
be used for enumeration of this feature.

But this is just a quick idea so far, and informal discussions so far.

Artem.

