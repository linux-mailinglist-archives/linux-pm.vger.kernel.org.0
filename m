Return-Path: <linux-pm+bounces-17844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE8C9D4864
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 08:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6468C1F21B16
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBEA1C7B77;
	Thu, 21 Nov 2024 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G2XfIG7c"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C74206E;
	Thu, 21 Nov 2024 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732175592; cv=fail; b=WRBN8rA+6m2KfrRQWgf1VdjUkZnwrtmwpDI5XR3hnUjrKCrK65nijva38lMzQVHo+tXAkP8UEoPeGrHnUHe8XRWcX58iLFaEtOcHFFTGlbziQvYjxfoElEP2tP3a3qNqXEfo8vc2IMsn+ZJZmvMuKfECcBgSegCGQmJoy7rgy1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732175592; c=relaxed/simple;
	bh=aShtPINNsDt0oiDKHd8z3Kibg9uYsyLOLcIKcSoOV/8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DRya43XeJLvMbE1C1LwJMf+Z+knIjRgGaaxtsHhkVEouwsaj//k/fNKDzSNgiJxap7VfnWi/1zjyk24vh3GRSzqSIAvtblFL9L9ZbSLLMhZiuoQaNY8VFh9Qpew5VXCtbKoYl2olTLvc7UY7CXABK8YR4F3qLpxr+HqDwCUbUlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G2XfIG7c; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5GEZOs37b2SN5t4ttpTmrbn4aH1cfgjdHfeLyDIjbYn5kxjnX5qmtuxL/FOHFgsNO2IngJvd+qOR1XPh0GCV55jG5IO1Ywszlmddzq3WWo/YZRrR4LNfgf8SuPqxkVS+OrMXC1NoycKpHoSU+JaXb1QovwhnApfA5hZAyPdfaDeZJwnUD2p4FCpyn0QaQ7ZFSREfY5zcD+6MN4qzblMZC+nhkCtvBc+T/3mbs46ZVGMpP5Epv+LiLqLZHuO+9i9MOy4OHm28AtQukLGcrwBa0e65ZoTSfBm9X3YPXztmzigHw+9eAX+2v4Ye4K0kh7DpktIG1sKvmTiYWaNNMPpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MyijtqZE88upHAS4CLKX5aJXzf2d3JCyL3Mw6Lznqs=;
 b=kwy4jqzpYjGIHApOQwuP6u3l739XK9czYOBsOVTkI/n/3QzjJjkDmRFNAAasfVXx6/fGHlGkJuatdz5eBEdW9WF6JxRM3kllTrmsuQrTOMf4GBO+GJ+gK95WM5yitGpUJxhfP8gLaodAJc/XGCslC3uZQmgfJkgqjJrylbHJOpgOI0rxV6bO51dABXEU0G6Q37IugAIFUuacoi+TibP8Bz0+qHEJzfDqdant5BIuWNa28zNHnvfgQTZTNyAFDM0UVUh7R7l0x14lSEGkohxfMKhoF3aiC7uc/nbsMwNYEllKRezzqL92WW8eg3aAiboxbtym2POoz/BjITCfdrGAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MyijtqZE88upHAS4CLKX5aJXzf2d3JCyL3Mw6Lznqs=;
 b=G2XfIG7cLCzKa6sh0nBikiwZLM5930fPeL4cAmG4dIm2eiLlYlYwJKwDwd1MTL9jIhQWGgL7pC+P66pBQxwX756mEAQUSfXhTaHp4YkUo5PBnqQF4x+AWWpzU/jTAWB6Yh4C4+f1spAE0pHsxdVkD9fywRBKTYPp58DOO72ViNictoA5OThh3WZthIBRlPNdH49qNJ+8K5qTGOycXLUyuHaIiR2Ky9KgQjn8jwKUq0TVFFRnMAeo+Z00pUpvEY+gTg9debUt/A+qpMx04p+2aSFs0tqdsOj9P7K+EqSpvc+X+aqVoHAA/tYtvzJxjyCNhvhH8KCw2qYjc1EHBOMnWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GVXPR04MB10538.eurprd04.prod.outlook.com (2603:10a6:150:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 07:53:06 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8158.013; Thu, 21 Nov 2024
 07:53:06 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: ulf.hansson@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com,
	francesco@dolcini.it
Subject: [PATCH] pmdomain: imx: gpcv2: Adjust delay after power up handshake
Date: Thu, 21 Nov 2024 15:52:31 +0800
Message-Id: <20241121075231.3910922-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::7) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|GVXPR04MB10538:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d86a302-4e04-43fe-3f54-08dd0a0188cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KXnqDz8s2fYpf/R02EJNU8i1XaDBcK9W47Q8zgYmE2bTJfL0fSHYRtLYTHeK?=
 =?us-ascii?Q?nXUUGHlZwPKYiM3ONTVr7ftB2VSYVwRMv/CeDtezel+5ZpsEgwCYI1vUXjb4?=
 =?us-ascii?Q?9R+f4tuXg3xJ0yTo8whPzUnurWv2T5wpm2FeJXO9qUGPpwfr2LZygY/Kv/Eg?=
 =?us-ascii?Q?qCZLHBmfFMBLwiP03rQt2kOkJHur2DK1j1BiJeVW3NBiT0yn1LAeUVP5AKU3?=
 =?us-ascii?Q?ecKwEkBJ4iOa6MSwRBTaft94cgfipURFjfNg5AYQwKrifwiGwgEIkpDaKbTO?=
 =?us-ascii?Q?s4E71M4UrTRSk0adqLWhn3nwB5mU6Qt8ryMe/RGiozjC8uRvFMdlHjtNfCaL?=
 =?us-ascii?Q?+92+9V7pEqpXDsKqydW3o8SFZtjswfLEQ+FCO5VpwTEJFeMn86VqsAqQRzy1?=
 =?us-ascii?Q?Y+8YKYTxv6CvVNWlDGqI0+GZVp5HlpjE84v1Y3sPvBCJ1wIB1ODMK56rjURO?=
 =?us-ascii?Q?XkO82CJAEcXGDqltTreIiWH1lDruOg6KHnPa9AYN56ZTi/OwG/wvtotBUoDN?=
 =?us-ascii?Q?AzOBWdH29+evuUIFIsl6b6B90WzHFKddOYJfjKEAYBPNmg47kYnUIyMcT1vV?=
 =?us-ascii?Q?9BFp3U6jeaqt7id9YdWExE+A0k4wQfIQfjWMDdJirkKCBrWb2izeNCuPEy0j?=
 =?us-ascii?Q?l5PaCMwTb1HsCIUJOWvBVfGsi5OlQjBWsbyCyijgcvjd10UJkRcwOVczbyjg?=
 =?us-ascii?Q?9qFzTL+VFxNOol0mpTKen3UafG0wFac6irk2NKH0nXT03C2VI26WUHphXPPM?=
 =?us-ascii?Q?9IT6qrwSR1ECsOYGUCIfUL4cUg5tgnNbxiBfvPe3T9BsRa++XyfBia1xzpBh?=
 =?us-ascii?Q?FxMgCLsRCm9VmEigEbyKoHVfXAat2m91o6nLJgUUZiBH2ipdcx9qr3lZDBp1?=
 =?us-ascii?Q?RHaKvpXa7wv1eYhlEsWvhUrVCocmw0/BAvecYVz1M+5gdrSZFHYo7JqWAneM?=
 =?us-ascii?Q?hX31IaGV5VciD8rNkGhPUXoylUiXoR0PDYMFMHVc1+PpOOip1lnjd4utGNxd?=
 =?us-ascii?Q?O4OPKAaQIUrIRoOaSZIpxo/jWbN47Lh2UIic4N0xzzygZ35f4PjvAK63+w5V?=
 =?us-ascii?Q?BEcz8HYE7SCQ+mRGr9pmBhk8MjmwAmcwD4l0kVUYRjFzJNYPOkOQ7Pyv8F9b?=
 =?us-ascii?Q?govP8LbcN5deppUc4XLutRKP53foRLAyz1dBIQ4AcFM4G80K+8RF4vKp8bHs?=
 =?us-ascii?Q?ceevYScNV3hdLUvwU5J63bnnW/Q7vkBbxpBs8VZ8GR+/DyG6lPX9xFOPpcHX?=
 =?us-ascii?Q?YzDBkPWMq4MkM+u0DhFK1ws/1WJereH063o6/u7KOs9RJ8Z9pyVi8/At8JL5?=
 =?us-ascii?Q?GTnwIthVKNKk5Hp0E4hblsTX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LTiEx/li6APIrBDXmstdu6EyNzp0lhz/sZMxQkLWQXDPqjFEsGbkFFqhUBqJ?=
 =?us-ascii?Q?wKX46/g8vdbVWjR6TsTTSWmGO7pdCypgNpJGNFo53o/KCWIFpUJzutMPbwZI?=
 =?us-ascii?Q?5c077fdxHS3l8pYQ3Vse7QFL3UGiTpWkXjvn9Ff4M879sKoc9W0c0C88QyGe?=
 =?us-ascii?Q?ORhLXbl416LrfJ71FDtVwmVUDgsFUibNE5GhdBTEqpAVrx1Vug34ZnJCtCBi?=
 =?us-ascii?Q?C3mpU8R8Qip9Fj8eg4+8TV0IGoD4WWskVs3wFxbRzRsOqIaRxGqSvcp52hka?=
 =?us-ascii?Q?arH8sQSjVNyN/Bm7EjYLAnmAm0te36ajckNsd+7D/YAJDcjidldkKgnxZxEP?=
 =?us-ascii?Q?WK5QkKyYJOm28LhPP1rh9SDms/QKj7ERCfTypBBeTZL4dRPW9iqzBC+SPIZM?=
 =?us-ascii?Q?uw7wh1C4Iesn6JzUTwCmKCGFT2+qc7IAOhf0/WKSU5YBX7mCTqf3gbO1ePSa?=
 =?us-ascii?Q?Hddx1nHVjHazSpmQkRyC6PHcXkpXY/IV8H0wkPEBWq+i+mI8zvD5s18wbtIR?=
 =?us-ascii?Q?ugk/WH90oJz7UHLQz0MhxkMEvMi/Dk75Ra/N7wfsJ2BD6b6B6KAMj2MsS0uK?=
 =?us-ascii?Q?5bI3qufWHUuPNz0g7b3su821mLPOLbC9Ij5m5MeBzLaoiIAufswDUF8uqoA3?=
 =?us-ascii?Q?oNkZd3SHfgTFgi9ZSjYr+9Rdx//spKUCJe+0QJwqmGBDpoCJT5MYZLUmFgGB?=
 =?us-ascii?Q?4r8lhI5CsMM+mxr7L+kArfjQcfscPHXh81H8Mt1FUAEg7erZ4C4SWCbsTQje?=
 =?us-ascii?Q?VOiy0UR2CCARLTn3LdghzARrmj8xSz64NRm2vx2HLQFo0Gml91Q4UPgVMfho?=
 =?us-ascii?Q?U3UXC7ScEmzQbiJytsJg+IGJWQbuDttaMFqz4mQj+/ZnJb5b1nnhuAT3PRcN?=
 =?us-ascii?Q?kgK9kibjDtGnbh76rxpjekWL3eGTy9Jd2ZApBC30NB+ZGTmi88p9zIEiwon5?=
 =?us-ascii?Q?K6B7YaVWVZMp8HP6Z0vp/+T3acRCWLQ2qhVgiGotwgo6bvSdx/E+AhK79ITq?=
 =?us-ascii?Q?q8ErwVCv3yq8O/PU1a88RG3n2uxZz6jYzo9mmRahdLZyEbsUzykKO41f44Nv?=
 =?us-ascii?Q?iZnzyPqVlHJbtDGk4Z5ghId20bg/Hj8GIuWIirU9+O2d2hA8xmOgwKkk/28T?=
 =?us-ascii?Q?5bOl8dBRoZ6uQ23/cHzwLnnAyYDAL5vVZIu70Q2oyhcI+8cyG4LQdBLbuF22?=
 =?us-ascii?Q?+BJG12UbL1y1J8gWGD9XTqPPGeYRMPxijtjQMqyoR10qG7JrsIAPx3WcscQW?=
 =?us-ascii?Q?gyhhaKlgXxECuZ0BX2yn5oAHcoOOnkz0Z9pjLYtXxUMNWbERmCeQPomr2epD?=
 =?us-ascii?Q?GIfd9TiYaDDV2gRsYoO9wTdcFGrObZoC/Z9elgGwjkqWF8QST9uyLDyZNXP4?=
 =?us-ascii?Q?gQ0pPZQRuxePaiAATFa55kFPyrIN+WaE4fUcNCf8b/X60w1dDzhKSjL+8ZiE?=
 =?us-ascii?Q?hbGzkF62+EYBoJfOTJWu+ZArJeuppYV3HezdtSAvKRywJJszIfoSOVUV5Mnp?=
 =?us-ascii?Q?YijyupvrEtYhfV0fi1jBCsdOMJEG5aV6C6MzVRroQv0ufizyloGnoQMEgyz0?=
 =?us-ascii?Q?ME0uPtma0Z4s6vLtjYgWz1s/VR4Bkk8bBjjHk5cD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d86a302-4e04-43fe-3f54-08dd0a0188cb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 07:53:06.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tuH3cBdfneG62w4DAbltndNqH+jBzz7mTHPcNPC2Tojf/jU9hFd1nHW3PnjWIpLJGmdtzlk3u2uFtf6wiHbZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10538

The udelay(5) is not enough, sometimes below kernel panic
still be triggered:

[    4.012973] Kernel panic - not syncing: Asynchronous SError Interrupt
[    4.012976] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not tainted 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
[    4.012982] Hardware name: Toradex Verdin iMX8M Plus WB on Dahlia Board (DT)
[    4.012985] Call trace:
[...]
[    4.013029]  arm64_serror_panic+0x64/0x70
[    4.013034]  do_serror+0x3c/0x70
[    4.013039]  el1h_64_error_handler+0x30/0x54
[    4.013046]  el1h_64_error+0x64/0x68
[    4.013050]  clk_imx8mp_audiomix_runtime_resume+0x38/0x48
[    4.013059]  __genpd_runtime_resume+0x30/0x80
[    4.013066]  genpd_runtime_resume+0x114/0x29c
[    4.013073]  __rpm_callback+0x48/0x1e0
[    4.013079]  rpm_callback+0x68/0x80
[    4.013084]  rpm_resume+0x3bc/0x6a0
[    4.013089]  __pm_runtime_resume+0x50/0x9c
[    4.013095]  pm_runtime_get_suppliers+0x60/0x8c
[    4.013101]  __driver_probe_device+0x4c/0x14c
[    4.013108]  driver_probe_device+0x3c/0x120
[    4.013114]  __driver_attach+0xc4/0x200
[    4.013119]  bus_for_each_dev+0x7c/0xe0
[    4.013125]  driver_attach+0x24/0x30
[    4.013130]  bus_add_driver+0x110/0x240
[    4.013135]  driver_register+0x68/0x124
[    4.013142]  __platform_driver_register+0x24/0x30
[    4.013149]  sdma_driver_init+0x20/0x1000 [imx_sdma]
[    4.013163]  do_one_initcall+0x60/0x1e0
[    4.013168]  do_init_module+0x5c/0x21c
[    4.013175]  load_module+0x1a98/0x205c
[    4.013181]  init_module_from_file+0x88/0xd4
[    4.013187]  __arm64_sys_finit_module+0x258/0x350
[    4.013194]  invoke_syscall.constprop.0+0x50/0xe0
[    4.013202]  do_el0_svc+0xa8/0xe0
[    4.013208]  el0_svc+0x3c/0x140
[    4.013215]  el0t_64_sync_handler+0x120/0x12c
[    4.013222]  el0t_64_sync+0x190/0x194
[    4.013228] SMP: stopping secondary CPUs

The correct way is to wait handshake, but it needs BUS clock of
BLK-CTL be enabled, which is in separate driver. So delay is the
only option here. The udelay(10) is a data got by experiment.

Fixes: e8dc41afca16 ("pmdomain: imx: gpcv2: Add delay after power up handshake")
Reported-by: Francesco Dolcini <francesco@dolcini.it>
Closes: https://lore.kernel.org/lkml/20241007132555.GA53279@francesco-nb/
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/pmdomain/imx/gpcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 6e6ecbf2e152..760301ad8e39 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -403,7 +403,7 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		 * already reaches target before udelay()
 		 */
 		regmap_read_bypassed(domain->regmap, domain->regs->hsk, &reg_val);
-		udelay(5);
+		udelay(10);
 	}
 
 	/* Disable reset clocks for all devices in the domain */
-- 
2.34.1


