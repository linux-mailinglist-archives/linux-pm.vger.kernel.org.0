Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66D2257537
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgHaIXk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 04:23:40 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:42075
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbgHaIXh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Aug 2020 04:23:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HscEUib7jkkIZ8Tl6zRbNXdq2QN9cIeVfumqvdZmIwB1JfKr695s7QeIQ91z0Ku2KgA0/3KnVKhhaeqYNd6CjlRP+VBZTe4fIbj1/fMXSn9wrVVK0K+Z7MfEB9a87WAXgD6AIV6VwwhzHZHVN44ccXJJcN7gbx+ZHkAQTjX72xUyYZ6+fyOge0UcgfXRNyKcLF3T0IPujj/0naGdDgeaYgQz0ePwWnGikLppd3tm/ixQ4FKRz6JUh34CwCDMM5BGC0mUcDr/ECIEw3MLBuI+4M0tECf6wzlhRT1GaknZaNykM4tC0dXqofTWhQZAEi/d1apuZUhTw7A/68vqkLdSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUN7FRLAHXpEYFyzg8DmiQ81myUDS2c80I62x5jiLrc=;
 b=AFaO62KMZugXrGLzd9l7JOX8ghpmG1hTZOf6SONw2p33H5ezE+Ma8g2wc2mT9WR9c/yQc4uLmvdpMYeLSxS6PRJvcHRa7yE3Wy3xLkUZNcQ6vEzIywxcnZRiOOEv7x8AberLFRogxzduHB1YmZjF8Ws8nJxQUZctn2ACqDaQp4KbldA4FQDsKBtmhJEAUkyFueqOZHUjRmvJgGfe510RAy2iYVqWgNWP6oHgIjYs9k8lHg2OoLnmny7USIeVETABNq9TOl4gDN+31+awV+cgKjA6vxj8E2u53OH9o9zhQvWfSldQt/tLVrst7UEmPhJ0XC/BH8Jy7Uxa2r9TQW9tCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUN7FRLAHXpEYFyzg8DmiQ81myUDS2c80I62x5jiLrc=;
 b=gdCAl7J5v3RJO2gyrTBABvx7FmOY0huh6W7QmDuOclEBmpsyDxh5JGeGkIx5tvSMqKWmf9RleDGgiQy6Nu9fRDh2c7yKiyd6C2Hxky1XNGH38TW1LrNtDmuXhZzt0cSw/Hro86EoWw/0mkg4zAIB2dK6zXSPiRa3RfxBKf07q1k=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5803.eurprd04.prod.outlook.com (2603:10a6:10:a9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 08:23:31 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3326.025; Mon, 31 Aug
 2020 08:23:31 +0000
From:   peng.fan@nxp.com
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] cpufreq: dt: delay the clk/regulator check
Date:   Mon, 31 Aug 2020 16:48:58 +0800
Message-Id: <20200831084858.2398-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:3:18::15) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0027.apcprd02.prod.outlook.com (2603:1096:3:18::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 08:23:24 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87777422-0be9-4a24-53e0-08d84d8722e2
X-MS-TrafficTypeDiagnostic: DB8PR04MB5803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB58034B27BBC20E826D792A7D88510@DB8PR04MB5803.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CG3/hV+l3RlBzY1dlPhJLA7BK5/a0K8nsRU/y8O9BAIdyahDmFMJiJSJX0/8Y4LQ8wKloTiopa1Rp3pcUaSODOxwbQoYUAsT+KVQWEZ0gK1ZF/4CFNyrwuEnIaxLw/NlLfWsv5to7joTbKGLW602woMZEjaewnPbimi4TY7j/KFnylTK7LQSoSoR4S92OKggiI/sjZuKfPObG+zF7hgtUQAEFuKlAT33oYWgjfF9FAGZGtXx/qS0CKP6yxXV7E2yp3DebR21G9Bg3xLAZaEGocn4QNBHfl1ScJz8Cf+iUDdp4sJow4rkrav024UTKjTiajjjBctotAh8X7E+Yx9OZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(1076003)(6486002)(86362001)(6666004)(478600001)(6512007)(16526019)(26005)(5660300002)(9686003)(186003)(2906002)(4326008)(83380400001)(316002)(66476007)(66556008)(52116002)(8936002)(956004)(36756003)(2616005)(66946007)(6506007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LJhS28vz7VglIPV6D7DhquDqpAlrZlRh1sEzzO53R6fbsLRVbboe77ahxdfKZeQ9lTKZ4aRxCDClL5pKZkq7J1epLkS86KQUXWAHJiLmyoK21oej+iygwMHtkDhZSbpDpmsWpG45scd8US5/z+YwDr5QIpytI6t0Wit5va0878velKYPuTBRVZUllEL3dY6aSLT5OhNqVnMakIRGuLH5u/6FsKHftMdpKAt0pJrMGz6hh2P0tHPKb1NAU7a2MmvFLE+jPZxwkSRDfl6Dm+xU8vKKMdJGJQnhdZiKeMzzoa1v7URZrCn9DggiUgJpFdNfsuMv9R3lKst7ngrkVQvJlphvm2jODhTf0Ww9I0XGZzGwJMat2HXXcOpSgrTdg+/p4NJtB8wkHSKjiuZfVlY3fJIzCmdgtoxh2ISJPfWUAP79L4c/j0y8fHH+BDRRmmJugdd/YjudBtUjtWHAhKigcn0k9bUJbwd/JGd2bYL/1bpOvkwSYJ/WMffYZOUfHtUSdAENDPw+q5uri9woWSx6Um/j/yW2A3NQgnMwvzIwMgyfQtaEKYE0n4xCDNXQo+4g39c40/PdHUBUysqus8tqm5ENzi48JL2P8tru0t0QgfFoSZE/bHeKLGR6kiu0Ok2LbT3q7Rj5nYWqwRRwMqEiBQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87777422-0be9-4a24-53e0-08d84d8722e2
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 08:23:27.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyS/LIa0JZ0O5EyoPT10dIOVyauXnvWh+6/Y0s5+Uds8Q/nja8znrdk75eH+z4QFdsYtlTV+Tg1CIhRmWA9IZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5803
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

cpufreq_init could be used to do check clk/regulator check,
there is no need to duplicate the work in resources_available.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Actually we met an issue as below. Per my analysis,
 it is regulator_put called in resources_available not remove the devlink
 before dev_pm_opp_set_regulators->_regulator_get.

 I tried to add a check patch:
 diff --git a/drivers/base/core.c b/drivers/base/core.c
 index 0971fedeec7d..4f8c7c13bde7 100644
 --- a/drivers/base/core.c
 +++ b/drivers/base/core.c
 @@ -760,6 +760,7 @@ static void __device_link_del(struct kref *kref)
         list_del_rcu(&link->s_node);
         list_del_rcu(&link->c_node);
         call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
 +       synchronize_srcu(&device_links_srcu);
  }

 It could also fix the warning dump, I not find a good solution about srcu part.
 But since we could optimize code to delay the clk/regulator check, I worked out
 this patch.

 [    6.799650] sysfs: cannot create duplicate filename '/devices/virtual/devlink/regulator.1--cpu0'
[    6.808725] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.8.0-next-20200807-dirty #272
[    6.817868] Hardware name: Freescale i.MX7ULP (Device Tree)
[    6.823486] [<c01127c0>] (unwind_backtrace) from [<c010c598>] (show_stack+0x10/0x14)
[    6.831252] [<c010c598>] (show_stack) from [<c05bc410>] (dump_stack+0xd8/0x10c)
[    6.838585] [<c05bc410>] (dump_stack) from [<c036d5b8>] (sysfs_warn_dup+0x50/0x64)
[    6.846181] [<c036d5b8>] (sysfs_warn_dup) from [<c036d6e4>] (sysfs_create_dir_ns+0xd4/0xf4)
[    6.854554] [<c036d6e4>] (sysfs_create_dir_ns) from [<c05c2734>] (kobject_add_internal+0xa0/0x2ec)
[    6.863531] [<c05c2734>] (kobject_add_internal) from [<c05c29d8>] (kobject_add+0x58/0xc0)
[    6.871732] [<c05c29d8>] (kobject_add) from [<c07939d4>] (device_add+0xec/0x7c8)
[    6.879150] [<c07939d4>] (device_add) from [<c0795600>] (device_link_add+0x3cc/0x534)
[    6.887005] [<c0795600>] (device_link_add) from [<c0694244>] (_regulator_get+0xe8/0x274)
[    6.895116] [<c0694244>] (_regulator_get) from [<c09f6568>] (dev_pm_opp_set_regulators+0x9c/0x1e8)
[    6.904092] [<c09f6568>] (dev_pm_opp_set_regulators) from [<c09ffa4c>] (cpufreq_init+0xb4/0x2cc)
[    6.912897] [<c09ffa4c>] (cpufreq_init) from [<c09fc484>] (cpufreq_online+0x268/0x92c)
[    6.920837] [<c09fc484>] (cpufreq_online) from [<c09fcbb8>] (cpufreq_add_dev+0x60/0x78)
[    6.928863] [<c09fcbb8>] (cpufreq_add_dev) from [<c0796f38>] (subsys_interface_register+0xa0/0xf0)
[    6.937843] [<c0796f38>] (subsys_interface_register) from [<c09fa304>] (cpufreq_register_driver+0x14c/0x228)
[    6.947684] [<c09fa304>] (cpufreq_register_driver) from [<c09ffd28>] (dt_cpufreq_probe+0xc4/0x140)
[    6.956663] [<c09ffd28>] (dt_cpufreq_probe) from [<c079adcc>] (platform_drv_probe+0x48/0x98)
[    6.965120] [<c079adcc>] (platform_drv_probe) from [<c07988cc>] (really_probe+0x214/0x3b4)
[    6.973405] [<c07988cc>] (really_probe) from [<c0798bd4>] (driver_probe_device+0x58/0xb4)
[    6.981604] [<c0798bd4>] (driver_probe_device) from [<c0796c08>] (bus_for_each_drv+0x54/0xb8)
[    6.990150] [<c0796c08>] (bus_for_each_drv) from [<c079863c>] (__device_attach+0xdc/0x150)
[    6.998435] [<c079863c>] (__device_attach) from [<c07978f8>] (bus_probe_device+0x88/0x90)
[    7.006635] [<c07978f8>] (bus_probe_device) from [<c0793da0>] (device_add+0x4b8/0x7c8)
[    7.014572] [<c0793da0>] (device_add) from [<c079aba0>] (platform_device_add+0x100/0x208)
[    7.022772] [<c079aba0>] (platform_device_add) from [<c079b65c>] (platform_device_register_full+0x104/0x114)
[    7.032617] [<c079b65c>] (platform_device_register_full) from [<c0a01028>] (imx_cpufreq_dt_probe+0xdc/0x2c0)
[    7.042461] [<c0a01028>] (imx_cpufreq_dt_probe) from [<c079adcc>] (platform_drv_probe+0x48/0x98)
[    7.051265] [<c079adcc>] (platform_drv_probe) from [<c07988cc>] (really_probe+0x214/0x3b4)
[    7.059550] [<c07988cc>] (really_probe) from [<c0798bd4>] (driver_probe_device+0x58/0xb4)
[    7.067742] [<c0798bd4>] (driver_probe_device) from [<c0796c08>] (bus_for_each_drv+0x54/0xb8)
[    7.076288] [<c0796c08>] (bus_for_each_drv) from [<c079863c>] (__device_attach+0xdc/0x150)
[    7.084572] [<c079863c>] (__device_attach) from [<c07978f8>] (bus_probe_device+0x88/0x90)
[    7.092773] [<c07978f8>] (bus_probe_device) from [<c0793da0>] (device_add+0x4b8/0x7c8)
[    7.100710] [<c0793da0>] (device_add) from [<c079aba0>] (platform_device_add+0x100/0x208)
[    7.108909] [<c079aba0>] (platform_device_add) from [<c079b65c>] (platform_device_register_full+0x104/0x114)
[    7.118760] [<c079b65c>] (platform_device_register_full) from [<c150f7f4>] (imx7ulp_init_late+0x44/0x70)
[    7.128260] [<c150f7f4>] (imx7ulp_init_late) from [<c15036b4>] (init_machine_late+0x1c/0x8c)
[    7.136726] [<c15036b4>] (init_machine_late) from [<c010247c>] (do_one_initcall+0x80/0x424)
[    7.145095] [<c010247c>] (do_one_initcall) from [<c1501018>] (kernel_init_freeable+0x170/0x1f0)
[    7.153818] [<c1501018>] (kernel_init_freeable) from [<c0e7b938>] (kernel_init+0x8/0x120)
[    7.162020] [<c0e7b938>] (kernel_init) from [<c0100134>] (ret_from_fork+0x14/0x20)
[    7.169599] Exception stack(0xec0c5fb0 to 0xec0c5ff8)
[    7.174665] 5fa0:                                     00000000 00000000 00000000 00000000
[    7.182858] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    7.191045] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    7.198202] kobject_add_internal failed for regulator.1--cpu0 with -EEXIST, don't try to register things with the same name in the same directory.


 drivers/cpufreq/cpufreq-dt.c | 58 +++++++++++-------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 944d7b45afe9..13b291757796 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -93,10 +93,8 @@ static const char *find_supply_name(struct device *dev)
 static int resources_available(void)
 {
 	struct device *cpu_dev;
-	struct regulator *cpu_reg;
-	struct clk *cpu_clk;
-	int ret = 0;
 	const char *name;
+	int ret;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
@@ -104,23 +102,6 @@ static int resources_available(void)
 		return -ENODEV;
 	}
 
-	cpu_clk = clk_get(cpu_dev, NULL);
-	ret = PTR_ERR_OR_ZERO(cpu_clk);
-	if (ret) {
-		/*
-		 * If cpu's clk node is present, but clock is not yet
-		 * registered, we should try defering probe.
-		 */
-		if (ret == -EPROBE_DEFER)
-			dev_dbg(cpu_dev, "clock not ready, retry\n");
-		else
-			dev_err(cpu_dev, "failed to get clock: %d\n", ret);
-
-		return ret;
-	}
-
-	clk_put(cpu_clk);
-
 	ret = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
 	if (ret)
 		return ret;
@@ -130,22 +111,6 @@ static int resources_available(void)
 	if (!name)
 		return 0;
 
-	cpu_reg = regulator_get_optional(cpu_dev, name);
-	ret = PTR_ERR_OR_ZERO(cpu_reg);
-	if (ret) {
-		/*
-		 * If cpu's regulator supply node is present, but regulator is
-		 * not yet registered, we should try defering probe.
-		 */
-		if (ret == -EPROBE_DEFER)
-			dev_dbg(cpu_dev, "cpu0 regulator not ready, retry\n");
-		else
-			dev_dbg(cpu_dev, "no regulator for cpu0: %d\n", ret);
-
-		return ret;
-	}
-
-	regulator_put(cpu_reg);
 	return 0;
 }
 
@@ -168,9 +133,17 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	cpu_clk = clk_get(cpu_dev, NULL);
-	if (IS_ERR(cpu_clk)) {
-		ret = PTR_ERR(cpu_clk);
-		dev_err(cpu_dev, "%s: failed to get clk: %d\n", __func__, ret);
+	ret = PTR_ERR_OR_ZERO(cpu_clk);
+	if (ret) {
+		/*
+		 * If cpu's clk node is present, but clock is not yet
+		 * registered, we should try defering probe.
+		 */
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(cpu_dev, "clock not ready, retry\n");
+		else
+			dev_err(cpu_dev, "%s: failed to get clk: %d\n", __func__, ret);
+
 		return ret;
 	}
 
@@ -198,8 +171,11 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
 		if (IS_ERR(opp_table)) {
 			ret = PTR_ERR(opp_table);
-			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
-				policy->cpu, ret);
+			if (ret == -EPROBE_DEFER)
+				dev_dbg(cpu_dev, "cpu0 regulator not ready, retry\n");
+			else
+				dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
+					policy->cpu, ret);
 			goto out_put_clk;
 		}
 	}
-- 
2.28.0

