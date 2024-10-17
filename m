Return-Path: <linux-pm+bounces-15879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E4E9A256E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 16:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36087283C3B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950341DE8A8;
	Thu, 17 Oct 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dmMANNFr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2F1DE2DA;
	Thu, 17 Oct 2024 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176394; cv=fail; b=KLGzqf2ngVN7fV6X6imU9ZNX614zoJQDPiiuiA0xKO0pQPnpO+6yljoMiy2OZo+eVRgKqUYRiijSRrP1Waq8CagITh0633Im3smomd8C6JWaBXBaVw5IEXsUp7iBAMvn3O57mmb0uLNCjC/A1mJhzoX5pa3iUinGnoBFC2F1I/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176394; c=relaxed/simple;
	bh=QZvlzrbRD9k9wzb5c+hPQCMsp5kiP5vqti+/Blz/qOM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=if7BuUK8O8LirctzJv4ndSKwhzBjsN/bfoqHcW2VTBu78quC+EkzTTjl1HlylwF+Yi/7yGg4F3rCotMH+O8e28KMOvnaHEHdMF0DuNtSZim0XRCaaVRLnzBMrPiqYq+3eg2Kivd6fMwv5+qXhTjUSZr/wITSF4rpnwVJr8gbJRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dmMANNFr; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqEgqJp5CffBARiSkYozjcXolo4XY79ZWhQWtbhZz2w2kKYy+QO3q9BlP+Xz9fcx2n5mI7pW44UmbL9uML6ABdRjC8+1kg6zdXnEVIRhvj+nKm+63e9vf9gzg4l/gqjdNWpTYuzIX0l5VO8N0u6DuSfZ/z8/cMtKVwmlLdh1z0CnV7E77biY/ix2yWZ1I6pfmiSKKbcPcHSEG4q+Fx0OHgt6KgT+c7oHDXyhC68fwd5uLUyVEYxUBUFSI0HIOqsXg1XjaghKJgLZjg/1ma8ihSdsd9bzrK9bhFxGnTx30KdXX1E2KogOO8ilLpLWq/r8Fv4n0FoA0auUXn/3NWuRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDu6jvYeyuCGwLV+cW0nrwuXMY4SjA9GCJMAxVdIlvg=;
 b=XQSnkcEXq41EydYMYfLCbfGaGr2HJhB0H5aOAUIPTXpYCYNAI3SUUPRCP9BjdFxR+En2KKi4GRqgxFsPaZ9XXBUlq4qACw5j3YCVY2YzVNrjQCtKhN4544kByw45ndj6Sqn31sNajMT0EihiWd0avr+6+H3/5kDHEpEgtBSygyXVKup9QYkdBO+RZsHTK0txZXY5D5uMbCZOpxiOit/PoFD+E4hvcfeadZEn2hYMdHXn4dHdNovNLgSFsElkLMojguwANpQs8yIJEknoFPO6G/cheCymXZlluX8SL68+Az8v0OxpNYt4ywJ9P/vtwYkqjacJ+YIq3sZdXpgrHUiD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDu6jvYeyuCGwLV+cW0nrwuXMY4SjA9GCJMAxVdIlvg=;
 b=dmMANNFrLAZI2QHvk95iT8gEaWbSTuKfZPZWkd5f6y+P778YcZ7r5WErKtpZlj84/vv5pPTfdCRa02AfPyF175niuknKuN/mlN7zalhpbIl/oJ7S8ryecd2PjHgHGc40MQgoOE38VC2uwIs5NpwWNU0BUVfTmILr/vJLAN233ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 14:46:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 14:46:26 +0000
Message-ID: <aadf3614-06ed-4803-91ae-06cd19d1317f@amd.com>
Date: Thu, 17 Oct 2024 09:46:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq/amd-pstate: Set the initial min_freq to
 lowest_nonlinear_freq
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com,
 perry.yuan@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
 <20241017053927.25285-3-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241017053927.25285-3-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:f2::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: c6842078-ee3a-48d5-4f13-08dceeba7a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkVoczRZRndnSitBRDNRaVQzMzRIRnZwdW15T2lpYU81VU1LaFYxTXg4Rlha?=
 =?utf-8?B?MGhQV1dXTldhZ1BsLzgwcXU0eW5mVnRHVTZOVXFPYU84ZzNWaUVWVmRtNWF0?=
 =?utf-8?B?b3pPWFo2aGVJSWFpSFpub2NPVTdIaWUrZ2Uxb2trbEVoNVFjTlJlbDJySmdr?=
 =?utf-8?B?YS9Wa2wzKzNTK1c3eEcvZEFPNjZCMG5sRUJoWUNsN0poTDk1MjQ2ZzB2TWE4?=
 =?utf-8?B?QXNySWtIUG0yak9Rd0pka1BFakZXOWsyUy9iTVh5VFI0cUZYekdQZnlEY1N4?=
 =?utf-8?B?TVlRODgvWkYyeERIeXVlQ3J4dHllcHFlczY1UmRaOG9ET0NPYTJYYnVCRDVB?=
 =?utf-8?B?SUhERk9pRjdPTkpHVlVnem8wcW5xdGNUNi94TDRiTGwvZm1XdEp0c1RkRXlh?=
 =?utf-8?B?dWRXQmxQTmM0WEJjQmE1NnBWd2Z1L3duekNML2xqM09XdERsRnkzcEZMSkNM?=
 =?utf-8?B?Q3pJSE1LQ0Q4bU9PdTNNSmgzS0RkbnR0ZjVFakEzd0VtQU91MnBvTHlUcEd2?=
 =?utf-8?B?YjA5UDFlRXRaSXVsajd0RGE4YWQwbVdPLy8rSm1jV3ZIbkUrbThuYXFrUnRJ?=
 =?utf-8?B?WlBWMElaV0N5L2g2STQxT1N1VWYrYTBaUGZUcFBQRVh6a0JHTGMxMTkwbll6?=
 =?utf-8?B?REVFL3FuanJwVTJDcVNGNXFsTTUvN1prOHU4M2hRMno2YktLbVJCcFZCNUdB?=
 =?utf-8?B?enNwb0dTdktxNENJTVEyUUxMYUFZN29Odk5RRk1NZG0vcExJN0xVNWIxL2lL?=
 =?utf-8?B?N3k0dUR1Y00vbTRGNHJ6bDNvcUVEcitPOERIRi9QeU5IS0IwZGRuQkw1SWpU?=
 =?utf-8?B?NjNCQU8zdWRjUGRFeGkyTUxNWmhITTBXRjhQeXhTU2h2YjU2TnFoYUNJay9V?=
 =?utf-8?B?VGlCVFppTlFGc2FKR1FPaldNYWU5NEU1RE9UVTIxVmdYdVhlUG1CRXJMajFN?=
 =?utf-8?B?eUJoc05DL25KQ0hUaWdzRmJVaXk4bjJmQ1dNQWxsYXJQcnNHTFhKRTRHdS9P?=
 =?utf-8?B?aG5NRjZLeS93QXo3NFpwSzdtWTQzeHp6Z3QxdHlkYjMyMmN6TFVLRFZPaS8v?=
 =?utf-8?B?NkIreFJxRXZvWVFUL1VGUjUwbXJsMDhEdCtHTjVMNjJKMGp1Y2ZwSGRnVjIx?=
 =?utf-8?B?djdYNlQzL2lRTTdBam5LaEkxOEcvZUVBTHRUMEpHQnRsOGZ6enkvcFMxSjd2?=
 =?utf-8?B?MDgrUWV1bGcvSkZkZGRKbVdpRDQrSXc3TldNTnhxU2wvYnlNcVAvS01OL1Ft?=
 =?utf-8?B?M3NVTVRIa2VlZ1V4cWZ0MUhmWXBCWUIveVJ5NEZPMFA3RHdlcnN5NWwxVEpS?=
 =?utf-8?B?UHViU09sUm55U3dZbVM1bER2QmgvS0FwMzB6YlNZVUdZUnpPTERHQklqTTZJ?=
 =?utf-8?B?Z1JYUkRydUhJZEw3ZHlJeE1kczNEMVhqYWxvUFY1VEd4U2R6alpDSyt5UThP?=
 =?utf-8?B?WlFabHZqZVVmeVZRMjRhdS9EOG1aMmdsd2Irc25uZVJxV010Z245dGVaa0k1?=
 =?utf-8?B?UlBld1VTUDlmMHNzUXNTQnZhdExjek1SQ2ZKaU9HUHVpY0FiNUtaUVl3OFpL?=
 =?utf-8?B?UTAyUnJwQjhldUZEMS9xR1hYWnBmWjM1a3ZwaFlFR3p5NDZKbk83angzeXlw?=
 =?utf-8?B?RXhEOFhFY01kNjZGRXNyMDZXc2N5cys1L1IyMGJBUVZzakkzSnk3b2hnTVNa?=
 =?utf-8?B?VXNNWHhFbEk0c1kxMXR1SUpTaW1ITWZHbk5KaGVYT0xaZFNPaStzQnpIWkRm?=
 =?utf-8?Q?opZ+YCpmVtzbLEsXtHgf4luQm3MLwmFV0gfP5Oo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1NhU01aS3ZlZ0tCYTZIbHFielBiUTFhMzZqNW00REU4WExFT09pTE1sNENm?=
 =?utf-8?B?Ry9ZU0VBWlhSRTlNSGVTdVcwdi85RCtoaCtEWnBGd0dBSjQ1Z2FGZGtQVHFp?=
 =?utf-8?B?MHZVVmhTK1ZaOUFPS2o4cVMvWVM1bC9mV01jUm90ODZZMkJJSXA5RFJhUTc0?=
 =?utf-8?B?ZUhtc242KzUyM2pvalhOdWdkejhaeW5QWWlZRUhCWFQrbzMxVDhZSjJ4ck43?=
 =?utf-8?B?azJhZjBLVDhlYkhVZG91enZaUzVGd3JSWGd4bjJoTE5STFpGV0c1bHZVdVBw?=
 =?utf-8?B?QzFiK2xJdVF1QklCYmxDQ0dIYUdoV05tK0F4R2xKeHI2QjJQSU1tVlFxbTBr?=
 =?utf-8?B?Q3hLb0I2Q0hGdTFvNjY0ekR4RGF1KzNVUDA0My9hSzlSVWFUcit6Rk5PZEZi?=
 =?utf-8?B?TnYwSk55YlY4b3R0WEdFS25WTHdzdXB2cVNSWFZuRHVPYzV0SWQ1dHNSUjN5?=
 =?utf-8?B?WGJhUXlJRkRzZGVEcnZ0eEowVDg1djhwTHZWNitQN1VMSWh6MEpxN216MjBG?=
 =?utf-8?B?VklieEFtR1Z2VS9aRE8wR1gybHcva0lyc3FueXlRTHVVZlVCMXVhMDhtVmpG?=
 =?utf-8?B?RVdDdWNHcU1Ec2JjTktTTVF5aS9pK25Lb2psUEk0VjRDU0VjOTJTd2RGTkMr?=
 =?utf-8?B?aVoyaTBsckVacFhob2xpSk96UHNzWTI1YlpTcWpjSmZXY2RYU0Y1dGhLcWRM?=
 =?utf-8?B?NllpMUdJczJxU09hVzZtZVEzd3pidm9hWHVDZTR6bVJHcXA3dlVaVU5OY1Z4?=
 =?utf-8?B?U0w2ZVk1S0xkWmd0RndRUW9JYVR6Wk44S2xBeE1SbU9nNGY1VENyV2lUU0R5?=
 =?utf-8?B?amVKb1RJenNjZ3o3SE0zQnBSWGtDYUdYZGVsK2N5SVZSTS9tS0YwWUd3K0Ur?=
 =?utf-8?B?NkRmS3lQUHcyRnBoeHFpelRiVEVjb014cGFJLzhIdndVWDZrVlVrdWllY21V?=
 =?utf-8?B?RTdRVkpkTitGcjArVkVvcDR6MjZmOGJVN0E4OGZ0NWlpcnNDYmlhNS90K2tm?=
 =?utf-8?B?ZG0rMFoxWWZjMjdiTlBvbHpGNjkwRFZjV014M1V3NWdVZ2kxZ2l3RXJhR1Va?=
 =?utf-8?B?NTNCa3JobURnMk02RmVIUk5RZWVkZnNFYllGQm5YaE9rUTNLSXZCRllnNGpL?=
 =?utf-8?B?TVVtY3JNcUtzZ25BSGxQT0xxQTJCaTh0UkZkc1FFZTF2RXVqb0phM1ZWK0RL?=
 =?utf-8?B?OTNuZFhOME9XRmttMVVVMWJFUzQ1d3VKSHVXS3B2QkZSZjNFNklRRWZTelJH?=
 =?utf-8?B?NVZTSUkrMlEwZEVLU214bzdzM3NDem83R2Rsd0UrQTJGTWRpalZPOHA5N0tX?=
 =?utf-8?B?QWs0eHVMMnNZcERzTEM0Y2tDUXlXV0xJNEhSUnFNeC9MUHFITmpVN0FydzVW?=
 =?utf-8?B?cDNXYVRHVHNMK2szMnpCME55VG1XcXhWcjJXYlY4QXpaRHZYSWZoTWpSdE16?=
 =?utf-8?B?czNjSjlVbWVzdi9sbkxwRTRXWFc3K3haRHYyTGpuOW5zU1hDQnVvR255SVZN?=
 =?utf-8?B?bElRc0N0YjVWcng4WnBqTktLeklFT01FeC9aczhoa0ZaQThMcHhzWjNyWG1T?=
 =?utf-8?B?YjNITGMvNVcydllmWCtJUE5pc3N2Zk1DN0pWQXpsYmVaNVRNTnBtWWlmUGRx?=
 =?utf-8?B?UytJUC8zc2VOUDdUc1MxMUNHMjFqOGhsVnNlaE9teDI5VlhENjJoTDJvT2ZX?=
 =?utf-8?B?c2kyUEgxUW9vVFBsVUpOdEhvRkRXK3pJNnVRUVlIaG9xa1JXSFk1anFEbjZq?=
 =?utf-8?B?TEZxcmU0U3hoT09Mek9RUWdpQjZKcHdrSFNmRkZJTlk1WXlBSTg1ZjBCd2JZ?=
 =?utf-8?B?TDhPdS9QVFVEN0ZxOEwyOUxacjl6ellWbzZLWmp4NWFPSkVpWHRKSU5hblYv?=
 =?utf-8?B?cXVVT3V0Z05DUElwUExISXk2c1gxUnpHVlFPN01TMndsVWJvbzkwbXJQMmRh?=
 =?utf-8?B?VWhJVVh0K2N5b2tYMzNNL1lIK2VZT2hBWEVGd29kVkZrSm5TalhXOTY3UTB0?=
 =?utf-8?B?VlBWbURMVXpqNEJVeDAxcUZxSDRORDBjeS9CSUR2S1pPSDJtZFZhK3dUNHFZ?=
 =?utf-8?B?d0JOdG5KamdLRm5lV2RlWDZFcVB6aWdVeTZTRHhlVmpzdmNScVV0VEh6UkNG?=
 =?utf-8?Q?Gw8i//n88D2VU204K0Jb+S/dX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6842078-ee3a-48d5-4f13-08dceeba7a8c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:46:26.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLF9W0AgvfHMwrt4bJV1US9QdHzUcNMRcOOciF7jVEz0ookU8uMV6VcrIOuIfSbBpuHZwRRvxZSo63zPbSp+SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729

On 10/17/2024 00:39, Dhananjay Ugwekar wrote:
> According to the AMD architectural programmer's manual volume 2 [1], in
> section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described
> as "Reports the most energy efficient performance level (in terms of
> performance per watt). Above this threshold, lower performance levels
> generally result in increased energy efficiency. Reducing performance
> below this threshold does not result in total energy savings for a given
> computation, although it reduces instantaneous power consumption". So
> lowest_nonlinear_perf is the most power efficient performance level, and
> going below that would lead to a worse performance/watt.
> 
> Also, setting the minimum frequency to lowest_nonlinear_freq (instead of
> lowest_freq) allows the CPU to idle at a higher frequency which leads
> to more time being spent in a deeper idle state (as trivial idle tasks
> are completed sooner). This has shown a power benefit in some systems,
> in other systems, power consumption has increased but so has the
> throughput/watt.
> 
> Modify the initial policy_data->min set by cpufreq-core to
> lowest_nonlinear_freq, in the ->verify() callback. Also set the
> cpudata->req[0] to FREQ_QOS_MIN_DEFAULT_VALUE (i.e. 0), so that it also
> gets overriden by the check in verify function.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Thanks for the fixes, I'll queue this series up.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fa16d72d6058..833fc17a39f2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -529,8 +529,27 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>   
>   static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>   {
> +	/*
> +	 * Initialize lower frequency limit (i.e.policy->min) with
> +	 * lowest_nonlinear_frequency which is the most energy efficient
> +	 * frequency. Override the initial value set by cpufreq core and
> +	 * amd-pstate qos_requests.
> +	 */
> +	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
> +		struct cpufreq_policy *policy = cpufreq_cpu_get(policy_data->cpu);
> +		struct amd_cpudata *cpudata;
> +
> +		if (!policy)
> +			return -EINVAL;
> +
> +		cpudata = policy->driver_data;
> +		policy_data->min = cpudata->lowest_nonlinear_freq;
> +		cpufreq_cpu_put(policy);
> +	}
> +
>   	cpufreq_verify_within_cpu_limits(policy_data);
>   	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
> +
>   	return 0;
>   }
>   
> @@ -996,7 +1015,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   		policy->fast_switch_possible = true;
>   
>   	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> -				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> +				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
>   	if (ret < 0) {
>   		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
>   		goto free_cpudata1;


