Return-Path: <linux-pm+bounces-41196-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEarC7oPcGlyUwAAu9opvQ
	(envelope-from <linux-pm+bounces-41196-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:28:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC74C4DCE4
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81B4950B1A6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 23:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFA03EFD25;
	Tue, 20 Jan 2026 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JACqqbEp"
X-Original-To: linux-pm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291BB3A7E0F;
	Tue, 20 Jan 2026 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950587; cv=fail; b=KAcm+q8b4U89wZrrZZJv+VfNZ/GyKpWB9ZaqlXmQtYnbgjUlgbcI8RrV6H55eJ60hJovm38LN/28ckYRqRr5jwP4TBUx85R/rdGWiIQ7D+Hm1xGmQlDLTwDvB4HYQc56+Xr9Y31V27J4/8WXwleMZ/DQpO++Nz+nzzF63JMQKPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950587; c=relaxed/simple;
	bh=paVxHCvelQ9+HbCLu0e/2LESawfD6AUcmnHlyMjiGFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pq31X/IpKdp1iFZE09Rcj74c/NqXKlz2iaLjOg5gjHKumtSGEpf0EUmrnqj6b6JUcl2tZ+YiqxdDos4ixY5T4n9jgyxLPq1q2QyAj+JnbV4JtBhMaHWt1iaVdLP9+d7ozEj1opfkzb+oQzChCpX+qrKZWzLulc8dfCohC4GWnjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JACqqbEp; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf8nV5tqJDTW4/DR9VgRJLgoF5wBO1e+pWlSwoFdT7llt6BcQJ1pBPbYi4Nl1VT+j2Bs39vkwLWQhZGyUOXhUBDtOF/vGKFICCaYSHsdwn/gYC4N8O/GZ2LE8k2WGq9GBAXOgOEorDBXw5vNPb9TvAhUw4caG0ezY/OJZpYxEodggWkKR0rJlG+AhL+cGGA6Wz+rZPPoDNNlAcxZmi9khKXrgxLnc/tHM9H8Ovshme1PHsvjebmSEDtRwcF99Y/hSsVqY7lVLzRej+65AKAKYavmeRZRLWoSg0yGTo2dFQh4AP/9cQItVIK4X9ZmtgehTFVSAwSBHVHmVlkkjp/HJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oHHbf08h+8N6ju0/eo216e5lOKD1Pp6inlUdLkiQzA=;
 b=E5kLcsjCVgUzAN2vLsRVx+gEfxKbXZbOOfMaez8eksbe5RAovvpLeKphNOgRZUIZGScntvApgNnpzqGBLMSlef3CLbt1xed9jA48ImMjiVjGk8WW8KVYHTR6vNf5T0WthUOGHdMxe5q+qZwJdbidYVp5bWCtPF96fwvgDZOblURLhZB/oQ9H2Qr345LRCvJYJ0e38E6I/dLiiEcZUkE6WHqbPO9OUYdTbL26SWKsdS9j+WSsFl+bTibl49sUx7tztXo8t3wSbGrJV14JG8wkiLYUOPO4QRaEvKtocrS8ze4WPqWvLPQTwePWMx477kvpq+MOJo3HaPgmvVtlcmwNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oHHbf08h+8N6ju0/eo216e5lOKD1Pp6inlUdLkiQzA=;
 b=JACqqbEpd06mD00tzw3n8g7E3gsUfgFQHMcRiAIUA2V3s5/DLU7+cONQOvcmfpJaGJBsAu34IZLDlbAsixJjng4Wguhp+mR6DD9CmRZMhGQuCTYl8sAEMN82YT48v6GaBUZLS5R/OFIihALDvYuBhB1rPwzVPa4Se/3hG34RaO0=
Received: from SN6PR04CA0098.namprd04.prod.outlook.com (2603:10b6:805:f2::39)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 23:09:37 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::fd) by SN6PR04CA0098.outlook.office365.com
 (2603:10b6:805:f2::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Tue,
 20 Jan 2026 23:09:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 23:09:37 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 17:09:32 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 17:09:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 17:09:32 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60KN9W0E1854949;
	Tue, 20 Jan 2026 17:09:32 -0600
Message-ID: <c5ceaa64-6507-427b-ade4-5a2ac8213d9f@ti.com>
Date: Tue, 20 Jan 2026 17:09:32 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cpufreq: ti-cpufreq: add support for AM62L3 SoC
To: Dhruva Gole <d-gole@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Sebin Francis <sebin.francis@ti.com>, Bryan Brattlof <bb@ti.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
 <20260120-am62l-cpufreq-v3-2-8c69b80168a3@ti.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20260120-am62l-cpufreq-v3-2-8c69b80168a3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff51c07-a8a1-494a-dbf6-08de5878fb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXp6Y05peHFHNWFES0JhdXVEcjNVQTN3bHh5ZUdQblh2QUNTSnMxWk95Tzhz?=
 =?utf-8?B?dEVKMCtPbUdVdWxLL3drMFVEdDR3Rk9DUWJMME5kVXRxNkszZnJMUEM5T003?=
 =?utf-8?B?YmlTUmZuc1UrZDFvSC9IU0EvdS8vNGlDL1hVOGhFV3MxdkE0dkZBK1A3K3JV?=
 =?utf-8?B?cEgrUG5Xd053bFlJd0w0aHVSUTh0UUdnc1JBNEJucjRuMWs4ZmNnRjhhamZv?=
 =?utf-8?B?SzhkZnBsUkVIU2pHWWFxc3JENE9lZUtVM3NZWGpSeUl4K2JHSTFRczYzNmhU?=
 =?utf-8?B?cFA4Z0ZLU0NFdWI0WDExeEw1emlETEtldWJSUC9IUDk0eER1d24zb25oZ2Qw?=
 =?utf-8?B?cUhQamxyckg1VzdZZHZxUTRHM29YNEp6UVNBR3JmWDNKVTB2dHd2aTVHZ0ln?=
 =?utf-8?B?SWM1K3FJeUJSVTFEZTV0eVlKQ09aS0sxRUg0Qi9jTEJLbGJJVHJIZkVwR3BO?=
 =?utf-8?B?NzFyZXJqQ09zb1dPTXEydWhXVlBFbzRlcVB6WDZPdUppRGpQYkhmK1I1YzE4?=
 =?utf-8?B?Sm0ySXNzNU5uOXI1clFPaUwxN3pCWU5YZVhPSTQyelZSMk9tQ0J5MDI4c1p6?=
 =?utf-8?B?Nkx0bGZYRHYrUGpyU0dPcjhvdVhCRUxWZ1ZkNXh4cGUvMFlSRGFvT0h1TG55?=
 =?utf-8?B?S0d4NXI5Q1c0c1FRTVBibGlDR21WSHFQemJpNjRqVlA3VHVYYjFTb2RpME5G?=
 =?utf-8?B?NUhCZWVJWk05TE1Rc0UzR3luNDhvL04zTS9KQ2VpaVJlRi9RbFZHQ08rRUZ2?=
 =?utf-8?B?TlNuR25rNXNuU2pQNkFGUzJmYWYxZXBZRUVrTUNIcnNONy90UyszSmlQSE1K?=
 =?utf-8?B?MXAzQ1JNaXNoa1ppSEp4VThMeTlRbTdBWnZLU3YvbFFqUjYvMWhWVjk0TjI3?=
 =?utf-8?B?Q0lScENCd21vZVNtWjlhRGxORnhNVW1SUUJxRnBsSW54MWNBQW9iZ2o3NXRY?=
 =?utf-8?B?eEFBZ2M2UlpBbkxtK2YzSHdvQkpGcGNHOGw2M1dDUU10czFWYURoa3k2cWRP?=
 =?utf-8?B?azVJMnRZa1JRcEpsWnA1bFlob3dKUTJya2srUnBVS2JTdUpOWVVscjZEejZa?=
 =?utf-8?B?eXFVdzJuQkxoK3M1Q1Q2L1VGUTN3ZUJxc0dPWUw2cDcvTzcyaUZDYUVrcndh?=
 =?utf-8?B?Y1hISHR2MWpuNVRjSjUvcTh0M2x2MytRQUg3TmVpa0drcllOR29idmpBR0xh?=
 =?utf-8?B?WU5SU3RMWnBETHkzU1c1TGFUZ0MwV2hjcU9NR0wrUmxWelpoUDBkZ0ZmeVZ1?=
 =?utf-8?B?czBvTFd2OWJLY1dTejBJS1hWVmcvMlcwNi9TSXFUMGxobEtDdzhodUhmQjd5?=
 =?utf-8?B?ek9HY3JnMFl2MjVydkVNbHcyOXFuTFBHZ0hyMFo3bFgyWVRsSktiV3B4KzRz?=
 =?utf-8?B?M2hqQVNjQmFWL2hYaUlWTWMrTzllVlRxdGZvSVljeUlJWTdSdFE5TEhRWlQ2?=
 =?utf-8?B?eDFUWWM1WGVjdndrZ3hwNXUyNW1hcUxKT0ZKeUZZTmxPbGNLaVFFNm9yMjl4?=
 =?utf-8?B?OVFuRmFGcFdIUmJqWldpTU5WTzc1MDl1akh5aVl2MGU4cTdRRGM0UmJXdXNn?=
 =?utf-8?B?REp0L2c3aE1KQTBqOExaajdFbVZIYTU2NlJiWFUxOHVuck1iV2RLcE04SnF0?=
 =?utf-8?B?emV6YkpsaEJWb1R6bS9EcU9TMXllNWFPdFUvSmJzdzA2dGpMbjYxYVZEMkdu?=
 =?utf-8?B?T0pYeUFxY2poNUhjV2pMQ3M1enJGeGIwcTV4YnpaZTRIaFg4K3loY0ptK0xK?=
 =?utf-8?B?VTNnNUlLaGVTU1lmNjdkWVJNNUFxVVNXWUhOdSs4cmpEV0xjVnoraFREK3hB?=
 =?utf-8?B?VE5HMitJbkdNVnA1ajJwa3lWVEw4VmNMYkxSbnRxVHJPOHRQU2VzU1g2SDQ2?=
 =?utf-8?B?czNHMkN1ZUtlR0FibnVBWitudkUwaGtuMVNXVWJmaHo0NEdQRyt1eXlMRDY1?=
 =?utf-8?B?MlBiczl4cHVyRG9wNjZLMmRCaGUrcmRzdmFnTG9GL1c5Q1Y5Um5vYU55Unh0?=
 =?utf-8?B?L2xiZUcyM2tTczFMVk9lYjBMak1ncndOZFZ1TkRQTXdrZGdXQUt1SzBpWnVU?=
 =?utf-8?B?VklZN2V4Z2o4ZGZJak5aT2U1Q1Zza2xzQTdRRjJNc2IxcVRqYjVvbHIvTHUr?=
 =?utf-8?B?aHp2SldnVnA4Z094VVcwT0NlbDZ6RDdTdUVicjl1TFExbzJuZ1FRUXVJTmZ5?=
 =?utf-8?B?NE9UcENqU0t1VjRhZEFQYkREd2k0MzlpRzhkaWtXVTdUUEFYYlViejlOdzFp?=
 =?utf-8?B?MW9HOWRNTUhoWlpvcEQ5M25JRUhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 23:09:37.2093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff51c07-a8a1-494a-dbf6-08de5878fb8c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41196-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ti.com:email,ti.com:dkim,ti.com:mid,ti.com:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k-willis@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AC74C4DCE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 05:47, Dhruva Gole wrote:
> Add CPUFreq support for the AM62L3 SoC with the appropriate
> AM62L3 speed grade constants according to the datasheet [1].
> 
> This follows the same architecture-specific implementation pattern
> as other TI SoCs in the AM6x family.
> 
> While at it, also sort instances where the SOC family names
> were not sorted alphabetically.
> 
> [1] https://www.ti.com/lit/pdf/SPRSPA1
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   drivers/cpufreq/ti-cpufreq.c | 34 +++++++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 6ee76f5fe9c567b0b88797ddb51764a2a5606b16..3d1129aeed02b06f5877663a1b87521a230e3b32 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -70,6 +70,12 @@ enum {
>   #define AM62A7_SUPPORT_R_MPU_OPP		BIT(1)
>   #define AM62A7_SUPPORT_V_MPU_OPP		BIT(2)
>   
> +#define AM62L3_EFUSE_E_MPU_OPP			5
> +#define AM62L3_EFUSE_O_MPU_OPP			15
> +
> +#define AM62L3_SUPPORT_E_MPU_OPP		BIT(0)
> +#define AM62L3_SUPPORT_O_MPU_OPP		BIT(1)
> +
>   #define AM62P5_EFUSE_O_MPU_OPP			15
>   #define AM62P5_EFUSE_S_MPU_OPP			19
>   #define AM62P5_EFUSE_T_MPU_OPP			20
> @@ -213,6 +219,22 @@ static unsigned long am625_efuse_xlate(struct ti_cpufreq_data *opp_data,
>   	return calculated_efuse;
>   }
>   
> +static unsigned long am62l3_efuse_xlate(struct ti_cpufreq_data *opp_data,
> +				       unsigned long efuse)
> +{
> +	unsigned long calculated_efuse = AM62L3_SUPPORT_E_MPU_OPP;
> +
> +	switch (efuse) {
> +	case AM62L3_EFUSE_O_MPU_OPP:
> +		calculated_efuse |= AM62L3_SUPPORT_O_MPU_OPP;
> +		fallthrough;
> +	case AM62L3_EFUSE_E_MPU_OPP:
> +		calculated_efuse |= AM62L3_SUPPORT_E_MPU_OPP;
> +	}
> +
> +	return calculated_efuse;
> +}
> +
>   static struct ti_cpufreq_soc_data am3x_soc_data = {
>   	.efuse_xlate = amx3_efuse_xlate,
>   	.efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
> @@ -313,8 +335,9 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
>   static const struct soc_device_attribute k3_cpufreq_soc[] = {
>   	{ .family = "AM62X", },
>   	{ .family = "AM62AX", },
> -	{ .family = "AM62PX", },
>   	{ .family = "AM62DX", },
> +	{ .family = "AM62LX", },
> +	{ .family = "AM62PX", },
>   	{ /* sentinel */ }
>   };
>   
> @@ -335,6 +358,14 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
>   	.multi_regulator = false,
>   };
>   
> +static struct ti_cpufreq_soc_data am62l3_soc_data = {
> +	.efuse_xlate = am62l3_efuse_xlate,
> +	.efuse_offset = 0x0,
> +	.efuse_mask = 0x07c0,
> +	.efuse_shift = 0x6,
> +	.multi_regulator = false,
> +};
> +
>   static struct ti_cpufreq_soc_data am62p5_soc_data = {
>   	.efuse_xlate = am62p5_efuse_xlate,
>   	.efuse_offset = 0x0,
> @@ -463,6 +494,7 @@ static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
>   	{ .compatible = "ti,am625", .data = &am625_soc_data, },
>   	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
>   	{ .compatible = "ti,am62d2", .data = &am62a7_soc_data, },
> +	{ .compatible = "ti,am62l3", .data = &am62l3_soc_data, },
>   	{ .compatible = "ti,am62p5", .data = &am62p5_soc_data, },
>   	/* legacy */
>   	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
> 

Hi Dhruva,

Reviewed-by: Kendall Willis <k-willis@ti.com>

Best,
Kendall Willis


