Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EB92D7644
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgLKNKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436585AbgLKNJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:09:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5339FC0613CF
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 05:09:04 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:09:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607692141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOElsWA36JjXT7fQ8CAusYXhPMgMYhmrVGPfp/0B5gE=;
        b=bSlBmscwHwd1dZyYLK+qa6RgWdEdIZNttnKPFHN5QTO6WeneqkunelvsaBw6FRwnKmvMMi
        UT5W2vKYl4q86a0JT0cwWvF2x2ch9W4HrP/TM6r5XJaiRqnURnijzxGcfA5g7cnePVQWLX
        pGIWr8QwZTke5E4kXtAc5TPGSlbOqun6F2SygZ8oihe/wiuA2bc+aLoSrsNjM7A2m/Vmqc
        0a4iH87YXEV0xfBzIBvVyMpkdbprmpGZCS7dxGlV/wHUIXEhFxyNUDllnn+bGLp/XFvxsV
        zAHrOdSaH7wzO1K66HwWu9zQqoHqmxXNX2gxD4B4l5UYewinfQLFSShYBoAn7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607692141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOElsWA36JjXT7fQ8CAusYXhPMgMYhmrVGPfp/0B5gE=;
        b=KiLbvZEt9tH4DIMGp5YlSFWhbraxznNsW/kNDd+90vvkB7gIhiVIVpMw1lkzZPqZyfrWyu
        P3cph+SdLSIVG+Bw==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: int340x: processor_thermal: Correct
 workload type name
Cc:     Michael Larabel <Michael@phoronix.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201210213324.2113041-1-srinivas.pandruvada@linux.intel.com>
References: <20201210213324.2113041-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160769214067.3364.10017142585292237981.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ac35e6cb9ea51dddceae7e20a736e248730908ac
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ac35e6cb9ea51dddceae7e20a736e248730908ac
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Thu, 10 Dec 2020 13:33:24 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Dec 2020 22:48:52 +01:00

thermal: int340x: processor_thermal: Correct workload type name

Change "Burusty" to "bursty".

Reported-by: Michael Larabel <Michael@phoronix.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201210213324.2113041-1-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
index 2c105fe..990f51f 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
@@ -87,7 +87,7 @@ static const char * const workload_types[] = {
 	"none",
 	"idle",
 	"semi_active",
-	"burusty",
+	"bursty",
 	"sustained",
 	"battery_life",
 	NULL
