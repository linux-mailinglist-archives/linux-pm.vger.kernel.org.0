Return-Path: <linux-pm+bounces-40844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C91DD1E391
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 11:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 376533076F1B
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 10:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ABB393DD9;
	Wed, 14 Jan 2026 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="QJdSDxJt"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAE394463;
	Wed, 14 Jan 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387702; cv=fail; b=cPiML9eBXX9yDFIsd2UFdVmkx9VtRgGOK25OJMrGSTNMcvw3DtT6GC3J06S3bie4/ddgvu1v9WEF8648ZzgG2LjTwjab9tFrbih4bjbkHglxEk3hd4W/O98VTfex/hVHzsvNQYe9GVUs75p3LMNs8qnRFkgIondZ1UXpcdpqlQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387702; c=relaxed/simple;
	bh=2TQpqSLxF7XIOGYLaPWvQARf4pPN1c7U05d+xtbN/Y8=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WKXACJjrAedgufpCRc1xmBi87mUL7rP/jdcam9pc3VirldVAIOfd3l3LqpshRN4ys2erajKTGNBfMCiWNxmX9GJKGdIJ3r8bOyFDNGzCz/8OIn0PsGDJs/BMu/M7EHg2F3BNWzaCRr+b8tzziROWIA6krop7tPTsYtDEkehPu1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=QJdSDxJt; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK9cUAA3zBM8hyjncgtfOfl2H23d674s6UrpPEs9QEE71NF10DhmvnXa/hSzPSYir9yD0PCAzJgor/hGeTalxMBfS9JIeFFyBRUnYlICXlJ/Mu3/amBlYfplOpq5CTo1PgJ5dNXWmHr6maMeFyJGvgSqAXNBVJVTIPF6q0r5y1gggqpbcPyBR7a6SxWjk5PhkS2QSuqoFQlhI2BQ037dNYGCBeFDNIi8OTaJnSVn/I5D9w382tmB7IUFNeURaCdXzFZRk1dL9YM/N97y7/4VuSIAf9NLCACj6VzHgokHpgPeY8iLY9rgU+5IkADnsvupM5wL1Y4mC4R3ZauUlPaQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4Du2ZHUWKPqx2Otp72OOKJ/sqrPgDEX0Gbe3HmpoOA=;
 b=Ovjbz2GcsBuKOqI1gQOfe9Bc6Se972fx1/UuWd4HybcUqpYTi0hIYtCOueChQCW0YCAgUYpya2JZs2CVEpIuf1yA+5MyQ2zjmdFxT3MNSqgPV4nCYRG0x9H9XMxCrlCZ79Pi+vW5kqX2OrAWTQqGou7b75NxH+ERFznHl1lCEfrRMK+P68zSNhS8ouWii3qGXRCPKNKxHjFJblxw79HUpL+Vbx48PfHtDoBkywL24VsKBhCkDgAvjk3BLp827hGm//ByzOBMqZtVFNqsaJVOkaTbA8DSIc8TAE4H4vkGQ/vYCJ3k+6ec1F7bzAKAqXbnT3irnpJ7SSomStUyQzMr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4Du2ZHUWKPqx2Otp72OOKJ/sqrPgDEX0Gbe3HmpoOA=;
 b=QJdSDxJtNyan7YemoH5YVm3y51TtenJ6sdECAesLygBLB6eM+6nj5ygQOFo4e0GoGGX9b/uGtCu0NhXMVQouzHaaJ3tiBNJFbNIjGDI+/3hblOA1DLZHUFuRahUOIe1FjVMijXErNLVMFZXb0t8KhhqJ6ayuPLFmiORL5Tbg5KI=
Received: from DUZPR01CA0165.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::6) by PAWPR02MB10238.eurprd02.prod.outlook.com
 (2603:10a6:102:367::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:48:10 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::10) by DUZPR01CA0165.outlook.office365.com
 (2603:10a6:10:4b3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 10:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 10:48:10 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Wed, 14 Jan
 2026 11:48:07 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Nikita Travkin <nikita@trvn.ru>
CC: Sebastian Reichel <sre@kernel.org>, <kernel@axis.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/11] power: supply: pm8916_lbc: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <pndtswxebnc.a.out@axis.com> (Waqar Hameed's message of "Wed, 07
	Jan 2026 15:32:39 +0100")
References: <cover.1766268280.git.waqar.hameed@axis.com>
	<64d8dd3675a4e59fa32c3e0ef451f12d1f7ed18f.1766268280.git.waqar.hameed@axis.com>
	<5f3152f01420823ef8ae2932ed781cf4@trvn.ru> <pndtswxebnc.a.out@axis.com>
User-Agent: a.out
Date: Wed, 14 Jan 2026 11:48:06 +0100
Message-ID: <pndo6mwtqqh.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|PAWPR02MB10238:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b12f7d-99d6-4e0d-a4c7-08de535a68ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|30052699003|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lMNW++JFlf/4qyyIq3nf0zu/5TqOucuALowClAhG/Ma2Rs7s/ZTUcQMY+Seb?=
 =?us-ascii?Q?d5Gai0tkuPRrgqV3L0BPP5XM6J1s4wU3Mt3admaQ59lZaurrSxrJY7Z9BzKm?=
 =?us-ascii?Q?i29Y9OvADR+A8xaYM+gAuMH6j8ZB7CUMMb3tddEA71KCKoZ1hosA1i3cx1DM?=
 =?us-ascii?Q?oiiSx5amuvckPOhbv9R0VWNLQBrNFcjCqRvpNRyeuDjva6MvyuZv0qNOjG3E?=
 =?us-ascii?Q?eHjmynYF0KUblCnV/woSGT6tjn9vSAq59s2euEfidzv/6uFPjHFutE8o3Ds9?=
 =?us-ascii?Q?99jD3peYXyfeJiAMwR2ps7RXcAYWdsSFYMXrG7kJAzj+ieGS+moHgvxzhGyH?=
 =?us-ascii?Q?7/dlIHgl5BKYoXkgLNuWHm7mMFvGCCYKlb/ngqmV5zw8/wO3EeD8hrt3ItU7?=
 =?us-ascii?Q?aBWER1EsueCErcTzBB4SyV3lY5KqwpeTMdEVTPVoG6zPFGvdsJ83dm2zkUs3?=
 =?us-ascii?Q?0dtWAmSqVHOHK8xAy2ThKs2rYpw2gFpT3FHwwf+ijGeMLE/MJUUyANUoO/8F?=
 =?us-ascii?Q?Wz3Eqf0SkhmjbvfwtvsABb9Ue+4D+6gyAagQyRW7Xhoq9VOHJI1AErEQRt5w?=
 =?us-ascii?Q?8HovDITmrc9uAy+K+2+S5A+f9z9YRxvbdUiNr+8nWoIq2xuHACjoU1FknfA4?=
 =?us-ascii?Q?LCCmuOOMlyia2QkdBi9WOjqbSGoa/I9N0CoriGyV5QwbELOhl3crKLAPusXG?=
 =?us-ascii?Q?vfDGFu+xWLOq49GMbqGU4kAIk9sYTuaK60l2H7eRIcnxyvHfzZk1gGjxx2GT?=
 =?us-ascii?Q?FXg9QM/s8TTZ+MQKe2TBLGoFeawx6OVxGqyGj6xLW7adpiCVXp73Jo0jNMqB?=
 =?us-ascii?Q?mH271JSqup6g7SS8UmvRZ3tpOjh0oYcWjvjRZKTMSUuBO08tg4xjIy8uxAJi?=
 =?us-ascii?Q?Z9PxtBQDJEjiuVLBdjEgCzbnekvyR9agf8xMrRXGiTRpZrXMvq5F4Rujdkm/?=
 =?us-ascii?Q?ANxmW1JVUN74AYFDx1j5l0vIWjldzsP5H6SStThVDII8+/3o7kzsR/3NCDW8?=
 =?us-ascii?Q?g8CRgLcolkRP7FJj57F5tlfHsl7zLkzyc4bq5fkP+l7IbhtHdrsLsm3USnf2?=
 =?us-ascii?Q?M7GW3cEiRAHKJ6qZht2NNvkYoT/E7kp3RssvHAYY4bTxusbWV1uOdRo3w9Ch?=
 =?us-ascii?Q?NxxOFs7Af96g70Qcz5dCRzDhCAqPdjyZ5nOAh8rwp67C1ldcDhgZHTSrA/oU?=
 =?us-ascii?Q?X+ANA4ODkD1rzGMi7ICtef3ipLrBRAffY68+dMMDjT9Sh1bZXDET2UoLwYd2?=
 =?us-ascii?Q?ZIkCtUXiWBCsI0pFSUhswIDbUWet8s/w6HFKMpzGQjBQbGra3H4ifRQFoDfZ?=
 =?us-ascii?Q?cZ8WeWgSpAeN47vG9J33f4/HYZyGsy3P3/4uHoo9k92EEIdLd/M1n2EdBZVx?=
 =?us-ascii?Q?XSvGFDaWXj9kh3PQRy1jmqWwTlIRSFLtwdvSa3M46b+EeBfW4YxFjwYth67J?=
 =?us-ascii?Q?ZmuBnnW3xr3ZbZPqOVRKLI6xYagne2qVVrSry6Mbd0reArq6UwZDLz70ScgT?=
 =?us-ascii?Q?+I02oS1m2rkMelkHD/nvo3OS17v7YDZMkGx51jE34zUmO6Wuz8fG2jyzM3J3?=
 =?us-ascii?Q?hg4ZqOb1hhbeoIR6kic+elaeszlafKjTn+BPz6CHQKIMbwYBfSQOhprEBxR2?=
 =?us-ascii?Q?/xILDrsoUHyOA+iUNILeQD8=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(30052699003)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:48:10.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b12f7d-99d6-4e0d-a4c7-08de535a68ff
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB10238

On Wed, Jan 07, 2026 at 15:32 +0100 Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Sun, Dec 21, 2025 at 10:45 +0500 Nikita Travkin <nikita@trvn.ru> wrote:

[...]

>> As a small note, the interrupt handler also has a call to
>> extcon_set_state_sync(chg->edev,...) which is allocated right below.
>> I don't think this is actually a problem since it has a null check for
>> edev (unlike psy core) so I think this patch is fine as-is. However if
>> for some reason you'd have to respin this series, perhaps it would be
>> nice to move irq registration slightly lower, after extcon registration.
>
> Hm, it _is_ actually a problem. During `probe()`, it's fine, due to the
> NULL check in `extcon_set_state()` (and the interrupt handler doesn't
> check the return value anyway), as you mention. However, during removal,
> we have the exact same situation as for `power_supply_changed()` as
> explained in the commit message; `devm_extcon_dev_release()` runs and
> frees `struct extcon_dev *edev`, the interrupt handler would now call
>
>   `extcon_set_state_sync(chg->edev, ...)` ->
>   `extcon_set_state(edev, ...)` ->
>   `find_cable_index_by_id(edev, ...)`
>   
> with an invalid `edev` triggering a crash/corruption in
> `find_cable_index_by_id()` (before we get the chance to release the IRQ
> handler)!
>
> Good catch! Let's move the registration a further bit down to fix this.
> I will send v2 as soon as the other patches in the series also get
> feedback.

Since Sebastian says that he applied the whole series as is, I'll just
send a new separate patch for that now instead. I couldn't find anything
in his tree [1] yet so let's chill a bit until things get pushed.

[1] git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git

