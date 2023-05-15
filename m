Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40970703487
	for <lists+linux-pm@lfdr.de>; Mon, 15 May 2023 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbjEOQtV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 May 2023 12:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243046AbjEOQtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 May 2023 12:49:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2023.outbound.protection.outlook.com [40.92.42.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996344EE1
        for <linux-pm@vger.kernel.org>; Mon, 15 May 2023 09:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXO/KeRKziRGoBU8Lv+2uPZwR1LeaDpdeLtM8OrnlD36QxwOSCPc3uKb3XhCy6dRwgy3NdydLAMnXyWQ5N/5mdrjlExsTgja8fZItXa8VnPRi6/Xu1Xy0WPfGxdVYM+jP+wF0fNa5mEUZ64nbXI27CTRqMcj2kb/O5H/bdnX/l9F2TU+WxIt8jpp5ahGy0OwYBfa7z7khT2Ld0zSlz3SzBf5dGJ5N4oaG4x08bleyOciKp8ytmKTBze5B7AjC6OZc9HE3IhmbwhENTcsnHbgMkNUc+bleIV9GDv1+EkMjWvNVR5p0E1Npt00eNkMVBSunXuLLwb6RjY2AhF7zj5rwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JccmX1fXhngiTOT4hwDnXRCAOZR3c4WFXCpnvkezK6g=;
 b=JrNTqt8R741fgEEbByw7OgkhAjbw7RrcNY/zxgIN2mqd6WJ1zFCuTqFuglql5HTeOeU3QYEu/Tfapbwi2ZAHANaJAFKYJCVmQ44fBIFFtsxgtDWioMGOV8HG3m0WFEkmoV+lnhoxH/SMChkj6mF3CvbVWRk/ZJrTKVzHgANa6rsSzes5kPNmpnNmviHoWHSaHXDUBtEChYYGpFQW8O75HbI28YWlUcjzfe6ZT+6Bm8b7+y6SCVdToLVEivvrAEzyCGD1CBHaSWjzJK9ydGh2rxtTnusGwaLKwGJQCfJ3bU4JVFMJR6nW8aq2yrttT8tlgYUjS5WivVoecWtBzDZ0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JccmX1fXhngiTOT4hwDnXRCAOZR3c4WFXCpnvkezK6g=;
 b=p0SBJ9LKpJv7Rc1wMm68MBkyuy25FY5w8gMI0lGkgHY2yXJ0mNaUykLapW+FFB9owYCK2aAjkXiTmCy4KbBxy8cwkkLPUtg9vE+wswdmL6FWGQxXQd15uQS8JJgCKoPyiPdBlt6U6HYtCggfEzICDwDM4ULhX+a8zcFml+NdG2PL1tBffDCNfJLaXG4U/DJ783XxbkBxftULC+zmU2bpx6UCBC7ZWNP4I5RI6l9+ja5VulecWDw6SDWPKA2KfKJY6XHcmOw14t+qJTccCxNmmNbJhRZERQbLRVwkiAB1UWVxSfG49LFhZnac7ceUKDtE7jh7n0wzWn+SY8XZacVb1A==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by MW4PR06MB8900.namprd06.prod.outlook.com (2603:10b6:303:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 16:49:10 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::17f5:7da4:55c8:1436]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::17f5:7da4:55c8:1436%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 16:49:10 +0000
Date:   Mon, 15 May 2023 11:49:07 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] power: supply: Add charger driver for Rockchip RK817
Message-ID: <SN6PR06MB53428AF7C7CB29DD6EE243FAA5789@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain>
 <SN6PR06MB534254918F9D84F996BFD2ACA5719@SN6PR06MB5342.namprd06.prod.outlook.com>
 <7ffee6ca-00fb-4fdb-8741-8f9163bfa75b@kili.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ffee6ca-00fb-4fdb-8741-8f9163bfa75b@kili.mountain>
X-TMN:  [ou6+H5/PZwncTnXEBf3ALUosg2MUxIgW]
X-ClientProxiedBy: SA9P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::34) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <ZGJigwtpc34d54i9@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|MW4PR06MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ae8078-391e-4892-732b-08db55644e38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EeykvVYptZlb600p+yqj9MlRJB0nC2U63UYRA/Zk592JACXh/G6wImLyzempJA2fZpMj7+ePmmz1DeikkjfEXtoSopquVcV1NBx2q0Q+o8rIyDdhwaddN5dWhmPgW7i86SDC+gGmFXypM12iXYf7RgpN2dtAcixK3ogcMUmIOUzjmNUIKqzdkjD5y7zpAxLhM61N9x/L4kzwrJUspPEpf5Ey/GV9QSTKr1IAyngJIubcj9+A7vouc4KrBfE741QDL9LA4LUPNCpuopMgfBKO8CFFLjB++dA3UQVP5wfv68I6J0ATS0kKEh/YWCg+1nSoVSMb2tn95HcZMiaJAJbCEHuBrt1RYiR0fc5wk5Uh2fMKz/c4yGlry9WJSyoAQXE75CWE7tcBfI0UuLfxc/mNuilGxM4meuJ6aXmutlLGDQ5g8ygkjG8aJBoLZJdevmSknwzFcZD2C3VDosyfEUmrJcSQDLWT5LmtIIQLAefqcfRktZqF2E6PvyBPVzzqRYwi1f2KnMH3phuVcRfgw6RwgCDBcRNyTKB2JTwF1rT2tl9gLnqm2gNXWFieGs+/QnLg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GUlPzj4JuUk/0iCgd5CM7v1ii9O6uKH8O4eJNN3aslkXmvSnjS0zbRMXI28D?=
 =?us-ascii?Q?mzMqnRqdMnLSzJ3bHnsZcSUD7NNsZTU9ZCFzZoECzGUqKDmnksLaSv/qTh/R?=
 =?us-ascii?Q?RuH4XdeISK5v4/FfKSTy0APOESoQ1dBxyHC3B6Rk+M3L7KfoyWJN4i4+JIXN?=
 =?us-ascii?Q?KMbdf+7SGJ35cx/Ecg2OKrp7o9UeLaQUS7Nc/aZVjaI6ZaBnRy/QPWxGDzO0?=
 =?us-ascii?Q?VoLNMtmwi7z5tF1EuDeVNMe/LCp0JpVQm3+dtNdXcqPg9DzJqb62AWNNizcP?=
 =?us-ascii?Q?bYew/0QrnKQRp4kry/PQ+VOV7FFM4ZMvGftod1DAVYp04Dw1uKursw4rCC/A?=
 =?us-ascii?Q?S0Thq3HaPnsvgXfV9ay158Wmo/8cCOjWYDA0Rq1FuTHBV3EyT3H2R2YpFwuu?=
 =?us-ascii?Q?cWneB6yoNnLhG627fqiVFV5rUJhUNXu5dMirHhrecKn9xwYIaNLQ30ZKDpYw?=
 =?us-ascii?Q?gqyvRftFd1lNwjTA/kN5SfPXkUqSzVoG+gOcneWgrnNfpk3IXb/d9rG9+XPe?=
 =?us-ascii?Q?t6AIh4qIsGoc6JNsmLu+7bbKufkmkmENWKv5XGsBgjqFcpukrEdMTE6qdwXC?=
 =?us-ascii?Q?smybOej7JAoUd8r3sXN2eLZRDdmKMz+m/WGrLw7/gu9CUYDdIxY6Z3yKyngu?=
 =?us-ascii?Q?6R15gQ456vl/QpVG+gm0Qml5SjrPqxCMqjytIxQubRjNLsP765/kxMkpksbk?=
 =?us-ascii?Q?b760qSf0hip6kA4g3mzGRBo9X49qaUueT6E/hpTkG0o5fO9sVqSobINEwMxu?=
 =?us-ascii?Q?XRWCaNUGUYjpf8IsUx2htCSMbElqCNTcVInCQdmRL0z/Tvv52uH1CJKKNso9?=
 =?us-ascii?Q?oXESh2Zyx0RTmNLm57ZttYiKeZL3vqYBnEPMctT1r35//LLKtS003jpvAhfc?=
 =?us-ascii?Q?zeRghspOHtP9YkEL6qwbOdCT0OXIrXNcqXFTQ+bsyogjeKpL9Q8ssfgDZrfP?=
 =?us-ascii?Q?W4Iovn/nhcJkeXl78hKnqepdKSB2+mUWs0BDa77OcmmatKB4CrjjFsBCLmFR?=
 =?us-ascii?Q?bGTrGMg9ANm2vMHH4TTmdHMaIq4smirlK7GHpO8neeCt/YwD8t+NWl1uMz5p?=
 =?us-ascii?Q?ewcMWK1LcxbP4WD9S3a0XFIQcDWzDigTgxTmqUTt2EHlAZF6UczfoZtkKa7I?=
 =?us-ascii?Q?D7ydaM7bnBo6QzL5mq7H6pYBNn/RnIMTqsXmwhm6ThNeYKFMwcC3xlYHMAib?=
 =?us-ascii?Q?s581ueVS6oansuoj1yLtDzeE3fdARPBd7Rc4wCIXLVng51Sy9gL4K+4gaCs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ae8078-391e-4892-732b-08db55644e38
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 16:49:10.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB8900
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 09, 2023 at 07:19:44AM +0300, Dan Carpenter wrote:
> On Mon, May 08, 2023 at 01:46:53PM -0500, Chris Morgan wrote:
> > On Thu, May 04, 2023 at 01:58:31PM +0300, Dan Carpenter wrote:
> > > Hello Chris Morgan,
> > > 
> > > The patch 11cb8da0189b: "power: supply: Add charger driver for
> > > Rockchip RK817" from Aug 26, 2022, leads to the following Smatch
> > > static checker warning:
> > > 
> > > drivers/power/supply/rk817_charger.c:1198 rk817_charger_probe()
> > > warn: inconsistent refcounting 'node->kobj.kref.refcount.refs.counter':
> > >   inc on: 1088,1105,1115,1124,1130,1136,1146,1160,1166,1170,1177,1186,1193
> > >   dec on: 1067
> > > 
> > > drivers/power/supply/rk817_charger.c
> > >     1048 static int rk817_charger_probe(struct platform_device *pdev)
> > >     1049 {
> > >     1050         struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
> > >     1051         struct rk817_charger *charger;
> > >     1052         struct device_node *node;
> > >     1053         struct power_supply_battery_info *bat_info;
> > >     1054         struct device *dev = &pdev->dev;
> > >     1055         struct power_supply_config pscfg = {};
> > >     1056         int plugin_irq, plugout_irq;
> > >     1057         int of_value;
> > >     1058         int ret;
> > >     1059 
> > >     1060         node = of_get_child_by_name(dev->parent->of_node, "charger");
> > >     1061         if (!node)
> > >     1062                 return -ENODEV;
> > >     1063 
> > >     1064         charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> > >     1065         if (!charger) {
> > >     1066                 of_node_put(node);
> > > 
> > > This error path calls of_node_put() but probably they all should.
> > 
> > Thank you for pointing this out. So I should probably just add a "goto"
> > that puts the node at the end, and direct every error to this? Just
> > want to confirm.
> > 
> 
> Yes, please.
> 
> regards,
> dan carpenter
> 

Would it be possible to get details on how the error was generated with smatch?
I tried based on the instructions from https://smatch.sourceforge.net/ but I
was not able to generate the error prior to attempting my fix. For my fix I
was just going to do an of_node_put(node) right after I set
`pscfg.of_node = node` and I want to make sure that solves the problem.

Thank you.
