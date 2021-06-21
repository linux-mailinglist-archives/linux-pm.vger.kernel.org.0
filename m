Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CF53AE66A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFUJtX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhFUJtF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FA8C061766
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:46:51 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYh0CpdHqLUj8PIJIBu81/Laa3X15entcmSp/KJlDQE=;
        b=OTQB6hoV1SueheO+8yR31tjs4PeKk2wz9bI5v9a3XW6lWb9QPoEvbazFDHWuEiB36ecM/D
        waWHGjW1jJ5zqauBIQvAFy04DYtjMYIr+9XNCsSQ7ZFom1hO9AjkB63Vtaf93Jf6ZQTOru
        /lKXX3p0MXqRYnbc4P7rQ5h8maszJP1wWAHiYCrxDYQYfKokp/ncO8Olbn6IXkKZL2yYGs
        8dyxy2dvTCmM8XCsagU0vG5OC8CFbOtBDiDe36zGqSPAsI+SPlpd8CnpuXqCrhsJIEUCOT
        OL2c5yeHy+v7sqzScRCTLp3yTqc0am1ObjxwAmuYdvMV4Iw1z6Ye0mhA0K674A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYh0CpdHqLUj8PIJIBu81/Laa3X15entcmSp/KJlDQE=;
        b=1EGyE7PoN/7hnslHtD406VE0WfS0rpEBJdYmes2R/jBlptJYyfEt7tdk4AjY7NfABaiV5G
        7voqB3gguAVXqcAQ==
From:   "thermal-bot for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/imx_sc: Add missing
 of_node_put for loop iteration
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210614192230.19248-1-krzysztof.kozlowski@canonical.com>
References: <20210614192230.19248-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <162426880551.395.2061660206973556225.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3da97620e8d60da4a7eaae46e03e0a494780642d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//3da97620e8d60da4a7eaae46e03e0a494780642d
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Mon, 14 Jun 2021 21:22:29 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 14 Jun 2021 22:41:00 +02:00

thermal/drivers/imx_sc: Add missing of_node_put for loop iteration

Early exits from for_each_available_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/thermal/imx_sc_thermal.c:93:1-33: WARNING:
    Function "for_each_available_child_of_node" should have of_node_put() before return around line 97.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210614192230.19248-1-krzysztof.kozlowski@canonical.com
---
 drivers/thermal/imx_sc_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index b01d28e..8d76dbf 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -93,6 +93,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(np, child) {
 		sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
 		if (!sensor) {
+			of_node_put(child);
 			of_node_put(sensor_np);
 			return -ENOMEM;
 		}
@@ -104,6 +105,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to get valid sensor resource id: %d\n",
 				ret);
+			of_node_put(child);
 			break;
 		}
 
@@ -114,6 +116,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(sensor->tzd)) {
 			dev_err(&pdev->dev, "failed to register thermal zone\n");
 			ret = PTR_ERR(sensor->tzd);
+			of_node_put(child);
 			break;
 		}
 
