Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71482C22DC
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 11:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgKXKZX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 05:25:23 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:15428
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731281AbgKXKZW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 05:25:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9ZUZJoWoBiwMrd54vK89GM9TwO4HEcFCpKp9TmMCz61wrzHMZFg4OJi4KbUuuieyPijFvtY7hzlMfAlXKCzEDAGpFQUwrmaG1enl+odQWLy9J6rCwMlqnrg1mMpm/qGxxMC39iboZwFiDV57w7MOhVt2WQvIKq04lMu88Z2b4Ve9i/I+w3q4RtQgmQrrT8kgCOsXu+GrcfDwGY+oBjg5DfEsT/T0jqA+vdc+f8xZ0BDGdD8nVvShR5jzpK4+8v0jEdJcotkllRB8srNux4/g+KFH5epTyCcFYfPGle7/Q1Oq0J6esJcLLGYLX67jH1kN+nJGvNKlXnQ4VLQFA9haA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt+YP04b0t/9T7hIjTkFE4HBmL+T38d3Uq1xS9V3qVQ=;
 b=e4nlLhKn/ilr7JfDK2IKLRN6ahqQZBvnApNR1YS5Xz7ruklpEN/7yIYAGrc6bMEalXmj+Dop9+vtHo23+z7zObjYvH29pKpwnECRHCA5iotrQgYCArzZyWP9MB6ZHBtOD/K+L5w4zL4RrK1xCQw+IGEgptad26pOYRbshkK/3gfF8ZQTcSoSVuW0B655kW0P2UQu1vNAaTcUvn8z0SzjaBIPnxD/DstbHIa/hEcjcjVti8Eh1Nk99mvwDMDTYRVY6vShS0LsPjmqX4jlFDZPpbBVFUVIzZwmvg/DDxb40sonvGI/tkIswVgd0+oeECXpJwwdGeBQ2vA4t+swTfAbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt+YP04b0t/9T7hIjTkFE4HBmL+T38d3Uq1xS9V3qVQ=;
 b=gp2gF0SnBfgc5pHo7KRtmAG7bR3ZyCdxRFMQyZTPDZvC5aS68I0MjrsF5gdcRBYbevhtU7VR7GIKkCs9odyFt7tMc+1/jpE9JV/UTFfTGSUccw2Bi9VeKwRyfZSr7me9Ou480ZBeBNt/Ez4kTZa5zDRVZx8lvZBvzJE4LibNefY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3669.eurprd04.prod.outlook.com (2603:10a6:209:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 10:25:16 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Tue, 24 Nov 2020
 10:25:16 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        sudipm.mukherjee@gmail.com, sboyd@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 2/3] firmware: imx: scu-pd: export SCU PD register status
Date:   Tue, 24 Nov 2020 18:08:01 +0800
Message-Id: <20201124100802.22775-3-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201124100802.22775-1-aisheng.dong@nxp.com>
References: <20201124100802.22775-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR02CA0054.apcprd02.prod.outlook.com (2603:1096:4:54::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 10:25:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42cb6794-8faa-42fe-55e8-08d890633c7f
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3669:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB36690ACD744C8D8B4EC62CED80FB0@AM6PR0402MB3669.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpEO0Jy1nPKsP9XiK+Kk0zPMNbeRojme8DSaKk6mdvCzMq01LJnUlUMN5LlvbaxLSKNA4brdClPjhFG3m1HSOKJbHhYJabNYdidnnChH54fKZ2o3xqLOYGmfX155EET02Qzxc5I879DvgVhw6xh3PAA43GsIiErVoPdO+md9S0qChPZt1uEvFxuwog9THT8GDGfVfsnMcpepGc4EpHpUftVvO2iAZUFO+GIhuEN0C2KrmniDJvPyNer4HyzJyBpBzms3rrFNLpo6Ha1fW8T8r+EdS34oeBv025am+VwfawgHMyimZf8NVvwlFZVBybe4MIUycokew91FGMC8hVYLaUFxERdmRZk7HBMTgkj6k7Az7iUNQU70EcV13z/GvIwqSDyHK+zYJ7+ubxcMC6M97A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(36756003)(2616005)(8676002)(966005)(52116002)(6486002)(6506007)(86362001)(1076003)(8936002)(956004)(6512007)(478600001)(4326008)(316002)(186003)(6666004)(83380400001)(5660300002)(66946007)(66556008)(2906002)(6916009)(16526019)(26005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QVNJJmNl+A/7s8Di9x8pyiOaI8MKieIsg1MC2SF175TTWWErP8srLqmELgLJYYCdwTacKq/bzGHGS91TB+P5kIg/p6QaB9+sUuH2dDbtHlrX/rkEltg4irUMK+lGUbIkmSRwQPoyr2uwh+ETvLRjk2ZEWTWZ4tMGr/fLwGc/6z6+YkgBxKon3elFi6/wzt+ub/+5YG8ePKiLSAup6k+V3UIMrG5c8yuLavERqrrrK9bRNtpI1XLsK/XaKNzjN+lLyvawYloZMIA5LHJYoizAWx1j3Mhd6l6haK7m+orVL32FCPCqaqfTlTKDlKq8mJI1Syk0sosqyhY2fFs70IwDna4qVoOK1d6MsWFvYPpfU3ls5nGuq99istjBIuA9C+Mi0Cr1HdcBx67eoVs66S0Wm8lLDelLQQdvDE+6Or/+xaiFErpC9SjKJak/kceypxRaMAcldNcVngFjKzUSQGufYU1VyDbnqVptXoct+05Y5EWAMHPY1Q/57PUmkYqZ2T5I/BCzpgs8esA0qBURNJ95pIxlvDMh5Li+Cr12RRWfPK9+ruq0fU4vUeLh2VeX730UDDe7TYFzgMulV6oaZAPDW7C99F+WJFPLfTsc8bDv35QZ6CASWbtCUmAxEpjIx8ClOGdvf+vYMDMfuXmOjm1ifPvVax6vruQA0BgIC0QDuiJJtSG5G92Fk+PdhFIL4N2vB1DqSBO0Uv3OwpNJWWiSPTWJZXB+J7f0rk7z0+6do0YJwafcloqPY/nJeo3A2Cry38g60UVok26Vd6RlqjkiWGU3rw2S226FhrnW+JvNRIUtijzpKl8KW7SnKCljgxNpo0CKp5UmN3+Nn8SabvLTgZg2BvGwICnIa2YYcUij+QdDhOsMTDsBVAQcnqNVE1Zj73ZWhm1VtH9ZrrCCU+NeYA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cb6794-8faa-42fe-55e8-08d890633c7f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 10:25:16.7103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W55KK7xc/NTouzlBRG6Xv1umAtlYVZy1Wysb6BqG26thMNMKtPDKXByVq/zQJws/iKi3LigBO8z9/Mi1GUGUWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3669
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SCU clock-controller (SCU clock protocol) does not have a power domain
property in DT, but the sub clocks registered requires power domain to
be ready first. Export an API for SCU clk driver to query the status in
order to support -EPROBE_DEFER properly.

Link: https://lore.kernel.org/patchwork/patch/1334670/
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c    | 20 +++++++++++++++++++-
 include/linux/firmware/imx/sci.h |  6 ++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 946eea292b52..53b49ef20014 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -86,6 +86,20 @@ struct imx_sc_pd_soc {
 	u8 num_ranges;
 };
 
+bool imx_scu_pd_initialized;
+
+/*
+ * SCU clock-controller (SCU clock protocol) does not have a power domain
+ * property in DT, but the sub clocks registered requires power domain to
+ * be ready first. Export an API for SCU clk driver to query the status in
+ * order to support -EPROBE_DEFER properly.
+ */
+bool imx_scu_pd_is_initialized(void)
+{
+	return imx_scu_pd_initialized;
+}
+EXPORT_SYMBOL_GPL(imx_scu_pd_is_initialized);
+
 static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* LSIO SS */
 	{ "pwm", IMX_SC_R_PWM_0, 8, true, 0 },
@@ -351,7 +365,11 @@ static int imx_sc_pd_probe(struct platform_device *pdev)
 	if (!pd_soc)
 		return -ENODEV;
 
-	return imx_scu_init_pm_domains(&pdev->dev, pd_soc);
+	ret = imx_scu_init_pm_domains(&pdev->dev, pd_soc);
+	if (!ret)
+		imx_scu_pd_initialized = true;
+
+	return ret;
 }
 
 static const struct of_device_id imx_sc_pd_match[] = {
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 5cc63fe7e84d..0eaf00ad6305 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -22,6 +22,7 @@ int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
 int imx_scu_soc_init(struct device *dev);
+bool imx_scu_pd_is_initialized(void);
 #else
 static inline int imx_scu_soc_init(struct device *dev)
 {
@@ -47,5 +48,10 @@ static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
 {
 	return -ENOTSUPP;
 }
+
+static inline bool imx_scu_pd_is_initialized(void)
+{
+	return false;
+}
 #endif
 #endif /* _SC_SCI_H */
-- 
2.23.0

