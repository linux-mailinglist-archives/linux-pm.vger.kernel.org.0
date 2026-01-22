Return-Path: <linux-pm+bounces-41305-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC+UI2lWcmkpiwAAu9opvQ
	(envelope-from <linux-pm+bounces-41305-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:55:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284506A6F2
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11B34301C0C3
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68C84A1381;
	Thu, 22 Jan 2026 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZfKAqiu9"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49665495537;
	Thu, 22 Jan 2026 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096770; cv=fail; b=tBsta3FL25X6MbUWHGdrV0ToelcFUd5gb6EUmVpsr1HH94rWZpX8Bqexwin7owXxZ6VBnZXuTm5XPboOA7AV/4Cgv7Aw0Jeax/jzAQWvLtXyYf8avy8oljQCLJWsW7XpaqWsceFuHkyhgkxX7Ly1xAsNb0I1y22Ssu779GTPQpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096770; c=relaxed/simple;
	bh=MJDrG/lwfSMZjdO0wj3kn+Mmxsu6SEwXq5kJpFDqes0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jRrr6liW74yb6AUDWZxOurmfx4YUK+eM6GyBP829DmOatZ21eo5y8mIt899jQQ/c2SVZexN3fYWonASZYq04/K3jfqN/K0Z+U9T0Z24oyErqX50htwOihHSS4lvuzq2P7zCnHkw/yiP8mbUKd1JIuSLtiWI3pIKtQdqNBQTjjEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZfKAqiu9; arc=fail smtp.client-ip=40.93.194.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwPWNALW32WDOVFkzvX2bp8eyQrJ8Ggu2+5rY/oIPmWwh1js0VJ6gS0QffRZd8FLATQ1yHfMqivnaygoWQRUY2LWVfjjqE68uAH5gu44HbTwp4a+AsCTqsRf1pn1BTDrKzBXl0dhQ7nSFFVm9TjbGpbYdKaY+H1IGc2I+QCIkcroKry5Z/egQC3nfUQ2pWtzTrd4uKCyEsOj3L/0nx7GRKL/pZT0CSlwPnDN18/tIbPJrNB0rSbYzOJWIw1dcNkeb8Xu/XxmhmaTmAtglKg2DoCgo5g/11loT13ltvKND2t6yUXvYCsi2TWylC5aEmxfYpX6hL2kXPBZ31M+/2plig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utDrOUZb6fj6m2dtLUymPdx0QdMFlxQJd04KLEOZjo0=;
 b=yT/vRtAnUYdONPFcyoaYHP6f9GAEawtjZjg5U94SbVq10jSZoRzChc4zeFsA0OVcjNkxwZUdKnG4L/02gjPpCWSpGaSV/PwuAIoj2/SPbczid+WKO30bS6Ph8YJtXqTocz3Ah7hsxQmtKme3sS2ORjvcojbnq7fPGFFWTUwgOLCR0G0umFN3YvxfIS1ROYWpaaCVyIzDiIwLnIHQLbpZkbzGTTZyuC36Kzl5gXcut3eKQKlcAP2zUXCZGZ+75fr3eiF8o6S6be6yq/iq1S/lSRImJ+iwHG9D7SvWg8RKGZS7dvik09hQZRtG75RVuE9IfYY8z7aM4RzYaSZ2GszhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utDrOUZb6fj6m2dtLUymPdx0QdMFlxQJd04KLEOZjo0=;
 b=ZfKAqiu9bnq6Z8IOYGaitTp1JD6Zg3iQH6eHsdGmLGnyTo5ybkf8EfWIcvjzMd9RGrBGY0r1zOxuq18lRSGXWVeWiZp+VNGE4vhw1T3pkj0M5JuJI2z7TWbMscwJpm+vTsX+rpQwMqDfoSOEEFWSfu/HZEIiKfsskiRZvwV05NI=
Received: from BY3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:254::14)
 by DS0PR10MB7407.namprd10.prod.outlook.com (2603:10b6:8:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 15:45:56 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::7a) by BY3PR05CA0009.outlook.office365.com
 (2603:10b6:a03:254::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 15:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 15:45:56 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 09:45:55 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 09:45:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 09:45:54 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60MFjoWD786230;
	Thu, 22 Jan 2026 09:45:50 -0600
From: Dhruva Gole <d-gole@ti.com>
Date: Thu, 22 Jan 2026 21:13:57 +0530
Subject: [PATCH v5] arm64: dts: ti: k3-am62l: support cpufreq scaling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260122-am62l-cpufreq-v5-1-65c50af71681@ti.com>
X-B4-Tracking: v=1; b=H4sIALxFcmkC/33MSw7CIBSF4a00jMXARW+pI/dhHCC9tST2IVSia
 bp3aQdGTXR4TvL9IwvkHQW2y0bmKbrgujaN7Spjtjbtmbgr02YgAIWUyE2DcOG2v1WerlwWOjd
 iY7BCzZLpPVXuvvQOx7RrF4bOP5Z8lPP7qxQlFxxVKRCUzA0V+8GtbdewORPhL4VEydicgHJdw
 idVbxTEN1WJaovFSQuJ2qgXnabpCfrjMe0dAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769096750; l=4535;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=MJDrG/lwfSMZjdO0wj3kn+Mmxsu6SEwXq5kJpFDqes0=;
 b=qtjkNabRwP8Og1bGgfJxWbsLjIWT7vme56zSBdTYSEBETPAKPskWpPu0gO3VQERN9yo3YRFbt
 lvM0cMJRRDmDJX3jnLpmZFHgQncH7dSwABm6uJk0JCKXgIw+by7Ecae
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS0PR10MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c869833-5870-4b27-4642-08de59cd551f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzU2STF5Mkcra0RSa1VKaEY0TmxRbnZuLytjWHM4NHRNRW1MM2lFUzdkOVRw?=
 =?utf-8?B?QkF1am9NM2REWm9zRWd4VkRMdnIwSzVkWWs1aWlEMHFGMjlUb3RXZUF3S24r?=
 =?utf-8?B?WW5sQWxDVTM4ck5VV2dOanZuYUtjWWE3S244T3BJSHlQWklveDBkOExCbnZR?=
 =?utf-8?B?ZEZCL0RJQWQvclNVdGhGVHRKR21UcTJiQUNpemFMQlNROVNZU1RGU055SHA0?=
 =?utf-8?B?WjRqNFFGdU16QjMreXJuNFB4ZGxvUFc1dG9STExJZmdVeUNWVW12ZGVNTHU4?=
 =?utf-8?B?RlV5MmpFd1NTc3E2NWk5cjJYcXlzQ3lNVEplaHllK3BUQlJXaUIyejBJNkNO?=
 =?utf-8?B?MmV2MzYyNVFOY1M0MzlNenZOaTgwVFNJWU1TMjgrSkxXQU50eG56ZnY3WVZ1?=
 =?utf-8?B?RXNVLzk2T2MxdlZ4b3R5Ri9rMFZXR2cxMjRPZTFOK2ZhK3BpQURIKzlncEps?=
 =?utf-8?B?dzlyNC9zYm0vSlNVbmNGbzh1TkhlazNxZEIxZktjZTgrNDdBV1I0T29RZk10?=
 =?utf-8?B?SFhrQnJYa1hHTklibitoSlVLR3g5MkVNUEpYKzZ6endac0owSHJteVdFbHJI?=
 =?utf-8?B?dU9oL0plcXBycEJWN1dEQTdiUis5dmdqTmdhcFArNGV2THJ3TnlrWjZxT1JE?=
 =?utf-8?B?V0t0U05EUUpFZGpnZnZaZmQySnB3Zlh0VjNSVkZ3VEZoY3M3ZVBNRTd6amt1?=
 =?utf-8?B?MFd4Z25VOHBXcFlqaitrVmZweW5senZjSVZPWUxBUmhiakJvTVpOOTdYWDRS?=
 =?utf-8?B?am4vTGZvTUR5ck5obXBkeHp3eVlMb1BocVpldnpNZ3h4OU54SDRETGpCUDJq?=
 =?utf-8?B?NG1QR1I5Z2ljdGNTNW13K0NHQUl0WkQ4M0RwdkUxVWhGaUY0QkVMbkR1SEFI?=
 =?utf-8?B?REFFOU0rOHZzSDNaTzRNN0VRSkNPSzdOaEozaEh4ZGtwVVJVM01oaG5aNlNW?=
 =?utf-8?B?Y2ZXVDhzTjFWNlpHdmlEWWtmeU5Qb0dMU3VQdmhwMitoNjFyTUN2QnlocTFD?=
 =?utf-8?B?VHNRTVFBaldQUENYem1NaEhsRDg4UFhwcmY2U2RNY0d6djRzQ2E0ZEFxSHNo?=
 =?utf-8?B?OFR5d2RKemkzZjdydEdaeEJiU0lrOGEvV3B6VzRUai9TL1V4Y2hQZmF2elBB?=
 =?utf-8?B?amg3V3p2dWU1UjFUVWh3Vi9JM0c0bmJScEFva3lJUzAxUmpoTVJWZU5pT3dj?=
 =?utf-8?B?NW9ubkhoTExQRUFwVGUvVGx3eTZ4Y21Va2UwWUtaNXpLY0lzdWl2UG5UQlRa?=
 =?utf-8?B?NGNsYU1YN2d1NWJYcW0wR0wwcVQrV1lqYlcyTzBZWlQySk1YSXRRL1VZSUpY?=
 =?utf-8?B?V0J0WGV6L2xLd0JuSitTUER1VGoyd1JlWDM1ZkptYmVnK2g2Sm5RUG5EMlRa?=
 =?utf-8?B?RWFab2NldHpBejNRSWdqR3ZiR1hsb3o1UXo3V0FmSTFuUzlDT1dZL2sydjdN?=
 =?utf-8?B?QTc3WExINWVEcDduSWtjNHpzZDRZMzdVd3ZUMHNCRTl5VFVTQjRUbGZUZCtQ?=
 =?utf-8?B?U2VLRFlxMDV3Q2FybnlWVG1sQXpqeUg2VG9remJIT0h3OUdTaHVlZW5BdGZL?=
 =?utf-8?B?UVd6aG5SUjlXUDRQNHNuQ0NKazFWK1BiMFVWUENlVDY1MDEzRVR2NXJGUXBS?=
 =?utf-8?B?ZlJ3VithbXVqN2hia1NOMjNOSXdwWnYxUUo3ZEF5bHBXZFQ2VlF1TzlGaWR6?=
 =?utf-8?B?QnN4UTBlMGlRSmpqNW4vdHhablpBUGh4eENKZUZnUVQrYTVKZTB3QzBLU2t5?=
 =?utf-8?B?aFdsek5BRDNLeXMyZERRbklmK1JCaXZxdWN1ZGRHSnV5SEsvS01XUVovbnZ0?=
 =?utf-8?B?WWFrdFNJU3luZkRrVXgvSjREN0RpUzVKZnd5bHJ1bnE2TUl1SjZIRmZtT0NJ?=
 =?utf-8?B?cytURjZtUDE5YWhOUzJ5S21mUzBDTFhDb2hTS1BOeC8vTlVoU3RVcUFScndG?=
 =?utf-8?B?WU0rMFBLTEVZT1VZbkxaaEg5MTUzSExiYThwdjROR2M0azZ5U3BVa0ZFb1ZB?=
 =?utf-8?B?WG1mampidTJUTGY4Z3NRM3hldDc4MTNCVythUlNSZHdKZlpLVG9TSmFXejVz?=
 =?utf-8?B?ZDZXN0FLaUdRR0ZQMXhnRmRqc1psRjN3RkJ2dkVlUnBqcTZ3MGVwZW1talhH?=
 =?utf-8?B?bUl0RGFLeHFKYUxrSHN1aGdxcEJnWG5qMndZeUNDcG5WZEc2NFhEeFFHRmZU?=
 =?utf-8?B?MlhrV04wV0lUS0duQzdZeThOTy9wZEpheWpmeTR5ZkNlZnpubTIrTmJ6eWpa?=
 =?utf-8?B?MXl2RS92ZVk1L1p1TTBlMlpMaW5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:45:56.3074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c869833-5870-4b27-4642-08de59cd551f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7407
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41305-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.0:email,0.0.0.18:email,ti.com:email,ti.com:dkim,ti.com:mid,0.0.0.14:email,0.0.7.208:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-gole@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 284506A6F2
X-Rspamd-Action: no action

Enable CPUFreq support for AM62L SoC by adding the relevant OPP efuse table
syscon for speed grade detection.
Add the operating-points-v2 table with CPU frequency steps from 200MHz to
1.25GHz.
Specify the CPU clocks to reference the SCMI clock controller for frequency
scaling.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
Hello,

This series adds CPU frequency scaling support for the TI AM62L3 SoC.

The AM62L3 is a low-power, low-cost SoC from Texas Instruments. This
series enables cpufreq support by:
1. Adding the SoC to the cpufreq-dt-platdev blocklist to prevent the generic driver from probing.
2. Extending the ti-cpufreq driver to support AM62L3 speed grading by reading the efuse.
3. Updating the device tree with the necessary operating points and clock configurations.

Tested on AM62L3 EVM [1]

[1] https://gist.github.com/DhruvaG2000/6dcceb80cf7bbd1e624ec210532538cb
---
Changes in v5:
- Update the opp-supported-hw value of 1Ghz entry to 0x02
- Minor reword of commit message
- Link to v4: https://lore.kernel.org/all/20260122-am62l-dt-cpufreq-v1-1-fabcc15e25fa@ti.com/

Changes in v4:
- Sent as a stand alone patch.
- Fix the bit fields in the OPPs as per Kendall's suggestion
- Fix the scmi_clk ID of the second A53 core
- Link to v3: https://lore.kernel.org/r/20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com

Changes in v3:
- Sorted the #defines and structs for am62l as well after am62a
- Pick the R-by tag from Kendall
- Link to v2: https://lore.kernel.org/r/20260116-am62l-cpufreq-v2-0-eac7e2e78d29@ti.com

Changes in v2:
- Sort alphabetically while adding AM62L as per Krzysztof's comments
- Link to v1: https://lore.kernel.org/r/20260116-am62l-cpufreq-v1-0-63d062317ae9@ti.com
---
 arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi |  5 +++
 arch/arm64/boot/dts/ti/k3-am62l3.dtsi       | 47 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
index 61bfcdcfc66ea8d802a36ed43cd01fbbf3decc70..a42ccd0d2fcc4d204cae81508f839c44ce83f558 100644
--- a/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
@@ -127,6 +127,11 @@ chipid: chipid@14 {
 			bootph-all;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		cpsw_mac_syscon: ethernet-mac-syscon@2000 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x2000 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62l3.dtsi b/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
index da220b85151227c63f59b2b8ec48ae2ebb37e7bf..fc514e19f57d5318f851bad2756817dd7ec29b38 100644
--- a/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
@@ -39,6 +39,8 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&scmi_clk 356>;
 		};
 
 		cpu1: cpu@1 {
@@ -53,6 +55,8 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&scmi_clk 357>;
 		};
 	};
 
@@ -64,4 +68,47 @@ l2_0: l2-cache0 {
 		cache-line-size = <64>;
 		cache-sets = <256>;
 	};
+
+	a53_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		opp-shared;
+		syscon = <&opp_efuse_table>;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-supported-hw = <0x01 0x0003>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x01 0x0003>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x01 0x0003>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x01 0x0003>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x01 0x0002>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1250000000 {
+			opp-hz = /bits/ 64 <1250000000>;
+			opp-supported-hw = <0x01 0x0002>;
+			clock-latency-ns = <6000000>;
+			opp-suspend;
+		};
+	};
 };

---
base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
change-id: 20260116-am62l-cpufreq-1987a04a6f68

Best regards,
-- 
Dhruva Gole <d-gole@ti.com>


