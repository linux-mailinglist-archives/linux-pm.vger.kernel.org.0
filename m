Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769272E25FC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 11:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgLXKvz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 05:51:55 -0500
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:32480
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbgLXKvy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Dec 2020 05:51:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1pHIwnJhiJQe6Mc/9IL8qJSGkmcCQepzxzkgHAWzJIxwNkvIMKVbb1fN6CTkXpA/Wk9qTUinfdyhsGEjRqFBF7nNyThrzNYvNF/r2tJePiruoYLMwVYQYyWjqGt5v5rsxVAdPARVxMT2QSoXyGvDIrDtcj2d6qgsSxOgvOKgrQUoC+y2ziY3H46mUjEHLUd536gX4zVVSbN6LxgBpP1kU8Tmd1XsrddjHSljAriJtec9D0IkUxzZ9Dd8xLLwmRQGe9cpXsEMsuTX+TrOp9on2ytK8DOpV7kijeENVD7bj3h1Vc8RvVGKpYN4KCsU+xhoncnFm/OliIGlJsqnDPtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVLw4gmsJ7yZxZzDCqfv2ZnLa2hw1IaYWVt93GiC6v8=;
 b=fuaV1B/KD3VYLN/2y4l3WITBaaAMQr1mgZk+IO+QMv6uhAenaPt0u0UnbA7HsWohGibJ1KvxPWTXzUuI0ucle8ykuBLxIM5japseAMwzLEpyU48nG3xhClv5jedh8n3IDgixgDiQQxYONcKuusuPexMPvSYLSfNnLVhqCq85ojYHKc9nsO8qkYnXgdZehW5G6VxCRANhSn+Rdu4iGwA3KgwWTrrw1hmLH0y0B8QO7pFX6qKta4d4HO26nmVXmu/Cz2Tkcqf8GXJX0npKk/ZHWo1RH0hMf7rU7OBH4Hf9FOddZYZJ6/VrlLcsRkDWsPMHEGaIWOM5Oas0VH7GkynObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVLw4gmsJ7yZxZzDCqfv2ZnLa2hw1IaYWVt93GiC6v8=;
 b=OPK8+iFCRac1ODAWq98M86RPJfuMkX4NDZKNVyAUpu6+cn/oXHxchT8/Vcc+03tkavBTzhhBcAqPxDJbxafI8nvP5U4UgbKnKTgQxIuizBkfZw5Nf6CTTB8VRMtX/DHHEFWuAb+KHVMES/SR7rYblBsGFLGweTI06JM0jH5GVDI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2103.namprd11.prod.outlook.com (2603:10b6:910:17::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Thu, 24 Dec
 2020 10:50:42 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d0ac:2f2:3653:e812]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d0ac:2f2:3653:e812%4]) with mapi id 15.20.3676.029; Thu, 24 Dec 2020
 10:50:41 +0000
From:   quanyang.wang@windriver.com
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] opp: fix memory leak in _allocate_opp_table
Date:   Thu, 24 Dec 2020 18:49:27 +0800
Message-Id: <20201224104927.722763-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Thu, 24 Dec 2020 10:50:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2da4920-284d-4399-339e-08d8a7f9c22b
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2103:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2103160C8FC00224F87B3975F0DD0@CY4PR1101MB2103.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKpn/QBx7auGt4HXdzdW4n6YLJRswjJMGkOomq4joW6OKMtAnXXIjrIqjLnY+QfLxmwCDAgB7M6+IAGsqVix/kmg61WcXsZrdAXaxozmks/eJ50OGpivaZMLBCIDJlmBWAfx1nN+4P7o9jo836R6jd9bZjjfgs1Vv/oJZQurJ5ElzhWMcG/eP8FTV75TQUbJLEtG3M+dP1DS4ydkWjzTbvGvmSm3PBO3qMqFilQtt6iELptapPbbeytdECT8qQq/4v2/dDphhPyODwniPwVOwOYUqx3P8d8Vl1sXZCx8s0t1uNPM0NDK88aLmgjx3NoX+/VH7UhD3vxb0Gm0/peulUi+/7B7Ts8tdlcwvVjt7brSH5HNc/pA8kwhM0hAXvqgEg/vBxh0Ivu97tvFePx4cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(366004)(396003)(136003)(26005)(52116002)(956004)(36756003)(83380400001)(6512007)(6506007)(107886003)(86362001)(8676002)(4326008)(6486002)(5660300002)(8936002)(2906002)(316002)(9686003)(66556008)(186003)(478600001)(66946007)(1076003)(54906003)(16526019)(2616005)(110136005)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KF/foSBfLz7/BCyQArDopx6KGW01GuyFGHn5hFa55b/YU+Ob4AUGdVcLcrxd?=
 =?us-ascii?Q?avxPfIm1uPPqcj5UDzGtmBXA+zW8fcmdoGBczvC6h/bNekRITuityRngvmh0?=
 =?us-ascii?Q?k5f/s6hHyQfik6hYEk9fVK6V/yXvmhUVWr2/hWSfzXvv0f4NtnIMwjjQMOgk?=
 =?us-ascii?Q?R9tjFJ/79gCwgPWrdahm3u/4MIFQ+gsyLhHBL14v7mnU4IqfCdlzS/eUIqAF?=
 =?us-ascii?Q?VpXZO/0VOauA2UMAfjyWGj6ClDSNV3RSGuB9fMbGAtQe1dMdwy1pGeliQfKU?=
 =?us-ascii?Q?WZhHWgBMLO1F/zVXCJ8dcq7I51ELU/OkMmDIs8DrRs6gGcV5RnByC/vB0WlK?=
 =?us-ascii?Q?4fZGz6njl0WZNRrHJ+TNGe9ZBeJtcTLiVFkCIG0afJfekEvg74a40xqXCDoD?=
 =?us-ascii?Q?CR4kQzdhSf1EWkMr+7gb8+pZF+JWWmzW1nMp6KV/7tx6pvB4gs8o4oezcJwg?=
 =?us-ascii?Q?DypvY5zoQFAeRwl88GMer4De8x2q7qYluu28A7brA1klROQW5f2S9CemXQmS?=
 =?us-ascii?Q?L37NHcDv4Lcc+nHlJB58syGuxVJUIjrdZfLl6ZVnOaF4MU66LFClc+V3P+MS?=
 =?us-ascii?Q?b1cysjFzidAV34BLVbV0peJaHVNkuKv43IvUjN/qBjEfzZn5qD7LtPnFw/Dy?=
 =?us-ascii?Q?gYFNkc1M0GyTXbo9nrJK7SiBBHVqjZOGw4wi2XWXCJ9a8Kn6L14bgDNA8YZN?=
 =?us-ascii?Q?2hEjCzWjrdgSMdUozzzLKgLcrXrFfLOv8GdoJuY8tLZhNv2KRCF2LQpv1zHu?=
 =?us-ascii?Q?H6r9efePYK/lueKEgl3qCiGCyai35I7HleXWT1lxPQtI1VhprAdE+IekW7in?=
 =?us-ascii?Q?FJqzhUr3HLTyz5QwZJibaanQnxjwQ/fp+cTzqBL4Ygn5/KbhSdac9AcL8D3D?=
 =?us-ascii?Q?pZJKgm8Ofri93WftLf5APvmdr9vUO8u93svRdaxNNCj1va1YVGVv4xEKCaFb?=
 =?us-ascii?Q?2a482lGhYSKrjgXB8CJitB6AStNp/2S/RH/uInYpuUukNQTsZLIkAKL/Xylu?=
 =?us-ascii?Q?SBZS?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2020 10:50:41.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: f2da4920-284d-4399-339e-08d8a7f9c22b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldxHFHxbsnR3DVz1jdgRFq34fnOpBbJGx69BaRMXk0PKuTomwTJgbb0wGg3hLumxHVPZ8ohyWVzlzYsUyTSXt2QvTPB7XCVJy6Kz1CqCNBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2103
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

In function _allocate_opp_table, opp_dev is allocated and referenced
by opp_table via _add_opp_dev. But in the case that the subsequent calls
return -EPROBE_DEFER, it will jump to err label and opp_table will be
freed. Then opp_dev becomes an unreferenced object to cause memory leak.
So let's call _remove_opp_dev to do the cleanup.

This fixes the following kmemleak report:

unreferenced object 0xffff000801524a00 (size 128):
  comm "swapper/0", pid 1, jiffies 4294892465 (age 84.616s)
  hex dump (first 32 bytes):
    40 00 56 01 08 00 ff ff 40 00 56 01 08 00 ff ff  @.V.....@.V.....
    b8 52 77 7f 08 00 ff ff 00 3c 4c 00 08 00 ff ff  .Rw......<L.....
  backtrace:
    [<00000000b1289fb1>] kmemleak_alloc+0x30/0x40
    [<0000000056da48f0>] kmem_cache_alloc+0x3d4/0x588
    [<00000000a84b3b0e>] _add_opp_dev+0x2c/0x88
    [<0000000062a380cd>] _add_opp_table_indexed+0x124/0x268
    [<000000008b4c8f1f>] dev_pm_opp_of_add_table+0x20/0x1d8
    [<00000000e5316798>] dev_pm_opp_of_cpumask_add_table+0x48/0xf0
    [<00000000db0a8ec2>] dt_cpufreq_probe+0x20c/0x448
    [<0000000030a3a26c>] platform_probe+0x68/0xd8
    [<00000000c618e78d>] really_probe+0xd0/0x3a0
    [<00000000642e856f>] driver_probe_device+0x58/0xb8
    [<00000000f10f5307>] device_driver_attach+0x74/0x80
    [<0000000004f254b8>] __driver_attach+0x58/0xe0
    [<0000000009d5d19e>] bus_for_each_dev+0x70/0xc8
    [<0000000000d22e1c>] driver_attach+0x24/0x30
    [<0000000001d4e952>] bus_add_driver+0x14c/0x1f0
    [<0000000089928aaa>] driver_register+0x64/0x120

Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/opp/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4268eb359915..c9e50836b4c2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1092,7 +1092,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	if (IS_ERR(opp_table->clk)) {
 		ret = PTR_ERR(opp_table->clk);
 		if (ret == -EPROBE_DEFER)
-			goto err;
+			goto remove_opp_dev;
 
 		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
 	}
@@ -1101,7 +1101,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	ret = dev_pm_opp_of_find_icc_paths(dev, opp_table);
 	if (ret) {
 		if (ret == -EPROBE_DEFER)
-			goto err;
+			goto remove_opp_dev;
 
 		dev_warn(dev, "%s: Error finding interconnect paths: %d\n",
 			 __func__, ret);
@@ -1113,6 +1113,8 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 
 	return opp_table;
 
+remove_opp_dev:
+	_remove_opp_dev(opp_dev, opp_table);
 err:
 	kfree(opp_table);
 	return ERR_PTR(ret);
-- 
2.25.1

