Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B504A978F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Feb 2022 11:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbiBDKRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Feb 2022 05:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiBDKRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Feb 2022 05:17:05 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE16C061714
        for <linux-pm@vger.kernel.org>; Fri,  4 Feb 2022 02:17:05 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x23so11787674lfc.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Feb 2022 02:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEZmn2TCD/EbdRMOs40aYSuOww/xn/Q6VxOfylJ/UrU=;
        b=fp+p0q5Ow3IEOMtvcfUBWSbZSX2v8PMGM2B3S/iRoMZyylHzL7nKOmZ4jZeSU0asIs
         5T1PIx9LuZCjwwGqblqOErrDs9xYFEzRIsJ2eMJeMuNGoi3r0iupIfA4MfWaNhPlFCNZ
         M0sk72pkv8AeUMoAxhddQfX3hHaXwVOYL30xjo1+S4J9p477l422yS4DiKwjUJMFtZJB
         SYfDcF+3hQScStIxqld/+HW3SGbNtc5I8s/r5gq303sa80mrLk9x/BdOSPAq/RaE6Jw3
         yU0jfEusuchipamwEY+eTj5aComsG3jSaqb0bv3uktXNUV/Izfd1PZM8KlZjncXp8n55
         S4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEZmn2TCD/EbdRMOs40aYSuOww/xn/Q6VxOfylJ/UrU=;
        b=U2fm6ILV2YBePN/fVO7BGIo89Ur1fuMBBxOe5xtWBKTJoCA6HeE1GyYfwLq95JTghC
         niiEDw0/TZIGN9UU+MLihEOHWv2iooQYIQT/xDMLpiGlR4rsmJjUBFQ1Pou0DTY54pIm
         sD1Ud8IbWDGxtM8WLDzlZ2xXip7eObMe0F82L7ob3ChQ4I7uwOZopiA8Xu4PYnmw8Ckk
         UuhHVyDKM8KSbJHdh5luvuoVJndxvvC/Qg+9DAo6RCa72V1sip0dPMprMkFMl3gMkeRU
         HoKZydQ38GVXfNp24hbEVUExH+56WLUHhYG/GfS9lTBpEDSUUR+vVbWZCZGkKKTNnjsX
         r1tw==
X-Gm-Message-State: AOAM531omQBlAj2clZbA31p2RCCt4vbVEzUhcOwpiNR6DM6KFYqOexTY
        WdBIukUBOS+dIQdCy8S7d6UHDw==
X-Google-Smtp-Source: ABdhPJwxPCgfe1d9RL6DJe+Y0zkjVBMr4lb7rkRtuUFFb0r32JCOYEif1YCU3faXZm8FzGhQbhECkA==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr1749831lfi.10.1643969823445;
        Fri, 04 Feb 2022 02:17:03 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id u4sm245855lfg.239.2022.02.04.02.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 02:17:02 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: domains: Prevent power off for parent unless child is in deepest state
Date:   Fri,  4 Feb 2022 11:16:57 +0100
Message-Id: <20220204101657.233723-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A PM domain managed by genpd may support multiple idlestates. During
genpd_power_off() a genpd governor may be asked to select one of the
idlestates based upon the dev PM QoS constraints, for example.

However, there is a problem with the behaviour around this in genpd. More
precisely, a parent-domain is allowed to be powered off, no matter of what
idlestate that has been selected for the child-domain.

So far, we have not received any reports about errors from the current
behaviour. However, there is an STMicro platform that is being worked on,
which can't cope with this. Therefore, let's change genpd to prevent the
parent- domain from being powered off, unless the deepest idlestate has
been selected for the child-domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Clarified the commit message

---
 drivers/base/power/domain.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5db704f02e71..7f97c5cabdc2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -636,6 +636,17 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			atomic_read(&genpd->sd_count) > 0)
 		return -EBUSY;
 
+	/*
+	 * The children must be in their deepest states to allow the parent to
+	 * be powered off. Note that, there's no need for additional locking, as
+	 * powering on a child, requires the parent's lock to be acquired first.
+	 */
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		struct generic_pm_domain *child = link->child;
+		if (child->state_idx < child->state_count - 1)
+			return -EBUSY;
+	}
+
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
 		enum pm_qos_flags_status stat;
 
@@ -1073,6 +1084,13 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 	    || atomic_read(&genpd->sd_count) > 0)
 		return;
 
+	/* Check that the children are in their deepest state. */
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		struct generic_pm_domain *child = link->child;
+		if (child->state_idx < child->state_count - 1)
+			return;
+	}
+
 	/* Choose the deepest state when suspending */
 	genpd->state_idx = genpd->state_count - 1;
 	if (_genpd_power_off(genpd, false))
-- 
2.25.1

