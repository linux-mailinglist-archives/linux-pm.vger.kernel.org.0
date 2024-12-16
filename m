Return-Path: <linux-pm+bounces-19272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3392B9F2A2A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 07:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D8F164B2C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 06:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0111CDFCE;
	Mon, 16 Dec 2024 06:31:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020134.outbound.protection.outlook.com [52.101.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE819258E;
	Mon, 16 Dec 2024 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330666; cv=fail; b=cEj+7jB45XmoX9Gzvc/C/YGrI/OQ/ygvRqFa7yFHVEHD5KhXVdQSJOLVFQdd7YzXsgpBMfaNhoyLaQ4r9aH6qThulrxo+KUDqdTNchHkHBMAnAA/6+MG2cieByYrgvTVvEQsvLTl9RVMYSDUoWZuEqUF4SZnpZ/xCJIXqXGART4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330666; c=relaxed/simple;
	bh=4YDCee/31iyCS0iF1HHy+CtN3lQC/OLBVibz0xs4SLU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZwDu5bjuhJYF8TVruHeffsRuXhNsF+4x+NbFIAs9S6MFKY3Wqi3ryyK5IKdSYLggwTWIJc5r2BuL41ppMdxjvUgF2WGi39WlAO0BSiw+f6A09gOLzVFfMAHsBYGXB4ddGrHCgAdP491VoLq0KJU4c/fb+EtCbMjpE7BtOK5h6wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVGqh0pzHEyQjY7PdJwMJ/aJOZYI35yrQZFTTSmzwogx4TICFKDEzFv604BzY/cnOuWvDKl6HwNo4OKa8SHqs3PtAo+8xmbXt2YgWOpChR0TFsVwIDdCc9bQ39j7RiT+FcbOOxXwE7MUAvUF1RdtGK6uqOP/3bUAMFWpXGZwlylvM5RFwa6G/o+KYJFssudccWmAJEP2FIOyYEoXqa+5FsQbt+MoIVTDWOGGCZj5KouSsV11JuPp+MEUH9a/SV3h7HksoVVr+sMcbzNvG0yuS//HjP0KY7EmKR96zryGy6u44FatJXmtlgAj5KF9D7yxvo7HanC1KenHyRCmvVkNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIUPhinBdxgS2rycyUlQiSDVS5N83C5nRtnMktgyzZg=;
 b=hWSfP/Joxj22u+xzG47r+7UhN4ZgmIxJ+TGZ4VvOXTmcNzDFKMpXA3MWXgsJR6+n11k7OGgYAF49ie8Ny4psL5PwNiC6sFE6jI3BCrH8MVVoWandIBNMpf1OSwyPHCE+20qNq5Aljms6UDG4tXOqtr3tB1VH0rPe9mg8+Jhkw+QTervLsFS8wajDMYQSoizdaUEPrZDlYxfOn82DI4U7BkFN7UZqu/r5rJcxQehM16JlCXHGUtdFUVVRFrdBSDOO3aBnpCUJ+WXfJgbgsNCtnemLYD9bJUYh0DFp6vAqwQF93pN0QJexpP5OGzfggjmoK6fWk99w6SHzuDFVPNQNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN3P287MB2154.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 06:31:00 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:30:58 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/2] power: supply: Add STC3117 Fuel Gauge
Date: Mon, 16 Dec 2024 11:59:14 +0530
Message-Id: <20241216062920.7228-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::8) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN3P287MB2154:EE_
X-MS-Office365-Filtering-Correlation-Id: a275beb5-c069-4298-e308-08dd1d9b33a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elJIcHlnci9CcmVXQ1BUMlplYm1ySHpGNkxMdjFmVUxEcWw5V1VhWXpKSzlt?=
 =?utf-8?B?eEZDL09GTjJsUW9ZUkNHczhUSHlCVkV5UmtMMDVJUHlRbkh2d2oza0p6VDBw?=
 =?utf-8?B?ZHZoazNPeU50UnRiU0RQVHZXR2FGMkRDSmNYVmtSSVR3cDNtMk1wWG5aRHc1?=
 =?utf-8?B?WmNtS1RSdTkwYTFlMytzUTViL2ZMVVRRTkUrdFNBTGZyaWNYMkhtSlVYYlVX?=
 =?utf-8?B?UGQ2QVZIS3Z5eXBGQ09qZTgxdE9iZ3RTaFoyeDJQd3JOWEg1T1U4c2RrcDMx?=
 =?utf-8?B?b0Q5QVJTUHdDa0tGZ2htOTY1MS9sWWlzeW1WUmd5aGR4aWFYZjZOeW9qanhG?=
 =?utf-8?B?Q3R6ZDhmYmlMRXo2dFNMRzgvUWF5QS9iMFR4aTBUUk1rcHAyR3lheTdWeUpB?=
 =?utf-8?B?WUZISHloMlQyWjBpTDVOWXkreUM2WmxTNXRrZ0VvU1FZU3gvbVNycG16Z2hz?=
 =?utf-8?B?aVlkOWgrV3lBYWtjUXllV3g0N2JPNW5VVkp1QWRlUTloeUx6S0xqVmdZUGU2?=
 =?utf-8?B?TVo1OGFDTzQzd2sxb2E3YTUzN0t6SUN6UUZwOS9BcXJqQ0VOUHBLRU5NVEdC?=
 =?utf-8?B?TmJXSSs0WkxRWU9OTlBPZTYxLy82eTN1ZnhUMjdsYXZCUm9nekJoTm4zdjA2?=
 =?utf-8?B?S05GUitHSjJnaGhOT3YwVUFUZThDdDViYkxOdE1laUZJbVJmaUcvdnJrSlBq?=
 =?utf-8?B?WHRRcmFBMUM4VGcvcGQ2aUNyak5PSWZ2M3ZwOWwyUWVqdU9kc3ZhV3Q3enVF?=
 =?utf-8?B?K3Z0SUlNWmsxeGdWTFFFSlBZMEZzdmJSL1JOcUgwWEw4bWNWNkhmbHBrZ2lx?=
 =?utf-8?B?bVk1Y0JTWThKVEEvV1oyNml2b3kzZWNvRlBrMWpDMEZWaFJoR3dZdVgxcVdQ?=
 =?utf-8?B?MSt1QkphQ3BKM1hKOFBrTTJvRnRLSHA1allzTjhndUJhcVBaZU1jQ3FpUlFO?=
 =?utf-8?B?S3o1ZFRhZStCZStQRnM4RGtFcFNiZ0diUjJYdkJWRVIzSGhranlQakovWnM1?=
 =?utf-8?B?enQ5R1kzaVdRRkRHalVsSWFHQ3ZFWTQycWxXR1g5Vk5ua3NYZTh0eXpqZnJ1?=
 =?utf-8?B?aTlucjEwSE10Zi83cGphemp1Y09hNWZndVdvUHFjV1JmUUVHazRyWHJVemxk?=
 =?utf-8?B?YThnRXVENTdBL3gySWJpaWY2Rk5rb3U5RHdKR0c2ZkZPdGlkZzQ4dkFLNUs4?=
 =?utf-8?B?WmZzUVM2RUk5TXRac2dEd1Y0bVMvV2FNenc1ZHRuMm5EL0FTMWxnRmRxQ3Fs?=
 =?utf-8?B?U1k3LzE1YmRQcHFYOUpFcDZRN1FrN0N6VmdzRlBhN0V6aGRKZHJ3V2NiTHhC?=
 =?utf-8?B?c3dOdlpFcmhWTXlDaldWVnN1UFNkTWIyWHdweFc1N2JMYTFtLzVnc3FQM3Ar?=
 =?utf-8?B?WnZSNzc0dTNDWVJlcTUvQkRZdlVVNmxCbDVtR20yTUdxRWp0T3JrRzNPL1hV?=
 =?utf-8?B?MjFMcmZGeHZCcURZLzMzaXFWYjZweU5kRXE5d0w2Nm9ENU5IWC9FZDEyVG51?=
 =?utf-8?B?a253U1FxNUhkTktpYXNyRG4zV3pPNDBpdkl2WmtyYWMyN3FMZEp2N0dYTExY?=
 =?utf-8?B?UWtwa3F5S25tUmZkbnkrU0M1UW1QRFYyNVJFeExSMTZyd0cwbkVRaHNyZjhT?=
 =?utf-8?B?bHJRRDZYVzhNTjI4MjFrNjJhbXg4U21XU1RnZ2k2WmJjMEJ6Ui9wZWh1VlFD?=
 =?utf-8?B?YUI5UE9PWVFiWmUxUUxrblI3cnJGbm0xRGt3WW1hMzNCTTlmQmUxVTAydFJr?=
 =?utf-8?B?OXRKZmFNQVB6eURkVVU3SXJiWHZRcHFPOTZEeXU2aitiMjQ5VkdLNHhHeElp?=
 =?utf-8?B?Y0Nob0NLdHFQLzB0VkE5R2RBTlp1SkpZU0JvTTRENlB0OEU1OGN4NUpwL0Yx?=
 =?utf-8?Q?p1hiKidq8VlaV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmRZL0JEaThybEh3SXM3bVliRzQyaHVkMGlMcTdVc1NVRmo0a0p4Tkx6R0dm?=
 =?utf-8?B?NVF0TUtlajdVSWRSOHRIbjhVN2N0eEdBcDdHZnMrb29UVXJKSVZJSEpSbkFG?=
 =?utf-8?B?ZUxKTlp4anZQUmw5Q2MwTmVYeGhkcXE1bHFqa251eDRzbTdEdVZXYjgzVmd4?=
 =?utf-8?B?cDVIRFZvNTFGNFI1M25nSWs4TDFVdTU0cWE5Y09zZHcyZWVUSnh3LzRERWZw?=
 =?utf-8?B?L1JIYW55dk0rRE43TThFVUZ3ZDRLSnBuRk1QTzJhQTZSc1FDTTNBL3l4M1Fy?=
 =?utf-8?B?WUtUWjJPTFdUZ00yTk1Udlp3cWozRURCc2tveTZMSXZpekFBOEhFQUxIR2Iy?=
 =?utf-8?B?b2tRWlhvdVNpcjBMZ0pTZUprNi9IQkRkbnNZU29wZEhCTjlqTlcwb25jaFRx?=
 =?utf-8?B?bUxHZVpMWFRkZEJYakpKeVpjUTAwUFh4czVxYU1TR2VXSm8vdlEzWUdtelZx?=
 =?utf-8?B?UmpZUEdhRjFzZ1JvN0JLQ3pjbHNFL1NQam9OVG04cWpMQW5rZmMrcHdCNnN5?=
 =?utf-8?B?NzJPYWZmQkVTeUhibWh0UXhlRzdFYldEczdUZXp1ZnJGajAzM0ZwMnNVUmZh?=
 =?utf-8?B?ZGZndWdiU1B6OUtEL0JTS05PM09McWY4NkhzMXlDRkVVMEM5MUQxYVo4ZmVu?=
 =?utf-8?B?VGIycEJsZlpzKy94bjBiR2lPdWt3azlPTFc2K0k3c0ZlMUFMSVR1UHZJWC96?=
 =?utf-8?B?QkIwaTZzSitPajlTRkxUSkxadjFvQkU3bUc0WE5MMlJqZnpnQ0N4S0I0bVRW?=
 =?utf-8?B?dWh4L0tXSWc0bFVWeFZKSEgxdS8rK0VpVURPcUNjVW5UVitOS0lnVlVXelU1?=
 =?utf-8?B?RHZXblBKUUdLalo4UzJTM0luK2x5QUM1aWE1dm15eHk4VFJSWTE3USs0dW5F?=
 =?utf-8?B?eFMwcnRkUGs0VVI3K21veVNoZFFOcE9YdWwrQXU2Nno1WDBpc2tZbnJuTHFl?=
 =?utf-8?B?WWNHM2liT3NmNDhlSHkyaVN4V0ZCL0ZSNVNTVWYrcTZJQ0NGZ2N5U3l1TVAv?=
 =?utf-8?B?VXJyZE1GUTNkSnVLNVB3RmdPZ0NSTVpjaUJCZDByNU1WVkpiaUxuWXJnekFt?=
 =?utf-8?B?MlBOWFQ5bVRJK3hSZldSYThMQTBzYWkzcGN5Sk1kbnFiQjdhK09QeVZWdktj?=
 =?utf-8?B?RThMUGRqbjg2RFZIMHdNRUFxSERCTndxZExTNlJmTENrckoycEdpa043WkhK?=
 =?utf-8?B?MWI4MHpxNVh3R0wwR0pLZHhZazJ2MVhLUGdERVNRRXhaZFFNK2hEbXM3MzVF?=
 =?utf-8?B?MURrd3F1T3ltUFFkOHV5UWlmWGRsTmxRMEJxOGcxdTROOG9EcEJPTjVwWi9R?=
 =?utf-8?B?Y1BEbDlIYXpDZlZkTlFuVHlkdEZHM0dXL3NWV3BibVVwVXNObWRSSEg0NG0z?=
 =?utf-8?B?ck1oRUZzSE5ZUStBNnlZWDNSVUlEY1lzUnZqQlMxOUJqeU0vVkpyUnU3V0ZD?=
 =?utf-8?B?OEdYSkhKVGpzZElpclplUjB0cHdaS1V2eTUyMCt1clp1TmNGL21NRjJHZHVW?=
 =?utf-8?B?T3hrY1BlNS9LN2ZiR01pYk03NGpYSWM4RGpLNHdZT0g1VzRvY1FmOHQ5WTRw?=
 =?utf-8?B?dEVIeUJTc0VsNkpTcTVXc3FkWU5GaEhsZ01JTjl2cHpEeEVpRFJhelBHZWlG?=
 =?utf-8?B?dlBNanJZaXErT1N3cEpTZFNHQlpXTzJSY09QRHR1TFpBVjI1ZWk0SHBvdHdC?=
 =?utf-8?B?S1h6bVFMUGV2YWtqZUJ1ZnFBUWxSdVlMK0ZLV0FqREdWbElSMXU1RWJMbTI4?=
 =?utf-8?B?Rm1mUGlVM2RxUEl6NW9sTnBVeUtFY2lSWXBrY3BLbnBZZklaNzZaMCs0MmVW?=
 =?utf-8?B?UVIrWGNHdm1NZm9ibkpvclA5RW9QTTU0bkhaVUNXdjJrb2V0M2I1Ui9rNUVP?=
 =?utf-8?B?UU95Z2FZQjFqUVpFZ3FpTEpZcmFEdVA4eVNwVTgyN2FBN2V1R29BdlNCbGdW?=
 =?utf-8?B?aVcrK3lsZ3FFcXBlSzFXaFB3S3ZVYzFWUlkyeUdhc21FRkI1R3R2RkNZR3oy?=
 =?utf-8?B?bWNqZlo4a1c2QkVuQ1AwMVFrQmpyY2h2M3VzSmgvb1o4Tkh1TDJCNDdYU0Yw?=
 =?utf-8?B?M2dnN0kycXBSZTU3SFcyY0x5dkdlcmx3azFzWTNrdTVuWkl5WXozQkJwKy9i?=
 =?utf-8?B?a29YWVFZNUg0UmhOeEZZalZPQnJOTDVwZWUzTlREMDZ1S2tWQW5UWjdwa0FN?=
 =?utf-8?Q?RrFRbFhDmZT884LI5fYbM9k=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: a275beb5-c069-4298-e308-08dd1d9b33a0
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 06:30:58.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHPPcuoWa9UaUl0kRHHm7n82BTcyGZq/5L/kjmK7lyFrSikSoXElgtNZG2/S/u0++1piMjUF93UKxgwYvHGkadTCZy1H8XfnjLeHzHv1k/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2154

Adds initial support for the STC3117 fuel gauge.

Output of test_power_supply_properties.sh

TAP version 13                                                                  
1..33                                                                           
# Testing device stc3117-battery                                                
ok 1 stc3117-battery.exists                                                     
ok 2 stc3117-battery.uevent.NAME                                                
ok 3 stc3117-battery.sysfs.type                                                 
ok 4 stc3117-battery.uevent.TYPE                                                
ok 5 stc3117-battery.sysfs.usb_type # SKIP                                      
ok 6 stc3117-battery.sysfs.online # SKIP                                        
# Reported: '1' ()                                                              
ok 7 stc3117-battery.sysfs.present                                              
# Reported: 'Discharging'                                                       
ok 8 stc3117-battery.sysfs.status                                               
# Reported: '38' % ()                                                           
ok 9 stc3117-battery.sysfs.capacity                                             
ok 10 stc3117-battery.sysfs.capacity_level # SKIP                               
ok 11 stc3117-battery.sysfs.model_name # SKIP                                   
ok 12 stc3117-battery.sysfs.manufacturer # SKIP                                 
ok 13 stc3117-battery.sysfs.serial_number # SKIP                                
ok 14 stc3117-battery.sysfs.technology # SKIP                                   
ok 15 stc3117-battery.sysfs.cycle_count # SKIP                                  
ok 16 stc3117-battery.sysfs.scope # SKIP                                        
ok 17 stc3117-battery.sysfs.input_current_limit # SKIP                          
ok 18 stc3117-battery.sysfs.input_voltage_limit # SKIP                          
# Reported: '3704000' uV (3.704 V)                                              
ok 19 stc3117-battery.sysfs.voltage_now                                         
ok 20 stc3117-battery.sysfs.voltage_min # SKIP                                  
ok 21 stc3117-battery.sysfs.voltage_max # SKIP                                  
# Reported: '3200000' uV (3.2 V)                                                
ok 22 stc3117-battery.sysfs.voltage_min_design                                  
# Reported: '4200000' uV (4.2 V)                                                
ok 23 stc3117-battery.sysfs.voltage_max_design                                  
# Reported: '325000' uA (325 mA)                                                
ok 24 stc3117-battery.sysfs.current_now                                         
ok 25 stc3117-battery.sysfs.current_max # SKIP                                  
ok 26 stc3117-battery.sysfs.charge_now # SKIP                                   
ok 27 stc3117-battery.sysfs.charge_full # SKIP                                  
# Reported: '3000000' uAh (3 Ah)                                                
ok 28 stc3117-battery.sysfs.charge_full_design                                  
ok 29 stc3117-battery.sysfs.power_now # SKIP                                    
ok 30 stc3117-battery.sysfs.energy_now # SKIP                                   
ok 31 stc3117-battery.sysfs.energy_full # SKIP                                  
ok 32 stc3117-battery.sysfs.energy_full_design # SKIP                           
ok 33 stc3117-battery.sysfs.energy_full_design # SKIP                           
# Totals: pass:12 fail:0 xfail:0 xpass:0 skip:21 error:0                        

v9 -> v10

- Use error code instead of arbitrary values
- Use Co-developed-by tag 

Link for V9: https://lore.kernel.org/linux-pm/20241213063813.32371-1-bhavin.sharma@siliconsignals.io/T/#t

v8 -> v9                                                                        
                                                                                
- Corrected the error message                                                   
                                                                                
Link for V8: https://lore.kernel.org/linux-pm/20241210080954.5067-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v7 -> v8                                                                        
                                                                                
- Add output of test_power_supply_properties.sh script.                         
- Change 0X to 0x in macros.                                                    
- Fix typos and Specify units in property comments.                             
- Remove stc3117_update_battery_status function.                                
- Convert voltage and current from mV/mA to uV/uA.                              
- Represent temperature in tenths of a degree Celsius (1/10 °C).                
- Export average current and open-circuit voltage (OCV).                        
- Use devm_delayed_work_autocancel.                                             
                                                                                
Link for V7: https://lore.kernel.org/linux-pm/20241202094328.14395-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v6 -> v7                                                                        
                                                                                
- Removes extra spaces.                                                         
- Fixes error handling.                                                         
- Fixes the logic for checking battery status.                                  
- Fixes typos.                                                                  
- Removes unnecessary commas.                                                   
                                                                                
Link for v6: https://lore.kernel.org/linux-pm/20241130094531.14885-2-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v5 -> v6                                                                        
                                                                                
- Use shunt-resistor-micro-ohms property instead of sense-resistor.             
- Remove the battery node from the binding examples.                            
- Add interrupt bindings to the example.                                        
- Correct the Signed-off-by (SoB) order in the commit.                          
                                                                                
Link for v5: https://lore.kernel.org/linux-pm/20241129114200.13351-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v4 -> v5                                                                        
                                                                                
- Fix variable names                                                            
- Limit code line length to 80 columns                                          
- Add interrupt and monitor-battery properties to bindings                      
- Correct error handling with return dev_err_probe()                            
                                                                                
Link for v4: https://lore.kernel.org/linux-pm/21c08a45-34f1-443c-97d4-6baf9fa01b67@kernel.org/T/#t
                                                                                
v3 -> v4                                                                        
                                                                                
- Added support for current, soc, temp, and status properties.                  
- Addressed comments and feedback provided by Krzysztof and Sebastian.          
                                                                                
Link for v3: https://lore.kernel.org/linux-pm/20240205051321.4079933-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v2 -> v3                                                                        
                                                                                
- Resolved DTC warnings and errors                                              
- Formatted the changelogs                                                      
- Added monitored battery properties                                            
- Replaced 'additionalProperties' with 'unevaluatedProperties'                  
- Replaced '&i2c6' with 'i2c'                                                   
                                                                                
Link for v2: https://lore.kernel.org/linux-pm/202401080530.0hMWnrIg-lkp@intel.com/T/#t
                                                                                
v1 -> v2                                                                        
                                                                                
- String value is redundantly quoted with any quotes (quoted-strings)           
- Found character '\t' that cannot start any token                              
                                                                                
Link for v1: https://lore.kernel.org/linux-pm/46bba29c-330d-417d-ad84-ceb5207fdb55@wanadoo.fr/T/#t
                                                                                
Hardevsinh Palaniya(1):                                                         
  dt-bindings: power: supply: Add STC3117 Fuel Gauge                            
                                                                                
Bhavin Sharma (2):                                                              
  power: supply: Add STC3117 fuel gauge unit driver                             

 .../bindings/power/supply/st,stc3117.yaml     |  74 +++
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c     | 608 ++++++++++++++++++
 5 files changed, 698 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

-- 
2.34.1


