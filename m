Return-Path: <linux-pm+bounces-28239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B126EAD13B5
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D36F168F8C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214661D7E57;
	Sun,  8 Jun 2025 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfH7f2fZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1919C2FB
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406742; cv=none; b=tEg+15tEkRuQ9+2XzR3stY9JPTFngcwbQk6pWQtDYkyJ+xbBtTuly+0YZ+oGCha/vk9WluLXjohIuUtcaUtMM66pcvNbXD/J7gQbwvU6yKUNj5FBlLPR6kU9cdStVp3YFVXpHjpToPAHWVnWrF7UHSV1m1id75uHcUu+uVqBEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406742; c=relaxed/simple;
	bh=LaszoLP4S3OTf3TEdi0LTOY08Af1XgTkVLHdGIX237c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtQ5iD66wfFyLNbHk5tqtX4Npyxt0+hIJ/WFR+JvOxpX5iPyeQtd4QDu0DzSgo9bAtRWYpIxy2OZaPmPQBh8+l0PAuw0IkEqVGsLBO6EYavYk9h3sq3NmTcDwE1XgEMH3sRVBnWJuOZItfaUTmLUWICWqRdvQBYHctah9OKEMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfH7f2fZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76216C4CEF1;
	Sun,  8 Jun 2025 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406741;
	bh=LaszoLP4S3OTf3TEdi0LTOY08Af1XgTkVLHdGIX237c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=sfH7f2fZ9s/UuahtywX816eTwkEdaqt0YxEci0sVsOjO5+CwSb4HsMqMkCDERhRQ1
	 t2x6oAqERBSuk8qHBZgrLtIv00oGDhbis/ecttewCcbO4jAIPo705wMzyaf2RPPe6K
	 ei8q0CmAzze+YubUq7EqPrk+C7EvD5vlKRz7lp30u6p8ZLtDSNz8/1c5HLs39S6iz8
	 n8UuCZGAy7SBjDNMT7bIj9pttqyCw1bKUzqhI+kpYxPAk+x0nxDwLpwT+32N9UTVyN
	 88ayDukZinCNKNAPGNngUSO4fjxmcNWTiftQwAX9hR0hgLFot8yNjH3crpQJkWjZTS
	 9VRL4VXI9xfCQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 14/18] tools/power turbostat: Avoid probing the same perf counters
Date: Sun,  8 Jun 2025 14:17:13 -0400
Message-ID: <9d6b56ebcc57108902335e35b8242aa3cf5b2051.1749406068.git.len.brown@intel.com>
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

For the RAPL package energy status counter, Intel and AMD share the same
perf_subsys and perf_name, but with different MSR addresses.

Both rapl_counter_arch_infos[0] and rapl_counter_arch_infos[1] are
introduced to describe this counter for different Vendors.

As a result, the perf counter is probed twice, and causes a failure in
in get_rapl_counters() because expected_read_size and actual_read_size
don't match.

Fix the problem by skipping the already probed counter.

Note, this is not a perfect fix. For example, if different
vendors/platforms use the same MSR value for different purpose, the code
can be fooled when it probes a rapl_counter_arch_infos[] entry that does
not belong to the running Vendor/Platform.

In a long run, better to put rapl_counter_arch_infos[] into the
platform_features so that this becomes Vendor/Platform specific.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6f91ec3f3f14..8deb6a23c7dd 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -7991,6 +7991,21 @@ void rapl_perf_init(void)
 
 			struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[next_domain];
 
+			/*
+			 * rapl_counter_arch_infos[] can have multiple entries describing the same
+			 * counter, due to the difference from different platforms/Vendors.
+			 * E.g. rapl_counter_arch_infos[0] and rapl_counter_arch_infos[1] share the
+			 * same perf_subsys and perf_name, but with different MSR address.
+			 * rapl_counter_arch_infos[0] is for Intel and rapl_counter_arch_infos[1]
+			 * is for AMD.
+			 * In this case, it is possible that multiple rapl_counter_arch_infos[]
+			 * entries are probed just because their perf/msr is duplicate and valid.
+			 *
+			 * Thus need a check to avoid re-probe the same counters.
+			 */
+			if (rci->source[cai->rci_index] != COUNTER_SOURCE_NONE)
+				break;
+
 			/* Use perf API for this counter */
 			if (add_rapl_perf_counter(cpu, rci, cai, &scale, &unit) != -1) {
 				rci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
-- 
2.45.2


