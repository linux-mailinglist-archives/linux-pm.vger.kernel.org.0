Return-Path: <linux-pm+bounces-20247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA071A095AF
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF5D3A89D5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C1212D74;
	Fri, 10 Jan 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7jYZUFs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD74212D7C;
	Fri, 10 Jan 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522786; cv=none; b=TdhPikEqn39yisX2yOJ5G3LRdenJEIR9lEJTCEn31MvQJrcMo+QQPYoJDN5EE4IQivB06b4Nq09MapsvhWdlnZmbTNZRXl8HLYKbQK2AGgAvjHFRLyWl6fQT8cJKJz+Frhbyv6vmu4Gzjxn+Ci6tggnSnr1QkWnlWxB06aSKtxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522786; c=relaxed/simple;
	bh=Jgs6Kgq09XtdCkvxRLfEWGHvPFq70cuabsdqe/U5DM4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r9+zOIITAqMwHliRSwEuUU8HCQZoUm79ejwr7nehN9EQN8PCQvakj3nqX9Hh8Ywx0Rjjj6poLNI7ruzRZQesMUFN7B2v+o+jGUxtP0YL9BxGgzRar7Dqmrj/W75+POE60mN2XrND5wf+9F0ksbNGpd52qAJ8xYHIUhW2Yi1RkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7jYZUFs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736522785; x=1768058785;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Jgs6Kgq09XtdCkvxRLfEWGHvPFq70cuabsdqe/U5DM4=;
  b=P7jYZUFsvYTr6uJDiJ3s3jvYS1NKXkcMoa9U3cnuX0+zec45popYzB6o
   ZJ8ULn9Qwz2CLMwCNlU0tbFifi4CWMeR128FujDVD9RJ/doiq56IOObso
   l75D5vr7Bhx1pqBkxKoE5QD5+GOZC+tQ0+/JgfLQb67oZ/UFbNgPfbBkb
   iaaE9uMf/naliekYQmoQOPXfkn60hYS/580+Q3AdRjQGQo1djGvupBukn
   zTJDG2WuWleF3Bs03H4mR6b2b55vJdIkLjyJMye+jf7Rh2bupd/FlEu53
   qjrRuzj5o0ZU+LRt7aTbof0vbEljkCrA2wsPeOH3ni9VC4gHpaCCKtIGV
   A==;
X-CSE-ConnectionGUID: 95CfGfULRmSm8WlzBg3YOA==
X-CSE-MsgGUID: kMLxhDl4TaSimyQHx0XzHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36706450"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36706450"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 07:26:24 -0800
X-CSE-ConnectionGUID: ImZLxQzhSRGVt+fTre0n2A==
X-CSE-MsgGUID: A6zKU2FCT0ODO8rHwOQ56w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108398000"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 07:26:24 -0800
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id D0C2B20B5714;
	Fri, 10 Jan 2025 07:26:21 -0800 (PST)
Message-ID: <5f24fe01b6dd0ae0e6d91209e143f2faff6ae017.camel@linux.intel.com>
Subject: Re: [PATCH v9 0/4] SRF: Fix offline CPU preventing pc6 entry
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Patryk Wlazlyn
	 <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
Date: Fri, 10 Jan 2025 17:26:20 +0200
In-Reply-To: <e6c49f30-b32a-4ad0-98e2-634113011f90@intel.com>
References: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
	 <e6c49f30-b32a-4ad0-98e2-634113011f90@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-10 at 07:17 -0800, Dave Hansen wrote:
> On 1/10/25 03:59, Patryk Wlazlyn wrote:
> > Patryk Wlazlyn (4):
> > =C2=A0 x86/smp: Allow calling mwait_play_dead with an arbitrary hint
> > =C2=A0 ACPI: processor_idle: Add FFH state handling
> > =C2=A0 intel_idle: Provide the default enter_dead() handler
> > =C2=A0 x86/smp: Eliminate mwait_play_dead_cpuid_hint()
> >=20
> > =C2=A0arch/x86/include/asm/smp.h=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> > =C2=A0arch/x86/kernel/acpi/cstate.c | 10 ++++++++
> > =C2=A0arch/x86/kernel/smpboot.c=C2=A0=C2=A0=C2=A0=C2=A0 | 46 ++++------=
-------------------------
> > =C2=A0drivers/acpi/processor_idle.c |=C2=A0 2 ++
> > =C2=A0drivers/idle/intel_idle.c=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++++=
++
> > =C2=A0include/acpi/processor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 =
++++
> > =C2=A06 files changed, 40 insertions(+), 41 deletions(-)
>=20
> Is everybody happy with this now?
>=20
> I noticed there are no Fixes: or Cc:stable@ tags on this. Should we be
> treating this like a new feature or a bug fix?

It would be very helpful to have this in v6.12, because it is LTS. So I wou=
ld
suggest

Cc: stable@vger.kernel.org # v6.12

Thanks,
Artem.

