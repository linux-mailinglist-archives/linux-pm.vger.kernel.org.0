Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF85DA65
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 03:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfGCBKc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 21:10:32 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52151 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfGCBKb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 21:10:31 -0400
Received: by mail-pg1-f202.google.com with SMTP id o16so490197pgk.18
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2019 18:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dy7IdBEhW7jfMC6O06J1yeWm8DJoUAt+P2F38lOHIKQ=;
        b=C+5g3BYbxc2d5v4pLP/1xtwd+gYW5qoY5iVHn3hvWw7WT8h7YVWVxHxfRmoJZQ+3s6
         hffBFFZ4zf6A+TQkyNDSMed/hkUv/4u1jzgsPMyyvLb8hk0B2xE21Z86qEbY9tJHH5oR
         GfYN6NWShZj/4lMx+s+3v/qGTLx+NmsrdLLR6Cdq1pKbrTdMgKnwRQDBVMM48asgS0+R
         /AYTF6Nm7JTPNsl33trsxoyKPIqWP9Y2TgHdjTQKk54a5F0nlHR49OKuBTRcQ7BXh/+q
         hSR7Y5Che5UPvZGgOcNebRoL4ySDoTiY3d1LLbAWX5xLnPfcS16Q2qDmzcKnrBnPNlKo
         fcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dy7IdBEhW7jfMC6O06J1yeWm8DJoUAt+P2F38lOHIKQ=;
        b=X7ZThSHNi3JISAQ13CimtFZdBGFfRE5U+B7Z9cMOe6gnUH0nrWU4Or0hErOLOJN2xJ
         Ve/mMUpJLQ6lXT6OdROW6QFBEZzJn41Wxd9eDs9xmp9p13RjzDRurxTwUlQ91VooUomn
         qteHx7NFvaf3ddTxvRG5Bj3an7QssKzsgC1J0vDUnisiKW/gllZHrpJKkZ8lGb1qkVRv
         ik5+azD4z8lW8AwNX3qhO8/nUK75+JIQsxxhEpev93lZBs2bfobnTOzfe3mfjiSXcP7k
         eXAA9WYU4DmGs3K0tyP47dtzhmM+hU/YtQiH5iARQNrzcQoy0vz/dL51d7eYzxXz6awo
         aCWQ==
X-Gm-Message-State: APjAAAXF/s0B59aXJylai/B3q4jXuYDzJO9ebGdMy0fey2B9YaDgwVN0
        T/TH8ebDE92iS7GP1Kj5V53k8m48I97ks+o=
X-Google-Smtp-Source: APXvYqyZ5SvXkZiJtN4AUVK0TG4NbXUnITz/8Rd9BjbL8Dw8vo+ZHuPMPIdAlkE6UzLY/jK4QL5YPQ5Wylc+8rU=
X-Received: by 2002:a65:4786:: with SMTP id e6mr25216266pgs.448.1562116230898;
 Tue, 02 Jul 2019 18:10:30 -0700 (PDT)
Date:   Tue,  2 Jul 2019 18:10:16 -0700
In-Reply-To: <20190703011020.151615-1-saravanak@google.com>
Message-Id: <20190703011020.151615-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 2/6] OPP: Add support for bandwidth OPP tables
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, vincent.guittot@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
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
 drivers/opp/of.c  | 34 ++++++++++++++++++++++++++++++++--
 drivers/opp/opp.h |  4 +++-
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c10c782d15aa..54fa70ed2adc 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -552,6 +552,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
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
+	ret = of_property_read_u32(np, "opp-peak-KBps", &bw);
+	if (ret)
+		return ret;
+	new_opp->rate = (unsigned long) &bw;
+
+	ret = of_property_read_u32(np, "opp-avg-KBps", &bw);
+	if (!ret)
+		new_opp->avg_bw = (unsigned long) &bw;
+
+	return 0;
+}
+
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @opp_table:	OPP table
@@ -589,11 +618,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (!new_opp)
 		return ERR_PTR(-ENOMEM);
 
-	ret = of_property_read_u64(np, "opp-hz", &rate);
+	ret = _read_opp_key(new_opp, np);
 	if (ret < 0) {
 		/* "opp-hz" is optional for devices like power domains. */
 		if (!opp_table->is_genpd) {
-			dev_err(dev, "%s: opp-hz not found\n", __func__);
+			dev_err(dev, "%s: opp-hz or opp-peak-bw not found\n",
+				__func__);
 			goto free_opp;
 		}
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 569b3525aa67..ead2cdafe957 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -59,7 +59,8 @@ extern struct list_head opp_tables;
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
  * @pstate: Device's power domain's performance state.
- * @rate:	Frequency in hertz
+ * @rate:	Frequency in hertz OR Peak bandwidth in kilobytes per second
+ * @avg_bw:	Average bandwidth in kilobytes per second
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
@@ -81,6 +82,7 @@ struct dev_pm_opp {
 	bool suspend;
 	unsigned int pstate;
 	unsigned long rate;
+	unsigned long avg_bw;
 	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
-- 
2.22.0.410.gd8fdbe21b5-goog

