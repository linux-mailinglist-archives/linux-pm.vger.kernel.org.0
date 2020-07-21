Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2CC227E97
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 13:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgGULR5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 07:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgGULR4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 07:17:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542FDC061794;
        Tue, 21 Jul 2020 04:17:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so10106444ply.11;
        Tue, 21 Jul 2020 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAZYRb+PrT/mXje3lSf2lwL9NTMcJfHXcPNcCCFolq0=;
        b=eJZ+wtCSbRIvnseSEtGo2MZwqqp8APM6zhcCvthu1ZunI2+KwylYL63f9hFBtsZXKw
         YQhHSyW0/85KOKcifPwWZ/wuNjupYSE6lIQOvH37DJIHLk1XZcrkB3rSszbzXKVX+CIY
         Ny7E8fR5jIgfPqSZ7vyB+HuvGIOLPilAHhLlVedCY0tTagGqm0V38Y1oP0tsSnVeAj4R
         iInCHcSZZkt87xO/1Mh7+YrZ5VE7YvpV6UqMWHk41mZAxJt9x9i9Rnh+gTSExZMcAZLV
         ho2CeOQyrKV5mUtB1tFngD1D/x/DI8BCcNJTIS2uUc/p/rarx90s+aoYqjRkSWVx9cgx
         VQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAZYRb+PrT/mXje3lSf2lwL9NTMcJfHXcPNcCCFolq0=;
        b=k4npeVKRpKWhDEnd2+F7y2N7ovJuecC3QiDuyGeFpYAQ+kpvW3WNy//OnFh8AqHsv8
         jM0z9j0wEMD/2LiPIA6bPwpM2WbruS6UQl7fjWZDJtl5MpXGtMVl8Vhex+JxWpEcGWm6
         joeeEDkeQb7fy24uB1nzLayXh3Sz2fzY94ld096me2D7J6khZpYD8IiYXg0h0Ft9pDZP
         ohzFMyOusMun771sM87CKmLkGerabJUJD1mXqvIYC5GZfgUZdDSs00mxCnaG6BR5cx/U
         v/s3T7g0ij55cOQYEV3Eyrcsp+7NbQ2qFlhFvEoHTJcJyTFlmO5L7QWwLqchkJKMzOOR
         SbDQ==
X-Gm-Message-State: AOAM533HWiWYpqyzzOazaeMLxCtuUXcVqfGsd0wliKSh38X61nD27DsC
        abQVfXu8taAeoPwATN0khWI=
X-Google-Smtp-Source: ABdhPJy/7uWhm2LunK8Yvpsk83y190X5APryCDRRX2MBXSWfQLFqpwQoPihUsYIX2kPq6cO9f7SZxA==
X-Received: by 2002:a17:90b:1806:: with SMTP id lw6mr83328pjb.236.1595330275952;
        Tue, 21 Jul 2020 04:17:55 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id f72sm19829566pfa.66.2020.07.21.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:17:55 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v6 4/4] power: supply: core: property to control reverse charge
Date:   Tue, 21 Jul 2020 19:15:39 +0800
Message-Id: <4be88d40096623f9e6c498880db0cb3c8fe057ff.1595329640.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595329640.git.huangqiwu@xiaomi.com>
References: <cover.1595329640.git.huangqiwu@xiaomi.com>
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
index 346c6c9c0737..a87ae1fff8d1 100644
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

