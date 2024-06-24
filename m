Return-Path: <linux-pm+bounces-9923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034891593B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 23:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BAB1F23EEE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A581D132122;
	Mon, 24 Jun 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lVxXvu4e"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023061311A7;
	Mon, 24 Jun 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265650; cv=fail; b=S80foGL7L0yLH5B0lZmTc8UGqwQzwPJHKsHOXZGNmdBNokXqb3sqraHZx/07sPdvslSp1tYkNLZ4u0C+9YyrXl8Hs2TsI5WXKiUUYLeu/DjjYkS7jvyFtmUNlgaxHibDBPlmqJ/+iGd0YCbkQgNLH+ZB63b0I9zO0W3B7mUa+aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265650; c=relaxed/simple;
	bh=bqxTxOJIxBMtpIo4RIwHQ0kwFFTXM1YppVD6ET7s6Cs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FdF8tgC4J8oN2uhAew92tu0CEJ/xn9lxhXOYaVbajOO802NXh++83JUVxnFzl6fmoAA0Ler4ukVsqN+n9IilEyfS3sTxmk+eWzG5C5YZX8KfhvFoaOMRIaciwjMOK08Z8oPNRBQxC8BfB95QmflUm2lpvyyX7/iEP4L/5hJhlO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lVxXvu4e; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktbxwg6OmuSKpCUgFQMwLRo4cd2c7px1Kx05pwDCmfz0Ms8iRbrcEMJNJDEJ4Oy3oOAyYmIyEotkb3gPcIrimLWWR3YtZVRItbVqRPXyfCcFF+lvsOmh33PCGiOGMaPxo7cmAz7gk+geG+aMvZO4I7A1BJhfcjTIDlg/I0OLOmllhZTR7//cl+b5VNwsiKPSYQfVXVG2Mv+busfTTfYCeua2GmgpjEpdnHhE0vlGqGeOn63n9MM45RKk5k8WhraOOMonsgEVodABdYZAFTWUE47DjQ4N90Ii6E+ZzlleNz92yC60psOZlJk3hRxqqa+5gdw8UlAdCrnTRcw2jef1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdwicDpZF1Peq7kW8IuykNwqFi3vU+9Sfpx0H7zrIh0=;
 b=iuXrnpUreKflcMkH8zbV2E+XL4TeoFbEXwn3vfrOqoTnz5crmlRGgWsCwWglQc2lmMMSDHZMXJ8okJz/787p9N/2h1aLhYs0VS+VY++T6JAub1ZlzUGOiqhVfy1jp9I2H9MW3pXy38ti2RQCF5aR0buUeFwrvORe7fGq7DnUiXaBm6aPN1TCrfZTPdYbMFv0jXUykQlTrBs6IW9LhnOqhcZjP/4WP6N+JKkHc7sm507C7VEZiBrLzs3/VrwyWM2pkoSfZ0Hha9ApTFYHlXvydZ/m3DQTufLs1/u16su+VCpP6/FYHme5/DN9mP9Bd/m9p8lSQIREU+7RC3k1vfqWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdwicDpZF1Peq7kW8IuykNwqFi3vU+9Sfpx0H7zrIh0=;
 b=lVxXvu4e0Am9TSSZU9TbnuF6A/zFc1cDbEwMjB0Ke7A4gEl/jdUcWLe3xmUvzLUHHaLFhXmkWO8462ecHQuOOxx7cL7AKBkRrsnXq5H+eLySws7ryLK+f8+9zvSzmhpm+Hx58C3LYedl91gxl2cQ+dO7VdptKbopjPQmcq3sV0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 21:47:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 21:47:24 +0000
Message-ID: <b584f631-b948-4cc5-89af-724b892341ac@amd.com>
Date: Mon, 24 Jun 2024 16:47:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/9] cpufreq: introduce init_boost callback to
 initialize boost state for pstate drivers
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718988436.git.perry.yuan@amd.com>
 <fef324b46625e5a9985b0c0c1bcfc05067d40e36.1718988436.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <fef324b46625e5a9985b0c0c1bcfc05067d40e36.1718988436.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:806:6e::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 653467b5-e8e7-4b81-a491-08dc94973ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVVqbmpISjVObjIzZkdyN0dERHRna1NoUEtuVmN5M01LNjhDbzJWRzAxZUk3?=
 =?utf-8?B?d1VJOThUMDhyR2N1cHN3OXcyNjl4TlRNUEJXQkcxOWM2MFgycGxyZHRMOHVN?=
 =?utf-8?B?bUhvQkkzdVZ5VFNDVE02MW5lWXBrRXRjdVF3NlBmTnVPTFJYS3pkSGh0TWRE?=
 =?utf-8?B?SVA1ejYrRTEzWHRWY0llRXA2SEtINlJVSTUvZkN5RnB5QitFbGV6cnBydGJO?=
 =?utf-8?B?NkdqOEEyL0dqbG0rVmJubzRjaFRqOUJ6N045bER6ZWdQSGlXSnI3c2llYzF6?=
 =?utf-8?B?RXo0bGRvaksxQU9oWlpsNmoxSDZkSzM0bC9NbCtvSEZ4c2kxalNXYzBDMjVj?=
 =?utf-8?B?MkZZb0JFUG1IcFk0Uk13K1pORmdxemp1NWdjNTFsdTEvakNIVmQvOVNLVWU3?=
 =?utf-8?B?WC9VRnlhWnNnZk9rNTVvWTNqQnREUzQrMTd0NGFibzR5MTRDZDhwd3FBQUxS?=
 =?utf-8?B?ZEZYR2k1b0xlbEM0YWVZNHVpRlRjOGt6RFZOSkdPeU9XamYrRWtIRkpKbjNR?=
 =?utf-8?B?T2NVOUl2Wjc3eWxqSGJVNTJSRlArVHlQMU1NT1VrOE14enpwUzhYSUFtQlJl?=
 =?utf-8?B?ZjYwWXZJWGNTTitkMjRGK2IxcUQxbzZJalc5R2Z1VEhuR0s0TDh0NmdqaDlI?=
 =?utf-8?B?Y25iaThTdUxLM3d6NWE5RlZsdTVVdmtlRnN2UzBKWjN4dS81N2QwNkJSdi9v?=
 =?utf-8?B?Q2l2OGpUa2ZVQVR5UzVFL3BsUUIyYWw3ZHkxNW1oUWJONUVPNU8rRFdEc2lk?=
 =?utf-8?B?aENOY3VBMmN5dEFYSnQxYmp2SXFaNy8ranl5NkZkV3lzVmVjRWJwZG9GUk04?=
 =?utf-8?B?VHEzZVVMQVo5N1NtaThYNVIxeGw1b2x5NWJpd2U3MXpsSW9adEJDS1ZqKzdK?=
 =?utf-8?B?S3Ezb1IyNWtiYmZoUzdhT0JvNTBnOGNOT3U5RUdxUUtVV2E1aWZWSjJ6WXhN?=
 =?utf-8?B?a2tYcktBVGZyajBFZ3hLcFUyT3VzNkY4VWN2Z2pGZTV5ejlPMzd1aDYwRFQz?=
 =?utf-8?B?TEh3aW1qcEpRajdGTCs2L3V2U3JVeWlTY2JCaTMzT3FPOGJDN21RY0sxRlg4?=
 =?utf-8?B?MEF4VXRFajBUZWdweUU5aUt0aTBFSWZtWFRVM0krS2NCNGtUYk5OcjZ6aU5G?=
 =?utf-8?B?d0Y3eks5WTFGekV0VUd3bzV5dW9NR0NkblB0bFoxUndqWEdRcXRERmMvSmsx?=
 =?utf-8?B?eUw0NkQvdE9oQ3Ztbzd5U0hSSlBBd0lJU0ZuVlhxeDhmUThEUjRCbFhZVHFp?=
 =?utf-8?B?Nmx4MnZLTHF6R1B1cTd4STN0aGRSNkhCU3hQcTBqSTJkS3h3L3h6aWVROHpu?=
 =?utf-8?B?UjZ2U3o2NTU1OXdJLzZQYkw4bmZVb1ZOWnVobTNDNFdsb1psempwcHVVM2ZV?=
 =?utf-8?B?N0RnSTJYa2RMd3BpaWVpYVQ0c0dKSWlQQWYzT3hIZzd5QzRuRmoxSm8wNDM4?=
 =?utf-8?B?SkhUakkrRmo3endraDhwTi95Q3lhUFI4ZXBFU0dCbE5HdnF3cHdySGF5YjAx?=
 =?utf-8?B?ZnhXZDZUZmVWQ1Y5b3hraG1DWFhYMGZrenJzWUc2MWRJdWFNRHcwVkdvQTI2?=
 =?utf-8?B?U1RIU3dPMGZkOHlwWlk5OFBhNWdYZ2wzOWJsbndzWGt0Z3pxNm9tam1NSElV?=
 =?utf-8?B?ajFxMnl4T0plaUxGZnZsRWNRK0ZET2pWWU5UcUZhOFVZMm16R0FYUEZSTW5M?=
 =?utf-8?B?ZkVuVk1hVlNrZUhzSEMzV3dqa0tWSkZ4Ti9lRXF1S2RqSWh0YnVFMnd5dXFM?=
 =?utf-8?Q?N9CHhK6RKZqlPshMps9CTESImWix+WurEHa/KSi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEpLb0pIZHFoUXV5S0tVdW0rdkFSL1BrSkhZTWEzSHNISHg4UXdVSWlZSHZj?=
 =?utf-8?B?ZDJ3bk5pdHJTaVZpMFBtRjFYYkp0R1ozbmtSakZPOHVIMHEwNndWVmJQdUhy?=
 =?utf-8?B?UWcyQ1BIVStyaFMxMXpLZWZnR3FyOEJKd2dSVW1INXdERFdvdUpXZmVnTFlr?=
 =?utf-8?B?K1h3MW1vZXcrUjJPNHpZYUhoV0tTRFpnU05Uc1pOK0JIK1htRVJhU3JmSHNy?=
 =?utf-8?B?M09leXFtU3FBYmxXMjR6RGowT201TTM5V1poaDN6aE1zY2UyUnhXc1htUm90?=
 =?utf-8?B?eDNobFJ2L1FuejhPNlJUN3A5TUxrYk9XbmRzWTRMV2hla3BMaHhxckZlWWY2?=
 =?utf-8?B?RGVKMVdYVmZTck84OGJjL0pHRkRBMnVzTWppQ0VmK0dISWljNWkyREM1c3Y3?=
 =?utf-8?B?V1NJYkZFbk1uRG4yOC85Q1hIcWduYkJWN3o0STNBZDZha1ZDdHpXcGNGRkVs?=
 =?utf-8?B?RFI4Rk9NNXpRbldtRGNjZWFUU1FSbnF5NXRQM1diamtyYVV1bUsyRHNoR1d1?=
 =?utf-8?B?ZWllNlpNZFJYK1NqUHdBMzU2Vnp5dGdRY3ZVcVprb1Zpa0xZWDloNmxYNDFN?=
 =?utf-8?B?TmRIbFB5d2dLYk5tT0RuMWZwbmVpTDVHaForZ0ZVeExiZk5RdzhRSm16c0xQ?=
 =?utf-8?B?a3RxUkhvWDhuTlZMdmtDa0d0dzJHcmhoMDg1Z3FoM1lBaWplUndCM0tPdVdX?=
 =?utf-8?B?Y3YxbWlNeTd6aUdsTlE5Tk10bmlQbkFXb1JrOEM3WkVKWUV1em5ja1J5Tktj?=
 =?utf-8?B?cFNpc3lEcTdycXlDblRCbk1xNFY2UXNIVDJGd1FhRVNlaEFoU2lidGlkQzBR?=
 =?utf-8?B?WnpXclQwN2tFd1ZmY2ltOHovS3o1dy9CSHlGZGpoK0RSRUZHZkNPcVBwRGg1?=
 =?utf-8?B?bFMrOU5NMTNvWVI0cHU4cEY3TlJhZFNlVHlMTHk3N0FlQURHYWNWSitpekRV?=
 =?utf-8?B?ZHhyUjRpdXA5Q0tWS3ZyTTZGdHJaTjYrTWFCVTBzNExiYXlLbFBXalFpMGU1?=
 =?utf-8?B?UG1QNERrcXdZYzEzWVJDWkJYME5kdlNCYWRaaUgvMU9yb3FobHNXQkhkWUIz?=
 =?utf-8?B?NXI0NC9Vam9pd1lscTAzOGlJdVdmNGtMTVN0ZlQ4Tmpac2hjb0pwUVczOThP?=
 =?utf-8?B?S2h0RFllemZDbkdLMVlXcjlYL3IxbUJqRFF1eGhjSUEvZEplckhQMmhRT1Vs?=
 =?utf-8?B?aExiR0FwNTJnQ1VVV0FCMG1JY0dnVmNNbVBsQmdrVU00MHcxMTU4MW9KWGw4?=
 =?utf-8?B?dHFQZEpmUStEUjFKbXJLSHE0dzNmMmdvYkRqbTNiRDJIZEt2d2VwOFhzd3FX?=
 =?utf-8?B?WEVVaUtsMGNzaWtjYmZTUlY1OHlvMXdVOHhjRjBvVWpiNHNJSmtGM1Zxditq?=
 =?utf-8?B?akJmVVYxbWV6bm14S2VEeXpJdEYrR3RZRUlaRzZOUE9zZkRHdENxTXhCMHVW?=
 =?utf-8?B?TnJYQkR4cXlwMGo5d1JoclppN1RGTGg3UEhlRENjU3p2ZjZoOG9hRzJUdk1h?=
 =?utf-8?B?MEYwSERVR2E3L0J2UXZJdThKbzdNeDRTNS9pUFJwanFqK1FnN3pHWTFkTnpZ?=
 =?utf-8?B?aGNGdG9NUDBRaUtGKzVIU2lScVhxcnBYZXMyMFpidWcwZXVpeHZDb2JiZ1dB?=
 =?utf-8?B?bkQxOVJDM0xFYy9kWm51emprQ0o4citHZVV3czl5UXhFVjJjdnB0Z3hTWXJy?=
 =?utf-8?B?cTFjTDhoQ0V5aE9oN1EzV1g5bmNBZzdoMjhSWlA0RmkySWVXRGcvV3pMOWNv?=
 =?utf-8?B?N3lBbkZxY21YV09JVmUzRHlqMFlld1dPcWN2YjFZd0tIMDB0b1ZjNVBNL0Vw?=
 =?utf-8?B?WG12RXdzZWZsYnhUb1h1UEt6OUtEYXN1MStTNi81cGpxWFZET1ZTeUhBM1BW?=
 =?utf-8?B?WHhGVy9HRTYwd1o5SWFaSHUwV3RHU1B6cTBSdE5weW91Z2x1djhTYjRxM293?=
 =?utf-8?B?WUVoWGlRVVRjTnltc3Z2RFB5cjBwZUNYM1hPY1ppcFI0R2h6RTRiT1IrN09r?=
 =?utf-8?B?TjB4N3RsZEd0MnlzRDh0ei95SU83SjloYTJmU3Y5dkV6Y0pEekNDRjQxK0Fh?=
 =?utf-8?B?d3VoeHpJb08xYlRIejI5RmE5OXZ4NFhmaUpTeExsTWNEajhBZVBvemk0YTEx?=
 =?utf-8?Q?n2v/ePaXo+ONy6KiXwsW9C431?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653467b5-e8e7-4b81-a491-08dc94973ba0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:47:24.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFk0HNdrdEmDwuZFW+xTNh4e5wZtdL0z/bOsWXVjeAFtO/Bx5WL2dX+vUMoflMCscyR3WAWkKMEbFfdR5otMlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155

On 6/21/2024 11:50, Perry Yuan wrote:
> Introduce a new init_boost callback in cpufreq to initialize the boost
> state for specific pstate drivers. This initialization is required before
> calling the set_boost interface for each CPU.
> 
> The init_boost callback will set up and synchronize each CPU's current
> boost state before invoking the set_boost function. Without this step,
> the boost state may be inconsistent across CPUs.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

As a part of the testing on the v13 series the past few days, we 
realized that this patch is not necessary.  It's really a workaround for 
a change in behavior introduced in

f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using 
cpufreq_boost_set_sw()")

I've adjusted the series (as v14) to drop this patch and instead send a 
fix for that one.

> ---
>   drivers/cpufreq/cpufreq.c | 14 ++++++++++++--
>   include/linux/cpufreq.h   |  2 ++
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1fdabb660231..0c99d2dfdb53 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1429,8 +1429,18 @@ static int cpufreq_online(unsigned int cpu)
>   			goto out_free_policy;
>   		}
>   
> -		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		/* init boost state to prepare set_boost callback for each CPU */
> +		if (cpufreq_driver->init_boost) {
> +			ret = cpufreq_driver->init_boost(policy);
> +			if (ret) {
> +				pr_debug("%s: %d: boost initialization failed\n", __func__,
> +					__LINE__);
> +				goto out_offline_policy;
> +			}
> +		} else {
> +			/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> +			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		}
>   
>   		/*
>   		 * The initialization has succeeded and the policy is online.
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 20f7e98ee8af..0698c0292d8f 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -409,6 +409,8 @@ struct cpufreq_driver {
>   	bool		boost_enabled;
>   	int		(*set_boost)(struct cpufreq_policy *policy, int state);
>   
> +	/* initialize boost state to be consistent before calling set_boost */
> +	int		(*init_boost)(struct cpufreq_policy *policy);
>   	/*
>   	 * Set by drivers that want to register with the energy model after the
>   	 * policy is properly initialized, but before the governor is started.


