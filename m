Return-Path: <linux-pm+bounces-23337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70ECA4CDE5
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 23:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA973AC113
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B911F1301;
	Mon,  3 Mar 2025 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EqBLE+pz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8561EE00D
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039844; cv=fail; b=FDSmoFdb7IN/pDlWhIVNznqXRUDvIA5YKwx7wkT/LqVKNckfsPdz0kIMZxK65lJcXHZHqJV85r0MHZ4+yMIV/eu2x7N1kEuQoXFbj57uTvubBUs9wnaVkxoryepdBk0xgwU468u5ZgfKWVYAh0MDOv0bEl3SuTBRZsHw2p1iAMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039844; c=relaxed/simple;
	bh=GsbIg+sbCT49boDfqnZDgKCrEQWswoesoNd+itjpTBY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=pXgr4xFIFep8BBSFkVij6wBT3C/6qei5TcBBppRuNTX28oMtEgv7KqVBmibdR5EmR8ohp0DglhqlQcEM4DSK8GgCau9QwdEcvx8hAmqevWzOiHP3MDTYHLdB0nHcWJz7UlK6hEONOsoBTuYxWewxc6L7ad1GJ8YySJ1oAfCKXws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EqBLE+pz; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOsvqtT8yu79HPgV5u1S/+tx0FxMxa45SP1CVL0VAy/GtGUpAgIfX3psTQIsQMNUw711VrSQE4Z/WoBJI0MInoJPlm/Qd0PDhP8AgiPo5Xkbvenn15+hdxmmtD6Iuq0mAdZxA6xOIrq20zjzhV2mgHHyrwbItU6fh2HjZ12EY76c9vpZjWz9/onGsjk7JcaaZ1Fw59nGaP5s3c4TIhG/xMflhuGLTG/xKN5Sat7YhTJ2T5nzkoAo1apOomDkPqIKCAhbPKIzLiF92smNsYO6HC0oPzeeFXtohvqu8xsPQCOAYfpVwgrfe7QidF8kji5YA1TLo1IVPdlLQqy4rg0fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDuM8iy0pbfzUEeMS7QbpnqHW54JrwYLJbRtrnLxA0c=;
 b=LoNCaJ1joXTvOCUFb/j2Y1VQ0O2xLdztoK3wpCORBsolFuuEHLPaJdlfJkgHHx9LvDbC9FQSxy2cRlvcAHPVWKyoateHkceYYPVVMGsjoEKZnsts9nf4Ztn2T8vi4pC9oz5O1jdE16telV1lrZ3qcG36a52ao5nbJaCIQoDILH7vj73J6fU9fK7wb63PcIJ85Bgw+wRsxdU0bUVEANfqWtciwpRqZuxVWzXe3M7NZD2Q6c6csHeRVd9YndC6ifaXKwde82vXBPgABIdIKcGhLWNy1Z9/cYEGo/Lema45nPNm9UsR+0lFvd3VKNVRE7NE1FQwL7MgUACxDv+aetPOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDuM8iy0pbfzUEeMS7QbpnqHW54JrwYLJbRtrnLxA0c=;
 b=EqBLE+pzo41plZ9pXXro4y3VuNDl1NK3ZMfoupJ16kAFkQ5Q7ybuLE4ibhsL27IIsdcFCNIJBOxXfWEbKMdmJSakYrCXAljPfB8nbJM9Ik8vUxGlYhjObQXIqaVC9BIbNlE9rsYrpS55eELNRgEcENZIYj/BLJh3m9nH/lCGuGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Mon, 3 Mar
 2025 22:10:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 22:10:40 +0000
Message-ID: <9b23785c-9aa9-44d2-9bca-0f4fbc9bbc70@amd.com>
Date: Mon, 3 Mar 2025 16:10:38 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [GIT PULL] amd-pstate content for 6.15 (3/3/25)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0067.namprd05.prod.outlook.com
 (2603:10b6:803:41::44) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c182ae-d6af-4ffe-c7c7-08dd5aa03be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlpTUGVLeFNDZjFMUVpqNFc1ZTEvNTZTU2QvZmZ1eUlYZDdxZEtFMGE3TzV0?=
 =?utf-8?B?MlI0V3kvandLNDYwY0hBOG1BM1VWZEZEUkg3RFJBWDVNMWZtbmZ0aVprSXNV?=
 =?utf-8?B?RmppdXM3bnZiVmxlVEFaR2xHR1NxSm1WSWxjelZteHhOVGdVM3JFWWgyTmZD?=
 =?utf-8?B?ditPQXNVL2RTcFlJdmRySml2SFNNREwvSWNwVU9wYThiWStsYVpQdGJkY0M5?=
 =?utf-8?B?U2VZOUdKODFCSXhJSi9zR2NlMGloNzRDN2lWVXU5VW00VTVHQXNSTXBuZlhR?=
 =?utf-8?B?TnYyME5UbVpvSVBXVkhQdEZncDBMSm1yRE5HbG5RWlIvL29XM3JDdVcvdXR5?=
 =?utf-8?B?NFQwSXhnOFBKcEI2S21Xbm9SUzhUdWlDd0NVTGNiMW1EU0ZtWmoyQnVkanNi?=
 =?utf-8?B?OXJtZ0RVRVB2RjRWSmtCVDMyTHJhTksvNEtubTU3azZDNVJQZ0hzV1F3UVBD?=
 =?utf-8?B?Sk13T2xYakhoUitIZVZCVXREazlTSWVOOVdDaXU3ejhVek5QQ0JaV1VjdDVM?=
 =?utf-8?B?NXdacVE0NUhaeVB5SHYzMG43K2VmYUFRZHQyeGRkZ3JSUjluWExTT3hwUEd0?=
 =?utf-8?B?QkQzdFlNUTlEV0hENm9jZnBPQko4bEhBcmZoaGpQeldIazdQbWRJT1pUbnRW?=
 =?utf-8?B?VXlEdEZReW9ZNHBxZHRpRHIwYU5MOEZ4YllNRzVwN2tkcEZudlRlZUtwMHhT?=
 =?utf-8?B?YkJUaFlOUFlxektjdmRXcnZZY2hMNHJWa25rUjJCQVRpaFFWTVowS3BzdHNs?=
 =?utf-8?B?Vkw2Ryt4TWpiRzExNTJiUlpFMUxVMXFQVDByS3c3YXdKdTJFblJwaGFJaVZS?=
 =?utf-8?B?RjBjTkFJVS9qMVdRaTdQM1pPNFJMcFl2WnBUay9KeGx0L0d6TEEwK3RtOG44?=
 =?utf-8?B?K1JmalVtN0pFdndBYzNWQk9oYmJqVE02ZWF4MU94MkR3Y0lJOWdiZ2ZsVXNr?=
 =?utf-8?B?OTdPUThLNnM5dGJUU3lzMmRUU05USi8vV1ZMS0o3dW50T0tJVnNrc0pyWngy?=
 =?utf-8?B?S1VGYm9rR09YOWtscktocnlKV3B5cHBWcEJPaTkvYTU4U3NLR2wwaHlSQ3hX?=
 =?utf-8?B?TGYwLzY4REl4My8rSVhaZnZ0VkRjQmlRVmF1MzdGbmkwbHI5UGQ2aEc1Mi9P?=
 =?utf-8?B?SFJ2VUNRdG5HeFhwamtBOU91cTAvQmM2S1BzVjY2enhKcU12OWJEV1VGUmdr?=
 =?utf-8?B?bzJRQ0h5MXlYbHI2cTlMbWZTdmJ0TmU1eGZtMDlydEppem56NEpmZ1IvUjlL?=
 =?utf-8?B?RWxVOGFCbVBKc2RGRkpEVkxyK0oycFYwWkpJa1ZoUURNYXZsUWRnckZOTFVu?=
 =?utf-8?B?TUdhMnh5TStrRkQ4SGZoemZJWXFDSnZoRWtCVEdraHZLamVSL0NMc01PWXBR?=
 =?utf-8?B?VnJZQ3lmYmJLS3Z6UW41MlpjaXlOZldmeXo4cVV4b0JqVGtBbnk4SzBpRXZy?=
 =?utf-8?B?LzgvemZzZkc2Uk9WNUhyZnBRYUE5STMyc24vK20rNkhlWFVTU3U0Q3dWcUhN?=
 =?utf-8?B?cnN3djdTZnVVQll4L2I2ck1hL3NOcnh2SlhWendZU2s4amtzTVJCVU5VbkRy?=
 =?utf-8?B?aTFQREhSeGZuSzhOdnZlTnY5Mm1VaVNoOHVWbGx0QTF6WGNWb1lWOGhDcWhF?=
 =?utf-8?B?WmNtbk9iMGxxNFJyVDR5Z0FtV05nc0d3aG1ZeWd4SlJyczdpYU9HVGFyU1lz?=
 =?utf-8?B?bTFLNVhJQ0I1Nld5M091TitQY0tYWWdzMmdMNTZmbkNMYm1HdXVVRjNzZkQy?=
 =?utf-8?B?alpSeHB2SXlwd2k0eEJtTUJ0bWhQV2lYQ3V6amZDc1ZKY1FPUGdyWEVhOWxn?=
 =?utf-8?B?Y2RkZGc5cndRclJUNnVqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1hCQy84ZUZZbFAxRlUzeVJsU2V2QnJjQ0VVK0NzZEp5eTA5aXpNUW0wb290?=
 =?utf-8?B?NGxNbDdJL1NqMWN4M0pGbEc5UHJ4eWlERkU3SkVvaVoyUllEMWxLdzJYUi9H?=
 =?utf-8?B?Z2V6VFJ0L3JaL3JvNDVUYnVZQnFFMVlJTmxKRlB5bnJmaHUyaC9jcC9rQzJ3?=
 =?utf-8?B?dWl6Q1cxbnBMbThIRCtvcnBSNUppZ1NZay81V1dsYXlkL3FVcW1ZUG5MYVJE?=
 =?utf-8?B?eEVYUmhjSUd4VWRYbTgwN1dOZmZIZXNRUndQbjFWY09uRDVmRmJ0OEJrREdX?=
 =?utf-8?B?ZzdCQVRSQnV6Rk5VL3IzcWoyZlROK1dxNWJmY0pQYXdGUWg4eWJUU1VCOGVn?=
 =?utf-8?B?b0tkRGdENytQeDg2eGFPYkc0VXdRbXg2ZWoyZkJiWmdEUm1LUFJtQ1k1WHp6?=
 =?utf-8?B?MkVqbGVXRmxNSmk4aytWZlhRZm5jVURmeUJXRzIvajhDbG1MQ2FYM0czaFQ2?=
 =?utf-8?B?b2M4djFNOU4wMis0NlZqRExCZTRVbEhZVlowaTF6NHZlQ3FjWEhveC9FZmIx?=
 =?utf-8?B?YmNjVElMWkRMQTk1aHpZR1VjNFJjL3BMOFVEdXhvVW5VMFNwNzVXZzNXTDhG?=
 =?utf-8?B?dGxocnhkVkdNelZMU2Vwc2pHVUY0c1hlSno0aENzOW9RTkMrdGdtem8ramds?=
 =?utf-8?B?dTIzd2FBWFFtOU9CRUdoT2l1SXdzYmtYWUtaeGtEdFhOTnQxSXpaT01WUTdL?=
 =?utf-8?B?UUVGc05rUmJIME1abjUyeTVJbm5mZ0g4ZDg4WXAxcm10RUlTRU5VNXVPQXkz?=
 =?utf-8?B?VERBbFFBQVNLam8yQVFTeXpNWktTMjlVMDQrNEwwSm5TbFN3Mm5pV0l0SWNr?=
 =?utf-8?B?andTNVcrVE42Z29LRmVkZ0p2WlBZSlkzSFdHeWxabXJwTjJ4L0s0ZmUxanV1?=
 =?utf-8?B?aTF4aWNINjdWamtOQ295UitVUFVQZldacmdZeUR6cVlZdnI1ZjlxQ3VBRlBR?=
 =?utf-8?B?Ty9GVmFZLzZJb2w1MkFvZUZDczJZa1ppWnVxSnJ5clNYNGd6YiticWswTTdv?=
 =?utf-8?B?UWhCQlJvYTZYMnY5cWxqSjhmQTlLa0E0ckYyUWZHREduTjhuSFdDNkVZOVIy?=
 =?utf-8?B?TkdPNEJuakkvcm1ySFd1NUwrZ1RaNnUwUUlaQTY0N3phYXVKY1NRZUVrTDdi?=
 =?utf-8?B?b1VDdkQ1T3VxNGtKZDIwTHl6R1JrMHcvdUdWWmF3RHUvQjh6dmMwV2dyNzFX?=
 =?utf-8?B?RGlUbEhCb05IS2hOTEJvcjBSRGFuak1mS05zRGlvMUJOQlU4UzhibUE5N0Ev?=
 =?utf-8?B?WWFXOXBGbUlkbURlN2JXeXB5WUUvOHNYR2VxaVY2clNtdmh1cDRMSHpRR0dz?=
 =?utf-8?B?aE53TG1BNE1JdDVvWUE4Y0FaUWZaUm82U3llZnNqRW1oKzU0VmRuVEdZdUk4?=
 =?utf-8?B?RENmTXh3bHE5ZThGeDg5QzJtTzEwQ21kMFcyK2tHeUttQnlveVNwNjhjakdl?=
 =?utf-8?B?eWI5T1UyVFNOdVdUN2paVmRqYy96UkdlZmxnaDg3Z2hnTTRCUzdLQ0VRYUYv?=
 =?utf-8?B?ZkNyQ1VucUQ5U3hEczFzQXdZQXZ5OUtiL05DVGFMZFlELzZhRzZmRUdWYmxE?=
 =?utf-8?B?WFpqdUkzNG4wbVBxVHN2QzF5WnVRc3FRVjlrZ3hLandXQm1YVGkxSDZURi9C?=
 =?utf-8?B?bG9leWllU2FUcElHK0E0TXAwZmxHMWI0cGJyZzFpRFRtZW0vSnpaSi9WQlZq?=
 =?utf-8?B?VTR4emNqTzVRT0o0QlJkOEU4U05tU3gvRDBpR0hRb3hDMDlwN0E5UU9jUVd1?=
 =?utf-8?B?aDhWaDBtczczbTdRUjBySXYxd3RxRGVGckNqSTQrSE5SdEgxbXpZZ2kwVXB0?=
 =?utf-8?B?aUpJQ2tIUS9oU2FIMXVhalVPdnJnR1RsZERaL3c5QnpXVjZMMjlsc1B4ZC83?=
 =?utf-8?B?eDN6ZmJJZENkQ1NUcU1VZUlONXVzTWc5ODlwUEJIK3hCZ0pYWVAzMUx1RDYx?=
 =?utf-8?B?ams0cmlERkVuVE5EbGZpWmlTOW0rY0lLV1RPWlF2YVY1dTlQOUJmTmhpdVIw?=
 =?utf-8?B?Q1pZM0VxbXVqWDRtR3g5Mlk1U3B0OGhtakZLM0dlZ2hlTWFOR0t3U1BHSGZk?=
 =?utf-8?B?MGRUN1pwSkF5Yzd1TmthR3JFUnFEZy9XQW50NytNanRvb29LRmVZZ2FOUkdi?=
 =?utf-8?Q?NTwiBGojctP6TzRurP94m/Qac?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c182ae-d6af-4ffe-c7c7-08dd5aa03be3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 22:10:40.3785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq06F7knBYlUge+EB62RyjXctmnO+BWNVb36eTM2aNMVncvO7TBEbdvLLLs5dRIoeaY9ow7pcBWGZV0RghMfyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

   Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
amd-pstate-v6.15-2025-03-03
  
  
  
                                                                 for you 
to fetch changes up to 9e64cfbb06a534089ae4fc9174c01cd91323d505:

   cpufreq/amd-pstate: Drop actions in amd_pstate_epp_cpu_offline() 
(2025-03-01 06:45:50 -0600)

----------------------------------------------------------------
amd-pstate content for 6.15 (3/3/25)

A lot of code optimization to avoid cases where call paths will end up 
calling
the same writes multiple times and needlessly caching variables.  To 
accomplish
this some of the writes are now made into an atomically written "perf" 
variable.
Locking has been overhauled to ensure it only applies to the necessary 
functions.
Tracing has been adjusted to ensure trace events only are used right before
writing out to the hardware.
  
  
  
  
----------------------------------------------------------------
Dhananjay Ugwekar (10):
       cpufreq/amd-pstate: Modify the min_perf calculation in 
adjust_perf callback
       cpufreq/amd-pstate: Remove the redundant des_perf clamping in 
adjust_perf
       cpufreq/amd-pstate: Pass min/max_limit_perf as min/max_perf to 
amd_pstate_update
       cpufreq/amd-pstate: Convert all perf values to u8
       cpufreq/amd-pstate: Modularize perf<->freq conversion
       cpufreq/amd-pstate: Remove the unnecessary cpufreq_update_policy call
       cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update
       cpufreq/amd-pstate: Use scope based cleanup for cpufreq_policy refs
       cpufreq/amd-pstate: Remove the unncecessary driver_lock in 
amd_pstate_update_limits
       cpufreq/amd-pstate: Fix the clamping of perf values

Mario Limonciello (19):
       cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend
       cpufreq/amd-pstate: Show a warning when a CPU fails to setup
       cpufreq/amd-pstate: Drop min and max cached frequencies
       cpufreq/amd-pstate: Move perf values into a union
       cpufreq/amd-pstate: Overhaul locking
       cpufreq/amd-pstate: Drop `cppc_cap1_cached`
       cpufreq/amd-pstate-ut: Use _free macro to free put policy
       cpufreq/amd-pstate-ut: Allow lowest nonlinear and lowest to be 
the same
       cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL enums
       cpufreq/amd-pstate-ut: Run on all of the correct CPUs
       cpufreq/amd-pstate-ut: Adjust variable scope
       cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
       cpufreq/amd-pstate: Cache CPPC request in shared mem case too
       cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and 
*_set_epp functions
       cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
       cpufreq/amd-pstate: Drop debug statements for policy setting
       cpufreq/amd-pstate: Rework CPPC enabling
       cpufreq/amd-pstate: Stop caching EPP
       cpufreq/amd-pstate: Drop actions in amd_pstate_epp_cpu_offline()

  arch/x86/include/asm/msr-index.h   |  20 ++++----
  arch/x86/kernel/acpi/cppc.c        |   4 +-
  drivers/cpufreq/amd-pstate-trace.h |  57 +++++++++++----------
  drivers/cpufreq/amd-pstate-ut.c    | 211 
++++++++++++++++++++++++++++++++-------------------------------------------
  drivers/cpufreq/amd-pstate.c       | 666 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------------------------------------------------------
  drivers/cpufreq/amd-pstate.h       |  65 +++++++++++++-----------
  include/linux/cpufreq.h            |   3 ++
  7 files changed, 461 insertions(+), 565 deletions(-)

