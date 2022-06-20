Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28F552182
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiFTPsb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 20 Jun 2022 11:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiFTPsS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 11:48:18 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EB3A25C6
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 08:48:16 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-LrPDPN-xOV2odip0BadsWQ-2; Mon, 20 Jun 2022 17:48:13 +0200
X-MC-Unique: LrPDPN-xOV2odip0BadsWQ-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0247.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:36::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Mon, 20 Jun 2022 15:48:11 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 15:48:11 +0000
Date:   Mon, 20 Jun 2022 17:48:10 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        l.stach@pengutronix.de, Marco Felsch <m.felsch@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
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
Subject: Re: [PATCH v2 1/9] dt-bindings: thermal: Define trips node in $defs
Message-ID: <20220620154810.GB23829@francesco-nb.int.toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
 <20220617070847.186876-2-francesco.dolcini@toradex.com>
 <b3311560-bbba-7fd9-7cda-65cfbd33458f@linaro.org>
In-Reply-To: <b3311560-bbba-7fd9-7cda-65cfbd33458f@linaro.org>
X-ClientProxiedBy: HE1PR0102CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::28) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20a84f8b-e3dc-4882-ec76-08da52d44796
X-MS-TrafficTypeDiagnostic: GVAP278MB0247:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB02478ECEBEC25F49D1C68444E2B09@GVAP278MB0247.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: ygXsZv/rZjzjBE0BLa6kzLawrBpkR0ViP+K6qKOpctEWay92yt4Q0qih4Qjknv61llf8aagGToNkDsCkHUcT4VGLXRfmn95IrlJCM7qhbr9bFGT/pyRAV7Owlq2TlaHL54fKVIPwtmfxqdNHPiWh04S4Xxg/7FLCSrqaMj+kKkVjx/JJeZlrjYCXWEXrF5Lo1xYJlbfesKh8HGx7sW90Iukda36MSmGCnllyZeywsXg/Yab/J+4t1xezjq+XJQvLXRe97gXV2+/ykmi0bUi6n/awbE8iMLdhNEVLjOn/lWupjWB+ENhB9j/rIkG7KwKpyHS7vqd4Km21qg3yY8UgW84vOASJcSMsI9KF9QD7fRZ5MJJqbVxebQPvt4W6lJmpPSUntn3mCEce56cKw+krPURVA23G1WAkysMluWmQxbNwsT4Hxdw6brA6G8QhxP1T4I9OgtsnVlFgL+mujjHj0rHTjFMuub0tmg7wTEBLyDF0yLfeA/pA0fKBLOUl6F2I3V8T9BOPtDg8V8mVpqSz0KZ1RQDU0z//qOUhh3qB+BU1TExlD0xHMpjsJAIjUQc0bT+DE5Xy5f4Iz7jDXYYXOfiM3iZXOYqduiTQoxO/hN0hH8DwokrXogiK8Sy1VkqEV3KQWvNBJb6bBk5JyOtaLi8upzX7lFJpHmfeaaj7Bh7L9IDhzr3WWNf80/DV5ccMnGJgJ9qNbcHkzisop6FHvUx4dvPgGLnq54OIMV3tSQJ7Pl6z9i1GmAqxZDP3qntyx+lJk5ZbrYqHN0SBqj8r/xKBdM6Dqoj8frG1D9gZw5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(346002)(136003)(396003)(366004)(8936002)(44832011)(54906003)(5660300002)(110136005)(478600001)(7416002)(6486002)(316002)(86362001)(8676002)(966005)(4326008)(66946007)(66476007)(66556008)(1076003)(6512007)(33656002)(83380400001)(186003)(26005)(41300700001)(2906002)(38350700002)(38100700002)(6506007)(53546011)(52116002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EZwdzdufwcSpcvLiIjEp99+ItR6ZYsxiLODWnuBE2UzYBYNbtw08sTx5uyq?=
 =?us-ascii?Q?PLrzIZSUAfo+VJgD1evVD01e624+O9TszUsbLIeVgtV0/G6dyBQrswaXQvTm?=
 =?us-ascii?Q?HN2aob5NEItYF7bosE6qQmt3YM8kIu58xm4T02SAaEPiaxKOj1OfuD+eLDQ6?=
 =?us-ascii?Q?nbsBdA/qUBcwxnl55eW9OSRbCp9Dalka+BsRTyWfYMZc65ZcQQkub9/phFtv?=
 =?us-ascii?Q?VBO/eC7WZre0w4zQCPjKfyytMvgmkY9XD3RoO+kT4x8iDaokvmeRUJ+ekbsi?=
 =?us-ascii?Q?fbR/vS8qpHxmd7px6jSu1mIoAYkkKqtacIxxRzjA8dSZnJtCXNcFVtrA4jbA?=
 =?us-ascii?Q?zYL3lhlmt2k3DR29ZlhTT4pTIvkqdVqlxQB6C5s4Hasz4uoxOEGVd1IN1xjk?=
 =?us-ascii?Q?nbH+MndNjvT2/NVBx97JeUPe1FUPKFv3n48kGPRsuFEGmKZFDAJfLWpEWhN4?=
 =?us-ascii?Q?Fa/Ol2Xejq5GsvuYA4DbBxvtnibYO7NRgYCbnCxC/L3yczXoD7TwMRFjmh0b?=
 =?us-ascii?Q?7hAx59MrfRuKBb9Zab6R49Ex5W4oourrCTzP1zkV3ZlWS4MI22Hz8BT0PayB?=
 =?us-ascii?Q?ZD92oWDS/gVtZr6/m6cFo/zsqj2+rLrEumPOPya9K03SBuK+lTc62xHmVInH?=
 =?us-ascii?Q?DWQV0GHkoum44GHIkW8iL2hfdNz8VbIGnBgMJr2ETBCnqhAMeMfEEdFxUdOm?=
 =?us-ascii?Q?o9u7LYN6DYwANdSUQRegJ1f38BlUJAc2wcvn2acEzOcqHWHAjhJzrbrOIz02?=
 =?us-ascii?Q?PtN9IdIkjNZYRQB8+8Tx1cZxF28Xogd0DZpm55gEUgxVxuy0RlffamjnOIni?=
 =?us-ascii?Q?YaZwytP1qfp7XYMAJ/6CQec48OLZWRLdSNCxACtT0FtC8pkCeUd6R1xzOONt?=
 =?us-ascii?Q?T4mM1UXpSguheN4OUfAWLS3HDxD8+BWPzRZj21/eYJwZ1RX7lLD7S25Oszw/?=
 =?us-ascii?Q?2H7ptJ93QldyV47S16sryrLz9vrY9dE4Bwy+hNk/qbEd0wAZv7yDB8ospue1?=
 =?us-ascii?Q?5Gt+cCVe/OlrWs0wCNhq/hCZyzm7UT1vn81qsC/CzwTuOxX7rsesGOgNT4E4?=
 =?us-ascii?Q?bGe+42dRM7glleBE4B5liLgsLsh4knDLPD+jwJNFSrKbJK6Ij8iOYcxqiVYe?=
 =?us-ascii?Q?7F1ZtUEJj/VnpkmFF7jTIWG4XDLIsNq3Se718vs3Y9qzHYlsQgw457RNSwe/?=
 =?us-ascii?Q?DH6leEOZo3FQ92D5S6RuWAHkDuivDMF0kQPW09/7nwkthbqMW+/ngCMnUHzD?=
 =?us-ascii?Q?p1H7Vr+X0WyBRmCw3MnD2v7i/Fm9BtCBCn2w6Kv8r9Y/mFarm/cb8I3gV7my?=
 =?us-ascii?Q?WrzPwziMCK4jmeUe0u5rrrQKYH1VQWcCaBBLPYCQxedVJ/Honbvn5rmrVvsm?=
 =?us-ascii?Q?/lOfgGrXsiymk0NMKxUB9MFvy8x7GDnQ1SX4UGkvk/gn5HKthyZ2/AGicXFz?=
 =?us-ascii?Q?bX2ZtnIZK1Zb+spNaPfW1iL6qRGOxk6R4/zARla5aEkIv8j4kWiADBn1iyZv?=
 =?us-ascii?Q?3Mk6WLJur1m1bM+E+2bQHH+g3eUntl2vIpFAWAKeEWu+cHh5rDwMLRpJvxS9?=
 =?us-ascii?Q?ETLt75qxhnizzoK3zMTWpG8p49ZbANKwiGLQJ7WyaIQHBZiSsfCX6ji2rgMt?=
 =?us-ascii?Q?Jlhi7ZloGRMtdj2VoKqbwXTor9pYPB8I7L4iVBeq1IlcjbrvZT/MVPgd3Rgf?=
 =?us-ascii?Q?t/YrAyA9pOxRS439m/vGBtowrxmzrLgEOAXNVbE9jcjbkI2H75CTlPVqazyN?=
 =?us-ascii?Q?nuPjAM1i22c+8qGV5mzZHeqJe3XARhjFerYpq4kencUWPCrRiVqA?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a84f8b-e3dc-4882-ec76-08da52d44796
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 15:48:11.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObNOTTJ9UC9st2Ye7Tr1pNex3xSIKZAmpfawlvNObFgozD6mxecjdetS/XbCB5bagXf6bb72pmYiFEdZswD0rNel/AzZOX0KLKpd0oMwcDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0247
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

Hello Krzysztof,
thanks for your comment, let me try to provide you some additional
background to better understand this change.

On Fri, Jun 17, 2022 at 06:02:39PM -0700, Krzysztof Kozlowski wrote:
> On 17/06/2022 00:08, Francesco Dolcini wrote:
> > Move `trips` definition to `#/$defs/trips-base` and just reference it
> > from the trips node. This allows to easily re-use this binding from
> > another binding file.
> > 
> > No functional changes expected.
> 
> If you want to re-use trips, they should be rather moved to separate
> YAML file...

Fine, this should not be a big deal to achieve. Let's agree on the rest
first, however.

> but anyway this should not be done per-driver bindings, but
> in more general way. Either the problem - using one DTS for different
> temperature grades - looks generic or is wrong at the core. In the first
> option, the generic bindings should be fixed. In the second case - using
> same DTS for different HW is not correct approach and why only thermal
> should be specific? I can imagine that cooling devices might have
> different settings, regulator voltages for DVFS could be a bit different...

Let me try to explain the problem I am trying to solve here.

Currently the imx-thermal driver harcode the critical trip threshold,
this trip point is read-only as it is considered a system property that
should not be changed and it is set to a value that is less than the
actual SoC maximum temperature. NO thermal_of driver used.

Because of that there are systems that cannot work on some valid
temperature range.

We are currently looking at a solution that would be backward compatible
with old device tree.

I proposed the following:
1- just increase the threshold to the actual max value allowed according
   to the SoC thermal grade. 

   As easy as 

-	data->temp_critical = data->temp_max - (1000 * 5);
+	data->temp_critical = data->temp_max;
   
   in drivers/thermal/imx_thermal.c 

   https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/

   It was not considered good enough by Lucas since this is a overall
   system design question, therefore should be configurable.

2- make the critical trip write-able from userspace/sysfs.

   Daniel is against this since critical trip point is a system
   property, not something the user should be allowed to change.

3- kernel parameter: https://lore.kernel.org/all/20220516190001.147919-1-francesco.dolcini@toradex.com/

   Initially proposed by Daniel, but Marco did not like the idea.

4- New device tree property, fsl,tempmon-critical-offset, ditched also
   by Marco

5- The current solution in this patch, with the existing trip points
   that are hardcoded in the code exposed in the device tree as trips.


Ideally one could just implement the imx6/7 thermal sensor reading and
just make use of the thermal_of driver, however that would break
compatibility with a lot of existing system ... to me this is just a
no-go.

Adding only one set of thermal trip point in the dts (no thermal-grade
specific set) could work in some specific scenario, however it does not
work for me since I have the same dts files using different temperature
grade SoC. I would need to update this in the firmware before starting
Linux.

Krzysztof, what do you think? I would not mind to get back to one of
the more simpler approach I proposed.

Lucas, are you really that against the simple working solution I
proposed initially [1]? I feel like I am running in circles ...

Francesco

