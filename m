Return-Path: <linux-pm+bounces-18058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9B9D8646
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F4028B7C9
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE97C1AD3E5;
	Mon, 25 Nov 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1YQMDvx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746691B3956;
	Mon, 25 Nov 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540880; cv=none; b=ZkJVBzs7k3QHuHVYQk8ORW+QSVsKKf0LyKQ9tIBYUhvi/8sE+sxf5cwwkDa9FJBeGAOATw4CnBAQZqJFgwimI3MO3TsLWtbc7FpJqOywS/r+ysAArlW83FCAXZMdETwKsDp+/PofX4Sds4RyHMVOQ0V1qCOQa45sVNm4Q34zd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540880; c=relaxed/simple;
	bh=6Lp0IV64+HavzuhO75TCUMSNsfZbWcVXamNaEiN0TXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXTIK7DHUDrKBdiB1/BHFoglVk67c31dxt15PswVWKJnS4xPsog6i5O3JJqYoxAa06GfpGoaFT2eqdDeCVVBZCce3J5CD/XhHveBfw5dSelahED8K4fnOncxuoUM/ANP5NHdTOyFL4wm4aERUL4vM48BLrmPOudm6ycskzwhECM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1YQMDvx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732540880; x=1764076880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Lp0IV64+HavzuhO75TCUMSNsfZbWcVXamNaEiN0TXw=;
  b=c1YQMDvxEzYFqyZu7TB7WfmiIzCt2quAgpEmEvP4QCBuEIgttx76kMKx
   hFbd6cFLyF7ZFdXBpCPjft5hVdrVJuGW1zBd2IxRIe8NjET971lsE9HrZ
   Lchv8JJKHd6BqOYx0KR/VVFiaqRrVVgym8Hd6KIgksY7xOmL9SrOZZkl5
   c0hCzx046gAxyL/NuoxOwxXS/5ZZZhWCsvffcSulBq24Z8q78hUGO2a6C
   ZS+koZG8zJjUbDRxwK1MwidXWyoWwJgK4DY9cI5u9N8uLUWm2SupCnudN
   Ojp7f4Eqitbi6vNSM35IQPDLFceMPAEMg/0JgTBYT8zovteyzuELk22px
   Q==;
X-CSE-ConnectionGUID: xSsbRPcGTg2OxMM1cHdDcQ==
X-CSE-MsgGUID: 3exD20YLSRa3uJeXj0Nliw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43145511"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43145511"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:21:20 -0800
X-CSE-ConnectionGUID: swPvfLtbReKhSTMXeDGAQQ==
X-CSE-MsgGUID: NqH7bS67SpmBvL7nkvax/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91161793"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pwlazlyn-mobl1.intel.com) ([10.245.245.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:21:15 -0800
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
Subject: [RFC PATCH v4 8/8] acpi_idle: Disallow play_dead with FFH cstate on AMD platforms
Date: Mon, 25 Nov 2024 14:20:28 +0100
Message-ID: <20241125132029.7241-9-patryk.wlazlyn@linux.intel.com>
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

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/acpi/processor_idle.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 586cc7d1d8aa..4b4ac8d55b55 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -803,7 +803,11 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 
 		state->flags = 0;
 
-		state->enter_dead = acpi_idle_play_dead;
+		/* AMD doesn't want to use mwait for play dead. */
+		bool amd_or_hygon = boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+				    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON;
+		if (!(cx->entry_method == ACPI_CSTATE_FFH && amd_or_hygon))
+			state->enter_dead = acpi_idle_play_dead;
 
 		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
 			drv->safe_state_index = count;
-- 
2.47.0


