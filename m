Return-Path: <linux-pm+bounces-38693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BAFC893F3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 11:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A3A4358D7F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440392E2F03;
	Wed, 26 Nov 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fZA8FBZN"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012050.outbound.protection.outlook.com [40.107.75.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CC326948;
	Wed, 26 Nov 2025 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152238; cv=fail; b=Ojw9AftqCjOXo4KrWuQ9dGp8SYnhvzbEoRJpqAcZV8JV7e7Ye7iJ0yYyKBBEMKivVWb76K+wyI3HmKCiV+NOEWkpqXFaYN2q3YLiGFAIMDiVay2DsskhYnSp4N5PfBnUNdtV729xO4NBNRmOHuzfosK4enCEh1S4KOSGV/cdEgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152238; c=relaxed/simple;
	bh=vgXGGwAngpL42HsowZHjvhe7w5/VTMiy9XxtPtgEwAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AnGrMIM0EvLf/VGbPrF/yFDd4J1+QAVZiBjjKR3qmpgNierAbDW19FVPRCyA1lAZxrVc+Y2HwjfE2i7WA96i1K23WxR8MZP05P4Y9MbfsQyjpMGNuef0getBI+yrdkpQYUUhxSzHKVRWzekOavs+AFvtqEf5LXD5YTQn+/NW69Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fZA8FBZN; arc=fail smtp.client-ip=40.107.75.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lvyg6uROXH1RwGM4MYPvGlSAAcrPre7dMEv3rE4o+09pkf6vJ8JaROSNdxFaslBanYgH5yOUPStuWheMgPJKePiZEZOE+5B0p9TOuyC/9Y4KN6uVyUezMv14Xztib+exZq0q5MP1eVveo20qXFLZH4acmJQ3UV0Ecn61cvPSg1EIiUoXY/TNq0r3SBYTBk1ks5Yhg/G2iZoKfiQhUSZHk/CkdCVcCRzomEW+jK5DOr56+8/0OYTbIuSR2jrV+YKnmV94+gC/685Egcn1jA0U2zb5Y0HIEIoDS6nfMIMgxBpPPaCLa9snGlGnUAgUNZ9aOeUiNYTs2QDHvWKGbB4oPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9zBKL71+UeEg+T9plxHvpCuKIzRfq1uQUOjVba2lmc=;
 b=gch9LJ51j0XoUtgtqaZADi0B3vAAXbbNieC+lJGvV/ek7yRRNJlHkXFOYhVUyqNK/TWb84ROtz1ZEwra2RvIfyyjsXZXBrCxzR8OeZ4jLD8RCANLklbHAhcs2+JIsnFc+ZGIJ9c+mcJq59XUpoSaAHU25lLF2nXVrr2msX78OT3OdaAnVuOyw2JB9WAvmDgN6rqyV9P06xzrfbcPAaE0/VKpcHhWUJBJMpuPrf5ZucZ3jPyfm6iBGKY3bcJO1AItplApPEqHAbdDyqhzGy0OTlnY+nqRlBXDtKiq5VEQs3xI+aZ3BQySuPoDHp2TSD2sC6s63z9UGEquWlZURJacIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9zBKL71+UeEg+T9plxHvpCuKIzRfq1uQUOjVba2lmc=;
 b=fZA8FBZNQzvzWEiLVqP9KrYhADDQXTWRrHT81J4HtMic2wA/wG6drN/uog6JR6GBXK3CIDBM8F5KM2PNHnPl6cDO2j4pzx21+XsY4sJHPLLf2pZ9FOzPOPQJFr836LoVU8xkd4Up0Q+DM5r+YulSZTwCnf59QvlTrQ3mhqTij2R+Agu5p7HVgLZmB7259L6kMFwxABkcP5goNL2+T9AaZzU5ZevzNIuXvlTpPId6+rEmFRZdKH8ENx0xlDu/omC+gVTciLsglMU+QtSgx7IwUMXcf4J9y8SG4ZTJKqoJ6UDpxj0KXppxqultdNQapH+qLGmhDVFvzY2rKGGOG3PDRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TY0PR06MB5211.apcprd06.prod.outlook.com (2603:1096:400:21b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 26 Nov
 2025 10:17:11 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846%7]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 10:17:11 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Yang Yang <yang.yang@vivo.com>
Subject: [PATCH 2/2] blk-mq: Fix I/O hang caused by incomplete device resume
Date: Wed, 26 Nov 2025 18:16:36 +0800
Message-Id: <20251126101636.205505-3-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126101636.205505-1-yang.yang@vivo.com>
References: <20251126101636.205505-1-yang.yang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TY0PR06MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c6ffde-c91f-4dca-67d6-08de2cd4f632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Y69n40NFafy8kGCQ3rknBsgXKJymIJvEbrhuEcX7rczZ4kX7tNUksvG6g2T?=
 =?us-ascii?Q?PuqvymPn8LCvtW9IpmTf0KEWhvwG36aNAhgairCpU2eBNNTd8o8mU0uS7+Rx?=
 =?us-ascii?Q?yhhAFzYLCmczHTzW7KNl4LkNe0IJnshRoEsjiTHIOH81Amj37P31wEs6U6YW?=
 =?us-ascii?Q?Ip/a2OEbSrkJ9V9ImFT8mSGW08rTjYAuqdfzOH3yWvCjnbBkGq42XCCSwllp?=
 =?us-ascii?Q?VQSZzOOGJIvVNFuvtXY+u0UVe18wqJkdSHjlUzuBJHu5aswDOXSm4nD+X3hW?=
 =?us-ascii?Q?SFdLht6AeZt/yfn6BbsO7bH1Zs/7kVamXIuRjLErpJcZhvj7Uw+mtCsqEvLg?=
 =?us-ascii?Q?tRMJe72eRA056hkKH033qPr2pzJA2AuVvEMdFMIZ+hkG4gUyUz56XDPqqN2/?=
 =?us-ascii?Q?Mfl5zWpkCaKWWeccwx9DpyFrljXiL8O9Kexu+hCeQPECvsnYodooLFa4SkbN?=
 =?us-ascii?Q?JIChccZJkDIppW+jbArJjkzNQtyTC2CNo+FTBFCoDIWcaAwJGbLlz4kHwAg1?=
 =?us-ascii?Q?PtAf4P8pP7RwMRMIiU3pt4aR0FzVHgUo4oZ4+JlbxF1lp+33p2jNOvWUDAY3?=
 =?us-ascii?Q?vKmn7Q0LpclyxF4u+/Bi3X2GjrMfcBYy7dqDzC2kX7t7dIDDGeEK6CtMeCNm?=
 =?us-ascii?Q?Uj1hKQmL6E8S4I6DI3EAThcDFAw3TFe5fSKe9bif6D1JZCbw4gw6J9DSXRcv?=
 =?us-ascii?Q?758CCp/JcyQ4SK+zdSssG1QXzdatnd6WfOwGvFwyWA/j96/RoHkYFj5ixdUW?=
 =?us-ascii?Q?TJNJRmCXwf4og2I9Y7DKZ0wQC60WgpyrIg5GlYutM2OXkz6uuDdhlXqVHNJr?=
 =?us-ascii?Q?TC7F/EoFpBzck2u7rmWZhnSNNmnh8HUkltlTMtlkvkxbRolHpXAX6L4TEgxx?=
 =?us-ascii?Q?G/Y9nwv8HxQHfGmDzAl+I61vp0juSakD1qNKFjf7rJH5PkTw0vt55ki8N36s?=
 =?us-ascii?Q?bPZ2A49rGZC/PWPXzkAzMfEqOA3UoFkp+s18gmXGNKEstCIX4NaS4Ajj+lBW?=
 =?us-ascii?Q?ju8JiJQqk/pHXBfkuKD66qpOI/fvrbzETE0cv2BBzsz2GjJByHU2L/iN+Bbs?=
 =?us-ascii?Q?PJh7pOM6pzKy/9whivqEOndhpb/KX52qutM41oUA2ufQPCLDQT31wMoaQiLO?=
 =?us-ascii?Q?kqpVEj6HU/b/dSRHznuV89MO8cvt3XFckYU0h/7Bjwaja61deGPy+LMK9ND8?=
 =?us-ascii?Q?KNroZsXjUBISskDIPsDSyYU1d+RTHxsL8JDykRPM0gueiP+dxhqey4OuZF8r?=
 =?us-ascii?Q?+jqHpe1naLt8BS/W1WM90XnY9Hexkob/he5njlnuNEZSp1EuTQx3aiVsELxw?=
 =?us-ascii?Q?mVXNcKUbFyC/+MSWJckLwVAt1PWy7HoSlDFeboSjuYboyGHm+UdugFx9/b7o?=
 =?us-ascii?Q?kEr+q7jnBB0/I4wgdmLRRi9gJZKse6pf4GirjjfNIlJIMxteJPh9+bt31RBZ?=
 =?us-ascii?Q?0LL9NbwZD9mTgL+iT8z+13XPaFwpPYTUfWkGOfbde56mQFLaqlqo0oAlJF/i?=
 =?us-ascii?Q?h70oVOyNlEaC/3s7qN3xHatkWMoWXMorK+Vt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MlW21Yei4C+IiDFhOKRxqt2a2IaWRe/Q2jAii5i1JMEy234KR3obWxvgpu9Q?=
 =?us-ascii?Q?nUs2o4GlNLqcpqdOPCASWTzymjB1zyzfBHdt+h4HnH5eh5LpFWGLH0gs1rjw?=
 =?us-ascii?Q?43hcYFapcL7Leh1jWtgU4wmYxtZq78d8DVazamD+GQe4jFk+c2VmqdGNIAVp?=
 =?us-ascii?Q?HLsvORVkBb3I2iaz5e0EPZgDbGjYHKphWB8ZoGiybacS4BC5ATEz96gYWK1B?=
 =?us-ascii?Q?D5kIQkFBHwkGbJJXuhJWdYkegziaoDrnVtuFRUXZHqnn0MLYGAJI5hXTg7TK?=
 =?us-ascii?Q?JKJHRKupJdLweDRw++90TQWWusnwd0GU+CcA8UTZRQEcwtHl7MolxvGpIloT?=
 =?us-ascii?Q?h+OHLoS4V0Kc4Jp92xx8tFAXImwXvgpgnGtxmCWpzpNvbNm0lhCnNYLeF+e6?=
 =?us-ascii?Q?VzisFvCpQWwV0fF7EVbcV+8JuxhXj9cFDS8DdXjYhA4uaCPKMhi+XOLAmPCf?=
 =?us-ascii?Q?/NQL90+NOE/GtptsgJzuZPa5F3Xp+m03QqtQUMYMBs3UMNTgYfBRQLSdoPh2?=
 =?us-ascii?Q?ta8e/BFPXcQqIxgBmH3Ibr4mSUMRj5lrtj9jekBTdgAsGUubh+Wzo90Oj53R?=
 =?us-ascii?Q?16lsslNOuief8JoaWoGG1FdxfXAzQe/VN8eP90VIadwyvMjnSlHy13M2i+pi?=
 =?us-ascii?Q?Isct1foP3XqHIyyd9RneOXsQqyXm2MqpexX5pc3WzLJgWOMH3kIihS2+yEbY?=
 =?us-ascii?Q?brXkFLbPSyZPd41yugcz5FrZaoGGYVQqIqKWRe6sY8whFygTP1VQ00ajW6MS?=
 =?us-ascii?Q?pGTUbEGCPwDTIu3u29r/9Ny3QNCUaI4Ys7B8IWT1Sr20rU4NOPHmrW/tlBw6?=
 =?us-ascii?Q?aJ4PS78kWpi3DFYwW9jlpvv4Znfv3GeBg+PkdqOqjzQvpiRdGk3DUdyVcqse?=
 =?us-ascii?Q?JTEeKv6YvlR+2S9CBoX0DQiujfRm40eiHm2bnJmL9SF/d08YNih3sArs5NFF?=
 =?us-ascii?Q?gUIdcxYy19uCLyS8FeQ2Jk/45Xp6gnSKU3xDirwEX590rlNF0jmJzLq1MDaX?=
 =?us-ascii?Q?81m6Tjn8aBtyZ4Z+8LBQsheJV5+ZlMM7xctc1pgqAroGWCOKj4kudtiZfjkI?=
 =?us-ascii?Q?Onz8RYBlBf4VH4wHUd9eNgtbPSyjLcN2LnbPvzuxP+v8kgQ11NfIwn5jkVde?=
 =?us-ascii?Q?65xg+tC48zZ5gwjC0e68TH7klRfFZg6QLe5dpkoMxP084iTDIsZzVz4eXAx9?=
 =?us-ascii?Q?UWxYYtyA1CV4YKwEswaXkKBw+F+PbPV+njxQRX+cRNNDU9z6VPBN5xtnU1Ey?=
 =?us-ascii?Q?NbX/B9TuL36Wrmd5ElffEGIJWq00kwmzGcR3Pp/9GyEmYvvwa3obu06zYfVB?=
 =?us-ascii?Q?lIUdNDzsURrc9YtSoNGrHT5TOFr9wmWJtwS24gB9y3hpMVlgqbjbvzA7OYhP?=
 =?us-ascii?Q?GqYbKLXda2k7VMX7lbjhUAxN/zArByEZsct5fQPMNlD04bqVCRqWqg4fOo/3?=
 =?us-ascii?Q?UFYVv01mIFlWawev777mtb92wYMWwLd1/pDHLLkoQGUcFC3+4tyO1njFZ2+Q?=
 =?us-ascii?Q?Q3fFi3COl4B9CXWX6JFOWYSHWGu4zCgKLAuui6dX7x/zbEQYj1K5/iE1+LnD?=
 =?us-ascii?Q?SIY955es5FAQAeYgexUB2GYRcagDfzYRI8NsTVXL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c6ffde-c91f-4dca-67d6-08de2cd4f632
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:17:11.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwsg2vbfWYAvMR+AEvdeEvJp85RsqCFP249zP8g+byhnNyDoSfJOnLDB+AXQ9ixQlPE/HTKrQf7nR/a/yYQ/7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5211

Setting the force_check_resume flag ensures the device is resumed
properly.

Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
 block/blk-pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 8d3e052f91da..d23918fbd59f 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -28,6 +28,7 @@
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
+	dev->power.force_check_resume = true;
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;
 	pm_runtime_set_autosuspend_delay(q->dev, -1);
-- 
2.34.1


