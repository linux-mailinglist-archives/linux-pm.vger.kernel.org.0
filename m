Return-Path: <linux-pm+bounces-43521-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOXZF2wip2mMegAAu9opvQ
	(envelope-from <linux-pm+bounces-43521-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 19:03:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B55FD1F4EA3
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 19:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F24E3111287
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332473E51F5;
	Tue,  3 Mar 2026 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LV2ZzG3d"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AEB3BED5D;
	Tue,  3 Mar 2026 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560820; cv=fail; b=aA6TiGW9rJii6bhCk14l9RBRSLry/NrbJz/3+ZNEqoSIyk36/Gpjc9TyKHNm/NSQ1oKtSgEkQBSNk/REM2KYgt4OVWAH1Os7hShYc6NVSliYZgLi5XDfKlfADggdeEwb/rvCYAKrKY4nG8evj/OR5NrDP8ogywcYEusqYSlWoHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560820; c=relaxed/simple;
	bh=AOdfwycofbXFkgFk/JlFbWqGzTddQ886BMYNs7VjCD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sTBcWEYoDYszvSt3tiSiW/UyoW69ffkQ6u5TXWQiMqzvrZfBWH+LeOrGHOsulB/b8N2SKM3taolpvGBtSBkpJfQpwvqdHyRyfuTN3gUbblCPAuj6Y9zeq9bX0zjbKe0oQEm70IT6ArxDo0N1mQlvtjJG/m+zNXDKGA0C5G2LltA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LV2ZzG3d; arc=fail smtp.client-ip=52.101.85.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4Lb8hyQSg3wmnNar3jrzLtsYqsBTAFwya7Zd9sHgWHkR2aJtmEUZkHFsifmAa+iJ0ak+Cl8QYBOZ3EuOlaZsJNiTFcnWS9zv1calWgoVDdU0wgIKhKZ0O1+NRk3hGVLA1CKhf8Bo4um5litPAZCchkB6rkjohcOGP7plI2AndQ+bsIfUjWLd0upqQ1YWMY+nF6OV1DY4w5q6ZkGNOHkhinG++jXhHrI5YTrro716JbxLt+FnOTCTw6dCNm7ad6bMBkOzREWqtgb0q0C1RDYM+y0fbQrg0GsYG2HzPvpIzLwOfl9ogoObU+DJESObx6X8THvLr6CzSWRFlbNXyt0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfb9O401PB9uiTl9A868GAwoHfOZmg3M2KR5W8qqr/o=;
 b=daBA/kIUIvVcSOedLjI5qKZI3QQt0RyYqVOUFdHPWshpeW4FgrWNezbhAhGa+JvXblnH3VuKfHQTpWGN64BuntguJIqUqjxOv+TSauttUvEkMPNr87m1fXM333fza1QEKTDGknc2eDgZ8GXfyVlYeDHC7WeQc//inVocoKMfpuC8/I4wjhEi8rfd4awcCmBt0jZpQMz7mGd2gXizyRwCupLUWd4p8Cuce9ykajTRsIspYfef0njfOwIlVuPzRArFlqOgJ8Rnt6/FOBuSnilfWA9LtSoSolMvCbKfYS+0sV0BvquNbHvUy3nzSEoZof9LvRD8KcqBGNeq2LRbxjv7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfb9O401PB9uiTl9A868GAwoHfOZmg3M2KR5W8qqr/o=;
 b=LV2ZzG3dIwZjDL5yTNkIGN1Y+3hcKS86xWsjNvJsVGhxe0AGQZgY7vOmy46Qo+c7m7CXP0KrWlx1V0v+GRwT08MlkCyHopJjxhaRQRE6JUoCzBHcV81Zl4aVw/SQyt2yPqeD5BHxd48j/Cj8vbtj256YxEr/nkAjjViqpFwyigI=
Received: from BLAPR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:36e::15)
 by SA1PR10MB5712.namprd10.prod.outlook.com (2603:10b6:806:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 18:00:12 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::d8) by BLAPR05CA0015.outlook.office365.com
 (2603:10b6:208:36e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 18:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 18:00:11 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 12:00:03 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 12:00:03 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 12:00:03 -0600
Received: from fllvem-mr07.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 623I022F2565926;
	Tue, 3 Mar 2026 12:00:02 -0600
From: Andrew Davis <afd@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>, Sebastian Reichel
	<sre@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, Andrew Davis
	<afd@ti.com>
Subject: [PATCH v2] power: reset: keystone: Use register_sys_off_handler(SYS_OFF_MODE_RESTART)
Date: Tue, 3 Mar 2026 11:59:59 -0600
Message-ID: <20260303175959.75647-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SA1PR10MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7d34a6-b16e-4601-c872-08de794eb715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|34020700016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	bWMG+JdaJl4N3n3DwYjeOzVsJ/rIO6y+CuVgG1QL6UB0zt62aG64T94C+RaY/i/Urq+miJd800HGLsi+VebUg+tEZL6CyS+sx3zI6YEmZCTGoHYfoXTtyN1/WaD7/UW/ccd8LrtnXnBYfGwpa9L3AaplQlxFre/h94Er1w7qMc4ltz/Xm6FAeQBBm2fgAvHZ+GuJqvlHAB+9qgcURzG6dSxPaM27eLMJKNsK3zJL8+BUpe3gDi97KdskfWTv/Eh+4jlTL0GGKaer0LzvSdItOYDO0iwG9IAz5EGXBPbD/KZLnkklRc31Nc7NsAhpFgw4i15mmABDyq0qf0MTBINRtX8oemEkUVvLKmBsTWDGPyxwjuwhilYqpH61eDqXO7uQcUJ2QoDrMsmBqyR5y0WLrZBQBz7thg+yfoZcuSLD6sHJUf+Hf3ImEq40W8gUL4UUIZWuysYB9DVoqfplphac8xZ0w6FvtovHqwXjo2vSZo+rLoTZ94hPbRfpyOzC2MZz5diQ+K2K7qz5c2uKZL1c8ah9ZOa6cLEWQ35osORFAw0JqunFYLNxhQg7lypZNvtFyFz0zAtLDX2xUDruX+l6/qbclPPQX08mj35C0R5yi36DrdpSJsXHvATnl9JDISCJ+dzs969Q9yYiqb0MWW/lB+FaWqi7n5UqRmIyotcIEBIYxEglkdKgaU13G4YBSB9Nf4x4gmHftHCDIJPs3S/NATbNCrsAR0EjbQfjArR10JWX6CemF5pU+S7dbBz9wIppJvysiAVauoJcny7GHFH0T84Fs79/ODSR1rXWraYpvwCjrD7CBMpmgLkzss1vqzO/G5FoqmQfU3S6ngRLTSZgYw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(34020700016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W+RbLl50gh/msBcHRDLgIWf7BvCo1XI1iZ0WPR/TQ8voNJVrL4KMimVpUguTIoez/hPTJ9+9sJPA+SOemoMbqP3AZuZPBNV/3StSrQnPA3b59liIYbrlNDFUu2T/IDhUdde3k429lcsfTTSgpaiF/h9JvrV2WLRK2gPxAGlgiSsfxkBrMXVzCKqH8M+Tw924K6VgE23OeDZ6tgeEmUqHCbzxeVyOp7YG1v3S4q0H7Y8M3y4NsqSf/gK4E5gdyyQPLZtH4g593IxDUQW5OmdJJv8HGQGVnirdK9ISoVS4JXVDBgfmG9+BliHlqva5uDP6Ohdt/VGV4sEG0+XIytNq1HkWNVP5bj27G10ECI2gEL+hIPE295ykeTv4u8Jxy8hxvABXx2fIK/y/m07nI54PfS/lZaH4FmPMvQlj4P0Dd1K1WGOYDZGd4b052qjFJd7/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 18:00:11.8189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7d34a6-b16e-4601-c872-08de794eb715
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5712
X-Rspamd-Queue-Id: B55FD1F4EA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43521-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[afd@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Function register_restart_handler() is deprecated. Using this new API
removes our need to keep and manage a struct notifier_block.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes for v2:
 - Use devm_ version of register_sys_off_handler() to keep return type int

 drivers/power/reset/keystone-reset.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index d9268d150e1f9..3c44cd6cee0aa 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -48,8 +48,7 @@ static inline int rsctrl_enable_rspll_write(void)
 				  RSCTRL_KEY_MASK, RSCTRL_KEY);
 }
 
-static int rsctrl_restart_handler(struct notifier_block *this,
-				  unsigned long mode, void *cmd)
+static int rsctrl_restart_handler(struct sys_off_data *data)
 {
 	/* enable write access to RSTCTRL */
 	rsctrl_enable_rspll_write();
@@ -61,11 +60,6 @@ static int rsctrl_restart_handler(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block rsctrl_restart_nb = {
-	.notifier_call = rsctrl_restart_handler,
-	.priority = 128,
-};
-
 static const struct of_device_id rsctrl_of_match[] = {
 	{.compatible = "ti,keystone-reset", },
 	{},
@@ -140,7 +134,8 @@ static int rsctrl_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = register_restart_handler(&rsctrl_restart_nb);
+	ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART, 128,
+					    rsctrl_restart_handler, NULL);
 	if (ret)
 		dev_err(dev, "cannot register restart handler (err=%d)\n", ret);
 
-- 
2.39.2


