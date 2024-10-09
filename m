Return-Path: <linux-pm+bounces-15370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827E49960B3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 09:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272E81F21346
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 07:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CFD181D00;
	Wed,  9 Oct 2024 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GC4dEgtn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7817E472;
	Wed,  9 Oct 2024 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458446; cv=none; b=CELZ8pCOcV8PjXSBVX6GM63CEKi5/L6KYrZPX1OgYrb/EcTBNtZCjpe1qQSQLWhuuTMrYl9IFvktYolH4cdrwM2Q/T5ayIHYuiHFC/+wKPPgelnNvTHJKtEOttY51FZtcS/bMQGwsgZZCSX+xd9XrAxlxSxqkRefczjCSClbacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458446; c=relaxed/simple;
	bh=YBfWibQiqVBu4MOLsbYd+xmlanrOBi8rPl49d/uOn9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JhD2WiKjeRVq1mJobUa0+stE7JBbkfjr+tg8/MEXSjC12JtyiC3VxW3Qtxn1FROXdUvkz5D21sMZOqguZFfUxlrQl8FTRf3GiRy6AVu60nJHJN7Zty6pwLstjlYlFQ/BoEe/s4m/tE0AByb5xkezE4HOa1T7FJxs2j/rL0UHZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GC4dEgtn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728458444; x=1759994444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YBfWibQiqVBu4MOLsbYd+xmlanrOBi8rPl49d/uOn9Y=;
  b=GC4dEgtnuHLVy127UemN4dlmgdw+afPT9/8fe56rC2f/TDFoZ7ZdPpi2
   GtJ2fOPI4QOzVlkKhRx7dXYXYaK+1nbSefBun4d7NVYNSQ9vpewedj/DJ
   R80HXXo8QuvXmLPYRh+xzLJuDHSNlfvo38iehAhjP5ouRdPhFsQHSBsiA
   H/2QxN6pn5bzRa0dt7FpRfN0ivCiUmh9RL4kwzHDKlhnYIGpiIJ6fSdG3
   /iF8zJxbxf9NBAo7P5rjfGv+gK+ZIqwsTJ/nRIJ0uGE+AmyqTGYTRCP+e
   fNd/iXxFr9a8tSniQxpWgozSDKyn+dykcBZC/4Ld8bthX8og9PfqbIyg5
   A==;
X-CSE-ConnectionGUID: OLP/zl0yS2+eFwkhrMxfIA==
X-CSE-MsgGUID: 9MhfriK2Sz2i+kqQzBWl5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31630185"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31630185"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 00:20:43 -0700
X-CSE-ConnectionGUID: XX8vDn1wQd6SSHAfNVw+1g==
X-CSE-MsgGUID: CHv5mVwCRJS9Na/X+T0FCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80665010"
Received: from unknown (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.245.243.187])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 00:20:38 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rafael.j.wysocki@intel.com,
	x86@kernel.org,
	linux-pm@vger.kernel.org
Cc: hpa@zytor.com,
	peterz@infradead.org,
	thorsten.blum@toblux.com,
	yuntao.wang@linux.dev,
	tony.luck@intel.com,
	len.brown@intel.com,
	srinivas.pandruvada@intel.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic timer shutdown
Date: Wed,  9 Oct 2024 15:20:01 +0800
Message-Id: <20241009072001.509508-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This 12-year-old bug prevents some modern processors from achieving
maximum power savings during suspend. For example, Lunar Lake systems
gets 0% package C-states during suspend to idle and this causes energy
star compliance tests to fail.

According to Intel SDM, for the local APIC timer,
1. "The initial-count register is a read-write register. A write of 0 to
   the initial-count register effectively stops the local APIC timer, in
   both one-shot and periodic mode."
2. "In TSC deadline mode, writes to the initial-count register are
   ignored; and current-count register always reads 0. Instead, timer
   behavior is controlled using the IA32_TSC_DEADLINE MSR."
   "In TSC-deadline mode, writing 0 to the IA32_TSC_DEADLINE MSR disarms
   the local-APIC timer."

Stop the TSC Deadline timer in lapic_timer_shutdown() by writing 0 to
MSR_IA32_TSC_DEADLINE.

Cc: stable@vger.kernel.org
Fixes: 279f1461432c ("x86: apic: Use tsc deadline for oneshot when available")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
Changes since V1
- improve changelog
---
 arch/x86/kernel/apic/apic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6513c53c9459..d1006531729a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -441,6 +441,10 @@ static int lapic_timer_shutdown(struct clock_event_device *evt)
 	v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
 	apic_write(APIC_LVTT, v);
 	apic_write(APIC_TMICT, 0);
+
+	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
+		wrmsrl(MSR_IA32_TSC_DEADLINE, 0);
+
 	return 0;
 }
 
-- 
2.34.1


