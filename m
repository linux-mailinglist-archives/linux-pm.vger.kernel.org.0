Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20E2443FE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 05:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHNDtX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 23:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgHNDtU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 23:49:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03847C061757;
        Thu, 13 Aug 2020 20:49:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so3567417plk.13;
        Thu, 13 Aug 2020 20:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPTjuwCthUmMjgvx3f4uFfhVGWQpGsk/v4Ea0sfsyl0=;
        b=hAKgRkSH/6PMrPtIMt5D/2HyLgw1nx1w8QsuOtGxkorVAlvocHGDgWeB3uwEmDCmdH
         ZO5ZmwqRef9KFkTVvhJkxF5UEhbI1LoQRoISXYGEzpdN7Vx1RnnnAD517/SfocQjZghS
         9q3oFlOi1ON1PDdC3clmkLQcPDoJ8hW6fMSDXKgs83xrf4usH8mx0RaEUHCjWaTprDtZ
         CIFjeF6Kefk3qwouAJId+o2WI9Xw13IErzQBc52oXXS9a7BPYvWg1FKPgZG+1KnU1a70
         /zvtxMsDQRBj/9SXUgHMA5MrOz17YkUsv5qnRjdi83NwZOfoVlJmKr1H3zobvisHJJvd
         NrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPTjuwCthUmMjgvx3f4uFfhVGWQpGsk/v4Ea0sfsyl0=;
        b=sPJhHCWcTAZd6YlQZzdad4+AvUsjkXKcrnF5cPX97izv6kBCcA30Y/XiwahX0W08wi
         3Szg1/svMhmGaxMg987w9GhKJsYHPd1F6wgcffgmKVE61vSAeiuLOurfLcmxtTxHwHon
         P2zF/rQIcLu4J9lU7YnE1cS4MEYn+B64++k+YeHIO30SVNBNA5LOAdDT8SFc8uSmg7nh
         H8v7e2/lq70lDtxCzJbYCvdj6IUd6fwEhQbITAyVEZapdHpSJVuDnQpbiZip5uXb+CZl
         0d+/jrzALPNCSVsW/eX6wjhUthn/7zT4rwM1dRLuEURm1/KIYyhHimTKf0GzyEOd8koG
         KbTg==
X-Gm-Message-State: AOAM533J7HL5PRvx0AmT8FbTcFbLv93wI80sXi0LKOWD4b1yZs7x3Znc
        TpghXy1gtRQxSpoSKVIfuBs=
X-Google-Smtp-Source: ABdhPJxjQHL0mKcWYfxZ3F3tQhatvGe4Ll3O6vfmxy6A9yrK1Mu16y8GRzXlXiMDTdealruB4F06Xw==
X-Received: by 2002:a17:90a:c58b:: with SMTP id l11mr677696pjt.195.1597376959558;
        Thu, 13 Aug 2020 20:49:19 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id n26sm7253385pff.30.2020.08.13.20.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:49:18 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v8 4/4] power: supply: core: property to control reverse charge
Date:   Fri, 14 Aug 2020 11:46:57 +0800
Message-Id: <9cc6413e866cce78d9d2612b5f71276abbde57d7.1597376585.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597376585.git.huangqiwu@xiaomi.com>
References: <cover.1597376585.git.huangqiwu@xiaomi.com>
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

