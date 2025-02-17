Return-Path: <linux-pm+bounces-22193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD369A37F02
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 10:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989EC16E788
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 09:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED1216600;
	Mon, 17 Feb 2025 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z6cLmWKV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703212163B5;
	Mon, 17 Feb 2025 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786039; cv=fail; b=cjIbumK7TBH4PXJCo6k1nonzGFT6M3kcOBvSDcl22tjXV+0lAh84mpHCJTzEf8StJXQi5Lzg15+TggM060OVifeUNRfYL+CCA00ly+vIttSpy/7xri2U2dbfsa1eLjEcQCoyr7/Zbr4uA37bv7WFFqD2Hzyr+BkFhLQe8vwBrJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786039; c=relaxed/simple;
	bh=YcTAihBIjQ6JnXB2nvgiBZnEc63u7hwfSzLJHeElnkw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=orgAbwtyGvGzc9auSp7Uy6HImMhdVdgqMyd4HVxi0bmPByGZRW6LtTBFf4N+zKsTQ90tQeiSEqa3MgonKM/depifQatqhRYLnNlq/3mMgm1oClpXc+zLjR/Q8hzB6uzSmYMVbGfdVK1ROdqO74JZuV5GNq6kzQ5pFZ9zPvRA7IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z6cLmWKV; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Brq2t8O0WMLJ+QR/rECDEAMH59X9zvB2cHELPtoepGgKgjLxbUFuNf7/PWtCgQpTTfOaWmx7kTz+c0b0S8HtPhWfDIRgrqlIdE93AZz2vdNDzjv21JmNL8Ad8emiRZsxKA6RTcFSjZ38uIci7I0YlBc1voLnKWjjwwa+FQJjDl7vVe012FjPgiYlaT0vJz+6F3nBcFvjM+5D0mdd32QT8N13vssnXs8y73CFKOzCb1fI47VroYk8+u9WC5RW9PEQEpsbLDjZXI4uiBWlUJ8Isn6SFqhXjG4S7af+cSY+lWFfTmFEkwjteq7w0rSxA4FXGozjm+L+IGnv0YHUXPnp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YxsblgvyhPceRn9CV3F5txUITBVLC+2fUBTAYKfjRI=;
 b=AHWawrIZyV4nCXYamqSb6ngPqPk0GQLLnok0Ao2MFBIHSwGKXqBf18YfrvRO7WFiq32SzKoO1+bxfM/IbrbUfHhyaobObGQtg8Tk9rI6bA30B/2nDbWNVJpHDK6fe0abAkZukUTmkK3xK/586zUG5zKEJATKOikdxNccdHQtmtI3T6RtdzPG+ZpEVQH1QK9lSzQcsOoXqLVyWVU422mZdhHH66Q2hYVjsGz+URl6itUtGUdJZW7n8AN0tOYjqA3EndddmuSjnSDIpBGMgPViQFrsfRdOjwkjTPqPszCB0HGe6NDpXLtCeR2B8Ds7Tzw7LgmDFbwE66v/Voyh8ClQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YxsblgvyhPceRn9CV3F5txUITBVLC+2fUBTAYKfjRI=;
 b=z6cLmWKVtZnxAHNNB7cqCK3l9lJRlu4sEPcx+jsxjQhfI1dVWFac3EOv0iH4zx2yYcV5KGX5G7jVvuO31f11FYyNNzINLx99iMNNvaB+RiGsgnM7L7D51TZFvgKAim1gzn9CRrCM32wCJ+ZmoLqLzC4E/xDBTkUEXjoOibCndj0=
Received: from PH0PR07CA0082.namprd07.prod.outlook.com (2603:10b6:510:f::27)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:53:52 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::65) by PH0PR07CA0082.outlook.office365.com
 (2603:10b6:510:f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Mon,
 17 Feb 2025 09:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 09:53:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 03:53:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 03:53:49 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 03:53:47 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <git@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH] dt-bindings: power: reset: xilinx: Make "interrupts" property optional
Date: Mon, 17 Feb 2025 15:22:26 +0530
Message-ID: <20250217095226.12606-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: e40f48e0-e215-4a1d-5e04-08dd4f38fc09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ukk2D6JmChjmxVv267/CAnSOS/0yc5rpljo44X9Wa/iMfCSxIy77Guv5YvW9?=
 =?us-ascii?Q?e120eXxr/0qk3ysWNWFQZXEwQX/S1iALHewRVFkrZQUIY7Zr86qSnkF/Cvfr?=
 =?us-ascii?Q?JJoLfHzNDM7+q45OGT9Z33+EYiVRw8WXIWvLg9GZO0cHG2a/3+G2PKkuzaCI?=
 =?us-ascii?Q?oh+BDpck8FElu3xQSYHkdXpVL9pXeXD3rT5qZmcsDs54o1oPfBUzLKBTmM/y?=
 =?us-ascii?Q?NGhT86m8AOsRtN/ItQiD/ykNAKSKHJLTWFgXK7C6Y4wzPfcayFy78dRUM71h?=
 =?us-ascii?Q?f+cmfGGn1y7W6UMC7w82cri0ZY8bIiz7QHISPdcB9YAd2j1x/iQtd6ARKHPP?=
 =?us-ascii?Q?eNNfzVUoHMmBNW4rxjAlRE+wMpccdwztrKQ7twlfMEU+Lzebw48yCrnz/kS+?=
 =?us-ascii?Q?1t3h36rdIjs2x+ksAECA0zFtgXEKqpk+gu32MyAqnlQbSZSCtKH/17NaKS5v?=
 =?us-ascii?Q?4VKwmhd3dyLKLDR1+HQSZB2nczLXRB5H0QbmsXYnaUDZZeW9Kd5mdWkSHwYp?=
 =?us-ascii?Q?fBWtX1ekuoBewRhf5NLoylKFR/5htKBxtEAZH7jM9lR2mX5zEfwRpFNCIZGh?=
 =?us-ascii?Q?YxJtBsMWZeCUwozb5FR+JjdSzs4O1H9tpprVSor3xDGx4zAmKItNTuQymhGo?=
 =?us-ascii?Q?3jCBiAEqvTgvbm5fMjmcKLlBGf6hhj/KgwSoDU25rMcgns4wwaR+iqrkA/zP?=
 =?us-ascii?Q?GcKcdJKibEtPQ8IHsP57/ZvhySRcz6gTgsfxfF0CX+sxTxWKqbtD2vj2zxEQ?=
 =?us-ascii?Q?yqqi4WFXRhI0WM/rPiHjJG3xqEr0zPgWppPw7Y2IvhrWyZsTmBVrn1ss+TBR?=
 =?us-ascii?Q?7KKJxjdYtTurcONHJycKdxvrJdu8H9MKvLHf2of8C3THNMyCsrpyeYQB4FWx?=
 =?us-ascii?Q?XZZqgXZsvEpghRRcOY/tRUbun+PUBy6e+lvGuYZve10qVNyk/QZJLWcblNOj?=
 =?us-ascii?Q?kd7enDn0l+z9cgqsvEOcJ4pBeyrrne3qHCV+hdSQKczAGcPSd0ZBhAwhMHBo?=
 =?us-ascii?Q?G+Pbz+GvfsM/2+JRSqqjm32H0Uy5s3GGTGV//vCI7UcSN4YsKz/wQo7xEnWe?=
 =?us-ascii?Q?Pp5P1naqhn2Bgv436XGopiTwClNgq59l5XWYutM3bCYJRir1FlVuJdC+qEzt?=
 =?us-ascii?Q?0VjYHmGTWv5VseRQh74OGRCZaDa1+uNnE8oUuY8OPUOUzR2vNKsGoY2W24TC?=
 =?us-ascii?Q?uXlJb3u0KU1ASONmRlRofgCjgW7ihXmAjAy03EQCixzW/pq1IoiX5kC0gg8U?=
 =?us-ascii?Q?3XMeGXAtEfAnUjUtnE6ZHvIFDsf8iNZ4Fmi8tC54teDcKkF7vVtbNAe5DiK2?=
 =?us-ascii?Q?CzdgXLA0SilruOs/MMLWZayca5sp0EEeHw4ESWjtYVVaNsx/9oaFlxrRtUvP?=
 =?us-ascii?Q?DXC3LCAXbANIxZC5p5o9K+WA70J6kibvAz/reglPSPjlmsAfeTg/N3hw/z+h?=
 =?us-ascii?Q?nboghxL0cfe2/SgTy7NQdmW0Ma2/ei3QTbAShjvufsC7jHcBSMxpN4FFmHrF?=
 =?us-ascii?Q?ViwayYn2wOpOj8A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:53:51.9994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e40f48e0-e215-4a1d-5e04-08dd4f38fc09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243

The "interrupts" property in the ZynqMP power/reset binding was previously
marked as required. However, there are multiple mechanisms for
handling power/reset events, including:
-Event management registration,
-Mailbox (mboxes),
-Interrupts (interrupts).

When event management support is available (default on Versal SoC), the
"interrupts" property is not used hence not required.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 .../devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml       | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
index 799831636194..079ad977b907 100644
--- a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
@@ -46,7 +46,6 @@ properties:
 
 required:
   - compatible
-  - interrupts
 
 additionalProperties: false
 
-- 
2.17.1


