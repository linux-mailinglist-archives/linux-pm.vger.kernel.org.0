Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E2524EF3
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354791AbiELN5G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 12 May 2022 09:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354777AbiELN5B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 09:57:01 -0400
X-Greylist: delayed 22853 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 06:57:00 PDT
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.111.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 374A51C1966
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 06:56:58 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-ok-G87yyMQqne9i7uMs8vA-2; Thu, 12 May 2022 15:56:56 +0200
X-MC-Unique: ok-G87yyMQqne9i7uMs8vA-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0499.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:34::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Thu, 12 May 2022 13:56:54 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 13:56:54 +0000
Date:   Thu, 12 May 2022 15:56:53 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>,
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
Message-ID: <20220512135653.GB39979@francesco-nb.int.toradex.com>
References: <20220420091300.179753-1-francesco.dolcini@toradex.com>
 <486c5c72-812a-d4ea-0c5a-49783bdc4a1f@linaro.org>
 <20220512073600.GA36153@francesco-nb.int.toradex.com>
 <6918b1a7ba401cd4db2db0601137766acd93bc63.camel@pengutronix.de>
 <20220512102454.GA39979@francesco-nb.int.toradex.com>
 <7f5a919c-2fa1-a463-1f6b-6b531d5ee27d@linaro.org>
In-Reply-To: <7f5a919c-2fa1-a463-1f6b-6b531d5ee27d@linaro.org>
X-ClientProxiedBy: MR2P264CA0117.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::33) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc921e48-1ff2-44a4-7159-08da341f45ab
X-MS-TrafficTypeDiagnostic: GV0P278MB0499:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB04999A05EB89A7530516CFEDE2CB9@GV0P278MB0499.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: L+0zMhhh+P32vKQRGyRK1a6BOQbNB2gUGRl20hXCtdG9wGua4Fcq5KTs8Uj0yWCcaLcFT/Qem6uQklKJ7dxzcSM6ExMFaIXlU7Nw91x6QcayruRXILVeKeIYYLO/cf7/6bYmbUZOsDAY39D10QLHGTBMYB0JoP/FaEGQ4rBeGj3j+Fz8ZVZ92YQS8lpernogIG8XjqMVkrkZatxNAD7tpGpORtpM/LyYJ3inL0DHldcNtGOUs67k0NnoCwEXgPhqQO+tr8nxaI6C7dyIDNPV8PfdrzsAOnmFC1U11fFrU6x3adKVvLCwEk3rHl2Ay0dQ9NTwzeDJCDyxBZgSOx3xGmgZzl3jm58zF706XYJfCknh3+ay/3GamslzQcMq7dH0DKyotH4TctnsRAQX9e9HQnnMxKneB/qxwcD+zCHLdeq97M+5lnBqvw3TXBfc9NYZ3NZRY/Xxv/73yVWIcfI7smM0q8oIRNRGWg7RYbkl6lptIF1Xy9JszUEPZ4YMwaVQqlMboCpnf0jzH52wH4yLTHFu7L7O9bX9kiHIERaEwAgOiTojU0KFIuLeXVPmAz7Z6IG/xIGt5+pEeYoZ7XHy3ym8QxIgmUj01AQ3lqisi32MCGvnMRcK9oZlno1kBXjqrPA5FgGa0oubhtg8f2vY5mCZiItFp7Ax4RYTJOUORCRtMNpT/U1PgDhaGiHMhiA5SVGfgLAk+L8HiS8q9j2XZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(366004)(39850400004)(346002)(136003)(396003)(2906002)(6486002)(6512007)(186003)(6506007)(53546011)(1076003)(52116002)(44832011)(316002)(66556008)(66476007)(5660300002)(8676002)(66946007)(86362001)(6916009)(54906003)(15650500001)(4326008)(26005)(38100700002)(33656002)(38350700002)(7416002)(8936002)(83380400001)(508600001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vT4BkdANt3EG/8/Li5jT5e1ZB77UuyHoVjjWbpW7wv4wde9QNf9cPxhVrZkY?=
 =?us-ascii?Q?0hz1MelOvOv5BAZv1Tpc14jp6Qwd9QeeXO4etBV08IUVyzWviB2V8U8a2I2Z?=
 =?us-ascii?Q?9YlliqjHWS3EIMkHRJZpk3XmgHaJzytOGKbbXHPaTXuuLrCNOsTobgnV0Urg?=
 =?us-ascii?Q?x74Tr5DGknOxsX7GtiDbJ6M9F2g7D8XO8pf/B/CE4+hADOyDsN8DcAxWIkNP?=
 =?us-ascii?Q?GVbI3TszUsYw+g7ol4XnKqCj/3qXVCPQo+bXamzAD4d0T0XIQ1nrYMVZlWXL?=
 =?us-ascii?Q?wrZMpr5vt8HOFFtWSGm1S1nI5zy3JsvNnoYeYiGmryM2QqpOpV8GqYg/3+ki?=
 =?us-ascii?Q?Shvl9trUxjTegnQTeiR2yWN4WC1xAPy/gMgNURZ9U8D/pPBiOCUwAyQIgO1O?=
 =?us-ascii?Q?oQpkOo7zB1x2vXyFwVogeweFDhEqU+kR7QgnV2eRvihc02c3kgZGwygPnQ1l?=
 =?us-ascii?Q?t1D7LNEdGVxSIUc4WasiHZr6hW7zUZfg7puVAxb2cUYg01NADIqeJYO6bcgf?=
 =?us-ascii?Q?321m3wxNy5vPW45UWihUvrHbQw+vbx+b17wnd4amefX5X3kBWp5V8/ecUOCO?=
 =?us-ascii?Q?TQF1pOszcUv8Gekv7C/KM+jUTuie2KiHug/6wHtCKXcjfHTQNfGdxwkF9BF7?=
 =?us-ascii?Q?OPt/YaWMC+hR3Zp7L/SKWYtGn62PETSgwjWqHOGrr2QkEZc51w7kv8iakEs8?=
 =?us-ascii?Q?ducPkIYNcpD/UGXeDalVfw3IeYnZUm1hECRhD++FkB8jcoPso71gD25Xdu8b?=
 =?us-ascii?Q?1GiyYmbfvhlCZBJC7XXywwxmM/q8Htjz3j6cZoEA9nAfn+QDZbqzB+USOlqW?=
 =?us-ascii?Q?QAA+rKTzbv9N7NjCRuTidpSh45qLP2CI5ltsU6xejH+zu2lWVGhVvbbo2qHO?=
 =?us-ascii?Q?oYCQhyO+JQmdK3/spzju8dzQ+NT6Mcyc71O8qmx47QHGnMwKk0gWLO6iD7V+?=
 =?us-ascii?Q?Ug+GH8rg/RfdidsQj/BFMsfKVcM5dHFEbOs+NY6xZchYMHa3t89zlI+eCrc7?=
 =?us-ascii?Q?LaHS4Nd/l4pVi0/RUowUoOpskSXPSeOnjvCFxP6R/ShxI+orJmTbxm0hUd0Y?=
 =?us-ascii?Q?nuXFyu8qxMWTvx+ZBWhUwnDzd7vv7S+Ui8zEMoF0ZmRINPpVLbe7MDip54Mv?=
 =?us-ascii?Q?NEOGfMgWpBPgY/RVkRL3xUVDn8b9+DLT8QXzbWd1zKv5O69d0wvgcgbBgLjr?=
 =?us-ascii?Q?RiH0iluYP6D+Ad/TAG/EosIA/Zj/fvsZcWa79RshL+MWh8xxR3Gx55wmYeOX?=
 =?us-ascii?Q?PzUE065vf7LREYorLquarVyq3OWeQC9CPfs0gErh/9AMP6zUJ+bAM9JMCBKV?=
 =?us-ascii?Q?Tb1LC1CxOcxXhlN3xaew/hsis3UfHpcWRze2vgvYDVNUz0tYcz6vzfMJzit9?=
 =?us-ascii?Q?jZHW3yQiLoB8DuSzqIEm1gaFS9Jq1C2k2jPKGgL/cI/N664Wt/yMbop6gMd9?=
 =?us-ascii?Q?NbufGaqaoWKnLiQnNkdFqiFEcX5nenz6ldxtdq80GarJLEyynPZ2qHL+Pkn3?=
 =?us-ascii?Q?j6jzhWmEgiAIAd9VohddQ78EwnmXQje0XzWH4rMqzukGDv6dC6axJ6shpjmo?=
 =?us-ascii?Q?lDX4fW60P7bfduWsYdxaoCKBr9veJhAbo8RnTaH4dR7sHK/icQiBGnYUJhWN?=
 =?us-ascii?Q?9c2D2Au7T12NHX+SWS4OqsQneizl0HdSAz6vfpg3ZrDss96Q9I7xa8DXFBN6?=
 =?us-ascii?Q?dB75L0s8S9f5raXyEo4QWhstdn0syPKB9uNojueANy1B/rKhOhQsS3MDYEYy?=
 =?us-ascii?Q?EX5SapDrsg+UVyVJgubvMEvPw2Ph+rY=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc921e48-1ff2-44a4-7159-08da341f45ab
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 13:56:54.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9Ww5Wn6iWrW5ufzOLD6zE8hVbT+33ERmonw0hMempZUeioNbxgHvG8yp1L9PzhBxtHx7D4e8tyFAS4pErGQ4Y8EGqLbVMgTa7d2tdKr/+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0499
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

On Thu, May 12, 2022 at 12:52:46PM +0200, Daniel Lezcano wrote:
> On 12/05/2022 12:24, Francesco Dolcini wrote:
> > Hello Lucas,
> > 
> > On Thu, May 12, 2022 at 12:08:08PM +0200, Lucas Stach wrote:
> > > Am Donnerstag, dem 12.05.2022 um 09:36 +0200 schrieb Francesco Dolcini:
> 
> [ ... ]
> 
> > Anyway, would it be fine to have a patch that make the critical
> > threshold write-able (in my initial message I mentioned this as my
> > preferred solution also)? If anybody has a pointer on how
> > to do it, it would be great, I'm not familiar with that code.
> 
> What about a module param ?

I would be happy to just be able to write to the `critical`
trip_point_temp file in sysfs, however the thermal
framework seems to enforce the critical threshold being read only (only
`get_trip_temp` callback available). Is there any way to change this? 

# cat /sys/class/thermal/thermal_zone0/trip_point_1_type
critical
# ls -l /sys/class/thermal/thermal_zone0/trip_point_1_temp
-r--r--r-- 1 root root 4096 May  6 14:33 /sys/class/thermal/thermal_zone0/trip_point_1_temp

Francesco

