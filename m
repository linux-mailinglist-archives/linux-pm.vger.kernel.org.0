Return-Path: <linux-pm+bounces-34677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97DEB57E4D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 16:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AD0164D0F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8FA20B800;
	Mon, 15 Sep 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h7SWvRLo"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C126281
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944910; cv=none; b=JsiUIIVXD7Sn9nRdE8KHUnq2c86ExqgxCHtEGlKlfTgO0kg4ZBaTM4eLoMu6ROWEg5hehL9QVAOllPGZrgX2mwPuAkTLSe/wlYuoBLp3SFis5Z2qgpQPy04YPzFkMs+2f7slw92EucDvOtEb1ftOC+wBBmmm+ltWoN/Pp3pG5gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944910; c=relaxed/simple;
	bh=CwUy7xI3aeGV2jHi752NlVRGAmuCtCfD9OUAYRdA1bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYvFtA4usdC4ujElVULNOghDCMF/9fJTZaNShXXIkXNpS/hzhXwDYDRdbz0A7X406HLPGtDh8eu22VkPlePOIBpmlHBzriHzJX1mH95vUF/M8ltiVFPCCoQscohyhXik/GjelxCFH2J+q9qBcxoU1wiqXC85q3vwwZ1N/9DZjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h7SWvRLo; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757944905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AhJ4pkDiJ0lWkmhamxXqTKU3eDM1TJhpY4CZ/P9eJwI=;
	b=h7SWvRLorPI/hS+JB+Q5OH1c0BtLwcdyC1iqMl/fC/0e6SMC/9ih8/4d4iySxlDt58aOsW
	GE43IfUiziAt0TrrZ5P7OsJE+575EuEad6mh1NNL17DeLS4bJbIf+dhJA6H38TuOWMRE9p
	g0P3cavDxaeaC6BHAOthYONZlIltqKs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] rust: cpufreq: streamline find_supply_names
Date: Mon, 15 Sep 2025 15:59:54 +0200
Message-ID: <20250915135954.2329723-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove local variables from find_supply_names() and use .and_then() with
the more concise kernel::kvec![] macro, instead of KVec::with_capacity()
followed by .push() and Some().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/cpufreq/rcpufreq_dt.rs | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 7e1fbf9a091f..224d063c7cec 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -28,15 +28,11 @@ fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
 /// Finds supply name for the CPU from DT.
 fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Option<KVec<CString>> {
     // Try "cpu0" for older DTs, fallback to "cpu".
-    let name = (cpu.as_u32() == 0)
+    (cpu.as_u32() == 0)
         .then(|| find_supply_name_exact(dev, "cpu0"))
         .flatten()
-        .or_else(|| find_supply_name_exact(dev, "cpu"))?;
-
-    let mut list = KVec::with_capacity(1, GFP_KERNEL).ok()?;
-    list.push(name, GFP_KERNEL).ok()?;
-
-    Some(list)
+        .or_else(|| find_supply_name_exact(dev, "cpu"))
+        .and_then(|name| kernel::kvec![name].ok())
 }
 
 /// Represents the cpufreq dt device.
-- 
2.51.0


