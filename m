Return-Path: <linux-pm+bounces-26741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D382AACA39
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 17:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7353B0E84
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25DE28467C;
	Tue,  6 May 2025 15:57:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05092280A47;
	Tue,  6 May 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547062; cv=none; b=QZPspqRAN7jsuvQo2IOPuT6szsWT9MprQSi0vtbpi0Ql1SXWixuo3jwWgpET5ZsbHJ4hnMJWYGVykuqHaU9/g+mwBVnASyOyL280DE/P2sddg/xvKmR5GXKc2+zzQCQsQ6P6l4YjlTmw5meLjNbvQ9qHXaeDpYEPBtRXYgKTALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547062; c=relaxed/simple;
	bh=/60OnUKy6dm+LeLueJk84qpcO7m27pziu8E+EZa+1Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4NirYe/muqunkcZgbSMCTRTxFw+Ql737/If8DUtHflx9KaU+tx3Wx/gdbOvG3LSNlVieQhwQeeWdRN/cr8ytL7havgqm5F/KDw5Y29J16cZ/A+7wwzYd5coCnWtkXEq516AKSQfpmA933eNfTENcIgZiONaUw8oxDhOpcktEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.molgen.mpg.de (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9C7D261EA1BF3;
	Tue, 06 May 2025 17:57:08 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: thaw_processes: Rewrite restarting tasks log to remove stray *done.*
Date: Tue,  6 May 2025 17:56:58 +0200
Message-ID: <20250506155659.95212-1-pmenzel@molgen.mpg.de>
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

    Restarting tasks ...
    […]
    Done restarting tasks.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 kernel/power/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 66ac067d9ae6..92daf1dce8c3 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -189,7 +189,7 @@ void thaw_processes(void)
 
 	oom_killer_enable();
 
-	pr_info("Restarting tasks ... ");
+	pr_info("Restarting tasks ...\n");
 
 	__usermodehelper_set_disable_depth(UMH_FREEZING);
 	thaw_workqueues();
@@ -208,7 +208,7 @@ void thaw_processes(void)
 	usermodehelper_enable();
 
 	schedule();
-	pr_cont("done.\n");
+	pr_info("Done restarting tasks.\n");
 	trace_suspend_resume(TPS("thaw_processes"), 0, false);
 }
 
-- 
2.49.0


