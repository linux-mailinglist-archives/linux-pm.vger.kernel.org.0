Return-Path: <linux-pm+bounces-28226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF6AD13A9
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C697A1858
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AAA19DFA2;
	Sun,  8 Jun 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C93ZAdUT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E55194124
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406734; cv=none; b=nfGf1d2Cw3oRTO8q0+vjtVYUKVt0lGeOJWQwk7lNJFnbC6a3ZKWUJbGeJ63wpgbR3B/JGZt1t5by16UpTIG+4jDhCCpNpnBGz50NMVVf3rzyzxIBIEKkgzgKKMRxaMdAmjcSCrkzxuOcPh/gQCLd/qRyeCW5EALUHzlCLW7HRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406734; c=relaxed/simple;
	bh=GVG5S33DGGev9KYCvzl42GzVrtbxeozERfrhGchRbxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLVaPstgOghKBGcWTSkpGdGz6J7jaTE4l8lod1zitMZn/Sv3pTa2kEWa9li0Q2Tu4yy7p1Lnp0j389yZRSiD1MWxczOObhl5WtNV0AUsj6HTmeiiwzLdGFA7f6s2Q+wapSznqNQMAPTPNafai7EJZN5bC4FQkaQWyU6oNEjXzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C93ZAdUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84CEC4CEF1;
	Sun,  8 Jun 2025 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406734;
	bh=GVG5S33DGGev9KYCvzl42GzVrtbxeozERfrhGchRbxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=C93ZAdUT526I7r7XLyrKbLLZTtwONH4wyyHEZVbF1izHu2gUGfCrO0uyHmBCDuFIB
	 7CZWwSIMx2Au3WjiB64PUgzgRkHzCrcFcd4Xjvp9k0eWexoRRskfNbqxnwNWsUbSZL
	 NGbDSp05w0Og7Rymcazlcs41y4AqkcBevQ1O2Fplgp0B3MWakvlhOLXq9THDR+z3Lm
	 EpHqxcfXtw5iQrzHlwSY+OJnZNe6ZLSoDPtHrONYPRAjIo8hSjpVq/vMTeELCd1gJp
	 Ngz5BWPmifWzxRKYeavzQzgJrF22pTGm9nDJQgQfcB1qB+pPrCS9ETSWSTCNoSVPRE
	 9cp0VbFT3bnig==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 01/18] tools/power turbostat.8: fix typo: idle_pct should be pct_idle
Date: Sun,  8 Jun 2025 14:17:00 -0400
Message-ID: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250608181849.569543-1-lenb@kernel.org>
References: <20250608181849.569543-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index b74ed916057e..183d9c0fb315 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -100,7 +100,7 @@ The column name "all" can be used to enable all disabled-by-default built-in cou
 .PP
 \fB--show column\fP show only the specified built-in columns.  May be invoked multiple times, or with a comma-separated list of column names.
 .PP
-\fB--show CATEGORY --hide CATEGORY\fP  Show and hide also accept a single CATEGORY of columns: "all", "topology", "idle", "frequency", "power", "cpuidle", "hwidle", "swidle", "other".  "idle" (enabled by default), includes "hwidle" and "idle_pct".  "cpuidle" (default disabled) includes cpuidle software invocation counters.  "swidle" includes "cpuidle" plus "idle_pct".  "hwidle" includes only hardware based idle residency counters.  Older versions of turbostat used the term "sysfs" for what is now "swidle".
+\fB--show CATEGORY --hide CATEGORY\fP  Show and hide also accept a single CATEGORY of columns: "all", "topology", "idle", "frequency", "power", "cpuidle", "hwidle", "swidle", "other".  "idle" (enabled by default), includes "hwidle" and "pct_idle".  "cpuidle" (default disabled) includes cpuidle software invocation counters.  "swidle" includes "cpuidle" plus "pct_idle".  "hwidle" includes only hardware based idle residency counters.  Older versions of turbostat used the term "sysfs" for what is now "swidle".
 .PP
 \fB--Dump\fP displays the raw counter values.
 .PP
-- 
2.45.2


