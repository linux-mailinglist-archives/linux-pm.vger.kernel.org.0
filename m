Return-Path: <linux-pm+bounces-22387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661ADA3B1B5
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 07:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F28F7A3FE9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 06:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD81BB6BC;
	Wed, 19 Feb 2025 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nqf4Qmuy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C64C6D;
	Wed, 19 Feb 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739947090; cv=fail; b=nIahtiOV/0wRSY+zbCRaGNMCmw43Vxl0cqARh+0ErAJwwwJcRP4zZIRWGLxNjcar7DeRE+hUO/M3wMgPta0ztaOqqn+VPOJNpKBP/2XfUu4WaB3xtc4W/rNzzrKgtsw9KKC5N4jqrZxMOA0hsK6+xUFB1KPh1t/6Dv12xa8Bqtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739947090; c=relaxed/simple;
	bh=GMEY9n16H4dF/nmq0zzkjapVhDVbjxPYznWxamPkW+U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+fvJn394aWF7VnMM0C/JPN7ZuA0gdF72OXUcCEH1Unm1HrD2eF0rAtBR2MT9ql7bqGxrtMIU28npWZj4DneYyUwgVGZKY93+gcTe61H5k688W6or0q0ne5zqIvSnNdCYleN6taqlOUzyQl4zALOv7fRpC8HkJD48UDCm8t4lBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nqf4Qmuy; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/4fK+lAwABwDuTaFJ+9Wxn6kYev/w695kP+Kj9Xi07DAdoJeiY1fdO8FHciUz5PY6wAENnrKxOwwHikXiaLwSgwjaGW+POxzdabPc12i2A8v8Fxw5/FuA38lp7MpUTDXxdRno+rF5KShY+b753b3HTPYdPHRz2L13LfYDZh0XBzFVflXpuWRc7V4EZ9buhsUnIj7U6g/OV1rugGxqcVsr5X/DWZ1MItZ0AmeWCcM/LVkD+5XeHJUikMCxINQbWcvKMlDFH58nddUl5yyanSaIJ5Ot2EFE2zq1T4KMA1qsGgD1dKkZxcQORS3DX7uHK3bEN7Muu5BTlDGuwkRPEdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOlS3key9p4Gwciu2IFxGKN95cibDtzy9PvQVltO1LM=;
 b=BcwfIxCQQkb274uhFUXoFcu3o7O1W2JXYYiYllp70PjJqq4DN8DTGO4rNKqyROMiQJJihqr7YbrNOaKIfdCMuBeZYm1Ola7N/f1smf8JPFpLvgEB97H4EYdCp80M3SmrE2r9i9GSnGeMhDzOcO1RSwvIcEvW6V5MKdGWHf4BSoEvPCT8baDjeS578iu8hKx/36zQn8nweHmWFil28cRRsQphXenwd62oxRSIQRq8uXM3R7iPaRDjKcLgXFQVl4FZANqiqIqYXQ1Fb9iSiKn9R8e8KDXWciMwFXsEDvUd2SMklw+uIAwjbQqVmIeoDBdF9YjOaRuCGnu3v9tDToL0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOlS3key9p4Gwciu2IFxGKN95cibDtzy9PvQVltO1LM=;
 b=Nqf4Qmuy3vZhHbPQd3LdoE7YPM9DW5jHV1PNmEBTXRIUObpVWPyV5gSXezd/sb9nJr3C/kwhfaHXcELYNk3khMeDD1rFYVxM3EcfudjmVKKucK7x1ZCIJa5SBqdxtFtBCbXBwUGjdPuS3u+kHEE7ZQd2YcaO7UxwaU0iqfAVBVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 06:38:06 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 06:38:06 +0000
Message-ID: <2644833f-0cf7-4537-ac3a-45ddf1a8f5e7@amd.com>
Date: Wed, 19 Feb 2025 12:07:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/18] cpufreq/amd-pstate: Invalidate cppc_req_cached
 during suspend
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Miroslav Pavleski <miroslav@pavleski.net>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-2-superm1@kernel.org>
 <66c37c15-e655-4c1e-ba5f-70307a0c8b1a@amd.com>
Content-Language: en-US
In-Reply-To: <66c37c15-e655-4c1e-ba5f-70307a0c8b1a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::6) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 45251703-9c25-48a4-e525-08dd50aff790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alEzVU41ZXJYN2M5S3c5QWdoeE85VmtlakdlTGFjWTVrYWFhbXFNbVVXaW1m?=
 =?utf-8?B?REZhNWJzUzhOUGxCUjlKdkJwbURKQnhpNTU3cFljQ0dTTU0rNEc0WHpkR2hz?=
 =?utf-8?B?UDFGbDdhMTdTdWQ1Q2FSemFwRG1ibmloaC9mVndldXVJdHdWcDFCcXVXb1RX?=
 =?utf-8?B?MDBxM0lxSjRpcHpaQTBZYVpFNG9ZYkxsR0hSbFF5bGhwY3RPM0hpUWV6MHpT?=
 =?utf-8?B?VHluVml0YUFmNlJjQWxMT1Z2ek15RWtmSDllYW8rSElMZVdQejVuKy8zM2cy?=
 =?utf-8?B?dmNvdldhYzJwdWtQa2pndXh1UDRyMmJlcFpvMU40RmRrSVZYZ1kxbUlKbElY?=
 =?utf-8?B?aVNsNXlyMFBTUXZESTJkb2VuWVJnM0RxcVJjUWVrZVlCazJMK25VcHNwRmwy?=
 =?utf-8?B?N3R3K21RNXFQeFB5ZmdnYjl2T1UxM1JjTVFNUmJHVnd5TWN0a2crNTd2dVdl?=
 =?utf-8?B?eVlHYlkwNTM3eDNSL0RUSWEvT2tOdjRvTlFzOThvSmtzbkVYY1A0Q0N2d05W?=
 =?utf-8?B?YVhESjIrN25rai9BbXFsTmFGbU55Z2JhSFhtc1kzSlQxZWFERU9TRVFtbWV1?=
 =?utf-8?B?aDdmQkRWek04Vk54QnhnaS9uNEFGc1ZSbHEycElhZzBjaXJkbjRNcDlRYnAw?=
 =?utf-8?B?VDJodUV4UEZBWGVXa2NuaWphUm85RWcxajF6dEUwVExGRXRXcTVyYi9QUW9L?=
 =?utf-8?B?LzZMaEluYU5VOTVjZ2RLYVM0WTBjZHRTYkZzS0VTSUc2dVdOSUFldEVTWEJk?=
 =?utf-8?B?UjNGZEVHODN5WTVmZy9heWRsTVZhMjUrQ3RRdlNkWnFyV0RUVEdOMG4zMjZB?=
 =?utf-8?B?RWpYN1hJYmt3N3J6aHVFeWV1NU9GTkJia0FYWENCRzVKTlFHbzAyQ2tnQkhL?=
 =?utf-8?B?WTRDQU1sUVlpbnJqOFozQ1lueDdRZVVYS3kxWXQrMGVjakF0c0gvL1UwcHE1?=
 =?utf-8?B?alZyRUcyUGlqZTgxN3hRLzdWYnpiNWZOQWF3bk1qcVdiRVVzd3l1VzdsaEFY?=
 =?utf-8?B?QlZ6UXA2U3JYTDFndmlNemVrRGFQQThzQ3FUQVVZeXhPRzJ1THNyNHFLMk5Q?=
 =?utf-8?B?V2sxV1loUWVPV0Fpdm4wckhJYW5qY1BMQUc4Y3JneURxd3k0TU10UFNkVkN5?=
 =?utf-8?B?L0FjSGFDME1YdDltV0VMeXdLTUVaT3ZsaGd6cFZwQTloNlRpU29DVGtHUlVV?=
 =?utf-8?B?S0FPRnA3WXVDSHg2YVljWFI4OWVGMDdEbHBzK3RMZ2NPNGwrSFRINnNLY0c1?=
 =?utf-8?B?OG8vSWdxUUFuREcvVFU3SUkzRHB2b0IzSCt0K005Y2cvalh2OEtjNmliSUJP?=
 =?utf-8?B?WDdLSXVPWlUyN3VJeDdTcWQway84Q0ZMWnl2VzVTazc2OWtSM0N5NnBCOHV0?=
 =?utf-8?B?NjdGb0plWkhsaVAwTXNDSkhXRTd5bXFtcUtTS1B5OGRadFRWVUZ5SGhoOHZ3?=
 =?utf-8?B?cERyZnN4M05SQ1FGbWdQRjVEald5U2JVYngwbXVQUWx0NEhYYytTS2hkVGlI?=
 =?utf-8?B?MU9NUXBKMk5NdU40YWp2YmRkKzU1KzJOcDJJSlhiMGZabXlxNWh5RUoyS05n?=
 =?utf-8?B?Sm5nMU9tQmF2RXFyUHhtVHVEV2FjVS9lazdDUHV1TTJPN0dwQXRXcVNlbUpm?=
 =?utf-8?B?NlhmcUYxQUZIbm56VnJ2NzZucDd2a2lFQVpPVkl4RE5LTUR2ekJ3blMvL1oz?=
 =?utf-8?B?MnNFNVROWU5Fam5KQ05mc3g3MnZhbHpmUmVMUnNMUVpPNGt0WGlhaVMzekUy?=
 =?utf-8?B?TUdKb2oyVFdZWVJ3VE8zOERzb28raWdZTzI5ZmJhSENaNG11NGcwblFkcER2?=
 =?utf-8?B?NDlCTkRtbGxqYVFxaDE4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnB5VHg0VzdKVmlJQ01tREJIRm1TajZQcVFlY1ZWdDV0d1QvVHZ6aHNFa1J5?=
 =?utf-8?B?dFpkL3pEOW43SEMra3ozZUNVWkQ3M3R4TGZUREJmU0liN0RtK2UraHFtUWl4?=
 =?utf-8?B?S2c3dXZjRUljNnc0NHcrWTJqRCtteGp1YUlwZXNJS001UFZpTHhkeVVrWkJt?=
 =?utf-8?B?bmlqZk5sK0dhL1hxakVlWXdHeU9GUVQzTGkvSWFaRnUzZDZTcnFBT1hEaDho?=
 =?utf-8?B?K0ZjajJ5Mmw3MzJEbUdMdUQ2MDRTdUhhS2c5MzdSbjI1NmtFZ3pqSFlTbFd5?=
 =?utf-8?B?SHI2b08rb0oxNlViTjRxM1NLRjl2K2VuQnEvajF5dXdsWFVJWG5pelMyalQw?=
 =?utf-8?B?UUdyRndJa2Zoc3d2M082L0lQQ0lUdWxiYW80WkF3RDBuK1Y2ZGpyZHRycExy?=
 =?utf-8?B?U0orNUxFdTVxQk9NUm5NZ1ZoaWF3SWZ4ZytwNUZGa2dsWnkwS2hqWmkxTDhH?=
 =?utf-8?B?QTdxNlJIOXdGTjJJV3o4UGdEeVk2UVdraElaMmd4VW5qRU5OZUhMZmpvSy9Q?=
 =?utf-8?B?UVBPOU1MVVk2Y3dNWWY4cW1GUXVVWjkwYlROZE51Q1ViV1BVeFpPOWZtZ0VT?=
 =?utf-8?B?YlE1b2oxa094MEY5b3duTXkwVFJibjluT0pMS0NhVTVjTzlrNFd1TXdoMGhQ?=
 =?utf-8?B?NFdNN1hRcm56ME1Kd0JoU0F6ZVFnTmlheG5Wa3BnK0hqRDh1bXVnTThvWXZn?=
 =?utf-8?B?YmY4THYrTEhROWk0ZUtLSnJ1MlN2QXlxeWgrcHZrb3JNMEJxMDFmM2xSd1hG?=
 =?utf-8?B?NEQxcHVha0hmTkNxSlp5aVQ0OFhFTFlZdjVGSDZRWEJBR290a2paYlBETStZ?=
 =?utf-8?B?MWNBZk9sL2NnRSt3RUNJYlRmOERnZTBHd1FHSXZ3d25udWhEK2RnWEE0a2Ru?=
 =?utf-8?B?cEUzWUlsTUlPN3AzK20wMUcwNU5HQjRFSjg5Ry9YSGFtMXpiek8xRVU0cGtR?=
 =?utf-8?B?Nlczakh5QmwycWdTNjJaWjJtaHp1Z3RlcW5DTFlTVjl4ZkVScnJYbG8wZ0pJ?=
 =?utf-8?B?MzllRkJaZW81ODZmMHJmOFQrSGQzQkNEVXAzRWtZMkpVT0RuRWJWaHU4Vk51?=
 =?utf-8?B?YnJKc1NoZUZWWkNhdUVRRUNZZlJsT01aWFBqWmUraXBld094bFFwUnFXVDZC?=
 =?utf-8?B?Kyt0RjAxTjZMeEZQdzJMd1hwZDRPR1hieG1oSE5ybCtUSUlkZHhpS2xiV0Jm?=
 =?utf-8?B?SkhKbGNaOFBmRGhjOUQrd0tQWmN2eFJzeldGeDY3Tk0yKzlPbk4xNzV3MGxl?=
 =?utf-8?B?SmpxOUtMWDVnQ1h3ZnFtcCtVL2hmQ1cvemhWL1NXZ1NvNndhREFMSUM2ZE9F?=
 =?utf-8?B?ZWtoT3djS0ErbkZxZlIvVHh6K1lCTGN4U2VTYVhrUGRWL05SU2JFd0tDZmFR?=
 =?utf-8?B?aFdnb2tHeFV4cURFVmhQME4ybjNla2ZZS21kYzlRR2ZEQTBpdnZic3ZIcXZj?=
 =?utf-8?B?Z051V2JQVGlaUTkyMGE5bVE2SUFkYzNtSFZtTHY3cXYzRzhDNW1ZSHRDeVd3?=
 =?utf-8?B?QlI5aUVZY0lyYVI1eWxvQ3d2M3hEWTliNDJnR3JPSmFOUHZrQkhjRi9pOFVy?=
 =?utf-8?B?RTFnREN6VHBEV1JtZFNXZlZORzNjTWtJeEhzS0FGUnBYV3F4M0dnWVdhQU5I?=
 =?utf-8?B?alVRb0UzRmlsa3Rkd0NMRFVnUmkvdjE4TGFWbk1SZDZKc2NuenFkRHRGY0xW?=
 =?utf-8?B?bWFEMUJ6YkZMSkpicmNjU2ZpL1VlVktaTEMwNngvcjREMFp5a0FtZGtIUXBj?=
 =?utf-8?B?U05QQW5WbFRqMS9RUHRTdjlhVTM5VlB3NUJnc2RFTHJVaHQybUNaOEYrQjFC?=
 =?utf-8?B?L2FnYXpYL0w4Ymwwd29Dek5WR0VxcjZkS09JU1hHVUZsOW5zLzIzbkFzMWZh?=
 =?utf-8?B?dkZGTVVjdCtKUXl0NlZUbk5VVHV2cllreHNrem5qeFlZY3p0d290NzExOGNa?=
 =?utf-8?B?ZFA2WFRuSVh4VEpmT2w1bVVrUWc3QXFzNUNTckIwcVBUcFZ2aEh1cTQwRmxS?=
 =?utf-8?B?K1hKTkZ6eWlQaVVXRFlGS3ptY3ZnT2szclBVZGU1cE1FWlJWc3ZRUXpGSEI4?=
 =?utf-8?B?SjltMWxBQ0xHSW5yZ0tTQjc2SXNkSy92UDVKelJ1WGpxWUUwbHNPdEF5Z24v?=
 =?utf-8?Q?Zw30cfyNgl5CnQILFjz7/YRiX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45251703-9c25-48a4-e525-08dd50aff790
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:38:06.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/ygs4tpZEV7YIVYnUl4IeoMcez5AHAHsBngT0jVGPEqxJBmdrarCYkBsM56o8Z+IlzximtIWljYhuuQYc4Z4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443

On 2/19/2025 11:42 AM, Dhananjay Ugwekar wrote:
> On 2/18/2025 3:36 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> During resume it's possible the firmware didn't restore the CPPC request MSR
>> but the kernel thinks the values line up. This leads to incorrect performance
>> after resume from suspend.
>>
>> To fix the issue invalidate the cached value at suspend. During resume use
>> the saved values programmed as cached limits.
>>
>> Reported-by: Miroslav Pavleski <miroslav@pavleski.net>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>  drivers/cpufreq/amd-pstate.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index f425fb7ec77d7..12fb63169a24c 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1611,7 +1611,7 @@ static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>>  					  max_perf, policy->boost_enabled);
>>  	}
>>  
>> -	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
>> +	return amd_pstate_epp_update_limit(policy);
> 
> Can we also add the check "if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)"
> in "amd_pstate_epp_update_limit()" before calling "amd_pstate_update_min_max_limit()". I think it would help in 
> avoiding some unnecessary calls to the update_min_max_limit() function.

You can ignore this, I see that you have handled it in the 3rd patch.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

> 
> Patch looks good to me otherwise.
> 
> Thanks,
> Dhananjay
> 
>>  }
>>  
>>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>> @@ -1660,6 +1660,9 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>>  	if (cppc_state != AMD_PSTATE_ACTIVE)
>>  		return 0;
>>  
>> +	/* invalidate to ensure it's rewritten during resume */
>> +	cpudata->cppc_req_cached = 0;
>> +
>>  	/* set this flag to avoid setting core offline*/
>>  	cpudata->suspended = true;
>>  
> 


