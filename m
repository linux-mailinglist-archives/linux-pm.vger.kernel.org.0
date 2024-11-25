Return-Path: <linux-pm+bounces-18050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2759D862D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F2163577
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8793818A6BA;
	Mon, 25 Nov 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2tMF49B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1217D378;
	Mon, 25 Nov 2024 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540844; cv=none; b=rCmDgofZVoiy+8zxFcYjB1sg49x9U9RSs/Fe78gqnk2smsaa7ZZzdKyHz25Z3I6SZ6MCyJn4TcIU+MuLT04I7n74b0DjVT0qdJvsecZEgJ26zYJbBkfE0xZeyJ+Ge/pqdx7y8GMiQbj/eRkPvQFHi8RSO/ZlJq7PJTaIW1QAuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540844; c=relaxed/simple;
	bh=vqIipY8S/dF9GuFhqRSM8PmpRZsIhAL4jNaiEFIUfuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHp5PnTyG7wwLb42vHAtrNJ4QoUVQ5SgfY2sEtyJ8y3Om+RgGaIfsb6xUeXeziZLTqQpjyWBAS592Z6mNz9MtJeatmOQsJoNoRCp2yx/LkfYnr/6lANyKtf1MQYhprqNmVeb9DTwMxTCR2aGfh4vvnEgl9gWzLVtCzILzCBTw7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2tMF49B; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732540843; x=1764076843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vqIipY8S/dF9GuFhqRSM8PmpRZsIhAL4jNaiEFIUfuM=;
  b=N2tMF49B4Y7hm5Lmcaz6mn5PFU12OnwE+yjVLWIztG5r6qn8EsOC0DfM
   RbS7LtL0DMk42/qitJXmZq7t16X5dmBxE0VnHfiieJNBUrTvmY3FG5/U7
   vysXNs38uN8TvKfsr4h+KnOQfoYiZxMASKMGIcWdK8UghgX5e4/xPm2FB
   GlTV4vyhxt33c0VcXzRK8er7yWJ6NKJwwhObedo8/MYZnwxleMaK5nBma
   5XJPYzex2rdifYJobeiAInb4qQqVQIC8MIR0apkhY/Re/gdBBQgOHSHCk
   /Jkivx0OgJ7Mr2hhOqhlCWxt7+ph1DrzqFCmKB17LpJLXirEQ9BmRaCyA
   Q==;
X-CSE-ConnectionGUID: MqHhWSV9T8udQ5GF85csjA==
X-CSE-MsgGUID: PguFX29HToyPJ4zLEakaBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43145423"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43145423"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:20:43 -0800
X-CSE-ConnectionGUID: hjoH3VLMSqOaLZZRDVhXvQ==
X-CSE-MsgGUID: aezfjcZnRPmpZHRuE7MftA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91161669"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pwlazlyn-mobl1.intel.com) ([10.245.245.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:20:38 -0800
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
Subject: [RFC PATCH v4 0/8] SRF: Fix offline CPU preventing pc6 entry
Date: Mon, 25 Nov 2024 14:20:20 +0100
Message-ID: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sending an interim RFC patch. Rebased on top of Rafael's patches and
applied modified patch/suggestion from Gautham.

Please tell me what you think. Is this approach in general is
acceptable?

When playing dead we have now the preference ordered:
 1. Idle driver.
      - acpi_idle can now do FFH and calls mwait_play_dead_with_hint,
        but we disable the handlers on AMD, because AMD doesn't want to
        use mwait for play_dead.
      - intel_idle have a handler for SRF. Intel platforms fallback to
        cpuid leaf 0x5 on other platforms.
 2. Old mwait_play_dead() based on cpuid leaf 0x5.
 3. hlt_play_dead().


Changes since v3:
 * Reworded commit messages authored by me as advised by Dave.
   Expanded the context about the mwait_play_dead code, hint computation
   and what is a problem we observe and the patch addresses.
 * Different play_dead methods are called now one after the other,
   because they only return on success.

Patryk Wlazlyn (5):
  x86/smp: Allow calling mwait_play_dead with arbitrary hint
  x86/smp native_play_dead: Prefer cpuidle_play_dead() over
    mwait_play_dead()
  intel_idle: Provide enter_dead() handler for SRF
  acpi_idle: Add FFH cstate handling
  acpi_idle: Disallow play_dead with FFH cstate on AMD platforms

Rafael J. Wysocki (3):
  cpuidle: Do not return from cpuidle_play_dead() on callback failures
  cpuidle: Change :enter_dead() driver callback return type to void
  ACPI: processor_idle: Use acpi_idle_play_dead() for all C-states

 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/smp.h         |  3 +
 arch/x86/kernel/acpi/cstate.c      |  9 +++
 arch/x86/kernel/smpboot.c          | 91 ++++++++++++++++--------------
 drivers/acpi/processor_idle.c      | 23 ++++----
 drivers/cpuidle/cpuidle.c          | 10 +++-
 drivers/idle/intel_idle.c          | 15 +++++
 include/acpi/processor.h           |  5 ++
 include/linux/cpuidle.h            |  2 +-
 9 files changed, 103 insertions(+), 56 deletions(-)

-- 
2.47.0


