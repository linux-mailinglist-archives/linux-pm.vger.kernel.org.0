Return-Path: <linux-pm+bounces-43330-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AkdCc67oWlhwAQAu9opvQ
	(envelope-from <linux-pm+bounces-43330-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:44:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD68D1BA256
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E659D30D9107
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45E43E493;
	Fri, 27 Feb 2026 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="kzyiS+eB"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE2329E60;
	Fri, 27 Feb 2026 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206540; cv=fail; b=q75OuSKQ4VVm+c9RmQik1U5PVSQCNa/t3hqMLATVF3k5y3/Wl3ViabA92LerCEgPaxd+3PKO43lwuf18GAKFgNHzr3k/+xgsXRBO5aloP7wYr0Wsg4W6XGOGV4O9WmBn5cp/L8gOSBdpHREltdMUVuVKBAYM8HBYgIpYxx/pD3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206540; c=relaxed/simple;
	bh=dQUJw8ox+lQDRWfDfxvFL0HmZx0B1DZb/NukBarZBLE=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=e0xThgHINpHjfWXrk4C4cZZzJNtNKB39KofWRW3bxpQgeek7fG0WpHpdg2Qpy2A7j6xiQOYVQQcqmONejZ1zEv6Dkn34dfEpmv1RXjHV3NxlWr5VBPUJwLiYPT+YzHEJypqz0XDQ+QTzN9RMjEVLX2HKerWvL25Aj4W3bo8wKaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=kzyiS+eB; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYlW444Qgj32/FrOqwHoHcFAzdMCq0+blNI5AkVKhEWZoGt5vwxTng6XMi7VRkRoncasL99bMFuaxeX0E4m2UiB/vWYe/RrzVGDMjWH5FYvG5bAOpWnuwp/gLMJQ7c7nzB5+C+hzKp6btZaNq0nIjZy9OY/stz2u8vFWsZcEOMW1DSGfeeklrqRFCCgfxz7OdL897N+3+0ThabTSek74aT2QQPMJ+6JQM4wDFcGS3m2yLr700Iwof22TmiZkkda42/tJh1MQGlbUQRUleCNJ6/qHEdX0WmXWcy0IKRWgL3Om2l2TWBRXeifBqP3LvWvjsl75BQefWvLNKGZmawKY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxyJrtLiYqGQOC7IgSVwQRWd5LXn2zOoL7kcBeVvSeg=;
 b=C+Xb3NgKiwlAbnRqSgCmPq+Bvmx/nvZEZGQn+ulTvSSSCQH1El2RFk57qjj3WeD4siJc6W4huADLO4qS9MvW30eCY7YMSJXxaAf1Qe0N67knYLblvLJkC+bFSlfj71RnST876Czs4BclU9zWGdoax+4Mjqv13p8tXrw6+2PEKJH61eVX0pbehFwYngLhO/Kq37pkZiNDBS4JeFLRBSkEM6QkgvV9KIuO+V7cLmit5yOr7OEANxSXsyD5QX/aCL9xukvGE4pAz5HGZCAOQlSWtcoCIc9qvaE8ne01aTNNht4Py5Re2CK1kljoslBKp3jUg5nfN1M3iYPrSvTEFCRuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxyJrtLiYqGQOC7IgSVwQRWd5LXn2zOoL7kcBeVvSeg=;
 b=kzyiS+eBxD9etH5iQXIHHQi1BYabD7LBWtFN8UgntxbQFxzQtT+AoB/Rng9NFFm6OQKgwXvdDRoL88C28QgfqekA9zVQusoqRmh3QSQEcLL/TFYGTFxeXfphb9EmKUFSXlThwzOJ+dHIMCSipGaYUAlAcewpqHXYjt0EGnjqNCM=
Received: from AS4P189CA0031.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::11)
 by DB3PR0202MB9058.eurprd02.prod.outlook.com (2603:10a6:10:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 15:35:34 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::a9) by AS4P189CA0031.outlook.office365.com
 (2603:10a6:20b:5dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 15:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 15:35:33 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 27 Feb
 2026 16:35:33 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RFC PATCH 0/2] Add driver for TI BQ25630 charger
User-Agent: a.out
Message-ID: <cover.1772201049.git.waqar.hameed@axis.com>
Date: Fri, 27 Feb 2026 16:35:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|DB3PR0202MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 5235a77b-d9c2-47b8-6ff5-08de7615d8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	ujmqM5JGmI4N+L+As+0d+W4jUG2cfhFAqYh56YMmJHxZr9QeYRcdmaaYKB/jw9WS1iQTp9cEBYG3dW0WSQfWZf9iL5gZyQmlFuHrYQPygan78MxdpeEo1Re8cas0C/PNuwYNqtmxUuePgdZIekjMTtQ1/CehK1Xkeq8SaMmaD8u3kl6HnuayJ0MXwJyW2pd2w+CcktDgwO401J9onGsfh0fruSJPdm51UaDF+XvnC7UAtBCjY+lKhE8pGwdX4FrWchd61yMSzhBYWhj++ZYT7CsGFrouvbRLhcg/9DBSHA8dUmbXM2XrgvCDVurJ0NfaMpmQVs1kGVByzzCY7lHMXR2/iD/B5N5v8/0ezNFJLTbwcMdwn5ZIf5ufOrW21AxsC6CcfjbV1wia4X4tn9XbaMCTEdKDW4IW34OiUQRmKh3hS0+WzJ7DFuZ5cq0di8SBpl2dKszagtzOP2oDjJS+zonbETIp6UA6rAVNyWzmbVcQZf4mP3Ndrty4HlhcCf1J9KQVajpOGuIOtg4VOgLLfNPCTmh+2eXWQkV13QK2GzXCYPbBx7iBpHfIXt8jkFrc8oKm/o6ZZexoblNJgDItmXixwOYMUXNlzPP2K5By2Au7KNVugMsac+eY95GcInJEoEnPgYmfaMQUedfx9bC/xreiaOXSWuEYLepYh7C/NqoqsEdRLL7vsa+nnRdy7xjgh3TB9FCMD6bjWsqz5aMfYVZHc8CA+ASk6SeLSilEBTbFJtb3g8RJN3fRATDA1lmNvUmJhnAkAevXAWDe0XME6yNrA/DLZxHhXhskdq5GmNmgifnIJiYB5NEIxWOSLZlF9oWdgp/v+mj0V9wzEaYtyA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tCV49AkTUxdczDCitLpok+BjHs9mkMy8+fpghuoFiOwGJnF57+My4ziyalMEbZFvgOftOz0fCufid6K9ZQKT9RBh8ncestZrgWYoYljXioOYqAf3q9y7LAuMOPcXkzdL/v5aPcZMM8CbUQrH8OmdaeaSD86fL7Shur+CwZ3AcviadMb/b5pZHulhdZ2W8ignj1qq91u0GPh850ptdktEPPyPv4o9j+K5hMoz8JIFXHW5UaKQBbR1LzXm8wU9v1Qi+1yDvCSOBgyJ/dlh+xwpFUjT7qulXznPxLDHYzsJnXqZ3ZjVLTHh23GRdsvy8h0HYPTkoMBcKaalxtGqw5SJmsW9tDtPWXfbYZmvh7+pPKzkCZVN2b7i0Jk8IuMQoIggK4gAlQ9cmxE5kHbL4yJFVu0p9QDVrvzxXdUJb1uMz/1QngHWnI6ARy2LzRNPDR5Q
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:35:33.7046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5235a77b-d9c2-47b8-6ff5-08de7615d8d5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB9058
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.35 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[axis.com,none];
	R_DKIM_ALLOW(-0.20)[axis.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43330-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waqar.hameed@axis.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[axis.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DD68D1BA256
X-Rspamd-Action: no action

This patch series contains a fully working driver for the basic
functionality for the new TI BQ25630 charger (see datasheet [1]).
However, some functionality has no straightforward implementation. The
following features have therefore been left out and hopefully we can
have some design discussions to reach a clear resolution for the next
patch version (hence the RFC tag):

  1. The USB OTG functionality (i.e. power *out* from the device) would
     probably need a minor refactorization to use the MFD sub-system to
     also register a regulator driver. Looking at the bq257xx driver,
     this should be the preferred design?
     
  2. Other drivers add a custom `sysfs` attributes for BATFET control.
     See for example rt9471 and bq24190. Is this the preferred approach?
     Should we add a new power `sysfs` class ABI for this? (There is a
     TODO left in the code for this.)
     
     I reckon it is quite common to have BATFET control for chargers,
     i.e. being able to set them in "ship mode", "stand-by mode",
     "shutdown mode" or "idle mode" (example values taken from the
     `BATFET_CTRL` register field from datasheet [1])?
     
  3. This device has liquid detection and corrosion mitigation. I
     couldn't find any existing device driver with this kind of
     functionality. The datasheet [1] even mentions "patent pending",
     although it refers to the USB type-C Specification 2.3... :)
     
     When liquid is detected in the charging port, an interrupt is
     fired. Likewise, an interrupt can be fired when the port is dry
     enough (according to some configured threshold value). My initial
     thought was that maybe we can add "liquid detected" to the `health`
     `sysfs` ABI? However, the question still remains though how one
     should enable/disable and set threshold values for this (new power
     class `sysfs` ABI or a custom one only for this driver)?

[1] https://www.ti.com/lit/gpn/bq25630

Waqar Hameed (2):
  dt-bindings: power: supply: Add TI BQ25630 charger
  power: supply: Add driver for TI BQ25630 charger

 .../bindings/power/supply/bq25630.yaml        |   68 ++
 drivers/power/supply/Kconfig                  |    7 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq25630_charger.c        | 1074 +++++++++++++++++
 4 files changed, 1150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq25630.yaml
 create mode 100644 drivers/power/supply/bq25630_charger.c


base-commit: f4d0ec0aa20d49f09dc01d82894ce80d72de0560
-- 
2.39.5


