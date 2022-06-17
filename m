Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4F54F180
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380489AbiFQHJU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380447AbiFQHJF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:09:05 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25B9863395
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:08:55 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-NY3MGSrGP1ONl_VP-0OvSA-2; Fri, 17 Jun 2022 09:08:52 +0200
X-MC-Unique: NY3MGSrGP1ONl_VP-0OvSA-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 07:08:50 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:08:50 +0000
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
Date:   Fri, 17 Jun 2022 09:08:38 +0200
Message-ID: <20220617070847.186876-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MR2P264CA0122.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::14) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0fb45d4-afcb-4987-e4c7-08da50303abe
X-MS-TrafficTypeDiagnostic: GVAP278MB0263:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB02639CF639D357718B7B3E46E2AF9@GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: d/SSTfJnwNpzFyM4hLL/ZHsyBytMHKUlSlwVS80NdAQ9VWn2UyD8BclcZpL9gZFLEk58o9CUQxdierBU5+iCH74f3khGq6kr6psabqNeuvPjNVCFnczxANCRFWgV7AVO0rhWgndvT0kvfhV9kh+6EOZBkJsDWvrrQ8SAZmtMDX9gZk6N1GqSjxPPadrfillQIS2GC3rbZSMlv30JDqwDSJQl3+HfHrFJrbsq/wPwdOuZ+2OE+8pSWCqPyzJdMsy5JkeleGxKSX305mqN2wFvHoyJ6zpZyD/w4U+odrAgSHICuNp/ec7Lz+q10obyNrDyLPTlavJY5DJ76TwfR334Ko+9zfP3U0oQ5JVxJemQlDE4nYikno/WTdPxLLKEPNtj/UnlkhoV48tZSkdlxOv5VK4f3lkHnsL7QGxYCwnXMYlDeqwpI7phodJ+y9CgsvwCEmMb7k7Eo+w5zDjeKyhkUzb/1wDaercSOGIlwq3f284ty2uFL2eEuVg6Hm6y7Fz58o6IBc6w+d6DodW6DzlUoOJVJAH83dbWDFVV7M42hiImPULsg9RdRXfyp9FgSZ4F/dUGGG/bwgVNPnQyVFHlw5h/r2do3MsuJBUcTvq5vDqy66w6t1YZRwwUhZ9D2fS3b4ljfGB8OHX0vR1IKOdiwQ/f22ZqTUhGUPYHoqqHhf/QGMdVosVSz139wkVstCALvPUT1J6cTp86JG0nYO+6grqCuvCdMYsz13l6FFnUR2UdgFvZN1UxdNCcNDoQ6IoWXsROtIPIqOUXHyYKxsZVxY9D5Z3x9MiH0OeTeZ2DCFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(396003)(366004)(38100700002)(966005)(6506007)(52116002)(8936002)(6666004)(6512007)(6486002)(26005)(83380400001)(2906002)(110136005)(5660300002)(54906003)(316002)(36756003)(86362001)(1076003)(2616005)(41300700001)(66556008)(4326008)(44832011)(8676002)(186003)(66476007)(38350700002)(508600001)(66946007)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zzNA7pMKn00RzNSRd0PnXjDV9EL/AIuPoGfumLga+dyq+AiOA/mpRJMWAB2L?=
 =?us-ascii?Q?w3yW9os3zfr61reSePwNNy+BiZDIPn4j5IQjN/PuvUbrlk18eW5N+uedwuqa?=
 =?us-ascii?Q?Zbceob1jxqMjP1EH59h0vMhh98nYjM845f/TgVEal2JBFND1lKsoq9umZjN/?=
 =?us-ascii?Q?KxUw05LXmpijJClvgLx0BBuMFoU3xg/aCaE27gOJB+JL3mLEbEVHu/6SIh2Q?=
 =?us-ascii?Q?Xijr5vmbgFGv7lpRspRqhfV6jHl+ctez3MCOIWzmB+ra600cIKw6hXQbuOKm?=
 =?us-ascii?Q?iXqkQLykSEDSl0YTAA5+sfwXTGSWTa6+tifmIQf0Hc4FMls7LymCcleBxBFr?=
 =?us-ascii?Q?6eylJNqSi8cWiPWENWjowunQgfW71In/HJT6uZ7RSmvuy3MMQgpIwXByA5qY?=
 =?us-ascii?Q?t8xrgAv7ARpfOmMt9IZWels5CvvYR2nMeMyY7HPh6rbTotrVTotSo4e2WUzk?=
 =?us-ascii?Q?/pEfukrFbRJ5ah2icYBzRM+41TDN/hJIvuHqsWnJRBc5P3gCOhP4cKkcrqdv?=
 =?us-ascii?Q?dqaXXhXk93vN7IgnRLN21Ut+5u3CX70Kl9Iaiv+S3yubE4dADm+EOy6DbexU?=
 =?us-ascii?Q?PbCH5IEQXR/lWx7L+EfeBuyLiUr+QMs/C+8d8LN6XiIwTOf4V1CD6X2Snmzw?=
 =?us-ascii?Q?pQAM6oMdLlloNspzCnLZ0ozRxMRuUv0nb90e7BATcr7BkEUeJhpeMiDeCYc1?=
 =?us-ascii?Q?yh2MiprEwKx0nCVSklaCvXwjsY66fP4mzkSO9RPqXjFN/34066SQK410Gx1F?=
 =?us-ascii?Q?ro/FqaXle/g8bKCpNOpQZiow4GHaLR6DCSiJIM9Wwm0gkFMxnpiZjMxfF+00?=
 =?us-ascii?Q?ij6YGUtzFAWUOnSI7uGcMWP2oZYFhAVemPmWtNopQ5kp4H4tI1CCd0BXys0x?=
 =?us-ascii?Q?B60gO5NuZ1f88cW2ECkQ0EqZhgiCAIe73cdBWv0CeUQE7lRDluHG5mNISsw4?=
 =?us-ascii?Q?udeK1R0fbaK7W+EQlN+/OvZJM5dxTfc5TPau34WSuZtYSabiyIhbNOVQbMYV?=
 =?us-ascii?Q?vH9uxm+3vWRcMDDCTS0xohrgaPqFfgaSIDMvjlu7P2GNhIgSgcd6J8edmSnP?=
 =?us-ascii?Q?CPor7UCaNM2pu4NN3Zjsir+BlAmCLFSGML6RhrZQkoxvVUhQLuZSN2QzJB4p?=
 =?us-ascii?Q?q+MOY5BH/K6m99FO5EWx47xOohr74Yc4EpX/50jYcKhzG2/IS5RWcha9YO9a?=
 =?us-ascii?Q?/CSgoJJSfN5ICop7O+6oSabSQE1RihPOnLUdZrCPx77GGMsW+tYsQvyZPSC7?=
 =?us-ascii?Q?W3v16Zp+SQMLQ71rvSpQSKTKInP8OE0CGcfLkdqU5HOjAwJjjWJ99lpSj6Or?=
 =?us-ascii?Q?FM7nU2LM5q2KLQ2dekCpMFoxeFZC5SuHLYyUIJfAJc2CnX1Ex/sat6wk+TAQ?=
 =?us-ascii?Q?fdFntHE/UcUy7ErGm9/pIQVPGUz7nLfySOem4JRjAsEEUPIVaeZBN1LEOc20?=
 =?us-ascii?Q?FOOyfWaor9P5TW8pj/IAPkANESX2hk2pz86xxbzGXPgFkZiX0e2Xr6VUC46D?=
 =?us-ascii?Q?gyIINij02KvEky855dgyEn5Ju4KhnO49BrtNRuR15y1cOh4zCPMXgnmZ9Mpy?=
 =?us-ascii?Q?4x/wx4cAkrxWq5ZL6Erp+fllcbYxEei0wCHsXExfegzvGQd+ObM+vLsU4037?=
 =?us-ascii?Q?2cAq+s9TUDPUgpSLhu+day6NPBmmwvNcj8ZRiQlbSkDrvp6LapFaFfjLE5DW?=
 =?us-ascii?Q?gDc9rozfD92r5ReU05kzhv7hhGy4okS85dMRjZuQOaOAtMH0YiIIRT67Cclm?=
 =?us-ascii?Q?bgZ/bGuaVDbFqSrlBh9pATRZ79tVz/E=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fb45d4-afcb-4987-e4c7-08da50303abe
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:08:50.1993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtdTKgY4N3Dd6Ine4X0ngFgokZWRNz6C0PVe92O8u1c41UeMpZi0g2YHzEmgNUDMMI9hFHADQOfopgTFwZPzEr7CA+kUyujDooFCfubpF+w=
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

