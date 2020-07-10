Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E187321B1A3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgGJIvP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgGJIvO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 04:51:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565EFC08C5CE;
        Fri, 10 Jul 2020 01:51:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f16so2325506pjt.0;
        Fri, 10 Jul 2020 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5loYY1DFP5UkjOp2MofZRfLySKRm9AgxA86rY2bQ2kQ=;
        b=CaMVmCn4E46eYL7mObanXh4Wo8mBMWqFptcn5SIIj1syHPGj6xY2tNavIgxkyYjT6M
         XaGUE35zU6pEIQcaSKMXfEdJCEZsjN8w0zLBqgwO2q/83jbX22i3dya9uA2itc0PRfZ3
         ttBi2hJmjuokjq8jHyfZAXhhmIpyNGrDdRbXPCVR+xzmdodv+BBrqsEFuIYfqY5b46UF
         PyT0Cd2GAww2O22NVLY4U7HreGUu7FDCaD7/9IodULNOP/jjutiOlVFDkx/7N+DdLqUb
         A/2duUVX5oucx428v32Dg726Sn++yyGjjkwpmDPqXtGVfdZaGMsE8G4zhr+u/Er/FzUs
         JpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5loYY1DFP5UkjOp2MofZRfLySKRm9AgxA86rY2bQ2kQ=;
        b=hBB2i7j42/NzEgnMe/EgB1bcrN12eJXJTWq+uoe5syHXQliZOU7m+wTzqF4ZI7lmeu
         woHi2m4YNNED2Kdelm+MbowaN1tF9HnS1lmbcYVnFoWA5m0OaySaadk5zWKFM/WU9cV+
         co0zePNq05W9ZO5fisNp7Uw+D518xff+QLaxMJcRQUefmbfeZBqu+mXPva+CCktwQ5Qv
         PjqVEzSxgwy1l6NpEHecRCom1BuE1ZqPaP8N6q34Heh7T0XVudAubvwkGQKXma1IAaoV
         SpGxY2pzLDKnCr/x7OKs8DfklFutzjS2Sn6KqQJoJugkUNcXNrXycD9OK/LD92e+FuK5
         7wYA==
X-Gm-Message-State: AOAM531MbXe/JXQrFgZMZqbdktaiFNh4pkBSieFwi2VyuryKgydL1G5u
        q2rvTtZ4REA3Er5BYwrOxfI=
X-Google-Smtp-Source: ABdhPJyse+/5Om/D9N2zI+BL3zAC4DQKeDfsPND1rf1V/zNbcQ/xm1darMvWQXIXk7+Zp/vGmR1sMQ==
X-Received: by 2002:a17:90a:728d:: with SMTP id e13mr4786788pjg.51.1594371073943;
        Fri, 10 Jul 2020 01:51:13 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id e8sm4734273pff.185.2020.07.10.01.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 01:51:13 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH 3/5] power: supply: core: add wireless signal strength property
Date:   Fri, 10 Jul 2020 16:48:39 +0800
Message-Id: <20200710084841.1933254-3-yanziily@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710084841.1933254-1-yanziily@gmail.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

reports wireless signal strength.
The value show degree of coupling between tx and rx.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 9 ++++++++-
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 2099cf194a89..1f42aa0c071e 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -730,4 +730,11 @@ Description:
 
 		Access: Read-Only
 		Valid values: "ADAPTER_NONE", "ADAPTER_SDP", "ADAPTER_DCP", "ADAPTER_CDP",
-		"ADAPTER_QC2", "ADAPTER_QC3", "ADAPTER_PD" or other private adapter.
\ No newline at end of file
+		"ADAPTER_QC2", "ADAPTER_QC3", "ADAPTER_PD" or other private adapter.
+
+What:		/sys/class/power_supply/<supply_name>/signal_strength
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Reports wireless signal strength.
+		The value show degree of coupling.
\ No newline at end of file
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c864a14829ec..42fbe1b68255 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -208,6 +208,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(quick_charge_type),
 	POWER_SUPPLY_ATTR(tx_adapter),
+	POWER_SUPPLY_ATTR(signal_strength),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 2de9a4c93723..397fb8e96b03 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -169,6 +169,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
+	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
 };
 
 enum power_supply_type {
-- 
2.26.0

