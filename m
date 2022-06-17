Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0227354F246
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380685AbiFQHzp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380510AbiFQHzm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:55:42 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D74951316
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:55:40 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2107.outbound.protection.outlook.com [104.47.22.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-44-yHBjMnUfOS2D0hdC-kUeow-2; Fri, 17 Jun 2022 09:55:35 +0200
X-MC-Unique: yHBjMnUfOS2D0hdC-kUeow-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0032.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:11::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.13; Fri, 17 Jun 2022 07:55:34 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:55:34 +0000
Date:   Fri, 17 Jun 2022 09:55:33 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
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
Message-ID: <20220617075533.GA190158@francesco-nb.int.toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
 <DB9PR04MB84123FC6272AF3C2DAE306D687AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
 <20220617074220.GA187629@francesco-nb.int.toradex.com>
 <DB9PR04MB84128DBB45B29B7BD6ED001287AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB84128DBB45B29B7BD6ED001287AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
X-ClientProxiedBy: MR1P264CA0153.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::11) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca5b7305-024e-4c05-3be7-08da5036c207
X-MS-TrafficTypeDiagnostic: ZRAP278MB0032:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB00329E35704F53CE46544CC1E2AF9@ZRAP278MB0032.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: l6XgbKPVlw1ckgorcfcKySmqx0deL0va66+K67m85ENtWXrrkovIBKF3+E8NhdVePMuxFwvg0Cp8AuSFaoyZNf8YfLQsic6GbqsFm5Mxee/D1yK26e9HouXiTk3HhuJ8ZU36ucO0H3ywFMb+TTi45gKTrnoOY8tc0JsY4iFUuLmsGx0pnt+7jDSMRAq55fgET6yHVubE1ad7zibHtsB/cPe9zms66lXFFkNigTOt2caLj3fwUjR6CIZvyLooHymV2/4FDTp1AXbd7jwglhavcF6w2B+hD3YYZ9UV8IHmxmGzWjMnd1RW6dRfw8/8sfB714KiZdNAfaTQBIXo9WavUN1bP8w0uJIuOxg3gbSK5VjWR/gS05AHw4u79Dbgvf59eh6l9CkShJmKoYF++IF/rdmOSobAXX304LQvZ4uyi9e+eGFK3DsWUVrz3O/IBIKgpSnuJGredcNQDYOztmKQ48R3G1DW1Dh4jvZFtwFQl9KUXrlKc6Qh55rS2fpsDXrliSRWashqLWDkiW/jrum1DnJUy7chGH1DDoNyim2la4bWFzyxtLWToa/FDvXChsuwH35wnidPMsEi1Cq3h0jOWIazKx3xCWMNcq0zFYY3JNZkBtwb3yUte1Wm8i1V9gj7/g+D9vMbko3bwKUlZwnW1jyApjn+1RR37WOUYtPB8+pS4R9Wv0m8l36q9mzzQp221OYFR6dRiVoSfMdKRCPdag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(39850400004)(54906003)(33656002)(8936002)(6486002)(2906002)(52116002)(26005)(508600001)(6506007)(316002)(4326008)(66946007)(8676002)(6916009)(83380400001)(66556008)(66476007)(1076003)(41300700001)(7416002)(38100700002)(5660300002)(86362001)(44832011)(6512007)(38350700002)(186003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TXN6gKYcQiEIoag2tkwP/ySxWncFsoa/gvcTpeyVcrlnlmuVKyA4UlQUyBV3?=
 =?us-ascii?Q?1CYoZCfSiK1bd5/1Y3CMnuhslV342QCZaIq7evCBDZO2o9G5cCFihndce75c?=
 =?us-ascii?Q?zRqAQp/nEatKkUOwOWRSnRCTI3aFRrq4E8nxugqmga0sXuVqc2qmRPY+slO4?=
 =?us-ascii?Q?/1JHr6DWVmi6qrnkYisW3LiWa59ZS9XqOREBuxN8y0ttyWwetQld5nzlHJF0?=
 =?us-ascii?Q?KOEtwH3/6D8TGGyWrNNSvXDJc4ZenlsoF+RYzqbEmp8XmaoY23KhamafOMIa?=
 =?us-ascii?Q?7ZkKiVQbcfL2kDjn7uK9tSDYhfZuOwTOJsRft4lIoyB8JevwhnpqBzZuXXuq?=
 =?us-ascii?Q?hkO8AztIEM7KtBXzXCGNGWz8yKs82EWZ5dBUpNTgepCtUBPxNes7bdxQb4d1?=
 =?us-ascii?Q?tQKNFnXLIIkxZgYCtrHAJuP3dnLeZqhIKRYQyxOtO0HOhmDwJ7xdcA0brwqE?=
 =?us-ascii?Q?0+JlSFOjxzPh7leCEvetLr0EJ7X9anN/+pML9eBbBcmRyhbvQm2LEgJqH9bL?=
 =?us-ascii?Q?AZ5WD5QNUcn5BJyhvMi2oasLiBnJso7uAcoX4FtR3TeoDN8Wbs/q5l0NVhNU?=
 =?us-ascii?Q?Ve5bWx3dvfuWZB+e4jJp/7D9Mz2t0gy7aUAoUpLFfD6UUW6ah64DQfLFu/ml?=
 =?us-ascii?Q?NNWq5MCrFoexLJtH5RUKg8AZzmJIcouuETcLNK51/xMJUuEUuRNR0Lcz7Sw8?=
 =?us-ascii?Q?fvauZUG/6hHMVT1LEe6tmw1KY3ro8PoGwCJtS0ZFBXP+8XpjMLKdb87m60ZV?=
 =?us-ascii?Q?tqszAVRluCrkSnu+N3s6fd6Zwj4a2hNyGTNg8/Mwl/4SgMcJmYAYXWyl1045?=
 =?us-ascii?Q?2kNjMFA/3b7QcQGkXXiXvqP0LCHFt5gikzGhJ5YJbSAQ51QVVgE+Lw7CzYgw?=
 =?us-ascii?Q?02PEEib8trkeVE7dZTB42mTs2UiaQf+D7i69mOc6+fnsdzWxDophnDHEn61P?=
 =?us-ascii?Q?bCTWA38lOvmhZ8espXzdYgfQmc8jwm8wpik4mYDWrzyzZ9uIPLTIIYl/gV+e?=
 =?us-ascii?Q?ZTHb7kl2oNGrhRInCjhgBf891sazkG5iqREeJVTMDxRAxtQfkMVzL5HL9C7e?=
 =?us-ascii?Q?WNXztWNz+C+opun+CXjR4veuTRgMYVmW5SLsQd/B7IFM9thx6y0T3y2qaerT?=
 =?us-ascii?Q?bWj6NHVPYmDUkgEhVO3q1e2SIDcEVo9T7jzZf9QdRlxlFSntJo6rsHWmRajq?=
 =?us-ascii?Q?cyoGZxEwsAUylfuIIo/hxHkFqAQRpC7RaG+R916xgv8WJ5rgVaj2KPYvdgtG?=
 =?us-ascii?Q?6TIQvSE9n+CDJOXwvVBReayLNrIRgo7auo/zR2s+Ag3TPFNn4ooPwHl1KewY?=
 =?us-ascii?Q?Z8HV9aPhW0yi9UCIfFCCzhQ8gu81Lh3lVvrKLyAjIjjD/zwIQY7ho+3HL65l?=
 =?us-ascii?Q?BG58XovQAEmpL2EQ/yrCECZ8zTYmpUVZwjmxZmnwZHysmUULGOs2c0jxhQ0L?=
 =?us-ascii?Q?dEeJuWGTYL5/Y32nugUyPsbE9fpQ7ElT1Rm8FFodu4QHPqL+mj7/MA4DDr3b?=
 =?us-ascii?Q?0zKXOUFTWQ819yjwXOavtnRa5Mq05XDl+yEKa4w5Nga4c2A7Mkc9iXD0PP0R?=
 =?us-ascii?Q?hTDheTGVwjllGRp2jX9s3gKQX8yxqxuzvZx5mfcHJYFJF8SDwebQU4s+VX0h?=
 =?us-ascii?Q?prgPfrh/chMQQQpHEXRabXEgs6UhelkpRmFNuQqNPXRyehehLHaA/v28NwWS?=
 =?us-ascii?Q?YeMvjbaYIuwrQHFAMglDbqAfFuSpzFF5Mp61wwtEo2hOBsRZM04IWQDhy7QR?=
 =?us-ascii?Q?0L3cl5UREU7Lqqeo5OvdVrPjcQ/sVEU=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5b7305-024e-4c05-3be7-08da5036c207
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:55:34.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQlvv1x7kfBXUHgBLKgN2tN+Zn8UV5HuOCNaq8HSJRyIsBxUftbnk4H+CEpIxZwmjQ73T6YBmX2puWyykuikeiZ0+80oCyD55qaQkVJBeng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0032
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

On Fri, Jun 17, 2022 at 07:51:53AM +0000, Jacky Bai wrote:
> > On Fri, Jun 17, 2022 at 07:31:25AM +0000, Jacky Bai wrote:
> > > > Subject: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
> > > > configuration from DT
> > > >
> > > > This series allows to specify the imx thermal drivers trip point
> > > > from the device tree, without this change the threshold are
> > > > hard-coded and this might not be correct given the thermal design of the
> > final system.
> > > >
> > >
> > > The threshold is set dynamically based on the part market temp grade.
> > > I am little confused why need to specify it in DT?  I saw in 'PATCH
> > > 5/9', you provide a threshold table based temp grade, why not use the
> > > threshold from ' imx_init_temp_grade'?
> > 
> > The problem with the existing temperature thresholds is that they are
> > hard-coded into the driver, there is no way to change those to match the
> > actual final system thermal design.
> > 
> > After various discussions [1][2] with Marco, Daniel and Lucas it was agreed
> > that the actual trip is indeed a system property and therefore should be
> > described in the device tree. This series make it possible in a backward
> > compatible way, this new possibility is than used to override the threshold in
> > some system-specific dts (see patches 6,7,8 and 9).
> > 
> 
> Thx. Yes, in current driver design, the critical trip is fixed at 5 Celsius lower than the MAX limited.
> So the purpose of this patch is just want to override this limitation to adjust it based on system need?

Correct (including the passive trip, for completeness).

Francesco

