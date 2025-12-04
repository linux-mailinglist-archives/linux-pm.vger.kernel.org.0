Return-Path: <linux-pm+bounces-39187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1634CA2F1D
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 10:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00E230607EA
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65B336ED5;
	Thu,  4 Dec 2025 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SbQzx69i"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC2336ECE;
	Thu,  4 Dec 2025 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839439; cv=fail; b=uN5qSYgRKoA+LmZAutaCxasr2xN80K0tK8hotsNSdqCWT2cKewphJiaBlv5WscByPjoFIfUIGqYdF7bJm97cJVvo4x1nKJrYg1eTkHlB9TCdyfV5FFsg6YaZZWvI1M/VSCV47ARGavDGXnKDI0IP9o7dsbHh5F0D6Pju43wDY7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839439; c=relaxed/simple;
	bh=qiiEQd9u6vJZ22QTY512tA3zpss8fOZ2V/VUTfICXT4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gWl/A5n8sNxpLMtdUquPWW7a4KKyaThEEEh1qRLckcBpGf2ReGz1u9it9fojysdjv3IbzJpgx4CVaQr1SYGaPRko2qBYPjtynQYeagbOVdHZXhmMFXYdqeInId4QfJA5OcMeZfuL/FUsktyXC3NH2X0sWlPcpHZBWjo3w4bmBNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SbQzx69i; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCMD1JlS+pSI2Fh7RhsipPhaLE1Usm3xyaAwM5R7p0PRSkePRr4P00Lsc7aA7D5OT4JCy9vSWIa9NnsV1+dlCRnZQhFADstsHXREdq9IsZtoraCONx145qIAdfnQatx9/ZvkD/1rzgTXu78IvfeO9edR6EPkoiRK1jUlxN8ji3lICDf84AwKUAfu22wiSEJFR6etoezwB04RX7+DaCJkU+9kZZVG1CWXqUeE0myNK0TRNSSyEQqnjxs3eel2H0TOdi7wISjDm91pkwZcFnyHVC7CbAUh1ZZYynkEgDqNtay7GRzj+1nbuKfu52L9W6qdRs+03SdEfRYK0dpEWWEoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2WdjJGjtQfWhPpQsw4qGGfy4pnB3yQfRR+RYPTglDY=;
 b=bZNibiTTTzNK72uA8jVKS27vHn7BrDiqZ/glbADjVWaT4YdZfwjMZfm2G8VdAnH0ifWygSUestEAetMSfOO5AIh1XdW/T0GlmQSNZkNego2Svh3U7Z+c/TZhWFnnJITrpn+uPZTBAMZvT9bZ7eC+/ouODoE34+3hubFNJt7BtA9mrAHQUWVsJ3UViKFV5tDdSMkrVuNIYFSvMnd50iKVaur9Rr6yNwrYErwopBn+8TmICnldTORKxiloo9kim5zRHOUfVIeHeVZis8KZpm+yGgYOdVjw1NIOv2UIESMSSgcqALlYOsF8u7KqckCppUd+iA//MKBFV5h+5WiOOZxrcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2WdjJGjtQfWhPpQsw4qGGfy4pnB3yQfRR+RYPTglDY=;
 b=SbQzx69iQvEOcC6Al96p+T57a3cOA9A3t1Ddar5o4lvEH2fG490OIR2HyDwpcjJubdMVFXQf0fg5+I/s9HVd5YZQD54hwjzZUtxqCc7D9itprwsv9iRB7PML5o0XAlaZz5JgThR3E+fjOMW5GvvFtexF7C7B/mARHGQJKxgSiWntFSB4GsxOS+j1WWnaolY2N/LHu4gePNnH4kT9T/41s5tMMrI6TypPhI3YieCS1QyQ4kGjvYKcty1addOi0X7WKn+hC70bumoorUYgmnp8CvbyW9VARrM6FVALg9Y+MBK0Qwl0lKIl2qs+dAA589EGfTyUxK5AGiu/F9oXGcAkrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AS1PR04MB9558.eurprd04.prod.outlook.com (2603:10a6:20b:482::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 09:10:22 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 09:10:22 +0000
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
Subject: [PATCH v3 1/3] media: v4l2-mem2mem: Add a kref to the v4l2_m2m_dev structure
Date: Thu,  4 Dec 2025 17:08:09 +0800
Message-ID: <20251204090813.595-1-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AS1PR04MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: 12de44f8-93ed-40d8-8fe0-08de3314f415
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8zdMEAawVas+PMgwQrXLOtJ76PeqoSTldurfYHVvRMNPfz9Yta6Z84mBSKuS?=
 =?us-ascii?Q?AysqOFC0Q6O+7rFYpL5Tchz78ZDHgaaMczgCosfuK4C8hOWv75c3pJ3c9Ffy?=
 =?us-ascii?Q?cTCgrDhkxgUHK7x+lG7ZnOvChFqA1Gj33hOnBhmZsc5h83sveEdHSNDqoiD/?=
 =?us-ascii?Q?EASAggF8bnT2Ij/2TmdcecYxbg8DjF50kLqa6IizK30yYTUUVyTBAzW1Q28o?=
 =?us-ascii?Q?o873roTDSjVQndD/CMajaQnEdynZjGlx4AY80bBa7pUdRD3NEJcBUDMew1fU?=
 =?us-ascii?Q?ALUV7WT1+C9Kcjp7x/Wpc1bzmHaT7IM0TtULL+F30yZequKjIOu5nvZw86cR?=
 =?us-ascii?Q?x2fKIad12n+3vNrIsaN+RQ0XzX1zheS0ICM7a9u6Cw6CIJ8MIwRLQ5QadcG2?=
 =?us-ascii?Q?S20ZfvLrLpmnvglm/ke963TyXDT0V3RdDPpEC6M2tU2vwOqLLm0MAQRPlrqV?=
 =?us-ascii?Q?iZxsxNiHDfnDJoqZDZnrbvMvHAxftwwqUBSHg8LzyXFHYuBlxbP4CdCBIzlr?=
 =?us-ascii?Q?BSBGSXGui1V4yTCWKgqKloIWSjbCYSO+VtlaAWRGHGHnih3ZtLUm1QG92EI9?=
 =?us-ascii?Q?rueljFQdKiarc1TzJ9LAaOEeiZJMPwgW13x45jqsL9IbiTX9CMkzjOemQsEu?=
 =?us-ascii?Q?kmkzlrDNb08wFgdbMhiAeHSGufzHot1hjcm6r5OgWP2Cr+zxe2WqwYSOr3NX?=
 =?us-ascii?Q?PpIcaaB+jy+2y8KhyboYFzIkxQQocFCQYG9DeWYmE+ms0RAxvearGm/sKc6Q?=
 =?us-ascii?Q?f6mb3xjSnrQgfwyrGQKUQZwMGwRH4QPjESIcTseFocfDjPoVpBDONKxVEJev?=
 =?us-ascii?Q?xrQNZ09ZIMR8Eh+OodnNYa5J3XpHijR9N7pIvcXfpKg6W6GaN7eu+gXpAlyM?=
 =?us-ascii?Q?ryUooGXL9UEh6AoApBFhwU8Upu1IGmWe5c0K3m1zuUscCcI3VuaMxAPEsfJO?=
 =?us-ascii?Q?+AYiPdIgXsDXM0ju64f7pVGZvUGSyd5gaJvYpyxDMOV/FpMgIAKPA7PnOMc1?=
 =?us-ascii?Q?F8s4GPuZi7eQ32vQTJ3ulWAbq7Y36yYklt88JQYTkXNx2eVbJgQgBYXn2VHh?=
 =?us-ascii?Q?FGx56ncx7AmBmc4Y66UovPJHnh93tqgWg6gtTdOA/CNCtBA1T9TZH30PYWdr?=
 =?us-ascii?Q?9As85pk1aodEOs2iQqnaboSqpdhweur/cDNyNlkjabmRQ5OomSLTsLewz+32?=
 =?us-ascii?Q?+lj5dlab3FZx7netUuyTH/Gd5jjuxfvekuXpg9ZlSwg9VCynJuW/f0qSRzq3?=
 =?us-ascii?Q?7Q+/1hkOCJPQ7O1iyychKlmxq7466K3keNqpDrpcZs40txxHNJTC2rLWf6Fp?=
 =?us-ascii?Q?rjmPTu2BpuydGGQTC/CzFddcWGKQvkNvoMET2t0zq3RgkrkMHHqUrEIBbFaS?=
 =?us-ascii?Q?IYsh94MWQdp6I6JkYo8FsY8f50cA46NNyaE5D7oo5elSnVeP7g6722mOswlX?=
 =?us-ascii?Q?2Fd1d3kmcca9tbHsTkcLDqTQTXkrXGEfveXaKDqfZWJbGbzpP8NpOQ2vZ7HQ?=
 =?us-ascii?Q?5xrZpjH1pw4FmHe25UN2f9qG7qhK/EuuJj93?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pghyhN/u1PXS3H7ZSmLAVYdW0aKj3J8rbYQDNFhVQqvIpiCV/2bxp8uv3OHD?=
 =?us-ascii?Q?A4GwPzD61i01ebDBTPTYigJzOiJIttiPG2XL5o+WPiRqofniJ7xP2HiEhOGW?=
 =?us-ascii?Q?/pFSzbfZ3PRnV+KAmSJ0hts7l5re00M4jAnbJhv8IfeXjRfT5rDGSUVFwf7W?=
 =?us-ascii?Q?IxOGK5Ph1ZSno9lqzUrKgn5DHuS4Cw5Hn21usWXRSD4/WxjpMFdqoBdd6N2M?=
 =?us-ascii?Q?CU2IgVrxSv1EomXU1YTgV1rx5osLatQRW8JyKPqV89V9ObVWBsj02pLt4VjK?=
 =?us-ascii?Q?soGbYKgksJue475zhXeh5z5iK6vq6JqQwzVCbTZbkvGJNObCZI+QKc0Nw9V6?=
 =?us-ascii?Q?mkI0l0+6Md2wcZRWA4z3Lhw7EJnio0xEa6nMZ+SvDzHJ0ImJLrPWyNgxKLXj?=
 =?us-ascii?Q?dfekUdo6SsRGIe065Sktqh3I9+uuuu2vb9mQ0q+nX33gd/RwU2BRzKW3p7Kn?=
 =?us-ascii?Q?g0CGwCNxGrQ9cAs/UJykEGmqefNHqI65npiwB1Yn+ldlnxqwf9vYIp/2r2Yy?=
 =?us-ascii?Q?Y3e4RiownTv0JUJRKXkdwYtXj1sPSiHkkb/vS8osIzMkuj0GlyzBLqES4lne?=
 =?us-ascii?Q?XZD5HvszcdAy0+sqS+6RFEqMULCI1EWROXnk7fTh8AG4jA91M47tCoidh+FN?=
 =?us-ascii?Q?OXtFBZRmziWb2Qi1GOpGhNsTKDiwpsM0buh98X8R3CommvU0WXI0vapKB04b?=
 =?us-ascii?Q?yTebQthqXa63WuOhrYleP+yr3MkTob3g2Zgdk3Vff5tu2qriw2kbKuZzlcVS?=
 =?us-ascii?Q?LTo8dz695WpO5MqxTH5XQqePOKRpcKLZncQwT/kJRQS7tR2T8BsceA83WLYe?=
 =?us-ascii?Q?+09q+vFU2REBPCSv5xb9Q0YJaasTzElNhMLiHRpjQMVYD4BInKucj1sKiXnY?=
 =?us-ascii?Q?+U5RGcl1FFX2zgX0vplRv79f7KJqEb7Rmc/twUS6iwgCLuViPfkVNY87YF3W?=
 =?us-ascii?Q?SVLhag7W03YbN8CEHa4tJltUWOO6DNQBc9V7jxohSZF0vIUG4YZ71pxxIMRq?=
 =?us-ascii?Q?2cG83i9kVkk56zg/wYnKcjXbJzahiiuVJ4QD8Aa2wcftc0l+tszj2Oq7mUtw?=
 =?us-ascii?Q?zWkDs3x16BAILeAmZCLYWXU9sCf0vRKlpUHxswIqahLfeMKJuzKhr2mTzo5K?=
 =?us-ascii?Q?1iaMsdSyw64aVwmMQCTcIYai+bTEWCeOJnlsHZ4Yk9wsBiYvQLHevLLBplHA?=
 =?us-ascii?Q?EWA8R2oAvQF0Q5wMCya6z74YTJ/CIxkKSgLhNmgYf667j4GEyP0DA31Ma/Is?=
 =?us-ascii?Q?O5oRn670yUC+uMwnBhq4Msx/hpWi98XtFHsh9iTEg/HsZq811kAJJ33d4Kcb?=
 =?us-ascii?Q?6bmcEiP5PzLMWhqkbu19bIk8wYvCIozGw+Z5Mf8LWy5AhqhAoGMnf9nL08eZ?=
 =?us-ascii?Q?jtJ+lqk7L0Z18xlyNtJzaR9mEn8EYmuPhn+QMpJR526AVU5HEJXw/UguwJGA?=
 =?us-ascii?Q?PTd51JnTCeDs2JD9Tqtor1Q8hok+3qU8+mQpUWQHcIbRmaboMuFd0aHG3xsv?=
 =?us-ascii?Q?hzKkUUdnFRI/0F+pBLRRyw2mXTRVgc6aUjj4jIRh8CdKdKPK2kNEKLcggCgj?=
 =?us-ascii?Q?FoOigEwKo8/8P5fNYCyFeDYUlJi0q0BcC2PBE1Ju?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12de44f8-93ed-40d8-8fe0-08de3314f415
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:10:22.3761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwl4RROsYJwRf73ix2bSwMbBeyb/Jbepu/np7G7uRMkWqRLyoT7EZrduU/Gg1TIuxYHqCwb5wVz42e4D8fX4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9558

From: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Adding a reference count to the v4l2_m2m_dev structure allow safely
sharing it across multiple hardware nodes. This can be used to prevent
running jobs concurrently on m2m cores that have some internal resource
sharing.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 23 +++++++++++++++++++++++
 include/media/v4l2-mem2mem.h           | 21 +++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index fec93c1a9231..ae0de54d4c3e 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -90,6 +90,7 @@ static const char * const m2m_entity_name[] = {
  * @job_work:		worker to run queued jobs.
  * @job_queue_flags:	flags of the queue status, %QUEUE_PAUSED.
  * @m2m_ops:		driver callbacks
+ * @kref:		device reference count
  */
 struct v4l2_m2m_dev {
 	struct v4l2_m2m_ctx	*curr_ctx;
@@ -109,6 +110,8 @@ struct v4l2_m2m_dev {
 	unsigned long		job_queue_flags;
 
 	const struct v4l2_m2m_ops *m2m_ops;
+
+	struct kref kref;
 };
 
 static struct v4l2_m2m_queue_ctx *get_queue_ctx(struct v4l2_m2m_ctx *m2m_ctx,
@@ -1200,6 +1203,7 @@ struct v4l2_m2m_dev *v4l2_m2m_init(const struct v4l2_m2m_ops *m2m_ops)
 	INIT_LIST_HEAD(&m2m_dev->job_queue);
 	spin_lock_init(&m2m_dev->job_spinlock);
 	INIT_WORK(&m2m_dev->job_work, v4l2_m2m_device_run_work);
+	kref_init(&m2m_dev->kref);
 
 	return m2m_dev;
 }
@@ -1211,6 +1215,25 @@ void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev)
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_release);
 
+void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev)
+{
+	kref_get(&m2m_dev->kref);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_get);
+
+static void v4l2_m2m_release_from_kref(struct kref *kref)
+{
+	struct v4l2_m2m_dev *m2m_dev = container_of(kref, struct v4l2_m2m_dev, kref);
+
+	v4l2_m2m_release(m2m_dev);
+}
+
+void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev)
+{
+	kref_put(&m2m_dev->kref, v4l2_m2m_release_from_kref);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_put);
+
 struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
 		void *drv_priv,
 		int (*queue_init)(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq))
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index bf6a09a04dcf..ca295c660c7f 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -547,6 +547,27 @@ v4l2_m2m_register_media_controller(struct v4l2_m2m_dev *m2m_dev,
  */
 void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev);
 
+/**
+ * v4l2_m2m_get() - take a reference to the m2m_dev structure
+ *
+ * @m2m_dev: opaque pointer to the internal data to handle M2M context
+ *
+ * This is used to share the M2M device across multiple devices. This
+ * can be used to avoid scheduling two hardware nodes concurrently.
+ */
+void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev);
+
+/**
+ * v4l2_m2m_put() - remove a reference to the m2m_dev structure
+ *
+ * @m2m_dev: opaque pointer to the internal data to handle M2M context
+ *
+ * Once the M2M device have no more references, v4l2_m2m_realse() will be
+ * called automatically. Users of this method should never call
+ * v4l2_m2m_release() directly. See v4l2_m2m_get() for more details.
+ */
+void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev);
+
 /**
  * v4l2_m2m_ctx_init() - allocate and initialize a m2m context
  *
-- 
2.52.0


