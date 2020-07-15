Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAC220162
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 02:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgGOAiK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 20:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgGOAiJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 20:38:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7D6C061755;
        Tue, 14 Jul 2020 17:38:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cm21so702119pjb.3;
        Tue, 14 Jul 2020 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0+YEDfe3wI8x1UJdIu95ngNQLf6GGIEXN3WhvwT1qs=;
        b=bdgvJSkr/yFownjUmAmOUmMS/dnvrJl7S3A0zeVF/9fk4B+CCbHG41BQ8uKKp5xTUo
         5tY9Vip/GZ/8f2WUhStd+tNV3prueDX2F9P9rLlxwLXpSrkSZrLzxkllwST/xb7XhSUN
         0Rouwc7By91KswhFHJ2E+gM4GShl3TMamzcCZ1OFO0ISRbewZGhoKCXNbbWdcIJLteG8
         PDCgqQ8W/xV1AMa/tbjFBfrKsH9SFWq1nFWh0GObETNA8WAIvgj/lzimufOolSA1nzZz
         LteXsPsH7D43WYEyTQi/ROOwkZX+UDEY4B0m5JqncEvl04jTfasvq/lf8yJdkfhpLZ/u
         jO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0+YEDfe3wI8x1UJdIu95ngNQLf6GGIEXN3WhvwT1qs=;
        b=f3wm7Z+vYCuXNq7/3azmL/kC7lrS2KJB8UO0f9TI/MYui5il/dZnzLy3gGX/NQY1yx
         08ihJyKp+Tg6IpiooEU5NYV5UcPoPq3XHcGi1Vb9wUatmGqhoBdbLcBi1RQ9+hVtbfEV
         OoxiNxJc/Re9dsmj4fLpKuL47q8RMUDXDILZxD5w+GdFttwx5rQTmlYECiXf8NYgE7Nz
         LHkHvF3/MTPV7BsCO3mlSMeie9p/hG0knHt5otKPZRiMhoCYT68TjEC1hkV+/A2eSWOS
         h2peolG/3UxngtphCHZuzJHdKgdJt/rJlkDOJTjk+JQUD5uSm7nNvFE3US4lpEAgeVNx
         QAUg==
X-Gm-Message-State: AOAM533l9jTDzkw/lHhLZnm8E1VR4oxRjI7clb+jf73WHnN1y/Cr2UfE
        ChgbX/5ErPVuGtUblesnD1i48tK12B+HwW2R
X-Google-Smtp-Source: ABdhPJzUPOGPru3NVFp3iyz46NiO6AIG+9uLfHIBvCSsklAQbvc1+uJqbRkN3cL+vihDK6CrvucJxA==
X-Received: by 2002:a17:90a:9ea:: with SMTP id 97mr7362596pjo.8.1594773488945;
        Tue, 14 Jul 2020 17:38:08 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id t126sm266156pfd.214.2020.07.14.17.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 17:38:08 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v3 5/5] power: supply: core: supply battery soc with decimal form
Date:   Wed, 15 Jul 2020 08:35:23 +0800
Message-Id: <7f59501fb0566895ea8d6656010c52f2a6a18ef8.1594726859.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594726859.git.huangqiwu@xiaomi.com>
References: <cover.1594726859.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Broadcast battery soc with decimal form.
soc_decimal is the decimal part of battery soc.
soc_decimal_rate is update frequency of decimal
part of battery soc.
We want to report such as 0.01 to 99.99% to
user space to improve user experience
when do very quick charging.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 25 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  2 ++
 include/linux/power_supply.h                |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 54647d6995d3..5e0bba3e1930 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -349,6 +349,31 @@ Description:
 		Access: Read
 		Valid values: Represented in microvolts
 
+What:		/sys/class/power_supply/<supply_name>/soc_decimal,
+Date:		Jul 2020
+Contact:	jiangfei1@xiaomi.com
+Description:
+		Broadcast battery soc with decimal form.Battery soc(0 - 100 percent)
+		is fine grain representation of battery capacity.
+		soc_decimal is the start decimal part of battery soc.
+		For example, soc_decimal value is 30 for 80.30%.
+
+		Access: Read
+		Valid values: 0 - 99
+
+What:		/sys/class/power_supply/<supply_name>/soc_decimal_rate,
+Date:		Jul 2020
+Contact:	jiangfei1@xiaomi.com
+Description:
+		Broadcast battery soc with decimal form.Battery soc(0 - 100 percent)
+		is fine grain representation of battery capacity.
+		soc_decimal_rate is update rate for decimal part of battery soc.
+		The value is depend on charging power. Soc decimal change faster
+		with larger charging power.
+
+		Access: Read
+		Valid values: 1 - 100
+
 ===== USB Properties =====
 
 What: 		/sys/class/power_supply/<supply_name>/current_avg
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 81916b6b6ccf..a837addb4f21 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -210,6 +210,8 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
 	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
 	POWER_SUPPLY_ATTR(REVERSE_CHG_MODE),
+	POWER_SUPPLY_ATTR(SOC_DECIMAL),
+	POWER_SUPPLY_ATTR(SOC_DECIMAL_RATE),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index a87ae1fff8d1..71e7c8010bde 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -171,6 +171,8 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_TX_ADAPTER,
 	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
 	POWER_SUPPLY_PROP_REVERSE_CHG_MODE,
+	POWER_SUPPLY_PROP_SOC_DECIMAL,
+	POWER_SUPPLY_PROP_SOC_DECIMAL_RATE,
 };
 
 enum power_supply_type {
-- 
2.27.0

