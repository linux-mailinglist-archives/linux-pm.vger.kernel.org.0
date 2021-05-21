Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8E138BCE9
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 05:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbhEUDTE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 23:19:04 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:17774
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233224AbhEUDTE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 May 2021 23:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbpzXf5LJ72YJCN38okICoSCcytMguVAKpdSbguEmmkAEGUSTCWh0iUBEEqaRKsMjjyV/iHlnrdqODuxKi6wwWvl0X2kwauA88SfQJyiupJ9jWl4w5utHTkl64gyYmm2JoDz8hx/PsmwZ07JmvBr3GBgvCCWkAaOI7Vqm6H7Z2lmDdeL8KvIQePrglXGynNtNQeyfEiHBMsp3TiODO4dSipR+vGZhNRWdGJiKJM+yNWXNPyfWlqt2tOXl6OWOkxFSRu8Ah/NaF/hv8/l/qUNIYzLJXJ83TXqIMMj2PZC5faN/mAQVH06IeAAk74RcpcPkuh7Qp4TfkL7YYdbpoXHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6PkU3KrosVopXVSVsRTeRean6LYvuhj6rn976TSf8Y=;
 b=h4p4f28AWOhW2suZgQ0BFPpn8pYZTUfDtdJl0B9l+Su5HyW9z6TQKr5xZJCVI02mkNA4Rk76DDIaKRPF0DlgwdVS9nqQVz1a1yum69Ywj+nbv8RHDD1TN/avn8K8f+kdsUmJtPcYKHrTs10qPzfwwdrMc/44MWnHlOZyBNdffHlDNIqzNwjE41AXMaavrj3o1k1vMfepdbMu8o7kmoEQu8jIfIp7nrqHvBEP8/fuFnj+pbopnXL1WerP2TdeBBTOqaqFLgCPl2CUfWXwtmhrUf8kiOnZ36T4YsJiYCHuUBBAvk6qFYjaaa9/ah93sYXvLljs9YlbiiEHMrzpXKA36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6PkU3KrosVopXVSVsRTeRean6LYvuhj6rn976TSf8Y=;
 b=CHqUd0PYhFrmMbSdtWfoqgQ6vJ5+6lmnXTYvG8LRXIGZujgdVOBXpsNfXTa9vTtV2wAbfjlRN2ND9KPdRvW3sSXlXSJRWPVsgFmno25kLRw9rBy+Q3dgnlsNY59Rh4jTWz3aWptBbWGISzfnPpoKtth6w6PwYvdjWR529seOiI8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4326.eurprd04.prod.outlook.com (2603:10a6:209:4d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 03:17:40 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 03:17:40 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        linux-imx@nxp.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, shawnguo@kernel.org,
        kernel@pengutronix.de, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 1/1] PM / devfreq: imx8m-ddrc: Remove DEVFREQ_GOV_SIMPLE_ONDEMAND dependency
Date:   Fri, 21 May 2021 11:16:39 +0800
Message-Id: <20210521031639.2767156-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:3:2::32) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:3:2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Fri, 21 May 2021 03:17:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c201c7b3-6a87-483b-f89d-08d91c06fd65
X-MS-TrafficTypeDiagnostic: AM6PR04MB4326:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB43260A947F80ED415B53EBB080299@AM6PR04MB4326.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6v+p+QNO/pSzYSh6fBL8BYqURNnXEvm78SFjaQ24/2DFj2AwBqePIiOSw1OotjlHTi6zWJpxR1+WYkXIokMm/f32cRNPXrfOQbxKrRVNaIjFUN0YGDVpXVZ+hRiTbPK2bQK449Hy4MHboq+jinJRZ25GS7r0X3nt/B4EVo+H10l1mRE0RsLNmWv8WEshMh2FKqT8mCGVSqYjZihsuIPMWgPH9gT5XKLkS6SUqdEE5BV5ASstSpR5GE/I2GJU8Az6a9oZiHy1D51Bxbu9W7uNNUqWA/iuj0CWbyHbTtIw1I9g4QF4cICFpjKq1DHWTbT228FVl/TwkSPmACz/NSKZvbpayYIPWLrfnx6xNhtxnA/lbeyRxpLWmoTdM2E29RZBI+RUWoERXITw2uvOmH8CxoJ7gZiztVovUOjdUAKcTdY5/Wo+onpkiMT8xVRJQZgdWleGzF2QlWtAAe1umFD312LRfO8VRSV5/AwxP/soychlHrQoAOA/Mpss3XZ5H9ceg8Jmp2S8e1aIFGvUiCGNcLOZx19+7nFQVZxK0CyDl5v699ypVnEWNxrJTcUbALHwpc0SgW5Rxiq7d/10g74qHsKg2XOso256AXooerbyBR4e2R3do4cv0uRdKSxYEuC8xNYphRGi/SGtoNb/gCxt3SADjQzTkT/vrUmjZ7sJi8yiLfBzSXGhYIwkb2KvW7ogLl6ugwQsBFSt6zECKWj49w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(66556008)(8936002)(66946007)(478600001)(86362001)(52116002)(6916009)(83380400001)(36756003)(4326008)(66476007)(8676002)(38350700002)(26005)(2616005)(4744005)(2906002)(956004)(6486002)(16526019)(1076003)(186003)(5660300002)(6506007)(316002)(6512007)(38100700002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Qk8g/xfVbgZR18E3UfoCdNrES6oDk8j7UplZdPBeWgXFXWNae3y/iguoupHp?=
 =?us-ascii?Q?VE3anJVGvTa8Lf11Yq4s1yifqiw0OZQug5ItEFReRR/puKMbqDfkHQ23fFf0?=
 =?us-ascii?Q?Hm5LqewvF1Ocf1Vool3oaFJSKzVaIZFagSM1ZAi0fLTinK/n/kHyVtjWCqUt?=
 =?us-ascii?Q?p5koA5ZB+rRZp6OyfLa2iTZpeBXhwowc0rTTuVPBGI4YRbkfdB6YAkYWZXLE?=
 =?us-ascii?Q?LHiUQfvp6BeR9Q0ZpyYCewuHjNieJTP9jGV9yX5yUoIbli3dTEAp/3076tZO?=
 =?us-ascii?Q?ssU8GLRw2eF6ORURPtDyUrQWEFmcReWP5sGclm7Ow0U3Ps7O0eN1HdgNgIPK?=
 =?us-ascii?Q?KuO2hPrO7l3lsBJaJxgE4f3xqgmljwxqdWiZyI5MmyHkFGSbSQzwDl4869uc?=
 =?us-ascii?Q?ItYgD3zRiFOC6D8jLdEEcIi0zTEzJTwM14O0GaeYGEghKetH74T3MMiZ6Rzx?=
 =?us-ascii?Q?SfUz+pZHHdgLApO5uSXkVnLD/IOF2WiJ/1CKjBYJRfNQ5v3nQYF2pXY+TIgr?=
 =?us-ascii?Q?ZpKlQRvm0AfzMoA0MGEEISaQluteU2Nhu7WpmACvUwJv9qDfaoL80QPmjY4Y?=
 =?us-ascii?Q?mwi8g5wBLA45+zaPaxWcr3axaee0oXgqo0Y8HFE/qr+n9p4WcqBTgxMJbjqz?=
 =?us-ascii?Q?N65TrGXvAQHY/GIuseTZEhEReJiD9AtaEY6CCOR57PqHmoGJ/z7p//oaoFEF?=
 =?us-ascii?Q?IgAFOHc0udd35dCGoki6o6B1PAfdcE7qvJuQSm+aJ7mw5VEG/V0TgCnuNqkC?=
 =?us-ascii?Q?QJkJqPZVDC91DbQO6ycv4HIUM20FJFcTMrwNqyS861n+ZmUNMWCwO2upopTg?=
 =?us-ascii?Q?FlIOY8/YsvYOSOwdBfTRaCv1pT381i+twbkauBVt49dH71ZrjrAyfyLmEVfc?=
 =?us-ascii?Q?siDD3RgGrCeq3wOPvSZDuP5sIDbL/FZgrpJFEq3nrEMJobprPDpBG4SGihxN?=
 =?us-ascii?Q?cplpGQuXAiZQPE/z5kygSAZE21kNoffs2fPC0FdmTybgBeIELkNRiQrKNGk7?=
 =?us-ascii?Q?EXkt7T/2nqbdceJ+k2TzfRpYVTojPmN7DXDF08T6zKgPcoMBJwF3U2EUDTEy?=
 =?us-ascii?Q?m2I2+M+oFdEMizIzmh1q189gs4Z2+LH3q5MwgAlby8sbh+6/JU2l36ayez+b?=
 =?us-ascii?Q?B7OORD5t+jPAVsor6dR23do7LlIjRP3/2JX+djOcvXOQktDH9xiUyO3wxglI?=
 =?us-ascii?Q?TJsVCGc+1sNHJT8Xq3jckn/iMd3xpyKRe/aQt7a+5tE1uTJo2/JnH0LcIQgf?=
 =?us-ascii?Q?fRRvrfp37uzwiTd6q58v3en6IOTcpS+oLCgawGUvynTBlSQrsM4oeL2VaFwG?=
 =?us-ascii?Q?9ZBWEcMj7NShbcMB8tfOOF4K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c201c7b3-6a87-483b-f89d-08d91c06fd65
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 03:17:39.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnkiEhX+5w/jG96uN6v8Uge+DjCvVH0UfrEUe5dVFOVBuMBpfgMGS/HulmgV/mRwwDkx0KA8ybdiIIALBF8YXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4326
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver can't support simple ondemand governor due to missing
.get_dev_status() capability.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v1->v2:
 * update commit title
---
 drivers/devfreq/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 20373a893b44..e87d01c0b76a 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -103,7 +103,6 @@ config ARM_IMX8M_DDRC_DEVFREQ
 	tristate "i.MX8M DDRC DEVFREQ Driver"
 	depends on (ARCH_MXC && HAVE_ARM_SMCCC) || \
 		(COMPILE_TEST && HAVE_ARM_SMCCC)
-	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select DEVFREQ_GOV_USERSPACE
 	help
 	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
-- 
2.25.1

