Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369DE21B19C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 10:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgGJIu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 04:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgGJIu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 04:50:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA706C08C5CE;
        Fri, 10 Jul 2020 01:50:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so2325213pjt.0;
        Fri, 10 Jul 2020 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1Gy2eiFAZUsA0x+FgKlCID6twmOuqr8i7CzwffpWkE=;
        b=YMEoCXhbONmYXGteam6ihuw0Z3Xht8zt/UHHs4d6STQ/sw/oVvgSV2EUsRijCqkE+d
         SzRBtkbOGq2Bg9zMbslDIjUYYd+4/xe2+DYDJeeLe8HKMAV+xf8Eqpzea/jMed4Li7n3
         W8VuD7LjkR/x5WD3fnqP5dCM5rQLco1KEF1h1Xk4PTr4I6dpU3DSPEzT8jCrxCLHJCPs
         G+j32WVs1VgnzoycZHCL5tm/lOqNuQmHwsb28cptUQFu2Tg4Vycuord1q2o7NEJ25yKo
         jFoS64xFaDh36fDCbyZYEibOB4oDNf2SeX9XL3t8tGK1QT8JVhZnhqDRpSQ4L8t4Koli
         pLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1Gy2eiFAZUsA0x+FgKlCID6twmOuqr8i7CzwffpWkE=;
        b=ioxlOHd+7CXwAoyRW9mfbrnHRCcAqLXdIRFufaUSjuRX1i6/f0JAgSL9XKPRJk3Ds2
         HUzfLBqRmGsS5eh58StZCayizkAm65n7+tbAA8JRg6cbUH0JHBuvT2dU85vQceQ+urwo
         P43hUx5/ItYWV3ZsqULCEB5GwdlYPjEXFptB1zLjzdZyHkaznpljuZZnyvY3QtJ10g4b
         IVwnrFnzqezmfO/aAW28M9ZPIejWLteSxW8QVv+kc/VrfssLVefcCYCfGUe5jbXcCR2H
         I/G0KgS7Vsleh3XKECGfEsZREYm2pxhILlRfzBNZjgb37LahPV5JdCP3enwZ7k7kp962
         0UTQ==
X-Gm-Message-State: AOAM530qGjUq39B9M9/d2oIWNFvmeS6KMw3o+/h3/IuxBjO7R7iO8Dku
        /VM4afluOSVYI0fjUXX77lpJB247+nH+9os/
X-Google-Smtp-Source: ABdhPJwuH2Qbal9KCQ70qLDfauQOaG63rmpLbMo9sMs7+9JNBZTrpxQig2pbJ3HsyacG9FsnFxBIyQ==
X-Received: by 2002:a17:90a:26a4:: with SMTP id m33mr4665951pje.124.1594371057316;
        Fri, 10 Jul 2020 01:50:57 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id e8sm4734273pff.185.2020.07.10.01.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 01:50:56 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH 1/5] power: supply: core: add quick charge type property
Date:   Fri, 10 Jul 2020 16:48:37 +0800
Message-Id: <20200710084841.1933254-1-yanziily@gmail.com>
X-Mailer: git-send-email 2.27.0
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
index 216d61a22f1e..0d9d6b46e239 100644
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
+		Valid values: "QUICK_CHARGE_NORMAL", "QUICK_CHARGE_FAST", "QUICK_CHARGE_FLASH",
+		"QUICK_CHARGE_TURBE", "QUICK_CHARGE_SUPER".
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bc79560229b5..f95574c41898 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -206,6 +206,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
+	POWER_SUPPLY_ATTR(quick_charge_type),
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
2.26.0

