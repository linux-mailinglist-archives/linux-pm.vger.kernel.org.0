Return-Path: <linux-pm+bounces-27023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86411AB2A19
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 19:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131793B50FF
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F353F25CC64;
	Sun, 11 May 2025 17:47:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8943172;
	Sun, 11 May 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746985654; cv=none; b=EIISmMaFvag2JMqfixyBBbSBlLEQHFIKaNVaKjVEcCgNlk7tvtA/h4cRVi0Dpqk9e85eteMeSG5C2ZsXf8KJ30Y875LLne+xNx+LEUvhRlNJLZZ6UR7q/AlSvG5NaPF81eYbYBq68WHBu3bhIO0LreuERzM+0hvCIeXwftURoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746985654; c=relaxed/simple;
	bh=BusRFZ5sgIuDTxLkz0Uc4Lb7dUVAgQ/2zwaOtXTQbVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVpDn5GYrTAdTAGLqZz9VcSTAXM5g404vxq+W6rt6MYFlZOPX8TUixqGuMQ1J8pw8elpvHhSX2MU6i7bVSxW5aF1JAy4YThqkEPjlztIfVa0xFw8N/1EvVJ0swCPT4aq+MKJ8/4jARrLzPdTyF4nSl3oGFDZQbrHk+Qlm2Tr2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.speedport.ip (p57bd968f.dip0.t-ipconnect.de [87.189.150.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 433D661E647B1;
	Sun, 11 May 2025 19:46:59 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: thaw_processes: Rewrite restarting tasks log to remove stray *done.*
Date: Sun, 11 May 2025 19:46:47 +0200
Message-ID: <20250511174648.950430-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`pr_cont()` unfortunately does not work here, as other parts of the
Linux kernel log between the two log lines:

    [18445.295056] r8152-cfgselector 4-1.1.3: USB disconnect, device number 5
    [18445.295112] OOM killer enabled.
    [18445.295115] Restarting tasks ...
    [18445.295185] usb 3-1: USB disconnect, device number 2
    [18445.295193] usb 3-1.1: USB disconnect, device number 3
    [18445.296262] usb 3-1.5: USB disconnect, device number 4
    [18445.297017] done.
    [18445.297029] random: crng reseeded on system resumption

`pr_cont()` also uses the default log level, normally warning, if the
corresponding log line is interrupted.

Therefore, replace the `pr_cont()`, and explicitly log it as a separate
line with log level info:

    Restarting tasks: Starting
    […]
    Restarting tasks: Done

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 kernel/power/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 66ac067d9ae6..1938fafa9172 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -189,7 +189,7 @@ void thaw_processes(void)
 
 	oom_killer_enable();
 
-	pr_info("Restarting tasks ... ");
+	pr_info("Restarting tasks: Starting\n");
 
 	__usermodehelper_set_disable_depth(UMH_FREEZING);
 	thaw_workqueues();
@@ -208,7 +208,7 @@ void thaw_processes(void)
 	usermodehelper_enable();
 
 	schedule();
-	pr_cont("done.\n");
+	pr_info("Restarting tasks: Done\n");
 	trace_suspend_resume(TPS("thaw_processes"), 0, false);
 }
 
-- 
2.49.0


