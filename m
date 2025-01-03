Return-Path: <linux-pm+bounces-19943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFB8A00BE9
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 17:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0A41884E84
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913741FBC92;
	Fri,  3 Jan 2025 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="YSZnLkfx"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023095.outbound.protection.outlook.com [40.107.162.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3A1FAC26;
	Fri,  3 Jan 2025 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921023; cv=fail; b=GdgtB1RFeU4buTjUNBNjxLVcaaGCZcyVQMY7+gAxodFN8FImTC38j183j6fRkxettpR3OD09blY4mXiB3VZonn4dzaRDMYLccUTnh+MS62dEipFpMDN2f9JOgt0BPkmFvfZ+uCdonrulge9Ii3ACEvVs/Sbw30KR0D9HBhQQvhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921023; c=relaxed/simple;
	bh=rXIF/EDDkJoPYUBe516tICOpGUL6Myt6ryTSCZTO4aA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s1D6g3r4RVojIZ+e2/boT99krhMahO7CBIj+An7pmf/iyGER+lsphLnT2sGE/aMEuuxgGwHJ9/1HvcKuyaZ35u1s9NkkHtQwvSB4nGmkLnehLBHp3tQsn1Vw+Xg7eoMZ7O0jf3lKNWV36UlYDPYg/rOMpvCzbGiK2oQmORZz1kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=YSZnLkfx; arc=fail smtp.client-ip=40.107.162.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X85r1KXsnllIqFs29pphpihOejykfG/ebuzchf0AFgIcAKLT2VUM8EGQVlC9R5iHJqm0yTlwH6gH6qwk5NDeumL8ZrafIQ0F8WsypYmFxN2+lb0mb5V79iPNvLFXVcQLhZWwOm8N5lpqqYpq9gYBQ4gwOmRlb7MdckokTO9LsCvR+UUVyZ8QtTNLevTAaPppVALXN4QT3Q7lUhSChO6LR1n+Os3QOAF9h6b6TE3nwuApHrMk/69aMG7sB0bSNdZHuDIOmbKiqjUNdlUwkaciX6je64LxW/AXmaa7Co2277GeSD19mJc32wuiDbb1BpmKK5h4HmVepQwx1W9WiJUHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8390tuyKAuiDLArCF6V0xbLMRi3X3kf+aiCb4nZ7Wk=;
 b=uAysE7U1oKo55PwJMUmIBxSCyTz6bex87Ny4BMo+LS7koWbU96oCIpTkgYdtcPBEOO7tUbKn/fHMuY5yI0fHtG6zpgq3bIFu0GV/OYEuMIX2lRBNyZ8H8Tmi1X5SYs16yrx80o7y6T6IiH6CMWu2TLUBs3YRzFIzycSruJJ0nKW5i+kGK8PU4iETWjeKnZlvG9Ayho1Gb0ytSH6SUx6Gebgx2TKF+9AaJdtDD8EdXDIUztSV7XLi4/Vp8w6MG/natOSIZ8dMvLBPupZpvZUirs85/zRXN17McXN26aI9BEGhqxTqI3eufynvxMO4cbbYurC7OEDWrf3o+1mngss4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8390tuyKAuiDLArCF6V0xbLMRi3X3kf+aiCb4nZ7Wk=;
 b=YSZnLkfxmhcg8my0xS6ndZcJXcoD+ZaIKbdXISXZI5FFdXaMzNxn1XaV8pJEtfIaRnHHNPBa2rVLo0XEY8munF3XKL54TgEJsdK8y79N53c08Iz50Q2+U4k/dmo0xBjqGU6E6khnPE9iBL5peV7lS1w4bBMaQP/Hr2gLZjVcQK/3DXYXz5u2Ksr9KdX38X4WgoN+gLwC2lc6DJB9LTUXumbUEq/e8oIdmbNiXukGZQmuQbJ4+vvxN0pSMPTnjQGVPMD0Gq+zWQPJCKSSr5yNKhgxIxtk/I38s1JEOhu/nhMj0aS9FDMtpqX3cLpE7HlcaFUu0ubYfnbPkPzO+eiiTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by DB4PR03MB9508.eurprd03.prod.outlook.com (2603:10a6:10:3f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 16:16:52 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 16:16:52 +0000
Message-ID: <2eb1f056-4102-4536-90d1-9d5df1fd2cb5@uclouvain.be>
Date: Fri, 3 Jan 2025 17:16:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: add max77759-fg flavor
To: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
 <20250102-b4-gs101_max77759_fg-v2-2-87959abeb7ff@uclouvain.be>
 <cf75f897-1c00-4a37-bce3-f1eb9855a3cd@kernel.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <cf75f897-1c00-4a37-bce3-f1eb9855a3cd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAYP264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e::14) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|DB4PR03MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adb9ba0-ff5d-4ea2-2eb7-08dd2c12089d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NitYU1VLb0hqZy8zSnVrMkU2aFhmTHFDeUV5djJUMi9IL1N3SmxUTk9yRU93?=
 =?utf-8?B?aUNnQVZhVlU3VkhKM3Y0UHRxWXhVSGIyOC9GRkdIOHA2dDIrRlBydTBnS3Ir?=
 =?utf-8?B?TVlGVS9ZenIzR1BBUC9tRmlaMktMOEtFQ0NMSDNRY2k2T0VjbDZzeFdqdlFt?=
 =?utf-8?B?U2FtVXdzYWZqSEZCSlZZMEp5NEVtdnpTUldab2ZXbXpXdVNBcnZLV3JRdWpo?=
 =?utf-8?B?N2plcnBzQXVEQkhUeG1ZNDd2TlViQmFlQ2d6RkhWTlRDZm5QUDhYWWFkNVJu?=
 =?utf-8?B?S0U0bkZjd3NHRmU4a09WN2tsM0NmR3J2cVFET3Vnbk9vOGk4NEEzdFRuVE1w?=
 =?utf-8?B?a01ldEJZVHgzYWx0MTZvYjVyaEM2VGNiMEJXTUQxZTN1YUIrQ2V3eGR3TTZE?=
 =?utf-8?B?bk96RmdSZVZmU1NpelZycDlUeTRGU1dmQXZmNUtkTEZ1TjFXc2RBaHpyOHU3?=
 =?utf-8?B?MzdJc2VhQmpHL0lYY2dzMlY4MWxCR1Z4ZXBtUzJOemhyWVZhS25kczBRa3ZY?=
 =?utf-8?B?c01FVGNIaEtSWStxTkJMTEJmMlhiSnQzcFBqOFNaMlh3andlOVdYVG1wVDZn?=
 =?utf-8?B?RjFsNDQ2SWc4eERwcSsvTzlkY2N2WXR0Y2x1dnlxRjJXQUw0SjNici8xZkVS?=
 =?utf-8?B?eGJiNE1td2NwR1NuZVNrMTArMW40ZVZSekNOZHRkcFZmNlZjN3pyQ1cxZGpv?=
 =?utf-8?B?emRUTjNyUlQ2UDFLSnJQR2hqVmtBYng3RU5QNVF2THg1cU5JRDVGRjlFYy96?=
 =?utf-8?B?dS9BcUtQbUJMQWlFaUpWTkxTaTY5cld4TURDdmJtWTBZbzhBSExLVHhscXhZ?=
 =?utf-8?B?Z0JpZXh5ZDlWTFhGTTF4VUFKbDZzNzhQOGV0V1Ztb0hPbGV4bkt1SkV3ZjV0?=
 =?utf-8?B?TmtXMGp2bG5VcnMwQWtUN0trelcyRkd2SHplVXJaVXl4Zzd4eXM5bVRmTmw0?=
 =?utf-8?B?R1dBT0k2bTVTdzJMMk5NZE9FQVZJM2FMQnMrM1BPamxZVWh5QlhlTm5teERa?=
 =?utf-8?B?K1NsV1ZEa1lTdVZMNHVoU1YrbzBrbmxmbkVoa2dTYzhZdkl2RHExekJxNXdv?=
 =?utf-8?B?UVY4VmVLdG5CdzZpTUtKTloxMzlkeFRnbFJmUlI1R2FEbktNM01ZT0ttVEZ1?=
 =?utf-8?B?dE1sbFNXZnIzMlRLVnlNZ2pZMVdoRjJ0WnYvZzdvUk5IUExuZFMvVjRoT2NK?=
 =?utf-8?B?NVkwV0RjS0x4cXFka2ZGWmMveEtSRjdiSW90YTNZQlc0OE5hcVlqak1LWlFF?=
 =?utf-8?B?cEttU2xseDhLa0dCdEFQYzVxdHJnT1ZCejNwdE1IS0thbnZLeWdrcnZFUkpn?=
 =?utf-8?B?ZVJsL0dMUTNReVlmV09aOG93RzI5b2p4UEV0RGx2SUQ1YWlkS29SSHFQSzJw?=
 =?utf-8?B?RGc2dk52QnlUb3Fsc200WXRyTE1rQ1B5cFBESjhTQldOTURtOUkxbHdsTldE?=
 =?utf-8?B?Qlp3S1BnWHYyc0YxMHFNWWtkTm13M3hZLzF4eVJRd0Nzcmk5U0ExeDN3NEdI?=
 =?utf-8?B?TmVlTzkyeUpsdXJpV0tLQ3BrWG9PeDEzNEYvZm9Xa0tzUEtKV0FvV0xmdDZO?=
 =?utf-8?B?MFlqcHAyU2pGWS8xQmZaTk5EL0lZZ0pxYm14REVVS0ZyUnRwSW9FVHM1R1RF?=
 =?utf-8?B?Z3pxL2NVaHBMcTk3UnNhQ0dHWDJGejZZRStybURsb0x0cmJxMVduY1lvYjZV?=
 =?utf-8?B?ckJCN1NCdlRjbUZHRWRjUTczdCs2R2taMDhPVEdsVHZpYzVLWWVWTngwa0Yv?=
 =?utf-8?B?bFJSSFVERVlRTUFJSmI4UUhaNEFCWFZ5RDZCVEg4UE1qbUFHenZwOXBsbEdB?=
 =?utf-8?B?YkpHWU9VSWFaVXd4azJKVWlMVUJrbzlFT1FQTzN4aXZVbnVBc0FaTWUvbUw5?=
 =?utf-8?Q?AtSFM8f3mOhJO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmUrakhYY3VuWEdzbERpNjNxMXlGaU5WaFc5RFdVcW1uazU3S3cvUklrVkpz?=
 =?utf-8?B?dE1ObHVGMkZYZkFCSWtyd0FYL2tERWkrMk1mYitXb1BGK0tOVGdhUkwvWUJq?=
 =?utf-8?B?bGNOMStIN2ozc1ZRNFRFc3dSRHZieVBoL1gvbTAwLzAvbHNwTTl1c3o5K3Nu?=
 =?utf-8?B?OG5iZFBKZ200OU9NbHJVMDJtV2syaFBza3Axb3lVTFI3VWFEZnBNblpscXBk?=
 =?utf-8?B?end4RWdvWGordzN3NEtxR0gxZ3FrMU9kRkN1UVFLajQ4bnlWbTZTMXFXZXNV?=
 =?utf-8?B?cmYyTmhTTm5BU3FEQjdVNWJTdDJjZWNseHFQOVgzTkFyakdGd0JHR1BFK1oy?=
 =?utf-8?B?MisrTk9Qd0k2MlMyMzRDNGVZQkpwaHZWcGJ0Y0pHN21uVDh0YVlQUG5ZbnQ1?=
 =?utf-8?B?YzN0Z21HUjNtRDNFTXNQVFEvekpRajhET1lIb1kvNkkzSXFvbkptQzEyMVJk?=
 =?utf-8?B?VFRrenBseWZrQndTL3p6N0YvK2V2amZzZFA3S1EzYVcrYUNwR1EwMllZa1ds?=
 =?utf-8?B?NkhRVTVOQWs4aHlvcVFxWmZUQ2dOOUpGQlRHS0U5emg1WEVVU2F3bnJkSmd5?=
 =?utf-8?B?c05iMk5oakNIMWJBcnRNZVBDR3E2TlVFQk5DL29SWnlTbHUrMEJxblI4Tmc4?=
 =?utf-8?B?YUNUMjZoWG1WNERORjRHQW94bXVtK2hKTkVkYUQwSGVQVGIzODBEbzdaTXJC?=
 =?utf-8?B?UUJzMENDOXkzZEg2Q0FiRHFsRW90MUJDNC92cGQwcHdHZFpXVEp1Qy9ySmVX?=
 =?utf-8?B?MEdrUDNBeWQzMmFFdDUrcDdQdjdMamFKTDA0dUZRRG9OV1RBcU5WbWpvODFl?=
 =?utf-8?B?QjJrV254Y2ZvblN1aWhHUVVlZDFEZjlWamU2VWRTRW1uM0Y3aCtwOEN1V0hq?=
 =?utf-8?B?T3N3MHlEK2hzUGtSZWtwdmFpamRBRUh2WEFuMGhqZVgyVytSa1o1cmp1ZnRS?=
 =?utf-8?B?S0kzUlBmcXkrR1ZDZTJEeEV6M001bENLdGg2THN0MFpMeklzdy8zWEhKcG0x?=
 =?utf-8?B?WGNFZVA4Nnc0YUJTbTgzUWhhWlZIM1E4cVd2d2N0aStvR2R6WVo0ZE9IU3RS?=
 =?utf-8?B?bGR0VEM2K0NCc2VFczFxbHZKSUlTd2E4WExNdkh0NFdQUFYyWms5M2xuNjRh?=
 =?utf-8?B?aEhLcm96OHkrbjJ3VXc3VTBDcmJsUUJtWFAwdzk5THNpVC9iOEJTUDJ3bWQv?=
 =?utf-8?B?TTB1dnRLU1JlQmpUUkpjOGxBdUdMRlM0QXdnY1pZdUhPZWZ1cXp0TWlhbHVp?=
 =?utf-8?B?cG0rNFRzbVJjS1htRll5STkwR1RuVld1ZEhZMDhZdmFBSmdxTis5aXpCY2x1?=
 =?utf-8?B?VHY0bHhCY09ldmJ6VGI0QVM5dWlDNmhRSy8wQmxtUGRGOS9jVk1JMXc1NGgz?=
 =?utf-8?B?NGtPMndvMzBvYUZzWDc3YTlBc3NGNi9OVHRhWUNGOVFJcVJYUjdDOUZ0Sko4?=
 =?utf-8?B?M1Z1Tk5YU2ZqQ1NkL2Z6OTFJWGRtSDNpYUM0MVIxYUxQenora2k5VkFNaE91?=
 =?utf-8?B?M1lPMXlXSVY3cmNPN1doTTQ2VDk2L1l2akpyeHlsYzhBMHJmOTNzbmhibFpT?=
 =?utf-8?B?SzZpc1kwOE1Zc1JZZW1HdUUzZkRBTHVnY1JSem5jVTRzQm9qeUdZOFhCYjkv?=
 =?utf-8?B?OEtmeWxudStSdW52aWt5cHl2NmxWOFAzbENETHhxVHdZNkI3NzRrdnNodm1o?=
 =?utf-8?B?T0FuZGRJQ2pON2laM1BRZitFSmpNQ0V1T2NuZ2hrbjVudjIxbTlGa2RQU0Nu?=
 =?utf-8?B?cVlVN1Q0RFZENzlRVGx0Wkg0dXEzMllhbkRsZ256TWdXcmtYakJQRDNkbCsv?=
 =?utf-8?B?ME94RWd2SkkxR0VZN1I2VjFsZjZCZmY4ZzBOUDd2WHBOdktKWlRmcHRPcUh6?=
 =?utf-8?B?NFExTGhYSmVpSnBaeC8yd0VyeWlnRjdKUkVDcGdwdW1XNHQ1N0loaFQ2a2d5?=
 =?utf-8?B?M1Y4V1JMbW0veUdQYVU1MitLaTZSZk8xTVlTL1R5Qkttb0FqbERxcW5VNU5E?=
 =?utf-8?B?TEVwdjdlZngyd3FjYXhncHZBM0VEOFR5c2ZHMThuVjl3dTZnMWY5Q2pkWnEv?=
 =?utf-8?B?SDBlSExQR1dUd3lVa2VYUVptUWZKYVFhcCtjZExuN256cmVYL0k2YWhSa2lS?=
 =?utf-8?B?a1BmT3ZpbkZrckthWVJuZmlrZG91cjlmL2xveVZSSXVnU0hkU0tmSHVsV3Jm?=
 =?utf-8?Q?YrMw81TCH0q1tkGUYbLUDDQoiiv79VP4TJBmR8/xxqrp?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adb9ba0-ff5d-4ea2-2eb7-08dd2c12089d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 16:16:52.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ire5XhF7l938VehVhh8KQMQBN/TR4e9bwYosF0yJRAnj8JW5AtlMzOrzSCpgg42itQsXC0F6J+KRbdL5fq+wsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9508

On 1/2/25 17:08, Krzysztof Kozlowski wrote:
> On 02/01/2025 12:15, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> The max77759 is an IC used to manage the power supply of the battery and
> 
> Still not the name I asked to use.

Indeed, I missed that, I will fix this.

[...]
  
>> -allOf:
>> -  - $ref: power-supply.yaml#
>> -
>>  properties:
>>    compatible:
>>      oneOf:
>>        - const: maxim,max17201
>> +      - const: maxim,max77759-fg
>>        - items:
>>            - enum:
>>                - maxim,max17205
>>            - const: maxim,max17201
>>  
>> -  reg:
>> -    items:
>> -      - description: ModelGauge m5 registers
>> -      - description: Nonvolatile registers
> 
> Widest constraints always stay here.
> 
> See:
> https://elixir.bootlin.com/linux/v6.11-rc6/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L127
> 
> I did not say to remove it. I asked you to add allOf section restricting it.

Thanks for the example. I think I understand now. I will put the reg section
back and use min/maxItems in the allOf:if: to set the number of reg/reg-names
to 1 for the MAX77759.

Do I keep shunt-resistor-micro-ohms as I did it here? I could move it in
properties: and only make it required by the max77759 in the allOf:if:. However, 
I think this would make it seem as if the MAX17201 optionally accepts it when
it would do nothing in practice so I'm not sure what is the best choice.

>> -
>> -  reg-names:
>> -    items:
>> -      - const: m5
>> -      - const: nvmem
>> -
>>    interrupts:
>>      maxItems: 1
>>  
>> +allOf:
> 
> This goes after required: block. See example-schema.
> 
>> +  - $ref: power-supply.yaml#
>> +  - if:
> Best regards,
> Krzysztof

Will fix.

Best regards,
Thomas

