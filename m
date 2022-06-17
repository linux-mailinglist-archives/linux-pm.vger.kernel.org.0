Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B1C54F18A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380571AbiFQHJp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380538AbiFQHJT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:09:19 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4EF23BBC6
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:09:10 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-Yw9DEakvNPyFAuOQiXgZzw-6; Fri, 17 Jun 2022 09:09:04 +0200
X-MC-Unique: Yw9DEakvNPyFAuOQiXgZzw-6
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 07:08:52 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:08:52 +0000
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
Subject: [PATCH v2 9/9] ARM: dts: imx6qdl-colibri: Set CPU critical trip point
Date:   Fri, 17 Jun 2022 09:08:47 +0200
Message-ID: <20220617070847.186876-10-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617070847.186876-1-francesco.dolcini@toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0116.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::34) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a747e867-0bda-4e2d-2305-08da50303bbe
X-MS-TrafficTypeDiagnostic: GVAP278MB0263:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0263885C0BBAF44466B0F36FE2AF9@GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: zGVITcGRqMzFRHnhsrFb1nVX3R5+ZoC/9rNjnPhUAbjBY7/5xMtwarvJcCOV7yTjxyfqQEfv5a6A3c8xLo2NqEMWdzVjifbAsNKkRyTS1/BBSt/yh3IO/VaqFSLhVIGU1+a2VbPU7MBxXiXgBbvdrZ/aSJrSB+pvtQ2mnYij6bPcpehnXdb2ujsnZjM6PTytfUhYf9ycpksdKAR6o3fpgkHrcpL8XQpBJC51GtM6YAeXWQfPNs4AmCDqgGaf6gyaSIbxVG2hinFnR2AYK86MCxbapm0fvVH42cQCVzbghx57OhsKvUxnscS/PdBiU4jIfmejasmo1hkYZAILK4TwjzNIZQ/2rp/X0bQ2K46rQ7p0DMXX7IDDZWn1WOHS952pd4lRHfOhY5/b3/rtAK9hXCC4pZ5f1iN0nxG49645si3ww7xOqXLjQzdBlnTeiI5anB2YrncBI+e7Bf/esTTFet+apqFuoZR9wmJjm21XcG9ryBvPrrrBsD5G/nXK+ZwasEKjIEKWZJ1aVrJI9vEs7wm+vpX9F/TQm4PY632/FU4ZkDyiAWlN0Xbj2IYnxKvU99ywITxP/5KDmV37E284d7TMwzbf05382EeAbuN5xsl9Ne/cxMCPx64gX6tlSd1IGhAmv5NZwrM6Ub76zg0TH1OMRQhvY/4qbukKhOhc13XG52EBm/lNx8jJqxCGCL1aYKfo+rQIHBXIk4oR5loVeNMfasEIM8cPqWr/SuwdTb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(396003)(366004)(38100700002)(6506007)(52116002)(8936002)(6666004)(6512007)(6486002)(26005)(2906002)(110136005)(5660300002)(54906003)(316002)(36756003)(86362001)(4744005)(1076003)(2616005)(41300700001)(66556008)(4326008)(44832011)(8676002)(186003)(66476007)(38350700002)(508600001)(66946007)(7416002)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/95c4sCqRcp+tSsfVTZSq+z1rrgXUFUAwINJsC9VUIWNisEFR3aL/6kg/rbF?=
 =?us-ascii?Q?WYlK0OrIb94xA8GfLn/rCmr39Ui28OIg5iw7pJ/0k5vk4qFEl7u9ak0cCQ+1?=
 =?us-ascii?Q?rB+eP7CRPDiCG8GEQoBDfj2SqXbUTBJt3zxkPCrECUU3xWHSQ2hDtkvF/Cz1?=
 =?us-ascii?Q?fg0azebMlU7xT4uaSGjK0MbjJU9QsXp3qDn/QJlj9jaYWIu179FAAqi/JK8t?=
 =?us-ascii?Q?NnNMvJBy6+Su+pfec8QGHCQik6eJKZWw5+8LN+x2abw0wTZ2r1Vgggiq3hd7?=
 =?us-ascii?Q?0VyaHS7yg6Ln+QadIU+q2pkPLAf24ynKiLnG8K80ajYXDChUvW2JHxzIVN3n?=
 =?us-ascii?Q?TZ9NdzxyUISC24oIEq/h12zJNzb9KxjyWdWA8Pjhp7vNUU58hJOFOTD8hLAR?=
 =?us-ascii?Q?GVqLeikQBPZugla7o7bUGiEWdwlSXxnKaxllBtZV1yCmi/B2rcEqekskYYyN?=
 =?us-ascii?Q?R8lu4su0bXHXYcXfCVuFy3zkDrJ6K3ft86Wqqt+jsI9nAP0Tb2IU2VjLJ2PB?=
 =?us-ascii?Q?zJ8AQbFZHiqqofLFF1yytpbMng59ne2v5Kgfintkvn8h+YR2nAREL1i8AuKT?=
 =?us-ascii?Q?3watvvTAGAdiiHSSz+5NPjYWTqLRD6k6rOjk8lKAW5nJv18tC8kAPQo3QP2/?=
 =?us-ascii?Q?dPEcRTUlWbqlXxrW0oOT4gQeUr/rf0UqiPO3H+iEEJA7lgB8AzvsikArQyrw?=
 =?us-ascii?Q?gL+MsL142UKCOP9YhXdic4rcbmMXm+826qMvvHNvAWZUC2Q6UGW1mCYht7Pc?=
 =?us-ascii?Q?PhbnvdrSZKNPW9yu8XCTeO8R3VA8h7Y3T5MZYYl9G+zYquQip3hu97hrkl2b?=
 =?us-ascii?Q?9hhr2C6Noqk1EqiGNDHoNoVEWTjeeqZEQiUt1LweZ0RrXh1w9UaitOisEzu1?=
 =?us-ascii?Q?emTVEg7MucbhSmsc+a//WKzFZIx51B0EahLbLCdnN1TrZg+l2FDQtxlnguBZ?=
 =?us-ascii?Q?vRTA4bb8wwNPCXya3ReYswERr07BHKRS6Ymchfls8/NTFDkY3AyG7AfId6Ng?=
 =?us-ascii?Q?BW0mH5h22/KKWp4Q9Em9ryb3ll8UfdTUzfDyGE4HJ3+dLvfinK8Qdg+YyKg0?=
 =?us-ascii?Q?68kqP+Bq4sTls/kdWetUerEi3wEx7SfNLYbYh84BthkIVN8mijGjCQ83F6tN?=
 =?us-ascii?Q?+O2xtdPOPoMbgKOFkWQ+YzsvmyjxByskxPcbSWvxKyyFu3c+jtB1w3ldISHQ?=
 =?us-ascii?Q?h23AFHa927Y7AM9wYYpEGDlX6bt3KFoaoblVK6Sv+mO5/qDaS9RKHiEtAEp6?=
 =?us-ascii?Q?RvItGD6cOnm6/ixG9ZL/hXycg+2PWKR82ucQ0fAQxcVGadJbzCnpqj+7EmYG?=
 =?us-ascii?Q?hVANzwDCxojw5RAIF5x6bMyh6Ts1zooWi9SqEMdWwViJxBPT+fZN7RL1IqbR?=
 =?us-ascii?Q?qQxGdu9mYlEq3uxChJ/GL7LVM9UpABm4dwwGZZCgH+kdQ/UQNSqlClAOSZ/W?=
 =?us-ascii?Q?7uDHnbbUPxgBKsDcBOMVt2JbEzC3lsL5qm29aJIpCq1KwD9/0UEIGbDd4y9v?=
 =?us-ascii?Q?eeL+hpgXa0SeWluPnus0LMqTO5lfTO2uIRTnKsSufANbZFaSJ2J83B8fLxm3?=
 =?us-ascii?Q?bqE2hMOrOJ5LAZwi5D7MZRy/PAutGx3Z1UZj2q5ZRFIleuTefy35W0ufBZRS?=
 =?us-ascii?Q?KbOEEYgrAYEzQoq4S7Kt5owL8Za3OHxZNlzIKocnxeBjn9IMx8PWmF+asbKF?=
 =?us-ascii?Q?iygR3wXh/iC8AfPvwj6MbxKD88g5BYwThHgw6Imi7uvjm+uAsisrULYxaCIM?=
 =?us-ascii?Q?/E24oVFTmaODBYc5AsbTXCC+rJSKshA=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a747e867-0bda-4e2d-2305-08da50303bbe
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:08:51.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPUlNHuSDf79ev0tzDnQvipP4LQ/4HJpsIIMQMe2LdAp17wIPXMoWxivNKFnsUuWCVaWvJQSVSLQswPNf5bEySzYhZTIukd7eyd8R7YybKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0263
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

