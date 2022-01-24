Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26A9497BA4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jan 2022 10:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiAXJOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jan 2022 04:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiAXJOP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jan 2022 04:14:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC9C06173B
        for <linux-pm@vger.kernel.org>; Mon, 24 Jan 2022 01:14:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 204so181270wmc.4
        for <linux-pm@vger.kernel.org>; Mon, 24 Jan 2022 01:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qiv8SCZ1DWia4b/ngawnPJlXQ3FTRyWB9RDCxFqT2os=;
        b=wLe7ks67JPi0/ir33GiUEWBmw+QazGl7+viYWqnVZjVN0MKcjiueuIVbGt52pplQUl
         c1W52yrGDY4SUIdUTHHrQsb+grONIZPrHVYcIzLRc7haL7jczvhmfopgeqr3iPEvgXhG
         5isCsOJyhK6rjnQG3kaNm0DH6hSBfT2dE/Yh/XdG8n0ANmLCpPNgrl2L/yYd5Yi/5X32
         JNYvMPB9HRoSW2nETf7Ndhyt0k4eXSmCuWLWOiEidaipXJVCzGch4ICQ6xmxPurzqLSi
         ZhYF42Tz2Wwzra2YiOZrqoVvwvdAhLV38nJ3tWZv7lJtg5RrBFRoSX9gZRXsj3urwnO3
         CHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qiv8SCZ1DWia4b/ngawnPJlXQ3FTRyWB9RDCxFqT2os=;
        b=0lCe9+gj/NWroZltfQ4/HyfEiouLZ2zphUK0yiHYuixn2pjPP8jXQR4CyiKIku6AGs
         NpE7TrCwAURQPLgyIa4b4WE6mg8+hTP2735gBCCiSh79J+4h4cD5hYPO18KENYhot1AB
         050Fv/zli2pOu2yJo8SY9FD28Mc2gVIRIZYYXWPmTpXDU8iThlc2jl+h80Ib59UFVAGe
         Arb8muGZ4QbBDB5ejHZEt0mXn1WgrW2UJx2/7xi0FJy3cKuj9izYUJ2+fqnj8ahd+X3h
         r5qhV0JB8P1xNW6gVDOwlOOPJaCkpKaoqAutYe42HCiF6Y4AWFlWVqrbBx4vCWCcKCGM
         QujQ==
X-Gm-Message-State: AOAM531/TemtNltWzXTk6ZT2sXB5IYmR/GLIdCmKMV7Hd1Y7HvTG9uH7
        k2vk0CWGVz1BgS2ZFXu6LjrcAw==
X-Google-Smtp-Source: ABdhPJyIEnnflQqUOEWE/Cu463EvA9RPW7Zy9Bo/q8PAKDzFOw2tnhB80U89Ab2CGcBs7xw5wevaoA==
X-Received: by 2002:a1c:2784:: with SMTP id n126mr908918wmn.1.1643015652934;
        Mon, 24 Jan 2022 01:14:12 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:507b:3e2c:fe72:e1b4])
        by smtp.gmail.com with ESMTPSA id o8sm15392007wmq.41.2022.01.24.01.14.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jan 2022 01:14:12 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [RESEND PATCH] PM: wakeup: Wakeup accounting for interrupts
Date:   Mon, 24 Jan 2022 10:26:24 +0100
Message-Id: <1643016384-11161-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Most of the time, system wakeup is caused by a wakeup-enabled
interrupt, but the accounting is not done for the related wakeup
source, causing 'wrong' values reported by device's wakeup attributes
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
index 99bda0da..2d75e057 100644
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

