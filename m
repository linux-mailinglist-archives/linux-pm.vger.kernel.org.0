Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C699325122E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgHYGkU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 02:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbgHYGkR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 02:40:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C45BC061574;
        Mon, 24 Aug 2020 23:40:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l191so4026660pgd.5;
        Mon, 24 Aug 2020 23:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPTjuwCthUmMjgvx3f4uFfhVGWQpGsk/v4Ea0sfsyl0=;
        b=WPjjoCq+eG/jacxw0fg2TjSSg+WH2qd9qtOh8QHCFrnYLd3PAxB9gGVpOGIj7++dxP
         HwS3D4HBpmVEypbh7z1GKn03/lmjFGPFRj5U1DTGZM1lDP4szKeMJkLiHR59EFPZEiug
         Tzgfl5QfBqr/936EBhajsGoBWIJkFKmo3cTDcKMFKjpM6mPQZZlD7wvTQrFD0U0jHLI0
         lyj8TqGBghmq5CjleenqJgsHIO7pIbXjgbgF88LcnNOcPIj5IxHtwBgvxQP0CBeu3FNy
         D8biLNpmjUwYJ85GXI84Atz+TxzUxIfFMHstOWhBevRYoaF8r05x1DhRN0DRngM5QtHx
         6fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPTjuwCthUmMjgvx3f4uFfhVGWQpGsk/v4Ea0sfsyl0=;
        b=KMMRw56Ji1WildJY/FVu1agLOqGRMp9LNibO6YbyRGdtyqV1aswGqtyRNyBSrbKZ8h
         xy2znbbRR1yn7FQMHWT6garh2O3DR6jSA7nWiA0RjrWJEKOvEPsfYTKmlEagUCzHojIS
         fw/dVl5zpHKWxx+xZQ2QxFKWIe/BN5LIZSed2ReezAGzVMHZVatMoQCCHxzD8+l+YAQV
         Qyzxy5L6Xtiityg8sQ2f9anfZTXJc3VnSxT22F6LZGXMSujornM5BF0mD2QI9Ni9DTQH
         CY1qMGpx4vlEVmGODg6TiSgRx7LiRSvC9OM653aM1oNpzpdGaLLEKSv2dQZRHAIdGNiL
         6PtQ==
X-Gm-Message-State: AOAM530vEHbdaP9UiB6nFpoOcFBm9ZNfSHF1pc2X7pt6bpCV6JJ3w3SO
        aNdJ4eXgDGG/4tb3Jf9rWCh5FxFalmBPbw==
X-Google-Smtp-Source: ABdhPJyaq/aiNW3XYF9jYLOs4N4aihEAEXilSmW5U5Zqa+46msSb8mpneLfXg8ij+FdWScxpvDBLaw==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2mr6317259plb.4.1598337617019;
        Mon, 24 Aug 2020 23:40:17 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z2sm14197283pfq.46.2020.08.24.23.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 23:40:16 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v9 4/4] power: supply: core: property to control reverse charge
Date:   Tue, 25 Aug 2020 14:37:59 +0800
Message-Id: <34d9921bc92f99c9ee680b4b090173c9c08c6e09.1598337073.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598337073.git.huangqiwu@xiaomi.com>
References: <cover.1598337073.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Interface to control wireless reverse charge.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 14 ++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 4459b720feb2..8840fdf483a7 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -779,3 +779,17 @@ Description:
 
 		Access: Read-Only
 		Valid values: 0 - 100
+
+What:		/sys/class/power_supply/<supply_name>/reverse_chg_mode
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Some devices support wireless reverse charge function which
+		charge other devices.The property provider interface to
+		enable/disable wireless reverse charge.If enabled, start TX
+		mode and detect RX. Disabled when timeout or manual setting.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index e420a453095e..81916b6b6ccf 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -209,6 +209,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
 	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
+	POWER_SUPPLY_ATTR(REVERSE_CHG_MODE),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 747338118fa1..988d3f05ea1c 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -170,6 +170,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
 	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
+	POWER_SUPPLY_PROP_REVERSE_CHG_MODE,
 };
 
 enum power_supply_type {
-- 
2.28.0

