Return-Path: <linux-pm+bounces-19510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B29F78E0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 10:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C55169278
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D19B221DBD;
	Thu, 19 Dec 2024 09:49:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020089.outbound.protection.outlook.com [52.101.225.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A8221DBB;
	Thu, 19 Dec 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601780; cv=fail; b=Bhj6MCTTyxX18mVGl9sHZX9qJV7HiB1PjNfnyF8oGqZiSHdKEXasDmQYci2K43I71NxBWHhEuK4GCgJHzp3gMnNqDxbGRmxT2sjOWwSS/oFhiV9n9rlDC2BgAq92fJSZYeSS+n7khFzDqrFAhTy5EVFlO8A2taCa81ESeyM8+7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601780; c=relaxed/simple;
	bh=07d8ODAv469vLBwn6iVGvmqthpr0gapn2uvBwRhOzLg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IkjpNsHHG3g6VZCBVhsvba+IBoA4xiDUOhHdOvZZwOIosxwsutK6kDCWmijuMqDUweetbFSqjRl5VAPwc2jCOMQnj/t9+YaA4fmbi9wWeyE66Yw9wBkxvm2RKzJy1zZf4j2UyurmUOmWbFKESSeqJgycKxirqX6DPVeVHpeL2i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd/iLjjzqLZ5+o4jv7ZrfWuCms/iyZ0e6+zsJKLKeqoLPSyZO0yNO/8LmIx19Tsbk0KjqHTXk2X7bhfRpZI86wrjYacfMiItio6t95UoqfdPOE4A1j1Ntg6JGqvJM8ufgxM/EV534r7Yf9tAvRxaCU64cWzM9RpQuFhDDP8vBGLQNBMUjGR0y7vUhWPh5RY6n6NRkQXEr4PHCQYPAOo8amKw94xjK/b3SYMlwpWnSze5VIh6I0z2dXhwm0w6qIwYMLSPpNzvkjd6nF3yb4qFPn9Bz+hsGVvcwX713iwZh/FYuCpatRomNDnpZHR5Xkpzjtf4nlH9OIkfjE7Eai65Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wum+5PlMIes5rmpz3ArVJZERqDE+ln0TFaFjNwJwsV0=;
 b=G4XMHKetJiGSjWSk3Hwhy+xhWW5EQED5zmAlkkH5ZiIXoKyz9hp5DsiPlhGw+eu/p8I6WnVDfZYk5sFhSGBRUes/soJ4v6d+919f3GAYvTrHeABbfcg//DQtFAtDPOjcol4DoCbIBIFL9Fv8Eb1VyulDiXadw2n6I8KZwqQJ38lJ7JaR6ZRU+WHeKdXasb+AYU14BokQmx/XehWoAbFdacAmRmoJvSIXWBnq9YYjHzM3C/J6YQvkzEQUbANuIsOY5+s4tjcsBVIk0hNnfSvfBeMKmegNU/rRfzbSrC+2AdTXdKJHzFGeIcuLVDsbgWMiauox+QNpewbPlb/4xbHCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN0P287MB1187.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:18d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 19 Dec
 2024 09:49:33 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:49:33 +0000
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
Subject: [PATCH v12 0/2] power: supply: Add STC3117 Fuel Gauge 
Date: Thu, 19 Dec 2024 15:19:10 +0530
Message-Id: <20241219094915.19059-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::23) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN0P287MB1187:EE_
X-MS-Office365-Filtering-Correlation-Id: dc82c05b-79b6-4415-1deb-08dd2012710f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU1SS2l5bExzOCt1YkZYOVl4YXA4M0QvUVlXQVNXQ09OU3h4OUdkb1gxY1kw?=
 =?utf-8?B?WU5Dcm1IRk1ibVI3bWtPa20wV2ZjSGh4QnJsSHhocGtmaHVuWHlOdWlTN3pl?=
 =?utf-8?B?TW96MW56cERoMzNDTFp2cVEyTUpDUEdDekRFZWRUeEhROWgyTzcwbW9aaUwy?=
 =?utf-8?B?OWZKc2FzRHQ1LzlWSVdHdnFuT0dwRDlzcWt2RktjRmxoRTVvOG9tN2p1WTdK?=
 =?utf-8?B?RlV5NzBTV2xmNmFNeTdSSEppYmN2d3AyRS9ia25RWEJWK1hNdDJGdzE4TUFL?=
 =?utf-8?B?djU5YXZFbWNUNEczUXRXMSthTE0vN0l5Lys2TnluMUcwbzNIMlV6NlkxMW0y?=
 =?utf-8?B?cDAya3RpZGFqdzdQUlh0ZE1lMHRvcjZ6SXN4eEU5VWwyVG5yT3BiSTNSWVNn?=
 =?utf-8?B?Z2hwZStMRzd0WUxFZHZRUFc1OGFvNVZNMGVWN3YyT2UvalB5Zm82OHh5RlJ2?=
 =?utf-8?B?ak53WEFPc1daWTU3U2kybEdnSnphYzgyNEVpYmdrcTFTeDhySHgyV29sYXQ4?=
 =?utf-8?B?U0lZYWpGT0llYWwwWlFKTEQ5ekd1VW1NQ1ZpTTR2UkYwbHE3dWIrN25pYlRa?=
 =?utf-8?B?RHRVbzNVTnZZLzlaRGVwODQrbG1tVm92SnhFVmV5akdWTit6Qk5ybHNpNTNP?=
 =?utf-8?B?eFZUVW5pS2g5WURJNUxrYU5PeHAybGFkMHozWEwreXZFK1BWUmNjbUROc3Ar?=
 =?utf-8?B?WTdDZUI1ZDJOU3dsS0RIb09UYmRkTmtMZUlpMVhSbGpkdTBvbXh5UFJCdzRj?=
 =?utf-8?B?bTAxcVNMbUg4UGFTdXNGYzhBc2ZBN25Cb3NkNnVsSDZUemNTZFBWQUxEKysy?=
 =?utf-8?B?cEpzd0lSTllLWTdxSFduaGZ5Vm5SMGEzMk5rNUd2LzdEVWhJWDR4Z3lXaVdP?=
 =?utf-8?B?Qjd5OWRoNXMxbXI2R0hnR0o5WENJV2Yxa2h0aWpoeWc4NXBWdjRpT2l0SHp3?=
 =?utf-8?B?ajBMelF0OGptZTZSalJ5VCtJVnlsK1ZFb1BQRk1xOEViaVBmMTh1YW9lUUlI?=
 =?utf-8?B?b1dja2gyU0dYMm8xTkZ3aGkyVkRvRHZvaDcyb3E2L1ltdTBSVkVickZmM1pk?=
 =?utf-8?B?V2hWU2dKOUdWRkFzd0o2RUdqVnlkN3NZb3dkeTdHb3kwaUdhRjJqRzQvNzZv?=
 =?utf-8?B?QTNuUWFmVGFFbTljTHl1ZHhMWFhNa05KVG8wSmFQY2lCYjB0TnZNSlJHZHJv?=
 =?utf-8?B?QmtmQUltZXhWNHEzbW9jWWVndENPbGo5OFk4REwveXlMbnNIY3ZmWjNVelkz?=
 =?utf-8?B?M2JLeUxQUzFlKzE1ZlRhc1Y5MkNtMW5Ecnd1d05vUVNZb1NnUHpLeUQ2V2Nm?=
 =?utf-8?B?dXBWUXkxV2JqR1BVRTFKQ0MraHU2dDN1VThkVHowTEhFNWN2ay9mb21Ra2x3?=
 =?utf-8?B?VGNpK1lWWjQyaHV3SmxaTnZlaWJsTHlHUm42c2xTbVRRb3ovUEczZW9iamUy?=
 =?utf-8?B?cmVmQjNlcXhyWGJGajQrZnhyUU1FZFU4ckdEbGZoRDkvUGhmOFR3TXRaTlRl?=
 =?utf-8?B?QTZRYm1WU1NGSGNJQnlhcEV1aTFaUFJjV0w1aDlBM1VJVjhXdms4RVZ3S1k0?=
 =?utf-8?B?bFNNVW5TbUNTT1I1MHZzZFVCQVRKMFZBQ3VNRGU3WS9DNDVvTzRnSktrWXlN?=
 =?utf-8?B?aGYxWGkyQkJJZEd3NFVXaDBwc2tMTVpnSkJKU3RkV3dDaTZZTWZTQzk1U0I2?=
 =?utf-8?B?NjZtT1NxT3VBT0tBSGdrSTZOTTYydmN3R3MxRFpLdFJSUldoZUVFUS85bHE5?=
 =?utf-8?B?eVJOMFJtWUZSS2pESG00S0JEYWNYNHJ0by95dkMzTXBiUTM5SndXNWhtTmlt?=
 =?utf-8?B?cXQ5VjB3bVhqQUhTZDVBbUNFTnc3ZkdBdWhZQXFWcFlxSU5IMU9zR215OUdn?=
 =?utf-8?Q?JkxwPQ5Vageb2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODJDa3BKN2VGVUJNdzhuaEU3ZDRJcmsxZGNvM0I3R0VPSDZtdzBQeGk4bXVv?=
 =?utf-8?B?bkVuZ0MvdmpOOThMbWtSZUZrZUpvUnVOaTVhdUFPYnBhNllkY1BvUDBwM09Y?=
 =?utf-8?B?YmttRFN3aS9qcVNhVE4zbXJxdkMvdkRnNGlSR1ljMkNpbmhmVVBYQzJlbnVV?=
 =?utf-8?B?Vzl4Mjg0SVFYTlNBaVN4blpxcE9BUWRTRkp4blZlSlVHVGpFREd1OGhDQlg5?=
 =?utf-8?B?OXpqdnJwNVJJM0FVZ3JWb2dDVU1CbzloZkh2RFdURHBBRjRSWWcxamVwUDB1?=
 =?utf-8?B?c3hTM25GZlFnWUx2Mi9GNzAyS0FPb1UvL0JWNXJVVklSYkNmemNmS2JLTGNB?=
 =?utf-8?B?emlFemh2cWtWRTNoU1c0cGNGdVFkWW82WHZpclNSL2dTQS9ndkN2QTlzdHRz?=
 =?utf-8?B?YjVYMUZBRUdzNDdDdXF2bjA5TytvOGlON0g2RXh0RmxhTmpnTzNlbVBwVi9X?=
 =?utf-8?B?MDEvWVgvdndHUHFVYkZmb1JqNmtlT3RhL052UHprM2FUMmpiSS9Qb3E2OHg5?=
 =?utf-8?B?RU5iQndQRUR5cXhwcks2Q3JqWTNQV09RUUFZN0FWamZxOS8vd1hyUjNRZ1Z0?=
 =?utf-8?B?Sks1RExrRCtlZmF1VXZSRnhYQlJQU2RrTUppZkR6WlpiOEpYcExsbi9BWStP?=
 =?utf-8?B?Vk9HekRBb3psaFRMYkQrY1ZFdFVvbk1zKzhhN0xIWUNaeTlHZTV5NU1kSDYx?=
 =?utf-8?B?SkRHYXgwTllFRjg2WUNhbFNuaEtJZ2NsZGxuSkE0OU9RaGpVVzZRM2diZFl5?=
 =?utf-8?B?S3ZRNUR3amNLOExSZlhKeFlMZlluMHZZM0RGTktNUFhvcGhTclkvRXk2U2xQ?=
 =?utf-8?B?TlZPQWE5K0s4Q1Z3RGcyMjk0QXgrMnFjME5SMWYzSGVBMmYxbkxJTVo3WWM0?=
 =?utf-8?B?NkkrNHNNc2FUalUwRmh6RFlVYXA2RDRtRERUR0tsZTJCOGhiWE8rUEoxK2N5?=
 =?utf-8?B?cGlFQXJpdzFWa1FPYnFpRTY5MCs2WmF1VDFpRnhnV1pRSCtPSlhVWTROeDhy?=
 =?utf-8?B?Z0gxNTZRV2l6ZTEwS0JmbEVlbFpHNHgrNk1zNTNKNEV5N2x0cUZiMC8vaXFx?=
 =?utf-8?B?VldKdUhMeit5N3RhVEVBNDkyaHdaaGc5anpHcHZUckZXQ2F3LzkvUGhRWDFM?=
 =?utf-8?B?TTlhMi9UaUhSZjl1bFV3MFVQd3VJbFdqanVpM211WE5qN3o3M0RiL0gxMXRr?=
 =?utf-8?B?dno2MXBqTVVDbmdDQ3hMN2JMMWpLUG5mbjBVYlErZmtMbzRzMmh6dzllWFQ0?=
 =?utf-8?B?TlVTVnlMVGZzQ01Pb0s4eXVDM0o0dEI4bTlWR3ZDOE9lYW5JWTk3cHZWVmJY?=
 =?utf-8?B?ek5lVGU5N0RaOFZ3WnhBMGd3Ujd5MGtWeXpUdzZpQmZYZk9pSy9xUFhvdHNn?=
 =?utf-8?B?VHpoVHlqVyt1YjZlRS80Mmw4Y2xVNWJNTkpIb2VRUURObG1HclBad0hrTWk3?=
 =?utf-8?B?dlVUZFZPZ3J3aUJyMXNmY3p6QTV5bGhab2tTS1FWOW5DdkVndnJWRi91Q1Fh?=
 =?utf-8?B?V01TRHB1Sk1FS2o3cUdEd084TU1CSHYrMDBYc2c0c2k4c2dRUStzR2N1djdj?=
 =?utf-8?B?SVdMRVpvVVhsa0xkV2tad0dCY0U3SWVOK0FFWlBZbEdFVk9rSVpkdE93ZUht?=
 =?utf-8?B?VGJKVC8zUjJ0ZTVxYzRVUlZ4T1I5WDVaVjZzSklzdEpSSlo4NTV4RitxL1pw?=
 =?utf-8?B?NDhtMFcxbFIzb1VHdGFsdmQzNVNrcnNkUWl5OGtVRnVTVGQrTzN0OVFjaFky?=
 =?utf-8?B?cDh6bitmRTlOd2xVRVJTTjVEenQ1S3pJZUpoY3dueVpLd3Jwa004eWRmK0RL?=
 =?utf-8?B?NmNzWEg5NjVjMmJJVVZiOGZhY1pKMk0xSFhWL1hONjkzVElYSzU4M2xydmZB?=
 =?utf-8?B?RHB4WUwzbys4dncxbGlZTEtiMVpvZ0taTXlPa25TTWhpVFhKNjFPeGdvS2Ux?=
 =?utf-8?B?VklmWXlsbjdWUjh1MEZHaU01VmxLWGpPd3M2MlZWT0lBdFl2OVB4dDhhMXNZ?=
 =?utf-8?B?NHRuMFJKdE9CVFJJbnZodDJ5VXppY05zbVZkYVNEbXRMVG1ub1hnVHFCRExW?=
 =?utf-8?B?MlV6eEVVYWdON293dXB3bmdkczB6bnZVR25lVG5ocTRwNUFIVGdxUk5TRzdV?=
 =?utf-8?B?MkNWTlpmVG13MjVMUWdhZnJlSkR5TEMvcUhyejg1aXkzRzlHSXlzakpKb3Ru?=
 =?utf-8?Q?E95tHFTgmHOEXLNzuY3cy8Q=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: dc82c05b-79b6-4415-1deb-08dd2012710f
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:49:33.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kn2tROZwXGF66/mhaILSefxI8do/+9zweOZkeVl69R7tw0p4W6UH+UZCbDM49HGKXH8PHWEJpq7gZy9Eu3zYwpWdYi0D+pGu7dD8rF9mdn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1187

Adds initial support for the STC3117 fuel gauge.

Output of test_power_supply_properties.sh
(with version 12 patch changes applied)
 
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
# Reported: '24' % ()
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
# Reported: '3506000' uV (3.506 V)
ok 19 stc3117-battery.sysfs.voltage_now
ok 20 stc3117-battery.sysfs.voltage_min # SKIP
ok 21 stc3117-battery.sysfs.voltage_max # SKIP
# Reported: '3200000' uV (3.2 V)
ok 22 stc3117-battery.sysfs.voltage_min_design
# Reported: '4200000' uV (4.2 V)
ok 23 stc3117-battery.sysfs.voltage_max_design
# Reported: '196000' uA (196 mA)
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

v11 -> v12

- Removed direct scaling (* 1000) in userspace property values.
- Modified stc3117_convert to ensure proper unit conversions.
- Returned -ENODATA directly without scaling.
- Corrected Singed-of-by & Co-developed-by

Link for v11: https://lore.kernel.org/linux-pm/20241216070457.8083-1-bhavin.sharma@siliconsignals.io/T/#t

v10 -> v11

- No changes                                                                    
                                                                                
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

Bhavin Sharma (1):
  power: supply: Add STC3117 fuel gauge unit driver

Hardevsinh Palaniya (1):
  dt-bindings: power: supply: Add STC3117 Fuel Gauge

 .../bindings/power/supply/st,stc3117.yaml     |  74 +++
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c     | 607 ++++++++++++++++++
 5 files changed, 697 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

-- 
2.34.1


