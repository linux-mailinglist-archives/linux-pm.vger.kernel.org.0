Return-Path: <linux-pm+bounces-13025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093C6962474
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 12:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A662848E6
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2016A38B;
	Wed, 28 Aug 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dYp8itH4"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2052.outbound.protection.outlook.com [40.107.215.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966515B98E;
	Wed, 28 Aug 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840102; cv=fail; b=WHPRfrBWZurJmmq7qxqgIhtLKRb4u4wzBzwMQVnP9DKOQwFljuM8DQDQo8v0c0TnEGBchEWqE+Kvmed4BVBWJ3gN04WH5GjPl1yqaAwW/VCk189x0+FW4UYP32rM//cyMHNCbFc2a0NUeBfGPJkGov15auGYj7WuvHHdzaSn+pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840102; c=relaxed/simple;
	bh=nqqY6m+wxCQzEgvWDIQJqMfuxhTiIBrekqVI2xfIyAs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SaOIS2gEIAgjIGcjY061lQmn79bQZA9KxlUv8dMsa9Uh1BTFmmekdkmp1zqe0sHZqCTTUhoh7+vRq5x7o/Q6OULU4vpNgK6gYgTQh3wJee9PLMFKm5RkO+S0PMEA6D8dTF7lR/RWZMb7GbncXgjxdSgxUqUuPJedIW9pZu7P03w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dYp8itH4; arc=fail smtp.client-ip=40.107.215.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWZqJ8mdjeHA2xTSnNNtxtcf1Ll9XJDuKMBbUt3Gp+x64LO7HY4pjtjxZsIwQjvutJYVCu1ldrToZV6LdIN2anCemfZorNSQU5YD0axLXm9okK4JaH1uHDQFFF4MA4Ea7XIcVJdourUZsfayxNNccKtf5m7tDf1zqE17HuD2Xna3IjCtQg1zeC6wHyHTYbyg0B6h6h5l/pN6OUdEyVfd6H3g+04Y6bo4mVFYAvFrbSlhC4U5C1Biqd9HukjoN+TkvbbRzw5nomi3kFhZhBlvyIlaG2zFGvqZrd5hTjuYgTYIGCdLy9hcmUuYY20NdS1d7e3lmr8B0mChuCHI96TOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPMQp1H7eMSB0tH2p/WYF/I9lpauVXh82kFfTEUCvMU=;
 b=laAO4KbaqwjSAzWs32iRfNvDidJ6eK5CvtxJ06QSWZw7EsxQe4TpG2CysBE/gXwdfDl46cNv6fcRmY/k/HlALrIXBAJVg9qrbkohf1tBS1YZRwiEgOs0944agIdQcRebDhF1bVnV9vdmyZCwRAGlW3+6vZ9UWpuL8/KvPqRt9jvvnDnAoye9kVcRV+XOHcBcnMUICWAHp6/KYFu8L11mJaU1ddejA7Td5Tu/0+AQQPJIOxEqEyfZwwihMoudA5za/vXzk2hdsNP7TkgXYKIWn/E8I9Nr4AwtHD5LkD/UACW+/u3z6vuAdVkYCbBJ7QynDvIyWovds+Xhi/Knv50RWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPMQp1H7eMSB0tH2p/WYF/I9lpauVXh82kFfTEUCvMU=;
 b=dYp8itH49ybsffmsgBAR0L7gvG4qmjMfzW7HkKS4C4BhNGSX2n6FHVpO+EUxuLNvG4QQREPnJnOA9Nyn87eQ8yH0bMgST03i3uOcOs4vsB5/GPZfp5tEWOv6WKZUCA4lmTb89zTlfS40+CQiKZF+Rnji9tUgmcEzEjGBNIeThNJ3CNWCws25V4MVIAi4zQy5Flv+JbZ3gtgvxiadSNEegtO66jYpV9/94Wjx1/Xa5tiBasNliWq13zb3HOXBo+kA0+Q5V9GCrlPZFbrDnW5HVg3tQp8h2oh24cBg0AHK4tkNUTP0qsjjaYocw84c7d+6sGzLGjZ87Lz8qvLgjOO02w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by TYSPR06MB6528.apcprd06.prod.outlook.com (2603:1096:400:47a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Wed, 28 Aug
 2024 10:14:54 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 10:14:54 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: djakov@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] interconnect: make use of dev_err_cast_probe()
Date: Wed, 28 Aug 2024 18:14:45 +0800
Message-Id: <20240828101445.979343-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0150.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::18) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|TYSPR06MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 436662ca-79cf-47a6-fffa-08dcc74a42d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zcloNHC+adg+ZuicdzA1IdxOFu7AK3PyfsKSC2kl9YfbU6E7Ek3dVO584Fwl?=
 =?us-ascii?Q?vb8Rga2s/B6OObs20+6av0NP9coiVEKV0ii9cEjHL1TSj7cWuxX9VadKrETI?=
 =?us-ascii?Q?GbXkKmXGMtkYKEnQp02RUD9GcY//geTXI3lNtuL3AUGx8SlsX66g53HYHNz3?=
 =?us-ascii?Q?/fLxOSS2+WbZ39YHAdTWRoLD5qP5v+Mx2OtIhlb1yQqNMgj8g3mM5qrsv2kQ?=
 =?us-ascii?Q?aM50PhtEf8rkSQg2BOeoumIXuM2GDnucM8pmuSM0J0jCu32ADENWS1M4tQpc?=
 =?us-ascii?Q?UE/H4tr7ePyf43dhKeTWdznQM6EkE6idhtexwJv2oMLvxe5zu+fcGDsVMa2T?=
 =?us-ascii?Q?f8DXHkXfig04B8eQQbr1zDK1Zi41dSA4GTQ1N3SG+er9xMwOEo4nlQpbGXzw?=
 =?us-ascii?Q?mXbPSiWJJi/bbLR/KrkcZGF4F8u2UWV/YI3qBsmD7vCSofh/zvM0eukTX/vY?=
 =?us-ascii?Q?dcX5fAOWZSqCzPwG9mK1lrUuVQNKvesKO3cQtojMCAr4dF0NU0BK581kGU74?=
 =?us-ascii?Q?JNltkeTYWcfU+sN/trqow20Eta0VWL6xt7vyaeAANlB9l56e5A0Lk9P2OiIg?=
 =?us-ascii?Q?MwLhiU1RDTX9lL3/WZ8iKPFpWK/FSU0jcw5TrwB0gp2Q+ro9H9fs/NMIXB8U?=
 =?us-ascii?Q?h87JmWAoWSIMkl21qiYLU88SJW7TjfFt52qbSKerBmwMaNOmbBEyQtODDpV+?=
 =?us-ascii?Q?QlomuQ9fH2JKlBD9YlDZBnGwwm5fFif3kcyoSTUbGBXr9VCaoysWjAeDG5GZ?=
 =?us-ascii?Q?lbbW3S9yb5A5f/45nL8ggNQt6Ez88lyMdIuKJLdhOEQmtzwwdUzJsvaArGvv?=
 =?us-ascii?Q?Pb3/+AS+ysBB1W3G41O2LDt/HtIPicBrl4nMkZcfzFiEyl+cx3wf9RaafymJ?=
 =?us-ascii?Q?Ozl8xn1kkVo5+VH5efeRlNGOCV+24k8CVI8l6JP1CLJNgVsnP6++5VDTx9dB?=
 =?us-ascii?Q?Ev45WKKuOi01W4sL5l9NmjbpjZ67tDxgq+6HFQd9OxdY57QwwjOYePARBIQR?=
 =?us-ascii?Q?6lRDlVL4EmD6Ew3384dFOOkQh9sLAzl54TKhzEWzTdQt3VJXk5LJLf5du39K?=
 =?us-ascii?Q?WLo7/2YSX+tNmaFx/OYOLhvv5v0XpyZC447CnY+windbZiBABL7INywtDMbD?=
 =?us-ascii?Q?SaaqJCccPwsfWv0Z6E7WvR5Lw9AbiMhr7KanuEg79BXyFopyATrKsbgvYnzE?=
 =?us-ascii?Q?1cFfHuUtAtVEJCijVgDDDSTSCRJVhA6OxAE8iODjCcYs/qZbl2bodSFgA8Mx?=
 =?us-ascii?Q?Gt3EgSCRkQLT/Xzm+9pFhi5VoroHMw3OGE4GnVGMYng5w7z3otPP86F6E+jU?=
 =?us-ascii?Q?EmbstT9sjl/D/doaDtRb2Z/yeknHDmmTbS4gE/CF8PCVXvqj5lo3oySGQ7v0?=
 =?us-ascii?Q?xoJTg5ARqPnPPg2J1PdRCpq/VRmf4K+U7KjauzNkKrloEtLlig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MxwH8+bIJF/09btNNqJOk0gNrZQb2f4T9jt6scZjhZ5v9/IAn9gYSol+HtJC?=
 =?us-ascii?Q?2ROkjJ9R1cbQg5HBv78dANfrVwMTkrQOIxzHoXsxO/uNnkO9rxiHQYPPpy9o?=
 =?us-ascii?Q?0r6+eoSzvQQGR8hipEoeiHRry1CIN1RfFJtwGoSMHPiWJNtcg+z5uW9kYA4y?=
 =?us-ascii?Q?Nuwi/gXxIz+E5QWSZiJ2vYuLceay1WM7waaihSKIfCQ3E68Z0eqm9eQFaeNF?=
 =?us-ascii?Q?zwgW/L/a86XvZCocZ2HItAYjc933y0j6eZLP6p6LqM8hvLuH4A8fpeUWDsBL?=
 =?us-ascii?Q?JrTH0U1Rlstp6w68RYwsbDew17D/JjtUDrb71DQptlDyky+jCncHuAPB9adk?=
 =?us-ascii?Q?RtZM4a6icSyHmD/ySBMA/BjygknVK7PZ05+U+y9Wnusw7X5DDfDoVkMs6DNg?=
 =?us-ascii?Q?DQ0ACEvjEbDyaPCnKFldzg2OP3j4cO6NyGUNpbYFGlOPRudbRQZuXC17bpXB?=
 =?us-ascii?Q?gxfgiJVnENal62iczRye8vf/Br8eFwhrtUBozIvXfMqnRrDvj074XCJeKfmc?=
 =?us-ascii?Q?cM6lhkfrTJ4SNiLgaraLPBFthw3p1X4PmcJTNdGgARGexAC7C5BuFi1m2Xme?=
 =?us-ascii?Q?l8ePMZeC5S0OlgQgoGfg3kZD6A7bcvPDChZJ0tgOnNQcvSNe12bDbakdJnFt?=
 =?us-ascii?Q?xErp7fSfVp04p5IasXtfIjV3NnB1rBy0ILTr4WyWXaLAOAtECLvfx/Y+Tf2s?=
 =?us-ascii?Q?oO6LfwkeznrGDxIgid+eykUvW7E1q27+IE6N5tideHHEwN3L7u9hCkQk/Soe?=
 =?us-ascii?Q?GNCFEHxVNLAZRlhX3L4ZRiUzYHXK39/ut8NHvnhs8Q3DxW0ThDBXPCyrL0Zb?=
 =?us-ascii?Q?FlASarFzprlaXqQGIjUj4ONj9ez2TGA1YwFVYVguYx2d6OP5URIs7xycFyns?=
 =?us-ascii?Q?rSIh8wpJsYHjdLsEf9+GswSFlM0kKrSur6h6y+KpxW90wdluAW02kBogMina?=
 =?us-ascii?Q?GFcQGdCvYr6Nf8Pid5hhBNkINmkKsRGDLveRpVBYPVM4PW/FFDLE9zRVS8PF?=
 =?us-ascii?Q?nxOK3Kj0W8pFe7LidmldM9cwxJuz79j/O8RAnQZLIrVDkRqnfs0ObFC9ZymK?=
 =?us-ascii?Q?KhHm/lDolB99ZEcwFAwsS036iZU5eXXdbB9zH74w4E/7A3iHAtZM6xtQhTz0?=
 =?us-ascii?Q?GiOh/1Oj/xzNfVCIvcMr+nEaVj1+s1dKlC+Tym7fKavqmuQ05ZmE8KWIEemH?=
 =?us-ascii?Q?FPX8IK3pwscksjcPb6mTw3lRSxQau19M1a17RHwuFZ27XOe1NeXEvtXF9ATT?=
 =?us-ascii?Q?Xm1rwgqQUyuKR2CGtK3uW466rseW6+D+YuqMAgtkXLn3Fo3LwK7aIXwqDQjg?=
 =?us-ascii?Q?XwLoV6gMueYu2Pt/hRutf/lQGsIHYBeQnUEW/N8tXa4Nv9bbUo8tpKQcRA5f?=
 =?us-ascii?Q?etGp+HaH4JKJmS8BWHjYwAbHEifvlTIi9wAqe6sN3ttlvVkot/jhHQNrhmVA?=
 =?us-ascii?Q?29oGQ+U05SODej+ngiKvkQhbFFVSzIcRrbPqE/yuKD1DMJ9U0kV3VbZe4Qq6?=
 =?us-ascii?Q?kLJ61wwURYQOHfH2cDQ+WNY1Szzwm2IyNwkrsppiAtQot1B3kr5PaBmo5Etm?=
 =?us-ascii?Q?cCVZh/0OEg/yEy6zEayPTHv76g0s7OGk9juR1XvM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436662ca-79cf-47a6-fffa-08dcc74a42d8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 10:14:54.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Qqt6WhHOSaykAJEb9EqVe3H+bttH7g8iVVV5/drUPPE3p3b/hihSios3IhmyuK+4gqLEHwrreD81LCc0WTtwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6528

Using dev_err_cast_probe() to simplify the code.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/interconnect/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 7e9b996b47c8..2ec4b6c2f49d 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -500,16 +500,16 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 	src_data = of_icc_get_from_provider(&src_args);
 
 	if (IS_ERR(src_data)) {
-		dev_err_probe(dev, PTR_ERR(src_data), "error finding src node\n");
-		return ERR_CAST(src_data);
+		return dev_err_cast_probe(dev, src_data,
+				"error finding src node\n");
 	}
 
 	dst_data = of_icc_get_from_provider(&dst_args);
 
 	if (IS_ERR(dst_data)) {
-		dev_err_probe(dev, PTR_ERR(dst_data), "error finding dst node\n");
 		kfree(src_data);
-		return ERR_CAST(dst_data);
+		return dev_err_cast_probe(dev, dst_data,
+				"error finding dst node\n");
 	}
 
 	mutex_lock(&icc_lock);
-- 
2.34.1


