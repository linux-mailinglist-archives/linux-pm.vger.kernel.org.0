Return-Path: <linux-pm+bounces-43087-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOCZLXQbnWmPMwQAu9opvQ
	(envelope-from <linux-pm+bounces-43087-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 04:31:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1393E18161C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 04:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F523039820
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 03:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A8386329;
	Tue, 24 Feb 2026 03:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mb+CXXuF"
X-Original-To: linux-pm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE2D3EBF17;
	Tue, 24 Feb 2026 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903857; cv=fail; b=EgNT4oKqfJQe/6fB64bJUr8pP6/iL+mFjp3Bv26AqFeod9ZHV2X+0mlS4DSVLGjSIPOBX9AlWn4HCyxjkYakvR7Bgw8wDxlNjo6xjC2pZvo1NzAMvhPS2S2NEw/37hsb+nMWQ/l+elRcXpdJfTYefnjrLttnj9jDnDMsDPi+ctQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903857; c=relaxed/simple;
	bh=u7WoDd5LkcoZPNmuAtFJj9obhL7PxPJNYgI6vJRkZmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ETEfNgnDbXay9RBj3lqacMyzIRDfO+zgHNgfc/y8vV3/1Zksv6vMqm543VUuakFn5404ZXUfpOqrgk2wf1pshY0pSqUld7r2wHVxB7U5j9l2j9VGOv4eBDRRpz0QM59fRXumA/FV0dl30f88q6XBrRc5R0FpKbL4/bTkW0ivWPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mb+CXXuF; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cL3Hv1wQ7xI/PijLk8LHb1yj+GerYv9Fgt3JsceBYkeHy56tvSCUy7yOXo8h0NqSFO90b3qJR5dHxNq4Dybw+SaL/t6J08ehQMTgew5bAPMYklDdFzMPJFgZ8D6tvq225i+BKcGSbfTDLoTl35KyC46Pd2Z+d2apYq+zCRpcRhyFBZRwHf8E1wuAMFxSKnowOhJWsmfueijInQkENw2FYPkuYaprKn2E8mTaVlrN+yyoUYmSE6bbWyUCqmvqgcUNohwgIs8icV2gNdxFkntuC4YgRO25nA27H00XoGiQ2dUnFIqQ/UiuXByPJd6t5q0PIw3hnr5y3ohnHOK/RJoTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsvBbUUe8Rj5gDNOuJe7+5pWoVgrfB3jahisIqnW1+M=;
 b=lnmqjxIkUKrxDGjPUOCt7ALN3fUnWUKrcwWjTr781IGm0Q6xj44ABwLOlf/Imkik72IsYtQDVB7Efc/Yvh2mJsJ0CTa9xzMxkXn+DWC1jpEisqI1o89pF/LJxgLzEJqehpa3kF5UZOXxM7kofmMFm8Eguqn+E6O4cBLJxo2XaDRtCTHrXx4bziv6DFdWa+UuRXmhpQKUilVk3mFh9/4wby/qB2Wt1CdKXHOo1514yAMJoz2aT0Yx8y61EZtDSMObV8tN4OcYwbSKFnMV1EombGwHBlg35M+QYW1i2E7NU2QpWJwTIpk43MCF1Z0nl+HgbyAEqJq6BzRIiPH/9MDe4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsvBbUUe8Rj5gDNOuJe7+5pWoVgrfB3jahisIqnW1+M=;
 b=mb+CXXuFil1HPX0xCwM1mpQlPUWggi18fsIIVl+nQtZxzFrzx8P/xpoo+NBvJ04byCTp4upRXAwcXJ9xYItgbjlCS+fOgouI+MID0geKyw8ks+9OgOTInjtNJbR9OtoYRa1+H8ufBPkV6KMVWzFZ2/Irbz2nsn2U0RCF91zr/ak=
Received: from SJ0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:33a::16)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 03:30:52 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:33a::4) by SJ0PR03CA0011.outlook.office365.com
 (2603:10b6:a03:33a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 03:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 03:30:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 21:30:51 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 19:30:51 -0800
Received: from [10.136.33.175] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Feb 2026 21:30:49 -0600
Message-ID: <c0979077-a229-4584-9ac3-747dfd96650a@amd.com>
Date: Tue, 24 Feb 2026 09:00:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/turbostat: fix microcode patch level reading for
 AMD/Hygon
To: Serhii Pievniev <spevnev16@gmail.com>, <lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260224023719.65165-1-spevnev16@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260224023719.65165-1-spevnev16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fad66d-5b7d-40de-a7a6-08de73551c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWU0NjhXZmNPWUIvN1Z2SnV5RUpnbmpkM0xqOVpUTzVDbUZVR2ZmeDhrcFRL?=
 =?utf-8?B?WFE3cEx6ZzV3QmJwOFZ2RVMzL2tyYWN4UXUyVjVCOVQrb0dlOWZSajhCNk9I?=
 =?utf-8?B?cHkyNXNjN0dlaWg3TEZuMGRhR3hyT2dmeDhFUnhaL1FCNExud0pjdklXazNj?=
 =?utf-8?B?cVJFU01SSFJVTzJ3VGc4cVdqNjZURmpPTmN2bGR5RG1CSXVnbU8vS3RIQitw?=
 =?utf-8?B?bGNGWmxJTGNXUUNVVG1xWkFzWWZLSTlnV05xWTFpK0FNR0VKcHQ2Ty9kdnFI?=
 =?utf-8?B?Wm5hRDhYRDY3Y0ZXMmNoZHN6dTVsWGpYa2J2ZzY5VE1EQVhER05hWDE5ZGZk?=
 =?utf-8?B?Skh1c3Nua2MxLzhjNEIyZDgvNW53VEtTS29jclQybGpjZFJsNHYxcExHUDh0?=
 =?utf-8?B?M3dLZ2cxZWE3UllJU3R6WFppOE5EdURvWE9YL0cwVmpFU2VzcUhzZzRsaTVh?=
 =?utf-8?B?NUhneWE2QlVFV3M1dU5zZ0VONzJldS9lVGhKK1FVRCtkQVViTmNCVWJIOHo4?=
 =?utf-8?B?M0F0R3g4dFFVdDE1N2J3VXNjUGFNZlRhdXJMNDlhc1ZMVldsbFBnRlA2dEU3?=
 =?utf-8?B?RURid2RHYXdFbG5PaDNOV0Z3ZjlVT09meUpGZVJTdWFyQ1Q2Vkd2MVZHZ1Ir?=
 =?utf-8?B?aGlrVHY5c3QwOThhYkNCQXNqV2tYaGhQYm9hdWw0MEZ5UzJmUnI3TjM4NlRy?=
 =?utf-8?B?MkdieEVzcDQrNU1yVWRIT3htMlVPOG5yVkhMRWYvc3hMTnI0bEdldDBYL09E?=
 =?utf-8?B?eStkUEF6eVNxNVFSREJ6bHc5VFBoaWpXRE9Zdm9wT1VlV3NSVnMvdTBjZVky?=
 =?utf-8?B?QWpSVEtQbFQvcEtSVnE0T2Q1eXZjUXVhYWc5d3dlb0JNOU42dzlmYk1VZndG?=
 =?utf-8?B?b1phVkFEd2FZdUllM0tMVno0UEQ5WmdpcmRLakFsQ2Y2ZTFwVTlpWmVDMGU3?=
 =?utf-8?B?eG5VbnB6RU1WUEVYVVFMc09ZU25helZpRkRlUHRoaFAwcUdyampob0hpL2lr?=
 =?utf-8?B?T3hlaFNCRjZuWVBnRmtYOTc5VUNuS081VGhvL1ZydU1Kb0xJL1dIZHRRMGF2?=
 =?utf-8?B?V2xIbjRDdEtMK3JsYjNLaGxBcHU4TEpRTzdQMjF5S2VEWHpEenY0b0g4dkJs?=
 =?utf-8?B?WVhpNHAyZU1uVWdPakd6dkRtMlBTNmpNdWRyQVk3di9lRndhYUp1S2dtWmNr?=
 =?utf-8?B?OG1lYlpLZ2o3Z0dhK04rMERUMyt5cERIMnJNcTZ1UmszaU5LckY1dmorR09J?=
 =?utf-8?B?aTFyd25yR1hjTWJNcGp1UEtlclJoZ1RFQ0RlV1REOXNORGJGUUJaN0QwOVJR?=
 =?utf-8?B?SEVJZS9CYnRrNWdTa052b3VhSXdyYjZWVjhCWlQwbHpuY0VRMjF3RktrdFEy?=
 =?utf-8?B?WG5zQllWZFV2S0toU3JNbXV2Z1BrNVR5a2kvMCtrdFJBNG4yd1BxMVhzMkdz?=
 =?utf-8?B?WXFhdTRoN1QwUm5PbGtTeFJCeDFDb1cyd2daaDBzdmdYbW9qQmk1UWxEb2pB?=
 =?utf-8?B?bFRHWHpoTllzS0Q1cnVwS2NlK3YySzgvSWJaVjJoWTVoVDl3SzV5NnpuQjVI?=
 =?utf-8?B?b1FLM3l3MnF4eXlGS0hhM010Vk1VWTBrWjYrNml1QXkvQXNkaGpuczZQWk03?=
 =?utf-8?B?aHRFMkIzOUtVbzEyREo0TkI4STB6MngrVGs3MGRNekhDZzZ5eDB5TVRMT2pG?=
 =?utf-8?B?ZHFOeDlGaDRybU9ocmx6elZYT0FXcVppWGF5SlFlSnp5b1M3RW9IWFpYK2Ft?=
 =?utf-8?B?UUxiMHRRUFVoUDFSWmVOcGVQTEMycTdmVU9YZkZ6ckJaT1lsUVo4a09mUGRT?=
 =?utf-8?B?Ny9iQ21uMnZqT3BoOVVZM2l1UE9GM1V2MTlUVm5zTGI2ME9tMXkwQzUrSmdq?=
 =?utf-8?B?clB0WlV4Q1lQRzY1MXZmZFhkbm1mRHB4Y25mZk50NXV3eUNHZGp2VS9lS0hy?=
 =?utf-8?B?ZXcwajI5OEdqYTEzaVVJazNpKzVaZEFndEFUVCtuUCtKTGJ2RHphdnRvK01K?=
 =?utf-8?B?dWlwcWNXWTNOc1JBU2JRM3pnamsyR1p0ZWVNaE5VQ0h1dmlQSkRReU05Z1R1?=
 =?utf-8?B?RllzVEV6UjQ1d2lRbkVvNk5jb0ZyZmlSVldRTmVYR0xXVldkVER0M3lJT0J3?=
 =?utf-8?B?LzZxZmVSU2ZFTXpYOWdyUGJpTURVZU1LTWhyb1BrcGpBc1d1cFRldFhKTnZ3?=
 =?utf-8?B?T3Y5T1M5ejhnc251NmFaczZabUNrZmlVL0dEd0s1eXVzZWVYN1N2WnJRNWl1?=
 =?utf-8?B?eUZZdzM5N3lqYlcyVmUwZGJOaHBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cH3e2lWV4Kom1L0f2JevhdjNywuOJ1P0KVl8HkFSc2ZcbavOi4op2x+mg5KFVMNBzJqF9AuOXata6tyNvcrKnjc57xhq0IXk7ySgOAsP8QKtBpMLHyriAfWCEgFSe8rsuQpRIp3VPXfu6MhrzKZDr0usFpNTcNsHbMBfAUHvDahTj5yzqxCPta35yNTavnwVk4vL4ykXnUoVM/HrPMdqs5FhF/SIIKqaVBGXb4XYtxkEihT7YMIDSenDtLV/1Fhbf9vx2UTyFI64i/3OIrL+t71vbP4RsajJ+FfQbPvB2Ae+Ygsnmvyf8tzfus5u7dQgxjyH5US7cvePk9Jd/zA0NHaTTe3P+55YCsz5LVtuYVOCn2qoPZaEAEzIIdjoDHqynAwaFgf7SfysOnHwAXDx2L2Hab6+KmYP4TWSJCYOPXqRkcc+A3AihfHwL7QPzOb2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 03:30:52.0185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fad66d-5b7d-40de-a7a6-08de73551c8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43087-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1393E18161C
X-Rspamd-Action: no action

On 2/24/2026 8:07 AM, Serhii Pievniev wrote:
> @@ -9139,7 +9150,7 @@ void process_cpuid()
>  	if (!quiet) {
>  		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d)", family, model, stepping, family, model, stepping);
>  		if (ucode_patch_valid)
> -			fprintf(outf, " microcode 0x%x", (unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));

Since "MSR_IA32_UCODE_REV" and "MSR_AMD64_PATCH_LEVEL" are the same,
all that essentially changes is the shift.

Can't we just 0 the shift for "authentic_amd || hygon_genuine"?

> +			fprintf(outf, " microcode 0x%llx", ucode_patch);
>  		fputc('\n', outf);
>  
>  		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);

-- 
Thanks and Regards,
Prateek


