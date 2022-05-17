Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3748352A691
	for <lists+linux-pm@lfdr.de>; Tue, 17 May 2022 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiEQP3e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 17 May 2022 11:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiEQP3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 11:29:32 -0400
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.111.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF15F4F9C7
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 08:29:30 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2107.outbound.protection.outlook.com [104.47.22.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-S2svXS7PNaSD-ch7dcvxaw-1; Tue, 17 May 2022 17:29:28 +0200
X-MC-Unique: S2svXS7PNaSD-ch7dcvxaw-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0362.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:30::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Tue, 17 May 2022 15:29:27 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 15:29:27 +0000
Date:   Tue, 17 May 2022 17:29:25 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org
Cc:     Amit Kucheria <amitk@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Tim Harvey <tharvey@gateworks.com>,
        Jon Nettleton <jon@solid-run.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] thermal: imx: Make trip point offset configurable
Message-ID: <20220517152925.GA32004@francesco-nb.int.toradex.com>
References: <20220516190001.147919-1-francesco.dolcini@toradex.com>
In-Reply-To: <20220516190001.147919-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::36) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc3d5977-b440-4f4e-c10f-08da381a0763
X-MS-TrafficTypeDiagnostic: ZR0P278MB0362:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB03623AD0C2CADE156261CA33E2CE9@ZR0P278MB0362.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 7++CSbMNC2uCQDdSLmVaT0Zq+X5zXAO9M8yvdYAxW77wwkkAdFLXRyPBSGD+xwkxDeUl5/XxASpp3WIKC0qEtF/xcabn5DSMkUd2PjXcfhH0PCyLuhbJO5KTl0ND2i3+QckGrDoWdwsv4dd/5XK4WTpj1GsT7DB20oXe+CeCC/WZnpsayb4F6h1+0VHtmPF0CbkndUp0BEK6YCUW/6fsjLtNpy5MRZ/uVChfZrB7a2qNzH7i8S+uEqAQ3u6ldsKRgcUKFJhrZl28it7tzV8qIdKF80tw3fpe+MJhfKzeSe6aO6+kZSFXJZs8I58DqqEVMRQ8grsGP3vsWLHVq94f3ygx0gbu9YuJmzR0MAUYxNFER567nshefclXF4PsxHK/sya/+ICUe2qGoJBoe/wTnawbf+1gNqeTKBWyRQcXCJbE9EANrEFJs9c6elPF7jPxXoFxa1wEHXG/QZlJRaE6ir774n/flW+83QIxrky0MSyuI9KHOu0lX0XtDlqDzj6GCM+a29KEiY+8/GeTKm/b9mn6Hwilkl/tR6w7oQlnw0weWCVtbzalifCB/PixMbg0Yl8qwBZAeP60xE+Le1JanYYtaEMSTXMRhPHhF7iBmDqhxXodhKO9nPqyJYBXFWu7zsL0goNrZA3ygpE0yj8yXUAGHdZtGMpvSNh3X3RKynrns0IBiQEf8CyW4SFeA3ARMTN4n4tS0RlbA1zNejfsmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(366004)(39840400004)(136003)(346002)(376002)(2906002)(5660300002)(6506007)(33656002)(83380400001)(44832011)(6512007)(52116002)(316002)(41300700001)(1076003)(508600001)(7416002)(8936002)(6486002)(66476007)(66946007)(66556008)(38100700002)(186003)(8676002)(4326008)(54906003)(86362001)(26005)(38350700002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdOBR7yQOFrKrztydA8xI0HPES8PUtnva9I1WNKC3UWtkLL++LWybo0nfKA9?=
 =?us-ascii?Q?1TllBvgb3TE7NDkGxetFGLPeXjvq5VV3jKOa3RTg4GCbuT56KizdtOQRrYwq?=
 =?us-ascii?Q?XR9Gz1Uc1bJDIxBmOIipHTRX7eRyG7lNhFzNkUvOvdIovTdK2PvjT/McPo8d?=
 =?us-ascii?Q?9ZgnNYg6TCTlT7rswrbONqSiT7VYMFN0NozKgif7Mcvl+3JWd0jaHmMkkatC?=
 =?us-ascii?Q?FT3lddbDRfL9AUzVKuGT6k0M6AerIFAqOX+YIvhPCLVTI39HcvfcV5fF5kZ/?=
 =?us-ascii?Q?q50ufvldNjg46KvipuiUR8VBxyl7nyNenojiExsObaXR5+jlRXy+FapUc7eh?=
 =?us-ascii?Q?B/kctimqIg0u7TGJAJc+n7rXi/eBQw01EqXlixN9obTuLzngFfW5numcyPPm?=
 =?us-ascii?Q?nHxLUTa+T1h1FjT82PJI2uqq7XJT8cjNXAqzghL8dSgymfkBt7FHkJpTcfhT?=
 =?us-ascii?Q?2NGceEPGmltds+wUj7AwI0bOksct+7nJpNB510H6ZRsVn4MowOz3nJbFIVRH?=
 =?us-ascii?Q?rz22/7oHcdhHxGq6t6hWk1iBrNtPEskYxA+8OR1/nIqF+YlNCeFPbYFDOJvO?=
 =?us-ascii?Q?Z9vF3QXIcL1Rg1JP0ykuWf7sj6LmXO0UCzJdikmWN0Ys4+qcDPwenU+aKJOB?=
 =?us-ascii?Q?LlrJxhEMXSZGjVQELmw5GYLKlPwsV/RdmpxyA0wtK37kWRzSlCm150TG2CTY?=
 =?us-ascii?Q?U2U1YUTpI6sIRomBK1m1cqrgsJ2/6OUYnv/xgc1IEI7rdDsuVwsHDNpboolk?=
 =?us-ascii?Q?U7AFzFItxgua8czAcTQf2bhB+0+3IPNmphTOBQZNh3mMjk0I4wjJVYzMOOOJ?=
 =?us-ascii?Q?2MjwgSpq7nYPzDezGJrXBBnzGJOkAv8hh7xW10LfKqvAk98BCLektJi4r4x0?=
 =?us-ascii?Q?md8iEaCRmbgOWy83mN09/3pFTmWfw5lO13DAxoyu3flhhmweieeWrKRKAHI1?=
 =?us-ascii?Q?ZFv58q41hBAR4W8vOTi1D9KUFbN6AGGZ9KaQBMGgHdVSL7PQH8xw6YBgSCUO?=
 =?us-ascii?Q?jFK/49yj1SyYuAdMTn8deytYz/ScRp2nDhP73AvcFJH+HvEybb+JYHVi9VPf?=
 =?us-ascii?Q?Uw90lrMQjlBtuRH6ztghtg6gyBnyKOhsVTucVs2fHpGo9+4qkNkL/Ss5jPv9?=
 =?us-ascii?Q?kuGTmsJWbzEEnzPNAAyJnRZyXwVDKLmwrYdaCqufFO61KpIGAUjbGecHEGcB?=
 =?us-ascii?Q?BurV3cyUfVFnMgwV/bCqBH9Q0y/qFtFf49e6httLhr6ZYvEo12IxdYRW386b?=
 =?us-ascii?Q?pSJXyWIAX4nTR55yfmYyPYW/RYg1W8uhcKuDS0xNKNTFuC2ryS4KTCpvTL+1?=
 =?us-ascii?Q?WCYGTrXbN/Q4Tr13CKaRD+23j9QGG/lgiglTC/g2NOA/uXKwRs2V1/FnKKAl?=
 =?us-ascii?Q?UyGVmp+iM1p5tEwUCF+cyi/LToJo5JQVjN6mfwG8rvoIaw5Ngi/GbrfCooYJ?=
 =?us-ascii?Q?ELIpNP5/kFO81GjuLpir9CLXeu5CmvXQcLEqJU+hqPYSCe9Vm8mo0Zc2JxJP?=
 =?us-ascii?Q?A+Dz4U6S8KS4oTTsHfM5DkqmfxviDPXAoELeleooTV19OhP/Zp28wQFpVki4?=
 =?us-ascii?Q?Gf66lDi3rNzSo1sz/y19WfvF5aXQCSH1mhEXBg436TS9QjYGjMvMexRZPSxM?=
 =?us-ascii?Q?SDv5QUBku7VBtYmimyBedmbF28+IFUVxHRCffcPfaYpsk9SOvt4H/gsybF0H?=
 =?us-ascii?Q?JWOSeqNtIQQzeuy98BowVxL3r+f2VKgKBWdLy2XTfsXPqgM40gv0Ru/9FB2f?=
 =?us-ascii?Q?2+j2eKhrjxK/aKL32XLDPeNAHYE1UUY=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3d5977-b440-4f4e-c10f-08da381a0763
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 15:29:27.1566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrPJXo4kLwtc0QtYnP2QYequqIauWto0qR6qbtnBvJeqevlq1mYUGf4DLGzuNl6JIhC+ZOWw30ynYlo1HW6pK9WUk1ygF7e1nz0IEL20Rtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0362
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

Hello all,

On Mon, May 16, 2022 at 09:00:01PM +0200, Francesco Dolcini wrote:
> Currently the imx thermal driver has a hardcoded critical temperature
> value offset of 5 Celsius degrees from the actual SoC maximum
> temperature.
> 
> This affects applications and systems designed to be working on this close
> to the limit, but yet valid, temperature range.
> 
> Given that there is no single value that will fit all the use cases make
> the critical trip point offset from the max temperature configurable
> using a newly added trip_offset module parameter, passive trip point is
> set to 5 Celsius degrees less than the critical. By default the
> system behaves exactly as before.

In your opinion this commit could be eligible as a fix, e.g.
Fixes: a2291badc355 ("imx: thermal: use CPU temperature grade info for thresholds")
?

From my application point of view this is a fix, but on the other hand
not sure if a premature emergency shutdown for a specific application
is considered a "bug".

Francesco

