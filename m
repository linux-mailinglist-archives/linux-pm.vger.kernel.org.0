Return-Path: <linux-pm+bounces-21769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C025BA30245
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 04:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF303A9684
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 03:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99641D5AC6;
	Tue, 11 Feb 2025 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fP+s3SGn"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA21D54CF
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739245413; cv=fail; b=Hr5ekhlsjFQlWefiSRbE+YNH0WkTuW/AoDG0RA+JNx7jjPvi7IN9Qm6cNYOx6wKBKhdm+CJRMsW5F/Erz2+71kzk8L4znxaHYUISrmP54Vv9yG9HQRjGFCpejHfAH0znjOP88XA7KfKL5k8bflE7D1spoVGUaKlaAa69DDoAb9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739245413; c=relaxed/simple;
	bh=w/vYIb1EPlN+v6EQpADTatqO9YVTtIGw1m5nhNmJ4Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=moEtc1iba13z6xzQqdX+gXY7tF2RPf9gZgIBHGLIIf+GoO4RnBXbMNc/Isbins/tRfdTOEyqexwJSAKMRqZhxRJrcjacIJkwafr4nL3xFINbpZkUuZIC0hgIzCqFu+Bq39WSjH9jjOhf8y27YG9QQT4CWrSh/s/dv4V60MFcv1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fP+s3SGn; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpVbHj7/c02KetZqh44eCCrxJd8SKSjDl0GeMnE59Wdn0YgbrZqef011QhdLkgPmgQbPwfd5wprWW/Uvwu1BH2G8ktfwcNsDjE+3ufdiERnwlBgA8iI0WbxyAnFEuSOOc+186FlrJblwLm0EYbwLYG/EA2YRZhQYQSzsXUt0uG03z8JP5ae1lcskUZ52swFA1F2LbkJhmQKtLnAsZqk9MYrkzJywG4vZtuxmh0SaUr4Uu8LZuF5UQB9/pF5bAmQBVFPNDUIVR7UK2761IzvD6Jy15oksBiaEIFIVZmDRXHnvG2TggaFVjbz+5U83uXl/NbMKWamePgkP90zwBGXTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kw39TPhj8wXw20Xopt5UVbJqokf4A2QmpJCyES5sn2k=;
 b=CcxcU3l2KiaLjCfCEUHHuRZSJGbhyuW3NMtxAV2AsFK77+NScqcSjhs44lSWNg+3lPvoK4J4wRGomWpBhpPa07Juv04iLlJZB11/iPmn2+FQ1izW/DIEFTYzwy++BU+NFMDKXkJinIRcgcDZxlQm8sTjMPGV3Nu3drA0sKx/dhAJl5WYnt4RsJj9JYxFgWYYOcsdsolCU9PcZj4HqA2EOeSB9Z7Tkv7JqVyHaPZYxqfqGibkelMPR30s1PdgrDMskpKg+inPLKWpQQ8kKdCrUrcSEIxC3zFbNSkQ5L/fVxGpnVvIgkJkO+ME6ems7AGtH17tZLrTOV78748askzuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw39TPhj8wXw20Xopt5UVbJqokf4A2QmpJCyES5sn2k=;
 b=fP+s3SGnvswgkNPDZwCNALGTqC13IRb8JQCPDMLlMrkOag0OUDMOa3/DMvEhD+/LwYeK320D1vjZdTrmVh5MY233Fai2hYtG665BWcIQvKqVrUJOns0Tbkb+Y04EKOjPqsGmGJEsGIEf1uBxvwMTRm/7yn54oa1/aO8+FtVqgCexl0ebJF00P2nr4khKSWuVBk4q3o72+W0B97057xJM66WlMIePYzpDLPX7dEwY4iOaavPARpKIP+Oy+BIJdhvJ2L6ZqR7gaXwtgS71tlS8wnYbs3dHS++z1dwd9RWEBsSjhl4af2XeoRbwwPZR/7jzIYww8qJ/ESgh3WjNC+VCvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DUZPR04MB9748.eurprd04.prod.outlook.com (2603:10a6:10:4e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 03:43:28 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 03:43:28 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	stern@rowland.harvard.edu
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com
Subject: [PATCH] PM: sleep: core: Set is_prepared to false before checking direct_complete
Date: Tue, 11 Feb 2025 11:44:23 +0800
Message-Id: <20250211034423.833783-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DUZPR04MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de1b769-79e1-4353-fdbc-08dd4a4e3f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RkHmaSjyh7hXvSHN5MY7jn7iHSOq+ad1bCP1RU2x7e5Lx8H3W8CoqC5+Xppm?=
 =?us-ascii?Q?j5Qyqrqcgdmcj0cYQRziak6HthWdermjlOjmWiRogkrxvZg2lJYkiPK/IuLe?=
 =?us-ascii?Q?EDe1oNNCZQje8omohcX3j2LPjcwquUoOu0FRBB0F6y0gelhBOTag1+s4ZK58?=
 =?us-ascii?Q?0LdOLugUFcRIbkEbtr1TXBRrq7/Rb9HeErMNCc+g707uo8Vl6OK6ySY1zkW1?=
 =?us-ascii?Q?fuCj4z5L135tWccv/jUvh6smrlcTYWlDwNd/QKqYSp+JGLlHLMWEKCiDOG16?=
 =?us-ascii?Q?g3uCFDJtw+6TSgp82P3PqTCAyhnrf4D+HElv07U6L8ZRXlUMfDJ8ov7RjbuD?=
 =?us-ascii?Q?gVhbvaARbWzLigj96YUKC0bliu6uKfAhxCPx5FryZfY8x46b07hx5fuwCPzn?=
 =?us-ascii?Q?g4TLhcZHtfWyW/pTWodQgWvowO7hR8dNUXU2JWrkbHR+Btju+JygMVssaIEa?=
 =?us-ascii?Q?ITv93ywyb38N2JKEBTOrRzVYxU7Kstl1yUUF+HGihpJSn6llOgOM9KxnFdlc?=
 =?us-ascii?Q?Ej/AlO1HhJCZJGFTa8FIpG6ybbBHreNtXrHwhvvhR2BKeySLVEPDGoYfZ9/O?=
 =?us-ascii?Q?uVksddAVEYK5Tvp3Lsr2oJFT5MR6sjHagLIvK84D60nEkVr2b4hG+ggRuaBu?=
 =?us-ascii?Q?XJREoDqegRifiKyiNrdqEa3n/Bs2BlL4WrPL7WrnPSDIKgX/PMwsbAiEXSWD?=
 =?us-ascii?Q?cOqyxjHk2XuZ9mmqAupQEwTKwzVC4rsrxUbcG0dbuyiUznTuDMcOfDIXvhXN?=
 =?us-ascii?Q?JQjIpQjo/5va8UqSml2Wivro8d3J7r5VXRP8VBQWadHFOkR992YntLZdMwA+?=
 =?us-ascii?Q?zCdX/n9YWUpVRT3wTp31KSuM4RaryNATDafVd7BVZ9MnHHhTNgdJuIO4hlq5?=
 =?us-ascii?Q?LOyRFPE9DKwk4criVCOO9mruIGRmqi2ANH3RE68hoqbFrqRBzXXlYSi4dOjP?=
 =?us-ascii?Q?WQbgtBCJ3zkRPckaEMRX1zd4SN7AWBm8XMbue8xSOnLTcglKSGCPhOZdSvpf?=
 =?us-ascii?Q?+UMB/MzZX0nsf4mL5zZD1IbL9Cl/TunWZc8hXiCZAl4daMxvgm8Zk97wq47Q?=
 =?us-ascii?Q?0eZ/J7/9s+Kn0wr/fMQxEwmybNihxhdIvmE0hzyF8T1klK1m61+BG12NXJv2?=
 =?us-ascii?Q?2igqiZqscvvSCI/NMxHvwdK8mlaSXDEHLvkiqv8ct4Fdx0iv1pkLS2ygBxde?=
 =?us-ascii?Q?8OZH/0amKorKZRg8HFHGTTo+71TOLW6i49Wp/4k/27Q73nxud1/fwOKyy4tJ?=
 =?us-ascii?Q?BzGl2282AUgsEkZnzvO++OWoOwXfxOcUk1eisCzd3IxyK504NLsHNKnD7ood?=
 =?us-ascii?Q?OOg7F32V1KsIqIL3OdduqMSyD6FwwxtEtSMs5Mz7q124igNos/5X+EKBQXVY?=
 =?us-ascii?Q?ZCGmCLzW5Yj8qAwNG+ukJYhjb6IJxIvrgBmbSFLDg68nZ4nZHzBM7vuSjdYR?=
 =?us-ascii?Q?jPebfAU19psgBYpKL0CaMZwpb27lOD7o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3YyNAl8KPVtJcSpWjZLHTb+qGkYCl6gXzgEwr+DYZM9ixt2sr66s7hRaELcl?=
 =?us-ascii?Q?3r4AAUqC2OfLhJGf1Jgr8S9x4QCViGxi7wM00emb13mXiddTDZpdd9U0b8IN?=
 =?us-ascii?Q?d/onjElagYDmBDJc7pCEw7I8y1roJpy6iXbM53Ln0JKyctPYSSNG0Mbl2mof?=
 =?us-ascii?Q?mSBgFm4M75V7BmHhYPRf+SYkxRMnt6YfOOGbauKS9y3elT0PjHq+vnb7wP7d?=
 =?us-ascii?Q?297Em1Mp6ga4oucum6UjNpNSBiJNB8ykWWUPnTC3b/JIE1eQqwSH9wzI2gW+?=
 =?us-ascii?Q?ezTX5QfcdVbW7cr9x3BSJpqyMrMH/9220eLzpwWVwW//rLPZ9JQhBipx90w5?=
 =?us-ascii?Q?ZPBAv0Zc40oAokACncIjmetivsJb2t/PwLgV6yYOjfYKDQSH+uvfjBmidNt8?=
 =?us-ascii?Q?UOYFcDUVc/zgEXV/peDlRzCeNLetrQNqUI7pMHB/IAVB56kePwkQRyCQrzHI?=
 =?us-ascii?Q?d09n0IZmhQekCNkssMJ8+k87IKDIzsQ/+j5BCLDSQT30TvxJVZLZb9kwsUu2?=
 =?us-ascii?Q?9t7hUyVKPUQy1v7lG/YaGGfXfnaRr1pB/Uru5z47js18zJ+zmYgz7QujA+Qn?=
 =?us-ascii?Q?v+S9o8wMeAeJMyOmeFcgoxGN12NKEXqJK3ULcLrDUTuG+1TA2k4yRZ66VWGE?=
 =?us-ascii?Q?LgP8esXnGwA81Ik6srEHyZQrgKCoEvUwhlxHlVXOtoo0EFHZ+qTetyECYs5I?=
 =?us-ascii?Q?Mw54G2F9mqw8OC6MgIG8tjiXrl0gduE9+9SqfZgpzDFXDwrhk8awyjdx1yUO?=
 =?us-ascii?Q?ScDioQCa+vUpqAdHeHaQc9Mbxv6FQvfiH7FlONvWRxJ6N6i6UW5l/D3+5H+x?=
 =?us-ascii?Q?9HaEAzKN4hMxTawgqROgo9xFJTOufQgCCDCwUmkDJ+Lj4bs+XKVuvw50g3PF?=
 =?us-ascii?Q?2XWC1MxM+6VMN0rbfvyVB7/UWGj3SiT8fipeWPCbEWSStPsIWx42po7aPiww?=
 =?us-ascii?Q?FDtBS2rqs/c6DicMTxee8HGsL77Argwx6mRjxABrVxxS1wvDWlJcNEyqK/O/?=
 =?us-ascii?Q?dCidoD85MGwX/wsWScwD5a1sszd/O0vAU82/5lBM2F+61z9h3hdsiul2WBo8?=
 =?us-ascii?Q?W+hQBww9mdNCLu+RH3Lx0WsyfpEFGzNTMIea/J+h/VBRR+CzbJ3qgtWeD0P1?=
 =?us-ascii?Q?AiYbufgK2HNNSOSJT32zlShAlEAiGVx++btz/loz8GIF4g3GHkWVmu/kuRWG?=
 =?us-ascii?Q?HG+Fr7gkfRi5W8nIoil9puQKo7uEIb2c76z4FGa0VofLfsF5i1TI6WCgUs4h?=
 =?us-ascii?Q?WjqY7Bez+KIE3rIA4yyVgcl9hVogMRyf+WuL8UuvmsP5asp/hu+CMP80TT41?=
 =?us-ascii?Q?ALbuJdE7PAbrAAIWNMzayises0cksJoqDaiVkyc3zAF90sNdBxfnXiaBOG58?=
 =?us-ascii?Q?A1z0LPw4uj7khZhc85uAERBxa4DWB1yN0/i+tLfYwiXzU7FeoiAn2rkdtKjG?=
 =?us-ascii?Q?a9iFTBEiR9jb+Qtt8lTT5rHWVoixnyo/HtrObh5E3BckyRaUGR0wIgMvJB4+?=
 =?us-ascii?Q?DKMI9ARjHgkM3wVW9VJjY0MrKamvrLUdT1yD/VnwQpyXejbS4alMSu4d0/Nf?=
 =?us-ascii?Q?76MR/zwVb5KCSWYH2qs2yv6FP/HZ0tm2gYy/cZ1A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de1b769-79e1-4353-fdbc-08dd4a4e3f27
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 03:43:28.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xgdd/dZsLfvcJg/37e0kHh+hmH/dNiXMQXZEMCQ0o2JcyTqJYnFlBCFz1OTpo0dPImS7BX9PDc+x/A5a4ClxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9748

Currently, if power.no_callbacks is true for a device, device_prepare()
will also set power.direct_complete to true. When device_resume() check
power.direct_complete, setting power.is_prepared will be skipped if it
can directly complete. This will cause a warning when add new devices
during resume() stage.

Although power.is_prepared should be cleared in complete() state, commit
(f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
clear it in earlier resume() stage. However, we need set is_prepared to
false before checking direct_complete after including direct complete
support.

Take USB as example:
The usb_interface is such a device which setting power.no_callbacks to
true. Then if the user call usb_set_interface() during resume() stage,
the kernel will print below warning since the system will create and
add ep devices.

[  186.461414] usb 1-1: reset high-speed USB device number 3 using ci_hdrc
[  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
[  187.105010] PM: resume devices took 0.936 seconds

Fixes: aae4518b3124 ("PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily")
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/base/power/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 40e1d8d8a589..69d0f9ca7051 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -929,6 +929,12 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
+	/*
+	 * This is a fib.  But we'll allow new children to be added below
+	 * a resumed device, even if the device hasn't been completed yet.
+	 */
+	dev->power.is_prepared = false;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in device_suspend(). */
 		pm_runtime_enable(dev);
@@ -941,12 +947,6 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 
-	/*
-	 * This is a fib.  But we'll allow new children to be added below
-	 * a resumed device, even if the device hasn't been completed yet.
-	 */
-	dev->power.is_prepared = false;
-
 	if (!dev->power.is_suspended)
 		goto Unlock;
 
-- 
2.34.1


