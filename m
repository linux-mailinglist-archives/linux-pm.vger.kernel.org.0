Return-Path: <linux-pm+bounces-29317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E4CAE40DD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967E53A73C7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54952248869;
	Mon, 23 Jun 2025 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pJ4xMSl5"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013055.outbound.protection.outlook.com [52.101.127.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99246248862;
	Mon, 23 Jun 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682473; cv=fail; b=LrmprOo4WTq+qLXEUOI91yQBURGtwHYMp+oTClMiM7lwrTOIH8ZOfRVy6r2/Ynjlrtxjc3tyRAdlcKacbwRuxk4SnGnPWZV2kJDzgEV0Z3/huliwrOzRMXMF6PyiAJkdJ7q0FQtYFTbi9tb8qFcPykaA0ok7LZN3NJkUbqllnTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682473; c=relaxed/simple;
	bh=+tO1FXQwDvCnwpKxIYmEXn+2VqAmnGbIX0FsFhutv+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nLaFTFszuv++KuchWXtOMtFPHs5tMAL2g0lFKyAuedPpYIo4VDu2DcgAU3ROE24b9zjhpgLAZlnvv+AIIvhaLuy/gWoKKgiKYx0oKwPGfFhRlMgB9E2DVpweYJGAojw+lrMl8gHNFA6c3snPfdNoWhcjum5Qc4wSAmt0I/gB5Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pJ4xMSl5; arc=fail smtp.client-ip=52.101.127.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rn1veXHLeWAG49B5yepfoD9atX2TyypTcu9Sn4U87LgehDecJUz+8ZR4aK5KYAtmLQ+MtORyfr6rqQJgvx4IrQ3cePTlLPXWs3AywMBdrTt8WcuW6xtuHNQL2c/TNxR7GhAr2IzDvTWS1dDVks4T3ao8poYcB7RtZoDKTJ95Qi/NaelriQsjFmYgE/i9y+tspqHMplWupel0jHoduivJnW/6FESbLHDR/j4EdRK/ofieAZVSh1vNvLaLq9oeHfJHXmKX63tdlI1mlOf8neEbF2ehsTyaYqKpiI305QxJXTwgBDKT9o1gC9pm0UiCTdt0GSBK/IiFGqcjAAKcfPY13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7O3jHLwOel+QJE7EqetL3b9oQSmYAMcYt/Iq8MMmRs=;
 b=SR8/B99UdXYYZJbCbcWqp6BbST1uOkiNHXOnYC6PHpQq9QGoqBmQwAqzK+AbfxKsKbXMEvp63DmrGop6aRl+aeDhgzYL5XHuTrSYVhYShcbjKLlSO4Seg0C0IkBMA0wj0bcwpyKedgcLsLMDT7wHozKTsFM4CUFNBhBtEymyBMcX/Kon+uHYCYBfv6dxZiEa5RyynUlWucATVGqkFUXbzPRZya5QckZR8e15ABRZOcPlxOD/o2B+uaa/PC2LgwQhyzkAUYXKMaV5rR1/V3jBeWJul3wEEPZbvASdVkNzVhe8SDnjNi9OVPrQc2CyODDjr4qKx91RUTsEIu0K8TIIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7O3jHLwOel+QJE7EqetL3b9oQSmYAMcYt/Iq8MMmRs=;
 b=pJ4xMSl5O3QK7/Oqyo6313EBGb3vI1T7ewwduQRJBeZcUy5RsDyzpWQgs675MVNTfZLE9xsTNXrfIPgtlgDMtHHpW7QKbehFBwXj6AySeOnWWFA5M9yvEk7s+7Ctnc4S0Y75mBF7gKQpMqwwn+ddcHVAKWTNTu76eVHe4FyRznc2Z46IR0pm6KI/09KPLk06sknWkf9Np/2Ym1FO4LB54WWN+xTuSRvJC3i+IllEsAYp6VOR5pfCXvAfq3EFKLuFezkeU54md0SySmDEDUjdlNin0um8lJBbAFQi0H6nMkRYPEjBzm9r5H+pM/hCEIPnETh6WnbKv0IgOTqnU2f6Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by SE3PR06MB8096.apcprd06.prod.outlook.com (2603:1096:101:2e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 12:41:09 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:41:09 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 17/24] thermal/drivers/intel/bxt_pmic: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:40:54 +0800
Message-Id: <20250623124056.474639-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|SE3PR06MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: a3da7b80-67bd-43d0-3826-08ddb2533a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmI3Q1ROU2tjay9VM01wOEFxYmttNEVnc2hzMklnNXNoRUVmejM1WjBXRkdZ?=
 =?utf-8?B?czlQUG1LZkkzUXJyN2VHT3lQQkNrQlY2MjllaCtxcm1wMGtDY3N1VS9JTTkv?=
 =?utf-8?B?clNCcGUwZ2F2KzhrTEtycDBWei9SakVGVGtLS3g1cEttcEd6UGg4ZU92U3lv?=
 =?utf-8?B?TzZrc2s4Z3d3QjlsRWFscS9md2J4OXVyMWVpYU1haWgwWnEzdjRIbDY4ZUww?=
 =?utf-8?B?dncvbGhHaFRtcVRySGtWcHZtcUh4dXpiTWhmTUw3b2VnWWc4RFZKOWI4L1BW?=
 =?utf-8?B?N3dqRUt2aDdYbEtiVXAwdE5tQlJSNUdKN3ZuS0lkRm52WHQxWGJyV1BBSk94?=
 =?utf-8?B?WGlIK0dXMVlPbHFvdkc5djZQNXR6TnVqdHRKZkxyRXNVL1dOWTNPNi90bVh0?=
 =?utf-8?B?NW9NTVpucTEvQU12VDIwY1llL216RCs1eGVTUUxlSXUwOHdoSzIrM1lacnZS?=
 =?utf-8?B?eHdVSG1ONVorQXg4RkRaeG9tbFdpVmtBeERzbUlaSzg3NFZ1bmlNeE0yZTM5?=
 =?utf-8?B?ZzFTd1dDWjlPbkJrSDdQKzluM2VPay92aW9xNWJLTEdkTU9EM2F3TnZpSG9X?=
 =?utf-8?B?KzZLV1hHZlRVbWtybDNGWDBLZEJndDFreDBpYkNHb2ExNHpHNGQwSVY4c0Z2?=
 =?utf-8?B?eVpjNkN0YWZYVEhvQkZ0djVRZVhUUWpONGREN3l0d1lHN0lFeE9DSm9JRjdV?=
 =?utf-8?B?cWdRVSsrVGI1RG5yWS9PTmdRMEdxcXhxYnJMQkVyY1p1YnkreVEvQkcwKzJZ?=
 =?utf-8?B?dkQ2NGRBSkFTZ1NxK3JadUx2cjY4RGw3aVBDTnU4bW9EQlF3WWkxL0V4eHVO?=
 =?utf-8?B?c2RBUGJZcnBBZGhYTUxsbmlaTTZYRmpkT0Y1OEQycktyYlRGZU1JNmxJS01B?=
 =?utf-8?B?Z0EzUVRkODhJYXJkZ3FrdFJwVkFub3NRdWlpRElLVmhraW5idFp6eUJDbldK?=
 =?utf-8?B?TFRMRXFjZU1TUXlWeS9YWEtkekJzdU1IWXZXaEN1b2dMUzlrVlNaWDJGZ1ZD?=
 =?utf-8?B?YVdVS1ZjSDdHNFN4UlhHY0tCTlEwdnMvZ0p3ZnJRQTBra0xsQ1JTVHFOWWFV?=
 =?utf-8?B?ZGNXeVU3VUNhMVk5QlU2RmZVK0M4Q2prVGFweURNaXF0dW4wOWxtWnpoL1Yy?=
 =?utf-8?B?WEZXTWo0UkErMXhKNnpUMlFJcS84TFczZTZNK2M2RHBWWWRWOFBvWDNobnBH?=
 =?utf-8?B?amFrL1FNUTd6eGxJeGwyMDQ0UTg3V3NuWGNmUm1EN1Q2bEZzY1h5dlhhbWZs?=
 =?utf-8?B?aHF3aDhRSzU1b2NlUS9RNUZpVXMyOUNQOVBHN1djTG5HTENJSUtVbmZWLyts?=
 =?utf-8?B?L3oyc0FwVmRGcXg5ZEdJODdrN3RsRDNOOS91aE9lT3JUOVUwVzhueWxYc1Nz?=
 =?utf-8?B?eTlESlE3WHF5a0NQc1ByRkc2dlByYk1XTEZLY0VKejdGenJwY2UvaTRXQkVY?=
 =?utf-8?B?VmRBajZmZE1mZlF3c0JSWWRka3c4aldOQXdsbTdrTjNlQ0R3U2NCYWNiT3E0?=
 =?utf-8?B?ME16cmRaMHpYYnpEWDVGcUFCNkFJbnRGQy9VS0RzZE90R2QydUdaZktYM3dO?=
 =?utf-8?B?VmdiZ2FWeVpDUW9pTjJkUXlHcHkwUjFFQVgxeUNCbU82Y3hGa1haT3VNMFcz?=
 =?utf-8?B?L2EwVWJKeVN6YnMweWtIZXNTMzFDYmFmNFVWSTNYYlFRTjVUdndza0VIaGc5?=
 =?utf-8?B?eUtvN3Y4SHpyY2ozcndEYzlycncyOEowMHplT1A0NHFMTjV4NStxemE5bUJ4?=
 =?utf-8?B?OFlsdFhsZzhRaThwRHFQNW1QeGhLcnBTeTlXMVUxMmdrTnRPaWlvQ3lENFhT?=
 =?utf-8?B?VzJCNFo5Z083YVh6M3lUbXB4MklERng0R3luOFcyZFpybXh5RFp4blZKNkhS?=
 =?utf-8?B?QzFuTFFMNm1WMEwzK3JraVh0cHhrYVdQNktNbWttWW8xSVdKdlRkL2h1K0I5?=
 =?utf-8?B?NE04ZjgwYmM5QzZCcXpVYVZEa3kzNGorai9ZcGNQVDVDUW5PcEVnUFcwaG9J?=
 =?utf-8?B?ZktwS1ZkSUVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDNwajVCQnorbkc2R0lUK3NJYTJLaGF3Uyt2bk9uYVM5eUR6TGFTM3FOZGV0?=
 =?utf-8?B?aXlpNXJUNldOV3BwNy9RbVAxMGswSUNuNFFHL3lVKzA2VUFOejR0TzZINHg3?=
 =?utf-8?B?Q1dsNy9GUkdVd1VOelQ3cG55Skw1dzN3N0JyTkdKTW1rb3ZOQTBDQ1pQdXdX?=
 =?utf-8?B?TklaN3ZYckZ1NXo2NUhOZi9WTlBDeWMzZTV1NGJibTB2QTR6akxYQzJaeE9C?=
 =?utf-8?B?aDM5ZXdlVXF6MnhTTlhZL0I3U002K1Z0NkYwVTFtb0hUNmtLQjBGek9Wd2x4?=
 =?utf-8?B?TEFqM283Qnhpc2JOcVNOZnJqWHJScFVtOVdYN1pWY2FER3QwazV5ZldxN3ly?=
 =?utf-8?B?RXhFalZhVTlDMVFuQlBRSXFYN2JtTnZmakowMTYvMlJDdys2SndDemhqTUZk?=
 =?utf-8?B?MDM2U2M1QVRCR2dRZWcrV2dYNlF4RjI4Vzd5LzRSelVQTHZ2clFXZWZER00x?=
 =?utf-8?B?eFNsM1cxZHEyMWp1TVA3bjZSdzZ5Mm1vMTlJRnl0eFJhNDd3cVZXQTZSRFRX?=
 =?utf-8?B?M0Nvc1FOWUxCblFSb3ZRbHVZUEQ1MzM2Nkd4TGdEcTZZNVJqOGR3T0xzSkJt?=
 =?utf-8?B?WWF4K25oYkVtZHJISFN6OTRuMFE5dUlDTlRnYWdOWXBsaitMU2kwcXZGei9G?=
 =?utf-8?B?L1ZpUVFzdFpGK2RPVG1EWW44SXYrU3grZzE1Z0hWZitIbFJDWE83RFFXNUQr?=
 =?utf-8?B?Y3ZSb2p2eHVadnQ3YUpmekg0UTV6cXRvM0V5d2VXWWZ4d2VSSmkxUGFGR0Nt?=
 =?utf-8?B?T0huaFlDakJTd2RGRHJRcEdDaDIxa3piVlA4Y1VzajlEZFhVRnp2S3I5MU1Z?=
 =?utf-8?B?VXNLY3NRNENpd210bjN1ZTduV0tHeWJqSUtBd2M1c0hOOFNVZERvcjM1UytE?=
 =?utf-8?B?RWtyakY3eGt1UXJqdEk0emNxeE5HbGYrWndPUk4wSG1EdXU3SGFienRSc1lD?=
 =?utf-8?B?bDE0STU3UVYwRkp2YzdDQnAvMWVWMmRBa3o1QnJqVE5Ea3N6UThyOENxb3Ji?=
 =?utf-8?B?NHFFYWtUSk56b3l6NHpPNFJGcVM3OCtGdEJ0TVFubHRpVkdlNm03NkZSaGxz?=
 =?utf-8?B?ZDlVODdBSEhXZ3NaLzRuc3NsenFKQnZ3aEUraTJFVUhTYmJKR3A1ZE9iN0lO?=
 =?utf-8?B?TmlJZ1RPQUdHZkk2em9MQXA3amF5bE0yNnVyUU5CUVNFR0FoYkJFWWdZWCt3?=
 =?utf-8?B?Q2N0SkxmNDh0TTFUc2ZEZ2IvY0VpSEV4SHdWb0RqSVJaNVFNSjVtVCtXQjJt?=
 =?utf-8?B?VDVaN1gwZU9iaTlzN3g0SWxKVDk1dzdpOVpTT25Od1RPSmNvdlYwaGJxbFdD?=
 =?utf-8?B?NURoTy9XUk9QY2xQMjFSdFlTM2F1VEd5RFc3aHF1SVFpM1NJM2pXTFVtVVdh?=
 =?utf-8?B?VTFwMVhIT25pdDUxRVZHRE9xTHdEc1VpY29Tcm1WdnpZeWlWZlZXNFFWbkhj?=
 =?utf-8?B?cnpwcmFPL0FPNEZMZjZ6Q1UvamZKcGk1bW95N2JDajFWaTd3Um1Tb3poZ2hq?=
 =?utf-8?B?ZkJGcVFPTUU4RWJieERDOW1vWkVTbmpSYWk5VXhRMGNEWUl3S0ZpSFVveTNl?=
 =?utf-8?B?TzlpRjB2Uk42MWl3K0JuQlR0ME05SWlDZk90TFV4YW4zWXQwUm9wemRhRkJo?=
 =?utf-8?B?T3cwZ1F0MWN6NlhaSnF4MEUvTGJuaFc1dFhGUTlWYWFmTGlnQUJsSkdZK2pS?=
 =?utf-8?B?ZzNhMmJxV0ZCNmxUdWZxK0toTFY3TTMzdi8zYU1YcHBCRUtiaDRDM01iMVNz?=
 =?utf-8?B?c0dzZlNsOWpyRXg3TzhwVGYyOTI5NWlPZitWcTc4TCtubjJJL1JFS2ZxMHFQ?=
 =?utf-8?B?aG5RSWJNS3R5bkJRb0NOeEZDRVVzdk1TTExVS0lWU1J3bVNPZEc1Wk15MzE0?=
 =?utf-8?B?Z2kxUmZ0dUI2enF3bzV4WWNJV01MY29GN0VLZVdvS1pjSUNRZUNJM2p6ZzhO?=
 =?utf-8?B?QndYUEJybFphWFV3cUNrYlNHekRnSkhaaElpQzR5WmtBcDlvSU9LdnR6Yk1H?=
 =?utf-8?B?NDd0d21paE5ZYlc3ZjJRUnR6bndMbW0vWWY2eFNkUm9hbXAyVFliYU51aWlo?=
 =?utf-8?B?QkdHaXVJZmtPVTJEVXAzaUlEeXQyTjkxdm1WalpMcXNlc285OEd3VGI0ODdo?=
 =?utf-8?Q?YNPtMt3n/ILJHzKKCEwEmayzz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3da7b80-67bd-43d0-3826-08ddb2533a63
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:41:09.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytmHjf/POXLFFO9aEW0mLfLy4OlL3LfFoDeOkkFnb8wnFcJpy7Me0ItN9whkvQ/Z+hzFcrcSdYTVTZl18cO4xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8096

From: Yangtao Li <frank.li@vivo.com>

The new devm_request_*irq_probe API prints an error message by default
when the request fails, and consumers can provide custom error messages.

Converting drivers to use this API has the following benefits:

  1.More than 2,000 lines of code can be saved by removing redundant error
  messages in drivers.

  2.Upper-layer functions can directly return error codes without missing
  debugging information.

  3.Having proper and consistent information about why the device cannot
  be used is useful.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/intel/intel_bxt_pmic_thermal.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_bxt_pmic_thermal.c b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
index 6312c6ba081f..1bf3e6bf8052 100644
--- a/drivers/thermal/intel/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
@@ -241,14 +241,11 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 			return virq;
 		}
 
-		ret = devm_request_threaded_irq(&pdev->dev, virq,
-				NULL, pmic_thermal_irq_handler,
-				IRQF_ONESHOT, "pmic_thermal", pdev);
-
-		if (ret) {
-			dev_err(dev, "request irq(%d) failed: %d\n", virq, ret);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, virq, NULL,
+						      pmic_thermal_irq_handler, IRQF_ONESHOT,
+						      "pmic_thermal", pdev, NULL);
+		if (ret)
 			return ret;
-		}
 		pmic_irq_count++;
 	}
 
-- 
2.39.0


