Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D016028AB2C
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 02:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJLAJv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Oct 2020 20:09:51 -0400
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:31041
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgJLAJv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 11 Oct 2020 20:09:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0agqJSTifV9C1/8KFK4v1W8jQzxObniI6nrIx66t1FXxAydTn8sM494VjHqr0rz5Tzq6aaDnoQeQWoN88WF0iy912RT3oLZEWqjokpRIHPqovk++8NM91pwGerCpLWYG0VsMZyiKg490rAZy48vCdD0DdFecL3mOCiTLFifCEaNbG5eBgpK6tQ/1yOBL21rUtsxobiNOD8feRrllI4+wqI77XEbZcMQLTc7FpvsHx7vmKTT7b9GHQvUIwdiwmFEe5Ml7VEnpqbNgV6Y0OOq7DvJvyghsffjZ7IfvdTjsj+FLnvvAQIYZMkDtLLweGIIEr+r8rALM99SSahBTJ2g5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zKdzI18byw69s+Y0+oBqTxtqs9ams5oeFQZ51RFsgY=;
 b=ad68PRsTC9ys2RjttAGi3j/LV6RnLHPlchbiK/T7wPxaRyKOK1+Ptxdq6XKMpop2m+PjyX7pbkpw6A/KY+JgrOyuqFv6GvyepkcDiYJAHNJl9PxEGs/D1HDQf3X5E2HYO88RgjwW8oxUhzIYvBfgz+Rv3O8jjCM7WyZNsvLTXGnRQnscEwZJNij0kYIgu1CMbbyxmkFk19oW2/zpiTSzu8j4VqSrbZKUz/bxZuYbMrKD6NOQ8SpnmfjyFu/eurp4hziJrReRDE9+iOeo3SFVa3AzpTrzhntpgUWHp9LidElCTu4LMvzvlAUugIPNtvHu2qahhzKx2niU7NdX2hK2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zKdzI18byw69s+Y0+oBqTxtqs9ams5oeFQZ51RFsgY=;
 b=iMwiKc5jcdfduMbwmYJkx4WowtqtxUXkUjgC05O83N52WTeUTmm6QP/mlm6cVtz4COxpHQP43tef5yCX5T78c6dYeH+YADi0Vll5wpsAuW17FRI8/uFxaRVC4lBnWmJuPWxBGTXy9ceMxTk3zQb6Eo0zy5cgUM0Au67kC4a6L9I=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB6111.namprd08.prod.outlook.com (2603:10b6:805:100::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 00:09:48 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::c989:9cea:baa6:8254]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::c989:9cea:baa6:8254%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 00:09:48 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH] PM / sysfs: Add the ability to call PM operations manually
Date:   Sun, 11 Oct 2020 19:09:24 -0500
Message-Id: <1602461364-17300-1-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [136.49.227.119]
X-ClientProxiedBy: SA0PR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:806:d0::17) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.227.119) by SA0PR11CA0042.namprd11.prod.outlook.com (2603:10b6:806:d0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 00:09:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1c8f83c-d06b-491d-1bff-08d86e4321d4
X-MS-TrafficTypeDiagnostic: SN6PR08MB6111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB61114D762ADD322F88779EE1D3070@SN6PR08MB6111.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g18HZ4s39VY75dAJX4jmXuYivKjAYUbrwCjbLbQFxZXUKfLdTv9xaXkgOMs84ZhTGnV//WTi64SCgWQD/LQPk2cOtB/DOCbbf0yz48vybzz3OocPIRVxsmDxWeSfBfu+KrReDVj6VHwNYd/msiT1m6BbBTMbqCpsLIt/vt4a8r9iv9JVAyXGosTDhx3unjWfvqdJh+fzudSfJnFa2zvHu+gziM/z1X8umhBqfGAFZC04x5FeTl/4pJHHwGFqnMEE7p/b7cVQ2AjgxFFSkw/LgJXtWf7H2SVRDXjYWN7Wq8PRg5s/gSLIMfCRKuhCvK3Syj+4ScELOsdQzg/Gfn3ISLdfjHsWqRdQggQUt9G7urZxTXBMSFlMVS60n0kJF1zr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(346002)(39830400003)(16526019)(26005)(6506007)(66556008)(66476007)(66946007)(4326008)(86362001)(6486002)(36756003)(478600001)(69590400008)(52116002)(186003)(956004)(2616005)(8676002)(8936002)(2906002)(316002)(5660300002)(6512007)(6666004)(83380400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VOmjpc/lEXXZV+8+KM6SxI02CGbR2fb4E2Br8dwBZqJQ/snF7DBCp9S3k2y+h1XoLHeQOw5iCsZbchRv8ALOkNi5ybJRDgptJzYPYR2m/IlwSy7bIl6yklDwlSPlCQGj0Godszgf2yMqSKqMh99PcVqzrkbGIVvTZTw4ad5FK/OMpvJnrT6zC8Hb0uqy2QTi5f6iLQarzz8iHTbfQehzxh37uDfi5YeMBijsmx3jgzQExT1J52nLUL9r1CspF4EXQh2d6XsImxoIp8h9rnbSkRJa7ozfpuBY2Zb+D5OM+m5RuJYCRGdrN0jL4RWhYUlHbI1aSOJFIB7bs5NfSWKSDsX87ie2+zn/chmvHqaka9znQazod4eADh+9sCIKbugoSwVGdFWXs5DNLsPNryMqd4FZ2jMa9vlPuiObuskDPfBmsq5wEjNlqrhvoCVichUTNkjtLExgLiYa/rhuyKpewthI/XR43NdYSPVv86XVMxprDMQjwBKrYS/N5bWYS2gTa5JhRIrwzKQ6eIUPTkgkkHg0mpBZcC1KFYZBvGfCWDKufpbRrddXh9dvzzXXEcqvpt/qdEEaoD1uaAi3kjB+/uLmFJ0BLix2EifVTQfoFPaT3F+/UHbAeSnG5gz/u3wvj1UeTsusMsQA1RpseQKVgQ==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c8f83c-d06b-491d-1bff-08d86e4321d4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 00:09:48.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mgle8AQImEoTFYzom2qwjLCbF1n9B6qc58NcvONM4lrC0x26EHHtPhgmlocNf8YawBGJxFzv3DoAxeRzhV7jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB6111
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

During driver development, it's useful to be able to call a device's
suspend and resume operations for test purposes without having to
involve the rest of the PM subsystem. Such an ability would be handy
for measuring power consumption, checking interrupt function, etc.

The PM subsystem does have debug hooks for limiting the scope of
suspend or excluding devices that shouldn't suspend, but there can be
overhead in configuring these hooks that is often inconvenient during
early bring-up.

This patch introduces the pm_op_test attribute, to be used as follows
(random I2C client used as an example):

1. echo 'suspend' > /sys/bus/i2c/devices/1-0044/power/pm_op_test
2. Measure power consumption at one's leisure, check wake-up interrupt
   behavior, etc.
3. echo 'resume' > /sys/bus/i2c/devices/1-0044/power/pm_op_test

Nothing is done to check or report the device's state; as such this
new function is conservatively guarded by CONFIG_PM_ADVANCED_DEBUG.
Only suspend and resume PM operations are included for now.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/base/power/sysfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index c7b2481..78ee6f1 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -77,6 +77,8 @@
  *	attribute is set to "enabled" by bus type code or device drivers and in
  *	that cases it should be safe to leave the default value.
  *
+ *	pm_op_test - Call one of the device's PM operations for test purposes
+ *
  *	autosuspend_delay_ms - Report/change a device's autosuspend_delay value
  *
  *	Some drivers don't want to carry out a runtime suspend as soon as a
@@ -571,6 +573,27 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RW(async);
 
+static const char pm_op_test_suspend[] = "suspend";
+static const char pm_op_test_resume[] = "resume";
+
+static ssize_t pm_op_test_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t n)
+{
+	int ret;
+
+	if (sysfs_streq(buf, pm_op_test_suspend))
+		ret = pm_generic_suspend(dev);
+	else if (sysfs_streq(buf, pm_op_test_resume))
+		ret = pm_generic_resume(dev);
+	else
+		ret = -EINVAL;
+
+	return ret < 0 ? ret : n;
+}
+
+static DEVICE_ATTR_WO(pm_op_test);
+
 #endif /* CONFIG_PM_SLEEP */
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
 
@@ -578,6 +601,7 @@ static struct attribute *power_attrs[] = {
 #ifdef CONFIG_PM_ADVANCED_DEBUG
 #ifdef CONFIG_PM_SLEEP
 	&dev_attr_async.attr,
+	&dev_attr_pm_op_test.attr,
 #endif
 	&dev_attr_runtime_status.attr,
 	&dev_attr_runtime_usage.attr,
-- 
2.7.4

