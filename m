Return-Path: <linux-pm+bounces-21416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77074A29800
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B6A161BFD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7AE1FDA93;
	Wed,  5 Feb 2025 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SVSpEASF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E801FCFDA;
	Wed,  5 Feb 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777868; cv=fail; b=e64SxoObmZG9l++ONpdOmRHkPRF1+iMk3lkNnGj3HbfJ6jtIPSedcaaMnyWhZYdBMEw0RVWj8eepD/SpXFLo+9zf90iBJZQeeHsPuAR4tHMDywwEFCbqJk1j0DezPxBWd/pRGkpXl4ZGDduvHON2dURxtjNQdVlH9mG4KWmDGoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777868; c=relaxed/simple;
	bh=gtuib9l8C+E9beAw/hFD8fjrM5qWds6pl1SNq+gwr+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3c1M8ewEmCVoaeE4/oChNHS0yWEMoQLNKtIXr9f+WlK6p7S63zrSqj11JCRMv9dNtDK3FPuhOmO6VBDWmEBOpkS1L3prIqAezybPuQQ5aBiKQPm5EbnTJWdhfiZt+B9UB4BVYm/JSCSNxmcKiv7xzJn63StfeGYZCfo2fxXf+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SVSpEASF; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibDwiPINK4GXrtVU4mP6hTgoVqKcJXaXf33W1yke+gaoQVKsZBodPhU1xIScroHXffuWGhlxofhfwdQJ3Dr9kh8jeima/qwUW98PEjHTeb9pLyzzqRKeJozi/7S1opQQRN590l4GQhhOXwlR6e7Fu1pfjaGRV3lVVXygLGtSewcwSldYSCdSro9MENbgRrfzlmyWY/j9ZGFVDoo9lhKgxLLEGmGwupaFGAe4gUridfp4EghR0B9OVhjifhX35n6tNrQOidtERKjcLfubnbTBiNa4uEcgKvbdcra1kc1X9fQrmfkATG3dott5STjyoejyUlrlda3uRqOcq9Cuo717Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJSD0hW00izV/N/9Gh3vrdX8DiuRhK6S1DzAxvlbihM=;
 b=AZdnV8V8We45q1dTyM4TdnM3SIL2tPd/Nf4aGMqXo72WJBzGUaUEI8GC02PDo81uxlHiVgPgesAo5f1qHFTeV1xTL57OXi5oQqO/PpK7x6CweNOqLud7y/EJm/vQw0V5/5F9BrOq9748JdB6RHC9hDwU2D5nwvyCHY+VoimxT09VzBLxTXq7ncs69gU0jf/Cf5+irWHT9HIz44LFkwLWbFK8j5nZX8vaKf8lo/rLjbWwAwbPuPj2XpzYJg1fajkof9Dska6IXOq6irPk+6REvzyoTX4FvmgsaSnzmIIUj8JDKZiHipZTTNc8OxoJwkuTQffYIQGHHeqqaZousahbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJSD0hW00izV/N/9Gh3vrdX8DiuRhK6S1DzAxvlbihM=;
 b=SVSpEASF5wRCKj5TJ4+ywlmq+myXvDBfIGfViT88zaygVTTJOhDpl/9hog7so6m2WKpghmhnx2lr1lqitLcu9RvxxzNykcHxW5FDciqqLBcZWkIJvi8T4/sGyG1yQimssVnemZ0Yz4toq/IK8PgIiqMvmezPlIBSDJaokp8JXr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:51:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:51:05 +0000
Message-ID: <1e5c0e14-24f8-4cdc-94b0-7863b0a6c660@amd.com>
Date: Wed, 5 Feb 2025 11:45:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] cpufreq/amd-pstate: Remove the redundant des_perf
 clamping in adjust_perf
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-5-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-5-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0223.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:73::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 7690168f-7afe-450e-8f56-08dd460da978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akVKbitKTzZDcmtzVXlDMjRCLzh2TElMazdwZ1oyZFp4aXNqdWphZ0h4Qm0z?=
 =?utf-8?B?R2d6VG5reDA0NkJrWVk1Q2ltRHBzbTJpVXQ2S1Z1eGFxUWwxT1VZZ1FUaE5r?=
 =?utf-8?B?eld6STdra252blJDMDBZRkpoMkhZZmIxQ1pzWkhpVlBGVVFiR1ZBcUNIcFJX?=
 =?utf-8?B?b01PV2hxTis2dy93NjJIWkFRSEQzaHZzaFpIa0dsRERZdEtMeGcwZDlheUVK?=
 =?utf-8?B?REx0YWFVWTRkZVhtT2ZVYmtNc3BTYnBuMDllYTR4M1NYbkdzclpXOVlJK083?=
 =?utf-8?B?VUtqOGY5MmdhM0gyeEZtUytNbzU1YktWN0RwNzRraG1wRzJTWjlCdnpTQWdq?=
 =?utf-8?B?R2VZRERFaEkvL01EWWhvbWlrMWJoRysvVDVmb1RoU1BTeFFscFVrVXFoQmdZ?=
 =?utf-8?B?RzNBN1hob3kvbXd5bTdIUXBpU084MFdjczdMSU85N3VSNjZxYmpnaUFFNDRQ?=
 =?utf-8?B?bzdGWlV2VTRSVFN4cDNMZVVwQ2NTNFR3Q3lMMjZMYUh6KzY2eStRSFU2R0hC?=
 =?utf-8?B?S1c0QWRlcmg1dFlvYXVxdko1MDNvREp3M2JISksxVlJyUTFoV3Izc3piZ3lx?=
 =?utf-8?B?UE4zcUt1U2plQU04L0w2RG02bWtENGEzMVpEOHMzclJiOHZhcFMwbFEvNW4w?=
 =?utf-8?B?ZjRyUm84bmVESktucnROUG0zN2tnb1JSZlk1aVNSNng5b1RDYnUwL0c0dEY0?=
 =?utf-8?B?WnlDa2NzS1cvODhCTFVWcWhWSTI3TFp4REpHQmJqUVlZQ3hKdncydmVQa0FI?=
 =?utf-8?B?c2tqQjlpRkNQaHExV1ZOazBqTjFOVTcwSjE1dnRHM0ZpYTZlTjM5Q3ZpSkJo?=
 =?utf-8?B?eEVEUCthL0RVREhIU3NCYkxOK21nS1FBMVgxMWt2UnlYY3BjR0FSVFhOTHhp?=
 =?utf-8?B?Q1F1TGlwYUplZHpscXlvL2gxRHBmUnpxVTM5dzNET0I1VTE4cjZtcjRzbG1w?=
 =?utf-8?B?S0xMOFJocld2eXZUcDE0TUZnY2RyRFo3dTNXeDlKcUlwSkJCQmtuYXF6MHIv?=
 =?utf-8?B?WThrQm5uM1dJT1Bia3hlT3VVOGlpSmNyVGdQY1RKWWNMbjVVUk1ncS9UbVIz?=
 =?utf-8?B?SElqdDYvYWpLVS9GandtM2d6T1c3bEFWL00vV2NmTWZueFVwejZWenBOYlNW?=
 =?utf-8?B?Z0RYR292VTZQWnJTbmxXZTdGaUU4YkNYTW45VXY5ZXlVblA4OEFLSHJqSU5r?=
 =?utf-8?B?WEltSCtITG1veGNtRjVzUSsxWWxqMmFtWDcycGdFdlU5bWlpcXRsWEhiQ1l2?=
 =?utf-8?B?VHk3MUlsRlFVdmc4ajVZZEpkZVVEL0dpcFFiRkxOUkF6SEp5ZWxpMzlud1dV?=
 =?utf-8?B?TXJPcUozRDJIWlVUQXZTS0dnY2N1bnU1clVpNEdpVmwyeVE1TkhadWpxelha?=
 =?utf-8?B?b01uRXhidjA4TjJ4czdvaGo4T09Va2xNcDA3T2ZRKzVkb1I5L0Y4K0hiL3pL?=
 =?utf-8?B?NzBkZXEvRERNVFRjTzlEZnNQcHlDZTNyNjQzRXVpcmtmZHNzNVB6d3FJWEJj?=
 =?utf-8?B?cjgza1JTdTJRN2czakV2VDczaUVQUXBYdXdrMVFJWEh0b1RsTXBsbEdCOTNF?=
 =?utf-8?B?RUFvYjBwL0JjOGM4QXJpUTFuQzEzUERZUHRsaHY2MmdyMXlLSW5DRHJ1WmhO?=
 =?utf-8?B?dnJLeFpOQXBMZVZTSjJKcC9QNS82dUxERGVIMW5wajhWdytCdDhWZDE1NFkv?=
 =?utf-8?B?TG1nYmkzcXQ1aGIrWklhaUhURDQwSGxUd1ZoMVJuTnpnMUJjanJPTVZFY1F2?=
 =?utf-8?B?R3N6M0ZKNUp2cnJmL1JmN3luR2VXRHhESGMzNFNEbWtJaGphYzRTbEI0QUR0?=
 =?utf-8?B?b2pubE4zbzFYRHZPME85WWVRWjFNWGhIM3B5cHhRbmtjWjF2L28ycWRTMTVX?=
 =?utf-8?Q?7/E1kbS7ViLSW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U01ucDJXQ2J2NG1lYmZhVUZIYlI0YVlFMmJLK2wrdEpMYjQrTmhNQmtsdGlp?=
 =?utf-8?B?OGlRMmgvYnZUYjU2bU9rejhwZ3g3c1NYcFRGa0lkdkF2c3FWZ1MxbG5JeHpi?=
 =?utf-8?B?MURYcXFkd1VOVFpscmRmbitwZlBLUStQVEZzekR1OWltNWdLWmphRXMwTklW?=
 =?utf-8?B?cUNMR1gyUWM1dGRGeWVKTE05OWhrYzVLUW9oanFXa1FIdzV1aEgyNFpDbDhm?=
 =?utf-8?B?dTJ5TWE4cUtjZGJBYi9kTlcwVW5ab0twTVBHMTI5eStqRnJPdGVQQkpoalkx?=
 =?utf-8?B?V24rV3p5Zmhid3FSaTl2cTZPZStGanVRbmdGRnh6TzYvTEYxdnpWZjM0aTF0?=
 =?utf-8?B?em1aYzE3alo0STk5blZwVVFwVk1FRjdHa1A5UGhKNE8wdDQzbXVMdmh1NGFz?=
 =?utf-8?B?KzhSL1oyWTR4NUNubTU2OURnZG1CK1lUdTF2dXRzM2JpOVhEUGlaWjhDNGYv?=
 =?utf-8?B?UDRuUmtxRWF0T21reWh4T1hMeENFaUU5bDg1cmZCVlkrYXpjaEl6elRoYkUz?=
 =?utf-8?B?bXhIeUFCK3krUVVxOU9CeGsraEtLeERRTWFXakJjUkhIYklray9oWkIzYm9t?=
 =?utf-8?B?bUlibVJyM0cvNmcrSURZVFJUcFZTelZaSUZZcnJqOXlJN1I1TVZ1R0Zsd01T?=
 =?utf-8?B?Z0sxZEFSY1pYa1ZVQm5ncEdNSFNSQlRqd0dIeU5jVklkcUFSeDhpdXhhTmI3?=
 =?utf-8?B?V1ZpbTc3UWhvZDdoT2FISlFlR091WTNTY2duV3NpeDB5N2lrd3gvZWx6Tlda?=
 =?utf-8?B?SWRFczhyV29wM3ZDNTdwckZPLzZJK3NXQlc5UlE3WEMxMlR5d2s1ZE5POHZF?=
 =?utf-8?B?R3FLZXF2Ym1sSDJESXdmUHExZHVUbDJsMUxNcitMMmd6WUl0TFR6N0oyWkJZ?=
 =?utf-8?B?M2kzYU4wTXpxTHNJY3I1c0lxaUEzQ3lNVXNxWmFXWC9mV1FEMXpQT296eDNv?=
 =?utf-8?B?YklpSnRaMWRpcVJTNnV3Z04vR1ZNK0NMcUNMZzA4Z2FPMlowYzZtaVRHa2dq?=
 =?utf-8?B?RmFKUS9WaldtSzlRd2I5TXVlbjh2QmkwOThad2duYmh1WElLRFdwQm1INVhk?=
 =?utf-8?B?WWRPb1dJTUh0SUY1bVV6NngyWjBOangycktHOTgwRElOdllEdWFtbTVtNVZZ?=
 =?utf-8?B?ZWt5ZDEvSnVHTDM2OHB0MXRMcUtldGRzczdZZ2xUZE4wZnY2RFpzN2dDWWNz?=
 =?utf-8?B?cGU2UnRlUkxBUkt4SFJXdHB5b2xJYXIzNzRKYVFrYjRMNEUyTDh2c2cyUGJa?=
 =?utf-8?B?ZTh5SERHZ0RwVmJ2eG5WcHJGMTFncnNiWHVvVTA2d0lRbUlvNWlHTmZGQ3Vs?=
 =?utf-8?B?R1lmekN3QTQ0N0lZeVJvM282cDYxZ0NFMXd3RTZOWkJDNlc0YkhCZXFSc3R0?=
 =?utf-8?B?dkszV0RSQWxlOXNIc3F6OC9NQzRlQndWdFIzK3dEeHVjVGk1clNJQ3haZmhy?=
 =?utf-8?B?V1dPdDZrNGRIeGU2cEFvUlA1TXEzaUhOQXVPSSt2Wm9WbkFqdW04T2RGUitm?=
 =?utf-8?B?dVZqcjJSZzV6QlppU09JUFpRVXdPWWxwejlrakM4SitHNXB3RlZxYnZJMGtE?=
 =?utf-8?B?TWpoaTgrVk5ZZXRoV0hwbWJlZkljZlczZkhVRVJrMXBKN1ZTa3RqTGwwOFIr?=
 =?utf-8?B?NmVGaXhKODY4dFVlTllzTnp1NTN2ZnFwc3hxOEJ1QWZIcUovQWYyQVVISmRw?=
 =?utf-8?B?QzNyNitWaFUzT3JId3JMSXh1dXFZa1NJcURoWVZLWCt4OXZsUVVSOUEvK0I1?=
 =?utf-8?B?RzFsMlQ1ZXpWNmxadnpORnZJUGNYUlFIZktsRGlCbnhaN2FkSzM0cnhQMHZX?=
 =?utf-8?B?TDVQSGhZTDRZS0pNNTZTQVpnZTdNeWxvUnhzK3g4VFRWbHgxYklwajFDbFJG?=
 =?utf-8?B?VG9mMUYzRFdiZnN3Nkp0SjBGckhuOTY5aExOYVE3d0dVSEJ0NFg1R2VtTTVH?=
 =?utf-8?B?K21acUdpQk83UEt1Y2VmVVRiK0ZiVzdTT3FHRDBsWDVpSStIcWtWOTVaREx0?=
 =?utf-8?B?SnRqQktNdlhMemNlSEJPbTRkL0NIMXNsSEtiUlptaW9GMVlIWG1TWjNHbzc0?=
 =?utf-8?B?c0dVTm5LNzV0M0NPa1d6Mmt5cTRXSkJwT1I3QkQ5eWRGQ3dabE5KUjIvdWpD?=
 =?utf-8?Q?EEPvxu5h+WG0uY+Pe8kH7m3Is?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7690168f-7afe-450e-8f56-08dd460da978
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:51:05.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NboPA7Z/+WRzQ5lnN1stNEEUuYMLyr0GWNOJgQScDcOHid+qLPOpeSZWiu4W3TKrDXEqlar3MTQ6a/9MHFCIDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> des_perf is later on clamped between min_perf and max_perf in
> amd_pstate_update. So, remove the redundant clamping from
> amd_pstate_adjust_perf.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this for 6.15.

> ---
>   drivers/cpufreq/amd-pstate.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a23fb78a442b..2926f292be7b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -703,8 +703,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   	if (max_perf < min_perf)
>   		max_perf = min_perf;
>   
> -	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> -
>   	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
>   			policy->governor->flags);
>   	cpufreq_cpu_put(policy);


