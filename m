Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBBC531493
	for <lists+linux-pm@lfdr.de>; Mon, 23 May 2022 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiEWOf7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 23 May 2022 10:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbiEWOfz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2022 10:35:55 -0400
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.111.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E53C7580F3
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2022 07:35:50 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-jjY9dcuIO5mtWQuYPO0-aA-2; Mon, 23 May 2022 16:35:47 +0200
X-MC-Unique: jjY9dcuIO5mtWQuYPO0-aA-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0623.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:42::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Mon, 23 May 2022 14:35:45 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 14:35:45 +0000
Date:   Mon, 23 May 2022 16:35:45 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>, l.stach@pengutronix.de
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
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
Message-ID: <20220523143545.GA30537@francesco-nb.int.toradex.com>
References: <20220516190001.147919-1-francesco.dolcini@toradex.com>
 <20220518085522.3fpzy37kkbkn4hpl@pengutronix.de>
 <20220518094916.GA27037@francesco-nb.int.toradex.com>
 <0006b8cb-b4fc-5015-5c86-be2a6a39be93@linaro.org>
In-Reply-To: <0006b8cb-b4fc-5015-5c86-be2a6a39be93@linaro.org>
X-ClientProxiedBy: ZR0P278CA0158.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::17) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ac5738c-0621-468a-b41f-08da3cc985da
X-MS-TrafficTypeDiagnostic: GV0P278MB0623:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB062351328EE8AA1C20C28A60E2D49@GV0P278MB0623.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: qFnTZBFAPNVZErH+4QImbokH0IZyYEDYH2Qv420vCMAHIBlubjCsWyaLifactz3yFrnUeQ2Yuh3WAkJPLOsTeVEf22fTMT6j5tSDnKlLh7FY2xsgkeQFzosYqYe1nVvlJ/jFWvk+Qt9VdKL2D8N+H/Spy022WG97U9/k+vMLLDPi92+SPuUTznv8FlCx+wXnSynEARulT8UnOBPxLx4ghSt0hwaxYH99xRqojQ1EJoi4biKFh9wMoy0Xf/witvxBTU21Cthy4yMOgk8UdJ93f0gHUkssBxt0kTT6CCKHhk8OxjKedMPT4QZptc9Q+mOlzK1su5GUOLKk1AbcJLLTnmG4BF+S/FiwEy7wB5QviaYMR33DvbnqZnNxv2BEMfu9KpQ5pQksbPK6k8vCTSik/rj6xfg5kPi9UWkcJGUBLEwvvl9Vlygp3tEywiFGzdOsqPcrI+CJAvTwYvbQYiPlYd4j5Bgk9sB+FdFXBwNuFjllyh05lyByHRQu5i42KKT5Otgh7aihgNpRv/NyOdls03pbW12yA9ZYOLx2B3EDB75xE3e2b3vX9aRNzeLZGNpz0gYF3xArsqDp37fDzme/yrt4nbfbdtR/poxHHkiKPLCc37Lm34CaV+G2ETzlwORPJu4FR074XBQbEQyet9XeqM38mwXWTr05+PnzImyx34hBU8aouQS+iRjhx83o/eY2o0EpYdZbJ+D+WIHd+Aic9QnvXRuO9n01a3oo1ZqnbLsKCA8h6QUeQCO0TzPIsNLTMZdx5aBPklaSaBNlS0I361ve4d8ZofeviOMmDB++0xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(136003)(346002)(366004)(39850400004)(396003)(5660300002)(7416002)(26005)(86362001)(38100700002)(38350700002)(66946007)(8676002)(66476007)(66556008)(44832011)(2906002)(4326008)(8936002)(53546011)(6512007)(6506007)(966005)(6486002)(508600001)(186003)(54906003)(52116002)(1076003)(316002)(83380400001)(110136005)(41300700001)(33656002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bKF1KjFF7cQ35Xc6FMnbhSZjenZ60BcANi6VoWfItEl7mAdVdJybjdiKAfb?=
 =?us-ascii?Q?BdRb2ODUeDaTPYAKD7f+MMw67qduTNp4JDXigrzWYLmNVTOYK1KFfLpWxngc?=
 =?us-ascii?Q?sONvsyPGDBXTZ17D/SJlmJRRA8ZVlB8xoRw+FZkwAGuWSLn+oJLGkKaYAFPS?=
 =?us-ascii?Q?3fvHIeXkYAFtetJpMRhRtpWpZK/X+8aPku8nK18DfDHmY3s7aYz+Rl+6Zczb?=
 =?us-ascii?Q?Ue8eFa+p2M5Rfa5T/YxcaBX6KgIF4EH41yZzyT3LlilVVxhWeBMMZIk3qKBK?=
 =?us-ascii?Q?4s2rJoAaU5EKIZ9wyJK4ceI/QdpFm079r04k62F2cBQkguv1KGfh0bDlh1hY?=
 =?us-ascii?Q?aYX2Tt/KWtuRDprx/o+GThsgoJGr+VUKIJuNwvevtnC8p3BGp/glRZyuBoBq?=
 =?us-ascii?Q?UdpLQA64PiixHAQEGh2st9bWYyLUKbCsh2qt+cCMW9gP4j65duTlqIfoA63Z?=
 =?us-ascii?Q?Q0023bmuijfqK2BK9gQtJEdjN3Kl22Fa+6SHrqGHDq5sOac2LKutPr+JXeMk?=
 =?us-ascii?Q?krZ6D/tt3n2ZyHXq/PNah3kQfH3cQL+Z+ECnR4m89NcFbY+krCUqh7blEKR+?=
 =?us-ascii?Q?T/ZAfq4Cm6cDjYa0xMOFoLxLonCVXaJm+paMFQ1PByLXuOTWorP72EJ8LhGH?=
 =?us-ascii?Q?VVN51W0XCTIhFaSYokrIlYlCyH8Z1ZwtULQJexzgAaeQatmkdBpRRQQc4+xV?=
 =?us-ascii?Q?Ba9tFckUySiuo8uGHNfiqb2l+/mCjgWjuhxOaAa09cNc14OpSGBez037zncL?=
 =?us-ascii?Q?DhZ/NDlppZtq8NHs50kyP6O5vtbK2HLGnQKpUdcRPwlU1oY46J8VQIYPPRRI?=
 =?us-ascii?Q?3VytLffkSLV/f0b6TGzvK4dcii7bZSTDtVjy/ZJRP1XnGKydezwUWi0vfKP/?=
 =?us-ascii?Q?HPv5RSvtQRFstcTqbAREOkCw+yBQd1xp921k5tYdHWC77FXPV6c2ToLs966z?=
 =?us-ascii?Q?y3ljnbWk9napmw3haLLe3puC3WvqTJdRI+u5sZenpzZmh+JEOMSaO0DfS19V?=
 =?us-ascii?Q?CuwetI8tU1aJAYjF4bWQiQZf23PZaoKhT8AqIJvO2E4QnMkVDdG4j2k3jKL1?=
 =?us-ascii?Q?km5ri743zJDTmHG9Wihb+qzODHLriBtF1u1CpO7KKFC4OhaN2qqNluQ3kNkV?=
 =?us-ascii?Q?QMBC2r05rWfXbXd9cSxLqa6iqeAzF3HcTPt9n3ASlgitP87Ygrh6vy80f+HU?=
 =?us-ascii?Q?FHl1b9wdrwTRZTAqi6OR3uSK6CDEWBSf0vKWdrcSonzLgXyQ8kh4uAuyxplS?=
 =?us-ascii?Q?8Zh70esrLfqhPycH7ksj5gTMHoHEpT7C1uO7L9WONEQ7gPMC+1YFcAtwRPsv?=
 =?us-ascii?Q?qDNaWhyYyYARAqUqWl7yCS8AF1Sf7gBUEwx1FKNrZ/byZbytMCJCQcLYHKpy?=
 =?us-ascii?Q?KCvyqPEgV29NnPsvPp7FH7vutrR8H0y8hrFaddfFPTJ/xe0+9qq2nBeqnU4V?=
 =?us-ascii?Q?dwsT6so1e13Btvmp2h6cpGurm8Da/BH8ItxgHifv6X22ByFn2efUZDWH+WMt?=
 =?us-ascii?Q?U9hHqRUTttPxRxm1p0rQNMf0zG3xw9Dc7/1LX88d782J5AUIYnl6tbq043OJ?=
 =?us-ascii?Q?2hbn6Csrk18+MCiCndn8G4wONAPREVUzh831hei51XI8059/dEKQErctkqZ+?=
 =?us-ascii?Q?LF0/FVV6Cq6SdML7WWHM7F2SE0jqTMLdTehbaE+SGv+t6G38eqj6qtA61kaw?=
 =?us-ascii?Q?TA3C8hXc7Vxgv+mZb68PNn6pWRU9Hc/a/bg2dMgJDd/WlO8P2NWEV56+hg8t?=
 =?us-ascii?Q?6FmqzU69kz6W8E2xij39AOSFb+V6frM=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac5738c-0621-468a-b41f-08da3cc985da
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 14:35:45.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZF5u5avRtTNG29DY3j8YOMqmxHiKYrrvLCndT4XCvAGckJmqg3CIJBSzreZWE/SZuVsBKWO6HXPM2Z2FBQVFSv5e5uYaVoVCzkp4JDoOlDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0623
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

On Wed, May 18, 2022 at 12:10:34PM +0200, Daniel Lezcano wrote:
> On 18/05/2022 11:49, Francesco Dolcini wrote:
> > On Wed, May 18, 2022 at 10:55:22AM +0200, Marco Felsch wrote:
> > > On 22-05-16, Francesco Dolcini wrote:
> > > > Currently the imx thermal driver has a hardcoded critical temperature
> > > > value offset of 5 Celsius degrees from the actual SoC maximum
> > > > temperature.
> > > > 
> > > > This affects applications and systems designed to be working on this close
> > > > to the limit, but yet valid, temperature range.
> > > > 
> > > > Given that there is no single value that will fit all the use cases make
> > > > the critical trip point offset from the max temperature configurable
> > > > using a newly added trip_offset module parameter, passive trip point is
> > > > set to 5 Celsius degrees less than the critical. By default the
> > > > system behaves exactly as before.
> > > 
> > > I thought the conclusion of the discussion was to use a dt-property?
> > > Since it is device and/or environment specific.
> > 
> > Daniel proposed to use a module parameter [0], but if you prefer a
> > dt-property I can change this. I would keep the same semantic (offset
> > from max temperature to compute the critical trip point).
> > 
> > [0] https://lore.kernel.org/all/7f5a919c-2fa1-a463-1f6b-6b531d5ee27d@linaro.org/
> 
> 
> It would have been easier if the imx6/7 platforms were defining the thermal
> zones in their DT ...

Marco, Lucas,
What about a &tempon { fsl,tempmon-critical-offset=<0>; } dt property?
From my point of view this is even a better solution.

Daniel, would something like that also acceptable from your point of
view?

Francesco

