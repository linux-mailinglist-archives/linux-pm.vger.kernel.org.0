Return-Path: <linux-pm+bounces-21192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E25AA2452E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 23:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FB51888A81
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 22:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC9192B84;
	Fri, 31 Jan 2025 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fOX4Xk4E"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53172AD20;
	Fri, 31 Jan 2025 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738362186; cv=fail; b=mT1EuvTfYfFlWPIyLHhm1IhG8OrB/NBt345b1PM0DGMTFPGb50/gCN6t9degkmarH+/o/4R19rwwls4FHo1H1Hhmm6xrBZgvppIo9//vEPZOgvi9YoNLnL7CaJfeTVEJXacew04LQy2oR60n0zIhhGxmuH+Jq5qn2tCwhca2of0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738362186; c=relaxed/simple;
	bh=aR+EXmPPqGVgn/XzhIj5WL6SFj0VMqt3dEOUrh0KHAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ghYqEoOYSoC87S/ioWO9MOmYZyUhFsvf2OEeJXsXQrv810mr/CpkgEl2O9zpa67zkSO95g69H4Tf4Zj880PRw9YqOF1RJRVmenKSsHpWkswLwd1jJ//f9OEn3tetasQgNLfG+/BJB6BxDUsI+e/XyTY6wsUx8Db5Fi51j1mPRgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fOX4Xk4E; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLkiPGqO08w5XNVztrcXVv+B82f6Oht8/HApqUQDTD0FAEtBa2ZhO0SqjJN4/Udnd+FTxifquEaSGtC/6Jdyp1lO65mh4Tc4or8nxCe1Hq6vSFBOdw7kgwfjCk80l4Zkqmy6mnP2rCw3oQ07x0Le0ZHFBDVq34iNs3azBu5aj5cpAUhxgcgjdtCIvEHAYBphp+2YO9BaNaAAHvPri34UPZeuN3JCb1hbh4cr7UWM+RUs4HJjuetOQFhMT6bh+E99iStt2fmKIct6v+8/Y4viDvqH37DoEo6H8VPahjv+NGo/ZRpXU1k0gSOwqHd06XttJfV8U9+a7kubJlvckW3eLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLRH+yVuX2a0KMDWja5PkDHmF/VnQaYycNWWcOP0trs=;
 b=SbxhuHcPFTz/bCxE2fgaNp6ZnAerzYgEfCJJp8TZ7PvxxD+2DgAvFLa5QQ1CK0bxQbRCyj61DZVebrzfm1VV9NOTvoBfK4EkC4KoM0yJGZgTBZYdqFobvxYlwjGJ7bdvGTzcWP/mdmUCmvSSC11S5zWf7IWnz8tYQpwdB9024FbAeqgpcDXvuYUYRfGJL1jR4SJjS08salyp9j+LShlTnFfgY+NhTz+3XGFf8EVYF9yCAqsCmppyjVxSLLUz086otil/znaRDyWXHPvC2cjdS9q4hz8/XQVjToOY5JEn/Kn466gGqERXwy5hQkw6sCp9Ppm3m9UvHwFQCGpql6jxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLRH+yVuX2a0KMDWja5PkDHmF/VnQaYycNWWcOP0trs=;
 b=fOX4Xk4EFl2BboQHtGZC05m8KEzcNwhi/XmFKfLsO/mofnB8fznOD9I2or/mjfJ2IJiaDPkn0SBTxjAMBNpgmn8Xm8OZq7JA8g87ZcHdx10qHsLMlEyYWrvaPwTMTlJRowEAiV5C1fVBWH8spQLwbuh2niE6NMPzTvLl+7N7W/SI9Ty+y0AHoZKIxBLIb4xP9JDCYyfj/sbzAakeQDrQRYset/xIiii0k9fUsHsAfccqqxdRqn/Tr99Ou/Lk90njme1kOFAXZzECm0Dcgl1T7NqIV5hDfkRbpo3z7JMi5fuU/enGFdvCQ+/KcApOdaV11+tqjUTmc1l2LZBAUoArpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10088.eurprd04.prod.outlook.com (2603:10a6:102:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 22:23:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 22:23:00 +0000
Date: Fri, 31 Jan 2025 17:22:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <Z51NOg24I/zsHz9Z@lizhi-Precision-Tower-5810>
References: <20241216-imx91tmu-v4-0-75caef7481b8@nxp.com>
 <20241216-imx91tmu-v4-2-75caef7481b8@nxp.com>
 <b69fe059-5aff-4fbd-879e-166d67310563@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b69fe059-5aff-4fbd-879e-166d67310563@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10088:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c91779a-49e8-40f5-24c9-08dd4245d252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bit0OTM2eDdDcGNZeW1JQTVJMjB4VURtQlVRZGN3eXJjWmhLS2duVVl2c3hW?=
 =?utf-8?B?M3J1ZU9zL0tCREp6dElJY3NDdks0OVJmTklvQXRTanptVDBTK3pycVdBVUpR?=
 =?utf-8?B?UjZpbXR3WHFObkFJZWxJY2xSZU4xdVAwRWZPNEpRUkk2ZlpVQ2x5dDl5SjdS?=
 =?utf-8?B?M2ljMnBqVGlRQ3NQSVpBMTdUWlUrTTROTmdVc0ZlWkdxU1ArTVc1dXVIa1FN?=
 =?utf-8?B?blR4ekN1bkNnSmxZTXdXVjM5cFV5VEloOFFLd3pBYkFlL3FGTUVBeXBHc253?=
 =?utf-8?B?R2NpRnRmS1o1QmNDRTlOY0s4dXplNWtrMTFuVmdnTEw3akJvN0w4OHJtdTNk?=
 =?utf-8?B?SXlYSnJDanJYTTUrVHdoZjFqRUZpV0JOR1hkRkRTOVpjcnlSUHY5YmhReVBC?=
 =?utf-8?B?b2pMTi9HYlBGLzI4bFhrNHUvbS9CTjJTSStCNWRrbzZOZVNnc2RTTnMrM2Iw?=
 =?utf-8?B?OE1IZ0x0QnV0eXRPQmt0SlNVbWlVUzJoRTZMUVhtUFI0UUxoWVl3U1hnb1c3?=
 =?utf-8?B?Vm9Oc2pvdVdNbEpDU3VtZjNHTGNzZEI5cVNaS2YzRDVTQWdLQnIwZGp2c2V1?=
 =?utf-8?B?a3lPWmRHcWJuVEdQSUhuMGpwUGVja1MwWW5oanhsRVR3MDFJa3FxRUtOUGFj?=
 =?utf-8?B?OHdYb2pvMVpkYWRJZXdRRjRZUnFOdTIwSTNBWDBYWS9uS3BGcVV1YVZsRm9p?=
 =?utf-8?B?c2NrbUplejMzL0lkL3RKNkpNWkg1RWc5YUdTbEl2UzJ4ZEFLWi9zNW1EWjY5?=
 =?utf-8?B?YWhjTmY3eUhBTzZ2QWxBNFpzRjdEWENvSTQ4WmEyVkJGamRPWGtYVU9mK3hO?=
 =?utf-8?B?QjZyelJXQTBoZmhyUzNHSTB3Ti8wbEY3U1g5elRqcnVUWSs4YmlhdHk5MUUv?=
 =?utf-8?B?ZFRKVkZtVnY1VEV0QnZQRHlaV0d6bFNtN2hLK3BUUVd6Qno1WGJraG9HUXVD?=
 =?utf-8?B?Vjl3WnNYRjRsQ1NjSmhDS3MzYVNLWkNNUjlZZXpnNSt2bWFJNXRkMTJUR1Ux?=
 =?utf-8?B?Y21KcElVT0Zvb0Y0bjRCc2kwbG5Ea3QvaS9WRUY1T2w1cnR4Sis4SVNIa2FP?=
 =?utf-8?B?K1lpVnh3VTYwQTNoSnh1bkRHZXZUeGJUUlkxUWhvWk9UanlXaFI5OHAzeUU3?=
 =?utf-8?B?dE9WcEdsK1ZqTDljYkVDTmlqckUvREVMZTRML3d4dHhMdThZTEtTeFdOdEFx?=
 =?utf-8?B?WmVUTHU4S3NiVmJHQldYZzVxbDBRdzk1Q2JYMTZzbWtuNUFIemg0aktJNjda?=
 =?utf-8?B?QytVWjlYVkNyRUFYbWx1ZTYyMTJjaWV2M0hyZldkVTdhczIxRk5ablJRcktx?=
 =?utf-8?B?MkJwN1p0TDd4dmhncWtmKzFERnMyNHZnWU1DVEU0b2xRUWlCTnlBcjk5UXpx?=
 =?utf-8?B?RlFnNkM3ZGFEdVJza0ZRM2hrQ2trK1JZb2VBZHg5N0d6M05BQ1p0VDYvSmo2?=
 =?utf-8?B?Zkc4MER2NDU4SFYyeU1Edlk0WmtNMWlqR21vamRDRjV3M3lhL09vVi9TL0o0?=
 =?utf-8?B?eUFIR2VGYjdPSXVhS3ZFeWNUcGFRZzFQSkJBUGJ4UFlheGRGZi95SE5FODdH?=
 =?utf-8?B?bGVod05tb2NTZ3QvS2l2NFZYaks1VWFTcytYem11R3VTcDk0U3dheVpLbG1D?=
 =?utf-8?B?MWNrMDJWQ0ZEU2srUjVDRHgvQllBWUNjVW5jT0JybXpQY2krVWRscDZ6TXND?=
 =?utf-8?B?dmZDNU5XaGpYUXRjZG1YNC9pVjJZMFRpZ3Q1YzZTQzRqYW8yQ0FuREpBT1I0?=
 =?utf-8?B?VldGc0o0K0h0cG1oNVNsSEc3eHp2OWwvb2huSjMvcG9GRFZBc256c0NrZjkz?=
 =?utf-8?B?aTE2YWh1aGZWYVp4ekhjQUFOQmxsMHhyeHF1c0FleDJRSEd1V3p2UGFHQmZF?=
 =?utf-8?B?MC8zYUxQamdQN0NYNkloMDFVZkdUSE5pb2t0V3hIZTMrNHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG53Nmc2WGIzM0lLaHlVTzlDNVo4UGhTck1UNGRXUnN4OGs4eENVaE1DcTR2?=
 =?utf-8?B?OU9oRUhkcDFlQW1lNlEweDVCeExYZ2RqR3ZFSkJPeEF6MkFuazlwZkQwR3ZZ?=
 =?utf-8?B?YXRoWnBFZGxhNWxiNWxCTSt2aXV3Qkl4cEIxekFSV3BBczJYOHRoRnJ5NjJT?=
 =?utf-8?B?MC9wZGRTU3JHQmtTRi9EaUpDZDgrV3Izcmg5a0grVFk1QjVFV0NaVGxORDJD?=
 =?utf-8?B?UWRjbENGSm12ZVgwNWsrWU9tVkE5RWV2d0F6R29iSUN5WjRVY0VEZ1RUT2k1?=
 =?utf-8?B?VHhyZ3ZrS0g2bU40cVlhU0t2T3NNY2ZCUjJDbjJSZjRkUlpuV2REc2dCNmhN?=
 =?utf-8?B?MWhSeFhITWovdzRxUVE1SXhlNWZGVWRQY1VUN2RuVXBZaG9wdnl2MUdyU2Nn?=
 =?utf-8?B?cW0zREZWRnNxY0xEUEM1bC9rM1FxVDRMWjZzazduTngrMmhKVktTMk9MOFdL?=
 =?utf-8?B?Vi9STHM0QytEY2JiTmI1TnAzQXh4elNPOCtIQi8yQWdVc01vSUJ1Qm13Y1hm?=
 =?utf-8?B?NE1TRzJXTW9pVUpUTEtGdEtTcmduMVNlOWJpVkVPU1lBRHBuR2NSc1pTTzBB?=
 =?utf-8?B?cHk2WGU5WE4zZ01KTlk1SnZuREhnOFVTZ09lRVFlWk9majlRZnZyS1NHMU1B?=
 =?utf-8?B?TE9mUVhzTUdJVGxLVG91ZFZsMFpVaUxlYXdrSm1RQk5QcVBoQXpvKy9jQ2to?=
 =?utf-8?B?VXNGRXE1b1BBbUp2NlNmR2tWUzFEU2J6Q0FlRjJ2cnZVcWthbWFJeTQ0ZFUz?=
 =?utf-8?B?c3dDWSswTDhsWWdKcll2dHhsWmFvWWwySzhrWFdManIyVXpqOUhzTFptWkVT?=
 =?utf-8?B?N294c0RrKzNJbEZFTUovS2w0V0xkcEo1MUttMVVnUVRHaVR5c0U5U2NCanli?=
 =?utf-8?B?alZQeFd1TUhXMzY5WVhBczNLbFRaTEZMNDdHL3UxdHdlQndmbkFGMmVtNTQy?=
 =?utf-8?B?Nk5Ma1g0ZXNoNG5abndPZVozOFZwdmxtVWRtdGFhRVUrMWduelJOaXJGbEdD?=
 =?utf-8?B?aDNlOUlQQ0JSemtTL0Mxa1FtM3JUWjNxbHpHUC9KNENNTjlaV0dkWUZCaCtW?=
 =?utf-8?B?TWdVRVlYWXhudVNSRGJPRTNuVHJwbnZzQkR0dCtmaURpT3pPd2RCbGVBcys4?=
 =?utf-8?B?c0NLTmhRaE0xWGlSeHJqNWxvSE1kZkUrNmI4TDBCMlpiM2VkM3NoY0d6bzFa?=
 =?utf-8?B?Vnh5UTZxUEFBWU5vQ1V6UkNZNGFXWjJRUHhvaUZicHJWQjZaM28wbDZRcUJN?=
 =?utf-8?B?TWdkWjlVdjNZNldjdUxXS0R2MWlLNE5pSERlVTh2UTFHWkZkMGVwWFJaNGlp?=
 =?utf-8?B?dVQ5MzcvUk1YWVZPYnVxakxkQnREN1d6aVozNTZIblJKR2tZb3ZTcVZRemZX?=
 =?utf-8?B?YnJvazhaL01icVd2YUl2dWNwcjhBOGVCK2g2TGtQTHo5b1gvU3g0dXJOZ1RZ?=
 =?utf-8?B?V3BQVXozOFUxN3dCb09WMjFxRmhvVGVQK25DajNET25EZmJGQWpxVktsRXNp?=
 =?utf-8?B?KzBxK2JZRlRvVmVZUHU3RVpPUE52c0N0OTI5bnVkbWs4YW9RM2NvZDBCY1M1?=
 =?utf-8?B?MFUxK2toRTRRUFJmWFlmZEg2NEFSSDJpZkJGb2N4bEQ3czUxZGRLM0pHb1or?=
 =?utf-8?B?Z1JLeFJ2eHVZQTNqZmhUa0h1aC9Eam8yaDczNEFyUFYyVjRKL0ZrOVFPV2cw?=
 =?utf-8?B?WlN5TTRlTmFIakpaUW9JcWhPdWZCUmJaNXJ3Y3BQL2ptM0N0U0lVVU5rVVIy?=
 =?utf-8?B?Q3AydE9JVGtFVXNtVHBoaWNyNDZiOXpHczcrWXBXRlJ1NmRva1oxaGc0L1VM?=
 =?utf-8?B?N1VQL1JyZWJTSWs1eFhDa0kyZDhwUElRYnI5WjlUcFlGQWdmdExGK3FvVUto?=
 =?utf-8?B?L3NmWDFDajFmRDE1K1pxc0ZDa2dVOE9hVDdDcjBLTmExYjJPQlEvRjBzS1c1?=
 =?utf-8?B?R2dyNXFpK3NIQ05uTytRU2dKbHZXaGlTWnEwZ1dXc1dXMjRGeTRMcDN6MEUw?=
 =?utf-8?B?VklGMVd0eG9FbENxOXNhdHpMM054TlN0MGVnaUtNVXpiaUNWZ3FlZWxUUkJM?=
 =?utf-8?B?a2RqVDZhUUl3QnBNeU1wVmpMRlRVM3FWR3lCNWU5NkV4VkJBaGcxZzdicHR6?=
 =?utf-8?Q?Z2v6DVSzr2M6MjwU+5Ypz/+po?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c91779a-49e8-40f5-24c9-08dd4245d252
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 22:23:00.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNnpbyAdjJY65sgHYSOtJw8pGNhmVr8lN6pU7MPfMODdL5/Y0b8N+/qL8ajk7+YfRlfemLw7uC4TJN5jgvJ+GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10088

On Fri, Jan 31, 2025 at 11:19:54AM +0100, Daniel Lezcano wrote:
> On 16/12/2024 20:25, Frank Li wrote:
> > From: Pengfei Li <pengfei.li_1@nxp.com>
> >
> > Introduce support for the i.MX91 thermal monitoring unit, which features a
> > single sensor for the CPU. The register layout differs from other chips,
> > necessitating the creation of a dedicated file for this.
>
> Please a bit more information about the sensor (eg. resolution, I guess 1°C)

How about add

"This sensor provides a resolution of 1/64°C (6-bit fraction). For actual
accuracy, refer to the datasheet, as it varies depending on the chip grade."

> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v3 to v4
> > - Add Macro's review tag
> > - Use devm_add_action()
> > - Move pm_runtim_put before thermal_of_zone_register()
> >
> > change from v2 to v3
> > - add IMX91_TMU_ prefix for register define
> > - remove unused register define
> > - fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
> > - use dev variable in probe function
> > - use pm_runtime_set_active() in probe
> > - move START to imx91_tmu_get_temp()
> > - use DEFINE_RUNTIME_DEV_PM_OPS()
> > - keep set reset value because there are not sw "reset" bit in controller,
> > uboot may change and enable tmu.
> >
> > change from v1 to v2
> > - use low case for hexvalue
> > - combine struct imx91_tmu and tmu_sensor
> > - simplify imx91_tmu_start() and imx91_tmu_enable()
> > - use s16 for imx91_tmu_get_temp(), which may negative value
> > - use reverse christmas tree style
> > - use run time pm
> > - use oneshot to sample temp
> > - register thermal zone after hardware init
> > ---
> >   drivers/thermal/Kconfig         |  10 ++
> >   drivers/thermal/Makefile        |   1 +
> >   drivers/thermal/imx91_thermal.c | 263 ++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 274 insertions(+)
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index d3f9686e26e71..da403ed86aeb1 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -296,6 +296,16 @@ config IMX8MM_THERMAL
> >   	  cpufreq is used as the cooling device to throttle CPUs when the passive
> >   	  trip is crossed.
> > +config IMX91_THERMAL
> > +	tristate "Temperature sensor driver for NXP i.MX91 SoC"
> > +	depends on ARCH_MXC || COMPILE_TEST
> > +	depends on OF
>
> s/OF/THERMAL_OF/
>
> > +	help
> > +	  Support for Temperature sensor found on NXP i.MX91 SoC.
> > +	  It supports one critical trip point and one passive trip point. The
> > +	  cpufreq is used as the cooling device to throttle CPUs when the passive
> > +	  trip is crossed.
>
> This help message is inaccurate. It should describe the sensor not the
> thermal configuration which is coming from the device tree for a specific
> platform.

How about

It includes one sensor and six comparators. Each of them compares the
temperature value (from the sensor) against the programmable threshold
values. Support program the direction of comparison (greater than or
less than).
>
> >   config K3_THERMAL
> >   	tristate "Texas Instruments K3 thermal support"
> >   	depends on ARCH_K3 || COMPILE_TEST
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 9abf43a74f2bb..08da241e6a598 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
> >   obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> >   obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
> >   obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
> > +obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
> >   obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
> >   obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
> >   obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> > diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> > new file mode 100644
> > index 0000000000000..ef5e8e181dd0f
> > --- /dev/null
> > +++ b/drivers/thermal/imx91_thermal.c
> > @@ -0,0 +1,263 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2024 NXP.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/thermal.h>
> > +
> > +#define IMX91_TMU_STAT0				0x10
> > +#define IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
> > +
> > +#define IMX91_TMU_DATA0				0x20
> > +
> > +#define IMX91_TMU_CTRL1_SET			0x204
> > +#define IMX91_TMU_CTRL1_CLR			0x208
> > +#define IMX91_TMU_CTRL1_EN			BIT(31)
> > +#define IMX91_TMU_CTRL1_START			BIT(30)
> > +#define IMX91_TMU_CTRL1_STOP			BIT(29)
> > +#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
> > +#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
> > +#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
> > +#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
> > +#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
> > +
> > +#define IMX91_TMU_REF_DIV			0x280
> > +#define IMX91_TMU_DIV_EN			BIT(31)
> > +#define IMX91_TMU_DIV_MASK			GENMASK(23, 16)
> > +#define IMX91_TMU_DIV_MAX			255
> > +
> > +#define IMX91_TMU_PUD_ST_CTRL			0x2b0
> > +#define IMX91_TMU_PUDL_MASK			GENMASK(23, 16)
> > +
> > +#define IMX91_TMU_TRIM1				0x2e0
> > +#define IMX91_TMU_TRIM2				0x2f0
> > +
> > +#define IMX91_TMU_TEMP_LOW_LIMIT		-40000
> > +#define IMX91_TMU_TEMP_HIGH_LIMIT		125000
> > +
> > +#define IMX91_TMU_DEFAULT_TRIM1_CONFIG		0xb561bc2d
> > +#define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
> > +
> > +struct imx91_tmu {
> > +	void __iomem *base;
> > +	struct clk *clk;
> > +	struct device *dev;
> > +	struct thermal_zone_device *tzd;
>
> This field is pointless because used only in the probe function.
>
> > +};
> > +
> > +static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
> > +{
> > +	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
> > +
> > +	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1_SET);
> > +}
> > +
> > +static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
> > +{
> > +	u32 reg = enable ? IMX91_TMU_CTRL1_SET : IMX91_TMU_CTRL1_CLR;
> > +
> > +	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
> > +}
> > +
> > +static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
> > +{
> > +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> > +	s16 data;
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret = pm_runtime_resume_and_get(tmu->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	imx91_tmu_start(tmu, true);
>
> Same question as [1]
>
> Do you really want to start and stop the sensor between two reads ?

This version use simple oneshot mode. So need call start every time.

>
> > +	ret = readl_relaxed_poll_timeout(tmu->base + IMX91_TMU_STAT0, val,
> > +					 val & IMX91_TMU_STAT0_DRDY0_IF_MASK, 1000, 40000);
> > +	if (ret) {
> > +		ret = -EAGAIN;
> > +		goto out;
> > +	}
> > +
> > +	/* DATA0 is 16bit signed number */
> > +	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
> > +	*temp = data * 1000 / 64;
>
> cf units.h
>
> 	*temp = (data * MILLIDEGREE_PER_DEGREE) / A_LITERAL;
>
> > +	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
> > +		ret = -EAGAIN;
> > +
> > +out:
> > +	pm_runtime_put(tmu->dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static struct thermal_zone_device_ops tmu_tz_ops = {
> > +	.get_temp = imx91_tmu_get_temp,
>
> Why not add the change_mode ops ?

I plan add later when add .set_trip_temp and irq support.

Frank
>
> > +};
> > +
> > +static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
> > +{
> > +	struct device *dev = tmu->dev;
> > +	u32 trim1, trim2;
> > +	int ret;
> > +
> > +	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (trim1 == 0 || trim2 == 0)
> > +		return -EINVAL;
> > +
> > +	writel_relaxed(trim1, tmu->base + IMX91_TMU_TRIM1);
> > +	writel_relaxed(trim2, tmu->base + IMX91_TMU_TRIM2);
> > +
> > +	return 0;
> > +}
> > +
> > +static void imx91_tmu_action_remove(void *data)
> > +{
> > +	struct imx91_tmu *tmu = data;
> > +
> > +	/* disable tmu */
> > +	imx91_tmu_enable(tmu, false);
> > +}
> > +
> > +static int imx91_tmu_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct imx91_tmu *tmu;
> > +	unsigned long rate;
> > +	u32 div;
> > +	int ret;
> > +
> > +	tmu = devm_kzalloc(dev, sizeof(struct imx91_tmu), GFP_KERNEL);
> > +	if (!tmu)
> > +		return -ENOMEM;
> > +
> > +	tmu->dev = dev;
> > +
> > +	tmu->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(tmu->base))
> > +		return dev_err_probe(dev, PTR_ERR(tmu->base), "failed to get io resource");
> > +
> > +	tmu->clk = devm_clk_get_enabled(dev, NULL);
> > +	if (IS_ERR(tmu->clk))
> > +		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
> > +
> > +	platform_set_drvdata(pdev, tmu);
> > +
> > +	/* disable the monitor during initialization */
> > +	imx91_tmu_enable(tmu, false);
> > +	imx91_tmu_start(tmu, false);
> > +
> > +	ret = imx91_init_from_nvmem_cells(tmu);
> > +	if (ret) {
> > +		writel_relaxed(IMX91_TMU_DEFAULT_TRIM1_CONFIG, tmu->base + IMX91_TMU_TRIM1);
> > +		writel_relaxed(IMX91_TMU_DEFAULT_TRIM2_CONFIG, tmu->base + IMX91_TMU_TRIM2);
> > +	}
> > +
> > +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
> > +	rate = clk_get_rate(tmu->clk);
> > +	div = (rate / 4000000) - 1;
>
> Use literals please (eg. 4 * HZ_PER_MHZ)
>
> > +	if (div > IMX91_TMU_DIV_MAX)
> > +		return dev_err_probe(dev, -EINVAL, "clock divider exceed hardware limitation");
> > +
> > +	/* Set divider value and enable divider */
> > +	writel_relaxed(IMX91_TMU_DIV_EN | FIELD_PREP(IMX91_TMU_DIV_MASK, div),
> > +		       tmu->base + IMX91_TMU_REF_DIV);
> > +
> > +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
> > +	writel_relaxed(FIELD_PREP(IMX91_TMU_PUDL_MASK, 100U), tmu->base + IMX91_TMU_PUD_ST_CTRL);
> > +
> > +	/*
> > +	 * Set resolution mode
> > +	 * 00b - Conversion time = 0.59325 ms
> > +	 * 01b - Conversion time = 1.10525 ms
> > +	 * 10b - Conversion time = 2.12925 ms
> > +	 * 11b - Conversion time = 4.17725 ms
> > +	 */
> > +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x3), tmu->base + IMX91_TMU_CTRL1_CLR);
> > +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x1), tmu->base + IMX91_TMU_CTRL1_SET);
> > +
> > +	writel_relaxed(IMX91_TMU_CTRL1_MEAS_MODE_MASK, tmu->base + IMX91_TMU_CTRL1_CLR);
> > +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_MEAS_MODE_MASK, IMX91_TMU_CTRL1_MEAS_MODE_SINGLE),
> > +		       tmu->base + IMX91_TMU_CTRL1_SET);
> > +
> > +	pm_runtime_set_active(dev);
> > +	devm_pm_runtime_enable(dev);
> > +	pm_runtime_put(dev);
> > +
> > +	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
> > +	if (IS_ERR(tmu->tzd))
> > +		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
> > +				     "failed to register thermal zone sensor\n");
> > +
> > +	ret = devm_add_action(dev, imx91_tmu_action_remove, tmu);
>
> Should it be moved before devm_thermal_of_zone_register(), so if the thermal
> zone creation fails, it will stop the sensor which was previously started ?

pm_runtime_put already disable sensor before call
devm_thermal_of_zone_register().

imx91_tmu_get_temp() will call runtime_get when devm_thermal_of_zone_register()
call to it.

Frank

>
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failure to add action imx91_tmu_action_remove()\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx91_tmu_runtime_suspend(struct device *dev)
> > +{
> > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > +
> > +	/* disable tmu */
> > +	imx91_tmu_enable(tmu, false);
> > +
> > +	clk_disable_unprepare(tmu->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx91_tmu_runtime_resume(struct device *dev)
> > +{
> > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(tmu->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	imx91_tmu_enable(tmu, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(imx91_tmu_pm_ops, imx91_tmu_runtime_suspend,
> > +				 imx91_tmu_runtime_resume, NULL);
> > +
> > +static const struct of_device_id imx91_tmu_table[] = {
> > +	{ .compatible = "fsl,imx91-tmu", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, imx91_tmu_table);
> > +
> > +static struct platform_driver imx91_tmu = {
> > +	.driver = {
> > +		.name	= "imx91_thermal",
> > +		.pm	= pm_ptr(&imx91_tmu_pm_ops),
> > +		.of_match_table = imx91_tmu_table,
> > +	},
> > +	.probe = imx91_tmu_probe,
> > +};
> > +module_platform_driver(imx91_tmu);
> > +
> > +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> > +MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
> > +MODULE_LICENSE("GPL");
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

