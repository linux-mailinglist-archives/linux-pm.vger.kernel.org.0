Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998D54F172
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380526AbiFQHJ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380518AbiFQHJI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:09:08 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EB0065D34
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:09:01 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2043.outbound.protection.outlook.com [104.47.22.43]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-xghosZeTMpWkYXLUSFePJw-3; Fri, 17 Jun 2022 09:08:59 +0200
X-MC-Unique: xghosZeTMpWkYXLUSFePJw-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 07:08:52 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:08:51 +0000
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
Subject: [PATCH v2 6/9] ARM: dts: imx6qdl-apalis: Set CPU critical trip point
Date:   Fri, 17 Jun 2022 09:08:44 +0200
Message-ID: <20220617070847.186876-7-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617070847.186876-1-francesco.dolcini@toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0122.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::14) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81aa5d90-ee26-4742-c2b9-08da50303b46
X-MS-TrafficTypeDiagnostic: GVAP278MB0263:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0263384AFF7054A66718317EE2AF9@GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: NLF4dgtkU9yzmS0Yw2Akm+BsrSo980UjCrzaIeE8dhbwx3RJ4y5QyCJj8uxTwE2uhFyX82JCwaqdIi89yt44TTYlWwXDxK/L5k8tyi0juOm8UVdH59yUO4tLOFhDV/Y+DVO2GX5TfCWOgUVEEJUcWeXLS5iXCO8oHjCa6ViJrQhfRUv1J4N3SBU3/UaR6HSYeGOb736Q+Pbctnsbzn7FQE+jIRuXFcx0KdcAPEXYXDjz0bl5hFXGNpiGULRwolmCmomt9JNAqvkQ6tj78i0IQYmSRDbEiDF9VK1rgK4AioMuVirG79Hd9PiLfxKRWGuwJj0FwjlDKJeI6FvqEqE31Yoc1v0djPZWJk+v2ThZQSEg8kOb8IMV9Vsrkz5vmtbQc5R8K+RvBB4+GeDOryAu4Q5e5xzbd+Er0JO5Uko5CCJb1CDaLKcH3tIKvfzC/KXmrJxbLq4XCD4dMMxqZ7cHS94jdGvjH8GtI4rB5rcKzlYKHVq2ydYFo/PnBfUh7BgPcmgynTPQWWsiatTL78b5o0XsvFcJc5JrpwTswl+ufZHXPtuylnZogpvKsI6wnlNqFJuamBXvVcc2w7u+rqJKxBiASiDz/kEQFISF2whdAPwFiqeDQVFuseloNn+/BYIKcaMuB74pr7dBhtcLijXFcmu6LbWJibGJQt0STBMq0FV8aaAxU01DFw9IBfmolhToevH4WM7jKjBJtWGy2kV8myowVOi0TcyDGTgkkxY3EqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(396003)(366004)(38100700002)(6506007)(52116002)(8936002)(6666004)(6512007)(6486002)(26005)(2906002)(110136005)(5660300002)(54906003)(316002)(36756003)(86362001)(4744005)(1076003)(2616005)(41300700001)(66556008)(4326008)(44832011)(8676002)(186003)(66476007)(38350700002)(508600001)(66946007)(7416002)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Fi0sxHw6RsVeLFrGhcAbArFZfF1XoLeeN+wgn2ADQKWzGJf3zoVRDfRQmDY?=
 =?us-ascii?Q?8ajctRjY+5jTibFjHURFCjwMuLBR/p31h28Iz2gLRfvocApxrwPFXQ4RD8mA?=
 =?us-ascii?Q?gfetjzB4gUpB8K8httD5TWOUEPBLCKz/M4Pmms8GdTBlKuSDYPmlYbiEuchV?=
 =?us-ascii?Q?dt2geailM7y33AV4HXhtWZxgnX5+X8kf10HRQT3RwF9orNNgUbtC2E0QpDUj?=
 =?us-ascii?Q?npkqyhXnf2EQNkFwq59SoGlad0+MdX6ujb3SHXo3DPCHqbossGpJjDNJl/YG?=
 =?us-ascii?Q?O7WgR9nPRLgt8vMQJG2Lv+pEg5HB+jn8xLTpoo4RN7mVbLhM2F82roM96m3K?=
 =?us-ascii?Q?8vhqelUp6491R0/WdXH4b0uWpkQEiHdEH05K5u8DVxLk2cZAZLautywBdgsA?=
 =?us-ascii?Q?kRaYYpT1NpJgNyTPxj5f7FNIb3ZFASlcmUhCQGajapDO2Da3Xei9ij9DNN4B?=
 =?us-ascii?Q?+aruux8LRBH7FVt4wX7spUQWRDNoRmY4EPZ4OLTbqx61utaHke2sGPSj/p1X?=
 =?us-ascii?Q?o04LWovuEmA1a0E0xznX6wRTKvddrcaEgXA/BboDqOpTNSNvUhDqXy02CWKc?=
 =?us-ascii?Q?AnLE1nEI6CTVcPTTUAIrjMz1Aolms+t8uFRCmJKwvtL9pLXsboBtoyt7U4Lw?=
 =?us-ascii?Q?zq08NJXCv8tXTJXI32dun3S8Uh/3oqskrrsMTHwOvJA5eT4HQ70/jI7KPL4U?=
 =?us-ascii?Q?2gBZLqK1BAJLt0sYh0xPhfH65lhsV8N4dI3rdWmiH8uT7p0AtNtFkUvyDzuL?=
 =?us-ascii?Q?rm9eZ1nWFjTJkntPr1LKi8tSu/naR+/mc75IxDyd1hp81iK7pGcp6yj/EH3I?=
 =?us-ascii?Q?E3NbV+Wcrihoh6k5dTRa4YAIq0ZYbfSMkRgJwrPSFddde5pBiVHsSJnuEv4j?=
 =?us-ascii?Q?SXWSYdUN2ZraYfZg+5kif63f9JSzZaFr/BalKaS881dagJV3QvYPYPH+aA7l?=
 =?us-ascii?Q?9nko9eQ5E5hvmheabpY8soJJ6QG8E9uYyoow/v3p2wURJpuv0PzxjGGlJIOS?=
 =?us-ascii?Q?Nw/E4/Vkp5wCKjDV76I2ymapqljq9pqkf/LosBaT/JGt13ZwrAGLdpXxQUk7?=
 =?us-ascii?Q?cFjghMoYP+yzV+c9WgTLNoL9mitgr2XgyEjs6bO+kz5wFRhPM60MQx//j3YF?=
 =?us-ascii?Q?4vdTlgsLjthCkEUF1mS19OcCyIOrooGQ+GzvtWBBjT+F3m7RZTuSpimSTCMn?=
 =?us-ascii?Q?LsJoFKkhQWCzH9pevBx6cgpXM3YlWH4+8MwZWeV+7WpF/VO2s2EU4VpgV1T6?=
 =?us-ascii?Q?9eSrm0aKEOfI2F9dl2nHptgqe40d5C7bHZxb7f2kop3DwJeiXL7AyqXbh3bQ?=
 =?us-ascii?Q?80E39ue6pxFBCy9gEA7RBGP1A6t3qQsSf8mNaqIw0hPCucWSTjEpqIZQMSZD?=
 =?us-ascii?Q?6kOm1BA6c6ML4hJAdVlviZM9uyQYRmIFLX/NZlKgGLAJfr1UO9sAFeY2okDq?=
 =?us-ascii?Q?Bti/rQGPrfFMiQjaCpS0M0vU9CeozZ9mzXvrfoRS4Qlii5/s1xhcUfrplsKj?=
 =?us-ascii?Q?YDzcK50mvDeuuT5mM6VM4sVFG4tU1kaPpOHEuYNN/tNvjBjvPdhW7VO+XTiW?=
 =?us-ascii?Q?5I/6fsNDOWZECbjika3e/ao+UsQ/qmz02nnp6cKCDa7r2f/BmPbOhrzRVbWv?=
 =?us-ascii?Q?a6vWv3W/lxlIdcG450MBSk97fJV9vZYYRJPL5wu2ayqHPH2qkqg+Jzo4Bt/n?=
 =?us-ascii?Q?YddpJCIWrWwCFAo6M8O4IFV9azpgu54EIluSULxZHdqdrYQpT2mS4td0trxc?=
 =?us-ascii?Q?XYtdi6bTSFP/Zb2BugXnVmBqjYHq/hg=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81aa5d90-ee26-4742-c2b9-08da50303b46
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:08:51.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8N0dw3Lxq0tHU0DruxnrXC/RPGs+udBi+uEjr5KgEP3YhVtsmmBqoMROPL2FpJyRpc+9uVmL8tUv9i3l/pT0qJaloBbuacgyU6Z6jYHJ1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0263
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
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index bd763bae596b..21ee16f3926f 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -390,6 +390,18 @@ &ssi1 {
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
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_dte &pinctrl_uart1_ctrl>;
-- 
2.25.1

