Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E2B2050CD
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbgFWLeL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 07:34:11 -0400
Received: from mail-eopbgr00054.outbound.protection.outlook.com ([40.107.0.54]:22289
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732383AbgFWLeE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 07:34:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6Jk7qPuLZ9xB956ojvlla1BihJ2jOHGAWfe/MAKzPs0Vj2pE8kZVZz9w7YxcKeykrgeFa9KOAzeWVV0/BEwc9YF6M0D0kCziAMRKYrqtr6l1B9Y3ooCPEaa4+iae1E7I41kIXX/yprmvWpnrP3s3HWb0kYYJnL0NnUneRPk3nQiEVhomlMtKKmxpae32itbyZYyGtOvlIdnSXf3iNuTtEcZLDMcyJvoxRjdzCTZwGMu2e5QwoRqkvrzVB0uJPJ+h2jmsBKZHvN/PIcvIcCnK1vWX+g5sC6333VzxjmHbouO7hptxtSKWJMjNggSR7+NFqSK0I8kaD4T1LhqTcbcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d50D3BY7IdVsv7PjKW8OSKb4KcfS2vi56zitjmwUuk=;
 b=JiBc59mTF9p2RT32tqAs6e3mKbxMneZx+h5Qfg8aod4dtt3bqBAYNMI0SikwYuIbsGUAR0MAnNgQF2lU0PYulR45obLk8G7R8Tx8/kHoxsPrF24U18SniasBkcUbM7Iyg0sxAeRBZNRHqTh85D96u2wUxhduLQFgBC8MI7Qo0FI5Hogpwo5n+pXL6hKrTVKy7lm0KbO8eiwg/4K9Na3iRiMCztb9x+vEOl15R/DThAipS7vC2MIfSi6x+INoy6bBRVepHmvkDos6gEp28n+gY6NV+51CRAPxyQOeQ+U5MWzhv3XYZytkjqWsX/N/Qf51GAURTjk2pvNeGi2xRdThOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d50D3BY7IdVsv7PjKW8OSKb4KcfS2vi56zitjmwUuk=;
 b=OGwMD7h7kUN2fChVoG8ydquk4hWtmWYFTP0eg+qLnVADY4Mnjly1/r6I5N72OKRVqQiNqcQvUkaxwfRhcKP/M1eEJrzal0Y9QT1qu/pjRZy0i/XKi0sSJxURf+CCZdNGgtEYOyItFIGMvoQT5+SeTpg4Ke6v796gOLef4Y4f2Fw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR0401MB2558.eurprd04.prod.outlook.com
 (2603:10a6:800:5c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 23 Jun
 2020 11:33:33 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:33:33 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     khilman@kernel.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, alsa-devel@alsa-project.org
Subject: [RESEND PATCH v2 2/2] ASoC: SOF: Use multi PM domains helpers
Date:   Tue, 23 Jun 2020 14:33:01 +0300
Message-Id: <20200623113301.631-3-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623113301.631-1-daniel.baluta@oss.nxp.com>
References: <20200623113301.631-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::36) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR06CA0131.eurprd06.prod.outlook.com (2603:10a6:208:ab::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 11:33:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 314bd7e8-5a82-4b36-c18d-08d8176942d4
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2558:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25588E552B0DD7444A465344B8940@VI1PR0401MB2558.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZIh5UwZreaHzitr5hW/R0bmrE/qaJM1BXC6Ru8HKLCzlun5xUjy+4TDhmxMmZaXJuO/lJDxtv4Dik7ixtpmUj1+yY6sCwgGZuKt87w4Y/OqpIJ3YxMHXqerKwqNxqqOFMow0T8ZR70rrg8IdCdJHmTBU+SmF3IBqVYvfeaCnuTrPcXMECLgmd7wCMd86UfWNTPBuVUkMhTzqVIJghy/mxm7+rh9uVgsWLn1lkzli0xIeK72oTz9VPMokqiXo7RQlxa8Q4HkRVKRqaN4xJOtjHWAGW7dUYdCymC2ly0NPT3MUV9eLr4kjAB/d3A0FuDxGmub1+rEL6/1UvhnaHmPKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(66946007)(6506007)(4326008)(5660300002)(498600001)(44832011)(66476007)(8936002)(66556008)(956004)(86362001)(2616005)(6666004)(8676002)(6486002)(26005)(83380400001)(52116002)(186003)(2906002)(1076003)(16526019)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4OtpC/pbnpEdRZ6cGkXwX585NoqwqYtg+qtt8N7E141jfKjwXH3ryMgkR8tv/jkhR1PKPHzxR5TDmi9DxYUhU4oOllaKAkDM/5VBja0FZSnfWqh2tOere4ai538YOMffs2gJYvIMU8Vx4Hv6dr0ZBLT/TqJPUvGga3T595s3CAksXPn0JAUqKFu59TqFxdBkeASCmx1bAXb3ykt7FMXfzQOGgRaEAqBGzISWdG/kQVwbqgiudwJHpOhRE+EF7qIjQgKGik39Qoec/GesQ5TtvqS05zJ1VJXx0Xm8dCs4mMt2xVsR1cSDX1OrD7lVSC9vPV6E+OkrpHgM3TMoqt6NtRzCsNBgnG7zcddZ5cvhPEWm7vL03/EDRAN+KuDn9B8lvqWA3ZM8yLElF6AVTXRhHtATYfRXkgYKLBpttDgGxd93H/Tsoill5BiC9ggSRTe9KdlIGXNHCEN96rT48YOw2Kwy7qhA8FSLsHD0qHFRFxc=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314bd7e8-5a82-4b36-c18d-08d8176942d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 11:33:33.5278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTbvkj0anU+lWtRDn8IwbtFDAKVCeSCPcV0R2stzsF+GymINUH699HIeHLhflzF9Xtfgx4fruuqenoYSr6VMoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2558
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Use dev_multi_pm_attach / dev_multi_pm_detach instead of the hardcoded
version.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/imx/imx8.c | 60 ++++++----------------------------------
 1 file changed, 9 insertions(+), 51 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index b692752b2178..2e7635b697cf 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -51,10 +51,7 @@ struct imx8_priv {
 	struct imx_sc_ipc *sc_ipc;
 
 	/* Power domain handling */
-	int num_domains;
-	struct device **pd_dev;
-	struct device_link **link;
-
+	struct dev_multi_pm_domain_data *mpd;
 };
 
 static void imx8_get_reply(struct snd_sof_dev *sdev)
@@ -207,7 +204,6 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 	struct resource res;
 	u32 base, size;
 	int ret = 0;
-	int i;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -218,45 +214,15 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 	priv->sdev = sdev;
 
 	/* power up device associated power domains */
-	priv->num_domains = of_count_phandle_with_args(np, "power-domains",
-						       "#power-domain-cells");
-	if (priv->num_domains < 0) {
-		dev_err(sdev->dev, "no power-domains property in %pOF\n", np);
-		return priv->num_domains;
-	}
-
-	priv->pd_dev = devm_kmalloc_array(&pdev->dev, priv->num_domains,
-					  sizeof(*priv->pd_dev), GFP_KERNEL);
-	if (!priv->pd_dev)
-		return -ENOMEM;
-
-	priv->link = devm_kmalloc_array(&pdev->dev, priv->num_domains,
-					sizeof(*priv->link), GFP_KERNEL);
-	if (!priv->link)
-		return -ENOMEM;
-
-	for (i = 0; i < priv->num_domains; i++) {
-		priv->pd_dev[i] = dev_pm_domain_attach_by_id(&pdev->dev, i);
-		if (IS_ERR(priv->pd_dev[i])) {
-			ret = PTR_ERR(priv->pd_dev[i]);
-			goto exit_unroll_pm;
-		}
-		priv->link[i] = device_link_add(&pdev->dev, priv->pd_dev[i],
-						DL_FLAG_STATELESS |
-						DL_FLAG_PM_RUNTIME |
-						DL_FLAG_RPM_ACTIVE);
-		if (!priv->link[i]) {
-			ret = -ENOMEM;
-			dev_pm_domain_detach(priv->pd_dev[i], false);
-			goto exit_unroll_pm;
-		}
-	}
+	priv->mpd = dev_multi_pm_attach(&pdev->dev);
+	if (IS_ERR(priv->mpd))
+		return PTR_ERR(priv->mpd);
 
 	ret = imx_scu_get_handle(&priv->sc_ipc);
 	if (ret) {
 		dev_err(sdev->dev, "Cannot obtain SCU handle (err = %d)\n",
 			ret);
-		goto exit_unroll_pm;
+		goto exit_detach_pm;
 	}
 
 	priv->ipc_dev = platform_device_register_data(sdev->dev, "imx-dsp",
@@ -264,7 +230,7 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 						      pdev, sizeof(*pdev));
 	if (IS_ERR(priv->ipc_dev)) {
 		ret = PTR_ERR(priv->ipc_dev);
-		goto exit_unroll_pm;
+		goto exit_detach_pm;
 	}
 
 	priv->dsp_ipc = dev_get_drvdata(&priv->ipc_dev->dev);
@@ -328,26 +294,18 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 
 exit_pdev_unregister:
 	platform_device_unregister(priv->ipc_dev);
-exit_unroll_pm:
-	while (--i >= 0) {
-		device_link_del(priv->link[i]);
-		dev_pm_domain_detach(priv->pd_dev[i], false);
-	}
-
+exit_detach_pm:
+	dev_multi_pm_detach(priv->mpd);
 	return ret;
 }
 
 static int imx8_remove(struct snd_sof_dev *sdev)
 {
 	struct imx8_priv *priv = (struct imx8_priv *)sdev->private;
-	int i;
 
 	platform_device_unregister(priv->ipc_dev);
 
-	for (i = 0; i < priv->num_domains; i++) {
-		device_link_del(priv->link[i]);
-		dev_pm_domain_detach(priv->pd_dev[i], false);
-	}
+	dev_multi_pm_detach(priv->mpd);
 
 	return 0;
 }
-- 
2.17.1

