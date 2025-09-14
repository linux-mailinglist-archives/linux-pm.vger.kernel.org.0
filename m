Return-Path: <linux-pm+bounces-34598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA0B5680D
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 13:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A0E3ADF5B
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 11:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F96C72618;
	Sun, 14 Sep 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="O2sSYI98"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013027.outbound.protection.outlook.com [52.101.127.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7555E55A;
	Sun, 14 Sep 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850371; cv=fail; b=em5RRfjfYDvO5TDVc0fhCn96ozV0+3ntBjNkjykKdPmFeOiuhLTeMSq0FKDwIAh8MBrMEsToI2r5nDiVodJP72lS08IfsMuLW3k/Nda+6aAtUEynZHvNDnOGtwJhccZW9KLYEU44jc3Tc0pPDXyxOR8d98tz9aGri6vU9UwJkQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850371; c=relaxed/simple;
	bh=fnwRcbmKMfBJAWNWTa+Zzpj6WArf4FVeb41h/kMPWyI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UvU07dWY+Hb5sfaUyvQskpaphmKE5qvKwz0Q60l4o1xe0YZsk6nvRlQoPPGTQIxV5RZo0E9rmxlJjdFpJGq3xzfncLO4trrFtwKOpOx4NVCVyzZwHm1Ovkvb9G4AwlfBTkKee4KbQi6RhgUogxN4PlO45Qu4F4IFhet1R7EUll8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=O2sSYI98; arc=fail smtp.client-ip=52.101.127.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffe9lu690CSqBSW6NZW3VQmJz+xL4FRFJYhaIwpgU3CXVfnmkEh22m5GJUb0xKgVHcSxALFtas9YL7mRoJ4pc5HPAcHBzcPz1nUyXHofIq/U3c7O/mfWYutbaa0hEMFlnm6mfWU8S145txFI7l04qwV7a9yejSqeiw3S4+U9KKBOv8c1oYMp26ZyGiytCINjddnjCubwdsM7MvLaQve4QyXsD7d2I/pO9YXIqnWq7FnNS6Z/NrXiEB4Z+TA6lJd/i64tH1yJoXTjoEjXqlNll2kez2aEK2xGvzMFbSHjHG5BKx35AyobQ37u0sx3IwmcWYZMcsn+aS01KqYoEYcUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X5yc7CYmUAd0/keyRbiSginyhRrctGPW8ft+QW+ocg=;
 b=x4dZ6g7q6MKz7BkpJnoItt48t9N/EV7Lw5hQfqhZStGDQZwf2dqV4lTnBa5KPseMvkXaoWChzm6vdI4P/6fM+33cuc7SrlBfCqetfrDGYxKJL1QF9bW+JIzoIpN80ai5SjG9layTXf0ujv2MTMGMDfQEEFCfVEKUkAmFW8ONbna0aRqrUbWadYfQHyINSmEdefyAlO5PDEfbEekanzbb9adCQOoDwv4H1uRt07p7ulnicGV1KNOi9aPQXrU1qFU6dhbE7SXCfUv9oNki3BqjQuMwj/RwPTsZBslPDwJ0wbyueDdOpaZ2ya5p9CP1CTaXsCHegnyExD+Eay3KKorsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X5yc7CYmUAd0/keyRbiSginyhRrctGPW8ft+QW+ocg=;
 b=O2sSYI98+kfXgIoac3sTw7tien7erR8fmM9+OZdMQPQFT8IsKLmcTog675VQLmjzWVfULZe1EP8KF/i2TddNh+al0a1Tw3puun78qEFf30O3C8zUzOna3Bagb+0GzC1UhX8eFSKrrbCLzFgt94yfEvOpTVJLGbHS97p280vaXrbf52KCuSfgQ5CSWrxJjgHj41lunB1uSHxgNItYIISQomNB4rGm9j88aFLeOBZxQDE8vxmUZCxvDYYgIXYO2VK8OTaVUDX1SG1X1HhwHdh+c4rH6ihPn7dMcxt/ZubfWQ+Xo9EzOqQ63v1diWouc45Ut4mnS5QxExkGhASvkOAnxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI6PR06MB7475.apcprd06.prod.outlook.com (2603:1096:4:242::11)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Sun, 14 Sep
 2025 11:46:04 +0000
Received: from SI6PR06MB7475.apcprd06.prod.outlook.com
 ([fe80::a41:1dd9:dc0e:5cd0]) by SI6PR06MB7475.apcprd06.prod.outlook.com
 ([fe80::a41:1dd9:dc0e:5cd0%3]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 11:46:04 +0000
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
Subject: [PATCH 0/3] block: device frequency PM QoS tuning
Date: Sun, 14 Sep 2025 19:45:43 +0800
Message-Id: <20250914114549.650671-1-wangjianzheng@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SI6PR06MB7475:EE_|KL1PR06MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b4a632-1abc-4669-8188-08ddf38448d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y4oyXamFcF+9wGvQdci/1if0E/MFgS1q0t4piecR08RCHXMfSc3I+XyrioUJ?=
 =?us-ascii?Q?fCginWGs4m8GXl8FL6feOXAHhRSpXYwL1eeX6YKuWRMTYWMnTH8WrCqf9uyk?=
 =?us-ascii?Q?xr0+uMvKQaqeTF62bisNa9KdbifYRT3+/5JcsV0fT6Qn7516RW3Lf2ki1/1D?=
 =?us-ascii?Q?VY8Sezi7Mp3EGluyHZh0nFfSYqpVVoXfb9NrkiKnrM5ejLCDE7HYJcMnSoiS?=
 =?us-ascii?Q?EPk27gdhIVvbcgaqIKI2ypMpzMpG4fc4NrXZbdT/SlG3uz0+61oPHFhGO2QN?=
 =?us-ascii?Q?c8S2Qp763Xo9SLxuzZ4fhfRE3BSIAoihvaIu6Io2vM9HuTQVuPfXXVjwr0G/?=
 =?us-ascii?Q?0xE+Y1ewHGeBJ6xizzssncWzQCzvEJTzUzORPhXjmvg+TtaEx/6Itl4OubDL?=
 =?us-ascii?Q?Kpi4ciV9X92Jvb1q1EjNA76s0hS2Qy5QHyBWY1dO69UbBuAr2W67xmqEPJVg?=
 =?us-ascii?Q?4gLtUTDDQ7Q+7cONhoHljaUxPa6dNxqJBeK/QoctZqzvGPpgAntZSpma+Js4?=
 =?us-ascii?Q?mqNjRingR5Ejnin96zONkvAK612z54t1WXN7R7Pf50MiCg9zlxybVFyhNx6H?=
 =?us-ascii?Q?diBbYqudKFo9stWbMwEhNPCi6rRr0iz6jwLO0iggeP9NTZJdNlXVdIKkbW6M?=
 =?us-ascii?Q?PyOOIQIy8eK6qjBE3gmYfDFxQxrf9eXMguPyBsB5MlS8omSZow+/bNNm+F3C?=
 =?us-ascii?Q?qyVROwADrOfltc9gV1N073bahugLgyrGM3814l6fxs3dtZlzSzbQCchyoLgU?=
 =?us-ascii?Q?xt+Df/ZFaXHR3oGOoUUAahB5sEkHaI4eTFJHE8toHXEojhL8/JgVJ/OXQrZ7?=
 =?us-ascii?Q?Bv9m51ftTMg5aNis9dnbJhps3LY/OAFiU7fBT0xnGpaXBUmUybSpsECHz0kk?=
 =?us-ascii?Q?Ev+B0tZeica3o8nWoX3+I/pLRcU2qQq6jK9M0nsqRENuCt+8uxCoerRtqvS2?=
 =?us-ascii?Q?7IrLUL2G+SmXS4NcLgOPjKgecPANlkVP1yofpBdIk/lau+FuDlK5C9ops0i6?=
 =?us-ascii?Q?yji/WIo4dmBpUJa/orrNVABmgfcKtrmW0p+OLc9qELSzZPsI1X40aA5rD3A+?=
 =?us-ascii?Q?lRRAqco2qWYhZRWa/2T/WPAYCbUUcqkiX6GoYk5AYTCckWUUZYD3cjeC//oB?=
 =?us-ascii?Q?yqvwL0MP7ctMbffuI57YnED7/wUq6djQ5tgYdCODSILNdwJ+yb1ksAFMKNcW?=
 =?us-ascii?Q?sCiMuDmPJ7afNHp7ID77Ref70LRzvKQCqwJd46ZAZH8LytAQP4HxPRPGMJjm?=
 =?us-ascii?Q?QptogIiWcFRghOtbX5/5xlRV1XANptmkTe4onggrRz2ty1G1DCg/JFPLcvgH?=
 =?us-ascii?Q?ct35qCjIYLGuqII5b6+Sk2Qg3dpQatjC7SSp6SFDADQRcwZsluE/wCcxWso2?=
 =?us-ascii?Q?zWcnhTVnkygL3pYSI0ljQ2O4ye74SYqBzVPMNepom6dvZK+4AHPAIb0NzzFW?=
 =?us-ascii?Q?TpwZITT6MLn7Vpjx/Y68xKGvDZvPs9LqeD8jOb568pGE/pqGolZFuzfLIJ7a?=
 =?us-ascii?Q?XaeJ3ONcupSim9w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI6PR06MB7475.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XSg4zWUh2j6c0rgV20TdSMqfH3ComDR8XqR3DD/bbgb+W24gR/t/UKDzJKV6?=
 =?us-ascii?Q?ljEVGMAg+ABdSRDMW5zEf3tWooWS6MyFiTKnkBXd2tRVDMctTjhy/y7o9ESe?=
 =?us-ascii?Q?dF1RIsC6zxCt8GDOzmx2FYcmrfG+hnszcVcMReKhelawPc21em9dM5shQSEU?=
 =?us-ascii?Q?oO4TpP2NCL9X5CpT3myqdj5aF+iCGxj2SSYElWP9I0kLcscrjsizgi1fIkc7?=
 =?us-ascii?Q?Su467qr6GlKUt5BVWNHTN88rq2Xp4R2PzrL8jPbD2l2YioElr4tfkZe90jQN?=
 =?us-ascii?Q?8FDeeM1n0bs2KznEm+qYB8MyC7dfrxHuoVDbV1w1fusuwRIz4pGfOvf0+EVz?=
 =?us-ascii?Q?8bsLBeiARm/CfLVwJjNhsBcf0WlR/hW+7qEBTrBundCfLkAlb7QZCzVIvYue?=
 =?us-ascii?Q?Qwg44g5oUQNQgMh9hwdYSrDJNFpNw2b/9tJKVIhZtdbnHI1AJHZ2yzz2M8bY?=
 =?us-ascii?Q?aIxVieri/+xJmRnETQ5GglF5pzJty2BD+DFxUf/aED2hk7qnqEOe1xRADAHU?=
 =?us-ascii?Q?7WICWQTwRXUZTQ+mdu1MjJfPXH6iiRNPv+Axcj3ZKxpW/tlWEeHg3x/0KecB?=
 =?us-ascii?Q?QlSr/cJTARk1pcNm2MOdn3GWcBp/HqlVXx5/l0C04sxoKYdICHgd+VTPs4zk?=
 =?us-ascii?Q?klL7+fubg5ofFTVdtaRBaOXrLlSr4RupX89yMZPUIYgtzV9KUU9f2NSRCMhf?=
 =?us-ascii?Q?Xcms2zdaBGI3uUObF/hk9fex0lc0ji3PFPEqTEQuPJOX5CIp9/ERsn3LGK6B?=
 =?us-ascii?Q?z4PzkQxwV+N+qWWfBI1eH3iU5lFs8s8XrkmQX+PrVl0V5V2MRWS34u6xnKns?=
 =?us-ascii?Q?UQ4us29l25NmvTWY37LHnu7YSbi6TiKwQ+ZS3Iqp0iuqDj53KjM72nKxGkTd?=
 =?us-ascii?Q?d7EY6a+TsqbQFrY7e27zsEQ2gfUp00qUV+95TgslaR1qk8eH+KBNIy1mKi/Y?=
 =?us-ascii?Q?LXFOT/2HI5lP8vz6aJpp87NUOwq8yYZPk6zrViLPDcA3jJMpHY/YugftHxzr?=
 =?us-ascii?Q?+XD6PTUTHH3kkMcrj6y6uB9ujzKijiOZv2z4MUIcY+MT3nE49mpM7Ok9+4Nb?=
 =?us-ascii?Q?gR86kG3XLVWbxhgSnzcuyW1c9uVAb9QjVOZCw//d9RVmRt4Zdd9pbKA9lU+a?=
 =?us-ascii?Q?fbeUkluUk+YrALCPktbnVSaEWqEFs8i2DtrYq8jRjOWsUN+fyATUhDhrf1f0?=
 =?us-ascii?Q?RICSQLvvp7z/XEpQSQOis/uFPJH/LWu0VT/Xi64sLqNTBqOVmMirGREvRJit?=
 =?us-ascii?Q?S6a//4hxAyxF6KKt3OVPFBCqcM7FFT3U5j1mj0M/i5hWPhEH/OLQALeTJ+jL?=
 =?us-ascii?Q?FR4xRlaGnnbHWu3tP0WAtzDOfMFKnMd6Qh/7TKwCLWMGNo41wGErUqPh2dGg?=
 =?us-ascii?Q?yIiW1OKpTmEPSoH/1sUEG5LU7s+HIOu0R7W/BX0y6Kixr+2iBBhp8xqBM+/w?=
 =?us-ascii?Q?CqNuDDidJdYFguo6aMibqI7Xf4Q/IokUL+Rh0vdXY1A9YxibeOSrF5rox9cv?=
 =?us-ascii?Q?VC02JGMEh7EQQ8gK17eaNwL1rv3eEaJuE4zGBAlHyUMTRjvvM3kFGNR9XHMd?=
 =?us-ascii?Q?G5zp3BNe1JfOCCCAjfftXpBR8PE80/GFJyXqSWyB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b4a632-1abc-4669-8188-08ddf38448d3
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7475.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 11:46:04.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF1zf1aeQQ0fvaup9iS3DTg6hFNuRWKp/2mKs4XP79QIJ68DtRuWM/Fi38ovQFwcC3BD0wLpf3P8lLvl9dl75g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044

Hello,

These patches intruduce a mechanism for limiting device frequencies via
PM QoS when latency-sensitive threads block on IO. Stroage device (like
UFS) use the "devfreq_monitor" mechanism to automatically scale
frequency based on IO workloads. However, the hysteresis in IO workload
detection, it will lead IO request to be processed at low frequency. 
 
Original devfreq_monitir frequency scaling timeline:
       |--- latency-intensive process working ------------
  |****+**+**|***+++*++*|*++++++++*|**+++++***|*++++++++*|
       |                           |- high load and scale up frequency
       |-------- low frequency ----|-- high frequency ---|
([+] have IO request   [*] nothing to do)

Now, the patches provided here intruduce a mechanism for the block layer
to add constraints to device frequecny through PM QoS framework, with
configurable sysfs knobs per block device. Doing following config in my
test system:

  /sys/block/sda/dev_freq_timeout_ms = 30

This constraints is removed if there is no block IO for 30ms.

Enhanced frequency scaling timeline:
       |--- latency-intensive process working ------------
  |****+**+**|***+++*++*|*++++++++*|**+++++***|*++++++++*|
       |- add device frequecy PM QoS constraints----------
             |- scale up frequency
       |-low-|------------ high frequency ---------------|

Here are my example system detail:
  - SoC: Qualcomm Snapdragon (1+3+4 core cluster)
  - Stroage: UFS 4.1
  - Fio Version: 3.9
  - Global fio config:
           --rw=randread --bs=64k --iodepth=1 \
           --numjobs=5 --time_based --runtime=10 \
           --ioengine=libaio --hipri --cpus_allowed=3
           (job1~5 startdelay = [0s, 20s, 40s, 60s, 80s])
  - Local fio config:
      -Test case 1:
           --rate=10ms
      -Test case 2:
           --rate=0ms

Runing the same fio test used above with enhanced frequency scaling
enabled/disabled, I get:

  Test case 1:
     enabled: 	clat (usec): min=141, max=872, avg=550
     disabled:	clat (usec): min=210, max=899, avg=635
  Test case 2:
     enabled: 	BW=388.6(MB/s)
     disabled:	BW=378.2(MB/s)

So the intermittent workloads test(case 1) show >10% latency
improvement. The continuous workloads test(case2) show about 5%
bandwidth improvement.This mechanism delivers greater performance gains
under intermittent workloads compared to continuous workloads scenarios.

Any thoughts about the patches and the approach taken?

Wang Jianzheng (3):
  block/genhd: add sysfs knobs for the device frequency PM QoS
  block: add support for device frequency PM QoS tuning
  scsi: ufs: core: Add support for frequency PM QoS tuning

 block/blk-mq.c            | 58 +++++++++++++++++++++++++++++++++++++++
 block/genhd.c             | 23 ++++++++++++++++
 drivers/ufs/core/ufshcd.c | 44 +++++++++++++++++++++++++++++
 include/linux/blkdev.h    | 11 ++++++++
 include/linux/pm_qos.h    |  6 ++++
 5 files changed, 142 insertions(+)

-- 
2.34.1


