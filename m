Return-Path: <linux-pm+bounces-28657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D5AD88C0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 12:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF1E1E2266
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16292D1932;
	Fri, 13 Jun 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BYwHUZG3"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012037.outbound.protection.outlook.com [52.101.71.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C622D0278;
	Fri, 13 Jun 2025 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809169; cv=fail; b=mvSgMHoJT08YhgxzXUlWNJkNhc1tB8wxJG0tfAcsf5jPCcHBIR0zImb2hdd7HRn96FMvOBaGFz3eRoOqa5HKDRfQI8LkTaQzKruUI1G4VX0HowmVc98ivkisfm1kgjkX8oK8AEJX7EJDwOYVhyCO5foROmI3JagX16PaS3MGiSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809169; c=relaxed/simple;
	bh=V/EjW4jQj2vQCEE32BKPJkBLzKSU+5veDVxqJWBw49g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iUCKQgW22WN3K69z6KZdqyrWo+XouCh33hTRO5G3JtFaddaIFbYdXfcxh+2xR244N3mxjUEpnX23g3/GvYVH0/0dwfdg4GZzinxj6jNrPRd4X7AbQqNPFPQHgkQJ+FU4N/FkZivj6cfLGkUB++P3t8Dxy7W86Qs7kHBqENYfYbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BYwHUZG3; arc=fail smtp.client-ip=52.101.71.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hM9WAq9RaTIrF+5i05MpR/IqbJ6KmGEitv7ScnqUrm8P25kSXMojVefZ5F8Pe7ygTnmXVFzVea46sZntfNA9SNUGGzY5rOjVnNX9jdAe3TqD043DioqhyCLEdGm17kZvm1zaJBo18K6BCz7pSZ5cP+ap+o6Ct5E7lnP7dFWcl5opQlekUcsIKI3zRlPvhnxwiMTdMtjDqmlMMRzykt0QPLJOz+AxlghYBzwWS2/T7UiZ/luqYBScKka5FicHWthRYS8UK4g57d39u7XJOL4gZPuCO6V2IsCoBq7lEOlNYfbGI/6sY1zhL4Qa4RLH69qet3iscTjHWEBEWO85q3W1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+7ZIcayKsHZ0SJIw1CWnPpU3rnWURtzIqNo6MW1NKE=;
 b=maOxLyJrIF2rIqMzOP/dPfVOpFasmOTOLLxfUfvlfTvClXoQMc4Ia8TORYKJlOlOiBqOWMXbwqSLhAOQNBaTiwpfgLyLa3JZJmzBwrpkNV95v47sxvlmwg5D5tQZGdQ8Ti8QleiqdN7rmcpbVp4qJor/eig0lo5kVQvqtAYbNfAzjHpgQf39uERL/F26oGU8swx6Gzty1BVErG0zrUW/ve4wTem+E5CJpVyPij96qgUlNKIwo/SqH9YoAHAsQk0O7K2FN5i6My9yzwGX6q203ikEMbezO143zya/q0S3IKJAuJfly0Sa7hPu/5neoS77u1it0y8eygNfU+sSvXy5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+7ZIcayKsHZ0SJIw1CWnPpU3rnWURtzIqNo6MW1NKE=;
 b=BYwHUZG3iOHWF/9mPez73wTlFfjoMJr6XPHn7V63v8vGJIgPZsns+nXRLN/4UuqcWsdQruh/aq2W78QMvCglzLFLyPYmLdPsfIxydK3ahmH/70uLkJkV1ygJ+asXj2u+wnqjvO/M9/0R8LR6A1/Pq9MYVJl5jndWppc1qpbxnqscwyZ3LgknIwcRuD1WlYUOB2usgYpH40h3g9kELotBHdBaHPtfLWsmeSJouN79I2gGWgD3g1lKd8U1K8QMNrKYwJrxX9tMVyjsUzUrmV9bA8JSxlw7VC0VgZdz+VIPb1KTbnWCKZZVUYMdaHWDmMs4WJzkb92RhhlgDDrcAHgD1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 10:06:05 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8813.018; Fri, 13 Jun 2025
 10:06:05 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	ulf.hansson@linaro.org,
	richardcochran@gmail.com,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.org,
	frank.li@nxp.com,
	ye.li@nxp.com,
	ping.bai@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	xiaoning.wang@nxp.com
Subject: [PATCH v5 2/9] dt-bindings: soc: imx-blk-ctrl: add i.MX91 blk-ctrl compatible
Date: Fri, 13 Jun 2025 18:02:48 +0800
Message-Id: <20250613100255.2131800-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250613100255.2131800-1-joy.zou@nxp.com>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 1beaac33-965e-4e4d-fffe-08ddaa61e89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pMUIaB+CXCKBxt06d1KcBte+5PzrVlD+Xehze5xlbORBJ7ixMZ0Q/1eXI8VW?=
 =?us-ascii?Q?JpSNcCL2829+w5u2cT+nRbcQM4GnqPMnXKzexQwbZp3cKH2Z+wigDmbM41vt?=
 =?us-ascii?Q?1K5vqfM1oz4XmW94Di0Q1ncaM0TrocYPgp6acWMBLcHEB5jA3iRRkX/oCBLp?=
 =?us-ascii?Q?9BXB40lbaxDjrq/xr4OXV8PKalTYVI3UgtnSCcIJwnXbRUUyeOX0/Os+oG5T?=
 =?us-ascii?Q?sswoi+jErZp13NdYvBLiKVpuJNYyBdYGYQMtgaSiNw5usxWFC5G1UuybQr/s?=
 =?us-ascii?Q?dKiDo8j0MiZ88Mgpsv8WeZgDW7kLS3/vX81rG1tWTd8OqTvsbs+nUeD1nMFE?=
 =?us-ascii?Q?Gt7LMR+kY9ClRkK+CCOEqfvpdBDAmLwMoaCyBys8I2NgxQK+SjoQ2MRJH9Di?=
 =?us-ascii?Q?T2QXsDwBlcFJnuUYCTDQ4KLi0XgJHylMaakGhw9ozHM+33AN0hkRS78t+VNf?=
 =?us-ascii?Q?R5eAHW8nWCNzi6KY7OvB5yXrx34Khz5YdtvKFOu5mFctz9KKlk1+iWaavU1G?=
 =?us-ascii?Q?l23KZ+V4magMrThUaxDgvEoK7xgw7FYb4bFQOar9MK+51Hq8CikziXDGaeeE?=
 =?us-ascii?Q?wwZCaR6JcSUW85PaykoeVbM+zwzBLWX88E8YbIHV7bHyO+EWF5tzap5VyaOt?=
 =?us-ascii?Q?ss8GymVqXmWna95t2sqDqdNzCqt/2kL6MDLU6PnxB2p+XLTr/yhwCtO3YN81?=
 =?us-ascii?Q?6YO9+bJIaG8BE4IebwEBLCS9HnKdsNbIXgCGV3aTDSG3Mt0aM8CYF/1+djU0?=
 =?us-ascii?Q?dvDIgyHFjEtrbhBKjGYBN46x7VKa6pVASB6sEpGDTCukwON4QM4gFseBcMGR?=
 =?us-ascii?Q?/sL551+pZYRTd3szcsR4ByabUEUdebDzKX9y2sPrcZgFO3KjX0cDektJdW4D?=
 =?us-ascii?Q?JVP4KSj2dl39u2N6T3zYrJsLpMXAQXHsq4Fj5bn2n0YJGEJfqHwZkm1Mc/CJ?=
 =?us-ascii?Q?HwpaZrli3KESP+oNateT/UkDDkq1npBmG+GA4q6uggS38e8k8THoGUrCa55B?=
 =?us-ascii?Q?TnfJKWrmRAlh5HICVuqqkyFxKKFXDtGRJotfVO7KXzcI0cWryCdCWnatke6i?=
 =?us-ascii?Q?yXq7qzCln05Cs988nDAhLcYGK2Faqc531qjVYEipe6mviWLYWoBQOwLIHCuw?=
 =?us-ascii?Q?U1RnUwqiCO0R05SpKNdGk628P89MFj1jjwp4DIK9NxwtSLg/IH7EvZsyOLEG?=
 =?us-ascii?Q?zbGxsOWXFTh/18xYbqyP+8+XEyxuL88S2XdjOgzLFd7SNad8hJFit9++O2y5?=
 =?us-ascii?Q?P1f+14EEKc5m3SzNrt32Bb9aRT9HCNtXC1/EHMKd1+Dlw2dlv6lC15tNvLHE?=
 =?us-ascii?Q?+XQNj6mPbIhFWI378kXxG8D50YmkHT6M3EhsTjqI3F08j3tkzSrONd9+fIzP?=
 =?us-ascii?Q?+S6cbVEaYw95AwQvDe/HfpXW45i/tLRJY6LoBlLqUOhgcHhcjK8ue4Dbcq3l?=
 =?us-ascii?Q?AG1Bta/Ircj8TNdQy/geow1JLun5CvfkvgcmJFKy0rCwgIRnaaLPB3CBT8Rd?=
 =?us-ascii?Q?199KDh7hfdrsUl8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mFYgAa9j+gNvdIKVIxupg/LttZqqkke9UCAOIpiH2rSTmz/3eE3otnTgpfId?=
 =?us-ascii?Q?YHw+D4I2DavlILT1sSuahvPCxDjz55oRkhDeZjWp8xqhXsTLjO0/I03Jblm9?=
 =?us-ascii?Q?Hw4CK8t1d4H5Nc+lQAzMklaWECGUwEGG89ZiDLSDM2T2Hnhb9hMsTxch30hU?=
 =?us-ascii?Q?Jkz1c/PR0SXPy0ZSSueVHvgCRtOKKoSpqA7ykbrq8CjyA/To2Da2KExZTaup?=
 =?us-ascii?Q?nh8uAlUiQaI7axz2OK8bj/cHSnYOvCZoGy7ymqGxlzGKD3+bl/1iASmdI4M6?=
 =?us-ascii?Q?rLOKVaLkyfrN37nhVPwX+wyG1MqQjUW0Sr7ao0ex5TFU0EqAxDCw+gwHHuU4?=
 =?us-ascii?Q?yxaPue/QuFPPztewCjRrNH2gRFpsjU3X+1LvmjwCLw4F5W9rzBCMfzsi7wUg?=
 =?us-ascii?Q?3ITrDYba52npGB7piIz/gJ4ma+6L7Lww3JJ44AoSEIQPaVHAYOovx85eUI9R?=
 =?us-ascii?Q?VYcxwW4Cx9Hr69QfRstSsI+WMQyvQRIHZWAOv8pOsErC4Zza37VeovY15oDj?=
 =?us-ascii?Q?COWfxjXO/TbUTDAqbSR7PKrGfTvvNrZE/rCql4r76+GLVaMni/8I/NCUifJa?=
 =?us-ascii?Q?G4Mz7zN5kCnTpRGX+6lrGhy0LESUsyIKtFLoVP80cYmEfwEJd/BAuGs4amL0?=
 =?us-ascii?Q?kMcwdhAs7utRuAO0gp/lUWpYrhZixpYKgUSepuGXkhudYSAHWMk9MNO1LbBq?=
 =?us-ascii?Q?ID9lW9cwRzQafukIMDui7UCd/gsEVWJPdkJsRRQ6sRL9DriogAjV1KhJzw1m?=
 =?us-ascii?Q?sgz325H+rYtKaxH5g5kfa9CaMMGd0QpeMbJL6hToErI4hx2/hXdtVPnyVe44?=
 =?us-ascii?Q?BW191TCRPWAPJmjyfhMC2YJcFjiFAZLSYpbPc0BH85nb6UngU+cskwkjFYuz?=
 =?us-ascii?Q?px9KYmxwF0PkDgx/Qkl6qvQfkUi8+WADd7dqYbVNYhVtedygfAT0F94+3oMG?=
 =?us-ascii?Q?oolz3Jo6mKksLtXxUCFVKGsaDk/E/1tGKIHEVF8B2lgEUepU8JCz0XGCluE3?=
 =?us-ascii?Q?D0KBzxYuYusVY6H74cY0q9tVCIvTtd2vmluL+ksGOeRmPwm0FN9smzXPCL7j?=
 =?us-ascii?Q?hpzdrQHkPqxew+LYRsiUvvyEKy0Ok3EkEkiOiKwN+gDPBIp/v6cwiDc0suQS?=
 =?us-ascii?Q?usp96Nyvt2qz9V0R5iGQ+pOCrDc7xM+K3a6mW/aRep3avC/07NLmAlPWsxKl?=
 =?us-ascii?Q?em722jlR70m6sJxaJV7MuvtH0wUWg6HndcSlzVqshXUnFU+wPFK9uUtF+dfp?=
 =?us-ascii?Q?qncC/PzJRvJRPOI5ZF9J3EDGU67rzY8g1S1kbLfodw64IgGFQ08XldhY6TWB?=
 =?us-ascii?Q?/ikbgeEEZd0wQ3g1q/iX/IKivrYv3Jhcq1XAgoL27an19uWvOlsPbqv5eFPQ?=
 =?us-ascii?Q?o3H1+Vcu6FCzYQFTngCS69fpapcAkmxYC8rf4SulC6mBCMu1AVJR9Ov/YLvA?=
 =?us-ascii?Q?j4k43I4WOjq/SxsSYc6of2rHkXmfYxDNCdYlIYNOThuPd0nbMtVJtYbe0HU7?=
 =?us-ascii?Q?B1x8B6FD0hdznA6QrutWaK4zTPcJTprvz9lGQM1QSypPDarh1HM/Z5BLS9QH?=
 =?us-ascii?Q?0WFrRRiLdfls/mB40xi9xmWSZebqCBf2CVT9FBEA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1beaac33-965e-4e4d-fffe-08ddaa61e89a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 10:06:05.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHiw97YtNYPzDgArgR2xvVowSP3qgGmkOElMVV2nnP2K8+p0IXSMjHY8EREK5Wex
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294

Add new compatible string "fsl,imx91-media-blk-ctrl" for i.MX91,
which has different input clocks compared to i.MX93. Update the
clock-names list and handle it in the if-else branch accordingly.

Keep the same restriction for the existed compatible strings.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 55 +++++++++++++++----
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
index b3554e7f9e76..db5ee65f8eb8 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
@@ -18,7 +18,9 @@ description:
 properties:
   compatible:
     items:
-      - const: fsl,imx93-media-blk-ctrl
+      - enum:
+          - fsl,imx91-media-blk-ctrl
+          - fsl,imx93-media-blk-ctrl
       - const: syscon
 
   reg:
@@ -31,21 +33,50 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 8
     maxItems: 10
 
   clock-names:
-    items:
-      - const: apb
-      - const: axi
-      - const: nic
-      - const: disp
-      - const: cam
-      - const: pxp
-      - const: lcdif
-      - const: isi
-      - const: csi
-      - const: dsi
+    minItems: 8
+    maxItems: 10
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx93-media-blk-ctrl
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: apb
+            - const: axi
+            - const: nic
+            - const: disp
+            - const: cam
+            - const: pxp
+            - const: lcdif
+            - const: isi
+            - const: csi
+            - const: dsi
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx91-media-blk-ctrl
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: apb
+            - const: axi
+            - const: nic
+            - const: disp
+            - const: cam
+            - const: lcdif
+            - const: isi
+            - const: csi
 required:
   - compatible
   - reg
-- 
2.37.1


