Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DAC59526
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 09:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF1HkF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 03:40:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58754 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfF1HkF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 03:40:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BE8C4200D4A;
        Fri, 28 Jun 2019 09:40:02 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B07732001D2;
        Fri, 28 Jun 2019 09:40:02 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C2C24205D5;
        Fri, 28 Jun 2019 09:40:01 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFCv2 2/8] clk: imx8m-composite: Switch to determine_rate
Date:   Fri, 28 Jun 2019 10:39:50 +0300
Message-Id: <5d62b31309e6402bd9fa608730518b39af823fb3.1561707104.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1561707104.git.leonard.crestez@nxp.com>
References: <cover.1561707104.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1561707104.git.leonard.crestez@nxp.com>
References: <cover.1561707104.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This allows consumers to use min_rate max_rate.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 388bdb94f841..1be82ec08ecd 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -45,10 +45,12 @@ static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk_hw *hw,
 				   divider->flags, PCG_DIV_WIDTH);
 }
 
 static int imx8m_clk_composite_compute_dividers(unsigned long rate,
 						unsigned long parent_rate,
+						unsigned long min_rate,
+						unsigned long max_rate,
 						int *prediv, int *postdiv)
 {
 	int div1, div2;
 	int error = INT_MAX;
 	int ret = -EINVAL;
@@ -56,11 +58,17 @@ static int imx8m_clk_composite_compute_dividers(unsigned long rate,
 	*prediv = 1;
 	*postdiv = 1;
 
 	for (div1 = 1; div1 <= PCG_PREDIV_MAX; div1++) {
 		for (div2 = 1; div2 <= PCG_DIV_MAX; div2++) {
-			int new_error = ((parent_rate / div1) / div2) - rate;
+			unsigned long new_rate;
+			int new_error;
+
+			new_rate = ((parent_rate / div1) / div2);
+			if (new_rate < min_rate || new_rate > max_rate)
+				continue;
+			new_error = new_rate - rate;
 
 			if (abs(new_error) < abs(error)) {
 				*prediv = div1;
 				*postdiv = div2;
 				error = new_error;
@@ -69,38 +77,40 @@ static int imx8m_clk_composite_compute_dividers(unsigned long rate,
 		}
 	}
 	return ret;
 }
 
-static long imx8m_clk_composite_divider_round_rate(struct clk_hw *hw,
-						unsigned long rate,
-						unsigned long *prate)
+static int imx8m_clk_composite_divider_determine_rate(struct clk_hw *hw,
+						       struct clk_rate_request *req)
 {
 	int prediv_value;
 	int div_value;
 
-	imx8m_clk_composite_compute_dividers(rate, *prate,
-						&prediv_value, &div_value);
-	rate = DIV_ROUND_UP(*prate, prediv_value);
+	imx8m_clk_composite_compute_dividers(req->rate, req->best_parent_rate,
+					     req->min_rate, req->max_rate,
+					     &prediv_value, &div_value);
 
-	return DIV_ROUND_UP(rate, div_value);
+	req->rate = DIV_ROUND_UP(req->best_parent_rate, prediv_value);
+	req->rate = DIV_ROUND_UP(req->rate, div_value);
 
+	return 0;
 }
 
 static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
-					unsigned long rate,
-					unsigned long parent_rate)
+						unsigned long rate,
+						unsigned long parent_rate)
 {
 	struct clk_divider *divider = to_clk_divider(hw);
 	unsigned long flags = 0;
 	int prediv_value;
 	int div_value;
 	int ret;
 	u32 val;
 
 	ret = imx8m_clk_composite_compute_dividers(rate, parent_rate,
-						&prediv_value, &div_value);
+						   0, ULONG_MAX,
+						   &prediv_value, &div_value);
 	if (ret)
 		return -EINVAL;
 
 	spin_lock_irqsave(divider->lock, flags);
 
@@ -117,11 +127,11 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	return ret;
 }
 
 static const struct clk_ops imx8m_clk_composite_divider_ops = {
 	.recalc_rate = imx8m_clk_composite_divider_recalc_rate,
-	.round_rate = imx8m_clk_composite_divider_round_rate,
+	.determine_rate = imx8m_clk_composite_divider_determine_rate,
 	.set_rate = imx8m_clk_composite_divider_set_rate,
 };
 
 struct clk *imx8m_clk_composite_flags(const char *name,
 					const char * const *parent_names,
-- 
2.17.1

