Return-Path: <linux-pm+bounces-36332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29A1BE6EEF
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 09:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2777C1A6534F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66600311963;
	Fri, 17 Oct 2025 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjCFQP3Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C730F928
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686143; cv=none; b=NZSMUZ2NPfzL8E5CkTg/ZOIsHY0DiT3nYJUf/0MDJUgcV3ta+8kkLreBBHA3N4Z/AyAmc89/oucqh28DkmShyAoexaoanObcbE/7hoTmIBLabkze+R6xaQmB43TeypuAo+UwVEbC4ywJxHY3ox79QOlW4gNgIe6hTmvssGGX07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686143; c=relaxed/simple;
	bh=NdQAhmUL+bnghvo6Emd2tLKBR+AZEvi1tzNbJA2nAEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSfEWRdX2ogSeyoD6pGJxxnPn67eoOTmVuNtvfLHWE8H0AbTSFj6kcq0IgX0b1U8iSUPiTuEeIdyhxHpSLjZiLLmP05ANqYj4GAWvaxOTbuBuMZgpjCxaiozJDP46Lgp/AG7kTvHHBdk8XDIzOSErpIBxV0hrCWmmyjrOVXhyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjCFQP3Q; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760686141; x=1792222141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NdQAhmUL+bnghvo6Emd2tLKBR+AZEvi1tzNbJA2nAEw=;
  b=fjCFQP3QH4BuKLQHH7ak5cIxyVAk/MKWK/1JmT0F+uzL1gYmfptJXtNg
   /f+wSvsSmoqOv62YrVIl3/qgDb/7w5MtVi77jsi5siaBFKCdqcop+DW09
   PIkEY0a9/pMG0NdyUOesd5ghfns7fFNzj1c1UuWSUeYXJ+e1YSC1y3afD
   xwTwuD/Ofx3hMJ56I2sDKaKXYPHnEL1mlE6obnCHB7pHqmFQGxHQ6KUSP
   lxrE1bfWElJVzJsM5hYkYpI59/ujI4UoaO/LI3odk23oER10cqaOATxeO
   8NNGxHjcit3ZN6+T3PO8fG+chxGluEKHMOxPyINAsegK4HiS5nGD8w1fi
   Q==;
X-CSE-ConnectionGUID: U9IPtXi8Q/SdNbsbrOI+iw==
X-CSE-MsgGUID: 3Z7QTHy2QJeQj0q9bOm6LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="88362217"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="88362217"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 00:29:01 -0700
X-CSE-ConnectionGUID: zYS0Il1dQsabxJ2T6pxc+Q==
X-CSE-MsgGUID: 7NAa00gkS86YxYUKLV6x5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183148461"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa009.fm.intel.com with ESMTP; 17 Oct 2025 00:28:59 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] thermal: Fix UUID string comparison in current_uuid_store()
Date: Fri, 17 Oct 2025 12:57:03 +0530
Message-Id: <20251017072703.2064390-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use strlen() for UUID matching instead of sizeof() to ensure
correct comparison of supported UUIDs. sizeof() returns pointer
size instead of actual string length, causing incomplete UUID
matching.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 908cc1bf57f1..236003d12dc7 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -199,7 +199,7 @@ static ssize_t current_uuid_store(struct device *dev,
 
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {
 		if (!strncmp(buf, int3400_thermal_uuids[i],
-			     sizeof(int3400_thermal_uuids[i]) - 1)) {
+			     strlen(int3400_thermal_uuids[i]))) {
 			/*
 			 * If we have a list of supported UUIDs, make sure
 			 * this one is supported.
-- 
2.34.1


