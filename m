Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1A2050CB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 13:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbgFWLeC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 07:34:02 -0400
Received: from mail-eopbgr00054.outbound.protection.outlook.com ([40.107.0.54]:22289
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732348AbgFWLdr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 07:33:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cx+Mh3nrYcj75555U5oRG1MK/3WCPdjenSML+onTiVoblMxuQbuz0zDwkrWWXasxnyVAs3RGPaus6inq3gXrmgm43KLF9/jt7KT8W44Rpe83fxC+WWUcbaGgdm5sXQuBgKDHiaVfPeF6Q5UEosg2VV+ALRDJTmNhh61bxjZztKXk7xq0aBdhpZwO7II9Q3MNRD0mAZSCjR3YI+0AtCixcK6s5KdXCkEXhkyIod7RIgMlsHUR1T+RcTaHwzuH92OniWOBTExQZe9HNxErb6jaFoM2lGOsuG45xuk3mGJDdobsnbhmc9b0pAhR61AOvgoXY8GnVMiDFFFuhELtjSUOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+2+YcbOFXrLMdikxPZWSbBvO15JELWvJtDNYg8/PgI=;
 b=TdGEr2tsRqIs6hOpugmNJm5fQCI/JTmkmYI2Ybqs4D5ugLivwjL8m35zp115bABKiJT5JkfgROol+uDquQSgkfU9oyJiYyE3vTZnQ31cNLFilTi8h/5pbf/WXpmbaNMwZ0Zw/O95GvOMwtdvcOVOcoorpiah4h2/guRx2vUIj16NFe00+3L9j8UJBxDv8adznHPuyU14hBGt3Wm1sE7c0Q1fltO6xZU/jtNpvL6CnEEvu+h0nNeFSQGtlriXJNGn9YY1yMIg4eoUwUvHqDD0So1Y+4wPTjNbx1a4JrCitdhlwvka/A5K/lIa6OQvvh6ThiBE/9BqBj+GMRjjwj9Fiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+2+YcbOFXrLMdikxPZWSbBvO15JELWvJtDNYg8/PgI=;
 b=QClTUi9+iQGt8DPQfED3HQdS+OUiCACNH+JuilXpUAWFDe5koTs9IJ/fhINJP81D8tXlzykYybNh48JDTGW07okk1j+/o4jyEsbYpHJJXseE5gE5OgJMlK/JYb15Xo8ZhUuNhR4X+jATr844u5m0fPcmwPVwEwLHAns1BOkSu7k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR0401MB2558.eurprd04.prod.outlook.com
 (2603:10a6:800:5c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 23 Jun
 2020 11:33:32 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:33:32 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     khilman@kernel.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, alsa-devel@alsa-project.org
Subject: [RESEND PATCH v2 1/2] PM / domains: Introduce multi PM domains helpers
Date:   Tue, 23 Jun 2020 14:33:00 +0300
Message-Id: <20200623113301.631-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623113301.631-1-daniel.baluta@oss.nxp.com>
References: <20200623113301.631-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::36) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR06CA0131.eurprd06.prod.outlook.com (2603:10a6:208:ab::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 11:33:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35c7ebc7-6246-434f-686f-08d817694231
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2558:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB255892513251FA0B906A9A29B8940@VI1PR0401MB2558.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9B6nf0CPdPiL0T8s2DUHroSuthx0rWkIZCTQNTu4F0R964u+Q5pVDHa9oxkvDvMssrV9r+xgrDvBkBrK7eUuGIvbDbRZ+lYhlNZMk0/sghevvoQGee1Rqnl4hjU2t6mMXJcZQ03/L57SWHzSLZwS0ZlJlM0nFzlKvQrMyPGTWZwqGie7w9TalkUePFILdTT/YYisihsp9HqbK1gTr0zmF+vVp/KwHXq07f2PBpXn1lMWXEYjXNTTDwof6y4sbPMqqeaGR8MoxCR4IFA7H4e6jxujWl75+2+y/AdEDngFTiFR+Wu8gb9RUrMwPYNqqVV/XksTcyFAMIzppcTXxMKyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(66946007)(6506007)(4326008)(5660300002)(498600001)(44832011)(66476007)(8936002)(66556008)(956004)(86362001)(2616005)(6666004)(8676002)(6486002)(26005)(83380400001)(52116002)(186003)(2906002)(1076003)(16526019)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BFxOYUZzmwn4ruSXPT8aPsf6cquZeuLkz+8zPvsYS7MgGmWoSiUvr1b5aVA+aK15pOjs68qZ9v/jBGSINMHKqDgTZ1qMn26DThxq+sP0+7Uri1aT1HE0vOSpyOYLeipQN0GGaTVodHw+jiFg2fxAv2dQg9Pz3iNipwkLWgxjfjOwBwgoxZGQhQ4CrjYXvwafnwKx/5Xkrr9w9DytWfrQhGBubtShB22+c8WOEbKRUbzIoDM7alPiVa2DP497l8ir4J6BcHSdy4Oag9Us2EJdBfu/A9OkasN+Ky9b63vPvxa8Y/F/Y/mcacbpVffH5IavEl6vgrM3EJA1GuTDOWjMdrUFD3krx4b8RP/5oUs6QgLBa8Zrk4TVO40+wCLHOcCm+pUpLMNdYmlKeyt84qqsn7DJLbO3FBW76/01aSo+LCfZ0pa6V350DImlJlENSaltVvWe6oyXi2NEj2NnsM7UEjN/0SksAYrgy4rhWcTU3aE=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c7ebc7-6246-434f-686f-08d817694231
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 11:33:32.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg6fl+/o/gFwcyC9Ku2YTEABSPMwv6P7r2uRfT8008mKizNQhwBggS32pEFd1PyXB2DrhuYxPrtT7XBG9TfDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2558
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
index bbddb267c2e6..6d1f142833b1 100644
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
+	mpd = devm_kzalloc(dev, GFP_KERNEL, sizeof(*mpd));
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
index 9ec78ee53652..5bcb35150af2 100644
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
+struct dev_multi_pm_domain_data *dev_multi_pm_attach(struct device *dev)
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
+void dev_multi_pm_detach(struct dev_multi_pm_domain_data *mpd) {}
+
 static inline void dev_pm_domain_set(struct device *dev,
 				     struct dev_pm_domain *pd) {}
 #endif
-- 
2.17.1

