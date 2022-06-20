Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291565522DD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiFTRp0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 20 Jun 2022 13:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiFTRnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 13:43:31 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECCEF13D11
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 10:43:29 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-dpTqqOJ_MxWWjDtJA2WF2A-3; Mon, 20 Jun 2022 19:43:26 +0200
X-MC-Unique: dpTqqOJ_MxWWjDtJA2WF2A-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0340.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:32::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.13; Mon, 20 Jun 2022 17:43:24 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 17:43:24 +0000
Date:   Mon, 20 Jun 2022 19:43:23 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        l.stach@pengutronix.de, Marco Felsch <m.felsch@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Message-ID: <20220620174323.GC23829@francesco-nb.int.toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
 <20220617070847.186876-2-francesco.dolcini@toradex.com>
 <b3311560-bbba-7fd9-7cda-65cfbd33458f@linaro.org>
 <20220620154810.GB23829@francesco-nb.int.toradex.com>
 <66ba39e3-5462-59c7-3831-20ba3ceed43b@linaro.org>
In-Reply-To: <66ba39e3-5462-59c7-3831-20ba3ceed43b@linaro.org>
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b88c64c-23bc-498f-63da-08da52e45fd3
X-MS-TrafficTypeDiagnostic: GV0P278MB0340:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB03402595B9C952594BA41827E2B09@GV0P278MB0340.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: CWQlGxnLPaA5a/DKp4wWSR8vfnOY8smojxXDPvBLQkCUz+SZRsbE3Zupo7uuWWp2ZfYqrkL2LqfdTieSuyXxGQQs5t0CSqTU2uiL1xoD7LuMoQ4n9J9FbqqV3MPsw7cHg3FW4KUrgvcJUzjH/F/qVVCXQq4ya6ccaI1aEVuPS0H4NlxQbBTFnnYOiEqDidQTV2p8Wn5j7npZrADX878uW+q2nsPfSPOsIu8sa1iCDsc0GhwV1aR246M1oghEhEZbgdMUCXTtbxpdm0KArOSMSNhrhybAEcspY/cTIHmGqhSz2sI2cCeLTSVaWgRh4xx5bBXTQM0zX8X3DVYiJV3AvqFmyAz0gTInTd1MKorI4cS73HOV3r3iful6dPpNPpV/8M9AKRkC3nteZSF6d5T1tnRwzCcEOAzy8NG+5GpqxgQYEHIhR9Ct4UoqBR2t2itoi0kES3GIcamtlaeZLpRaXhH/8i340OH5OMjXqtx/FDn+qmIlLb+O6sKRUv3ZVN6zrlNsPxN9c6ZTYdwG8cIs/tK++qvBuceRGxh+Cqz+6ON9zFVb0EyjogRrZGui1TRIe2Pn48TB5wV3HJAo7Af7abJpmr3Bp8LgGZwekzN8bSjNXZ4Q5RtLtcADAQFwjnznoOY2hLT/lLOaPa/xFNcZ1H/ze7VMrR3mTG+NkEcvFq/hIKyvi/l8S6VTi229Bx4PfA8f6AW0JKyZNe1SqM98jEa3kXdT4dvdb2qJI1RAcXWb2idRA7Oiv51y6KL3bV7NWQ5rVYAdmHoFJKAyjnYQMSEh/B6DV9m82XIV0zHXp1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39850400004)(346002)(366004)(376002)(86362001)(6512007)(26005)(38100700002)(66476007)(6486002)(38350700002)(6506007)(52116002)(41300700001)(83380400001)(186003)(1076003)(53546011)(8676002)(966005)(66946007)(66556008)(33656002)(8936002)(5660300002)(44832011)(4326008)(2906002)(478600001)(54906003)(7416002)(6916009)(316002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cqbLvglBjANdyAjRO8d3CLHM/JUkkr5zhQDt7rzu5WYXcAI86I98EqMRcP4F?=
 =?us-ascii?Q?0juf1MBmt6skjHBrd3R3dw+F/ppTDHYrb6K18+PUSv/xYfmC9R1XHmVLCqXI?=
 =?us-ascii?Q?ACoebQOCIpgGwdQ4XZGhPeNNVyogRfJu4YKAxuAdnpHZ/A/vqi3ndLp38PkL?=
 =?us-ascii?Q?b/95Wa9Za62xgEkllYvmFLa0kK5qa4MpmYizOBJNeF8ktdkUGZp3Cv1/eBkN?=
 =?us-ascii?Q?HZMEox30WMfuwVck/cGp/80y35Tq3CWq8HJC9LH3Y/HjjA4gzJ1qT429wdo9?=
 =?us-ascii?Q?o4t9QuIAU+xcAQism4F6eg0hYPvrX8bZwvbNEtJ5xt+NqmmxLM1a4fJFN3Vq?=
 =?us-ascii?Q?+R83DUnRyxnPcbMy5kbQ5Nb07VdV0dHxPxpeff/NdGx9r0JM8iSEZ+6YEB2L?=
 =?us-ascii?Q?dnu2wXLJWqukjMGS0nv5PKHcsV10SebRFSnFmGDZHG7Rru5iWiq5ghH1F3cG?=
 =?us-ascii?Q?pSqbvYud/skJ+ElIqfEAv8bCJ6GQt0vim2qox0zn0Yia+BaGS9HLnoDXzC6p?=
 =?us-ascii?Q?Gr+JYueKOoEOxOh8Ewby6gMFXzYGGx9ShWZ5dagt+mmIkL3vVVmqEdc914Jp?=
 =?us-ascii?Q?0eFxc0hZQLkLLs5kbQd1yMQr9ncgFXHifPs6VBJmvvoSM30qrnqTk5O7nXXM?=
 =?us-ascii?Q?R2nR+MOoIKgCSBLMeiwyR55wuEbVetuUY1AEy18gpRz3yJQvn1/KruqnAkKc?=
 =?us-ascii?Q?X8yMHJw84IJkOBYQylC+7qLpdO6l87ZPkj0s48CSbP2zI7v+QV796FtKwUxw?=
 =?us-ascii?Q?qWMU0uW9hbXc37OelV3w+DrhSd5o3XX27v9Tj86NKAr/g4wZ3j5oN2/SLCqk?=
 =?us-ascii?Q?cTM5AxTkbP+A1jomUk18QF7xUrf0FO33bA52S63QzOlFBfo7AjdBYIynBroE?=
 =?us-ascii?Q?7hKkU0DIW/hjmORaHpcWuIQfeDCFcNDVaDq8IPLvsm7CJbh7WMZ24RBD7ypY?=
 =?us-ascii?Q?4qA7TNhnGy5OsoBq9MDCBnWllJnCMRNzSo9Vm+wAOmLB4eyv4ongZ+DECX1e?=
 =?us-ascii?Q?jfPgb5y1rlPOueO58z6RHj2ce5zfrmTEOdVRj2nDHGclyJI/TjVaHDEVGRAk?=
 =?us-ascii?Q?HWp6PO15uILqL1f9I+3gbIT1Orfql3WEWUckXbjj3kxagw1XX1tseAZ24S12?=
 =?us-ascii?Q?CvsFL7wBNZ+a6DnUaVSFW+35CQhNwFVQ02OTocgOdnPzcsCV7CCJc5byqHbN?=
 =?us-ascii?Q?YkDjeJtvErrypW6jvQJOazZppWBKLXwga/TVfMUx4X4vMI3FznoFRVtYkJ7e?=
 =?us-ascii?Q?UdUUxbvc+tjRVfLuKgUxL12AeqHESdMRiWDcqNwL3/uYDU6TSUmzGP8UBRP3?=
 =?us-ascii?Q?fp/ndI51w4qxeZd85q/VWhU+zDQvhHG87YefJVKN5AA5V2iDhKm27tEtoIhZ?=
 =?us-ascii?Q?IT5XRZtNp/SbcVbTnZuhZsi9ojdHwz242T9l8zDQmgpxhsVbT1JiKcBrrVtQ?=
 =?us-ascii?Q?zC1uTXjk4oO9Zgjm+4YmxG/u6EoMLNGwVqbKf4ocMcpSxG8Fzt2Q5jnJWM64?=
 =?us-ascii?Q?PB32IAQv1xmE9HY2EWV2m099moS4Tl86txJvGpcwcqiGHoFtVRM1NXRk0kTa?=
 =?us-ascii?Q?93pEDwf3RjSdrrcXAPNXwOFcAB8tguKUylWmEb9cA6zIrio3uspgynszwIDf?=
 =?us-ascii?Q?OybYJ4w4akhT/lTVrlOeZO3GAn1vD93YRHG5ewyi97bumibhO2/Fk+yQ4x79?=
 =?us-ascii?Q?KzM4qTXKV++hlPiSRqyWzX6bgjr5kH27pdH2J+gpyr+xxph6u++bmq09zHYr?=
 =?us-ascii?Q?mVaM5TAYS0WAKUCdxEtU3u0Td9FOMq48MYuPiXkVkkYN28IweptT?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b88c64c-23bc-498f-63da-08da52e45fd3
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 17:43:24.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J24o4LYylcqus359/E+5hSrKl2v8RZ3vcPMcrEIB+sAJictrnlK7E5AVO0rUGjM4Qfm0fh08Vxl5IG7G2GhTd4A2/rM899TH7FIxAdUQcFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0340
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

On Mon, Jun 20, 2022 at 06:44:23PM +0200, Krzysztof Kozlowski wrote:
> On 20/06/2022 17:48, Francesco Dolcini wrote:
> > On Fri, Jun 17, 2022 at 06:02:39PM -0700, Krzysztof Kozlowski wrote:
> >> but anyway this should not be done per-driver bindings, but
> >> in more general way. Either the problem - using one DTS for different
> >> temperature grades - looks generic or is wrong at the core. In the first
> >> option, the generic bindings should be fixed. In the second case - using
> >> same DTS for different HW is not correct approach and why only thermal
> >> should be specific? I can imagine that cooling devices might have
> >> different settings, regulator voltages for DVFS could be a bit different...
> > 
> > Let me try to explain the problem I am trying to solve here.
> > 
> > Currently the imx-thermal driver harcode the critical trip threshold,
> > this trip point is read-only as it is considered a system property that
> > should not be changed and it is set to a value that is less than the
> > actual SoC maximum temperature. NO thermal_of driver used.
> > 
> > Because of that there are systems that cannot work on some valid
> > temperature range.
> > 
> > We are currently looking at a solution that would be backward compatible
> > with old device tree.
> > 
> > I proposed the following:
> > 1- just increase the threshold to the actual max value allowed according
> >    to the SoC thermal grade. 
> > 
> >    As easy as 
> > 
> > -	data->temp_critical = data->temp_max - (1000 * 5);
> > +	data->temp_critical = data->temp_max;
> >    
> >    in drivers/thermal/imx_thermal.c 
> > 
> >    https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/
> > 
> >    It was not considered good enough by Lucas since this is a overall
> >    system design question, therefore should be configurable.
> > 
> > 2- make the critical trip write-able from userspace/sysfs.
> > 
> >    Daniel is against this since critical trip point is a system
> >    property, not something the user should be allowed to change.
> > 
> > 3- kernel parameter: https://lore.kernel.org/all/20220516190001.147919-1-francesco.dolcini@toradex.com/
> > 
> >    Initially proposed by Daniel, but Marco did not like the idea.
> > 
> > 4- New device tree property, fsl,tempmon-critical-offset, ditched also
> >    by Marco
> > 
> > 5- The current solution in this patch, with the existing trip points
> >    that are hardcoded in the code exposed in the device tree as trips.
> 
> Thanks for the explanation, I see the problem.
> 
> > 
> > Ideally one could just implement the imx6/7 thermal sensor reading and
> > just make use of the thermal_of driver, however that would break
> > compatibility with a lot of existing system ... to me this is just a
> > no-go.
> 
> This I did not understand...  What is not implemented in thermal sensor
> which would solve the issue? And why it cannot be implemented in
> backwards compatible way?

Currently the imx_thermal driver defines its own trip points. How would
you change the code to work with old device tree binaries using the
generic thermal_of driver? imx_thermal would need to be changed to be a
thermal sensor device, all the thermal trip point code removed.
The driver is using thermal_zone_device_register().

Maybe I am missing an obvious solution, just correct me if I am wrong.


> Your change is also not backwards friendly, which means existing boards
> (old DTS) will not receive the update.
The change proposed in this series is 100% backward compatible,
the code-defined trip point are optionally overwritten by the dts.


> > Adding only one set of thermal trip point in the dts (no thermal-grade
> > specific set) could work in some specific scenario, however it does not
> > work for me since I have the same dts files using different temperature
> > grade SoC. I would need to update this in the firmware before starting
> > Linux.
> 
> 2. If the devices are in general compatible but have discoverable
> differences, use one DTS, discover the differences and apply them
> dynamically via driver (e.g. read the temperature offset from some
> nvmem/OTP).

Yes, of course, I agree.
That would work and it would be a reasonable approach in general, but it
has one big drawback, it will force an update on the firmware on
well-established products. Anyway, would you accept a change on the
thermal_imx driver using a single set of trips from the dts, but not
using the thermal_of driver?

> > Lucas, are you really that against the simple working solution I
> > proposed initially [1]? I feel like I am running in circles ...
> 
> Yes, because it is not generic and skips other similar cases, like
> regulator voltages or battery properties. I can easily imagine that next
> week someone comes with duplicated opp tables, then duplicated voltages,
> then duplicated CPU nodes and finally we have one DTS for imx6 and imx7
> but everything is in multiple variants. :)

The patch I proposed in [1] was just making the hard-coded threshold
more reasonable, instead of setting the critical threshold to max-5 to
just max. Your concern here does not really applies.

Here the patch https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/

Francesco


