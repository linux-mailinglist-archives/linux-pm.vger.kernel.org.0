Return-Path: <linux-pm+bounces-21379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8FAA2892A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E3118880A2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053D522A809;
	Wed,  5 Feb 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o/3BYcPx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9215198E;
	Wed,  5 Feb 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754810; cv=fail; b=HOtVycsLZdoWAcjLG8G1VV3HJaiQlLgJ5FVqZCH4Xib3pESYeTXIojcEMz4tilHrIOqebU3p+cO7oH3S4R0rQ/1ZgdL+xOSd7QKQk5UhJ7RkewOBy+W4XFmfhWn+C+HNfE0D7fHk01yFCpH1qhrM2idKzgWL3CK67vr1WD5AY2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754810; c=relaxed/simple;
	bh=i/UhMLPmCacK3mB3v0BhslvvqNKno8mc3Ai5KE4xqCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/MLFAIpXK6S3f4Vuugi2EZyJcZoh0bm3a6IqdIlDQL8ZxIlkkYiGHEUI8rB1oJNf3yId6dNM9NoV5O/PuqbjEt0URFnI8NVVWzYZJ9+oIfx9dwBVjGWZcup/i7ZjTmw7fPe9Ec8mXbmUNg4HO9AoCEveOALX/eXyVALehDsU9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o/3BYcPx; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0fh+tKfPOqTpPU1LRsuunsjCCO1nZAbUaelewz/OdhJXo5oQSaKQz35685Mc+kZ1++thRx4X5a0XnVIOAiyAtVlAUP/ik+JjopXFUHYtVXv8ixjZiBdE2TYJ8PvP/do3U/N3kuUVe5lPf4Xyp7t2ms/3lvyF8s0X/Zq4BtC455mpNFFp7SayRAu4A21ozvJGxZN6wSShB+dE25lHTlHS7Hc1g8zRLuxMfdUcJRewT/5HAGQZPJQ/CtHcwC2IiTrl0ShdlwqBQ6BchoFLyYiKma65RCubcxRGLH0mkc/IyakwTbaguS4CyZmYUt9mANMoKQ4ZE64eECcR4TKmY0jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh6P0DUicvv/5Zr6R5mg0S7MRkYRxjIi4MYblxmUzNs=;
 b=v5p98NUWYVc0RCDciHxIm7sBX4nY1DvE5nW5XRWzWaek+gcYPjRlMUexb5FBWJtmOx3SM3idhXhH+RZFOc969BMtAh+/raUWU+6bGn3KTeVAYbyjDfjM3OO0A2JrYS5rEtkUUwSi3nMluBw8p9H9XAxZobrxx2XAZUbL0pCpQ1SPTVXX7BLTihPBnJj03l9wAhlxGjCJbA1VpUakfA5PLL3GGJ8VJpAANV/bH1kJTvtx35Q5RABT532SKtqcpCauqBJ3FOH/8CRN1T1DwpGlacmI2cV2xi9qyyo+tidT6ieqLCdk378D1i/YziixolG1Ju/c4bjh8zJPlCdcMcR9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh6P0DUicvv/5Zr6R5mg0S7MRkYRxjIi4MYblxmUzNs=;
 b=o/3BYcPxaw1Ud2I7MYBzIJ6sbSdn4d4BTUVhuqKV3HdqpMn8CpzlHPuxWz8oWnYbXdvk9vlW9Gt9dyge1JbDnp7Y8LZtic5UFgMzpONqbAXSvv0jsS87vSGtwthWPU3rFR8cBbmjYkz1H6iRuOrwkI45tursA/lwGODMLYCguIU=
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 11:26:46 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::6b) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 11:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:26:45 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:26:42 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 04/12] cpufreq/amd-pstate: Remove the redundant des_perf clamping in adjust_perf
Date: Wed, 5 Feb 2025 11:25:15 +0000
Message-ID: <20250205112523.201101-5-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 501ad802-3e11-4836-1d34-08dd45d7f955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4qip58V+jH/Sje0cqLI89MmlnOK+FqlTy9v/26TK3cnY5QtZ5uhvESjOAmji?=
 =?us-ascii?Q?KNT6aqJU+VnRI3HYbxwMC00C5oyvB9Zn0RZv4N193OQdBJV+BGIEZseZxu7+?=
 =?us-ascii?Q?1hkoJB8Oyw0iiXgzsoygKF4eNAXmxIvgFq2/QoD1KEAYXSOc+DextG+806/L?=
 =?us-ascii?Q?89h5avEwhsMZqHp/7CZ8o8913SzDyHfxZWKvdYHTX03iVcK+W6CPeayhaXb4?=
 =?us-ascii?Q?ynFEhtOhT7OBTuWytyAznGXeeC3ck8tpNU4Da3eiWcRRgAolGcfCzIkeZYdH?=
 =?us-ascii?Q?FvheDzDK8m87ub11Cj+QFZ+7ozczJAcTMeLnvCykaa8XUhQr3VDoiVpwdFwd?=
 =?us-ascii?Q?T/0b0O6FvTT6wCXhQC/gn5IVMJQQPtuRS25So7ZAtIwnsZzDpU6E+wcCI8yq?=
 =?us-ascii?Q?0woXzAHXnyqeFSOMZFvQwhmNnHgsmxfc+1yjslnApxYWExtLn7LF1yvBpRbc?=
 =?us-ascii?Q?8KyHhSSNyqnz02B3jlAz/pRMgRsm63mdJo+KlsEB5e+Eb2MjJ6WmrZTXz6n2?=
 =?us-ascii?Q?CC0drApUdE0xzb9nbb5t9Rm4XzShwtKMa1vJKZrD9Kv+rE8AeNQgyP6UFMHh?=
 =?us-ascii?Q?vwVPiK2Wd+ULAJcNvomxR/yVhwI0AW6JNyyKFvTPGOyFyLvokfZRW7R7Yx1T?=
 =?us-ascii?Q?7PrjSrJbQmnvDu6HdfHtYqdYAYN6fSGmLRh9rJ4ChJmMJc3BjgAboKjXWxip?=
 =?us-ascii?Q?/SYm7EO3mS8sgsz1NIJ+uMLM75/qtLcJh/Qkxi7i5jM1CabqihxuVUnfPd5N?=
 =?us-ascii?Q?jEmvfPu+Nl5NOIKt7fkYTuXFPQxzXIzQjsVcMzuxDSPO9nC2gs9qJ3g2aVTM?=
 =?us-ascii?Q?zYfC5LrzqFwk0uH+kKecWujFGyKdnYEdj3iohtNhxz7BnaVtscRavmB2s7zB?=
 =?us-ascii?Q?JgzjytrHoojMYhU9YUyKKh5UK/X0fu9vFVUEM0bHpBepjxk4XeWZP9FJS+Lj?=
 =?us-ascii?Q?rSng40IOb/n++av5nDL7TzoDij9rUzCMQgOF6/1dXkyMPIrvf0Eo3464gVbR?=
 =?us-ascii?Q?EYCEobBs9gxAUwd1JQRkAgzXOLLGYvrXobpJGC61JwhA0XWKYXJjNjplgIPq?=
 =?us-ascii?Q?0OdETIJAEtUET8GPFqzi4NhIdbBjXG8FaPgjxoQtMNjnyrK3wP1XIruTdPCr?=
 =?us-ascii?Q?pwRo0+b2mVv0pFJywCIQGRiGIyGiZGD7vypR1H/+tn8pCooCkEs+fv7VJWC9?=
 =?us-ascii?Q?XvNw5AAxnImG45lA8S9xgjCnRPoeUPY8mtMBvFLUfZiXp5VNlQfIQwsVb7/K?=
 =?us-ascii?Q?EJyPR/rX33U2OxRfMuV3R0UPkcN/f1P/QxpT+eWztpS6Dt8pyCNPU8SZQEg3?=
 =?us-ascii?Q?83p1r8SYkWHkzeEmn2FWUQAEwmQwF9CQUKk/DGeUuhTYrJ2xKd7CbFh7PDsG?=
 =?us-ascii?Q?9zHrAV7WUhJ7ICQZW4hy5OXLqpyRkRulsrw3gdi9fnbhCI3uHVRlQFqwKFY8?=
 =?us-ascii?Q?vdnqkhIGG96ov8Yb/t6nXTd/b/qxiZ8Kv2i8nSxlKLZZYLF53/1BFIhjkBAk?=
 =?us-ascii?Q?hf/ewfT+PBPWl74=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:26:45.8774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501ad802-3e11-4836-1d34-08dd45d7f955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080

des_perf is later on clamped between min_perf and max_perf in
amd_pstate_update. So, remove the redundant clamping from
amd_pstate_adjust_perf.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a23fb78a442b..2926f292be7b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -703,8 +703,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
-
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
 			policy->governor->flags);
 	cpufreq_cpu_put(policy);
-- 
2.34.1


