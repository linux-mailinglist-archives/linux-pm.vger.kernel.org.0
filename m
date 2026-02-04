Return-Path: <linux-pm+bounces-42052-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJNjHScpg2kxigMAu9opvQ
	(envelope-from <linux-pm+bounces-42052-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 12:10:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1FE4EE7
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 12:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E55E03012BDD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 11:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D523E958B;
	Wed,  4 Feb 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WlO93qAE"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3903E8C78;
	Wed,  4 Feb 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203420; cv=fail; b=I7YRFrpWI4UwUxVN3nYv2qvygVGpQ6YMNzTckVgYaHd4+il2jdxeyB3T+Z/6cZs/jZS3EQhIWKbrywH+ziDZWP60+rZ4xowsu5g/Fx7eA/sWfkHmdiQK9lNFTvzWxO425XAMm7PzDsAiqjuy5siuAHacgsFAgHUzmr6kSzawKPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203420; c=relaxed/simple;
	bh=P7NYmWsJk58ZhgRSwssREq8b4RI/WAu9Jlm87ymKhFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZP3RIm29AUD0Op82tWPB4Pb5EEIucO6XXh5huxqzK0j9H1b5RvFqOf6YSEthoX02QBGu8vKxE5U4iMvZt+uWT5dzo4UuOeFi/198x9NfejOZCS0plYgyiIkCUavH2minXCiX9efSJH9AQZEQWzomBQO0iHu9KnJa3DYQxLvGVz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WlO93qAE; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMevf7MI2/+3FdvNX/4KvgQDpiMCdh8OmtpIGD4XOtoVAENh4aQ0JgEBu0ooKWUMZf2NE9lJtKHgnN3nerV1PaH5Tmx02FsWybChEPqR4NwAc2JlRKQ+3O2sFcPOZr+0XqsLl57Zw8NAV8M4L70KcJY9MCo0rVvnKUDZuPZO4D75K9riMvagfb0//ZUOdytRLS5xM9HiA7ozbZrtg+WBnFeZnqTo7N5ZkvOREVd/LtLfxfWx85fnGDQOPudLp175oFf7eZAbUcDfN6hHG7M7+0RSdL8+tY5rG7KWW6rnbp0oCHV8Qn0BkmuBwlmuZpOiqZwjaRmanot+NS7rmbahTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcC75EuDvqft2lKGbe61xE+TXvTmhxmt6VQzfYyWDnQ=;
 b=hqrKHAB2/b4ZhGmsGip/WmcqwuR2CGN/5vqHAedpderL6nwYqD+Ar9fEQHnYBMIrvWpNreJnvtahbTXqNj2UkaTdwXCDHlCUDZipRWWHdH+tpjohOcdLmn6diBo4drS5g+lVS+VQYO+BUs++Jb+f4x0yX12Lb4jl6h88xllWfVoY5W4C8ObELsh3PQFuwKM//u6sFsm+1Y1ddL2y6xi8RPtX47b1HYBpq3ot3X6vsCcmWgLB0W7fjxteb2EM49icEgZTCc1Aj/SAJ4sMYigBeU/qDXbWG0rjm0kTqoB6LwcHrsIOa9bR/2Tu/AMz/C6rjKQ6FBxXJpmzkUvFkM69KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcC75EuDvqft2lKGbe61xE+TXvTmhxmt6VQzfYyWDnQ=;
 b=WlO93qAE6SMH/jJtLfV1TVpe9d01CVoWYb/l0mJVi0ozMngwMKZmF/XewAPD4N4J74EDGFv54j/rfDB08gswAyygO4nd2RiL/GjOugK2h4eNIb5pRWQVBVDwmJJHSIei+AwmqGa865zpJSz/FVhQ7xKua0InMC9OukZtWAtkv2yVkcNIW/P8Gq1c3Od4C2nflyne5cGJIlerHs7dWSaDknT6vUUs+kDi7hrtlME2+awMyN5TCcGA4fHyX1LcMvNzQybXL19+n474xRWNnDZ8x2i8J1IxgP6RBN4exdnjUkLtjMfxW/Evf4sba/DO3nLrG1xDKSeZ0W2WEZML5wLPig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 4 Feb
 2026 11:10:17 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::52de:f9c9:8c2e:7dd5]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::52de:f9c9:8c2e:7dd5%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:10:17 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: ulf.hansson@linaro.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	jun.li@nxp.com,
	rafael.j.wysocki@intel.com,
	a.fatoum@pengutronix.de,
	ping.bai@nxp.com,
	shawnguo@kernel.org,
	l.stach@pengutronix.de
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] pmdomain: imx8mp-blk-ctrl: keep usb phy power domain on for wakeup
Date: Wed,  4 Feb 2026 19:11:42 +0800
Message-Id: <20260204111142.2147646-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204111142.2147646-1-xu.yang_2@nxp.com>
References: <20260204111142.2147646-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c97e72-aaf3-4c00-047b-08de63ddfa26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VjCngditoLf9Y2p0/ZUJ+644bkfWCFjoHHUMikeOwc9WFGbdkzey8WdiNW/k?=
 =?us-ascii?Q?L++EInWg/5K90Ge/GlBOoiOpD+RnGxWvc7R7Ml6vx4BDlo4TpiWCa3jT9ASc?=
 =?us-ascii?Q?N08GIYfvlDAlyb5eK+6e6n7LTuNL0BxvcHMJuPLZQLnVk69rCTyen1JXwC6p?=
 =?us-ascii?Q?x+8s5uROkNjTOw0iCf/J5ipAobA00/TxweNvk/XcQbzPB+XhLjm8klOdViie?=
 =?us-ascii?Q?d1zQexcijYuWZRXCYzKgibvEKBL8DYPksVbpPCmSEpO3q11tjqpFeL/yEO05?=
 =?us-ascii?Q?DRds9nYbLMvmYJ04ZAmG0Xc+ifPa3HE/Fu0o6i3wui4Vrf13viMKigrS6KTU?=
 =?us-ascii?Q?+DTIj00HGb85PkFLg+iTAHFpqu06VGOQKxlKo3lq2ffwnjKKgrZKFEkjXTuo?=
 =?us-ascii?Q?FVIXOmFg5gv591gumS2A7lSVjHkBz7qQT2Izjb1Z2uwBD+sLmlDbIrLbyAVW?=
 =?us-ascii?Q?OUCO0Au/XpQuvfWEykgpyoR5Zpe2ND41yQzNwBII2PcvETX2SbkTDIdw0D0s?=
 =?us-ascii?Q?nyp2MmwYk7ToUKLmcyS+7qtDECSjCSU5Ss40gsvLxFqtErDqX0zdSM39Z/1Y?=
 =?us-ascii?Q?KaAMd3JO/3XVeTC4PhoxDii/cnlpwS/RZLPIcfHvM8zdDnYg3DPNBTQ8nIIU?=
 =?us-ascii?Q?K2fnPybtZPdyiknCQYsbtmKZhztp3fwXtVctL3/kzfTPfaon9mGb3eOyZxic?=
 =?us-ascii?Q?RU9hAIEdrjXCGDCMxZARfQWpcR8mjVeKZ8pFnxoPrD6Vym8t1Z3aSxiL8sWl?=
 =?us-ascii?Q?nXUPltGSGFlwgNrVuIaYMcGpxYiA5aiMq05OB6carTshMXC713NCMMWT0MKe?=
 =?us-ascii?Q?gOZYix+G461Q9pLQfwsaBhuIlJFxuWam9ZpwRmaUnVwRHoal2RTn7hWlK2y1?=
 =?us-ascii?Q?6e7rsvZ+TbaSQk2CbIjUpHqPDGABBKJsYqTicWJRN84OBFuOCNnwEv4lWPXA?=
 =?us-ascii?Q?ZSYfzq1nt5yR28VtrS6VeGaLHfTnWFk4IQpe2TKP3QTRPFqQp/Se1d8Byqbt?=
 =?us-ascii?Q?g3GWFVxHQP6+xIKFCUDlZqc1CM2d9NavdID30S91MUlC3g0L5Tk+Mg1nXbL4?=
 =?us-ascii?Q?xtTvHUivtSEbWGa4t9QMVyY8GzdnuOK+oBcqhMyMAjXTnB7j2avKDVTG7Yrd?=
 =?us-ascii?Q?3IbCpJNqZZGReMA4TZLBdRBhXbFJyqtAlekJLXVOwdDMylhiXAPTe7QZL8Vr?=
 =?us-ascii?Q?2xxBQNeVe4cKxe2Z9Tp7mJigpGApwF1BB5xA/43xcrxqEgOu21G4Qc6cm09m?=
 =?us-ascii?Q?J00p8NNDRLy3IkVW7+bbC7HHgQ86rvlGI2g6Hlq1ZQlpXwrffZFwF0C/hoMw?=
 =?us-ascii?Q?XaFyDlr84d77pr08iEyNd85/wjndZpS0pFUMT/L4mAjOU4gSCWjkPBb5iUut?=
 =?us-ascii?Q?JUIyMSklqeCL2Ij7aJSvESLtDltgrRHcaGQ7vr7yJ8qZOmW33WY+P1Ubb5jA?=
 =?us-ascii?Q?OkTqxfc3jGfyXEVC7ENUogX3FM4hORJh8H8g/9RF+QMBOujAxO3jWntRbMBR?=
 =?us-ascii?Q?OSHmoZJS5hEWi5yef3N2nLEMBuS1DQ/Qq7bYr7B1kJCmxKzxYp/QUY2Lxg/C?=
 =?us-ascii?Q?rPKFTd/BF1AfamQlOd/BMfd8F2Ngfj4Oy3GZEjODeAdjQmUm0lI5hsdPpZza?=
 =?us-ascii?Q?I2Y6DOCbYqcbHhr7Fhzljkc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PTJOUo61O3p9NsLxKA2BJ/Kt8YWXLGM0kfvDbZgpuYFKQV2JEl7ad02VOtqT?=
 =?us-ascii?Q?mXjYRGgrQVk9W88Ztks4buruiBt15IJc6SD3+Y82YuGiV5BY39T2ToAiyUVU?=
 =?us-ascii?Q?ap3v4Hk3+V+IGbwprSfHVg6OPoCU4t89PnG1AGeNE7nPq43WWbFLfi09wiHt?=
 =?us-ascii?Q?9LqEXnOxXnBPuAEHNTIAVAesrw/hWMemwEXl2KrUoJWUTPjfD78wJ4n3T18W?=
 =?us-ascii?Q?NS7HmelkKaxZEWUAGlp7LbBfk0104Jq/sbO+f/7+34EJD5SSjOUBntoVOmFt?=
 =?us-ascii?Q?utnCBfFpBECchTzqvnDym0TkiKxTnVDnQwCsrDUFtEGc34tIjEvcKeJrWGP6?=
 =?us-ascii?Q?t6/VbTJj3QqPlrsU6kdmdOAJqWWn3P24EjJB/MtboWy4YPxTrIs+m4hRs7xE?=
 =?us-ascii?Q?+DDxIpOdPNFUBPbkggJWpYi8ID2lTDRqHrVaYn+8ItS/EnS+frT7bJF4D/vD?=
 =?us-ascii?Q?jEP20gYEvFyZWDryB2hFPZp1gevvRnVjyQFRb+t1ItnOJZ0pp5LZTSfRIpgE?=
 =?us-ascii?Q?JaclmzASdX6I6yL6pfIhpaB1ShdXbXATa8RlM+hE2P4/CGGQhx6avxTlQNQC?=
 =?us-ascii?Q?VdxtvJOl42YXND2xYpzgwtlnlduaL+KRVry+k7ZddGcsBwrThhjrXe3RwXQc?=
 =?us-ascii?Q?TVfPHFahS2o2N7xDCb+scw66klOAKMkZQupIJUgNwmdOrNHaWRUTZRLYdVni?=
 =?us-ascii?Q?DGpt4wCPKiOJKONt3SEb5SWFtlyLCmUT2rKqmn2RoY0U6sdeWLxiqdkqlJYi?=
 =?us-ascii?Q?ySrCAZSWXesdjqZ/8KrU9e1FQqCPByWHdPcfyiZBriQjbevqaK0y3WLvQrVR?=
 =?us-ascii?Q?ELnpyvcPFXUjvrE0AGdEHD0cLJOt9QdCwnfsSLr/68/wIsvu2OsfTBXExmRG?=
 =?us-ascii?Q?uKJckU0fliq0bVwVI2JpJ6qz/pP4r62eGn+U+8ReGbf0x9c2sigzeZkeAe+c?=
 =?us-ascii?Q?0d/s4QXgomz2S5quarJ/6bnupZtufb0FhMKnp44SDamjXLbRXkU3E9dc6ikF?=
 =?us-ascii?Q?TM+S5qFeJDy+nP7YyrjJT/3XPk7NzbrcGbSxcdzREhkK/SKq2lsPnKfBm66i?=
 =?us-ascii?Q?Oyc7oFenE7CdfsTvT+4F+JhQ5JvjKE4zuWPmbdyBbnBpReDRTuaLtwsFjDRa?=
 =?us-ascii?Q?6f54ktJtePDSkmu7xO32SeNgpAKSkToeYQSSuNJipWUFh5+37RRYABSj316a?=
 =?us-ascii?Q?GlnMqRoyZtrTSVSVugKF1A/34yIJe4sUAgj5X6zeyo+Obct63Y8UhvqXEMj8?=
 =?us-ascii?Q?rDYT6DhEO3EU3BXKPerFWsD4d4qVFA1ilURhtzb5Dzub5exuXXKh/dOdzPye?=
 =?us-ascii?Q?hji+yfYcXBx+1tMGB3nm1dUPKOnFq7RAsKmLgjfcB4Qxa6ZtDFx2MJZrfuLt?=
 =?us-ascii?Q?jENmPOz/Ih7uEQV9dNfR6VD5We4WsS4yZZylmKzD/WqN7rCidd1wkn6zIoPp?=
 =?us-ascii?Q?2joEk0PnGWNiSjKvJLuhp5ADuh0MJJS/yny4j17SqoAUfIWtk/w/AtUpBAcB?=
 =?us-ascii?Q?K8PPYR/BYElOTxYsgEhcLIPdjfoyphNOKsPuqdwHagDGJ4gKTW+dYBNNeT0d?=
 =?us-ascii?Q?YBtV/ZiQAXLwYAi6S0JUgXWf60VFtDYI8GXx+DbslsNWi1VmWKKdIwPhZjRP?=
 =?us-ascii?Q?ByRi+F6kdRKEQ/HOm82YoeaIAMVuJ4b1+CCIIDDMrMWY3aNg7jxNsFokP7Nk?=
 =?us-ascii?Q?2sKXF0c8Tu6PKETnadhbvk+rPYcPtRSkEkVeSA6H8/og2BQYv2I3iARrTO6Q?=
 =?us-ascii?Q?XqH3b8JQMA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c97e72-aaf3-4c00-047b-08de63ddfa26
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:10:16.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbNVhaoKuJ3zJ2nUgtsJdKkBYj0R4MiZeIP1Z9l6Kog4T1QnK3UM4D9jQGPYcrqe+f1grXxpv9PxpnrM25FFOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42052-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[linaro.org,nxp.com,pengutronix.de,gmail.com,intel.com,kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu.yang_2@nxp.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5F1FE4EE7
X-Rspamd-Action: no action

USB remote wakeup need its PHY on, so add USB PHY power domain on active
flag.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - add flag to block control related power domain
---
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index 56bbfee8668d..8fc79f9723f0 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -53,6 +53,7 @@ struct imx8mp_blk_ctrl_domain_data {
 	const char * const *path_names;
 	int num_paths;
 	const char *gpc_name;
+	const unsigned int flags;
 };
 
 #define DOMAIN_MAX_CLKS 3
@@ -265,10 +266,12 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
 	[IMX8MP_HSIOBLK_PD_USB_PHY1] = {
 		.name = "hsioblk-usb-phy1",
 		.gpc_name = "usb-phy1",
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
 	},
 	[IMX8MP_HSIOBLK_PD_USB_PHY2] = {
 		.name = "hsioblk-usb-phy2",
 		.gpc_name = "usb-phy2",
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
 	},
 	[IMX8MP_HSIOBLK_PD_PCIE] = {
 		.name = "hsioblk-pcie",
@@ -724,6 +727,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		domain->genpd.name = data->name;
 		domain->genpd.power_on = imx8mp_blk_ctrl_power_on;
 		domain->genpd.power_off = imx8mp_blk_ctrl_power_off;
+		domain->genpd.flags = data->flags;
 		domain->bc = bc;
 		domain->id = i;
 
-- 
2.34.1


