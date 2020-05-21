Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80D51DD3EA
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgEURIM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 13:08:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48578 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgEURIM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 13:08:12 -0400
Received: from 89-64-86-91.dynamic.chello.pl (89.64.86.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id bed6dafa262e0ef4; Thu, 21 May 2020 19:08:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH] PM: runtime: clk: Fix clk_pm_runtime_get() error path
Date:   Thu, 21 May 2020 19:08:09 +0200
Message-ID: <5127441.yGvM1JjtLk@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

clk_pm_runtime_get() assumes that the PM-runtime usage counter will
be dropped by pm_runtime_get_sync() on errors, which is not the case,
so PM-runtime references to devices acquired by the former are leaked
on errors returned by the latter.

Fix this by modifying clk_pm_runtime_get() to drop the reference if
pm_runtime_get_sync() returns an error.

Fixes: 9a34b45397e5 clk: Add support for runtime PM
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/clk/clk.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/clk/clk.c
===================================================================
--- linux-pm.orig/drivers/clk/clk.c
+++ linux-pm/drivers/clk/clk.c
@@ -114,7 +114,11 @@ static int clk_pm_runtime_get(struct clk
 		return 0;
 
 	ret = pm_runtime_get_sync(core->dev);
-	return ret < 0 ? ret : 0;
+	if (ret < 0) {
+		pm_runtime_put_noidle(core->dev);
+		return ret;
+	}
+	return 0;
 }
 
 static void clk_pm_runtime_put(struct clk_core *core)



