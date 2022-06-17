Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051A554F18F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380377AbiFQHJo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380448AbiFQHJU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:09:20 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5115E64D1B
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:09:11 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40--saaJ5-OOJG0XSkmcLbaEg-7; Fri, 17 Jun 2022 09:09:05 +0200
X-MC-Unique: -saaJ5-OOJG0XSkmcLbaEg-7
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
Subject: [PATCH v2 8/9] ARM: dts: imx6ull-colibri: Set CPU critical trip point
Date:   Fri, 17 Jun 2022 09:08:46 +0200
Message-ID: <20220617070847.186876-9-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617070847.186876-1-francesco.dolcini@toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0137.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::29) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4de4c35-15b5-4c54-2305-08da50303bbe
X-MS-TrafficTypeDiagnostic: GVAP278MB0263:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0263CDB48BE6BCDA0D4AE179E2AF9@GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: sDVcDaLdhHcCOlgt7goBsgbX9tZveaNiH0Onfvkhd1/gbuQq/H4nm5zObXmO6v+2mTCKTss+TqN15H76lb5dI4w4fd5G/XEujeGfUK7Up+JI+NftTrluMcwdrM8Q/Qc6v8SLIItbulrg+JOtejIrxUvBxwN+QNyVa0MyJ6A0kqha970k4ta3lTDVocNAQFZh89A445uXqHpNRQlvjDo2dX6BTi07nbVOknntnYgCU5QPAsS7qrNcA1mfragKALiUehBjw+82oQQGfoXVMFX/ePX9uhlAp+C/auFP4nl3ZOV45mZMEEDb7TS1OcUxVCvDj9tr3kE9JKAX0olEApjVpBzhvvGYNozmA/AWWH3e0xcvSODQHL5VMUQTqy6jxtxSelXW7bJu7Tp3JCjGDsd2Xv6WdkF1Mz+x+fMxxQN9vAt/kmxeGStSRYQBJT5QO20PXmrAJ8YNG0gzw04dkimBbLeYCtq0NWs2C81bPTrvW4TAYZ5aJLXZ6du3hKwzcvgHRxqaPuy7kE8JF2y9GgpUya6IZbO9XRH7xVuoOPlbcKqLtYPIuE3nIOm70UPeDno6Xrt32ZfqcEMvWYs5k7nFixwX+/MGeIACbrH1zgIRfnSG86Cc0lcxtNO1ia5JerQz8olSotduPUbMAEmI3qLQDFEI37OhLA0UjXzpxsx16fAgUzeJBzFwV3zdzbe174ddOUzFYcSTIJqORMR2vUpz+vNRYtwTbI+g+1o4YgRN9C8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(396003)(366004)(38100700002)(6506007)(52116002)(8936002)(6666004)(6512007)(6486002)(26005)(83380400001)(2906002)(110136005)(5660300002)(54906003)(316002)(36756003)(86362001)(4744005)(1076003)(2616005)(41300700001)(66556008)(4326008)(44832011)(8676002)(186003)(66476007)(38350700002)(508600001)(66946007)(7416002)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UdZBiEca2sc7VZdEp5IjGge74NSf7kwPte3DpgJHqts1s19kE9QJ07wPu+1t?=
 =?us-ascii?Q?f70DX4aQDffcH5pT0IuUNPekd9dwWPRSNhYgk87bvhlyw1C6kvKIm+5hp85E?=
 =?us-ascii?Q?MBQQ54jVhFIGd7/Qf4VBcqQc2XAQ8aSDGubcAAtXRhdl9ZxUwYRD6tQyJzmf?=
 =?us-ascii?Q?n6XL+qgwqklg9Z9UL5+fhBr4R7FZjHllxnBlPN4zjp3c3Ks4zJDQ134U6v4r?=
 =?us-ascii?Q?ZzOXFQPOPV5x3sjTHs8aWauMIPCpLq0IM4VWgMqPSxsSpBgRsOQUKxM9Pm0t?=
 =?us-ascii?Q?5GMVTU5B03F3ti3LCGuCybu47p/fTq48uHKUdKBL3pG4O1z+F0R1KfnY4ZId?=
 =?us-ascii?Q?VjMcoC9N2xs7jyniEinrhNRuhQEOQDjMBrW1D9ygS95DoG9fXo7Q1jLnSl0a?=
 =?us-ascii?Q?Jmb6Rk7uhJYeuOZIZcDVknqkoX1Bqw7L7GfbElBHsNRagFvBkKzt5bBryO2V?=
 =?us-ascii?Q?3flBeH2K8O/p8ka9ViuNWfrUMKDku9IYr8G0OyQmTjurmBGmTh+zRYHjefvW?=
 =?us-ascii?Q?uu3Ud4riKZbqh4rFuvg0rckucgxSoCjatpnnFtb9ZDq9LRxYi6jhqcDWt/tj?=
 =?us-ascii?Q?I+D25A6iQp8UnECxpEW8PCBAD10T0D6KC7ec1yQdQiOpS6FhL1HF/Hv11F2h?=
 =?us-ascii?Q?MiMHAMW7D+gYNCrwkre3FOynu34b3JY04twDJm52Hsnx7zV95NyeZftRrA/8?=
 =?us-ascii?Q?N8UHGHF2BzUqUsKC03QupDDBgSmvWQKrwGQYcQMfMK2qBEbIFGH4WLVCTVoH?=
 =?us-ascii?Q?zs/GZskJDRCFygFrJHlK4pvMukEXavw/PeZO33EZrMx5cZenEEj8yRYgrz4r?=
 =?us-ascii?Q?3a/F+vTWjbLwB5povxry0p7gj6NziLR0aocXLnPr6CfvuBbC/KsYDxNN9FYw?=
 =?us-ascii?Q?4DE3uECgvrX1QV0rRE9gUsgtx/vElaawcW9UbzhpQeLDqw9Gth3s00oGvuOG?=
 =?us-ascii?Q?i2rxNTxQsn/n84sS9FmKjmLrmbpVyodlUlUMwX7N6hXvoHCkVKvMGEIl2Vuu?=
 =?us-ascii?Q?iIUYu4O5ZThwGoJ2fzE5fV2JiDtbxPXI8o8Pl4zE8cdv1u+EP70pPvwt3Ks0?=
 =?us-ascii?Q?5Q+7DhxMxOGRqrAYoftYS0WWhEWtbqAfYdsPTKvFmADqyG83smXMpHvK2LWc?=
 =?us-ascii?Q?CIcMz91GifwuYaQE6z0xRvpcEm+iZvpxxkgwaHZ39fWVlQacYq92QxBQD2Bf?=
 =?us-ascii?Q?1wRdeCXQ7C4VTHrJ+FhwIY23d/LlVXtvUQmBQc6+km1Ig82lgJEdC9vzjulM?=
 =?us-ascii?Q?2luNaJWW3rK2W1bKkvv3PnbXyjY5cRngjbmRypvGx+WfFARfd6VqgQNmVBXp?=
 =?us-ascii?Q?eZrEXkR2hzRsyKQSFz9jtklvpY0qgZZ72aL224IHnQHt5C4sPeuKzJXmcFz+?=
 =?us-ascii?Q?GsM3bKHurUPwOgyGtscIWiiZBtTTpQRPvrHdmbfz6PlKOyjuf2ydpbwjJ7MD?=
 =?us-ascii?Q?sw6jWg7TFl2x7Mj5TwLJsSddI5xukHWXfVQizDbGwqx0LC8oCAO1AG9AnpQF?=
 =?us-ascii?Q?mk5b+LbzAimWX7+IFZqXGsu0enoC0CPTIDuqG4FzPbYnxiG+elkr1RYNHuBI?=
 =?us-ascii?Q?W8dKK+2Tgv950ZCaIhcjSqRZ+ZDfU0m99/UnZBOSaN6XpTKwUjIb+2HFZbt4?=
 =?us-ascii?Q?VBBrjkkhWTYLrTexSUbFen07mauxsJsVcpY/I4N6QD/BRVenL0c7xntewNG3?=
 =?us-ascii?Q?1jhS5qcgOq47lF2B8vaHONdajYHW0jOGigvCX4j2HnemnPjXoEl/pDMSoU0U?=
 =?us-ascii?Q?3KGE+Zi5NEP1YopM7+enGOHpxacANZo=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4de4c35-15b5-4c54-2305-08da50303bbe
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:08:51.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mD94WAzK+KKu+QO8/JVx5Zjd6Z24XpHu2nhDMB/tvhbt3y4JDLdItNZLGM0ZTX2H3vj1lUoYBhjuKPfkWMi4qQo+K72zxocw/YlzAi1dJaE=
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

