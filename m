Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A7E40599A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbhIIOsR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345533AbhIIOrv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C2FC0560C9
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:46 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzZ69xQB8ntz4NbHhu8WCcG51smINwUD0WqaxRYQU6o=;
        b=f593HDkpYpTB1xLVKwiXSR04n1+41zivqz+lRIUOlCQfjksArq4ykagcleoHeDFMWGWE3m
        LnQedQUWDj65NQOkWwhqR0E7WTrkZYONVDVoZogPqCRWoej6jBXFF95ZrM4DRw1Ucn0ups
        S8S7IifXaYJg12oJMccGgKoWi081Lx5GlUdXWRXRpkglqEZ39qED1HrkjwD3xzOs4VfJSX
        TDthc1T7ARnsr2Lr2LrKHnW/6iCS2q+WwWhiMh3qQ/77h6AfkcMG9buTM2+7SoksPwZaiO
        1yl3fRoO8plXpMXoPrabcRe6Xz7fWdnMG+rmGcJWq2u+BlzL6n4rGYMtV0ilMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzZ69xQB8ntz4NbHhu8WCcG51smINwUD0WqaxRYQU6o=;
        b=AsYHzwWQiwX8ktsUjUyAE86hrz4IQX1d4Hw5krgGHbSzIIF5n+L9/Z1Ihago53u5VM6glm
        moL45fj4SzuDwkAA==
From:   "thermal-bot for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/exynos: Fix an error code in
 exynos_tmu_probe()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210810084413.GA23810@kili>
References: <20210810084413.GA23810@kili>
MIME-Version: 1.0
Message-ID: <163119832387.25758.3255139820325756878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     02d438f62c05f0d055ceeedf12a2f8796b258c08
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//02d438f62c05f0d055ceeedf12a2f8796b258c08
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Tue, 10 Aug 2021 11:44:13 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 12:40:35 +02:00

thermal/drivers/exynos: Fix an error code in exynos_tmu_probe()

This error path return success but it should propagate the negative
error code from devm_clk_get().

Fixes: 6c247393cfdd ("thermal: exynos: Add TMU support for Exynos7 SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210810084413.GA23810@kili
---
 drivers/thermal/samsung/exynos_tmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index e9a90bc..f4ab4c5 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1073,6 +1073,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
 		if (IS_ERR(data->sclk)) {
 			dev_err(&pdev->dev, "Failed to get sclk\n");
+			ret = PTR_ERR(data->sclk);
 			goto err_clk;
 		} else {
 			ret = clk_prepare_enable(data->sclk);
