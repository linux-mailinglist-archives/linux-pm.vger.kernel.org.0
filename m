Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2351F430D93
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 03:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbhJRBhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Oct 2021 21:37:07 -0400
Received: from mx.socionext.com ([202.248.49.38]:16351 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242982AbhJRBhH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 17 Oct 2021 21:37:07 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Oct 2021 10:34:56 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 07DDE2059034;
        Mon, 18 Oct 2021 10:34:56 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 18 Oct 2021 10:34:56 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 37646B62B7;
        Mon, 18 Oct 2021 10:34:55 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/2] thermal: uniphier: Add compatible string for NX1 SoC
Date:   Mon, 18 Oct 2021 10:34:51 +0900
Message-Id: <1634520891-16801-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634520891-16801-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634520891-16801-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add basic support for UniPhier NX1 SoC. This includes a compatible string
and the same SoC-dependent data as LD20 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/thermal/uniphier_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index bba2284412d3..4cae5561a2a3 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -358,6 +358,10 @@ static const struct of_device_id uniphier_tm_dt_ids[] = {
 		.compatible = "socionext,uniphier-pxs3-thermal",
 		.data       = &uniphier_ld20_tm_data,
 	},
+	{
+		.compatible = "socionext,uniphier-nx1-thermal",
+		.data       = &uniphier_ld20_tm_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, uniphier_tm_dt_ids);
-- 
2.7.4

