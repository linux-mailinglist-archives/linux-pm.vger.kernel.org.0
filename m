Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B03354C510
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347647AbiFOJsq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 05:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347656AbiFOJs3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:48:29 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E45B46152
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:48:27 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-9iyU_XNcPGWX01L9UTltdw-5; Wed, 15 Jun 2022 11:48:24 +0200
X-MC-Unique: 9iyU_XNcPGWX01L9UTltdw-5
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
Subject: [PATCH v1 7/9] ARM: dts: imx7-colibri: Set CPU critical trip point
Date:   Wed, 15 Jun 2022 11:48:02 +0200
Message-ID: <20220615094804.388280-8-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615094804.388280-1-francesco.dolcini@toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MRXP264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::30) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c12617f-d10c-448a-0c70-08da4eb42a51
X-MS-TrafficTypeDiagnostic: GVAP278MB0392:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0392F8248E5EEEBAD5E5B11AE2AD9@GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: e8DVSRR05NOV2HjIYt55xaG6YFNT1gzfBh+Xh2QyHDiss4r4HvIfIuNIRGiHhzwX9HvBpSbW7zqNVqPyHvL2QPEhVNBthv2UmVu0Ub+6dTQhIOSxi29Tt2LOFVCT1djTb5X+uhKFTExcqJ6emKHJZKoEHxGRXbxqT6Obz6UKM8ZnRGGdgR4R76UEb71MQpoMrzqMe9ofoZiE4/MwgXfOjHsmwkTdpH+I1g8e5t2nvZyOw8GMy99gXp+AMoKV+Jk7ORQ1aVXhPWI6ugjsRpWHTHGg6g8gKmI9fJjlpXE/aVgJzC6JwdXTDf8d1ae99DusguEh8DNm5QRRr3Am/GTFYjdrtaGVG920gEJqEQ7h9tdzY7XOL5fn168PeLcwswo1LoMuStd+KMfMkQNqHoY2VKfGs4MQyZuzawZ1+uQpgWq7LKvHaazdk9YVB0j7V3Nma+CIygyky6ysi6AsVS8BarujbrTWw3h4Ba7UfV46FsYyTHsCmZRqoVLN/3KVRHWDCwDYTRISTuEYuy7T6r3PcMOirdyFSATVypaAPJ+Y9RPsDPhH4YtEqUMn9Ku+wNcYxFiUL/EtIe0a+EKZ6HDM3qKxRDo7i1MoBoCNS69X2ugaFApd6ACvLn3BQkuajaBgSnb7xq2X4yPjGIsfNGj1AW2917MBsh7p5S9+e7z91teRz+V0l8DMfY3Izb1UFm15xaDUMUhVrkb8vHnO5Q3xBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39850400004)(346002)(366004)(1076003)(41300700001)(2616005)(8676002)(110136005)(8936002)(6666004)(316002)(66946007)(508600001)(4326008)(86362001)(66556008)(54906003)(66476007)(26005)(52116002)(6512007)(6506007)(36756003)(2906002)(38350700002)(38100700002)(4744005)(44832011)(5660300002)(6486002)(186003)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I3lcCpRkG1SFKtT+xAv8Wq9HsQi150ZnnhQyPtA18CUr0y3S/R6zDERXM4Gt?=
 =?us-ascii?Q?1EuTpawjOl+ZEuuIAy3dLPYYs7prgng20E3hj8+v/PpGi1XIbKJHnUr4IjiP?=
 =?us-ascii?Q?vvgmdzH7Q6dX+zOUPPbE5qSQ7t8pxY8b3rrNDRjJXmXQR1JvcclzpJieiltG?=
 =?us-ascii?Q?n4aDxguruT1oq6bib/vJUbtnxen32nj25mlNnb1eXPp/iJTGE3+JeFZa0KG6?=
 =?us-ascii?Q?T28IHs0lPgELdpIYp0TF0BJKXpQD3H9UIrwREHP0CNHyoEMIFkLihfRSP4Ij?=
 =?us-ascii?Q?SsGL/vDuzqK08e6scyCsEf7nXe0JDX9eSmRWGyNs0Xd7PThergTfsrsIq0o6?=
 =?us-ascii?Q?/1cKVsPTitYkbLIyxOTiUgtvh7J1tARjYgDJ+h9vqhIx3RUZzK89xgBMpApM?=
 =?us-ascii?Q?Hl9OVhiCAYSDGz/8OoC6PRvMNLzqMZvLEJDU01/Fi/bqvHa+2UZ19Cr3Zig9?=
 =?us-ascii?Q?AS3jWWZ9ubcQx6enXlD1X+iiSHbOyAgOdecJBxuXn4wl9aiJ7M2Vs+MbUxCg?=
 =?us-ascii?Q?LnFkktEzpK8HRxNja9b4XJdkvkHRy9XGWHqUDJ4W8Q3p4paUl7dcQ9HtZ2wq?=
 =?us-ascii?Q?Wss6CmjF9ZlcHnY6DAzh3nI2YIHcuxcZsy9yg4lOvuigfZLxz24c9O/OnXCX?=
 =?us-ascii?Q?hmfBE8AV08XaGCIxE3qFaWtsLzciKKL2Ij5fpYJH1Afi3sxYl+kDdm2hhLzM?=
 =?us-ascii?Q?G5rJrjuRUnBLWRlQPEDiMIRUik+piPNWOhR9phwjHcnDMNyvIbXSf4Ng/o+e?=
 =?us-ascii?Q?2drHMQ+Z8/kkQR7qJQX0Eq0Jho/qTOaXI9ATEQ8E9UAmeBlCkX2JcMr9hpCg?=
 =?us-ascii?Q?2FQv/p4s1pulOJUooj7GSPCcvRjZLrh68jjJOliW+5fvzWSbN9y9vXBvF3kr?=
 =?us-ascii?Q?sej9Ik0Wn/IwxBCV6W6go+WWSajOHfVPwrAgkl0UjBCYbwr5/qTyYn2+onR4?=
 =?us-ascii?Q?fUhJuvhsc8ZRg9aVQqLoKidgiIWUT4GrJJk+Zfeh/ZChaeNlyZrhhOVh15yh?=
 =?us-ascii?Q?sudNVTABAfKG+UFr4OOx5LsE+Km+31rf0zqAJS/zV0xGbylKqRdI52sCWrDQ?=
 =?us-ascii?Q?G43LTs0JdvLI5HWvnRb4srOaR1PFWsSKaHJK7UPrEGlidchZdhER/x7Ljsio?=
 =?us-ascii?Q?GU8oN/qR9zdPOiIKE6kRLWuZGKqpOgW3U11m8hf1tBJxrQ50f6+ShYZFZWG1?=
 =?us-ascii?Q?Mx6YDwr7TVYfc+Kn7y5Ia3LXeZEanuxOdUlSjzia11obsNrx6KmiB4JHd2xT?=
 =?us-ascii?Q?G/Y0VpRGb+o2latRp1ZBIuFmj+Uvskm7unWOT/Yf00H7TBbSHvUsAIxAxgN4?=
 =?us-ascii?Q?YFkwLK0NJz1q5wGYEMApdH83PM4B+FH6eAUX86Cb4RTk3pC1/B4bEEhlycsB?=
 =?us-ascii?Q?DT4CMOfVI1uv4ww1WH9jevxi0I5EKzpvg7E9Q8BBPqyolvBqaFmAwMrL1ji1?=
 =?us-ascii?Q?NlEStuOtfjct06wdlHhBD+l3XyhUGVck6C8LBadYaWX1oex6lieZUQ5RAw0B?=
 =?us-ascii?Q?O39E1LmPmBFjQVxlXMl1koeG04mjK5INTe9i5H4dJpOBOnEscW4R3VWXHDAQ?=
 =?us-ascii?Q?VVvjAgvhbxjIpT7PyaEsESERNsnEJhOjh0Ji7gWp1zAJ9yxKyUlUb0eiz50u?=
 =?us-ascii?Q?M7tLyVf2uC5O/sYBlXdXN9dKVemFuHvM0dv2e5MZNStnFZKGM8XACw7pW9lK?=
 =?us-ascii?Q?2ymQB5MBfna2B6qyHL/IvUYw/Sa1/UuXRjv5+fWj4omMet3bCMR02sCD3dHL?=
 =?us-ascii?Q?Gyff4oqBIv+gHkPh9EeKi7yOOMz+goQ=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c12617f-d10c-448a-0c70-08da4eb42a51
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:48:13.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPvH0cumFHnxo7/y9u8QG10mnfJJZ+OSKHMKJfqjAXFSPxjI0tEJdUDRz61FfonFZLpAg4kC8IfcRPRXQoUddWxjdZNgMo3ZVS3dc9cnuNc=
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


