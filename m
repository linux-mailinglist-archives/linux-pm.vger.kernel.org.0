Return-Path: <linux-pm+bounces-42159-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNtNFWq9hGnG4wMAu9opvQ
	(envelope-from <linux-pm+bounces-42159-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 16:55:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8EF4D2C
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 16:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A51B63004CA3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85955429812;
	Thu,  5 Feb 2026 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ndbJNSQh"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3C42849C;
	Thu,  5 Feb 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306917; cv=fail; b=lfX0YFvM4Eec1+P4bybNbW+5YI2vhdgNJGc1QzGeZfIzacwSghmgHd5FsFpw9Z4WyMjm34oUKEdUolhASz2J/5HNewBfJ0+9TwbfMhVE6OrS/TxdJeB1Ute4MWPWyzaLXWVV2IPjKp+skQ/U7XMBn2lZQNjHg1eTGJT6Wqsd2zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306917; c=relaxed/simple;
	bh=qTSCunEEBtyqxFevCcRAy5pQwaw/LLlIKimnVtuMezQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W3h8mqMA3rOO34HnOKLhc8X5eJvjnEl3QA/lH5vU5+cCamPu/xwgF5zLCTOTTookPsVEJonpm81EmF/LuCAB/IGCGADWmQj8I2jToRlotk1r1yKcYEBisivx8slI4kqcOpYs5RNK4tcbYSQDEZ2yqCPoR4wH1Pii2xGyYJqZVEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ndbJNSQh; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hb+HMBRpZk1rTZYK4EcIKnEkzdBK8S1zGb48A6cD+pYyP6zyLkiI/uvgRc3+3YJvap5xIZ6O5FUd4dZ5aUW9V03y8sv8DLDnlIsUFpBZtap2CpN2fv8ZDu9nxf7V0Z2nMrat+CUGKp2aZqnc/7H6lYRG9YAmNuXHqJdvjZBATLOGA+g47QB34BEj2+whYSEqWvbLxO3qma60HUeoS4OeYP4l0iRyJkb4w2LD4jjpWXddTcPZaVbV6+d0C+2B2vZb4wZWiseEhCwwSudmem00vZRtT/CFYLtkIshGdF89pcTv23w7sEutNwCEtcD0N7i2du1ZOdrh6evomG9TlWueyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbodL6wVmjR2viYN+uVGr5vtP/xehROiChFnGpK/Kbk=;
 b=S9VoSt65tS7gswl5Ud6eazal3DHK3lh8bx7kmZx58mbCzgc2p4w/M73GYE8zE8vG7gonlEunqkJacvt8W4tsX4HPOAmSWlyXsHxBT/aoK211iJjB3btrqOHAM2G5rvPEZX3bmKC1qGAAzw8LQscwxma1ClUHMJ7Bvr72w53la5z852r1fTdp1c2a0hKc+wmfxlzKEWRQ7qxiOkFkKGRVg/pyKQSJo1wVLqYApTrzjqFkh+GKxd+y4dHvx0H4hGfc39aYIKBQqTZYPjuvgH0ZBLfPYiGpaP8lrHd333vI9afrXpuTcMkAR66lWztJ/m9sSauy0J1ToLAFoZ7XJheS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbodL6wVmjR2viYN+uVGr5vtP/xehROiChFnGpK/Kbk=;
 b=ndbJNSQhiukII0CodijTuMXW5F5URtrN9/Hx83JnV8OpxRM0b2u0tAfMd6l0xjm8kfGG9wrwtR7NhwZGsQlt0AHzxsKk+P3N1yVfaWLnVOL3GUNnk60aH0SKBvxRUNsVh+Bb28TlELWTrTgzYsPuVS1g+kVw3EemCigPcDgDhBr4Ns7V0PfNA34SVIl2ZFGTlX4Y7mcVyaiVZifbPbaDzJARVNnKOK/ZtMAgPGgJdORE0Xlt7oTPwINQC37BpHkT27V91b9l7WbCI9nh2f7bnu7WZZur/J1xn4vuu5FBHMm7LcdHNj5e13PqEZ/FwUS3Ta+xC3lF0GESuCWJTF8bsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7396.eurprd04.prod.outlook.com (2603:10a6:20b:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 15:55:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 15:55:14 +0000
Date: Thu, 5 Feb 2026 10:55:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 3/5] i3c: mipi-i3c-hci: Allow parent to manage runtime
 PM
Message-ID: <aYS9WwwjgZi5UDTE@lizhi-Precision-Tower-5810>
References: <20260205100915.19792-1-adrian.hunter@intel.com>
 <20260205100915.19792-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205100915.19792-4-adrian.hunter@intel.com>
X-ClientProxiedBy: PH8P221CA0063.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 1918116e-f78d-4c8d-0fbc-08de64cef33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vnh1qPjTuXW1du51y1KbT7V/d7AMpPV4lr6VfZ5Csng0DAyd557COnAxAUdF?=
 =?us-ascii?Q?nNlElcoGBULQEWYSVk1U3TWWFWbCaNAL4zWHNMQi0mVNxv5k5EMnfYmZgC+V?=
 =?us-ascii?Q?UV1V8eXC3UFXDiNfNhhjUhv1w0sUvYbeu2+mGIH2YUxI1RSpNPrGeUoM97KK?=
 =?us-ascii?Q?u4g7TxUo07x54fydZkAaBbiBvW0iH8ldaVr87ezPiBfoqQXxS4ksalJ1qkDb?=
 =?us-ascii?Q?SAkGss6CbCVws9UyjR+fH/3TWxGmvfmFsUZyR8E0DM5sm33/hylJyyNire5U?=
 =?us-ascii?Q?Y8PMIARbMCXFisz/qKzdvgj99JAzUjfSDKW/iX9akidrk6z2v8k2Wr8c9/wI?=
 =?us-ascii?Q?/89AUOcv7iaZ2atEuXxwOj6wTieVMzoih3EliQrOHC/KyoLM95mYc5teEM9l?=
 =?us-ascii?Q?Qb3yQI+j1z6vTUVDjbLf2JSSnBLyUkGXT1gLGs+CuDxYfG3yk9Dkk/iWNurL?=
 =?us-ascii?Q?9i4t/qypd+QtvC/E1t5dlqBM/fy518xA9nUmDXLgkLwmJU4FYRRz2YcjX99Q?=
 =?us-ascii?Q?NPbnrqFQXjA+vJC8mZWwQ6NrBNSNNdlV6QrWcdGXSx5DEL+GKpdIZLE4t9Yg?=
 =?us-ascii?Q?00skRoClbAduvV9o3pLvOrzrbmUEuXpRSAEsrTGlOaMEctyLrAHWo1Pghbqu?=
 =?us-ascii?Q?vxGY6ap3QQx/AsAcTZeojFxkb+UL464CdaKqdu+26nzoZSozTzGLvkuod1kx?=
 =?us-ascii?Q?hYOOw9fN86DyTVucEFacR45AOgBkzuJ9yUjqJLQ2+bzRkR3kx+Z1X2QierYn?=
 =?us-ascii?Q?CapMAX2wwtEX7JPQ4pqrifF1cWQEiUffI3etuxVlXm/+ux4T8NyEcM8K5Ork?=
 =?us-ascii?Q?/libpzk+n8sYxofDFoXnys5229zoUMmb6mlRw8w3M/1UuGCtA2prfgcmeK9e?=
 =?us-ascii?Q?lX6GSxeN2uqG/CGjlQ0gD+9ZeBXvLr+GDynTa1+fzhA66KnHr98GfkpY14QV?=
 =?us-ascii?Q?AzOKf2bp2JBQIyqmlxjAvC8pQCInnbetzKMgLT3I0mRWUrB0xqe/rRt9s61b?=
 =?us-ascii?Q?ge45MHBB9hG6DRhXXp1yKzXaHp05/mI4ZS2h23i1CHMbVTw/If1ZorruYQbY?=
 =?us-ascii?Q?VVC33Aw6FJym325fKCQ9Ud7HXDRSwXJQ2lnjStengpO58ngdZj4L2rxb0jEr?=
 =?us-ascii?Q?uKbOuKPQn/WezL63rq0afwWaOzRHdzclsfb9E0Yl/rKaERymP1UfrxuZjlfI?=
 =?us-ascii?Q?o3kFuzTrzHnbzoD+qThKmlMPSCLLlWmeX4RfTxekr33CZkdsCyN95Aqfw9ks?=
 =?us-ascii?Q?vtFHBehekeNssCSc2eK2hGi3HRsymYOvr+HRf3Db6LeEJfDP5YP+oMh7W+AX?=
 =?us-ascii?Q?4aW+c04rY8YK2FSmNFhcXhbXUkOI1YB2d9r/2mQ+rCU8DBskjen5c+463FuT?=
 =?us-ascii?Q?mu/eKJkN2S5K58vahMS3x5gvG52GFxXOAfIu/GzUVjUcQ6c94OQFBgCrADm+?=
 =?us-ascii?Q?P1MXRcURNeQRHXw4K6WaWWPOLzOBqeDo3TEoqM0LeDmKEvjbbKbHzZcfi/6k?=
 =?us-ascii?Q?vtwVZsuPpKlrW9YarQCpm4HfacJZk7XZC8dnYXSU1ruarucaso6fAo35mlXe?=
 =?us-ascii?Q?hXum0tXcfm0IPDOoruakkC4Opef8xz998t2c2nTpQx1E0HgFJvirB9WdW/9i?=
 =?us-ascii?Q?0sZpXaRw1AeIdSmWdUxquVU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9xqOn0PKnjqvySzMkUbtp4lA87awNI9mjas/IeIZkkvbNjZBzAEYtPOkdxqd?=
 =?us-ascii?Q?9GJxp6XFJtJkRCyYbTtCp5Du6tY/fB5Wg5eIKdYiNY+aer9frnhzMQAuJyRs?=
 =?us-ascii?Q?W8fILoQHHT1z7VZ1sB9RHyY6ZETkvwDoxQ0YENlWp27lgBw3LE9l+1mW2FPr?=
 =?us-ascii?Q?ZE4WhtoRG72qimwCqMf/XN+esd1WZDPEoGt5wKygCGZXCVEb6W3YayloNexw?=
 =?us-ascii?Q?XMlboAe9SLD2E/7jaN+L0JyFzHS6LmN+sxjOesTDa5ry30gpW9sp4Dp1aRTO?=
 =?us-ascii?Q?c2PWGYGY7vXTPKrjVm3cCd6Zpx9wYIjamB0r/ifeX+jkHqVO7bbyquZkXX3w?=
 =?us-ascii?Q?/AbApFa2b1FBDwuNHCe8AcRDPCPtPcOCrujPuDnXVlOg9AteLQdxg+NlaPgm?=
 =?us-ascii?Q?XIpsXe3sa+vv4NDGUFqK8xwzM1py9tC0b+9xBRZYsBlbonEDHWEJHBbHIXN+?=
 =?us-ascii?Q?0dDK/5irwHFz3dcSsN8DlSlEJBfDnVAf811l1iwxm7cLxfZHp73oDcTA5k8a?=
 =?us-ascii?Q?MMch+04tFhQEiTFfb3UXaIpqST7sbXJJhBnaJFWXnFj81lhBXxsehrQWCgv3?=
 =?us-ascii?Q?4de2xBoyO9lUBfjJAu1J2wgFHgCYUhkR7HFf9LVyYJfcu4d+dlqALXgRYj1x?=
 =?us-ascii?Q?0BiTbVd+f+sOHjtcAdypS4coUy/pR+f38Z3Rv8zTNhFViFEDlJovwfQYiGMe?=
 =?us-ascii?Q?J2cENol4Ejmwr0B7u5ii/nJ8dql5WcREDmUnwdGQKHxEYxv5Gybu9Cen4bkI?=
 =?us-ascii?Q?h3oK/aMvURE7blZL+1uFQyao4zSFlgB2PDGTOYL7x5IYeZXIdH2o8r3HZOKc?=
 =?us-ascii?Q?EmsT1tbEJIO6fQ6/fDJoOANncJLLQQTBHe9d2XWOb/7hfCH6qtenQqCP0ZH2?=
 =?us-ascii?Q?m/NGzo5Ag1UjZh9vSeEut8OZfQJ4FUXDjhgGHYe6F0TDHAigN0RcRSzIm7ZK?=
 =?us-ascii?Q?JoI5RV/AAn6O0cgphkGTCMPCARorM/BtUM8Fm65owP7XCd3dzA7INOWHK4U2?=
 =?us-ascii?Q?kdyUe+IJCEmLDbesCUw+7yZVr9ckQbHWqUAREQeA2m0Evmy0jc2d/yXV00ve?=
 =?us-ascii?Q?++uO+Uc3Wg7xw9lwVK5ghJYmj7ngGQ5yOAMemB42eBnTJPfLLJZj5fyEBCXl?=
 =?us-ascii?Q?iXTKICmzZozZT1KyeWSIYwWgpSXJOucX99+YWK+nN6G8b0+1oO3uvbZ6IRUQ?=
 =?us-ascii?Q?gcfLYHXTUF/3oSmBVPTmnEEzeeTvzN2WM3Yn1se1OElmb3w29oG8x/usLq7U?=
 =?us-ascii?Q?K/IhMASA/9n9NXQqlFT9gOnl16xOHn4PHzIARj9IGegQ6FFb6oWw06mJPpBL?=
 =?us-ascii?Q?QACF7N5mGxGmsPTkg/eRj0jmrOeP4guwbsjjOtxTnIaKOiyZPbMJQWXssN8M?=
 =?us-ascii?Q?bkdY2MozKWpWj6QM9jf2imrfTccqCxTkx9LoOI7w1I0F9GZpcJekci01s02G?=
 =?us-ascii?Q?ztsEelCF2cRnZUW5x0GRsZREqfhf8AiskANw6ZZWdglKdAxLc6E62MKWmRPg?=
 =?us-ascii?Q?8huvvPo76GovL2d58JkT8j8BEwE2HPWWado8KDZ6JbLiq7o+eJO7ZbXu5NGb?=
 =?us-ascii?Q?P7vbXmuuxFDWAhki6wzGdZvxa5tb81LeetXSFi4GmKvAIjNxzcOwYNb78IXZ?=
 =?us-ascii?Q?rKOAx95EdClsowUGeoA5ubnNXePzdI4G+/MxwYXhisO7QVZKtVFPkOHwFD5w?=
 =?us-ascii?Q?zSgsLqtZciQDBb3+6mTXWjL6m8MgQtQthznIFanV6aXTzRVcF8xXH5Ze8zn/?=
 =?us-ascii?Q?/u+nbYCMrg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1918116e-f78d-4c8d-0fbc-08de64cef33e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:55:14.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDuTXZwajphWlRduaMvY/FipnPIV7TWx3xnN6JgV9dVCU0w9/iA3AH3n4djc9uOOPkfou9y7715mwUbNPAtNCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7396
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42159-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 6DE8EF4D2C
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:09:13PM +0200, Adrian Hunter wrote:
> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
> where a single parent device hosts multiple I3C controller instances.  In
> such designs, the parent - not the individual child instances - may need to
> coordinate runtime PM so that all controllers runtime PM callbacks are
> invoked in a controlled and synchronized manner.
>
> For example, if the parent enables IBI-wakeup when transitioning into a
> low-power state, every bus instance must remain able to receive IBIs up
> until that point.  This requires deferring the individual controllers'
> runtime suspend callbacks (which disable bus activity) until the parent
> decides it is safe for all instances to suspend together.
>
> To support this usage model:
>
>   * Export the low-level runtime PM suspend and resume helpers so that
>     the parent can explicitly invoke them.
>
>   * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, allowing platforms to
>     bypass per-instance runtime PM callbacks and delegate control to the
>     parent device.
>
>   * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
>     by parent-managed PM implementations.
>
> The new quirk allows platforms with multi-bus parent-managed PM
> infrastructure to correctly coordinate runtime PM across all I3C HCI
> instances.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
>
> Changes in V3:
>
> 	None
>
> Changes in V2:
>
> 	For HCI_QUIRK_RPM_PARENT_MANAGED case, change from
> 	disabling runtime PM to instead causing the runtime PM
> 	callbacks to do nothing
>
>
>  drivers/i3c/master/mipi-i3c-hci/core.c | 28 ++++++++++++++++++++++----
>  drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
>  2 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index ec4dbe64c35e..149b3fad34b5 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
>  	return 0;
>  }
>
> -static int i3c_hci_runtime_suspend(struct device *dev)
> +int i3c_hci_rpm_suspend(struct device *dev)
>  {
>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>  	int ret;
> @@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(i3c_hci_rpm_suspend);
>
> -static int i3c_hci_runtime_resume(struct device *dev)
> +int i3c_hci_rpm_resume(struct device *dev)
>  {
>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>  	int ret;
> @@ -768,6 +769,27 @@ static int i3c_hci_runtime_resume(struct device *dev)
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(i3c_hci_rpm_resume);
> +
> +static int i3c_hci_runtime_suspend(struct device *dev)
> +{
> +	struct i3c_hci *hci = dev_get_drvdata(dev);
> +
> +	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)
> +		return 0;
> +
> +	return i3c_hci_rpm_suspend(dev);
> +}
> +
> +static int i3c_hci_runtime_resume(struct device *dev)
> +{
> +	struct i3c_hci *hci = dev_get_drvdata(dev);
> +
> +	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)
> +		return 0;
> +
> +	return i3c_hci_rpm_resume(dev);
> +}
>
>  static int i3c_hci_suspend(struct device *dev)
>  {
> @@ -812,8 +834,6 @@ static int i3c_hci_restore(struct device *dev)
>  	return i3c_hci_resume_common(dev, true);
>  }
>
> -#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> -
>  static void i3c_hci_rpm_enable(struct device *dev)
>  {
>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index 819328a85b84..584ee632b634 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -147,6 +147,7 @@ struct i3c_hci_dev_data {
>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
>  #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
>  #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
> +#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
>
>  /* global functions */
>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
> @@ -156,4 +157,9 @@ void amd_set_od_pp_timing(struct i3c_hci *hci);
>  void amd_set_resp_buf_thld(struct i3c_hci *hci);
>  void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
>
> +#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> +
> +int i3c_hci_rpm_suspend(struct device *dev);
> +int i3c_hci_rpm_resume(struct device *dev);
> +
>  #endif
> --
> 2.51.0
>

