Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74364855C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiLIP1c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiLIP0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37928F0A9
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:40 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ess20CBh9/5OyZSgIAjT52wxZOYsIni3iwxwHSSJSwo=;
        b=nWmLpaMxIi+5dfOnBDdzECIieYrdA/wcQBKO1K+1t9UMPTFSUBMqsqxUf6LafhhZu4H9lc
        kXrmS2eQNbep0PebB3CfQ0fyjDgmsxuCtMHy0ovBVziKHPgVccQ6YH+u6Vr7hFgmIVc1/I
        g/fR08BWfI2P8PgXV4Ktst5ZnsI3iFkatcYaqTrRmMQyQ35ErnXoFOYBnbl4uRbcljECj+
        ZvaY1pS2j7pU6UkQsdtZpQgYLiHekLMsXH38IyUzcLyfC2KYV4YeUNSeg2oGKrPA5i5qJg
        UmXDruTjGO5SV8GaL1aDaMWFQFoczXImDZIvESjb4L2y0D0Ur8Xj/dXbA0z0xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ess20CBh9/5OyZSgIAjT52wxZOYsIni3iwxwHSSJSwo=;
        b=PjLnPw1shuYoGFBuRxHQbfE+w2xcuoYrRihy/37qJmFYqVBXpjsZqcRb8WzaJmIayUEHrB
        pFmzUol3r4Ww8JBg==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel: Prevent accidental clearing
 of HFI status
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959722.4906.8964362807961283510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6fe1e64b60269aa58fa00568807738025ae3bd05
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6fe1e64b60269aa58fa00568807738025ae3bd05
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Tue, 15 Nov 2022 18:54:16 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Wed, 23 Nov 2022 20:09:06 +01:00

thermal: intel: Prevent accidental clearing of HFI status

When there is a package thermal interrupt with PROCHOT log, it will be
processed and cleared. It is possible that there is an active HFI event
status, which is about to get processed or getting processed. While
clearing PROCHOT log bit, it will also clear HFI status bit. This means
that hardware is free to update HFI memory.

When clearing a package thermal interrupt, some processors will generate
a "general protection fault" when any of the read only bit is set to 1.

The driver maintains a mask of all read-write bits which can be set.

This mask doesn't include HFI status bit. This bit will also be cleared,
as it will be assumed read-only bit. So, add HFI status bit 26 to the
mask.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/therm_throt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 8352083..9e8ab31 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -197,7 +197,7 @@ static const struct attribute_group thermal_attr_group = {
 #define THERM_STATUS_PROCHOT_LOG	BIT(1)
 
 #define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
-#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
+#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(26))
 
 static void clear_therm_status_log(int level)
 {
