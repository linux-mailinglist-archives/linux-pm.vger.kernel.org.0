Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F5F2C2190
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgKXJgo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbgKXJgh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DEAC0613D6
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 01:36:37 -0800 (PST)
Date:   Tue, 24 Nov 2020 09:36:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9CNCdHL9grMRHRieiIBp66qzTGOduWUa3PoySw5lQ0=;
        b=LLHUJEdHb/2GN+0UWMJbLeov92CfXwk7C+9CoXMcfswqm5AGSs1aUYXYll0tRqZ93CXB3D
        kbcGlA7ZIdq1zfYEDlClRLPGxD5WhJLRvU9IvfRDspBQ3CLVsaa4zY5QzrqDFhsKf6ksq6
        DT/4NUST/M0snGNdrs0p/6HyE4hLVk/X2MXGfPbtYeNmpYDGG0VUuwQl1D3FaU2SMZZwCA
        AvMqb4eEj7Z7Ev736UFWcbGKJ3YvM/3ATgu7E6Fi5i2REaV90I30M5tFimlKPIFDUndy6z
        gRqi34f5npl8KQCrJaXwmrjBe+sucqfL/ppJZf4Q7AL1+xcpFuOXE9uR0vwa8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9CNCdHL9grMRHRieiIBp66qzTGOduWUa3PoySw5lQ0=;
        b=miN6RSGVqsAlLcxfXWsNaYAWjnRHb+nU797wPeQ36gWaGo9InjS7vg015oq0VK987tOWzc
        o7z7way4ep8v02DQ==
From:   "thermal-bot for Viresh Kumar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] docs: thermal: time_in_state is displayed in
 msec and not usertime
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: =?utf-8?q?=3Cd5461bdf9ab6b6fee7f28f538582edbb426aa077=2E16050?=
 =?utf-8?q?04905=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
References: =?utf-8?q?=3Cd5461bdf9ab6b6fee7f28f538582edbb426aa077=2E160500?=
 =?utf-8?q?4905=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <160621059529.11115.17145263247398186723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ce7c01557465e920f5bccc5878b8dec165eeb80b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ce7c01557465e920f5bccc5878b8dec165eeb80b
Author:        Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate:    Tue, 10 Nov 2020 16:13:37 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 12 Nov 2020 12:35:02 +01:00

docs: thermal: time_in_state is displayed in msec and not usertime

The sysfs stats for cooling devices shows the time_in_state in msec,
remove the unwanted usertime comment.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/d5461bdf9ab6b6fee7f28f538582edbb426aa077.1605004905.git.viresh.kumar@linaro.org
---
 Documentation/driver-api/thermal/sysfs-api.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index b40b1f8..e7520cb 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -654,8 +654,7 @@ stats/time_in_state_ms:
 	The amount of time spent by the cooling device in various cooling
 	states. The output will have "<state> <time>" pair in each line, which
 	will mean this cooling device spent <time> msec of time at <state>.
-	Output will have one line for each of the supported states.  usertime
-	units here is 10mS (similar to other time exported in /proc).
+	Output will have one line for each of the supported states.
 	RO, Required
 
 
