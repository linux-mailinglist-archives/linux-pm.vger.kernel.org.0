Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86FE2774D8
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 01:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfGZXQM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 19:16:12 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35893 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387490AbfGZXQL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 19:16:11 -0400
Received: by mail-pl1-f202.google.com with SMTP id a5so29310470pla.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T5820OQQJWp4mkgZ4wnYqdAO7VH4vOloLaIe1pVCzGw=;
        b=rDRdRt1bV5MKFBrQ5Vd/g9xRQEItk/yUTt63T3VAu7uVPL36GV1YsP8TrEfApHh+I/
         8bbXL0HHxWc22P7SJCdgHB37BXtOuvrmLVVdFhTs9g4WwVF5r4kkPGcAt3HvF1+moaUj
         AwvhyzbnGzr3w0LAodKf+WzNgW6GdxboES8/O+vahxIqabu5k3uT3vhMj+LO6twVi5wc
         a3GSBaZN+VAKQfJIsmlTui5z8KFOr6Xz8DsB5vPuK8l9/IJFxWGnz52ZxLQgsjz6e9Zh
         xRpBdWT1yrSApQhHHbg/QceFEAInyPa+alLPWEBITCYKzy2EVY7851E8imHAiTa1MnVO
         7nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T5820OQQJWp4mkgZ4wnYqdAO7VH4vOloLaIe1pVCzGw=;
        b=HuJNvJ7FL0OqU+w/WFVmhlETJoVU0Nj0QQRmZSq3KE7UqwZh9GBVR13fdyAuGmzGOD
         7dfKaJ3J/PkEB6lKpQIhWgYdD3Owkr5HJzTCmvp+AZmY6Nigs2NwvnUy/UB9jcl0OmzD
         KDCPJfSbxd1Qnk0StpIRnzm3w7ty3TPGvc36mGGPeuN5a49AawWncNjWZfxro+YUbUwr
         0VGTtjZYSO8WB3D/mSphuHfeyCMKO0fWp5n+r3smWh889r5se/7eoRT9aVW9fFfHtAcQ
         lnbyrrzQXt/Ah/2PFd3DSVxk0KzbywcXRPDScukxRJs670yiCKbUVSVOUJdwLj/gLmbY
         tGzw==
X-Gm-Message-State: APjAAAVBhNOXyu5g+OuzGAQTiVkvFcgGzEpULM+auFCub3IxXv+xaJoS
        9udTuiWiN2EURLWgq+gYN6EySz4ImBTb5Ow=
X-Google-Smtp-Source: APXvYqxvxCZ+h9e26rxDg8g/fbMxJWTK7jGlZs1GjHC9J00BqtPAYG3+n9U0MLf3JudpR+bNpSlJ2Y8Og3j2Btw=
X-Received: by 2002:a63:520f:: with SMTP id g15mr89389221pgb.28.1564182970293;
 Fri, 26 Jul 2019 16:16:10 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:15:56 -0700
In-Reply-To: <20190726231558.175130-1-saravanak@google.com>
Message-Id: <20190726231558.175130-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190726231558.175130-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 2/3] OPP: Add support for bandwidth OPP tables
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
index b313aca9894f..ac73512f4416 100644
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
+	ret = of_property_read_u32(np, "opp-peak-KBps", &bw);
+	if (ret)
+		return ret;
+	new_opp->rate = (unsigned long) bw;
+
+	ret = of_property_read_u32(np, "opp-avg-KBps", &bw);
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
+			dev_err(dev, "%s: opp-hz or opp-peak-bw not found\n",
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
2.22.0.709.g102302147b-goog

