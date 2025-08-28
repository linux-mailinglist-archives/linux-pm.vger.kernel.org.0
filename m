Return-Path: <linux-pm+bounces-33332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D56B3AB5C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 22:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18E5207B9E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 20:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD0E264A9E;
	Thu, 28 Aug 2025 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acV0uXrf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3D1991CB;
	Thu, 28 Aug 2025 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412145; cv=none; b=ESAeOo+1wic1F+it6fEmfQQJhmlo/WGfZaTN/eeBytPP4j7Au3qtcitUJ8nciU3bY8fRxWMRUITjqfWjR3NWKvpVcpYn/Zf4rR7Y3WbuGM/kUWIX6GEJZTpsKwR6wdt5p6yiNABTq5uyfdag6Dwc9/kjmRNxrm2l9E2jkLnVt8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412145; c=relaxed/simple;
	bh=0kAURCamzDhFeTEPWTVMzWRqqdRIcNdU/CBMS3Fa7bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1LEl1A8PUJofmhVkxj2gLRhHA6AODAGwR7CtVo0d3fL77ib27H97UVOFlgBDuLFHkIq1zl8AepeYv2ltlH4GoRZeoPA13f8yw8te5LkvsgL+8uVA9VXP94I5z0Opcw8E1ys5suJyy62dzCVCD+Ja5phSkP6aSX0cjZv6Wex144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acV0uXrf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756412144; x=1787948144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0kAURCamzDhFeTEPWTVMzWRqqdRIcNdU/CBMS3Fa7bc=;
  b=acV0uXrfDilauj9BqRVta+R3sqZ7uxK3I0eJ026nHU0TZ/19GRlccF6b
   e5AG0gb1TBA1oZoTiZ0ywmPY/V7NWjCkUEXahmN5bBlhPD67TgPpy47v6
   BZUrSNtdc7b+6o+i/j0V41jKKD3kFmjQD5d10ExL22JBj5TqNRvJ8NxM+
   QbDJuJ+9NVbLHOboc3kAL9fldorWxDDjeM/AbxvXlLPHtLrovJgNC6ITP
   GSbd/+Z5VtXRJobu3WmeEvyF6lJr7dnbDqKE+C0O74n57Tu4D6RwEnmbZ
   1tS+ZWWL7btFL92IkLP901xUK/X+1oEge8l1mDG69/R9C74JWh3+uEfoP
   Q==;
X-CSE-ConnectionGUID: NelmaHPfSrSEdntuYqxCQQ==
X-CSE-MsgGUID: +T5Gec+DSh+2w55DybghNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="84098227"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="84098227"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 13:15:43 -0700
X-CSE-ConnectionGUID: ijGNslvISpmYtZB9nTTPUA==
X-CSE-MsgGUID: jFXPHXKIRkCI6x481TCAqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169454343"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa006.jf.intel.com with ESMTP; 28 Aug 2025 13:15:43 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] selftests/thermel/intel/workload_hint: Mask unsupported types
Date: Thu, 28 Aug 2025 13:15:41 -0700
Message-ID: <20250828201541.931425-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The workload hint may contain some other hints which are not defined.
So mask out unsupported types. Currently only lower 4 bits of workload
type hints are defined.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Removed extra line

 .../selftests/thermal/intel/workload_hint/workload_hint_test.c  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index ba58589a1145..ca2bd03154e4 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -144,6 +144,8 @@ int main(int argc, char **argv)
 			ret = sscanf(index_str, "%d", &index);
 			if (ret < 0)
 				break;
+
+			index &= 0x0f;
 			if (index > WORKLOAD_TYPE_MAX_INDEX)
 				printf("Invalid workload type index\n");
 			else
-- 
2.43.0


