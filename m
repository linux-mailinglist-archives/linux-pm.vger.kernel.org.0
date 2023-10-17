Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166FA7CBCFD
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjJQIAk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjJQIAh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 04:00:37 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2121.outbound.protection.outlook.com [40.107.14.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF9611C
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 01:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5U7KdAt1ZtA1WhU6EjLyE24pSeqnSAcYYTHpaZKApSL9cDMBRuOgmluQjiPmJr5uls8EYskpEbz+jumK0BxUGiIpu7FwvGMEC3+KPr1AJBXgHSIkPDkgP0FDvIk33Q/CtVHO9LVVZ6zW/IhcQeJyXi7DW5tWVscVGckmaWaYtep5Im3UNLO0qHjMu+Ps0QaTrCqVm2XBRijgA0BtUZvNMkv6lzDGZuGe3Z4gF4DGtXcgxb+H9vjXQPhHcsze4jffHausrzkEqErQJWgG7OpHxOgyQk7W4pz6ncsvsJAkT0axjYGmlLCd/GJsqH7EBaOltboGKgpyKzU6W6fuWaVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9eceTxlD3Igkv3Kz3GQlKgeSQrT0dmiNZ55oDsLyh4=;
 b=mcuPDcYw0L/dz9Zl4gCqUjpjLKQAzjL6jcpXt3rltj80zbuhlrhNOOmrnib/SznVA+6zNZOd5uP+nOkTtw3wB10IvZEOkuJ3kE+C5oZ1YV7gIaJK7rhMGWLy+BMadkluMXtO3kB8UbjkObWoUCO69Q8sRkziYUsIWzCAHl2lpY9FBHBxGMMvNzc2LdBwMw2T1wR9BWgY86Y37cHyglL99jr7dcN4Epb3ZoLraUr4Grfg9h3O+E7Avtf8eJL/fsDzpD+VdmrveqHkJXyNGjm1o71kiCkoSXi7iNCTP3OczK1nSYSSqnVs9PQwdE0WOFKmY5HFk2ZVQaBLREHWeOHw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9eceTxlD3Igkv3Kz3GQlKgeSQrT0dmiNZ55oDsLyh4=;
 b=XCeT6+AnXanfdiX5nnRU5HO8/UiaxEKSj334YYFalYuiLLuaBlc1tM8x1uPSYBRQqtYoKzIcYQyOa0jKpV0uSmjseg8XxbWnVRM18Xd/H02PBI5AVZ3lujFpYv1uf5RDk9D0VuuQJkc4ZYTC1Ury1dtAjZQONexJsgSFxQ+P0pU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::24)
 by AS8PR10MB7256.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 08:00:28 +0000
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b972:fe02:5368:5470]) by PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b972:fe02:5368:5470%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 08:00:28 +0000
Date:   Tue, 17 Oct 2023 10:00:21 +0200
From:   Emil Kronborg Andersen <emkan@prevas.dk>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
Message-ID: <hhx2tqxmgrjbhz2wnhozffpcq63spuli4mrensvbnmilrvbh2d@6qo444ddawc2>
References: <20231012132214.257207-1-emkan@prevas.dk>
 <CAGETcx9mUVzERc8Uf3FWYtMv+RZyNgvjm1oOtQZq6yN4_3Bp8Q@mail.gmail.com>
 <CAPDyKFrjtZH-yHu9od7bAA69=AdUHmsFr-amhhW70JLCKZGH5g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrjtZH-yHu9od7bAA69=AdUHmsFr-amhhW70JLCKZGH5g@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::21) To PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:10a::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB4576:EE_|AS8PR10MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a3be92-4933-4802-8e4a-08dbcee720a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPtJVPGbcWnPmoryByQK1LB+ac/RGb1zbsgMMkSS0x+OX2D5keKPyI0qu+T059J/o3rHSDBYpQEmXTw/0DLdPnxnJ4MOR3XEqn8ZEsiJ+W+bc0ef3NIWwyG7XSd9YzPg/h57Hd7b9nwcmQLhYtUaFzHis+8/9Ck5Rzr6zyUAxH3oni7dxYCYABY+QXJHEcK9dRmqZuX3dmFsOzjmT9dml4cVOGev8NHtyBl0NPHJPGhP6exs/VFWNeXkqa/intpkGP6UCBqu16PfMeN2uFfa0A1qpKmJB3yFGn51oE9fwutaOzEiQrdKiPCzKjYJGlZJuZHIX6xJYmYbIRNt8RkOSwj/Bl7ENbtc6vXhG8xIQRuclwdFi6xLKWCVpu2/1ZLG9BRzA/G5sQQY75pl85xumO0dAYCcTT/tuD8WnHMUEUvcpck/up03+o6VGW18/TzYycd4kQKatZnvcYrkt/tdn8j3acPpyhUDTVs52hE3n4Y+fvtZondpnIHzM1GoeCTcedvJIXptsNnyfl1dZmn9W6s9nb3Ie+PLCrhioytVkHGJwiFNtFFsQyaYUhN9VHQtWYthxbbf/qGKeeUw4xF2jK0jdJqUC9zvMnlAa2YfZmmQJ/hRf2PbrKb3CdX8eRU8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(366004)(396003)(39850400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6666004)(478600001)(66476007)(66556008)(6916009)(6486002)(66946007)(41300700001)(83380400001)(38100700002)(86362001)(6512007)(38350700005)(316002)(26005)(6506007)(52116002)(53546011)(9686003)(5660300002)(8676002)(4326008)(2906002)(33716001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iDyCeA5szl+el3XcBwWi2mMzkrHd8KfzOYg91rG45gCxJ5qxGZNj09bwa5MA?=
 =?us-ascii?Q?Xexxnoz6v5RP2mD9GG1EgsnFV7hPLijI9ed+pqMyazKLl5DDfkFr43MjdjfL?=
 =?us-ascii?Q?99Z9uTqtWOWQ2XZ2vMIFcBBuV3Lhh+j3epU3lSLLGn30k4nIFW8VGSAmHlrU?=
 =?us-ascii?Q?ea0zJGhR6uvLkv41WAEvRlO4DqeSNMwyC5q4UrXWOYDTJirMWhWD+n2GKV5O?=
 =?us-ascii?Q?aufJIhGm+pAWG5gKRqvHbGdX02TiAedkpXjnaI0SKIfIrL8w2Wwx9hJO8sqr?=
 =?us-ascii?Q?VcBNfmZftZoKaDNNdKLqEhi1aibasUde+JJBEFYrEADwyPM4rDZ9xH1NcdQm?=
 =?us-ascii?Q?N8mwlICJWGMq0UWuG5vuitFuxpuST7LcFskSXF8OFyb7XX6Q/KDThW4AiTK0?=
 =?us-ascii?Q?v1buuuqPlwzl0lAvay7qPL3k592XFQiYQSl2hnhfLhAwSz6+Rgv3n1mafVB6?=
 =?us-ascii?Q?fOnaJj1gTG2xybOleywuIUym6aDDw/Kd5FLLLrrxIqmjcSsHIvgnHrN846uu?=
 =?us-ascii?Q?Th5TFi4ua1lUzTswAuu38loBYxAgcV5kMuVgZCufuNVyqk+W6EJxGF9ewCdc?=
 =?us-ascii?Q?WmvWbKbiNBasLjfd/g5k3w0qdId2bmdcmdxY9WHYltL+0KfL+4YTH2iwNPJu?=
 =?us-ascii?Q?wozrNnirpPOCYTdhZstf8jwzCBsnIvkvc4z41OtGeOPgZrOzXLXs/rfztSDh?=
 =?us-ascii?Q?GtJpSployaeC7uKYqUdS/f2GdIcDKZsTKAq1TSaXwzuNwDIIf/nW4uc3HWSX?=
 =?us-ascii?Q?v2HHbMdWWv3zc4XCjpe6818uLLlFgBUYlZ5tUUIxF6/063VBs+93Uu5M0riP?=
 =?us-ascii?Q?e8cAmj/ZJy0kjSacFS6aqecdAb52+fBccRRo2wnns2aL1WBlqa3JmLMTZZPi?=
 =?us-ascii?Q?UVWffRei5eEHrkT+gJxVfqDkXsrfDp145n3vmJgIzAsCS1ORvr7C3hZIcoD7?=
 =?us-ascii?Q?GSqN/FJFlm6mZEUwNuQ7N1RNPdleHIGd0FXw2OXXaFEe2Nliw0mx8OB+aOxH?=
 =?us-ascii?Q?PT3X6HQrL6Y5Waw3gICT0DrKGInfhkHwHSapvfH1cjjxIzHxtMTZhLZD80Zv?=
 =?us-ascii?Q?ocBLqDihLd0PlHHOoyC4EovYnpRlP4giZJaDwbvrSh4NqirG+ra2F6PCYe78?=
 =?us-ascii?Q?UuTTE3oxtlrEzR9YWpi3R9vOxSHQVjP73JOMAEIdhlm63puRM5KGr0CzBphy?=
 =?us-ascii?Q?r53KDDKCWDsUvlzie3piJ9IuelOGk2RMi5Z+BX9rf+u9uFSmsmJzDOqzq30X?=
 =?us-ascii?Q?r7ymb1zvlTvu6bgi5jDYMh+c3//F1Af8ETnlwSdkLM3/zS7veF5aGidFpD33?=
 =?us-ascii?Q?6HTxoOY2D06N5Qv0kSHL2oFZSs8uER0Ko8zhm7UGCO2mBjO0aoc5q4f5pVIQ?=
 =?us-ascii?Q?UEtY7zhr8BDygkOK2ChG9ezOPBL9E7Gol8yfsB32jEPPCYgf2G3norCgmDl0?=
 =?us-ascii?Q?8Fl1Z29pjz9fa22aAYMQwuqsOXjvg+yOMcMw3uRErPxVd2NuIGO9Hm1AqAXu?=
 =?us-ascii?Q?V7jKGto16lmoV/RcHkgFY1f8mcuBBjxus4F0l+dGGoec9lFCL3p0gR8TIYhQ?=
 =?us-ascii?Q?KUcIkC1uRQi9359psteLdJ2XUse9Nfw1wKKJmaXS6qVeNjrpXR9Rahk5eVr4?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a3be92-4933-4802-8e4a-08dbcee720a5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 08:00:28.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwgqVBuBqRuUisDP8ZZx9raYzMBB7Scu1SAxaCcW13CIWL0pZHCLf95HdmLy4JiklRBEQxG1uPGl3NEWVs6fJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

On Mon, Oct 16, 2023 at 11:53 +0200, Ulf Hansson wrote:
> Unfortunately, it's not that easy. It's not required by
> pm_genpd_init() (or of_genpd_add_provider_*) to use a struct *device
> when registering a genpd provider. In fact, that's also the reason why
> pm_genpd_init() needs to initialize its own struct device.

Do you see any way to do it properly at pmdomain level instead, or is
that not feasible? I agree with Saravana that a centralized solution,
akin to what was implemented for tty devices in commit 1a5ecc73b2bf
("serdev: Set fwnode for serdev devices"), would be ideal. However, I
was not able to find other reports or patches of problems regarding
fw_devlink at pmdomain level, so it might not be a general problem here,
and fixes per driver might be okay in this case?

> That said, can you please explain the special condition that caused
> this thing to be needed in the first place?

I noticed this issue when I updated from 5.15.93 to 6.1.37. Except for
the commit I bisected, i.e., 3fb16866b51d ("driver core: fw_devlink:
Make cycle detection more robust"), I found that the issue was
introduced somewhere between 6.1.16 and 6.1.15. Here, some commits
regarding fw_devlink was backported, which might be relevant:

$ git log --oneline v6.1.15..v6.1.16 -- drivers/base/core.c | grep fw_devlink
11d93294b7c3 driver core: fw_devlink: Avoid spurious error message
3dd596616d10 driver core: fw_devlink: Make cycle detection more robust
a3c171751512 driver core: fw_devlink: Improve check for fwnode with no device/driver
7a8ce4d2fbbc driver core: fw_devlink: Consolidate device link flag computation
16aa2487cf15 driver core: fw_devlink: Allow marking a fwnode link as being part of a cycle
eaf9b5612a47 driver core: fw_devlink: Don't purge child fwnode's consumer links
2455b81afe68 driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links

Best regards,
Emil
