Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D612D1C4845
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgEDUaF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgEDU34 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:29:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E39C061A0F
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 13:29:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v2so242355plp.9
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jc0TOyQ4war+DAm2+lh4uAs3ApKGMVi9why4UvGExE=;
        b=QNsTHDRZoZuDPWYQs4Csq+6FgUrP8w3uyMqQAR+1uJZZGAxtjqBK6vIQLXiLro9EUM
         rZiKT7UuJeIhn7v8tm363KM+VROs4JMrqn+S7N7HytoMEK+V/od5eq1OdNDeXkskr4S1
         0ilRHOmV42klq2IeepjH+ryE1UU5IjBInAFLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jc0TOyQ4war+DAm2+lh4uAs3ApKGMVi9why4UvGExE=;
        b=hi1FGvwEDBqDI7mXXMBmDS8I/pFlrY/26Y4hTyg92RW4M796K/qjRhk6KKADIbfoAW
         QDv++Y8MBLUrCwz8Oykojd2uJPPs5wYoaY4n3r255GbtLOEqqcgcWKWyQ1qAQ9Y4BFHA
         XrKYHMXjj2b03GNypxiEZGh0tEcaL7ShRAAJEa6eK1y1XLyWrqlbIZ+pdxbLb4aFoSYm
         zH9Aw1Fl+vDJt+nmAVFkgkiE4Oi9yR2Bei9iBXRvXF2HFioBKKkO+2vB2gXW+qdQsA3e
         rLAjLLMOB6bOksjinazjYQW9g/Li9t3NHytJ2rjOY36A7hkPTdjmkFjalESuu+djGMeY
         QUmQ==
X-Gm-Message-State: AGi0Puay8MZT1ymbSqWQ9t1VRYv3Z0fKAcC2d93zcm+9XCwJfrQLJ+8t
        XwAZ88HY+FtAt/wscKve8fHh3w==
X-Google-Smtp-Source: APiQypKaJu64Aen3AruMc8A3xz6cDGP1Ljua3iefkQJP7oxlKh9bFxhPzW0F/NDlcNiJYNL4gl8S4g==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11mr1019115plq.304.1588624196117;
        Mon, 04 May 2020 13:29:56 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id z23sm9511737pfr.136.2020.05.04.13.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:29:55 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 4/4] power_supply: Add power supply type property to uevent env
Date:   Mon,  4 May 2020 14:29:30 -0600
Message-Id: <20200504202930.228453-5-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200504202930.228453-1-mathewk@chromium.org>
References: <20200504202930.228453-1-mathewk@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add POWER_SUPPLY_TYPE to the uevent env for power supply. Type is a
property of all power supplies and there is a sysfs entry for it but it
is not included in the properties array of the power supply so
explicitly add it to the udev env.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
v2: - Fixup with patches in series
---
 drivers/power/supply/power_supply_sysfs.c | 61 ++++++++++++++---------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 8f90daff0003..d856aed8cb41 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -410,6 +410,37 @@ void power_supply_init_attrs(struct device_type *dev_type)
 	}
 }
 
+static int add_prop_uevent(struct device *dev, struct kobj_uevent_env *env,
+			   enum power_supply_property prop, char *prop_buf)
+{
+	int ret = 0;
+	struct power_supply_attr *pwr_attr;
+	struct device_attribute *dev_attr;
+	char *line;
+
+	pwr_attr = &power_supply_attrs[prop];
+	dev_attr = &pwr_attr->dev_attr;
+
+	ret = power_supply_show_property(dev, dev_attr, prop_buf);
+	if (ret == -ENODEV || ret == -ENODATA) {
+		/*
+		 * When a battery is absent, we expect -ENODEV. Don't abort;
+		 * send the uevent with at least the the PRESENT=0 property
+		 */
+		return 0;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	line = strchr(prop_buf, '\n');
+	if (line)
+		*line = 0;
+
+	return add_uevent_var(env, "POWER_SUPPLY_%s=%s",
+			      pwr_attr->prop_name, prop_buf);
+}
+
 int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
@@ -429,31 +460,13 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (!prop_buf)
 		return -ENOMEM;
 
-	for (j = 0; j < psy->desc->num_properties; j++) {
-		struct power_supply_attr *pwr_attr;
-		struct device_attribute *dev_attr;
-		char *line;
-
-		pwr_attr = &power_supply_attrs[psy->desc->properties[j]];
-		dev_attr = &pwr_attr->dev_attr;
-
-		ret = power_supply_show_property(dev, dev_attr, prop_buf);
-		if (ret == -ENODEV || ret == -ENODATA) {
-			/* When a battery is absent, we expect -ENODEV. Don't abort;
-			   send the uevent with at least the the PRESENT=0 property */
-			ret = 0;
-			continue;
-		}
-
-		if (ret < 0)
-			goto out;
-
-		line = strchr(prop_buf, '\n');
-		if (line)
-			*line = 0;
+	ret = add_prop_uevent(dev, env, POWER_SUPPLY_PROP_TYPE, prop_buf);
+	if (ret)
+		goto out;
 
-		ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s",
-				     pwr_attr->prop_name, prop_buf);
+	for (j = 0; j < psy->desc->num_properties; j++) {
+		ret = add_prop_uevent(dev, env, psy->desc->properties[j],
+				      prop_buf);
 		if (ret)
 			goto out;
 	}
-- 
2.26.2.526.g744177e7f7-goog

