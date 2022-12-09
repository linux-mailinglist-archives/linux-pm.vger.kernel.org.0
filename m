Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBCA64856B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiLIP1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiLIP0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9847E8BD2B
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:42 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jYAC19tP7GFY88+8181iigvJPB2Q4meSKlJJf4+qUQk=;
        b=hY8gzRRID1+oYDdAY3u/JBueIUZLelx9ONRS3ILChyRqEi+plhKpUz80PC3m0sivhZ7+Wt
        MqV1P2lhcSHIpvhkJ19ZIzddLGEpuwitNVKmLzfymE6baM3uEV6thJctj9MTErFCDwuQ3/
        YXWdJ0LVTFDKbmzFSh0sLljD9OynWMCFnzsHfn/TBkYYTltVUV1ez9agZKPQTED3VDCuic
        +pRBDHhTV9NqKAlBr9gZaS+bRy3hvHmQ4g7Y2E0AVCzrYbVOgIBHdbvEOcc9CTfjH89I07
        bjCKl40vru4JUDorRSNc+8oiYn+OW6aP1o9WG82qhYKAYFGNygOPDR49SiPsiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jYAC19tP7GFY88+8181iigvJPB2Q4meSKlJJf4+qUQk=;
        b=RWEGH+9Gn6sl5Rsl62IIuTTO9ef+uK2BFzcp7BJQDXnmWQZQ6EZhoBULr04/AJphBwkJj5
        Z1Kh2ZTzTCBeeuDA==
From:   "thermal-bot for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel: intel_tcc_cooling: Detect TCC
 lock bit
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959922.4906.755625363628346108.tip-bot2@tip-bot2>
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

Commit-ID:     be6abd3ed65678f8c7bd212808a9841785c2d5ca
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//be6abd3ed65678f8c7bd212808a9841785c2d5ca
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Tue, 08 Nov 2022 16:12:19 +08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Wed, 09 Nov 2022 14:58:02 +01:00

thermal: intel: intel_tcc_cooling: Detect TCC lock bit

When MSR_IA32_TEMPERATURE_TARGET is locked, TCC Offset can not be
updated even if the PROGRAMMABE Bit is set.

Yield the driver on platforms with MSR_IA32_TEMPERATURE_TARGET locked.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 95adac4..c9e84e6 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -14,6 +14,7 @@
 #define TCC_SHIFT 24
 #define TCC_MASK	(0x3fULL<<24)
 #define TCC_PROGRAMMABLE	BIT(30)
+#define TCC_LOCKED		BIT(31)
 
 static struct thermal_cooling_device *tcc_cdev;
 
@@ -108,6 +109,15 @@ static int __init tcc_cooling_init(void)
 	if (!(val & TCC_PROGRAMMABLE))
 		return -ENODEV;
 
+	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
+	if (err)
+		return err;
+
+	if (val & TCC_LOCKED) {
+		pr_info("TCC Offset locked\n");
+		return -ENODEV;
+	}
+
 	pr_info("Programmable TCC Offset detected\n");
 
 	tcc_cdev =
