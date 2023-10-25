Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859277D67F3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 12:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjJYKMk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 06:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJYKMj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 06:12:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE27EDD
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 03:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM8GJ8UUfDg/3IQH5aQJ/JF0XBoZWioZLl3KAkb10HEXDoCEzj3Ri9j/Yb+8NmMwcb2Ad1hpyfK6q+c1wjh54vcCsm7qfpPSj6kifAXdUdqiwKvImf1Nrky6NHx4oQirHmOxJhOGVKz94HsPLacwQZM0IgTgSj3aohl+EuKW0MvjMn9eXgdzDZ4m9PajDYKN/XHakpOL9TQY2TYTTNtWpqydQxwYeHH8QZRJMFlioV0g+5GXL5uUyij/cyrWqW+z5i4j7MLD7QfMiBxeSsniMxN+K5JCL8YiBeZtnaITm1afWjwGP8YooI79Fdn5lAw3zJiQSFokVBfkD9M0LPbsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg25XrHTRogHXsEKsnfksfeGfZFSl1at5Qc8Qyu58cY=;
 b=IRrbYu1QHON5tlVr/RT4vMYd2s7FM2sPBRGRY9jdo238Nkw42Tz4oY2jbMTeErt9Ro+T1BlEetuo5ob7SoHAjHluGeXHzFPF+U3oNbbc5cxdEDH4WNac0+L8RJLKAB87uXGnVg9cAu7V+I43W6P2Qn2Ab9m60qHH52mI6a32OrNzKXdhzbXSv/I5+b6rhSqZn/oD//BjDuKYEmG3QIZc3sMxd0y6wjTuplIAGThRu05QwpCFLqvTbqDsP+KIhn4pj3SZE8bLxNwA4b6JZJht64dl7VoDE5VJklbap3uK696RTMtO+JARhuNMNr3q3nwHA3Gh/L2BB4ZIrHAxc/0alg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg25XrHTRogHXsEKsnfksfeGfZFSl1at5Qc8Qyu58cY=;
 b=XMPAkc6TQPLrLzVCdOHuItz78C1N/QFXnZ5Ji+xc/3Q9TToC+ItBRP+W/lSfuj8PHAVHfw02vEPY+i0R09jmxMBt2vKXRZ6Jiqmodh5aAB7UfDy82aGc16HQFHUJE9ofTZc0ruy3L27L9UsO4/H32B7RzSt0/b08q0LO3ynXivs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::24)
 by AS2PR10MB6896.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 10:12:32 +0000
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5133:ebf7:df87:bf89]) by PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5133:ebf7:df87:bf89%2]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 10:12:31 +0000
Date:   Wed, 25 Oct 2023 12:12:21 +0200
From:   Emil Kronborg Andersen <emkan@prevas.dk>
To:     Ulf Hansson <ulf.hansson@linaro.org>, festevam@gmail.com,
        Pengfei Li <pengfei.li_1@nxp.com>
Cc:     Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
Message-ID: <3jw4nompbmwfigjetvob6pxxac56tbavifzvf3kbvsubtvxwvk@oskzm5ihpc74>
References: <20231012132214.257207-1-emkan@prevas.dk>
 <CAGETcx9mUVzERc8Uf3FWYtMv+RZyNgvjm1oOtQZq6yN4_3Bp8Q@mail.gmail.com>
 <CAPDyKFrjtZH-yHu9od7bAA69=AdUHmsFr-amhhW70JLCKZGH5g@mail.gmail.com>
 <hhx2tqxmgrjbhz2wnhozffpcq63spuli4mrensvbnmilrvbh2d@6qo444ddawc2>
 <CAPDyKFrSzepC0c7-XGeGcHSsfpEGpF0a9ATGpemxvcc8mtL86g@mail.gmail.com>
 <CAPDyKFotwRPBLpOe6q86b7JhS8t36wP2wvn2hid5uZ-57J9Ytw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFotwRPBLpOe6q86b7JhS8t36wP2wvn2hid5uZ-57J9Ytw@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0032.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::6)
 To PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB4576:EE_|AS2PR10MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 298df6a4-072c-4ff2-5827-08dbd542e696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vyp6a54ClpNWmUow+GBwPEv6bkXTWkWOWnRKZZkvRrJMSUg0TjsNzHFiXMWrodzRymhcp/UngI9B7IwiSO/C59a2G1Noh2lm4PUdRBKlIWSVZWRa8u9z6Mq/CRuwk0VV83j+51oF+aMo3vpcsIxGGpsR12JFroN0wFM4KpB+INFJBsSNTEcRXmDG6W3pNqUQ81W/5tIV+XFNUKXGzodAFrXG3VZbdz7ms4DZNPPbfFC+DtwXNZJ6tcxr+qk9wFvypBSWCC8+Ngh5Bf249/j2fg+36j2ocZouqBJnEChugIex6wNnNsxRPCC55xU6op1Qy1uZFw3jKc6FdPBS9zT2VXLHg/D1Oi5L/+6UOWjsSbu8/mWX4FIo4bQ4F5P3R0tX0NHGCoKuBpRCT4SmVy+vgbIN2t5HpGtXRwt9eIxZeOhk5C32xxhb77DxAWDjhP4ilUmnCzOL4Oggx/TTG4c/gHEQULSmpa9t93KWkPRpUORhVX2vZvJy2coOlAWRojMcCeCTaaTUpKgYB05AtlpUcocYLZ0Rdiju+NDuu92BKqtnXSUuDLrEjOaJhH2DCml4wvbaB2/MHLdqwEBUjthrMsHAVCXvTikrTvQ2f4hqXUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39850400004)(366004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38100700002)(26005)(52116002)(53546011)(9686003)(6512007)(6506007)(83380400001)(38350700005)(33716001)(8936002)(966005)(6486002)(8676002)(4326008)(478600001)(86362001)(2906002)(316002)(5660300002)(41300700001)(6666004)(66556008)(110136005)(66476007)(7416002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?884E036Ca8jY+HRsLRemGbe+RBFiS5fBVV5hYv0EjE8iL3ENQKmooUQA/1fo?=
 =?us-ascii?Q?b2XwwE4aVwh93V40VqAj88qmjX9lUQLE6tbZalZusuPySwTQF2H2XxLezFOw?=
 =?us-ascii?Q?ICV14dsCroCYzGTy/cyRjkrS1rOtj9xhHd2zZ/i2gRpvWgfnDXMZbuyzwNZ+?=
 =?us-ascii?Q?tpyC+v7P6pKSskESZ5RIMvUF3JifpsHjNDjskMsYoHAcNOFZ4Ev9gBAAEgdM?=
 =?us-ascii?Q?9jCaxQ2T6BwH9ae4I9IMXU2kQiLmh7w2rzdmgP1mIy4ia7LF+3F2x8SVAL4o?=
 =?us-ascii?Q?t8V/mnkmZ4NP2rhtfX+xEl6U4/0H25cL9kVq7c47symTApFL2gMCXUfkUw1B?=
 =?us-ascii?Q?OGT063WhjwkXgSVsDnyrMXHlgwVM+/sfyQHUP9wNTA49c4RBTMf9VRSoUgvA?=
 =?us-ascii?Q?OSUe7NhyFEq98kRkE+b95BkG592xog5wcsF2PrZDYbCjsvno1BqPNQQxUis/?=
 =?us-ascii?Q?zDz98PN+tAKVFgkmlWh/g5HaQid1i+BcuQYj9F/MtI4naLihq6firZCm1B0i?=
 =?us-ascii?Q?juHtPE9sLIpUUOa8PNSNnbcaMUIxyn3lpT8xBPg9xk0C565HtDFOI5jTLEwn?=
 =?us-ascii?Q?2C4RlHZ7rp99u2DDpSaURYH1hjMLrADavz04X7vAaccqeGzxVbgaz+xZ4iAh?=
 =?us-ascii?Q?yZmBi7VHgT0J3IToDBxuuo5ovGUre184jkurTaq+L04Lk4wdYWEPYwOvXqzr?=
 =?us-ascii?Q?Wefi0IgodkFTMHNo66tilzmKUSr1nNqQPf2cUb4NmEECMQYtbCYXkZ5mgJ+y?=
 =?us-ascii?Q?o4GRml2Gm24n6CHO4DrnKPkV8p9F+RNohVGJPcomb5MYtRmhSxZoURZCVPOf?=
 =?us-ascii?Q?FDvYM+KupDL/oQLpk6yXaBhfAWUBo/SvLVsv1ineT8NKtEfLJanrRDKPZRxb?=
 =?us-ascii?Q?Bt4HrqCPrjF16Rgi/XvfUHN3Jn64ZPh5bjy+ckboRgfw0iElNZ4WJ96dM0pC?=
 =?us-ascii?Q?B7vgy/V1hnjPYCyDgRWmtmPJr9S0zQowZWpDK0zDemftrmr/Mq/sMxqQud6Y?=
 =?us-ascii?Q?MFWEGyJqdrs09ty8PiK+l6QdJWtKl9ktI/QnQxZU7pi9vD5UlNgYGYA35778?=
 =?us-ascii?Q?Lv1Z6KeR9L1tzATVsBt967Y5lwTRkKYMuYcIFhQgnZK0IGwRS2HgeOoDLF9G?=
 =?us-ascii?Q?R0d+WgrufaaKVa1on4eENCdk8re64o1mzQR+wdsw4dlrTx4TsX4Cc2Ihy2Am?=
 =?us-ascii?Q?Jv/MyaMhfgBfQcKJTr1MuKSUa6JRZtd4lSTMS3m14+khUKkY4/Ear7gTcS7j?=
 =?us-ascii?Q?np8N6BgtVylqwohNnb04iNg0tIg9dUZ+GkyPSKi8ebVib1ELMPq4auKXAR9C?=
 =?us-ascii?Q?+BaPzMyPYLhRvxIkNADrj02r6ops9niDWk6qQ1u2KahOPkgWyU2Bq29ha/da?=
 =?us-ascii?Q?sdBDG3Y+qeeVtKIqZBL0wpmdMEQgSiXeQdwtHOeSBSeyPDm3q4U8zPKQF4T8?=
 =?us-ascii?Q?riEbo6kYwOgxJCsSYsE97ai/fafwIARuyvMLXFTXmWgrXAGLQTw8Im/B1D84?=
 =?us-ascii?Q?5a3YIpmPsxCZ7QBQeHIOPjinzL8Aj2zm2eicB0/rG2ph3Hwl8VIW/k9LEbab?=
 =?us-ascii?Q?kzVNmUlUHX6/A53dpiwceYH4szSzpAVjwq6UkJYTC3PuWRo9hos6zakL/MYs?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 298df6a4-072c-4ff2-5827-08dbd542e696
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 10:12:31.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlC0G0GrXk6SGufGeOepgrFavnNujS81ClbD5bHpmZ2R/tfppyPM3hnGpIfvJn78L+XtGLYCGPd7GoxKfjjOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 24, 2023 at 14:42 +0200, Ulf Hansson wrote:
> I had a bit closer look at this. If I understand things correctly,
> this problem is because the imx_gpc_driver's ->probe() (imx_gpc_probe)
> is allocating/adding a new platform device, per child-of-node to
> represent a power-domain.
> 
> I suspect in most other cases where a platform device is being
> allocated per child node, is when the child node has a
> compatible-string and the parent driver is calling
> of_platform_populate(), or similar. In those cases, the "dev.fwnode"
> would be set accordingly, but not in the imx_gpc_driver case as it
> needs to be set explicitly.
> 
> That said, it looks like we should move forward with the $subject
> patch. However, it looks like the patch [1] from Pengfei Li is more
> correct than the $subject patch.
> 
> Kind regards
> Uffe
> 
> [1]
> https://lore.kernel.org/all/20231020185949.537083-1-pengfei.li_1@nxp.com/

That is also how I understand it works.

I was unsure if the patch from Pengfei Li [1] solves the same issue as
this patch, since there are no errors included in the commit message.
However, after testing the patch in [1], I can confirm that it fixes:

[    1.039830] imx-gpc 20dc000.gpc: Failed to create device link (0x180) with 20c8000.anatop:regulator-vddpu

I based my solution on other patches, where device_set_node() is used.
For example, a26cc2934331 ("drm/mipi-dsi: Set the fwnode for
mipi_dsi_device") and 6dbe6c07f94f ("gpio: Propagate firmware node from
a parent"). I am curious: Why is the approach in [1] considered more
correct? It seems logical to set the fwnode as early as possible from
the parent its device.

Thanks!

Best regards,
Emil

[1]
https://lore.kernel.org/all/20231020185949.537083-1-pengfei.li_1@nxp.com/
