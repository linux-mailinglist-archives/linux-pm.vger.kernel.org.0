Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5956454F1B6
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380531AbiFQHOh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380557AbiFQHOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:14:23 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3884E64D34
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:14:21 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-kr8K9Y_-OVy8Xr5IL6v1ZA-3; Fri, 17 Jun 2022 09:14:19 +0200
X-MC-Unique: kr8K9Y_-OVy8Xr5IL6v1ZA-3
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
Subject: [RESEND PATCH v2 8/9] ARM: dts: imx6ull-colibri: Set CPU critical trip point
Date:   Fri, 17 Jun 2022 09:14:10 +0200
Message-ID: <20220617071411.187542-9-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::28) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f642753b-293b-4bfa-0e50-08da5030fbc0
X-MS-TrafficTypeDiagnostic: GVAP278MB0438:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB04389E823D99D82819740085E2AF9@GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 66j8AAIcqEpxJ0f7CdWdipkebCd8dD60CMTUg37/6K39xYhXLlIQYFloNrO5PV0/v/zoYhOKbWh1/MC75hRL9nYNsMNVbtpggvycKYartGZud63jR/HAo85njPIzERTUNSt/BBnrBd3lXciEF6jKWNdmppG0ieiTJTMJ0TVsjG6WCdpXXWdosG6UQNctrvDTDZDlEehkFv2a+y35p6XVR+02YfL1rf7yCZvMSjUNg2Tlwrxa4AgXanFb85m1cVPx5RWTKDzg63wkvijArqa+r+288BCVpzVBUjRti5bcKXpPVYmYcy5j4DXDDLxJVnbFvxB3uJKhScy0Z3qq94HB7r/Hq/8bCdPfnMiq2YytBUiHRDLfOc2pi+ZDvzlz0K6wkjB+WYPm9BTMjVnobZo2dB6+xN9qyiDz9AaEX0eiYig43viFinlYTk5pcQlYz+V/ItvCQM0K6F8UTGYfUSQIXhDVbJAIXNzeCGK+TKcmfn4Ht6i7quAvE2Wx7u4BntK7zXBBsuRXf59rhUsivzjOdySjjAzJqSUE/TWFiyTxX0fn4mdSgvC/1dWmedAhJxq47elzpNXZSLZiPf9JEJrelypMq9i5DCkZlZBmmK+JlqiNLAvp0e/JFO+x44IdFXH2IySbRB1ih9xhhWhoad4Myx5Sqav4JN/sP+8RKWr1f3mH/NOEmKZXtL9rKW93K7UqlpzWD++22ZxsEymBHayn7DBtNBDBHaezdHstpF0ga1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39850400004)(346002)(52116002)(38100700002)(38350700002)(6506007)(2906002)(8676002)(8936002)(6666004)(6486002)(316002)(66946007)(86362001)(7416002)(508600001)(5660300002)(4744005)(44832011)(83380400001)(110136005)(41300700001)(2616005)(26005)(6512007)(36756003)(66556008)(54906003)(4326008)(66476007)(186003)(1076003)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?scI5x1UqLnLE6NkVod/HCB52nKxfs3+4OH0jHsKpg8qbAby77mrAaZeRIQD1?=
 =?us-ascii?Q?6zHJZvaemUAxnFfwZqk6t+lSHsO/pmoVwyTu6tKP8bLVMJyWvKggQwZWGBjY?=
 =?us-ascii?Q?wi7iez8L44ZlLMwh5Jl5Pn8JGpGXSL6x0SV0nwSaXGjm6YXXEbdpNk0vlnoO?=
 =?us-ascii?Q?sGT4svQ0ChTqlUAH2F5NbH+/HZhGDvBEbw1xR4/2EkTxHeyJ1NrTitanaX3B?=
 =?us-ascii?Q?MfE3u/en4jeRrQwBbKNNHeTUKk5ePawEew22MwRxf7qPWhqOzzZoBGpo8JLu?=
 =?us-ascii?Q?ukbNBgcHA0B6eergY5d6dval7TMWibuultEaqJsfSiBMdh5UFZ3Yc9NLbijU?=
 =?us-ascii?Q?ZSghYdVK5q/yXq9ocWoT/pjSn6DnKR07A0MTb1F66zi5SJAav5el8aRnlUbj?=
 =?us-ascii?Q?M8N1cAXNzzK8fPxNW/AUYf+U8qAXCpjhGzrjAG9FtDo3EdcsKPY/nIWpKnHe?=
 =?us-ascii?Q?fiFZVkJWC1rsAmcM/WsvAbAv3WtAPqs2528Xi6Mr/rYawZn35CmgYuhW3coR?=
 =?us-ascii?Q?Z6pXDU/ahsi3tNU4Hk56jOPr54YV2zSArs8SPfqSD72yP6SCKTonUNkL66q/?=
 =?us-ascii?Q?GGrQPpWks00Lc5s/dtxaYNz8ocqvjVVx8IgZuN1LFQG0JFWep9o5avUNTPG6?=
 =?us-ascii?Q?3NtO9278Hr3ydnVuYFAmXsxSoORluQqDkihjY3s4bSAqPWaktSd7fbM0qNSq?=
 =?us-ascii?Q?ZN5Qzgwp66n2gPh3WsubYEFpLNwJbcSTjzXHf5mt5kUgRfZmcGjzKpB48yT6?=
 =?us-ascii?Q?0bdoAqUOhC1dGfsHjDKLEcB7TFjTnnakEyvDgHcpRECt2q9Rp+UIcRkZf7pG?=
 =?us-ascii?Q?muYjo6EB8jRSF3aoFezUbQoLi5/iHAdfUTNv8s7zhNiGLZMrz1RbWN+2uAur?=
 =?us-ascii?Q?FpXMMv3SBE4+q8F/c5YOBXkRZ/mfJ5in/HXsGX7lmHdYts//kNrrt/dJKhL7?=
 =?us-ascii?Q?3i6TKMsu4CNXosKGPosV3DJz9BEaU0e6WuLeFtTJ5vTVtY8PY7sE3oDNkOTY?=
 =?us-ascii?Q?EQFEgRYgwo9oB27y1Hal6K2o443LhVlsZRxXJH60Fiu/puNs92pHkxZz9fcg?=
 =?us-ascii?Q?Axv1n59qbRwi9wR0IcmFpFcxcl/6B6Vav9ItYpB7SbIyDbuDTDbTAy/2U8pt?=
 =?us-ascii?Q?8PGUPeCauGZGUEdHwyPDAVV6+t9MCDTHKUYgcMZwRF/+xedHMA82RJOJVowG?=
 =?us-ascii?Q?Rft29rck+z9SCyKQdC0+KvkrijT8QBZKa5cjg3eUq/YTMfNoj46uN9hqE3yk?=
 =?us-ascii?Q?zqBwtlw2hKlb4dHAWJdplifCRAPXnisrl7VUsg4GdaQYv6qX0Kz/a+AcRW1R?=
 =?us-ascii?Q?yknWZWzVxGlawoL1sO04bUzBVeCUF0lonhbsx4lcPOqVesLmYLfMCfWvmKjR?=
 =?us-ascii?Q?zpxzSQQbrl48BpNhLUSd5d0G5uzU8mTN6X4zW60cZwj4Jh08A3NgOtSB+Pav?=
 =?us-ascii?Q?49Tyf//Jr/wCzPxDE6XawCRjS308mwfR+Rh4VFF6vD3ZJDr5TT+TyGFCCebK?=
 =?us-ascii?Q?Js5if3MKEOaUojZQppsrTqVLx7NUjc7rN7rckxeI6vTuqZRn0l1SiB27nBvV?=
 =?us-ascii?Q?HiKOSvv7P9JCkWt3awRFIHdjjpcO6+ogrQKUCoth2NBkFbrmB8h+ISJ80H2O?=
 =?us-ascii?Q?56KXSxFOySoeVPQpL+C1ne8xt478ZKRw+3/CywNjiCvG7uPw1bzgpOjUuNAf?=
 =?us-ascii?Q?ZH65IynW/OAcc7unZsVmd+b/t/pIVOKqzhxB/RobsRXKXvaCRxrKVqrY8u5W?=
 =?us-ascii?Q?OUMopeD8cUZENtr1vSfbXe6+lzSmgJE=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f642753b-293b-4bfa-0e50-08da5030fbc0
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:14:13.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS7W8aZpdEb2oCMYq0bQHkAXbWr2Eng6ysFnRKcj10E+8A+8KVa99uuLeffR0elwO6EL3R+ZLKPHF2bjUwOH0m8srKTs/YjFiFSJnrBe4Gk=
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
 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 15621e03fa4d..6d8e1ef0315b 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -250,6 +250,18 @@ &snvs_pwrkey {
 	status = "disabled";
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
 	pinctrl-names = "default";
-- 
2.25.1

