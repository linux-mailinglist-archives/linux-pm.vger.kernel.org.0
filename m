Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE382CEE44
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 13:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgLDMl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 07:41:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41561 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLDMl6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 07:41:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id y7so6431241lji.8;
        Fri, 04 Dec 2020 04:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RXUzzoRMZ6PIXmVqYH2yp1o3qr6JX3BOhrhwT1JN5o8=;
        b=qllRvMQZl4XxvPgztHiP3PWoakMVKgMTbZ9QHlol6irEVTAzWbtEbxGzDRWnsewwnI
         kA+Q8H4avWtHgd7aju97QAalTEQmD5Ai5A0FlXdb3WrbN7xWy7W6HAD2sMhG3LMvBiON
         ypFtpZ6reSYCOU/X7iT3h6CEpbdlFL16eWYeHQhYTp4Ic5EJShbYkDb6ttESbggxXveV
         uAXfd2ewBvfJGyjQtSv9Kko7K/dx5BxilwGfLqQpsjB4FamMsC31cC9gVTQoZb2hwaTE
         W9ACzBjJdJuQ0Uw3A+FGzaMlcXv2N5ZjVSsmgjSN/khGXPNrjnXLz8SKGlOxrc7i+K0J
         9jYg==
X-Gm-Message-State: AOAM5320OFnxlT4IC0o/yz2QgVJbGoo44L96VswWcVSGy4NiUTFulHYn
        jGY9qK8Oggzo3s1qYkuQoVE=
X-Google-Smtp-Source: ABdhPJzFwvB1CMOSO9J5xEMuaHzJLMbptmORJJvS7fEVnli7qvT1eW9rSg/rBQNH0DK8oPFRudpGwQ==
X-Received: by 2002:a05:651c:1067:: with SMTP id y7mr3462768ljm.357.1607085676368;
        Fri, 04 Dec 2020 04:41:16 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id i6sm99310ljn.16.2020.12.04.04.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:41:15 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:41:09 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Cong Pham <cpham2403@gmail.com>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 1/6] power: supply: add cap2ocv batinfo helper
Message-ID: <f2866a9052bbeaa4b3795907f91974e1d18ef68e.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The power-supply core supports concept of OCV (Open Circuit Voltage) =>
SOC (State Of Charge) conversion tables. Usually these tables are used
to estimate SOC based on OCV. Some systems use so called "Zero Adjust"
where at the near end-of-battery condition the SOC from coulomb counter
is used to retrieve the OCV - and OCV and VSYS difference is used to
re-estimate the battery capacity.

Add helper to do look-up the other-way around and also get the OCV
based on SOC

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

No changes from RFC v1 - (this should be changed to support at least
0.1% SOC accuracy - will rework for next version if this is continued)

 drivers/power/supply/power_supply_core.c | 51 ++++++++++++++++++++++++
 include/linux/power_supply.h             |  5 +++
 2 files changed, 56 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 38e3aa642131..67258799ae2e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -787,6 +787,43 @@ int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *t
 }
 EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
 
+/**
+ * power_supply_cap2ocv_simple() - find the battery OCV by capacity
+ * @table: Pointer to battery OCV/CAP lookup table
+ * @table_len: OCV/CAP table length
+ * @cap: Current cap value
+ *
+ * This helper function is used to look up battery OCV according to
+ * current capacity value from one OCV table, and the OCV table must be ordered
+ * descending.
+ *
+ * Return: the battery OCV.
+ */
+int power_supply_cap2ocv_simple(struct power_supply_battery_ocv_table *table,
+				int table_len, int cap)
+{
+	int i, ocv, tmp;
+
+	for (i = 0; i < table_len; i++)
+		if (cap > table[i].capacity)
+			break;
+
+	if (i > 0 && i < table_len) {
+		tmp = (table[i - 1].ocv - table[i].ocv) *
+		      (cap - table[i].capacity);
+
+		tmp /= table[i - 1].capacity - table[i].capacity;
+		ocv = tmp + table[i].ocv;
+	} else if (i == 0) {
+		ocv = table[0].ocv;
+	} else {
+		ocv = table[table_len - 1].ocv;
+	}
+
+	return ocv;
+}
+EXPORT_SYMBOL_GPL(power_supply_cap2ocv_simple);
+
 /**
  * power_supply_ocv2cap_simple() - find the battery capacity
  * @table: Pointer to battery OCV lookup table
@@ -847,6 +884,20 @@ power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_find_ocv2cap_table);
 
+int power_supply_batinfo_cap2ocv(struct power_supply_battery_info *info,
+				 int cap, int temp)
+{
+	struct power_supply_battery_ocv_table *table;
+	int table_len;
+
+	table = power_supply_find_ocv2cap_table(info, temp, &table_len);
+	if (!table)
+		return -EINVAL;
+
+	return power_supply_cap2ocv_simple(table, table_len, cap);
+}
+EXPORT_SYMBOL_GPL(power_supply_batinfo_cap2ocv);
+
 int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 				 int ocv, int temp)
 {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 81a55e974feb..bae98b628f92 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -403,11 +403,16 @@ extern void power_supply_put_battery_info(struct power_supply *psy,
 					  struct power_supply_battery_info *info);
 extern int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
 				       int table_len, int ocv);
+int power_supply_cap2ocv_simple(struct power_supply_battery_ocv_table *table,
+				int table_len, int cap);
+
 extern struct power_supply_battery_ocv_table *
 power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
 				int temp, int *table_len);
 extern int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 					int ocv, int temp);
+int power_supply_batinfo_cap2ocv(struct power_supply_battery_info *info,
+				 int cap, int temp);
 extern int
 power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
 				int table_len, int temp);
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
