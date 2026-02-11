Return-Path: <linux-pm+bounces-42530-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIj8IO30jGk8wAAAu9opvQ
	(envelope-from <linux-pm+bounces-42530-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 22:30:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FCE127C63
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 22:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34F613086370
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19836B057;
	Wed, 11 Feb 2026 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="My/PHvw4"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171A367F51;
	Wed, 11 Feb 2026 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845405; cv=fail; b=RS9S/0S3VWSdV+EEWfwCQJueuWQr9TVGzOkJ78dNv1pwPj3B/TO8qyWDRBIGTk4R1MepSbb4lDmKtR9Hz+DHJ3w3lFDtiKyDWpN7KW3m60G93/ra3gaTVWvR4Ga/cHqON8jrqDQvwog9qTot5fUSoKIe/Bs01Um8jBkkeaxAaMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845405; c=relaxed/simple;
	bh=VAuROiGiJd3Co43Z3CH0WGm6N7k2O0Zx/MjTi47HgMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=laTvg9Pmg1CsC+67NRsRV640m0r2PpeVUIFJVNKP6C16AVRcxmxMawP2IdkF1S8pyjeYvdq281/EXvDVbcYX8DTHfDQ+ygD2Qh+OBcCmdz2Zwk7LkTDo9B2pPU9io1UhLnp0hT/kLIaj0eKQe/+UQ0fcuvHd9B5d2/1dm899pk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=My/PHvw4; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpwLwUt5pZy3ZAc8bE6hHlpU8v5otvbWAT/EI+GFsglsEgn02VVlacSJxSHZU+GxEBcyurneuGdS3NG6YURU6ujkyplppn5Cy9th5uO82Ztlft3DJ2pHZbWjjEYDmd5vqpau0aDgJpJz8RwyiSwDcbc/lJ/u06zppPKv1mHOjfKvFWq/1y556hzYQuUiHXETCNqkDzeygJGxE69BbahwbWQemARBEgrXCdG3ERDAf07qyQXF7D3rJKTLd1QRTbGcANKIeJoBHO7TNRstmxajEo6QkIeKY6PRQHrYuiFKpXrm5W3Ccz0eyNNxb22YfUgVuTV6ev9OsA9AtczpAOmPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9mP/9zwF8XMSkFYQIcsZjGC1pqPcV+ik18DX8qzBfA=;
 b=Url/uy/rOlaweKvbW5MuYClFan0tMYf15sFW5b6XildW+6xGCstILCI9pKqm1cANVTHT8vk33CUWHIEfSjfoZymCca02Aa68mT+FfMyny9xX6jBMvmCMTsqNFTWV3nVAAbKgmBGMlWSQQ8Ft9JBu+oeS19xQD+eFTCxK84LwGfqNhorAJEM0BVhX86x844OFHHkgqcbjzu/v4Wayywj/vF4AAj21UPP0ENbpweg3rGHs67VM7a6ZDjDh6kwHyDs/Nt3VOW7LyZ9T+VPFKYVKdHinlHT8Tii/pbx99wvlFFjv0TiFCi/MWqxpTAWd4D13VOxhoM9rQWjPr+AVHHQi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9mP/9zwF8XMSkFYQIcsZjGC1pqPcV+ik18DX8qzBfA=;
 b=My/PHvw44Vm6+kxE5POkY0rLe4SktUSGmKrpsuxpwvSYxb8cos4y3J/0ZSY3xx52/T700x+ItQ49jYMWzVz5YjTrl9XnAp+bFiO6SNTp6yQG2QTg05mwVUNIP+pxuTBLOFR6QINBTyx2sm/m7kSrrrnkZuPumC8AcQPWcn7Xtts=
Received: from BLAPR03CA0073.namprd03.prod.outlook.com (2603:10b6:208:329::18)
 by IA0PR10MB7160.namprd10.prod.outlook.com (2603:10b6:208:409::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 21:30:00 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::3b) by BLAPR03CA0073.outlook.office365.com
 (2603:10b6:208:329::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Wed,
 11 Feb 2026 21:29:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 21:29:59 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 15:29:58 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 15:29:58 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 15:29:58 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61BLTwfg2327765;
	Wed, 11 Feb 2026 15:29:58 -0600
Message-ID: <057547c9-773e-4ba2-a754-aede29d07daa@ti.com>
Date: Wed, 11 Feb 2026 15:29:58 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pmdommain: add support system-wide resume latency
 constraints
To: "Kevin Hilman (TI)" <khilman@baylibre.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	<linux-pm@vger.kernel.org>
CC: Dhruva Gole <d-gole@ti.com>, <linux-kernel@vger.kernel.org>
References: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
 <20260205-topic-lpm-pmdomain-device-constraints-v2-3-61f7be7d35ac@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20260205-topic-lpm-pmdomain-device-constraints-v2-3-61f7be7d35ac@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|IA0PR10MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd54d4e-67d1-4e01-3eab-08de69b4b5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDJ1NkM0MHh4bUpQM1VZVnBWd0YwZUlYWHNDYzlRN2haUXB0MkpYUzB2MXZa?=
 =?utf-8?B?NjdkNStRenkyOWhBSDViczJWRUFDNVY1Qll3dW9KSUJvZmsxSVE2ZUkzZlBW?=
 =?utf-8?B?UkkrQ3E5c1V5V1pDblZCNDhlaHdWTzZsUFEvTkpOY3FKOXdoTHB2VFNzMUxZ?=
 =?utf-8?B?UXBtV0dvTHJKRE9hQ1MvUlhNeGE2ZytteVlBNFBTdzJIU1F0RE9saWJHRkJV?=
 =?utf-8?B?QjZjQzRzdEQxaWJ1RDNwQVVVUlFuV0VLbThjOHpkbkQ1Ylk1Z0xScEtMVzlm?=
 =?utf-8?B?SlVkdVJSNjBKckVkMHNIVjBUcGlNazF5Y0c0UlFPNTBkb0FYWWt1bjQwbmUr?=
 =?utf-8?B?dUpOS1NMVWN1QTFrZkVkMDl6b2JtNmlWK25VMTc3Y2FYSENlWWtjaHplSElE?=
 =?utf-8?B?NStyb1F0cTJCZHNFV1pHSU1PWUl6bWY3SmVqWEpxOHVmQkE5L05RNFpHdmJS?=
 =?utf-8?B?ZEJpQzhFdzRtM1E4NHEyVUNxNWw2YWNaTm1xcEs4amV3SUY2RE1lT1N4NzFP?=
 =?utf-8?B?VDBwUVNRS1RjQjVCQlorWklFRXlnQmpGNm0wK3FkRXRxMTlGTHJyTnpzTjBT?=
 =?utf-8?B?VlNGd3RiNHNtbG5tbk9ILytIZW4yZFNWWlNIOVhLdDlCdnl5R2w0VUJUaTZp?=
 =?utf-8?B?V1FDdEttRzVuUDNvVkN4c0FDQWpWV2x2RkJZcFdBRW82NjVhVngzMm5hNlNi?=
 =?utf-8?B?SHpJQThmUDdJY3RkRWFoSVFDMW9LZzluZkxHSzZ6VGtMRk4ybzU3bzIvN3NX?=
 =?utf-8?B?UXJ5ZnhEcGd4Q2EzVEFheFpmMllxODNpdnRKYzlDVHFCUjhSdng1VDhSb1Jy?=
 =?utf-8?B?NzdMblpGZkx0YjUrQVprbkdtK3pQRVFYbjllS1d4OTNObUdFayt4SXd4QUkv?=
 =?utf-8?B?VW5wVUlUZEhnSmg4R3lwWm9mMVA2b05DTUpKUXJlMnpxbHRTSXpQb0ZQaTQy?=
 =?utf-8?B?QmM1bTJ2VCtmWVBwVVM3SGdnREpUZU9rOVFpQThrdFQzQmZWV1lzT2Uyalpn?=
 =?utf-8?B?NUhEK3N0K1pjTUtMQk9rY1NwLzNib0FaZXpQdXdJTGxJY1NpNm1MT1ArL2xy?=
 =?utf-8?B?OEtuQWNPYjhER2ZCS25jazI2QjZuVVVwRmMvTnA2Q3JvN1B5UDJYeFhFcnJY?=
 =?utf-8?B?ckcyUDU0MDFGVUpnaDRoSkMrSHlXTVdlM1E2U2tnTkduNFRXSEM1UVNKUDFQ?=
 =?utf-8?B?eDJHdlphYTB4bkE2TElRdE9TWFQ0cDNYcW1ZUmdoWXNsenNwYU52alU0RWNT?=
 =?utf-8?B?Q1VLa0xqdittTW8rZjlTbmlON2hIQTRrcVVOeU4xMWJ4N0dqaGtsWnIzNTRh?=
 =?utf-8?B?dk8rZVNXbER5bXh4cmYvNEFCZHozS0lSWE9wUmNtS09SZENRcm9qOXRzazQ1?=
 =?utf-8?B?N0lwYmdEbTlIOG0yUGp2T2NweE5pVWJRcUFLM2RBWnJ6SkpiT2VQSXk2cGVV?=
 =?utf-8?B?YlFoTU8veXA2d3JQVWhsa2tTeVdtaHdZUHovSWlSVVh4ZXFnVHF4bzBSdHQ1?=
 =?utf-8?B?RURrTzdWV2NLWC93Nm9rUS9Fek9LVWRBWHNWV3FRQmdTVklBdEdidlkrTXF0?=
 =?utf-8?B?c24wUXVqK05tbGw3VHhSRFl2bkNTSk1jTlBwMmNjUjF5ZXF1Z0F0eGc2MGEv?=
 =?utf-8?B?MUxxOTJMOWJRaDNpS0Z0Q1V0b09ybXYvajNsTjhpWFhOV0ZuT2o2UW9vVURJ?=
 =?utf-8?B?ZThLWDUrQ3ZXdzQrQlhVdC85TWpOV0R3b1EyektXR3JUckhLRlVQaVBrUVEv?=
 =?utf-8?B?NjRrRVpQOWxTVVp5NjBpeHM4eTN5dDF5dVROd0NPY0NyK01lYTR4REZBaHUv?=
 =?utf-8?B?QWJLWVk3K3lzSkp1aXI5QWk2Qzk5enhuZjJjaUZrWDZ0UmdhODVNcytOUUhZ?=
 =?utf-8?B?TFVUUU42clpHcStMODlxeUVTM3MrTkdQa3RlSXRnMExpQUJVZVZsMGJoUHdN?=
 =?utf-8?B?YTVwMG91U0dyYVMxcEtKL3NjbytrSEQxa1kzNENjcjhBNWlFbzRMcmJVSlBy?=
 =?utf-8?B?elJoSnJjREt5WFBhT1NiSTBEMzJEQUZrcGo5MDBRSlA0bExTT1JUaVJRS3Jq?=
 =?utf-8?B?Nkw2UFJOb2xZdCtROHk0WGhFdUpEY2FBUk1CUzlNSk1xOG84RHhNRW9QcGRz?=
 =?utf-8?B?NERoNlpEVE00OHBlbFJ2THFBcW9aUkJadXRKNXhhQmswRGhSckd4STIzRmVl?=
 =?utf-8?B?VGtjNTg0S1VpR0o2UFAwTVJuaVdRSnlWTnRJeEJSNG54VzJhRXcxWUQzdmpm?=
 =?utf-8?B?dStxRlJNTE5aMG52R3kzdWpGbzhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j5PGSrkdsRcMW6Ym0+j6VIwIDPNhMOCCDYHAIhqyw0v3P6re0RtPti4a+ELnOwcFsieCkPyZQv6QyV1sG0T1LfZUPEXG3W9F14pv69vAo9PMwPnRMNCxUZ6NS0i6nwijA73JHi0AghCTrODMrr3zMkt1oOe3zd4Vk49qIbRgRi+FgNkiajEjAyFsunUvfsMdsnMIiIjmeryF7zzWWb5sROybfqurHUtxSdiHzeWTmKvw+YadMC5jNwX+9rIUtoYkv+z8VkaGOZL3uX94hK6r9SO1/T3juPg3VehBaDeuwF7AQK4rPoa32mi0g25x5rhxLuMLlZo3njLjG9N39n1HQ7iHNcx6e0P/09Uq283judmdOcsSnxFdjGvjePGYCVZCAUyk/mZrB3HuFPnfKZny9Sj6RECPfyp0YmpEMIuHyk/+OBTKA7XPPeolfJGa2cm0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:29:59.9186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd54d4e-67d1-4e01-3eab-08de69b4b5eb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	RCVD_COUNT_SEVEN(0.00)[10];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[k-willis@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-42530-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+]
X-Rspamd-Queue-Id: 02FCE127C63
X-Rspamd-Action: no action

Hi Kevin,
On 2/5/26 18:29, Kevin Hilman (TI) wrote:
> In addition to checking for CPU latency constraints when checking if
> OK to power down a domain, also check for QoS latency constraints in
> all devices of a domain and use that in determining the final latency
> constraint to use for the domain.
> 
> Since cpu_system_power_down_ok() is used for system-wide suspend, the
> per-device constratints are only relevant if the LATENCY_SYS QoS flag
> is set.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---

Were you planning to also check the CPU devices QoS latency constraints 
in the cpu_system_power_down_ok function? At present, this patch does 
not add that functionality so if the PM_QOS_FLAG_LATENCY_SYS is present 
for a CPU device, the QoS latency is not taken into account.

Best,
Kendall Willis <k-willis@ti.com>

