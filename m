Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF71A54F3D2
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 11:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381459AbiFQJEx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 05:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381308AbiFQJEw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 05:04:52 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4E66240A9
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 02:04:51 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2046.outbound.protection.outlook.com [104.47.22.46]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-0vy6RTYzO6KdYT93htwoRg-2; Fri, 17 Jun 2022 11:04:45 +0200
X-MC-Unique: 0vy6RTYzO6KdYT93htwoRg-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0127.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.13; Fri, 17 Jun 2022 09:04:43 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 09:04:43 +0000
Date:   Fri, 17 Jun 2022 11:04:42 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v2 4/9] imx: thermal: Configure trip point from DT
Message-ID: <20220617090442.GB190158@francesco-nb.int.toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
 <20220617071411.187542-5-francesco.dolcini@toradex.com>
 <20220617084017.54psumosr6p3a6qt@pengutronix.de>
In-Reply-To: <20220617084017.54psumosr6p3a6qt@pengutronix.de>
X-ClientProxiedBy: MR2P264CA0096.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::36) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e7bc407-9be4-45e1-8b95-08da50406b06
X-MS-TrafficTypeDiagnostic: ZRAP278MB0127:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB012724703816910370772EB5E2AF9@ZRAP278MB0127.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 3bHoe+YPoC2FEP28UvoV3G/HPKgZf9vx9kGiXBRiPdond+JW7Knik1Q71UVcGm04Nc0dCO/rZyteDcruYEktoLqe9eM65DjlC4/GHxRvNTwcY/5ynHzolzoaji9E5anY/NnnAKM0zpAz/0Sv9h9vDhOomkCopJjxaon8LDUUCq4eLBji3esZphPQhHom7a59Xsf8H14CZ82hpCJla6ThwFhT1kdqnsL+S+Hwset8JrPdWsmBB2GpYWI3acWZIq9i5Rmwk4yuPM0qB8ck6sdVFteFMYMDOQQG2nu7VZ4zVk5X9QOwI3DbioFjEDXRRNuuj07Ef62cf01mo9ln6Xwpr6+kBGGfns6nF2JIfuqt5gLs60iy+SdPpRLJJPh0wc7VzbQHA8g9jGtyyTJ3bloEpFrAuBu85hWdyyHsjtcLNaszQwIuQDwjmizwiywcTZ6L2Wdl+gWAMEGb7hrEa+DkCC3xJRvvnVeieMRjwpD2zcc6Z9bA+j3LSxhIW/FWrqrT5POwfOhSpjtL3RXzlYvAHoU6BASstN3Rdc36mxMf5KOF+LNeWjuEm6R3TF4FySqqrMu4sdPzjc2fVImRiP+vgFsSvsmi/+A0fQzXch/pUq12EZHCN97eDEBGMQDdWpMJomlHI27RqJCW/gacH8XUQGoGPQDW9t127NlPhH/7THYV5TXzz3PAZKNVeYgUpuuItfvboAQkcevtBZrNLTH3Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(346002)(366004)(136003)(396003)(41300700001)(54906003)(52116002)(6506007)(1076003)(26005)(66556008)(6486002)(6512007)(86362001)(66946007)(66476007)(5660300002)(38100700002)(186003)(38350700002)(7416002)(6916009)(316002)(508600001)(83380400001)(2906002)(8936002)(33656002)(8676002)(4326008)(44832011);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WT7OaQQg5Lswi01XSL+Bg0cMKm3yASJyaBdZMKjTwEnGcbN91cQyp7+/EutU?=
 =?us-ascii?Q?p1DXiAfCRC6RYzcqeOmTETX70hoQIUC8h5EoTQBgX4Rb0FXH2h0AMJVcfj+6?=
 =?us-ascii?Q?lBbzdTqgl9ml9QqBLfmfBYK3QpO6GS+wTCp5upopJsDndEA0EfgX4Yo+komz?=
 =?us-ascii?Q?6tBbVGJEOPMiKAncG2pDg1vbH/gqJSw2i8l7UnPRBsNVTgH9fheDuGqKodQH?=
 =?us-ascii?Q?tMQYTfuusTlyPkVOSuItD08jv4QOKu1fw9w7yLYxkRSjbAAX5nrK3njJDQrk?=
 =?us-ascii?Q?nfWqOwv0IqiKeH8Vwvn3/rqpXf9Dn8g+q8ncjkuwSFmC+ZqS2iImeiVndcO7?=
 =?us-ascii?Q?kbVhUxuco9sCF+xWxR17hR2r2qsTSBkihoAMwhOI5V8IKHePrEHQd/rp1srs?=
 =?us-ascii?Q?OyUSImJJkynPSgg33y4uvHpIU+MC9NAjyw/sGk5/LT8OcRbLlhbfT36pvyDd?=
 =?us-ascii?Q?U+gGsDbA6mc+3APOe9uLHRTcRAJCOSiFy1tAAhsjvWXlaOKZm68OeyYefaOA?=
 =?us-ascii?Q?u0d/j8etmZWk4VLcSBh9a9MMJ/Hv+oEubAhA093jrRqUIk9IMF1u2hzC9OAm?=
 =?us-ascii?Q?rTqQUsb4Njs7IOlLZQqHLmKm4egEoDBpD6Sx14Negdx+Sr7a0Hh5H8yxoYlB?=
 =?us-ascii?Q?NqmDKakaKD4jNqsi6NxURhba2WpY2zZx3yGpJxC5GBpAH/bIZZZ3NhP9V7wE?=
 =?us-ascii?Q?Qu2ixBmRHkSst26gHWzva7SF0spoXqR8xPpj95AISb13he3Eo8KWzxCLpT86?=
 =?us-ascii?Q?sFDhApnnKtHCnZTJJIZ+Nt4DLkr+3Gmd24SurdpcRhXqXTOwvYX1FR5Hn72R?=
 =?us-ascii?Q?n79CVb/r3BXoYaufsXkx29a8H7lOSJ3xKhpejwmCxaSP2yAbaD5l4dOeTcag?=
 =?us-ascii?Q?QODwpCpWmsq4EQOnkgPNxU0ez8CwyDxKRIri7xgwdZipJXr/IYxA9Kz8wQGi?=
 =?us-ascii?Q?ySev72ajdetGAg/7+JF75cDTh1rKt6G3Vszroij/n1uG/O2ehXcotw9orgRx?=
 =?us-ascii?Q?j3NSJCNzhbyWQReHbL/0PMdeE5C2j5x125AMsHgmEzwUWe512EngQP9qM/Uk?=
 =?us-ascii?Q?GXZHarNvQ7IVlB0ECDIy3walN1/8kuDqacJf8EHQ4B94Bc5ZyoeSLfy1Huta?=
 =?us-ascii?Q?umzFb3zaDjv+ohK+D/v0oJNBpbtUPmfmtWBoYCMZiQNjr1B4Zh3x6hrCFQ37?=
 =?us-ascii?Q?J1+FUQ1/6APvN5WcUWVnMmJhHmNSDU84Xv1YWJJVOT8SqKvCBSOYO0j5e+K0?=
 =?us-ascii?Q?lkFc/tk8bmwH7GfM8Kt1F24pEaWJqJLjiYNDLANxoY3Ls3+Ts5oWXuxh1vJX?=
 =?us-ascii?Q?F5mjQ1mHjdbNKplcDhZDr2vBowzpTo5+UNywVi9Z5q8ZN7eoPGFjE681rVVB?=
 =?us-ascii?Q?IbBq70Fn8uWZplcTOBwW9b7mtxWd74svRc25vZnOK3PdZlgKDVal8RSn3c1v?=
 =?us-ascii?Q?5b0rDnoFEREbtlW0nj5fvc1nvNJ1ccKyMTScru+/xeykK5q75GS7IHm+wXox?=
 =?us-ascii?Q?1fHcya3p0WRGt9ybkMfQ/AxNh9/2YWjO8pJJ5BtxccDOgfAjRZ7X2BUxtYVw?=
 =?us-ascii?Q?GN1uBt4UTiyIEqvkUDdFGmR5GtSMFTc2fvWc1xceF9xkTg7Co4c6uyTkXVyb?=
 =?us-ascii?Q?1d1g0kayjOmp65xtJizHNaYETXzcD5+Os5+yll40qOEf82OnlkqqQHzDQuki?=
 =?us-ascii?Q?FzXu0MEOPlLTc7GI4SiL4x17rTbCGgTVb2fb8FlScxafC7JgiScLz5Un88SF?=
 =?us-ascii?Q?B0a/b9paD37LsqxeTm0bI/z6X3wxyG8=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7bc407-9be4-45e1-8b95-08da50406b06
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 09:04:43.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCl0mtGk0wiCeeRQVGYHwvhFsBUjNM8FFtqi8zOjUMmjRc2Mq3i3ZLaVeCu077sygsYQkyL4It8PjAsPH66UwnfvQpLN8GRu88Ha/U4wFvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0127
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 17, 2022 at 10:40:17AM +0200, Marco Felsch wrote:
> On 22-06-17, Francesco Dolcini wrote:
> > Allow over-writing critical and passive trip point for each
> > temperature grade from the device tree, by default the pre-existing
> > hard-coded trip points are used.
> > 
> > This change enables configuring the system thermal characteristics into
> > the system-specific device tree instead of relying on global hard-coded
> > temperature thresholds that does not take into account the specific
> > system thermal design.
> > 
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > v2:
> >  - return immediately if no thermal node present in the dts
> >  - use dev_info instead of dev_dbg if there is an invalid trip
> >  - additional comment in case passive trip point is higher than critical
> > ---
> >  drivers/thermal/imx_thermal.c | 58 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> > 
> > diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> > index 16663373b682..a964baf802fc 100644
> > --- a/drivers/thermal/imx_thermal.c
> > +++ b/drivers/thermal/imx_thermal.c
> > @@ -17,6 +17,8 @@
> >  #include <linux/nvmem-consumer.h>
> >  #include <linux/pm_runtime.h>
> >  
> > +#include "thermal_core.h"
> > +
> >  #define REG_SET		0x4
> >  #define REG_CLR		0x8
> >  #define REG_TOG		0xc
> > @@ -479,36 +481,92 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
> >  	return 0;
> >  }
> >  
> > +static void imx_init_temp_from_of(struct platform_device *pdev, const char *name)
> > +{
> > +	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> > +	struct device_node *thermal, *trips, *trip_point;
> > +
> > +	thermal = of_get_child_by_name(pdev->dev.of_node, name);
> > +	if (!thermal)
> > +		return;
> > +
> > +	trips = of_get_child_by_name(thermal, "trips");
> > +
> > +	for_each_child_of_node(trips, trip_point) {
> > +		struct thermal_trip t;
> > +
> > +		if (thermal_of_populate_trip(trip_point, &t))
> > +			continue;
> > +
> > +		switch (t.type) {
> > +		case THERMAL_TRIP_PASSIVE:
> > +			data->temp_passive = t.temperature;
> > +			break;
> > +		case THERMAL_TRIP_CRITICAL:
> 
> Should we check also the temp_critical and temp_passive not exceeding
> the temp_max? Sry. that it came not earlier in my mind. So system damage
> is avoided.

I would not add such kind of restriction in the code. I can think of
multiple situations in which a system designer would prefer to take the
chances of burning a silicon (or more likely just age it a little bit
faster) than to just shut down the system.

In the end whoever is building the system should be empowered to do
something like that and it's no different from what it's already possible
with thermal_of driver for example. 

In addition to that from a system debug prospective all the threshold
(max, passive, critical) are already available in the kernel logs.

Francesco

