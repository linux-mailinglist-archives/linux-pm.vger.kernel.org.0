Return-Path: <linux-pm+bounces-43658-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMxpEEg5qWnf3AAAu9opvQ
	(envelope-from <linux-pm+bounces-43658-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 09:05:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D52A820D1A2
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 09:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26774300D96C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E380B366057;
	Thu,  5 Mar 2026 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UaiY1QT2"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB633CEA2;
	Thu,  5 Mar 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697902; cv=fail; b=ATy5hc7Y3wma/EQ0m2Q0cqVWedZ37OSNgouyfsdsAtGMmQtGSVTBwV72QsLqo5JMeE9Vw3wknIIhMP7nLNnSayEio34r8G28ga87eh4LvnF2nvGADtHlArF7CUsKFPw+WOjpcDdeniqZrwu5nfyuZ/Hz/34+nezAqPQMfq40DDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697902; c=relaxed/simple;
	bh=b02+3C/Bo8UkG05Mr4bjz0ZwJTIkffmLk7Mc6EsxTHE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QZaOp3Fz3h2XWtuPxXwObfyEYHuS2KL51qTRiEYpbQsk4+kRlhtE4OdKBjCTIKM13S/j/R6Z41zpHrS/a5nd7TfDA61ygyBgUEpoGz30HcVnxwnowikrB/mzuy2Ga/9+oQNsRxaP0IZtrhMnvXjNch8wa7JailhfTEP9iPlbY9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UaiY1QT2; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BA6JD+Dlc/z5srMGVWrFVmNMBVdunpxEyuotnpdx1INJK70EoUYnoO20EVzhl+SEbcM98Oa693UnD/EzunWpwlElT8n4bw3vYCpokPL3uaaZBcxPjUgBv4AT32cr+RkooInn96gd6yw0ZNm9/bUMdwbStKy3P3z5zMgUE/FtvnwnIwN/Qyb72Wf5xx3vLsPqBQ6PnfghiBzZq7DmyIYMouYmx7iVa/vByf5YPshCKZDleF1u0h6DnDX+9VjoqFanWMT1dDgZ4pu+NeFkMbqBVX+V8Df4Jvq+A08NGLQMKKEmD0Qd2WenHDjQf00DlKymQ8J9eHoUtKbqobz7agn34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYvW5lGMRhYLQZM24+H+ued90PfEHhVLncMJPUK4Ie4=;
 b=SbSXzO+l2XBk+Xp5v7R1vRkOgIdrKfcNs5umx9kSIVmfRrvygx/IWgJTYYMR6dKjvf4fJyRIxh+XUu7SdP1Os/XZfO+IV8extGrtyBJR2xboRdyP1ysvCg2keZpAP/BEA5BRdJDpAeGdFPm2O1yetB3BxosfaxuOHGxBEDicjUKFTn7h7XiFMTAc19mp2AQXhPY+AeH5nT/Zw34N3ZCD0QX8S40ivQEkiMnfYjO5Z4fxIkKj3wF7oS/yAlMCLyA7U9qia029NdAOq6+PW+rOGTj7dLr2OTqcSY8EQyay5YfWj9cLPtxVOSYeWOgfUcNuxVcFJTxTur4rkU7PGb+U5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYvW5lGMRhYLQZM24+H+ued90PfEHhVLncMJPUK4Ie4=;
 b=UaiY1QT2Bd7u0HtSwG186Pk/lex4o2xcYELeiKCMBiP5KcFe0iRifC6RKIOnN8bRMmEaPsKC/Xm2NukZgex5BIbqJEyKKRVodc/ifFIGGdMn1btPAOVVU1ufxz53Lwm6Cz6Ca3tT+yyGBqB/hq2Ru3CGKxLkuHdiP7/Cv21BR8OJBrcP8+OW9whWCaHKxFmXMNcv25/rUXnie2Vv7htkPDpmW3wKLw+zu4MAJotnwEl/OA8Djx5KHKBuUEUXJ3eF8hy3/FhonVV2lgEmraK7ZLyZ9NrxS2+nGbXmCexFHsD4PBnNCmSjv0Lf8R9Bi+nvD/6XeKbh4bcLy55gUH/h7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by VI0PR04MB11000.eurprd04.prod.outlook.com (2603:10a6:800:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 08:04:57 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 08:04:57 +0000
From: ming.qian@oss.nxp.com
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com,
	shawnguo@kernel.org,
	ulf.hansson@linaro.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	m.felsch@pengutronix.de,
	fra.schnyder@gmail.com,
	linux-imx@nxp.com,
	l.stach@pengutronix.de,
	Frank.li@nxp.com,
	peng.fan@nxp.com,
	eagle.zhou@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: verisilicon: Fix kernel panic due to __initconst misuse
Date: Thu,  5 Mar 2026 16:03:52 +0800
Message-ID: <20260305080354.639-1-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::10) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|VI0PR04MB11000:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f22eab-b6f8-41ee-5399-08de7a8de3d3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	e8ArglDeqa9cmZxyNYQuTWQMiYElb0r+jS/Yvlxn/NW8AH2fLwAG8t3RBjMJKbMKDByB/GQiJHZNt6Cf1O2W6zuxyE2l688ZmP94yEcTK12OChyiyP70r4i75gZg7YFvvP86VCAZkGmUIYdMlIG3NYPDReytzctqeJ5ShJjeYS0f2FJmhOCUguyKHsa7N7ChNVMTTKz5wBZs0YAnS84+xibPczMkZifr0dpGk8jnUJsPM5oogWKp426xchyG5LCbcMFQhbnxi7m6dk7l8kBWr2kkb97SBMoAJ68gLTE4CTP8wG4g1olfTgidBGYFtV95F/HALqmzakyZarDxulnOlL34a09+lYTfRAl1bppep+3ER4H2G/TBLpHTK3So29qfi0XRYcYn3b3rlYyizdl7X61KOiWcsgWKKBYc7CJlUKmvmTAYzR+nu4OjNP/8qE48In0D3Bm6DGbpzBOma7QhuL/BUlzFGguIlMxr3gqXfRhULV93RP33HVKiRmZyA3HYTL+wVVn3zYmfFqrGK7dVUfmjpvUHV0PcXy1+7MnBbL0vXKTRHSfcKLyuJ9Z79rnotswGAUKYO4tFYtWY9EFLFlE4fq/mLP344Zv+AiJY9WkBt9COJ6VCrpqZuxQaqJxiCUNhcONdqHl4Fg6+/1AYhDshnHzUfM9MEmH5mgY9B2B/QQRihtwCY+BjY36S4srfDUoWrdbLpl5TtjiNm5T6265LDrGvtVA3XV8rWCVeYS8EaffCFcaqM+dOvVZ1EpO1fxuWwb16D5Pe3z4wXCjqOjpcw4fIKKOnT0X36CTe0hw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bs4EG9kxZOCYh0GhkMICcvkFrjQOPQvEDjmC+5OHni8W2Zp5WnjeC9Ac9Khr?=
 =?us-ascii?Q?ExQ460cgp4J07PsruY/WqkhuyIEO+0CMJTBHGam0o84fdzsnVNccC6YqZR2w?=
 =?us-ascii?Q?pzpoaMjgDFI8mMx0j2rRdo6UPt+//T2t0Auiuxg7CAsHycRSElzH80gg/IEn?=
 =?us-ascii?Q?XOdS1tckWHHnoLRxxy7iDUOLdP0Z9xnls4TaRPsdk+SyoW6l/MHhuqKkdjzq?=
 =?us-ascii?Q?qhrrr9IK1wi6BCGfLwkNKnTC6Jl3tJ2BPmoRLrkzzo6r/VJC4MpjyNpOP4mx?=
 =?us-ascii?Q?X28FBV31wQw37194/cbyFextqx223UEIA8jczXdWKszeFUK6N2nHVj2AcZIL?=
 =?us-ascii?Q?xj6pEe4u8gGhhHy0u+iZ5EIN8lMSB9kQM/nP+bi0mMZBjYgk+0pn8qNXHM2U?=
 =?us-ascii?Q?6yhyrXybXv9COFskuUgIyBxaJZ15fiUbQLnhFuC8Gumo0AWh0paOwxRdQAQD?=
 =?us-ascii?Q?vsHmEvpWBdUe4QQPiwmeOW2aZryD0FZTudSQkAGB78GgXlirQ7GSHuMMdcuB?=
 =?us-ascii?Q?2FMMF533sjgccFJC+laQbi68cusSmrZfjfoulft/VEWE1XPyGmDg6Cifb1xp?=
 =?us-ascii?Q?L5heHA2IqetUMKOTYLJT3U8R0EvWmkHlvISL43iG2W3FfmwRjuseZFf1QrFC?=
 =?us-ascii?Q?XCuyp/m6PQkWBOuLT5dtmyvU4zvaqqtKgpZApPyRP1SrbR2G+rGw4XUZjdXC?=
 =?us-ascii?Q?3zvMRVHlYsfK3JG7KfwdlCKdyWNqbjdg55npHaTUdw9VA+V6zk0DkKWvDyaL?=
 =?us-ascii?Q?B10VM2GR7e9H5TMSZu1yw5wsOfshblV8EOOcVA+jCxPiyr7FaA0889dWUtzc?=
 =?us-ascii?Q?PcUrpdoQ2wBojuulGO6I0wJtbPDrwMAYm9VidbsBRmzYuFyNEFyrTXy+UrjC?=
 =?us-ascii?Q?pG7/hMryM+JzIGkeEgOpFP6w40u/wMDKCuLEqoK4j/IVSZZI3n1nq/cfNCD0?=
 =?us-ascii?Q?M0gSma2Wk4ya4umP3UQBQqYCn9pR0cCxF4CEJEZHeJKTpeyYBhtkvQlzYtQn?=
 =?us-ascii?Q?lpl5GdS5QEOQGktNlLBaEwVKI6+h2lP6g5pI87taHJ1Bi3u8qy4DWGCBf7UB?=
 =?us-ascii?Q?3F8RTzm4efM9QBri865uPMg/5qA/shQfo6f+Kwd6nf+OwcOygiyX4k+zEfAQ?=
 =?us-ascii?Q?EWCHcrNT1iP/YF/JzsKzC/P4WVvrt+s3HD0OoF5PdxGANRqQrbzGYflZnGK6?=
 =?us-ascii?Q?W5EHZgx5tWd93OnNIlCQep03DJac3342nrrXTCJMjrQYGP57ItlKLVlBUcCy?=
 =?us-ascii?Q?kyDtczMZOe+LIpo0YI8c2IYVAjPXKy6EDMIVCygWWaNKdthihr9w++QZVbij?=
 =?us-ascii?Q?pHsyX7s3NpfYB2UnWTITgGeJZMjoZIXbe//EACxuqJe6S9l8Upbaks/ufYEw?=
 =?us-ascii?Q?4IGvGy1iqb1IqvdI2Pf772N+15W5SC/26KsEquZ4+LV23pAZEzqAHUs4ny5d?=
 =?us-ascii?Q?295IwAAcFuNEU/1IFsISd1EWmWpx5trN0ys2hVFYkX2qjGNXsv2KfT8mT6hW?=
 =?us-ascii?Q?6E2oMB2IBx9NngVUofPZltfAZeoZYIubv1bpMfk9MqvHVpzWaWAR/1ugcVhK?=
 =?us-ascii?Q?3sUD5KH/jlrvtbSrERCMLPu7+sptKi8PIXrN+hBjsAzX2esbBxZVtu3HNEoZ?=
 =?us-ascii?Q?w63/lhCMhLfNElfBbwpRx250zZxuDRA5Z9w/s/dTsmoxrvmh/UQg0qOOJLfB?=
 =?us-ascii?Q?W7e93RlD14vz3YYDd5Nd63sUHYaoVuYjE82QJDiev6OKyFdDrLPtn2r/6bn0?=
 =?us-ascii?Q?lHn4phqQBQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f22eab-b6f8-41ee-5399-08de7a8de3d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 08:04:56.9310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0dqDggzKjBwfIwup2bvGISGlZCUIrbKM9O1jtaKC42W+D7LPkxvRGasyMtXf+tkgvY9EctOK6ler4EBbJrbFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11000
X-Rspamd-Queue-Id: D52A820D1A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43658-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Action: no action

From: Ming Qian <ming.qian@oss.nxp.com>

Fix a kernel panic when probing the driver as a module:

  Unable to handle kernel paging request at virtual address
  ffffd9c18eb05000
  of_find_matching_node_and_match+0x5c/0x1a0
  hantro_probe+0x2f4/0x7d0 [hantro_vpu]

The imx8mq_vpu_shared_resources array is referenced by variant
structures through their shared_devices field. When built as a
module, __initconst causes this data to be freed after module
init, but it's later accessed during probe, causing a page fault.

Use __initconst_or_module to keep the data available when built
as a module while still allowing it to be freed when built-in.

Fixes: e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
index 6f8e43b7f157..fa429e6e8281 100644
--- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
@@ -343,7 +343,7 @@ const struct hantro_variant imx8mq_vpu_variant = {
 	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
 };
 
-static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst = {
+static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst_or_module = {
 	{ .compatible = "nxp,imx8mq-vpu-g1", },
 	{ .compatible = "nxp,imx8mq-vpu-g2", },
 	{ /* sentinel */ }
-- 
2.52.0


