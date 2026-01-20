Return-Path: <linux-pm+bounces-41162-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPcuF0UgcGlRVwAAu9opvQ
	(envelope-from <linux-pm+bounces-41162-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:39:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD04E9A3
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 821DA841D9A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE1042315D;
	Tue, 20 Jan 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eGBhf6qv"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE753D667F;
	Tue, 20 Jan 2026 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909691; cv=fail; b=UYitSOQz/JjcPnG5RiY8rDPr3EaHlT/aVkjZnKxSkwz5ZmAU6WovZLrWxwIqoHS/447tUMgDPHsqes1EFdVl8Jz0s4uUddQSmkyuZ+XEVLsfIrMI37CFtNvfnmgs1fMoyE/Q8vPHobXTx8g9WHfLsFYO80qxNN9J5b0HUn5qZg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909691; c=relaxed/simple;
	bh=8v/zDvOO4UFkS29Vc+4D0FdG1Jze6o5TPD0rwb0PGpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K5+jUkjoZvC8L4ckUOkb5BcIH1UlsGznmXYVgsbGuV696uDCOuAK02wOui927Dzw9yfFfNExHkqjIo8YiFmE08d9qbJy6DXmSAF4htPiyBcRsDN1KGKZWf3YmTgXjeqw4hcQUonbC++QVxkOZdBsrDSNdt84K96oz4wiYRDpSys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eGBhf6qv; arc=fail smtp.client-ip=52.101.85.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+sIOaGGMB3r9R4fhv9X4oiZUjsNAFUMjuLHGVutoTPRzYaqnekhvGjRpQS5hya+CsVGMW3Shy2DWY3yzDwdE7tYTcjNJN77NmKpJM8PaQOJmWO6DFVCaKlRX9zyDV8w+IUHteBZ+dmab7BuyJmC4Z5ZUY3UYpnAlDxyHErUmGu/1YfCI71HVjQF1uyJsym+EupcR5mGMl3vFMv4/MpsjWWA8hwHkKIGH5NK/ZdlVtrJ/pqUBVryQMEWGXc7uji9d0bbSHvYGqIONNFo3vpfVLmY1LvShlCKbLvgKITpTWj9b2Sn7U2ZIrAQSdqus5ra4hFranxOkpaJj9dAwOcxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/XlGIFy9699WXLM+ybWt4TiGyPTKoDNysz7mGjB4No=;
 b=XrYzuyc00OPdwsJnEZJr1nOpt8bxTg6Sdf8nDnxjYTcFrrkrboVkIcLJQPRkMFUA7AY/AZL69SqMJBvYdrmpyRvmUe8pcvnx+doMVgfbi8NYffXsHcTf4qcJOlL0PL8E/i9Z/K2Rom3Thwo5R2wePLiNi6DmqRKX7EJhHJhSCSYAFwlWblLRvGfoDyslCQESC3IylhjlAjoemnW37sMGMvsqe5GG7DvCxLs6cDsdlXPUJc7NPbyxTtvV+u3IPrMGQYRPdZTYxvC8ZDCCfIHQX3rzZbpjv0VR+RI7Kfb2YHv2136oI+SXXNjggAk38PjNgc5DlCsBZxKxzs3YC+Lhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/XlGIFy9699WXLM+ybWt4TiGyPTKoDNysz7mGjB4No=;
 b=eGBhf6qvc4QzFeUpXe8GRxUg1Tb/6IuL9X8Oo21uwrfLqVmbUmruojoBn+xZzNAFeX+2WiBDQlF/AdeYPcKhVBO8ZpX1OfVZr+3f+71zqffAPicsOPO9DXR1qKUeW9pLD+AkkflC64zoa2Hu2MWa/Sf6uP3dc2bgq03ZaynaztY=
Received: from SN6PR01CA0031.prod.exchangelabs.com (2603:10b6:805:b6::44) by
 SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 20 Jan
 2026 11:48:06 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::b5) by SN6PR01CA0031.outlook.office365.com
 (2603:10b6:805:b6::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 11:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 11:48:04 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:48:04 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:48:04 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 05:48:04 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60KBls141151397;
	Tue, 20 Jan 2026 05:48:00 -0600
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 20 Jan 2026 17:17:30 +0530
Subject: [PATCH v3 1/3] cpufreq: dt-platdev: Add ti,am62l3 to blocklist
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260120-am62l-cpufreq-v3-1-8c69b80168a3@ti.com>
References: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
In-Reply-To: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>,
	Bryan Brattlof <bb@ti.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768909675; l=1104;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=8v/zDvOO4UFkS29Vc+4D0FdG1Jze6o5TPD0rwb0PGpY=;
 b=3VHzpnD+nOXKUvENEMp4SAqkSGhwKhEWIkEOkPI5UM6bWliIE4fo8tV/hGUSfY2kRoMVqP/l0
 /Wi5wyF5N29BV/yyN1D81qmzW4qZhBCRDS5uIkwlt0sHWDTRNrIqyL3
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SA2PR10MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 333430cc-3f22-4e86-cc98-08de5819c5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUpVYzNYaU9PeVBjMDhFSGQ3STJ5YnhRYkJNeHQvenc2SktEeTRwamhyL254?=
 =?utf-8?B?MWU5cnpLYTFWTHZWaWt0S1hHWEo5QmhqMlZRZ0pxNnlSSnp4S3FyR0F5VkNE?=
 =?utf-8?B?N20wQUNkdWNWYnFNZDNrT0c0Y00rMTBPemJkcSs0RVpObjdTUm9OaHRJTUM1?=
 =?utf-8?B?VGVvTnZnTEJvQmNSVGd5K2xnSzJxdXZ1TmZNdEQ0NXhoQjNZQ3duUUFuMzgw?=
 =?utf-8?B?dEQxMHVFcmxsRVRsQlh1U0J0M0t2ckZPWUJuczUyN3RhdDcyS011dDJIQlZD?=
 =?utf-8?B?dWJoZzhoNU1OTHlYQURwV0xsekVQbUlRR0hvZU94bEFXbFJySUlZVzN6YmVQ?=
 =?utf-8?B?SHpXRDVjeFptd0UxRUdEMklhdzF6SmRLbzNqN3c0RSs0T0l2REU1YmprNWcv?=
 =?utf-8?B?aklEa3huV3YzZHd3VHRpSFVvOTl1MVFQTWExRHl0UkhHMzFXdHEvTm0xMEVD?=
 =?utf-8?B?OHNlRDhad1VOT0dneERWcXVwK0ZpdVZRT01BVWRicVkySEhJT1NyQlQrVGxS?=
 =?utf-8?B?UFpiM2l3Qjc2WEp5NVloZFlIeTBXZDdBaEVUcmhTNGp5Vzdoa3AxUm9GWGNN?=
 =?utf-8?B?TWFXU3htMmluY2xSeEx2ck9KRUl5ZlpGK3FaTm1IbDhwTE1JSkEwdlFMK3hS?=
 =?utf-8?B?aTJIUGM0QU5KVTBGcExBZXlxZXg2Kzk1cjgzaUNhTGZzTzdaVjhXWnJUNDln?=
 =?utf-8?B?RGM0bjdSK0UxWE5xb1NkRnNvcDU4bVlzL1RGSWJXdUl2SExxYzR2ekhWZHFo?=
 =?utf-8?B?OW9zYW9QYU5LZ0I2QVAvS053b3JhZ2JESlIyc3JPRm9GZnlFNHNHeHJRNys0?=
 =?utf-8?B?VnpPc1FaNkFsckZjdEYvaHA1MnpoN2xzUHphenc2TzdVcVRlVDZEaWtMVFBo?=
 =?utf-8?B?ci9Xb0kxM0ExcGFvb0p4MjkzQnBLT0lnelUxTm51SzBUVG01R01pOVBOUmJy?=
 =?utf-8?B?a3Q2dTQ4Z3J6dVlMMnhPNlkzOGc1a1lUdTNnSkdPQkc0M2JEUEVuY1B2YVlm?=
 =?utf-8?B?d0FrUktSYTk5SExzUVJ1S0FyTEpudTBXajl5U1A3SUZpUndrcTVHTEVQVHZr?=
 =?utf-8?B?VGVvTCtwb2tPWmVDZXhDWUh2eEpPUlc5bVJvWWlISmwwMlNDWFgrRjkyenBl?=
 =?utf-8?B?SmNtdlJKUy9KdktaeHNnSnRzQ2pwS0hsampjK0JxaWZUT3pYTGZYVjlVRm9S?=
 =?utf-8?B?NDlrWlpBWGp6Q0J4RkNJVlhOeHVsTVp1bFBuRzg3WXY4MklYSlEvbnYyZXFa?=
 =?utf-8?B?b2gvb2NtNnBEYmRCYVdGUkhScVBDZGh3Q1pJK2JicTU5b2Fidkw3d25HQyty?=
 =?utf-8?B?bDU3REpqOXh0Ums0bktONHZoOUNXYXE3RE1ybHZabUJ4OElOL2I1TURDUzlm?=
 =?utf-8?B?WENodzd1dlR1YUxsL0ltdGpGT21yRUpWaE85UmJxR1RPUHViMFlYUzQ5NUQx?=
 =?utf-8?B?Q1ZYbU94YnZ4c3VGUExma2RtNHI1ZExBeXg0NXVqSm5aWW0wQkZhUWYyNlFp?=
 =?utf-8?B?QWgzNk5ZNWIrWmVPeGRDT1ZPMVloa2Mvdm5LOHRVa2FQODNJaHBtYmdwS1E1?=
 =?utf-8?B?QUJHQ08vWXUwYWZDcHowT003cUZTbHk5UlRPTkx4UjZKTjVTNVNESGhjSmEr?=
 =?utf-8?B?Y29sT3VRS08yN0V6SHFPemtuQWFFL3FzRHNoeDZQb0EvUGlyUE1Ob2x1NkVV?=
 =?utf-8?B?KzQ0TWFYNUJWTlorUjZ5MjhlblZ5SWR2WS9tOWhLWllQSjI2UEhWMHJGRm55?=
 =?utf-8?B?dTM0VDFWc2tEWHVIY2lCUjhqbnNLT3grTUFBbGYzZVM0SEoxT0VROTl2WEM0?=
 =?utf-8?B?eEJjVmpaTTVDVzdBb2JOcTkxZGpRVkp5UjdqTHRaSG1UZSsrSnlmZnRsVjNP?=
 =?utf-8?B?Y3FKellYdU1oTzVwYXMxM3lNOU1SYkkzNDBqT2wzRGFQQlpkbTUycTVUUGVu?=
 =?utf-8?B?bnBBaGltbGtzMjFlRWVSTVlNaDFYMWFlOHU5YzNkR1pQb24vVW9pSEVLSHJ5?=
 =?utf-8?B?MkJsOWdOTklaZUk3OWJ6NE5vVllHb3Z4S0plSW9BeUp5RXlwVzdpVnBNMWF0?=
 =?utf-8?B?UkJlTnJGTUJZWVpjY3RmVXk4L2N1SlZTdEpVN000TTREZ2pSNnZNVjVTNjEw?=
 =?utf-8?B?REZka3g3K0ptNzZnc1NIQUJNYXBjMW1JQTZHaXdKOG1ndndWR0Q0MTZqbXgw?=
 =?utf-8?B?SU1EYUNrLzh3VEZsRXEwajlEeE5sZ3hCaDdSMXRhTlVTcER0YitLYzdEOFNN?=
 =?utf-8?B?NnVwQmIzTkhWM2xhWkZlcm4xYnZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:48:04.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 333430cc-3f22-4e86-cc98-08de5819c5d6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41162-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ti.com:email,ti.com:dkim,ti.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-gole@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E3DD04E9A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add AM62L3 SoC to the dt-platdev blocklist to ensure proper handling
of CPUFreq functionality. The AM62L3 will use its native TI CPUFreq
driver implementation instead of the generic dt-platdev driver.

This follows the same pattern as other TI SoCs like AM62A7, AM62D2,
and AM62P5 which have been previously added to this blocklist.

Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1708179b2610bca6035d10f0f4766eee6f73912e..16310e190d9ff96af3d20cc5d98dc0e4af4d1bf1 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -193,6 +193,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am625", },
 	{ .compatible = "ti,am62a7", },
 	{ .compatible = "ti,am62d2", },
+	{ .compatible = "ti,am62l3", },
 	{ .compatible = "ti,am62p5", },
 
 	{ .compatible = "qcom,ipq5332", },

-- 
2.34.1


