Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A554F1B4
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380490AbiFQHOg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380547AbiFQHOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:14:23 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2EA014D3E
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:14:21 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-9WKeBhhoNa6RWYcw5-vY6g-3; Fri, 17 Jun 2022 09:14:18 +0200
X-MC-Unique: 9WKeBhhoNa6RWYcw5-vY6g-3
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
Subject: [RESEND PATCH v2 6/9] ARM: dts: imx6qdl-apalis: Set CPU critical trip point
Date:   Fri, 17 Jun 2022 09:14:08 +0200
Message-ID: <20220617071411.187542-7-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0122.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::14) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 483fa76f-11e1-49dd-e324-08da5030fc2d
X-MS-TrafficTypeDiagnostic: ZR0P278MB0347:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB03471241582A60FEB7274D8BE2AF9@ZR0P278MB0347.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: pgLxwHgFF4UdaWnWezfdryIZv+YnveZ+cfoV7dQ7UR3PYy3HupDizn5AxA+YUhPbL5AXNlnWtvi4+ILYCU49tNICtpxXRZk6PYnjT/gXQhL4FV2HlFsrtkaJjqaRtEvBX1QS+wLXCbZDEmMTNkMeJj1EwDhNbuSDGoFKHr5WPXX1mw53DlitgeEo+Iakh17/vfLM7049TnW6ev1dZuSfUTftLsDkwq4kFZktl/wCFr3HheXAwbzq17g2inndtdrqQQ3fuCM+aCMNRZ6FwlkES9JTWlFJ4bwevJq5Xc4Q6gBObGHrLIXcyFJWG1copVydiRera2UeqVAWVFIhOWZvUSxvRZIuLFiwg8uDJ5kVhQkuJ+1F3h73AO5K0WHJqfW/2RQi5dQmvuFvu4lw2+4G0p7OzGoBVmWMylrQCy73Q6LCfwJoVMOR27We6UgwhaiQd5nFKXByzGs7jrnpS2oErHrrxfkpZPJM6k8FGGWRz+gzsiunAIfCWZUt6QYmhGqCWjCC3xHAQPP6HtatVsnOiv7kEWWPkQ1YYYri9b4e+xhgj18ROqQfXOt9veOzm4z8Ybac+tRRZ/Uw2wWTbSQultxI4pJJIz18f5xVfExm0jaZP+9hMTkdOPJ4DNHc3tyvKauGavWEaMbi+2oeN2L1T5XYNPPPw4eIFDTqDrPreZjOap8ZntXG1EhdzXWiRhCZqul3Run+UE8C7dvS8V+PQ55pvIh/RWzOOFiqE0JlD9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39840400004)(346002)(396003)(66556008)(2906002)(36756003)(66946007)(8936002)(4326008)(8676002)(5660300002)(86362001)(6512007)(52116002)(44832011)(38350700002)(4744005)(6506007)(6486002)(38100700002)(41300700001)(2616005)(7416002)(186003)(66476007)(508600001)(6666004)(110136005)(1076003)(316002)(54906003)(26005)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PFIryXpO5Up8hWt32p0+n3wqae+cW9aU4r53b+fyJEBP5ss8hVK34H6KXKED?=
 =?us-ascii?Q?i4c4wD2V0Oo30Ge3cbucMoQSFIck49kDTsRXIgtqe7oLSt9qztVs9w7ofZbE?=
 =?us-ascii?Q?AOQw1eUuR49rjNB1AqTgMPgidXJkzci/MdTW6kamncCuRjzsdPHFLwXPtOmw?=
 =?us-ascii?Q?WCCcovnMWZRGx/Jkt6uxQhEFdutAf7UEYQpnab1sKrm4zFMhAsBVixFNd3hs?=
 =?us-ascii?Q?piG+ybBgG0DuWGd2E0D7uaie0BcNQS0SJ3MSgIB9C/6shPYTsUSOFsw+7F+a?=
 =?us-ascii?Q?4Xa45WErxfcX/yK45R2HIbqZZG24Y1DHZvTNd6kJIvEDFqLM/6l5pOTc4Z0K?=
 =?us-ascii?Q?+MjITtCXzORkLjMjIAmiQyByBfwfVn7o1zu8rzlUhKCWdT3DwmvuLTg2auQR?=
 =?us-ascii?Q?T4fXdFKdo+BGaB+R/U/Yd7gAy3iWGpbMMz1CkM9uCphvurssbbdSdEGlIc5q?=
 =?us-ascii?Q?NO8f/PAtyIhWfpSp3vW5m1WbRUkKO9c0uflCvi90aYURck6bWWlTwFXCB0ep?=
 =?us-ascii?Q?kKjVdyWKQEIakhJlmZFrfkgZErxbAVbWjlaSGLRbXcc5Wfmx6oum6ckv89AV?=
 =?us-ascii?Q?NUItoBfog6MR/+SYUJYyDDaNC0G2ZQEz2XFldEqvVSbYKiM3KCFA26ewLeBs?=
 =?us-ascii?Q?MvhBAz+caByh/9DbEZLeWwHs1k7uUnyzJyHMo7ZhAt37X8zt8jN/Gy5pzelD?=
 =?us-ascii?Q?ysBpPpTi/QNTXmpaQ3LXiRt7V+KpgFqdkrLBCGXniBAB/zFmpd2DP3l1NDY1?=
 =?us-ascii?Q?F0wh9VO/4ys4f4wzKsz6nIT2IzZhkc1E9cnWNMtFG+PauKghAFb9CLnlm4v+?=
 =?us-ascii?Q?w+551Vzw8alLoWoKGgk9t/zpylLXQ8tK696uxukK7sxn19FqbV3U776J+w53?=
 =?us-ascii?Q?ym8nIG2cXTZ7KZUXiXT7YJTuNxBuLbvmLPGZ5QOZwbOHRf4MUV5Z/W9siSHJ?=
 =?us-ascii?Q?0Y+QAkQHptP3mwYk/wypycytb9ct+aNHpzqGizp0GrFsFyH4S08g+lqXxzO7?=
 =?us-ascii?Q?c599megnQoxg38AccnUSCBKlg8w47BgBBvlfr5NSmpiz3+TriEz4n0eEBC5r?=
 =?us-ascii?Q?KfcKBj1V4IHa9M0iB9G2N9uKmqS47ajruIZLy+sh+zM0lH4RBWYns9NgUWwJ?=
 =?us-ascii?Q?adBAKqOaweZeK2WTuFU706XKBNxCacMtttHzL2LEVbiEKgRWI9SZlVabPnUA?=
 =?us-ascii?Q?KCxtwPGolAAa33HO7jvWNgeQBa1/yStgLCFhoYUZj/NxcZKE7gHTC2cTYpyZ?=
 =?us-ascii?Q?7nAvGtZwFgQdZysRigulxP8wM4o3VTxcJHlC8H604Moh4O9ksXr028FhUWyK?=
 =?us-ascii?Q?gabu+iYO07+H+uTM22tDufp8bknAa6mlMU2qrca3hIpEjtDIWCiPhR9fEOA2?=
 =?us-ascii?Q?Xh25x9RR75KVYkOIhoFNbgYx+YkunA/KXIyVJjzEIcx7ELOtuqH0tSsT+q5H?=
 =?us-ascii?Q?EgqeR/JAwFV1V6sTt1o/llacGA4bTtiHPkw6Fe5C0Xyd6r5uQHtCluqiOZBL?=
 =?us-ascii?Q?2AhwQZur6SMbB7NXi+kJqchO0c9IlR9pnb9wlQV6ayPPOn7ifJx+AdrLQ1lA?=
 =?us-ascii?Q?8IldAXtST5X6Lap9zOQyeTxMw7etVsuTYAbVKaStwNmcnU1C1IeLI2y3V1WS?=
 =?us-ascii?Q?+dafnyKZRGtu5kgh623mz+UVaevtCrgGsaU4YjLWFRwOgSGas/x1toDQmakz?=
 =?us-ascii?Q?DDUYzR3SdPWyqAAcK1ntW9OnNTs/jJAzHAzgU9T6ZiNdEGaClrv6dpRn0s8l?=
 =?us-ascii?Q?vHEUbXRVfIHK+/hO/br8VsHANwbtwf8=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483fa76f-11e1-49dd-e324-08da5030fc2d
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:14:14.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joqhYq7DjMAh7+0sq8XhsI0nesv8z2b+10Ln0kho8AAAgb6GcWXdkLaCSzSvTnNc8DGCNzmvVqUkEf7MDMnmKpC2ZwJ5QlMgunseN5SEyLA=
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

