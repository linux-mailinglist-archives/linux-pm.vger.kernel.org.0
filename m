Return-Path: <linux-pm+bounces-41240-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDAKNGMTcWlEcgAAu9opvQ
	(envelope-from <linux-pm+bounces-41240-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 18:56:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E5E5AD80
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 18:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23D0C802D75
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 16:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A703587B6;
	Wed, 21 Jan 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l+LZBFUH"
X-Original-To: linux-pm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1F33C1BB;
	Wed, 21 Jan 2026 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012853; cv=fail; b=ez6ITj4lFmPFxf9dZ5pHhrEC1DE4vNihdkgm4gc5nANv3XIp8V1fk9GekbsXEPnnbleo8FlV68S2XjSGMBr29duiFu1UIaSJ8tAkIR1SDuU+bxbNGF1MOLkqbtNn7AmUQfcdhsJbrZxsgfW+Sn+T1KWUBWBu7r8sRwU8rR/yu18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012853; c=relaxed/simple;
	bh=F61cwS9VAN2yQ88A4dE3YgRvR+AFlDF0PA4I7X9Vpmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iDpyj6OW4q5QDtYZKakHGJ/US5zGMSVOtYGMZJ57630gVkjmMxFanwRV41AX3HgG2GejjaBGcTQDhYYeC5AW4R3rI/epiBAXZPcY9OHVsLcz4CeipKYnXUNvuiIDLzqQPKskF3zrrfMMncUOz85MdBE81Gah6WpN0Hp4VzdSJtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l+LZBFUH; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFVVWxH07Gol9jCo0VSramEuCZFohT3U0lwxohgxYZLln9oEx4f/LIhXZBbfjdrhg9NPZ8P6eZptncUuKU7lNpo/VS0OZzzYpkYZxepIf4e6OD7V3WsAHm8hqr9qe7K6M5H0+5VspHNTYX8NE2Ja0SUj4mbSL2woY91/NuYj4gqND9uwfyzflCrqjDnXXG32M+7Qypsp3cz21pnOBbGlOuiMjtwGSDA84YVhjuYuOZgxxQ7ZiWuJDJS1bdt0Xqpv4lIIlL0z0cUD74tm9gUy8EEcajUeQnZsXiZtHYBQWUn2ookGo3YYbkG4fVatfzwaO/7eesgIX+2YrF4JCg6RiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXpd1477fzp3hYVE+FGPvFYJj/S1cTaIXo/rpqBtSJc=;
 b=XcgpY1HEQkD9CDdAf4AF72yqwMPcmJgacMQJi8KFMsf9mIejpCODY/DQUohlVtdU9HNDQNUBDkDJ+/YWCoHWoI2cQBuYbLVYxGzpcQJ56JrDAzkayO0CiYA/1cy5aU2JOosUwQG16l5piR0t+I+ohyRKvnMmmzL+kbtwKyZvxWd89TzYCpDchty0et5ohKrUeJNecekQpBlGJi8zG5w1/ekunhsBdnfw/XT8AqRAn5grJsooy48+Wrdp4mfeEoLC3xxnU9oXca7bNRHnugtquDSfMH9AIvgjEOlBdQmmKQVGo2zKIbwH6YBJfgeo9F6JvCdih0mTrbN5ZOCBFYHm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXpd1477fzp3hYVE+FGPvFYJj/S1cTaIXo/rpqBtSJc=;
 b=l+LZBFUHdE1D0tnM70MleOtHyQkJ8fb4qNpcfhlpIEVawqLa95SJJ0SkaXhB7iXDN1hvs04etnVErGC9gsRVfGaZZ/dVmD2+LmQBEzdKFkFo/RRZ33PFaF2oqQylKgoRTI302MJeWNpQmajjNaE0n15hKwvfKXp30R6RfwCFjxA=
Received: from SN7PR04CA0063.namprd04.prod.outlook.com (2603:10b6:806:121::8)
 by CO1PR10MB4739.namprd10.prod.outlook.com (2603:10b6:303:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 16:27:26 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::3a) by SN7PR04CA0063.outlook.office365.com
 (2603:10b6:806:121::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 16:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 16:27:26 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 10:27:15 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 10:27:15 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 10:27:15 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LGRFCF3173620;
	Wed, 21 Jan 2026 10:27:15 -0600
Message-ID: <652d6b5a-57cc-4985-87fb-94eb53c520be@ti.com>
Date: Wed, 21 Jan 2026 10:27:15 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: ti: k3-am62l: support cpufreq
To: Dhruva Gole <d-gole@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Sebin Francis <sebin.francis@ti.com>, Bryan Brattlof <bb@ti.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
 <20260120-am62l-cpufreq-v3-3-8c69b80168a3@ti.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20260120-am62l-cpufreq-v3-3-8c69b80168a3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CO1PR10MB4739:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a34485-803a-4f3f-0af8-08de5909f6c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0xWbWhuTEcxTm9Ta0p3QjJrSW0rTThYaGpKcjdqUzVaaTBjYnF2aHhuSElr?=
 =?utf-8?B?MUoxdlZqSzRUN2orUzMyNFNTSnhhd2lZVllpdHVQb0Y4Wk12Tzc2Vi9Wejlp?=
 =?utf-8?B?eG9vdHNmTVdXM3JsNVhraStHTE5iNVNvN0Q0UzZkcmttMXh4RTYrSVhMNno2?=
 =?utf-8?B?dmcxQ1Zjb3J4N1BNR2dLWHU1YWMzcmlXaFdyK05iK0dNNU05cmRoeEttd1hZ?=
 =?utf-8?B?NzVHdFVraGZpUnZUQ1RmbDQzYXZqYTRZbWZ0dnRkaUdRKzMwSnFQbmd1bGxS?=
 =?utf-8?B?eldxSUtDdnZZT3hWWW5tSUk5TE91Q3YwSVN0NFlRTTMxR1ZnOUord0tWRWtr?=
 =?utf-8?B?MTJMVko3eFNFV0NhNmI0eTk3Q0VZMWJ5UDRtT0tFbk1vd2FtLzFxOHg0RWxQ?=
 =?utf-8?B?SHBBN1hzbkdFRUVITkdWKzdUNDlVcFVxbWhkWGhWa25IamdzL3dpVVpaYnlE?=
 =?utf-8?B?S2pURXpCTDZtTWdZVmhVZlg1bnFKVTJJVzVWK05JRWFTaUlWRVNCeW5zdzVx?=
 =?utf-8?B?UEhCMHFrVmxMZE5LbTlhM0kxdjZobUFIOTVtaWdIOWdIR1pwQ0hFV1Fxai9X?=
 =?utf-8?B?MlNFSHhyUTZJYUpiM1ZkdWR5RVVWa2RFeXhnOHVwWWlUbSt4TlVDSGtkUE5n?=
 =?utf-8?B?ZVVBZksvL0dTdEVBdFI1ZnBLSTRUMFhrbmY2UFdQQ1ZDcHhyWjJFREQ1K2Q4?=
 =?utf-8?B?dVZqZEhBNklaZk5uY2Q4dHIvZHIrY2RyUnVpTjJtZE44eDhTcU94YjFuRXYr?=
 =?utf-8?B?czAxRGo2cWQ1dEt1UGF5QWd2T25oY2w3d1lXZ1dlT3J6b1gyd3F3eXZWUHJC?=
 =?utf-8?B?YUdFbWtlUURURWJwWDgxd09FRFhRclJ6ZGtHT1VYOW9SbWFRc3VMZXcvaWps?=
 =?utf-8?B?Nkx2cWZNY0VoUFNWQ3JDcldiN2lUb1hpSG96MnFrY2hUQk9qMnpPK1krNTZh?=
 =?utf-8?B?clFtZHVhYmFOWkl4dmN2WWlJazVUY21oRFhMa1JIZGlFMlpmL0Y5bURNbEF6?=
 =?utf-8?B?cEtFZ1VoTEVaa0hmNHl6UEt6emcvNWZWcHV5ZGc1ZEJJWjJwc0ttRG1ZZTUw?=
 =?utf-8?B?eGtBVVhXekh6eU1nY1V5MmdkOHFEOW16ZVVNS2dRaDlMdTJML01HZ29BUXcx?=
 =?utf-8?B?SEo0S2U2ZG52TWJqdE5MSFRBV002Vzl1UzVlR1JxbWNGLzFxQ3RkZjFDeEpq?=
 =?utf-8?B?T0s1OU5XSmY2cExlUktBaXdydWdyQVNaM2Yzd2kwZ1RJUktvS0JJeXdDYjV1?=
 =?utf-8?B?VlgrenRLY3FYVEtzc1J1eFNhN0FCTlhlVTdZUWJwVlFSY0FMVUdRRjYvYXRD?=
 =?utf-8?B?NlZ0TU1ORFRtVUlyU0dLOUpsMVFvMFAxY1RKeGl4U2tvYjBaOFlnak42bWRx?=
 =?utf-8?B?L0Z2S3B3V0wrUVZDVVA5Uy8wM0tocXY2TkxxWWpPaXB6UmNTQm1jWEg2bG90?=
 =?utf-8?B?cmFCRlRqT05yd3pnRTNKbWdyWWVJVVRNZ2ZiVE5Zd0UzQlIxUjFHS0trNFhL?=
 =?utf-8?B?TXlHWVVnT0pJWlNCT2RkQkIrcTlYdWI3RTFDeFVkQjFrL0pVYmxPR056cTda?=
 =?utf-8?B?bTRRanJQclNWbVFhUTRjTmJLMnZDcENGQTZPazhXckRpYU9rSDNNbEJ6OTc1?=
 =?utf-8?B?ZmJJcFU0R3RTSkpsVWZYYWtWdjlIMHpVRVNKVmtYcVc2L1F5dCtNcURCbUhB?=
 =?utf-8?B?b0JZemZvVWNXajRVdWY1QVZ6ZUtGK0R3OXNrTE1FcW9XQm5WMnVyNFRTclc1?=
 =?utf-8?B?WVlVWHg5dThVUUt4TktRT29ZSzN3Qi9jdjBzUFVtdXRVZ3paUzVXSkdzWHhm?=
 =?utf-8?B?ZVEzSThhcHkrOXI3VW9Bc1J1MkNQdjA2Vnk5bHVDdDAxL2tpWWxUTTN2Ly9i?=
 =?utf-8?B?Sk0vMWw5OE0xanhEaEIrenp0aEZicWZqS1hZQlRDQUpMaDg3MVpCVFBGMjZ2?=
 =?utf-8?B?ZEZiS3daa2Y3Q1pHNUpFU2FiNFFVUm12eUNFUEhtVUpvUnZhZ1VVUDhsbmMz?=
 =?utf-8?B?SDZyUzRmZ2d0TVhyT3JmK2xjVEpkTjM3cXBQSXI5cGhBK3lQbVJvdXRjazhT?=
 =?utf-8?B?THhueW9USGdXTERZcFRhemlJbnpZUkwxMGZ2bCtKdWZEVFNNVEUvNURXQVNr?=
 =?utf-8?B?dERzZzhXSWlSU285WjFQa3RPOGIrQksvU3M4OXV3czV6blhzaGNtdWFnVWFm?=
 =?utf-8?B?RTRZNXpxR3BUckRnM0x3dW9uSEY0c09tbUd2QjVmNlZqdTQvY1YvemM0SnF1?=
 =?utf-8?B?cnFIZlg3UmlJUSsyY3c4OUdaRGlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:27:26.2377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a34485-803a-4f3f-0af8-08de5909f6c8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4739
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41240-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.18:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,0.0.7.208:email,0.0.0.14:email,ti.com:email,ti.com:dkim,ti.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k-willis@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 73E5E5AD80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 05:47, Dhruva Gole wrote:
> Enable CPUFreq support for AM62L SoC by adding the relevant OPP efuse table
> syscon to k3-am62l-wakeup.dtsi for speed grade detection.
> 
> Add the operating-points-v2 table with CPU frequency steps from 200MHz to
> 1.25GHz to k3-am62l3.dtsi
> 
> Configure CPU clocks to reference the SCMI clock controller for frequency
> scaling
> 
> This enables proper CPU frequency scaling capabilities for the AM62L SoC
> using the ARM SCMI protocol to interact with the power management firmware.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi |  5 +++
>   arch/arm64/boot/dts/ti/k3-am62l3.dtsi       | 47 +++++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
> index 61bfcdcfc66ea8d802a36ed43cd01fbbf3decc70..a42ccd0d2fcc4d204cae81508f839c44ce83f558 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
> @@ -127,6 +127,11 @@ chipid: chipid@14 {
>   			bootph-all;
>   		};
>   
> +		opp_efuse_table: syscon@18 {
> +			compatible = "ti,am62-opp-efuse-table", "syscon";
> +			reg = <0x18 0x4>;
> +		};
> +
>   		cpsw_mac_syscon: ethernet-mac-syscon@2000 {
>   			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
>   			reg = <0x2000 0x8>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62l3.dtsi b/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
> index da220b85151227c63f59b2b8ec48ae2ebb37e7bf..f7146421918f7037c6a192cc4765e8814a508afc 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
> @@ -39,6 +39,8 @@ cpu0: cpu@0 {
>   			d-cache-line-size = <64>;
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
> +			clocks = <&scmi_clk 356>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -53,6 +55,8 @@ cpu1: cpu@1 {
>   			d-cache-line-size = <64>;
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
> +			clocks = <&scmi_clk 356>;
>   		};
>   	};
>   
> @@ -64,4 +68,47 @@ l2_0: l2-cache0 {
>   		cache-line-size = <64>;
>   		cache-sets = <256>;
>   	};
> +
> +	a53_opp_table: opp-table {
> +		compatible = "operating-points-v2-ti-cpu";
> +		opp-shared;
> +		syscon = <&opp_efuse_table>;
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-supported-hw = <0x01 0x0006>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-1250000000 {
> +			opp-hz = /bits/ 64 <1250000000>;
> +			opp-supported-hw = <0x01 0x0003>;

What is determining the opp-supported-hw values? To my understanding 
based on the DT bindings docs, the values should be based on the number 
of unique speed grades, which there are two for AM62L. Looking at the 
values used here, it looks like it shows 3 unique speed grades.

By this logic, the value of opp-supported-hw should be something like 
0x03 for all OPPs below 833 MHz and 0x02 for all values above it.

> +			clock-latency-ns = <6000000>;
> +			opp-suspend;
> +		};
> +	};
>   };
> 

Best,
Kendall Willis <k-willis@ti.com>


