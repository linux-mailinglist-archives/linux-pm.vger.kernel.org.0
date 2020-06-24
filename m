Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A172207143
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbgFXKd0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 06:33:26 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:27279
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390430AbgFXKdY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jun 2020 06:33:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/NYUBKxBJRSFdGXUsWIucmX1jLk1lmYy8uI/xV1dgqRmqyABRZ4d19OOyEOd62PsmGsS00EV3Mp0Lu44OX5v+hbzXlWJQvaPskRzTICDPBkmXFYQ8sw6a8fq/8AqqSgdRDlQ5Xlp44sIB1wZOQ9aRuHotTjW8QLx0HWH/G07/Hcd+xcZ7HbHBSdwwHKw09gVoxY+a5Bnj9uW/EQt2oCz14wecWh/afPgtbeaFAjOFIGHZIAc3x7tAx7k4PlbpOmJyYGCjseD3DkOoCkTnLma+Exv5lcooEc4eMrJjF0KUW7zm4hbRYoLE3Xiwdpc8MKNeUDgIhVgYxSaVgGCX2y7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/gLNWHJBFdPe+yK6SdEdcGlZQH9DOx59u4muZL5sGg=;
 b=dX8+2MAyw7U7s8zRp4njQYhvL7zmkLRPs0VjZhPaS+8AUwwV9AHQ7Z/8DG9qD2DUlUYJu2xFxbkxPfv+06e4ARbGqq7daJtaHarZFCP1zWxhE54RpeiLJTzNwnprSryCXDe1igchsWMhf0GP9+kmRJyLXJhlmHlxNO2SBB1HbJhPKv+BVa18krD4NLPMCdjjqE7B/27vdJCYwEiEj3UAXwIH1+Iyr1ATW9eQldFvoVSxkCgUWaSxTJxUQQlx+HBFCotm//z/40Cv+Uj/z5fZWysCn7ZkQl6MhbsKrrxqEdv+mk60mtQsM24bx8pXCp3Df1ZXqcsX9A9dqw8EMxhqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/gLNWHJBFdPe+yK6SdEdcGlZQH9DOx59u4muZL5sGg=;
 b=gcJniOqq11ZYv5Qz9UtZtyrmmI8JPhukxcfp3CyhvAJbxHdyZd188pulw3elVcHfVpuJgyraXMTPDlubJFHGJVnMDbO3PmSLhiflUFPTc9T0wpytMoVeiN9KkCJT4tKZ4ibUNLRfkVIEr0CbWG23y8idj3qzhQM5TsdImgqsegg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR0401MB2445.eurprd04.prod.outlook.com
 (2603:10a6:800:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 10:33:17 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 10:33:17 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     khilman@kernel.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        alsa-devel@alsa-project.org, linux-imx@nxp.com
Subject: [PATCH v3 1/2] PM / domains: Introduce multi PM domains helpers
Date:   Wed, 24 Jun 2020 13:32:46 +0300
Message-Id: <20200624103247.7115-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624103247.7115-1-daniel.baluta@oss.nxp.com>
References: <20200624103247.7115-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::41) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR01CA0100.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Wed, 24 Jun 2020 10:33:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbd7c576-94c3-436f-b529-08d8182a01d8
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2445:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB244572BD8963332DC64788F9B8950@VI1PR0401MB2445.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIURNGWJ+NaTOuMUQjp8oJ09bP1L5OYWRb3G3S2+y6ujOmgqN97npcnCuI6GRsboZKukhAZY2wrkFYaSCAfDa+9tqoDBwau+nH6ILq7U2osFzGrAgslNZOVMVefEyJ8QF3RYsCFLeO742Sx8aqFy3j+No9kvEt+Vg7j8jibN0wo1bc7GpLgy7L2NfcC0nnaEJDK9IdpAP5dNTVPyeTtCjHkojM+21wtgbdQFDoMggO26FVCaXCLQK/TZT07m0BkWpXvdapoCz9YuxKzbE7jZquRlmJqATKjvv+7e3DtFUqQURk4lLXe5U7Za7gtLeDsUmF9hJy4hv7vNygFh84wOEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(86362001)(8676002)(186003)(16526019)(1076003)(8936002)(6512007)(66946007)(2616005)(83380400001)(66556008)(5660300002)(66476007)(316002)(956004)(26005)(6486002)(44832011)(4326008)(6506007)(2906002)(52116002)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /thEo6/d96Gx9bStZpBOcWxhm2Tae3uEMKRX54IsuW8zgFKMFfDlKBu1zI9YBAX/nyrDua8ieeDr8JEcI90nzRyoxU6cKn50J18OMNNQvXpnA0Auri4KhC95aeuj17T9R8T1GYaQdqJ8UTHL0DUQ8/j8j7ia6qB/jH+9PLamv3fOl2JdMGJHK/KhqcDxD5X5y7uKj4Uc1l9IxRfLwbaIstsICYvdbG6ZCAgS3zHwRSNF/QOtjfaUV8rH8RnpDbh6d1dYLF3qi/jJbtV+1ihQqNgkBSSWuTQu1DERYRSpuO2waMsi5rlozaGVyUgfffjUmjAG0l6r/B2iG56py4nJwGbx/VFcg0YGqApUElYGMnzf66K4pdOWuewBUxKD7+WPbEMW7u5Hgo72VV3WecXbix5fIppc+rW3VcFNT+KGMO0n950MXDB7dqzjsLSBAclN6PuM2maYhncFa4fbROHa3/fMG5gs6mkXFIha04YbFpc=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd7c576-94c3-436f-b529-08d8182a01d8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 10:33:17.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+yZ8tBeNp+Or2QguurcRoMMre+79IZwJH+mTjb7n1/y+5hwQWpJ42lZ88RN64QKbo0pJr6cNbx6Rgr57YxtmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2445
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patch introduces helpers support for multi PM domains.

API consists of:

1) dev_multi_pm_attach - powers up all PM domains associated with a given
device. Because we can attach one PM domain per device, we create
virtual devices (children of initial device) and associate PM domains
one per virtual device.

2) dev_multi_pm_detach - detaches all virtual devices from PM domains
attached with.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/base/power/common.c | 93 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 19 ++++++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index bbddb267c2e6..b0a4d0109810 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -228,3 +228,96 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
 	device_pm_check_callbacks(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_set);
+
+/**
+ * dev_multi_pm_attach - power up device associated power domains
+ * @dev: The device used to lookup the PM domains
+ *
+ * Parse device's OF node to find all PM domains specifiers. For each power
+ * domain found, create a virtual device and associate it with the
+ * current power domain.
+ *
+ * This function should typically be invoked by a driver during the
+ * probe phase, in the case its device requires power management through
+ * multiple PM domains.
+ *
+ * Returns a pointer to @dev_multi_pm_domain_data if successfully attached PM
+ * domains, NULL when the device doesn't need a PM domain or when single
+ * power-domains exists for it, else an ERR_PTR() in case of
+ * failures.
+ */
+struct dev_multi_pm_domain_data *dev_multi_pm_attach(struct device *dev)
+{
+	struct dev_multi_pm_domain_data *mpd, *retp;
+	int num_domains;
+	int i;
+
+	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
+						 "#power-domain-cells");
+	if (num_domains < 2)
+		return NULL;
+
+	mpd = devm_kzalloc(dev, sizeof(*mpd), GFP_KERNEL);
+	if (!mpd)
+		return ERR_PTR(-ENOMEM);
+
+	mpd->dev = dev;
+	mpd->num_domains = num_domains;
+
+	mpd->virt_devs = devm_kmalloc_array(dev, mpd->num_domains,
+					    sizeof(*mpd->virt_devs),
+					    GFP_KERNEL);
+	if (!mpd->virt_devs)
+		return ERR_PTR(-ENOMEM);
+
+	mpd->links = devm_kmalloc_array(dev, mpd->num_domains,
+					sizeof(*mpd->links), GFP_KERNEL);
+	if (!mpd->links)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < mpd->num_domains; i++) {
+		mpd->virt_devs[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(mpd->virt_devs[i])) {
+			retp = (struct dev_multi_pm_domain_data *)
+				mpd->virt_devs[i];
+			goto exit_unroll_pm;
+		}
+		mpd->links[i] = device_link_add(dev, mpd->virt_devs[i],
+						DL_FLAG_STATELESS |
+						DL_FLAG_PM_RUNTIME |
+						DL_FLAG_RPM_ACTIVE);
+		if (!mpd->links[i]) {
+			retp = ERR_PTR(-ENOMEM);
+			dev_pm_domain_detach(mpd->virt_devs[i], false);
+			goto exit_unroll_pm;
+		}
+	}
+	return mpd;
+
+exit_unroll_pm:
+	while (--i >= 0) {
+		device_link_del(mpd->links[i]);
+		dev_pm_domain_detach(mpd->virt_devs[i], false);
+	}
+
+	return retp;
+}
+EXPORT_SYMBOL(dev_multi_pm_attach);
+
+/**
+ * dev_multi_pm_detach - Detach a device from its PM domains.
+ * Each multi power domain is attached to a virtual children device
+ *
+ * @mpd: multi power domains data, contains the association between
+ * virtul device and PM domain
+ */
+void dev_multi_pm_detach(struct dev_multi_pm_domain_data *mpd)
+{
+	int i;
+
+	for (i = 0; i < mpd->num_domains; i++) {
+		device_link_del(mpd->links[i]);
+		dev_pm_domain_detach(mpd->virt_devs[i], false);
+	}
+}
+EXPORT_SYMBOL(dev_multi_pm_detach);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9ec78ee53652..af1107731044 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -183,6 +183,13 @@ struct generic_pm_domain_data {
 	void *data;
 };
 
+struct dev_multi_pm_domain_data {
+	struct device *dev; /* parent device */
+	struct device **virt_devs; /* virtual children links */
+	struct device_link **links; /*  links parent <-> virtual children */
+	int num_domains;
+};
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS
 static inline struct generic_pm_domain_data *to_gpd_data(struct pm_domain_data *pdd)
 {
@@ -369,18 +376,27 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 
 #ifdef CONFIG_PM
 int dev_pm_domain_attach(struct device *dev, bool power_on);
+struct dev_multi_pm_domain_data *dev_multi_pm_attach(struct device *dev);
 struct device *dev_pm_domain_attach_by_id(struct device *dev,
 					  unsigned int index);
 struct device *dev_pm_domain_attach_by_name(struct device *dev,
 					    const char *name);
 void dev_pm_domain_detach(struct device *dev, bool power_off);
 int dev_pm_domain_start(struct device *dev);
+void dev_multi_pm_detach(struct dev_multi_pm_domain_data *mpd);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
+
 #else
 static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
+
+static inline struct dev_multi_pm_domain_data *dev_multi_pm_attach(struct device *dev)
+{
+	return NULL;
+}
+
 static inline struct device *dev_pm_domain_attach_by_id(struct device *dev,
 							unsigned int index)
 {
@@ -396,6 +412,9 @@ static inline int dev_pm_domain_start(struct device *dev)
 {
 	return 0;
 }
+
+static inline void dev_multi_pm_detach(struct dev_multi_pm_domain_data *mpd) {}
+
 static inline void dev_pm_domain_set(struct device *dev,
 				     struct dev_pm_domain *pd) {}
 #endif
-- 
2.17.1

