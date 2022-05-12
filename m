Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB61524A38
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 12:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiELKZG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 12 May 2022 06:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352595AbiELKZE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 06:25:04 -0400
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.109.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8751D193225
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 03:25:01 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-0XDFnviQOeCRQrMGPbgNTw-2; Thu, 12 May 2022 12:24:56 +0200
X-MC-Unique: 0XDFnviQOeCRQrMGPbgNTw-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0298.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:33::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Thu, 12 May 2022 10:24:55 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 10:24:55 +0000
Date:   Thu, 12 May 2022 12:24:54 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] thermal: imx: Update critical temp threshold
Message-ID: <20220512102454.GA39979@francesco-nb.int.toradex.com>
References: <20220420091300.179753-1-francesco.dolcini@toradex.com>
 <486c5c72-812a-d4ea-0c5a-49783bdc4a1f@linaro.org>
 <20220512073600.GA36153@francesco-nb.int.toradex.com>
 <6918b1a7ba401cd4db2db0601137766acd93bc63.camel@pengutronix.de>
In-Reply-To: <6918b1a7ba401cd4db2db0601137766acd93bc63.camel@pengutronix.de>
X-ClientProxiedBy: MR2P264CA0010.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::22) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b5dde6e-af24-46ea-2796-08da3401a85f
X-MS-TrafficTypeDiagnostic: ZR0P278MB0298:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB0298E94244A103DCCECB6ACFE2CB9@ZR0P278MB0298.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: pOlkIHv9lIz6EifqGjkJQ6+Ie2cjA7Z7lnOIeRj1osqUPFzGhkYL4H5lVhsS2bdFJqPMxMB4VfuwqvJ9q+oTA7LSXVE2poqxCWQ/3GWZd+QQHa2n+HhGGAf+azSUWJFKJqjC3SZ0XaaCb3Yc3VcJ/FxN4E7393lad3fG/xY6x8Q2+I3G+usjC4rDVzmZppvaixc+zH0uYyUW0g4RQoBn2W5VXfMRunr3EFx90l3zS4w2s0y/iMkYDWyMQb9IpnvslaoAx79RP7ek1MlyZU+1Px3ifsRr2rbW6UzjYWxvYf1shJ4/zT8DL34Dg9CJmu2flngqlpf3hxSIu5dQioTMuOTmRkXTuaCJ8DnqDxkcXcNNnZ9cXDdQr7gDIH1tI/8C/NHbuTqhxxXhjQsJApXMUqNQgfa6U/oY/nbq4raSOZ1lA/8/RzuV4z4VLyEp5rFEfHlPPNdcJWb+SgnRpvBGkE7hdLGfO2hYPuavvETRxqBgCY02UBEGNUPID7nDlWX/ZDEy6QkP+zc8nGqB2jcfigEbK2EGzGYrdqbIXU4sUzgkC62bc/OcO90tQv+lt3gqz5LtUUYa7iL53fMojtJifBnQU/5SyGCVjRX+oazX6e5f671c18FIeRNVUpbcHx6ExLlXudDp7F8shoQ678YcftLixfRi7GI8YxaSnu43gZcXZhI7cypnjYQcbt2h8HyVZ19ojxZR0VQb3MTm2T+rfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(136003)(396003)(39850400004)(366004)(376002)(7416002)(53546011)(44832011)(6506007)(33656002)(186003)(54906003)(52116002)(316002)(6916009)(508600001)(5660300002)(6486002)(26005)(6512007)(86362001)(15650500001)(8936002)(38100700002)(2906002)(8676002)(38350700002)(1076003)(83380400001)(66476007)(66946007)(66556008)(4326008);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2W5HJZr2LkjrrTleVdtWxPZAa49no04cVSbl74ItkJoM9cT3CWuLbfrWkoql?=
 =?us-ascii?Q?vsNrVvCxmum6pqDRQ9jLOsfIe4L4D76t/YZTPKw1V+afm3gbxtMDp/ZSzJYF?=
 =?us-ascii?Q?Pu0XieFNaLdbK6gnWuRCbGpb0r5upgPhD6+cMxin5KOxT8ewzbf2WBdZF8lh?=
 =?us-ascii?Q?BFrP90gU4mLhq8QJTQLVbzRIOcI04jleOKPqoUH9x1S1mYQrhsBetxKKEme1?=
 =?us-ascii?Q?5w4gBPhvzqSFBhjLuScBQMHo4S5YVYoLOvGQCDBu3amNOGM94K9YfpaZyZwL?=
 =?us-ascii?Q?QmCfLhsyvGAUGAuh2CX762ZPOIhg+Q5YDJmNreT58t5tDIGin1bzF9Hkyv6X?=
 =?us-ascii?Q?/BK54SPWWC+6zt1GdRwXePCxmPqKdD/+7vJ5glrlmeGW9zx76Mt7KXAdij1n?=
 =?us-ascii?Q?XsEIy5Vnkv8pp1sDOJ2D87RxaRollukqQZuvWIt7ichM/oiyhlvN4HyBCU4f?=
 =?us-ascii?Q?JB02TRhQZOhyvgmuvOurObthXv2Tm+ZZb5jefReE0nH+/hsi+qEnVTLC6cSN?=
 =?us-ascii?Q?BjEB05WVcqMjRxtUn1jlpyTK93FawelEUi8vdXSdFrt3VM12cgRw4GAuefbi?=
 =?us-ascii?Q?EntHS9Qw/nGwX59hE2td81vrunw5DFJbKZTubqiZ6WHIAsGpGY1ELAAiyOpy?=
 =?us-ascii?Q?Wq4u4Fjp+pBnYJ7TRV0X7qmp/2TJsoMdJa/IOgw8XK8aKH6YMI15trCPTDUR?=
 =?us-ascii?Q?kx2BZ1FSMu7CJNowCCcS0heGwUpZ98myI6FjD9iGDukuUJmTqRbxkLhJq2EV?=
 =?us-ascii?Q?W77oh5GYkMjIVnJj9lEkn9Yu6uI0nmY/RDBgrFeQacAw+1HLEirjxpTSe8TV?=
 =?us-ascii?Q?H/junM84HCcOFjb/j4NPEdyodpzcZQ7EZthiEgX105H4wqB3vtf08sbWo9Sp?=
 =?us-ascii?Q?0/xrH3okBNceBTwxprvUEs3GCWpRRkPdHUyO3fh1T7lHWGC64DI/IeRLUjzL?=
 =?us-ascii?Q?ooTsRHQd/S17fFiX5pBaM6C8yXl7NxWAf1izal8s9JrHUD4x3Syv1+fn5PRq?=
 =?us-ascii?Q?gAgCa6tvLPLHg/z4NICqa0jYDizzr9kmOPw5BwHe2imlGeToaqj5SLL43ww9?=
 =?us-ascii?Q?vNteFNOhD54OzaEdqEIUClDOw6jHDX6HfHqx6pfthsSoe8uavbK7mUlC5XVx?=
 =?us-ascii?Q?PxbLkHHn2lBJm+7mMSQ6QNACtRgj82EzD4NMnKHS27vJjs9PUeiOBp5dkFxd?=
 =?us-ascii?Q?hVE+6yUDXg3SAcmB+rkZvwWKyD37I6aaQ8mUc0+dplbbvlwrO0X0xhS2UspP?=
 =?us-ascii?Q?gK9hDas6yEQnLEPyTy2ID89gyU2WE9dTQLb6pJZjAqOGjEXb9UUN3W//DCLS?=
 =?us-ascii?Q?p/M8DpL5A3hb1f9lY0/nGPwxe8PRrX6yeDO/VRuNts5Ni+5JAv3i4KYVlnnk?=
 =?us-ascii?Q?FmeK0d7KljOP/bWV6MJuYbydB9XBWgiNnnCoFZF/eBvnhMw28+6pxarJS4qu?=
 =?us-ascii?Q?/ub/PrtBF6Ye5p6Xz27lLOViCXrQS0Qs2wF/+xgc++A8cxU2TAopr5vTxtbt?=
 =?us-ascii?Q?A6zHIRw3gqUCTVGMBiwENahdUfwj6Vx0Zpenkx3sijDXyY9sLr/TdYI/hauW?=
 =?us-ascii?Q?NGjFZBwr5wMQYmLwb7mDHT5UryHVmi1rNPZkUM2CTO+SkID3pauqeTCmxRHl?=
 =?us-ascii?Q?dRy7UdOupe1fiSfdKOWszaNuQqoRLrM81z+ZNhZW7fmBGuuUxu0iVu8kJuXo?=
 =?us-ascii?Q?F48MisVOF8d9eREietyqLkT4AmWYR1C5hanVgwxMAGyi534nEFcwH8FJakjm?=
 =?us-ascii?Q?nn8xMKJ7eZwFzQQkKY+LPV5mizm9VXg=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5dde6e-af24-46ea-2796-08da3401a85f
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 10:24:55.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eL0mig5pL/odCowfeHfNv9A00dMFWb4tlEFOnh1gAYpaoUW8iHiwJaWG99Am6GeGzUAkfUWyQVqOXevWmMQaExwM+6YaxIzq6SJlF3CRtSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0298
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Lucas,

On Thu, May 12, 2022 at 12:08:08PM +0200, Lucas Stach wrote:
> Am Donnerstag, dem 12.05.2022 um 09:36 +0200 schrieb Francesco Dolcini:
> > Hello Daniel, Sasha, Shawn and all
> > 
> > On Mon, May 09, 2022 at 11:55:20AM +0200, Daniel Lezcano wrote:
> > > On 20/04/2022 11:13, Francesco Dolcini wrote:
> > > > Increase the critical temperature threshold to the datasheet defined
> > > > value according to the temperature grade of the SoC, increasing the
> > > > actual critical temperature value of 5 degrees.
> > > > 
> > > > Without this change the emergency shutdown will trigger earlier then
> > > > required affecting applications that are expected to be working on this
> > > > close to the limit, but yet valid, temperature range.
> > > > 
> > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > > 
> > > > Not sure if there is an alternative to this patch, the critical threshold seems
> > > > to be read-only and it is not possible to just change it from user space that
> > > > would be my preferred solution.
> > > > 
> > > > According to the original discussion [1] the reasoning was the following:
> > > > 
> > > > On Tue, Jul 28, 2015 at 4:50 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> > > > > Yes - the purpose of lowering the critical threshold from the hardware
> > > > > default is to allow Linux to shutdown more cleanly.
> > > > 
> > > > But I do not understand it.
> > > 
> > > Shawn, Sascha ? any comment ?
> > 
> > Just one small addition, we (Toradex) are using this modified critical
> > threshold since quite some time, on multiple i.MX[67]* SOC, and we
> > regularly run stress tests on commercial/IT part on the whole
> > temperature working range (ambient temperature up to 85 degrees for IT
> > modules) in climate chambers and I'm not aware of any issue reported
> > because of that (indeed, it is the other way around, without this change
> > we had issues).
> 
> That is really an overall system design issue. Most chips will probably
> work fine when going over the critical temperature, as this is mostly
> set due to device lifetime constraints, not because the chip fails at
> this temperature. However the chip is only guaranteed to work at up to
> the critical temperature, so one could argue that starting a orderly
> shutdown when the critical temperature is reached is already too late,
> as the temperature may rise further during the time taken to shut down
> the system. Also device leakage increases a lot at those critical
> temperatures, so the system may fail not because the chip is
> malfunctioning, but the board power supply may not be able to supply
> the increased current required.
> 
> Really I think there is no right or wrong here. I believe that this
> needs to be up to the system integrator, so the critical temperature
> should be writable by userspace in the constraints set by the fuses.

I agree 95% with you. The 5% I do not agree is that the final system
integrator should be allowed to go even above the fuses constraints.
Sometime is better to take the chance of burning a chip than shutting
the system down.

Anyway, would it be fine to have a patch that make the critical
threshold write-able (in my initial message I mentioned this as my
preferred solution also)? If anybody has a pointer on how
to do it, it would be great, I'm not familiar with that code.

Francesco

