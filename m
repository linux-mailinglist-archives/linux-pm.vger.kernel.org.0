Return-Path: <linux-pm+bounces-26506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C72AA5F01
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 15:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABEC9C6EB1
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071E516CD33;
	Thu,  1 May 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BVtdJa2x"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2B14883F;
	Thu,  1 May 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746104488; cv=fail; b=VVzTue0SRjUlwPwbE1JJZZ9nAJwXYNdEM3tlvAk6onSs3DuijdJhFMh7oNrPZJxvBr5EJanIsdgJD4rz9XJUYXPv8qe4qimnbFBPoEZonTQyJrgSnRQjIOUwO+s0CuHHk/RneeIvbzV5ePZP5B+DzM5Ug7IFtd5Hgm+h01TUHqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746104488; c=relaxed/simple;
	bh=6ftu+lN0Svu5XIkYlxFaHFSkkH6eFnNTWzXjRGQHtT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aOeQ42zlFQTjQJBfCr21mWwsGMYoaq6hWQG7Q5tkU7EgJS4Opm1br3xvo9p2354yuFzoiWySC2Be/6A/vc86+uIHDpnGJ4fYOvXK8VZnAL1haSCBY20jzGfeJvon6TR3GicRY+LhsHOOZmcSvAu4XZuXJHlg7o7hCBoGpNvKKDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BVtdJa2x; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0p+doLfs39d2b3IkVOAP3bCqKJ+Ui+CgdP7J+TbE2VbPuya1uDrytlwXaZsfE+En/d4IqjwKGaZg4RyXEUtjOLqK7NTGXBR1c9PEdHeHZH9JuYWz4zz91yyzbIHOv83BqiN5Sz7ogJgQZtcPNATQqQ2PFGR08gBNci2mfcvWKDZspFgBtm1gzbjZfmYaQxkDP+nwuhL6M6lPvLUFtGgQrhtYqrIMpsbdm+aFP5vYaq03fXjYElt2WbxPZBZ4KxXpkMK1E/r5mTl5pY5IIlDTQUUoycFxqB2BnUWm5/3c265XPG0cEfWgMOPXMSRNNfoLtWt1lxP0G7J3zoVJuk5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAwTHeHNyZCpTDhFnotyNc+CeKzGyyuhrM0abkePf9A=;
 b=q4JfQM5rP77Ajd0h3kNRTbcfUniKFlMG4baS36pu6lBtzOdfDz64ZEYXkzTNZvsuKA38SAAaSRBLCyIEH8SJkIcdP2DPqcAP0HM+Atx/Y+gEMskNTJ03EMcNPmaLRMRvWHOqncGMNX6KicbOCixMDwnQZe4+8me4IoUNw/bYvST4I97oKhdWL75lSnyDWZVKBjGoj9DOUzZ3neU3J/mnwGBrNzlDEtynwQr2bEMizSrsL/eEDf4eoOdCmSYW2deVWZshVeXPlWMAZx4ePVStbf+OE4I4Tof6dC1kSXoomNmbbYGDYrAVN4JQDLT0Iiybv4+aWlRs/KRQI5SejtRwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAwTHeHNyZCpTDhFnotyNc+CeKzGyyuhrM0abkePf9A=;
 b=BVtdJa2xf1Jz0wdvlPP7wubFctg6T1h1uzpbTSgZiec6LtCdx/Xj8ynRQSVcnl15SgBfkNei4Q3sdr9QPnYBEhN2EWptyjCx3TSUdnGaK3yiuiMqD4RbQ2lWQ9LjNSMTwQnZ2BzD1OOYXdYQ408/m8fJiHLQFVgQwG4u8xOMIweVVTV0lrphv6Oox4ZVb63yOqqiCUyNCaV7hTpgx7OWOQrKLIfDj5a0GbBOy970BJSGC9oOOencbm0FfiVm8Y6vqBEmXBh9GAk9UGn2ri4ZvarGcYt1mUa2cT2tI+/KtDQH1ClenOyfWTL3tscue+ydxUWV90/gMc/mHb0b12w8Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 13:01:24 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 13:01:24 +0000
Message-ID: <cf4e70e4-9fe5-4697-8744-8c12c41b5ff9@nvidia.com>
Date: Thu, 1 May 2025 14:01:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] cpuidle: psci: Transition to the faux device
 interface
To: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-2-e6cc73f78478@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250318-plat2faux_dev-v2-2-e6cc73f78478@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0031.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::19)
 To SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: a71be6ab-3c76-4d0e-d7be-08dd88b04698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2t2eTh1YkdES2YxSzNJalEyYy9jaUJIUXAwcTlPWUgvekEvcEl4eGU4bStV?=
 =?utf-8?B?UUFYcVNpZ3hmZDM5UTNYaUV6UmNQMkRlMzkyY1BYdExQUHFVNE9oM1dZZGhY?=
 =?utf-8?B?MmdBamJtcVg0YTRIRWlRajRwWFR4L2lTdWpoNXFkVlZ6aWNLMTAvbWNzV0U5?=
 =?utf-8?B?TXg4ZjFocys1bmNBOVlZRU5oVUhUZGlwd3Z3UjlidUlvU3NpVitKekFscDZo?=
 =?utf-8?B?RFhrazExcTltN2hMU1lYbXR3MUt1TTkzeWE1QXZrdm9BT0JySUVHVFNRdUw1?=
 =?utf-8?B?SElxdTNISTZSWTNJYlRjVVIwNVQvRzMrRlV5dlRLeFM3TVVwU2F1TlNjeE9S?=
 =?utf-8?B?VW9mTVJ6eHBCTHVJQVcwclB3aENKVzVZZzJ4QTRWYyt1VDh3bEFoa1lMS01S?=
 =?utf-8?B?c1hvRWo5NHpqeE5aK255aFhPWmlzVFl4b1JYR2h3WXdEOGtSSHRWY3lnYWRF?=
 =?utf-8?B?dHRoSG1vVHVnN1JxRnRsWFBaTmR6SXdPSFZ4UDY0N2h4aVZneWRySHZWKzl6?=
 =?utf-8?B?eko2OW9IbnFTRk96aGxyZkFCa29ja3BjSWZxanc2dEZGb2JWVEU1Z096eHdW?=
 =?utf-8?B?c3MwemNnVHZSMk9KYlFHMFhPU21qcCtZNW1zek91OG5ZMVZNQ1JuZEd1aVV4?=
 =?utf-8?B?eHNjT2FrR0VzZjd5dmFrUVB0V3hmVyt4TWRIeGFjRGc1NUVjL1NqN1U2SVdq?=
 =?utf-8?B?eFR0UmNhOXlLdU9rN1JSYS83NFRBWkduVVJONHRLZHY3UlhGWXZPbFpDOVlj?=
 =?utf-8?B?VFJ2aHNSSlVJaWI5a29Pc0UyTnk4eXlaT3lOekdRY2lGWktpR09LdXFGMUdJ?=
 =?utf-8?B?UGFkWU5rN0x5cm5Nc3N3NWkrTEIwL0xVU2dkZWNKSHFHeTZNaTYvbUREek5s?=
 =?utf-8?B?NnBSVnh4OFhJM3BNYkhIeThOdlB4cDNaZXZXTzFuUU1zRkZSb2VYOEZCcEJp?=
 =?utf-8?B?ZForZ0QyUlE5RUVIRFhtdGlGeGVoS3h2aTh6L1RSNmtDTGxnODhBOHJuR1Bl?=
 =?utf-8?B?TTFSK1VTd3FzazRsR0k3VGhCaWNLSzJaVkVVYWFpeTN2RUY1dTQzL2tSd21z?=
 =?utf-8?B?eWozN1BxUEM4Y3pkUi9EN29jR2hXeVQvYU16U0hXMTRIeTlrSS94TTFIQno4?=
 =?utf-8?B?NGNuRmUvOGJvVFo3cGVHdjZVbG1pNGNYbEQwQXdrMUNISkVxNlp1TThjTlFh?=
 =?utf-8?B?OFBZQ0JpbzJGc0pwMjQxTktvdHhvamZCV1Z1UkE3WFhYa0c4TnlZcW5pM3ZB?=
 =?utf-8?B?Rmt4bGpCUERScUcwQWJnZTZNRHBZdG1Pbi8xdDBVbGw4Q0FGVm5lU3VML1Ax?=
 =?utf-8?B?aTQ2VTN4cTI1VVpJeEFVM01EZDM3VUFiUWw5UHdEY210L1hPYW5MQng2MVJi?=
 =?utf-8?B?c3A5TXB0dmhaeWUwTldPM2FhT0pBcENDM0syMWVOY2w2VjNCZFRMVmRiamx0?=
 =?utf-8?B?aVNhRW8va1h0eDQrOWlCWkZOTFhXRjYxWnVPaGRhZG1TanBSOUVoVXRLVEVk?=
 =?utf-8?B?UFJCRlUzbkJPZTFzYkxPT2p2bTNjS1NrQW5uUVd1NWNjZjdmVTdyWHJTWFRN?=
 =?utf-8?B?di9aL20yeWpKdFlPQVJ3amFKc2JNbys2L0w4TG0yZlRDc2lvR2NaMWlzM1R5?=
 =?utf-8?B?Sll0UkpxaldkT1RJUmtsU0QrcHhmeitPQmgybVVmQ2dZYldVS0tZb2JGTmk3?=
 =?utf-8?B?R21YU1BaRit5L1czTXhOengvZXJIWTR4ajgwN1NhZUVQc0tDaWpUdldJWU53?=
 =?utf-8?B?Vk4wTHplcVFDQVB5QU5GYW5PY3JvTFdPc1g0Z1M1LzBnUXpjUUdMZkJTRUdK?=
 =?utf-8?B?a1FkS1VjMXF4dDljT0N2WEErckNyUDZuWVAwVHp1YmxMU2JMNWxucmpMNnFX?=
 =?utf-8?B?bXp3S1VNMG1YSkw3OFpEVU5UTUtLRUliZ1dQNE5OaDd2MU0rZWRlc01XUlJD?=
 =?utf-8?Q?WLNlKE/JyoA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzcrYXU2ejN4ZG5TaGErNnpEVHJPWUVtdjgwY0ppU0l5MFowNjN0T0taN3dN?=
 =?utf-8?B?cTlVaU5GS1BHMmNJM1poN0grYkttbUFyZ2l6d0YxUkxxZHdva2Rmd2NLQUNs?=
 =?utf-8?B?dytVQk5wMlBqQzJ6SDk4UVpyU0xibDhJSllzanNuR29pazgzUTBQb2hwYUcv?=
 =?utf-8?B?NHVSRmVybGExeDlJSUdET3grc1MvM3FUa1d1Q0FvVm12U0lZYTlFY1ltWW9X?=
 =?utf-8?B?QWRnQzBMR0tyZEdsL2lnWFlacktOZkNXd0FLeFk1RkVhRWxubEhiSWlRZity?=
 =?utf-8?B?V1dZQUlqL1FGMklHaExmeDA5cEd0aElTWElXT1NaQVhWYXBOWVZLczJ0S0Fi?=
 =?utf-8?B?WjhHWnRSY0tIYVNsQkFESHk2MkZnL3krVnR0QjJJTGhMaGdPdGVNVW51WEtQ?=
 =?utf-8?B?c3VyZG1KRnQzMWJRN01SQksyMFg3OFVweEhwVjFBV3hBR2xPTUxsaDBwZjhI?=
 =?utf-8?B?L2ltUzh2ZVZ3ellOSDdWNGZXUFJyOHNWWDZKeUxuT2VWWFlxQklxV0hiOG1T?=
 =?utf-8?B?SVZkQkU1QXV5WHE5Ri94ZEs0MFI4aU12L0l3QkFySFpDM3F3VUVpSktnTVBs?=
 =?utf-8?B?Wk0zcWdJNHFRVDhVcm9sSWhnOHh5a0RPYzVTTFlCb0ZXRmVqeitpZ2JrUlNj?=
 =?utf-8?B?NmViTmVZdjc0N1FUT3haVUZrMWcyMkVaK3lFK1JCL3lKMlNUbkRBbzhpMUdJ?=
 =?utf-8?B?RUxMWGJpOWlIdjdDK0JTYzM3UnNjTHIzUzFQekViaG1DWnJVRytkUnd1bWJp?=
 =?utf-8?B?ZjlaU1B4VUtEblpMci9HeUhZekJkOEZkWThvWDR1bHh1TmExbDd3WEk3UmlF?=
 =?utf-8?B?bUJhcXFOem4xRS9kWDRVOThrNlhxeHE5MkFxekNRNlRKZWFXSkZGWGdVNi9k?=
 =?utf-8?B?VEtqdWRtUWxka283d3VpZXAwUWM0eStKVXBzYncySDVTSU93UTlhVjd1MUN2?=
 =?utf-8?B?VExUSTV6WG5tODNlWlZEZ28zYmszOE84SlZVditsaTR0aTkvODYzaVpvc0c1?=
 =?utf-8?B?OCtCOGlYSktXVTQ0dFpOa1lzamNEUzNHZTdmRDBMUW9wVWRITGxzVlBwZ1M3?=
 =?utf-8?B?QkI5T1d2ZHpDUGhUUUQxaWI1UmdwcnllOEFZTW96Tyt3cTluREhCY296VG9N?=
 =?utf-8?B?MnMwRkJkVDJ6UmRmYWFMKzk0VUYrRzg1TFNLUHhHSFNubFZDUUs3a2pERHhS?=
 =?utf-8?B?YkVER2I0aWlkRmF6MXFzUHRPeHNjUzVoQkVxaWhoZENtL3Zxd0hGZnVhNVlG?=
 =?utf-8?B?U0t0ZGRlU244NDRPMlRQb000citYdWZGaFZLeWRVbHZ3QlRSNi9GVzNsSEpO?=
 =?utf-8?B?aDBaV09pQmdPWUNZbnBzamZIKzJlNkliaUk1TUVTenRhdVBwR3lDT091cXQ4?=
 =?utf-8?B?SjAwQWJPVXZsNnp5MUhnOWtBcXRjMWY3NkkyKzdkMzJBaCs2Y2RPSUpwTWhs?=
 =?utf-8?B?eHpHTk1oSTNnODY5a0hTRitEYk1kSUxmam9LMEtwaHN2aVVOV3J3VW1NNm5l?=
 =?utf-8?B?QXEvdmE0cDFHZmIzQmtwZFMvdE40UnlDdUR4ZllGSUhwUkM0RGltTzI2bTBl?=
 =?utf-8?B?emxPN2VUQ0RMU2VVSCtZb0FjcTNiT3VRRUNhejJsWEh4NlZpNkswMy9SSE9a?=
 =?utf-8?B?MTJ2cE5WbGE5Z1plUHd1OVNKeUhtZ29BZmhBWEVyZlBpRS9sQ0hGMlRVVmN6?=
 =?utf-8?B?S1A5OXRlNmVWVGJjREo1TFpiYVFscHQzai9hMTlCZ0ZGK2RHYVF1akxiZjB4?=
 =?utf-8?B?Wms4QXJYWldib0M5cVcvZ1FPMVdONkl5aGJlUmpTc1FyZWUwS0lzWURMbG5a?=
 =?utf-8?B?RTQySVo1K0xqcks5d3diNTYrSG1pVEpIOFR1aHc5eUVsWnFrZzJqdldXNXRW?=
 =?utf-8?B?WTNLL2N4T3dDZllNSWMrNHd6dEdSSjlDZWZuUXF3bllyQ01kdkpyY1BrV0sx?=
 =?utf-8?B?NXoxMVhHUFRvbTBUckQ3aml4YUZWRFZWWDlQZTR1RjNIT0dBbjRRNSt4cnlK?=
 =?utf-8?B?ZjBLWmtOa0V1VTFFQVQyUi8wOWlZSDF5TldZNHhQUnNWL1Y3WjR4MmcrdW92?=
 =?utf-8?B?Znk5SUxydS9tMStpcGR2S3ZHZDJIb2R5OVZWaGhDZ2tuOVIzL2JPTTU3TWw1?=
 =?utf-8?Q?154hnNCQ8nO1hMdEo+8vK8QK/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71be6ab-3c76-4d0e-d7be-08dd88b04698
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 13:01:24.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCawFWufjzmSq6fKmYJrr5usKMNeC4monD3sJyL8p8FLMzbc94fSsOi/kXvPxft/r/nLHOKVpsTd78VgcWFSPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980

Hi Sudeep,

On 18/03/2025 17:01, Sudeep Holla wrote:
> The PSCI cpuidle driver does not require the creation of a platform
> device. Originally, this approach was chosen for simplicity when the
> driver was first implemented.
> 
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the driver to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will simplify the code, reducing its footprint
> while maintaining functionality.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/cpuidle/cpuidle-psci.c | 32 ++++----------------------------
>   1 file changed, 4 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 2562dc001fc1de69732ef28f383d2809262a3d96..5d4d6daed36d8540ba2ce3dc54a3180731b03d22 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -16,7 +16,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> -#include <linux/platform_device.h>
> +#include <linux/device/faux.h>
>   #include <linux/psci.h>
>   #include <linux/pm_domain.h>
>   #include <linux/pm_runtime.h>
> @@ -404,14 +404,14 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
>    * to register cpuidle driver then rollback to cancel all CPUs
>    * registration.
>    */
> -static int psci_cpuidle_probe(struct platform_device *pdev)
> +static int psci_cpuidle_probe(struct faux_device *fdev)
>   {
>   	int cpu, ret;
>   	struct cpuidle_driver *drv;
>   	struct cpuidle_device *dev;
>   
>   	for_each_possible_cpu(cpu) {
> -		ret = psci_idle_init_cpu(&pdev->dev, cpu);
> +		ret = psci_idle_init_cpu(&fdev->dev, cpu);
>   		if (ret)
>   			goto out_fail;
>   	}
> @@ -431,28 +431,4 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static struct platform_driver psci_cpuidle_driver = {
> -	.probe = psci_cpuidle_probe,
> -	.driver = {
> -		.name = "psci-cpuidle",
> -	},
> -};
> -
> -static int __init psci_idle_init(void)
> -{
> -	struct platform_device *pdev;
> -	int ret;
> -
> -	ret = platform_driver_register(&psci_cpuidle_driver);
> -	if (ret)
> -		return ret;
> -
> -	pdev = platform_device_register_simple("psci-cpuidle", -1, NULL, 0);
> -	if (IS_ERR(pdev)) {
> -		platform_driver_unregister(&psci_cpuidle_driver);
> -		return PTR_ERR(pdev);
> -	}
> -
> -	return 0;
> -}
> -device_initcall(psci_idle_init);
> +module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);
> 


I have noticed the following error messages on some of our Tegra devices ...

  ERR KERN faux psci-cpuidle: probe did not succeed, tearing down the device
  ERR KERN CPUidle PSCI: Failed to create psci-cpuidle device

I had a quick look at this and this occurs because of the following code 
in the probe cpuidle-psci driver ...

         /*
          * If no DT idle states are detected (ret == 0) let the driver
          * initialization fail accordingly since there is no reason to
          * initialize the idle driver if only wfi is supported, the
          * default archictectural back-end already executes wfi
          * on idle entry.
          */
         ret = dt_init_idle_driver(drv, psci_idle_state_match, 1);
         if (ret <= 0)
                 return ret ? : -ENODEV;


So although it could be argued that the error message is valid, I am not 
sure if there is anything that mandates that we need to have the 
idle-states present.

We are always checking for new kernel errors and so if something new 
occurs, I am trying to figure out what is the correct way to fix. For 
this case I am not sure what is best.

Thanks
Jon

-- 
nvpublic


