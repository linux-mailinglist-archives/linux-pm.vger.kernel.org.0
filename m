Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B18648570
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiLIP1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiLIP0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89E58F701
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:42 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ob1RkAbRhZ2AtEFnH6z5mlrDf+gUffIhl67W1j1RCIU=;
        b=cWVDI7BhxxKRs//GGreIJGRj1msQ2GQHT8oQIkfAcubWjola0R5P1E1qhmjFOxT2VdjbYD
        zskZsvRtTDszqZCFV2Q9DlifbVmPPKJm1ud0t1uk2BM7+s5nyD4t6yJk6kTrff2uSVY0yU
        SwffsHu3x9pWiTMgt3fvfhGZ1tlv4wZhI8bkFu4exTLDaaGQuflnNVlrs3oJnVKFXLBkS9
        n2DzMcOsDhhkOm9xxzbWpW6oayB72jIcRWvLJUmLS39VVdhvv9Vp5AzrT0tGK+mmNP8n4I
        HsaXUi1njriCTu034QXG49g2rgsBfRAapQB8N0SXmSp1QSgYqQMFqc8w3lBcOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ob1RkAbRhZ2AtEFnH6z5mlrDf+gUffIhl67W1j1RCIU=;
        b=uVqb2bQYsvhkNH7bKi6FqAZ/h3kf6/SJMzwkzTnSZYCbDiafaqBollhcIoA1nwkny+xWYM
        9Ge7psA2abvYglCg==
From:   "thermal-bot for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel: intel_tcc_cooling: Add TCC
 cooling support for RaptorLake-S
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959907.4906.5100288226387491188.tip-bot2@tip-bot2>
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

Commit-ID:     e77f069fd6cea822efd15ea79aa61aa6422d4f67
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e77f069fd6cea822efd15ea79aa61aa6422d4f67
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Tue, 08 Nov 2022 16:12:20 +08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Wed, 09 Nov 2022 14:58:02 +01:00

thermal: intel: intel_tcc_cooling: Add TCC cooling support for RaptorLake-S

Add RaptorLake to the list of processor models supported by the Intel
TCC cooling driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index c9e84e6..a89e7e1 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -85,6 +85,7 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
 	{}
 };
 
