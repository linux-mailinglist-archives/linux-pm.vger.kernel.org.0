Return-Path: <linux-pm+bounces-34601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347B5B56819
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 13:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFCD166B81
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 11:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F08C262FFF;
	Sun, 14 Sep 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JVoxrhtb"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013011.outbound.protection.outlook.com [40.107.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4161262D0B;
	Sun, 14 Sep 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850391; cv=fail; b=NRDkPXU8bIMNDYlQjtamuEAZyaK5VZsKSxCg4BJDAVl4CD/ANVUmoUTnkYmELN6w3h82G+YGBhQ1lzb5pcEGLzhPHCzP9wwn94Xgh2ZEgaVd5Y5hyn1+1CK1KTqm80D02wHFJCpRoaFF6uQiViuyiTE5wghUDmOIuZYNlTamEPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850391; c=relaxed/simple;
	bh=PzgeUdcDAiQZwf973Ye+bwqxg4/Y1B/AdzG34eAEVJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyjZSmF8BBKODVbJxSR2WHs2jgfFjfKzbRu4k4NpJ3bYhvwM6jUx8PtWMrPyDFFZZIgcJjyqVYzYbMALz7dmyo+A2IHHAD8V88SI0AR/wc7guNF8ay0kLegaKefx6G8v7ttqZ7dWuxxX712wtEDUAYnnaqJ/JtWnvFixJgWPxg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JVoxrhtb; arc=fail smtp.client-ip=40.107.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWXpQP0xjLModrIIWx9pPiVGO83qAkVDpXOr7QpCbINUdXWJXjZW9iRnUa5oDkQHveO1mdtuQ6w5SUusF3+IybTBGMVdQyePaMfE7WuNOT04efOFX+z2/Tym9NECXGSfPtvvK357OQS6TzK0FKtzJq2vuqnjYvJWiO7FJNWqgAOfYnalAwzRJZoABWncQReztk4En1awr/bZEuWgT1WnBt1beHxh3fBHjIZwkwGVtW/7UB0/Vb5/txPf96S0lbeJYjwwhDSAvuK933XmtjzzLC8X7dp0rdp2Y0nQFlhCCwpPyt+lj3M6OsDPERYfxLJxS/JREVyvM/D5Bv+JBrYWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4DEqlNSMe7bfd6gTLouIZaIRYmPMrdunVngZGIw1/s=;
 b=rpz/v5sz4dqFsdp20ecXDM/gRhsRBWS5WpkK3Uv/ZpwqGadOf9M/71Ug6ggc2uEDI9Hdkw1E3vEXFaSEiQ9Kts6xcbnBEaWL4GrU+k5PpCigajKcUaZU++bPHZT8uGWjhRMc1QMrTqrvY8FO6QTxBO3lWwJGdWLgj4/23+LlmCGWmyFd+HDB2DKx2DybiOP34GoCQqmmeIzpvGHzlR7rhHub40LHbLgQHCkCPeiCfatq2CY6ce0pdcSqaVxjarg7QdB/ZB1NmReieCYIW04HCUi7QnU18u+Yo5Gf4sZHy70tn121Y0SaOivf5FNURzauzV5U1a+kimCSq9KdK9PZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4DEqlNSMe7bfd6gTLouIZaIRYmPMrdunVngZGIw1/s=;
 b=JVoxrhtbVvNkxjaaX1yNis42gqmFEpukrNtG9YU8640cPa1cXvOZ+viXWN/2PykXZFyzBoyjznJaE7XV/22JZhVCjSrBwWGCEsYXOiwMOtTRvsygWPjE0XWR2VvUlZa4OeD8iPkus3iC+i6QzmGwKvIkj6qWnPRYiQbcst5flns2imhR/kFVd3bbHfG/O8vvXjwuTTh+qpuvn5WQl3nGOOBIBGVL4T+IcXzpdD1zxJCyJU0xtDOqxrX3xqo9J6wckiEEg0h57mejVRVjX3aoZhT59QesGTcyiXHe5v2nUrAAtf2IwemcXv1OQorR/cGmSTPVwpUuWYWUpkoXB6mPXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI6PR06MB7475.apcprd06.prod.outlook.com (2603:1096:4:242::11)
 by SEYPR06MB8122.apcprd06.prod.outlook.com (2603:1096:101:2f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sun, 14 Sep
 2025 11:46:24 +0000
Received: from SI6PR06MB7475.apcprd06.prod.outlook.com
 ([fe80::a41:1dd9:dc0e:5cd0]) by SI6PR06MB7475.apcprd06.prod.outlook.com
 ([fe80::a41:1dd9:dc0e:5cd0%3]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 11:46:24 +0000
From: Wang Jianzheng <wangjianzheng@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Wang <peter.wang@mediatek.com>,
	Bean Huo <beanhuo@micron.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Wang Jianzheng <wangjianzheng@vivo.com>
Subject: [PATCH 3/3] scsi: ufs: core: Add support for frequency PM QoS tuning
Date: Sun, 14 Sep 2025 19:45:46 +0800
Message-Id: <20250914114549.650671-4-wangjianzheng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250914114549.650671-1-wangjianzheng@vivo.com>
References: <20250914114549.650671-1-wangjianzheng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::11) To SI6PR06MB7475.apcprd06.prod.outlook.com
 (2603:1096:4:242::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR06MB7475:EE_|SEYPR06MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: ace0f097-c525-43a3-14c9-08ddf38454f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DgIlg1puK5lrjf6jxI+VrNgaYDTKjUTi4OTCw5GiQ6+TjhV88LCj5Dbeh56s?=
 =?us-ascii?Q?BNgBRgF8Gylbsi7Ux8A6f+NH/XB4wuMwDE0Sjf+38N1yVXsScnPwH8CSUEaT?=
 =?us-ascii?Q?frsV7oY1k/uwJu19qzDzChNESKUXuuougFYB7LpNzWvbCJFFsti6vpeeyPpq?=
 =?us-ascii?Q?R31D63Bq9qWpktK6dkiLyRpi84smuyUf3qAwOSY05b1KSVi/7jUalJKKXGSw?=
 =?us-ascii?Q?E7/vLlABhjPpPC9f2J8VPSdt31uolazHtWaBNJVeRL6Eq0xSLJ/Dvr3pHfqM?=
 =?us-ascii?Q?k1FrAK9dsG362a8iwXguIh2FoRjEkD5L7ewl7Uylsy7mPTddQEk2qNHjajAD?=
 =?us-ascii?Q?nfEcuBbLZPLQgs9uR/tPZZk5xDqDzDwwLEb8sP2qgyMCnG553egTqq0GKwOY?=
 =?us-ascii?Q?NEQsF2/cinaJKESVTmWl0ZdgAa4AtShITVNBWmjPB8A4UC53bBfHKIY/yuQS?=
 =?us-ascii?Q?XLOUr68hbYe6t+TZLpbWsH/I0s7TySFZooEyEEXwXaun2Qb7w1dYoVnp2nLA?=
 =?us-ascii?Q?urNwAC0dMoOjgJUxOYF16+6kTJAIYeF6KtUSa0I5XU5Kqj5G3Egeh3p06mPu?=
 =?us-ascii?Q?y2ae6+0cKaA++2YGAfAnsO7V373hWSDdvHe8NQs/OoJRK6NLY8UVsxvKWnJ1?=
 =?us-ascii?Q?012W6HHhCAa3VPOEwPKW98B4M4XMFeYQTkf2WcF7RX0qo+F5pcUzvHpIHoXm?=
 =?us-ascii?Q?ZKHwRf2t/Kf4T31CdUXNhMlxjNDbFALu1cgSrrIMG7qiE7h248ZzLPcrXfv8?=
 =?us-ascii?Q?LzBokIqi2KxXeJ/cE8OTPkcKv7Kcoj5miWHYJzeQLStZAX6bRqIkZxolaOTe?=
 =?us-ascii?Q?AZ0/dZcu4cqLvCn1np8UjB0nnmc8Zgq7EDOudwf/b+wxyzynUKvDZeMCzFXO?=
 =?us-ascii?Q?+HNEgt4p1xPEB9KOpHrOQ1UUj4Xtm3AmJabWNzGjeQuKof6ak2aVaUBROOZw?=
 =?us-ascii?Q?HJGbyFT1t/JHsCrjmKtizn8vAz2+Wf1XZWD6Wk9Uyh69Jr2pxGW5lqBea7FR?=
 =?us-ascii?Q?hz5TdbzCEmGuugSRXhoF1nHm+aUcuzZUMTaerYI71kMZduVNXg35oBUBkbLV?=
 =?us-ascii?Q?yeTL2sMDMkcJffa2aCkT9g125T47olZ7cA7HInf344g/MAxV6e5822E/OOWb?=
 =?us-ascii?Q?wEZB6Jz+YyisoPyqtxcT47Oiw9ElvuoLmqmda4AeksBSRIqImRXwf6x2nK6r?=
 =?us-ascii?Q?n+BQ33eZp9KoAdjb5m3EKbcj86oAeNovEUbw0pSG0xDRwYAMtiXSzc6fGXHC?=
 =?us-ascii?Q?iAewTWIr/1hnz/cQ5UI2ZmncAS3hLBHIkk7CWyjHot6wxml8hJ5YmIrugeRH?=
 =?us-ascii?Q?47ZlU2BM1mLR/ym5gHiuwGhC0falweq3uTzVT/JyaaRWHI+y0PZ8/fhGSFoG?=
 =?us-ascii?Q?w9gmqoDxVCCBKTEjAdv2wl+ZSCXTy+kw+AkbNJf1pRW4prRN6gMcyxTUJTK4?=
 =?us-ascii?Q?dV8n53e4+T8fpZXuNQgxmaknklSRswXJVFZd3d4/nEHJiwN0xL66XklmmheI?=
 =?us-ascii?Q?x05n/itCFNXRrHY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI6PR06MB7475.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2goJRyS6q5Kp5656hY8DHJHYVsxeTDzAocz1/j4pdm7ABJ9k/UbPU5xcu1SD?=
 =?us-ascii?Q?96R16Of+k9HmVb7oxpPeijtNL/54tMF5IHMjkPuNeO+yCt81sJ5ewSTQ++uC?=
 =?us-ascii?Q?hCDeYoh3Z+99V3jyHSUFLvlGNzcxBxWU9V3ynx1MQaXhGK8Wonh0D/+TwlY/?=
 =?us-ascii?Q?s8DyaR+aztzcwWmu33B0ADkHnLyrgMjTWOCm+JNy0qDxjFd5pEhiG12lZr/p?=
 =?us-ascii?Q?lFkkS+andvG4fhUxEsceA2Lp0tm7zZuU0OUKdr8jOu2yD5OuEIdki5K0pWOR?=
 =?us-ascii?Q?SUOG7ai2Tzwzvr56n9jgvc3og4OHo6cP0SL5++bnrslLOglL7zy/fzHspHSy?=
 =?us-ascii?Q?YfyDDsnN9zykaphxHT/2INq7MupLOYIQW+BDwJDPDAEm3U6lJOHECEgwXqbK?=
 =?us-ascii?Q?Y1jjKOjgiB/Wm8U5jnLfTuehg9Ijdt4mtwvpOwAPX9uSdWowXLwc5i2aQpEf?=
 =?us-ascii?Q?WsBLZ82VVBM+KJmKKjP9a0RfuRTCbcMCsz26vsuULZHUJXKCcSLePWrHJ2Fq?=
 =?us-ascii?Q?OU8E/F46dh4xNdMydccH0Z5bj0M1z8aLq++9FqLqSblOJnHkBzQ7jMGwpnxA?=
 =?us-ascii?Q?teMQqgOdDHcsVtVLJEkpl4JVWMveE9D6Rs1Opm/54JPFk4KA+bu7dKNMwZFY?=
 =?us-ascii?Q?Bbhi8E/Dx6S3tw2aYo+ANyq/BrMK34Y1ta3Ssg7KaRU5p2ZtE++bfIrbON47?=
 =?us-ascii?Q?rKDsB86cleyED9s6wbSvwgt8zxOXWujOb0OBZSQb+2bAU9rdGr5AokW65xG5?=
 =?us-ascii?Q?FH8I1NcZkX29VJZhdW3y4D8yoTzubBimbVBqt/9iHJPXZ30qr430En949otP?=
 =?us-ascii?Q?rAgLAp/b4iEOa+Z5XEK6k6Y1IYDFeizD3JBDwSCQLLpbHsgFFsZWvP3LMhFG?=
 =?us-ascii?Q?Tc8RaL6wDfKIuDHHhiQ94GLqGmgozQtzHmkmE0RuFx9eXzjQUZlLykyzLqwg?=
 =?us-ascii?Q?yVcUr421cr2lCFK4qX2vnop8SjpMBmGB4Vc5d1i+4b/iPuRSoj1+uyz2WEcX?=
 =?us-ascii?Q?mRpYhBuf4xgmkHxTDJ9XSalZwU8P3/4uUI0c8jOsXBWjVcskzxhkpLXwwFGW?=
 =?us-ascii?Q?/TpfS2vdaJav12ajixwqChVw9Tg30U7mV4+ZT4xCf3A6y20B0MwK3FTMWjKt?=
 =?us-ascii?Q?8bO0CXwcwFvp991OwtvoAD4Bz3hOUYPVTl2JG94aQkOF2hxSrXegJ7754UaM?=
 =?us-ascii?Q?lN0xBPwheHIKB2yHKQ3jjIcpydrUnWywqdVjOr+X1BtY3/7d6vDA5joKRrH3?=
 =?us-ascii?Q?WNTYPOW6a39fpHu+AYDez9CW6FdfpniVA2rcsTdtTeVvyTH09FPlhsyX27ZY?=
 =?us-ascii?Q?9pICspYEN+QYzYEjmk6trijn/GzspczZ6lZPFzgA6h3c3q7+f1cccqPcGS9d?=
 =?us-ascii?Q?hJzQLL54G9UzU6AgHntEhwJMQ9LY4+0HI0cJkWtVbQCMPCozDW2wQZ37tX5u?=
 =?us-ascii?Q?l+nc8BoDndiEmk9pzdpLKsq0+0uWIAtoqm//wdV2kxjU0WuorDhUBi99DZqC?=
 =?us-ascii?Q?ShEcmn+GyWfvFmtzTJWzl/A6EEwV2xl9K5mFsLlA/Y0qkHfJd5XywGPra9x5?=
 =?us-ascii?Q?xzCPEJ84/PXrD4YexosPku6cbPoAxVHKnIgZUDta?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace0f097-c525-43a3-14c9-08ddf38454f7
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7475.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 11:46:24.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofXNRLp9NwjveBrJ6HxGVPvID3IqOLEJDrAoKpd5L5kDHtkzixDDXlNe6qIM7hAX+b0X0YTmCH1an6RFjlGksQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8122

During frequency scaling operations, the host can reads the frequency
constraint configured in the PM QoS framework and updates the target
frequency accordingly.

Signed-off-by: Wang Jianzheng <wangjianzheng@vivo.com>
---
 drivers/ufs/core/ufshcd.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9a43102b2b21..1a9bcbc9dab0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1546,6 +1546,47 @@ static void ufshcd_clk_scaling_resume_work(struct work_struct *work)
 	devfreq_resume_device(hba->devfreq);
 }
 
+#ifdef CONFIG_PM
+static void ufshcd_pm_qos_freq_read_value(struct ufs_hba *hba,
+					   unsigned long *freq)
+{
+	struct Scsi_Host *shost = hba->host;
+	struct scsi_device *sdev;
+	struct request_queue *q;
+	struct ufs_clk_info *clki;
+	s32 min_qos_freq;
+
+	if (!shost)
+		return;
+
+	shost_for_each_device(sdev, shost) {
+		if (!sdev)
+			continue;
+
+		q = sdev->request_queue;
+		if (IS_ERR_OR_NULL(q))
+			continue;
+
+		if (q->disk && !IS_ERR_OR_NULL(q->dev)) {
+			if (q->disk->dev_freq_timeout) {
+				min_qos_freq = dev_pm_qos_read_value(q->dev,
+								     DEV_PM_QOS_MIN_FREQUENCY);
+				clki = list_first_entry(&hba->clk_list_head,
+							struct ufs_clk_info, list);
+				if (min_qos_freq > clki->max_freq)
+					*freq = clki->max_freq;
+			}
+		}
+	}
+}
+#else
+static void ufshcd_pm_qos_freq_read_value(struct ufs_hba *hba,
+					   unsigned long *freq)
+{
+	return;
+}
+#endif
+
 static int ufshcd_devfreq_target(struct device *dev,
 				unsigned long *freq, u32 flags)
 {
@@ -1559,6 +1600,9 @@ static int ufshcd_devfreq_target(struct device *dev,
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return -EINVAL;
 
+	/* Select the frequency based on the DEV_PM_QOS_MIN_FREQUENCY */
+	ufshcd_pm_qos_freq_read_value(hba, freq);
+
 	if (hba->use_pm_opp) {
 		struct dev_pm_opp *opp;
 
-- 
2.34.1


