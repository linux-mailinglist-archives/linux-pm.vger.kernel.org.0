Return-Path: <linux-pm+bounces-9779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220F5912BC7
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6A7289933
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF9016A937;
	Fri, 21 Jun 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ydiBHtpK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F71684A6;
	Fri, 21 Jun 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988691; cv=fail; b=YMtSF7nMV0/0vDzb+taVPG887tQcPRpyRKhxCqhLxwnGi9bgUepAYKvVY1CJEYw+boUYtNzYI8Hny4FZsrjfm6n/M+WP80fNSVXFJ+wTpTmY99rEZpmOTq/snxbM6N5+SeuquRzL6jtlV81AIM9crHWtg5tORhEGu6z5XB+82zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988691; c=relaxed/simple;
	bh=392AWBzKdKzSSrwj0pG0J1sJJzAKNXFtDdvuZBD4r48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5lrpMAwC+ICvGdFIesre2aCp0P1EgMLQcsckJUd+Sys9ACsxfsR3JIEzvNusIvMeHKHCulVa5jHkcaOV/ixB6PZQzIq65uEbv2D4D1havPsORpcwkqt82H665tSMSt/ZbHX3QqFx9jC7BepvIlUMNG3P/NbtcyHEvsK5fqFNRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ydiBHtpK; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3b8xwookryXfdrkJOOGQS1YXXgYhpDg08J/3kuo45WW5yASeGqbFzHDpmxYDUt19K9ePMCoUuLaU/I4E6R6uxZtkipf9tUg7HCv29Y9sFRwWIm0hCVGsDb3xbNgUX0Jb2eRrD9DEDfT4AETh9rXw+ZqdYwwpyKvWUfz9oKhlM6qwG0x/qeC2maprL0GOfVdtQdNUiB8bgMn8IhFXsgKiWPButazSx03ZE+8N1jOSH/X/+upVnt18Zxp0KsuUFTscT3YMKwXLf88OUOSoT71kLOosGsmF7Uc1Pmp4bLOKTK44u8/27se3V/wOJ9UNOfcJvmS1Vo2LUK976ciaMLdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roSRh6JqXml/3zhWAIUWh9W5ezQqGUp+mvuN7ooDMtU=;
 b=j93pKqcHptSAIJKCcsy1ztKWwm2NTZBvTu79U8IEVuRjFbnHya+3RHIj43f6igxF6OHZ0pg88eRABc5HBl9Xhi5j5sl2MukrgJXv+1hUaHTGkNx93qkmOclv4wgrzu+W1M+qEPAG+2JNcyuGUsbZXvVgVmFYeHISKYCTBjk1GC7PfTCrPqrGFLG7sTmQ/FfBxE6Mz2VLdDIU5NXzhz0rmc1PBw7eXd+kZo1AdEWNwfktjLOV6vHQZZagyUdcLRxlMX4gPpKMQmQy9BY4o+zfyAsUqdHwZKsvRfnWqQ5Zq52Km/miB5d2RoT/BbolwvdJ/vtgnKwN+aHMj0eMUy6agQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roSRh6JqXml/3zhWAIUWh9W5ezQqGUp+mvuN7ooDMtU=;
 b=ydiBHtpK0AvRDb7dAHR/xdR5ZGWDM6GCHbl68nq/8mHQCto1h24At/tEH7synd9GfGvtQfboGT2NWWcYydejmQ5M9fN3n4Np9tqQpz084MWFBtkDh0XoZ5OVp9jS6V/niSGm+nmIgpq+dySAcS8uiNMADKkjJ3PwsHzdaVy5tZQ=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 16:51:26 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::f6) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 16:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 16:51:25 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:51:21 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v13 2/9] cpufreq: simplify boolean parsing with kstrtobool in store function
Date: Sat, 22 Jun 2024 00:50:57 +0800
Message-ID: <d392eba3bad1231776124c321cef8c184ce1482d.1718988436.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718988436.git.perry.yuan@amd.com>
References: <cover.1718988436.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b8d5ca-2623-4a3b-d7b6-08dc921263c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5m/KGho38JbHUAVD+x2lKl3n6XNpm71qXnSGRewBWFXyzqvqZQ2BD1Utb7mB?=
 =?us-ascii?Q?YbWkKYSQyuRVo3jutVy6WQG2pmL2tld8PE/iSywA/XMvnQon4Iuw0wL/mqEJ?=
 =?us-ascii?Q?QvoFNXB2H2uJCSc2ZiRhzBXWdNuFP9leeCwrWNAEPyaB5+9UbpwtAjicatXa?=
 =?us-ascii?Q?wvFm5blk6niSAQArsEOiQBCD9WYo01FzWpy47Qrbjhedpjz7mDTKa3O66/mw?=
 =?us-ascii?Q?BqOeWkruRXEbUOEozw1CfSUBww0SZckM+Y8IdCbR9Aj/uqpRJUayaqW3ObMi?=
 =?us-ascii?Q?sHTefi+HMOkN8JcHVWjRRdapENRI8y8vkLoB9CoSfr/bhzvJ2Tfnyca4sBgM?=
 =?us-ascii?Q?YOqt9J4PLqZBlyw0ZNSQRdChvKkmaM/xLbJv526En8FXkxVfqdgZcpuwkhaZ?=
 =?us-ascii?Q?k6qRMfeCTi3a5WcLfCKALlKLiaCAajthaaMufYxtZVvBTfl/kjnaz2RcSB6u?=
 =?us-ascii?Q?uJ32vju18+Znla2fLsXUOSEann2WCrgD4gvfXRJh3SvLcLyruE3TDHe+ojWu?=
 =?us-ascii?Q?m3nzggXhf1a8jdNub+0BZfnxd/A0eVzMTwOzGPXKZhZoQMkH/nUUBR+1geN8?=
 =?us-ascii?Q?pnTjBhNDFn91+N2B4VzeoDn+NBsxsuT9WqKXaqZf2ukcFnnK5t7az7swiuNT?=
 =?us-ascii?Q?tvccNVgGxjcycBRN7+jvIb28UyX6yCPdc/exUPTpcyWj2AjVdzQBpKAX1dyY?=
 =?us-ascii?Q?ceRtLLHVNM2U/NvhpwSBdLfeBW2p2PdLr3Kz9hzoEV6Ou9ksyAUNGbJgf5ie?=
 =?us-ascii?Q?Er4i3onlzbZK6k2utmiJFNOBKTlVt8plWN252fqkuh6hxAoA9p5RsUhgvoId?=
 =?us-ascii?Q?bWVpTNxIG37Z+nK+JnEcPhcSzhwoeXEK0VH0acuxmQZ+7yjb+Oc52DC1061y?=
 =?us-ascii?Q?pHbJCoxa1p/lq+n7DEwl0jVQd9ztHPguYgJGm38P4rF9VNEPj72Av4r7ihuT?=
 =?us-ascii?Q?+lNrqCq/Y7tBoWqKHQaDzCuhz6WSXGuW+EsOhBb2kQp3K380sfl0GfjB+ULS?=
 =?us-ascii?Q?Ns+7jzsPXXEmokXPUHuTYUJkqUDD5MEslyl7W5FfoVFqV4JQf5qH3v1jW2bd?=
 =?us-ascii?Q?AcuZvA/rQyD8RFW2I0OtDEm2oW3GdVLPjkwuv8iAOm73l7BMC2C5JAk2oiNL?=
 =?us-ascii?Q?JLjH/JuISE9gYTlfTrTK/W/YAjD7NJzAdbens5T0NUOouo4KLRVQMHRQwtgt?=
 =?us-ascii?Q?nsz4wuCfA3Jkk8A7AB+7mvSOIzuCTQin5ufdMmvdRwmUeRF7PBRS/5xiDPAJ?=
 =?us-ascii?Q?vFnBRZ18xgujeHXgMm5yvF2J0RJBzUcWE4/zdJmvnNv+9MX2PrpmltU1WmqO?=
 =?us-ascii?Q?aRaBFlzYLri0YWUX9Wb/mx7NxbVVSpeMlNC9BONS2zUQc97NBPPBbFa3u8ei?=
 =?us-ascii?Q?qJJCzu608S/al+r9Slhk2dl3kwIqwD2X3VJ9hUwR6UhVRCk6Gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:51:25.9207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b8d5ca-2623-4a3b-d7b6-08dc921263c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883

Update the cpufreq store function to use kstrtobool for parsing boolean
values. This simplifies the code and improves readability by using a
standard kernel function for boolean string conversion.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a45aac17c20f..1fdabb660231 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -614,10 +614,9 @@ static ssize_t show_boost(struct kobject *kobj,
 static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
 			   const char *buf, size_t count)
 {
-	int ret, enable;
+	bool enable;
 
-	ret = sscanf(buf, "%d", &enable);
-	if (ret != 1 || enable < 0 || enable > 1)
+	if (kstrtobool(buf, &enable))
 		return -EINVAL;
 
 	if (cpufreq_boost_trigger_state(enable)) {
@@ -641,10 +640,10 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_local_boost(struct cpufreq_policy *policy,
 				 const char *buf, size_t count)
 {
-	int ret, enable;
+	int ret;
+	bool enable;
 
-	ret = kstrtoint(buf, 10, &enable);
-	if (ret || enable < 0 || enable > 1)
+	if (kstrtobool(buf, &enable))
 		return -EINVAL;
 
 	if (!cpufreq_driver->boost_enabled)
-- 
2.34.1


