Return-Path: <linux-pm+bounces-28232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2BAAD13AF
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135471889DB8
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473B51C860B;
	Sun,  8 Jun 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz1lx36H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD61C6FE8
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406738; cv=none; b=DGwDiMb/idwMOB0/EBS5C2MBykl5uAp3Sg8oUsG6e10vmN2ewf9nxYU44rcQ0oBnMTLe83GGPHQjinvc62Tsoprn9KvuKtjZ3w8zdhPkt/ffJ9icu7qcjdZ2+WexFoTwHVg4aFPa/78Uo/h6WAhDLSONzy0eEgXSDqngsNnFtcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406738; c=relaxed/simple;
	bh=QmXCcXv9hwJ1VKAcNUOOaVWK5RssElRe0GowEBgVFBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWDaKfUrHHXcB2ZuShrSAZWrQJZpvRNL1DjlIsgbGaK8cVoihhY1nOtnXobyl1RGR2wKGduYtbnCW+3RXBqwWqPYjzSjG1A7uSJeNmv/SdF9iPjTpPN04EFrnGa7O1mVLFk1O9yBCsGX7FAgfLLtabe6dQ4uHleTet1gZwPpnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz1lx36H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A71C4CEF2;
	Sun,  8 Jun 2025 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406737;
	bh=QmXCcXv9hwJ1VKAcNUOOaVWK5RssElRe0GowEBgVFBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Kz1lx36HagLJ40WQ5OIeHdqddRzkKCVCe+k8liSW5joGKuPJ5LzUWKj5QbUe7TOyF
	 B04T/OrNeA25Dk/k/kfXNIAmqnuSFyq4xC4kjvN9/pGEVDrJ2Fn08xRDU8CQ6k+OWM
	 WvIK6vVFY59qw2vhql9GQjfRUK7dRXTWCwoV6u5eP7l7y5gFExD8Mu8qxl72xv1y9i
	 4tHPENFWAgpANTgwtPli7g7vtUqgdvMUOI247xeJthalmEEGCy79gbvYnYtE8pONy9
	 iR1TPSUyB2tNvLWd172/L1WfdGppRNcZhFAD1kQhOfT1UEKfjbBS38cmnMvqSDOAWF
	 oQN1cJtYGqbsg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 07/18] tools/power turbostat: Quit early for unsupported RAPL counters
Date: Sun,  8 Jun 2025 14:17:06 -0400
Message-ID: <bd2c6acc500d5c44d0202463aa2138a3363ae103.1749406068.git.len.brown@intel.com>
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

From: Zhang Rui <rui.zhang@intel.com>

Quit early for unsupported RAPL counters.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 69c19e01b681..7e7d25d2362a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -7948,6 +7948,9 @@ void rapl_perf_init(void)
 		enum rapl_unit unit;
 		unsigned int next_domain;
 
+		if (!BIC_IS_ENABLED(cai->bic))
+			continue;
+
 		memset(domain_visited, 0, num_domains * sizeof(*domain_visited));
 
 		for (int cpu = 0; cpu < topo.max_cpu_num + 1; ++cpu) {
@@ -7971,7 +7974,7 @@ void rapl_perf_init(void)
 			struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[next_domain];
 
 			/* Check if the counter is enabled and accessible */
-			if (BIC_IS_ENABLED(cai->bic) && (platform->rapl_msrs & cai->feature_mask)) {
+			if (platform->rapl_msrs & cai->feature_mask) {
 
 				/* Use perf API for this counter */
 				if (!no_perf && cai->perf_name
-- 
2.45.2


