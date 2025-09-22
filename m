Return-Path: <linux-pm+bounces-35135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30423B8EC03
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DA717A095
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4944B2F39B8;
	Mon, 22 Sep 2025 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g+5KmKE8"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013042.outbound.protection.outlook.com [52.101.72.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC02F3606;
	Mon, 22 Sep 2025 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507299; cv=fail; b=ZAr2idorgogxejmgDp/gC5TCef6+yhPuZRSB8zXZNqSGsieUoYnFZPkbzMdaCQEvXDY0gV302W2d0dz/5QCfVtrev/sERji5qlBfEmJuX/8jN20GI+db8Uvbfw5SytzSnxn6xAyWHxTP2CWoR8RUSIy82FI+vZcFQN5ZD0p/JFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507299; c=relaxed/simple;
	bh=W8vS5ztSi/wBpkyb7zcOiyH/FeijQe8uyYrrzpMzHHo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AVA+q43aTVpwgKsyEb3mVUaawhH/g+sX5w/W04XBVOAgWA47jaxnloLX425Hb1AVKm9U6soRC3BgiCFjGkncOGLEcFTL6PN39VOzu18lpYZjHtfLr+S1uFiI7+PPbMSQ1Usaaz2GXyYqLOsE74mjo5chsAw+Do4OKtVbp3IM188=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g+5KmKE8; arc=fail smtp.client-ip=52.101.72.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cjj43NjG9Ij3mhiGyNIfxK4VodB1eCaPyGvyvpXd1PN/lY5ajZo3CFBXH2j1njmCSow4T3HkRw9edFTDZOwLj5yTk4/EWdA9z1s67Ta75A1k3OAJDGr95xJmwM8lvMtFt1dHVNKXA6d93d5/aTXRkkElBwKOThhwceuY/bA8td8VezNk4d74GjVtCK6+OHLyAVveIE+oFng9gnYPVB37j1jPwFte7JCawFfuUdRzgpyHR4g6zTJoipNO4ZGv/motvoQfifNSnSZrfaYGlq/ypU9CDVskPfCzx18Nc/nNYtM1vyth3q/gm2mNToOKhKDXw9UlgPBVGADAKKY5lXo1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSV3r8U6YyZFM08LSXwgY6kuTfLIWft7C0+iawqKPvg=;
 b=pAZbNQ2OyrrVOqPGJxXrw6Qx6T83zkurYw97kiIK7b5POVYKx2VxeP4GasBNBQlaiueUMrtwLQ7Gv0H8me0BLYAZWfcn3HUwNWjWqu+HiXA98NaEtNXzNHq0v2e7qS4yVNOVZIOqmMAw+hkZ4hzKvL8A76eYiuPtXd2MIozrMsWoK9xjySkceK+M5cQv0tDuzieiaqIro7csfcXYnKTzHGxi0VRtcAW0pcmIMoe+KGGnv47ATxpkaDdPkW1AKsAVjIQ6buYCSL5Vm5rg0m0cW+GCE4WXXarLdA73wtj77Psw58tVj4VU1m6bE70EWyDAU+di3WP10Ra1JRJotYgpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSV3r8U6YyZFM08LSXwgY6kuTfLIWft7C0+iawqKPvg=;
 b=g+5KmKE8cSJEd6l9poi/TiLhdn2XX2OPzx0Roi7K4Fk3B6JdEL2A/TVAbq+03La94oqWONlDvxUCeGOZOCrmmaIDBGZBKOSTEmwYTJuMfWQSxq64PuS862x2E+jwBdYv1wlLB2zueXzFVCeA+5nMnRnOVEWlZuo6jck8luWnkM2CwTBoqYdiZv5tp6GE4K+GCmcxBQ5prh1VnHP4Rs1IO1qu5tXRv+Ii2kdoY75UrbtB3qP6ODvAwyIHTQEfewQi8+Zq8pDha0fO1LwcXi+CN4OVKRf3x5d98If47ID21EA/Cew+FznM064lzNg1N21O2XBiVnh5WgVGNFUBL7yepg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:14:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:14:55 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 22 Sep 2025 10:14:13 +0800
Subject: [PATCH 5/5] usb: dwc3: imx8mp: Set out of band wakeup for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pm-v4-v1-5-7ed2e98065ad@nxp.com>
References: <20250922-pm-v4-v1-0-7ed2e98065ad@nxp.com>
In-Reply-To: <20250922-pm-v4-v1-0-7ed2e98065ad@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507262; l=1409;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=W8vS5ztSi/wBpkyb7zcOiyH/FeijQe8uyYrrzpMzHHo=;
 b=FLBVz9XXT+WDDfdiknCr5WTNUDiZ7OIQs5437j9fC0IL4meRvQz0dHO0N7m8qAfCMGKIjabH5
 Eayl4Lf50k/DSqXruLU3Ee1ggiAhg9ZQDXgzWoWU0DxauQYMoAdArrs
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6ebb11-def4-4eb6-fbf8-08ddf97dd23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmJ2Sm0yaFpINENmV3RFSkVPSS9oeTNLUVlDNER5VVB1UVFkNkZsNHFIUlBC?=
 =?utf-8?B?QzhVdGgwTE1Yb0hQYlFCVEU2U2dUUHF0M0Q0WWMzZlJFSzh2U1B2cXY2aTBU?=
 =?utf-8?B?dlZ6K2hSb1FtakY0VXZYcE1BWkVUYnQrNzRyK2xPbU54c3J1ODMwMExTTkZh?=
 =?utf-8?B?WDVsUlArNDBLdkNSVC9BcTJaUGY0WEpGV0tWeERRSkpXR1JMRHZwWjlFM2FX?=
 =?utf-8?B?NkxLYjREV3RCZlcxTVZQM3ByU0JYeHpPZ3lCNXZPRHNNWTF1WDlRVlZuN3FU?=
 =?utf-8?B?NTV4azd1UUFLbzkwVGdQQzZSTVd5a0J5c25FNFFIcnVrUFgrR2JtZWF4NVRJ?=
 =?utf-8?B?RXBtZ3M2cmVpVkJtU2lIS0xiNUgzTzRXVlVTdlJtclliNzQvaTcrWXdjVHBK?=
 =?utf-8?B?NHZzT2c5b0puWXNZK1d5NTI1cXFQMjEvemFpWWpuL0VhdkZzaUllMEtab0hs?=
 =?utf-8?B?ZUQ1ZXQ2ZG5jK2NFb3R3TDlLYjVKRy9OWFc5QWNmZytwWGE2QVpFTm41RW5r?=
 =?utf-8?B?WTR6Q0NxNWFnU0xPci9uNTlGMmxnQmVMV3NUdXhsVFUrSktJOTN4SytNVUYw?=
 =?utf-8?B?TVE0aVBzSVl6MHF3NTZrMWNSVEdBcGRhcTREZE9NL1Y4Z2JJYTM1d1pKYWlN?=
 =?utf-8?B?WmhmWExtZ3lna2FIZGk3OXFjS0lFWE9iMGFQSkRGZE1jNW5LUW15ZzJsSWhR?=
 =?utf-8?B?L1Q3TjVqTUxtQlpRL0N4Nzk1U3pZMXpHL21YS0J1VHhTV0d0VDJYb3FZR0hC?=
 =?utf-8?B?cjdNSzd1QndNRng3UU1JVzNTemt5NmptTGRORGsyN2JMWmpOcEh0akYxazdY?=
 =?utf-8?B?VVFuT09HdUxzV2JWY0dDZEZJaTBkT0FoMWlib3F6cnVNQlVZTUsxeW56TGx0?=
 =?utf-8?B?T0k4dmpwNE51dmJZUmZTVDJiM0pNdUxickdPNVFRWDJjclJZSE9XMzZsYUdS?=
 =?utf-8?B?cWdUZ09oY1JsdDRyaDlMc3E1Y1c5eFA3UURiWDM2OC9sdzlpL1BEME9qdUFK?=
 =?utf-8?B?c0p2Ni9tVCtwSGZpbFlJbWl1NExTOHE2TXExYklLeFV0WWJxVXpIZGcwd2x3?=
 =?utf-8?B?YWU1ZXR3L0xOZWIrMk5DSVNyWE04VTdVVDdlb0RwV1RpVDlEOHJRRjIybVAy?=
 =?utf-8?B?cm1zTmZjL3Q0YzhVczgzZldUdnRjMXNHVU1DeFcrNGJrY0tpVjlEVkJ6ZSto?=
 =?utf-8?B?NlhNR3lDN1F0czBZU2lPbXRiMVZibGZ0WnJNdFNCVXZhWW40d3k2NHZIVGVZ?=
 =?utf-8?B?L1dNSDJ5cjlyRDZibDIxdkM2REdoM3VJRzlaMmhDcWkrQVBRbHhGY2FRL3NG?=
 =?utf-8?B?T1c3TnRwRWJodnNIYmVSSVllNDl2cEQwZHhKUG01QWV2ZTV2cnk0VkU5L0ds?=
 =?utf-8?B?SlRHWmRwUm9JQUpTNzUzMXM1WnYwU01ucVFUOVhJNEovRHRYaTMzTkNYWWJN?=
 =?utf-8?B?ZGg4Mm5RSGRrVFJudytNL0FRWUovcG90QUcwWGdubG5EOGtWUHBPZHJ3aVU1?=
 =?utf-8?B?Yy9Wb1BCdGhaTW5adXlkaHBWemlRNHd4UXFCa3NQeTAzRTA4cHVhSUlYRU5a?=
 =?utf-8?B?c1Qya0hLMU5ESm1mSVF0bFJZQmNxK00rWUhwMU5zNnkzVFBGTGRVVy80Kzda?=
 =?utf-8?B?VlJESUJQQmlvMnNGQnByVERubWdIUmdzYy9jT1d6d1dqTHNuR201MFkxNTM0?=
 =?utf-8?B?YmpHSkFqK0h4cXFBdkdZL3FLV3RRMnZWRHpQVzlaNjUyQTZzSmF1Ym12L01G?=
 =?utf-8?B?VXl3bTI2eXpFZEVyOGtqUTN5Z1plM29MeGRERnFOVmNhN1lHQmN6bkVkbjkv?=
 =?utf-8?B?Nkd4bXphejNTNk1sQXIvNXBKaDRiTHNGUHlOSE5ZT2tENi9zSzBKRFJMMzZX?=
 =?utf-8?B?U3Rxazh0SnUreG50U1huS0pkYkViV1BhWHVvQnBrajBCWU5ydnRwOUUyTFE3?=
 =?utf-8?B?RFMrb2pxTFVtNnh1dXRMTERxbis3YUtxUjE1ZE9BOGhsREh5aC9jL2ZmZVda?=
 =?utf-8?Q?JaeDl1Fm1oHlMPFIEuvVmXRf9RT8yI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm1nemlDa0NrMm84YzhiakoxNmxZc0hUVXNsL3lTZmgwTVgzcmdZMVpWN0VH?=
 =?utf-8?B?K2ZhclhtV094ODM1eHZONUN1aG5qd2E0aGptdDN6RmhON2NqYmV4MU0vdTcy?=
 =?utf-8?B?eUxoSFdwbnhrMDcwMWsxSy9BVmdMT2x0MmdvZ0U5bzNYaUFXcldTL1VKYkI3?=
 =?utf-8?B?Ty9BUE9tQ3prb1pzNXBIWFU5YnZCSGs5R3dRK2VlTjZ5eXRjTHRZeXF4NDBu?=
 =?utf-8?B?UnVNcFBJdjJvdXVEZjR3YnV0eW5MVjlla3FCdXlVYUFEZndVRk5Mc09zaG1W?=
 =?utf-8?B?QVZwTEdIVHFMQ0tjeEhBSGkwWGx2czJSSGpoTzZraW5tenMvSHZkS2x2bmZH?=
 =?utf-8?B?d2NSNUxaeDQzYUZ5Q3ZBem9FTlF6RjRmTk1Id3Z0SFp3V2JhQVRiL21DVFky?=
 =?utf-8?B?blRqdHgyckNaYllUcnJMWHFNOXRkUGx2YlYvTThLM3Vqc29CS24xQS9sUXBr?=
 =?utf-8?B?aFVRQmVFcE9xUlFFc3Z3WG9rY3p5cUNhenJNZzgyY3VldzlkUTNmdnNyU1Uw?=
 =?utf-8?B?ZzBMS2xIVld3ak94M29BdGxGS3RuTjRTNnNQTGdOMGRRRE1kTDBrZGpkUmls?=
 =?utf-8?B?R1pzNk9CQzZmQWU2cXJ6SVIzMEdMSjBza0pEZFlQSDJHRWQ4R1lrRlJyZXRo?=
 =?utf-8?B?SU0zWEx6N1RkcDRjWU1mTzhEU3FRZXZ3bjRmbWNQUXRiZlRHVnpueEY4L1Jh?=
 =?utf-8?B?V3pRZU9HbS9CVHJtUWNQZHFYVnFFR0hGSCthYlJmYWFRTTNUL3o2cGVCc2Vp?=
 =?utf-8?B?eTd0VHUxQU9iNHpOTlpmUUg5bm9RSXViWkJHQjNXaVl4TEVRR0VGaXYzbExF?=
 =?utf-8?B?VFBpVFV0ODNBcmE1TndlcEJCeVA3T3g4TjRZbHp5RjA2WCtkZVJKdW03RTg0?=
 =?utf-8?B?RERYZURJTTkvWUJOS084anc0ejRKaTQrN3d2OWJmTWZZbFBaY2l2VjZlZlBB?=
 =?utf-8?B?K0tpcC9sRVhCUEU4OFdjVCtvRzNLK3RjUlR0WVN5R1B5bnRUa3NOcUxYRVBT?=
 =?utf-8?B?RXRVVWMzR3piS0E3V2hScUdOT3JZdDVaWFNBcldZb1dhUFNpUnNZaTZ1SG1O?=
 =?utf-8?B?OGUzSGZGVUxwc3VvVDFURU85Z0FhY0ZCaC9YL0Z2STlvZVdlUlg3TGtJZERU?=
 =?utf-8?B?OFpPRnVHOTNWMDhoNHJBUFNmcmU2M25GcklvM0NuMWwxbU52Z2t3OTZEZVVZ?=
 =?utf-8?B?aFI2WFNoSmxBMjdvNDV6QzdjZ1U1cDRva2FZUTIvUmwzeU1SQXR0TDBOT0J6?=
 =?utf-8?B?L1VsU2tkWG92ZjB0eTRaOVpsUHh2bElqa3hOZTJ0Z0lhM1VaUnAwVVkrYnNs?=
 =?utf-8?B?RFpRbXNncmpnV3FMM3dmSjhmaTdJcXlDUk1kMEN0Y0JDY0MwNmpzeDhPcDZz?=
 =?utf-8?B?SHcvWEozMi8zY1Y1QVN3Y3YzZ3BNQkRhd3BobktTOWtwTVhMM0pOdHRVdVNq?=
 =?utf-8?B?NzlPMHVGVmxEU0NJYTRTV3Q3K1ZqUzBTSGRDazFscCtyNnVFRGNLSW53ZVQr?=
 =?utf-8?B?VWhoNW4wVVlRRmJ0aUNZTm5hT08wZXJUSWhzQU10OFZscHdGT2xBdjBsNjRr?=
 =?utf-8?B?MVgzcTZodmYvbFlFOWQ2OVl2cTFWbFVBcDVDVGxRZzZPck4wYVBYMWVmZG9p?=
 =?utf-8?B?YkVscGJpTkxnaGhMRlBWRW1TN3IyWjhrb1o3ZGdpWEJBS3c0eHdXLzMxanlC?=
 =?utf-8?B?OUN2ZThlbGpMbVo3RkFpU1ZNR3BmeW4xMEoxTWhYMkNZR2lhb1NMckFlQzYx?=
 =?utf-8?B?Mi85dTJSckdCNGlpOG43NCt1bGNBWGNmYm84ZjlYdXFzUVFDNld0OEZJempL?=
 =?utf-8?B?QUFJdVNVQjdqV21tVnRCdWRjdnhKVkJPVjBZdnNWREp6QzBldVl2OVFmTm9x?=
 =?utf-8?B?T1dqMXp2d3M3aG45QThwOExVVGZjZnhxa3JubkxGa1lFMEdQRDhXd0RNdTcv?=
 =?utf-8?B?cG5OQ21JMjlrVzJ1d0Z5OEdFMkFaUDJUdkZRZjZlWWIyS3A5MDB2c2hKSHhr?=
 =?utf-8?B?Q3NLYXpabFZ6ck8wZWdmZUlmSTA1ZndrRU5sU0l3YU5aRHZGWTROQWRKUkdP?=
 =?utf-8?B?Q2U3MUF6MEplRGF6enpiWE5LVzdIYjNJQzRsYUpXU3VYbFB6ak12ZUVIb1B5?=
 =?utf-8?Q?j2VA+pyx5m9eEw7yimHYMWtbe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6ebb11-def4-4eb6-fbf8-08ddf97dd23a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:14:55.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djzEw8gRhYpOpmHyrBGk6Z4G9e0kC/OUyueK7fEqNTUo0y+I4HlJ8j4dnKRWeKKBjqQgD7f92iJuZ4eJkZtcjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

i.MX95 DWC3 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
power domain(Digital logic) is off. There is still always on logic
have the wakeup capability which is out band wakeup capbility.

So use device_set_out_band_wakeup for i.MX95 to make sure DWC3 could
wakeup system even if HSIOMIX power domain is in off state.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Tested-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index bce6af82f54c24423c1e1fcc46913c8456b6f035..225d59e9c1901c36be1fc18311dace6cdd45de75 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -334,10 +334,15 @@ static int dwc3_imx8mp_pm_suspend(struct device *dev)
 
 	ret = dwc3_imx8mp_suspend(dwc3_imx, PMSG_SUSPEND);
 
-	if (device_may_wakeup(dwc3_imx->dev))
+	if (device_may_wakeup(dwc3_imx->dev)) {
 		enable_irq_wake(dwc3_imx->irq);
-	else
+
+		if (device_is_compatible(dev, "fsl,imx95-dwc3"))
+			device_set_out_band_wakeup(dev);
+
+	} else {
 		clk_disable_unprepare(dwc3_imx->suspend_clk);
+	}
 
 	clk_disable_unprepare(dwc3_imx->hsio_clk);
 	dev_dbg(dev, "dwc3 imx8mp pm suspend.\n");

-- 
2.37.1


