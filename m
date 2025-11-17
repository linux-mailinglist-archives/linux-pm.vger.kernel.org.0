Return-Path: <linux-pm+bounces-38132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 250E9C6512F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 17:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id B8F1A24166
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1342857FA;
	Mon, 17 Nov 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9xYV828"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685C2877C3
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396137; cv=none; b=GdI/r4SW/dcx7VTy1gdrpsyHBaRVibjLaM7hmyN4JPlFaIKp7Sh3ooRruw+8e66efglhvRxU/dWl+jGDUfEssvOOVqoNK/slzgF2DLaHrnTpV1Z5UJ1aUATQdK57JxgPwus1NBDQg/gx352pbR6pc7xbfjGTuwDkUDiOMcRObh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396137; c=relaxed/simple;
	bh=Ix17wIzCTW7Y78cTkvhe8KwyiOkoAGc1A2A0irlsGlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ILPND423X0zpJ9Wl3FD4JJijTCIAp/guUDJye5q8YfMM2QdUhbJCoxr6ZkFFj/YBGUWGTiTGZF4xIGbTwN0aHN9Y0lvz7sNmRLQmMFnEYb2h2m+LOlG1oML1gE/ynLf4iC857B9ngtSXjOrTg3CxQs7eul7z/ALXUqA45V+64z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9xYV828; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763396135; x=1794932135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ix17wIzCTW7Y78cTkvhe8KwyiOkoAGc1A2A0irlsGlI=;
  b=B9xYV828XUtHclaMuKxjlNhT5i1YjE5X/kF/GBqwpEZbS6WGyEYP9SAI
   7HArlvT0JJ9ITyEIm8tbKM//+KDDPLQUIQda7RWewLze45FuldNkPfEL2
   ApKqghaJdVl6iu9x9fos0/9r1EXAQ5ynXi+yyJ3wZpDQ3bBeZb/U4ZbEW
   BHMs6XpcWmCEzg9UM1kZnMiEnvnkv1nbM7VhKwO2+fWXjN+KO/Mk4LOS6
   5HGDl2lLsOwRE693TsUKWrwuk92+bHH+w4Ez5N0r5ZJkSkwkDN/9gEtQT
   byP2oHIk3vdxPdi0PDcqnca7Wq5EUOAt3cjzW+DsO0OhsTbMS0ti520Ks
   Q==;
X-CSE-ConnectionGUID: gBacOc+tRR+abOfKLhXUUg==
X-CSE-MsgGUID: PL24KnAnSEWuQDDH2WUNfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65283426"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="65283426"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:15:35 -0800
X-CSE-ConnectionGUID: 8oM4HaKQRsmw53HYM4u65A==
X-CSE-MsgGUID: xRuenYe7R7u6fwLf3HUIKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190286633"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa009.jf.intel.com with ESMTP; 17 Nov 2025 08:15:34 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cpufreq: ACPI: Replace udelay() with usleep_range()
Date: Mon, 17 Nov 2025 21:43:17 +0530
Message-Id: <20251117161317.2426787-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace udelay() with usleep_range() in check_freqs() to allow
CPU scheduling during frequency verification polling. This
improves system responsiveness and avoides busy-waiting during
frequency change verification.

The 10μs delay is non-critical timing where scheduling
overhead is acceptable, making usleep_range() more
appropriate than busy-waiting.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 083d8369a591..bf511ab675ba 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -395,7 +395,7 @@ static unsigned int check_freqs(struct cpufreq_policy *policy,
 		cur_freq = extract_freq(policy, get_cur_val(mask, data));
 		if (cur_freq == freq)
 			return 1;
-		udelay(10);
+		usleep_range(10, 20);
 	}
 	return 0;
 }
-- 
2.34.1


