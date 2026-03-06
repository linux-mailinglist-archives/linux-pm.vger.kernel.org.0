Return-Path: <linux-pm+bounces-43771-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK6bAXqmqmlTVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43771-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:03:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A4A21E622
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C68A8312CE7E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D9D34DCCA;
	Fri,  6 Mar 2026 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P+3IaniJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4ED33D4EE;
	Fri,  6 Mar 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791109; cv=fail; b=u0OHsE/EqnIOarXeWqav58WY2/L8v7x3x134azSCSpuLTit6uVmNeXyYuph0R+q3BljTKEUpLOUuITsZlAxUBWqkb04drz8hPBzm6noFkuwTUZOTmNQiqSyPn853Nm6aHNrLADLqvXdyocXrkDb8GaIfzoMr9BmcFkLHSX9WFb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791109; c=relaxed/simple;
	bh=TolGaAjP+hdGIKlApaDjQYDyC7YRz09x4VAJmANDTWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQzShdIGvrbKmdcHfPjgVgmFlXycWMJpMg4H80xoOrBFXqEze8fRBADJvEyFMYhDd76ZK80jYNmRjb/lOQJdbS2HBJN8KG/+CLJrSSbC+RCBsIGzy6De6CxsTIQ1bamBIWNDJlGkf2b+wst2GtTfB3xEkFHkjv0WwmX8JbejiyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P+3IaniJ; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3QhX/iqEa+xrgmj+ZZOaSdnik4X+xUcYFQsQGvtIZca68cE0HKatb2U7o2u2Sg0+1j1xxlddSH7s4H+KcyRmEOz+iwuWw16rqraK+rAtPGscrvPn09F6saOnjMQfFJvXnbPCuGN5rDaj24zyW/tqbfJ5vzK656nrqJw4oKk7FHUsDHGz3dnjjFOktUbghsl/pwUoqKxZOfsldGBtx3SSAr6MoCr0iPeWqc9FWyO58SWa4dU+ntMfSuZp/+e5cKsKpWcNx+r0O2cCG2EMiKtdR4yFGWfV8KeM5hgos81/pGrp5AmP3piYP6me2pHG2NCEC/2uCKR8s+eY2aNV9FjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pzlpzA8yGLtPHZ5le54owSJpjZDHrFVUWKfr3ILc4U=;
 b=Dzp+RhPDn4ya08dl4L5+qZlZEQf6pAAdc5B93havRqM23IFHw59McNUDbxp8opsXNDpVWiYEYmqOZ78Zy2C5ViIg6FtytsetUO3x6JianOVr7p7jkztzxMFy/n52b2PPizYE0V+zMtJxsljLcjeoefoqsPkRGenDXjGKcmKwcvu7gJhBD9305yuJIm+f9hZecaqSbrFZF1gGYgCmx0of6CjLJewhBZ9rrssy5QOHKigWIKzQIVV8Qg2Wx9p8hH1ncxEQQciNXNGdF+l3IxESw0NRhKSocVgOGj2K8TADLj1lVo+kpcvCANmf9VPDXjgGzqQAO6xXs7Q5XBnmjBxa9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pzlpzA8yGLtPHZ5le54owSJpjZDHrFVUWKfr3ILc4U=;
 b=P+3IaniJ3IdFyVW0Hf2BW5lR0kmZ+G6nbswb3ZBbirtckzeo/3LWEOGzAQGXKcKY5+q41ShbogS3ehPxGjFSGD99/igD4Vtes1ElPoV9kPkISTIkMwXtiDFdk7500vF0Bfq6EOXNTqB38kvuQ+JpioPDw72PTjyk+QN3pNuaHaU=
Received: from BN0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:408:e6::11)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:58:23 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::ba) by BN0PR03CA0006.outlook.office365.com
 (2603:10b6:408:e6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 09:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:58:23 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 03:58:20 -0600
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 2/9] amd-pstate: Update cppc_req_cached in fast_switch case
Date: Fri, 6 Mar 2026 15:27:46 +0530
Message-ID: <20260306095753.17155-3-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306095753.17155-1-gautham.shenoy@amd.com>
References: <20260306095753.17155-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7e6641-ef17-4016-dfed-08de7b66e79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	YfVKj8fsAqXxGnjjg0BadkTNT3PckL3Lg3pddlOA3OBI4G3lYtouWGg0yMZiA8OJz28ej3SS5i2pG9swXyoBzQ1RGkyiCp6zZpzU8SSe+2TNlZ/pon8LbcwqZGWTQEkqV7zkgEDj34TZbCNElZXnxgOQ1WVTgqpBidLA8xEz1fhznyYHbjTOjPugq0bRcMAyAz6mu5zseCMVm9zB7x76zohO/VFNqsU8TRA2W7jWOoJRXYR0u3b+BqzFsHyb53113gW146YWgg4SUFdHIVpRtq4SWIk83gvrYRYw1ecFuN6NY2Lb1RcT39YK2dQdLeys4SdU9hgoXVaSivXK59ngejHazMuuJywE7F1Vhi6pKj/BnojV9lodspsvzhEN6WObmZdOQn+7bQlE0lNXDEqdjxPi87qNJbsL1L9IsoqT8ezTP8r506dBkA+Y/0VAGV0aGonLu+mqMg4IZT2THW6/QnKopI8AT5TAp1rX+yEBaqorj3cgzv1I4wcRznEIkRO4JeoxhqrRMRjjzGRakvoW59oBZX9Htur+RbWJamfKuARg/iZ+JEuyIOC0QS3AaYEdKVBVTMK3/4jUUSJWh/Q4bFOLUP7Fb9ifTQJI4khKMaB6A3ZDEoqZ2Ne/5QCYeyS08Rz/Vu8dUIpZOxDjVvjzWVa4RSzpK6O2uhxAI0dH859zexrPIvhMiUgh5f4qY/XbcGma0b3nCpxVgfoCoLF+W3l9B7S9jDE3MpOnH5O9NwcCqdY/Q9InHZ+W0pSauw8bduIR+R65dpeNqBRUoZDf1g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eP+wUdqFRFLDN72U8q5gsA+aMnxjw7k99rVpbSGFxaVFGm1NkB77BoWeLyQAbdLejUXnRdlPET8XLqTk14vsrS6haKOWT8etOQGsMQtkxJCoCqb9007jOcpcl5iUtP4c98s/J8E1oahT2XC0F5JPQaiIrQTUAQX+2ybFEzOXU4UylsBX3vQUqxmrOPlF+c4UHGMHJ7BZjE58vaWOGSm83czO5EVSqvHiKu80iYcKCUUwLrZ/33VzEm/VlSENAag+THZBWeYi6sxBS+et9N/d+dp+NCHskw8L+vvFBfkMCkaGFy/mXzrA9SX7Sqty8UP3e1Ln2UDvrKSqWbrvDFz1pVl+SbyphZyYBD6Ibuau71DOwWeYFybEIPjRGe7kqnvhvQ3DL58GEYI0ynpjbXrZX1MMLFSN3OBZEE6D5yZRsMw4gUU5hEG+ezJPxQxVAzMU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:58:23.5393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7e6641-ef17-4016-dfed-08de7b66e79b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
X-Rspamd-Queue-Id: 52A4A21E622
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43771-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gautham.shenoy@amd.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The function msr_update_perf() does not cache the new value that is
written to MSR_AMD_CPPC_REQ into the variable cpudata->cppc_req_cached
when the update is happening from the fast path.

Fix that by caching the value everytime the MSR_AMD_CPPC_REQ gets
updated.

This issue was discovered by Claude Opus 4.6 with the aid of Chris
Mason's AI review-prompts
(https://github.com/masoncl/review-prompts/tree/main/kernel).

Assisted-by: Claude:claude-opus-4.6 review-prompts/linux
Fixes: fff395796917 ("cpufreq/amd-pstate: Always write EPP value when updating perf")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d57969c72c9dc..24cdeffbcd40e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -261,7 +261,6 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 
 	if (fast_switch) {
 		wrmsrq(MSR_AMD_CPPC_REQ, value);
-		return 0;
 	} else {
 		int ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 
-- 
2.34.1


