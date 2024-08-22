Return-Path: <linux-pm+bounces-12693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585095ABD0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 05:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1D3B22499
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 03:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75E1804F;
	Thu, 22 Aug 2024 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PzAzZRYL"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382E134A0;
	Thu, 22 Aug 2024 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724296885; cv=fail; b=U/6rD+vcCjstzv9HtBLCLbpTZZJ+1I/uqXf9Z/89ruc6UhbwcsjwsNF/AJsmdy2Jrcw9mencBDfx0iwsHdrNXt4xXItmwtTgOyatgR39Eb2Mnf6YSBeRBWtJfk336r1igTT6gaYI6FSnj88v28gAi+E4AhLDHJfyf58cJP6UxCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724296885; c=relaxed/simple;
	bh=5oaviaHVHCC3DXkUg1gzs8PjInyH91o+sBgDkpiZMYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F/Ogs/Fb1vjlu6AZ5K5jnA/g8SDIAG6x9sTdTyHEYuYCAN/I74bgKp/naMnErj+xR+V4hV67f5zGAREApwcG57aonW+7NoeZLXg351hn39QyrxY5KmlPo3O964vA/ZlvtGN6IitQ7r1tBTUo7IKtHU7Cv/CROCGI0mIXvoicLpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PzAzZRYL; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMse0Ko3CQksLkV/SQk73zPDlqPHWIXrxyfrzoKemoFVPt9Ii6GhOGyf9GKQdxmKwifNBl/tWBSoCkjlMmJXV6cNnVOaxHNdFhERU48QoXdi1+fFYI7KGD0Pf7D078jXr6sWOPpXwkC2af1zYStFIkatvxNsomycV6r20BL5sciZ7QZdyeXlBIYM1hHbwW4yDqZF4O3jHoan+eYS7WiZv48OKTF2aQVIIN7NybO1hT4Ww/R/E2FZ656wesLG/mxEGQh3PGgFfsrSlvXN/PCfA2nxKt1D62pKG8flKrVUMpt7+tQUXWdjwPwjMmHvgmzkO1omGGB+UponL9h2hf+HIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdfwUNn+bAM0witrVXbdFtv1woNIHXAFfYuzVDn41Ok=;
 b=gaatW3KUptYT00mbe2DG+tU6Ri/ZHDMptkOiWjQwJXmwCUSDREwZNaHQdUPO46C5da6eO0nG6Jw03YSWb5+Pfo7zTku8PXAP/6a/o1SSVtxHYK8PnNJedDrveoKdWz/6IQqzsZ7MTHvtnUBb9ooFeiRcLN8E5FokZSByX27ZEu74vGjuXxQT4pJ1D1DGoheAtMrWG9tWS1tpyTOaLGPSOErX8pwFPi/EBGXMq5/b9e/IjkC5sKBeHLQXhyd/EdHxnVJ1wansG5OjMOQ6ssbIT71fl/mewTT5M9zcPBxXJmNfLAOIR4cFoT2xNYC/KC8swWdNGXYJJfmEMan9JNPh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdfwUNn+bAM0witrVXbdFtv1woNIHXAFfYuzVDn41Ok=;
 b=PzAzZRYLpi+3yvwW4Tj3ot/Rs8v3ZUJk0AxH5vtU/ju4izNfRL/5JFTbyLAH9iQ0GLarauJC8Sd1hHF1tXiK3KrT35IJIOmg8nUQK8qylpwzdwgABPcLBaSQP8SjxRGsqkuqvKdnlrTOdvSaZqwbvZJ2wVtCbjljqC0szbUginGIIzEg3Sl5/eZflvMTkdfIk0JzLd/VaJXidCa4FEBptdlqvLi5ia7jzkmLWUbc4ndRJvpaiVEMfdAxkPWuh82Jw3VIvj/Wbuv2Jxw3RFCRvt7d71EVxqHIDslwPLkKHKfU4uQjOuT2Dc1XFYUbm/yPH8Ru67b13cluQiHWNz1zUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYZPR06MB5484.apcprd06.prod.outlook.com (2603:1096:400:289::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 03:21:19 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 03:21:19 +0000
From: Yang Ruibin <11162571@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Yang Ruibin <11162571@vivo.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] drivers:testing:Handle possible memory leaks
Date: Thu, 22 Aug 2024 11:21:08 +0800
Message-Id: <20240822032108.1223332-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYZPR06MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 487a09f9-3794-43cb-a86b-08dcc2597d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oxYpxzFp4nTCVdPGWstwtpEmwIlrHdGKuivBmGDyzLU6AK7joECw/qD8S9Ui?=
 =?us-ascii?Q?bdfUu0cKcRnlSYnU5yH51SWKyDqPUVLJhcNVRYh/ao5CKsNK9SpcgKNQewKs?=
 =?us-ascii?Q?3hDMqHgGj4w1fnJRxGfhnGY3jQlXIN2OkjQORPUIOmFdvYfbguKoSgomUqOf?=
 =?us-ascii?Q?C+59J3MLXzAkLcjcuet54hahpYiR1CLtK3ZmAqjFKYgw02RRJj/I4PlZYHg1?=
 =?us-ascii?Q?w9til5TVjSh/8tmVW0dK6f4UEL44GVOu69fzLeWBefwIzdj8F9letmUH7Itn?=
 =?us-ascii?Q?gQ96vQDz+lXZSeI9QhruEZMK1bNco5A38q4sXtsnqD+jlIIiM+mBLM3Ltodw?=
 =?us-ascii?Q?5Z4fDFuLYDq5mABe28vJ1M5+sNlCnjRgnwbnLf/G8g7PAgL/+tOLmWrhIs97?=
 =?us-ascii?Q?AI24Anr64toGzjFQ21ZlGwCxRtasqpoCk6QS9Vo/tSAUU/VRTzArb33y2DvW?=
 =?us-ascii?Q?U0LamXU6lttcXRFgHY3Xw4YjRUPj/C/PPApWSZZ6i+T/PYzSDHKWJBeWlbsN?=
 =?us-ascii?Q?AQggZbsBdZvmqF9STjC9nQTLXSiMZVuLfFk0Ykazr2ToHspaykp/CLOWr1Y5?=
 =?us-ascii?Q?MUhIqEkqJLc00W0OFFxpci5eOqxDyHjioWabtygaYyFLaGZ8Sgzm4ulDoKYI?=
 =?us-ascii?Q?vWtmpHrDmLJgDCQbT4pvFUl7HOjCypi5bJVPCE0LpZlnlENTJDMqeIOEeo6J?=
 =?us-ascii?Q?/Cm6OOD6efTVEly40J2TXfGG8GEOd2akuYPGCtmUG7woK6z5Zf3PKa8Bw7c7?=
 =?us-ascii?Q?Hd+XFlN40aWoUWIQHULAafJa4ASLq1rWW6DxYHRayLvo6b/3GfbrbkXhbbga?=
 =?us-ascii?Q?3ZKLkYo6IvOH02p2qdFxlIZI8K0Wl1jAvRi6gBGHPFL3XsKtajrJfihTuWCb?=
 =?us-ascii?Q?5hiKqRhuKowgy0lTqVRqwpTIr97SKk7ZXHpQwUxtzpeshM3qxkiF+YEoyr9b?=
 =?us-ascii?Q?HZwZVJey9ic84uEfSZ9V/KfzijIe+jOodVa1b0uwoh89PGU5vwLCUs0+W63V?=
 =?us-ascii?Q?zZTdpMleAG/3OG0f7O1vQAsm7xnb/9YJN1kL7YTCk88EAda4qoctTQ7LeqjK?=
 =?us-ascii?Q?H7oNXehpZfRV4u3UVf1Fm6mDH7dHFilqvs7SNIBr2zt55Gh8FvUJ8cst9aVf?=
 =?us-ascii?Q?LHtBZy+IJoaIuu/E9NKOZEkF8M7CSdUvbr/cKLoX3G2IZBrDmOEe4OehOMTG?=
 =?us-ascii?Q?zVNjQeWLMduUeVCQn2C6Jt6sZI0RseSvG30RptxgVmQvfVn+pqgN12+AHnIB?=
 =?us-ascii?Q?8uDGqFTiFw/krCzk40l5uTsOijA0V8je+DcM4iPH9iFdvvIHTgR2hDjRnNHh?=
 =?us-ascii?Q?9+0Bez3ss3utgrgOrFzmNWRoZWVsXunyt+/hFXD2i9jABJPpDAtV7cAnJXbs?=
 =?us-ascii?Q?+HlwidThsFXoElptapoMFBiegtEPovOSHYox3y3QR5ijMxiAlnHF1oOngeZz?=
 =?us-ascii?Q?iorT52UEHGw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmUnbQ3fwq92oS4hjJqjNgH/3VdTgCLxUE7nJt5lwbwgxmwc+Au9bNNoeM+I?=
 =?us-ascii?Q?QlsOq/M5C40+CbXxyjyS/hI6T7vz/X4mBpfyQxjpDZme0fA6EB6wQePqTvSv?=
 =?us-ascii?Q?aIfUwUPMqXKLkAomXLXqj3i8NcT4A3eKoWxQfA49oBUjppRbD31J6ZHLQELv?=
 =?us-ascii?Q?AFOIIqmbA/1JbOz/AuNsrhBXtTsNMkLK35SpZDbETzwFwGCUb0RAr19E1GPY?=
 =?us-ascii?Q?66EeI1eUxIMuPQJzmK/9Jb09FtxY/ZLTNJPrqclYxF+OcbxE4ZuCWkDV0ss2?=
 =?us-ascii?Q?7phSHjKSGRMrIaLv1kdfeLVy429XBBROL6F4OEQFlvuUK/NnDgjl4P2+B/2f?=
 =?us-ascii?Q?kGLDuovR6bCxBgNm3QKLK18ZhGOiJm6xF95l8ri2vQ/XhFylstI6c1o/LJ1L?=
 =?us-ascii?Q?UDj6ZgSPQXu8OO3mLBtPBGaFO/ZOkTiLuFcLpf3CLY93QqRkrtOjihwiNbM4?=
 =?us-ascii?Q?bY08xUKLzVCKfxiko6Vb270tCGhdYDTehMoDv/n16G8+szsM/r/dHlTcctVg?=
 =?us-ascii?Q?GScFR/oX9QsVVTbq5EkbJr8Zn+pEmJ9scZkrGNAEkLbv+6lnOJkIz4S/J8G/?=
 =?us-ascii?Q?lB9mSn2iQW1QiVyL2bRuzYa1+tShhJbDtOrXUQR1uqlOO7AA3RBjA9I/+BK1?=
 =?us-ascii?Q?qAAveWZlOGPk6k0LoOeoTHFF5yZFxwHipIyqwAhU43texNG2R+UEKygFT9h7?=
 =?us-ascii?Q?qrwpGveCrPTrTpsYga75gNqRZnbghmPr0i6TA7+pb98vrDLTryFjsREX3yYI?=
 =?us-ascii?Q?6zZaxZ0QTDLTIEULX+wW+cjwdcZINgupSaRUD7Y26JWG2AvmXJeRlCb9P57o?=
 =?us-ascii?Q?fN9epRdRMAFggiRJnJcBlZEDhIpRKxGf2ALypXTy7C3r4dFXL8BI2h4dq8ze?=
 =?us-ascii?Q?5dNRxFmgRX7Di1Suld5fCAiDmhGn+E8BKEYu0BTBZStVy0sNo+V3TYK9AYUY?=
 =?us-ascii?Q?VTgySpmFkKTcRr1xe900q7QZObULJlA8OPZ0U3d+kIhDZPIT9k9+I69l/Plr?=
 =?us-ascii?Q?dgo9gDr/SyGfKmaXCrr4mxKlfxzJN9eWOfKF0HNErWxANGUb7LfM8zMaNJf/?=
 =?us-ascii?Q?0cfgvMaqEC6sqA8RpcSyC5/WWP0gGi1Ds1vZfDJUfZZSb01+dCxOu88Xc5Lh?=
 =?us-ascii?Q?UJ8XLyurd1Z84COnpjknwSA31PtAkkqqn6WPwXzIosSLxjAiCwAT1UxuIV2Y?=
 =?us-ascii?Q?5fmSpOMseVceqd3u42i7/5QwLiiYLk+qx9sOl/xjFjl/Lbf3o+aF+PdXnTwK?=
 =?us-ascii?Q?/lcl/TlNeeN82NxqyF51tB7urp09bA8staWQBWGj2wvAbyblBNnum2kd1G8E?=
 =?us-ascii?Q?HjebPLrVmH5qn3bi/Fnrm6iayeBJk10x7gJKVccm8puPImBBiqEkN/j0Mcrf?=
 =?us-ascii?Q?2j/FIpr9prqTVssOKfazpv3Nay8HcIxYe3Cia8UebX3AOfao5hpG9AcoAdtg?=
 =?us-ascii?Q?7jntgEqBxcoggdk2y5mB2wkT8WqpzkvI4IIag3F90OyYoXmWVtdN/1fti+NU?=
 =?us-ascii?Q?OA3ppS76S9atq1n9XTrbJr5CKVPOxwN4dg3t1vTxRp8r4ry82WwMqyjK8rk6?=
 =?us-ascii?Q?gXEMpYN4d5RTSoK/3SahkBlh9ApJP1prhoohWlMz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487a09f9-3794-43cb-a86b-08dcc2597d42
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 03:21:19.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IR3zfuvhX8ImGdjlCsXUhM0PL1STTHLd8mMB4NM5Pv3aYoEYCzdfsdTyhL9o2cAiCgotvGmrkdOAn06Kd7vneQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5484

When copy_from_user() fails, -EFAULT is returned without
releasing the memory previously allocated by kmalloc().

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/thermal/testing/command.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/command.c
index 6771eb7b1..7868caee3 100644
--- a/drivers/thermal/testing/command.c
+++ b/drivers/thermal/testing/command.c
@@ -151,6 +151,7 @@ static ssize_t tt_command_process(struct dentry *dentry, const char __user *user
 		return -ENOMEM;
 
 	if (copy_from_user(buf, user_buf, count))
+		kfree(buf);
 		return -EFAULT;
 
 	buf[count] = '\0';
-- 
2.34.1


