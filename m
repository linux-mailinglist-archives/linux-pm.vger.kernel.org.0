Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD27854C4FE
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347754AbiFOJsi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbiFOJsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:48:19 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C79B46C81
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:48:17 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-RqphdaogNVWFegoWSJIB5A-1; Wed, 15 Jun 2022 11:48:14 +0200
X-MC-Unique: RqphdaogNVWFegoWSJIB5A-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Wed, 15 Jun 2022 09:48:12 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 09:48:12 +0000
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
Subject: [PATCH v1 0/9] imx: thermal: Allow trip point configuration from DT
Date:   Wed, 15 Jun 2022 11:47:55 +0200
Message-ID: <20220615094804.388280-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MR1P264CA0129.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::17) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 956e8808-a572-43d0-8ac6-08da4eb429b3
X-MS-TrafficTypeDiagnostic: GVAP278MB0392:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB039252A2E4910D3881E994ADE2AD9@GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: LeyOCdmS0hjhO5dlvpsdY6mQgG7unc5L+vPR0c2T5evyiPV6QJlUcQFvPC/pQj7+Ag4TqX2wPWXDYG8xjVW1lSspUx8RSlzA6UQZg0YpWKFF3V8FKgKxTScJIwOZoAEd7NzOBT5ZxX7AHf5TtEdxnKSeSZgWNRD//A4CS9rRTNecdVA79YSxIyaT/WAFXH/nKAzEka245/ujP0EGNUWvUtdkhQC5sogrP/8NBtdYAFMnsLF+fqkddld740nBIK1Yw+WUj4nOtKfXrYeIlIDf7uCCCIxZgI/KGjdy41hS6/IO3A/UDPm8owMMycUOIwxCFe2CzWEo9NfP491knB3OT99Ca9lqHK77dD1iMCFPQ+NiJHDzDbUh0RTzph0ro1d21z0ko5UfdgXg8WIJH4SAtL5o2BaMV8ra0tgWRjiH7+YFjOPaOP8EMzHfkqtVa+48BFELtPMxt11PTzQIzGg1qQBdoSKqRYUrLwRHUr7/L5l3eA6Rg6Fh9wO1sJqyY5ZElQ2dPHSwbxHK+gLArYPYNd5tIjZh9M8WFmSgKC7rkXLR31T7e6IJeFUV8aHcpgsl5F6FFtDxtfEEcvPyL0ZPcUQw7RMF3OYVuUqOIn6h7e+srCBI7ZygOQk9avO63RpM1yNT9VGcbN3SeR8kzo1O17P7fexiUbtdEVutdMhsdzMla50LA9krpkp3rFK/5UC0nLEUqp5DlyAPgInlimTPj3PUfp/CX+UNASuHifM3eoT0qwm4m8H96FEMjcx5NXSdkx3vonYY1LsKI401iHDTF9RR8V3Pr/Fx5Bq9abyEGMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39850400004)(346002)(366004)(1076003)(41300700001)(2616005)(8676002)(110136005)(8936002)(6666004)(316002)(66946007)(508600001)(4326008)(86362001)(66556008)(54906003)(66476007)(26005)(52116002)(6512007)(6506007)(36756003)(2906002)(38350700002)(966005)(83380400001)(38100700002)(44832011)(5660300002)(6486002)(186003)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yp2M7ClJ7gJhnB55i8Tk0phArTI5jKrkc66P8hLF7QMqt85HbEEL6kkB7pfI?=
 =?us-ascii?Q?M+51jDykfINqfXUbbUyScwNqf76AZSNdHlehaULGDOOwZQc+jXXHORL3+3KX?=
 =?us-ascii?Q?8YvtgXpxoIWRPbai1Y5XJfa+ClghmRqfM/9TVFFECElMAUTF+ZHRwR9bSQK1?=
 =?us-ascii?Q?QqwTZ9VrRYDIq0MhKuzcGnAyZSMo8Szp+BE20UuPZ8zcfGZ68KuxP81iuI+8?=
 =?us-ascii?Q?OUehGMcicRdyWZ8y8D9NOgoVk7hvSY21aL9ncjgdU0FNjF3SUz3QA3yP/S3h?=
 =?us-ascii?Q?AqWFf+6JYsZSUm3/D+Rhi69gvnkSmZJKw21swmOZhHxQc2ZorOyg1JaOY+1t?=
 =?us-ascii?Q?vcJaTbJ/nrOBCj1XZiofmD1PNJI7ii1D7/4SE8QXn8iekl3GH2HgtwbIBTfT?=
 =?us-ascii?Q?A7WmCJZFXhsNRhc11yhzY2T67PatjZym4q9f9hJJVG9shMJlMLmlN6w6xNqz?=
 =?us-ascii?Q?O2ZsN6gs0hBfoyGT0F554KzZsLcsdEj7/yCPm3dHZlS5Y1oMI1xBxk5Vj+3y?=
 =?us-ascii?Q?t9LFmQoAO70aKQxUuM+x6z29HRQkg08K8T0vmvnG4LJGszmcgh90KLeLfWvE?=
 =?us-ascii?Q?M8WtJ86ZcI1BtO9RnB6xhHVPjoC5qKsicDsinQl7b1Hk/XqW+0LH7sA+zleS?=
 =?us-ascii?Q?CxymMTxpL4jSt+6nxuvZ7+V5Ej9RaF7/jy+3qgnOV2BNI4WthmKIMuZxURHb?=
 =?us-ascii?Q?4qJsKViR2UvdoX9IS0fD+mXLm9fzh8sg+z3rg9k36wO2BbpScP66/H+6W0WS?=
 =?us-ascii?Q?yn93EtSxHa2Kdpa/UWE67WROjUXyp+SBbvzzuIrIBwRD6KkhM4GhIFr3Im4R?=
 =?us-ascii?Q?ZmH57N8+70RQPVmFfSjglmscn9lMRm3iqCucPEvYwEP1OOb81B+o8hwR+0yG?=
 =?us-ascii?Q?NJYDz6stWJAxAyAbkWRK5a/8QouGzWjnwdd8RwaD58NTAlEPiwimT4Cgn+LD?=
 =?us-ascii?Q?WmpzGOWpvKHCztolpdxZD8u4ZXFHQj5K0QIQu/Rt4ba5F3b0US96xsJ1a9gY?=
 =?us-ascii?Q?9Hjlr4IgTOCfcxsdsg95/yOzu7UYZRx2RvHI1dGJWSuvQTnjxsETASBGHQh7?=
 =?us-ascii?Q?YDJHlntTvZvXtIFXrJzPUSx3BbAaSKtAnPkk2+7bb0fI6dZb8CAEQDb0QL7z?=
 =?us-ascii?Q?ryu5ge1+ffEa0nnvXbYN2fP1AdJrJf0s4MSrZea0goCWWH0A4n0r4Bke0Thi?=
 =?us-ascii?Q?+cRdqC395omM8zW5QPRbKFcOb1YG7jn44gVeuA3jHjIXpYTJMR3QoMLJ9J59?=
 =?us-ascii?Q?rww7UivlTF9hFQdqECPa9xIkbeMNsZRd1BtQZiL0QTmVGNJbqwSpMiR0Elxp?=
 =?us-ascii?Q?s6Ethag0nKc1lE3EijsvKILyBCLSlN/lW3lt9JiiVt9B1W4mCJ6uKFsl2XVt?=
 =?us-ascii?Q?9vd/Sd3RBrDscaGegOyWC3S72Ymb9+roXYFpIYwIzVPNqYRM2zAhbUhbJak/?=
 =?us-ascii?Q?E+VvPIStUCUkkpeOu5sE5zKFEri3yOc509RTcs8HjeueUOlQKYHqgMbxh+Ac?=
 =?us-ascii?Q?I+31ZyUgcn9FMOeUDImPjSsjlIQG8FPJojhq0qatWHwnaS/88SRjBY+Zd+HM?=
 =?us-ascii?Q?TaMwbc2xgjx80ZwvAEKDagI4uDg3S2LSOAXUyngOI0nnSEs58tWCVU047GYb?=
 =?us-ascii?Q?HImRQ80uq6tWOkx7ljwDrF89mo/W/exw2NDk44fTLDV8V0zChVpnxAqDBYwb?=
 =?us-ascii?Q?qKwADhoxJMxH7iy1WaEJZA8/ETDbStpZLLzWF84Vi1DuIqenc5kvN9ti4o6c?=
 =?us-ascii?Q?Wd/2UwVCpiXLCreI8Q19dEeN/15Qi8k=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956e8808-a572-43d0-8ac6-08da4eb429b3
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:48:12.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmCPKpPz2xYSWHv/gjruDplj3qAxcy3K809om/dp41BSjz8XvNjllsAILyGrSfymmIYJnHC8apr01kuWf0peDUgUkD9PW7fyglieKwbjVYk=
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

This series allows to specify the imx thermal drivers trip point from the device tree,
without this change the threshold are hard-coded and this might not be correct given the
thermal design of the final system.

This change is backward compatible with the existing device tree, and even
with this change in by default the thresholds are the same as before.

Toradex board are also updated to use a system-specific thresholds.

Discussion on the current design is here:
https://lore.kernel.org/all/4ba1d7d2-3e8c-ba60-37fd-9598f415c076@linaro.org/

One side note, after this change the dtbs checker starts complaining with this message

```
linux/arch/arm/boot/dts/imx6dl-alti6p.dtb: tempmon: '#thermal-sensor-cells' does not match any of the regexes: '^(automotive|commercial|extended-commercial|industrial)-thermal$', 'pinctrl-[0-9]+'
	From schema: linux/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
```

to my understanding this is just a side effect, '#thermal-sensor-cells' is not changed in
any way by this series. I can fix that, I wonder if I should remove the property from the
imx dtsi files or add it to the binding yaml definition, not sure about it.
Anybody can advise?


Francesco Dolcini (9):
  dt-bindings: thermal: Define trips node in $defs
  thermal: thermal: Export OF trip helper function
  dt-bindings: thermal: imx: Add trips point
  imx: thermal: Configure trip point from DT
  ARM: dts: imx[67]: Add trips points
  ARM: dts: imx6qdl-apalis: Set CPU critical trip point
  ARM: dts: imx7-colibri: Set CPU critical trip point
  ARM: dts: imx6ull-colibri: Set CPU critical trip point
  ARM: dts: imx6qdl-colibri: Set CPU critical trip point

 .../bindings/thermal/imx-thermal.yaml         |  27 ++++
 .../bindings/thermal/thermal-zones.yaml       | 130 +++++++++---------
 arch/arm/boot/dts/imx-thermal.dtsi            |  61 ++++++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         |  12 ++
 arch/arm/boot/dts/imx6qdl-colibri.dtsi        |  12 ++
 arch/arm/boot/dts/imx6qdl.dtsi                |   2 +
 arch/arm/boot/dts/imx6sl.dtsi                 |   2 +
 arch/arm/boot/dts/imx6sll.dtsi                |   2 +
 arch/arm/boot/dts/imx6sx.dtsi                 |   2 +
 arch/arm/boot/dts/imx6ul.dtsi                 |   2 +
 arch/arm/boot/dts/imx6ull-colibri.dtsi        |  12 ++
 arch/arm/boot/dts/imx7-colibri.dtsi           |  12 ++
 arch/arm/boot/dts/imx7s.dtsi                  |   2 +
 drivers/thermal/imx_thermal.c                 |  49 +++++++
 drivers/thermal/thermal_core.h                |   7 +
 drivers/thermal/thermal_of.c                  |   5 +-
 16 files changed, 274 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx-thermal.dtsi

-- 
2.25.1


