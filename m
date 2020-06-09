Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7A1F4702
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 21:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgFITWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 15:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgFITWn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 15:22:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC77C05BD1E
        for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2020 12:22:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k2so1817311pjs.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2020 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AREZFen+390F/g/lLqSOI2E3OTadaJweieFHsKjOGEo=;
        b=mCASZcRtsW2E9COdZCGGeuE6fxEOLG8kDxoXySFgqYfZkelvoZBw41VZgZ7yG7T2UY
         3NumPgt5kZ5QkhfHFo9v9bI06oehP5L1msin12ey1vmNVyZbK5eAv0BaRAsETVGqaKP4
         04KW+40DI4sYL6yy17H4KQCE7TtXDHFiyQIT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AREZFen+390F/g/lLqSOI2E3OTadaJweieFHsKjOGEo=;
        b=l6LPTY/3mgc/8WztEo8cyfUuB98kQfc5i5eiawupGK3OmTKv0Z7i780i60nEJv/dKE
         XpPUEUcvTxza1v2zf7DBs4gapIRR1CM2K19xLBQ32Xy7bl+GhgWxsUbIABWAKQPYqj7U
         76fXWnQOy5txf+ywJDrDEfbIZqP/juNTe4c2VdK+1tPUjX3ac/GkvxHcmQZSWgP+f7Ml
         Mq2auDU49QPh/AEqWRpIooelzlY75+m1Ld+YE8qISuE+LGCyO2WZUU06eIF7piVB6cMw
         BtspbPyvWMqa74x5z4hi+9+P7L3QWZXBw2zmn86BxFfXdR+C2PNVaBCSfwawO/sn+7+R
         ZzzA==
X-Gm-Message-State: AOAM530PqvjaY25pFi2k644NkFCbcnXYYJthEgcszFah31GcFAvByr2f
        wWJ9HNBZq3Z8GjBi0Xk5fwqbhA==
X-Google-Smtp-Source: ABdhPJxhnDO1wuNjXw7lcXWylEoFV7scLH3smcZwtgL94V+KtbXIMxQSgff/lO9E9m2xpoHwCpb+yA==
X-Received: by 2002:a17:902:bc86:: with SMTP id bb6mr4501337plb.243.1591730562043;
        Tue, 09 Jun 2020 12:22:42 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([161.97.245.194])
        by smtp.gmail.com with ESMTPSA id p12sm10883174pfq.69.2020.06.09.12.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:22:41 -0700 (PDT)
From:   Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH 1/2] power: supply: Add new power supply prop for date of manufacture
Date:   Tue,  9 Jun 2020 13:22:36 -0600
Message-Id: <20200609192237.32571-1-twawrzynczak@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Smart Battery Specification v1.1 defines Manufacture Date as one of
its availabe registers. This patch adds this as a property so that
power_supply drivers can support the property and report it in syfs.

Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
Change-Id: I90bf8c67b0cd531f2155404424a98302a1c931d6
---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 include/linux/power_supply.h              | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f37ad4eae60b9..ac6d9992a8675 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -171,7 +171,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 		ret = sprintf(buf, "%s\n",
 			      power_supply_scope_text[value.intval]);
 		break;
-	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
+	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_MANUFACTURE_DATE:
 		ret = sprintf(buf, "%s\n", value.strval);
 		break;
 	default:
@@ -310,6 +310,7 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(model_name),
 	POWER_SUPPLY_ATTR(manufacturer),
 	POWER_SUPPLY_ATTR(serial_number),
+	POWER_SUPPLY_ATTR(manufacture_date),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 28413f737e7d0..67839bb0a46b6 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -162,6 +162,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_MANUFACTURE_DATE,
 };
 
 enum power_supply_type {
-- 
2.26.2

