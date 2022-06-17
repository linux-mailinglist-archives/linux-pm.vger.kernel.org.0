Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DF354F1A7
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380411AbiFQHO3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380516AbiFQHOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:14:23 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 683303B576
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:14:20 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-xDFvHCdgPGmF3hygdP8L-g-3; Fri, 17 Jun 2022 09:14:18 +0200
X-MC-Unique: xDFvHCdgPGmF3hygdP8L-g-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 07:14:15 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:14:15 +0000
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
Subject: [RESEND PATCH v2 7/9] ARM: dts: imx7-colibri: Set CPU critical trip point
Date:   Fri, 17 Jun 2022 09:14:09 +0200
Message-ID: <20220617071411.187542-8-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0125.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::17) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 328ffabe-5b14-41e3-0e50-08da5030fbc0
X-MS-TrafficTypeDiagnostic: GVAP278MB0438:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0438F7DD01D9D33A8FB25086E2AF9@GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: CcRPJB/N17m8iMhN29EGL9KPTvkSZLcyiSL7B0LlOSZ57JfPJb/0ihZojT+iNejYL0vVWwuFjnhN3ugGXxX0IAXOIilig1Bwz4CO735i7QLaP0f6iab7zAOHgePTWBhP3nfzk6KgO1lQ3b1e/yJgeiogZjMdIyZD+s/QJhIMFj2gXtgiW6NOMXaaOwpU91PUtVVhezPnNpT4Zl/65rcfXLb0YdJPBQSPZEslHvnrusV6HQ4RfsBtDsLxo5guJ+x9XJRWHeqeAsYQsWJgiViiYEMyQVJAagqDpxquP2VIGbRLA2pveQ6aMQHmG7ng96mShnwtxNd4efDOozDY5PuPqBGPEJrwDbCaTsRSZRGf+WS1c9fPUnTzFr7YFaWl1+d4xcrmXVgJnxFONtuTq58Zx6dGMM+3ESxzcQqsLUw5tiE+xmnxLP5+zyNzXPdxKaV48cl1Dr5vqKzP1Cv45qrW0AbSEOmvZ03aqQ4HyhJ+ByeJMXgPUyvEhI0TBqf8ju3ditsKUFkYgxdcRZHXpHakWoAkgDbUxLbh39J9ZmXbyxoH0Z0oIDTtqrHXg0pOO/Ep92g/7r9D4c4GQgy4QokPhv36CbbHcngL6ypVb6wJGe7uaptIthho/mWQubs7yhTZT/T/foiJxeRqM05JLaV+JdVkjrMUpWUQDoYx//hpeRiTWZ46sUdr8BjfA976SSWhwKfm7mhgVrR2uC9/eQUm2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39850400004)(346002)(52116002)(38100700002)(38350700002)(6506007)(2906002)(8676002)(8936002)(6666004)(6486002)(316002)(66946007)(86362001)(7416002)(508600001)(5660300002)(4744005)(44832011)(110136005)(41300700001)(2616005)(26005)(6512007)(36756003)(66556008)(54906003)(4326008)(66476007)(186003)(1076003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?56Z7SPS8MjoHmm2SPtm3kDA+aCWAVeNFuwpDv1X5kyJsKwcTQfnj7aSWSL1g?=
 =?us-ascii?Q?E94pZKrb0o7Rg/GUguImF4RRU0565tP19SSaOwgAqz9fazi02InFdtcM9JJV?=
 =?us-ascii?Q?K4Do2kmZvhfkki2powaEVmW2c5zVLpswqPJcUcNLMR+I7RFHbZ5pc7SqWTzG?=
 =?us-ascii?Q?lFvqx6SsQ1sg9//5TWUqcCTXCmTx1z37vWZndJ1ELwLp3rRqUgia2qu9VRg4?=
 =?us-ascii?Q?7q1qSfuD4Dgpbs+w4Nt0Ro41Dur9hHzNTEuFTdYylu2AexMapZuqu6mgBnpe?=
 =?us-ascii?Q?K+Mh4QpFjq8QYvrUoplkeW0mssliJWkGu3O1evqh6RAKdoGFY3zQL0nErSGa?=
 =?us-ascii?Q?DUXBrbVeHe8VovwTlQVjlCc7rPkaMZq4iYjsX3uepbe9norbkGNEt2yN7G4/?=
 =?us-ascii?Q?fRlJNprwmwAzoMyqP7uV4z9IsBDg/RIu2dVCslgAiM4gzhFlgKRxzoKE7BYx?=
 =?us-ascii?Q?Fj3/L7d0nRmniaSuMNMDfXYHJubhyF/GsayB9oAk/wXZ9ztovkzWWIX3AuIs?=
 =?us-ascii?Q?qrynJfKGwvLhXAnHgxPyk7wfhNMfYwNwU30fl5bayxRgGZh1UQgg5Kixf4vv?=
 =?us-ascii?Q?+5wX9xQvRBlt0hH8eMBxj84UKgFY60L59yQhBJwWRWcr/MpL87FaLbRVxZ+Q?=
 =?us-ascii?Q?/oU9Q5bJst38dQYWWiR7UjCw5XRNOLOIVaZIQg5HxE6Uet5HeYGulca6pSAY?=
 =?us-ascii?Q?VshouYZ0qyCcCwxgG2Qmgl+qPHogj/R2+HZAJFH1d2ckJ+RfBfrVkuD54pB+?=
 =?us-ascii?Q?pQ2wiKqhv88Ca3nFa5J95SF/KjtXk8j5zN3msWAmCPgexlf9MSue7bhv+6qv?=
 =?us-ascii?Q?YhgCNrd3PYKX7NTOiiLRA6LOkyYez6GhCGvjp4xiL210nsO0UW9C22mmYBCo?=
 =?us-ascii?Q?t1ZV+om7YSdrg/TCIQt72wiSdbyiMCqlNwla08YJLzcPa4Qr5PmZl1CwEAIA?=
 =?us-ascii?Q?IyJ6ZYN1X9NS3O0fZVbhyryHwY1IJtlGv8H8Jsq30Q3YyCnymuHc7g2yeZPo?=
 =?us-ascii?Q?aVslfrOrNB5GDIiVKSq0egknM9G0r04gPCBo3NCx15aTMUHPKuwIsAmos1m4?=
 =?us-ascii?Q?WUl6LOiTVGfmKB0fjdbMsstvrPv4IDmlOwRbZkr0P5b7+JrKABd1TVVC9fxs?=
 =?us-ascii?Q?gtxKTu3a8NpOQqzcuytCwgVheESsit98QZxWe29sL8cwZqsfYUJGMLpgX5tn?=
 =?us-ascii?Q?HxgZxVUAdHUpA5ppN01UfTK5dKsvfiZKYZctTQEWo8eAmirEq4Wc674w3rJt?=
 =?us-ascii?Q?SzH2a5217BhtTgFITdPAUOPh926i11ZcxC7oywJbBYTFLWW4s4wSSiAOshWu?=
 =?us-ascii?Q?GP4Cek6Grz7/D8226wsBDJsy5SnWeGkFeIoJaRM78lM6dqtL8jbBlsoEwQe/?=
 =?us-ascii?Q?Gz+4m7fmIhX2if75UWpII4MSM+vlWcbi+wEtWDW0Eb04rRYuM+Wo5xR1Cala?=
 =?us-ascii?Q?V1sJfdWVMD2+7N9zJ4Du6jJfleblfLFXNJ8qrtO8oAe9T91IVOVo14Ensw3J?=
 =?us-ascii?Q?V2qAP/9WcVEPh0kUQDoZV7PvlNzq3JP0fXZiZm+3DXny4A0qxpobVBuuhsdG?=
 =?us-ascii?Q?JrtdDm5BPiqk8WegXhntbPN0mmyOWUxhcLrxxCvdVO7OL5uijU7b/aEKLFHN?=
 =?us-ascii?Q?mMfPQhkbNNu/UXdTLFYL7Ng3r3lstiaUn2Kj9RWlhjYuJyESNKIGLa5kY3N5?=
 =?us-ascii?Q?/H1cNduXpnJJo7p44Ob98bGKi41+8XI59gUKkEHtHqjWrgrIC1VM+9w/GS5t?=
 =?us-ascii?Q?IobSNfRvOCiZtQzbeW8HP37dpaV5oZA=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328ffabe-5b14-41e3-0e50-08da5030fbc0
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:14:13.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2AbWysX2wu0+k04HEnwfcc1lXbqDILbzRZ8CkyPtgHx4xI1UJr/CDmZvsb7l3nNnHCZ5kPaDuiXuFzOwIcpJnyXen0sjO1+VM7BY7feFW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0438
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

