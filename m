Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ABC21CDF6
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 06:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgGMEFs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 00:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgGMEFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 00:05:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F85C061794;
        Sun, 12 Jul 2020 21:05:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x8so4933992plm.10;
        Sun, 12 Jul 2020 21:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QHv+xaP8gtFzkMGvulGeFBjvhBMsdrCL77aiNCTaKw=;
        b=hB6hlVvgyyOWlIvydUhoJGJFnh0h4VhRgpU+3Pj7EF6zno5gySq+xMGZA57ZJNi5nq
         zOaQIc7OYLm0znR3rpy57Sx2Ae6t80fvXraH9G6jiaf0a3w9Iw/jGsexNgCBQRK0gy17
         wHoAO35V3zML2JlSc5rJqDBw6NCIn+YSlShEZWauhND947/6uJZqyDiv8Y7WSDkcvuI6
         6dkG8qo/lk43IPKavyBrUlsJSadLSlEXzV1qxpebsS2tRhirh9GyD8CDNpQscwK0s1W4
         0T1WN/7v8c4fcXUNG8FDwHOAFKjVKWiFLxapNZzMBbH3+qIZxo67JW72IOy3ffx4TFEZ
         wYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QHv+xaP8gtFzkMGvulGeFBjvhBMsdrCL77aiNCTaKw=;
        b=k5NXO++Dm6JV5MOXFSEtUpcliOec/GlB2+4CcniydHwbV5yDLGzD90nbTURH1563Mj
         VmwssbKDbMOqTECwhceLbWWfrY54Ld4xlmuD+atvd0c5Ff4RgiVcW646wd8zLbSq4Zdg
         nAN8420msCu0J7Qcej+6x5NsQ/PuIiY+YGjtmvAbktid+svLhFh5gS5vOn4I4HnsY22e
         KpIRYlifhgLxiC35tyL2sGJjueoMh6vuQAio4FvGf0Sdn2pIaf919+AHPgicXRJTp7th
         gtM4IFaLjBPG6WX+TFK+ZC531Y3BSM92J3NxO8KG7HcRjJl/SLSfpuuLZSEcM311vGXf
         ptVQ==
X-Gm-Message-State: AOAM531f3Gae+CutQIJrwETHqHs3y2aZEX9ZlWqmez1XJJ6AGdFu7s5B
        uxZeAvFO5GARBoUUwcEolT8=
X-Google-Smtp-Source: ABdhPJxZNU0CrXx0PCdOPhnP2zUowgf6EgKHOtFX4uWwaePODwVu8XEmbVLjf81JDznWbLgU8wA0xA==
X-Received: by 2002:a17:90a:f695:: with SMTP id cl21mr18569118pjb.86.1594613147069;
        Sun, 12 Jul 2020 21:05:47 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id j13sm12561570pjz.8.2020.07.12.21.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 21:05:46 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v2 1/5] power: supply: core: add quick charge type property
Date:   Mon, 13 Jul 2020 12:03:36 +0800
Message-Id: <38b7b1dc10cf608faceae923374791a52a450919.1594612572.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594612572.git.huangqiwu@xiaomi.com>
References: <cover.1594612572.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Reports the kind of quick charge type based on
different adapter power. UI will show different
animation effect for different quick charge type.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 216d61a22f1e..d3169d47e359 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -708,3 +708,13 @@ Description:
 
 		Access: Read
 		Valid values: 1-31
+
+What:		/sys/class/power_supply/<supply_name>/quick_charge_type
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+		Description:
+		Reports the kind of quick charge type based on different adapter power.
+
+		Access: Read-Only
+		Valid values: Reported as integer
+
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bc79560229b5..9554d7907373 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -206,6 +206,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
+	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index ac1345a48ad0..3fe7e9ef2f0f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -167,6 +167,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 };
 
 enum power_supply_type {
-- 
2.27.0

