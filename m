Return-Path: <linux-pm+bounces-40926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90249D24B87
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 14:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7595F30CDE72
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529539E6D3;
	Thu, 15 Jan 2026 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NjLmqeTW";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="HwWN3LUD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DBD35E552;
	Thu, 15 Jan 2026 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483129; cv=fail; b=NTk/4T71LTMoiMxGSvBtdpGfG2mnKjM3iIGCf2kit4r3Sw1LxWcXKkZJpwSm5jyC7F3ZTy4ZCyFHQ0fLqLFT/FEgU5SK2v0UBd9xQIbjzyaQG/aMv8QU+EK61+TBLzb6vFW7JW+yVMXFn+Sm0DR+6s9PRrFb9j7U+7tkteHaqhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483129; c=relaxed/simple;
	bh=IGTymRLT9WMcMohOVMNsjXbC+PJBjJ0STzmwNZQk0ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ONPoBuvKKHnwYWP0A1ZUCS+4t8ryTR+60zOprnCuf70tXzX7B7wf8A6JLzerdb2HdvnJhrwjSdI8Aben1izl6kp3pTGsflt1Rfp/eRqbPL7jq3k3H2C6SpesZewpz+IU9eQxk1C3SDA+WMYfErIog1Bojv9K0nja5gAxzxs3M0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NjLmqeTW; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=HwWN3LUD; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60F5fBXJ1686043;
	Thu, 15 Jan 2026 07:17:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=KqR46/NFHkFAx9so
	Nk1zxhCCrg0TpXOit60nzOFzL4I=; b=NjLmqeTWKLPUpsIG4c+G1c6hP2qqgidg
	9HFKyeMcG1jy7w0euhR6FOilpO/WePlF/Wxy37Ph/4R4vE0gnGrYYlngjI9NwCdI
	gKTmD9AC9Iw7qqwbb9Voo1INU5tdSPMjHyhRzpElLuYiQP9XHriZmXRR9ke2pS3Y
	pPJ/CR96KrECBXLtbLhS7T8MotyA69dM/w14V5PaY+6iOZaQ/GbDlagZXmv5QmY4
	rxqhuRPi6a0yTCCnLSlUwr8tnuql4Y5EPBd2XDBmShV3BlblJHf+DTr5VebgsinT
	Ap3xPelXbhMwqDg16GoGumPKaY+rOvDNJvAEk/ayh6sxYHD0wU5FLA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020139.outbound.protection.outlook.com [52.101.46.139])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4bkm2n5uqe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 07:17:40 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvHug8iNoXgqD3Vgbck3jijfvqjzv2Y7rup7jS7Emq9iqyzj5ABicQQGxcXfUjBrK0vFFmizNLBbhnr1JdCC9L1tuiohCgoDbn7Ua3UHrgVycKkul9fKF5HTlXS0hG2fJHME4BvFFB4Cd9kxzG7ZqoRFgEt5f7wzdxjfo8tckGvIbhMuPKmfYNuVJ5NCdNR9xrg5NiNFh+Hnuw7x67gLnggUOmf4AvbYqwMpVd1e+HtNEVMHHNCDE+65VRKaCQNMDcGSPqMGeMEPhsQYPkaKQ4uf1j0KBumz2F20AtBcguvCcKjYv/rxD378Q8K9pc+Q1rcS4mE+qKvwvJakfl29zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqR46/NFHkFAx9soNk1zxhCCrg0TpXOit60nzOFzL4I=;
 b=KfPtflB6B9yip84fvmgq9Mr7yaHXF1LlsYYihC/qUqj4l9/mFFAX7xBP3Cn5ocG57vf8zV9mdlYx1NaRd6Y0RVfWEiowEQWAQzb0iDAjSSnNsNe2v3/Rpvkr9pu0R25P0A9xx7rtHxqS80VA5q5NMbAlOF65dv92fuijSpw2ZmgqYRJ1OXd1r+FBLKk5jTrfbGDm6RjmBAOUX/Xe0Vh8QJb/oqsGpX+wGSzHHlpv90bGlWklBqpXsx9sXZDTh3QNGLBzv1gxT360oEc5fWX/5o+BXzy0T1WdvKWL7P+HaLUovAz9Yw1kvIcgOk3nZfjlVjHhM2RF9GGk02qr+a7p8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqR46/NFHkFAx9soNk1zxhCCrg0TpXOit60nzOFzL4I=;
 b=HwWN3LUDBCaVLlfIitEEvUbTS0JfW/knuQBg8m0oGxRExg6xTudzbeETBUwrJZe8LhdTYx0ud524/jD1ZIePvmRZAWMQOyTvV0yUXXPLMpppXjd0a/mW1XaJxl1tfeJ7+5ZfCmOqhicMY4lLW0Yudt6K6gC2FlzXdL+T4SgkUuo=
Received: from SJ0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:a03:3a0::26)
 by SJ0PR19MB6891.namprd19.prod.outlook.com (2603:10b6:a03:448::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 13:17:36 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::4a) by SJ0PR03CA0261.outlook.office365.com
 (2603:10b6:a03:3a0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 13:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 13:17:36 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B9B6D40654E;
	Thu, 15 Jan 2026 13:17:34 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 9E1E2820247;
	Thu, 15 Jan 2026 13:17:34 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH] ASoC: SDCA: Add NO_DIRECT_COMPLETE flag to class driver
Date: Thu, 15 Jan 2026 13:17:26 +0000
Message-ID: <20260115131727.373738-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SJ0PR19MB6891:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 27cbe808-e0bd-4030-52ba-08de5438736f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|61400799027|54012099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sLO3rdbh5x9licMbicixRUZQ5eZK6nCjsFNwv9GUNq1HaMugmalX0N1RFMmr?=
 =?us-ascii?Q?Zu++ozk+V70Ygb8RHsnPn4E8/84TGnyYaXUo51JilTIOlR0dd9KZqXPUMfuj?=
 =?us-ascii?Q?o1HbGtHv/UDpYj5y/HMxFTGw+qRIt7Y+/hjBGNAzYCmsksD+LJgw+O9bESAJ?=
 =?us-ascii?Q?+FYIg3ztCOGeH1KALyCsy2c/26VfCsRtXhs3I3h7U9+oRyaKRD98V5GhDarD?=
 =?us-ascii?Q?4ITSsfKZUIDvsFEWoHIcIg890/viOPtjOV+WYYfbcxhR/12koTdZI+qmvIgs?=
 =?us-ascii?Q?Zb7OaxJ8sgntf8UnI/m+V2f9gKf5psK1RPzyKHoKrxd/KIa0ufoH1xYvlYIf?=
 =?us-ascii?Q?9CQYhwiGQuvwOF2H0vyK2fGRVVUCCFCSr1M9qp4QwZXv4x1236+TSQXrZCuk?=
 =?us-ascii?Q?/PSJjMBNMoY0GP+To5vF1w5e5++DIO0aOVB2J2VpNvbY4uAhped5O2kV9DkA?=
 =?us-ascii?Q?kYxAZs3zuodaAaYppwygv11sj7XT7cy9R7BJGs7BGzBJqN3oW170AA2JTZCx?=
 =?us-ascii?Q?YZnfBl1CNTIKIPepUSg+cPsMcISsnnTkOrciRVTxo6Ujw8kvozKd9Zobunqt?=
 =?us-ascii?Q?gimQ8P0tV5wZbCGBFgZAM1JtN3qmnfeOPD84vnD4WrBoPEzD5C1pKsEIuLGE?=
 =?us-ascii?Q?ianHUkLvM6VLfTpTM6RaDVO7uDZ0gldGq9Af1RXc+eUplfnsYHUNvzYuSd6z?=
 =?us-ascii?Q?ibbpsE4H0ZhOF6tvxmiC3KYFSLuBJF/f2yidwLzO1lme7iXPwzZ8KddW0i5b?=
 =?us-ascii?Q?fNsFrmBxODtnFmY5J9e4CwJEknTet80Oxz8nDflr3vHE5Nt4sfePTnghwPV9?=
 =?us-ascii?Q?Wnd4Y1z8Uk8BpbN7aiyKkHIfYfNA984NMe2Ajd9AKYR7Y+SPEwoAjy2e6Gy1?=
 =?us-ascii?Q?DQosTnKJbxKd9MHjLnl2rTp/0pnOCkkKFICpFQqo7jbyuW68HZUZLtvIL7HC?=
 =?us-ascii?Q?WNcXu1ZjO5R4fsZcWyS6O6UOkIhLsHfxS2UsmZwsO6cqVP5/ycOxYqR3WBfZ?=
 =?us-ascii?Q?NxBSTuyfm/kadmFVTcMDtTa6avv8fTB798eWcCwZhzJr6CXlaS614l4Xg4Pb?=
 =?us-ascii?Q?TqM+0UUtrj7wqMeNWp03SZxoQP8h3sDQo7TRMe/HhurWIw9qYLfzkr/P6QjP?=
 =?us-ascii?Q?CtP+52PI7uoWfhr1BuLnMdNfxZTpckG9E7hL+baFLdqU7z/9mhUre/OFJ6L/?=
 =?us-ascii?Q?rQhhnamgbEtyucJQwKIxAj3BtcCObd4+GWrJou8F/QT86WbmkFTqX8J6nFEH?=
 =?us-ascii?Q?rNT2uU62ICnhiUj0a6TQ4hkB6dCI4vFOPaLW+po+40JwWqdyj9oHFJUmfkbv?=
 =?us-ascii?Q?LeMNufsgBA/nD9RhABGQD1Qvy/DtV4n0iO9snpnQn4OZdP9smZxB8kGboJr3?=
 =?us-ascii?Q?YwpKHYquELsqRcV13y2T+sk8b6bKUkr97CdxSu/xuk82FPxOqKncNPJSK3uN?=
 =?us-ascii?Q?oQDljvEiuh92IeMy2hxcK7UoukQbyIDSih9LDc7rMo3OFdr69UKcjMLPw0QF?=
 =?us-ascii?Q?RB5rOwlhH2k4uOs6qKJlIKGkE/BfF31JqTuVbxd8/66Hnyv7E9ecao6R/NMg?=
 =?us-ascii?Q?6rbe8Y7NPyy6xe/NXsvyci3D8Jj9QDm1SKGpQ77QeXY6AzXHNgoye82rvYBX?=
 =?us-ascii?Q?SxvzcWv4p//az7qoZKxGT+gmFrPaYLF403cPDf6zWRcpfngJovNPIltxG1yO?=
 =?us-ascii?Q?c7ufnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(61400799027)(54012099003);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:17:36.1426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cbe808-e0bd-4030-52ba-08de5438736f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6891
X-Proofpoint-GUID: 1C7dIPOzI2EKH5Sr3k43W9UHwPRRzjsC
X-Authority-Analysis: v=2.4 cv=JZ2xbEKV c=1 sm=1 tr=0 ts=6968e8f4 cx=c_pps
 a=mX607ur0qtllMGi8m/+XyQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=FekQUBfL_KCFTHRCfuQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA5NyBTYWx0ZWRfX7IsbmewwGppX
 wOiEMbPRxom4iPFuhpAyQp9yBglV66vmyjFuFhdwOTmHiJJEsZyfndCd9svh4x2KlzYMQsVxiAb
 AblSSa8LU5t+I7s6rjC2IPVoxRnSy+yrnrPqnv/RIaHiYkoxzVQT4/wP9ODI4+S4ruJPkKWo86x
 1oHd1hztctR/63EMDWYV9uSRy/Xdz9s4NsBYslSwygSEsHKHSIw/LgpKmsmHISdnQiXaqrpbiZ5
 wQVpVEdxMxdp/herBb/qrTZER68cBh2GiBHLjoi71nBh0xB8RV+1e1ve/L7bKJ6S1317MDN4lmh
 xlL+qGjxXNFYp5F0Yetxz15yEe0eE3GUf309sHVshttYEwoXXiyukOTDXgTOkouIOlJ3I3XMglS
 Fuv8Ni1Ns3TSkqHI4WLqRX+ptWUoK6U5KN3+OHcHw8SdzoDhzs+SV3nAhTIOJ97DPW4LNExXGa5
 Bsfp22itrkK0YstuVew==
X-Proofpoint-ORIG-GUID: 1C7dIPOzI2EKH5Sr3k43W9UHwPRRzjsC
X-Proofpoint-Spam-Reason: safe

The SDCA class driver currently expects the device will be fully powered
down on system suspend but not on runtime suspend. This is typically
required as when audio is not active (ie. runtime suspend) jack detect
is expected to still function, but when the whole system is hibernated
there is no need to recognise audio jack events. This means the class
driver needs to always be informed of a system suspend, so the direct
complete optimisation (where PM will skip calling system suspend if the
device is runtime suspended) is not appropriate for the SDCA class
driver.

Add the NO_DIRECT_COMPLETE flag to prevent this optimisation from
running against this driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/sdca/sdca_class_function.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sdca/sdca_class_function.c b/sound/soc/sdca/sdca_class_function.c
index 0afa41c1ee93c..98fd3fd1052b4 100644
--- a/sound/soc/sdca/sdca_class_function.c
+++ b/sound/soc/sdca/sdca_class_function.c
@@ -377,6 +377,8 @@ static int class_function_probe(struct auxiliary_device *auxdev,
 	if (ret)
 		return ret;
 
+	dev_pm_set_driver_flags(dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+
 	pm_runtime_set_autosuspend_delay(dev, 200);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_active(dev);
-- 
2.47.3


