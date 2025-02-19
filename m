Return-Path: <linux-pm+bounces-22386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E21A3B181
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 07:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC91898880
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 06:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685B1B6D0F;
	Wed, 19 Feb 2025 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xfN42HXf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6B192B66;
	Wed, 19 Feb 2025 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739945686; cv=fail; b=C5lunnxFxfnGS+SBElyl+Exrvx8oYLlaZ2tY6Hn2DXzaAHFY0b5wV7QaIuspIYfLlIc0WVtLEBMrmWAqkekb7lZh5FhgWLo0JRB8KreIDodlkHT5eSBzod1NK/eOZWajuaLXwSOcLmANr8bierCxhHi/sC2LI7gqvKhStz/mnDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739945686; c=relaxed/simple;
	bh=23aFKc91xJXKbLUEudece32opRmYcmX8qRTzyBN/eRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eB6nxxDFVHyPlTPxS+kSAhlslkpdpf4G8NAcSKshuVwogvuff6S2dyRqcyc6BI5mlyms/bZHZKRhuP3nHGMYcD64xrPzwLXuZJhFIM24odL/6DgHCnQXMl3jz2dWUoEtWM2rOPLgyblgZKIjhasZW1QHlLa0LfP+VL8DeZ78BLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xfN42HXf; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeWkpukemboOkMsTd01WOVftgn9Ic+T3PWv3Ub7pv+7ZeOfBbtc4KBKxpYz1Okg2CDZ9CZrzmKcORHtSWEWSh5JdhDGB+0xvVb3SHcZCjCOr42hE0KeS+vka+9Flrb/ju2EZ2rBa0KBKc/LehBWr4O2G/FDHaHzzI2cb+b2DqYn9zrpyBCYzom6AJplKMTdVzSey3oAZ5tItOkBclF3+9tzJUQD1QwLNgliXv/spNy5Kq2TL8a2iuiI58wo1wMXrbdiqXCcudaFjGcJ6fJ8xhtNCbq5RKYTmc0YmJfLrkwic8QJEgSLYa9D9d2q6SPedXrO5HS1L3KnIb4Vz2d2ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNZ1YCb2i/owL7Dil8E18uU7/LY4d6UvVL6mKPsMjK8=;
 b=Fj3uU2FADlh+e02PAW6T2kfld+TEOn3rJDhJL3J6eur3TwyTuhGCdiE1i0fmGTKBa2we9SR6pn1NjrXJQMqRrolBmYMR7+hzS6D9bwMXUHkGJqmBcO4ktTvaMqJdzDN6aQpEB9HOvRIMs3YE6Tn/sgziXd9YJodJWOvT9MzsNirVQmlNe5s/ei12/9X7esKLRd/P76awGTwWTRTPjUEPGMKCEEHT15blocyq2MfQnRQCKfmMXI9V6orFV0ZoL0ZU9tBBkleqHaCJoinvAyHbT6WzWok699u0o0gYyY/oUeK1Ta6ho/lIW10fBQ1DR5Cm8+lTxv3AoYp2fZjb+Y15Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNZ1YCb2i/owL7Dil8E18uU7/LY4d6UvVL6mKPsMjK8=;
 b=xfN42HXfeW3p4cysupK3hF6vXTq1qPhJn9rsLiXssRWAtjOHNd7vcqWSWXGcsYIH5aHtaxqO9EfakiFbQNvoZQ6QJtkDtOAlDOQpDsg+uS+cHUxBUV/ZbCn1+gFVG39QN1Myv7DjNhAQTzU8x/zik8mVqHSTJ/NEx8ejErOI9ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 19 Feb
 2025 06:14:42 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 06:14:42 +0000
Message-ID: <0729eed3-4034-4744-baf3-ddee54be1f7f@amd.com>
Date: Wed, 19 Feb 2025 11:44:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/18] cpufreq/amd-pstate: Show a warning when a CPU
 fails to setup
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-3-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250217220707.1468365-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 93042d17-a82d-4df8-e94b-08dd50acb305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmc5WmE4Vlk0cytBc2JqYzk5RUh5YzZINXZBRi9Wa3VYclptWGs0Y3JqdStO?=
 =?utf-8?B?ZDF5dnE3WmRqM3RCY0N6cDNzWFdSQVkzSjgwbkI2bEdXMHJDTnBNUE91ZUJy?=
 =?utf-8?B?TkNlZTRjVEpackhnSjFSOFdyUkhxK2N3Ykx3M3lIKyttMmgrdy83NlhXYUNH?=
 =?utf-8?B?Zm9IeGVTTi9UVlE0T29iK3l2OUhhcy9mS0FtQUc0UHFVS0UweG53VmQ0a0Ro?=
 =?utf-8?B?U3MzYzE3K1FuR2NPckxPTkFmMWhuYkZLd09BS1lHYUZ2QlltUHJEZ0hoNXh2?=
 =?utf-8?B?eGN2WWl1N2tad0Qrck1ZQi9TNDV4bjdJVXVpY0RqL1VCYmE5RUZCZDJLY0tV?=
 =?utf-8?B?TzFzVlU4N1JSUXhTY3N1Vk5UbDhvNFB5YjQrcnlDSDU5VHZNb1pza1hIQmMv?=
 =?utf-8?B?d0QxcHdQSE4zQWFNWmdIU3B1WUdZR1dtUExtQTR2b1NMUUx2ZTVKNGYycDZO?=
 =?utf-8?B?OVRINjE4RGkvT2psS1RJVWdXa2Y2VjkxTVdIQ3NaTkwrUjRscXdUZFBJcG96?=
 =?utf-8?B?bVZ3OG5QVW9ZSUV0V3NKYVZYYlVNS0hOZmxhbTgvSTM3d2ttamRITFV5cmE3?=
 =?utf-8?B?QU90SjhpVWg1WFJJakF4cXJWVi94NGU1bm9lT0lQVGZjT3RNaERGMkZoZ09Z?=
 =?utf-8?B?Y2xSMjJUTVdDak1vN20yeG00VTZMUzNMcFpaTTU4SHFGWjdpQUZzdnkyM3Vj?=
 =?utf-8?B?eE1ESlpjWjhjMkZIaHRTMG10ZWFEVGZBVXkyZGNPc2tnWjNTRHNLOXVOVC9v?=
 =?utf-8?B?K3VmWFdCMm9SMURJRi9KVTNHSlFaTWNvSWNRbDV3ZXRGcC9WTDVIMDJlbzFQ?=
 =?utf-8?B?QmhOYXhjRmh1Y3pOOXpHNzcxZFduWisvM3ZzR21TWnVrT1REZHJycUlQb0FC?=
 =?utf-8?B?UHhIbHZHdjVIelVCSzA3MGVsL0wxcTVDMW1mRGxLRG4yOGo0SHBocVZkQm5G?=
 =?utf-8?B?cXpyKzVPM1hkNTVZazVVeWRWWUFtY0syYmIyM2NkSTdNVHBMWGRzSG9SQzlD?=
 =?utf-8?B?aXl3NnJLaUVxQldJL1F0b1NIaDRaOGF5M3BJTUdpWHlBSTJBYlRobTRRMXk5?=
 =?utf-8?B?SnFHQnpnczBzNjBQWDhJc0NKVUthemUvS2JVNWpweGUxR0d5S0IzaHlFbFJ2?=
 =?utf-8?B?ci9pQXdqQklxQ2c1YThSQXkveEMxRmppY3Y2alA1cDRaenoyREswMUlMNTdX?=
 =?utf-8?B?cXpKNXZyR3FmVzM3WUlGblJwN3p5RzJNemorMlJTZU1VbzNFazdJZWpHM1Ev?=
 =?utf-8?B?biswNllESW42UjdTTU1GdFE5YkQ0WUtBQUdxMjR3amprb2hranJzQk5nRzZ6?=
 =?utf-8?B?a1ZLV3RiSkRVUzg0WlJ5dGNaVlhwZHQ3VVJXczJYcWdYNzcxVlBTakptWTJC?=
 =?utf-8?B?U2ZKSlpzQ3kvV0JhMjBTTkVLNjRqckpEcVlVR3pqZFBpNmZkYzdZb0dPdEwx?=
 =?utf-8?B?bkltVWYzZHZwSUZvOGwzcXh2UmJFNTIvQ2hocGc2dE1kby9uRzlIUUlZOUFp?=
 =?utf-8?B?dUhSbStWSDAxbXhTNXI3YVBjN3dUcDRqbjdSYlJVYlFieHgreUlNeXNQUVo5?=
 =?utf-8?B?M3dEYkZQbVE5clhoTTRvVHlESUJUWHc4QXBYOUlNS1lnRUJlVDhFdGpkZzE2?=
 =?utf-8?B?K3cvS2RXWTliMm95dXFMWC9FOVR0aDZaL2hoRTZ1UW4vWEYrTnAwdFFOZzE1?=
 =?utf-8?B?NkM2MXdhRGJXejFmRHFMNzcyR0J0c3dnblp0Skd2ZVVMcWxiQUZmTlR1Uk5a?=
 =?utf-8?B?Tk9yT0Jlc1FydEE4bUgxSzUzWkp2TG5VQk5kK3R4WTlFMk8yNkJvQ1N5ZTFE?=
 =?utf-8?B?UmZtMk9zWnFQSmpQZmpHZVdrWVpHUmk1N1VLcW9wUUo2eFMxQTk3WGVTTHFG?=
 =?utf-8?Q?TBYFC6z7z9pOL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUFRNlZKY2llQk5YNkVWQ2pialZadzZ1NGtOSVliQTIxL2Y4ckpIcy9MVTNk?=
 =?utf-8?B?bTVQYWJJOGhHYTBxRmhMbXJBKzZIUkxlQ0JiVXpLdzZBSHU5SWc0RURDZDU5?=
 =?utf-8?B?U3JGcForRmhzdGcvMTNMWHF3SGVYYk53K3ViMm5Sc2NLaFIxejNYVUppU2Rw?=
 =?utf-8?B?cmo1RmhXeHdHcjdESlBKQnBRM3NLZnlueFB6dzV4RXovdjNvbDdTTm5jellY?=
 =?utf-8?B?M214Q1lqVUNKdHRTL2E1cnV0VDBRREFmZlRWOHBlbWhqUWVzV2dmRzZEc3RR?=
 =?utf-8?B?Yzh5eUpuNys2K3BYL2d0TkVhL01jMkcyQ05CTVhRN1ZxcXBoaXR3WU51dFJj?=
 =?utf-8?B?TlhLdGxoOXFaN3BWUG1DYzcreVI4Z2FWOWQ2U29UYjQwcVFhU0hMWGVvd3BU?=
 =?utf-8?B?Q0xSaU9FWmVsVXZqOGpUTHh1TFNmSUhXZ3lqVnZKZTY4UWNIUkRrNGo1N3Ar?=
 =?utf-8?B?S2JZMmxRdmZoTDVOU1BaR0FHSGZZQVNYeEVOS3NURGJad1VpQ0J2Tk1DdzVG?=
 =?utf-8?B?OUEvWmZpbU9zVWt1dHozQWNpcm53Nk12KzZ1T290R04rVFZKdURsbXl5ZUR6?=
 =?utf-8?B?dGJYRlQrUkxJWUVVTFBCYTRjUGFQNndQMHlsSTV0NktGdXVIcXA0K0FJWFVo?=
 =?utf-8?B?THNzejFyd0MrM1JtNG5LUW80MjJiOWtoMmszSW1TSUxwZUg0MDQ3QnNzdlZR?=
 =?utf-8?B?bzFsOFpncWZSTVpqMzNPbGlFWmRQZ3RxME1Dd252N0dsWmgrRTY4a1RkeE1t?=
 =?utf-8?B?VzRTNnBTT0tSSzFVWWpTdFRXSUdsc3F6UG9RTEJjbFFGQjlTOW9iTGQ1MVo3?=
 =?utf-8?B?Z29pQkVjQWhtUkJyT3l4NUhTTUJrdmdpNVp2MGQ4NlFFa0FEVjd6eE5uVytn?=
 =?utf-8?B?Yy9YdXJaVTRCL2ljbldDRHNrRTJ0TktuSEtIT3Y1eWxuMk9zbUVVWVJiekx1?=
 =?utf-8?B?dGdVdzRZNE1PblhwcUlLSFovS2hHek9QOXgxVTZ5MXdzbUU0dHcxWnNiVUhr?=
 =?utf-8?B?eCtuaUxteXBVQWtzNzl4WCtwRjk3NWFFazg5Nk5iNjkvZmxVaUVidWpkV1Vm?=
 =?utf-8?B?SlBFUDNkVkJGVEw4ZmVwd3c5Q1JQQlRVVHhlQWJQazZvUHY2NWdyUGhmRUVy?=
 =?utf-8?B?VlZqcG1ROStkdEZHdjlvZHIwbmM3OEFBOUhOVkxCVFkwdHlnY01mY0o2YXlJ?=
 =?utf-8?B?OWFHamYrTTZHc3lUbkhOd2hVMG5xY0JIWC9LMytXSzRuZVM3VjR1MzM2ZEpO?=
 =?utf-8?B?ak9XMVMvQjlyU3NwcWZObWU0SENObU9ORkFIbFpxY2FtR3JaMEllWG04WFYr?=
 =?utf-8?B?QWdOeFZBL0NlZzdQYnNGRE94RTB4L0pPcHp1cTV1RE5kVm1lMjFmZnBMdHR0?=
 =?utf-8?B?LzBCcDYyNjBaL2ZINVlGQk8rQmx1RUVTQkhpMFVRRVNOWld3d2c2b2xERkVi?=
 =?utf-8?B?TWFoazAyVU5Ca0laWDRhSFM5UFRiTndua2gvU3dxY3lHZ2JMYmNxSkorNk5y?=
 =?utf-8?B?Q01yQi9YVkFnZmMyci9JdEw0NnFadDY4c0k4a293UjZuRUNUaUV1NndiVVF1?=
 =?utf-8?B?MUxrWlNyOGpVNnloV0I2aU5wQS9vKzI4OC9mcEE1dEdOaHdqMjFpWkJ0MlZo?=
 =?utf-8?B?elM2ZSsvYUFEallEbnVtQnRUekh1bjB0c1NoOHRIUzkwdlh4RkJWME9ZVFMv?=
 =?utf-8?B?bHhwYmc5SFhmWjZwaE5zSTUvL2x5WkN3Y1hzSXhHaElrc28wZDRWVGxMbWpn?=
 =?utf-8?B?RkYrMnV5OTlDRGF4VzFEYjc1cXJYdklyaGdGNE4xbktjRmJBMzgwZzJ1YUJW?=
 =?utf-8?B?VldpZzNQTGt4d3VCekpmNW1yZ0F0YlVBTXg5czlCcitHNFFpZDJDRC9zbkZO?=
 =?utf-8?B?QndYRk9hVFhhZFFqdGVKNzl1UTNWbkJUd055QUNqQ2ZNTkNORDVONzA5NVdK?=
 =?utf-8?B?TStUSzd1YVZlTVdNcTRablZHWXB4bi9lbC84dG9RUXlwdXpxWjNLZU12anZ2?=
 =?utf-8?B?MDZ5a1ZXVGhkY3dDU0lqZlo1aWlOQkx1VWxjZG5tcERTZGRLYmprbGRZZzJF?=
 =?utf-8?B?YVd0TkFIQ3BmZUZrVFhJb3pQd2ZQd0FRV0ZPaUVZUVZyVjBkUk9aSTNGQUxZ?=
 =?utf-8?Q?4Ufp0fJnRQIelqYafz5xnYjza?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93042d17-a82d-4df8-e94b-08dd50acb305
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:14:42.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ltji47o/je8yFJdHIY5jVS+85LuAvV9iylusz6w6QTWH4QRJhFHwNlBQjFtlL4/t52rB1DRklF/1U5H6jaENZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456

On 2/18/2025 3:36 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
> populated.  This is an unexpected behavior that is most likely a
> BIOS bug. In the event it happens I'd like users to report bugs
> to properly root cause and get this fixed.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 12fb63169a24c..87c605348a3dc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1034,6 +1034,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  free_cpudata2:
>  	freq_qos_remove_request(&cpudata->req[0]);
>  free_cpudata1:
> +	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
>  	kfree(cpudata);
>  	return ret;
>  }
> @@ -1527,6 +1528,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	return 0;
>  
>  free_cpudata1:
> +	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
>  	kfree(cpudata);
>  	return ret;
>  }


