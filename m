Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91C0405996
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbhIIOsP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbhIIOru (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18918C0560C2
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:43 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MpdSACoAFKuCZxg8O48eo7DlFKfeMHUllI38es3ZimE=;
        b=mpILsSt5IVhezuq3dbfnvcBi0x0CeG7d29wePdIg1GCQQbOeBGwTATUBL/UL+PHmEeGzXR
        g0ctb0bxER2D/rtuuWgvzYjX7lmbwpsrEDgBeFnfZGpZ4ypOBPfgSXD015jxM0NhXYvvBF
        g7d/gkl5UJrtR2ZekMT0b3pff54bsxvK0ZA6BkDyl5/AgEK8exJpgDdK8ZoD9rlDcMJF2O
        YTAeSZ1wUHpF0vi1bQZ27MbJ0k7vgsA9jpne/EwADoX757F8wzoBfrO48oJ/M9We+isMyQ
        MUo+pft2VQQ4to/8qqScc7f65/zdURh6LX7OJKNuK9Sd5PsFwy+/eZyUy07XKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MpdSACoAFKuCZxg8O48eo7DlFKfeMHUllI38es3ZimE=;
        b=4QNu1cKuNUcnzGdhE3NSmPjZ29Gw6IV8QT2wp3HbIbG99f64+FZARMk4NBOIu9vsL/8CaJ
        3scQayJyxovad1CA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] MAINTAINERS: Add missing userspace thermal
 tools to the thermal section
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
MIME-Version: 1.0
Message-ID: <163119832090.25758.5866861181688303140.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     21c1e439fd864828b58f783641b3736197ccc813
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//21c1e439fd864828b58f783641b3736197ccc813
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Sat, 14 Aug 2021 13:14:07 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 13:14:07 +02:00

MAINTAINERS: Add missing userspace thermal tools to the thermal section

Patches related to the tmon which is in tools/thermal are floating around
since years because it is unclear who takes care of it.

Add the missing userspace tools directory related to thermal to fix the
situation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3..a78f490 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18358,6 +18358,7 @@ F:	drivers/thermal/
 F:	include/linux/cpu_cooling.h
 F:	include/linux/thermal.h
 F:	include/uapi/linux/thermal.h
+F:	tools/thermal/
 
 THERMAL DRIVER FOR AMLOGIC SOCS
 M:	Guillaume La Roque <glaroque@baylibre.com>
