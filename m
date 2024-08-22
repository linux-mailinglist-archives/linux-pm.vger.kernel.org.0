Return-Path: <linux-pm+bounces-12695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F9895AC0B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 05:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C3828271C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 03:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA61A22EED;
	Thu, 22 Aug 2024 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QpV3ydSj"
X-Original-To: linux-pm@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010050.outbound.protection.outlook.com [52.101.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF700125A9;
	Thu, 22 Aug 2024 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297968; cv=fail; b=FFbXarkgnNHcYYNIWaO3orFSB9ksK3gK7oEu8TuQYyR392yWXwgKi/I7tWdpHXUH12eHa+MIGt6OqhSlXyG6Mxlfu5mCW/PTdiPmsddJdsWNSQKYMEB8DgPMDzB3ahLsKGe/Dtm6n31mYUsvUCwAMhPxJKUyZhO/zk1Al69K0tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297968; c=relaxed/simple;
	bh=WC8wm6lOsFcUCsjiakqMOyMiH4D/slbUgZoNbJk8bis=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H5+VqrraEjlLg8BZUOFzIYe1MeMnAWnGTf5R6cg6wvg/p9cuR9hKpNs1V1WdyTucjVPdoDnnLPXZoTeUAfq7qnh4SlUboFzt2/McyIUhzavVmVnTNVVXE7KBq3ff/EVRGmN0Z2FDYRyBDnbognvYWsld/17QJm/g1X1gaGqaDy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QpV3ydSj; arc=fail smtp.client-ip=52.101.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhPDODJsixJ9LXmYCe6Apvq3VjOddklF7h0XuMzXV3+bMhXL8u3zT3GlnA/IzvFugq39WZohfiYfCCpPDSaFdVMEp8HwnouNb65V16U7oDxNfOv2vUoXQuP//QSp8ZvAUaCZbm6sRMmvwxY0BFAj35Q+ZLO9A5ZM+TlfsJ3qewiT99hz4D8A+SSErwXoA8aSO5aKp9PYqU8gp5CfvZHJGLe+wItuKABBlt2za6MLEvNelI+jrcb4ZI8ukptuZ5AU9ulxrIR5KHwhZaFhFcx+aNsuBo7EjdncmDeip66w3+8dd0h2rKcJ86y+oQg7uwRnFE9UYNBNmbdY+D2myP7kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMlTdQ5VmLcFhnwe4bxoxDRBs0DFujJHYpZfk39r2aw=;
 b=mmALUKUCXmIiT9On1F+DXhXpmuczVzYAkhW4cNhz3gV262y40RLy0c7Gi2Mz7iUhEaQVt1p3s5od5kOgOHK0XIGA89PHEgNdlqdbvCF7JTac4hAVj2A8UjLhV73AT4kt9BvqPcYXYhHH5iXLx5+h7rIK1NF8yjpupZnCWJx4AoQes7hAPGce0FBtViFbgD3NcDXtSaez3tLPj2IZQ5ewi1SDdQA4VBb0lQi3wLTw9rsbHfGvGQavvErhyx3VQUGIgLur2SG6cctGU4iz2W8ON+WBdLam+3vu27x3Dk5A+75mWhz4U34E8TWU8WvH7xCzazvFkbZma/LsGNu8q7YRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMlTdQ5VmLcFhnwe4bxoxDRBs0DFujJHYpZfk39r2aw=;
 b=QpV3ydSjcUeaRDW0SfxBLjKTYG+8+JeTXE71QriKENXF9Sf/uRq17mp1E2KL+x7lvy5pd1yop8Gqu26ydCqfMJg18dzrSUpllzjDao6CUxOBRDkspf6pXbJBLb1kkQ2vaM+ETAcvgY7ZkH94EE8lypEwBgQ0MWCwIkl0Z2DDqncfdnIbTqZp8WrtP1VVJ04UMxq8l/LNMcK68qW0dxc9EZpyXm9M9+JJYW7ckA5/PMvdAMGEh2bOisO/ojlYRMaBzof0EZ/JeUNOE3OpGnQ3ZpT9WBNM/+TRrvayvXamtGxYClX2FK7rjBnm5fjdQ+aMRh2B6hs95buNO5LNq20eXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by SI6PR06MB7243.apcprd06.prod.outlook.com (2603:1096:4:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 03:39:23 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 03:39:23 +0000
From: Yang Ruibin <11162571@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yang Ruibin <11162571@vivo.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] drivers:testing:Handle possible memory leaks
Date: Thu, 22 Aug 2024 11:39:13 +0800
Message-Id: <20240822033913.1240040-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::22) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|SI6PR06MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: dde97606-0703-4e50-3f16-08dcc25c0386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?djrNoKugkwHB2Xa+0El8d6GT3cy/0z7+8UhLWi9uaPoXbmXD2XH0CPdsNbeJ?=
 =?us-ascii?Q?0TXnSzt5IoZF/7+pjUYfRfKaJtKlBXJBoetMaKbhc4p4E7+OSRt0XAHsQ14r?=
 =?us-ascii?Q?aBKU7TPqBsndbsBB1dsMuzVPeY7xivRH613qWIq11EoiTmpt6Lz8zXg9Vx0u?=
 =?us-ascii?Q?TtuAWofa4BYNSwbhRSbanOWWcgcUo1WaoCvvILsc+Efqzh6toS6rtxXiqcJq?=
 =?us-ascii?Q?mt6RBljA/es3tv7N9bYQ8r8WuQ2Orvx1wHme6RA1EynIYmrdKxIEChYMA0wh?=
 =?us-ascii?Q?Oyp8758+SwPj0+SbzdX2Z+P7R4Y4Rck0iU5v8MAgZQzUBzDmzc46X5/Ncqhj?=
 =?us-ascii?Q?gARTtsqRpSKBbBi9XVaoFZqVvnQcdeXn/gtqwJO/ZRTd/48qR7OdWCyAhjk7?=
 =?us-ascii?Q?mmCDPAlB9yoSEJy6PTPQxjhMfLyghs6TEa80Taptv8Rx0yloOEve2N7JacaM?=
 =?us-ascii?Q?XN/B3qXQwntiUTUpl0RPjBVyZttppWlRMkGr9TiAfPA47d698jWpeZyUQT3Q?=
 =?us-ascii?Q?w9WvKiHQIL0WN46parz+DIHkYWPi7QQ02KAAtdl+MIHiYnaKdPJppaTP36vG?=
 =?us-ascii?Q?tzz2VZl+Z3MxcDfIec8+lmi+Bxkux5S997GSbYn/e8p3d/mf2Q4jV13ZZce5?=
 =?us-ascii?Q?DPLAd3gDsa9FIDZ+R2op5VW82HW0hKhTicfJyk2wlC3b/pOpe4EVCyX9Z3A3?=
 =?us-ascii?Q?nruJioaa0I4G/WlixMfEjj8cTqqeWw7y44xo6j06aofhXlPhH+dnX7IwzzDG?=
 =?us-ascii?Q?mCwMynab+j3v6hKDzenjFbFfznwLXWFcA4olqMvduavPGLWa4YheBwfCGGMB?=
 =?us-ascii?Q?Mwjy9VmlrucWnU4R2BbFeUs97DbnQCITTbNcSUFZFTH77qI9OOoPbUMPenIy?=
 =?us-ascii?Q?PlmJ0c+UdSUAEOhcrWQenWcqOQL2UFqAq7HokyLiS+kgxpkd1dPZXKUL2mUV?=
 =?us-ascii?Q?ahz8LfBtwEXOveHA+SIt4RF0izkQ7nXxTRaFn6KmxFpj00YaR2hJD+TTUcaT?=
 =?us-ascii?Q?7OjbZcl0C8zfTXOnAqhWYZ8cIAVrNdjLwg2NSt0E7ltDk2scPKLq+PmChHd5?=
 =?us-ascii?Q?n60vx8irtOdZgXOdeKm+mlOed8uMhC1X3AO+2Mi080qw5aynsmSIpjRwLBru?=
 =?us-ascii?Q?dYQVpF0ecoVniJdYjxYs0mHQlqDvrzQ0DwZ4UIKmM2/R7QkGSIYiA5pKbqON?=
 =?us-ascii?Q?RP9jSjNPqa7Yqf2Op+m1QZyVHEP9HwRZkV3jcNur11e+buzNKJdy5BWkFc84?=
 =?us-ascii?Q?W8qNoBLVydeOUllauPr/eDMkyhOVW9QWA4Na9qUN5jQ/g7NQCkgR1jREZmYM?=
 =?us-ascii?Q?jB3gD8oP+2jDFFQ0lH2tEh3edhDw/wVX71qwmEms1M79l/+l+X98v22tqYsz?=
 =?us-ascii?Q?CijkVnF1/4IkThlVR5jOgivqbQyWJSRqIVaWfj/mjEIgQUezApHAj0r8Dfky?=
 =?us-ascii?Q?kQWiORrsTY8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hFTtnsNty1mGZO5xY0Zmh+xHuUk5X7wHQQQhbJEYQA9TNos0nf+RnVGJx4Kd?=
 =?us-ascii?Q?x5Ye+0+32DsWwEsEVGxT8eOMMeLzycd18LNT/XmVSIcdXoSyuSlLcWvAFU+X?=
 =?us-ascii?Q?oLGCChI46Vn9Jf7gEMpc7mfyPY/M+95wkao4T3gwBt0FH5T7y65BozK0aTpv?=
 =?us-ascii?Q?62WDe69lhycIF+U2sXLGON+umDssdzJTmkhBisf23mXZYBdVPVIjF9gfBrAq?=
 =?us-ascii?Q?+trhYZIYBNW+OZlhbQefDqWQX/BkLLBnc36r8f/qAyZhBmrzODKLR54eOGGH?=
 =?us-ascii?Q?TcVe+Woc1XyoWRQEefTUnWA0GepeVl0yn0WZZIDRkKr3ODZV1owyDHvmLhHR?=
 =?us-ascii?Q?KrTNo4X25mscY9ngOkt3Phqf+G+iBCmTaBS7tcgGE5gynTcvtgkxk3xTO+eR?=
 =?us-ascii?Q?rfw5mCrbp81xgrExi91YZMaIsmMKmoVdE9+HHwiVoZVlaawMGK9qN1/DW5Is?=
 =?us-ascii?Q?bpLIRbK3K4fAIxuPpqm1V4vTScL16UlqZZu4Bt8Npj8TY0R3DxLx7hCExP+x?=
 =?us-ascii?Q?RM6WAvf9QuBellrYGmxI1o8IE4d1LT+EUaHrBix5XAJy8PWs+yKKb1HIB+rB?=
 =?us-ascii?Q?BREjEgT4YNIDPJHgdjASchGcsszhVphJW3BE9s2yI2k6w9zmR7M+h/UfL75z?=
 =?us-ascii?Q?FSNRU314wvBz9rT8Pa4OHVWxbZs8IRMntZZJCtigh/EpaDLcsi7zjlosV6xc?=
 =?us-ascii?Q?91RLww8CPEqqV0EZEGXZpDqAKNykH2imQ7cC7Ojmj0TkBfmzZ9hIKP4IIeVH?=
 =?us-ascii?Q?kv6gsYMdhgczsYYGKgFzcPs3CPFbatkrQY209Qw9c/4wIT59K/LMUsIaJZ6O?=
 =?us-ascii?Q?y4FFxKHaiBnvN0vruGjINHjpP9S1KOAIgB2UBcUyEXa2IU9+P22Np1bKG1/0?=
 =?us-ascii?Q?JegPEMFI6Cnd04NClOALgZhD0Pfh+tPjlYMxf/9oYmWAngg4XWhwH6nGQGBG?=
 =?us-ascii?Q?O/X+FHNTN+fABFjGfMupb8q/sF2cRnK6SC7p4o5eeXbyRc65FuNOruPUrP40?=
 =?us-ascii?Q?ohV2ipEA2F6L9Etz/rtfIsLC6d9kBOGLFbNhMQy2mwaUbWI5tysR0YGe/Mso?=
 =?us-ascii?Q?sFHnluC0N5KNvl32T32uPSQe93DHmyGmbsnhOYul3vDXzjy8/8ACEuXY86RQ?=
 =?us-ascii?Q?B3naDB/siwEYPfkRAHWo2q40UhIxR6mzaEB662nWfkiAj0sNsF04IEbmXXNd?=
 =?us-ascii?Q?JdyBzkhIprTBFPzd7ZWY4anpTni/WcQhnk1SvgUv3ZCpHQN5JzCGbi5SZZff?=
 =?us-ascii?Q?tEQoxWcvZN0/BR6qLQrVNwuG0PH43/+EgmQAdlrFTsGWhUlnbWIrIXLverfS?=
 =?us-ascii?Q?n0L+dGeqhFrjOnaQX+BRmPDNWoz2rO04KoOj5G4JS71fxMOHxV4JJuOVbEQl?=
 =?us-ascii?Q?s/TVHFyNcwXEM4sdKskHqr51ojWckWqymnkvCmTzJi4SqV7G1sa8B2HWcY2C?=
 =?us-ascii?Q?glYlieU9qxMz0APEzT+RCBFk+u5w5QWdgsT/DTJPIX/WmYgu+1T4DNclXiDo?=
 =?us-ascii?Q?G2fBdpeYxTc4duk3vpUKINvm5bznELGpg3Zf+ELrDI3X+gAaSt3Fjdn0qtAz?=
 =?us-ascii?Q?3D6RsgrVZ5qTeKoxzjmVsW5cth9L0h1Z3mmdLt66?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde97606-0703-4e50-3f16-08dcc25c0386
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 03:39:23.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpclraVjxS3iN1/WxqjiKmBPTmhD5jS0ivS/EOMzrIJaPqI5MGddpO6UqmCQUQbA/ICq0e7urPWYuQ33hOXBNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7243

When copy_from_user() fails, -EFAULT is returned without
releasing the memory previously allocated by kmalloc().

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/thermal/testing/command.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/command.c
index 7868caee3..b95bcb94e 100644
--- a/drivers/thermal/testing/command.c
+++ b/drivers/thermal/testing/command.c
@@ -150,9 +150,10 @@ static ssize_t tt_command_process(struct dentry *dentry, const char __user *user
 	if (!buf)
 		return -ENOMEM;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (copy_from_user(buf, user_buf, count)) {
+		kfree(buf);
 		return -EFAULT;
+	}
 
 	buf[count] = '\0';
 	strim(buf);
-- 
2.34.1


