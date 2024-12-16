Return-Path: <linux-pm+bounces-19341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8259F39DD
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 20:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22913188B950
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C020E024;
	Mon, 16 Dec 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XSKv23/6"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A520A5C2;
	Mon, 16 Dec 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377141; cv=fail; b=cupHMjGm08h1nHtLmsf6kcyefo4B3uwFFdEQc5C5obf8tQq1da3x7xtbRbRMEu1+l17j6vcAPDgo5XrNSC38P9fp6gPpRfg822WWprPCxu5DV5NvyyoAkl8s/nSiDgyMNwkymTQrGEN7WLTaVL3xd63V0fAWr04lm5cSdmaPsPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377141; c=relaxed/simple;
	bh=kdIPDHEjBHdqCrUWlLBBGL3Vgp5gW4ksfS/sPcojF9s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l/yOTADhVsn5DfxQgiJAreCuloIyKTf0O/CWZu4rRxC0Arrh4HG36O6WQRuz80eOrZbNCCGfmCtys0Y84wmBH6w0PdXGuHHZLpP57e0LLI0HePhGagm0azpgiXBTOh5xfEerFv87gEthE3cjndzhNOHN44nUUUXwp1lK00UeKmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XSKv23/6; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTm/ox+n0TCpYnCkuzceftir3VUAxUkuADvG411WHJP5fhe1IAf4ZClFflY/cxAkxzauqTBE9qMhpPvsMQVvscEiIfhYQ0PR2Fj4LIi7BPnF+R3a5NZeQfNvTXjW9+qyqXoFMjQd+iV6L4cQ5zRfYayVKuR+nza8D00trtChuq9NGHmSX9Rguafnso4LbCpouzGoe0EtYSSP/+DBUh+48fJ9cfSBw6N9dUK06tQ/hxpbBx3TyAhFJBt+ZWbsCPdWH8AA1xOcUpC7mltzNgFN6DTnS9HiMlPir0DZ43EYvKpM9x0WPdBvl7qg+CLXjxcwQmvEf2di0PPgM8oYy10TTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKFkLXzsPrMPAJ/AkNZ8x8fL9AgBS0//d+PC9EoobIM=;
 b=q3p2jssLzlLyqrEUUgeQDMDIZO3DMwYJa2nuHxb7zv0FfWW1Erm936IS3gi7ilioEIhle+IWGiWX+DqsHcZ/Mvhw6+JvRz+QLrwS0y0Hl3h12u5zsA3Te9Mnxywg2jMC+fqIY1wW17ysWHg6TkjChCwgAZ9ifmzaNXPplTjqJ5XS7WHf93AJauev8BbTM/6s74KjGVvLLqmAIDqFzEnEjzKjSxrrDQ1XuO0IYoqMZaFpUZad67sm0EOCYfvz216yNXoYTIczPTHgn392xSUL7uwkwSQpYRoeSfsVdx31aNH2Ncpb9pATJTP2IBVQ8+L2JMU9P7kpbE9CUKEcn90ybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKFkLXzsPrMPAJ/AkNZ8x8fL9AgBS0//d+PC9EoobIM=;
 b=XSKv23/6MM/MekLFFN5M8aYSykGyW24CMR+W+RjthrSYJrvS8UoxFqNjCJW6lNO0MErNap2Aa6W334F3oyAj/0kbxCXyEYyjeB7rUaX5BFalo0m3hfpg1TsIBWzjtQi+1hUIgqKDSVQzch9X62WwoTupENWwTw/jYcpNmYbA98Xx3sYP2SBhMdDHK6+KCAbS3E57B330DF7wsrVvhZ85vRQHMBcIS0DeHwNrMRRiqm/rR4tNZdZNDb+GkOzCMcqxugxbzF19XKF4DjCs+wiYsU7qeErMD7cX402ammGkNMYtoNsKDQBbJvliIv3Fvqy48wbO1qpyor5xxzJ9m7tGNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10249.eurprd04.prod.outlook.com (2603:10a6:150:1a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 19:25:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 19:25:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 16 Dec 2024 14:25:15 -0500
Subject: [PATCH v4 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-imx91tmu-v4-2-75caef7481b8@nxp.com>
References: <20241216-imx91tmu-v4-0-75caef7481b8@nxp.com>
In-Reply-To: <20241216-imx91tmu-v4-0-75caef7481b8@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734377121; l=10515;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dTjQUl4h5prrPcKAUb7k5+VuHEpPWFNDFvgoXRWdg9s=;
 b=452e6c2wGvXh+swQBQAEYzet8wrY5KezCJxktvl3JXfktNnfH7QMluvQ3r9olYFPSblRhrsUK
 guD54nrVjHYAbIT2EL/We1HK4v1gg6BjZPBSvfbJUv7NfcgceV0UtS1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10249:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2e8d68-121f-4239-003d-08dd1e076aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzAyR3ZHelJVTEtsS09CdXBtL21ZQzgzVEhCTWxjajJFd3pqTWx0Tm13cjcy?=
 =?utf-8?B?cWdicTFjWFcrd3NkTlVCZitON2doR1Q3TzZjWm9uNDc5QzBUQlFWalMrNFJm?=
 =?utf-8?B?RHRuTkFia3ZicUtvK2FXVTIvM1JCd2x4TWRCbDRHdStHRE9DRHJyTlg1Z1Yx?=
 =?utf-8?B?WCtyaEJyb04xNlZaUFpkeHc3dnlGcUpadm5HeWJsVzMvQnRNdnRhTGpwQVNG?=
 =?utf-8?B?VWFSOWFmZG1ra2gwWFpRRkF3cUlMam4xNUJQTXIyY1JVc2lkc0F4OTJud3VO?=
 =?utf-8?B?Z1FCQ1BNcFdCZmoyV0JBL2lib3NyUkRhNVhtWmpGakRTdWlydVgxMHFaWTd6?=
 =?utf-8?B?a2JYc016eVROSUU3aGJrbDJkTHhvSzV3blpMbUxJaEZFTmVwQjJtQUFJYjRa?=
 =?utf-8?B?WUVBR3dSdDRIK1ZEaU13VkhnTEswMXMzS2pHOG9DbjNKcFVUZzNGZ0xZUjVz?=
 =?utf-8?B?cUIrbk4zSTJITEFQYWNVT0VDT0ZmODJ4M2VIbzZZOFhLS0UxVnFERWdpdUpo?=
 =?utf-8?B?MFBqK1ZtaHFSVDB1Ylc2SUJkS3RPWWtrTjQ1dkVKRW1FRmVVUDA1azZvdS9J?=
 =?utf-8?B?Vzg1TTM2K0RFdFdxcGlMNG9rMlRVN2VxOEZXbjFYQnRUS2trdEFJYk51bEdj?=
 =?utf-8?B?QXU2YmRYSnUyaGlpVmZKQVczODlhdi91Z1NFbUtZeDIzaWloMlFybTNZMzcz?=
 =?utf-8?B?citZQlZ5cFdIdS92L0FCak9McDlaU1MxMU5INkY4NzN1NEVWckIweEJiSEl0?=
 =?utf-8?B?WVkxV1FDb3NTaTE5Vk01S3hBYzVkem9FRDJnMWlkWDh0M0xZUWlhZ041bnJw?=
 =?utf-8?B?YnNsWnRXcnBScVVlVXBFaVJTS1RtbWFCQm5McEg5Y0lNeEFOcExiZCtCVnhs?=
 =?utf-8?B?a2s4dXpjQlltL2dGcHNHV3NKZFZ5ZDFBSHY3NGRPd2JYaGw1K3J3RlNRRFpB?=
 =?utf-8?B?Sm9xUTE3VXo2aWxFbHJpM3d3bGpZUDh6NkpDSkpkUEViZlRtZVBJUHlqYmxF?=
 =?utf-8?B?OWR2V2lSQ1RQcndUUTV6VFlSTGVraEw4dGl1TEUrT21jeHRuLzJGcVFmNmlm?=
 =?utf-8?B?MElqOVUzMVpiWnQ1VnkxQ2JPU3lTNHdsVUJIeDNLYmxYczAxMHUxbGNPMlNI?=
 =?utf-8?B?Q1JWRjhsWkZnTEE0SFZjd3Q4UTdMS3VLSHJNTUFnajR5MEgvYkF6VW1DU0Zn?=
 =?utf-8?B?amV2NURyV3p3eTk1U3BJekJzNkU3WGlETVAzak8xSDc2Z2NJUlJlamcvdmJC?=
 =?utf-8?B?VjYwR2oyaWg3UGYvZkdKSGQreDNQaEJpOTJhdnI5M2Evb2pnb0ptVEpieXRP?=
 =?utf-8?B?SDlQbnRtR0FuczRJVnV2S2NpeFlZOG4rYk90cTlXdnE2UGRxeXh6SWREMGhE?=
 =?utf-8?B?MGxaWm1IUG9GdG8xY2NUVytNTi9oeGVtaFRIZTQrL2lacVQ3aUsrRWxibDU5?=
 =?utf-8?B?SHJqQkoycnVkdjJiLzNBTzNGY2tXZE5sMG0zTFNMUEZyYWJlckYwaHVBYk53?=
 =?utf-8?B?UHhnVkdPS3UzczI5Rk1IUlRoUFFNYjhqMUplWE1JMVVVbmo1bDBGbGhGRFox?=
 =?utf-8?B?Tlc3NFhsc0RYa05pdTFxVC9ySXZXcUVTSjN0UHByZ3Rjbk1LbE5wYVFiM1lK?=
 =?utf-8?B?YURXWUh1T2dvdDR4WkMxbWxTVHRhYlpRTUsycytKVEYwL2RBYnN4NVplbEpO?=
 =?utf-8?B?TXYrbVVVQzMyVW9PSERJVmFEQVJjakRRclZOclVZbkdEZEYzc25iNUM0Sldo?=
 =?utf-8?B?ekNlczhUREp3eDQySTdyNjNWNHZCbkZyU2ZzTjBUNnpmOXRJS09abDk1ditB?=
 =?utf-8?B?UlZIRmd2WjRmMk5COVdBSjRFREFYSVdqR2ZaZWFjT0h4cHp6TFRUdG1EVFhp?=
 =?utf-8?B?MWJGTnMzM2JhT1VsUWt5MThMSWZHSmN6L3EwZ3d3TXRraU9HY3BjT0Rnenlp?=
 =?utf-8?B?YWhZbzIrTEV3QTBDWitQS2xBM3crYyt5a2REUmpyb0NFMVQ3MEs0bEZZR1V4?=
 =?utf-8?B?UTJnVmpEK1VRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWlhdWdINDQ4bVJBQldQb0VEclJTS001ejJ3aEdVTXRxbkRCVDI4eHhyUmwz?=
 =?utf-8?B?Y2FiUVk5SFo1ZGN1WjFJMWNPWGhmai82OEszK0x5OXh5aklOYXo4M0U5S3ly?=
 =?utf-8?B?RFQwT2hjYkNjWmRnMTZub0pPM3hkOTgvNzl0SE1iNU12TVE5R2YrWnd3dU9u?=
 =?utf-8?B?bDQ0am1naFA5cWFFNWxaRG9XeU5LVWxzRHNGaTEvZGVnUC82TXR4SXVpcEdo?=
 =?utf-8?B?enRVMGZBeUNJTEYxY1c0UmdUOU96MDVrR1RSRmhqQ1ZuTmphdlJYY0Ficncr?=
 =?utf-8?B?ckVMZE96TzVlSjdFckZ3L2FiRDJLc3hEUFNFR3BIOVBHWERRSzFpZ1ljMnJo?=
 =?utf-8?B?MHZGeGJoZFpFSndqL1BqY2dxL1RMYzFHU2tBRkVCckRpK1U0Mk1kNmN6dTIw?=
 =?utf-8?B?ZmgzUm9DRlFVWElISjlhbDgxcUU3cmtQa0ZwRE1mOHdOUjhaMHlCZTMydmhq?=
 =?utf-8?B?LzNZdmh6M3NDVHNKRW80UXJQUG5xRjJmNVY1M2hmSVB4WllFN2psNHpOMVN6?=
 =?utf-8?B?UjllTEdHdzQxQ0szMHl5QUkyUEZ1WHhuWHJQcVpCN1hNdlh6V2lNem80SHN5?=
 =?utf-8?B?cUNnWGxaMCttWE4xTG9VVHY1dTN0MHBzWGZMdUc3clFHV285NXFZRE1uTUdF?=
 =?utf-8?B?VGN5T1dKYjU5NjU2ZWVHd1kyMUhoV0xlQkZWT3NlQjQzN25ENDVCWmdFVGpw?=
 =?utf-8?B?bnh3OVdCYnBmZkFGS2dDNEhYckhQV3g3dDdXbjlkaDNwYVIvQ2FjNUhkREFW?=
 =?utf-8?B?dHNPdU9aY0lXTCsrOWFSUklvdjVDNVp5TVBWZzB0VTFLNzExV3BwdlhqN0xB?=
 =?utf-8?B?WFFtMVI3amZCUkk5VnB0Ym5TTm5WczNNREgrYTBZTTQ2S2ZyYVlOV0lHMWlR?=
 =?utf-8?B?U2hQUWZ6MklVU3kzRXBWOEtWQUhFa2JRMHNkZXhyT2J5N0ZjMHNGUmFZSldB?=
 =?utf-8?B?QmhPQlhmQU9BMVBkUXV0ZEF1NDcxdkd0dDVIK2tQTzdRUWVsZVFXaGhFKytm?=
 =?utf-8?B?N3NCUFZSUFVqUEphb2NRc3VRNjJNdDRQMEtsdTdHTlRUZXZwL0E4aEVVRzBu?=
 =?utf-8?B?L3E0a0FPaEtiNm1zQVllNzd4QnMwL2hnR1Q5eWlNSzA2eUNQem9yQ25FV3ZG?=
 =?utf-8?B?QlJ3UGRMa0xnb1UrV2hTdUxlMmhJaVVGa0xkYXhVb3JRYkoxUHZXaXZHQ2Rl?=
 =?utf-8?B?b2VBKzE2ZnRlWURJMnQ5YTJjb0pMdzVab2tPa1N4OGdzTit3UkpXWm1JRkpB?=
 =?utf-8?B?VCtUM2srR3huSWx5VC9vQ1FZcXpNYXhkTE1mOSsyQXVsSS9SQlRKQ0pjMW42?=
 =?utf-8?B?MjZMODNQRWRjUGMwMUtjaWkvaHp6QWMxTGJWRTVsV255eHhKbERHS2E1NG5W?=
 =?utf-8?B?c0VxYjVNbXc4UExuVkFaV1hRakh4YzNVUlFtWTlmRmtaRDcxeGFnS250UXE3?=
 =?utf-8?B?bnQvU1Q0Q0dTYmxrNFFxTmppcjJ1K05vUkE4YzNDcUtpTnp1YzIvNmMxL1Jy?=
 =?utf-8?B?UnRpbVp6VExXcUhRZDRObm9SWjNlMWNCMmFJS0wxQW00bDcrYmE5dUNPOGlM?=
 =?utf-8?B?RytSRVM3K3VyMklkT0ZvOCtMTnE1SmdYZitDWmZpWGpLampVeFpBc09DZ2dT?=
 =?utf-8?B?UTQwdlg5Yml1UHpVRXh4S3NmMEhsL3R4MVQ0ZUhobnIrSjZ1bmxlK29VbnQ4?=
 =?utf-8?B?L2RqK3Y0Z0V1cGtUT2tOZFF1NE4ycU9hY3RYcCtneU9MTjQwZnI2VThzQXhx?=
 =?utf-8?B?OXl2SlNXdUZOZVYyd2M2MkRQTldSNDY0T2EzbGx2ZmtKOXJSNHJUNVBzclJW?=
 =?utf-8?B?MWNrcWFGWWZVeE5vRXpuQ1I5YURoWFAzZFQ4YjhOS1I4dVdDZ3JSTzJsejlN?=
 =?utf-8?B?dEYxNFQvZzVvWXErNmw2R3lYM1MvTXh0VEh4RlBOakRTMUVrVThFUWRTc1pO?=
 =?utf-8?B?SG9PNjBWY2ZxanhQejJTZDhqUlg3SkRPMVozZ2dDRkNyOU4xOGc2TUJuS01l?=
 =?utf-8?B?RlEyZHRuTStuajVGSjN6TWhsbUZyVEgvcmVTdU82LzZNa3pkMWE3OHNYUmNK?=
 =?utf-8?B?cW9tNStLZEl4L3Vtc3pZSEkzMklzT2pTek5JRHYzdkZQcHBFTXl5T3lRK2c5?=
 =?utf-8?Q?IfCwl0MPQGZLxr9hQVjXSTqeK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2e8d68-121f-4239-003d-08dd1e076aef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 19:25:36.5501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYK+uL7oFnDPpZAMxJeYrCF4n/Z4izQ7oXIqHhoxhEmOgNogtL+mEz+oC1bDBn3oCgcrvuWGk5Mrti5pmfE3aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10249

From: Pengfei Li <pengfei.li_1@nxp.com>

Introduce support for the i.MX91 thermal monitoring unit, which features a
single sensor for the CPU. The register layout differs from other chips,
necessitating the creation of a dedicated file for this.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- Add Macro's review tag
- Use devm_add_action()
- Move pm_runtim_put before thermal_of_zone_register()

change from v2 to v3
- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
uboot may change and enable tmu.

change from v1 to v2
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
---
 drivers/thermal/Kconfig         |  10 ++
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/imx91_thermal.c | 263 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d3f9686e26e71..da403ed86aeb1 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -296,6 +296,16 @@ config IMX8MM_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the passive
 	  trip is crossed.
 
+config IMX91_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX91 SoC"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on OF
+	help
+	  Support for Temperature sensor found on NXP i.MX91 SoC.
+	  It supports one critical trip point and one passive trip point. The
+	  cpufreq is used as the cooling device to throttle CPUs when the passive
+	  trip is crossed.
+
 config K3_THERMAL
 	tristate "Texas Instruments K3 thermal support"
 	depends on ARCH_K3 || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9abf43a74f2bb..08da241e6a598 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
+obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
new file mode 100644
index 0000000000000..ef5e8e181dd0f
--- /dev/null
+++ b/drivers/thermal/imx91_thermal.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/thermal.h>
+
+#define IMX91_TMU_STAT0				0x10
+#define IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
+
+#define IMX91_TMU_DATA0				0x20
+
+#define IMX91_TMU_CTRL1_SET			0x204
+#define IMX91_TMU_CTRL1_CLR			0x208
+#define IMX91_TMU_CTRL1_EN			BIT(31)
+#define IMX91_TMU_CTRL1_START			BIT(30)
+#define IMX91_TMU_CTRL1_STOP			BIT(29)
+#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
+#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
+#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
+#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
+#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
+
+#define IMX91_TMU_REF_DIV			0x280
+#define IMX91_TMU_DIV_EN			BIT(31)
+#define IMX91_TMU_DIV_MASK			GENMASK(23, 16)
+#define IMX91_TMU_DIV_MAX			255
+
+#define IMX91_TMU_PUD_ST_CTRL			0x2b0
+#define IMX91_TMU_PUDL_MASK			GENMASK(23, 16)
+
+#define IMX91_TMU_TRIM1				0x2e0
+#define IMX91_TMU_TRIM2				0x2f0
+
+#define IMX91_TMU_TEMP_LOW_LIMIT		-40000
+#define IMX91_TMU_TEMP_HIGH_LIMIT		125000
+
+#define IMX91_TMU_DEFAULT_TRIM1_CONFIG		0xb561bc2d
+#define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
+
+struct imx91_tmu {
+	void __iomem *base;
+	struct clk *clk;
+	struct device *dev;
+	struct thermal_zone_device *tzd;
+};
+
+static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
+{
+	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
+
+	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1_SET);
+}
+
+static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
+{
+	u32 reg = enable ? IMX91_TMU_CTRL1_SET : IMX91_TMU_CTRL1_CLR;
+
+	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
+}
+
+static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	s16 data;
+	int ret;
+	u32 val;
+
+	ret = pm_runtime_resume_and_get(tmu->dev);
+	if (ret < 0)
+		return ret;
+
+	imx91_tmu_start(tmu, true);
+
+	ret = readl_relaxed_poll_timeout(tmu->base + IMX91_TMU_STAT0, val,
+					 val & IMX91_TMU_STAT0_DRDY0_IF_MASK, 1000, 40000);
+	if (ret) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	/* DATA0 is 16bit signed number */
+	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
+	*temp = data * 1000 / 64;
+	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
+		ret = -EAGAIN;
+
+out:
+	pm_runtime_put(tmu->dev);
+
+	return ret;
+}
+
+static struct thermal_zone_device_ops tmu_tz_ops = {
+	.get_temp = imx91_tmu_get_temp,
+};
+
+static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
+{
+	struct device *dev = tmu->dev;
+	u32 trim1, trim2;
+	int ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
+	if (ret)
+		return ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
+	if (ret)
+		return ret;
+
+	if (trim1 == 0 || trim2 == 0)
+		return -EINVAL;
+
+	writel_relaxed(trim1, tmu->base + IMX91_TMU_TRIM1);
+	writel_relaxed(trim2, tmu->base + IMX91_TMU_TRIM2);
+
+	return 0;
+}
+
+static void imx91_tmu_action_remove(void *data)
+{
+	struct imx91_tmu *tmu = data;
+
+	/* disable tmu */
+	imx91_tmu_enable(tmu, false);
+}
+
+static int imx91_tmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx91_tmu *tmu;
+	unsigned long rate;
+	u32 div;
+	int ret;
+
+	tmu = devm_kzalloc(dev, sizeof(struct imx91_tmu), GFP_KERNEL);
+	if (!tmu)
+		return -ENOMEM;
+
+	tmu->dev = dev;
+
+	tmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tmu->base))
+		return dev_err_probe(dev, PTR_ERR(tmu->base), "failed to get io resource");
+
+	tmu->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(tmu->clk))
+		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
+
+	platform_set_drvdata(pdev, tmu);
+
+	/* disable the monitor during initialization */
+	imx91_tmu_enable(tmu, false);
+	imx91_tmu_start(tmu, false);
+
+	ret = imx91_init_from_nvmem_cells(tmu);
+	if (ret) {
+		writel_relaxed(IMX91_TMU_DEFAULT_TRIM1_CONFIG, tmu->base + IMX91_TMU_TRIM1);
+		writel_relaxed(IMX91_TMU_DEFAULT_TRIM2_CONFIG, tmu->base + IMX91_TMU_TRIM2);
+	}
+
+	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
+	rate = clk_get_rate(tmu->clk);
+	div = (rate / 4000000) - 1;
+	if (div > IMX91_TMU_DIV_MAX)
+		return dev_err_probe(dev, -EINVAL, "clock divider exceed hardware limitation");
+
+	/* Set divider value and enable divider */
+	writel_relaxed(IMX91_TMU_DIV_EN | FIELD_PREP(IMX91_TMU_DIV_MASK, div),
+		       tmu->base + IMX91_TMU_REF_DIV);
+
+	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_PUDL_MASK, 100U), tmu->base + IMX91_TMU_PUD_ST_CTRL);
+
+	/*
+	 * Set resolution mode
+	 * 00b - Conversion time = 0.59325 ms
+	 * 01b - Conversion time = 1.10525 ms
+	 * 10b - Conversion time = 2.12925 ms
+	 * 11b - Conversion time = 4.17725 ms
+	 */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x3), tmu->base + IMX91_TMU_CTRL1_CLR);
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x1), tmu->base + IMX91_TMU_CTRL1_SET);
+
+	writel_relaxed(IMX91_TMU_CTRL1_MEAS_MODE_MASK, tmu->base + IMX91_TMU_CTRL1_CLR);
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_MEAS_MODE_MASK, IMX91_TMU_CTRL1_MEAS_MODE_SINGLE),
+		       tmu->base + IMX91_TMU_CTRL1_SET);
+
+	pm_runtime_set_active(dev);
+	devm_pm_runtime_enable(dev);
+	pm_runtime_put(dev);
+
+	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
+	if (IS_ERR(tmu->tzd))
+		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
+				     "failed to register thermal zone sensor\n");
+
+	ret = devm_add_action(dev, imx91_tmu_action_remove, tmu);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failure to add action imx91_tmu_action_remove()\n");
+
+	return 0;
+}
+
+static int imx91_tmu_runtime_suspend(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+
+	/* disable tmu */
+	imx91_tmu_enable(tmu, false);
+
+	clk_disable_unprepare(tmu->clk);
+
+	return 0;
+}
+
+static int imx91_tmu_runtime_resume(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(tmu->clk);
+	if (ret)
+		return ret;
+
+	imx91_tmu_enable(tmu, true);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(imx91_tmu_pm_ops, imx91_tmu_runtime_suspend,
+				 imx91_tmu_runtime_resume, NULL);
+
+static const struct of_device_id imx91_tmu_table[] = {
+	{ .compatible = "fsl,imx91-tmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx91_tmu_table);
+
+static struct platform_driver imx91_tmu = {
+	.driver = {
+		.name	= "imx91_thermal",
+		.pm	= pm_ptr(&imx91_tmu_pm_ops),
+		.of_match_table = imx91_tmu_table,
+	},
+	.probe = imx91_tmu_probe,
+};
+module_platform_driver(imx91_tmu);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


