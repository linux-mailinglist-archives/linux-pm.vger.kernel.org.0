Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F86551FF9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiFTPMN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 20 Jun 2022 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243321AbiFTPMD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 11:12:03 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5797F639B
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 08:02:31 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2113.outbound.protection.outlook.com [104.47.22.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-7O_Nn76jM2WrZpdXUOgBFA-2; Mon, 20 Jun 2022 17:02:24 +0200
X-MC-Unique: 7O_Nn76jM2WrZpdXUOgBFA-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0333.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Mon, 20 Jun 2022 15:02:22 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 15:02:22 +0000
Date:   Mon, 20 Jun 2022 17:02:21 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
 configuration from DT
Message-ID: <20220620150221.GA23829@francesco-nb.int.toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
 <268a2d44-8bd4-158a-41d8-b41dfc15cd88@linaro.org>
In-Reply-To: <268a2d44-8bd4-158a-41d8-b41dfc15cd88@linaro.org>
X-ClientProxiedBy: LO4P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::16) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8beb7bab-b769-4afb-edb7-08da52cde0dc
X-MS-TrafficTypeDiagnostic: ZRAP278MB0333:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB0333CE6037B24D1D51712876E2B09@ZRAP278MB0333.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: QHEwnmNcup+0DLiHi59H5eRmqowv/yHfgu5hLbSqHBSmoYz+5i+lEeFc+AislMA/stYn9oDfic6HXPpPUC6PhAaJ2aNeCPxPmrpDB8RVLrAlNaMXZ06UZ2QoW4G0JItu7XRKN0RVHpJjEbS4xAVc70M/uatMka9Yek+6aJMB98NwtgAe6FF3ZthuwOJo7Ybv5tzco4nq5rJa60ucm6EPYi0hC/18ORNbdvKcb8J/Hxju+iKU6JGVHtKq34C6KUWMOawZO78kkq11uNxoOYgNKlgIucv6IXPdDvKMU3rUDkoD/Eg43Sgr8tpR10FBsgb+wo8oGJF+yBgVPHzz/gJZdCQTg5FG/v4PTs+l6+X42bMU5j6zXGISuSo3mhkB6pqt1CPL4PbBvqqNVWNcd2K8mRLhnbjmskveefdz8PWQ0cuZkuSK5UKCeACEQaLxk8hHFbPVraziUQxMj0K7OOkAq/zTWRMFnnPOd4mpDddhFqSUP+QMc2OQ09UDH2HYlzwKpN1rzCSBYICnSJpeAAw+a/Kf1He/xMjEeVIcr9UI/6Ben/I6BIGJ5Y0Yk4OcHaWgm8SMpV5KXW5e5iwLUpKC1jpipilxTmf9ocNfvOPtpAIgDFwtXdeR8vmf/xFTomMdnWuSukAnUB8ZSlpKT3mkaSd4uR+Frvpt51Qb8kR65AjGOidQUQkd84qaHORi0jHMYD3z7ptrZLTD6PN6aBQEfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(366004)(39840400004)(346002)(66556008)(66946007)(66476007)(8676002)(4326008)(6486002)(54906003)(316002)(8936002)(478600001)(1076003)(5660300002)(7416002)(186003)(6916009)(6512007)(38100700002)(4744005)(33656002)(44832011)(26005)(38350700002)(52116002)(53546011)(86362001)(6506007)(41300700001)(2906002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZCw3jwbp3cbGwjMAOzt1SZCSOxeE3xiWH+wO3NpR7F0OAdX7THzzJobY6WxT?=
 =?us-ascii?Q?9c48C2pldFWJpTExUA6zBDD1vdCX1gyz0jsvaolXkZj4bHpGHwh0cmGBUynp?=
 =?us-ascii?Q?vC83srJlIeO6oPHmcElRNTjxRYStLu/a4wlb+Qrk07UAi6KCsKrXDQyND2bO?=
 =?us-ascii?Q?H3X+Q9FoofbJ5o0aysErcCUezjA8FS+GnxrA2Uq4LE2JIzPlMMQfzcnqrfn7?=
 =?us-ascii?Q?VqHA3Z2tLhQgnucAyeSlOCS4yBVMsiwLw5arMBHHdoPTaR+QYAE+oHNx2bac?=
 =?us-ascii?Q?/zFX+E4RFz5vJ1T3F6DGaVfAuoSD/ZghqpG/h66OotmheyTXHysVyjzIsvGI?=
 =?us-ascii?Q?oChrpzLHE4Ew8Sg0F6bCkwYG5MdoCg9X39YPmLaJRrM8bKLM0QDhLSkJ551/?=
 =?us-ascii?Q?W/NokafPLayFtYvVA6virZnUNM+Ct6yGZpef7ZVr78kd/4xpUeAqxGe2cUaR?=
 =?us-ascii?Q?/wUfb+kY69NUGsfpB7B5LYhzfgLylhohxE6rkUhdSUjcIzWAAsL0JHwWvFlh?=
 =?us-ascii?Q?yIDXJEPIBPtyDUN6xOYuX7vK9z1v5iehmQsH/ENRdrdSgsQ8L+6y5C2k2U60?=
 =?us-ascii?Q?OPos5eeKaxh2LGKGxd6csqArkYc5zKg5sTG/ambV4tMO3sgSjz5JYiAhpxb+?=
 =?us-ascii?Q?zZnti4GppbylXH0vaygIAI88BnaT3rLINhRRQj4gCrivHyvwzhJmIIJBua62?=
 =?us-ascii?Q?aoVyRUTGTmcRZ2h0scbtRr/v1kW7vmIKBqoE6g8yO+xAXjr+JVWjRWlHLcv8?=
 =?us-ascii?Q?/foKd0fT0JW65tGFo0D9duVDEHxzF2qsV3KTMxlByllquju1+x1PZoWbXuTh?=
 =?us-ascii?Q?GwbgM4fzSCQSV5FsQA5vAtcaDQ20c6SGqL/MKIH4ozkEXQE1hSAFZR6KD3R0?=
 =?us-ascii?Q?F+eyzMcyIYTJFX8YiD1FulcfrZTI/r955W5R6jN1d/aAx19AgWVZkH0931Tj?=
 =?us-ascii?Q?PEyXoD4VUU+XlLLebFLqC8zq6G26mfRm2YBcRi+DVItQhzBTQ81SAMOgE/hR?=
 =?us-ascii?Q?KwaPv4t5Tzmg+Byx+k1K7mnFuryQz2U30f0M8h1VwdDgE5GaDnMTM8hmdOwI?=
 =?us-ascii?Q?+oHACiV1cCubHp37JkkyC9tPs4OKfTctK77AEzT+4zlYRENPMh/0g3Xz0TPJ?=
 =?us-ascii?Q?MmqC8ydWph8pATAFpoZXtSVpfj5KZCRJZDdZws5PdQ9WCM6dakKNfSNL9xkc?=
 =?us-ascii?Q?8XOGQXrSKjzWWeHd/ZogQevI2PP70oSGtYrdzlMDK4aBalhOYFSt7BkJbu+w?=
 =?us-ascii?Q?qjRzCATIQr2fP4J0rh3cflH+FjD0N+a+mKV71NUl7BkQZbarGzuSaBDdiJdz?=
 =?us-ascii?Q?hAEWl9EQ3UQXI+a12RZLtHl2e9nXUSWfZpMZ6K14mu4rGerQ6ObxMfSr/sfk?=
 =?us-ascii?Q?8rf+ABazt/IkZZj1lmccoPZP2Hq1c8ZuXQyAxJCelp3k6BtsF3IRR3ThJ3Vr?=
 =?us-ascii?Q?YLc+AObONCbOXyYO0X+sCYsSudoLPDa87GLT1kCk3G4ZrlGCFYibzKDR7Nfa?=
 =?us-ascii?Q?d3JoEKEw60/Yb9gfiG41n9UrWaF1P+CAzkvmt4GYDeCRz8f4P+yYKsOikGxZ?=
 =?us-ascii?Q?liJLEJUQ32CzS2CBZvykaPccMUB0pmlCF2Him1w/t/Z7AXIdu/oyOsOxa2nz?=
 =?us-ascii?Q?7wrimxt9am/Q0BcR/lYKgYkpVbKGNU8FzUNfLOc3rIZQfuzZTUeRyNtHnHVx?=
 =?us-ascii?Q?yPPJew1TXm42YFXlMt+SePlXY5CIwiGC29183qLnxU925jSF620IsU+lObvr?=
 =?us-ascii?Q?Vdi6lfwkFNUE6dAVfmJQLMIgOVxnD+Q=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8beb7bab-b769-4afb-edb7-08da52cde0dc
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 15:02:22.1476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFbxkwNlvyPBUeJ4hW7sbLDQuLIB/r+ht7JWLToCtuiIprOaHMNvIO6fBstjuXfEJPkiRMYT5OqAbwwAA/ZUwThiPHTheYO5E0wVzjw6sSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0333
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 17, 2022 at 06:06:40PM -0700, Krzysztof Kozlowski wrote:
> On 17/06/2022 00:14, Francesco Dolcini wrote:
> > This series allows to specify the imx thermal drivers trip point from the device tree,
> > without this change the threshold are hard-coded and this might not be correct given the
> > thermal design of the final system.
> 
> Why resending? What was wrong with your v2 to which I replied?

Wrong subject in the cover letter, I had v1 instead of v2.
I thought this was going to confuse people, therefore I resent.

My mistake to not have explicitly written the reason of the resend.

Francesco

