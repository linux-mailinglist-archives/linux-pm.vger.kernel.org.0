Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F71554F183
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380378AbiFQHJi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380475AbiFQHJO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:09:14 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8030D663F8
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:09:06 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-N5L7AjIpM1-R7Tf0dWcO5Q-12; Fri, 17 Jun 2022 09:09:03 +0200
X-MC-Unique: N5L7AjIpM1-R7Tf0dWcO5Q-12
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
Subject: [PATCH v2 7/9] ARM: dts: imx7-colibri: Set CPU critical trip point
Date:   Fri, 17 Jun 2022 09:08:45 +0200
Message-ID: <20220617070847.186876-8-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617070847.186876-1-francesco.dolcini@toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::8) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 474c785f-3e1e-47de-ae07-08da50303b52
X-MS-TrafficTypeDiagnostic: GVAP278MB0263:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB02630AA51C32C59E93A34723E2AF9@GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: fSGc89KSvo2vU7DLskadvGjif1AOD8eNSSEviyWGCdqlog43VD4OhPT9GaL8+eCD3SAoEWWr+xcx5fPIK9G6NFLEz138jnLIsGet3LFxXZZd5YONorC3BRcNx/pO5bAc6sAzzS+DjrzyVqVuE3aJgVKCSqawF1JeKfhziQDJIdQDRIIEEqL4ZwrqprfJ3vf/IW+TC8IN8TIJu3r3md4uAwWKzsFj1JSMnTJk+u1TgyUWs5s4Uf2dldvRvmiUL9RuP3hZrp9/R51cs0H8WXp4oQ2LukSVwFBOo+gY6CBb7xpvBMgfbKQdeOO0+lnvCULUFTjoo1vwNBv2l/NiloZl77ULVzlCnoPiud4/feswtHu41zqs+06robyKj6kEsKVstaHrFCtmIjHC4Ln4X8lmJK7Jr8yF8XPY7a8fo4CjMDRZdJz8F0pckt4MBouWIy2b4BcNXqi/kk+3+VgdSXGYHswSG6NOEmz6/bBfKPasfQYywx7y0BzBfVJ4wQT1BFayo1vmbiOTSLLQ1CIAaz1Ftx2oVzVInVVgjbbZ3aHECU+rHuLekpDIN2Khou2wJhSWGFj9USSmFc3HYT1DK1DOBqYlAk3rDzs+2WnXw0zEo8O/yhXonUFPfvPoF4InOpFHcsENilmTxGxYGCxL3p2D/9tAggetS4uNQVJl9PZB2XVe5ydUG1Op3S3qfwa5rOXpiXJ8PLLS5NYE7Vzoqtf20A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(396003)(366004)(38100700002)(6506007)(52116002)(8936002)(6666004)(6512007)(6486002)(26005)(2906002)(110136005)(5660300002)(54906003)(316002)(36756003)(86362001)(4744005)(1076003)(2616005)(41300700001)(66556008)(4326008)(44832011)(8676002)(186003)(66476007)(38350700002)(508600001)(66946007)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZSFBJ/a6U86SHrrKpQArt+Aq1SGB098tcJeDEe0bS4vIUwJwJzgwB2Q02Q+r?=
 =?us-ascii?Q?/gLAFsEL5qwa7hcEzDshmblzlWjG8Vf3RSbqFdTMRjduU+nr0dMxLzWsihDw?=
 =?us-ascii?Q?cYQLu+3Gwketd811MPjmGKA1Dt/tWIu7q6Hi9bE3OBFQmR+9sOqESaEgZtxL?=
 =?us-ascii?Q?OEi8REUInpcPAJJ5UrMKLBl8eSLmwew/L/FpbCd+wnDnQvUyGpBs6aG2VrjH?=
 =?us-ascii?Q?QOyl+Q1i8Jz+LuWqgj596qcd1i8ry/G8kvdt84k80kRgH0ow6yr3gBj+ra6n?=
 =?us-ascii?Q?8pDDZ5nBbySh8x3ql6C8bdgLHTQP0qe5IcfhdPOpE2vWIa5fXJczsbYlsik3?=
 =?us-ascii?Q?k++w5UNKC+VtcHqwETP5wHAlZ3IdPD556Tzj41042bisbfilB3SbXUBVdfK6?=
 =?us-ascii?Q?HYjrLvPTMz2oXQmax7PPwDVcFrzW/BgaUGe7ry0dNV6mYGrjfq1LQ++m0H4J?=
 =?us-ascii?Q?uscnBD1Xzs/6TLfCdczyPQRzhE6kpE/TTYCue0w1tk0VZsoKvVSXTvjjsprF?=
 =?us-ascii?Q?HHSbgrUkDvDM7RTgd+UXpfji/UdCS5WDF4MYwYbHUWlx2GY9aiReXoAGfday?=
 =?us-ascii?Q?y2eJky53DA8dd7avgLUtvbEg8kbidOo3ljit6CLE2BGk6bsCk1QnohYM25Qt?=
 =?us-ascii?Q?CFRYGFwVm5hmxxHxCYbuFGCYZduHuhzJGf0I0mfROsT7LoDzybpFoei+plXU?=
 =?us-ascii?Q?UKNcbWiu9aPp4CEvZS4pL+Hrwe6UQGo9MdtxLatGLhC3SPzRCq8AEqE42CI/?=
 =?us-ascii?Q?NLccSsItjbkBrDKTcmoKws9GKsGZVv132dpW1gztYQ2rCei8ZKm5Vl/EMNa2?=
 =?us-ascii?Q?FRufn+G9cyH89VKFGtDMrv0wjx7lyFfuldLtjh9y3csAffb+ZhUGAAwks/bV?=
 =?us-ascii?Q?wAI0RjCdAaAjKox2dROr+KO3W2gz3CoXXFuMjHqA6Y3jki/3zZQ8dugSeyWD?=
 =?us-ascii?Q?zj482qGudMhnt1hrhSPFyMK9Sx+aClCz2CqseK6caCTh1pBM/RTjJc8Q0Gcp?=
 =?us-ascii?Q?JXE8AycQgVbBoOLPXNy6abJ8YP++lcciL3eLcVTLIZMCxZoxYtEJd8exHySF?=
 =?us-ascii?Q?ojgUsOb2GR0EHmxSRnwdyLSH6FeqABupSSjwlu14Q3hOS7BmL+CaA1KRP6Ps?=
 =?us-ascii?Q?tlhUHDrPxIE42lurcWILKzSy1JcfljgZd3mk6U5HFwZiA7/ZZysj+ypStpNJ?=
 =?us-ascii?Q?Ckoqc/0cTfxjzi2Im2/FCewvgp2gu+HnjLVNBbwkSALTBe4o+ioqL/UVGBYU?=
 =?us-ascii?Q?dVRj1jyNUdRt7PXiZTiyMnwgkFD6evqRA5xBGJsyBGmPlA/IEqxoQxA+69bm?=
 =?us-ascii?Q?l73nGtLT0ne6yr97mW+2GSmkvH+R6gWAyKLshsQtrkzNv7/4vtDjgdsLXHz8?=
 =?us-ascii?Q?2GUTsAfP3HDpNeM8Vgs7r8wOTBu4yiTkJHk4PBGZfULoV3Ojhx/jWh3GPH0S?=
 =?us-ascii?Q?0aXV5I7BGLbMmbPyaiApC6nDsXIGeyIoOEkyOfNuCq29UtszcoBPa4OIQKF5?=
 =?us-ascii?Q?98CGjjz22dtxidxC4rNONg09qITudCeNmZvhbrZKLDKRq01hkcny+lZXtrRd?=
 =?us-ascii?Q?uhp3+OvOs+0vp1wIgngbkpvdc73Cluq0Y5b9rM4Zs3ZuUUx7QdFnYRw8Furn?=
 =?us-ascii?Q?eL6ss9YKKMTcOs1at5Yk0O7LcVDQrMYSr+fnA6ZOX+8iW1FekcmvMqukBzzd?=
 =?us-ascii?Q?uV5wE26ssKKRasAcmYGqyUsGogFxbjQs9shvk7DgktRwtgPZHTSkpoKr2ocE?=
 =?us-ascii?Q?B2EIAMHOMQBYe419qQWcvjDoIbl7NCM=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474c785f-3e1e-47de-ae07-08da50303b52
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:08:51.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOLb3soHnQXdxYL7wQFcd3Ge3TWKrBEzcBVJ2QtxhUON+NWRoeRezWoqz1Buq476a/Le6VxrgOaMIK9tS+vEcO8oPz/sTsyCpxnodqr7voE=
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
 arch/arm/boot/dts/imx7-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index f1c60b0cb143..ac6dfb664d53 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -430,6 +430,18 @@ &sai1 {
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
 	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_ctrl1 &pinctrl_uart1_ctrl2>;
-- 
2.25.1

