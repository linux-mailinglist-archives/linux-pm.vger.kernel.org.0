Return-Path: <linux-pm+bounces-19173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B815A9F04EB
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 07:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECFF1883B8F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 06:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A318CC10;
	Fri, 13 Dec 2024 06:39:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021097.outbound.protection.outlook.com [40.107.51.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEF218C32C;
	Fri, 13 Dec 2024 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734071993; cv=fail; b=hw/yvAOeINHklWXeXzdcddkWavo46P7D9dQKna+u0jXzuR8d8TTrcdqW135rf4WpmGl2YYGbr6CxyJsvGjNHhllcfgifDj/PwMCpC88/0bBojoK287rNzV66L9sq0TPQJO2X+vGqbeMYQmTdPbEmFquCfTqHClnSEhy43SmVI/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734071993; c=relaxed/simple;
	bh=k3ZSO2dKVWq2ccYCLW7EKq6zqVSR76pN/qzQMyEv3KE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SD15jwzvdr/O2ahIa/PN997Z+lXzcQgHZCZtqaDmXELDvoca9Y8rR2KeUhDe6OTeW/MNoVvv9aaeNOnJmWlS4GCb8BsfrS5GK//qBnzbw91WbX9vDwPBAlrXd/dsFt7KyupVwxm7EkpsSfuh3+pwg+D9NXGH23QFeJXXruLfNEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNdOyECV9o+gtlJmRpzLpGUgkEoGVF2fbi30LGXYGSLex7Zq+WxfbkSNILfVd2lFwBO2BIFumI+ypiKqGPu5gPRhu6sEEoIIYOARLH+uy403JDqbBaTnHjC/06+hxmTtWndeJS/Uok4m/7ZRPqTCAA8mZvqWw9UCDT9n+nWuAj2KMhES9bPhxosqah/sBuRwk8Fp+bqRfvDlKWqFw+OB9ikZW1bz4xoPvetw6eTZFqZNFRo9g2IdCg6IP/yCEY3W+MUnOG0ADjiX8d+NcoebfYT8p9RMjcPVaxL3uZfT/SGFgurrWn9OaoLQug2L5yRgT6c5/B5EKEsNpk+yT/AVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tbgh/ZyZCmJaHJHB56Vl696HG/GNPyXUha4cq2H+hZg=;
 b=DRLkpWlt8mRGDShJT5q7gTs3m0o+6dht8tT64j9t7z4vy4QJqtIkzNqmh/UEM5RDFdPnoxojWVi1/v71iZHjXuc1HZXE0jWjaRbnYfr4pz4hUhj/vlUYwazXFWAPYDFY82QPHkWM2eazac5xg780iacgbf5vBfIlIGxyBTM/qMJYImeBl/NevKII1LwJcB79/nRdfM3/WYnpKdR+Rob3inzaKm/AofNRK6Fqyx7dVduxUwZlZaql1s3EKYgxxsBxD6napPd1gMxloxM/XMxZ3h0ljVgtf6CUETuLrUqsNGvaEgU/BW3o4GxOvSOLDMakMqETMW5Kb928a+/90XsN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by MAZP287MB0053.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 06:39:47 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 06:39:47 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	christophe.jaillet@wanadoo.fr
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Fri, 13 Dec 2024 12:08:10 +0530
Message-Id: <20241213063813.32371-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213063813.32371-1-bhavin.sharma@siliconsignals.io>
References: <20241213063813.32371-1-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::18) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|MAZP287MB0053:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d13f476-baa1-45f8-6b91-08dd1b40effe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RERyY0FHSVJJb1RQNkpJaG5lUGJndjVJQnNTVHI0NXNzSzAwSlJzdnh5VUVR?=
 =?utf-8?B?R1hiVFFZNGl0NVFEL0NTQnc3M0Q2Wm1rYm1hNWVvV0dNemc0Z0R1bnp3VDI2?=
 =?utf-8?B?WVVZVnBPbmQwZW1KRzFhNjRqZk0weC9YYThpa2xObjdFOVlVbWhVY1oxV0xE?=
 =?utf-8?B?a0tCZGljb1lXcFVwUUd4ZlZuZEkvR29RT3Rld3piUnJTd3lwaWFWenF0OHBH?=
 =?utf-8?B?bVBLc3Y5RERQckg3ajY5THM3Mlo3NXdUVUlJNEtQVkdodWRpYkZ5ZWpUWmdU?=
 =?utf-8?B?cTZYbkNYTGcwQURKMTMvN28zVDVpcnZhc1JsK1JnQzJnWTYzYVFCY1FUcEt3?=
 =?utf-8?B?Z2pOMUk3NXkvL1NvOGxsNWdYN3Q3emY0YU5hMUFSRFZjc0lVV3M5eEc5dEpt?=
 =?utf-8?B?RnFUa2UvbWpsYzU2NDRmeUNCTkcvcG1hVE1oYzFwN2I1S3lhRHZLNkZFN3V2?=
 =?utf-8?B?cHQxa1BGMlc2aTAySmkwRXBaQ2NPNHFLM2EwcGdyTnBkUkhUM0hQbW1nYmE0?=
 =?utf-8?B?b3FDMGkya0lkbkJ4bFZjclA0dFJLeThOakJoV1ZWT3pFUU5hUks5QnJiZmlj?=
 =?utf-8?B?cVFtclVVSnpTakhhYkU2VzZwaVpRTjdjcjhRMFFsQVg5SEZkbXQxTTNRTml6?=
 =?utf-8?B?OVRDd0psYXM5VHAzV3NEbXR2Q1RQSkNIa0R6SDB4cUtSU2MvRVFiYnlHcGN3?=
 =?utf-8?B?dnc3K0FBWWxyK3J4SEVyakxyYlBlbjQ3SUYwaXlaWFVPeW9FT01sL255SERq?=
 =?utf-8?B?YUR2RldyRnBpS2J2enpwR0Zsa2s5cEZKbDVVcStHQnZuV3dOZkcwRHAzTTdj?=
 =?utf-8?B?NWxmRVhKZ2hTNlRleHdKbDN5VEtTSldJUHZpWlI2SVR0bkxuNms1cnJuTFVF?=
 =?utf-8?B?UFBuUFNRZnBzMVY3ODZyU29naW9RT0hWbUxjcWRFbEU5ajN4TldpTWJnRURs?=
 =?utf-8?B?TEdYZ0o1WHhXckoyZlpERk5SYnVOWXFGVXlSQ0RRb25ZdVF3TG5tTnZmS01m?=
 =?utf-8?B?WVk4WnBaY3I5SmhzRnpWSCs0L1R3UW40L2hBV3o5eGlVcmZ3MVBBeWY4M2Fp?=
 =?utf-8?B?RU5LbWZxRjBuVkFvWkRJVFRmQ0hmcU9CL3o1OHZONHpsUEgwZ0hnZVF2dkNz?=
 =?utf-8?B?dFUzdHI0b3hZVnRyaW95NGNBNElIV1cySFJWN2U5NFExUUdHelo3Y3d6Tjkv?=
 =?utf-8?B?dXhTQzBWWlUxbXRBQTArMXRObXVLVllYRU52YXhsSVM3YVNvbWRaTE44RXd1?=
 =?utf-8?B?WE1GdDFocWhHVjNFcGFGZHNSZ0R6UWhGTHpiZTVFL2kyL0wyYmV3T0FNdjRy?=
 =?utf-8?B?a3NDeXhNSkN4U202RUZEUVVkT0ZxRW4xdG0wbXNJRUdyV0d4aUNicEZNOVlS?=
 =?utf-8?B?L3lKTGd5ZGl1bVZ2K2FkOVlYbzZlR3pDVFNNWkNEN2F5bmFVaUhxMzVpRkQ0?=
 =?utf-8?B?WVZMM0hrdERyT1hUN0t0aVFwNFFxd0NRY0NwRTZPOUdJVk5NMUpERkptd29I?=
 =?utf-8?B?dk5oNlNCRUhMRnJFS25OSVhkWXRzY1ZqbU9TM0ZudjJWZ2EwUmNtV2d2Q2dO?=
 =?utf-8?B?K1FZamxaalBpSUg2b25hUEpmSjR2YXdCY2NnYXlJeWNZb3ltSHYxK3h2OXd1?=
 =?utf-8?B?ejJycUNCVnNTam9CTHoyVlNrSjByN1duMlZiZklId1UxVEdSb1NJUWtTQmpQ?=
 =?utf-8?B?TjNlR0oyVmlMSDlsVjdNcFUybGFLbzVLT0Z1dW9kNWhCeHY0RUlDK0p3K2pq?=
 =?utf-8?B?Wm9FWGY3cTR3TVczMzU5ZXhQLzc4ODhGaXhSRSs0eU1DUHlTbjNuOE9aTCt0?=
 =?utf-8?B?dHRtM3cxeGxhaEFwbVRpSUNZLzBVM0xuQzFkVkhlWUMvSXdxcGRqcGFiaU9i?=
 =?utf-8?B?UDY3V3dpMjZCMi9HdEFLc0JUZFBuRk01UEZVUW1lZndISFo2Rk1wMG9pcFpD?=
 =?utf-8?Q?5h6pp844WNiZ8/IYXwgxU7/tijg0jSwo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mkk3STZ1NmlDaFdVQ1JOUWRWeEhLTFlINUNuNVBXVFVYUHgzcHQ4SlJEUkpC?=
 =?utf-8?B?YzJjdCtlQXIyaFJ2YzB3Vkd4UHMzSzBqZFpuSDZpbldHc1VqQkJXZktzdkpt?=
 =?utf-8?B?bEJsQTlqY0ZFRjZsSXFPN3FHSkpWTzFDS0F0Qm9wSWc5NFl4V25hTCsxQXV6?=
 =?utf-8?B?clpnNC8zSTJDSjlPU0dNSnIwMFQxRDR1S2xkUUdWRnVCUlhVR1ZNZWQwdGMw?=
 =?utf-8?B?Wi9RZW10OTdqcUJVUEZPQyttNUNrSFFlL2cwMnQ4YzVFLzBTWUhFRkU2K1Zn?=
 =?utf-8?B?VEQ1cEZsc01QZXhvYVdxd2UyMy9QNzlVL2JoTTFrUStHcTJhZUJCYnQweEdK?=
 =?utf-8?B?WHZ5Tlc0TlVINEhMZG1jbFhDbnNFaGpIRkR6clYyUEFsdDVGRVJZMndhQUpp?=
 =?utf-8?B?WjliWmd0dXFqV3IyWW0yQ1dmRVJXRkVodnZ1TmhPR1RTM2p1bkJjV05xMm5I?=
 =?utf-8?B?Yk9QVkJySkdMdXZHbWNYZ1hmNlpKR1oxZ2RxU2ZPUExwOTc5bzNpME9TRnQy?=
 =?utf-8?B?a3l0QitPZmVvUTJ1SEZwbnhVZWt3MmhCUXhLZVVaeURJUGpRRkErNjVZZTNl?=
 =?utf-8?B?SXF0T3JpdmtxSlBtSk8zMi9EM2p1U1VHeGYvQmk1SzFvM1RpKzB3YmhMdVRn?=
 =?utf-8?B?ek5mSGpxOFRnVDVGWDY0bXdKM3Y0S1hXeFFCUEpSeXRxMEt2blo3MDloWU5G?=
 =?utf-8?B?YTN2aFF2Mm1FNDNaRVA5Q0c0SEZtVE40a3JFd1dYNjcrY1BDL28wQzl0N2tX?=
 =?utf-8?B?cVRTaWVvd2s5b1RBdjBIUlFhOVEvekdNZTZ2S3JDN202eWtVVFhwOW00WmM5?=
 =?utf-8?B?M3Y0Wk5aTHNlYVlXMnBQZDBERWNqakVjcW5GTnNDcFNDU0ZrQmZpWlB5a3VG?=
 =?utf-8?B?WWl3WmV5a0RFZFNGSjdlVGZ0TmtEV2I5NzFmOTF2cG8xZTQxTXpYa1phOWRx?=
 =?utf-8?B?ZzFIdDNLN0wxaVdiMVdHL2d3ZUJwbmZqbnlTWFlWRkFDRXlzSUVQaktCaWRI?=
 =?utf-8?B?OWUvbklXS2oyUlZhcVlxc2ZoV2l6RUEveC9MM215dWtjZWxydTZIMC9EOGFM?=
 =?utf-8?B?Q1RiNklEenhYd1hiNllOcWNNclY0ellmMDhrN2pTUGdsdFRxNTFvNFRwc2tz?=
 =?utf-8?B?OFJXeDBCd1NyWVJZV3FxVVRHb0NFdjZOQVhacWhlbllBVDRiQzVnc09xWVVP?=
 =?utf-8?B?Mzd0aEpmRHFYbENLNnN0eFVaTW5ESmJ0S0wxRXMyajhCQ1FJZE1iUkQxNHM3?=
 =?utf-8?B?aS8yMExxdXM1NEVPUFpmT2lMMitXNGNtL3pDU2dzOHBpQ1hXOFljWjN5cDJF?=
 =?utf-8?B?WE9vaDUwZmFtWm9IejM5eHJjUlZ3cDFvelRyTkVOKzNtQkxNR0RTaGZSNlVC?=
 =?utf-8?B?eVpDTUxLb2tYdUY5RTcrQTA0VDBzSW5xS0paZEM4Z0tUTWVSNDRWRGJtQW9Q?=
 =?utf-8?B?ZG5CVWpUNDRwc1locUxxblROYkxuZTlBeFdDRlhqc0F6ZU13NWkxcEJKRXlY?=
 =?utf-8?B?Wm92OGxKK3RwYlpmVHFsNENHZGVvN0J4cW9JUnovaURBK1NnWXVKci9MTUtH?=
 =?utf-8?B?QUlLbHZ2dnlOM3dxaXZ1dmlueFZoMzR3WVBDZUkxRjk5Q0lGZ0w1cjl3SElz?=
 =?utf-8?B?dFhiQWJaZkd2NWgrYUthdm02TzJvY1dueElWMFRXajB5MVNWcHFzdnQ0WW9M?=
 =?utf-8?B?aEVIY2lnMWMwRUNjajV5U1BxVGsxbGJTME4ycnRDQmszVG5lT055U1RqNDlH?=
 =?utf-8?B?WXEyZEhRKzB2QVdHalQvUFRZTmE0UnZjc3FRazlUa3hWSHVrc3BHT0hTYVlD?=
 =?utf-8?B?cGpLUlk2cG14TDRXOG1JZTFZbkVmTktteWpuU2RFVUZZMUhjbXBHWnVJNFRJ?=
 =?utf-8?B?aFNvUUhMai9lSTI1OWdDRGNYcyt5cTVXcDhTUGpBNkFZSWZaSWVhdkJZY0c0?=
 =?utf-8?B?MzNJZzcrbVh4V0FuRnkwb2lJNkV0K0c1VjVtKzZDeTlGdTdoNDE0ZFRDMGl1?=
 =?utf-8?B?ckJobWc5TFppVzFqbjNQNU1Hc2JicGZ2RUd0TU1YTHdwY2wyWCsyUkMzTWVr?=
 =?utf-8?B?N2k1NkYxTmx5OStpWXJzQmdWNC9xRmd6MDhTWUFMVlBZQUJEMzJIOXdJdkYv?=
 =?utf-8?B?c1pRZStBWUsxK0pzVFZiek9CcEhRWVB2VXdaNEVubnIrUUtHYmdveGVRMldN?=
 =?utf-8?Q?bajIRP8CF5/JsgWpwbUe0+g=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d13f476-baa1-45f8-6b91-08dd1b40effe
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 06:39:47.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boLm2n8T1MwFpqtczcrJd4/HDSR5gxvwOz+QED2BtKA5lrRTvZBZ9HbczFFvJnv8x0QtJw7YpMm1QJuln+8er7vfwuvWmBnugoGdYcPPhuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0053

Adds initial support for the STC3117 fuel gauge.

The driver provides functionality to monitor key parameters including:
- Voltage
- Current
- State of Charge (SOC)
- Temperature
- Status

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 MAINTAINERS                               |   8 +
 drivers/power/supply/Kconfig              |   7 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 608 ++++++++++++++++++++++
 4 files changed, 624 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 17daa9ee9384..85e29690b9fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22168,6 +22168,14 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
 F:	drivers/media/i2c/st-mipid02.c
 
+ST STC3117 FUEL GAUGE DRIVER
+M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+M:	Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
+F:	drivers/power/supply/stc3117_fuel_gauge.c
+
 ST STM32 FIREWALL
 M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
 S:	Maintained
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9f2eef6787f7..0806f00058a4 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -918,6 +918,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+       tristate "STMicroelectronics STC3117 fuel gauge driver"
+       depends on I2C
+       help
+         Say Y here to enable support for fuel gauge with STC3117
+         chip.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 59c4a9f40d28..b55cc48a4c86 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..20e8890b9897
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+ *              Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ */
+
+#include <linux/crc8.h>
+#include <linux/devm-helpers.h>
+#include <linux/i2c.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+
+#define STC3117_ADDR_MODE              0x00
+#define STC3117_ADDR_CTRL              0x01
+#define STC3117_ADDR_SOC_L             0x02
+#define STC3117_ADDR_SOC_H             0x03
+#define STC3117_ADDR_COUNTER_L         0x04
+#define STC3117_ADDR_COUNTER_H         0x05
+#define STC3117_ADDR_CURRENT_L         0x06
+#define STC3117_ADDR_CURRENT_H         0x07
+#define STC3117_ADDR_VOLTAGE_L         0x08
+#define STC3117_ADDR_VOLTAGE_H         0x09
+#define STC3117_ADDR_TEMPERATURE       0x0A
+#define STC3117_ADDR_AVG_CURRENT_L     0x0B
+#define STC3117_ADDR_AVG_CURRENT_H     0x0C
+#define STC3117_ADDR_OCV_L             0x0D
+#define STC3117_ADDR_OCV_H             0x0E
+#define STC3117_ADDR_CC_CNF_L          0x0F
+#define STC3117_ADDR_CC_CNF_H          0x10
+#define STC3117_ADDR_VM_CNF_L          0x11
+#define STC3117_ADDR_VM_CNF_H          0x12
+#define STC3117_ADDR_ALARM_soc         0x13
+#define STC3117_ADDR_ALARM_VOLTAGE     0x14
+#define STC3117_ADDR_ID                0x18
+#define STC3117_ADDR_CC_ADJ_L		0x1B
+#define STC3117_ADDR_CC_ADJ_H		0x1C
+#define STC3117_ADDR_VM_ADJ_L		0x1D
+#define STC3117_ADDR_VM_ADJ_H		0x1E
+#define STC3117_ADDR_RAM		0x20
+#define STC3117_ADDR_OCV_TABLE		0x30
+#define STC3117_ADDR_SOC_TABLE		0x30
+
+/* Bit mask definition */
+#define STC3117_ID			0x16
+#define STC3117_MIXED_MODE		0x00
+#define STC3117_VMODE			BIT(0)
+#define STC3117_GG_RUN			BIT(4)
+#define STC3117_CC_MODE		BIT(5)
+#define STC3117_BATFAIL		BIT(3)
+#define STC3117_PORDET			BIT(4)
+#define STC3117_RAM_SIZE		16
+#define STC3117_OCV_TABLE_SIZE		16
+#define STC3117_RAM_TESTWORD		0x53A9
+#define STC3117_SOFT_RESET             0x11
+#define STC3117_NOMINAL_CAPACITY	2600
+
+#define VOLTAGE_LSB_VALUE		9011
+#define CURRENT_LSB_VALUE		24084
+#define APP_CUTOFF_VOLTAGE		2500
+#define MAX_HRSOC			51200
+#define MAX_SOC			1000
+#define CHG_MIN_CURRENT		200
+#define CHG_END_CURRENT		20
+#define APP_MIN_CURRENT		(-5)
+#define BATTERY_FULL			95
+#define INVALID_TEMPERATURE		250
+#define CRC8_POLYNOMIAL		0x07
+#define CRC8_INIT			0x00
+
+DECLARE_CRC8_TABLE(stc3117_crc_table);
+
+enum stc3117_state {
+	STC3117_INIT,
+	STC3117_RUNNING,
+	STC3117_POWERDN,
+};
+
+/* Default ocv curve Li-ion battery */
+static const int ocv_value[16] = {
+	3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
+	3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
+};
+
+static union stc3117_internal_ram {
+	u8 ram_bytes[STC3117_RAM_SIZE];
+	struct {
+	u16 testword;   /* 0-1    Bytes */
+	u16 hrsoc;      /* 2-3    Bytes */
+	u16 cc_cnf;     /* 4-5    Bytes */
+	u16 vm_cnf;     /* 6-7    Bytes */
+	u8 soc;         /* 8      Byte  */
+	u8 state;       /* 9      Byte  */
+	u8 unused[5];   /* 10-14  Bytes */
+	u8 crc;         /* 15     Byte  */
+	} reg;
+} ram_data;
+
+struct stc3117_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct delayed_work update_work;
+	struct power_supply *battery;
+
+	u8 soc_tab[16];
+	int cc_cnf;
+	int vm_cnf;
+	int cc_adj;
+	int vm_adj;
+	int avg_current;
+	int avg_voltage;
+	int batt_current;
+	int voltage;
+	int temp;
+	int soc;
+	int ocv;
+	int hrsoc;
+	int presence;
+};
+
+struct stc3117_battery_info {
+	int voltage_min_mv;
+	int voltage_max_mv;
+	int battery_capacity_mah;
+	int sense_resistor;
+} battery_info;
+
+static int stc3117_convert(int value, int factor)
+{
+	value = (value * factor) / 4096;
+	return value;
+}
+
+static int stc3117_get_battery_data(struct stc3117_data *data)
+{
+	u8 reg_list[16];
+	u8 data_adjust[4];
+	int value, mode;
+
+	regmap_bulk_read(data->regmap, STC3117_ADDR_MODE,
+			 reg_list, sizeof(reg_list));
+
+	/* soc */
+	value = (reg_list[3] << 8) + reg_list[2];
+	data->hrsoc = value;
+	data->soc = (value * 10 + 256) / 512;
+
+	/* current in mA*/
+	value = (reg_list[7] << 8) + reg_list[6];
+	data->batt_current = stc3117_convert(value,
+			CURRENT_LSB_VALUE / battery_info.sense_resistor);
+
+	/* voltage in mV */
+	value = (reg_list[9] << 8) + reg_list[8];
+	data->voltage = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+
+	/* temp in °C */
+	data->temp = reg_list[10];
+
+	/* Avg current in mA */
+	value = (reg_list[12] << 8) + reg_list[11];
+	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (!(mode & STC3117_VMODE)) {
+		value = stc3117_convert(value,
+			CURRENT_LSB_VALUE / battery_info.sense_resistor);
+		value = value / 4;
+	} else {
+		value = stc3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
+	}
+	data->avg_current = value;
+
+	/* ocv in mV */
+	value = (reg_list[14] << 8) + reg_list[13];
+	value = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+	value = (value + 2) / 4;
+	data->ocv = value;
+
+	/* CC & VM adjustment counters */
+	regmap_bulk_read(data->regmap, STC3117_ADDR_CC_ADJ_L,
+			 data_adjust, sizeof(data_adjust));
+	value = (data_adjust[1] << 8) + data_adjust[0];
+	data->cc_adj = value;
+
+	value = (data_adjust[3] << 8) + data_adjust[2];
+	data->vm_adj = value;
+
+	return 0;
+}
+
+static int ram_write(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_write(data->regmap, STC3117_ADDR_RAM,
+				ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int ram_read(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, STC3117_ADDR_RAM,
+			       ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_set_para(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_VMODE);
+
+	for (int i = 0; i < STC3117_OCV_TABLE_SIZE; i++)
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i,
+					ocv_value[i] * 100 / 55);
+	if (data->soc_tab[1] != 0)
+		ret |= regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE,
+				  data->soc_tab, STC3117_OCV_TABLE_SIZE);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_H,
+					(ram_data.reg.cc_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_L,
+					ram_data.reg.cc_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_H,
+					(ram_data.reg.vm_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_L,
+					ram_data.reg.vm_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, 0x03);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_MODE,
+					STC3117_MIXED_MODE | STC3117_GG_RUN);
+
+	return ret;
+};
+
+static int stc3117_init(struct stc3117_data *data)
+{
+	int id, ret;
+	int ctrl;
+	int ocv_m, ocv_l;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &id);
+	if (id != STC3117_ID)
+		return -EINVAL;
+
+	data->cc_cnf = (battery_info.battery_capacity_mah *
+			battery_info.sense_resistor * 250 + 6194) / 12389;
+	data->vm_cnf = (battery_info.battery_capacity_mah
+						* 200 * 50 + 24444) / 48889;
+
+	/* Battery has not been removed */
+	data->presence = 1;
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT)) != 0) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+		ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+		ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+		ret |= stc3117_set_para(data);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &ctrl);
+		if (ret)
+			return ret;
+
+		if ((ctrl & STC3117_BATFAIL) != 0  ||
+		    (ctrl & STC3117_PORDET) != 0) {
+			ret = regmap_read(data->regmap,
+					  STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap,
+						STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		} else {
+			ret = stc3117_set_para(data);
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+				     (ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+				     (ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		}
+	}
+
+	ram_data.reg.state = STC3117_INIT;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_task(struct stc3117_data *data)
+{
+	int id, mode, ret;
+	int count_l, count_m;
+	int ocv_l, ocv_m;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &id);
+	if (id != STC3117_ID) {
+		data->presence = 0;
+		return -EINVAL;
+	}
+
+	stc3117_get_battery_data(data);
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT) != 0)) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	/* check battery presence status */
+	ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &mode);
+	if ((mode & STC3117_BATFAIL) != 0) {
+		data->presence = 0;
+		ram_data.reg.testword = 0;
+		ram_data.reg.state = STC3117_INIT;
+		ret = ram_write(data);
+		ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, STC3117_PORDET);
+		if (ret)
+			return ret;
+	}
+
+	data->presence = 1;
+
+	ret = regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (ret)
+		return ret;
+	if ((mode & STC3117_GG_RUN) == 0) {
+		if (ram_data.reg.state > STC3117_INIT) {
+			ret = stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+					(ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+					(ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		} else {
+			ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		}
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_L, &count_l);
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_H, &count_m);
+
+	count_m = (count_m << 8) + count_l;
+
+	/* INIT state, wait for batt_current & temperature value available: */
+	if (ram_data.reg.state == STC3117_INIT && count_m > 4) {
+		data->avg_voltage = data->voltage;
+		data->avg_current = data->batt_current;
+		ram_data.reg.state = STC3117_RUNNING;
+	}
+
+	if (ram_data.reg.state != STC3117_RUNNING) {
+		data->batt_current = 0;
+		data->temp = INVALID_TEMPERATURE;
+	} else {
+		if (data->voltage < APP_CUTOFF_VOLTAGE)
+			data->soc = 0;
+
+		if (mode & STC3117_VMODE) {
+			data->avg_current = 0;
+			data->batt_current = 0;
+		}
+	}
+
+	ram_data.reg.hrsoc = data->hrsoc;
+	ram_data.reg.soc = (data->soc + 5) / 10;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+	return 0;
+};
+
+static void fuel_gauge_update_work(struct work_struct *work)
+{
+	struct stc3117_data *data =
+		container_of(work, struct stc3117_data, update_work.work);
+
+	stc3117_task(data);
+
+	/* Schedule the work to run again in 2 seconds */
+	schedule_delayed_work(&data->update_work, msecs_to_jiffies(2000));
+}
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct stc3117_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (data->soc > BATTERY_FULL)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (data->batt_current < 0)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (data->batt_current > 0)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = data->voltage * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = data->batt_current * 1000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		val->intval = data->ocv * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = data->avg_current * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = data->soc;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = data->temp * 10;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = data->presence;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property stc3117_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const struct power_supply_desc stc3117_battery_desc = {
+	.name = "stc3117-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = stc3117_get_property,
+	.properties = stc3117_battery_props,
+	.num_properties = ARRAY_SIZE(stc3117_battery_props),
+};
+
+static const struct regmap_config stc3117_regmap_config = {
+	.reg_bits       = 8,
+	.val_bits       = 8,
+};
+
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct stc3117_data *data;
+	struct power_supply_config psy_cfg = {};
+	struct power_supply_battery_info *info;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &stc3117_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	psy_cfg.drv_data = data;
+
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
+
+	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
+
+	data->battery = devm_power_supply_register(&client->dev,
+					&stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(data->battery))
+		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
+					"failed to register battery\n");
+
+	ret = device_property_read_u32(&client->dev, "shunt-resistor-micro-ohms",
+				       &battery_info.sense_resistor);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to get shunt-resistor-micro-ohms\n");
+	battery_info.sense_resistor = battery_info.sense_resistor / 1000;
+
+	ret = power_supply_get_battery_info(data->battery, &info);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get battery information\n");
+
+	battery_info.battery_capacity_mah = info->charge_full_design_uah / 1000;
+	battery_info.voltage_min_mv = info->voltage_min_design_uv / 1000;
+	battery_info.voltage_max_mv = info->voltage_max_design_uv / 1000;
+
+	ret = stc3117_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to initialize of stc3117\n");
+
+	ret = devm_delayed_work_autocancel(&client->dev, &data->update_work,
+					   fuel_gauge_update_work);
+	if (ret)
+		return ret;
+
+	schedule_delayed_work(&data->update_work, 0);
+
+	return 0;
+}
+
+static const struct i2c_device_id stc3117_id[] = {
+	{ "stc3117", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.of_match_table = stc3117_of_match,
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+};
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.34.1


