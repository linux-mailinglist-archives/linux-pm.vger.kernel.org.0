Return-Path: <linux-pm+bounces-28229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D6AD13AB
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20281889968
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CE1BD9F0;
	Sun,  8 Jun 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3wZ5F+3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414151B85FD
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406736; cv=none; b=tAE/WiXw8anXCHYegtiYGEJQNKlu0DKaKQduDRQZrwYN27DHtHFu75OInmPoqy3tO2hgECA+fbmZdSfi8aRzi8LWKG8u1BfC/iFpOPONi8Jrio29wr9W2Qko3ilXC3vgsN8uAWgw0WOY8n0wyJv66N+85HiQTokTW6rLCxqnRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406736; c=relaxed/simple;
	bh=teBjrcoR7gw5LkGNczue7HAV8JAXUt0juGIf+nbqgGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmxFM2MyigaGTJL2Md/3nZDQjr7fUN3yHNYikVl+HBpVprYOckB9KqSdYau5ZMxCFJ59IOUnrVbONzX800JsPga2cKcvB+dGKHZ/UmD/kHnt+ilRuZvgdFadTRXDm1z7ShmHbwL3R8X4MUOl0V4ifAWcdL1WLNSh96qo4tZKC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3wZ5F+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD8CC4CEF4;
	Sun,  8 Jun 2025 18:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406735;
	bh=teBjrcoR7gw5LkGNczue7HAV8JAXUt0juGIf+nbqgGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=l3wZ5F+3r229jDe55Yb6tbypT5Wx+hm9VDcv+nhavpmcT128s79eQnywLizrN/vSn
	 84focfPlPqrt76dGSuKN+vu+5VaLG0djXwYDazqsv3Zyu/SBMyLSYw90US0uVt1AKP
	 f59zORa1yzz1p/tHMyfUSYm7aDjPbZVEAV/KvAo2oIo0cxbtXD8t5//VwUqNsb/phA
	 gey9TDZ4txh3gybrsZ9PqnP2/1mYf+nBln/YkORYsngUVhqPqsdKgeoFtLRYPo2VVO
	 sUJx+GrWHuJ9Vim8vknaT6bSZ2q1qkPjjeE+f1uAsjixxwtL2VTIm2NMN6AN2utBPi
	 DAki0hQD8SimA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 04/18] tools/power turbostat: Fix RAPL_GFX_ALL typo
Date: Sun,  8 Jun 2025 14:17:03 -0400
Message-ID: <1abe0fb15a3b4beecb19e0fd7b19d81c633fe4b0.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Fix typo in the currently unused RAPL_GFX_ALL macro definition.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3b418cae8812..018f0fe96691 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -539,7 +539,7 @@ enum rapl_msrs {
 #define RAPL_PKG_ALL	(RAPL_PKG | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO)
 #define RAPL_DRAM_ALL	(RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_DRAM_POWER_INFO)
 #define RAPL_CORE_ALL	(RAPL_CORE | RAPL_CORE_POLICY)
-#define RAPL_GFX_ALL	(RAPL_GFX | RAPL_GFX_POLIGY)
+#define RAPL_GFX_ALL	(RAPL_GFX | RAPL_GFX_POLICY)
 
 #define RAPL_AMD_F17H	(RAPL_AMD_PWR_UNIT | RAPL_AMD_CORE_ENERGY_STAT | RAPL_AMD_PKG_ENERGY_STAT)
 
-- 
2.45.2


