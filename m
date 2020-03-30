Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8161987F9
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 01:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgC3XUN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 19:20:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36404 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbgC3XUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 19:20:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id g12so20059653ljj.3;
        Mon, 30 Mar 2020 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fv8dc7di5mNxhhrq8SinzaGaASexqvtbzFjGs38VwgM=;
        b=LEF6jeC6S+Pu6feCqp/Wulwo98rHY6rdIq9qPMyvgVfQ0ZrNxRc/9WaZfXNzUN2hUV
         mhnxPCGmJ4xsA5y5ZHwFg8QpAs8SnCq4q7D85vGWbf6l2Xg/teOwVpWWwSwcLEuAZqKJ
         /lTz+HcBdffglVTX+Vz00fJ0IPLYZtDnklSaPIuOGmxWtnadp+eD54WsEzTEwq91HvI/
         0sxa7y5O17RrVyhtPldPydZkL/5GDbbeVMrrOoggvH8Dd6KHrweOlIvteX6+jmWZztJ1
         h/tUAdsfEFE3WZSDbuX3qCuOtDq5rVZnfx3sFZLcKX/bedQcIofpBKfpVaFOxVwshW2O
         6LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fv8dc7di5mNxhhrq8SinzaGaASexqvtbzFjGs38VwgM=;
        b=EIpeF6tS3C53FsoguX5o0JwMwFu2jqXSktpHqb9KQkgONar6W8PeUiLUuWq89CkJ3m
         H3WWcsH5CIaq42EbdInEbqgvRbejaTunmL61T+X+X7DwOL1w7gNJD0+ok2PR9DkGtJQS
         2vFahypxPR5FzGqgQmhxxqYufEOv/Ac2Fpd6UXCzp+HDrHYI3+vDdpPYvPuscjnet0O/
         Fy7vfRsTtJZF8pNUXKjr88f5Q+bYj1bpurQ3zY41X0ns/zukvHf4FC8lrKPkOvZJr/1M
         Q5dezCeO9my7sm9SOazb6EjGmppA9H1vK5QwRdBZLV+zVkEunEzTgIhq0oiF8IOCHPcV
         yFYw==
X-Gm-Message-State: AGi0PuYRcF1ImHSy7f53k9eWcl1rEsXroz7FbDWn+6MgPpypAZ6Q7O0J
        uXPZnbtOH3VOwdrauv6bYRM=
X-Google-Smtp-Source: APiQypK2Vnf5OALxWdbmdCt0+6UzBlAss2wK8mQzDJiIb0w4RHCGHmZwWClAbKEW60GsklLXsGSH3g==
X-Received: by 2002:a2e:8648:: with SMTP id i8mr8415121ljj.188.1585610408466;
        Mon, 30 Mar 2020 16:20:08 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id h3sm8773187lfk.30.2020.03.30.16.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:20:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] clk: Introduce clk_round_rate_unboundly()
Date:   Tue, 31 Mar 2020 02:16:14 +0300
Message-Id: <20200330231617.17079-3-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330231617.17079-1-digetx@gmail.com>
References: <20200330231617.17079-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In same cases it may be desired to round clock's rate without taking into
account current min/max requests made by the clock's users. One example is
building up OPP table based on a possible clock rates.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/clk.c   | 49 +++++++++++++++++++++++++++++++++++----------
 include/linux/clk.h | 18 +++++++++++++++++
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 39c59f063aa0..28c2e1699619 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1412,16 +1412,7 @@ unsigned long clk_hw_round_rate(struct clk_hw *hw, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_hw_round_rate);
 
-/**
- * clk_round_rate - round the given rate for a clk
- * @clk: the clk for which we are rounding a rate
- * @rate: the rate which is to be rounded
- *
- * Takes in a rate as input and rounds it to a rate that the clk can actually
- * use which is then returned.  If clk doesn't support round_rate operation
- * then the parent rate is returned.
- */
-long clk_round_rate(struct clk *clk, unsigned long rate)
+static long __clk_round_rate(struct clk *clk, unsigned long rate, bool bound)
 {
 	struct clk_rate_request req;
 	int ret;
@@ -1434,7 +1425,13 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 	if (clk->exclusive_count)
 		clk_core_rate_unprotect(clk->core);
 
-	clk_core_get_boundaries(clk->core, &req.min_rate, &req.max_rate);
+	if (bound) {
+		clk_core_get_boundaries(clk->core, &req.min_rate,
+					&req.max_rate);
+	} else {
+		req.min_rate = 0;
+		req.max_rate = ULONG_MAX;
+	}
 	req.rate = rate;
 
 	ret = clk_core_round_rate_nolock(clk->core, &req);
@@ -1449,8 +1446,38 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 
 	return req.rate;
 }
+
+/**
+ * clk_round_rate - round the given rate for a clk
+ * @clk: the clk for which we are rounding a rate
+ * @rate: the rate which is to be rounded
+ *
+ * Takes in a rate as input and rounds it to a rate that the clk can actually
+ * use which is then returned.  If clk doesn't support round_rate operation
+ * then the parent rate is returned.
+ */
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	return __clk_round_rate(clk, rate, true);
+}
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
+/**
+ * clk_round_rate_unboundly - unboundly round the given rate for a clk
+ * @clk: the clk for which we are rounding a rate
+ * @rate: the rate which is to be rounded
+ *
+ * Takes in a rate as input and rounds it to a rate that the clk can use
+ * which is then returned.  The given rate isn't bounded by clk users min-max
+ * rates, unlike in a case of clk_round_rate().  If clk doesn't support
+ * round_rate operation then the parent rate is returned.
+ */
+long clk_round_rate_unboundly(struct clk *clk, unsigned long rate)
+{
+	return __clk_round_rate(clk, rate, false);
+}
+EXPORT_SYMBOL_GPL(clk_round_rate_unboundly);
+
 /**
  * __clk_notify - call clk notifier chain
  * @core: clk that is changing rate
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 7fd6a1febcf4..b534643015f5 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -622,6 +622,19 @@ void devm_clk_put(struct device *dev, struct clk *clk);
  */
 long clk_round_rate(struct clk *clk, unsigned long rate);
 
+/**
+ * clk_round_rate_unboundly - adjust a rate to the rate a clock can provide
+ * @clk: clock source
+ * @rate: desired clock rate in Hz
+ *
+ * This helper function rounds the given rate to a value that hardware
+ * could actually accept, without taking into account current min/max
+ * requests. Useful for cases like OPP table buildup.
+ *
+ * Returns rounded clock rate in Hz, or negative errno.
+ */
+long clk_round_rate_unboundly(struct clk *clk, unsigned long rate);
+
 /**
  * clk_set_rate - set the clock rate for a clock source
  * @clk: clock source
@@ -857,6 +870,11 @@ static inline long clk_round_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
+static inline long clk_round_rate_unboundly(struct clk *clk, unsigned long rate)
+{
+	return 0;
+}
+
 static inline bool clk_has_parent(struct clk *clk, struct clk *parent)
 {
 	return true;
-- 
2.25.1

