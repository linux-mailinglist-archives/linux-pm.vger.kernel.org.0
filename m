Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCDB21CDFC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 06:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgGMEGE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 00:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGMEGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 00:06:04 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC2C061794;
        Sun, 12 Jul 2020 21:06:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b9so4942048plx.6;
        Sun, 12 Jul 2020 21:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPWSGdnxG/rBlzp5xQBwhrQ5NjyIF2qaf+KiNjPG/m0=;
        b=pIU1kfZUkSE/zCej70KlwIk0WwehP1/WFUeWBB4WFH4vIIULLDYp2o0Oeov2tfB0uZ
         B665MN244wDPTnb8q/CdhcItntjYs9jtz7MJfUxjVPDdjSr93NbJRskv1b/O2KZ30TTj
         5Y7WExgskLHFPtchxu8OC5rS2okpXDb0Ca8EQtDwGZrO+fzvC9rKvsf34lCeTLCjPOSx
         oWguLJZaJvh38CIgDLPHsRnM3KWiv0Ujh5+qC8XwjBfdz0aV4Uu+GjYeLMU0+CKWfR/H
         yMrXcJJCszDh6pvTRvlAQ3t1of8jFEQnzKBE/Od7n4EFsfYCAjBmniU9JBFH/ph8Ca2O
         x+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPWSGdnxG/rBlzp5xQBwhrQ5NjyIF2qaf+KiNjPG/m0=;
        b=BpZKzm6cmlc+SsGFB107pDfmnkz8EplCv9+oOQWDIEpDGpc8ipsJQfmFEFivBWh/I3
         nKQ/mY/HAJeewVhx55v3Y613xRQzDlQZiIghHG5s/PdVLHZyOd/xQ7e2QpDiWKVxBPU4
         PIU7XZ94rMWKNxDC/6hKyN/3gweQ0XV/ZoRI0IgqJWa7t7dAsgl1tEsh0EcrQU6eDYSo
         BmWEkdCdKo1MelM5rBzb08t33gvU8MJmt3fi91P1hPWzlGIPd3w4Z1mfPQ04QayHFQvL
         8MIgRmVa9fvtB2F3L/Y0BG2og9XkYJkw0BtyBF5VXV8riWXlS0BTAArGZxtnS5W37fik
         iu1A==
X-Gm-Message-State: AOAM530zQPls9J3kqLYQ19uTZnWAvcVLSexkg4BFNwaN+zIX6+/DEXXa
        cK8veZg5rExHegLs9VhRqVM=
X-Google-Smtp-Source: ABdhPJyfwg7muf7ApFRi4HQSEe1pzf/DdVxbl4AfLt7dnfrZdVLGHBxp+8jdFpR/KfOoo/5elXEqNg==
X-Received: by 2002:a17:90b:3755:: with SMTP id ne21mr17753598pjb.218.1594613164122;
        Sun, 12 Jul 2020 21:06:04 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id j13sm12561570pjz.8.2020.07.12.21.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 21:06:03 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v2 4/5] power: supply: core: property to control reverse charge
Date:   Mon, 13 Jul 2020 12:03:39 +0800
Message-Id: <64abb8036fdf8b694d296a4170cb5ac51248af35.1594612572.git.huangqiwu@xiaomi.com>
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

Interface to control wireless reverse charge.
Supply reverse charge function when enabled.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 12 ++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index f10780be2732..f4234ba1684a 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -740,3 +740,15 @@ Description:
 
 		Access: Read-Only
 		Valid values: Reported as integer
+
+What:		/sys/class/power_supply/<supply_name>/reverse_chg_mode
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		The property supply interface to control wireless
+		reverse charge mode.
+
+		Valid values:
+		- 1: enabled
+		- 0: disabled
+
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
index 397fb8e96b03..319bf6456867 100644
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
2.27.0

