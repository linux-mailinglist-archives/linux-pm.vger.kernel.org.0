Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7D54C969
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348658AbiFONE4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 09:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346889AbiFONEz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 09:04:55 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CC2727146
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 06:04:54 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-b2UX0rR3MNGe61fVk8qMLQ-2; Wed, 15 Jun 2022 15:04:50 +0200
X-MC-Unique: b2UX0rR3MNGe61fVk8qMLQ-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0061.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Wed, 15 Jun 2022 13:04:48 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 13:04:48 +0000
Date:   Wed, 15 Jun 2022 15:04:47 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
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
Subject: Re: [PATCH v1 4/9] imx: thermal: Configure trip point from DT
Message-ID: <20220615130447.GD388464@francesco-nb.int.toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
 <20220615094804.388280-5-francesco.dolcini@toradex.com>
 <20220615103956.qm3o45n2hyuylgwf@pengutronix.de>
In-Reply-To: <20220615103956.qm3o45n2hyuylgwf@pengutronix.de>
X-ClientProxiedBy: MR2P264CA0080.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::20) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 168ca7a6-26ac-4546-885f-08da4ecfa08a
X-MS-TrafficTypeDiagnostic: ZRAP278MB0061:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB0061D50859A3C4103BB32A20E2AD9@ZRAP278MB0061.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: OAzTrNYb316YomGINh0b2xxAFyFVVRRb8yTrF3s2Fz2KDhjBY+thEd9M7dki76MlSguwmscWW2yRsg49RMtkbZ8rcaRlFYXsdoBtSH0j9x0Pva6897TKECc8Mp7NAKwAXqWF4x5gB0JOnx8f3Y44uSZ5W5jIyrCmBrjkIWeTfIFX6ZBFdDeaRPS4RsYuDRGTuypsnfq3/kn1gnDIjJILkfXhaBG61HIWsz0Hrp/3V6RrQDUWBmPKxUd05/lhTBUwqanZ8rSKAONrVFqXh+fo8u+mYhHWecChIlUZ458HamccSsElFs6uQyeUs0pHBnF3rBGgs6360ewa3rbiQgghHAI6HrZ3VSWrK1kVlz20iB/r0Lq9//FuAUTQD6N0QClPIr6l5Fg1EJEz+dSzssyBANOdu4IgN4hWOMjazzgl9GDKSMIaPZsOqiMbgxnf2Pp6UERIv9SNzSc+PzR9nTjkYu/eaPOOglpk6DCz0dqmbWcyLJR7jDQGi2E/1p6K/aIwsPxCwsM3Z1czbPOCbrtDYKMdtMnEwGVrhUYDFuGshnGMYADUBjZo/p5PWUetBLr3iDXQdUK4dBFqEdLOsbuxCQfJ+S83YSJYMKRHhL9WjbD3Y7eBxBAbCXI69gAQf4xabTDFfLT51N9iYvAT9Kte41tSi0cI01yMIQkzohASOkKXaYfPDDmmXnM86v7OvzYbgn74GO8RCIiMFommRfX9cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39850400004)(366004)(33656002)(8936002)(38100700002)(316002)(4326008)(5660300002)(8676002)(38350700002)(52116002)(6506007)(6486002)(6512007)(7416002)(66476007)(508600001)(66946007)(66556008)(54906003)(2906002)(26005)(6916009)(4744005)(44832011)(186003)(1076003)(86362001)(41300700001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBdAyLJuKW4xgI6oEiaHHi05Df01FSN9SzbPqp2Cn7nJ9GSOX8HvCHqD73YA?=
 =?us-ascii?Q?tbXUquy5tGBpGmexdy8hKvR6hAzvA85qIPHT14t9GzDLQETnymNxMG+T/lw7?=
 =?us-ascii?Q?YL0eYGJOrcvZj6eapUecc9V2Qlx2X08fLrbMp8J+DwosCjYn7IOpZzAsgCYB?=
 =?us-ascii?Q?yfLm5DomxgYz0XKYc2WONFk8k/Mm1syPrs1HDI+rBggmjSrQmH5YgjdNUwHI?=
 =?us-ascii?Q?JJFMN2Rg0uHLOsS/1YuZ+GF76p+FinFHKqvlrkDIdjN8sXqZ0NNnP+T2bHMC?=
 =?us-ascii?Q?ErppmRK4yizBXr7ozeUj8mn626CK5JKE879jJuuizn18GUTkyPqXItUHaHyN?=
 =?us-ascii?Q?piSUhbyL5LyWQUXQoigc+Uhchc5O6lhsFVUpx3aSPOBVwEhZVpd1oIFMXSni?=
 =?us-ascii?Q?Oc0HO2YPAsAl8/9ut5JQxvuv7cnVS6EqFeLFZ9X2XOnlmVJ1uOzRP8bCUxK9?=
 =?us-ascii?Q?sRacdmzqsXkBKO5X6F+wtiRiiK0vNa8kSKMdeWT1Yp1fVnV2KpD9qJ20wiO7?=
 =?us-ascii?Q?jK21wvQFIXYJSkw4nU80xRRIZ1Ze1hzzqGemWaOxTF5V5QfgrCZS1yOQaFTX?=
 =?us-ascii?Q?FeYi7kc0cAGvZY99MVJ2WibqRgFilPosmWo82ziXeCbDvENjx4eyNPCvMbK4?=
 =?us-ascii?Q?JbNDfQWcS3X+JGeKhocQMXbl6fuRQ8oKFf3HHwFHaCUigay+4YoWqCMcKwnO?=
 =?us-ascii?Q?8PisPZgXRZbRo5/JNaLHoNUi+ruuxdZHW4pDmlwxNniWqjBs/SJDuFZ1nyVv?=
 =?us-ascii?Q?1i3qFfNSmC8yENuD6khXe0foj17ku2QEg657vALGXu1m1zXn4EFQCgCt/rL9?=
 =?us-ascii?Q?rlc8udqSt9fsbgzp61WGEeh9QTzmV3vQVnzrZvVXXbtZRjRdym+wGk6HmGMS?=
 =?us-ascii?Q?BJPpk+zjnka5DU/8A+Th9wV2BWI0SRxQWTiFvGgvsZHOuaoddZppB6SZeiy9?=
 =?us-ascii?Q?j2/WxK8aOjdvc/qGlhO8pu7W4FJSCQjOFjxPIS0YubjtEfRNkmlvy6JXHe7e?=
 =?us-ascii?Q?0WgmLZ8buOiUBq1qnQof1vc3S+YYjcIUzFMqff5Z4qgVBQmmJ6S23y9Vd4RZ?=
 =?us-ascii?Q?teylIC77QNBLT2gXWJlA1azQdsJuFHtoPf2mlp+NrBhzg03HmLx7a54CqlU+?=
 =?us-ascii?Q?H5/8BunnElJfLfG5QAvWGc1T1AqUlELhc/8nLE7LJUURQgePSCo8StQ3p0Jk?=
 =?us-ascii?Q?2EepffUHp+Qx3BpG9hgrp8ZoSfKqL1V0OMLbCwyC/KSpILr3rE0IxeYYxgLw?=
 =?us-ascii?Q?Qv9paHtO0GpxjuWyQWHbFLAvEdC4LE29MP5a5GAeAfZ8Rm2gRvPerX8vm44W?=
 =?us-ascii?Q?UqaLh5Zv8E9c0m9pSzCz7Lw/M2oNkxPe0VVYKGoUD1BhTGHPqVfVATle8szQ?=
 =?us-ascii?Q?YqkxPTVMLOrOunaNHo7KSDbvHbnd8Zknyo0sm4BPDYJf/sDXeYOfRsZfXX4v?=
 =?us-ascii?Q?PTrZIKdC7VkKiojromH+HzLpyJoNMzLMJYKFtaT+6CE/5donSnqPtnrQhhW/?=
 =?us-ascii?Q?pIlzAcxCa3RReMJ4Z0lGIMoVp/gvhDGsCHm4e9YVl387hJ90pEe38EwmfmCi?=
 =?us-ascii?Q?NF57X4twRhAPJ9vXzjS4JeNmw1jNH42YkNI6/3eP+1gnCILmJZBFy9GpotQQ?=
 =?us-ascii?Q?gvkGM7epFCTqNaxysl0jlGghJSMx3K7DxeGB8b+sd46U7KBhI2QdPY3IddaF?=
 =?us-ascii?Q?RGB6dZJov9jja7wxN0e7gVq6O9H+C+E2utiJj93AqNpE5dDRDZGNZqwTGBgz?=
 =?us-ascii?Q?3BTIiPpZ1X/2AyM5mmXW4LiiT77M9Rc=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168ca7a6-26ac-4546-885f-08da4ecfa08a
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 13:04:48.5914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zk/sf+VairS6Uoa3EJrq8fjVnA3xcBnKVecLoFRyFtfLxsFlu2LR+iC3MaG5NfD3qgJzmIwe2rCk61SNFW0tvXyOxwC1KuG2MIlqM+BVskU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0061
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

On Wed, Jun 15, 2022 at 12:39:56PM +0200, Marco Felsch wrote:
> On 22-06-15, Francesco Dolcini wrote:
> > +static void imx_init_temp_from_of(struct platform_device *pdev, const char *name)
> > +{
> > +	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> > +	struct device_node *thermal, *trips, *trip_point;
> > +
> > +	thermal = of_get_child_by_name(pdev->dev.of_node, name);
> 
> here I would do:
> 
> 	if (!thermal)
> 		return;
> 
> since the thermal node is only available with your dt-changes in place.

I didn't do it since from my understanding both `of_get_child_by_name`
and `for_each_child_of_node` just handle correctly NULL as an input
parameter. Anyway, I agree that your suggested change would make
crystal clear that this is optional, I'll do it.

Francesco

