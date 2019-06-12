Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0892430DB
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 22:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfFLUNp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 16:13:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37315 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfFLUNo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 16:13:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so7802698wmg.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2019 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A36/iHVaO3uEyS+d/EzeUq+RkDaMz832JoNltOURTBo=;
        b=pJZ/5d5bOCs+D/TMQ5HtKnIIGvOiYfkzCi/ZdmCXPovFoxtFlNW+znmeVJoNQ24uOO
         SP6bNoCNILq9tzyaj/oXNFP72q58wVj6ldVo7xeSZ179In8KmiNQUIL8XU2paluGue7x
         Q66eCs7deVGb04ErpjQlM4ZSoVDTf9QDkETW+J/XJ7bkdpTWNXfPsnhf0UC4pQJnbIuO
         bkXgtexgQBm6pOpdRJsuutM7+EQydWCkL8IjcPlTk8hjbUceGQMlIgamepIbUVHaQ0g5
         D1A9v2CpVNgp625F4yhbrH8LLw1kmqnefVhKPIN1l+ZwyYO5XiCJRPfsm6HCNkXLTRmZ
         df0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A36/iHVaO3uEyS+d/EzeUq+RkDaMz832JoNltOURTBo=;
        b=CTVKznb7PoUvfkndqwrdfDfIdnewoSxrueH8XJvx4Yc3JdWFPW4lSp1ZB2VLis9OwG
         0eEp6Yn0Gq8xJsbwgBq3mWP0esli85epWgrOGirXFdmE7I2pmwEzwh83fy9CAnkSZqxW
         PH+PiUoKywNte8Ada7joNyxsDEQ+ximh58d4Nd6adD3sKfA2LVSRCx7C0caT1SetYRUv
         bneiNvex5FUYpmdTcA3b2wbJekx3pucINbe7Vj7Ub/UlQxmjQiAEB1BphMN0frfat/ve
         3bjrS5cqA//v+R+mBBL4kBeiOnMTeO+l0t8fZr/KKZIML8OCfLPpv0JfSa69PQBH5AaY
         tk6g==
X-Gm-Message-State: APjAAAV+9vkfLwnQqHHCWZzD2xZz1Bm+h6aUL5QHH34pqzPWQPR1eGvg
        lYqs7L53ugXDebiV0IPINJ5+fQ==
X-Google-Smtp-Source: APXvYqy97vxFMTVImWGLO4fTpqCWE48n7WZKaiHLH+Xz2zXVaLq3FZO40hl85YzJRhdjmrVU4HFB7A==
X-Received: by 2002:a1c:343:: with SMTP id 64mr704892wmd.116.1560370422201;
        Wed, 12 Jun 2019 13:13:42 -0700 (PDT)
Received: from mai.imgcgcw.net (237.65.130.77.rev.sfr.net. [77.130.65.237])
        by smtp.gmail.com with ESMTPSA id l8sm1119566wrg.40.2019.06.12.13.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:13:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 1/2] thermal/drivers/core: Add init section table for self-encapsulation
Date:   Wed, 12 Jun 2019 22:13:24 +0200
Message-Id: <20190612201325.1150-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the governors are declared in their respective files but they
export their [un]register functions which in turn call the [un]register
governors core's functions. That implies a cyclic dependency which is
not desirable. There is a way to self-encapsulate the governors by letting
them to declare themselves in a __init section table.

Define the table in the asm generic linker description like the other
tables and provide the specific macros to deal with.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h    | 15 +++++++++++++++
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0df190ed82a7..be901e84aa65 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -15,6 +15,21 @@
 /* Initial state of a cooling device during binding */
 #define THERMAL_NO_TARGET -1UL
 
+/* Init section thermal table */
+extern struct thermal_governor *__governor_thermal_table[];
+extern struct thermal_governor *__governor_thermal_table_end[];
+
+#define THERMAL_TABLE_ENTRY(table, name)			\
+	(static typeof(name) *__thermal_table_entry_##name	\
+	__used __section(__##table##_thermal_table) = &name)
+
+#define THERMAL_GOVERNOR_DECLARE(name)	THERMAL_TABLE_ENTRY(governor, name)
+
+#define for_each_governor_table(__governor)		\
+	for (__governor = __governor_thermal_table;	\
+	     __governor < __governor_thermal_table_end;	\
+	     __governor++)
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f8f6f04c4453..8312fdc2b2fa 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -239,6 +239,16 @@
 #define ACPI_PROBE_TABLE(name)
 #endif
 
+#ifdef CONFIG_THERMAL
+#define THERMAL_TABLE(name)						\
+	. = ALIGN(8);							\
+	__##name##_thermal_table = .;					\
+	KEEP(*(__##name##_thermal_table))				\
+	__##name##_thermal_table_end = .;
+#else
+#define THERMAL_TABLE(name)
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
@@ -609,6 +619,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
+	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()
 
-- 
2.17.1

