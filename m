Return-Path: <linux-pm+bounces-43446-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP9RCh/mpWlLHwAAu9opvQ
	(envelope-from <linux-pm+bounces-43446-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 20:33:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B04E1DED7B
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 20:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0193A3031832
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 19:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5156847D951;
	Mon,  2 Mar 2026 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qXCrO7jp"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037647D941;
	Mon,  2 Mar 2026 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480028; cv=fail; b=aEFByyXjSu/bLPe2d2Ccii024Xu3CkUwROpnHZ0mEfGRqDZ9rhPWUyfyy354Rh+kefjlWj6TYO6KKMixWZKawrMlqSsc3GBS7ffTOXQhthOIBhOMsxe7MekAlkW7dkP5JZtou5uNh0mN4AclFiP2Fw9IF2J1wZl+EFV4exR+ejw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480028; c=relaxed/simple;
	bh=TmStDpoXfuU1hacQj3jB+WvqB8slW1GAim0zpGdgSXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tXHiOn2Goboo+bcohZWwcSQLe2ASOnTpimw2Pjy6baSoxlnPCYCVjJefk/XYRAZ/dlPu1cWxtn9n3wCM4lEieg6ztEjyI2VI9qeR8lqNqd2g0I4GiJgB2Nh0Umc/oFL6cAqEYZ9sp0Z438ujXoaC3Ksm/YDu2QhFdTS6fGZMh8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qXCrO7jp; arc=fail smtp.client-ip=40.107.209.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hghJnKr/YHW5SYX7PIDhcNJMd8jkT4PmlK6V13P0HAqwdLGYc36YVISua3NrZf6V6WH+tFqlRuvzCbc0xHTmaCwiaxMe1sq7SHgqToqyaLN1IfLLiz4TTtMOovLiXOmZ0+6i7+/LRXDT8F0lytTKHLkcazXsso72LV4TwMBCnOw13fZ498MZJpPwnPjC1ECvHBGYe/M+PhlkKbHOv60IDNamlHM2j0KREONqacO4O/kkNMXhLnd33NTvFqJKnnzUvuBJbun4jHzRwdNakeQLkux8Fw/VWwEksqd7Ek4Gq3VpaW1hGgmsRPK0/EK8tu7UQ2nBP5PjH7bLS19lWAX8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aop2IK1gQtJ0O6Z395KxCXR2XSb3ijIcMZJXE3NKRgQ=;
 b=rtSmQukUCacx1Nx6kue2qB0xLICtlk41tILobqiDuqZuM5kU1gtXC6JLCVdIdwC9DJUsnV5GXmtCkei/eskIWJcJHvvWeXi/LI2Zitfev6PUM/3GunzgqwzbJTQWDbbwC13NcNocJtQZtdLxzRHDY0Y0zjXI8k5DVgQmWVLCo4nyNPkeUVqlYUgcbL/yidfoEmYAUMNaG4oZMP+qKVPeiCFjplW0xyvUO8zauaTAoW9jdwT/uHtn1PSK1c7Zx5SlMSQn4Ee2ZhKsbmHjVlrVpAI/wrQS87LVZVUxx7h+cewfdsN6I8BJVAcaLfHQs0iBUWr19fChKVjvpdfn2dZvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aop2IK1gQtJ0O6Z395KxCXR2XSb3ijIcMZJXE3NKRgQ=;
 b=qXCrO7jpnFLl673U0bd0jdhbyGDeVBGmqy2Z6vku8TwGtcWkOgDsRRSMtzlwr87XPhyF++aFCfj2+NtjZTe0qDHrjtuy4xZ+u6sHZZjijcG48ogN6uJ+jCPUkZKPvuoQFAInMbx3SM56YKbzoTWEGzZsy7EYunj2t1h8ATTv/XY=
Received: from BN9PR03CA0975.namprd03.prod.outlook.com (2603:10b6:408:109::20)
 by BY5PR10MB4163.namprd10.prod.outlook.com (2603:10b6:a03:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.19; Mon, 2 Mar
 2026 19:33:44 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:109:cafe::66) by BN9PR03CA0975.outlook.office365.com
 (2603:10b6:408:109::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 19:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.0 via Frontend Transport; Mon, 2 Mar 2026 19:33:40 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 13:33:38 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 13:33:37 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 13:33:37 -0600
Received: from fllvem-mr08.itg.ti.com ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 622JXbpi1325577;
	Mon, 2 Mar 2026 13:33:37 -0600
From: Andrew Davis <afd@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>, Sebastian Reichel
	<sre@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, Andrew Davis
	<afd@ti.com>
Subject: [PATCH] power: reset: keystone: Use register_sys_off_handler(SYS_OFF_MODE_RESTART)
Date: Mon, 2 Mar 2026 13:33:35 -0600
Message-ID: <20260302193335.274095-1-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|BY5PR10MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3a0d3c-6b3b-4e99-9690-08de78929bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|34020700016|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	4ojpjkynUIPAHbSVLUr8u5DMiClGS9Skx3Cj+XHm3KXcDAYSCDeM7J5UqV9rq0kgVZJQ+Iix0suUadiD9uDK70n4rvtmRK0cph+4rGb+eX2JWcJ3YwkWOGKr3YDSbZCut8VC7oQmZNzGguoXID8Myc1MonYty3H9CCtKv5m2KJglb/9haHrAxi5HnFCHqqB7b4Q49WZffJEJUm+zYK7ZWmOdKIlwJ4NPpYc893Jmcq2It1gRiwVo2YIqRjvq+LsTPY4Z9CehdcjplZMf2ckjmR9fEr6ebqhyAT6oZ/v9qK8bj/z5GAHFEtbXj/v1+L/PKLeST9BeAZsAu+03GjL55jJwxgFf/eJMIRsFRtprXikePQRqbdgyoyxnBEQyKP+MWJABTmt27DKbZG8h0DD1kKfJT884Axt2vkKkn5pDtmhElNqoZ28g7QbaqCm0sHiiibacPbs8q17x+V5pum1hG6zfiwkrPXLNiTiRFgZ8NS7b/hrk22iTR+8vqJkxZCNcy8LID1z9afrTQn1B58NrmP8MQB8LwuRosiH7Jxkxs2waVaBoLLtQxJ9/Q+KblFrEUAD6Fhfs1pj06jXf28rfSmNJSxMe8Ne9BUmhawW2OKnxfLKQ1ggTcSeeZkmxAxJy9aMUpXf7jtcm/ry/tG5aXhZf5jcC9qFllpi4o+hSmicZ3OW6b9OHodC3ERD8t8/6sBkhcgE+IBumsgHnXobhAtvzsS5GlBPv7riffcwm8nn+qCowZLCts1HnSms2lI3rjERDX+iAljTHsmvLPkBvq4UmkqrJ3w2H8H5U9U1nD3bCZbZ+jQ//YcdVAllbwpdq/PHLtwvCIzyN8QXsrMDB+Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(34020700016)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6UZDiOFKfmqHiK5K8m/ph1azlE+TVKkmqbB1CyBZEqBxt3F9DOSFwB9EYl0judDGks32i2bXrO5hLFOs2axuV53uMv267hQ6zlNGBq8Z2hnomlGlScC9rGmpc+jjyQalRFZRCd7eTLshH5rAJvWOmWteV6v5DajEja3WZlFenjY/8ML8pgGqFvPpgWbdWWBJAdnsTAOROSrqN442e684cXKAJd6l3bBQB9qNpQCVZBLm6vQfgCW+TW6N0Xyk6STHWI2hxlZe1vyNzgfU4GI8bx0hxV9E0mXjpYu1ma5gFXMZ+AnGi/NlO5Pe8L9faDxcFgeXvfmxjVM1oPXJjWRLUtYhWvn5/k70PkdvQL+5fNv/xMkPbEu+bafEAqBeh3X1+HmPe6nkXWkHu8lHkgXHmz9Kstb5+QcWEyU0cZ3g197Eo1c23ls7Jx85oV21GJVD
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 19:33:40.5802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3a0d3c-6b3b-4e99-9690-08de78929bc1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4163
X-Rspamd-Queue-Id: 7B04E1DED7B
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
	TAGGED_FROM(0.00)[bounces-43446-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[afd@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:mid];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Function register_restart_handler() is deprecated. Using this new API
removes our need to keep and manage a struct notifier_block.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/keystone-reset.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index d9268d150e1f9..b016f016cbd84 100644
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
+	ret = register_sys_off_handler(SYS_OFF_MODE_RESTART, 128,
+				       rsctrl_restart_handler, NULL);
 	if (ret)
 		dev_err(dev, "cannot register restart handler (err=%d)\n", ret);
 
-- 
2.39.2


