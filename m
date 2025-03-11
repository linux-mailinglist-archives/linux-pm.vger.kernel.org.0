Return-Path: <linux-pm+bounces-23826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CF5A5BAE4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 09:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00721893105
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81A1EB19A;
	Tue, 11 Mar 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XgRX8aH+"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5F1E9B20;
	Tue, 11 Mar 2025 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682040; cv=fail; b=jQbdteieRKMLVNEx2lKIniz1HNcjcWH07ehbVGRdYSlsnBP1Sel5yCZTGtHThYamEUTv9bPmrk3HvCd5DWDJPYzJsXO99uWu+tyNFOkkfkvkHHIIfZ2cNHSxtjA1F9Ee3m4F2hTb5zsL9yxZWT1T7svSsUWkqZMP8qAdUzubTjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682040; c=relaxed/simple;
	bh=91DkZjieoVlUP5qjRq/F2jKr0eOd7R9iup0NcH6vyHo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MDupDGE7HgNHIajZadyXw7gKSuOiyfRMprUwawks7HWTx2eSUcDsgGwQ09H/Hz37fuk90I3LBTE4jhcEK1KbFxBQRUIqpeOH3Es6NUsGMDYoKnIQDEp4tHkJRyzqBEc1bYhC6jmAfQJ0paSgNBC1Tvgz8A4aoE16WwM1RNRAmb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XgRX8aH+; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDFFk1ji4p9LqTgpQoCMULKjFF+dwQKSXg1u7dAXabwfIwIDL+AkfovAKBE3YNP4xiaPy7ncXjixZg9OgctS184vhFeR0sUb4YT7v+OshpX1bQN1UxcqFKYFR9Ek9qQQmeAfSIisP4Y0oxrMunfg6DWSua+wISMXGKxrTPt9cDm599K7bC5m5Xe33aDJOPsueIICV25ANaR8Mv05/Qe21AS90DVUEMIuXP36P4iCPtDCfW9hiZmPDrAk/yR/VDej/ZTQNMv0h1+XEWKhO+C1llruM6/HoIyYfjkXpsGIczbtS+s6i1iO2xOUbKouECaEKeppuqCYWD9E2ICsUbl2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hycVQbR1FiuKVoQLUz0k00wmE+MiSgSGdFF5H+fMfbA=;
 b=wdAnpJNHBMnTDiutLJd9+TBGtDR49WKhSDs5yy4sFwDaLbmQqYEj6uvvaDw2VpkvkwVrw6Za967wUOK89SrdQ5tDyhHWgg8pfJeFZGVDGGt2Pjh507PCkM0WQ+VJ9mRNJ5C01VoPrIe4C0aXrrItb1gOCrY4VL40XR+WA5BFfGZbn+pTBG6xzq4hxOR665kh8V0KqsrUTNEQs4GacbI+Up03l/Evah4gxQCH/fkX+3tCzZ4ws2rSPNBlDZgFi6Ye7Su/dq191QYbaiAHmJeesPe+Xfm/NMdu6lKVIo1ABEAJoe4038JXerrGy7V+eYlgG1CjQTLbA1ThvkQPYUnTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hycVQbR1FiuKVoQLUz0k00wmE+MiSgSGdFF5H+fMfbA=;
 b=XgRX8aH+0i/uNPwlpp9PK7AwMOgEV3SAipDcvIy0V28JsaVdxDtaEz9Qj8EiyVf2oli48EIBlQD8esMdBp7GYL9X/QTMFrmSWjHqZKprOwdddXrRUDWHfIEOB9XrrWyFxaMOVHqBo+znz7d66K3V6VYJU7wUBkhiQwhH4BAJTq0wkV03cylzeGSuUDRD0Z+Ev5xs3MVIkp+IdHsoMNTAnR/rh/B1/yVnxe55AgAgEYT6ccQndlrSosoMUqK+DOC9KIP5G1ipun1Lv3R+x+7mCo2b33Vl8uY41fyyWQjefJJuhzV9t33WM0+5e4LtaPQqYTDCiRhcfQ3usCN63Gyxhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10521.eurprd04.prod.outlook.com (2603:10a6:150:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 08:33:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 08:33:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: ulf.hansson@linaro.org,
	rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com,
	vincent.guittot@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pmdomain: core: Introduce device_set/get_out_band_wakeup()
Date: Tue, 11 Mar 2025 16:32:39 +0800
Message-Id: <20250311083239.3336439-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10521:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ee39d4-05fb-4423-84bc-08dd607772a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gmcqpaanZeJs5Sf3bNRzb57NwiK1OoOd9TXgyBy9eyW46WwdzcoFuMrRe5+K?=
 =?us-ascii?Q?Q9XC2YJMQlsfwI87z8YNp2Nd+zG1P8rlzyzAaI5DJz+3NN+gqYMX3OA7rsht?=
 =?us-ascii?Q?75IBt2jahQYrluQWnksDB3spUzTRYYZcoKkdX6iz7jcc57ERzScVMVlKKMEs?=
 =?us-ascii?Q?11lsgWuap+Jef2+dcrN0bYwutLffQRBsc0CuQBw2hK2lOVYvaW8LS3m/FrIZ?=
 =?us-ascii?Q?tTrpaGz3EgZZ8gYWVcVqtN7J+B1UChuaQ1fkAqw/2ei1OIiodq7EAJti/4a9?=
 =?us-ascii?Q?ZmkfjDm9okUOgDuueHFCYhtphQSXMwmbrnr7NdHZn6W5Bm8m587m1E42h+82?=
 =?us-ascii?Q?lH1oY2igG1v+yLmlBOI3L+DmfOzABy9/yD1aAYN8SA11VJLF1GNMWJLWCCOL?=
 =?us-ascii?Q?OkxbMii7s8/02u2QOP3Ju4GGlqGV//+BO/uhj1liOqzByZU/rWjcJWJs3xPD?=
 =?us-ascii?Q?ehch6Z/QsFcr70ojSTHtlhvkIhSv7cTP94VVCnJGLZwzZKUwBS8eLzdtEl1d?=
 =?us-ascii?Q?ggBOvkwvvIogh+VFSoR7Ezt/o/eqYRJvbRsnMkSfJWGa3R6vj1eJEOBSl37N?=
 =?us-ascii?Q?ASOd9ZsqXcGahcCAetou2qPRgZP2YWK3NsbPv98/BAlsDBGyCPKX2bbNgGWH?=
 =?us-ascii?Q?m2NDgxzSlJGzims4I4DFe5AGfg0OaKvsmAuzLC1CEqXDjoPcy+hR+fzcuyAY?=
 =?us-ascii?Q?S1i8Fqfbms93GBT4uV2iQgC4nVvDWEZ1XoiR4a4Ox0jnKCy/jccsJ6BQDED0?=
 =?us-ascii?Q?nq6VJHwPh7AJytSfIbPyD43irYwLXP6pc4v4+Xu4vEuTcBjJT9Jja4HzeqHF?=
 =?us-ascii?Q?v5nFulhTl58cho/ujKNEGMGAp3InAM4DdmYHV/BJj/MN7KeMiWnaoMQo0G1p?=
 =?us-ascii?Q?gfAVfAnG7Eb3RGlu6b9G49go5NXIQjQaSzo1FvmlVfKvW4D8uFgAjrpTMOCa?=
 =?us-ascii?Q?OhFovX7j6i9/ldQZSzVibDBGmwrAn7Nlg+U6TbZGjn5sp315tlWxTEvWUJXW?=
 =?us-ascii?Q?HlR61sPdZ0cZ41VOxBV/pgjVumg6nRCTaleVwO/JFM44nhz4wk3oZr4DJDJV?=
 =?us-ascii?Q?SKdir8aHStIUouqFq/OcEKDGrhDAmgPFsGOl/f7bVlv6LnZXj7kQH/lvc7Jr?=
 =?us-ascii?Q?kFzAaJk59+/00ks4IpscEoQawKsF58h0sUXb8XYJCTYXHOlH3+vbZ77UKIie?=
 =?us-ascii?Q?+rbiWZUks4gX+aZGppCZrynYc3jK38oTxSvmzDa+Nhk7s7MNX1q1p29XkP6F?=
 =?us-ascii?Q?iNnYaQ5geceXDziKvvQQgs5xjeYJufhBxTKhzyNhW9R20RPmDB50RMZlrhG0?=
 =?us-ascii?Q?EKYYOja2nlqthC9ko5UG7ZtB7JuEHNr7TfvOnahXONfbH0bIyds0YLBKA6d+?=
 =?us-ascii?Q?xV0rrCia+Ol4vVgQpgxsKo27Z58Wz263TISMGiAcOpcxJ7yq4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tmW6wH1sm+RSr3BICEvtMmODDLRBxbjIeaifejmuvJ0XgJAbjGE66ptxfEl+?=
 =?us-ascii?Q?EHHkG2XEQIFBuWgrmzOyvsok9hQ9wRAXezeXDTfnU4lSvR+WcZNvM7J29ua/?=
 =?us-ascii?Q?UQed3pTsjjeXPTE/HGxbBL5as+rGEAzF1YS0hDTouvh2EJHaY++DVeehEv5C?=
 =?us-ascii?Q?aqMAqCYYPQubXbjY4kzK1GOzp0PQjj1FG/0dXlA7Yz+NQYTZcAVjFI2ujW47?=
 =?us-ascii?Q?UNt/DJI9tE3eKA9L/ctY2Jnqj8Lz+LUCpbVWcx9CLWKAd4V7USwH9Za/kd7B?=
 =?us-ascii?Q?jjZuKGUkTWiROywGGz/sTMQt7KtjrpHLovhWEduwpDhIEY7kpLC/z/seCs0j?=
 =?us-ascii?Q?SlyJWBwYaQMJUQ4vucQM/lwDL5J4lyu7N19H8x3eIW4nhwSeCU9gvp8DohZ+?=
 =?us-ascii?Q?nRK9N+yVFkhYFktsQQ8GP23gvbgRmEbcvW55H5qQ2igSx2s564RWGWB/fN8A?=
 =?us-ascii?Q?7ln2CA88iYhNixbNuemPAZZWWmn87iqX7DtS3eJ75temKk4Octf3UcHBfL7f?=
 =?us-ascii?Q?o8Nx/r07bkSn72MKHPEpZKF1eHwKFyB3zTyx3oobGCR1wmx3XD6rJiVz3hfU?=
 =?us-ascii?Q?4P5hyAJBGbl8U6ZzWWuG6K2NX3wE9iAUyLEGiq0NkmdEBXxWeC+LobZMu97K?=
 =?us-ascii?Q?hrkwP4Ojtvn4lxDhiOpoCpTbwHomtLJ4jnYGwOX93R7sOINroRmi6c45rKgh?=
 =?us-ascii?Q?leyAtxkdez+BvhvzwMmhnugJ6J5RKkdTY2pXA2k4LwErS6LOP7X7lGSLlmv4?=
 =?us-ascii?Q?+0XfXnVHPVU1kGAROGK3SFOIJ8yKT0GU79StMcqeX1kFg0jBl3JRQckzCt8K?=
 =?us-ascii?Q?XaED9MMHrlfuGP8QoF0KPO7xzzWYXXZtqi3ZNrUnJ0lvsDKO0OXtYRWFSPXA?=
 =?us-ascii?Q?UaLwnXXR1wNFFzrBEr5fBn3sQ8Xpxbd02bBvp+0/Rxcx201MmIFzpUfB1l2D?=
 =?us-ascii?Q?nXkzIzR4eWvz3/BYhPKMGKS2YDv9uUSryIMMUxLg2YVYKEkkmpG1mGrwB91d?=
 =?us-ascii?Q?9XorePfE6IV/BYtxjK3USEbF7JTNGBHVpYXfaKtpi2q4tVa3li6bq7tdbNsw?=
 =?us-ascii?Q?qUjjtJ1JeJPcUThl/zIS7LLGWTLT83BXFelmRw2frpZRVRD6EAaxrtY2nV8l?=
 =?us-ascii?Q?VgRTp2gU5nGloLTJvqE79rIS601AfHeSXF2RlJBKzMNiuq8i/Qc4ee44UTif?=
 =?us-ascii?Q?fY/jKcuyvE1bLvw+iXgchjzqmnHhvLKpn8FwlcGVs29iLLOmRHEuSwsT1DS4?=
 =?us-ascii?Q?05ub/Yd3gvAGWVYcJ7QbFe3P/iPADuITIxDYvQeK9X/qQKeBkkbgXIlaUQCv?=
 =?us-ascii?Q?Q9c7q6LUCtRrMc9VtAHdfOECZhHnutqyOKX77MQcJRyk4RPIQ8Jdv7/EyY8q?=
 =?us-ascii?Q?HzA6PnD8K2IUtfNK7CI7oo28wvzeVZpDLix68uq7x9AnZdjQ9vfI9G/IS7EH?=
 =?us-ascii?Q?KQT6ElTqs/Dk5nBVtf0Xvby9J/89W+ViAd7lTV6FSfva6P03QSdqYXhLU673?=
 =?us-ascii?Q?l0jIosjoXnA1b4xzZ0DcuA3R4lrMx/thIaELjsezHsTE6Br/sv+Y6c8t73FD?=
 =?us-ascii?Q?EohNwiC8LbAwhbcO2KBRuDAiqfh/VyKtk9F1QI8M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ee39d4-05fb-4423-84bc-08dd607772a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 08:33:50.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtDIRjhXp+s1ct23OH0fYsTAyndhv1PydJEqcRoUfO/vj/zaSUDTyK1CTwEHsq31A2N9Tte9VpPuxmkj6Vrjaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10521

From: Peng Fan <peng.fan@nxp.com>

For some cases, a device could still wakeup the system even if its power
domain is in off state, because the device's wakeup hardware logic is
in an always-on domain.

To support this case, introduce device_set/get_out_band_wakeup() to
allow device drivers to control the behaviour in genpd for a device
that is attached to it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 More discussion:
 https://lore.kernel.org/arm-scmi/20250218162045.GA15753@nxa18884-linux/T/#me83f18f001e0db51860c53d0979f1ac8deb10a12
 With "device_set_out_band_wakeup(dev, true);" in probe of driver
 drivers/usb/dwc3/dwc3-imx8mp.c, when USB power domain is in off state,
 usb could still wakeup the system.

 drivers/pmdomain/core.c   |  6 ++++--
 include/linux/pm.h        |  1 +
 include/linux/pm_wakeup.h | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 9b2f28b34bb5..fa0d93c9078e 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1450,7 +1450,8 @@ static int genpd_finish_suspend(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd) &&
+	    !device_get_out_band_wakeup(dev))
 		return 0;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1505,7 +1506,8 @@ static int genpd_finish_resume(struct device *dev,
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd) &&
+	    !device_get_out_band_wakeup(dev))
 		return resume_noirq(dev);
 
 	genpd_lock(genpd);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 63a8dffda787..2c1dd35c3e19 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -683,6 +683,7 @@ struct dev_pm_info {
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
+	bool			out_band_wakeup:1;
 #else
 	bool			should_wakeup:1;
 #endif
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 51e0e8dd5f9e..8dee27c34c3c 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -94,6 +94,16 @@ static inline void device_set_wakeup_path(struct device *dev)
 	dev->power.wakeup_path = true;
 }
 
+static inline void device_set_out_band_wakeup(struct device *dev, bool capable)
+{
+	dev->power.out_band_wakeup = capable;
+}
+
+static inline bool device_get_out_band_wakeup(struct device *dev)
+{
+	return dev->power.out_band_wakeup;
+}
+
 /* drivers/base/power/wakeup.c */
 extern struct wakeup_source *wakeup_source_create(const char *name);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
@@ -177,6 +187,13 @@ static inline bool device_wakeup_path(struct device *dev)
 
 static inline void device_set_wakeup_path(struct device *dev) {}
 
+static inline void device_set_out_band_wakeup(struct device *dev, bool capable) {}
+
+static inline bool device_get_out_band_wakeup(struct device *dev)
+{
+	return false;
+}
+
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}
 
 static inline void pm_stay_awake(struct device *dev) {}
-- 
2.37.1


