Return-Path: <linux-pm+bounces-31464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E305B1359D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 09:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6053A64AB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 07:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B65225A24;
	Mon, 28 Jul 2025 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GR1BqNsU"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416F19E97A;
	Mon, 28 Jul 2025 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687142; cv=fail; b=Abo95H0wNo2kY5g9y5LJ5MCQAP+F9EwMxEhFs9ekpIkQc7/Oa9twokpuRlm9M5NBZ+ifeefstFRXK3k+v+zhRp/buOhIYr+JoADI/ZETZTwS3ZVt1Lh8b2frWlFBq5Hdl+0UkUPFHefuIXcDJabxZQsKWWxWXD5Bdem07FdJj3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687142; c=relaxed/simple;
	bh=JZBdPd/DMJc78OM1kc7pSALavoO2spdbYkv/+nygUJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NarKTuOxrhxeGbbkXm8gkjiQgwFs6bXTkz79vl00oU/SHPWQUvJmh9jl9F43OmJ72RjiqZYvvMkpM3T+5/gffmjZYjhseBP1NlVq+PR4TOLS0xI3snQSjPekVu9IAqYLPBKOBCP7RaAkDRTDRdIWm96B94+ywP2/px+F0sOgLm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GR1BqNsU; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc6hcmOnaXT7pSoQUpnXh+WVbZsbjyNpAFPQFoezo4kfmU9Tk/aGoDvmmFflBCQay2p9TwML7JUwdH9yBw5sGYcEbwvIlH6zgbAxMN3XqW1j1mFyKaZvBNQk46T6SD06rWvm4oIYnjHnHptJbUN7yAz5iW3ofVHrI/DpJ2ef0niqxAhoW0PAJC+IuX6rEjS9qNH5zQwNNHgzB/wp8ICZs45QFkuflWVoeEAmTvB91i481IoUW4+qK51joF5Fzvb0iQHB5FrRldOxW+u0IJS/CsO9iexqvejfmpFSPm+XDge4WE/bqNmnM/4VPE/SQA8kBWrPTEAHFO/E28wVDg8rjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6Jn7mbPzfz0hkLfRblTp0nLoNvEsopbWUGJlN0/7fw=;
 b=xHpM8p9Db/83J4Pz6lXeu/X+zYNxq9mpoJMR6exJ1/9FN2iPHn1Yal7ODmuMJyXoctfgjzT1Jslb2A9mazPdlnaljY0uwFexzpk1D481YcLSMyTvi8dLQQGqm4NZRZQ0g5tjtAuRbUm/u3z5zy0ai82IuPdMSjdnBVdt7sCK1FKLYBfFLUAxg8mtQXMSqNxvhf5XOrQCyNoYuxQGClYQO7nOCaB+pESDRhgAT2wAmJdY4rwfNubP9wI/8Pi/Sd8r4Vkb4EXBJc5MMorz1V6HOy1XxIjkTe3Oyd0B8QeqQYdtTCfStg+M0LqAvsvVWDwOV4TaPpYVBuTYuyvmyZuNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6Jn7mbPzfz0hkLfRblTp0nLoNvEsopbWUGJlN0/7fw=;
 b=GR1BqNsUHEz2P1kj5BSQ9Ee+nFpC6MuvZkRSGQIlpRgnMt+j6iX+CFoTUfMDBp10EjvX7v112Qt2fwIaUUI3tBb2o9kyOfciGVTRUIF8LoJ2ehA/uFP6MSToCC73Zp1pxl3UCxomIFHAR11dm1ZeVv8T7eisAfS5oFTXKgFSKgcQXQtCt9fFSE5nL4g6q/ep6Q/nB0x2VPyjAUdoic/dGQ260dZotdvFsBAghM+7Z+eSnSorLU92dc5AnQDdNLfQEKmP10VPkzRbi7JIcCbu0nGtdH0uM0kXJUVpN5Vj9cyf4t43a6ykNiufkl6Dv2y0LQl2bvrrl6gnE7GZMfq3Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:18:57 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:18:38 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	richardcochran@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	ulf.hansson@linaro.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	frieder.schrempf@kontron.de,
	primoz.fiser@norik.com,
	othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	netdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Frank.Li@nxp.com
Subject: [PATCH v7 10/11] pmdomain: imx93-blk-ctrl: mask DSI and PXP PD domain register on i.MX91
Date: Mon, 28 Jul 2025 15:14:37 +0800
Message-Id: <20250728071438.2332382-11-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250728071438.2332382-1-joy.zou@nxp.com>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 837577b4-f391-48cb-e9ae-08ddcda6f8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YQ3pyLVwyA7nQEjjZ5jE41onaMWmnyWlBMpilPxUBfvp9C8kF20bHTqT/KpB?=
 =?us-ascii?Q?8zFqVZQXIAvP4LxtA+Gh+XAS79C+NzuXCexsoVBY8HvGalzizaKCfXWYF1dC?=
 =?us-ascii?Q?XQ/599EndtL9aLts7uoPdkYd2JK4bhOX2qUBiTaAEz8/2Smg0XohXH7HznJ7?=
 =?us-ascii?Q?+ufJpoxe7ONY1MAbR2OeTnkeCqkNlFczEjL4wClOJM+VhrTq9Y9cMBZBpF0b?=
 =?us-ascii?Q?3od0rIO1GewzDvowBGzUcpittLgXM5bkmofhtCsK5XtQhSwf8ngP8uaSRTVR?=
 =?us-ascii?Q?ElJrf9PCh1qmd/g+5jgiSWBeZKtS6GhkqegB8HAlR6WqIcZHVZpAMW4+yof7?=
 =?us-ascii?Q?GyxO21LcNTz+AqsFehnmfw9v8HHjcw6FfBnv1qCjOcPzpHbF9YSuLXCK9/AQ?=
 =?us-ascii?Q?oWn3urhQaGOeuvHYW0e80vFC1ymkGUxZK/3mMKC/1gD0pgK9YpwC4iztzibs?=
 =?us-ascii?Q?glamjjnSqocDaQPT/UpnmFyjG0u/eFDo2bjAVTRmrJh73xcfwImKEt0JaE6K?=
 =?us-ascii?Q?TducX3xQUpbv7BbiI6GJfyDdAX9ENjmcpVQw71KETdVaKb1pQxJKTGMgW9uU?=
 =?us-ascii?Q?8R0anVPmjg9+YJt+XqhSKhWaO4KDtLlmINb3W0PZ1U0T6Ztbc0ODecsZNC5w?=
 =?us-ascii?Q?myT+0WdvOGFbxN7oYH8K3f6qWO1pVKX+aizQ8TbXKSxBR7v2zKrGe28j4Uz3?=
 =?us-ascii?Q?zOiKUn+gnqVUFkiNSWy43LnEOZR6CDuFNvFoHskbRynOgefnh32ZiFByq10a?=
 =?us-ascii?Q?z+Dl5ZGXAloYSFnBMiKofMc/A9Vkw3g+aAbI6f85eJYhUk2jwIH5/ABRrY8k?=
 =?us-ascii?Q?YC3ZyRjsvc7UOJ1e9KRN8Eo5Krm0nviIHmGdfvYjQByeIA75ZL2j3P1pqH1n?=
 =?us-ascii?Q?886odfuvmjYEjE2l/WWYX+udeFeG0KqqTr47IdJcoWj9EVTNOAad7bnZsLTd?=
 =?us-ascii?Q?ACv7tO0VXbRuQ1Kvpx0Zf6vB+X+476VThyfFjq4HNEMH+XBV+JWdw0kc9YBJ?=
 =?us-ascii?Q?RtQEBJIvA67IRgSaqiBG79SBoQwgJ0/kIs0CV1UnnRcqA6Pz2/NUXENFTbI6?=
 =?us-ascii?Q?1FaBQoPjrU/ufUJT9Cnzmmy4UvCoY5OCRDOnB57XamvCLCLKyFLaWxSd5Wqw?=
 =?us-ascii?Q?SCD0ReICne8RXD1/TITySD+Jq1Pk4U0Lu+e5T5yETMeMUlDEZEQxMzOarIOU?=
 =?us-ascii?Q?z+HthE8Py8m5beRtg1l9efYeNDZgGbaMKSoAH6mmMf0XCXYQb5adShOrAL8f?=
 =?us-ascii?Q?CPsHpXlgZse+nbMJ5rwLy/zo8/CFYgpHszcwC9kD1JgLhPSdGu6emvh6qJQD?=
 =?us-ascii?Q?T02unSa/7Mx1vwh4wDglJZ8UVvD2movjYtjq2sfp6HSJ44ro6KRqSqTLCnV2?=
 =?us-ascii?Q?MnZCCKQVSHcd8olSb0bMuWYfg9bUC7ET8pSBKx9mEandeUBShz3NLZ4QXxLK?=
 =?us-ascii?Q?HtR235V86OxIVtlf0QhGdjclqyXr9HWEYuoJFRko82/+YjsaYmHQrMNZIwe7?=
 =?us-ascii?Q?dV2anj9OJ/w0pZo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oGuuL4ciSt6AI2FL2Ag2kqnDa9V4eP96AA2xBL5xdeiROUsFLolueaPPh/sd?=
 =?us-ascii?Q?YtMSI5U88u6GtM6gUJTCK4eEv+KrXhuIYNa2WT2IwUsW9encvpMwI5LKpi63?=
 =?us-ascii?Q?LYZbSwTZ/pcNRoGTWtAFCVR4LSqb5VgDOv0RUKLeAVWD/9ZwD9ykWwgXBcsm?=
 =?us-ascii?Q?E13l9hzvmLirkCZypcZAmCBue1pJNkRSveyV8W8A3DaHP+x+/P4JoMPwxTUI?=
 =?us-ascii?Q?vRySlNkr+uHYIaLQ/6lZv2fT/e9bzRey9xssNcGj7thg1IGE9AUHkILv1NQP?=
 =?us-ascii?Q?0zeuhwqbKwYhWwE54oBSTluCh+4xZvZFV2BZCuo5+sIQJjsKRqSiPhq0QEfA?=
 =?us-ascii?Q?87er9GzaUcwAYEvZnFI3nTcdMkzi3Jg7dDLesdmN49016t9b6lVYQ0WdGd5D?=
 =?us-ascii?Q?pbuw719jHOjSjeBiZXnwSSnq+76jltpKME3EYBQMuENDMdclHf0ACoQEFSVR?=
 =?us-ascii?Q?2/UCRd5cJ4BM2s4OE/kLA1RqZmvBqxsS6ARN9Yq01ZmRtyJcgfOf30a4MUC7?=
 =?us-ascii?Q?2iYrGY/aw/WsWfpgIW68SZhfWIiOb43LtCKiCJ1Ik9c+7x26S+H/qCdlQ0cY?=
 =?us-ascii?Q?Mtj2rK+6X5Owyyh5T850OvtKacANSnXoknwTXUXGhNLKuDOznrACRXKvGIgU?=
 =?us-ascii?Q?b6lcLpbxCz2lzGf5Sl8EoQo9SW7pkYC2ZC5UgfQmCBAycnToXGW4A7dcuO7v?=
 =?us-ascii?Q?JpwG2g6kCma/YCCreYjJ2BDju/YPffZxg13jFWCBOQdVie+pzniE1PqZshcU?=
 =?us-ascii?Q?1qZNiMjP+Jt469/RCIPrW4nUSvKUG3igSolkm1uH8IOU2/EVwOxDERdgU92O?=
 =?us-ascii?Q?6/F75RbRXoLTOODDm5OpFtyJHIfm59KdqB9XP43mJk859BySgkRkBL4cyL+b?=
 =?us-ascii?Q?ZvGj6oP7kzAfM7Yviz35S3BZpT+6PnstyaMVktMPar93QSMnI3QlOKJATwSR?=
 =?us-ascii?Q?pHh4OsvcGpCY4CX5xNAU4SDxoKujW4q4ZZdSO5O/vRNv7sSukQFUbBg1v3+6?=
 =?us-ascii?Q?TGU+EycoPw01QyeE5tFLGSR9TMXtvUlOY2wSmWZAF+79aDasvXeHK42fIRVj?=
 =?us-ascii?Q?JW4rr0DHft49nkL4ffqusJlJsMiF7t4S5Fcym2hMity/JO6eEEatT8do5SSP?=
 =?us-ascii?Q?I3xEv20JTlESj6jIntL6RXQs/VzBBfHW6uv/dVHwvSkzxpiMFEDUnGV3sv11?=
 =?us-ascii?Q?wTqalJEAVA4/g/207enT8m0aHs0ZngbdQVeY/5TRjIksQfsfnF78CRHvgsny?=
 =?us-ascii?Q?9ip3to6hORPyyFVXKhIy1vJNizXcFj/5UysqIqagMDoRBxLqy7kNuwOErCh7?=
 =?us-ascii?Q?j70ZwVYw4Mzmm8jdPiay2UoDKXCvASNDlAgs+MIs8gtOVQAXvDczVzRb31cU?=
 =?us-ascii?Q?abxeE3Sa2yfC4QA50SfvKwQJmk7s5WGknegESwmYE0JCNG7qb+iq/xFdJpde?=
 =?us-ascii?Q?jlun4Bv+iRX4QlJW/TGEP3A+PkNE9Yw23fM2Trweb5gZB9DUrTvp3ff/XdAB?=
 =?us-ascii?Q?Ibs4QsmsWtZTu3tcGAEF9yl6pXiPry7VDSk4kJXyQOSDfnOrX/mKQdc2TP3M?=
 =?us-ascii?Q?cReQTRsrD4LR30hTUUW/4XpDLFHuAvWm0+FrfEOr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837577b4-f391-48cb-e9ae-08ddcda6f8e4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:18:38.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hl1Z6ziaY7zcVGOcRUfglNSMovKDk1TRrfkOIQYd5bkd864L9YpD8s2JDpG0jaoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

The i.MX91 is derived from i.MX93, but there is no DSI and PXP in i.MX91,
so skip these mask.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v7:
1. Optimize i.MX91 num_clks hardcode with ARRAY_SIZE().

Changes for v5:
1. The i.MX91 has different PD domain compared to i.MX93,
   so add new imx91 dev_data.
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 1dcb84593e01..e094fe5a42bf 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -86,6 +86,7 @@ struct imx93_blk_ctrl_domain {
 
 struct imx93_blk_ctrl_data {
 	const struct imx93_blk_ctrl_domain_data *domains;
+	u32 skip_mask;
 	int num_domains;
 	const char * const *clk_names;
 	int num_clks;
@@ -250,6 +251,8 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		int j;
 
 		domain->data = data;
+		if (bc_data->skip_mask & BIT(i))
+			continue;
 
 		for (j = 0; j < data->num_clks; j++)
 			domain->clks[j].id = data->clk_names[j];
@@ -422,6 +425,15 @@ static const char * const media_blk_clk_names[] = {
 	"axi", "apb", "nic"
 };
 
+static const struct imx93_blk_ctrl_data imx91_media_blk_ctl_dev_data = {
+	.domains = imx93_media_blk_ctl_domain_data,
+	.skip_mask = BIT(IMX93_MEDIABLK_PD_MIPI_DSI) | BIT(IMX93_MEDIABLK_PD_PXP),
+	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
+	.clk_names = media_blk_clk_names,
+	.num_clks = ARRAY_SIZE(media_blk_clk_names),
+	.reg_access_table = &imx93_media_blk_ctl_access_table,
+};
+
 static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
 	.domains = imx93_media_blk_ctl_domain_data,
 	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
@@ -432,6 +444,9 @@ static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
 
 static const struct of_device_id imx93_blk_ctrl_of_match[] = {
 	{
+		.compatible = "fsl,imx91-media-blk-ctrl",
+		.data = &imx91_media_blk_ctl_dev_data
+	}, {
 		.compatible = "fsl,imx93-media-blk-ctrl",
 		.data = &imx93_media_blk_ctl_dev_data
 	}, {
-- 
2.37.1


