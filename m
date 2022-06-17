Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6846354F1AD
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380536AbiFQHOc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380543AbiFQHOV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:14:21 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E119265D01
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:14:18 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-YO6aamJEPsWg7gNkNp5Few-1; Fri, 17 Jun 2022 09:14:16 +0200
X-MC-Unique: YO6aamJEPsWg7gNkNp5Few-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 07:14:13 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:14:13 +0000
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
Subject: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point configuration from DT
Date:   Fri, 17 Jun 2022 09:14:02 +0200
Message-ID: <20220617071411.187542-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MR2P264CA0137.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::29) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8117fbf-3ae8-4d67-19dc-08da5030fb44
X-MS-TrafficTypeDiagnostic: GVAP278MB0438:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB04381F67FD59AA5FA2754737E2AF9@GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: y0mplDaC7HgihdNPrMxsmgZXc3TgLIo7oWp+Rj/ZOqM1xNtxFXH9I1dbFQe41A7So0jAlxiDvo5RZPDD6YT+Bw3Z7RxlOD28CDeubyFKKE08/yLez1pfTKwERl6stZsrOHaVPt12Gpqdup59CUpXpsKScKq83XS8STGJYTIutIk4oHXoIPfW5ZrK0ruQ8DGaVemqM4x1FNASXzxKtBU4U7rxDLahf1bTawoXpgzbciQaIop7kv5uPtcZvIK0r/ZloqyVgPgYLNpyHZuLLoQ+aqgNwc6fz9TDGoVYKvaXqGYLJYJBbiV4Nc70/7sSZ36bQHbDAKfeJGB+PCWjMo7vWZp6C1yrfHMtLfxsrHPr9d6mtnrCf/EOVwQDDdVup69jWiGv5+DOuTaLuDiX3vVuyqyR+sdMdVBx5HFp3yIDRI/fS06wv5a+UMUe2t+soqhW/y3+AwFGCJ1XmCPl+ksLh23Y6SflrontkhvpuEm/S9nzqJCfR6rKHQ42lbJKgg/wQjmhf7ahIsJwkXYmkXAyEWNSz2kJTAhVVNittDYPvelnMAs3uz7JD/3Qr+5PwniV+9LF0Vg1OAbXb549x1r02zkHqvHU6SlpBnci9E1jflRtiBuVAeEmC9t4vI2CjDX4yuNZKPb+tYkUuFWjuUOtw87jXeAC2D4YPty/Bwj+afe/ZzGoRnyhsDM/zNLAfXqqGoIsHF1ItPSglA54oDhdJoeXRRRdDopA/PUlk7Bmc/0Ayzr4sqaXWlTkJ+zlgnSt4bJkEnSpiQ7PBrLkupU42nLqDJ0U/ytwdlTiy0diWaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39850400004)(346002)(52116002)(38100700002)(38350700002)(6506007)(2906002)(8676002)(8936002)(6666004)(6486002)(966005)(316002)(66946007)(86362001)(7416002)(508600001)(5660300002)(44832011)(83380400001)(110136005)(41300700001)(2616005)(26005)(6512007)(36756003)(66556008)(54906003)(4326008)(66476007)(186003)(1076003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8D5JEROGsZfIO2Xbnh4gyAcLQ0XgVwdYJGRw4xYZuYjBoOTKQ83CjbEghK6c?=
 =?us-ascii?Q?+GOsh7joFfxV2W3Qhzx6TbjIH7uVuE7Hd/IUIjmSy/T1sMWyZEa6rBcqM7w3?=
 =?us-ascii?Q?4y0steJIsGvd/tbCsDPgXdFIAh3rT193EwGlZIwkUzs/Y/D7CMlwjLo/Xlen?=
 =?us-ascii?Q?32IZcpRV5gkfeeaZ1gQMFBI4QlYuHSq1PyJaI1WzMtAzR+2f8GHgYGpSppSq?=
 =?us-ascii?Q?vqf3CoqpbnXERd5RuFQaeTMyC641sabQKx8cdu7p7gnxpdYxuMagSeo1WKfM?=
 =?us-ascii?Q?LWtDAsZN4kLHimJPyP+5/EBY63Za1orKPo7Dvn5eG4grpS8Yr85axu53zTPR?=
 =?us-ascii?Q?LCXyfOt/aqTf+kGfeIXhzGb/UYaK7+0bq0dqQUiIG1XtV/oxbdqs2eRLV/Nl?=
 =?us-ascii?Q?r6Cg6xr6IZF4zPHf8hH9deptQsSIkDf2G0KSjD4NeqL/63R777JjaMUSVPUI?=
 =?us-ascii?Q?AsshytkEP22gIrXBcUHjoSTIgIdUdi2mgKuUUbAG1I9EZF6PtcD46NFowVzR?=
 =?us-ascii?Q?y6rOYKoCCiRe1r4iFcqYLzREB8m1SfaDV+C14v6QtkwYow0OaYjYBA6PQXXC?=
 =?us-ascii?Q?Xu46kZ90NppwQ2s7IcJMeKYUaIRSuNkiSDn6+p8B1vyBuYoxGtzh0RK3Nq+Q?=
 =?us-ascii?Q?SFankiwljJUa+I1i/7CUhMLwnrlJ4O63JJj6UShCbogFHSnv8CfJ8dYUrjZ1?=
 =?us-ascii?Q?cK/f5n/YAI6uSmWL9rL7cUnJsWAKfxSpC6DZXI6MvQiOEC8p0y1uCsd8CJNP?=
 =?us-ascii?Q?s+gyTF42oLyUixa3O+XQOh01ssd5hbvHbl5x5O6lnaF91ImtONVioRmKBFsE?=
 =?us-ascii?Q?+Nn5hMV0DyOP8zDCCTGbXWQjFn7AemK4ZDXUyWEWUo51CjSq9Uwpa07bsDgp?=
 =?us-ascii?Q?f5yfpMVARXaWpEFyy27V/BHZ35X71asfg9jevhHC9OLd4wthUYmLwwJplHBP?=
 =?us-ascii?Q?6NVp0xnM2WgksAa9kn/E6vY99R0CIzl4hVSMRFVBxlX8D9okgS2OVNxv+nE6?=
 =?us-ascii?Q?F1rO1y9K7Znxun/x1aSFrL1aYnJWM+jMcBjQ8jgthhfEy1PAqD51lxiG6NbA?=
 =?us-ascii?Q?7nyNzRNcQlL+GhDnIaXSzkcZpebVjiaxgIhj+7WmO3u0pE1CSfpS3R0KY0Bf?=
 =?us-ascii?Q?gtk5poclcbZsF73JNQDSawykdYmYEmIEHskOmKESU/bIqmVScxiy+Ht4evWT?=
 =?us-ascii?Q?CUmb393SGsDVDQhOhPsMn0uqv0Zj4BdN7B6+3BvLQ9SxJoOYGQZyMXU4pYmx?=
 =?us-ascii?Q?8vWY9U0QxQHgJ/PEnF5LmJ6pML9Q6likA4m08Ot2ijQUOUKunkrUdvXCebfA?=
 =?us-ascii?Q?OsoEYEbMznkmnE7bXu/iIu+YSvj2d94C6x3jzxT72MmbnpmTo3Mx0L72BWQ8?=
 =?us-ascii?Q?qb+avbHCHjjyzGBpngJDgEcIFa7MTFQB04mkaAm2RdEi/O+G7W75JwbTZwei?=
 =?us-ascii?Q?PBF5fV0/jJkTOc+tLrHQj3bvn3Moil3MKdkx+03KJO0Qmp1hXu1i/euyD2oD?=
 =?us-ascii?Q?wOFO5r6dHAXJnJl/aaN/a3IWxEazIrq/dtE4Db82rq+vuyri3s69IjvNWly2?=
 =?us-ascii?Q?CpXQyEpnN7vUMdnzScXanoaB9nYbUhVsr3aSSBpBk1SBRE9P5BE3n5SWgzVJ?=
 =?us-ascii?Q?cOfKkK0Du5v2xN0BrsyJ61+y383oYJT2RHYIkmCFzGVSeLA5UzqaFPSTdbQL?=
 =?us-ascii?Q?pataCw7xdcYKR4RIMzyqvmh7biEpvz/li+UOe0UCZ+UJ9pYUpvYLuhWhtekh?=
 =?us-ascii?Q?1bWrwz4JXJ001DJMs0MsXcMp8x4oJJQ=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8117fbf-3ae8-4d67-19dc-08da5030fb44
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:14:13.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkllLnlMPGNktY74uafB6EDtRnZeiLrwZrBOXpQh7YaEyQSriXVsPpQ8dbsurSJEGwtGKVboGHSHe1ISYF55BkJgfBbNgj8jzYfCi9LXXso=
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

Changes in v2:
 - fix build error without CONFIG_THERMAL_OF
 - more verbose error reporting in case the dts is not correct
 - additional comment on the threshold fixup in case the passive threshold is
   higher than critical
 - while parsing the dts thermal, return immediately if the node is not there


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
 drivers/thermal/imx_thermal.c                 |  58 ++++++++
 drivers/thermal/thermal_core.h                |   7 +
 drivers/thermal/thermal_of.c                  |   5 +-
 16 files changed, 283 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx-thermal.dtsi

-- 
2.25.1

