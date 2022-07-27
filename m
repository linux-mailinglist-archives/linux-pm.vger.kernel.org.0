Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596F55833ED
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 22:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiG0UJL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiG0UJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 16:09:07 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F85F5B07D
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 13:09:05 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a13so20799984ljr.11
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJtun5NcNR5wLyutYX62IIiLTVDFy1hcC9gXT6STMk8=;
        b=XZtW6FVvaqmfalpx0q3HcwspGk2aOxr4ZIX759Vec0uZcWMN3UvIJP4v7oOSyem4KV
         dGssTb1ubfo3rpB+ZdbMkUMkemuYuXSFgC4ZVolkm+eBdzjsCzfdIue4h4zns1j6OqCZ
         vOYomoKyEhZ0IaRbpKm7JEshAe9RNzYfi8fPwXSeeDMKTZEKpj2X8WChDoR0G3SxsRP0
         MmZQpAW1zn0p4lctA+YdJUvtLaJ86pI+8W613zPeSRJF2ybzSCik0qQguFSSvguU39GQ
         B3CVa5LNF1dVHJ+FvUEE22LBsG528g7pIVSNpe0B6CxLQShQbAiiQRwrUEDO8dI8iNM2
         BT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJtun5NcNR5wLyutYX62IIiLTVDFy1hcC9gXT6STMk8=;
        b=UDPDuZmMTrpk2MFdLcbjYNhp5hk/Hp04xOhm9DG7wjDl1bgPBTfuHJbyQWdRISV3sT
         om1twU40ji1vi/P6wKTqoIq4b6UFE1F37t9mscKw1x5TcIO+OeT02BiZ39toeiTMMrPb
         uR3G2jC5mXTkcT2qOj8g/ru2DkJbWU/0t4wnB+kKu7mlrufLpJdS39bI4XOPwYRHuMLK
         yJiYDffy/PthBRYlHbIlvr4UwqWFwj8Bgvv6zHy8NiMkI6fHOx2ETqhWXyuD7LyQ4C7q
         tab0eZ+gpoJ+nr73MLwVxQHokpZXYE1YClcqAozdgA10KWlWmdEj2P323HUowLCrvP8X
         78Sg==
X-Gm-Message-State: AJIora8xirktHyswfhExD/rIuLtqMDE3gq0ZJ4RBjlVkpXE6ntOpOz2e
        6WWjrVPvdiXNh0e4Zf8i5Gs1hg==
X-Google-Smtp-Source: AGRyM1sfdGc2AXkd9v7L61hwgPs8XRui3lZKm4ip1NQ849VBvnGRnqYMpuE3luDBme8hNv+XItguaA==
X-Received: by 2002:a2e:8789:0:b0:25d:edad:f50b with SMTP id n9-20020a2e8789000000b0025dedadf50bmr8740460lji.86.1658952543402;
        Wed, 27 Jul 2022 13:09:03 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b9-20020ac24109000000b004870f517c89sm3961649lfi.33.2022.07.27.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 13:09:02 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] firmware/psci: Add debugfs support to ease debugging
Date:   Wed, 27 Jul 2022 23:09:01 +0300
Message-Id: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To ease debugging of PSCI supported features, add debugfs file called
'psci' describing PSCI and SMC CC versions, enabled features and
options.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/firmware/psci/psci.c | 112 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/psci.h    |   9 +++
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index b907768eea01..6595cc964635 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/cpuidle.h>
+#include <linux/debugfs.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/of.h>
@@ -324,12 +325,121 @@ static void psci_sys_poweroff(void)
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
 }
 
-static int __init psci_features(u32 psci_func_id)
+static int psci_features(u32 psci_func_id)
 {
 	return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
 			      psci_func_id, 0, 0);
 }
 
+#ifdef CONFIG_DEBUG_FS
+
+#define PSCI_ID(ver, _name) \
+	{ .fn = PSCI_##ver##_FN_##_name, .name = #_name, }
+#define PSCI_ID_NATIVE(ver, _name) \
+	{ .fn = PSCI_FN_NATIVE(ver, _name), .name = #_name, }
+
+/* A table of all optional functions */
+static const struct {
+	u32 fn;
+	const char *name;
+} psci_fn_ids[] = {
+	PSCI_ID_NATIVE(0_2, MIGRATE),
+	PSCI_ID(0_2, MIGRATE_INFO_TYPE),
+	PSCI_ID_NATIVE(0_2, MIGRATE_INFO_UP_CPU),
+	PSCI_ID(1_0, CPU_FREEZE),
+	PSCI_ID_NATIVE(1_0, CPU_DEFAULT_SUSPEND),
+	PSCI_ID_NATIVE(1_0, NODE_HW_STATE),
+	PSCI_ID_NATIVE(1_0, SYSTEM_SUSPEND),
+	PSCI_ID(1_0, SET_SUSPEND_MODE),
+	PSCI_ID_NATIVE(1_0, STAT_RESIDENCY),
+	PSCI_ID_NATIVE(1_0, STAT_COUNT),
+	PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
+};
+
+static int psci_debugfs_read(struct seq_file *s, void *data)
+{
+	int feature, type, i;
+	u32 ver;
+
+	ver = psci_ops.get_version();
+	seq_printf(s, "PSCIv%d.%d\n",
+		   PSCI_VERSION_MAJOR(ver),
+		   PSCI_VERSION_MINOR(ver));
+
+	/* PSCI_FEATURES is available only starting from 1.0 */
+	if (PSCI_VERSION_MAJOR(ver) < 1)
+		return 0;
+
+	feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
+	if (feature != PSCI_RET_NOT_SUPPORTED) {
+		ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
+		seq_printf(s, "SMC Calling Convention v%d.%d\n",
+			   PSCI_VERSION_MAJOR(ver),
+			   PSCI_VERSION_MINOR(ver));
+	} else {
+		seq_printf(s, "SMC Calling Convention v1.0 is assumed\n");
+	}
+
+	feature = psci_features(PSCI_FN_NATIVE(0_2, CPU_SUSPEND));
+	if (feature < 0) {
+		seq_printf(s, "PSCI_FEATURES(CPU_SUSPEND) error (%d)\n", feature);
+	} else {
+		seq_printf(s, "OSI is %ssupported\n",
+			   (feature & BIT(0)) ? "" : "not ");
+		seq_printf(s, "%s StateID format is used\n",
+			   (feature & BIT(1)) ? "Extended" : "Original");
+	}
+
+	type = psci_ops.migrate_info_type();
+	if (type == PSCI_0_2_TOS_UP_MIGRATE ||
+	    type == PSCI_0_2_TOS_UP_NO_MIGRATE) {
+		unsigned long cpuid;
+
+		seq_printf(s, "Trusted OS %smigrate capable\n",
+			   type == PSCI_0_2_TOS_UP_NO_MIGRATE ? "not " : "");
+		cpuid = psci_migrate_info_up_cpu();
+		seq_printf(s, "Trusted OS resident on physical CPU 0x%lx (#%d)\n", cpuid, resident_cpu);
+	} else if (type == PSCI_0_2_TOS_MP) {
+		seq_printf(s, "Trusted OS migration not required\n");
+	} else {
+		if (type != PSCI_RET_NOT_SUPPORTED)
+			seq_printf(s, "MIGRATE_INFO_TYPE returned unknown type (%d)\n", type);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(psci_fn_ids); i++) {
+		feature = psci_features(psci_fn_ids[i].fn);
+		if (feature == PSCI_RET_NOT_SUPPORTED)
+			continue;
+		if (feature < 0)
+			seq_printf(s, "PSCI_FEATURES(%s) error (%d)\n", psci_fn_ids[i].name, feature);
+		else
+			seq_printf(s, "%s is supported\n", psci_fn_ids[i].name);
+	}
+
+	return 0;
+}
+
+static int psci_debugfs_open(struct inode *inode, struct file *f)
+{
+	return single_open(f, psci_debugfs_read, NULL);
+}
+
+static const struct file_operations psci_debugfs_ops = {
+	.owner = THIS_MODULE,
+	.open = psci_debugfs_open,
+	.release = single_release,
+	.read = seq_read,
+	.llseek = seq_lseek
+};
+
+static int __init psci_debugfs_init(void)
+{
+	return PTR_ERR_OR_ZERO(debugfs_create_file("psci", S_IRUGO, NULL, NULL,
+						   &psci_debugfs_ops));
+}
+late_initcall(psci_debugfs_init)
+#endif
+
 #ifdef CONFIG_CPU_IDLE
 static int psci_suspend_finisher(unsigned long state)
 {
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 2bf93c0d6354..f6f0bad5858b 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -48,11 +48,20 @@
 #define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU	PSCI_0_2_FN64(7)
 
 #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
+#define PSCI_1_0_FN_CPU_FREEZE			PSCI_0_2_FN(11)
+#define PSCI_1_0_FN_CPU_DEFAULT_SUSPEND		PSCI_0_2_FN(12)
+#define PSCI_1_0_FN_NODE_HW_STATE		PSCI_0_2_FN(13)
 #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
 #define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
+#define PSCI_1_0_FN_STAT_RESIDENCY		PSCI_0_2_FN(16)
+#define PSCI_1_0_FN_STAT_COUNT			PSCI_0_2_FN(17)
 #define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)
 
+#define PSCI_1_0_FN64_CPU_DEFAULT_SUSPEND	PSCI_0_2_FN64(12)
+#define PSCI_1_0_FN64_NODE_HW_STATE		PSCI_0_2_FN64(13)
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
+#define PSCI_1_0_FN64_STAT_RESIDENCY		PSCI_0_2_FN64(16)
+#define PSCI_1_0_FN64_STAT_COUNT		PSCI_0_2_FN64(17)
 #define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
 
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
-- 
2.35.1

