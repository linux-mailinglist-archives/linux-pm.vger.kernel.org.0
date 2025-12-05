Return-Path: <linux-pm+bounces-39228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D15CA5DD1
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 02:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83B36301B7FA
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 01:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495A25393E;
	Fri,  5 Dec 2025 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iem2ou3l"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A831A254E;
	Fri,  5 Dec 2025 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899725; cv=fail; b=M3RTJtaJQJ1TxSmfBEYzvjeN+VC6lBgTpk5RcBq1vOmwzS+ZmT/IQBlYT1XYHfDKYpgcTf2GhFrNNsyLkBvZjMg9+ChG9I8QaVsuiWunG4RAHD3q6lEFE88ez7Mg1PkhNKZc99BzpiC9MTxSlixjxOcP7H4WbKBFrk57oCSIQ5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899725; c=relaxed/simple;
	bh=AxQWziaK1e4kkA8VaBybQJit/EKj2YIBiyhn5t1axlI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FBdIMg9v5lcPj3CUijR5tsI7r1n/S6/mAZgTy8c0ikGWuy0TU/Fc60U2V1NvzhlmyvZnzlqimyECUZIHNI9JDNQIXidk4O4WcDdbZQ/mPX7PdlRJkoNo3t4bblbERdWyFmUZM9DriCsPCdUekkalcjDoMIXWKhjs8k5IZ2UWFmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iem2ou3l; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpvEzpjpm77PMy3RdlFbqyTUI8xCNSvnuCbK24Mymlnf2gxPByUeOxBog+cnATw7dcHm/oXgYTxKstiBivymyWn8unNmp8eZe2aMbsuNtIl8O5D9dr1nK6kVEFp8kH1UR3GajONjZM0qWbTqZlppnwyq1Ky99wDNjCE6QzQ25qnuSs81JMJVsysiSwkkBv/kv/88U7QhV/MbiaIpm81maWP7uWZyI7YwZZXOoU79JdKmOBaoe0prIlOtlgoAu9BGUyK7actt2sje3H/2wL25QC//U8k2DeSApvCBrxPb7YJgBerSRwNf+1kN/W9XGFys4Fdpf1U4DpGHEsSubrraCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lEp6oL0zs7jBcmxoAMEDE4tCBufMESvPdHz7vxd+hA=;
 b=LEsmZEiukKOM4GZ0tyi+V+yZorH/hCdqWdjrp52X2IQngNMkDAO00v5Ozs9LinU/KR8ZZz5NWTlQBp4Tk10MbYxF6YgY60fHN9LFiyiaXpfVrGzZaRt7eZj5z4DGlZbk/ECkrvlZoIxhQCCwUqsF2a4aL7z/7QpthXt3PgxCASDgEED2TS5nSlgeygQTpgtT+GxZDxoEP0uz/Vpr4+MRzjvt6IaHYm3locykOTwwT/WOYEdCY/5F9qdlqEVhedE4f9RScbeh0e7mNQ0Dr9i0wFHp0u7fOC3EzIGfYozielXKPZWIdVVS0olRHNM0KubKrJjesxMAQL+TwnS1YPzKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lEp6oL0zs7jBcmxoAMEDE4tCBufMESvPdHz7vxd+hA=;
 b=iem2ou3lM/68Rk5u3qwC5sr2ZBZNuN1brGFzqMvTJDFqcDYdv83h17lJGC2Y1MVayepLLVs054NmIOhPUNRcUetwQcDOv+KL+a1QBCV1ynh1yp1Yw5UUgQVYUGsXE0kf/MmPbKs2nFFcB6UCAJY6TSTt38FwagZA/vwGQRi07LjF7dyp55Ij+1euwWZ5ctnFDvHGagZWGrM7qks9BwB63H8CXI6Cujeef6eXQXfoCQIHN9Z515O8pG5lTbv7A8Ci+V57432bFu+KMhbhd1zsugQbr8L/ud9dDp4PJfVeYyEbeWdaTh/zjlaKQSBI2d4K2jFckCvVqoTUIXr3tv+IHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DB9PR04MB8313.eurprd04.prod.outlook.com (2603:10a6:10:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 01:55:19 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 01:55:19 +0000
From: ming.qian@oss.nxp.com
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com,
	p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com,
	shawnguo@kernel.org,
	ulf.hansson@linaro.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	l.stach@pengutronix.de,
	Frank.li@nxp.com,
	peng.fan@nxp.com,
	eagle.zhou@nxp.com,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/3] Fix concurrency issues between G1 and G2 on
Date: Fri,  5 Dec 2025 09:54:23 +0800
Message-ID: <20251205015428.643-1-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DB9PR04MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b965f5c-c57c-4d57-4c60-08de33a157a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nJ+RQc4kIml2+UAXZN1q3L04FeMAH7pQk+07RanoCv0Aa+v6q/+6zAV1BKaQ?=
 =?us-ascii?Q?eliCaiciLVUqzcmhoJzzaw1d4k+OP/x9peQcSU50VqBrKIPGdBqw7YNE2fET?=
 =?us-ascii?Q?GgSSKpJ2s6AqYV92TNNSY1yPkzOHszFMG96a5hw5/NBAdxjdg88+C4RGebj2?=
 =?us-ascii?Q?ly4ATPOFXnWkuuzYYHkV9ysE6HZ4TtwXcNo2lPMCsWIYWP6+X8maJF6Wzg2a?=
 =?us-ascii?Q?WuiVhHgS6aEBQJ479FWeK9jdtHnqAKNKkpcfG4EniaZYlGuivZkOgOqpbmv+?=
 =?us-ascii?Q?1fVIhoy/HaM0892mOf+JbYtKmEMWPPKmiBkdAdBK0FbmVY4GSyDYqGDFtUzQ?=
 =?us-ascii?Q?BzYWO2ZidXDt1yktStXFZC0vkIw+ivjvDuP2fPQOBsY8IFMr0xEyPMmbVWKH?=
 =?us-ascii?Q?YUKy9hH/Vf33AirSwDg3KLFbJD6OMYRhM8/OjIpJ3MGEZx+lV4EuIx9cCXku?=
 =?us-ascii?Q?BLn5mKn749B0A3UuIZ9NThqJaWR5fP8vpETbH4KcPfO+/dydv3zRG+DE8Po6?=
 =?us-ascii?Q?CSRumpW61R45Gsckjcvwb8N21FNMHcdF49FWPa1lYNVLE55m8XUnm0tgAQLY?=
 =?us-ascii?Q?TNSdXBVf1E7GEM3fj3gXI94LjlE5D6aKt6ZjJDj/aMONyOM8y+W4tN2RC6To?=
 =?us-ascii?Q?Njf9k5EYFcKWZS12PTRlItvEhxT+t9Mtm6I+CKoSIMpHxcglX0RKORPRioJz?=
 =?us-ascii?Q?I6+dDfCrxGLbKkgSt2iJa9Vxd6Nj23W1RjLIb8z1WkAVCuXD0ge5we5mPHmY?=
 =?us-ascii?Q?wM8C90pc8VvFIpiBty/A1cp6PZqBshLHA1Vj3QUSRTseeXjf5QyHBaXTbbpC?=
 =?us-ascii?Q?C0D0j91mhd11NGQK/GUnSfHMWwqpmzKrD+vIsfbV8lByV4eZvbcnZc1mRBuu?=
 =?us-ascii?Q?DdrOZqoLZO9ajKTFrpZNRc3GTGlfPSbAQV/3MzQBmLbqII2sG7WraujkBqWU?=
 =?us-ascii?Q?oOqtlhhJ0KOhdUaL6J380TnrYVQ88HvLlvGbUfem1iiBpeFGxa0K4rgSw3+8?=
 =?us-ascii?Q?PeNzoo6FYA6svLCYISAozxR9RtBYtoA2gsCJ362quzW2JQZS+4cmvk/dDN8P?=
 =?us-ascii?Q?bwcR1zS+kohB0x4F15ehWIe0fXYGAnllNoODNthhkN3s7SjLcABl+L3A806B?=
 =?us-ascii?Q?m5N8ZAxmceZX94pppQVmgHyaXxdWSElJUvkWLuqKvlGf/61kBRFxEg2+/jyo?=
 =?us-ascii?Q?F2zgox+46d5QCVaZlp15CquVJ4TewYeHLRXhQmoxS/Y/E032GVm3n7OJKVXt?=
 =?us-ascii?Q?3zo8PabfRgF7pt2qtwoZVpY1Lk1RnlLBSDoiWTz5r3H6oymhhKRYjtm815wu?=
 =?us-ascii?Q?Qkqx3UDs3uUHg1EjV1iKZz6cMhOotvK4dJUvPD+8SysCCj6NIn66nG3nWgHv?=
 =?us-ascii?Q?ZOERrX2y2/ZNWuDDSBGiuNOHbYAsiGo7rvPfCID0ppBQG7x6pCFdwckGzgLA?=
 =?us-ascii?Q?WoqzSnL9sbVXSwVApSVfSlOUDGw0f2Ob2hcoJbJyAejNVE/ybq5EY4tvwp4n?=
 =?us-ascii?Q?W2AvOHCbFmRBKSduIpNye0yihNLG9OsXVHan?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NfWKEept7vv7SlaRYphU7qlolUJkZzMQbD6JW03v1LHvHG2s0+iHSHJYDirg?=
 =?us-ascii?Q?0Hb5K91qpBoLeeho8c5ob6VsFBTs1DL0cCHvx8KsK2XOa6a6iBAP5aTRkMBM?=
 =?us-ascii?Q?F8Q/FlEKgqc40J1rblq49viQQ2gfY5B6TWpixfT8jpdMW/o3sOkrVzOUs2za?=
 =?us-ascii?Q?YfV662SCh6/EBx+MqHu1OBcNHR28alzaa7J3wBD6jUbPjsP/se8UCmUzJwvv?=
 =?us-ascii?Q?4oToIeZzO1Fbc3S6OvdvNqhbxQtkD3cR9oVEplqM+5Pr1zyDO8SEENqYnaDt?=
 =?us-ascii?Q?ncvcAwpfWWcG+0GGu7aCa2vcIndggaRlyAsAGVPCUn2wc5BPW4wE4gLgS7oW?=
 =?us-ascii?Q?Vay7+qkczLx+kVNJIzscRuaaHqAc+21NlN4N/6Lx7rylHBuGh5G4J0HqQyaU?=
 =?us-ascii?Q?TZ3HaiAk8KyKQT2M0qI1dqodYUf200qmZNPXlj42hTKoPAPg6TVjxqePz8PD?=
 =?us-ascii?Q?7WF35gIo7ShxXXBqBRTfQD7TjQ9AhtNtHbjTFZRw/pix72SV4A0/rtYF6mj9?=
 =?us-ascii?Q?czXTC+bnUqJG2U8ScKE1zqOTvofOz3vV0fJFuqAxBFkbXdfYmysaF7c9eXIT?=
 =?us-ascii?Q?lFF+LUiZwpMMeSpEpSjdq2CMtTNXZ5JA2/moe7PBeKQtHSRmdUTilO9+rt7w?=
 =?us-ascii?Q?cOweYgRhUYZy1vtj0HrJgmVlfWo86m+y0t/T3q5op0QcapjNhXrkXWY9rkLX?=
 =?us-ascii?Q?xbjNuuf5ktQ9i1vcf6i6OeQtu3WyfScZ4JxnDMpQ/c4gPRW1KZrDbJlexSSn?=
 =?us-ascii?Q?+4QNi0kdsKKFbA6Bh7KP3LUoRsCvdaCUg5BldAIlzS5rbl+PHRwNVMXGNcAY?=
 =?us-ascii?Q?Svojea2Moxxiymqbjp0W+7KlxzLlIxLeoeFIbh1s2nam32ZJn+dBhgrpmV3y?=
 =?us-ascii?Q?oWokUqbxln9Q+V41O0CZirwsVuEBhrO2lV9nRxVjwwIolQ8pAM2wGJIQSR2g?=
 =?us-ascii?Q?32xh2fc4eVUekcKbhUKm11QhNYi+DVHaXXBKIB/lsRPJc82ZYl0vTB16/cd5?=
 =?us-ascii?Q?YlehvHSSYUF76Fce1yt5idg6oKLWt3dAV0kAGeujVERE9NJ6uVO9KmBc14DX?=
 =?us-ascii?Q?sGbOGxASiA1M9T8Y3DY1WO8THXohbnAkTGgLoxgQ9BBzNAM4MKx/azfkgBah?=
 =?us-ascii?Q?cUAv0Is7Xi1C8R1iosTreUrIrR7F/zgjx25UA4plciprYLXPVaPEPF+ipq4I?=
 =?us-ascii?Q?jRihQZFRkCrHnZLB3z6Eq2e5pbogCb5rByb06GzZJb6Y4l0u1myOrW/lOV6e?=
 =?us-ascii?Q?yd3kkXvH7cZe45SfwtY9B+MgTWDjUDqu3nxea8NZPnVxHmamVhwIbQxPGNbs?=
 =?us-ascii?Q?6XwtRtKaJHM55ftWgRDjfA0QBicJPDm/eUFS5msoO8ulKaV6FLBSp5O1Gtvd?=
 =?us-ascii?Q?EXNufjWiJ8kP8ZMeiv38k4i9q/oi3E5LjiavkGAEsfzZ38fmtRFuSOSWZioX?=
 =?us-ascii?Q?Nzl8yPyqZCfwUwiVVTD61/ZYMs4D+hLS0yZYU7N8U2UUtmVTKau8GOQUch9m?=
 =?us-ascii?Q?jOOe0daiTVRlrzTdjxiUEtZc1BTlxKrAylrK/0o9S8j/GPQfSIvZwtJdvnhz?=
 =?us-ascii?Q?0Tco+RxqabCfkBlkS6T+kZDMi9DWuQk9ULKGlCXg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b965f5c-c57c-4d57-4c60-08de33a157a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 01:55:19.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsdp2TdrmkqCRcbFgOcQI7zQviGE0vjgaZn/yPTkRFQh4LXywcko25DzhNDD7wPt9XXi8ZFsgN6FPbMGYsdrog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8313

From: Ming Qian <ming.qian@oss.nxp.com>

On the i.MX8MQ, we encountered some concurrency issues with H264 and HEVC
decoding.

There are two main reasons:
1. The vpu blk-ctrl don't have separate reset and clock enable bits.
2. The g1 VPU and g2 VPU cannot decode simultaneously.

We attempted to make corresponding fix to address these two issues.

Ming Qian (2):
  pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu
  media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC

Nicolas Dufresne (1):
  media: v4l2-mem2mem: Add a kref to the v4l2_m2m_dev structure

 drivers/media/platform/verisilicon/hantro.h   |  2 +
 .../media/platform/verisilicon/hantro_drv.c   | 42 +++++++++++++++++--
 .../media/platform/verisilicon/imx8m_vpu_hw.c |  8 ++++
 drivers/media/v4l2-core/v4l2-mem2mem.c        | 23 ++++++++++
 drivers/pmdomain/imx/imx8m-blk-ctrl.c         | 11 +++--
 include/media/v4l2-mem2mem.h                  | 21 ++++++++++
 6 files changed, 100 insertions(+), 7 deletions(-)

-- 
2.52.0


