Return-Path: <linux-pm+bounces-32397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A170BB26555
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A715FB615C2
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B59E2FCC1B;
	Thu, 14 Aug 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="I4zlB23o"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013053.outbound.protection.outlook.com [52.101.127.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63121F582A;
	Thu, 14 Aug 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174382; cv=fail; b=inYQJbTWnrDIbbHr4QCxCRQzPztr4jyV90+qU4llB6lEnDdqFuzhp7Z64Vwpd8mC5SAPuKzZM7K+NgEBWw1TTSLUsNhEwjWmmA1vzxaKklhpjbMfXPIt1MqF9/N5iGnSfB4kQgvrCjTSXvzxpta8oRn+l8SavtXNnCRKikMuBPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174382; c=relaxed/simple;
	bh=BH0bQeliNK/+9ATHNN0OLrrEZxPasij8T/zJaDhpFvs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S5lJW7vB4HN10XyiQ5pt8s74kygqZpniYEj1AdanZFMgCqEwu2CJTKJVZwUpg0mwNq6KADmb5uKpuFMWgrZ4ArW8JpRFcnuGFmck6QKGP71mwfPoRMynIOMUgmWt439z321f2oZEoBwtOJ6rE2kGRloBEKcEIJwBnaRNtWwMpTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=I4zlB23o; arc=fail smtp.client-ip=52.101.127.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5rPTtdOCxFRp3emrkTRJ7WdtZVdy9fwc4X/XdmaLqjHn+xc08cpfOPlJSZyzs97pTOYtLKn+FLoYMo6zaIkCfrwdxLX8EsL4DfaYZO9bAlJrZkS0uYDKX7P9A/LzvVt24w1RpknJf/4RnCFpL4t/xhUUB8sGf1K/AcuD8VjBfqN4egt9MhetJfZpIfviwevDoGFNg5rz5po0wogov9y2MYiNPb4B2+/4VfywF+WVxxsGO5YnYD8zBwSJOy5cbyXgc6f8gHj7UV6WSCFr0hXOmQnTn7J/i+D60QWIVvLuvbBPAqtGF1DbuscgWJ2BczAlv8Oq8ZdfwpHISr2oQTuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nilJFSU1HPn3DV1FUcTchkNrt3i3+mDOha398A9mf2Y=;
 b=sQwOUFDhkqcQ9KEqki81VFKvFlGUAZubf1zVplXLBA1QYjxoggodLWKMcnlQ1z98JmIhK1ZA+XAvL/4poyxGoeLj0Payq82ApxEZzqq/Qt+LbLfEd4tDZC9UBLOAea32yKA+8BE5aXnc1R6TVGb+JLh72v1Ic/1OLwzrVM+xMHD87XHjgWBmJpoE3IV66ka/AlY3sHVKLAPrp3DxBHhqVgZQeQpuZGN65IQAbFO8tXHW4zAWk3lULiWDBJJvqhJo+uK/eE7oAIr46+ZMqr8mrgRMSf1IX8QvjS05bZGcxQW1HC9eM3ulNiR3dHaxdxHu/SpQ6BS1Amgo2aZIbJyvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nilJFSU1HPn3DV1FUcTchkNrt3i3+mDOha398A9mf2Y=;
 b=I4zlB23oxJeAak/hF1lnwIRVCgVRZuDgIuzUgS0M59HiQY63IVMwONKb8pnMQW972vjvJB+b6jcA/4gxaRtsDLGNJcYMxKL69rE0Yo721y79kkEBPxaHKDwKlFibmHroOvp2+b3KU2c03UDdwRYo6uK+uSsiJ6AdjRD4DFYsc2r4+kF00N5mcUAxb+/56RuBcZNZJ4JMi5u0QhVvI6XFquRcUdI0EcoO0hlMEiQK2RVoELLiNM3QRriGZJqxQ0O1GlsSjALuuIpfe/dnmJLspkL0ql2uMZItF4J2N1snUva+BmtuMAdoZGEP+zv7+qI6IiTUhG2VbbKvt/x5PXOWjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY0PR06MB5378.apcprd06.prod.outlook.com (2603:1096:400:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 12:26:15 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 12:26:15 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
	linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] thermal/drivers/ti-soc: Use IS_ERR_OR_NULL() to simplify code
Date: Thu, 14 Aug 2025 20:26:04 +0800
Message-Id: <20250814122604.211723-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0138.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::17) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY0PR06MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf22a48-0f04-4a13-6cc0-08dddb2dc2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IfYu9m9qsJONRDB6zXVvL9g/1ziT1VGdVB8cozsdKrCE4eN2/luja2YuI6Go?=
 =?us-ascii?Q?Q3d+MXEfXPVR0dQnLt20m/+k03N3qa7BMXLelL/cqVmkvfjWgmrVCUsMZqMp?=
 =?us-ascii?Q?YlpIQTImYHrkhZNRW/dXlYFOVSN3PogHCYA1pbEivVaL6Ff9U0Jl+yWC8eTT?=
 =?us-ascii?Q?oOQX4UJN8xubjcTiRT7F2p9P3txcm19yOHW2Wwa+w0xx6h8ipq15oJZaXJJl?=
 =?us-ascii?Q?hsuVayWio4FUT+guDTAgJluGGvRhxaM4GqxWzpT3lNKI1tDI0ByGFAQWM2Uu?=
 =?us-ascii?Q?cFuOup8Ehh/lkhOAu1NHh+VnAvOVpNJCUKc+aKa7DLNL9Kzmq0j/UhjQHXft?=
 =?us-ascii?Q?2iSl9KaDgD+QC3bY5gdoI5ri5PXLliV27w50LZVrYtol8gZR46sasUV2xfjD?=
 =?us-ascii?Q?KR1tlA2IjcKB6Zr6j23e4AdwwjswX+nAuVhcJkh95mu6ur+uoI1+I4xwNdNG?=
 =?us-ascii?Q?wm8eK+S167V+r1hz9aJ3XtOw0Xkp1kahUvrazZE5cfBCvERyC/Q6iu/pVE7Y?=
 =?us-ascii?Q?D6+0on+tY+htOHEzsTVxdvD9NgU62nPMF6qUNO5tAl8JewiP40bgLhU/l6nb?=
 =?us-ascii?Q?e/6rK1XdKpxF2kjK7JUktVAUBn33yAE0Jqbm++6vmyIXPXNy23SlZnD2JIUc?=
 =?us-ascii?Q?NyCOivS2MVt4EldnBAhgjVPnfMYEwFOfwdiSWWI75kP/Scc2wPpTaSPCI7hB?=
 =?us-ascii?Q?EZiCmJzi/NUaxe3jRmI7FDkxYeWjzB8/bGF07GB+TORWlCQ7PsdRr48OIX0f?=
 =?us-ascii?Q?b7r0Hkb94EIkX+vfaFzhB/xHAhsehbhLqHQ3IK3vlJqM+BlPtognIbfwuzT7?=
 =?us-ascii?Q?HR1teo32Y/1hrNQfwNgReCZ9NEKB6uxuJCcwCBoJRlNuSf4q0SNu20f15y6I?=
 =?us-ascii?Q?brT3G19fVRAag6S/btiXUPz5k1m1c8k3mqNG1cidb2R6yWx1OyKn0LYssR8C?=
 =?us-ascii?Q?XHeLYpPHL2Kkner3w3fKTGvQRUTXTtGAgAF9x+7jGKjjvATGP0AvUx4eaxxG?=
 =?us-ascii?Q?J74oOFyPLmJ5yjrjXvO1Hudepf86v297lZGwoNxSVHY0iZZYyyI8QiPnaojQ?=
 =?us-ascii?Q?ZuHaCpHpkoZ/4pm+sD/kL2koJKCqq0b6bCkwrhEsR6C64/PIUFt+79LKa4RP?=
 =?us-ascii?Q?iITr1s2pWgxJeSNZdFOWTeox1YnJKMREnef4XNyD9ead1qc+pcwT0ZehAXDk?=
 =?us-ascii?Q?VHSlrPR/3ybUKq/i5Jc7dQOGkLNoSFV9ZH7XgKKZRraYHAmNjSvUc9vzqfb7?=
 =?us-ascii?Q?RK+Zdyr1zNTdu3P+mTkMMBxLJnpkKw8p0r8BSVFCRgkhgKdnpmbSUmnJ5juk?=
 =?us-ascii?Q?Wp3UTO4VmJbYYbR91V7Cyra5DOVR/YErPpsqKPdy4oW65lQVgdCltZ30q7yH?=
 =?us-ascii?Q?ZTxpYd9Dg2YjY5oswb5pN8N0msdhVTUhD8v2KdVDlQ5XQ5bzoC01JbQUJ+HH?=
 =?us-ascii?Q?viqQvWTWhB21x8AoPm2omYv+sQNNiFuTQreL6jGNv6FtJvoMHD6jSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hzu3GE+7R0DH6MtlaN9jQNFam3f4SSLCkGnCmksV9aL2d4ZibilciU275tz?=
 =?us-ascii?Q?2CNAv9aqqdDszakmK++tvzViV7MWjxwnkc3N1gJuOopPhkV1YD2IN2Qd9LcB?=
 =?us-ascii?Q?9ErBYhbROPLSkGp1gndxa4QSMddlSFk944s/5JK++BjHCi92VJ3iT9lYF4sE?=
 =?us-ascii?Q?s7XXr4rtgd1shRppnuBvSNzAPOVhYuIWGbz61kfr3Pd/T7DeJgND389LoX5G?=
 =?us-ascii?Q?9P10ZXj+HBshadf6g34d/HO44F8hgESHMFv4YPHs59OGpUI9Tiw1qb6IsGZV?=
 =?us-ascii?Q?gm6PV3tRETd2vOuuaGfw6by6mryBpJ6aJPCzl7uz6d5bIY46G0KZ4qO9Dgif?=
 =?us-ascii?Q?axkDcMES5ghucTmRpuPw+9wkzzUU10EX7+/Iafv7xLDCxlZVqoavgGq47+ne?=
 =?us-ascii?Q?6ZRPcZXsO9s+yz9ezC4wj20bgEj42rnNQifc34Gl3AVS5aVQNJDGK+LEbDpQ?=
 =?us-ascii?Q?uA8HBR6CQ1ooPwlHxvLE95zR0+7r0J/DqOQchBXMQ3FkK0DXJYrDoWM4QtKP?=
 =?us-ascii?Q?FYNDvY75k4Q3VBA+CXGYpBRbztfR+0M6ZzdQD/bgqn+Zz30zXjIHOvRR/Ta9?=
 =?us-ascii?Q?ZQPG6N0o9FcUYS2qn+/Slo+Xj0wZb43nC4ZX6Sr8mwT0h2O1FZVrL3146d++?=
 =?us-ascii?Q?/BzJH/WPyCrX2b3hmIZ6Gb+pz4XNBTrUDSxHSJuDI6l1J3CufuwUvplD3kal?=
 =?us-ascii?Q?NshSWWQjTU4/SKEB84cjxctFYeRbIhceBjYe1zcgNkLf7iOacGylTN31QQk1?=
 =?us-ascii?Q?PPgnx1LIQ7Wf4ehR0RdX8NpHAw+BQ2PDECv7e+v+MdgA540gV2hZDxJFM81d?=
 =?us-ascii?Q?XhAut0rwzGG3OZwuybUZch7rGG7oZGmod2CU6OZqD1kESKF7B1XCDB0VX1GP?=
 =?us-ascii?Q?Eny8TmEu9LyvUVQAL7IYW3Jh+88UvO363cbrQELOWjERM9Sum4BOlTOfssj2?=
 =?us-ascii?Q?QlVI1J3mgDrwIfKHQYYZPF2FIKRzYIjD6vZR2H1M2SSAbjt0MIPZl7MOz8oY?=
 =?us-ascii?Q?5qmJop6b48f510Njvf7+iHyzcGK0puBjcaZAXNx5UWCBSSVNV2/sCjCW3Tq2?=
 =?us-ascii?Q?kyYI1dh4xiETgM23TOFWpVVvyzfFEKPe652/Q6Fy2n+n7IG0xAtBIeJtHz+P?=
 =?us-ascii?Q?VIn74s6XSDKc3nSJptKHZXRf3tE7HtntTWHLbyJNNmR9q0/DspFhZcOmizge?=
 =?us-ascii?Q?ok9/1beFSq99AElaBXjYWSmh6fE71dvKOjv9SwoXYU72GMji/kpBp4MAB67Y?=
 =?us-ascii?Q?Ro7taO14A9gSRA3tlQy0OGLjWPJ05ah0hwD4g2DH/+mcObi8kSAfv1GZVMA9?=
 =?us-ascii?Q?x8s+F7gl19IUlyAB5wz0yPImh873hWo16kK5x2eF4/pwSd9CanFCMbDFOIoF?=
 =?us-ascii?Q?UPK6/jq1v2olxTTHeVdsRavrYwjDSmDUmGSGiCpBmNmfg3oWpNPSAtnadpA+?=
 =?us-ascii?Q?iJgMMnMG5PYo9H5980YXcYTCuTX0lxiJgpLI/pkM6T606Wv94M9Kx7MRPdUQ?=
 =?us-ascii?Q?fqdAJF51GThjG+Ut5S67f82kQ2GzFMa0wAOmalexgGZ6tD/JUkYq2ExTzDps?=
 =?us-ascii?Q?aehJgLeycSIYFS2XreRpIVtrrjEZE0KqqVMu5/RI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf22a48-0f04-4a13-6cc0-08dddb2dc2df
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 12:26:14.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgiyIkh/9OXYJGjdJAtJgM+sNepr8VX0bn85mdSsoiOW7a5wQRYN3ybFsWEe2GpmJ0yB0ZaQXupbvBqk5XyWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5378

Use IS_ERR_OR_NULL() instead of the original !xxx || IS_ERR(xxx) logic.
This will simplify the code and enhance readability.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 0cf0826b805a..9218417e6d92 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -228,7 +228,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 		return 0;
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
-	if (!data || IS_ERR(data))
+	if (IS_ERR_OR_NULL(data))
 		data = ti_thermal_build_data(bgp, id);
 
 	if (!data)
-- 
2.34.1


