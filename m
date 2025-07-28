Return-Path: <linux-pm+bounces-31458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B5CB1357F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 09:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF4189945F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 07:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89C022F74D;
	Mon, 28 Jul 2025 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZA66EPNK"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28982264AA;
	Mon, 28 Jul 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687018; cv=fail; b=uzttxCKjvHVH9fY3VhOVS8eZtMuhvhoFectICMILeEwCtyu8B4Fryh2cPRopyOYB+HjETDV7jLY6WlWl6cmETVOoaNgX29Kon+xpXuoMUJ0h09X7Zlmu93OflLXeq63uorK113KAxPiUty+kzoaUFpfRfXJ5N2+oKBvSyY/zIq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687018; c=relaxed/simple;
	bh=cTuqm00c0NfI17jEEftxMAd1GkauYFWnSm84LoJByYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QioA8Hpjx0BCdHJsWXj91ALMHRuo0ZOcPCLp02Tuxwm04C2u/S9uHWT0GTDBJnV0fMVO7n7x2dsgfTnF7Z74rDhC6b+mh7gWu0GGfbzrGsj9qTqPLzjV5ZV1+mNLyoaX8GYnEoPa6PrUFVOUN4+I53E047Cl2m4VwAKsT2uxW1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZA66EPNK; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRfb8KlL8wmRsm6gJma7a+qZb8zZYP2TXt1U/L5UU5n0THs+1ZeHQc0+1K0j4mTqeScvldcGW2yoJp3zCF/U3Vu1AoErzfsflWoG9iSWawVUiOIFl6Iaz13N4PQAW/rWxu6QmGmETOju4Vfatod38YVWNE8ATkP4weyvBVMP43uYiu8g5IsjRHgwafn8cl3Z9jVuPFxxRImO16nvaNnIuXtstrhTIkVWlBIvCcKO6jJ8zYFg2HT7E5ZxN+JG8FZm08MYkEOhyNEeAFJ9f1NQSogrJuF0+9kGrOC/uSis9UaNChUKW/NZVJK2Zq8v3OlNQm/46ULUOn2WRFxLHgfk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp5d/f+RClbIV+D+0M8NOks7XYRbCdKvvDn7TLgPbQ8=;
 b=dpmPCAsJYQx9z+vl8OJrWS/tI97yVO65v0MUZ+dcTvGQGuU7HrMtavre6P/HmbEnmNB8ktqVjeMvEx145TQ2XfQrHzUreZpdLwCtj7iiVZwTS/pvMsOi5vMIRt4kQwZEVNkUYqQUIEfnWTo6gHePOtytRGkPjULaILMT2jwHFIob24wzvtwANDLRs7o7pkDqai8ryIocA969zsgk3SaXdrhgcjREhsOzQ6qpxkEm3nQct5pK6WGQ6TdWzViwYCCRZcRd/zCAyDpBGJlNcmsl+TXKMUG76crsVBbjsc/l/jBeZ868G/+VCv+RPP9/ow+4Y4Sib2/H/bFNn1McWVwEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp5d/f+RClbIV+D+0M8NOks7XYRbCdKvvDn7TLgPbQ8=;
 b=ZA66EPNKOn+oXi5HdV8oUz9CwE0Yb7LeGbuwh1gXtqOioC+ckkrt9xVDdUqrlTmYRuXFmT8mz6RdU6bYONIkQHuvJmS4tk55O8J2lCAVxrVbBk1R6wqDNqXL6xRYyC8VM7hn8aZo9U2499ayzCA62itAzmjWq68Of5Q0EBzFbhJPrGJ0Jc5WN7CSEkUgGVP0MElZzMvVn23ZyRfgz3FnEJatzGFVuCmYIVK6i7ZIz7JpfzYj9Tgu/njJfMIpffpZ1nlTNLMI0C/JApK+xhcDi9RiCD4uXCG1ywAVc/mZvrq+aITkrPda4sG/VM0HLuUfd/kKo9V3D65UIIfWL372VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by MRWPR04MB11489.eurprd04.prod.outlook.com (2603:10a6:501:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:16:51 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:16:51 +0000
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
Subject: [PATCH v7 04/11] arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi and modify them
Date: Mon, 28 Jul 2025 15:14:31 +0800
Message-Id: <20250728071438.2332382-5-joy.zou@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|MRWPR04MB11489:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5df621-b52c-4379-16d2-08ddcda6b88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?abE0/1rWhD56N4VMqxkRuOHQBcGIjWQgWSBexTvUxEtbcgq9UHNG4ViBfXiN?=
 =?us-ascii?Q?EgY+LJB2MD5JpzxX7oczbbsl04otvhTByFYwZvRgtXCLIjk1QAp8aqgeKo4q?=
 =?us-ascii?Q?hSz1669DI/vT0kcw99xde9Ugc/+jYRuCiRoLAVqdOumkTUES50iQpUISrA3T?=
 =?us-ascii?Q?M/DztaOkyx1B6ONo+lXitiAUyB6g6BbNnuNGbZoZQW+NittFWAyCIj6Ou01K?=
 =?us-ascii?Q?rADkbi/m/aQnHRh+znERduvevtDQgrHPHAkZlZ+tQyCDkI46vz6I/cmEYZoS?=
 =?us-ascii?Q?ihNFC1qqTcG6C7DrZcwdIj/s/9x3OtIKqN4Nj63Nliz16ydVpA1raEixALCF?=
 =?us-ascii?Q?fL035clvorLcmcFWlbk13KuWTdcnbrdafCdfrk2GL8L+s8YB1gd3/x0sfxj4?=
 =?us-ascii?Q?dH9mKfmWv3YwyNBr/WN5M3XUhSKsMLfylndrnyAe9b0bGPosnp/x9+ILLmQe?=
 =?us-ascii?Q?TraqomLOoYIunNMgMyWZkvb0fKooOmr9VfhxbKl1gFBx2pKB2FLSD4aasvka?=
 =?us-ascii?Q?ighOPrVTmehS7lVqqHQGU4/B1bpHkqi9/P41zdQwiGN1foAmrKY6hooyg3O0?=
 =?us-ascii?Q?805rYcSdTnVVLoHS4Wqswm4PL3HZIX6Y/PtxzBtVnTFgdQfTRJjdf14QCMkN?=
 =?us-ascii?Q?wmgtYSmvxrxiyH9HmcyEVA/IcbTSiEEc7jnOLGCRUD3ecV4Awqeqd9pLpvZG?=
 =?us-ascii?Q?doXcPzF8yzOvoMxF5xYHFXLVKaRkuGJX06hP4mWLYEmGZEktwgLVKZ4Knttq?=
 =?us-ascii?Q?ZGdzniQK/4/KUXn8hLw27VDHf00MqzLJ7/ZsyjS3p8wZgchMzFv4UhZ1T/k4?=
 =?us-ascii?Q?9z8iTxbfWCOB7DPWKLxaOxdGtCcz1ftyhiwm2l4IEOV4a+xvhqNyj/vfUmRc?=
 =?us-ascii?Q?HJAMc0CaWljIaDpQjiNijcEDZTUGQeqNqlnexzVXztPYNAjdNL1bMqAc0xEA?=
 =?us-ascii?Q?y1MFNtZieQzpSBkTR/Pf1N61F0fxKIbS4JCUuXLSegNsyFC5o/b9a+NKYYQ0?=
 =?us-ascii?Q?R2IbsaAV0E/w4+ZS/yX8uuDv+rxcbaE1YxfsEYzz81ToxMT+w7nb7Bq86PuW?=
 =?us-ascii?Q?+iwCAVtvmeKRhK3K9ywA8/U7NSI6avhEivO+BlGa54bEe8vi4QIClMhDOj8i?=
 =?us-ascii?Q?+hlRRUrf0awP8hUX/emdcl//dUeN+TBUfNhnJFn5vvmyOA9bmGdEdflVrbw4?=
 =?us-ascii?Q?Ixg3B0CcI46G9nvPMPPSrcCAQ1Rk6kXaQRqhbac9HCMi8AxKD9AYF4FxrX1r?=
 =?us-ascii?Q?VOUTs0WZBMegSINtMphZgxQ5rByE6RMzU7XFJlV/J3SWgmnNBG7GySMlXt1E?=
 =?us-ascii?Q?Zwz5LptASMgS/uvAYEvmfpq9GlW5P8/BvKhbO5vXtWXFKbcDbFIE/lwDPqOS?=
 =?us-ascii?Q?IP+/5aZXfVCeulKwiNX9DgU0Nkzygf+nK/LEemBrCq3UrjpUBImbhXaHcTMw?=
 =?us-ascii?Q?h2h6GFJaJOVvsaZADpC4z7JvW69gZOLuiFhlpzzOqjTH2+J2YsR05vAk2tHe?=
 =?us-ascii?Q?9b/HUmoqi47klyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5zQE2Pv6cw6KLzX09WD32aaeKKGCHlEyJeNTYRF8K6ygq3upZH8T12TCtoy+?=
 =?us-ascii?Q?KMXNjeckd9ol0P11eaQnwRDgyb5B8P9oslE91xkjQEPtZKb6soXbfqTy+sPf?=
 =?us-ascii?Q?uhk1lxvFYc/4pYVtcj0v5gFPRE740yMrr0mmrQu1FOPd4ETlMvp/kcqZU3gJ?=
 =?us-ascii?Q?NdZ0qFSbPPUXF4xqgxUpIxMsZcp5nE4A3Oy+msiwNikxr6c7Ec9sRzvNIuKo?=
 =?us-ascii?Q?ITlf1soVPH7Zn2pr5ZSjyy1oSHp+UXGeJcqDwGvsqwOFPaO6hcLftIG9JxR0?=
 =?us-ascii?Q?bc1TnSyV+pSQXSfKtuSqMaDSmW+vX6GXrW7H4A5dcRUr/aTecQy/hsqCguCM?=
 =?us-ascii?Q?PS1M2AkB8PdSEpVYOWudDIOt/yGrSrzrkJyf799wR8GtxSi6SFp044KT8YII?=
 =?us-ascii?Q?GFB1H4nLsAQ7b67+qsBWTckShyu/nkg05FUb/AyuOxFuh6JadBgN+CC2TTP2?=
 =?us-ascii?Q?MzP45aDTNQOR71voXKTqZ2nW/qd7z6OJ9GxT0Uzvx3XGz6c57A6bZbO0XZu9?=
 =?us-ascii?Q?7isssJg+0HDR6YKXr7t5qL3LMIinhz+HiiIfge9/Thgpd3qoVALDYFV3YCBD?=
 =?us-ascii?Q?lDf5haVGA0Y/UNQfnqjfr80bI6mlTI2rDXFy7D3PRrST30PJ8hmwjX1dsbYx?=
 =?us-ascii?Q?/qRvPjr2hnnPTZt+5Tk1SkDBku4QDGloNmzoVZhW2AaRuBrHb0SwCU3BabOg?=
 =?us-ascii?Q?ifrNPNH1eLRmoCaKXbeY7DpTQi8Jl02X4O7RMAZ1XU9Yo9dIBpKtl3/fUqh9?=
 =?us-ascii?Q?u2Y+CQlitHPDp/pKi7Srmy3btCP0A9G847Hl6X55qFMUOjjnqY77IHSIn8m9?=
 =?us-ascii?Q?V5zttoZXzlyZm9cBpXjYuDvYK7wPcbUMh/vDEkYBcJAOqObrY6jESwoaUjgr?=
 =?us-ascii?Q?WLMLsQlP059NSVgV5BfmC5h6xtPxV9rcz+pUyBg9xLoUF4z4Hu9hkWEX0z9a?=
 =?us-ascii?Q?wN/QrJ72FscTw4Zf4z1cPXqtNwyv3mGNWETszBJYzFgMU9QqGa0ibr90Hx8z?=
 =?us-ascii?Q?lk8hBCeHcoiKtb7EJBVlmjdVcUOOFd/3WZsTNrL3XGOYGKQK8Z+uTwUmXkw6?=
 =?us-ascii?Q?pJnJNlINQjb7pljK7UjwAhzTUTeDnAulq4S547P7+hfABFcnMK/wb7YNS15R?=
 =?us-ascii?Q?nUjupncvAoKA25bqLtB2I+mWFB9H4ak0J/mb39Td9SQcl1vTK496aCSjMUAL?=
 =?us-ascii?Q?bHBAx7EdWMr9AmnssoYqPSSu+66eOHMwpKEGmwRK7TIzbdIYGiv9OZ02Jl1A?=
 =?us-ascii?Q?RwgRC46lxPxomy1cS8QeEIm+ifoPjYlZmYZ8DAjojmB47SGM++iOGBfSGT+U?=
 =?us-ascii?Q?YtE7n54J0U1tcNqhUh2O2c+rF7jdwy1qOfvud3VTetimaJGW3L5nZ7IlmdZn?=
 =?us-ascii?Q?FNs634GYyBkF0e/T+EGxJVKx8BzTfWXS/6Bo8FW/UFNH7TpB5/RL7AaWUAGV?=
 =?us-ascii?Q?J1heipevr4mLmW6XyNOgKeacpG5ywnQ46AXi7FwnKcg1+MrNUbVkzToTtqHR?=
 =?us-ascii?Q?Y/zF6l7/gXRaLM/BLvQMgevVkCRh9Pw9wXvbajnrPZ5YIyQuqqdHURPN8vqr?=
 =?us-ascii?Q?f9w2/3JY5e93hUMTpn2t3EmBvYBiE8797mnxe2GK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5df621-b52c-4379-16d2-08ddcda6b88a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:16:51.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJjOfCxXUpd9Q6Lq9i0GrG+mv40dJ2jYVECbVUrVzRayQPiaAX2zZ1KYXj/Bvi7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11489

The design of i.MX91 platform is very similar to i.MX93 and only
some small differences.

If the imx91.dtsi include the imx93.dtsi, each add to imx93.dtsi
requires an remove in imx91.dtsi for this unique to i.MX93, e.g. NPU.
The i.MX91 isn't the i.MX93 subset, if the imx93.dtsi include the
imx91.dtsi, the same problem will occur.

Common + delta is better than common - delta, so add imx91_93_common.dtsi
for i.MX91 and i.MX93, then the imx93.dtsi and imx91.dtsi will include the
imx91_93_common.dtsi.

Rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93 specific
part from imx91_93_common.dtsi to imx93.dtsi.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v7:
1.The aliases are removed from common.dtsi because the imx93.dtsi aliases
  are removed.

Changes for v6:
1. merge rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93
   specific part from imx91_93_common.dtsi to imx93.dtsi patch.
2. restore copyright time and add modification time.
3. remove unused map0 label in imx91_93_common.dtsi.
---
 .../{imx93.dtsi => imx91_93_common.dtsi}      |  140 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 1478 ++---------------
 2 files changed, 163 insertions(+), 1455 deletions(-)
 copy arch/arm64/boot/dts/freescale/{imx93.dtsi => imx91_93_common.dtsi} (91%)
 rewrite arch/arm64/boot/dts/freescale/imx93.dtsi (97%)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
similarity index 91%
copy from arch/arm64/boot/dts/freescale/imx93.dtsi
copy to arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
index 97ba4bf9bc7d..8f3c8c15642a 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2022 NXP
+ * Copyright 2022,2025 NXP
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
@@ -18,7 +18,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -43,58 +43,6 @@ A55_0: cpu@0 {
 			enable-method = "psci";
 			#cooling-cells = <2>;
 			cpu-idle-states = <&cpu_pd_wait>;
-			i-cache-size = <32768>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <128>;
-			d-cache-size = <32768>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&l2_cache_l0>;
-		};
-
-		A55_1: cpu@100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x100>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-			cpu-idle-states = <&cpu_pd_wait>;
-			i-cache-size = <32768>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <128>;
-			d-cache-size = <32768>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&l2_cache_l1>;
-		};
-
-		l2_cache_l0: l2-cache-l0 {
-			compatible = "cache";
-			cache-size = <65536>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <2>;
-			cache-unified;
-			next-level-cache = <&l3_cache>;
-		};
-
-		l2_cache_l1: l2-cache-l1 {
-			compatible = "cache";
-			cache-size = <65536>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <2>;
-			cache-unified;
-			next-level-cache = <&l3_cache>;
-		};
-
-		l3_cache: l3-cache {
-			compatible = "cache";
-			cache-size = <262144>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <3>;
-			cache-unified;
 		};
 	};
 
@@ -150,44 +98,6 @@ gic: interrupt-controller@48000000 {
 		interrupt-parent = <&gic>;
 	};
 
-	thermal-zones {
-		cpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <2000>;
-
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <80000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
-
-	cm33: remoteproc-cm33 {
-		compatible = "fsl,imx93-cm33";
-		clocks = <&clk IMX93_CLK_CM33_GATE>;
-		status = "disabled";
-	};
-
 	mqs1: mqs1 {
 		compatible = "fsl,imx93-mqs";
 		gpr = <&aonmix_ns_gpr>;
@@ -273,15 +183,6 @@ aonmix_ns_gpr: syscon@44210000 {
 				reg = <0x44210000 0x1000>;
 			};
 
-			mu1: mailbox@44230000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x44230000 0x10000>;
-				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU1_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
 			system_counter: timer@44290000 {
 				compatible = "nxp,sysctr-timer";
 				reg = <0x44290000 0x30000>;
@@ -485,14 +386,6 @@ src: system-controller@44460000 {
 				#size-cells = <1>;
 				ranges;
 
-				mlmix: power-domain@44461800 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44461800 0x400>, <0x44464800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_ML_APB>,
-						 <&clk IMX93_CLK_ML>;
-				};
-
 				mediamix: power-domain@44462400 {
 					compatible = "fsl,imx93-src-slice";
 					reg = <0x44462400 0x400>, <0x44465800 0x400>;
@@ -508,26 +401,6 @@ clock-controller@44480000 {
 				#clock-cells = <1>;
 			};
 
-			tmu: tmu@44482000 {
-				compatible = "fsl,qoriq-tmu";
-				reg = <0x44482000 0x1000>;
-				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_TMC_GATE>;
-				little-endian;
-				fsl,tmu-range = <0x800000da 0x800000e9
-						 0x80000102 0x8000012a
-						 0x80000166 0x800001a7
-						 0x800001b6>;
-				fsl,tmu-calibration = <0x00000000 0x0000000e
-						       0x00000001 0x00000029
-						       0x00000002 0x00000056
-						       0x00000003 0x000000a2
-						       0x00000004 0x00000116
-						       0x00000005 0x00000195
-						       0x00000006 0x000001b2>;
-				#thermal-sensor-cells = <1>;
-			};
-
 			micfil: micfil@44520000 {
 				compatible = "fsl,imx93-micfil";
 				reg = <0x44520000 0x10000>;
@@ -643,15 +516,6 @@ wakeupmix_gpr: syscon@42420000 {
 				reg = <0x42420000 0x1000>;
 			};
 
-			mu2: mailbox@42440000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x42440000 0x10000>;
-				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU2_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
 			wdog3: watchdog@42490000 {
 				compatible = "fsl,imx93-wdt";
 				reg = <0x42490000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
dissimilarity index 97%
index 97ba4bf9bc7d..7b27012dfcb5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1,1317 +1,161 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 NXP
- */
-
-#include <dt-bindings/clock/imx93-clock.h>
-#include <dt-bindings/dma/fsl-edma.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/power/fsl,imx93-power.h>
-#include <dt-bindings/thermal/thermal.h>
-
-#include "imx93-pinfunc.h"
-
-/ {
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		idle-states {
-			entry-method = "psci";
-
-			cpu_pd_wait: cpu-pd-wait {
-				compatible = "arm,idle-state";
-				arm,psci-suspend-param = <0x0010033>;
-				local-timer-stop;
-				entry-latency-us = <10000>;
-				exit-latency-us = <7000>;
-				min-residency-us = <27000>;
-				wakeup-latency-us = <15000>;
-			};
-		};
-
-		A55_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x0>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-			cpu-idle-states = <&cpu_pd_wait>;
-			i-cache-size = <32768>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <128>;
-			d-cache-size = <32768>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&l2_cache_l0>;
-		};
-
-		A55_1: cpu@100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x100>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-			cpu-idle-states = <&cpu_pd_wait>;
-			i-cache-size = <32768>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <128>;
-			d-cache-size = <32768>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&l2_cache_l1>;
-		};
-
-		l2_cache_l0: l2-cache-l0 {
-			compatible = "cache";
-			cache-size = <65536>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <2>;
-			cache-unified;
-			next-level-cache = <&l3_cache>;
-		};
-
-		l2_cache_l1: l2-cache-l1 {
-			compatible = "cache";
-			cache-size = <65536>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <2>;
-			cache-unified;
-			next-level-cache = <&l3_cache>;
-		};
-
-		l3_cache: l3-cache {
-			compatible = "cache";
-			cache-size = <262144>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <3>;
-			cache-unified;
-		};
-	};
-
-	osc_32k: clock-osc-32k {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "osc_32k";
-	};
-
-	osc_24m: clock-osc-24m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24000000>;
-		clock-output-names = "osc_24m";
-	};
-
-	clk_ext1: clock-ext1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <133000000>;
-		clock-output-names = "clk_ext1";
-	};
-
-	pmu {
-		compatible = "arm,cortex-a55-pmu";
-		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
-		clock-frequency = <24000000>;
-		arm,no-tick-in-suspend;
-		interrupt-parent = <&gic>;
-	};
-
-	gic: interrupt-controller@48000000 {
-		compatible = "arm,gic-v3";
-		reg = <0 0x48000000 0 0x10000>,
-		      <0 0x48040000 0 0xc0000>;
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gic>;
-	};
-
-	thermal-zones {
-		cpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <2000>;
-
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <80000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
-
-	cm33: remoteproc-cm33 {
-		compatible = "fsl,imx93-cm33";
-		clocks = <&clk IMX93_CLK_CM33_GATE>;
-		status = "disabled";
-	};
-
-	mqs1: mqs1 {
-		compatible = "fsl,imx93-mqs";
-		gpr = <&aonmix_ns_gpr>;
-		status = "disabled";
-	};
-
-	mqs2: mqs2 {
-		compatible = "fsl,imx93-mqs";
-		gpr = <&wakeupmix_gpr>;
-		status = "disabled";
-	};
-
-	usbphynop1: usbphynop1 {
-		compatible = "usb-nop-xceiv";
-		#phy-cells = <0>;
-		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
-		clock-names = "main_clk";
-	};
-
-	usbphynop2: usbphynop2 {
-		compatible = "usb-nop-xceiv";
-		#phy-cells = <0>;
-		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
-		clock-names = "main_clk";
-	};
-
-	soc@0 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x80000000>,
-			 <0x28000000 0x0 0x28000000 0x10000000>;
-
-		aips1: bus@44000000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x44000000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			edma1: dma-controller@44000000 {
-				compatible = "fsl,imx93-edma3";
-				reg = <0x44000000 0x200000>;
-				#dma-cells = <3>;
-				dma-channels = <31>;
-				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,  //  0: Reserved
-					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  //  1: CANFD1
-					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,  //  2: Reserved
-					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,  //  3: GPIO1 CH0
-					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,  //  4: GPIO1 CH1
-					     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>, //  5: I3C1 TO Bus
-					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>, //  6: I3C1 From Bus
-					     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, //  7: LPI2C1 M TX
-					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, //  8: LPI2C1 S TX
-					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>, //  9: LPI2C2 M RX
-					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>, // 10: LPI2C2 S RX
-					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>, // 11: LPSPI1 TX
-					     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>, // 12: LPSPI1 RX
-					     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, // 13: LPSPI2 TX
-					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>, // 14: LPSPI2 RX
-					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>, // 15: LPTMR1
-					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>, // 16: LPUART1 TX
-					     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>, // 17: LPUART1 RX
-					     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, // 18: LPUART2 TX
-					     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>, // 19: LPUART2 RX
-					     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>, // 20: S400
-					     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>, // 21: SAI TX
-					     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>, // 22: SAI RX
-					     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, // 23: TPM1 CH0/CH2
-					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>, // 24: TPM1 CH1/CH3
-					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>, // 25: TPM1 Overflow
-					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>, // 26: TMP2 CH0/CH2
-					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>, // 27: TMP2 CH1/CH3
-					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, // 28: TMP2 Overflow
-					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>, // 29: PDM
-					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>; // 30: ADC1
-				clocks = <&clk IMX93_CLK_EDMA1_GATE>;
-				clock-names = "dma";
-			};
-
-			aonmix_ns_gpr: syscon@44210000 {
-				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
-				reg = <0x44210000 0x1000>;
-			};
-
-			mu1: mailbox@44230000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x44230000 0x10000>;
-				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU1_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			system_counter: timer@44290000 {
-				compatible = "nxp,sysctr-timer";
-				reg = <0x44290000 0x30000>;
-				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&osc_24m>;
-				clock-names = "per";
-				nxp,no-divider;
-			};
-
-			wdog1: watchdog@442d0000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x442d0000 0x10000>;
-				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG1_GATE>;
-				timeout-sec = <40>;
-				status = "disabled";
-			};
-
-			wdog2: watchdog@442e0000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x442e0000 0x10000>;
-				interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG2_GATE>;
-				timeout-sec = <40>;
-				status = "disabled";
-			};
-
-			tpm1: pwm@44310000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x44310000 0x1000>;
-				clocks = <&clk IMX93_CLK_TPM1_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm2: pwm@44320000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x44320000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM2_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			i3c1: i3c@44330000 {
-				compatible = "silvaco,i3c-master-v1";
-				reg = <0x44330000 0x10000>;
-				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <3>;
-				#size-cells = <0>;
-				clocks = <&clk IMX93_CLK_BUS_AON>,
-					 <&clk IMX93_CLK_I3C1_GATE>,
-					 <&clk IMX93_CLK_I3C1_SLOW>;
-				clock-names = "pclk", "fast_clk", "slow_clk";
-				status = "disabled";
-			};
-
-			lpi2c1: i2c@44340000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x44340000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				dmas = <&edma1 7 0 0>, <&edma1 8 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpi2c2: i2c@44350000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x44350000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C2_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				dmas = <&edma1 9 0 0>, <&edma1 10 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi1: spi@44360000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x44360000 0x10000>;
-				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI1_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				dmas = <&edma1 11 0 0>, <&edma1 12 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi2: spi@44370000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x44370000 0x10000>;
-				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI2_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				dmas = <&edma1 13 0 0>, <&edma1 14 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpuart1: serial@44380000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x44380000 0x1000>;
-				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma1 17 0 FSL_EDMA_RX>, <&edma1 16 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpuart2: serial@44390000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x44390000 0x1000>;
-				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma1 19 0 FSL_EDMA_RX>, <&edma1 18 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			flexcan1: can@443a0000 {
-				compatible = "fsl,imx93-flexcan";
-				reg = <0x443a0000 0x10000>;
-				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_AON>,
-					 <&clk IMX93_CLK_CAN1_GATE>;
-				clock-names = "ipg", "per";
-				assigned-clocks = <&clk IMX93_CLK_CAN1>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <40000000>;
-				fsl,clk-source = /bits/ 8 <0>;
-				fsl,stop-mode = <&aonmix_ns_gpr 0x14 0>;
-				status = "disabled";
-			};
-
-			sai1: sai@443b0000 {
-				compatible = "fsl,imx93-sai";
-				reg = <0x443b0000 0x10000>;
-				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_SAI1_IPG>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_SAI1_GATE>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>;
-				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
-				dmas = <&edma1 22 0 FSL_EDMA_RX>, <&edma1 21 0 0>;
-				dma-names = "rx", "tx";
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
-
-			iomuxc: pinctrl@443c0000 {
-				compatible = "fsl,imx93-iomuxc";
-				reg = <0x443c0000 0x10000>;
-				status = "okay";
-			};
-
-			bbnsm: bbnsm@44440000 {
-				compatible = "nxp,imx93-bbnsm", "syscon", "simple-mfd";
-				reg = <0x44440000 0x10000>;
-
-				bbnsm_rtc: rtc {
-					compatible = "nxp,imx93-bbnsm-rtc";
-					interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-				};
-
-				bbnsm_pwrkey: pwrkey {
-					compatible = "nxp,imx93-bbnsm-pwrkey";
-					interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-					linux,code = <KEY_POWER>;
-				};
-			};
-
-			clk: clock-controller@44450000 {
-				compatible = "fsl,imx93-ccm";
-				reg = <0x44450000 0x10000>;
-				#clock-cells = <1>;
-				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>;
-				clock-names = "osc_32k", "osc_24m", "clk_ext1";
-				assigned-clocks = <&clk IMX93_CLK_AUDIO_PLL>;
-				assigned-clock-rates = <393216000>;
-				status = "okay";
-			};
-
-			src: system-controller@44460000 {
-				compatible = "fsl,imx93-src", "syscon";
-				reg = <0x44460000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges;
-
-				mlmix: power-domain@44461800 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44461800 0x400>, <0x44464800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_ML_APB>,
-						 <&clk IMX93_CLK_ML>;
-				};
-
-				mediamix: power-domain@44462400 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44462400 0x400>, <0x44465800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_NIC_MEDIA_GATE>,
-						 <&clk IMX93_CLK_MEDIA_APB>;
-				};
-			};
-
-			clock-controller@44480000 {
-				compatible = "fsl,imx93-anatop";
-				reg = <0x44480000 0x2000>;
-				#clock-cells = <1>;
-			};
-
-			tmu: tmu@44482000 {
-				compatible = "fsl,qoriq-tmu";
-				reg = <0x44482000 0x1000>;
-				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_TMC_GATE>;
-				little-endian;
-				fsl,tmu-range = <0x800000da 0x800000e9
-						 0x80000102 0x8000012a
-						 0x80000166 0x800001a7
-						 0x800001b6>;
-				fsl,tmu-calibration = <0x00000000 0x0000000e
-						       0x00000001 0x00000029
-						       0x00000002 0x00000056
-						       0x00000003 0x000000a2
-						       0x00000004 0x00000116
-						       0x00000005 0x00000195
-						       0x00000006 0x000001b2>;
-				#thermal-sensor-cells = <1>;
-			};
-
-			micfil: micfil@44520000 {
-				compatible = "fsl,imx93-micfil";
-				reg = <0x44520000 0x10000>;
-				interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_PDM_IPG>,
-					 <&clk IMX93_CLK_PDM_GATE>,
-					 <&clk IMX93_CLK_AUDIO_PLL>;
-				clock-names = "ipg_clk", "ipg_clk_app", "pll8k";
-				dmas = <&edma1 29 0 5>;
-				dma-names = "rx";
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
-
-			adc1: adc@44530000 {
-				compatible = "nxp,imx93-adc";
-				reg = <0x44530000 0x10000>;
-				interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_ADC1_GATE>;
-				clock-names = "ipg";
-				#io-channel-cells = <1>;
-				status = "disabled";
-			};
-		};
-
-		aips2: bus@42000000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x42000000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			edma2: dma-controller@42000000 {
-				compatible = "fsl,imx93-edma4";
-				reg = <0x42000000 0x210000>;
-				#dma-cells = <3>;
-				dma-channels = <64>;
-				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_EDMA2_GATE>;
-				clock-names = "dma";
-			};
-
-			wakeupmix_gpr: syscon@42420000 {
-				compatible = "fsl,imx93-wakeupmix-syscfg", "syscon";
-				reg = <0x42420000 0x1000>;
-			};
-
-			mu2: mailbox@42440000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x42440000 0x10000>;
-				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU2_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			wdog3: watchdog@42490000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x42490000 0x10000>;
-				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG3_GATE>;
-				timeout-sec = <40>;
-				status = "disabled";
-			};
-
-			wdog4: watchdog@424a0000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x424a0000 0x10000>;
-				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG4_GATE>;
-				timeout-sec = <40>;
-				status = "disabled";
-			};
-
-			wdog5: watchdog@424b0000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x424b0000 0x10000>;
-				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG5_GATE>;
-				timeout-sec = <40>;
-				status = "disabled";
-			};
-
-			tpm3: pwm@424e0000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x424e0000 0x1000>;
-				clocks = <&clk IMX93_CLK_TPM3_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm4: pwm@424f0000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x424f0000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM4_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm5: pwm@42500000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x42500000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM5_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm6: pwm@42510000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x42510000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM6_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			i3c2: i3c@42520000 {
-				compatible = "silvaco,i3c-master-v1";
-				reg = <0x42520000 0x10000>;
-				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <3>;
-				#size-cells = <0>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_I3C2_GATE>,
-					 <&clk IMX93_CLK_I3C2_SLOW>;
-				clock-names = "pclk", "fast_clk", "slow_clk";
-				status = "disabled";
-			};
-
-			lpi2c3: i2c@42530000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x42530000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C3_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 8 0 0>, <&edma2 9 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpi2c4: i2c@42540000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x42540000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C4_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 10 0 0>, <&edma2 11 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi3: spi@42550000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42550000 0x10000>;
-				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI3_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 12 0 0>, <&edma2 13 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi4: spi@42560000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42560000 0x10000>;
-				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI4_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 14 0 0>, <&edma2 15 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpuart3: serial@42570000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42570000 0x1000>;
-				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 18 0 FSL_EDMA_RX>, <&edma2 17 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpuart4: serial@42580000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42580000 0x1000>;
-				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 20 0 FSL_EDMA_RX>, <&edma2 19 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpuart5: serial@42590000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42590000 0x1000>;
-				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 22 0 FSL_EDMA_RX>, <&edma2 21 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpuart6: serial@425a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x425a0000 0x1000>;
-				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 24 0 FSL_EDMA_RX>, <&edma2 23 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			flexcan2: can@425b0000 {
-				compatible = "fsl,imx93-flexcan";
-				reg = <0x425b0000 0x10000>;
-				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_CAN2_GATE>;
-				clock-names = "ipg", "per";
-				assigned-clocks = <&clk IMX93_CLK_CAN2>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <40000000>;
-				fsl,clk-source = /bits/ 8 <0>;
-				fsl,stop-mode = <&wakeupmix_gpr 0x0c 2>;
-				status = "disabled";
-			};
-
-			flexspi1: spi@425e0000 {
-				compatible = "nxp,imx8mm-fspi";
-				reg = <0x425e0000 0x10000>, <0x28000000 0x10000000>;
-				reg-names = "fspi_base", "fspi_mmap";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_FLEXSPI1_GATE>,
-					 <&clk IMX93_CLK_FLEXSPI1_GATE>;
-				clock-names = "fspi_en", "fspi";
-				assigned-clocks = <&clk IMX93_CLK_FLEXSPI1>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
-				status = "disabled";
-			};
-
-			sai2: sai@42650000 {
-				compatible = "fsl,imx93-sai";
-				reg = <0x42650000 0x10000>;
-				interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_SAI2_IPG>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_SAI2_GATE>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>;
-				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
-				dmas = <&edma2 59 0 FSL_EDMA_RX>, <&edma2 58 0 0>;
-				dma-names = "rx", "tx";
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
-
-			sai3: sai@42660000 {
-				compatible = "fsl,imx93-sai";
-				reg = <0x42660000 0x10000>;
-				interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_SAI3_IPG>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_SAI3_GATE>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>;
-				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
-				dmas = <&edma2 61 0 FSL_EDMA_RX>, <&edma2 60 0 0>;
-				dma-names = "rx", "tx";
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
-
-			xcvr: xcvr@42680000 {
-				compatible = "fsl,imx93-xcvr";
-				reg = <0x42680000 0x800>,
-				      <0x42680800 0x400>,
-				      <0x42680c00 0x080>,
-				      <0x42680e00 0x080>;
-				reg-names = "ram", "regs", "rxfifo", "txfifo";
-				interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_SPDIF_IPG>,
-					 <&clk IMX93_CLK_SPDIF_GATE>,
-					 <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
-				clock-names = "ipg", "phy", "spba", "pll_ipg";
-				dmas = <&edma2 65 0 FSL_EDMA_RX>, <&edma2 66 0 0>;
-				dma-names = "rx", "tx";
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
-
-			lpuart7: serial@42690000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42690000 0x1000>;
-				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpuart8: serial@426a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x426a0000 0x1000>;
-				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpi2c5: i2c@426b0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426b0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C5_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 71 0 0>, <&edma2 72 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpi2c6: i2c@426c0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426c0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C6_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 73 0 0>, <&edma2 74 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpi2c7: i2c@426d0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426d0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C7_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 75 0 0>, <&edma2 76 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpi2c8: i2c@426e0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426e0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 77 0 0>, <&edma2 78 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi5: spi@426f0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x426f0000 0x10000>;
-				interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI5_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 79 0 0>, <&edma2 80 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi6: spi@42700000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42700000 0x10000>;
-				interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI6_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 81 0 0>, <&edma2 82 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi7: spi@42710000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42710000 0x10000>;
-				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI7_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 83 0 0>, <&edma2 84 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi8: spi@42720000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42720000 0x10000>;
-				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI8_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 85 0 0>, <&edma2 86 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-		};
-
-		aips3: bus@42800000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x42800000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			usdhc1: mmc@42850000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x42850000 0x10000>;
-				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC1_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX93_CLK_USDHC1>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
-				assigned-clock-rates = <400000000>;
-				bus-width = <8>;
-				fsl,tuning-start-tap = <1>;
-				fsl,tuning-step = <2>;
-				status = "disabled";
-			};
-
-			usdhc2: mmc@42860000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x42860000 0x10000>;
-				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC2_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX93_CLK_USDHC2>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
-				assigned-clock-rates = <400000000>;
-				bus-width = <4>;
-				fsl,tuning-start-tap = <1>;
-				fsl,tuning-step = <2>;
-				status = "disabled";
-			};
-
-			fec: ethernet@42890000 {
-				compatible = "fsl,imx93-fec", "fsl,imx8mq-fec", "fsl,imx6sx-fec";
-				reg = <0x42890000 0x10000>;
-				interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_ENET1_GATE>,
-					 <&clk IMX93_CLK_ENET1_GATE>,
-					 <&clk IMX93_CLK_ENET_TIMER1>,
-					 <&clk IMX93_CLK_ENET_REF>,
-					 <&clk IMX93_CLK_ENET_REF_PHY>;
-				clock-names = "ipg", "ahb", "ptp",
-					      "enet_clk_ref", "enet_out";
-				assigned-clocks = <&clk IMX93_CLK_ENET_TIMER1>,
-						  <&clk IMX93_CLK_ENET_REF>,
-						  <&clk IMX93_CLK_ENET_REF_PHY>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <100000000>, <250000000>, <50000000>;
-				fsl,num-tx-queues = <3>;
-				fsl,num-rx-queues = <3>;
-				fsl,stop-mode = <&wakeupmix_gpr 0x0c 1>;
-				nvmem-cells = <&eth_mac1>;
-				nvmem-cell-names = "mac-address";
-				status = "disabled";
-			};
-
-			eqos: ethernet@428a0000 {
-				compatible = "nxp,imx93-dwmac-eqos", "snps,dwmac-5.10a";
-				reg = <0x428a0000 0x10000>;
-				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "macirq", "eth_wake_irq";
-				clocks = <&clk IMX93_CLK_ENET_QOS_GATE>,
-					 <&clk IMX93_CLK_ENET_QOS_GATE>,
-					 <&clk IMX93_CLK_ENET_TIMER2>,
-					 <&clk IMX93_CLK_ENET>,
-					 <&clk IMX93_CLK_ENET_QOS_GATE>;
-				clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "mem";
-				assigned-clocks = <&clk IMX93_CLK_ENET_TIMER2>,
-						  <&clk IMX93_CLK_ENET>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
-				assigned-clock-rates = <100000000>, <250000000>;
-				intf_mode = <&wakeupmix_gpr 0x28>;
-				snps,clk-csr = <6>;
-				nvmem-cells = <&eth_mac2>;
-				nvmem-cell-names = "mac-address";
-				status = "disabled";
-			};
-
-			usdhc3: mmc@428b0000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x428b0000 0x10000>;
-				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC3_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX93_CLK_USDHC3>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
-				assigned-clock-rates = <400000000>;
-				bus-width = <4>;
-				fsl,tuning-start-tap = <1>;
-				fsl,tuning-step = <2>;
-				status = "disabled";
-			};
-		};
-
-		gpio2: gpio@43810000 {
-			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
-			reg = <0x43810000 0x1000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO2_GATE>,
-				 <&clk IMX93_CLK_GPIO2_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 4 30>;
-		};
-
-		gpio3: gpio@43820000 {
-			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
-			reg = <0x43820000 0x1000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO3_GATE>,
-				 <&clk IMX93_CLK_GPIO3_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 84 8>, <&iomuxc 8 66 18>,
-				      <&iomuxc 26 34 2>, <&iomuxc 28 0 4>;
-		};
-
-		gpio4: gpio@43830000 {
-			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
-			reg = <0x43830000 0x1000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO4_GATE>,
-				 <&clk IMX93_CLK_GPIO4_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 38 28>, <&iomuxc 28 36 2>;
-		};
-
-		gpio1: gpio@47400000 {
-			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
-			reg = <0x47400000 0x1000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO1_GATE>,
-				 <&clk IMX93_CLK_GPIO1_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 92 16>;
-		};
-
-		ocotp: efuse@47510000 {
-			compatible = "fsl,imx93-ocotp", "syscon";
-			reg = <0x47510000 0x10000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			eth_mac1: mac-address@4ec {
-				reg = <0x4ec 0x6>;
-			};
-
-			eth_mac2: mac-address@4f2 {
-				reg = <0x4f2 0x6>;
-			};
-
-		};
-
-		s4muap: mailbox@47520000 {
-			compatible = "fsl,imx93-mu-s4";
-			reg = <0x47520000 0x10000>;
-			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "tx", "rx";
-			#mbox-cells = <2>;
-		};
-
-		media_blk_ctrl: system-controller@4ac10000 {
-			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
-			reg = <0x4ac10000 0x10000>;
-			power-domains = <&mediamix>;
-			clocks = <&clk IMX93_CLK_MEDIA_APB>,
-				 <&clk IMX93_CLK_MEDIA_AXI>,
-				 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
-				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
-				 <&clk IMX93_CLK_CAM_PIX>,
-				 <&clk IMX93_CLK_PXP_GATE>,
-				 <&clk IMX93_CLK_LCDIF_GATE>,
-				 <&clk IMX93_CLK_ISI_GATE>,
-				 <&clk IMX93_CLK_MIPI_CSI_GATE>,
-				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
-			clock-names = "apb", "axi", "nic", "disp", "cam",
-				      "pxp", "lcdif", "isi", "csi", "dsi";
-			#power-domain-cells = <1>;
-			status = "disabled";
-		};
-
-		usbotg1: usb@4c100000 {
-			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
-			reg = <0x4c100000 0x200>;
-			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
-				 <&clk IMX93_CLK_HSIO_32K_GATE>;
-			clock-names = "usb_ctrl_root", "usb_wakeup";
-			assigned-clocks = <&clk IMX93_CLK_HSIO>;
-			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-			assigned-clock-rates = <133000000>;
-			phys = <&usbphynop1>;
-			fsl,usbmisc = <&usbmisc1 0>;
-			status = "disabled";
-		};
-
-		usbmisc1: usbmisc@4c100200 {
-			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
-				     "fsl,imx6q-usbmisc";
-			reg = <0x4c100200 0x200>;
-			#index-cells = <1>;
-		};
-
-		usbotg2: usb@4c200000 {
-			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
-			reg = <0x4c200000 0x200>;
-			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
-				 <&clk IMX93_CLK_HSIO_32K_GATE>;
-			clock-names = "usb_ctrl_root", "usb_wakeup";
-			assigned-clocks = <&clk IMX93_CLK_HSIO>;
-			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-			assigned-clock-rates = <133000000>;
-			phys = <&usbphynop2>;
-			fsl,usbmisc = <&usbmisc2 0>;
-			status = "disabled";
-		};
-
-		usbmisc2: usbmisc@4c200200 {
-			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
-				     "fsl,imx6q-usbmisc";
-			reg = <0x4c200200 0x200>;
-			#index-cells = <1>;
-		};
-
-		memory-controller@4e300000 {
-			compatible = "nxp,imx9-memory-controller";
-			reg = <0x4e300000 0x800>, <0x4e301000 0x1000>;
-			reg-names = "ctrl", "inject";
-			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-			little-endian;
-		};
-
-		ddr-pmu@4e300dc0 {
-			compatible = "fsl,imx93-ddr-pmu";
-			reg = <0x4e300dc0 0x200>;
-			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-};
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022,2025 NXP
+ */
+
+#include "imx91_93_common.dtsi"
+
+/{
+	cm33: remoteproc-cm33 {
+		compatible = "fsl,imx93-cm33";
+		clocks = <&clk IMX93_CLK_CM33_GATE>;
+		status = "disabled";
+	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+
+			thermal-sensors = <&tmu 0>;
+
+			trips {
+				cpu_alert: cpu-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu-crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+};
+
+&aips1 {
+	mu1: mailbox@44230000 {
+		compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
+		reg = <0x44230000 0x10000>;
+		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_MU1_B_GATE>;
+		#mbox-cells = <2>;
+		status = "disabled";
+	};
+
+	tmu: tmu@44482000 {
+		compatible = "fsl,qoriq-tmu";
+		reg = <0x44482000 0x1000>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_TMC_GATE>;
+		#thermal-sensor-cells = <1>;
+		little-endian;
+		fsl,tmu-range = <0x800000da 0x800000e9
+				 0x80000102 0x8000012a
+				 0x80000166 0x800001a7
+				 0x800001b6>;
+		fsl,tmu-calibration = <0x00000000 0x0000000e
+				       0x00000001 0x00000029
+				       0x00000002 0x00000056
+				       0x00000003 0x000000a2
+				       0x00000004 0x00000116
+				       0x00000005 0x00000195
+				       0x00000006 0x000001b2>;
+	};
+};
+
+&aips2 {
+	mu2: mailbox@42440000 {
+		compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
+		reg = <0x42440000 0x10000>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_MU2_B_GATE>;
+		#mbox-cells = <2>;
+		status = "disabled";
+	};
+};
+
+&cpus {
+	A55_0: cpu@0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a55";
+		reg = <0x0>;
+		enable-method = "psci";
+		#cooling-cells = <2>;
+		cpu-idle-states = <&cpu_pd_wait>;
+		i-cache-size = <32768>;
+		i-cache-line-size = <64>;
+		i-cache-sets = <128>;
+		d-cache-size = <32768>;
+		d-cache-line-size = <64>;
+		d-cache-sets = <128>;
+		next-level-cache = <&l2_cache_l0>;
+	};
+
+	A55_1: cpu@100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a55";
+		reg = <0x100>;
+		enable-method = "psci";
+		#cooling-cells = <2>;
+		cpu-idle-states = <&cpu_pd_wait>;
+		i-cache-size = <32768>;
+		i-cache-line-size = <64>;
+		i-cache-sets = <128>;
+		d-cache-size = <32768>;
+		d-cache-line-size = <64>;
+		d-cache-sets = <128>;
+		next-level-cache = <&l2_cache_l1>;
+	};
+
+	l2_cache_l0: l2-cache-l0 {
+		compatible = "cache";
+		cache-size = <65536>;
+		cache-line-size = <64>;
+		cache-sets = <256>;
+		cache-level = <2>;
+		cache-unified;
+		next-level-cache = <&l3_cache>;
+	};
+
+	l2_cache_l1: l2-cache-l1 {
+		compatible = "cache";
+		cache-size = <65536>;
+		cache-line-size = <64>;
+		cache-sets = <256>;
+		cache-level = <2>;
+		cache-unified;
+		next-level-cache = <&l3_cache>;
+	};
+
+	l3_cache: l3-cache {
+		compatible = "cache";
+		cache-size = <262144>;
+		cache-line-size = <64>;
+		cache-sets = <256>;
+		cache-level = <3>;
+		cache-unified;
+	};
+};
+
+&src {
+	mlmix: power-domain@44461800 {
+		compatible = "fsl,imx93-src-slice";
+		reg = <0x44461800 0x400>, <0x44464800 0x400>;
+		clocks = <&clk IMX93_CLK_ML_APB>,
+			 <&clk IMX93_CLK_ML>;
+		#power-domain-cells = <0>;
+	};
+};
-- 
2.37.1


