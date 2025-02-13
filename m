Return-Path: <linux-pm+bounces-22006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DAAA33D1A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 11:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3287716587C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CDF2135DD;
	Thu, 13 Feb 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="epejZP03"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758A2135CA
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444302; cv=fail; b=alpjXCKsVWw8qES9+x8AZHQE25MfuFHphUiSCn+qILrwOu2UUTdSikGSNQ5F8qNq2L0gWBm9Gr5qUk4XBsSL9Ft66SSslG2uAtraIYHpegjk0PR3NmPXdIaUc/mLYh27x7utfzSY9D6gHB3vSo6MSjQpZhsyIFNcrkE/dUYJYF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444302; c=relaxed/simple;
	bh=8pJymemrWfW8SjK6vC7XQ2J37R6hcDnHT3i+Eo8BxAE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Iz6fQLQrbZg6fGNqxlPIz3rqGFLPPAyIFNRdmbXpJYwLyMPfIuTIlplQf27AOImqUlgTSVs3JjFM6zm5AzF8Vt+KUDVwyIS766XF7Mt4+cuGPhK0BQi41Nbr7NXVabvqyUb/ycUkxSwcz/1v8bMGXGg261XsOZxJMKcUUXaBuso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=epejZP03; arc=fail smtp.client-ip=40.107.247.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyGiL4V7A3ItIeBvQcyH8fThg7vt9jzTs2jyHqJHC9OB8pRYUtwglrFlVrSBebVOIEPATczTirAab7+ibFReZLN/eXNeVaxCwBRh5qmRgrzNBbqWqhrvJsUjPYbAKnWoq89a6H8T1wXeXWm7lQcC5npB5jvRfs/E52NuG7qZtiN6I4VpYCEfj7mZt3mlX8Nk7OPGKDl+9z5/pcfud5Ki8oQZHGnCpUqCaczTvvFBjUmPDBpQyBfEhoS8FBOjOpxxYi119J21VOzeP8zWKRCU8ORZCD2LhgkFB4L39QStVGHsAvw8TxhqRYzA7W5px+KAoKe8MamozoxWcmx9VcNxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFiA2F1xHPi3tKar+v56zeNlO7+JzmwB9qQR2WEqGsY=;
 b=B5bYlXP2FQy3M2yLfY34NVHGqY+y6b+edVfm9X/y+OIHoBDmwMkA60wlSdFW8BVpDSjpwnYT0ytSjkUYNAJbmbQiGKLMUQZ3Cq+CghuGDnppauJejui9CMqH4y859JTByJ7aFBhAqhbA3UyEi6ucdqKXzgrsEL1xp/J5nHM4B8ffcz3jKkO/TXAMmeMqwouaN28j0/iJW2VsEr3c4DY6SoO7PUzsTouk+mQKh84xg9lNQcmOx33uV/f4bJmsXsFG9gpnp2SU2n8ZTQVUi57BusAa7FsSn9VkmBFW4/LoHWoT4ncFjPaOijAylGUR8LUx8uaWf9JJOZWm3WEeuFP4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFiA2F1xHPi3tKar+v56zeNlO7+JzmwB9qQR2WEqGsY=;
 b=epejZP03+N6t4w3UrR0QMxPu/s1TCn14b/NPhD9EcdDQrIzxq21XLGjH1ZAJmYZco3VZf2qlU7cvanvqWc99gV86LOobSmI81a4zEJpuv4hjDUmeKhQNOyoz6Ip4NGr6tfd1oS+/oPWXm4x+RK1Z9GzKHQMmGQoW6dEZXEwLxZoQuCru56d3gBjfJhf0kaCCN9zeJIVW0Ip3308ftY2KqdjFZWwdq4tTLukOlX+s552XxQA9kbrS0ndM419i1pUGpDxwbUHh4n6qc6ypfkfgKLF9quizYvcBRULuuOYEYYhlp1DgCYAXLW5NVZXjQzy1R/0NuCb1/09iuibWUMAUSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS4PR04MB9575.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Thu, 13 Feb
 2025 10:58:16 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 10:58:16 +0000
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
Subject: [PATCH v2] PM: sleep: core: Clear is_prepared if no_pm_callbacks is true before checking power.syscore
Date: Thu, 13 Feb 2025 18:58:40 +0800
Message-Id: <20250213105840.2864654-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS4PR04MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d98c22-5c8c-484e-0df0-08dd4c1d517e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6tkL6jHoM+LrRM6bgcPW1Qd/bOc1tci/HUxxDG6ee5LjrJf96CxMJqynLLCG?=
 =?us-ascii?Q?6WrivW8JK/UcfkuI7IaARnJPmNUGIrtIKWojm9tEEB7pncTQpa7JE59lishT?=
 =?us-ascii?Q?w8lRE3wlVrEmE3a6q47LEgtM5AGyfkx1RcK3zniktaSlx8afcgKsTS8Klwkg?=
 =?us-ascii?Q?KBb+JjHOcHxILW/xGYvCJ4U0lDcmciJKKvAuXFIFieW1n0WqvfaokwTOoBed?=
 =?us-ascii?Q?X8r/HC+ckndV5p9CoimPYBIv2W+Vi/R1GSSg9w5QItOoVwWLZap056x+JI0J?=
 =?us-ascii?Q?8TZ2rpj8MKyddnV/S7yOgwe9IqItfY6a1eYuIQSxEWYktlTLnaN19Bn5NlSh?=
 =?us-ascii?Q?rF6u9iUme03x/CJrC5Mv4kXoTGmNzWbpAfSAIDCRBd9deFxkMVEvdI2to6de?=
 =?us-ascii?Q?NeZvKxIKGc4t3T9fQCCRCqKWLhZPcLudF4VMcLP50GuLnXDTNVWZ+d/YV3WH?=
 =?us-ascii?Q?RIKYD01ph3n0kl+UuBfzupqgYAfC4jHw8GMDxANiHXIdzFw5Q2YBRfjY697a?=
 =?us-ascii?Q?h8l/wnSM9jTBT1SctA/8k3mRLde8RTvKnLAVV/o5Z/FNOqKoQYSHxE0AfIlY?=
 =?us-ascii?Q?CFMrLmtGyBoyoMn8cSNh8OGWZmTqfluSSOx9NXcG+eR10UWqJiUH54oTsizj?=
 =?us-ascii?Q?IWBLRfB8Hq/4+rEJW7W6JjGY+yspVrsUTy1kZbpzCIN6j7yMirm3QlcaR+16?=
 =?us-ascii?Q?eTZ0fjqsaoDxuXOeFK2qyWZul/MdCHOlRD9lo8TERk9aDwx0Y2RK5IdbfUl2?=
 =?us-ascii?Q?0l078phnMZCUGdvcsGgIFu/NeAYCx9Bk2uea7eQkWtny3Bmt3yI+0iAG3+Bt?=
 =?us-ascii?Q?4KQ1poV7N1wJGUEOecRT5bfhzRA81tqLNUc6uZqI50G+CGJZk6jNT35YmEHZ?=
 =?us-ascii?Q?16Jl2Poa9S09SCuYVtPHh8GvXP/z15OUbCaA6asNC1S/WV6Vw4+4jeZ6A0i2?=
 =?us-ascii?Q?bpjldlC5J/ku6VsdROTjN7LnANBnYMW/oUyyodokqwHz2Hq5ZtL63jbIIQMk?=
 =?us-ascii?Q?7kHT5axROU2E4chEcJFchUL6P8DsgmUWYW0VlC5CkRkpotUMdLlous1G/V5f?=
 =?us-ascii?Q?4xm0qSgSAy4iLxm/QgAZG+MypCrhZj/9IRifl/yVB4seRsxgiHr4EA5NsjiS?=
 =?us-ascii?Q?Eb7nt/1YeTyJk3ruwVRbHV880xi1Qz/FCEuQYJHd+4tXEZMQrli/CxQ176iV?=
 =?us-ascii?Q?DgQ2/irK3l4BVnIH2Qzgp/9OzjXQvTQimAsyK5qms+dR1bNdmtJ+5s7rihir?=
 =?us-ascii?Q?dTpE4yso++wYlSk+wbII1MMqhWqth/FbyLUXnY4zA3SD1oN9KXDnP5LqQ5Zo?=
 =?us-ascii?Q?C1WibrxpkPUrC34o2cViWMsoL+5f2EIgxg/8B0oWIJa0Hw8B4ov2Wy2KjCms?=
 =?us-ascii?Q?bLMd/MLHJibAE75vjBAPCiIPbPkN4uhNhVvLsTGWZz6/iNmNqbLXDi2uv20R?=
 =?us-ascii?Q?HIDKncgUK5JKpTS4lHcIzQFn8s3ojVyn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dyzjnItY5lCa2EoiUhK6opsDLMH0Y/Az3QGUbAoEBnIBD1KYxzwhDBNyJouP?=
 =?us-ascii?Q?LhZwRc8SOGb8aVuIWVlNLetonK2ZlklwsRwr04RFNzE2QyOwSiQwY0IhvW1v?=
 =?us-ascii?Q?V9jGCqZKsoN/8EKRg6xnKM4kOr4Fm1dvoT3lbVe+UYlIAbr8bWG4mJ/1jnrr?=
 =?us-ascii?Q?d0bvFeqeljnBzP9CUtpO8y+driZZ45eDBuOPmVYV+DrWMHxMJinMvCpFhONs?=
 =?us-ascii?Q?j7FwPkNDf00D0Qfi68QQh14kYnPLS/292SR2tDLzm9Km873od81ww70MnzNe?=
 =?us-ascii?Q?Oym428JdDNJoHLIyYM+cvfeBONCK3CqFjA1CM5aNQU3nH8ffLRNJ5NZvcdZp?=
 =?us-ascii?Q?4Vf1AWx4vfiMTOyVAiQyLZVaznNxFDxHFqwdDU3Fc46ZM70SBT/8N0Q6fDbi?=
 =?us-ascii?Q?tBOmrvmvZ7zQTODCJ2R0x6bVWYK1xvE0kaHYplkQ2bxjaPSZQpuzVEL6Xviy?=
 =?us-ascii?Q?QsZXG9L9VTPr3H5MwBnQDv3IzyluYaqHDgG1mJo4maobsM92Ris94C3weQvF?=
 =?us-ascii?Q?W7OYhJA5zzw1vP/OpWhwaUWnRuNtsxc4R7ZQWftJcDI3FQXJmXTOQZWqpadG?=
 =?us-ascii?Q?8hF6tkzoKKC/DEHYGyVKJlpqPOAyEKeOHNTbqnZSxI2jqm1JB1KnRjZ08iwT?=
 =?us-ascii?Q?DebBxdpQgQSTnztqNePRvVtuBeXg0qAaezEDkRowx5wyoGnBYSku7NiVDmfo?=
 =?us-ascii?Q?OBjHA/IQRccyaFfehit0OhJrMqG4wSTJkT7vTz8vEtun7ZmIzsyZ/H5yKwZW?=
 =?us-ascii?Q?svXn4B8UnrPA+z9NzmY29GvXNGFt2Hxtw0tEAJiEWiCBfmPWUfRSENau0KSx?=
 =?us-ascii?Q?zEKL2pREmJPCjFducTMzzMKsTnMH3mn+0Y/N7n9kUiNRhdVtl23AhGigZoUY?=
 =?us-ascii?Q?YUhTYPfsYpxbPnayiXzGnPb6sd3ePQq5nnGQYUJez0jBExpUXyD5gzpk4mgq?=
 =?us-ascii?Q?KAVKa5mRQ715UfC7T6gqePhcwm6VXu4UMIKtGLrvGCszGcA4rzeJHICm2w6x?=
 =?us-ascii?Q?9hgWgIDVFL2/kUKsex2NObkKz84EecbFRNb1Wngsyvx2zoduZ56YOCXGvY1V?=
 =?us-ascii?Q?9La94t75aDyAIHTvCrBTMe+DWMzZvAaFDCAvbqzxzP5U6RPtQ+40ttUwuzNC?=
 =?us-ascii?Q?k5D+W2iM5R7tnRzF+jIPELm7wXjx3XA+VYzzYbnM7YoKmMu5E205HzwLsgRz?=
 =?us-ascii?Q?IyHNZy0M72/McVzCULUbFProqvt7DK0PBxYjUNEaYayXCx7EM40/7UTgwsVJ?=
 =?us-ascii?Q?WU1pFluwyb1jp1H1M4SvuLegGo/HMww2zGLBGYGkwQEgFk43YnnH4m3d0RKY?=
 =?us-ascii?Q?XawJIVDJ4dZ01x4+Jt3ctdon8zulgRv4Z4gaTfUhdX4+Wqe7Owp8ta3Z5g0V?=
 =?us-ascii?Q?y5EgvWT7hzPblnOnT0phU/+MmOFgfiH28BydbuoYTJ31xrQEYq29WxwFWPvj?=
 =?us-ascii?Q?fxrz2F85mZdaZ5HCtmLcdtzuCwgzgvfBhBLw8ky3CiYu+647JwyD5IrIjFi0?=
 =?us-ascii?Q?vxGdUSbC2aXAo1zt4FhLqkif/zkEGmmXWXrRJxs515kjAXRjHQby9wVm6gQU?=
 =?us-ascii?Q?uIRaMFFWyxKAGq5MxOvkwbQeVbsjBcwFPXzNxrci?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d98c22-5c8c-484e-0df0-08dd4c1d517e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:58:16.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m9LiP5PXrdrw+G6zlLa0EvJvx7K1kKOVWLdnxqOfR0jRtvjROb8lJi3ZOlC4Gqm4CyimqneGUbXTdFb4tymUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9575

Currently, if power.no_callbacks is true for a device, device_prepare()
will also set power.direct_complete to true. When device_resume() check
power.direct_complete, setting power.is_prepared will be skipped if it
can directly complete. This will cause a warning when add new devices
during resume() stage.

Although power.is_prepared should be cleared in complete() state, commit
(f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
clear it in earlier resume() stage. However, we need also set is_prepared
to false before checking syscore if the device has no pm callbacks.

Take USB as example:
The usb_interface is such a device which setting power.no_callbacks to
true. Then if the user call usb_set_interface() during resume() stage,
the kernel will print below warning since the system will create and
add ep devices.

[  186.461414] usb 1-1: reset high-speed USB device number 3 using ci_hdrc
[  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
[  187.105010] PM: resume devices took 0.936 seconds

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
v2: clear is_prepared before check syscore as suggested by Rafael
---
 drivers/base/power/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 40e1d8d8a589..5e69cfaec661 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -926,6 +926,9 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
 
+	if (dev->power.no_pm_callbacks)
+		dev->power.is_prepared = false;
+
 	if (dev->power.syscore)
 		goto Complete;
 
-- 
2.34.1


