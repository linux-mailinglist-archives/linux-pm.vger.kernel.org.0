Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACF13B3096
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFXOA6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXOA6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 10:00:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BC2C061574
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 06:58:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h11so6782214wrx.5
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ok0oNGCf+JRjtT625NQEQK1FVyoAR1R2bcfF16fRL9s=;
        b=mN7XkAsBYWDnGI1+t0h8Ux2H30N03Skm5npTDjNvHgb1f6GI4JtUptKdceoIO8mxCs
         zChaF8S7i7mRptKAZ2hj/GgitT1pp8+Nz6XRd4kCoalC+8cVLXYUty+vF4ntK25s0kPn
         tK9RZflf7IzVaPmH2B1AdX06OplsV7xfralPJSkpsL3FejbJ660kAxxEtK3LHpUdKxTa
         X7SBNoSvIxFKgjMi8AUFw0/p1AXAJIEhngVxB5XRssjnM1DUzTzG7O/gFU7SHEuDV/pE
         dXo8nh5M/tcxuRPvgh6i5gmxRPu4QuKHnRYEkbZy0uDamvjry2RCxp5a/NwXWqi3+rbp
         kdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ok0oNGCf+JRjtT625NQEQK1FVyoAR1R2bcfF16fRL9s=;
        b=Z4ydSl3gllIfg959fX5EggmYqx+QkNbmbB+mZOQ4JvTAnIjkOUAF6+TlPb41JFKqqk
         xo+SCRfFl1T4GDRPhOG/4GBEWforu9X9fjA4UNWeTYVFejlwqfm0QiOCauzY7JK60XKy
         OVB8z+J3wS3JIbDoK0utrjkLYoDi/hOeYv+nEW9RfYTBcCBuf/bEz/fei/q5GVkoan4z
         6kZowktabfNFmXf96TLHkQzda7DiPG1sZc2vno3ZBUirMbtNHsYb9SDM00GjtOos6L+k
         BwQGyfLjAsrbRpZ2qeYaWArSGBFSkr0Pv/6av1sJSsa40jyl9J2Ft269gk/kBPrv5eH3
         z5sA==
X-Gm-Message-State: AOAM533rdbEQIk3B3pa2YpIQpOVnDqIukEOjfqUhT1/7Isl+4MDL3MfQ
        CwxGkNnozt0YIK8QSJjX535Rxw==
X-Google-Smtp-Source: ABdhPJwbJ1B0IeYjIAMHS4KuxVT3QWy8OkDMf2XaPHBZhBsH3QRNXI0fvCyCsSSbtty8QsDOSX1EDA==
X-Received: by 2002:a5d:5919:: with SMTP id v25mr4485292wrd.319.1624543116806;
        Thu, 24 Jun 2021 06:58:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:78f0:ea41:c81:639b])
        by smtp.gmail.com with ESMTPSA id 9sm9465894wmf.3.2021.06.24.06.58.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jun 2021 06:58:36 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, pavel@ucw.cz, len.brown@intel.com,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] PM: wakeup: Wakeup accounting for interrupts
Date:   Thu, 24 Jun 2021 16:08:40 +0200
Message-Id: <1624543720-4170-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Most of the time, system wakeup is caused by a wakeup-enabled
interrupt, but the accounting is not done for the related wakeup
source, causing wrong values reported by device's wakeup attributes
and debugfs stats (debug/wakeup_sources).

This change reports a wakeup event for any wakeup-sources the irq is
attached with.

Note: This only works for drivers explicitly attaching the irq to
a given device (e.g. with dev_pm_set_wake_irq).

Note2: Some drivers call pm_wakeup_event() in their irq handler, but
not all, moreover, an interrupt can be disabled while being flagged
as wakeup source, and so accounting must be performed. This solution
ensures that accounting will always be done for the interrupt waking
up the host.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/base/power/wakeup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index f0b37c1..922f701 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -952,8 +952,19 @@ void pm_wakeup_clear(bool reset)
 void pm_system_irq_wakeup(unsigned int irq_number)
 {
 	if (pm_wakeup_irq == 0) {
+		struct wakeup_source *ws;
+		int srcuidx;
+
 		pm_wakeup_irq = irq_number;
 		pm_system_wakeup();
+
+		/* wakeup accounting */
+		srcuidx = srcu_read_lock(&wakeup_srcu);
+		list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+			if (ws->wakeirq && ws->wakeirq->irq == irq_number)
+				pm_wakeup_ws_event(ws, 0, false);
+		}
+		srcu_read_unlock(&wakeup_srcu, srcuidx);
 	}
 }
 
-- 
2.7.4

