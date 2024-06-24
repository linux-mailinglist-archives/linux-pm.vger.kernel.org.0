Return-Path: <linux-pm+bounces-9916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E384915910
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 23:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613451C222B2
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D5813D53B;
	Mon, 24 Jun 2024 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eAGA3wji"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4672381B1
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264684; cv=fail; b=HgsG2a+s352U70uCC1V5/510hC2fz9fcjTZH2iIL5CsQ4HZb8ko13CvVM7+dRjy9rJ06TAvfzXX3xLF9JBfj/F0q7DZlvsy5S881iR9pXxsW7rKHaHldGGFWIF/Fgp5ltzAu0JJO1sCYHHrf5R6mpvSZS97LsQc3kc+dwUd2puI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264684; c=relaxed/simple;
	bh=89GwcmDlYdsDbgyWr1p1kY3y3GB+w6OZVNbpjyYTLDI=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=H3Y4DNx19JxT3R2bINsN4oM5i6imjp3MzqWlh2Pe5MQKPuC30rmutJqZfKjjncVEETwmCrnqxxfY1ZyE7u+t/v9OHTgzdey24XirEv62ylGMj3MaB9Bld/zGAb7rbRNuRcJN2xARzboPwPGOcUo5PtKDYRm/IB5QZJ9aDIskmNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eAGA3wji; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7vQwMMLeQ7lcWSBYxv7pZgAGq+7/m6qRA31scgAXs3s3aCs5AO8t7oireIHquznhvcmIrUku76daljA/w6qC/pg0sorCNqiYNGLRdtMmSQt3xawd6a0fnukBOjHPV5YuqLQ+VZej8AXyfHVoGq0Ub3iFjP6phdyrUPFKfknd7ItWkumZOI8D/w1+wc933DjLRNdbjTQUI2BLf0qDjfsLErSrEkvufIYU8nP4m8Ocdd2j9ND7dLEV+rY0nkkesOUoSkgdD8dMcIcF/3wB0+6H9ggzs2atpHBuBGsc3z5bn/qK+z7ITRJBxlkH6bQXsGgwpnIbDbqFctcSxFIHAlWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY9AMqEe05G/gwHTih2Yb/c+B/DGaaLrCp4k0vjC//U=;
 b=kqVdj/tA3u9dyoLELUCunoa8HUF6ckOX1piK2NzqUEe01SbOY8pGD3Wor3Cy/Yq0T5VaOy4URWqPNtuSfxGbcLL9umi6VEBOnLXCzxmeRhBDaFNDmGKTY5gK3io8rZq6aZWc3AUfjVv7lpbqpSAKJNVcMQu1n/VXHYpFKbkaVlxDEjDkTBQCBwOmN9IYGxGKNVIEAdooUgWyx1GLDlelxfR4josgfE+xssP6Vh/TpoABCORp/dHERQ1VtF2gemlT+V/mNig2I2fy5vLluecboVytjEl9Czt/cPHWa8otNHcFNg7UQCqp9nUbh1bjF75RreWn1dREWjwW3ZJoz71CnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY9AMqEe05G/gwHTih2Yb/c+B/DGaaLrCp4k0vjC//U=;
 b=eAGA3wjim7XPyk5FOr+NjW3BXmDbl2zx3x+OzsOLmQdvoujZwBvxw/DccNq4Odjh6LbwmP/T/y1dNIfdfRWZtMBPrEd/C0dSxQ4wOXNq6Z/spAHf9DFFEF7iUhD96dTgPl0BXDLaVkxK3njZUv7YuLSsIiF0fr/KoWmAkgDyJWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 21:31:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 21:31:19 +0000
Message-ID: <111b995d-b99e-416e-85a9-39c144c8b23c@amd.com>
Date: Mon, 24 Jun 2024 16:31:17 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Second set of amd-pstate changes for 6.11
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: db58e96b-14a9-4a07-1644-08dc9494fc88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHdoL2FGMU1uZGRQeEhFcUtlSDJ1Q0ZxZVFablZMd3VPSWw3RnJCVFE2bklV?=
 =?utf-8?B?cTcwS0tTUys2ajlVWWJPS0JmdnN6cDQ2TUhtM29lbmJ0YS95TitwSG5KeURy?=
 =?utf-8?B?dGx1d0RKOXJadEk0M2VCZjhVbFhaUGdrNGlqRjhJdmtwWGtIN2dmNGozUW9D?=
 =?utf-8?B?WmlBcWtQL0NUTmFPZnRvR1NRZmdKd25OT0NYc0pxRTdXcHNVWGVPVGtaSEV0?=
 =?utf-8?B?alQxVGJkTVlBL0pTWVozQkJMS3Y2SDNYN29FUFA2UGgxZnRHQU5ESFlhL0Vz?=
 =?utf-8?B?M1MvaDVXellkeFhUcVBpUmhhaHY1eUd6anpPcjJ5eXEvRzdVRXF3VWVFNWNC?=
 =?utf-8?B?SFNnVjlCYVdYMjFZMThNTUY1cWVqOFhabVhCalFLMFU0K1F3ejFmaGlkSlZW?=
 =?utf-8?B?YUNzNXQ1N1RtaENOcHBObXhiWnRZY09XaTB0QmxSZkFEK0oyUHBmeDcvcVA5?=
 =?utf-8?B?SXAreWZGS0t6QzdFQVRka0RaVk8xR2cxSGVRNWx4REJMZDJEVVRpNytpT2tL?=
 =?utf-8?B?UG9jV0NkM003MEI1eUszR1NBQXJYVzRtNnRNSkNQclZTemRKcitLZVd6SVdC?=
 =?utf-8?B?RCtNbDVKQlQ1WXRXQ3cxS1NFVmI3emhKbzJpZitSU0lRUlFHQWgwaHhVNC83?=
 =?utf-8?B?bnUzWFB4bHp4UjVqcGdLN2ROeVFCTEZJZEt5K00zU3VIaTRGbFJGdXFFTVdQ?=
 =?utf-8?B?eWVrNlE1aGlTaTBBUlhSdFdIdkFZRGxyK1p0TnEwZ2xWaTdjR3pHaExtQ0Zz?=
 =?utf-8?B?TUNBU2VxNTBKL0lzR080dndRTm1lYURkc2RXOHdkTkQxTHkrcVFxUHFFN2ZV?=
 =?utf-8?B?RUdaRytOWVdSc1BmdlM0c3JndG05TUxkZHhvbnBBZDZyNWF2TmJLRld2MUFt?=
 =?utf-8?B?SXhjZnp6K2owTDU2aTJKTG53OXY2NWRraGNXekthQ1dqeFVnNTBLZExTOWt0?=
 =?utf-8?B?dHRUNENGc3hISk1HdXVKZTI3RjF4dGJRYTF4ckVhemh5V2MzUkNiWlh0bURa?=
 =?utf-8?B?bkVSbDI4eHVadEtYSHFFTjhHMW5KUWR0SHkzL3BXRFlISFYwbGZPbDVXSHRM?=
 =?utf-8?B?bVo2S3N4Nk8vMzdxSmVMTWp4UWpsSUM3eHRrOW1wVzd3RzgxYUVVYWdqUDRn?=
 =?utf-8?B?a3ZFT0tkd3VpTXgxc054eVN3UjFKRXZ5a1lGWjhmMXNvcUxTOFlzQzhVTE1E?=
 =?utf-8?B?V0dSVzlmNERjNHdXa1hSSTBUeWpTUEhuZEhkRlR5STJDaUdrUURhMlVqT0V6?=
 =?utf-8?B?Yjdqb1JScXR0UEdzNjBRVzZQYkEzMWlRRW5vQ21BMmk4ZWQxNGFqbmR0M3I3?=
 =?utf-8?B?YmdwVFBBV2IzeXcyK3ZKSGl2U3VlUVp0NmJYaEVQWjVaUkZIYWdtdU9kdTl0?=
 =?utf-8?B?WGJZNFc4ekZtd1BJR0tVeUMrak1PaTJwUXgwTnNySnRGYWlEOEdWaFc1dUNs?=
 =?utf-8?B?SXJzQ05ER05TRUlROUlPN3VxM2R0ZDMzY1dIalh3YytnMCttR2JKZ0FVQklh?=
 =?utf-8?B?QmdKaS9CQTlPYzlIeUR3eVFmUjMvbU91bVJsd3VTVTdGcFVqSEQyQ2xrREN5?=
 =?utf-8?B?TGhyeUZMZ0tKSG5FSjhYVzJHZEVNN2x1RzVyT2RleDFvaStwY0pvV2hGdDk1?=
 =?utf-8?B?NGNXMFFnNDBtemZGNVhOTVlET3Yzd2xXekdOV0xYbzdPR0ZTMnRkdHlKR0U4?=
 =?utf-8?B?NEJ5bnk5Z0dRakZoWEY2blpaMm1tVWZjTWxTaXpFSm4vYk9OWFJTWDV2WCt4?=
 =?utf-8?Q?WKnr0fCOkvIdeowGwrvN74d9e2bSnbC3hbzPhWT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHc1eTlRWGQ1STlIZG1YUFpLd2IzWC93c1J1ekJHWWkzcDlRM2NoV0dQUXhZ?=
 =?utf-8?B?SDRtNmpsU1RQbDRwNHliT0FGWlZSYU45WW9tYmxaWWRUVFpxcVRZUUZMM0l5?=
 =?utf-8?B?K0hPUjJrbG1OYU0zbkx0bkhtZWRKTFR4Uy9weFcybjFWUnlEMVI2WUJ0TVVy?=
 =?utf-8?B?MndTVUZpR0hqeWxjOVdkTHliVHhpUGYxM2RkRlJJYU9oRFhNQ3pVODZxT25N?=
 =?utf-8?B?VitIK0lrMml3SkgrZTB3UWs5NXV2czZKM1FYWDcxMGR3NHlxZTJ4ZEJtOXdl?=
 =?utf-8?B?V20zbEZ6OElJa21PeXBUbWNiZ0lYNEdoMFNGV3BLRlpHSy9qYlJkVG5wMHk2?=
 =?utf-8?B?cUxQM1owWmVRVVBpTVFPUTBQcXYzQm5JSlpRdEZnTmRKNU1tYmxybVZ1ZjNL?=
 =?utf-8?B?V2sybzA5Tkx5WVA2TlppSU4xcHNuamo2c0xKVWRkR0xOS0hnQ2xIV2xRdmRM?=
 =?utf-8?B?QW1xMjMzaGtjaEUyQlBRVXh1Wk1YaVlIaHNLQ2pMNFNTMXhyTlJsaWxOeG1L?=
 =?utf-8?B?Q3orNzltM05oNzJ5cDRRM0hZd25iNUQ5NHN3UGEzUVYwdEg2TFdEdTJFTnh1?=
 =?utf-8?B?RVhndVBYUmE2dmVDNXl1UVZTNUpheitZZjAvMk1lNkpkV0VzRnQ2VUFzZ21Y?=
 =?utf-8?B?ODhwMDV3RzYzR1pJZFVOZHcrZThVN2tLMGNEc3cxTkJva3hoOXg0SElYRzFr?=
 =?utf-8?B?bWt4cVMyQXFydjlNWXRvVjEwNXVEaGRSRWRIMXU3Umx2emhySmRoKzVST1J2?=
 =?utf-8?B?YnZRMGdVWlhIcE1xNVR3cTdwNzdqRnNEQzBXMjdGRE11YWNuVG5lOUJuQWZJ?=
 =?utf-8?B?bHorR0o1L2RKL0x5UnNtSVhwb0w1K2piOGczb2pUT0NmVjYybjhkbTFsUmdG?=
 =?utf-8?B?dElVdERLWGxFRUI4NjBUU3FJTXlHTmFUTUdhcDVzT0ltOG1ieVY0MUg2Y0Y5?=
 =?utf-8?B?SHFmMUhHdk92dVhwdlJiUjhqaTJxcis0YWNKZkRVcHdXYmxBY2w5L0pjYjZ1?=
 =?utf-8?B?cVdDQ2NBeFRzTnVBVENyczNta3JIL3J3Z3BwRm53M3ltN0g0QVk4ekRXZHdF?=
 =?utf-8?B?WE9jNGVwUTh3TUIyUW0yMHVPc2ZuQW9aMWxBcStEY1BGb2tpcjZUclpDMDk0?=
 =?utf-8?B?bVYzcWFudEh1ZUZnZlQvS250UTlaWC9DQnZIYUJ6UWl0cVpxMnN1dERXSDlC?=
 =?utf-8?B?ejZTYmRvRkhZWlNJUWVFZEdCOEZkdVVDZElyUjRSUU5FZUpjdVVTSmNBU3Q5?=
 =?utf-8?B?eE5CczhMZURkSWRVT3JYMWw4SkhkdHFIZldxVE5nUGdSK2pzRnhJM2hYMXZz?=
 =?utf-8?B?bzZka2x0aWdBWDUxcjBZNDB2bytUNmk3S0x2cms5VWJRT3d6YU1SYm1ZRFNz?=
 =?utf-8?B?ZVh5UlNJNERpeXVHaVhhNXNSVnYrd1NiZCtwNTJEOTFVdWJQVkl5N2QyeGgr?=
 =?utf-8?B?RTdrMUZScURyYmJUMFlyWFZ0TzhncWtjemJCVVZrcFVwRXVPd2hma3ZLbnNn?=
 =?utf-8?B?K0xYUkJJZzhxR2VGYmR5MG1lb1hVRWlGUENZYkhNWExybmxLYzd1VmJyL1g4?=
 =?utf-8?B?K3RtTkNZclNPdXVHYkZCT2tNV2RIWEJOUnRSdGhoVFc3ZG45bCtyWkpvQjhw?=
 =?utf-8?B?L3BPMG1rVnY3SHVZOVFoWmVSckJQN0VPcnlBbHN6SUpLSmpXZUt5WVNpeU40?=
 =?utf-8?B?TTFkWE9LblhGSmpUcUNiRkZoZ0xYaDNpNVhMVVFCY3Z4RmlEdXVpSS9ZL0JB?=
 =?utf-8?B?dlJ6a2dWSUIrWXdoTUs1UDNRRUxYVnFLMURlSnd1T05QYmxnTUZyUDYwdXNq?=
 =?utf-8?B?Z3FtNWZ2VlBoWDdHYkw5VlBoc011b3FZMllZRFN3VWpNRWdvd2ZZRnVTNUc5?=
 =?utf-8?B?a2krNWoxVXpMRGp4SG9DRVBIeUV5RVpGSGpWV3E2cXd1emhYb1FwV05IeTdT?=
 =?utf-8?B?SnFNakV5VlcvRUwxNTJ3ZXhTYmo3ZHJTWkFWMklTRFlxWU9zeGZvMUxTYk1S?=
 =?utf-8?B?SThXc01LOTBiTDkwSVYwN1hOdEMxcUxvOUM2eks1MUZEcmVFMGlTMmIxcDZZ?=
 =?utf-8?B?QkJheWZSalJ2MlF2a0IvRVRscWVJSk8rcnBhMlhSOXhpRldvcmhkWit2VDRz?=
 =?utf-8?Q?mrMEe28N8OZ15oF0r2+Hg/v6t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db58e96b-14a9-4a07-1644-08dc9494fc88
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:31:19.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4BwGXmPDvyTNeyKIlcKZR5TGWDa9SxUFQGWwIGFyUx/FEBUbcWuspk06iQQtGW3hGv7yRf7ajA1ndPd5JWt+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647

The following changes since commit c00d476cbcef4cbcf0c7db8944df7e98a36bdbfa:

   cpufreq: amd-pstate: change cpu freq transition delay for some models 
(2024-06-11 16:12:12 -0500)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.11-2024-06-24
 
                                                                     for 
you to fetch changes up to 2240d3e60bb3e7a00422596412d012aeb54c1573:

   cpufreq: simplify boolean parsing with kstrtobool in store function 
(2024-06-24 16:16:16 -0500)

----------------------------------------------------------------
The second round of changes for amd-pstate in 6.11:
* Enables amd-pstate by default in "shared memory" designs without a 
dedicated MSR.
* Adds extra infrastructure for debugging problems.
* Bug fixes found for init/unload failure
 
 
----------------------------------------------------------------
Mario Limonciello (3):
       cpufreq: amd-pstate: Allow users to write 'default' EPP string
       cpufreq: amd-pstate: Make amd-pstate unit tests depend on amd-pstate
       cpufreq: amd-pstate: Don't create attributes when registration fails

Meng Li (1):
       cpufreq/amd-pstate: fix setting policy current frequency value

Perry Yuan (9):
       cpufreq: amd-pstate: optimize the initial frequency values 
verification
       cpufreq: amd-pstate: remove unused variable nominal_freq
       cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
       cpufreq: amd-pstate: add debug message while CPPC is supported 
and disabled by SBIOS
       Documentation: PM: amd-pstate: add guided mode to the Operation mode
       cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
       cpufreq: amd-pstate: enable shared memory type CPPC by default
       cpufreq: amd-pstate: auto-load pstate driver by default
       cpufreq: simplify boolean parsing with kstrtobool in store function

  Documentation/admin-guide/pm/amd-pstate.rst |   2 +-
  drivers/cpufreq/Kconfig.x86                 |   1 +
  drivers/cpufreq/amd-pstate.c                | 176 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------
  drivers/cpufreq/amd-pstate.h                |   1 +
  drivers/cpufreq/cpufreq.c                   |  11 +++---
  5 files changed, 122 insertions(+), 69 deletions(-)

