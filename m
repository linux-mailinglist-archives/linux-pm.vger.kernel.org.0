Return-Path: <linux-pm+bounces-35950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F3DBD23C1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 11:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E993C1854
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239792FC86A;
	Mon, 13 Oct 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTUTojTI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56012EC543
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347104; cv=none; b=WOOy0y8ajxVwsv0Q6wg+K4KOvfUD/E94U/MLkTYcLkWy+v7I8uyw6pRnvH5FZG9Iv7htZNYjCuDsPrcP6/YHuYq/W/ttJdZfhuxt9YHb1K0OvqowSmHbbbgy9xSW2wya4HhkrtrpSfCG/kXVM2joS8dAlUaFfiyA7+JCwU/yD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347104; c=relaxed/simple;
	bh=8YpNp+gpdFDVnpjPnV3V6R+ZbBZjIpje23eKpeA1mp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGW9UEMQW4JCKKw3nl/OpG0UI6vRjyTiPnqqryaYO/loqyIx12M4NBSGymeVYFbThBomgCfI0VqOTPaK1ek5YOmiSvE4MYHb+eJfBn+pR7tqqSMSj1yo5a/72IUROJ91t2QU+CPZ7QXYQXIbVwuBYVMvizHURmple6QA3KW9eTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTUTojTI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760347102; x=1791883102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8YpNp+gpdFDVnpjPnV3V6R+ZbBZjIpje23eKpeA1mp8=;
  b=ZTUTojTI4mdHD/rXxnZtJNBVIAK07OK5E1sI47BxqYDUi197ZAiWbL1i
   BEl4oZkf+pGHzyoAuL+iQhWuyOpVK/1qsDHXewRY5gCXAAY/KmddIbw8A
   z+86K6z+tYqTd2F9DDTR7XZNOql+KSog8WC8UXIe73xDX9i7cM5QlAZ4c
   2DIYAbyMnx2NmCttfwcOVPdf5hiajmNepkhB2XrrS2apugW2A/FTTl4hw
   IKxIK7l2GQLnW8l+tCDv7nvHjhDgHJXyi41hUxZ9X3Sy7MUWzbHhXtWDa
   pjeGeEhQaoqBUIee53LusANFzATPlRvVsPdXLvoaxWZiBIa3ubU7WySbp
   Q==;
X-CSE-ConnectionGUID: 1W1og/cnRJ+EcvAxxfY52w==
X-CSE-MsgGUID: HogC1GTbS92wZ0TH9XBvfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="85106446"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="85106446"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 02:18:21 -0700
X-CSE-ConnectionGUID: t0m+FxGLS3WUHrxU4GFICA==
X-CSE-MsgGUID: bBWmSVYjTxqbCBSN0rrkNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="182309109"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa010.fm.intel.com with ESMTP; 13 Oct 2025 02:18:19 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] PM: energy_model: Replace kfree() with em_table_free()
Date: Mon, 13 Oct 2025 14:46:21 +0530
Message-Id: <20251013091621.1191919-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree() with em_table_free() for error path of em_create_pd()
to ensure proper cleanup of energy model tables. The em_table_free()
function provides the correct deallocation mechanism for energy model
table structures, ensuring consistent memory management throughout the
energy model subsystem.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 5f17d2e8e954..e8ae1f518b8a 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -441,7 +441,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 	return 0;
 
 free_pd_table:
-	kfree(em_table);
+	em_table_free(em_table);
 free_pd:
 	kfree(pd);
 	return -EINVAL;
-- 
2.34.1


