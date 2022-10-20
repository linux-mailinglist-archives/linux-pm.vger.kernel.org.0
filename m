Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159F8605C87
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 12:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJTKhW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Oct 2022 06:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJTKhV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2022 06:37:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BAA1BE1D8
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 03:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ06bXuUiL7JBL/Cro2958VFlI6+ebqi3JKSwaS5dMGPPjU9Wfxq0nciwOCcTnf3473qmtUQSowdppY9OyM8Fx7fM8wU3CuxleCj3Kkpxoj8Z1v/raquGNkb2VH7alYmCTKzQBKrQKNhyZSC335yOJsWkXAjxZaRYYbBk71SY0K4OdJbVvf4UvkQ7Es7UeBthypPQ1uXRSeSxGcIN2n087+RHni3B226udSXF4qI7OSxDE9Z3dZu+AEUPs9TEgYR5pfmp9O6176df0PFmTrYclL1fwaXS6qPbpbyDUpAb/KSlJ+Dx4NfwX+hVYe21JkLZsV5R4MH1yVqnuMV0vpH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLxoNMS3/xQkt6nnBBsICqPGHj+mkPa+vNy+D50yZoQ=;
 b=Ks3FTgbqI+XCfN1g/SOUn6akUWjxbulROX8RMOQm8pvTrepltdZIpW1HhBL5gVigNCAxi8P2xDp4UWAcWIM10UlZMaruSa56BXAd/Cjw3JmtGvgwNCsMwrX/rKinpoe8XlYVBUdTmwCZBhSsgwbnTKao2FERKT1wqFkQujyGw5Kd+CE9NjW3oWqH4zeTeRigZaMQUvKJdBjupShJbvYOuoM1SYcmG3Z3RB3VyuWsZiIV0sXy/T4RPpM14JmLk9qP7Xzpuyhp9Kzj+i2Lz/RsxME0oON0TEnHnFlztOsj/fi4dF1WTAG7p/BggCfNb7DAlsVeNY0EbE1fikCQmPdeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLxoNMS3/xQkt6nnBBsICqPGHj+mkPa+vNy+D50yZoQ=;
 b=R+8QUAy2kFe9AKf/k1GgeJiGttdeH57Th6LSr7PcWMhbOFnGOYUwvohLcmheNQmcdVQBztqj2btF3oVE58H+oS7y1KDJs/VJQ+Z4fNOteOgq6nNNPgbCAeVSsIFM1BXRf+b0NyfykUFFj/kfUpKWoynGdGLo51XhEG+CjLL6QCaP6PVA+Hlm82/EGfQnId9A1BvmKc3Nu2iLcsIk0gouLpqlrUhS7zi1+kIhS4+Tug2b98BT7wUgTkd2dk7CjTyVeUIS8flx35TfENnlJ9qyqZgrvK5WB9TlrmtzUn0TsZXj2/7vhbt3G7Qf3RJ9ikuwP/pfv6Sakpylhvyx51WiSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 10:37:17 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::4ff2:d93e:d200:227e]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::4ff2:d93e:d200:227e%7]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 10:37:17 +0000
From:   Ido Schimmel <idosch@nvidia.com>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, vadimp@nvidia.com, mlxsw@nvidia.com,
        Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH] thermal/of: Fix memory leak on thermal_of_zone_register() failure
Date:   Thu, 20 Oct 2022 13:36:58 +0300
Message-Id: <20221020103658.802457-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0601CA0003.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::13) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|BN9PR12MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe3550e-21b2-40d6-a905-08dab2870f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQDWEpJm361aH7N62lJwxniIvkEqe35tu45NK7DKcFTcUFU9KSolNltemqlBwlqyLxROqC0RAJsgMAQm0R3WqGhdXl3tfWnLSvjFkdUUGMt0ilxy/9u+oarAMPHSZsFTb9Vn/xxZr/FBprm8c3YzAr5j3oW6m/r1D3DlXAeUP/TOumnncPrJe8b17md3p53YL0nI7chN+lPBciUAM6StVyBgf1uboo3ViCzPf/UvrifHzSQK8eWm3pn+5Ij1VRUDTpYo63aIM51U9CR4C6Ek1vCl0AJahRAX78RUIFR310z23PzGON/zTglzsCYHQEYCdQoEdu9d/2Qyr5z+Vwjhcymw51oIauQjLeXcs9aNdLbjPRHs4rgtAwL4uoN/9PrNuXYcHkI0wF/bge7Xdf7+MSxcji1pknzt95+XPCUygA9cbFxGdI3NdPiVmuHYl7/YagTDZcm50ryEL+6f6mg/vs4LUaD6dr/Xw2T6Aen2eDkha/DDa2H1TVDJuF62Of/MeIG5waFtZqRgNzz0Q7f2i+HAZEznc1NLGXOXFPuViIKQr6po7XX8jJcQeZsmIe1lghb8w48rnly4rlruavzFICOrSjVMBlBvpQE7r0u54wYofOV7h2ao7h/Zp5G7LkdqT2wZCFk4FyPBdSHeNB0WYMkfUqPJD4v34gS3n/j3fTnyUUwUzhlFVevhyJVkNGXyOA8FaPmW9YYw0GmfNFoQIggCsGGFUS4KrYpex5HKHppdVtPLadQ5hJU9vQOoyjXmxtsgNHWU+s4mDp0dxxYaSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(186003)(1076003)(41300700001)(38100700002)(8936002)(316002)(6916009)(5660300002)(2616005)(83380400001)(36756003)(6666004)(107886003)(26005)(86362001)(6512007)(2906002)(478600001)(6506007)(6486002)(66556008)(66476007)(66946007)(8676002)(4326008)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2iN4cNwkWHGNTPKWGklvw4CR4sAgXQ68HEVtU5ACruto4DnUe+WHnvA17dAk?=
 =?us-ascii?Q?hdpaKCCIiJncXpFlcGyXrMxCmr2XIKgXzOAXE/+w+VfQVjLodAo7jYkBZXz/?=
 =?us-ascii?Q?uQlyEM/jhgqkiFODAyr9VIhEuq6DoC8tjdeAm7ni1nODNEk9JC8FGzdviFaB?=
 =?us-ascii?Q?77iSLSkZlpOKTIA/KpU4vkg8jZASN0tryNCMK+P4lqpjSTHkhVpPePngbdVf?=
 =?us-ascii?Q?yy7N7vCghGgn402pFouvCG5qp95EXE1O5Xzxe8r8zGjvUKbqFYb/b9nW2S0t?=
 =?us-ascii?Q?KH5VY9RZ8mKcSPCojdjp67E2Uxwiwaid1FqH1S29h69ZyZKII/VWTDZNWUCJ?=
 =?us-ascii?Q?wTJ6zW3o3IPh83lqa2zW6mUb+idPQ56vyjFSwCV5Uz4Etw6EexEYpZABYPKc?=
 =?us-ascii?Q?y55q8dubQaxQWqh6hHj+lDR7UpIrpUeSRQbMkHZq223oZMavjsaK2SV8agF6?=
 =?us-ascii?Q?tytYXeclXxcTTefPp0RcRnrCB6nipTU6+NdLLxAQ3Ch8juP04H/sY9ZbaSc3?=
 =?us-ascii?Q?1qJeATDaK6ACwz/g69TDnMdr+CI0jcfdyY/1IJ96RZzmmDzqtqb8n+XkXV2Y?=
 =?us-ascii?Q?pT+aHm4uAHmw8KA7O6flMyHRRQCFc3J/bnnl3asZPBnazMMF1h2vceHkSBND?=
 =?us-ascii?Q?kbZvexTZoc+4rdtjzHk7y+XHzuHCfn8P0EbjH46djKbVWjkAQcthu1XFqHmB?=
 =?us-ascii?Q?X3FcSBnHmPWSyUaIde5rWMOXKakci9cbFwGyE354CANwtsLG2pOWYk4RrDnG?=
 =?us-ascii?Q?ZLrIuaiMeQiSk3mMmlG6vuTrPd3H8CoZVYKNaUxrdfB+WTOHXfkCde+cE/an?=
 =?us-ascii?Q?KjV+nD9dtK/Fs9Gr4+1Vejs2LjziCgCijGYeTXlfnhCjg83AdHwNFtl55X0G?=
 =?us-ascii?Q?Rx6tRABeAobRUmGRDUgNnPX3CZHZ4kWazgfBCEWKN/flsXZi2sLUXYoB1Xxp?=
 =?us-ascii?Q?hGO/2n+nXf7qEvzwdyGKit2iLQV9BGl5nn2YUnWm+8HG+imDxZf5Z05mgFdM?=
 =?us-ascii?Q?OIXGI76scDQaA1HFVhnHP0uNFm6bVRXoax/6M7oG0m7LZ8Y1NOanQbpkHoU7?=
 =?us-ascii?Q?iNUcpQEAr9ApzKTpGQli+BbejmHnIO3yj1NurvaHwtmqn3UDOs8FKu8Lu2M4?=
 =?us-ascii?Q?suENHX2DUVQskvIO3hpNfm/l92sRVBHCAX5hRSerexfrZptFLMWm3kfUqodY?=
 =?us-ascii?Q?WdraBCQ8lJLmCnHXBHO+Zdn10VOMFT2UOP6nXGe92NfRujWpEcEWrM32ESb9?=
 =?us-ascii?Q?w+gSJ6X8IY/d4FZd6RVeon3ZXrbOklEt8MjEss+BHNFmyvLK/pFRllrKhJuc?=
 =?us-ascii?Q?cp/bU+AuVG/DY2v5tOWKxeFWi93VKErOewJ0TnpTpDXZktlKIkHHMsNeTWsQ?=
 =?us-ascii?Q?kBLes8tJi/qMpWMsnV7L0lvYtTn+Cz25/1edwOmbKg6UjJEQize3Rx93u/tO?=
 =?us-ascii?Q?Rhftbl/WIzZ/tbfYO+ofesjnnLM70ruRWvj7Zb/cfcASXPxwa5qSTwaKsGpb?=
 =?us-ascii?Q?+xi3PeabiZnEtMMgaBsqd6AIvDUaQycd3kvzpn9u3BtAjbBf9QBdQcLHxc0b?=
 =?us-ascii?Q?7IgxP6+f6KSckp8+OUoAi0lKD+I3LAOBHPLFWHNl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe3550e-21b2-40d6-a905-08dab2870f22
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:37:17.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ecdhRUbI8ouOGI5mFzul6SjOni2/34BnFCOZvCmd2ICdA5oSlDJ0E72ukoiZRA2gkdKT6YMXcCPbRTtCdMTSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function does not free 'of_ops' upon failure, leading to a memory
leak [1].

Fix by freeing 'of_ops' in the error path.

[1]
unreferenced object 0xffff8ee846198c80 (size 128):
  comm "swapper/0", pid 1, jiffies 4294699704 (age 70.076s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    d0 3f 6e 8c ff ff ff ff 00 00 00 00 00 00 00 00  .?n.............
  backtrace:
    [<00000000d136f562>] __kmalloc_node_track_caller+0x42/0x120
    [<0000000063f31678>] kmemdup+0x1d/0x40
    [<00000000e6d24096>] thermal_of_zone_register+0x49/0x520
    [<000000005e78c755>] devm_thermal_of_zone_register+0x54/0x90
    [<00000000ee6b209e>] pmbus_add_sensor+0x1b4/0x1d0
    [<00000000896105e3>] pmbus_add_sensor_attrs_one+0x123/0x440
    [<0000000049e990a6>] pmbus_add_sensor_attrs+0xfe/0x1d0
    [<00000000466b5440>] pmbus_do_probe+0x66b/0x14e0
    [<0000000084d42285>] i2c_device_probe+0x13b/0x2f0
    [<0000000029e2ae74>] really_probe+0xce/0x2c0
    [<00000000692df15c>] driver_probe_device+0x19/0xd0
    [<00000000547d9cce>] __device_attach_driver+0x6f/0x100
    [<0000000020abd24b>] bus_for_each_drv+0x76/0xc0
    [<00000000665d9563>] __device_attach+0xfc/0x180
    [<000000008ddd4d6a>] bus_probe_device+0x82/0xa0
    [<000000009e61132b>] device_add+0x3fe/0x920

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
---
 drivers/thermal/thermal_of.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d4b6335ace15..aacba30bc10c 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -604,13 +604,15 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 	if (IS_ERR(np)) {
 		if (PTR_ERR(np) != -ENODEV)
 			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(np);
+		ret = PTR_ERR(np);
+		goto out_kfree_of_ops;
 	}
 
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+		ret = PTR_ERR(trips);
+		goto out_kfree_of_ops;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -659,6 +661,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 	kfree(tzp);
 out_kfree_trips:
 	kfree(trips);
+out_kfree_of_ops:
+	kfree(of_ops);
 
 	return ERR_PTR(ret);
 }
-- 
2.37.3

