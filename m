Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30638227877
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 08:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgGUGCA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 02:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgGUGB4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 02:01:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC5EC061794;
        Mon, 20 Jul 2020 23:01:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so11448562pgb.6;
        Mon, 20 Jul 2020 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rt6OILtoXvarYoblULhOIeiZp6zLUqn8NzrZ6DwL+ac=;
        b=kT+OXrwkEGS0+Ojb/6qOa0SIOtWehMYks820nIZ3eTq6LzaNnAWPJcH9KdSIIsxZC3
         z0etdpEAxLgyi8c9Wbf1aPs792Dr3yWd5BbSdqI47OiY8ozyZgY5clhT2qRswVlmOPOC
         aRPjEu+3v28+UMIjrR9kZMVVtIsb3EbOJwhZqyer5kejhjzL/PfJ1CuMRJ/OUP7+MLd4
         MUmrNxp0hE3clKfk8UJi0obw2MSli1Q5rrrfbabL6eu5iP/yMQrK5FNtVsF1JH8M2g1b
         ceA4TGoqPFPSY3jG1u6Z62pBna1qKLGPGZRBXLFD8zXYyAbOONzRcNuYeqd0dvWWbyzM
         +bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rt6OILtoXvarYoblULhOIeiZp6zLUqn8NzrZ6DwL+ac=;
        b=b2Gl0/cg1+NS/xqK28QqeSfb4rik7ir54C+VeQT0wXP54qgJh5Tg173jU01B8NaP/m
         QGJkwNSxe8G4aQCpinDn+FRgJb1BsTgG/hsQFyigVGBWoYhV1MXqc0zfzv9qnW+5I2J/
         n4cezs3rO32xlkhoVw90WkOaI7BOQDVsFzxlH+bRTO+TyfbnDHAJQnqUTv+AXkOEvxA8
         QR6wfWqTctVdktyhFnuZ6e+BgoZfCXU5/67uO8wxbpmlrZkmZU0H1SP1em53q+yDQZ7J
         N73z7DeNRAyXeg+ZjD6BTW+1/pvk2Sfc92gFxjcIc2jSg+pPv44AaYlsQXweURT1n6TC
         XYyg==
X-Gm-Message-State: AOAM532szm/v+ZBQ6HWfdKOEezroGiPIhB0J/JEEX3dbrJY00kwCjvkM
        G6Zyk9gzg4gkXzMWvb/p1BiKzmVv9RQCZw==
X-Google-Smtp-Source: ABdhPJzqvv70WYZkewPWyfP2lxpv0JLD+3Vxc0VZjOuKJHfuIExbVjRQYwH65ivzf4nJ0AJWURjBUw==
X-Received: by 2002:a62:e206:: with SMTP id a6mr22659012pfi.24.1595311315868;
        Mon, 20 Jul 2020 23:01:55 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id 129sm18368833pfv.161.2020.07.20.23.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 23:01:55 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v5 4/4] power: supply: core: property to control reverse charge
Date:   Tue, 21 Jul 2020 13:59:37 +0800
Message-Id: <f58e4cc6f5235d463d96c950f2af2b9a47920e9d.1595301250.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595301250.git.huangqiwu@xiaomi.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
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
index 75ec7de2fe78..54647d6995d3 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -767,3 +767,15 @@ Description:
 
 		Access: Read-Only
 		Valid values: 0 - 100
+
+What:		/sys/class/power_supply/<supply_name>/reverse_chg_mode
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Some phones support wireless reverse charge function which charge other phones.
+		The property supply interface to control wireless reverse charge.
+		If enabled, start TX mode and detect RX. Disabled when timeout or manual setting.
+
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

