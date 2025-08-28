Return-Path: <linux-pm+bounces-33327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3701B3AACA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 21:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA701BA78A6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A8923FC66;
	Thu, 28 Aug 2025 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaF1h/NY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4E20013A;
	Thu, 28 Aug 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409018; cv=none; b=b5o3pvp5TxitptcTo+1jdhgPwtUSBwehuCX7CI4Zf1ufaKvek+Kp5t5OEhNfyU3wH9q04VxXjeARyD1LvvewB+gRSCKw4STfsTBpo9splNdynyJMaQx/07u5ly5qD8PJDV9m61Mdq1JjKpCRRmVWux/atUkXRYg9bnS3I1nXoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409018; c=relaxed/simple;
	bh=V63f1ex+PBQ5+O6++zEpvOMvjCSNqO1rdBSOwnvnUAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HClh6ZoGXDshxNslUreHupgf2hjH7Jffy1nVy1sGE1t9ZnZTpHOW8blhzgpzfqCYUnrccLgF3kFmjm5VCq9IqR5YJJN9adxXCZYo3d2/lAHWKtBbPMcQW19uh5mCA7aUEJGXv8NBfqf+CXEfeOfeAzvnQ0LmQXdmHNHTC66J/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaF1h/NY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756409016; x=1787945016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V63f1ex+PBQ5+O6++zEpvOMvjCSNqO1rdBSOwnvnUAk=;
  b=NaF1h/NYUQDNQPWH9tazkoH98J89BxZv7C5axEmwyzDClYdgpnLS2u5h
   MtaGC9eY7CkDM9ktWqzNpFL+q/ZjjS75UrV5VpjB/YTUtRq4AaY12ymPS
   AM1XkvHmpW48QcsWO4Bvxmhrio/mD/6Q6warxv++tEn6Ltpp4oJs50QHe
   nCKqOmeeRoAYPAzVKFfBZM3xE3CXet3Cl6c48hgV1fiBmBjYhpq+JVV/g
   lXB6TNQs4PgZDqRFWMQgJpEPS93P4LcPR0LcLp6c9eY/j9twHO04kQTiB
   W3wAFrQeTHeYsEeOy/GbCXwoKF5CFCTwI4wrMVTLTDRkxIdQL5Cl/t8V2
   w==;
X-CSE-ConnectionGUID: t4Md96PiRJexmvN4h/KJYw==
X-CSE-MsgGUID: ao/JwkwRR2+h8P5SW5a0lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58621884"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58621884"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 12:23:35 -0700
X-CSE-ConnectionGUID: OLqdhYEdS4yV4rxfpxcjow==
X-CSE-MsgGUID: hdl/1B/FSTmfnhUT6JzTkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169783663"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa009.jf.intel.com with ESMTP; 28 Aug 2025 12:23:34 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] selftests/thermel/intel/workload_hint: Mask unsupported types
Date: Thu, 28 Aug 2025 12:23:28 -0700
Message-ID: <20250828192328.929742-1-srinivas.pandruvada@linux.intel.com>
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
 .../selftests/thermal/intel/workload_hint/workload_hint_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index ba58589a1145..3ee018bca899 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -133,6 +133,7 @@ int main(int argc, char **argv)
 		} else if (ret == 0) {
 			printf("Poll Timeout\n");
 		} else {
+
 			if ((lseek(fd, 0L, SEEK_SET)) < 0) {
 				fprintf(stderr, "Failed to set pointer to beginning\n");
 				exit(1);
@@ -144,6 +145,8 @@ int main(int argc, char **argv)
 			ret = sscanf(index_str, "%d", &index);
 			if (ret < 0)
 				break;
+
+			index &= 0x0f;
 			if (index > WORKLOAD_TYPE_MAX_INDEX)
 				printf("Invalid workload type index\n");
 			else
-- 
2.50.1


