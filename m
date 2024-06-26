Return-Path: <linux-pm+bounces-10026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490A917A40
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 09:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413631C23629
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A084B15ECF7;
	Wed, 26 Jun 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OMqpQy+G"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172E15ECF3;
	Wed, 26 Jun 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388583; cv=fail; b=ETla4w5i1PbfTnC/dZTBhAm2E+phCC1WYNWl908G5dNnJ2f7HFp3q+WaeWYlqVPZPUsvIRuT3xashrf/Pn96AIvKB/Ng9PbOIe111TTt2uXGl0Of4WTo2TMf9v5oc9nKRT0AJpXFi3b6zG4o0DrurgdS1G9yAKPtT/goeWYlqiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388583; c=relaxed/simple;
	bh=hu1dKRcnmnl6J89SrKVjiesVGRrTTW8Ego+m/bBL0lg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HoQzh25JPUZFeGlJQ0YXI+pii4mqNWMKIHov6ocV4FItRnf98hUCHooXsS2hCexVqKeZhrcaB0Du8UwLncAqug1VGliIDTJvV1ED4izqkB3eZ4PV6NKleavx1NpPO1CZfGhi0v1XThZQp5kNa5/93+cWNzw0jDvGSnKwOUFFXwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OMqpQy+G; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB1TW+D1wdwVCw5epMpQ1EPybywF6wdirJ6n8+qan+ap0gWg5BGYTg1emRUaU5PtnORg19SjuTHutJIZUNBOnkfH8PqCyNJgVHnNfNZFtWCLKWDFRAm5O7LhgsRi7RmHecTG+t9rVn2GwkF07wJgX12dnu6D9ulZ1l5KVljHiS1YG7RDUnZnUjF6t0Z9tslbyZh60BXAUFJn1HrGI7bNtdr3By+zXXI0z3dGWutOH1xGtlYp07gTAAJ4mPBjLtr266NDVPaJejjGCUQUhUhPnZRwcF3otq8yPb1R+w4EbirUxvXm76IEdyny5+AuXbAqs4Zhm+X3vBmhHU5ob0tLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDK9SJyS7cgfCvxf6oVXUNtbVdHnWQuQdrb2juar6DE=;
 b=h/ZiOWeLZ+RwxsB2kQNUBsybznxyEbyJmRxxHTWxv7lKF+Ue//NOo78HQpKQxVIOn5UOh45pkXFGVCz/a9Oz8fHN/amgDZPqcwF5grQyuXN2sYdgHmHphs20/S6zaQpx75gjQycX3aS/q1D6pFL0x6h33oNLZQZhhe2YUg+daGbft1hQy3WZ3nomBYOnwak/q441Q9RsyccHe1tUOecBfjrvGplXjGkTb0pHiv/W4Xwyg4Y087S7YJ+bwQWlMXE9UYYy8ZjmWGtznIAkyyfanvsOxWpSQQ6SgwYVTAdlibM601Yix9ok7KtKy0aOZqyuFWpFX87hibIa4Nywq+wu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDK9SJyS7cgfCvxf6oVXUNtbVdHnWQuQdrb2juar6DE=;
 b=OMqpQy+GR0RL/0/TMEi87HGzW5xycczTOa0sPPk/aTs8LExYuSrsvq1aJsxgMyw7xNEvwRR+b9w2LpWht9TIj/RMmDInzR6/kWgqtyIryOzmROuQf8DbQn9c9Wk5m8EfCtPKBYfZzUOo05hKqGQCvijYDE3J3Ts7HOWVrF23urE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 07:56:18 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 07:56:18 +0000
Message-ID: <e1132f04-9569-4f64-9b6a-96cd810ef5b8@amd.com>
Date: Wed, 26 Jun 2024 13:26:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael@kernel.org, viresh.kumar@linaro.org, gautham.shenoy@amd.com,
 perry.yuan@amd.com, skhan@linuxfoundation.org, li.meng@amd.com,
 ray.huang@amd.com
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
 <95bdfe3e-610f-43de-be2e-294cf2576fc8@amd.com>
 <e9811d4e-60bb-49ea-80da-5d4597ef8705@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <e9811d4e-60bb-49ea-80da-5d4597ef8705@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6252fd-2ba8-4218-b410-08dc95b57631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2krWlZsUE91dUZUVzQvTnVrZTdGeWcrZzJRR0pNQ01TdU0yUXFYZG93L2RV?=
 =?utf-8?B?RnM3SlRkNnRyVHZNZFdXMDNqYktsMWgxZFhwTjdxT3JtU3NqV2E5aGwwQTd0?=
 =?utf-8?B?dS8zaSt1RW44TXFaalpGVXFpa0xtZk5zcWtVaW5VTHpveW5GY0JSZmF6aUVE?=
 =?utf-8?B?UGdrY2U5WGYvcmNhN0pXYzhoL0JZVTdieHlRRGhyclV5dElnOHY1N0NTMjQx?=
 =?utf-8?B?enFMR2JyQzdwRllhQ2ZyMmhCa2h4eUdxWXhzZngvb2c5SW5CcWM2aU0ybzkv?=
 =?utf-8?B?b3BuS2Yvem5OMzZXQVB1eTVvN2YyRWNrUjEyMzZwbDFVT1lEaTM4N0xDLzl6?=
 =?utf-8?B?OHRjaHBXV05MemxvNDJFV25tWlNlNHhQL21hM1NBWlliekNaM3pUOXVPTmtM?=
 =?utf-8?B?UUJFVitJWkg1NFlJQnJNRUQrSmpwK3BrWnFCMzRWT1grc215SkxqcG4xZTRq?=
 =?utf-8?B?dzBFdzVpTndpd1RaZ0hpNStSSHJNM3g1RFM1ckIxMUU4SXFwSUxQVDViOFB3?=
 =?utf-8?B?VjZLaVhRNFRESGtuMDF4TUN5TERhTTBFTG5NT0VTbUxNbTVqWWRKTE1nNitK?=
 =?utf-8?B?OXBWaUpUTXVXdXdTZ0N6QnZyc1lJWUdXVnpRZWtEZXl5K0lXNGVWRWc1d3Zn?=
 =?utf-8?B?ZXpvYzdlV0s3UHRkek8xWVU0c2c3V1dUbFlRazh1bTIxeFQ2WHRBOFlwOC84?=
 =?utf-8?B?NUxNS2FCNFp3WndoNVBreHE4YUdZVis1ZEwvMFZjYi8yeEdSTktGNEdiV0ly?=
 =?utf-8?B?Ry9hSk1OK3NYZWFJSzFVektqaWVWdmdJTEtOSUFweldKYmVRQlhwZnNIOXh6?=
 =?utf-8?B?dzlqYS9wMGlDUEZnYjlseXRFNVFzenlvbXJYS0RvVXJNSUVqbi8rVnBuem5n?=
 =?utf-8?B?VElGQUYxQTNqbjh3anhsQ2dYU2R6alF2NGRTVmhNZnduTE41bFUzbktqWFVG?=
 =?utf-8?B?N3VYWDN3TVRIRG1JMXY2RHJtb2taQ1ZSYm1UVTRRaUZ3QTFZcmkvdkJoa2Zw?=
 =?utf-8?B?VTByUHpVRXBOYVdJbzd3KzF3cHZXeWZ6Q29JcTVvQ1pIcWhwc0lYd1VRS0x0?=
 =?utf-8?B?VlAyTCtISVNLYUZZYmhYSHdRVmY1dmYzcXhaWGJlSnF4QkxZdEVXVllGVzFF?=
 =?utf-8?B?c2V3MVI5MEZBUFdSZnJWOEdFZ2RuaFZqYkNMZXNBekk3NkJFSTEzbTFobXM0?=
 =?utf-8?B?MkIwL25HTzEvdnN3Wk5tYnBlb1RoVHVlRGFxWDJYL3dJRytUb2hLbnIwTTFW?=
 =?utf-8?B?dEFyZ3YrSFYxOGtZcWhCd1Q3VTRDVi92alRiVG1weTZBc0dMOXpjY1BKSnhR?=
 =?utf-8?B?anU0ekNTczM3T0VhWlJicU83d3FKZ0s0ZkZBV2xCUzZkc2FKWGdtU2V1eFZa?=
 =?utf-8?B?czZ4dUgvT1IyVmZqRXkzU2ZQSUVyMlpnYWY3TGJYNmp3a0NJRElkelpSSWs2?=
 =?utf-8?B?RWdZcTh5M1RrOEloWDhCc0VhUllNOXpxSS9ZMXZEN2JpbFU1WE9xMVhwa1Y2?=
 =?utf-8?B?NVdPQ3dxRGJ2VUhHTTA4VzdPUnFSOGFEZ2Y5NEIyOEk5a2Frcmk5VmcxT3dM?=
 =?utf-8?B?VmxHWmJZckp5TzVyQlA3akVtQzFKQVRQOHRxNCtCaC90ekpyTlU3SUVFZ2No?=
 =?utf-8?B?SWUvNkpOUFNabm16ZXBqUXJYVmdTc3hsNDd4Y2I1NEFHNFgzYmlXRHZhZmZ5?=
 =?utf-8?B?TzRpeFBuQnJwczFNY3pCSWdEK2Q3ak5tandRbnczeDBpcDBYeVRKUkE4cDBH?=
 =?utf-8?Q?GphZcIJK2ClXGmaf0iER7ByGMT82n3aKFJsqYCv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUZ2T2JOMEE2RHhkMHpuWFlOa0JoNm91U2h6N3FkNVB0Um96SWtpSEp2a3ov?=
 =?utf-8?B?a2I0NVFvU3M3RTI2Q2EwVFA2aEdGOTFtSFRFaTRScG41ZkxadnI1OHJxdlky?=
 =?utf-8?B?ZG9sS1Q5OVduVHZkdmM2WGVzTnpaS2RPN3o1SmFhUlVzRWpyKzhHTVlTUFUr?=
 =?utf-8?B?dUFiQUx5bkhTR3czclB4L2VSRFlxYXR6cWVCRmNVRDhGTHRyUVNhZit2NDVC?=
 =?utf-8?B?cUJ0SnplTTliYTFvRXYzcGhTdWdhTnNUZUxJNUFvUlQ0L25NK3FEUXlDTXVX?=
 =?utf-8?B?VlY0RGdLVlhhb0VwUFZ0WmV2ZFlyWEM5dVdOZTZzZmllSWljY2lweHF6dEli?=
 =?utf-8?B?Ymh0dGgza2syY2dESFdaVUdzYWZvR2s1eEsxN2RVVjd6a0RWb1ovUjdnOE1M?=
 =?utf-8?B?L1U1L1VoWnUyNlg3bHF5NHFranh4UnFkYktmSTVIOVc5VGF5UTJpWDd0R2Nt?=
 =?utf-8?B?Y1p4T1l1bzVmYmlVMUZzclBrUitscmQ2c0EyTXl3WUdINmJWU0Q1c3V4VE5o?=
 =?utf-8?B?eFpERXBkNk83U05lZnNvRWFldEdKWkxEcXVnZ0wyM0tQa2RNUDRvSTNFU2JW?=
 =?utf-8?B?d2tKbzhRaDJmNVFTUHFCd1Ewd1ZMQllXQXZmc20ySDhVYnZLSmdIVVVZdWJL?=
 =?utf-8?B?b1lkTDJCLy96cFh1ZERkcGttSHF1OVQ1c2lnbTlvbDhEZFh0bG1mbGFJcjlR?=
 =?utf-8?B?YVNzRmREYyt4Ty83bjFDbWZvQXlXdTFIOFNxVTlqaXMzNlBmeVpDU1FFVkt6?=
 =?utf-8?B?eE9qaDR5aERySEVScEFYczVkLzBPS1VnRTl5anBQbi9WeUlWeC8reDhld0VI?=
 =?utf-8?B?S0NHWDV5ZnVwOEFaclZlOGJlcWNGc1VSQ25RQndsL0hrcHpNT0sydEE1dHdK?=
 =?utf-8?B?b2JiKzRnSkt3c2RFZis0UWFiZUx2R1VielA4WE9ISmFqK3hJM2hObit1Q3Jl?=
 =?utf-8?B?OGdDeU1TNzQxWE5aK3NYL2VtYmN5QS9wNTZFL2w2aVFxTlFWeGJlVmROaFBr?=
 =?utf-8?B?Szhidm1xNzBoemsyTW14V0crc21PWW91dVgvVzNocnVMNUpGYU80c0RaeWpy?=
 =?utf-8?B?a0J0R253NmdWenJ2VHBzMXYyU25JMHZVQzhxQUxmU3hWVlN1SGI3ZW9rdGVF?=
 =?utf-8?B?TU1UVHUyc3QvcW8ydE1BemVlLzVUYmV1TjRiQm5Ua21RS1dmSi8xRjZkdXhm?=
 =?utf-8?B?SnpSMU44ZDc5TTVRbTlwSjhkckpWd204a0RhajhXRUVhem9uZ1R0U0MwYkt1?=
 =?utf-8?B?S3VrdUI5VmtqMXdvelFIQ0J5ckhjUVB4U2JoUjBESmJ6MXlSQmZQVEs2elY3?=
 =?utf-8?B?UFVFa1hUc1UxOHU2NUtDMEE5aS9SOE43MHBIaTl0cDVzbnhGdHFDWWhIT3Vu?=
 =?utf-8?B?bU5ldWE4eEJ1U1BLenRSajdneWd2bUZhMCtaNlJsaFQ4Uy96VU5OZlFUS3di?=
 =?utf-8?B?UlhzVStMaXo2amlkbUkxejFzbFNsVTJtTUZsRkVmdHpPNkMwM21XdStCajBT?=
 =?utf-8?B?aEJweUp5TlpNR0wzeFRxQXBFbk9uZFFYTzR4bzJ3NnRwZUtwSFdETTlFZUV1?=
 =?utf-8?B?L2pnNTdhU29FTVVMQkhQSzFJZUVBTHhCVklBaTU2WDB6c1ZDNm9QMEdFNlZD?=
 =?utf-8?B?TStLNXM3THU2YjZvcVpFbHc4WGFWdUZMRDdSL0hESE9UaXp2cWk1Z2Z1ZkIy?=
 =?utf-8?B?TUREeGVLdUlJMmhKeXRCL3VpckdLL08yS0hpc2VOTFFFUGFvQW1kWEtUYysz?=
 =?utf-8?B?SG5zakpUdlJRald0RnpjSis5NTJ0MkQ3U0Zzc1RFaXZXSkMwbldoSndqYlUr?=
 =?utf-8?B?MjNpaEF4bDk4NjFnc2V2TlQxNEdyOXVTbHhYZnhnd0hKTEFBeTI4MWRrUXdw?=
 =?utf-8?B?ZGZMeGdKSjNUSy9jTGZpK2lURURzNTJpUE5ub2FsZXQ0S0dEZXI3VE5QeFVu?=
 =?utf-8?B?MlBtazY3bCtLZ0tnTkZPRmNZNHd6TmhZN1Z1VWRvZVFMd3ROanBGR3puQ082?=
 =?utf-8?B?dTFMTlNTZDl6VFdnVG9yY2NMcU5oVXJTYmxjSE9nT1JTeXdzLzhjUW1DaVp1?=
 =?utf-8?B?U290MFdjQUxCOFpsOGtoRE4vRGVzcWdoQy9ZQmdybTVRdlpqamJvakRMS2V3?=
 =?utf-8?Q?p8b26b9I+OHRRLAQZf0emh/Nr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6252fd-2ba8-4218-b410-08dc95b57631
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 07:56:18.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/1sGgIJdWcVHPIqdPbDdQfqymXoP4WUBQoLuUxxFKEaow7uDcr7nboPaTxqO13tW/QXq+puYXeglGgsYpwugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943

Hello Mario,

On 6/25/2024 8:41 PM, Mario Limonciello wrote:
> On 6/25/2024 08:51, Dhananjay Ugwekar wrote:
>> Minor modification, the commit subject is supposed to be
>> "cpufreq/amd-pstate-ut: Handle the inconsistency between nominal_freq and other *_freq units"
>>
>> The second half disappeared due to the word wrapping I guess.
> 
> I had some other feedback on the series, so when you submit a v2 can you try to fix the title on the first patch?

Yup, will do!

Thanks,
Dhananjay

> 
>>
>> Regards,
>> Dhananjay
>>
>> On 6/25/2024 7:11 PM, Dhananjay Ugwekar wrote:
>>> cpudata->nominal_freq being in MHz whereas other frequencies being in
>>> KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.
>>>
>>> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>> ---
>>>   drivers/cpufreq/amd-pstate-ut.c | 12 +++++++-----
>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>>> index fc275d41d51e..66b73c308ce6 100644
>>> --- a/drivers/cpufreq/amd-pstate-ut.c
>>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>>> @@ -202,6 +202,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>>>       int cpu = 0;
>>>       struct cpufreq_policy *policy = NULL;
>>>       struct amd_cpudata *cpudata = NULL;
>>> +    u32 nominal_freq_khz;
>>>         for_each_possible_cpu(cpu) {
>>>           policy = cpufreq_cpu_get(cpu);
>>> @@ -209,13 +210,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>>>               break;
>>>           cpudata = policy->driver_data;
>>>   -        if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
>>> -            (cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
>>> +        nominal_freq_khz = cpudata->nominal_freq*1000;
>>> +        if (!((cpudata->max_freq >= nominal_freq_khz) &&
>>> +            (nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
>>>               (cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
>>>               (cpudata->min_freq > 0))) {
>>>               amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>>               pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
>>> -                __func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
>>> +                __func__, cpu, cpudata->max_freq, nominal_freq_khz,
>>>                   cpudata->lowest_nonlinear_freq, cpudata->min_freq);
>>>               goto skip_test;
>>>           }
>>> @@ -229,13 +231,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>>>             if (cpudata->boost_supported) {
>>>               if ((policy->max == cpudata->max_freq) ||
>>> -                    (policy->max == cpudata->nominal_freq))
>>> +                    (policy->max == nominal_freq_khz))
>>>                   amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>>>               else {
>>>                   amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>>                   pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>>>                       __func__, cpu, policy->max, cpudata->max_freq,
>>> -                    cpudata->nominal_freq);
>>> +                    nominal_freq_khz);
>>>                   goto skip_test;
>>>               }
>>>           } else {
> 

