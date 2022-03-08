Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A424D22B3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 21:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350252AbiCHUex (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 15:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350255AbiCHUew (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 15:34:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3BA3E0C1
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 12:33:54 -0800 (PST)
Date:   Tue, 08 Mar 2022 20:33:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646771633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbllTWgNO3CP30s7P2XPGc6Om+T9W9axG8+Ll1hymbU=;
        b=y67fsHE6Tpxrl9Foqgax1FQiDbmZ7wg0RlqDPLIbIINNdbT3BtzjgudTNBW/yU7jdr29ou
        Hs5/YO58wX4wBvF8shtxXTZS1JtnlapNxSqY5gVzR+KHqPnn6rAHXG4+1BrGG2wOH8cQvf
        f9CTMTQIfDidkAhowatCN/gwbnajG8fJ4Gc0YK9fBTy7BHGqZvzrWfX0qtQWDpnDbOH2MS
        w5r8xWQK7hmMgU4+Y+4JuU+JtuoPGGvgDSCiR3z60v7RpLKVxVYikZZxFIE2YfOWyg2r+K
        cKcOneHKDw1aDqhYoiWo2+P6WGoYP5sF3PUPPaTPr2fvHkLpVuujENpFbksAsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646771633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbllTWgNO3CP30s7P2XPGc6Om+T9W9axG8+Ll1hymbU=;
        b=qz5PwYA9KzXOGb1RTeyYarQXXbBMetMiofAUlzFkz/P0NO5MHyYCAq0KCTk9OZgKi6tJAs
        zkxOjEwp8bmekoBw==
From:   "thermal-bot for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] MAINTAINERS: thermal: samsung: Drop obsolete
 properties
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220122132554.65192-3-krzysztof.kozlowski@canonical.com>
References: <20220122132554.65192-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <164677163086.16921.3686805947032969558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     62db1e8e9701a947a00f3d8987ca3298827def56
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//62db1e8e9701a947a00f3d8987ca3298827def56
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Sat, 22 Jan 2022 14:25:54 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Mar 2022 21:26:08 +01:00

MAINTAINERS: thermal: samsung: Drop obsolete properties

Update the Samsung Exynos SoC thermal driver entry to match reality and
add Krzysztof Kozlowski as co-maintainer (as he maintains entire Samsung
SoC).  The rationale:
1. Bartlomiej's Samsung email bounces, since he is not working in
   Samsung for some time.
2. The mentioned Lukasz Majewski's Git tree was not updated
   since 2015.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20220122132554.65192-3-krzysztof.kozlowski@canonical.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ba1e4a..82fe389 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17135,11 +17135,12 @@ S:	Supported
 F:	drivers/net/ethernet/samsung/sxgbe/
 
 SAMSUNG THERMAL DRIVER
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
+M:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
-S:	Supported
-T:	git https://github.com/lmajewski/linux-samsung-thermal.git
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
 F:	drivers/thermal/samsung/
 
 SAMSUNG USB2 PHY DRIVER
