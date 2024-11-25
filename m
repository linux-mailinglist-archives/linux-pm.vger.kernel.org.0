Return-Path: <linux-pm+bounces-18055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DDD9D8640
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A78C1639A2
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D11B0F26;
	Mon, 25 Nov 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksp73htM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC6D1ABECD;
	Mon, 25 Nov 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540868; cv=none; b=ajiTkgIdH++nyueq45qNi5jHkDWm+07S+NfC6opWX2vBmwrUTNjaLpl0KyXIa6NRqwnLw2i0BAGezVWB7HbyrNr1cY/+4oateoI0fVWi9cDiLPpJLbm+/Kp806Gll8Q/VAAOD0S/eCPxSrJV2r0qH6Zsr695D21B94JX/uxGoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540868; c=relaxed/simple;
	bh=GLH12fT3/lYQq3EY/HgfN3IRPf9HflYri+2sOBdLQmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ3wMdoawlloppB1mj0oPCYyOi1yK5HZdAt2KUPv4nuLpL+mEWNpTE+cBwu+WeMzIulwGcobQAG9E81ge4nLLj0OxDwkD7RGWAwpXnrG7nnluX3xmLF/uqGg+bUDorEg0sgvgw2TKqlYGVu70SzO88pQiaEkYS5amoCt+y4JuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksp73htM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732540867; x=1764076867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GLH12fT3/lYQq3EY/HgfN3IRPf9HflYri+2sOBdLQmk=;
  b=ksp73htM8WU8Vuf8GnK19Y+/MgLsEkEIkifg7eCUx8/wh98UBnkuo2nN
   /lfFNqMjAeU09ivbRJv3sw7WR4jTZhwYeaN26+RoznuNgm+C2Co8UxJXx
   YcTVN3hcDF/T0A4xuSu+iqsVoUuSpX3Iwu9MTab5WTiqwPKSfiSKanD0n
   Hao0N2Aqi2c+gcileJ+Rq+B7ebNEDD/+wDslRd2n+jF6eOw/MRxHi5orY
   hRX0DtYfEWsYUldkGl5mEtdhynQQOXn2aqIVqXtndAdDfqZuusWCm2Lbn
   m94ehMRXtCI2kis21959aSaCeDZgsDRvKYKJ7CkAB1g7esao2su/+2FYR
   w==;
X-CSE-ConnectionGUID: HNiWrji+Rkaufbl8lTRpzA==
X-CSE-MsgGUID: IRvSvEZ4SzqnjI1S3kP0Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43145483"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43145483"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:21:06 -0800
X-CSE-ConnectionGUID: YbOhICPrS3WeQATz5ZdX2g==
X-CSE-MsgGUID: b235ZwNMTn6wAJ3pOUVadw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91161742"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pwlazlyn-mobl1.intel.com) ([10.245.245.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:21:02 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	gautham.shenoy@amd.com
Subject: [RFC PATCH v4 5/8] x86/smp native_play_dead: Prefer cpuidle_play_dead() over mwait_play_dead()
Date: Mon, 25 Nov 2024 14:20:25 +0100
Message-ID: <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The algorithm based on cpuid leaf 0x5 in the mwait_play_dead(),
for looking up the mwait hint for the deepest cstate may calculate the
wrong hint on recent Intel x86 platforms.

Prefer cpuidle_play_dead() over the generic mwait_play_dead() loop and
only fallback to the later in case of missing appropriate enter_dead()
handler.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d0464c7a0af5..2627b56fb9bc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1413,9 +1413,10 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
+	/* The first successful play_dead() will not return */
+	cpuidle_play_dead();
 	mwait_play_dead();
-	if (cpuidle_play_dead())
-		hlt_play_dead();
+	hlt_play_dead();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
-- 
2.47.0


