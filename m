Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812AE532711
	for <lists+linux-pm@lfdr.de>; Tue, 24 May 2022 12:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiEXKHk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 24 May 2022 06:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiEXKHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2022 06:07:39 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54C1C42EFB
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 03:07:38 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2044.outbound.protection.outlook.com [104.47.22.44]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-7f6-0HI5PJ2IWoJcqjX5yQ-2; Tue, 24 May 2022 12:07:31 +0200
X-MC-Unique: 7f6-0HI5PJ2IWoJcqjX5yQ-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0219.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:25::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Tue, 24 May 2022 10:07:29 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 10:07:29 +0000
Date:   Tue, 24 May 2022 12:07:28 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        l.stach@pengutronix.de, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] thermal: imx: Make trip point offset configurable
Message-ID: <20220524100728.GA99192@francesco-nb.int.toradex.com>
References: <20220516190001.147919-1-francesco.dolcini@toradex.com>
 <20220518085522.3fpzy37kkbkn4hpl@pengutronix.de>
 <20220518094916.GA27037@francesco-nb.int.toradex.com>
 <0006b8cb-b4fc-5015-5c86-be2a6a39be93@linaro.org>
 <20220523143545.GA30537@francesco-nb.int.toradex.com>
 <20220524083514.btjjv6ai6ve74bdc@pengutronix.de>
In-Reply-To: <20220524083514.btjjv6ai6ve74bdc@pengutronix.de>
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 475a8897-6773-4156-47fe-08da3d6d35f5
X-MS-TrafficTypeDiagnostic: ZR0P278MB0219:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB0219D8AE3AF0F99C0E2971F4E2D79@ZR0P278MB0219.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 5R5vlTWn3i8v0hCayPH1DK58jEzlQGW/2sVKbt6FD94yTAYLo2X6n2ywA0Bf329vAed0TV5rsbTPfdlnM2tLRMtteUI755aR8RsmFUaS4K8HYtjkmORXKNoUyFv7zii/7cRxcFQLkBR0X2MeFr7VcU24W1B8Wrxk8vIE9uwtAUd/hTDex+6SqGhOondZB5RHWpCl+bOY3OSCF/4wlmvoDP3f6E0bAl0r9sVTpNXUWTqkGyOEFhH1h8hpagp6lklFNeVJLJ4Ue5D9UPk9/YFYebHmIxz2LsAd/SGO2J+WFmpBeXXWJ98EYZVJ7sv/0ub4XVX5b2/lD2HJEAsbJSAIxU0CcTRqooNZehMoWrsYGeTFfjVGtDpr7pZuZhfjeXAdZhRxS3Wu/tSpQ+XAuqWqdbeH/9pt4ERCTJvvsrNOVHAUEdfjFpXY5ija9lkKuwUpFzRZNKpTsCcqQuTvXt3xNPKOkYtC68QyT9ciSMDPFBoNQoJw6scxrdjjyLRgwN8bUuzwOA+f63Ly5tXuM9/1GVjql8uyf8CBbRdN93ofyeJkXb+dyAtLHZuoyejvEIPpFodBgdW2Da1m89h+0mtA6F+k7c8EN1ksGTRDf3pl8NTLFH73WD/ECmI6F9fruFsqUwUE9SnKobenqpPOJETQrvLfxdVXM3EQLnLF6mFMivulFkmoYWr7YOpOIORxT9XHSlePIC4xzsyJpjsViqHSZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39850400004)(136003)(366004)(396003)(346002)(376002)(83380400001)(8676002)(44832011)(66946007)(4326008)(66556008)(508600001)(66476007)(54906003)(110136005)(316002)(6486002)(8936002)(7416002)(26005)(1076003)(186003)(5660300002)(6512007)(6506007)(2906002)(38100700002)(38350700002)(52116002)(86362001)(33656002)(41300700001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YcmAjNsLtyoLBYn9CHaZ2iNZLp512X4jMRIzEZjsfaQyTRytKmuJs2fdfYUS?=
 =?us-ascii?Q?gB9OE1aNRQEEkutefjp5gkO1/Im62pva6SJUKg0xA/hWYRXZPm/uTsllvfs5?=
 =?us-ascii?Q?d+iDTCja3efnCUbR8lfbjwmzLJSgOgUXtxjdmDSRegmehFQ+VsOkRHRpnE/T?=
 =?us-ascii?Q?jzUHncd0/GgRvpysWlojq6PtZRpguGf/va79LZNcensYF8hghRQ/XjAPPbW4?=
 =?us-ascii?Q?xF1af/ZYGF/E2ENKomn2pH9roBdZkjoYK/aTZZzLaSvIzKk4WVfOg3sZ+m6L?=
 =?us-ascii?Q?MfNV9mXpWu1oPwK70lJVzBh1UTf8o2AqlEL7Qxf10c2/3d7TFuA1M94BPJrH?=
 =?us-ascii?Q?H23rfWhZNX7DsfnPVrOa2jeSmeGCC9V24A1c8S31PUYy8p03I1ySUG0Df+r7?=
 =?us-ascii?Q?Y0JrMgt9NZE2DMl7yiqUQ731jliqeRg9zJJWZvxB+K0hhfxJcQuUeQX0MQFH?=
 =?us-ascii?Q?pRa/y6AutPfvrXE2uh07/I2COT6t4YopxGYCQVZx0LfDV1R/Pa0hKuSAaX5U?=
 =?us-ascii?Q?OCrMHFMvyJbb+m2/qix+hB8Y7EsCYGxWA2hNluHdjGPgVgnRfeGbw0xqo50Q?=
 =?us-ascii?Q?XOQ9GYvuFrpBbt4FRLODQO9IiROrMnSdwoU6tPC56dPitNyj74w/onfjRyMl?=
 =?us-ascii?Q?FRYSJrwHoTmw/5IIx0nxbKpNaAv3FO3mn/fuDnnS2BqqkpLDn84si68PjnCe?=
 =?us-ascii?Q?VHCB1nc1/IEP4z/8lKJB3VeZ6lNYHXkdpPZZeSsafGmKGEnupshxvOqPUCpr?=
 =?us-ascii?Q?0385mLoCgq57ZZtuFGHCKXVG2t9xYs+scSLkfhWHpkaisOm2bCKDDLuiEClg?=
 =?us-ascii?Q?i3OeU3xO+pqotXMTnJ+oRn2tSmcawozGcq8qnMd6aimUgpwTgZEAzP/kYwjz?=
 =?us-ascii?Q?7nGKQa8UGusdzn2YiFBfAzFTDYXzOFUegqQ1I0nVMCNVJ8Pj0EsDw+wxWESj?=
 =?us-ascii?Q?ZClEeD8d61ZSepw9K4eRhnkxEo3cDsSU+ZC32rDDXP0JzR6/GIliCxcejKVl?=
 =?us-ascii?Q?r/tTrmTzM5lQrk9ZmCvBAl8rWm70RX0hgFSYieY5gX6bQM7pgTiQGO2Il3yu?=
 =?us-ascii?Q?Kh/aDEtYR9LeMA1hS49FYvXy0OHunEXEJ5E8sslYv1hus5gH4yFe0VK1zmmo?=
 =?us-ascii?Q?x+YvfDyhhoOpJVQXzLVxY2UJKeUmLwD9vDkEPkI8SMbTLGa12UWrwHIh8rA/?=
 =?us-ascii?Q?NIns14Y0Ml4b90k5cRkXs/ZMpY5yOwYyRMiZPPFf/y225k7AOE73m2+984qy?=
 =?us-ascii?Q?5gNEPglj12VL+foR/HWNGpd/TqtP+VghVTDQteV62x9qQOyOtAdBr40hshV9?=
 =?us-ascii?Q?RuOCWvzqmAK44AAbpvQYK3RENVXArJ3lXomRvWa3CPRfJjJieqWtYDt8hny8?=
 =?us-ascii?Q?qGnsDJPp+kOMp/DmZ9zu2reDb/j8j3ADG9dqaXoWwMbyAiJckRp+dOzEjbbF?=
 =?us-ascii?Q?KkoXepSIClcMgAZWoFpqCcpIgCnzTQSHM+OuaR2eVUOJHAkbFJ+fvb2Sv824?=
 =?us-ascii?Q?nMAD7FBi+oAaMbXbETPVMFOI4FE9rpkDh9Ylr+ookJodB955/zrORUgsex8c?=
 =?us-ascii?Q?6lt99z8aVW0h58ILPYl2b4B5jVnwNiDvh8fF/foyGVtI2Py+4nz/rP4yEo0X?=
 =?us-ascii?Q?Bb/Z3wQOiWStrGNl+Nx0Obm3FN+B8eOYMnhY5IPGwJjyUe0G0ICaWHfFUFDi?=
 =?us-ascii?Q?bjFJGdLYA5Wes0npc3ofgyd4YCs2CHspEMtB6BHhnzC9y8Kh6fPHSXOXFvvd?=
 =?us-ascii?Q?uxnx976wUyYoT/si0rqX24mLeDQezs4=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475a8897-6773-4156-47fe-08da3d6d35f5
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 10:07:29.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCx5Rshr9mJHBVaIQmtQrP+F9Ghy6o5UKjXCJME4TpXw8M4abfy+eOn11HumrcFlCzoXCeXLyqkv8k+W7RAxXdDcF+kcxnLGpgDu+AKJCaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0219
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

On Tue, May 24, 2022 at 10:35:14AM +0200, Marco Felsch wrote:
> On 22-05-23, Francesco Dolcini wrote:
> > On Wed, May 18, 2022 at 12:10:34PM +0200, Daniel Lezcano wrote:
> > > It would have been easier if the imx6/7 platforms were defining the thermal
> > > zones in their DT ...
> 
> After checking the driver I completely agree with you... But this would
> need much more rework.
> 
> > Marco, Lucas,
> > What about a &tempon { fsl,tempmon-critical-offset=<0>; } dt property?
> 
> I would not introduce a special binding for it. Instead I would add the
> support to parse the already exisiting bindings so the new-tempmon node
> would look like:
> 
> tempmon: tempmon {
>         compatible = "fsl,imx6q-tempmon";
>         interrupt-parent = <&gpc>;
>         interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
>         fsl,tempmon = <&anatop>;
>         nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
>         nvmem-cell-names = "calib", "temp_grade";
>         clocks = <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
>         #thermal-sensor-cells = <0>;
> 
> 	commercial-thermal {
> 		trips {
> 			commercial_trip_passive: trip-point0 {
> 				temperature = <85000>;
> 				type = "passive";
> 			};
> 			commercial_trip_crit: trip-point1 {
> 				temperature = <90000>;
> 				type = "critical";
> 			};
> 		};
> 	};
> 
> 	extended-commercial-thermal {
> 		trips {
> 			ecommercial_trip_passive: trip-point0 {
> 				temperature = <95000>;
> 				type = "passive";
> 			};
> 			ecommercial_trip_crit: trip-point1 {
> 				temperature = <100000>;
> 				type = "critical";
> 			};
> 		};
> 	};
> 
> 	industrial-thermal { };
> 	automotive-thermal { };
> };
> 
> That way we can reuse the existing dt definitions and if no *-thermal
> child device nodes exist we can keep the original logic.

Good for me, it's more work, of course, but if this is the way to do it
let it be.
Daniel: I'd like to have an ack from you before implementing this.

Francesco

