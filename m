Return-Path: <linux-pm+bounces-41161-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH8wGosrcGniWwAAu9opvQ
	(envelope-from <linux-pm+bounces-41161-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:27:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C314F14F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA0841619
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16403BF2E5;
	Tue, 20 Jan 2026 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iOnnDgNl"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2D339848;
	Tue, 20 Jan 2026 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909685; cv=fail; b=Z9HbrhY6agZIteWrw6wUXeE5PHTjE9gilYPl9SxmnKqH9+rnjhqCMT0vY9tpzub9VsXu6c3bbzy0H67DxJg1nc4Q0Ihuv7oSkyiVVuVPRdUDMawdr8UkwlW47QWvxoEAm8ahyJ8sEjr1UOEmdiX9QajIFsv5WexuDP9B8EfP6c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909685; c=relaxed/simple;
	bh=gHwKlw9tM7umxFfbAWIca6msfZb96ehD0ii4uxfAk/Q=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=RFykpiyQwFCTPFxkwlhgtooyfoqkPhRUuK9RIc5hmXO5CzlMvrgWJYX7gKIvqT6mQ2PVhcNyLZjJINynl9NhSjJnbRH/E/06t7yH59kmR8bIh8qHEXpLpcxFx6dWyHj5qDfobT6Fy+iMCy9a1AtqEWv8gUHXeF5HLWPq1mly8E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iOnnDgNl; arc=fail smtp.client-ip=40.107.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyOevY+3u43SmSlVxicCdTKCxIHstbzpOHxf98fx8+5SAS89YmQN9PJMMbCa0xO7RskvTNoknvc/CcLsdYBkSsrNMHrfQWoc0KmGDa7v1hwzJkSuX1VzHmELm6N5Cq77n38M8/2lh/hnn8eEk+3+mkea7hBUdrlXCNrWABT01EgejVwzJTZB2zh+v6rn1AJ56fI/2+s2N3WmlE7yeqWbPAYpSpB0pPT1031M6FUs2dlrtSxNoT5JxL9t4rgTfMRcHIkCGKZzyPHC6PMNERIno0SlT9Vc7OmpoICVBAUGPNhAWHyxDxcMAEfp9/wXaG01De7cFLXxQi8HvpYO9Z1/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otBxXoelkVyGWdviwTNicAVK1vpnWo8ztzTWW14MJ50=;
 b=poowlZ/Q/STR5apcfik3/ghkDB/imPMcjbuv9IYKhUbanXJ+yLGhKeKtwIyiwNrNZwv/AAKpLnE65HpaXY4ORtlI4UkSwAXCSkR1KYlmzCL4wjSYAb9uOZueoM+zQaljHhMsQbbD1T5bfFC+zphpTMxOpnXla0v0QyElDzUOOYdGE7UDjG1ScoMI+iqDmRrm1R28+8AtwANv4wcJ74B/8RdYpOYDPdQXex4JFQJWk7sC1L5xDGLpk5uv5rc5KRMQeLtlnzgAbBda1QdvMXj4ukg5euFYzH6b9vJBhopQwE/G+IQAyarEUJF1Qqb2YwvDY2KNcUbaN8rqYLVsryQTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otBxXoelkVyGWdviwTNicAVK1vpnWo8ztzTWW14MJ50=;
 b=iOnnDgNlN+nWXRmK/htT3gWloi9sm2lLKwdwKosNL7houaPD2+eV/RWBPRmKn/pHYUQLYDOrfHxhQusavqHo/lIerZCux8lJQptGrp98vSGstv92hFEfqGn2JiKzAEwUYykiyPNjZaAjpbUf5GB5ZEZWGvDK2MLku+kU0lHs1RA=
Received: from SA1P222CA0133.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::18)
 by SN7PR10MB6618.namprd10.prod.outlook.com (2603:10b6:806:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 11:48:00 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::37) by SA1P222CA0133.outlook.office365.com
 (2603:10b6:806:3c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 11:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 11:48:00 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:48:00 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:47:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 05:47:59 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60KBls131151397;
	Tue, 20 Jan 2026 05:47:55 -0600
From: Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v3 0/3] cpufreq: ti: Add support for AM62L3 SoC
Date: Tue, 20 Jan 2026 17:17:29 +0530
Message-ID: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJrb2kC/32MywrCMBAAf0X2bCTZyqb15H+Ih5Bu7YJ9mNSgl
 P67aS+e9DgDMzNEDsIRTrsZAieJMvQZiv0OfOv6GyupMwNqJG0MKdcR3pUfn03ghzJVaZ0+Omq
 ohNyMgRt5bb/LNXMrcRrCe9sns9pfp2SUVlTUmrAw1nF1nuTghw7WTcK/KeaUnbeMbMsav+myL
 B+ElPO54gAAAA==
X-Change-ID: 20260116-am62l-cpufreq-1987a04a6f68
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768909675; l=1663;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=gHwKlw9tM7umxFfbAWIca6msfZb96ehD0ii4uxfAk/Q=;
 b=/j4T/ttVU4zDMaIZ2HuZZROGc/2ZLTCSsUyXEma/okGgyg0nQSG1M2Das5T4BmmmRtHeuE6rq
 XMVfxG39isNAjyxxVIClHfQLWkuVo/EHd+itGPzk3K1PDFut4oqxbmt
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SN7PR10MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: cc998257-501a-4cf8-d099-08de5819c325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzMwN0ZVTTU0SzlyS0IvQWpSNll5Tlp2WXkxNHJ5QzFZZzN0RXNqUTJtcytu?=
 =?utf-8?B?VjJrNGRvR2p6MUNtSUxkU3hMRnF1ZEpCSHBpUFFEbjVtZmhIendROWJRZm9t?=
 =?utf-8?B?bTU0Yzk4N1l2eDc4UGhsWENIanRBc2ZBVmZhRTRTZllxNlUwSEpGZWhibnVz?=
 =?utf-8?B?aWY3dXBoR051MzBjcU1UZ1lPRHhkUTk4bHJ2ajkyUDB1QkJ4NlFDZzhCSTZ5?=
 =?utf-8?B?K3F2eGFKb1g5aGlUbUtQMVFPa0F5WGtmVW83TStlVG94cC9FWWlGTlZCQUxZ?=
 =?utf-8?B?MDdIVXdpdnJmcGhYR2dQaTZLY1VhbkxpSUdlUXpBdnFUSUswemJaM3NJYldx?=
 =?utf-8?B?MlZmQkd2WkFZemFxV0JyN2RtV0JnSTNtZ1J4Wm5nWU5pdCtzUkNPVERhc2Yz?=
 =?utf-8?B?clNpLzUxY3VjQWJCcFIzbGg1RUk5RXRwUkhackNybko3TFRodHNDekljMTZZ?=
 =?utf-8?B?bjdKRWZuTlZmcElqRGdYR2RaL0lXRHh0Mi9hSDBLQS9WZUMvUkpXUllnVWtm?=
 =?utf-8?B?Zjg0NzA5Sm9iTE9kZXVEMkxFTDdCM0kvcWl1aGFRUmQrUXNNZGdNL2RqdUdr?=
 =?utf-8?B?KzlCdEtIbXA5ajM4bHhxLzdzaGVzUTRSZ3lIV2NzYzUvMTNNa252c3BKM3Rq?=
 =?utf-8?B?Tkk4SHNzR0VsdEh6em1rSUxhZnliSTI2OUJxamwwVlVmZGllOVQyRXNLV2c1?=
 =?utf-8?B?OVZualhrVnlqY1hnbTdTZWdCd0pxNjJsYzQrUjE1bXJERVlTU1ZTa3FaMTZu?=
 =?utf-8?B?WTdobmZXUXhranprUGlOUnhVWHEva3VDRXF6L2dTV1FNZVRhZUE0cmxaTmtF?=
 =?utf-8?B?OG1MTG9uVmJkUUJGbWFROE9iWEpGUDdaTWYrTEVwK0lzaXRZdE8vR0JROEZH?=
 =?utf-8?B?Z0VndG8zbGtrZHZiSnNEbm5PcmxpSjZidkg5OGQyMnQzUEc1cVRyb3UweVpk?=
 =?utf-8?B?OTM3cmlKYTBHR3dYMGdMOS9aaDFWaUkrZ1VZL3VvS3lRaDZMaS93TFExcE9r?=
 =?utf-8?B?Y0N0a0hlRzdXYWdBU0VXUlRPK0U3SkU5TFVncUhWbEcvY3ZwNXl2V0FaazNz?=
 =?utf-8?B?KzF0YVlPR2lwcFJla3paK0dGUkdGSC9RMnNYa09OVzI0M3BxcFdsU0lid1hT?=
 =?utf-8?B?a3EwTFpLS3k3aENYcEppamxZbzNGUGYzNHFBMnJ3MEhPNDNROWdsTURvYTFo?=
 =?utf-8?B?RCtueEJMcU9IbkVzMmpzU1N1TU4wQVZ6azBPRjR1RmpNczdJNURnaEplM0Qx?=
 =?utf-8?B?TW5ybFZQRHJJU3JVY3NZSHBHcndQeThKSFlTK0ZTbURUMTFLL1B3ZUtoa0ts?=
 =?utf-8?B?RlJ5THUzejhLWHYxU0ZkZmZrQlFRNlhENGpvS2hQZEE1cUdYSzl4aWdKdXZ2?=
 =?utf-8?B?UStVam1wM2l3QWJKTTR2elZLTzkrWTFKeHpZMllNcHhWaDdlc3JHYlMxQUQr?=
 =?utf-8?B?UG8ya0ZhK3l4TjRGME5WR29WNEVYeXpNTCt1QlFkSStZYzFCYzE0bTBjWTlz?=
 =?utf-8?B?bnp6M0UyV082VkpyMlc5d1g1Tk5reHhZV0tLdFZJamxtOHZPYUZOb0lqaXlm?=
 =?utf-8?B?V2NVeUNMRzl4T3VCTDlrZDAyZlFQUWppR2l2SUN6dm5WZzl1ME5VcFdtZGNT?=
 =?utf-8?B?TFM4ODh1Z09pVWdMc0dGMWlMcjloQ0RXak5hTHVDbE5rb08vU3lzcUgrK1U0?=
 =?utf-8?B?eHgyb0ZSbDMwSWU2OEp0STkxRmlIeWZ2UXRSWGRQRXFiZi9wUmt1bCtTNE0r?=
 =?utf-8?B?V0ZFUjZRNk5DM1gxZGlJTVJlRkc0YzI3cXpGbnZHWnJJMDlGSDVqWUoxZUFB?=
 =?utf-8?B?NHdiekU4NFRXVllLRk5kQ0lWaWlwY3JocmdsWll0MUxJbmNBdFVGTnVva0d5?=
 =?utf-8?B?cGhpN21LTkJ2SzdRVVpHT3U4WVRqeDVEYUU2NVNSMzJxUUtGVWFLSDJNUGRi?=
 =?utf-8?B?UWtONGN6aGc3bW9NbXhxaXloaThTUVUyMW1BSjNuZjBkbG1kV2VxTW1WbWFu?=
 =?utf-8?B?VEJWdDF2c0JxM01SRWxrVzRpREhIQ3Z5TnFiUHJNL0hJcGM2eXJ3S00wbFYy?=
 =?utf-8?B?TVpweHFZUUpwSkJKanIzUStlVWhmYTQzL21aVHpDVlV1WElsaTBjbC9ma0Ft?=
 =?utf-8?B?Mzl3cWwranRKMFFZckpaNmRmNWdRM04waEpyZ05jTTRmRUg4QzZzN0VHNmpw?=
 =?utf-8?B?L3ZpVEJ0WVAxbERlcENwcC9xOGlQclBGYklYTWFXTWxtajdVVWk0Nks0VVRB?=
 =?utf-8?Q?L/dCy3NGCIAPk1DJAFWjyRcYcWdFQcfm/CpOv4Oci4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:48:00.3870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc998257-501a-4cf8-d099-08de5819c325
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6618
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41161-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ti.com:email,ti.com:dkim,ti.com:mid];
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
X-Rspamd-Queue-Id: D5C314F14F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This series adds CPU frequency scaling support for the TI AM62L3 SoC.

The AM62L3 is a low-power, low-cost SoC from Texas Instruments. This
series enables cpufreq support by:
1. Adding the SoC to the cpufreq-dt-platdev blocklist to prevent the generic driver from probing.
2. Extending the ti-cpufreq driver to support AM62L3 speed grading by reading the efuse.
3. Updating the device tree with the necessary operating points and clock configurations.

Tested on AM62L3 EVM [1]

[1] https://gist.github.com/DhruvaG2000/6dcceb80cf7bbd1e624ec210532538cb

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
Changes in v3:
- Sorted the #defines and structs for am62l as well after am62a
- Pick the R-by tag from Kendall
- Link to v2: https://lore.kernel.org/r/20260116-am62l-cpufreq-v2-0-eac7e2e78d29@ti.com

Changes in v2:
- Sort alphabetically while adding AM62L as per Krzysztof's comments
- Link to v1: https://lore.kernel.org/r/20260116-am62l-cpufreq-v1-0-63d062317ae9@ti.com

---
Dhruva Gole (3):
      cpufreq: dt-platdev: Add ti,am62l3 to blocklist
      cpufreq: ti-cpufreq: add support for AM62L3 SoC
      arm64: dts: ti: k3-am62l: support cpufreq

 arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi |  5 +++
 arch/arm64/boot/dts/ti/k3-am62l3.dtsi       | 47 +++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c        |  1 +
 drivers/cpufreq/ti-cpufreq.c                | 34 ++++++++++++++++++++-
 4 files changed, 86 insertions(+), 1 deletion(-)
---
base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
change-id: 20260116-am62l-cpufreq-1987a04a6f68

Best regards,
-- 
Dhruva Gole <d-gole@ti.com>


