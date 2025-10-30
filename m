Return-Path: <linux-pm+bounces-37075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760DCC1E515
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 05:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020943A72C1
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 04:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965CE2E1C6B;
	Thu, 30 Oct 2025 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwH/97Fz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E928C035
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796923; cv=none; b=jdgUdKXGoMZkCZeZfE5dK4gWnV61SI+5YTfM9PRYIL+U+p3+lAHKv2HRh90/auQH1K93xCfSKUZgXw6236LTIBtGIMw925tFY5WDOxGH46GHcWVi3x6k0nuQHF1weqPipgMnY05SqVpg4b6/3rqFT1Ztj1ofqAaFsziO7t7Q46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796923; c=relaxed/simple;
	bh=iyXbUETARdq+OunYKwngxek7OmooxZRYsgau2c3mwck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mNYUb0e5gZeCtDrr911baydxxmGDyNidebfijKPIQwdsrFNufRFNbAKMo5J344bf7JPs64esRthwrMvilrX+lgiErY2pAiiTUsT543gfFHV8MAJycZaGNKIBsPKuMJwBk0V6HDApx0THsgZD0i6EDNNm2AvLCTZu6YUDKgFPCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwH/97Fz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761796922; x=1793332922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iyXbUETARdq+OunYKwngxek7OmooxZRYsgau2c3mwck=;
  b=dwH/97FztzgidNgDhp/hcmUsc7wCnI6NbDLKaBZ96mwGRhz/swFhYIA8
   JiqRwJQu386U0cAI+3IKlWii+cFfa2CRA0MF2DVlpZYR8w0a4PTwWsOK0
   LrneaKL/OzFCnu6Kn/85ryB/Dp18EdzfI00YZwi9cpRrNvb+T+ZIMfwYO
   oXVruLLRp+lCKB9XT+k0g8NjSgeafhE/PTnohDaJrgD0Wd4Wl8NFuOmt0
   pu11r91zU652DtlyrcJwOZWxe6eaoRqmaaUfFi35w1L5AF3IHePQbVE+5
   78mvk0Uu1p4zS74gCe/d5yUq5qqE0CLKoD3MNq6r9b10VAtMr+y9m2N0y
   Q==;
X-CSE-ConnectionGUID: 5pmxf0SNTcySS//gz8+AKQ==
X-CSE-MsgGUID: nDXEjQ2sTXiqu2aKQ29wzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75379634"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="75379634"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 21:02:01 -0700
X-CSE-ConnectionGUID: 5FjmbNNITtmlTQX7rPXzaA==
X-CSE-MsgGUID: 2g8kFTD6SrCWLf1Jp2EhNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="189915339"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Oct 2025 21:01:58 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] thermal: Use symbolic constant for UUID prefix comparison
Date: Thu, 30 Oct 2025 09:29:55 +0530
Message-Id: <20251030035955.62171-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sizeof() with a symbolic constant for UUID matching to maintain
existing ABI behavior while improving code clarity. The current behavior
of comparing only the first 7 characters is sufficient to distinguish
all UUIDs and changing to full string comparison would alter the kernel
ABI, potentially breaking existing userspace applications.

Use a defined constant to make the truncated comparison explicit and
maintainable.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v2:
- Use symbolic constant instead of strlen() to maintain existing ABI
  behavior as review feedback

 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 908cc1bf57f1..128556632685 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -16,6 +16,8 @@
 #define INT3400_ODVP_CHANGED 0x88
 #define INT3400_KEEP_ALIVE 0xA0
 #define INT3400_FAKE_TEMP (20 * 1000) /* faked temp sensor with 20C */
+/* UUID prefix length for comparison - sufficient for all UUIDs */
+#define INT3400_UUID_PREFIX_LEN 7
 
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_ACTIVE = 0,
@@ -199,7 +201,7 @@ static ssize_t current_uuid_store(struct device *dev,
 
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {
 		if (!strncmp(buf, int3400_thermal_uuids[i],
-			     sizeof(int3400_thermal_uuids[i]) - 1)) {
+			     INT3400_UUID_PREFIX_LEN)) {
 			/*
 			 * If we have a list of supported UUIDs, make sure
 			 * this one is supported.
-- 
2.34.1


