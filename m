Return-Path: <linux-pm+bounces-17204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D740C9C1CFC
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 13:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B401C22D0C
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC431E9088;
	Fri,  8 Nov 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKbpINH0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959B1E907C;
	Fri,  8 Nov 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068975; cv=none; b=H3kxWk/AOxBW03E/7qptGrPD1FkfcMICdkIq8r5CYBRAeEwlQzNO14EqY9+LWJPsMEzradTcH2j/VEh3WQs9XmxNRLnuzY6YCqKojExZe2TsexnmebVz+lVP0QefLHqxGaGjW4W4vCIouZmbFLz9V1t6UdrIh2Qt7mVULt982k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068975; c=relaxed/simple;
	bh=b7srFW4ztylUzGKNKDA1PC2mqEDgmyxEsntlM8t70ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9ND68t8bvbExYwfhs0Pw5mBB/+NpcEMtICemS3vNrIyjUTeEcxIfJFC6Wv8rFVeeLqdXfzyhucR/6BJCHvAWl4N7zxODrTtIQk9sl+qTzLOxXuLHX2GoQptHe8v2cJtPXZp51fcjSbX6UMNI8CwQPukZ1jlyNW9BdzztqoM0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKbpINH0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731068973; x=1762604973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b7srFW4ztylUzGKNKDA1PC2mqEDgmyxEsntlM8t70ig=;
  b=HKbpINH0ygkQ0QG5B0t1lGlZ36vM67tnAfxrr88e6eZ3rt5SyG/sgHdi
   V0Wt9AbWcwcUj7FVt9W1BHZrfSwE2khi1K9bBASOQUmZZb9uaHWDxaK4m
   XZ86bccWamNsO1BVRf6ZuOUwYRBu+qtIvma0KfWyHXtH3wM/drX/1mR1j
   yGiY9nRgupo6ARx6zNYTaYqwOIlGWZlQyB+60/Ao8ufirWrEA2Cf9Vijr
   DJY55xBlBj9S1LrBp93PpGZnznQGiX2SzN6lZnJQp/Cp2QFOtf2oQQ3iL
   gsAEF5AsoulJvxarVhwuTDnLQkeuYD/Tkq3IN3jOFacWR7wo0NYVbnuXu
   w==;
X-CSE-ConnectionGUID: mTZgeywHTJWM/PKNIb2dTA==
X-CSE-MsgGUID: UVTPy8IrRk2YGP9IWyy+MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53510361"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53510361"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:29:33 -0800
X-CSE-ConnectionGUID: rIpTTDHIT9qMAd99VtFkqA==
X-CSE-MsgGUID: pFoPAVBHQ56apGPXxetzDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85921121"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.89])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:29:31 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v3 2/3] x86/smp native_play_dead: Prefer cpuidle_play_dead() over mwait_play_dead()
Date: Fri,  8 Nov 2024 13:29:08 +0100
Message-ID: <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic implementation, based on cpuid leaf 0x5, for looking up the
mwait hint for the deepest cstate, depends on them to be continuous in
range [0, NUM_SUBSTATES-1]. While that is correct on most Intel x86
platforms, it is not architectural and may not result in reaching the
most optimized idle state on some of them.

Prefer cpuidle_play_dead() over the generic mwait_play_dead() loop and
fallback to the later in case of missing enter_dead() handler.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 44c40781bad6..721bb931181c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1416,9 +1416,9 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead();
 	if (cpuidle_play_dead())
-		hlt_play_dead();
+		mwait_play_dead();
+	hlt_play_dead();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
-- 
2.47.0


