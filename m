Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D917654C506
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347608AbiFOJsn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 05:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347630AbiFOJs0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:48:26 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01E0346152
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:48:22 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-F80T32lxMdWwgIFqYfPEcA-1; Wed, 15 Jun 2022 11:48:19 +0200
X-MC-Unique: F80T32lxMdWwgIFqYfPEcA-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Wed, 15 Jun 2022 09:48:15 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 09:48:15 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 9/9] ARM: dts: imx6qdl-colibri: Set CPU critical trip point
Date:   Wed, 15 Jun 2022 11:48:04 +0200
Message-ID: <20220615094804.388280-10-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615094804.388280-1-francesco.dolcini@toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MRXP264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::33) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c6b905c-7e7a-4078-0c70-08da4eb42a51
X-MS-TrafficTypeDiagnostic: GVAP278MB0392:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB03920186A590457759514947E2AD9@GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: ASgfbbLdoMPibhkyPsI+GPIRF2/1u4HLq6YBER5ixxYXzEwzvjf442PBJdG2Pf/iZ51ovCTCzGHTmFGsv52XMc3+PycFuJmDgr3Fs2+dd5w0L4ewUPCXUm/qwyOHcDXapFpjdpbVmimPAL1VfICE1u45Cm0TOnj208MRUT930x0LlMHUHLhNmQ1i4JmEEaRjFZ5f54y1HZbrAgpq8sGqhwk8ZdGtmIs6YC4L91/6+3RonSvBDhqpwCOebuQuQ89MVV9/ljkYCIrbHFmr/3l9L8Zm8FO6elNLjifCVDwBTGklUrHl/InKLlRun3nMa1E2tsc7/+e2PS21C+6MJ89LnYxgpIWBoyzxpG0V2Z8CnArafgcjDkXlMwWY5BjUfr5yihRpjmaiVWAsL3AeQ5B+ktyzOn9z2UHwKBMBvsq+KbPAEUlB7Q4V/oKWHyaC+xrWkUJu25Fk5akZbrNIBDyBVLleDIMP2C4oFDInAp5tp3XRBNEZq7eG1ZrLxLwnDORsbD524154UV2LtRgAFatiI0PZEujJqp4y/5pFdcvZYNyH9mWFLj2m3dBbGY0qano5TJ1TgUgFpAzZa62l8+t9jiZvWeLKY7jGXpq8+08V48cL3oc41bfCiQrPegwNlKEpQcafJMu9QCbreiXtXNAWP+hQyfLe0DKG/oTJpkugBlmB+KSD6S9cd6jxXn/wlb/ndcWtxf40u2tmqnVx4glBGDOapDSayS4811/LqDN7Cn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39850400004)(346002)(366004)(1076003)(41300700001)(2616005)(8676002)(110136005)(8936002)(6666004)(316002)(66946007)(508600001)(4326008)(86362001)(66556008)(54906003)(66476007)(26005)(52116002)(6512007)(6506007)(36756003)(2906002)(38350700002)(38100700002)(4744005)(44832011)(5660300002)(6486002)(186003)(7416002)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fVVPtm5Q0eO1tHG2/dpoh26q6o+n4mELeN4NCtBxdyce4m1Nig3V36nWk9Jw?=
 =?us-ascii?Q?sef8YuCl77YBdKtueJOrn7wL1+ndbKA/UHj5HWtmnVhiFEgPicITTq7Cj9UK?=
 =?us-ascii?Q?CtymGRTLJJ7IkBs3vMzRaBUaeRALKLTv1ou1kBjkjYy9/p2z3OIrwIlaATXg?=
 =?us-ascii?Q?YLLDnQYL1bmIrkDVyx3TH1n81RHIXglCxJ7YduJwGeXAnW2rytI8q3xIhRZl?=
 =?us-ascii?Q?g59bC5HCAKoU9FvKRQ0BjEL9SODBKSwb84xJrw6PsJileeNtSBD3XpQYy5/Y?=
 =?us-ascii?Q?tqmgJoufQF1HiChlwphRK9gHlBag7/JzmbDCVm7MZuN/XzMhuFTZML7yJZrT?=
 =?us-ascii?Q?4WbMaPAa0nsznlMxeYnZs+VNNH0l97/mO0npoJbH8TYEvucRz7K8VwDPcOQa?=
 =?us-ascii?Q?ugkchlt9UIod/O7qkFOzp/Pvd5heVDSW1gmpCGewulkbzBsMjyqYj1VX0z4i?=
 =?us-ascii?Q?SdpPn0vVphX9cFulVkHyVgQBnc14LESIGVRwxeD3U8WkCoBro5JSP4GIDfaw?=
 =?us-ascii?Q?N5cjfaz27DDBS5o2PdlaWWYaK9GbWh24h0qX60qqajcgI13TDvMPX8AUJPro?=
 =?us-ascii?Q?6944AqxpkSiakosLu1fNp+TnR5Vsxp18c+PDYVlslJao8PQfx6ZZbWhHA954?=
 =?us-ascii?Q?fOwoN2AdD4Oy51ECybIDQ8G+jlbcU9xJFF9LbES7X7fg86ziKsw12uZyT67s?=
 =?us-ascii?Q?4zpI3Fh5KuKrwD0tuRjDEl6nWhYDAACcKSI1oWRkmQ+t+5uEopLlg23x0PiJ?=
 =?us-ascii?Q?TQC6+4XWZjo23Xp3Jq6CEVrncJMqGCvn7i0GuzSOcMWFeZ7c0TC5n2vc9ofx?=
 =?us-ascii?Q?r1f1HPLAPZcnGu7Tl5JhUXahCtLWMSOtuqXLtZBIHvGzIHWcaVdj0A1sRxaj?=
 =?us-ascii?Q?eJPE9q+dYEmp5TwHh/zESxGf67y4l9EiXD7nT3JUbuWXrzZPsTGAuSEUUpTn?=
 =?us-ascii?Q?8IzoT08dTOyeNwDusx2ntTPwkz522qAljGIva4JvykIr879ScHzUy8l1nD5+?=
 =?us-ascii?Q?IU5mM9sWhVpO5yk4lolIWBG5cCur/U7noXSJZMZJCmjBid1UMJ9ldBj0TaCT?=
 =?us-ascii?Q?ooSccqv7KpGSyS33Pr1tAZp7URagQCtsCSb+YhewN7BLtUPGJLrkCXPXagXh?=
 =?us-ascii?Q?q2yezmSrWJMWMgFih+Es6oOOGi6WgoyqpiKyVsVgm0xti7hcL843gjhHGB3G?=
 =?us-ascii?Q?OsRCXZP5zL+aoIwKQE7W9zgCVj3AVNITxfJAeeK/5yn74HdyFeVxdBFKKZiT?=
 =?us-ascii?Q?rfBs3eAqbU4UzJHMPndg03URek1IxHLP7fMF1pnAK6LzP/5zwGUOgjkb2TWU?=
 =?us-ascii?Q?Xlwk7lFx4GuRMM8ujgmDT5F4lKBUoFDzCfFu64jtytgQIGs+OOI250SkRpE+?=
 =?us-ascii?Q?cnkt5QwkxNwf38lJJSDQ/x8uXvI/aiZIjKtU8PeXHX5r7zFcavbP3iG3Mnen?=
 =?us-ascii?Q?xFWRTc+O6nc7d8cxbCxV/o6l1PnhMGzijudP4pF/+7l8PpiK96DSqSAQPGv8?=
 =?us-ascii?Q?+1gk0pUjI2DLa4uFMDdfku/xnWbKD2CPtJON6Z6cdx8e6DbokNZ1Jx6DK22Q?=
 =?us-ascii?Q?JrBkQbJ3yWcxad5pZoQjXRI9aDEwieYv1TDPQ6o6vd0okmfk53T57YDtKkm0?=
 =?us-ascii?Q?uNZwQhyTJ+RyWBBg5rZkjl2qEweaTGJj+zWCaMXZ/RHcyw1CDeCmcRWnAkWR?=
 =?us-ascii?Q?Ix76qaIf0xVmKA7GsV3Go1QRh397MJyT+j1Q1n/0esdYDm38iKCM8oQlmzSB?=
 =?us-ascii?Q?UIgh/CIFbjvPk2YhmtfBDWWo4rAIkfc=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6b905c-7e7a-4078-0c70-08da4eb42a51
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:48:13.8162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMozsiVT076W5mOWx++xNy67gC2sozVfE+ruQCTGdn2uUSKX9SEKWtf7bLN+PgCwQIM6R/HPLoKuot00jJhN23c7IdKi+wAYZY6a6Wu7UwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0392
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set CPU thermal critical trip point to the system designed value,
95 degrees for commercial grade modules, 105 for industrial and extended
commercial grade.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index c383e0e4110c..fb7bdf65a0bd 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -642,6 +642,18 @@ &ssi1 {
 	status = "okay";
 };
 
+&temp_trip_crit_commercial {
+	temperature = <95000>;
+};
+
+&temp_trip_crit_ecommercial {
+	temperature = <105000>;
+};
+
+&temp_trip_crit_industrial {
+	temperature = <105000>;
+};
+
 /* Colibri UART_A */
 &uart1 {
 	fsl,dte-mode;
-- 
2.25.1


