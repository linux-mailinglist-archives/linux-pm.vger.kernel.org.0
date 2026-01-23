Return-Path: <linux-pm+bounces-41353-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OIkGsE3c2lItAAAu9opvQ
	(envelope-from <linux-pm+bounces-41353-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 09:56:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE4D72C77
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 09:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F5F8302F7C3
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EBE339B34;
	Fri, 23 Jan 2026 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="QRj8ycdU"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74E2FD685;
	Fri, 23 Jan 2026 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158552; cv=fail; b=T4BEzwq295mrD4EITF7pTY1xAze60hwlgpxGcnsD1MCRezLpAVl0OMhDOlHSUFvbXpsQFQmoiDs18oZf7sVXWpQz+kCs1gDsxUS7dAscIx/b5BJATajENJYxfdHbqwK7AXxz8QF9x1xxgM4t5saI0RP3IY7U3xWJ7Q5+KR30Emc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158552; c=relaxed/simple;
	bh=hifIBIPAapB4qd4IvtYHvdorB3E4AZkGQ95BONeSCtY=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=PA8g28USmjfafbeIFGf7/k3f5E93tEY92tVTb7uwu3IDMaFvpnNeIxZxMQFGaqHo4UMFFyluGbPnJ/Czl6N6h4E0pyJzKMzPJ8Vz0g8gXXGj/tYA037ww/6u1K+rYor43+KOSuxbTMTSO8IJKfx7bYq2XkMDBSl4hGsqJz3wm3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=QRj8ycdU; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATVg7cdKmDe0Bn7lRFk3XmYzD+W8TGx2aX1Z2GB+d6VIwOk7BiYHDFotXMExzC97DWwc0nPt1vTpVonRjh5Lw5/hBeTpxTV94gcGkmtKoL4okcH5h2eM75EWL7/N15Od1zBU6OUzug7e1HmX123iYLD6+U4wkPa60BoCP4wqvkhckJpd1vSqbBxJAh7iHQo0kEv9DMRib3MUlwkQnyQJ7rnpdUh0+CxMjZHVUrO9skebYvDp+ZexWC39O+Wma+b1xNDxJobRT5euup2JpGdfcWp9rRwK4M28Jp0NvwWGIv0NFen3fvkRIhHEvXJOXn5dbJM/Re5XeyV79Fpm4TKykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDSzqJiBUCpJXWA6GHDX1ILvcNSfH7KsZc/c+LRiBJA=;
 b=aWmyJaUNCTxFtd5d35WBJDBtU5rcLccQl0JjcIlyalgPkBLK+I9j3Quj+NFsq6G/jC3vw+hOhCpuGkYTXZT5gE9kW33WFXq0aWq4H58HhJ/t8vA4CLzb63cB5nSqgN/Q6qONAAUIvK0IfMbCKMLuWmsCPY14eZv6y78BWKc3J2dMCC2DKl/NpIUihi0QSL1waHCKRYQT503CIz1fEg6Dq/u/54oQqQWQPjbUX/0dDcdl9H6c6tzJmt2vpENP38Sw+X2lUCQggCJqR76C/iP/eR/chzDnxraOGXZkHAn2M8rzi00xm2alssUTh9Tw2OqGGoJ0sGZuQf989aVR3nn5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDSzqJiBUCpJXWA6GHDX1ILvcNSfH7KsZc/c+LRiBJA=;
 b=QRj8ycdU4mHOUhY+bHs1yqMqD0CrwEVIe63ynSM15WGvTJwF7Y8vZAI2sk4hJGE/YEcenXm9e8aPwv+Vet/DVHFXeFPlS+AV3oNnP1gc/G62ArUgQxW4Bvzkbg+W9h2zbLVkOHFjGW0VXLP14w65IJzDpexvWEblo4Oj/oMER9U=
Received: from DU7PR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::10) by VI1PR02MB10251.eurprd02.prod.outlook.com
 (2603:10a6:800:1cf::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 08:55:44 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::fa) by DU7PR01CA0022.outlook.office365.com
 (2603:10a6:10:50f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 08:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 08:55:43 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 23 Jan
 2026 09:55:42 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] power: supply: wm97xx: Use devm-variants in probe
User-Agent: a.out
Message-ID: <cover.1769158280.git.waqar.hameed@axis.com>
Date: Fri, 23 Jan 2026 09:55:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|VI1PR02MB10251:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d947e83-b414-49db-4cee-08de5a5d3123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?14PAPNTj4y3lP7TFQUqcwmqdSCBgYoBhDpyzD7JOAtf2ijrV5mgtxDHaoHwU?=
 =?us-ascii?Q?JpI3GDjY21ypPnjm4AmgBd0iK1YRRQzHsV3L03wcGoTPxEkicKrZuTZMQwej?=
 =?us-ascii?Q?0Z7NEZQQnQ9l57hLLiTOXMBHaDI95u9x0MYTNWt4tcV9UUj+0wCzewzGSNH1?=
 =?us-ascii?Q?DITRF3pgP034wuWGAjNo7ibT9i5uYZQqtYnOCU2T5xtf2n6LwGsXFl723Sht?=
 =?us-ascii?Q?1QBD4t+kYRk9aleVr1WaIKeLrFk1fBNMZLNl0fV45LsV+35QHNAgAyjhj3WF?=
 =?us-ascii?Q?QGYP17JSA64VoKShidML4epyzz0naAYDTWGcZE88Bsnz1YL4xPMNxo7zx6Tv?=
 =?us-ascii?Q?1IjfbB9hUzUn2XKkDQ3VQJRxN/fU6Y/NEW/fT26hoKbJSGEBYY621cSjmBYG?=
 =?us-ascii?Q?IZqDjRnlV82nrP21J+LDCs4savkojykDMPmobjaBPzYK0LKKlMmdk/vKco4e?=
 =?us-ascii?Q?UDSSJSGHzg5jl7X7OCBYEdohit/xeDluKVE+CwE8RgZi7TS8rnxS80Wet6UG?=
 =?us-ascii?Q?vLHlxlxk6gYuMBZGiwvTUy2iEXabJOcQO5Lj2YUFtbkyj+pLePHhuyySWcF7?=
 =?us-ascii?Q?FN3ectkQQtCK/5NXUTU8zisqfEHuhAUH7x5THS6Rm+RmTuIrsZ9+KE/Es7po?=
 =?us-ascii?Q?E8Kgyhs6A6nZN1clO8jKw/dfNZZfAepQ2p21FRnZeLygd8op8RauPuNU/JPT?=
 =?us-ascii?Q?x7thLgzjKtzYMTgihQOHs59Ile8L285C31oKKNeQ1jjYVcOXJCLZBEKIfGGv?=
 =?us-ascii?Q?FIA4WXvHBLep3xm0Ho9hCYlfKfL5DbYjb2jAnJLjcKop2bpO5Z3V/5ZOqvRF?=
 =?us-ascii?Q?PoXiq63tv59x1LN5CrQpZoiw3YVGphVfIiEAiPiM77ADnLG5yf7idALBmam+?=
 =?us-ascii?Q?ZfcVL8cdz/XYxMvEQqlpMT9ABdZLMvfjURMS1OFKS5O1S9zUZV6hyQxvAl5F?=
 =?us-ascii?Q?G+CL4FkEVskF+F4Nn0V1vnfwxrgyFWiZlyOag5IPJ6ZVUbNFHQpIt6rPcd6y?=
 =?us-ascii?Q?7YUKdNk1t7T0gPiLWoY6glpd3rPWxksczH2gSnntJ30EvSuDYeKf2bR0JZuU?=
 =?us-ascii?Q?ldtfQIgR/pnACv7onFhG0mVn5NwqOnvBcAkJteMZs64MgXMa/GXD3axzXZ+I?=
 =?us-ascii?Q?SUluDL132PpvfKK7kJLN+yhuUtkgryke2e3PM5+nwIZEJmryDhynprNIeKRM?=
 =?us-ascii?Q?iwEiZMRJutQqDePSxYvgWWvErWsU297SLRbgrxDo5E6SFKfPVcOkEmM3ZTfR?=
 =?us-ascii?Q?a76sUaSgweTdoE8Q8LaHAydLa3YMxXT1cDu4msVaX11p3UTkSfF8PzIsRigm?=
 =?us-ascii?Q?mqRPZC7BgXmPG8JX8F8RaMAyYki6fyUiLLR9tluLVdBqYlYd62XMs5iNRs8j?=
 =?us-ascii?Q?f4Z5aMTy/89PbZx7WKZtd41sSSulYsv0+qB3e4JpCuXWDNZQhI3kl5xez/VV?=
 =?us-ascii?Q?0xRPp+wk/o6z2P5arN+BBD9C5VoflC6kAs0dO26Lk2Kw906HZAz4f46tYrLh?=
 =?us-ascii?Q?2ZYOK9jTh4h8uQ1Z8eL8keWGIEMI3GwshbuzxjQvTC/qUUa7jNFZGjQWXO00?=
 =?us-ascii?Q?OXfoyJSnOkDEBcuT1kYR5nKd6kB9tkwU5BG8zab7NkjG2trOkGvAsEIQxOZE?=
 =?us-ascii?Q?DUxi9CmLP+1KcMa7m07FiQDeyfJkQHMluxj/bWsKbzmFM5qajnwXhH1kIa1H?=
 =?us-ascii?Q?0osWJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 08:55:43.5546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d947e83-b414-49db-4cee-08de5a5d3123
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10251
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.35 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[axis.com,none];
	R_DKIM_ALLOW(-0.20)[axis.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41353-lists,linux-pm=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waqar.hameed@axis.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[axis.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,axis.com:mid,axis.com:dkim];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EBE4D72C77
X-Rspamd-Action: no action

This patch series contains some clean-ups that makes life a little
easier. It was originally triggered by a NULL pointer fix in this driver
that has already been applied from the previous version [1]. Therefore
note that this series is based on `for-next` branch in Sebastian
Reichel's tree [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next&id=39fe0eac6d755ef215026518985fcf8de9360e9e
[2] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/?h=for-next

Changes in v2:

* Fix clean-up order by applying `devm_kcalloc()`-patch before the
  `devm_power_supply_register()`-patch.

Link to v1: https://lore.kernel.org/lkml/cover.1766270196.git.waqar.hameed@axis.com/

Waqar Hameed (2):
  power: supply: wm97xx: Use devm_kcalloc()
  power: supply: wm97xx: Use devm_power_supply_register()

 drivers/power/supply/wm97xx_battery.c | 32 ++++++++-------------------
 1 file changed, 9 insertions(+), 23 deletions(-)


base-commit: 432b119ab8d8bf1f550c247f7fbe960e87ba6c92
-- 
2.39.5


