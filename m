Return-Path: <linux-pm+bounces-32201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB77FB215CE
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 21:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7F31907FFD
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4612D838E;
	Mon, 11 Aug 2025 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JzAEiSYK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JzAEiSYK"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7332D63EF;
	Mon, 11 Aug 2025 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941427; cv=fail; b=LKbHaxT/OH3qeuwFBdDFGhGWKvXnaYEQi5xeyvUW1Q8z4MPxZWBbelARV88cDmJKpkS/gbKQXV2dZJ3qbtgfhySha+1kJ9q3UnAmZIuGJ+r4Fu43koatvrAvQinrXtAMrUPpdu+UPdLg5q34LnOgVFnrr87XzmWySQ6pFKDDCrg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941427; c=relaxed/simple;
	bh=SlFV6UhWNpCJSwamIoh/MJ38+AB77M4fTNMGKifANG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UZFsRoOXxkh/9cCGQIByZtE78GYA1oNdjfAvNtjG4/uoa988XonUlZlyIGC1Un8UUY/49YsA0tfKSkU6dgT4VqwXS/Ha56ggBLXttoJqtSnsAzf2jElyUyjLvMIRmDdMx5YAUXwswTFTPfkyAanZ9LbkUiOsAZB9KGnh1KVEMOA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JzAEiSYK; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JzAEiSYK; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hxRN9zmxiea6sjYG6yrr7OwAT4idBoqTcXT0BiOn7RqGmGBQ8a0qrw5AXD5ZSUGFC9f9w+J+R5I/O4vfyDWHRwkC/1upi6OhNvCpiheRNwp/X55DUsWxs54u4nWlacWgiczNTej6945DT3/Fu2vUgRmplMxOT2jnEsNrxnTV/opKOsGGEvVF9ibn6cqZOiAVWfNnP3h8yZ3xSNWAovSnUjt09Bmj43S9wxjMfUKrzD65waBtFjya4PtqY3JFwaqqQoCk8CIuN9I2HMgz5vGzhzNvXnRI1GqkoRqkIctDcpDJS1hd3Nr7yea5v+x7m1EHxsljZvLDn52SdDOAns5Psw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI5fdw49858JVvr1yniktlvQHw41ZRVysJBmQ/NLcOU=;
 b=tOLRtmO0nR00pf1vYI5W/7Lr8XPK+G1567SGnNmi5TXk1GfRpNPRybv97XfzztWg9pI+p2Wt+C6rk6jLnv111a/KGh5Ob2EcGx4pBxkNTZ/ZwupjZ8Mh/igmK8cpsTj8n2Qx4fZLvEftWq9YPS1QTpFNYbS9xj+TlwVF+f2VoKSdeE3qpEmbWcz7VW9KAl2mfyW3grXhXcDAZ6fE4jpBoEb3LN6s0Lk6UGXTv2j8teG2Ar+5bA3El/pwhT888Ykyzs/hWcxxWW6IRKsJAFQZtv6WV8dtnzh7XpfxiLvb7GIdgZDbh6ZB8m9qKd5F50q1hi14IzBRZU8/lD/Ivd895A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI5fdw49858JVvr1yniktlvQHw41ZRVysJBmQ/NLcOU=;
 b=JzAEiSYKo1muZdNHVbYklWwRjbZcrpJUqnaqVK1vuhGG/VM/kVM68xiFkuz5RMGhClNMKj01D19kvB4jEux+TsiPZIaNG++kgpdz1X6Mq2Af5U3/tQ3z+Y5VAP2vXJHlS82K7iZeMjQ8ek4knt666ONsx+Hx3wnES7bl/gHRs0U=
Received: from DBBPR09CA0008.eurprd09.prod.outlook.com (2603:10a6:10:c0::20)
 by DU0PR08MB9346.eurprd08.prod.outlook.com (2603:10a6:10:41e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Mon, 11 Aug
 2025 19:43:38 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:c0:cafe::9b) by DBBPR09CA0008.outlook.office365.com
 (2603:10a6:10:c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 19:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Mon, 11 Aug 2025 19:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHtvMTJWjFNaBaBeBKB1P8uURFc7RM4PYC2Vb5TVzd4iqSJ8dEfun6cDkg3FYaDhuOSc8wStudkIxvEiH+Fzz953gVyKslE7fWCM8aGyrUuq99UnbF2BUqsYtkRQNPchLuT9a1Kvj4DZCKPvtKPanGHqZGhyXTkfOmt5FitnnP+PVxBgNjAVpXRaJZr2+HhycUojztuCylCvNBlVvBbztMr2RK4Ii4tKEM8Wnzdsj3e2q3X6LlTSU/R/3TareH+15j5aYOe3gkW1nZXd4pMWWS6oeCPF1gwnSFSnE9gHHQqcOT7Smey3peb9tB0AcD/CN19/toLPDhv0XfYOEoGxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI5fdw49858JVvr1yniktlvQHw41ZRVysJBmQ/NLcOU=;
 b=pU8dJpjwc8iLTqT+kN47n8lkIjottCrQYWwC/UeZP7zjRX2F0YZ6z6Lh1lYeALcrpF59v1XaA5wg/lqecfggPmSQQwbBjGhaeKufy0MWXuG0gcEbVZWrLoSXrmW/5MW9hrRwDWdjtcULWk8jBphpaVQIYmi5AX/JhRKjkWO3SvWA8kuukg6wrEF27mM/3iwXG8EZ40dwXRceMQ718WUWKDfS6VHVYRqazD6ozxKTddgWooqG+AIM6rfbLEDw9PGlu2FYSxcZn25LjIgsNOCw6nVYE4iG2B/K3iGuJUFVZNVkCIKeDaFEKQYV26G2Cfms0grLdaTTkDgNsv4JMeYWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI5fdw49858JVvr1yniktlvQHw41ZRVysJBmQ/NLcOU=;
 b=JzAEiSYKo1muZdNHVbYklWwRjbZcrpJUqnaqVK1vuhGG/VM/kVM68xiFkuz5RMGhClNMKj01D19kvB4jEux+TsiPZIaNG++kgpdz1X6Mq2Af5U3/tQ3z+Y5VAP2vXJHlS82K7iZeMjQ8ek4knt666ONsx+Hx3wnES7bl/gHRs0U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB8PR08MB5418.eurprd08.prod.outlook.com
 (2603:10a6:10:116::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 19:43:04 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 19:43:03 +0000
Date: Mon, 11 Aug 2025 20:43:00 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ry111@xry111.site, Dave.Martin@arm.com, ahmed.genidi@arm.com,
	kevin.brodsky@arm.com, scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 6/6] KVM: arm64: initialise SCTLR2_EL1 at
 __kvm_host_psci_cpu_entry()
Message-ID: <aJpHxLgmy5A/YD7V@e129823.arm.com>
References: <20250811163340.1561893-1-yeoreum.yun@arm.com>
 <20250811163340.1561893-7-yeoreum.yun@arm.com>
 <86qzxh927n.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86qzxh927n.wl-maz@kernel.org>
X-ClientProxiedBy: LO3P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::10) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB8PR08MB5418:EE_|DB5PEPF00014B91:EE_|DU0PR08MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: ee13198d-9e5b-4bd4-646c-08ddd90f5e3c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?nikB8DLzKAnOPyF6ONier7mgGhpL9Var8Rs9C27RiRwbSWsCLNHfUAP+xMs0?=
 =?us-ascii?Q?HCjdwrtVh21KmUEFxC7IMJgVkJVwwgR/8eTvHHi9JiGICsBdDivj1r5ViHFH?=
 =?us-ascii?Q?ceKmqt/sWk4VMz0AfLbkFND8f2gIG5Mbag7r+rS7TBCzfdYkDZC0jffF+5za?=
 =?us-ascii?Q?VVaPiKG1H/WZEVTKota4iElma19pZBCtRCSfF5MWTk/dFyDd6X7xnaV1JuBE?=
 =?us-ascii?Q?z9/SEFieZzD1KtLJyoY1YE7Vpr399P3qVpC6Aurmw9/cJ+V7wTseAOyFMcOc?=
 =?us-ascii?Q?fPLBpSPA7xTWtsfkheX7ygoAmCW4WR6WaAtEx8EZCZRjCBtOsGdyE6Jd6zDM?=
 =?us-ascii?Q?X5JFVvh9JIoVUxFELHapTTXnwHoFqsYmIODmcfNd9Xlrg0ziTLVK41vgUC7E?=
 =?us-ascii?Q?pjiy/CnAo0XVxN1h8yOAuJS9CDpYK+HXh/VIragErcKpQUSuFl01LHLmCEtQ?=
 =?us-ascii?Q?FF0jUwonf1w9ew05FD2PLSLDPYfRSlbTw1RnMQ72xie9rZAmFedjFYh5EBvG?=
 =?us-ascii?Q?f/pZaCdcfbAY09aaGwrIEMAX7Q6SD7j3SMv/+vuQHfajQO+mA7MQzX4wPcuu?=
 =?us-ascii?Q?UjO/fRLD2p2GEsav57bkqLXR9d3dX9M8n0JQGfcQt18AFbPFxtzgNnONZEOm?=
 =?us-ascii?Q?5y4+1qOTB1V5UNXfAX+f3xRUswRLHwbTk4INaqAtCrxN1G1hXifnpBUp4h9i?=
 =?us-ascii?Q?d6cFoFvfABtzTjZsEIKmz+rJt6UDbaboBsMGenD8aBIMZJcnchf54T+gpvYr?=
 =?us-ascii?Q?9SwLWrU0QGQVsoULFt2dynqv0T+vRl6ZYNww3JDjZ8ZlBA4RMceWNlt1kZXe?=
 =?us-ascii?Q?qH6/IJdi72B8RDx5YNqcn7nzmjYLdNpk1fu06MDufgk4wXFzH8EIiiiF1aE9?=
 =?us-ascii?Q?1rVNP4bWr0d2tHJ7KehQwLOg/B90InzdMrpvRTZfqNbq7vh9tmDD7DQC+/NP?=
 =?us-ascii?Q?H90gvsrPuD+okhTNHCXlJdFjyYaVJowrWsKVQpsEtSsnY8eXPzvrla9u6qUC?=
 =?us-ascii?Q?JN0l3JWbT2DA/ImHqmdIjI9iQLIzf6vdib9XAlEjoO3EgfB3M8zT6KsdyV8Q?=
 =?us-ascii?Q?Cgx9/NLf0EN631MdRb2FUtIHKbcBISBLn/JLRNPchOFC10S0w47KuuTTbHqy?=
 =?us-ascii?Q?gvWhbgJ+zn3D0hcgRGdalhmNWvo9/oun63jwsenOGwLTcTxCf5nn6ZzmJyP7?=
 =?us-ascii?Q?4fNMonTL8hAex1V69u1eqcegqbY47glTnOWegsVpVeT7+mQr65ambMnPswtB?=
 =?us-ascii?Q?Mx6KKOKueq5u18XMdujF9qBc5y7vt5rNkpwTYbp80yypRQBsL8kuLBB7n0KS?=
 =?us-ascii?Q?P1CCUt2SR32RvHGhkQhI72QRAMg2pGuFTw8/GgAu2VjhbZXGL1nf+feUhQeM?=
 =?us-ascii?Q?NhCGjm58QSD9mcXuZaCIz2mzqrABIujobdVgDDC71lnM1b/50MFpFbuDx27a?=
 =?us-ascii?Q?wC5NyHcue/E=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5418
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b9c9363a-f4f4-4b16-463c-08ddd90f495e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|36860700013|35042699022|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RgxEIthORu02MXJ+K9NokZuchd2EemrBy+Wl5Y8q9r4AZXpzoBvkNr/hAUyR?=
 =?us-ascii?Q?dQbjtYyNx2UALtyTUoHSsBg3lO1N20yruNZbJ5Pwxi6XsDPJqWd8W9JU+GCw?=
 =?us-ascii?Q?bNBABmZfNsy7O4gWIR/2eQaxrhxVaUjJs8l/H+yzli5HlpJm8eTN5XBzmgZf?=
 =?us-ascii?Q?J9ZedJ6SETHcpteit/YbiUCAofGHONNzXQFsezX4k4gzizsjfAKd24Cv6oLp?=
 =?us-ascii?Q?ftctmnxdSxrF/HXBGatEF0SLT7p0ms9geuOzVuiqKfqB7rUGKZvdw1QXfaC+?=
 =?us-ascii?Q?3HPMkHG/osyqbRvPnonCYnAJzQEk9XTyAoqJdH/pGPojFP9jat9OA+lTgw9M?=
 =?us-ascii?Q?2/ZfdGDBG/IOF4lH56KD+m7qyN8oH9+IwD7wy9pKk8Kv/zq3ir21sjNkvUkR?=
 =?us-ascii?Q?Ju8WayJLhmjrm/4fDTnzDxuhzD4IKYbVSi5B4sEuWDlKUUUAx42Jd6tvV9ni?=
 =?us-ascii?Q?aqR474gVXpN+tp7lOg7GfIzrtv/i0HsKXRPfwg52YL6ru8KSupAAo72KJJoP?=
 =?us-ascii?Q?wIqkoF75d7DQVDljABB4ivzm4si0N2f2HipZX96Dm60/pyspwwMaugLNWtNk?=
 =?us-ascii?Q?UNdwLOvwBHOgK1pnt6yVQdtoiHHF6PhrMSr8jUgVpVzdGJEvFl8JVGRvUFIm?=
 =?us-ascii?Q?7S4LL1Bp0OGpVs78zvkamvBjkLIBHIJpOsXTEkGl19U/UedCDkZPQFhNvClw?=
 =?us-ascii?Q?2jHMXtY5yN3HzVY963uJDhmBoi+hSPy8lkfl+59ssU1HOFnr//SkG9steQ0U?=
 =?us-ascii?Q?vZi+m4TNh6BAid5pPOXF8Q3nI+ut5+7FvXRe8vtCBTwXLAmgAYaXW4t8Rh9o?=
 =?us-ascii?Q?+pK7mrCN1f7/c9Hz1cb+p9PVJpQM1F7TGumWKNzq1uDxIOo470Dgq4vYsGbB?=
 =?us-ascii?Q?UzX3AuWqjg5DCLDvi0FR/KNC1KyTXhO33ylPAkQtIPQhkoqmHrmne2enmsbU?=
 =?us-ascii?Q?KhM5F7wMDc7y9fyk1c5tpOtao1MnREVRRx2X7ReeGJwr8WYY+6Uno5b770O7?=
 =?us-ascii?Q?I0tDEdTIStuur4IFJ4YV8Wf/5bnT7AQvlwcErSmtHHoFh7y/8IW++C7Q0EDP?=
 =?us-ascii?Q?FF6tOL+QnwcihC9jO83Cmhk1m4IaHp8ZTvKSnJ1jRZVzpuRs+sUk2zzJm9Js?=
 =?us-ascii?Q?qQCDzlw8XGWo8RkBki0eg7UNH2Znj0z8kKyFdoYA6zmdWm/rlk4J5qZ8mvCJ?=
 =?us-ascii?Q?8dZfFMRPNdGHZnFaTRCp+qXpuohnBASNakvKX2q5h2FNt6BxAq5BCdKsFbA2?=
 =?us-ascii?Q?HvWSpZDUTR4VW0DQONY6lz7s7KvwZBW7vAzhmT8QUi9CvRQ/Tonlp1QfTu92?=
 =?us-ascii?Q?qut7fBBoEa00+fTeSc0+ALq/HEXR9vVrud6nTh7nX5vbi6qfxseQ8MLVR80y?=
 =?us-ascii?Q?OhCxUmQEzx5Sd5CLAsqxoIOjbFck349z1lGQr/QpEn0AIg55sNKuvgWK8rEF?=
 =?us-ascii?Q?uc22DhVg7wQweY9idq3szI/T+/EC/6+6RfeUkVsWWPU/zmFt1B9krxn1t5VR?=
 =?us-ascii?Q?LV6QV4mWfw9F0SlYUY1DcjFmOts37MJjSUaB?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(14060799003)(36860700013)(35042699022)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:43:38.4239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee13198d-9e5b-4bd4-646c-08ddd90f5e3c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9346

Hi Marc,

> > initialise SCTLR2_EL1 at __kvm_host_psci_cpu_entry().
>
> Same comment, I don't think this is an acceptable commit message.
> Please ask for help if you don't feel confident writing it (I'm sure
> some of your colleagues will be happy to help).

Okay. I'll rewrite the commit message

> > @@ -219,6 +220,8 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
> >  		release_boot_args(boot_args);
> >
> >  	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
> > +	if (alternative_has_cap_unlikely(ARM64_HAS_SCTLR2))
> > +		write_sysreg_el1(INIT_SCTLR2_EL1, SYS_SCTLR2);
> >  	write_sysreg(INIT_PSTATE_EL1, SPSR_EL2);
> >
> >  	__host_enter(host_ctxt);
>
> This needs to be folded into patch #1.
>
> Otherwise, there is a window of patches where the kernel will not
> survive CPU hotplug when booted in protected mode.

Do you mean fold this patch into patch #2 where initialise
SCTLR2_ELx?

Thanks.

> --
> Without deviation from the norm, progress is not possible.

--
Sincerely,
Yeoreum Yun

