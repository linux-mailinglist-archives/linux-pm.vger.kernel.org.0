Return-Path: <linux-pm+bounces-8580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C66E8FB831
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F822874D1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D6513D24C;
	Tue,  4 Jun 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hDhmZVox"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CF12B17A;
	Tue,  4 Jun 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516631; cv=fail; b=OziUqpR6M70IL+98YUNrf76D6uwxGUbyCVMdTihDIXgmlt9zOiFK7zSv0Vt4pc7q76PW9GPstIqfjT2AV8DpyrEyBtN+8f3xVYjimPRbePlvRd25JaqI1QVWOyNycJEGtpW8udGzZIJoyAsiaAg5E2e3Zycjf9TCZmyzcX0Ss20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516631; c=relaxed/simple;
	bh=OzQHBuYCevC3QMLOHmUugapdlyVZ/Vufcvdwq4dAuwQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FMvyRPYboNUz0s4eHsZH40UqyK01goczIIsScpyxmJtRMXDOSVVZU1WqID49x577oR/2aJa9aLA366MNG3zcVRd35X3DmRoKvWpNcY4+IcluMJCfQBWqX8bvzhO/MOEw/z24XqBsszYb+/+v98RmQ/ajKoX8wCVo9RHwmT3yoCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hDhmZVox; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKA/vpMBkK5qYGUguIgA8rkA6mTcuiGAmCJowFITiJdvY3p/lRHxPO4Or2EA1WMGVreyn8m9xsF/yL8u86LQU8vGHnlwhdp9M3HAVoxbmSgQojflHTP+xMR2NxC0Rgy2r8Fq5mz45FTcBXw3NQDzh7Iy25KA+pUP6A+3T9t4CYYnKtDValsTiwXzpq0cpSg26+OPWqX0nkGxfZCKonczVWdBvf+6gDRd0q3s2wHK87SXYRRb1WqpRhN/snosdcgUcUPQC6pOrThVTy+bY/mzu5dncWRkzguo7knca0e04q0ap7F1F82AqrGEfEKKv3JUSZRDSpBsORsNlBKTYkz8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKlcO9YF6T/DTBc2NhO1L+SJ5LXiqrhNhnvx3x8eVyw=;
 b=UnMi3GqKKc6TB7orsoxEGQF7Bo92ETZ2OdOQfw20SiIesgyXr5fSNWW86ljWW7g29p6QZKz/Q22wOK1QFeb3cMSl8KYrqNSKRMl4iCKMZIa8h1bs5ELk/DWYcIEBxu5X2OoP974obMqDoqqi1zhtowM72h/5BExjI5rvZWfAfKsDDk+V121AcFdixVGKxNN2dNjgxRLxHrqI17jAvxd//+35iqZiQv4EnIRfdgEppXZFWNRPxV8mDlQjenlDRhOZNS65shGxmNSkSIDRXTnkKNoWFVuGmF54bvB5E0VEud9Y/lx+aw2LbCQAdvE9S5Wp3nM5NiGu97AH9uH+ph5Ncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKlcO9YF6T/DTBc2NhO1L+SJ5LXiqrhNhnvx3x8eVyw=;
 b=hDhmZVoxvk5k55TgTgFco/pdzRLODDSaizVtPGIYr7L1bXAGBydSF1mwST7umJ4IsAh1rlb7osazqHnLU+tsDCsKrwtLduT5JlBzIuw3A/qMP+dM3AfkQ9bWJFzeKudcIyLBEH6UBwRfu25T75TSX5+OcbczIGn+Zgh+QoFIdeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 15:57:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 15:57:04 +0000
Message-ID: <5b4155c9-35d4-499e-9256-148b3ed7a491@amd.com>
Date: Tue, 4 Jun 2024 10:56:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
 return value
To: Anastasia Belova <abelova@astralinux.ru>, Huang Rui <ray.huang@amd.com>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240603110741.24818-1-abelova@astralinux.ru>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240603110741.24818-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:806:23::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 32300e11-b5f3-42f9-3aaf-08dc84aefad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zjc2RWhjYlRob1h6cFV4TlJUeVh0QkMraG9TUWZUbkJCVUFCaHQrUlBkWlFw?=
 =?utf-8?B?WWxsdHM2QmlhdkVuQTdMTFFLM1dSeElUS0lIWnN2TlFHdmtjaXJkaFhkUklX?=
 =?utf-8?B?RzIzaVBxdUZDRERreWdHWDVtcjRNVG9jNGlSMnZtRkdxc2NiUHRNY0p0RXgw?=
 =?utf-8?B?ZlJhMVlCd1pBbzJLTzE5S3lIbG1TanViTHI0VVlES0F6RXhGSzl1WEVGaGpx?=
 =?utf-8?B?ZFRxYkZPeGgyR2REdkpXMmc3aTNHYm1QY1cxVWkydW9wSlorODltZXVPNENI?=
 =?utf-8?B?K1BUdW9PbmVQdHRkZjBRYy9aTFptUEd5T3dSRS8xbzh3YjRGclQ2WUhpY0Y5?=
 =?utf-8?B?Z0xrNEFtUmtGdDdXY2o4TWRRNW1td3lKb0JKaDBVZmk5Sm1GTXFWM0l6dmJn?=
 =?utf-8?B?SHJBMkZQRjF2SlJuaEh4QXVkQ2lteFhxYWFxNWFGZ09Ha1VKeWU0Q0FaYk9p?=
 =?utf-8?B?TENWblBhNUxSaVVaS3JOalRNSUY0aVU5MVpXSHgxZ1F4aXIzbENBcmZFOStj?=
 =?utf-8?B?ODNMa25KY0E2ZlV0cHc0blA5R2dldlB1cUF4RTZoNE5wNkJRMlhNdkRuU3k2?=
 =?utf-8?B?TE9pMjNEVzc5Q2ttYXhLd3FPbllvcHdoYnl2MVgwb1JmMysrdFVUVlloT3k4?=
 =?utf-8?B?YXUxS2JHSVFDVGFtQjErVFljalFjS1lORWtRdmpoRUJpUW8rOXNqSkl4V2VG?=
 =?utf-8?B?dmI2Q1dGZlRucVVUbHBvSXljNnJRR1VBNnF6dGdDWng3L0U4ZS9kOU9HdXdX?=
 =?utf-8?B?NkFqd1loSy9nQkJSMUxiUythNEgyeHZyNHJFQzN4N0lOcWJTWnVvWXJybW1T?=
 =?utf-8?B?WkkrMnRsV3kzTmFJVmFUam8rSzdQU0x1R1RWaFlyU3RwRnE0bGNLV3B3Z004?=
 =?utf-8?B?RzhibVJlaDFuWU1zYXF2SlBHT00wUHBZdEE1UVNIa0c2ckdHYzNKRGx3Um1n?=
 =?utf-8?B?dEl1b0w3RUVvbVc5cTF4bDU4Qm5BMGZmZE9qTHc3cWdDY1FNbklrTkRWcmNq?=
 =?utf-8?B?dXA4V0NwNnpMZ0hSQXJNSythVHAzdXk1Qm9rWVRYM0FFK2N2R04vUmZ1VlF6?=
 =?utf-8?B?Mlp2TXZlK3lVOVg4Z0dYNjVRbzRjVFNqM3hFZHpHWm5ZTFp2MmxhbkRiSHhL?=
 =?utf-8?B?cGIwQUJaL1hxRVVOWU90VTZJOUFpa1hNSXE0OHEvdGg0WHl2V0VDOXVyQ2gy?=
 =?utf-8?B?VjBGZXpwd2kwdGsrVDA4Y2lUUE1nKzI1ZERBZFhjcDNGYVRDYTh4cmxrU2FT?=
 =?utf-8?B?My9CUnBWNEpXRVA5cU9nNzdraDdoNjJheUZyT1pveHlOTEhrc1BtM3NYNUgy?=
 =?utf-8?B?Tllqd25FcHBOUTBjTmozTGtIUlgra0hNSTQvcmtMalNjSzFVbHp1b1Qvdyt2?=
 =?utf-8?B?dFJ2UmZDMlpSSFBYWDBYcWF6U0ZjY3dQWHArQXFuY0xLUnZiY1ZQWlk3SmJW?=
 =?utf-8?B?d1ZiT2VwWmVvcTBJb3dNb1pzVDVza0hRSEkzT1hCYk5OK0dIUGw4WE8vR0cr?=
 =?utf-8?B?c3A1OXdOZlRLamdaSG1pTVRObFNIN2V2NXlUdG1zNzJZS3JLbHcza1JZSElD?=
 =?utf-8?B?dkgvMGd5cDE5ZWNxQ1VtQWhYOWM1ZlhpSnV0OGxJbnJvYitEUW96MGNGTnQr?=
 =?utf-8?B?dEhUVUk2VTh6OEl2Z3BDOXUwNXZZejlaTHo3aS9LQnhtWVZudzltSTBHOTNt?=
 =?utf-8?B?aDREMjk2TUIzZ1F1dElkMkx2K2ZTMDhTc3VDRDNDaXIyUWE2bEFlZjJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW91RGlDVDZTR2o3ZVJyemlvQmxwNXFGRDZiem84dGpGZE0rM2lJVDIvQ0hp?=
 =?utf-8?B?Slp0ZHJkOGlJY3UySzZBQkZucU1nclRYUkYzOW0yN3lsbVN4c0E1U2RaWW0r?=
 =?utf-8?B?a1cvYWNHMXIwNlVwdW5VRDR2R1NqN2Y5eWNJcFYxaU9yR1UrWTFpTEU0bHNz?=
 =?utf-8?B?bDJWdnhCalM1Z3plYU1uTStWN2x5YWRGVmtTZ1M1MmFTdkZMY0VqZDVEKy90?=
 =?utf-8?B?Wjc3K1FOTzUzbHVBQjJSKzBYYkdyMWRUdDRKSUIzTFJMSmNwQWMvV1k5cCsz?=
 =?utf-8?B?U3ZkdnlIKzRuRHlFcTc2RW5xVnVGYWllVTRvQU5VV0lEVjNrdW8rNnJpWEYx?=
 =?utf-8?B?UFZtTmo3Z1NCMEY0OFZuMTg1OWZkY2ZVWHdoVE10dldNdXIxTlVkTnBCd3dr?=
 =?utf-8?B?anp5bW9Mc1RMaHlobUxra2I4UWlYcmZJK0FVRXpjV2lMbEJhZTR3ajRRRXJp?=
 =?utf-8?B?TmtVTDdHbzB3ZFFSZFhCYUo4UkhiUGdYaFBwM3hhSjFvRzFrN01vR3g2ZG9O?=
 =?utf-8?B?a3Q4WEFHRlZDMGtBdi9UUmZabDZ0cmZoV1VHcmM0WVhkNzAxSUFSdWlzYXA2?=
 =?utf-8?B?OHNmTmRTOEVQRkpLNncwMUFXbzRuekhERW1oOWhENHZHa0syMURqVUxnRUxx?=
 =?utf-8?B?cWJPSEZseTQ5cHlDWk1ZNVlFZW0zRzdMQmlYWGlhcEdTbFFRWTRWVDVLYkRu?=
 =?utf-8?B?NWtUdVM3b0JtczdKdEFXVnhmelVUKzhoVE40U1JrS3JpaGR6Sks1TXU4NFZx?=
 =?utf-8?B?TXR4VjVnQ1RiYzF0NXRNeUh3MlZEM3p6SDlPSitraTdiRjJ4UC9TclIrYkps?=
 =?utf-8?B?WVdndUxhS0libG1Jajd0MHBaS2c1b1RweXBjcXVHN1FZazIyc3hRSERqUGFS?=
 =?utf-8?B?MTR2SHk4dG9HM1FjelhLVnFFcFFSbWh3bGZXTGFjZy9JbjlzUk8rd01WNk95?=
 =?utf-8?B?clpxSFR5cmlqSWozQmh3Q1ZXUm5XS0hKdXcyQWNDSG5qNlRCRmlva2xMMVJC?=
 =?utf-8?B?Sml5SjA2elZhelBQdVo1M1lhaisxaEx3UnliQnhvNjdYdU5EQkFNcHI3ZDVz?=
 =?utf-8?B?ZFpiZnUrTGcrK0JjYWF1OE9sTGJmQWxGRFJqQk5DeTR5MEQxZWUvbi9xcVN1?=
 =?utf-8?B?V0NrTzFNY3RDanViSU1CWDBIODNhdFRGMXA1dVBscUxxNmNRYWtYQnBtVkw2?=
 =?utf-8?B?dlo4dHJNVVl2TkpQTXlNbERHb0t2ODNmNGhVbERtNEkrazJabnFQQ1hvV1pi?=
 =?utf-8?B?amZuemdwaURjR0t4eHhpYjMyZkdXTzdkU2N0MnhFZWJET3UrdnlZaEM0THE2?=
 =?utf-8?B?WmUxSjU5UDF5ek9IM1A2OUZKelhxRXFtaWxZd05rRDEwS2NSL1pIQlJ5VU9D?=
 =?utf-8?B?SXhqU3l2SEU3TG5ScVQrQU9YVkhRRC9COU1wMTJ2OHNaRVVCZE1tcTZhNS9M?=
 =?utf-8?B?SEN4SGFNOWNPclBPeGZoeHpqUDZrMWNaUFA2UXZDWUdTeDRwRDh1bjRJdFEy?=
 =?utf-8?B?T0lBU01YNUZDOEFtR3ZlMWNobjgyR0NPbk1SN3pnRTNDRWVQQ1k1d0lvbGRV?=
 =?utf-8?B?by9XSlgyT3dpVjhaZGhPVGhDVTRsd0VIZmlSRHhGYmZQUlZjL283Y2dHdWFF?=
 =?utf-8?B?RGR1cFBJZk90RERnUThpTDlQdG5UODV2d20xdVBJcUJidUZYY2JXL3hxRisx?=
 =?utf-8?B?Y1diazk2K0NLcHRkNmxaRGVVaFE0cisvRi90VXlsOE5xTFFhcHpMbVE5Qi80?=
 =?utf-8?B?R0hsaUc4OFpzQVpVN0NmS2xnWEZsZW9ldlMwOTMyMlphWXUxT2dQLzZwdS80?=
 =?utf-8?B?aWcxTy85ajJiT1J3eXJ1VllTbjBRQ1FzVVJ5ZktCdmMrS1FYSXdxN0xrbkFH?=
 =?utf-8?B?dDhXK1daS1lZdDFNOTBMWWlCeFAxTXFBNmd2YmVNUHJkb2twKzltWGFjYUdL?=
 =?utf-8?B?MjVrbmlUQUQzY3lQcFl2TFcxY2dUd0lFRnRZUnU2WjYyMzZrZTkwZW9TNXk2?=
 =?utf-8?B?T2ZpYmJrZ0krQ0NwWXVGR21IQ1BKSThyR0xrWjhiaHJ0QzYzQk9vSksvS1hr?=
 =?utf-8?B?MTRGWEh4VmJWL2lSeThMWGc1dVJ6dzF5Mk9uMTR0clR1RGFQTVcrWVphNDNq?=
 =?utf-8?Q?L4/0h4x68KiX8mb0FJIvutyun?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32300e11-b5f3-42f9-3aaf-08dc84aefad0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 15:57:04.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdhhKqLDzO1EgwgY5MevrlSyMrl/vWvgyevPvGYyJg983YgC6+dHtjhAeI2m4ez+DJiGwM6XKdwlJSwWxc2skQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036

On 6/3/2024 06:07, Anastasia Belova wrote:
> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
> and return in case of error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Thank you!

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1b7e82a0ad2e..672cb6c280a4 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -621,6 +621,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   	unsigned long max_perf, min_perf, des_perf,
>   		      cap_perf, lowest_nonlinear_perf, max_freq;
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return;
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   	unsigned int target_freq;
>   
> @@ -777,6 +779,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>   static void amd_pstate_update_limits(unsigned int cpu)
>   {
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return;
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   	u32 prev_high = 0, cur_high = 0;
>   	int ret;


