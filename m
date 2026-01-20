Return-Path: <linux-pm+bounces-41163-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHA4Ji95cGktYAAAu9opvQ
	(envelope-from <linux-pm+bounces-41163-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 07:58:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A951527DB
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 07:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5CEE8424C6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730EE423A99;
	Tue, 20 Jan 2026 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Txs7kEPH"
X-Original-To: linux-pm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3E423A78;
	Tue, 20 Jan 2026 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909697; cv=fail; b=gXvbYEUa29KPzQttFpNCsr2oqyBUJR2j2l6bUMSKEGbIo8bzaa6VhXIiW9Tq4on6kgaIQR2wtTRL12/turYikMWRlo9Z9g64/RDbXF3R8tfdUEywt6Ym9VjhhtutlYJg9CmGXKW7jN77MD8RmjkUcyuHxRL76EvxdXqAc2o6goQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909697; c=relaxed/simple;
	bh=RkAsr2lA9A6ZAiN93/ACD5XX+VZ2olPPVNTlyketpIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Pce/I9s4ud8E9HwdPdD/0Ay6yEqO8BnNKd73W+B74ZVQmtRZI31H3+kDOcF1zMGYUhF4Nr+rzQngQXYIpqHsJgjog3adsYhGU0EklUeZPLKUzWKcx39aJr35Ej/j6wZX3a7sAB5FnUQNpTQ3DwZuFJJdIrPnlV25KiVUkcT5zQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Txs7kEPH; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi8nFu3LweeP3u/v7Qy9Nz/i9JwMRIOS4G8s+SOiNsLbPOqkXBdZsYrI4EgvzgMekMzID/CKFn2NKLUEwD89jMpEO3M6xWu/mKzxeBrzzGCgdluNm+UwTtRHaTDX2tljmmxYtKv3d7XnWdmoTUXjnHkfidWRqbuzd6X6v+XGZE1vQZOF7uZ1w1YaUdOn/c6359icQ6hBEeM6I4xkLuTnCY5CGgzVTh0WBwUE8buHJUzpqqiKEzWOhsBSCuqdKbe8iroKFMz4tlI7ZNQV+oLCXy5t7SmjKLJR7TXDVaJHN4zatTOjEA9NYVgoJu/HX4GHX117Do2qSkPUvmc/KjdjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP580RvY9D7VmGuXv6TG9lkdbWdk8XIjDo4zWr3SQjo=;
 b=bRNMYANzeL9N7piZcLsrgSsaTiH10yd1WbmRopGt2G6uPpDrIpW+3BsU+wflU/EKNHCnQ0MnbIEgQA+7nYfyPM8Z0jDboMSuAl3Xtw/OWANFlfwBjg4AkUZ1+UBSY8nP1Tawf1UhUIw8Cv/GUZL5vtFpuaDBXuI5FFXCTMOiR1TuuV5qfWo2LR4VO5UQkShMeDFli8Fkzw35PFb5lr2YEFiqljU9MuMnujFxKPNC6Plic2Tb3tfcP0AgilYcdH9jWaVPMgoWWbedrutxBCbr1wHeZTT3KaKAWohb4q/Fz6dS2YM/HL+/Af1j97eG1T7o8xWbtwP2l/tQBtWvO94eNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP580RvY9D7VmGuXv6TG9lkdbWdk8XIjDo4zWr3SQjo=;
 b=Txs7kEPHDjq5yl+fCzLEeQ52zXqkaz1ldXctGNKTJ8tKwOwUSfbSROygBLEutN/7Upae1r+b7HKT7xrobc5XYlLX0ceD1ZkCLqXlXpimnyM9a2ZarR8A8MQ1d2i3dzrhocDkTVlvLUjepZM9BHyvNea5mIgWxJmHrApx+5a+WBQ=
Received: from SN7P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::30)
 by DS7PR10MB5998.namprd10.prod.outlook.com (2603:10b6:8:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 11:48:11 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::1d) by SN7P220CA0025.outlook.office365.com
 (2603:10b6:806:123::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 11:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 11:48:09 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:48:09 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:48:08 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 05:48:08 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60KBls151151397;
	Tue, 20 Jan 2026 05:48:04 -0600
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 20 Jan 2026 17:17:31 +0530
Subject: [PATCH v3 2/3] cpufreq: ti-cpufreq: add support for AM62L3 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260120-am62l-cpufreq-v3-2-8c69b80168a3@ti.com>
References: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
In-Reply-To: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>,
	Bryan Brattlof <bb@ti.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768909675; l=3142;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=RkAsr2lA9A6ZAiN93/ACD5XX+VZ2olPPVNTlyketpIo=;
 b=SWw//WdifMSNhLSQ/b57IFeVbbfstmBWdh72PrltbBYNJ49k1+7Bpf28sN2+FtnuS9SiEAYzS
 oTn1lf9KmlCDFtaHaIMGXTDrWHDFtQNQBqHroZBCki6fCc2oucQ17ho
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DS7PR10MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: a90c0795-8ae4-4acf-b5cb-08de5819c891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWtZYlhTUldnR09KVm10dFdNOS9nbElhZ2pJT0VOaHZLOGlJSVM4UkR0UWJQ?=
 =?utf-8?B?MWl1enBrb251K3R6RFlnNjRpMjU2bHprdmkwYVkvNUlnUWRFVkxjeWhpRWxk?=
 =?utf-8?B?YjExVVNvVHZLdnl4WVVoZlFUTGVIaEVCMEYvVWpTdlg5NU82RkJFUGpkaEpz?=
 =?utf-8?B?UWlUYTZyTEM0MkdsZWh3ODN0QUhpNzVQZStaTWJUb01ZV1V0dVVTbEJaSGQr?=
 =?utf-8?B?TmlIQ3RySVBzMTQvQlNWTFg1cWJlWXdJaHduNlZFQ0dmbzVUVHlXSUNkT1FS?=
 =?utf-8?B?MFB0RUE1Y2ZFWitDWUtGSjkycSsrcVJ6ZnBsc0dUbk16SEhxbkk5dFREM2xN?=
 =?utf-8?B?eUQvRXVnbUNXUk1Id0VPVDB0M3VXMzlBVTNwV0RhQTlaR2VsUFZUWHgyRjlL?=
 =?utf-8?B?QnYrNFZJdGh3eUR6dXBCYnQ4Smd2Zk41bG15TjRQeXFNQ1BrRk9JSUtrbGNW?=
 =?utf-8?B?c2QrMWxDUnpyWmRIakhQWWo5aS91TFlHK1lxSGJKeFhjVCtvNUJMVDA3WEFz?=
 =?utf-8?B?NjdBK29XWEhKVGExWDJEMUlVUnVSUjU4M3JBekd4Zlg5dTBqa2lXRDloS3k4?=
 =?utf-8?B?c3FEQzZiajZZWWIyd21tbFlSNk9uTHlQa1ZndUdISWVDWTErcVg2VFdDaDVY?=
 =?utf-8?B?a2crUkZQYW94eGpjanJPZTAybHA5M0RrN3lDTHZlN0FONmdjanhYQkhaZ09C?=
 =?utf-8?B?TkRUY3dwNkFkazRHeXAzMlBaMVpuTW50VTJDZmZnT2dpZkg1UGxRVjNjQXo4?=
 =?utf-8?B?eTZOanRudW1GZlFsaFJUVmQrV0JtbTVkbThNMXVNcTlyeFZzaGtUUFRONWVv?=
 =?utf-8?B?Q3NSZmFaRnkxcFFjNGdrWG1KeDl4ZHVQd0w5cTY1VUJQSjNoUHNTZVB2ZHRG?=
 =?utf-8?B?b0RhNm5sNW1EN28vK1JnMkwvVnNkdU1qMXgvc1ZnUnN6Vzl6Um1wL0JjOU53?=
 =?utf-8?B?NVZyeTV0Skp6OU81bE8wRkhXRlhZMWVHTVdFaTE4TThITXBaU0NVNThVS0Iz?=
 =?utf-8?B?bk9nQXBjVEJlbWJkcmdVeGF3bXRNb3RCVHZIbXdHTmJZUE82SjJXY1RZMFNW?=
 =?utf-8?B?NjB0VVdzYXlpbkF6U1EzN25EbzFMNmQrMXpmMlJoTW13MCtuUmpvL2x1ZzdK?=
 =?utf-8?B?eFM5eUJOcG9oaU14SkxOMFpvclFxN0JGWHVTSDBvK2w2L1FyY011ek9YQzlR?=
 =?utf-8?B?Yy9SOTJPb055aDNYV1ZvRHVlaS9pa3pBb1VleXFTcmJ4Z09oSGtOZmIwVmNL?=
 =?utf-8?B?cWNFT0ZqQXJsSHZYMk16dHBGZHliUEo5SW0rYVBhcmNhaFRHeTJtcW1IQlRH?=
 =?utf-8?B?K0U1N1VGWC9qWnB1Ymd4MUlkSWRBaFdVK29VWXBjZDF2UkY5MGwwb0pUN0Ny?=
 =?utf-8?B?eFZ5U0FhUjZ4cnkyTThsWkhoSDZleTg2Vm1EejU1UDgzYitDOURqYlEzY0g4?=
 =?utf-8?B?d2hPL3hZQmd3N3N5eXlicnBhWHFkQTVCV1RydG1ZNUp5ejlUd3NYeHN3N1FT?=
 =?utf-8?B?Uytra1RsdkdaazlMTHhXVzBkQ0pKL0psSHBFblRoS2FaZnlDc3VSSk94QUJw?=
 =?utf-8?B?MHV4dTZsTEVjdUhra0RDQklPeEE1L3NuUU9yOWlhc0daL3pyRnYzM0tiUVNp?=
 =?utf-8?B?anFVejhSc0ZnU2MrblBxYThKeEF3OXZZK08xektmUmFmVnl3VUYxSlhGVVZB?=
 =?utf-8?B?M051SmV5YUEzODhodDV4UHRTL29zZG9wKy9mZmltdkRlODh2VVZsZXVrVHd2?=
 =?utf-8?B?bUlwYU9lWndsUzU0dkFkalZoMXRWSnVHclYzcFBaNEducWNMekJacWJ1b2Yz?=
 =?utf-8?B?YUt2aXNBUjVPWU9YUzJqa3ViV0hmMUF0bEZraWIydnNidjczVWUzK3J6cFFC?=
 =?utf-8?B?TkcxcE5WRFF5cDAxNVliYXdYU0duemEzYmRlOHBGSWx1NUJpZ0xRaUQxak54?=
 =?utf-8?B?ckRTMnVHUkJUcWpIZ1Yyc1k3NGJKRklDZGpxaDJLbUo0K1RLTDJwTmhnU0xU?=
 =?utf-8?B?dkxENVl2YXZFeFR5VlJjZEU5ZzhXc0dxalluVzl4S21OZjB6dEd5blZtNVo0?=
 =?utf-8?B?blVWZnpwN3cwM1FyYTdOamtaT2V0ZzUzT0M5a0tqY3dKZE1Ud3RLRUsvOVJq?=
 =?utf-8?B?bjJvWEJVeW5uWGYrdktDcEg5OFAzNTM0UEJkKzFRR0lhYVNuY3p4NTc0Qko4?=
 =?utf-8?B?WHgwdHdDTjkyU2dONTNJRlhVYmRZMnEzU05EdTZzeDVQc3YwZWhyT2dOV0ow?=
 =?utf-8?B?OUkxcmhmSmxPMStpd01GaUIzQWlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:48:09.4783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90c0795-8ae4-4acf-b5cb-08de5819c891
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5998
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41163-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ti.com:email,ti.com:dkim,ti.com:mid,ti.com:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-gole@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0A951527DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add CPUFreq support for the AM62L3 SoC with the appropriate
AM62L3 speed grade constants according to the datasheet [1].

This follows the same architecture-specific implementation pattern
as other TI SoCs in the AM6x family.

While at it, also sort instances where the SOC family names
were not sorted alphabetically.

[1] https://www.ti.com/lit/pdf/SPRSPA1

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 6ee76f5fe9c567b0b88797ddb51764a2a5606b16..3d1129aeed02b06f5877663a1b87521a230e3b32 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -70,6 +70,12 @@ enum {
 #define AM62A7_SUPPORT_R_MPU_OPP		BIT(1)
 #define AM62A7_SUPPORT_V_MPU_OPP		BIT(2)
 
+#define AM62L3_EFUSE_E_MPU_OPP			5
+#define AM62L3_EFUSE_O_MPU_OPP			15
+
+#define AM62L3_SUPPORT_E_MPU_OPP		BIT(0)
+#define AM62L3_SUPPORT_O_MPU_OPP		BIT(1)
+
 #define AM62P5_EFUSE_O_MPU_OPP			15
 #define AM62P5_EFUSE_S_MPU_OPP			19
 #define AM62P5_EFUSE_T_MPU_OPP			20
@@ -213,6 +219,22 @@ static unsigned long am625_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	return calculated_efuse;
 }
 
+static unsigned long am62l3_efuse_xlate(struct ti_cpufreq_data *opp_data,
+				       unsigned long efuse)
+{
+	unsigned long calculated_efuse = AM62L3_SUPPORT_E_MPU_OPP;
+
+	switch (efuse) {
+	case AM62L3_EFUSE_O_MPU_OPP:
+		calculated_efuse |= AM62L3_SUPPORT_O_MPU_OPP;
+		fallthrough;
+	case AM62L3_EFUSE_E_MPU_OPP:
+		calculated_efuse |= AM62L3_SUPPORT_E_MPU_OPP;
+	}
+
+	return calculated_efuse;
+}
+
 static struct ti_cpufreq_soc_data am3x_soc_data = {
 	.efuse_xlate = amx3_efuse_xlate,
 	.efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
@@ -313,8 +335,9 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
 static const struct soc_device_attribute k3_cpufreq_soc[] = {
 	{ .family = "AM62X", },
 	{ .family = "AM62AX", },
-	{ .family = "AM62PX", },
 	{ .family = "AM62DX", },
+	{ .family = "AM62LX", },
+	{ .family = "AM62PX", },
 	{ /* sentinel */ }
 };
 
@@ -335,6 +358,14 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
 	.multi_regulator = false,
 };
 
+static struct ti_cpufreq_soc_data am62l3_soc_data = {
+	.efuse_xlate = am62l3_efuse_xlate,
+	.efuse_offset = 0x0,
+	.efuse_mask = 0x07c0,
+	.efuse_shift = 0x6,
+	.multi_regulator = false,
+};
+
 static struct ti_cpufreq_soc_data am62p5_soc_data = {
 	.efuse_xlate = am62p5_efuse_xlate,
 	.efuse_offset = 0x0,
@@ -463,6 +494,7 @@ static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
 	{ .compatible = "ti,am625", .data = &am625_soc_data, },
 	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
 	{ .compatible = "ti,am62d2", .data = &am62a7_soc_data, },
+	{ .compatible = "ti,am62l3", .data = &am62l3_soc_data, },
 	{ .compatible = "ti,am62p5", .data = &am62p5_soc_data, },
 	/* legacy */
 	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },

-- 
2.34.1


