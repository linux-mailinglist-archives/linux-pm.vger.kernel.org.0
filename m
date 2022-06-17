Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F52B54F3EF
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379989AbiFQJKQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 05:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiFQJKP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 05:10:15 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 231E655499
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 02:10:13 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2111.outbound.protection.outlook.com [104.47.22.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-44-vqT5NVwiM9SHPcK9mFq5sg-2; Fri, 17 Jun 2022 11:10:11 +0200
X-MC-Unique: vqT5NVwiM9SHPcK9mFq5sg-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0266.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:32::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.13; Fri, 17 Jun 2022 09:10:09 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 09:10:09 +0000
Date:   Fri, 17 Jun 2022 11:10:08 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
 configuration from DT
Message-ID: <20220617091008.GA193066@francesco-nb.int.toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
 <DB9PR04MB84123FC6272AF3C2DAE306D687AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
 <20220617074220.GA187629@francesco-nb.int.toradex.com>
 <DB9PR04MB84128DBB45B29B7BD6ED001287AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
 <20220617075533.GA190158@francesco-nb.int.toradex.com>
 <854d5705-93a3-18f2-a16d-b2245cf2c085@ysoft.com>
In-Reply-To: <854d5705-93a3-18f2-a16d-b2245cf2c085@ysoft.com>
X-ClientProxiedBy: MR2P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::34) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6dd53a8-15ff-4dce-2c39-08da50412d5b
X-MS-TrafficTypeDiagnostic: ZR0P278MB0266:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB02666DA97C42B03F807220A0E2AF9@ZR0P278MB0266.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: kdz4mIh8dt7VUVIFH7ZR39pVQlNgY9T4mvCJcH32mM3m5m8ZnZfydWQ+1HHQFOdk0wcBWJtxtBQwHu8D4jVuM0sU+tqFeeky+Hs9DqkV/7w6H9IN2PeBWK3+yMaMWzbKw80Vb46Rqc7nfiYpaqRZ2D8kbBvq/s/VGqk/zjKiLh+rQAr1o7dflD5mxQU012EiRiOXiK3i/ksWf1nWrvNS6KSl6iRr1WsNjmCcAXZ8qjtm8znZ06m6q8xC3y37+m1XVWfKxgMrlxzkS/UW0OfSsK8TpGlfboQZ82jl+/gDAH0WkJTt0a0zBAWURmFLLEuo7qNV8QraycrsTNvHxrh+oB8LuidgctAFXdQGQ0kwg7kJHVOS/Lzz3XJYOExlYSs+txYjb2FUUrKqgHnETjd5HVdOVetIJQlXsbZR84lAjzDzqBCDeViPgJjmV8yAQV8TAGO2HJeR9sGq1sO3Dk5QArj6uApY5Q5oTmCr0MA7rO+qZgOkYY2LUb3nEIGVvuGR0a7V8x/LQNjGAk6G+nkMCjvzinNnqNGkgnaZwiwTZA2aRVrzS8KkbYHEvO2Wn/t2zk2Dj67mtMOIUGorKup2OaRNrmfxP92z7M+YYpChTHa4g3lzT6o9ujnD51ksmMOIn0oQOc7+jXzOfAsRycl0XehxlalJ1D+UuDwP/Vlml7IhUiPERxc+f+mIFgcgqRjX+PImtYXg3A0iPWxDR5yGkA6pxnLNVv3st7IUk5herETylqCNmtCUxKiLzaWHAPiPCJ6shXBkHlVGaHhBjSe7m0CP3kSv1z+GqPd41j7x3Z4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39840400004)(366004)(41300700001)(316002)(26005)(6512007)(38100700002)(38350700002)(33656002)(8936002)(2906002)(52116002)(6506007)(7416002)(44832011)(508600001)(5660300002)(66476007)(66556008)(86362001)(6486002)(8676002)(4326008)(966005)(186003)(1076003)(66946007)(6916009)(54906003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uo2dux7VJV8kgcXXebTbgDHp0biQnq5jV1ethrOEUghK1iF5KKr/A9a8V3ke?=
 =?us-ascii?Q?XSGkxatar/rWG2zSoezFRPoX+MG4dHvwp5Vb43Wdk/LU7jNDEAw8HIvg6eLs?=
 =?us-ascii?Q?nUrp5ATtf7oxcRt8Fe96wQVRMKhBtCzlpRkI25R4guR+/OSx/2zKAR30KSss?=
 =?us-ascii?Q?lR14vEX7iBlZnYvdNu9aAMQmWlVS3Jhkwqg3YrDq3W6zdIETSji978sWEfT0?=
 =?us-ascii?Q?xHBet1p/xDveI1qzGYAxS0LhnxS7mjffwtYRRT2FClEncl8r7TGM3jL36/kN?=
 =?us-ascii?Q?gZH6GZWHOi5ZSr3Wx/RIwNmATWn/Kb8Pu9febmV6i8TkYwohSqS3Ql+tXVR/?=
 =?us-ascii?Q?0hfuSym4X07HdLqUxHS0O7+BRfCJZ312BM2ZNRt3nskhClb84yEkcIE1K3FP?=
 =?us-ascii?Q?XZxTEwFJA3iB+16AuTMwjcyJaRE1PJurHR1EgsYrxTOz6Q1ZB0XlrejSRv38?=
 =?us-ascii?Q?NeCUzXUM7A6KqC+E9cgWiF11KDvydkLu63GY4FsUHMvfNJ/uWc7f1L+7Rx1j?=
 =?us-ascii?Q?zNHsgkD/zHPqRBIWx0eEurT6pbbCkll/O8DAxjWIKL1fZ/ChOQl2IFp0KNVI?=
 =?us-ascii?Q?y7iW+kS186sfr207oI+GG5mv3WdSeEWyPSYEW5kUgaPZw2mDvzc1bGUXP7Kc?=
 =?us-ascii?Q?py5rVJfSPT+DauJmqohaLxjh+6F7Pe2avpP9i2jkO4dHSRji218VGk+bIAd4?=
 =?us-ascii?Q?iJOt6WKUHKPdEAPCU681Gi5+pXwp/IgTFR1YS1FDEsYrzR3DuY8D+mGyganp?=
 =?us-ascii?Q?/gwHRcXddQz0J2L5+Vpckxo9xjDEb/+Vv2nHaEdSMwCsDazVqx7OfWVCAFCJ?=
 =?us-ascii?Q?df/bUUXYGGZH4Jw4ToXZiWS+JR/cHs8KVtZ5Xkf+zvwDckW248SY9GI2FRgS?=
 =?us-ascii?Q?2OHpws639ugyV1I5dHOZcYkq2/xbPBxetvkM9yjrOsVEv9BebygDPpBt8lG5?=
 =?us-ascii?Q?qWocDWZOhf+9yRROIcULIT+EDLGkMHNAIsR6ZPYqVF2ZZZwkeCiiR1dUFcs6?=
 =?us-ascii?Q?NpaW77ToGgINQzybNfcB3RxkYDlTni+0hlQ+3+sysmolinIz52S2fUOkss7g?=
 =?us-ascii?Q?n8TV+1xNTFv1/ajYm4ttpZ5wfXHfoPWcCqGqaGpWRMsn50xVMhpoSginkhwN?=
 =?us-ascii?Q?yj8CWoazGPOHBgXRdk/Vp50U1Mm4+kBfs6o5ZwHXh/+1FYNHmYPNlp+nEpSp?=
 =?us-ascii?Q?TGiZpsKZ2jI58f9k9NzruG8o5ioi7ZUcnQX2QWjpHs7ernWGZRAlZkkRmf39?=
 =?us-ascii?Q?kx/cQAoEl1I9J1eKkQR+7EWLaFnachiOLqpgXcTCxV56SHHDe0qjpg4GPlDW?=
 =?us-ascii?Q?VKuRC9eCq1RrNeQoK3SyY8e4X0thZ4rTfu21hM8/Uyg7LPhDoJAwfWIqnQmW?=
 =?us-ascii?Q?fQKkdAS9Vo8KMnXY39rReV/yW2F2FM1LsaYr85rtnUnbv51h6w0GQFNs+ECy?=
 =?us-ascii?Q?0A7/YRQH/Q4jMOc8ZKq8QWqkNLk8HxaSx+T8u6aQwHISKnOJjqiWgmJdBAxP?=
 =?us-ascii?Q?HxqX5GQw2WP5zJ9o5xLsgkPqr4U53zJKqV4kyLGmXJuFcjg5v+XDTE6oMAMC?=
 =?us-ascii?Q?LKqljIQ4nh76/x+eKdpNnnWqeV48rQviNMmLFlr5VEo5+R/A97vfWkHgYbbR?=
 =?us-ascii?Q?PHbG7tZvqLrPzNlL9bXr0BywYT/YdSKbMdJ5+01WR3r3zxwfZVnpTlzagz3k?=
 =?us-ascii?Q?tOQcez3Ta4iUKOJqPK014rF3B2orqAUK6QNVvasIVwEdAKY3XbvoEVTlr0nA?=
 =?us-ascii?Q?BxVRm9yAHrl1Y36webhNIGA4PB10UHc=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dd53a8-15ff-4dce-2c39-08da50412d5b
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 09:10:09.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAGl1n1uk1BwzRLFpknl5Hb8tIc2Rb50QdKzK1MqP9LfBTVvA2bQCDp7eDiuSCDS7Jf5LgcMkx4s8Fv5gt6RxkI1XRiyoZSCTE+vDABQdws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0266
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=UTF-8
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

Hello Michal,

On Fri, Jun 17, 2022 at 10:36:17AM +0200, Michal Vokáč wrote:
> On 17. 06. 22 9:55, Francesco Dolcini wrote:
> > On Fri, Jun 17, 2022 at 07:51:53AM +0000, Jacky Bai wrote:
> > > > On Fri, Jun 17, 2022 at 07:31:25AM +0000, Jacky Bai wrote:
> > > > > > Subject: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
> > > > > > configuration from DT
> > > > > > 
> > > > > > This series allows to specify the imx thermal drivers trip point
> > > > > > from the device tree, without this change the threshold are
> > > > > > hard-coded and this might not be correct given the thermal design of the
> > > > final system.
> > > > > > 
> > > > > 
> > > > > The threshold is set dynamically based on the part market temp grade.
> > > > > I am little confused why need to specify it in DT?  I saw in 'PATCH
> > > > > 5/9', you provide a threshold table based temp grade, why not use the
> > > > > threshold from ' imx_init_temp_grade'?
> > > > 
> > > > The problem with the existing temperature thresholds is that they are
> > > > hard-coded into the driver, there is no way to change those to match the
> > > > actual final system thermal design.
> 
> AFAIK you can change the trip point from user space if you build
> with THERMAL_WRITABLE_TRIPS so in fact you can adapt it to the final
> system design.
> 
> We did exactly that when we swapped imx6 dual for imx6 quad but did not
> have enough space for adequate heat sink.

When I investigated this only the passive threshold was writeable from
user-space/sysfs, and Daniel was against any patch to allow changing
also the critical one [0].

Francesco

[0] https://lore.kernel.org/all/4de41b5e-1fa6-ece4-9d9a-2656d399b452@linaro.org/

