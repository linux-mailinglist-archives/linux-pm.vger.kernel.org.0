Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACEA54F1AF
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380543AbiFQHOd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380555AbiFQHOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:14:23 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5392764D33
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:14:22 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-3GkfPEIeOEKpj6nYUFmeog-2; Fri, 17 Jun 2022 09:14:17 +0200
X-MC-Unique: 3GkfPEIeOEKpj6nYUFmeog-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0347.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:33::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Fri, 17 Jun 2022 07:14:16 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:14:16 +0000
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
Subject: [RESEND PATCH v2 9/9] ARM: dts: imx6qdl-colibri: Set CPU critical trip point
Date:   Fri, 17 Jun 2022 09:14:11 +0200
Message-ID: <20220617071411.187542-10-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0179.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::18)
 To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 249b8380-29b7-452d-5fd6-08da5030fbe6
X-MS-TrafficTypeDiagnostic: ZR0P278MB0347:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB0347234C3995322D7CD9998BE2AF9@ZR0P278MB0347.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: Zq8t3IAnX//xpP1sdnezoxxzn7M1j5WnSdQ2PVkV3yUvawrseyLdXyeQC4VqsNQ9MpvXAxg9JdSI104XbdNRuHuhWFKU5MP2AaY4w3l3yt6cP2xmoc5Y2ngBr1vKk+AjAn2v6BbIqS0v5uNU/9ybA2cRJs2PVB+MhJcV3zEUruXSEnuXBSNqRvIO67+EmgV68Lni341hcx003H0PVrB9SxSFcasj3oZdFiQjsd7qzEBO+HBGzvPDGul1g6HgVFjP/e85renDYjMgkGLRXqHDMDkFbO1qqlgrp90oOx8qkaG4LCOG52riQa/j3Ys/mOVwSbK22TQqIpjBhevmEuHPE9d2uSR9i/K7iYZGddr5qMpig8uDWC2CL5LD4YNSKpjXoBrVF1J8ggmyW5wv1LulBrPoImDn4EWPPe4kJlyBR2Hcoy/z/BtfTbENQb9RQTusecof9fIJ615QgrQiFa3ne7OKbxOuA2Brw/WBHNXPQffZIM5doGJEKgGKtPh5wim6w5HPDhWSvxkeIxaCofN+QldST+FC7qH5dltBE/61v13SiTsKGh5Q6W4NuO6KVq4eqW20izHpddcHcDrKa/OWSiiIZQyUHPyTLeFCjGcQDwyHjdS2y55WRCkUfq1ZRe8J+oIzzwrlP2LzWuljgAiQzxYe+rhqW/Ctd4T4g+Bk7evam24mbB34+f8lxU8pggihQrAueEvqJHWalFCpuUoj2P9icFZunqrNOGT0wYLsF04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39840400004)(346002)(396003)(66556008)(2906002)(36756003)(66946007)(8936002)(4326008)(8676002)(5660300002)(86362001)(6512007)(52116002)(44832011)(38350700002)(4744005)(6506007)(6486002)(38100700002)(41300700001)(2616005)(7416002)(186003)(66476007)(508600001)(6666004)(110136005)(1076003)(316002)(54906003)(26005)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ENE6wqM1pDkTRAEyWRcLmnFUVOMx+Xaw09I9fi7kTErAJ79yn5iilDUZhmiq?=
 =?us-ascii?Q?DQjAA8KDq5X3Y4zFXHf6S005i8YdRC/FG7+UQhWB868byv0tQsyY9SLaq/8q?=
 =?us-ascii?Q?Nf3oHHS7KsJ20r3DhJ05i3hoOKvuzHFx0XtYWBT2BxUFumUhLRU8gW5O6WZh?=
 =?us-ascii?Q?UBmOZpLLOpWcZtQOtRX+yNCfu+f/gMyL7qTp3cJT9azY27qzaslXf0g1ewb1?=
 =?us-ascii?Q?mye/1czPoIzRH7+zZU85wOvCb0AiwbYRoSrLvog5fy/ECxEIzI9AQvmJsUnq?=
 =?us-ascii?Q?7IgHmHwunMTXHuUhvNlHfaO7jGaWdV6nxfuz6bXBHp3RdSP3ljZ3kbsBbkxI?=
 =?us-ascii?Q?TU4vEsVkQ/B1vOZweGWoCuQhh3vBk+YDy6l/mCVpgfbwHXK8xHvWowMj3Z1W?=
 =?us-ascii?Q?o11IxEat7leO7nagDnqGlZ/qFc4keRgwtC9j2ZUvXGLOs71goE1fFb9hEYL+?=
 =?us-ascii?Q?m1xhBukFrqZVC+sneDUZWibASFGUaZvky/4Ra89OYt5wi12H2lMZuIstIBam?=
 =?us-ascii?Q?qkxUi7zqiJAO45kF9CZ9ylAOLvgu1eUEtNda1GShf8FLT7sYKZY20E/mvrMq?=
 =?us-ascii?Q?xsE57UXErmJ8Njnl63disxBynyube41lBa6Yko4wXXGde0pwjhdy5xOk8oNj?=
 =?us-ascii?Q?aTm7D4RPZlPOPs9uiELah7GAv1xm9CUd11Y8F9WqQexPmGLbHXm2XZ3sfG8x?=
 =?us-ascii?Q?G00IBGiYrr30DKqzNOS+DgG9GiGE+Dj7rjonO4xR3az2VhRke4cmDhTNXt8g?=
 =?us-ascii?Q?6UBDRa1rmCJdHXoEmStj+Kk5DjiBEcdZlESFK8/3d/ED+GDmPkopWX5LWoIP?=
 =?us-ascii?Q?8iTzEFtsprdjz9sFDDKz/VIR8iuSyvAJEXM0QiEp8o6zMhkpUlAmSYV+kfF7?=
 =?us-ascii?Q?lE4o69WrKVVgEK8lOtRZWs/d4Ud5AEq+NUc3+4yZI6vShpE8q1v+CAX1epd9?=
 =?us-ascii?Q?p9Kr+OIhnZ5SS4BqPiH+hXAtEEKTNyQCEQXJNsgRMnniA+XAoLhhkH8j/CJO?=
 =?us-ascii?Q?WztcruqQNEaSV/8RVyghYJEDvq5UDKlrCtp0HXQ5Tw0Tdp8+AGWRns9uI+rr?=
 =?us-ascii?Q?h7O+RjCahrzXAkSLQoZSaCjwg51BoDjmfwbxVnLoX00yVF6GRCi7i8xGpQ6d?=
 =?us-ascii?Q?2Q5vwcKfyMOftzVGjdCQiQcFlLJmmJvr5CQElGVMigrzWAoM34pm35iCp1Uz?=
 =?us-ascii?Q?EExJdRewZMyLeCsF/9L5bkEdJ4j4l3a05vXvrLFCi22vXRpPhWdCs0dLzSpV?=
 =?us-ascii?Q?Gm9EpqyJ/A467F7v9ca9De0TgLsAVQj89JVnlK4gNJtiROvvZ3DnqfyQ8q7y?=
 =?us-ascii?Q?Q0tslsFzDjx7HlwSfgQO6jO/F95nhUczA08SOX1gPf5ktKTa4lXrzv8/1FsZ?=
 =?us-ascii?Q?Abzx5Y9fmlabxVuBwhlFVlGfNsv9F/1QHSuE8n3irIMcFBYZuxkIDjoB6rsV?=
 =?us-ascii?Q?o52J+BDQFcXoB8QcPQxFjfiEMq6kNuiQ3hUiHB1q6tb1mSj53ySFw1qGvbMS?=
 =?us-ascii?Q?vocqqwpWy7+MKYbOA4k41J48Lq5fIvf+CswoEolCdbiTRznjizFgYX13a9Ds?=
 =?us-ascii?Q?Ivu24d/4RKKv+qr46Jv3mksUCl9iEeBEU8SyutPva4OSztuUUcPE4ipv9yir?=
 =?us-ascii?Q?+e7DunsFhELw4fUEwNsDqWcOex8OzHkREPCcU11DCItb0GP8xotAb3Q3Au3L?=
 =?us-ascii?Q?H2Tg7OJCDYPpcV1FJcyTHeJ1M5JVk91sr0jq5zc8bO0mbDxzahVSAydsk2uo?=
 =?us-ascii?Q?e0lBRND4aXfgXgu5XriQRzmNfRIwz6Y=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249b8380-29b7-452d-5fd6-08da5030fbe6
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:14:14.2115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtVhXgbWM6+pxs8T8VVZTeL98pseiMwV6KqeCWSkweuRoGf0d4zrOxniKUEkkeSGQqt7Wy2RT88KB/mxssDqTdaizcaddfn1QpER3+NrqrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0347
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
v2: no changes
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

