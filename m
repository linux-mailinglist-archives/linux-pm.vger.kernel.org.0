Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00624528DCE
	for <lists+linux-pm@lfdr.de>; Mon, 16 May 2022 21:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbiEPTRK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 16 May 2022 15:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbiEPTRG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2022 15:17:06 -0400
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.109.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BB0E3CFD9
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 12:17:03 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2113.outbound.protection.outlook.com [104.47.22.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-Kbcz2YTCPc6CqfjMVlgn4w-1; Mon, 16 May 2022 21:17:01 +0200
X-MC-Unique: Kbcz2YTCPc6CqfjMVlgn4w-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0134.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:24::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Mon, 16 May 2022 19:16:58 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 19:16:58 +0000
Date:   Mon, 16 May 2022 21:16:57 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Message-ID: <20220516191657.GA148058@francesco-nb.int.toradex.com>
References: <20220516190001.147919-1-francesco.dolcini@toradex.com>
 <92ae0fd5-f827-ae3c-bbef-d551c9fa5b76@pengutronix.de>
In-Reply-To: <92ae0fd5-f827-ae3c-bbef-d551c9fa5b76@pengutronix.de>
X-ClientProxiedBy: MR1P264CA0022.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::9) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5184633e-e2f8-44ef-baa0-08da3770a606
X-MS-TrafficTypeDiagnostic: GVAP278MB0134:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB01342A778F83621FD6B9B7FCE2CF9@GVAP278MB0134.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: d6eAbbFdA73xybZL7gGFgHiQZxQHIAeMmFd+VBm9FkDz4j0qt4kBPTFyErztP51Q5n0sUTFZwCCymG03gwA80J+qEWLFGf+J4hI18i5ptBTd6lCKCvvDUUrG+pxFA1Tj+JtjkmbXqgNIz+zB3oXmkgrTsgyiaCre93gSnxGyHhWVyIctekV4443uZNFR3gdoLBYQaCxqo1ix9ice3IDMgGzBnbf0ngM4AsDAmy4iSJwu3GQCYmmnLI6gTkfqGS3S4vS1HAq2QW9f7hGWsOGHPRshMgy3bEGrSA5z6q45BCWGQqQ+UC9Ce3eHEJa1c4ZCmPC6f/jo2B3BpsplmPXWsXwTVMLOH1tmK75zD0ZyabrCxx/i3K20f/IEaxaDkTuAFayoQzsftlrAo5kZCIdkTaUbObDey38lE+AG5amc0hdjuI7hfcESqPPHJiPn8XVmEME8pYLOjNdQlQF75QWHmZgx2rLOgPKEU4YgmZL+YLD7gue7s9UbIhanWpVEe00wo5AYgfGTWpHhIl2LCvhOpkCEMsi3hfWg3TUuacVWB5G1rYEwTvkthgRNmuptTi4UccmI5rjpR/WIJJUTDW0vqROevyiBEKwzgma8k5eawaQ7QvhNmjveEhOnvkMqr4GGmk+WfNOCKweiu2b+JQxQQJ9tKb8E9cCbmwqV9RJVLPghDWUcJyw8dC9a0bCEWFDSZeSN02iRx5XTXiPa0Mz1Ug4Qs85ZDAEQZzMZ+TyUpDAdcZoNv0dYqkfgmT9VEsE7XirBRmtksfUR1toGRh7nmK3lpAW/g0eEHyWw5/zsO0mCL7iagYTE8JiM1oHYamd7kloiPH1IQJUAdbAK8zpfdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(366004)(8936002)(83380400001)(52116002)(186003)(44832011)(508600001)(7416002)(38100700002)(38350700002)(86362001)(966005)(5660300002)(33656002)(6512007)(6506007)(4326008)(66946007)(66556008)(8676002)(66476007)(53546011)(54906003)(6916009)(2906002)(1076003)(316002)(6486002)(26005);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PWk1i7SyVtDVToQKw3zlK9qN7AdHSWKU74J/YCCcNxGgZ9jlr+iW4xMbque1?=
 =?us-ascii?Q?Nm4g7OFW8JgRDqK9A7FUcwxzAmK1hsQe9a67oAb3y2n/YIfgxe1oR7YaIy2x?=
 =?us-ascii?Q?96CLIh+NTYRwKnjnV/AAgKNNdBK2iO9vm96KQLtFnRvfsXAnjR22aGK/o23e?=
 =?us-ascii?Q?jYzMrFIBBKVpd2VVHMIqqv8OpC536Dzm6aFoU24ZT+/PbN4u3YtSCLSDHQ3o?=
 =?us-ascii?Q?1KjiatdtrdMAX2Vk6kUZVdZ97VM/byrIf4HFjzbN+D+RiJdqu8xE4xoUw5Fy?=
 =?us-ascii?Q?rwahHGI2jitvM1hCrfa4i8whtz0tpNJ6KqSBbQKAdXh/i9dP/iBJ2k94uAhz?=
 =?us-ascii?Q?2wA7a910wLW9AOP3p0VkxzPj9jU/uUwt+CUF5O3sgqpl6lxKbpTj4i0Jq9VZ?=
 =?us-ascii?Q?+umPT2MaRkknKzzwJGeSmKfUB4Q54appl7PnF0eHLnRpyca+CeR2X+yUDMP1?=
 =?us-ascii?Q?NhbhAWEfpecGois4OtaTZql7Adb+Ur0o8CpoRHEU0CjWAApX4W40+AHJW0/3?=
 =?us-ascii?Q?s5hz+mFCmYtRmQgzGkvKjOSs9+WFQUbWj/awuarnGV3lXJIYjFR5XT0T7dxR?=
 =?us-ascii?Q?rNfFRENkaplTlSWyKNJxlp3aBjhMmsbZ3lUO7D54sr0h7iUspMWjQCh0ySze?=
 =?us-ascii?Q?AoxvHJyoQYF4IoH+a9VSQ/CEcX7hAL6v1+7HqkzZByMWOhBIXvUuXE54161g?=
 =?us-ascii?Q?X19IINRozMfmSGFnUM6ZKueeFplb3mxegGqIg8FoHQVJF+ZYDQj/JywvllZi?=
 =?us-ascii?Q?FadBWP7Qg3EN/d0lPBU7cinXt7iDYyOrj3lPEt2RLVsQQTx83GIn3CSQz9nD?=
 =?us-ascii?Q?En2gGozH56R61IWKdh1kdGrnj3+/yzacOY7m+BLxClweUX1XG8Vss/3f1XZw?=
 =?us-ascii?Q?w+IPzPYnTfEVVCKNHF1gz1yqN9QifstIJB6vmIFnjF6VN6LqONF5aaiJEHBz?=
 =?us-ascii?Q?tzlQhJgOb++fbjipQEgiTJzSQ0kmBshaBvWJTgJ9AeI9Zs5VCvDbn3Asu5b2?=
 =?us-ascii?Q?yk/0suvKDJVoi/WE2vJYCjPkc/mlh3cjGOMP1+xSVpUqv6cmkE+9W7UEfTCl?=
 =?us-ascii?Q?OVjTai7piAyNPc5Ro1b2JlMDNirgpIv5h9A+lUyjjhNazHnkQVgHspvlu91v?=
 =?us-ascii?Q?RWwKqYJXcqor9bqiGURpJU5v10so5Ud/a1SzCjDLxuVUXaMcMJGFmULmaJoO?=
 =?us-ascii?Q?+FRqi6zZRA+jqB6WqAt7nNUnR3n+2t8yPluwzGI4b9wshIoYbENeFVV97Q3H?=
 =?us-ascii?Q?h3PPpkkg5H6dyQmJemBkWmNA0LjzPHmHJgJL3aQmQNNj/AVnwzI+qjaKJm7j?=
 =?us-ascii?Q?sym3IwGpo78zhYYg3gudfiTYJc8rzIBz3s1CL3bjQ6wF/1y/4h4oEf5IcDkR?=
 =?us-ascii?Q?Wx6iFR5o7lOk8sJY93jkPbdEP9ghXzAuWCEhV8XyRdKyg7QmGIVJcnFfXy7x?=
 =?us-ascii?Q?z8+f+2mrc9gmVMj2LQQV4S0D6KNWwnCA8YvRMt9PCk1h/GRZqlXhyC1RX1TA?=
 =?us-ascii?Q?+RB1WgagVHrtZNfvNLh+HjZS8leZOXW8BMisHXp5ZiFTdba+NlPl/J+8Bxya?=
 =?us-ascii?Q?CqLO/Pj0R14G/m6XYYbQvte/Prwiae6nkfedcAF7NTs3HlB5ut8G5ck/DDKc?=
 =?us-ascii?Q?KQHyBkpRfPwUY2xswLnkBmubv4r94M4fOcEAut3U3ph8mUNGUztbPGiacHU0?=
 =?us-ascii?Q?/yVxyshh3CeJXMiartsjt6zLfuuWb/7rdO6bpYmD0I0yRl0RW+7XoMX+tpX1?=
 =?us-ascii?Q?llbOB9ObpURw3vIQqwdbE+Muh5jQMag=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5184633e-e2f8-44ef-baa0-08da3770a606
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 19:16:58.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ovyl7V6+iUiyT0s/t7EKKJl+ixJ1b3cEHu79KPGtMiHU0pEZKOkrlhIuxmTHveZYXV46ic8p8xRjSG9nPyTxgwaAR10vJmIGfpmEeEfakN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0134
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

On Mon, May 16, 2022 at 09:06:10PM +0200, Ahmad Fatoum wrote:
> On 16.05.22 21:00, Francesco Dolcini wrote:
> > Currently the imx thermal driver has a hardcoded critical temperature
> > value offset of 5 Celsius degrees from the actual SoC maximum
> > temperature.
> > 
> > This affects applications and systems designed to be working on this close
> > to the limit, but yet valid, temperature range.
> > 
> > Given that there is no single value that will fit all the use cases make
> > the critical trip point offset from the max temperature configurable
> > using a newly added trip_offset module parameter, passive trip point is
> > set to 5 Celsius degrees less than the critical. By default the
> > system behaves exactly as before.
> > 
> > Link: https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  drivers/thermal/imx_thermal.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> > index 16663373b682..42d1f8a3eccb 100644
> > --- a/drivers/thermal/imx_thermal.c
> > +++ b/drivers/thermal/imx_thermal.c
> > @@ -86,6 +86,10 @@ enum imx_thermal_trip {
> >  #define TEMPMON_IMX6SX			2
> >  #define TEMPMON_IMX7D			3
> >  
> > +static int trip_offset = 5;
> > +module_param(trip_offset, int, 0444);
> 
> Is this being r--r--r-- intended?

Yes, would you expect something more or less strict?

Daniel was pretty assertive that this is supposed to be a system
property and not something that should be possible to mess around with
[0]. Given this and that trip points are a+r in sysfs this was the most
reasonable solution to me. Said that I do not mind changing
this to 640 or 0440 or ...

[0] https://lore.kernel.org/all/4de41b5e-1fa6-ece4-9d9a-2656d399b452@linaro.org/

Francesco

