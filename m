Return-Path: <linux-pm+bounces-7027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A0D8B11DD
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 20:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C73284947
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83E616F831;
	Wed, 24 Apr 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKVFsUBr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009E16F0F0;
	Wed, 24 Apr 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982494; cv=none; b=aeNrBPFtTIHPqVOCyMoYfr/E4RW+rbMYutjQ0Qn/xWaUzsvV4ycQGhP1/gJNatoYpY9satfu+84iIrP9PRdeyrYO9wFfBU+rSe2bQRJZCVZ1F1b97E1JLGdRkNj6664NPevA9E64nPnHrLn+R4dqcb4yfN3KOVZcHn4s1F3J8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982494; c=relaxed/simple;
	bh=DeoNg6vE2dUVTJ0VP57n/7LnvyNJiz2+PFZomKP9EJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxRjWMRFiOXFwaI/7xgOgPMUfiVVnxy7iIF1ptPIM206L17sBGY3UOUxBE714dbxyTM2FPcqbBB1pM7tY5xhfmJkFcRxjNulwNiTQXl1YmHqrtm7NUo/wczRE+kLrNNgKnlqhF2YJOAcy2yLuwz4b6N4qu4HnL8lKreaIMlUrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKVFsUBr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982492; x=1745518492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DeoNg6vE2dUVTJ0VP57n/7LnvyNJiz2+PFZomKP9EJU=;
  b=HKVFsUBrVWin0d/no7GF32hlauwIPlz/vsHVjalC5OJeduuJXwi1l7wP
   7DUZA5sH7xvcV4jmnE7hPoJxhzGXb2DsFB6fRhgLEqWGi6Z7fDx3+E0gf
   HtYLMDr1NL2Yv4DJkxEzjDxSSq4iHgm/vES0liwreERCUCqmpoKqK0StB
   K1UX6SdfZA8q5XebdwCbwq5L0yYhzVpH2HvaNhRO1XfZcWd6YijWqMWVZ
   UL4c4gh8IpOVNJ6EsxcN675jdl6cCwkF4nLg60o551e0hDiYvOq3w8r8U
   HdEBKzfnDoWr9U5kHu/m54EpnoZ8hXPk8tTQvq9B3N80cXORbbkd9RB3b
   A==;
X-CSE-ConnectionGUID: VqSp6THRTmCdmT8ypPzCfQ==
X-CSE-MsgGUID: xnyiLqT2TleMstHO09n45A==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481772"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481772"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:52 -0700
X-CSE-ConnectionGUID: B9T8sCJCTnK+A/+999me2Q==
X-CSE-MsgGUID: 3qZu2DuTROGPe+WOfIcg6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262568"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:51 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 08/71] cpufreq: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:51 -0700
Message-ID: <20240424181451.41308-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/speedstep-centrino.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 75b10ecdb60f..ddd6f53bfd2a 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -520,10 +520,10 @@ static struct cpufreq_driver centrino_driver = {
  * or ASCII model IDs.
  */
 static const struct x86_cpu_id centrino_ids[] = {
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM( 6,  9), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM( 6, 13), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM(15,  3), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM(15,  4), X86_FEATURE_EST, NULL),
 	{}
 };
 
-- 
2.44.0


