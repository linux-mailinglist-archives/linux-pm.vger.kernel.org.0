Return-Path: <linux-pm+bounces-18135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972E39D9E50
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 21:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A30B26B5E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459C1DCB0E;
	Tue, 26 Nov 2024 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGl3qrFB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184D13AD18;
	Tue, 26 Nov 2024 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652162; cv=none; b=iMb+2oKhFh1EHH6taRKBF4/j0+xdrlCP+7zjr5QRXvoqUnvEgkjsscprEl/Vf2w2n1H4tPqpWKxGTZXBymDAp6y6pPQy26scXQgYBa+hlzoPibInvx1q84dySVWO63/zzZdPAQL48Hk7jBYTRx+NO3KWBuugy9WdnGwY2VXuP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652162; c=relaxed/simple;
	bh=AVk+SD4l2lVk+TITztP9M5rl1rLzhhvxrouZyuPH5QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KiiGWSWyXOzXqv1SoPqujUlqXrY7hNiCJTNwWH96mPqq9shk2OXBZBA+E9zSMJ6rCts0Xg4VxvEFO6PUcXVvZAkwD3b2w983UQ6u5o+6jXAzkWMxCxXy72I0VjldYiXVABy8bnrLHixLDCCaSi3zkNqmT9PdXcujCt26uc9a/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGl3qrFB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732652161; x=1764188161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AVk+SD4l2lVk+TITztP9M5rl1rLzhhvxrouZyuPH5QU=;
  b=JGl3qrFBdCdHDVYRNHg5XVnChGzBXif25wFU4o2mEB7QkfJIHHsKsKXS
   Yz7JSaYXPThnT/T5hqt87F9kOM6jIZh0Uu119Mvhuu6zUVL85EWm55r9x
   bMMpDMcZqhbbLCQQ0byoq/mML/wFaCEk0PiZIm2O274e7P26zlVbRnI21
   yxACQuvSS4NN9/l92X6cb3DcZCrEwF8YpMwrgkcKyLIzFpY5+CLaQLSQF
   7mOmWo7jl1yudDIS++kBeT09felTjlTUQtIjCdrHzHx6nEjYrFySUQCiw
   lqf+kU3A1QHhgmk4Rf3u8VBx/abVVsdmwOl2TtKJouZuGua58RXkINjdv
   w==;
X-CSE-ConnectionGUID: H1cnvSs3TTK6kGE+K+Jr+A==
X-CSE-MsgGUID: K2MnfXNETDy5BwuL7ygZcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36624196"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="36624196"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 12:16:00 -0800
X-CSE-ConnectionGUID: PidHqB0gRdSAHT6MgqedUA==
X-CSE-MsgGUID: kSWJ/sHSRYu12jPf6gYyKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="92047548"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.172])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 12:15:57 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com,
	tglx@linutronix.de,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v5 0/3] SRF: Fix offline CPU preventing pc6 entry
Date: Tue, 26 Nov 2024 21:15:36 +0100
Message-ID: <20241126201539.477448-1-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the feedback so far, sending next version of the patchset.
Lots of simplifications and a little bit of rewording this time.

Rafael, I know you suggested to move the commit message from the
1/3 patch to the 3/3, but I feel like the change for SRF really is in
the 1/3. If you in insist, I'll do that in the v6, but I think It
serves it's purpose better like that, to justify getting rid of the old
algorithm.

Changes since v4:
 * Rebased on top of Linus' tree, picking up Rafael's acpi idle patches.
 * Remove mwait_play_dead() code entirely from the native_play_dead()
   and delegate to idle driver right away, instead.
 * ACPI: Don't filter FFH based cstates on AMD, rely on the BIOS to
   report them just like the AMD prefers (IOPORT based).
 * Apply Peter's suggestion to intel idle to define a default enter_dead
   handler for all platforms in intel idle and allow for overwriting
   that in case It is needed.

Patryk Wlazlyn (3):
  x86/smp: Allow calling mwait_play_dead with an arbitrary hint
  ACPI: processor_idle: Add FFH state handling
  intel_idle: Provide the default enter_dead() handler

 arch/x86/include/asm/smp.h    |  3 +++
 arch/x86/kernel/acpi/cstate.c |  9 +++++++
 arch/x86/kernel/smpboot.c     | 46 ++++-------------------------------
 drivers/acpi/processor_idle.c |  2 ++
 drivers/idle/intel_idle.c     | 18 ++++++++++++--
 include/acpi/processor.h      |  5 ++++
 6 files changed, 40 insertions(+), 43 deletions(-)

-- 
2.47.1


