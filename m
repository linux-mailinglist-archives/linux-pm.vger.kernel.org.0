Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D703855D6
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 00:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbfHGWbX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 18:31:23 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54587 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389465AbfHGWbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 18:31:22 -0400
Received: by mail-qt1-f201.google.com with SMTP id t5so83571771qtd.21
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 15:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f/5iyKYNpppjBF3zdaFLWaB9mtwpqzd2AKaKjPJxAWs=;
        b=oG/h5CSE4Vl8m9nJpZKL2XmKPaShpcaKcKIvjDfvwRS9zUFnoyEJ3iouLQdGeCZq+E
         hf9dKIkpZb9iIuxITVcANYzlRy6K7U+DS0F6TsUJOUjUBN39vlI6rEFj7nwKYnjH1jnX
         6aSKpaBVNOrDAU8lFkxwVB4padlrh79dFWccl81oByzfLMik8LcjrwAAATm0E9k+bbVs
         eKzqRFY+EYl5uV2uMKPbKLCMo93gdvytxJvjedgKr3PGKLN/s5CP10TvgN1jHHWZ58dc
         VFrHN/eoabKXS5bZ03G+2CTZZeJfUJacXEtg2vO+jIsZWRl1Enxs5vUieQ0d0zVf+S+g
         sIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f/5iyKYNpppjBF3zdaFLWaB9mtwpqzd2AKaKjPJxAWs=;
        b=mr8QeeXg+KZNosyhHLpOqud3LTbbMNNrM0XlJ7B5/auzevZOJllGEbqOYBKtl8Jv4K
         8Ub8gH+y8+u3ZR+H/rbGvQAPuixAP4ttOztHLhvYkw5NKsBNzsp/KdvVgaEJj1M2TP2+
         fmQLbvNhkrCpKJPYKsbQwAcJPEd7OvJyUMaM4SiHxmQfOwsiA5fQVLYE9gnKbKVkoyul
         QBeQUUneg3k0pVKVN4t5HCWvy+Gr1ZgNaaD9BzuO9XZ6Bu+QI/wJw61goh2/bogFbFbO
         FAN1rgXWg0a9+BebNaLVYLrWg0OcAHfh9OceXj8nIlj280kcnC02A4c3KC3DBCxdWnCs
         NFmg==
X-Gm-Message-State: APjAAAW1S7e+4JsmZ2LYvGVOf8jLbi/JzNHgmJwLIhfln49qOi0rlmiC
        PVKbEVbnSH9WxIQ5u4kmc8NBE2TYiTQVo78=
X-Google-Smtp-Source: APXvYqz0a1du6BAb2n9zOY1TKTVI9Gg9OvB/aNzpeonZWxzlN/oxlG5fY68P9FEOHHUsq2e6wy1iV98PD6FTBF8=
X-Received: by 2002:a0c:df12:: with SMTP id g18mr10126912qvl.34.1565217081340;
 Wed, 07 Aug 2019 15:31:21 -0700 (PDT)
Date:   Wed,  7 Aug 2019 15:31:10 -0700
In-Reply-To: <20190807223111.230846-1-saravanak@google.com>
Message-Id: <20190807223111.230846-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190807223111.230846-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Not all devices quantify their performance points in terms of frequency.
Devices like interconnects quantify their performance points in terms of
bandwidth. We need a way to represent these bandwidth levels in OPP. So,
add support for parsing bandwidth OPPs from DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/of.c  | 41 ++++++++++++++++++++++++++++++++---------
 drivers/opp/opp.h |  4 +++-
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1813f5ad5fa2..e1750033fef9 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -523,6 +523,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
+static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np)
+{
+	int ret;
+	u64 rate;
+	u32 bw;
+
+	ret = of_property_read_u64(np, "opp-hz", &rate);
+	if (!ret) {
+		/*
+		 * Rate is defined as an unsigned long in clk API, and so
+		 * casting explicitly to its type. Must be fixed once rate is 64
+		 * bit guaranteed in clk API.
+		 */
+		new_opp->rate = (unsigned long)rate;
+		return 0;
+	}
+
+	ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
+	if (ret)
+		return ret;
+	new_opp->rate = (unsigned long) bw;
+
+	ret = of_property_read_u32(np, "opp-avg-kBps", &bw);
+	if (!ret)
+		new_opp->avg_bw = (unsigned long) bw;
+
+	return 0;
+}
+
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @opp_table:	OPP table
@@ -560,22 +589,16 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (!new_opp)
 		return ERR_PTR(-ENOMEM);
 
-	ret = of_property_read_u64(np, "opp-hz", &rate);
+	ret = _read_opp_key(new_opp, np);
 	if (ret < 0) {
 		/* "opp-hz" is optional for devices like power domains. */
 		if (!opp_table->is_genpd) {
-			dev_err(dev, "%s: opp-hz not found\n", __func__);
+			dev_err(dev, "%s: opp-hz or opp-peak-kBps not found\n",
+				__func__);
 			goto free_opp;
 		}
 
 		rate_not_available = true;
-	} else {
-		/*
-		 * Rate is defined as an unsigned long in clk API, and so
-		 * casting explicitly to its type. Must be fixed once rate is 64
-		 * bit guaranteed in clk API.
-		 */
-		new_opp->rate = (unsigned long)rate;
 	}
 
 	of_property_read_u32(np, "opp-level", &new_opp->level);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 01a500e2c40a..6bb238af9cac 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -56,7 +56,8 @@ extern struct list_head opp_tables;
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
  * @pstate: Device's power domain's performance state.
- * @rate:	Frequency in hertz
+ * @rate:	Frequency in hertz OR Peak bandwidth in kilobytes per second
+ * @avg_bw:	Average bandwidth in kilobytes per second
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
@@ -78,6 +79,7 @@ struct dev_pm_opp {
 	bool suspend;
 	unsigned int pstate;
 	unsigned long rate;
+	unsigned long avg_bw;
 	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
-- 
2.23.0.rc1.153.gdeed80330f-goog

