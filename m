Return-Path: <linux-pm+bounces-34600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C8DB56813
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 13:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3EE189E29A
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6BE2494F0;
	Sun, 14 Sep 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EGGuszEJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013058.outbound.protection.outlook.com [40.107.44.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712AB24679A;
	Sun, 14 Sep 2025 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850386; cv=fail; b=cCSMFBf6ukM0dk6px2jCk+hAIFoIptRxZTLK9AEGsk9tE2/j3tYHGKd+hPKaBFksR6PY0zDH2pzkOp3vkGYw/gFZG4y5/s5THQaBIU+kPJlqfs4nGEPteCW250GXtkKv8DEFkdiirJ25ud0tg8kFSyWthu0mXxeogeE2eZbpvmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850386; c=relaxed/simple;
	bh=aRzA5WhTmfdq4eL5Hsabj6023ewXrcd24bXTCEd27Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bs7P0S6oD5rvXHk0r4f67QP3/wDQq+lincqsoNn/hnMmOdO+ga2iG34Pr6noWCbfHNyQJfGHlYXys3Q0miJjNNG4XPEhc/aADE/ruYLUWFRFsAj4KA8NvO7yWZwfFcQzctWT5TKT3Isr0PVadBeQhCKLc0G+lhhmx7PyHqMErT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EGGuszEJ; arc=fail smtp.client-ip=40.107.44.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVzNB8ePEo5lGqXvknt6acNFjgJfdzXjHx4QAGxy+TruJFZ7m7VDeg9TZRIcYeOIIP2iqLbJeWDRtJARPnSjqrNekgl4oklh1LbZ+d42DPPwuuIWIn2QLxo5S91ztFvg/rkoL/LOD+yrpK78O7sfN8Suod4HmnKT+W+KcIUqGomjYzJeAUujaFmtJUU/1oXF2H8xR1U2IpjNoj4lZZkKwiFyu0XgaxWDZj+2XazCPRIWwEsMDfE41NYVQ/90k9ykQGPS53W2akUQTrkK50siSt3Q3VjwS6tvgCGemSvFMVSICw7PQ1ez16PTwACjL3ExnXTZytww9q3BZYHv+Hb/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnufDJFbQkKa0CDMbVSX3u/LcIBX2D4wJsRXgzAdrFo=;
 b=Qg1xUuWR3T3CPUDnRuMMBnkBOyntyDmIsr4iJOX7yNVYUKrDwO+vxcnC7uTsaBFgyH7UFQHYgV0HELQ9m50cuXerKCTu5w+8obLpHwY8uJpqH41ktPmMWuyjIWS2D30OIj/rcmsimo7fDLH6a6BvlrL3oY734yKvixFkcjibyGgvK9xSueD1jdJwbAPunv9iURU01emJ6K1IAtvT0GZpiSGG9uVr9YHLj1vmzajwG3DdidZ8zptA7A73LRMlvURVDTnJZv9XmDsI3sGopgi8yF/2otFwdjUjHcJ5YAkPTWDJpH/iD+nCVRvCjUyvoXy16Ibpz0hnd3i5HWnvNYhJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnufDJFbQkKa0CDMbVSX3u/LcIBX2D4wJsRXgzAdrFo=;
 b=EGGuszEJDjZIvQHtoBTZIAZGpwRFIV1Jeck3YHpYeYm9YHm6gH3ZU8XwJfYWJrj5/CAJqkB09oSJcNohrLzRS5aa8inpZFvgqj4O/hH5HlbFSv6O8UEirohL6P/BAZghyF/72mI2a5+F8nHfh54lQSNx9dnsKcjFgP7aarzNmlLORtas4h0vtxmKWwxm9qlnFnM1O1xzp7IK59jnvkDR1VB3QY1roMIPDKiMi3L1foqnHGiDdFt/AjWjHAa7E64O4Rss3zyXNTt7yyG8NNsbzLysTZrH76g7fD2W8Dgm70Tku2iglHZJ5t3YmBEwK2/qKzyx6OzC55W06F73qeNCrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI6PR06MB7475.apcprd06.prod.outlook.com (2603:1096:4:242::11)
 by TYZPR06MB6045.apcprd06.prod.outlook.com (2603:1096:400:33c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sun, 14 Sep
 2025 11:46:19 +0000
Received: from SI6PR06MB7475.apcprd06.prod.outlook.com
 ([fe80::a41:1dd9:dc0e:5cd0]) by SI6PR06MB7475.apcprd06.prod.outlook.com
 ([fe80::a41:1dd9:dc0e:5cd0%3]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 11:46:18 +0000
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
Subject: [PATCH 2/3] block: add support for device frequency PM QoS tuning
Date: Sun, 14 Sep 2025 19:45:45 +0800
Message-Id: <20250914114549.650671-3-wangjianzheng@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SI6PR06MB7475:EE_|TYZPR06MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 57eb2a89-ee3a-402a-d58c-08ddf3845181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XJzj7udZz1lQEswIuCzELOV3xLVZk7TNSXRj5w3vmLwYG+vDfhQxb7AUssbI?=
 =?us-ascii?Q?TvRWHFcn7uF0nRFsECPrU9RNY6nym7+ipPMbpD2rUK71KhGkrAyFPOEV2xbF?=
 =?us-ascii?Q?dZxHPI+AHFhbyDwiqsh5alw5YYpbgYKUpzo37Bm9Bl1/dBU+7Kom5E9PSBam?=
 =?us-ascii?Q?n5Hfd5DjG02KlDtLVR+brwShK4dGd+TXXG0upwuJ++RdS9OWb56KF7sCOTPm?=
 =?us-ascii?Q?Q/dMLHs9xJPiQnPv4jxwkZipgNtEEsn6Ui1vMxANdVcLOSEdA/umn+rrunoF?=
 =?us-ascii?Q?ZF1m7m+/kg8qVBp4sdXD9YuRfwPF2DusypQMa/fuaGXVu9DFyZsGfoRhXZjb?=
 =?us-ascii?Q?fCXeS0FPVeXiZ1yALx08lhY2MyUjSi0/OC1xnEvsXpbjw4uBvfUidAgpg2xS?=
 =?us-ascii?Q?yJMQKUwIyScDeayfZKhfnCLbCe31xTv7w/JLNJWmKuPKvToDzrR5jVuLkRpv?=
 =?us-ascii?Q?3ZsVONkEQsP1rwDQxBj/jEW5ig4OHwFSWSUy+ydiyY+KouLY1esv8fRiyj1N?=
 =?us-ascii?Q?kP/lMex3QT09MgqRkhLq6M9fej1BeXyellHhdj5eYaxCch7pRSjaA8VYElGX?=
 =?us-ascii?Q?GIgqwpiwRSLd5Jko+IrC08Sjd3zKnryk0r0StmsYO1swIVqGqhpLILIS257p?=
 =?us-ascii?Q?F9Zx2sYHXjF3y/1ddFupKT0Ie2RR2usiqXN4b3fhY+hTxam1pa7BoXdbQMuX?=
 =?us-ascii?Q?EpcByNDFLv8Rc8iV1ZqBMiBe0cQ1WvSOC7nbvtnmklHmt+6xN3KvkttfTkcd?=
 =?us-ascii?Q?evciwXVtm879Ml+7kJgo5ZdZHm6jvgNhhkKrZIslWB0u4398Zg3PwI8TeRJ4?=
 =?us-ascii?Q?WcQQcfmCxloDBdblAkwDLnj0OkUuIKG6sSOGHMxMfyWpWNZsAKUvR5FYxxu0?=
 =?us-ascii?Q?a0A3Hm3h8ONurO1mssNBN13+BpModUOMLpMEetl7vy5JhR/1MinqBbueyZcX?=
 =?us-ascii?Q?obpRKNbU43lW4/YiuWXHUm0YPyiQgdRyBvWjdXSJ39iV73ClwJLLb/k1jr8x?=
 =?us-ascii?Q?hyFJoecxNczSOcum3A3Qx77U3d8cwhZKX03BMl2/PBh0z5dhpRnGmqHgBJuc?=
 =?us-ascii?Q?5+sCd3atmNQKLli4jFysXRLbQWuKSKoMS5IywcDdHk11pe45wddXN01eynEs?=
 =?us-ascii?Q?WlJD+R7nbmMtmf7rEn2l041W2WhdLBVW39u/WWw32EmCcFytkzdEKo2OSQKD?=
 =?us-ascii?Q?cLb+yltdOFYXMH5HtEbH7eWlFJrjk5/1bosE7hq5IGCpItb3dR3Xs9ZqblFM?=
 =?us-ascii?Q?dGLPMub1OsqUa/Tqd6XFLjEV05rsfyNLR1BLH4hMRqtCSQC4ZxsrSmGzbg2/?=
 =?us-ascii?Q?MoVjiLY2josdKmaWYawP7iokuWQ7E0ZHtpUKSwOPOyAoPy7DcuxVKaFgPPFb?=
 =?us-ascii?Q?Nam8hjGZVb8zsr9L5ZjW/Cpp47Wh6K36Hvb0oIe4hJ62xYVg3p+JbCENa3lT?=
 =?us-ascii?Q?z1Zr1ZS9f77YtxgKT5UQx6rvRhOYV3s6NMH/aiebFyU6g6EmeqjsJbtMIywo?=
 =?us-ascii?Q?teWQl7VUXEsZdWU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI6PR06MB7475.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cfbDkMDpngigMCYIUT+Iz8vObmWAP/eNZWdErfCjuKBFEw5/aFy1N+JhkvHj?=
 =?us-ascii?Q?u7fENPoW0SXucy4J6mJgyHgYHqCuGdWEaalGzYNyL7IsioQ5nFcUwaUIRXrp?=
 =?us-ascii?Q?HSR0gzp/TK3+q1MIWQNFwkeCyEnGZyrWF2XOxea/doTqdNbyw9x8Ahe2Kdxo?=
 =?us-ascii?Q?3jVFdy54GdqC03uTVnETqOIsqljVF0Iyuy6mA5aOm/45zWG0NenHcKcVpFUI?=
 =?us-ascii?Q?UZjzDdrdJ0+7q9cHKJt09I0ECD1IBRA4QjYzqfMe5PjVgQmECeoAJjZ/9eAN?=
 =?us-ascii?Q?P/QhxOrGDi9UDNlW7WqlaP/PEJetS4lRR12UmNRz9sS1TKXytQk1/7wYOpRu?=
 =?us-ascii?Q?UbubsdDJSkhWh3oO9qJDSjbIywQbzXeROC2nrk6NTSWC56wHXX9ZIZNOyMPz?=
 =?us-ascii?Q?sh+8YKELFjks/HI1AxT1E/kFDkjrfd9NYUjxOxWozfUNluM0bq0QQC1KLXju?=
 =?us-ascii?Q?X67HpHCcFAg6Q4xaaq5rJyZtptFkCFSoeR7e2wFfc3xsuRmekWlqkNX3CPb/?=
 =?us-ascii?Q?3ilZ9iLHE7/G74qZlYHj2gjtKW7PuEq7aOb2UTqlAi1Ydy59RPtxeurjb4ts?=
 =?us-ascii?Q?GuDJ42ZaS/S2dhEOydMlNag6Z6fnjO54+yXXLjfIDuYLaa/vVcZo0+a25D5q?=
 =?us-ascii?Q?Y5yUJj8DdVCw4Erd2gCmp08oaiQz4yEVJ24exddIDB1Jz7ORQYCjeODFqQE8?=
 =?us-ascii?Q?NJrUThfIppgjnbWbi9b8EeqcTvQnxBNfWjwRJxIlgYoqgdeb6DN+lAifgPY1?=
 =?us-ascii?Q?9wUq0T04bykpg9yO2dse1lTFXfAR8gIi988dEi0OaRCTAEusSHg2MlOAL9EB?=
 =?us-ascii?Q?V0KMGBhZdTKDxfwMRaa2Aqj+fVLphS2Es9UKJhMY9i1tGVtamHAzv4uE0sPn?=
 =?us-ascii?Q?kleP6HTfDViG7FiKp6H+pDwj3ExAcnSR7al4YjnspPRlcGz3UugWBmbZEWAS?=
 =?us-ascii?Q?hxbi3n8F5VoYC3srBtsFERnSEiLG9GYSBnYnfu/RgWqSaU3xYYb97evFjWHE?=
 =?us-ascii?Q?+rh8e1LDgqG3yxWCoZlUKQwTgphF9ZIUCAbcXuGbMNqiidNl+kuZj1gTHV0F?=
 =?us-ascii?Q?WwcCYawqEx2LT6boSVsb1oIVhO4Sp7ddU9KiN1XKxloU/49PPsJSmiFhfasQ?=
 =?us-ascii?Q?r+Ie1AG2SEM4bCaagzx69P7vxyuT60j4MH+mwf9c+XIsUA63hocrV24E6mpN?=
 =?us-ascii?Q?/EssKPX8svqbdkSMSls3mcAbeUF+6X9iAxpUVqxEf+QisuNbwIlfJxJi1pZE?=
 =?us-ascii?Q?a95aUbWDCsMCAbEZqf4514qCIdt3/4u4ao/+MoApXPV5ZNdSnyVEpgD04N9T?=
 =?us-ascii?Q?h4Bv91Le10O8E0ueqjaTenrnRv9qjNRw1z6ie5eCW3MxINPXUBxur+hrhgqP?=
 =?us-ascii?Q?ILKzFTINChDVam7bElSE7zj2ZeEb9jMizjvMPoHWJrPzDiCCxKVt2iV/2tgE?=
 =?us-ascii?Q?IUj0viLUWO2H7+v9tKnadFzI6tjkqQqhnpB3a2UDBjcPqpgiXFUs3lyjViwv?=
 =?us-ascii?Q?pC2yHYPSBISEZ/AKG17hYuzU2aX1GbqdhQkYYgeC/VF51nPsxvV6JF4xysAp?=
 =?us-ascii?Q?Fofs3Ex57+VGmviSH0jkjQ/5a2kxdszebDgNPcsg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57eb2a89-ee3a-402a-d58c-08ddf3845181
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7475.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 11:46:18.6375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /u6ndrDT91XNQ+23VDoVgfRaDn5CpzMWqpTzWsPrG9fVP9Sn5uR1+ZUwNN7QPeg9QivdmwfK1GzunRemMf3w+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6045

This mechanism use the PM QoS framework to add device frequency
constraints during Block IO is running.  When critical processing
I/O requests that could block latency-sensitive threads, it
dynamically applies frequency restrictions. These constraints will
be removed through a timeout-based reset mechanism.

Signed-off-by: Wang Jianzheng <wangjianzheng@vivo.com>
---
 block/blk-mq.c         | 58 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  9 +++++++
 include/linux/pm_qos.h |  6 +++++
 3 files changed, 73 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba3a4b77f578..fcb4034287d3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -11,6 +11,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
+#include <linux/blk-pm.h>
 #include <linux/kmemleak.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -28,6 +29,7 @@
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
 #include <linux/part_stat.h>
+#include <linux/pm_qos.h>
 #include <linux/sched/isolation.h>
 
 #include <trace/events/block.h>
@@ -3095,6 +3097,54 @@ static bool bio_unaligned(const struct bio *bio, struct request_queue *q)
 	return false;
 }
 
+#ifdef CONFIG_PM
+static void blk_mq_dev_frequency_work(struct work_struct *work)
+{
+	struct request_queue *q =
+			container_of(work, struct request_queue, dev_freq_work.work);
+	unsigned long timeout;
+	struct dev_pm_qos_request *qos = q->dev_freq_qos;
+
+	timeout = msecs_to_jiffies(q->disk->dev_freq_timeout);
+	if (!q || IS_ERR_OR_NULL(q->dev) || IS_ERR_OR_NULL(qos))
+		return;
+
+	if (q->pm_qos_status == PM_QOS_ACTIVE) {
+		q->pm_qos_status = PM_QOS_FREQ_SET;
+		dev_pm_qos_add_request(q->dev, qos, DEV_PM_QOS_MIN_FREQUENCY,
+				       FREQ_QOS_MAX_DEFAULT_VALUE);
+	} else {
+		if (time_after(jiffies, READ_ONCE(q->last_active) + timeout))
+			q->pm_qos_status = PM_QOS_FREQ_REMOV;
+	}
+
+	if (q->pm_qos_status == PM_QOS_FREQ_REMOV) {
+		dev_pm_qos_remove_request(qos);
+		q->pm_qos_status = PM_QOS_ACTIVE;
+	} else {
+		schedule_delayed_work(&q->dev_freq_work,
+				      q->last_active + timeout - jiffies);
+	}
+}
+
+static void blk_pm_qos_dev_freq_update(struct request_queue *q, struct bio *bio)
+{
+	if (IS_ERR_OR_NULL(q->dev) || !q->disk->dev_freq_timeout)
+		return;
+
+	if ((bio->bi_opf & REQ_SYNC || bio_op(bio) == REQ_OP_READ)) {
+		WRITE_ONCE(q->last_active, jiffies);
+		if (q->pm_qos_status == PM_QOS_ACTIVE)
+			schedule_delayed_work(&q->dev_freq_work, 0);
+	}
+}
+#else
+static void blk_pm_qos_dev_freq_update(struct request_queue *q, struct bio *bio)
+{
+	return;
+}
+#endif
+
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -3161,6 +3211,8 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
+	blk_pm_qos_dev_freq_update(q, bio);
+
 	bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 	if (!bio)
 		goto queue_exit;
@@ -4601,6 +4653,12 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 
 	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
+#ifdef CONFIG_PM
+	INIT_DELAYED_WORK(&q->dev_freq_work, blk_mq_dev_frequency_work);
+	q->dev_freq_qos = kzalloc(sizeof(*q->dev_freq_qos), GFP_KERNEL);
+	if (IS_ERR_OR_NULL(q->dev_freq_qos))
+		goto err_hctxs;
+#endif
 	INIT_LIST_HEAD(&q->flush_list);
 	INIT_LIST_HEAD(&q->requeue_list);
 	spin_lock_init(&q->requeue_lock);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 950ad047dd81..ea6dfff6b0f5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -26,6 +26,7 @@
 #include <linux/xarray.h>
 #include <linux/file.h>
 #include <linux/lockdep.h>
+#include <linux/pm_qos.h>
 
 struct module;
 struct request_queue;
@@ -522,6 +523,14 @@ struct request_queue {
 #ifdef CONFIG_PM
 	struct device		*dev;
 	enum rpm_status		rpm_status;
+	enum pm_qos_status 	pm_qos_status;
+	unsigned long		last_active;
+
+	/** @dev_freq_work: Work to handle dev frequency PM QoS limits. */
+	struct delayed_work	dev_freq_work;
+
+	/** @dev_freq_qos: PM QoS frequency limits for dev. */
+	struct dev_pm_qos_request  *dev_freq_qos;
 #endif
 
 	/*
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..e0d77ff65942 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -95,6 +95,12 @@ struct freq_qos_request {
 	struct freq_constraints *qos;
 };
 
+enum pm_qos_status {
+	PM_QOS_INVALID = -1,
+	PM_QOS_ACTIVE = 0,
+	PM_QOS_FREQ_SET,
+	PM_QOS_FREQ_REMOV,
+};
 
 enum dev_pm_qos_req_type {
 	DEV_PM_QOS_RESUME_LATENCY = 1,
-- 
2.34.1


