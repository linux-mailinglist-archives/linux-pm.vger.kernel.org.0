Return-Path: <linux-pm+bounces-21695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92BA2EE89
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 14:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587E33A74D4
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2049122FDF5;
	Mon, 10 Feb 2025 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S9Q4nSgo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CED22F3B3;
	Mon, 10 Feb 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194721; cv=fail; b=Rv0NlZwj5Nw1FbiUTaZOy9H81GFm+myzUbbrHDqtF0N3Q8Ij91FojrIniXzcQnulUDr/DWcmWZRtp1nlFV8OOYOfOoxYm2Ta4bbespsi+nGvI1S6MNCEXIAAEmgBl/9KHUj3slpT6z/Ad+rulWL2BNz3HyxUt4Q0vN0rDoQS7Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194721; c=relaxed/simple;
	bh=rRb+peGQvMyFGPEaEZlv1nQFXTLR7vHli5ccux2muBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mEuZicSUpXeXRO1lFgsa3Dwz/Rgyk1A8MY9Olv6eBTc0bYwWFFRiyUEHI0VSaDSvVuiLzXvtYG602onBk5W/g2GFYrvTHosurvfPE3Oe8adF5hIvqyl/PPzPvbsr0WXkdBDbaIuFwZDSZr+AtrzP2E2N1XLS7v4a6Tge7cawfp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S9Q4nSgo; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvrdudC4eiOke41R2nBcBp8Ex1rOUoJp72SWKtmbxY8uxh6JfFPo4V501rKra1eHqdZjjphrduCHK1I67E4NT86yLSarvwQAzdIGY9a4+uPrAETzr8k03YXnvz537+vwgXG0jFRv+yBnFjOWYFLg6wH+8JSRWGQjiS2bHMjewlQ7rGcR4HlGQclimjqqVYglTL12fNxxIpdOu97Dga6S0QomkWlODDxhOF/OdP26Yx+2jPQw6GV/znrfaVxag4Ym5VpdcPIddJrHa4XaAU5tiT5hmQ6nhGIuliq+vp6xIH5/JjGb/MBal8hNQJs1yV2NOvtrkqsN9lHnZ2XBsLrsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5F1QHfEGZbi6QNMoTfRHnQoAEyRFT8Kvffy4CR+k1Y=;
 b=NNrxQa3TNx5sDQKNGUVGDRWIUSRKxe0zVisaZpen11kNzQEqBCyIMZ/6jmn/g5mKOGkY8eRpm808rMgha91vBwn8P/Vl0WGXEdYb3GjXlnQHf1tzMiimu7Lfs5h6YxLiXRv3ohREV8/WWAzH+EsNrdXczH9ZAt6bZm3Z5VFdzCaXs7K/nm1QBMZRb5wrJUowznLyJeSI5hR7wPzLUxrVpR00Fm/FA3tEIhCpmsqJ7krTDLc779Yw1DQneE9Gzm7eJjx10DeVlvQLy4pcqXGCXS2kCB2+joSGkcL+dxlGDwGRg39S13OpSxK1CYFB0/MLceWLxUaHCNEvOzgKFLLesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5F1QHfEGZbi6QNMoTfRHnQoAEyRFT8Kvffy4CR+k1Y=;
 b=S9Q4nSgoiwhWG+TjhhKnVSYoZZ/Z2G2bRO8n6QV097h8acQsHEC/IihCg0g/gSypET2tT49/C8BYN2AAfZlnIYGF4fdLf6AInJ8Ae0pE38s3Ibh3lMm+HRehHDkGFF3oJIEmJ/VksYRpIBg494tZUsFz6LNniUQMZYaggZtfeEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 13:38:34 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 13:38:33 +0000
Message-ID: <5577e2ad-6cd0-4fe8-a8e8-28199491ca3a@amd.com>
Date: Mon, 10 Feb 2025 19:08:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] cpufreq/amd-pstate: Move perf values into a union
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-4-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-4-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a6e837-e256-4be7-6eb4-08dd49d8369f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnEySG5FZHJUTW9YWWtZRW5wOENtUkhqSWR6KzlTWVRXanVMdzBZVmMyVUNy?=
 =?utf-8?B?cGJhUTh4Vk82V1l0eGFoOHNRcXFKYnpuRjVXOHNLY0FzWktpNnZMT0dLMk9q?=
 =?utf-8?B?dm8zQXh3MFNGd3MvOWpUWG8vdHk2bXNoUGZvRTNNcWoyR0pUTEYvdm5VdFY4?=
 =?utf-8?B?dHVhcXRKS2V2a05BdmNHeHlYM1B5dGJYb2JBRmo0YUlBS2tCeHREbmZRcHA0?=
 =?utf-8?B?dXJoMEFVSlAvRWhreXBXTU5JL0o1V2xIdTJad3J6Qm43Rm40ckJGWTNXN1pU?=
 =?utf-8?B?QURYRHBaUjJzempFYXNTMTlXdjUvaTZYditPc3llek9IL04zazVJcHY2ay8y?=
 =?utf-8?B?WFB1U3J1LzMzVFlLakdpUE5xaXAxbm5NOGlRUUtITUxEUVlncVBLcy9wdkx1?=
 =?utf-8?B?S09IeTljYjQ5aHo4amhJSHlZSkx6Vkp4ZzVLbXBPT1Q1akV6b0VLcGlHbnJN?=
 =?utf-8?B?Qmk1OFQvbkxwT2xJdDM0SmZkYmpQc2F4OEM1TFFaMzNjcEZlVzlXMkorb0tr?=
 =?utf-8?B?bkxxY3FKWTlLWlhSUExEczczaGkzWnVDVVdlb1dLcEliNjU2SVFkRDNjcnBj?=
 =?utf-8?B?dEowb2w0TnoxR1piVXlFS1V2dXFJSm1IcHhHRTUrNFZPYVNFTlVrVFMwSU9x?=
 =?utf-8?B?QTR4TWtha3JGSjdYcVd1cWwzOFI1c0ZzOHhsNDZTNWM0NlNxeTZGclpaQWlM?=
 =?utf-8?B?dDIzdlMyZW4vMFNxZ2JpQWNaMHJjWks2eVRhbjFsalJTU0phTFlVbUNwdXd1?=
 =?utf-8?B?SWtNMXR0YXQ5NXVTU0VFY3BoemdXb3FSR0d6YjM0RVdJREF4YVFyMEU0ZTRz?=
 =?utf-8?B?bXQ1YlRlR1RRWmVZNmp2dldkR1BYQzR1WjBQdkxRV1NKQ3RWTUdPakdFd1I4?=
 =?utf-8?B?QkkrbjBLb0V6Q2xZMTlpMUZMVG1DbnZqbE1KT1BiSGc2OXBWdk1UT00rNzFY?=
 =?utf-8?B?YjB2RWRhNEtGcWQ1V2pWUGR6cHJEODFBVnlLYmF6QmVMNzZEazJPTEVhTlFi?=
 =?utf-8?B?Znp1TXlrR2dCU2JaRHVxZlpndXlrL21GblRIV2Y3ZU5QdWdtZEt3ekJqM2w5?=
 =?utf-8?B?UWtPRklBT0VUblZtNXZjSjRqazd1bkZnK2ZMSlNPaW84elNCMTl6dmQxMnhC?=
 =?utf-8?B?Y3krVTNvN3NtN0FId2E3bWV1TWtJSHpJcGFwWm44bldEK0wycjZNNWRncGFu?=
 =?utf-8?B?dCtoK2RjTjJ1aDQySjJkeHZMNlhXMUUzVlQvSVNpZWM5RE1RVVR0bXg5bWhC?=
 =?utf-8?B?R2tLajhSSzJWU0lVMlhnY1BpU2JTdG1wNnhXWHNCeHVOVE5QeFYrK1lyMktG?=
 =?utf-8?B?RXBSZldyeTBic3Vld3p6RkcxWjJlMmZ2WENnRFlWY3RUR1A0cFdxNDM3bTR2?=
 =?utf-8?B?TGY5aHRnL2Q4amtXdXJwdHRaQnVFajBaV1RxVEFEZ1cwRmI2Sm1MaHZ1Uy9O?=
 =?utf-8?B?VGVESmhZTWJLTXpWYjU4VUZ3TkdSTHYwNU5mM090b21aTUU0OWtSU0QzY3Nt?=
 =?utf-8?B?cjY4R3dPa251M1h5UXJzT0VKM1dzL0dtSDhXNFZrV3FXVVRoK2Q1dkZORE53?=
 =?utf-8?B?U1ZDZGEzVUszUVhWK0ltSXpZd0g5bXBvNFFBWDFVZ0c3bkdXQU9BellLVndq?=
 =?utf-8?B?Sk5XamxzbWJmNy9waVI4Z0xpd3pEangyYTZtTWJ3VWxFVFBZbzJRRXJkZ1FI?=
 =?utf-8?B?bzMyc3BTbWc1cjBPQzlmVWZkSmVnU204K0p4MlUrSlYvSW1UNGZEeUdzN29r?=
 =?utf-8?B?bEU5bjVwRERQMllFbkRDaGd5alVOejBjZzVpU2RPYnR2UTUyZjE1QTBWUzBp?=
 =?utf-8?B?M25yNW5WaGpzaml1bkwzVUlIL2crMVdvampZb3kyeTkvWXhaWHE5VjUyemts?=
 =?utf-8?Q?KRZUiHyAdvZbx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVFRKzRBSHYreFpJZ1BGbVBSQkxRSkk1bDBqcWkxcWZ0L2hNY0NoTlM2OUxk?=
 =?utf-8?B?ZWRJVFBpYzl0MnVGaUliNFBBenM2OVJKN2psQkJzWlpoL0xBcllaVVg0VmRt?=
 =?utf-8?B?UEZ4ZkV2YWJoVjBzVWVPRFJNb2dvRGE3aFpxUWlsU092Ti9lSllBNHdzUFZy?=
 =?utf-8?B?ZlZlK055dzRabkVCQnkxN3hFMGU0eVB1Tm5mU2xKNC8ycWZqek1jRi9va01M?=
 =?utf-8?B?NW14OEhwQytrYnU1NURMSjJqWW1wVWI2Q1BBNlZYUFN1S0JyT3JPOWFCeGZi?=
 =?utf-8?B?ampqcXpDVFE3aitYcmhUS21VNTQreHpJU0hUcVRwM2s5TFd1T0I1YVVZWU42?=
 =?utf-8?B?a0M3N00va0lNWURuTTNFUkVscUxLWWU3R3RSUnk5RFR1WDFSTVVpNk50Tndj?=
 =?utf-8?B?Sk1MQzdyUVdUTTk5MGprTFdOM3doYlRDd1ZCSGh1T2crdEhiNUdjdTVrWXJF?=
 =?utf-8?B?VTMxdVFoM1lYdVRzSXlQdmlxN240eDREZElFUDFyNjFMV2ZnN3FoU3FXQTdJ?=
 =?utf-8?B?YkEwNnN4MWVHUmtycVZrTVlqWklidmVrYjRaeUlST0tpZG5WRU9aMWlyVEZS?=
 =?utf-8?B?RXlyempVbmlYZmRRMEloQTV5L0c2Um5jTCs3eXRPTlFwS0xyMmVSNjV3TjJp?=
 =?utf-8?B?RndoR1RnU20rdGt4M0ZhMXN5TlRZVjFzSVhkbEJjVGNyd1cwWWx1a0RpMUhw?=
 =?utf-8?B?Ry9uUlJlZEJIK3Y0K1pLclBwbWVoN1FLNkQwYWhBTEF3MFNiU1ZqL1FUQlQ0?=
 =?utf-8?B?RHF4ZkFjNjNiQWlMYS9QTnZjQkpjYnVMRzZUODA4bFZDb0xVOTVQMWhKcnRD?=
 =?utf-8?B?U2dmcHM3Q2dDaDVCK1lrc0J2OGM5bEc2NHVzL0ZGemZLbnZtZkpEejdTa3Y0?=
 =?utf-8?B?QjZtNDNSMGc0bit0OXRIRFV1STFUeW5JZFM1dzFwRHJHN0g4WDQ5Q2p0N1Jx?=
 =?utf-8?B?WC8vb3hxYnhKMDBPWVIweGJjMDZPVFdnUmMxdmZsR05NOXp1OE5URXNpVVZx?=
 =?utf-8?B?cjJnaGpzS3pYWlIvVFhOK05RR1BaOWVaZ1kwWDJsUm9xTmpZc3lIdjhLbkRW?=
 =?utf-8?B?bktvSGtIT2M3VDFKOUFuV3g1UGtreFNhamxBdGJieWZUSDZHUHJpQURhbVgx?=
 =?utf-8?B?OXZNellhVGlmRmhxT0RYK2p4Z0RtRkhob281U0dOYkdGRk53eEdULzQ3aHNN?=
 =?utf-8?B?eTBtTjFaN21rUC83ZjdRcXJmK3p5QldISTZtRlU1emdLNjZHaTk5RHd5UEhh?=
 =?utf-8?B?bnJ4ejZRYUJxKzA3TWd1dzZzVmE4dzlLbnNYTFNBM0xvTUZxSWJZaVdQQVJP?=
 =?utf-8?B?NU9ISVNTWGx2QTZoSXJDOWpEajZZRTZwWDBzSFhiSjdTMUNkY0NkOHV6Ym90?=
 =?utf-8?B?aDk2L0E1UzN2V0hiajMycUVScU5PRy9zM2tiSmV0Sk5ycUdlSHBlNloreGlo?=
 =?utf-8?B?bUI2SkxYUjlmN09HbzZpWVNzUnpyRjdEVGxYOUZXYTVXaEl0RThCZnQ0dDFP?=
 =?utf-8?B?bWRDNUhCczdIVWJLRS8wQVluSG4wcEdadXF6Y1YzdHNMRy9yT3BXVC9uYU5J?=
 =?utf-8?B?VXlWYXJCYmo4dHc4NGF0M0k1cy9uZEFLcThVNVhoenJtWW0xQmxrMG5ucEox?=
 =?utf-8?B?RXZueWVLR2lYN0hoYWQyNUVkYzlQMHJVdWpGWFBlTGZja3VOSFV2Ry9PWGNU?=
 =?utf-8?B?cnBMMlhOR3pIR0tPVW1RVWFLNW1MRXFQOXJFaE8rQ1dkVmRFKzAzWGhoOFR5?=
 =?utf-8?B?eVpVMnVtSGxVbmZsUGhGRmlsU2lWRnoyWVE2MWllc1IyQkEwSnVyV0txOU5a?=
 =?utf-8?B?d3lUN2d5ZDArVExLRGFuR3U5ak00aURXdDl2Tm5IcWVuRy9qekVtK0NCcm01?=
 =?utf-8?B?dmZPKzVXeTllRkRQUU12MU5NNlMySmtUQU1iNnRWVHNaSjZlSlgybnBJa2lG?=
 =?utf-8?B?dUFHaXpQTndoNzM4dGJkU0FpZERiWHRDZ1Q4aTNpSFQ5NEMxcktFY0kzSkJD?=
 =?utf-8?B?Nm1oZ2ZLc0tZaUVCR1dXR21WVGY5bjN1WEZDOVFpRThka1FnWGZSN0xyYW9n?=
 =?utf-8?B?VGxQODdaSFRUcWFyVWsxem9xVi9JZUtwOGtURmd1N21DWUxFbzFrNVBycnZZ?=
 =?utf-8?Q?BXhD9X1HBIZbBRXCYm+gwU2wd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a6e837-e256-4be7-6eb4-08dd49d8369f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 13:38:33.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpD4fIBa6hg0p3oURfLOmrc3tL+xBLsdKMvdyzBuuBM0lgbQYwVjFEPGINpClHUJsYuC6w5siyKOCGDOhsNizw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> By storing perf values in a union all the writes and reads can
> be done atomically, removing the need for some concurrency protections.
> 
> While making this change, also drop the cached frequency values,
> using inline helpers to calculate them on demand from perf value.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c |  17 +--
>  drivers/cpufreq/amd-pstate.c    | 212 +++++++++++++++++++-------------
>  drivers/cpufreq/amd-pstate.h    |  48 +++++---
>  3 files changed, 163 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 445278cf40b61..d9ab98c6f56b1 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -162,19 +162,20 @@ static void amd_pstate_ut_check_perf(u32 index)
>  			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
>  		}
>  
> -		if (highest_perf != READ_ONCE(cpudata->highest_perf) && !cpudata->hw_prefcore) {
> +		if (highest_perf != READ_ONCE(cpudata->perf.highest_perf) &&
> +		    !cpudata->hw_prefcore) {
>  			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
> -				__func__, cpu, highest_perf, cpudata->highest_perf);
> +				__func__, cpu, highest_perf, cpudata->perf.highest_perf);
>  			goto skip_test;
>  		}
> -		if ((nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
> -			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
> -			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
> +		if ((nominal_perf != READ_ONCE(cpudata->perf.nominal_perf)) ||
> +			(lowest_nonlinear_perf != READ_ONCE(cpudata->perf.lowest_nonlinear_perf)) ||
> +			(lowest_perf != READ_ONCE(cpudata->perf.lowest_perf))) {

How about making a local copy of cpudata->perf and using that, instead of dereferencing the 
cpudata pointer multiple times, something like,

		union perf_cached cur_perf = READ_ONCE(cpudata->perf);
		if ((nominal_perf != cur_perf.nominal_perf) ||
		    (lowest_nonlinear_perf != cur_perf.lowest_nonlinear_perf)) ||
		    (lowest_perf != cur_perf.lowest_perf)) {

>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
> -				__func__, cpu, nominal_perf, cpudata->nominal_perf,
> -				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
> -				lowest_perf, cpudata->lowest_perf);
> +				__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
> +				lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
> +				lowest_perf, cpudata->perf.lowest_perf);
>  			goto skip_test;
>  		}
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 668377f55b630..77bc6418731ee 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -142,18 +142,17 @@ static struct quirk_entry quirk_amd_7k62 = {
>  	.lowest_freq = 550,
>  };
>  
> -static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
> +static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
>  {
> -	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
> -					cpudata->nominal_freq);
> +	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
>  
> -	return clamp_t(u8, perf_val, cpudata->lowest_perf, cpudata->highest_perf);
> +	return clamp_t(u8, perf_val, perf.lowest_perf, perf.highest_perf);
>  }
>  
> -static inline u32 perf_to_freq(struct amd_cpudata *cpudata, u8 perf_val)
> +static inline u32 perf_to_freq(union perf_cached perf, u32 nominal_freq, u8 perf_val)
>  {
> -	return DIV_ROUND_UP_ULL((u64)cpudata->nominal_freq * perf_val,
> -				cpudata->nominal_perf);
> +	return DIV_ROUND_UP_ULL((u64)nominal_freq * perf_val,
> +				perf.nominal_perf);
>  }
>  
>  static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
> @@ -347,7 +346,9 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>  	}
>  
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> +		union perf_cached perf = cpudata->perf;
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  epp,
>  					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
>  					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> @@ -425,6 +426,7 @@ static inline int amd_pstate_cppc_enable(bool enable)
>  
>  static int msr_init_perf(struct amd_cpudata *cpudata)
>  {
> +	union perf_cached perf = cpudata->perf;
>  	u64 cap1, numerator;
>  
>  	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> @@ -436,19 +438,21 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>  	if (ret)
>  		return ret;
>  
> -	WRITE_ONCE(cpudata->highest_perf, numerator);
> -	WRITE_ONCE(cpudata->max_limit_perf, numerator);
> -	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
> -	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> -	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
> +	perf.highest_perf = numerator;
> +	perf.max_limit_perf = numerator;
> +	perf.min_limit_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +	perf.nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
> +	perf.lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
> +	perf.lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +	WRITE_ONCE(cpudata->perf, perf);
>  	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
> -	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
>  	return 0;
>  }
>  
>  static int shmem_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> +	union perf_cached perf = cpudata->perf;
>  	u64 numerator;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> @@ -459,14 +463,14 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>  	if (ret)
>  		return ret;
>  
> -	WRITE_ONCE(cpudata->highest_perf, numerator);
> -	WRITE_ONCE(cpudata->max_limit_perf, numerator);
> -	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
> -	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> -		   cppc_perf.lowest_nonlinear_perf);
> -	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +	perf.highest_perf = numerator;
> +	perf.max_limit_perf = numerator;
> +	perf.min_limit_perf = cppc_perf.lowest_perf;
> +	perf.nominal_perf = cppc_perf.nominal_perf;
> +	perf.lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> +	perf.lowest_perf = cppc_perf.lowest_perf;
> +	WRITE_ONCE(cpudata->perf, perf);
>  	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
> -	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE)
>  		return 0;
> @@ -549,14 +553,14 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
>  {
>  	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
> -	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
>  
>  	if (!policy)
>  		return;
>  
>  	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
>  
> -	policy->cur = perf_to_freq(cpudata, des_perf);
> +	policy->cur = perf_to_freq(perf, cpudata->nominal_freq, des_perf);
>  
>  	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
>  		min_perf = des_perf;
> @@ -565,7 +569,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  
>  	/* limit the max perf when core performance boost feature is disabled */
>  	if (!cpudata->boost_supported)
> -		max_perf = min_t(u8, nominal_perf, max_perf);
> +		max_perf = min_t(u8, perf.nominal_perf, max_perf);
>  
>  	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
>  		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
> @@ -602,36 +606,41 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  	return 0;
>  }
>  
> -static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
> +static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  {
> -	u8 max_limit_perf, min_limit_perf;
>  	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
>  
> -	max_limit_perf = freq_to_perf(cpudata, policy->max);
> -	min_limit_perf = freq_to_perf(cpudata, policy->min);
> +	if (policy->min == perf_to_freq(perf, cpudata->nominal_freq, perf.min_limit_perf) &&
> +	    policy->max == perf_to_freq(perf, cpudata->nominal_freq, perf.max_limit_perf))
> +		return;

I guess we can remove this check once we reinstate the min/max_limit_freq caching in cpudata as 
discussed in patch #2, right?

>  
> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> -		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
> +	perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
> +	perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
>  
> -	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> -	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
>  
> -	return 0;
> +	WRITE_ONCE(cpudata->perf, perf);
>  }
>  
>  static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  				  unsigned int target_freq, bool fast_switch)
>  {
>  	struct cpufreq_freqs freqs;
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
>  	u8 des_perf;
>  
>  	amd_pstate_update_min_max_limit(policy);
>  
> +	cpudata = policy->driver_data;

Any specific reason why we moved this dereferencing after amd_pstate_update_min_max_limit() ?

> +	perf = READ_ONCE(cpudata->perf);
> +
>  	freqs.old = policy->cur;
>  	freqs.new = target_freq;
>  
> -	des_perf = freq_to_perf(cpudata, target_freq);
> +	des_perf = freq_to_perf(perf, cpudata->nominal_freq, target_freq);

Personally I preferred the earlier 2 argument format for the helper functions, as the helper
function handled the common dereferencing part, (i.e. cpudata->perf and cpudata->nominal_freq)

>  
>  	WARN_ON(fast_switch && !policy->fast_switch_enabled);
>  	/*
> @@ -642,8 +651,8 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  	if (!fast_switch)
>  		cpufreq_freq_transition_begin(policy, &freqs);
>  
> -	amd_pstate_update(cpudata, cpudata->min_limit_perf, des_perf,
> -			  cpudata->max_limit_perf, fast_switch,
> +	amd_pstate_update(cpudata, perf.min_limit_perf, des_perf,
> +			  perf.max_limit_perf, fast_switch,
>  			  policy->governor->flags);
>  
>  	if (!fast_switch)
> @@ -672,19 +681,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  				   unsigned long target_perf,
>  				   unsigned long capacity)
>  {
> -	u8 max_perf, min_perf, des_perf, cap_perf, min_limit_perf;
> +	u8 max_perf, min_perf, des_perf, cap_perf;
>  	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
>  	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
>  
>  	if (!policy)
>  		return;
>  
> -	cpudata = policy->driver_data;
> -
>  	amd_pstate_update_min_max_limit(policy);
>  
> -	cap_perf = READ_ONCE(cpudata->highest_perf);
> -	min_limit_perf = READ_ONCE(cpudata->min_limit_perf);
> +	cpudata = policy->driver_data;

Similar question as above

> +	perf = READ_ONCE(cpudata->perf);
> +	cap_perf = perf.highest_perf;
>  
>  	des_perf = cap_perf;
>  	if (target_perf < capacity)
> @@ -695,10 +704,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	else
>  		min_perf = cap_perf;
>  
> -	if (min_perf < min_limit_perf)
> -		min_perf = min_limit_perf;
> +	if (min_perf < perf.min_limit_perf)
> +		min_perf = perf.min_limit_perf;
>  
> -	max_perf = cpudata->max_limit_perf;
> +	max_perf = perf.max_limit_perf;
>  	if (max_perf < min_perf)
>  		max_perf = min_perf;
>  
> @@ -709,11 +718,12 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
>  	u32 nominal_freq, max_freq;
>  	int ret = 0;
>  
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	max_freq = perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf));
> +	max_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
>  
>  	if (on)
>  		policy->cpuinfo.max_freq = max_freq;
> @@ -884,25 +894,24 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>  }
>  
>  /*
> - * amd_pstate_init_freq: Initialize the max_freq, min_freq,
> - *                       nominal_freq and lowest_nonlinear_freq for
> - *                       the @cpudata object.
> + * amd_pstate_init_freq: Initialize the nominal_freq and lowest_nonlinear_freq
> + *			 for the @cpudata object.
>   *
> - *  Requires: highest_perf, lowest_perf, nominal_perf and
> - *            lowest_nonlinear_perf members of @cpudata to be
> - *            initialized.
> + * Requires: all perf members of @cpudata to be initialized.
>   *
> - *  Returns 0 on success, non-zero value on failure.
> + * Returns 0 on success, non-zero value on failure.
>   */
>  static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
> -	int ret;
>  	u32 min_freq, nominal_freq, lowest_nonlinear_freq;
>  	struct cppc_perf_caps cppc_perf;
> +	union perf_cached perf;
> +	int ret;
>  
>  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
> +	perf = READ_ONCE(cpudata->perf);
>  
>  	if (quirks && quirks->nominal_freq)
>  		nominal_freq = quirks->nominal_freq;
> @@ -914,6 +923,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  	if (quirks && quirks->lowest_freq) {
>  		min_freq = quirks->lowest_freq;
> +		perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
>  	} else
>  		min_freq = cppc_perf.lowest_freq;
>  
> @@ -929,7 +939,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  		return -EINVAL;
>  	}
>  
> -	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
> +	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>  
>  	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
> @@ -944,6 +954,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
>  	struct device *dev;
>  	int ret;
>  
> @@ -979,8 +990,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>  	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>  
> -	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
> +	perf = READ_ONCE(cpudata->perf);
> +
> +	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
> +							      cpudata->nominal_freq,
> +							      perf.lowest_perf);
> +	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
> +							      cpudata->nominal_freq,
> +							      perf.highest_perf);
>  
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
> @@ -1061,23 +1078,33 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
>  static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  					char *buf)
>  {
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
> +
> +	if (!policy)
> +		return -EINVAL;

Do we need to check the policy if it is being passed by a sysfs file access? 

I dont see similar check in show_one based sysfs functions in cpufreq.c, they just dereference 
it directly.

#define show_one(file_name, object)                     \
static ssize_t show_##file_name                         \
(struct cpufreq_policy *policy, char *buf)              \
{                                                       \
        return sysfs_emit(buf, "%u\n", policy->object); \
}

show_one(cpuinfo_min_freq, cpuinfo.min_freq);
show_one(cpuinfo_max_freq, cpuinfo.max_freq);
show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
show_one(scaling_min_freq, min);
show_one(scaling_max_freq, max)

>  
> +	cpudata = policy->driver_data;
> +	perf = READ_ONCE(cpudata->perf);
>  
> -	return sysfs_emit(buf, "%u\n", perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf)));
> +	return sysfs_emit(buf, "%u\n",
> +			  perf_to_freq(perf, cpudata->nominal_freq, perf.max_limit_perf));

For example, this function was lot cleaner before, as perf_to_freq() handled the common 
dereferencing part.

>  }
>  
>  static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
>  						     char *buf)
>  {
> -	int freq;
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
> +
> +	if (!policy)
> +		return -EINVAL;

Similar reason, is this check needed

>  
> -	freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
> -	if (freq < 0)
> -		return freq;
> +	cpudata = policy->driver_data;
> +	perf = READ_ONCE(cpudata->perf);
>  
> -	return sysfs_emit(buf, "%u\n", freq);
> +	return sysfs_emit(buf, "%u\n",
> +			  perf_to_freq(perf, cpudata->nominal_freq, perf.lowest_nonlinear_perf));

Same comment about doing the dereferencing in helper function.

>  }
>  
>  /*
> @@ -1087,12 +1114,14 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>  static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  					    char *buf)
>  {
> -	u8 perf;
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata;
>  
> -	perf = READ_ONCE(cpudata->highest_perf);
> +	if (!policy)
> +		return -EINVAL;

Same comment, can we remove if unnecessary

>  
> -	return sysfs_emit(buf, "%u\n", perf);
> +	cpudata = policy->driver_data;
> +
> +	return sysfs_emit(buf, "%u\n", cpudata->perf.highest_perf);
>  }
>  
>  static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
> @@ -1423,6 +1452,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
>  static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
>  	struct device *dev;
>  	u64 value;
>  	int ret;
> @@ -1456,8 +1486,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> -	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
> +	perf = READ_ONCE(cpudata->perf);
> +
> +	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
> +							      cpudata->nominal_freq,
> +							      perf.lowest_perf);
> +	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
> +							      cpudata->nominal_freq,
> +							      perf.highest_perf);
> +
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> @@ -1518,6 +1555,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf;
>  	u8 epp;
>  
>  	amd_pstate_update_min_max_limit(policy);
> @@ -1527,15 +1565,16 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	else
>  		epp = READ_ONCE(cpudata->epp_cached);
>  
> +	perf = READ_ONCE(cpudata->perf);
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
> -					  cpudata->min_limit_perf,
> -					  cpudata->max_limit_perf,
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf, epp,
> +					  perf.min_limit_perf,
> +					  perf.max_limit_perf,
>  					  policy->boost_enabled);
>  	}
>  
> -	return amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> -				      cpudata->max_limit_perf, epp, false);
> +	return amd_pstate_update_perf(cpudata, perf.min_limit_perf, 0U,
> +				      perf.max_limit_perf, epp, false);
>  }
>  
>  static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> @@ -1567,23 +1606,21 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u8 max_perf;
> +	union perf_cached perf = cpudata->perf;

Do we have a rule for when READ_ONCE is needed and when it isnt?
I'm a bit fuzzy on this one, as to how to decide. Any rule of thumb?

>  	int ret;
>  
>  	ret = amd_pstate_cppc_enable(true);
>  	if (ret)
>  		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
>  
> -	max_perf = READ_ONCE(cpudata->highest_perf);
> -
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  cpudata->epp_cached,
>  					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
> -					  max_perf, policy->boost_enabled);
> +					  perf.highest_perf, policy->boost_enabled);
>  	}
>  
> -	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
> +	return amd_pstate_update_perf(cpudata, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
>  }
>  
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> @@ -1604,22 +1641,21 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u8 min_perf;
> +	union perf_cached perf = cpudata->perf;
>  
>  	if (cpudata->suspended)
>  		return 0;
>  
> -	min_perf = READ_ONCE(cpudata->lowest_perf);
> -
>  	guard(mutex)(&amd_pstate_limits_lock);
>  
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
> -					  min_perf, min_perf, policy->boost_enabled);
> +					  perf.lowest_perf, perf.lowest_perf,
> +					  policy->boost_enabled);
>  	}
>  
> -	return amd_pstate_update_perf(cpudata, min_perf, 0, min_perf,
> +	return amd_pstate_update_perf(cpudata, perf.lowest_perf, 0, perf.lowest_perf,
>  				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
>  }
>  
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 472044a1de43b..a140704b97430 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -13,6 +13,34 @@
>  /*********************************************************************
>   *                        AMD P-state INTERFACE                       *
>   *********************************************************************/
> +
> +/**
> + * union perf_cached - A union to cache performance-related data.
> + * @highest_perf: the maximum performance an individual processor may reach,
> + *		  assuming ideal conditions
> + *		  For platforms that do not support the preferred core feature, the
> + *		  highest_pef may be configured with 166 or 255, to avoid max frequency
> + *		  calculated wrongly. we take the fixed value as the highest_perf.
> + * @nominal_perf: the maximum sustained performance level of the processor,
> + *		  assuming ideal operating conditions
> + * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
> + *			   savings are achieved
> + * @lowest_perf: the absolute lowest performance level of the processor
> + * @min_limit_perf: Cached value of the performance corresponding to policy->min
> + * @max_limit_perf: Cached value of the performance corresponding to policy->max
> + */
> +union perf_cached {
> +	struct {
> +		u8	highest_perf;
> +		u8	nominal_perf;
> +		u8	lowest_nonlinear_perf;
> +		u8	lowest_perf;
> +		u8	min_limit_perf;
> +		u8	max_limit_perf;
> +	};
> +	u64	val;
> +};
> +
>  /**
>   * struct  amd_aperf_mperf
>   * @aperf: actual performance frequency clock count
> @@ -30,20 +58,8 @@ struct amd_aperf_mperf {
>   * @cpu: CPU number
>   * @req: constraint request to apply
>   * @cppc_req_cached: cached performance request hints
> - * @highest_perf: the maximum performance an individual processor may reach,
> - *		  assuming ideal conditions
> - *		  For platforms that do not support the preferred core feature, the
> - *		  highest_pef may be configured with 166 or 255, to avoid max frequency
> - *		  calculated wrongly. we take the fixed value as the highest_perf.
> - * @nominal_perf: the maximum sustained performance level of the processor,
> - *		  assuming ideal operating conditions
> - * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
> - *			   savings are achieved
> - * @lowest_perf: the absolute lowest performance level of the processor
>   * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
>   * 		  priority.
> - * @min_limit_perf: Cached value of the performance corresponding to policy->min
> - * @max_limit_perf: Cached value of the performance corresponding to policy->max
>   * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
>   * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
>   * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
> @@ -66,13 +82,9 @@ struct amd_cpudata {
>  	struct	freq_qos_request req[2];
>  	u64	cppc_req_cached;
>  
> -	u8	highest_perf;
> -	u8	nominal_perf;
> -	u8	lowest_nonlinear_perf;
> -	u8	lowest_perf;
> +	union perf_cached perf;

Can we please add the description for this in the comment above

> +
>  	u8	prefcore_ranking;
> -	u8	min_limit_perf;
> -	u8	max_limit_perf;
>  
>  	u32	nominal_freq;
>  	u32	lowest_nonlinear_freq;


