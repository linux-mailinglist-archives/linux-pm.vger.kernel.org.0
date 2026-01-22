Return-Path: <linux-pm+bounces-41309-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DaJLFdRcmnpfAAAu9opvQ
	(envelope-from <linux-pm+bounces-41309-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:33:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F4B6A077
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6CAD3000B15
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A89353EF3;
	Thu, 22 Jan 2026 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BUDjDSkJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07173DE33E;
	Thu, 22 Jan 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098630; cv=fail; b=SfIBBl0Y9IkNLmHXAa6S/ZKJrNYDj1Ir0M6OyrhTds+qsb1FFrl5w+v8pwbRoarzNW9Tuo/YM70zPMdOASjirBZEeYcTQTsCAJZsKPw7IZgrxCnal++ZGaQKJvcsYHoBxxbfLEtOxXrxTem1kKB6OR35BqSAzz33KlC+E2pYZsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098630; c=relaxed/simple;
	bh=aVMvPvzLz2D3Oj32MXk+c3FFpHn6wOKrdEd3LNR7d+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d8PmpEb0+rtIsVUf6wurMT5iWZFkMJbqbpg0WTA4huAR/fYMIhe5cE5zNp/dZup4MbzDTSUmQqynwrihS02L1WM0SUlmcu99F/YovRqnxcn/HDCHV81qYwuelUHRUlv5+6WJN3pYLsidewoDtT8VOrlaExI39kGlif8vlod1aeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BUDjDSkJ; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie/QNYvxm5U7RUGUL3alwaqic5iTRkq7SCHVvETCCsBbkyvsiLbaEU6EApeF5FZSBO0H7qoRGfm8IBRypMgYiCbaG4L6rAa8o6DRNiBkY0S5Q8D1xg0wC+loh/seBOMmZO2uH9lTH4w1Y44Bq0k/I1op+kBwvZpuC+kdTE/GWofTcwU55VkdSBpJ4SoLLaTtT8Asn+xidMWowVY6mj+cqwOSg/uadT3QH/rl+Ft1ZaF7WnJcg7JRyMyx4aUmp6wu4vYpKrON4oRM4pp5XMqVsaB00mV2+1EC64DSe17yxdD+JenbOeUc1FU/0jR4CElgYXgG6lLYf+Mk+I70q21qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkd+rJQQHwMrZGjkb0HBndIJXor1a28QM8PN+I5N/5s=;
 b=Pz8D/BAdoUhLRgb3QoHat95bgHop1QohNmmNCwP6oKsb0uyXT39ZSVwerGJmZr/nM+0M5cNci1CkGlbstot/ksRbTnKs4DBVXlVnHjNv89Ha5NlXNSfEQg5Vm7aP463s76+6zKAvAwu99mHjhMuEKw6na3w/iMIuibYlqXNK5pmFgTK7hZ0Dfd1eLS840wEP3MGeQAJW04oKBtw37ONtmI34AgqaQs5bf/QFUby/LJgcfgV3hVAs2F6mr5V8FvDYrorCa4cfIpJ4S/OVveAXcKI4JbOPrmUl15Mt0zyepXWjA3mhJSrRDWptkj9qUEBIdMTBiVhh3plcvAvdlW2dPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkd+rJQQHwMrZGjkb0HBndIJXor1a28QM8PN+I5N/5s=;
 b=BUDjDSkJHZB5B9l3tlqYTQb32NVaSNLWR7ZYKizvALtP11ec/842akZLxlxh0Y2GcbxD76UxcO0uOItZSN/SLx/GBzDV4P+ROlWT8F/qd8ybZ399SmmOqSsjpv9FI9XupFrXVbpOFPjYavyjAWj873Q6YXG5oNPjm4Ggl4xXDxY=
Received: from SJ0PR05CA0204.namprd05.prod.outlook.com (2603:10b6:a03:330::29)
 by SA2PR10MB4732.namprd10.prod.outlook.com (2603:10b6:806:fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 16:16:51 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::de) by SJ0PR05CA0204.outlook.office365.com
 (2603:10b6:a03:330::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 16:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 16:16:49 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 10:16:48 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 10:16:48 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 10:16:48 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60MGGmtm830365;
	Thu, 22 Jan 2026 10:16:48 -0600
Message-ID: <093e47d7-283b-470b-893b-318afb5f0afa@ti.com>
Date: Thu, 22 Jan 2026 10:16:48 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: ti: k3-am62l: support cpufreq scaling
To: Dhruva Gole <d-gole@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Sebin Francis <sebin.francis@ti.com>, Bryan Brattlof <bb@ti.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20260122-am62l-cpufreq-v5-1-65c50af71681@ti.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20260122-am62l-cpufreq-v5-1-65c50af71681@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SA2PR10MB4732:EE_
X-MS-Office365-Filtering-Correlation-Id: 16772838-a92c-4d41-07c3-08de59d1a5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXZubHpRR2hHbGljdmx6MU1UTGxMbXVlQXkyTTY1Vjd4K2RYcTBwUU9BYzAw?=
 =?utf-8?B?NWw4SXp4R0ZLSXFjTjFRc2F0cUhVaTNEUTRZTHZLYmRoVjd1Q24rNzJMOTBV?=
 =?utf-8?B?QnZRNTBpdEFaa1o1TGdDSXpBYjFhZmYrTDhGMlAvTFVMSVVkVittVk9rSG1U?=
 =?utf-8?B?ZnRhdVk3cEFMMDJ1SHNLZmdaZ3pSYUpzWi9lR0lJSmNPVUNJRjZSS0s1YmJZ?=
 =?utf-8?B?UU9paGI4TVRxTVgyNitTWTZEY25qMHF2d3liaktzemd0bEM0NU1xKzZoVkpo?=
 =?utf-8?B?ZGdIMzdnRStYNHFoWkk5Y3Q1MXhBNEs4djI0SlFUSGZFUzJqMFlPeEo2Q3BU?=
 =?utf-8?B?eGFTZmI1MkxOSnRYZFdKcGt2TTdUd3pWUCtVUFlaUXVReDY3VzU5UnZ5WHZG?=
 =?utf-8?B?RTRBZ0paMHdoSS9HZUlFUi9wbDQ1cGM5dFVicWlEZFpSTklZT3NZWTJIaTZM?=
 =?utf-8?B?WjRndGNGMmZpaU9HWkt1dXh0bTlxeFpwU2gvd3VlbFE0Q00wOU1hQlg0RTJR?=
 =?utf-8?B?Sktqang1MkZ4OFBZQi9pbEFMUkYvNUlhTHpnd25Wbm16TDA3ZGJyVlhNZDV2?=
 =?utf-8?B?MC9tdzNwRVd1Z2VLaDZOTjRMcDhLZ1VsR1VCaWxWSER5cXVPdUxnSnNsdWs1?=
 =?utf-8?B?ZVB6bmgzdWptZE9mWkFBcGp1bmtFY1UxVitPWVBKMytTYWQ5REMxWnBCb2p0?=
 =?utf-8?B?SFpMS3BRV1pQTHE2NkFod3ZmUGI2OW1wcTZTdGt6L081aHNnamsrQXZOelVk?=
 =?utf-8?B?QzREQmxUbkgyQzJKODBhazMyZnBVM1NTUjB5L201ZWFxcnBob2RINFpTdU5j?=
 =?utf-8?B?KzQ2YzF0L3Jvd2VLNEVwTHFhS0JsczVBeERlenVqazgwdzZlREZsYXF6WXRn?=
 =?utf-8?B?YURUNldEZ1Z5YjkyVHlmMDJ3UFVmWExQeHpKMGppc2kxMlNoWXo1anNhZkRs?=
 =?utf-8?B?V1FVbldPVW5VN0ZTTXdCWjBTaWtJRFh6WDFtc1RkbDh1Z2hDVmN1ZFlMb1RF?=
 =?utf-8?B?ZEcrOWdNeWZFTlNiNWpGblhtelBNdFdQNUYxaEtSZFB2WWxXcm5Kb1RCUVg2?=
 =?utf-8?B?TFBsaWxrZ2xRVEM2RnZPSElXbUlXc2dMT29vT2Y4T0NIR09vNHkxV2dwMUtl?=
 =?utf-8?B?Nk9EWW5EMmVoMTA1dGxJNnZGM3BYeXNZQ2ZVckp2TmNJZHpwaGdJOTVwUUpE?=
 =?utf-8?B?bTBGUlN0aVg0SXZvclk2NW5CQk1LUEhWUHBVM2ZaMkx6Q0k4NXRWdkhWcldj?=
 =?utf-8?B?RE9MQWFNWC81RXE0dTgrVmJzeHFSR2NQS2NnUVNKMVNoN0xyUWdJUFR1TWgy?=
 =?utf-8?B?K1ErcWloODNUbGhWaEw5Nm9BZjZCOTN1dE9kY1V6TTZuMHlzK29RSE9sQVZX?=
 =?utf-8?B?WlAxZ2phVFhLVG9LY0I2TFkva2Y3ZDhlRUpqeGZ6ZnJMTm5PbjRoY0JBcGRB?=
 =?utf-8?B?YUZaYXF3cDByUnZkdmVuTkd5V3Zmc1hpa3dPeXUzbVBZWVF1bDZPaldiK0tC?=
 =?utf-8?B?a1EzRWQ0SDZKNEUyeUdXS3Yvb2lXZllDcGlwZGpPbzc0TFZuY1pEOGRsZjZB?=
 =?utf-8?B?NWlua1VyMWxrSGtDNjdMUFZDOVZQTDk0LzIxTEpDekRwejdtVWllZUoyMjZE?=
 =?utf-8?B?blFYc2c3a1k4OVdEQzNOczVJSnUwRDFPS2hYa0hQVEJ5cWFRZEJ1dWpJNHR6?=
 =?utf-8?B?NStFT3BpY3VhRVR2WGc5VEYrM1JqaFRHVnB3SVNmZFUvZHd0WHROQkdXSDJP?=
 =?utf-8?B?Zk5vMjRGbnZTTEthOTk3ZnN5dE9CL2VUaFFNcG5oZXhkZmZYOUxOOGZLa2Jq?=
 =?utf-8?B?UWQweitxd281ZEVmeGRoS1NVVllKR1g4Z0Y4UWp5RUZpMEx5VG5wV0ZsNjJo?=
 =?utf-8?B?MDM5MjFXZWJKZTRRaG1XZWZOR29Celh5a3NnL2RxNWFhNHhib2pMYjdHeFVU?=
 =?utf-8?B?RGk2MkNCSTZ2N0ZpQUhnYXdJNUUvMEkveElRUkZoektoRGludDloNlVIdEYw?=
 =?utf-8?B?WjBuY1kzdTRmLzY5Mi9SMmtvYTNXUktEbnlsemNxOW9kY3lBYmJidWtaSnlD?=
 =?utf-8?B?d2ZsaXJNM3RqdW5GWHZEc1hSUlp1ckJQT3NtN1kzUFF2ZjFjT1FHQjZoazdU?=
 =?utf-8?B?cE5oZ3lGcE1xcXZRTGp3TU9VWno3Tk9oYlA3UnR1T1d1cHJRL2lJeWljMlI3?=
 =?utf-8?B?cDM3QlI2S1AwMzhndTU2R1FQdkFEa1lESXBnbzR6ZnlpTm1CWHZJdDVaTDRi?=
 =?utf-8?B?TUdFd2VEVUJMQUJoMTAyY1JqODV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:16:49.6603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16772838-a92c-4d41-07c3-08de59d1a5cd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4732
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41309-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k-willis@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 52F4B6A077
X-Rspamd-Action: no action

On 1/22/26 09:43, Dhruva Gole wrote:
> Enable CPUFreq support for AM62L SoC by adding the relevant OPP efuse table
> syscon for speed grade detection.
> Add the operating-points-v2 table with CPU frequency steps from 200MHz to
> 1.25GHz.
> Specify the CPU clocks to reference the SCMI clock controller for frequency
> scaling.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Kendall Willis <k-willis@ti.com>

Best,
Kendall Willis <k-willis@ti.com>

