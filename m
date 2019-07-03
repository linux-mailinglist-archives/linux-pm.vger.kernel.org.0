Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319755DA6B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 03:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfGCBKk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 21:10:40 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:46396 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfGCBKi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 21:10:38 -0400
Received: by mail-ot1-f73.google.com with SMTP id m16so436574otq.13
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2019 18:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yFXfbR6wa0Ur/jSZ6VNfgLJznw66VBn59W3yxqCW7NM=;
        b=vwv84SdZLnvN4EmOeqy22YxzbmFmKouwa0nzBFOwmxta9hlsJT0H3QFXCuy5t777YN
         FjNrPeaCRamOIDNLfHaCdvn+Cv7d4uzH2Xgtar+yJTKor7GRaURomcBbJN49yNiPSiTc
         9aCQcC00dtNqUOnuB/4syiHqjno4Xb5t8LGnKcUtXKbhX1rGhy/S0MKjRtGJNWa28KUE
         ZgoJGZZS0d0lI8qLSPBe1RoQyutcB2VLpy7YkvTV38IePnyBD3nl+3iaP3x7skzksJ1g
         6HxhRqmBSesa8mVVinWZyyUJu22aSHoFC6GACyqtYa76BjBb33Q9mtiBfphneTFq0D4l
         rReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yFXfbR6wa0Ur/jSZ6VNfgLJznw66VBn59W3yxqCW7NM=;
        b=VnKBVdFtFH5Y1wTQrxbKo2zmP5AGCacUjl0EEW43OyEyOGOxZHZUmpWRcvNDwAHF16
         I18ngFkJ1RzRIB8POz2kwN4Xd1Irnde7Kv7PnE4BJMSmMbp2WPToz0+9uz9vr/Ed6ZSe
         Jb9EtQgz9R+JtMWt6PKMLfbLeCh6TlJK9fT3mTw0Tjxh2PUV4+h2Da9kUG0amRozx2qD
         5RRx5GQXHhEBX1t4ZB3ndmeC2kNtrXeJ/YsBD+k9xEZbtWS5laUy8HgP3gr9ffujLGKL
         HCI6KJIFI6X7RXeQVlBwDYtih0LLbs8rDiw2jEkRKG6kvYPBQSxqC33E92/F5VbDVuve
         5xgA==
X-Gm-Message-State: APjAAAXku/4kDSDIttJwPGA7isnzsHTpSMIj40BDv2aPum4I9TgmwnYR
        3k+jL5zDfXyYRYrbsahy7Hr1oYERs+vKwD0=
X-Google-Smtp-Source: APXvYqy/kO7fXs12HqbjkZVqApk+Z3KfTpViPx35W4gf2H71u487pYhcO8yqWOR8+YLawhr6iW9vzVIQEUtt+SM=
X-Received: by 2002:a9d:6c17:: with SMTP id f23mr16508610otq.174.1562116237315;
 Tue, 02 Jul 2019 18:10:37 -0700 (PDT)
Date:   Tue,  2 Jul 2019 18:10:18 -0700
In-Reply-To: <20190703011020.151615-1-saravanak@google.com>
Message-Id: <20190703011020.151615-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 4/6] OPP: Add API to find an OPP table from its DT node
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

This allows finding a device's OPP table (when it has multiple) from a
phandle to the OPP table in DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/of.c       | 42 ++++++++++++++++++++++++++++++++++--------
 include/linux/pm_opp.h |  7 +++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 54fa70ed2adc..34c51905f56d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -42,14 +42,9 @@ struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 
-struct opp_table *_managed_opp(struct device *dev, int index)
+struct opp_table *_find_opp_table_from_node(struct device_node *np)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
-	struct device_node *np;
-
-	np = _opp_of_get_opp_desc_node(dev->of_node, index);
-	if (!np)
-		return NULL;
 
 	list_for_each_entry(opp_table, &opp_tables, node) {
 		if (opp_table->np == np) {
@@ -69,11 +64,42 @@ struct opp_table *_managed_opp(struct device *dev, int index)
 		}
 	}
 
-	of_node_put(np);
-
 	return managed_table;
 }
 
+/**
+ * dev_pm_opp_of_find_table_from_node() - Find OPP table from its DT node
+ * @np: DT node used for finding the OPP table
+ *
+ * Return: OPP table corresponding to the DT node, else NULL on failure.
+ *
+ * The caller needs to put the node with of_node_put() after using it.
+ */
+struct opp_table *dev_pm_opp_of_find_table_from_node(struct device_node *np)
+{
+	struct opp_table *opp_table;
+
+	mutex_lock(&opp_table_lock);
+	opp_table = _find_opp_table_from_node(np);
+	mutex_unlock(&opp_table_lock);
+	return opp_table;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_find_table_from_node);
+
+struct opp_table *_managed_opp(struct device *dev, int index)
+{
+	struct device_node *np;
+	struct opp_table *opp_table;
+
+	np = _opp_of_get_opp_desc_node(dev->of_node, index);
+	if (!np)
+		return NULL;
+
+	opp_table = _find_opp_table_from_node(np);
+	of_node_put(np);
+	return opp_table;
+}
+
 /* The caller must call dev_pm_opp_put() after the OPP is used */
 static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
 					  struct device_node *opp_np)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index d4d79ac0b5b2..d80c59bcd50b 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -359,6 +359,7 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
+struct opp_table *dev_pm_opp_of_find_table_from_node(struct device_node *np);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
 void dev_pm_opp_of_register_em(struct cpumask *cpus);
@@ -396,6 +397,12 @@ static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device
 	return NULL;
 }
 
+static inline struct opp_table *dev_pm_opp_of_find_table_from_node(
+							struct device_node *np)
+{
+	return NULL;
+}
+
 static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
-- 
2.22.0.410.gd8fdbe21b5-goog

