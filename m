Return-Path: <linux-pm+bounces-24898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D198DA7EE84
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A41897EDC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 20:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38990221DA0;
	Mon,  7 Apr 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GZjbT9gv"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013047.outbound.protection.outlook.com [52.101.67.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE72A221D87;
	Mon,  7 Apr 2025 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056360; cv=fail; b=sK2iYWhSCpH8w5U8hPTJK/mK78ykxlmQ87xO6HEu2sRWB1Z14hQ/eEgX14cYQ5rr3HQQnA3FaUHhVMHwl+2BiQAunUFQLSriSetQ9mQ91S90CA/GpQWGtIQuu9q81IT/L+JBNCtX3h6cTLtD4euPCydmcCpd7fqOKHfnmqhH1qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056360; c=relaxed/simple;
	bh=mUzERge0VJoOjiNnZjxUCrzvzrte7OXaiJn1iA3QQso=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Rs+jqUKnNGNTJRyyZYCENMqDTUQqQcszalIBv4X5oVZyq8mc8kNPgUYBfN2nFRbL2a8SUAh2iCl3FndV0fmZMli6AZnQPXBQzXu0OmShNKo7IQPoNavwG+jSXKKM9Advs1TvF0diHqh1Y/VdyMDD1cxOWU8ufKB4O4+hqztaOjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GZjbT9gv; arc=fail smtp.client-ip=52.101.67.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXEJHXzdN0HuefhTBlQYJ1GLux6Ere5w0NiksU1V028FF6TG8s6pczTHspLaQxQb8OpssbckAMBioCEBrhi93+QmHb+D0GVQOLpb+BBpUpxXFaSSgaHbsjCfO5uV+Fai4o1H3SdwP+Mu0aI9g4RbzbbhFgrgX8tSmH3DIedVIs1WL1RVZjNz+zurQE1ejrXLzcxXeANVPMyzneIM7n2XoNTOCS/WEG3w8LMx/vN+O6rPYqZp6d5LRLMgZUdUQYqy/+RZzgdrA3OvlNpouLnL3KC6zzrIfY+S3QreJBOsYJdOWk0D1RxOnriddWAw2rEbEnHgS77Xy4g9lqgLHFvVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y1cMRRBVFRxs4LMwV6zw8aJ0LswAnfpVcvXEC7f0SM=;
 b=SOGvt3+h4A92YlLoU0zc1jx80tlkEK/eo+G7Sbq+EobGRvalHwc/F8qPyMNFx1kOdLkISfNkv9g/y+Ipn6cqR02+s7KJ8UM0I+wqce4a6AY5j03q0uLw/XEDjbGbr5fdoYawFeTRvHE1S2vu7DzdmkRkNN982zsyzJFx5yTgBZgD4DI2Ma+yp5BR5S06x+Vbsspnta4dNZ9cJZo0OdAgEHqxlftdjFctJYT0ZfVVQnFTndr2XuukLyTkWgH/905sJqYRAPyincMHIHiJ8C9d8NNEMkyROXuMZGmOlAym79h9Fgj8L5qTYzJaM8Vv55w1TbCEfj968Yu7oD9tY52e8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y1cMRRBVFRxs4LMwV6zw8aJ0LswAnfpVcvXEC7f0SM=;
 b=GZjbT9gvuA5PqHZCejcaj6Gt4qVihlbb99wFusYBjZ+Hoad6WvDXbXhY6yPxykjwcCmFjJWwlgND8MI/9enj2KRX03phtA765oZGPjRYV1ut3dJAftKP4HYwYY1JurT6pMKc33voHH7IjlRqgWCHidhHtbORDLD4cUXqBdhdpvdK1/io6D2KutQ1EgsynESh6ZPNJlNzi5hidjZRP/QPi3hoW+tXf5HucnX1W1atVW74vY0infASvaKnleBZJoh3gyAbb6wJvFT/KfnJS6ZJT+RrkwmEjNp8aRObBbquGoiThuMbRttuqbIA7j+oiJH/3fdXbrHVxFvZHZTtxlEgWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7668.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Mon, 7 Apr
 2025 20:05:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 20:05:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH RESEND v6 0/2] thermal: imx91: Add support for i.MX91
 thermal monitoring unit
Date: Mon, 07 Apr 2025 16:05:38 -0400
Message-Id: <20250407-imx91tmu-v6-0-e48c2aa3ae44@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 linux-kernel@vger.kernel.org, ye.li@nxp.com, joy.zou@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744056350; l=2483;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mUzERge0VJoOjiNnZjxUCrzvzrte7OXaiJn1iA3QQso=;
 b=8bwoddN5NSvHScnYz3r4xscKcVCFcy7lEZZU318aw7313B/T8fE/d3eFXQINQNsDe5ijwje0o
 vMzv6euDqaTBkz3FvtIg7HnCURKNIraU31g6NZ6e5yPgSR/N4ON0Pw7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:5::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8d1fcf-4306-4b56-a398-08dd760f9a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmw5eW1iaXhnTWx4U21UaElzNVRRQUFOdTZ5cnZ0T0I3Vnh3U2FvcTV5M1E3?=
 =?utf-8?B?M1VmclA3eFVpZWVyQXhlZXJhSkU5Yk5yUTM2NmlFMlJnL0ZyQkdhd0gxK1lw?=
 =?utf-8?B?WDZVQUJacW1ESS9jMjlqa242MVFsVmFXU2ZKUGw3ZVhZbjkzUGVhQk1QeEsz?=
 =?utf-8?B?MS9qRWQwODNQM0JtM3lCL3hCRHV6ajFZVEk1MmdHR0ZocFpFUFJlT2hhREl6?=
 =?utf-8?B?elY1MnlWYVI4d013UURYNHMybWh1emgrQVVvOHM4WHpuUnNQenBIOUpBcllt?=
 =?utf-8?B?RGpEeFhRU2VlMVhGanAwYzZYdVUzcENVcnFBeXNFOUZObFZGUGZoUkxMOWhR?=
 =?utf-8?B?V25yVDNHT2Y1VDJtZXpxM1pjS2RYcktHM1Z3NEFqZDBKQ3F0WmZmMDVOMUFi?=
 =?utf-8?B?R1d3dHhnVFAzSEg5WnVkS1ROSFFtVFczVEVyc1ZDVXo0SDdnZjc5V2FFcUw4?=
 =?utf-8?B?dWRoQktKa1Fqa0k0MjFRTy9GYXd4TGFVR29LQWpPazhnK0pma1BPMzZ1czNq?=
 =?utf-8?B?UEY5TE93UXBmNHFZV3FIRTdPVEZLNlpQdWFHZGNnTTRJZEhqQ0tLOXZxZ0RZ?=
 =?utf-8?B?akhoNjhiaktuQjhWOHBDMHR1TXpBN25OT2ZlanZ6UVYyU3d4dlg3RWw4cklN?=
 =?utf-8?B?ZCtjbUliUjNlZlpCSTl0S3VVcU9HeXhRY0w2N1pHMGx4bGJWU0o1Nzd0bTB0?=
 =?utf-8?B?ZFl0SjNUUjNZQWV4NzdhMmRYdUpMelQvN0R0dGVwTTdmT1FTdUF5czg5ZlJR?=
 =?utf-8?B?RDFlSTBMQU1SNFUyc1hJVkZWb3orT2tFeGIvak9VWHVxNE9wVXMrUWViK21v?=
 =?utf-8?B?Vjl6OW5IN1dwaTRXYkFNeVVSeUJHamYxdTY0b1dzVVpkQURST3gvV2M1L29m?=
 =?utf-8?B?V1dzVDYxTXJ2MU0xT2V3ZUlkR0J5ZFEzd05VUjQ5am12T043Q3hFYmljNjU3?=
 =?utf-8?B?WFFNL0pFbTRQVkRObVU0dCs3eHppbFg5aWFUanhCNEw4L0dXUC9FUnNzZkh5?=
 =?utf-8?B?TGFPVEZkb2l3R3I0NjZkRWRpYjhHNjFWQ2RSL3FaOWNTZ2pmOElIdUtCclpu?=
 =?utf-8?B?UlZHVElMci9aODRVYXFDSVpnV1JjWUk5eVJEN2pra1RpeFR5dnliQ09wWW8z?=
 =?utf-8?B?V2VVbnBnQys0di9WVjd3c3FUMkNZMjRZK09ZMTlYb3pZeitFck1rU0R1UXVF?=
 =?utf-8?B?Y2tjbUkvZXVqYkpnQy8xV09naW5oSzgyQXVrOGZ6K1J5YlZZYU8xdHhLK1dr?=
 =?utf-8?B?NEFORzdOeit6UVB3dy9MS0t3ZURsT05WeWoyU1dIREVCbFBLb0VjWkRDV1JT?=
 =?utf-8?B?WlEzL3BDRklBRXBiYzgyMGlMZmQ0L2tUZHJxcm5ZNE5YS0t0REU5RDZ3N0lj?=
 =?utf-8?B?SkNwdHVscis4cjFDN2pTVDdKYitpTmVpYUhBRy84RXZ4OUFtWURoNWs2NWF0?=
 =?utf-8?B?bUptdE95YlZWaEV4R1pGeHZiVHZ2UWdQdjQxY1YwWGVqWHpiUlJMQUx2Skpv?=
 =?utf-8?B?ZmFvUnNYVDhiR0Z0RjJHdWZRNjRJbUg0WXloUWl4Y3NGREpYQnJwYmtxR3Nv?=
 =?utf-8?B?L3pXbkxpZnR4QW5ycGVJL01PelQ3S2ZEL0gzeWdhTGZ2R3JBRENhakdMRTJi?=
 =?utf-8?B?RE1JMWwvTEpiaU9ENVQvS2Q3Tzg4RlA0RkdkVHVBMVBBOFBTZnNSQ0VrVzV0?=
 =?utf-8?B?QURkeHZpZjhXMXB3djB3eDZKQ2dqd0NDelNGR0dKNXZTRllXditUN29qekxv?=
 =?utf-8?B?UVpWbDFNK3NUQytmSDBFUlA5Q1hvS0hXTTZvNTJrS1UyRlN0aTdxemh0RHdS?=
 =?utf-8?B?aVM5aHlYS2dYc2lDd0ZZNVlKamR3T1JKaWVsYjl4b09BK2txNkYyUkJ4MVlx?=
 =?utf-8?B?SGFwVVNFV1hhU3hycjMzV3AxUkdKbUxERkVodWJVRngwU2lPWnFJTU9LYyt5?=
 =?utf-8?B?Qjh1NURYNFlmdnlXUmxsSkZqZ0dONmxZWWw1YjkrNU11Sm82YmQ5cWgzd3k2?=
 =?utf-8?B?NnJQSk9ybUU1aXk1Vi9ieWx4T3dqOE5SY0YwMllqUStGMWtNcFBtQ3Z5cGNQ?=
 =?utf-8?Q?kClKFa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2J4OTFLdnpkcTVid0p6RXdLV0hyd0FuM2Q4TTNRWERuQ3NhMU1SLzJYNzlz?=
 =?utf-8?B?dDB2cUsrcjBuSXVFbFhsYUZRT1MzTHNrcDNwU2g4VkFlcVlxSWtSWDYvSnpG?=
 =?utf-8?B?SHlreEV6NFBnb0ROaCttQmY4L09mM2YxOUhPaXdjTjV0TUVUN0R3N1NGUWh2?=
 =?utf-8?B?VHMyQnU3VWZpbzhreTlVQk5tenFkZTJvV1FCMlBMOUxTRmhjWEszVDlGZWI5?=
 =?utf-8?B?TjdnRnplVmhmNHdub0VROVRySE92VHZCZHhUUkhpL2ZXK3l2TkE1T2dMVUV3?=
 =?utf-8?B?NHlCM3dlTXNPY21MOVFoV01pQ2pSUHIxQUFYazVRd3JSRHZXTEJQeURSbVpm?=
 =?utf-8?B?bmJ4NEdjYlNVMDRuUVc1VVNSUEN2dE4wS0Y3U2pERGVwM211UVVNY1lqNnRF?=
 =?utf-8?B?c0NKUUNHUDkzZENoNEpiMVo4WDY0SnlUWHNZWlpYdWt1bW1Vbmo2L0ZPN2lp?=
 =?utf-8?B?cDVZYzBLd1FzUHA5eXRXdTl6QklxbStFblh3Vk1Pc29vMDc3Tnc5ZSs4Y21S?=
 =?utf-8?B?a29JcXlCckh6ZkI3QzRVcm5RMXliWkVmbjB0SDluaUxNcjZ6REFCUWpVMVdN?=
 =?utf-8?B?VVczajRVZEtrNEFzUERtWm15ckgraFMzNUZLTUtFNnJpdGFWazU1N1YwVDNI?=
 =?utf-8?B?N21mc1lZWW8yb0dyVFZScktSR1pPT1l1RjRESFN4ZzhhWnNQMUM3Yll0VjZX?=
 =?utf-8?B?dnNUSEMwU0syV2N4bHpZYXlxNG55MFBFNlMwRmZlclcxVVp4UTAwci9PTVll?=
 =?utf-8?B?a3l2eUJ0Mk1XZ0N3YTl5Z1JwY1N5dVdVenNwcjRESFErSnZTNDExeThTMTNB?=
 =?utf-8?B?aGpyTDVJRHprT0Z6Sk00QkNDaUFQWDFDL1BmS3dCSlF0YzFiUTkwSURPSitX?=
 =?utf-8?B?S1NFMEhUOW11T00vNWc5dURncGNQeERhWmhGMGFqWjlnWkNneWdWK2NRbTZ3?=
 =?utf-8?B?VjRrMXFNZEdCOFFvUzFKRzB3ZEFIazVpM1FsMTR2RGlydW1wNk51blVON3or?=
 =?utf-8?B?Ty9JQ2dWM050OEZwc3lMd252c251cllET3BaWTlmRVNhZ3ZqUXdwdUQwK3JL?=
 =?utf-8?B?dVhHSUZQb0h4cUJUN3MzWFVFd0V3VXk4ZDc3RUxFQWJ6UGVqbW1OYUFndDVy?=
 =?utf-8?B?WXF6eHQrMWR3YU4vRGh1TXViL1YvT0ZaWXNGYW02M00rekFtS012c3QzUG9t?=
 =?utf-8?B?bWZvOEtYSjRkTGlLSHV4eXlvbUNBc1E2T3FqM29jQ2NQQURMT3VIYWNUbG0x?=
 =?utf-8?B?RVkyMkFoQ3NETGdMT1lIU3pWMFdOUVEzRHhYZWZaeHFmUGN4S21DTG95L0VT?=
 =?utf-8?B?c21aWUw0U2oxcjdXam9sWnR6MWNhb0dhcXRlSlVEMW5meHp6YTJtdzR3cnNk?=
 =?utf-8?B?eE5wZFRTbFd6T296T0RPSllqMDFlUHNXR3VyY1IvYzlVSk5JK1JNOG9jNFVR?=
 =?utf-8?B?V3VFd2x3S2VDdWduV2ljcXJac25naFFRTUlvSXAxanYyb3Znb0JkSW5kaGV4?=
 =?utf-8?B?ZENhLzJBN052ZjFmZkovdzZLOHE0SURrZEh5ZGoyM0QyOGtCRVVMT2IwYnBm?=
 =?utf-8?B?b0RNWFlvZ1AyYmM3dzNlVmYwZWZBU094RFdXWlhlbjBkOGluQStzTjlkUTd0?=
 =?utf-8?B?V0xsL0t3OEMxOC9ObWlRMmdobHhEbVpmQkJvL0l5S0FnNnIvdStuUEJMVkV4?=
 =?utf-8?B?MURha1liT3pUQ3BvcVZLcFFxaVpVWExSUDRBUkpkZHJMZVQxQ1Vic01ROGE5?=
 =?utf-8?B?Rk5MWFlQSkVuSDNtcEFHRUduNkFBNldEY08xbVE1d0lsWkd4bXhHSFVlbkNE?=
 =?utf-8?B?aHJINEJvYytybTR1Mytjb2VDN09MTVoxby9KdXNpT0tIdGt5QjZ4VTRod25a?=
 =?utf-8?B?bGpkRWlneE12Qmx1R3dISE5jM2ZMd3RFd3RqclVodjBLZ2N3Y3JPREsvZWFV?=
 =?utf-8?B?Unc4UEZVNmlkKzBhRnRaRGE4Y3RRZ1NVU3BQVWdicWVkZ1l5R2F1ckRRcHJl?=
 =?utf-8?B?M3hmdktRRXhOYWhqT0oxT1pBZm5rc1JZUmw3TTNyTVpienN0TE5KZzYrN3VW?=
 =?utf-8?B?aUdzd25PUzNtTkJRbjZpVzNpTEdkRlJBRGhsbnJuam1sa1RaLzBxd0ZxK3lH?=
 =?utf-8?Q?jg2U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8d1fcf-4306-4b56-a398-08dd760f9a8b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 20:05:54.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3MUcarLPo7E35qyU/6qWVVj9k1MM4n2FIPSPh8KdQwWWsM4odqf9ZgiQhbw438fgr3zTfWO8YdYO5RFdu/uyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668

- Add binding doc
- Add imx91 thermal driver
- dts part wait for https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/
merged, so not in this serial.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
- use set_trips
- remove mutex
- Link to v5: https://lore.kernel.org/r/20250218-imx91tmu-v5-0-76c0b27673e6@nxp.com

Changes in v5:
- Add irq support.
- change to period mode.
- Link to v4: https://lore.kernel.org/r/20241216-imx91tmu-v4-0-75caef7481b8@nxp.com

Changes in v4:
- Add Kryz's review tag for binding
- Add Marco's review tag for driver
- Use devm_add_action()
- Move pm_runtim_put before thermal_of_zone_register()
- Link to v3: https://lore.kernel.org/r/20241212-imx91tmu-v3-0-85e756b29437@nxp.com

Changes in v3:
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties

- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
  uboot may change and enable tmu.

- Link to v2: https://lore.kernel.org/r/20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com

Changes in v2:
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
- Link to v1: https://lore.kernel.org/r/20241209-imx91tmu-v1-0-7859c5387f31@nxp.com

---
Pengfei Li (2):
      dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91 thermal module
      thermal: imx91: Add support for i.MX91 thermal monitoring unit

 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  87 +++++
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx91_thermal.c                    | 398 +++++++++++++++++++++
 4 files changed, 496 insertions(+)
---
base-commit: f50e59ef812d87066a5ab07c7bafc54aef378c20
change-id: 20241209-imx91tmu-af2a7c042d8d

Best regards,
---
Frank Li <Frank.Li@nxp.com>
-- 
Frank Li <Frank.Li@nxp.com>


