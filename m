Return-Path: <linux-pm+bounces-22761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB56A414B6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DEA188659D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 05:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C4340855;
	Mon, 24 Feb 2025 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nmA1UhXu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D88A32;
	Mon, 24 Feb 2025 05:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374609; cv=fail; b=ZF+B84yy0zMzTeZitPncQk6JsPVtbYus4GFRQHybWY8KIWuoHVFay4WXHcVtSo2wA+jLYlq58mDBAU4CLszHLRRhWBLOeGVwJ4hLDu5VXqL1ctM4L/opo5Ew2N4IjrtiMkun6m54YEUGiW75n9kSoKqic18AKeg1imwF3oVP7cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374609; c=relaxed/simple;
	bh=+o63Wwl/ajqxIKclys6JtzqkgmCGDpwjDjbFRxtAw6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UtGiUfo+Z5FCPq/pmVyJTkZQ367qs9ZhMLEGHRDz02d44xdfVIWqX/pGZccjv5E0jzAzLbh8FvEQZmJxYqEuegksBw/i2leCIeQO87Vce6X/G5ySPNe+SCgO1g4+oOL0chpd0S0sQRs9iGlRL2Wbyeb+dmQ2I1xxCDCwnbUBLBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nmA1UhXu; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBqpHCc2iUgalyzAM7W5phANnvYaCshVnFZyrE9OH8+1u1cURWVRG15nrGBBdS3IOCRK/8z030m8iynlIJ62iTzj9vHi3Nj0RczojsljJE4Svc2epRmvsja0faP5zCBimIdVcjtH0xbEnkhL/3OOrgzCLN/pKz0ClLMOuJ5OqbLHmB3kV9nycOCIY9CbcC9PL0/eo6J00fh9u6WL2UTKvjqwOIWzCb+1dGFAEubRoAh3NVl4xPpCfbpSL4p2h02aHSDUGte3kD5zfWPk+XOny4ZXH02OR0JZcyJ86eOJjHnWRBHrA1EGkmmlGNPl6ntAEi2IveZtPxDvRT7KxMIjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5065jgX1BrOD85EGEQS3q2tpksiXbvPebH+x0Qg9nPM=;
 b=mDMBr4PJdpR+wqVPLH+dmkrN3eZS8ORMdDRwP05qseDI31WB9qGvNvb74VEB5nHtziyd13nAokqLnzvp4NHkeHUcFKwYWe6Z1g0c5HGc7xMiLhH+U3qMTG/+jEOwVnIpKHhf8yqBuv76af8Ff1p3zwfK2KCYetHQ8Uug13XyNQit2gX4NtiCqronz69IHdXQUu0gnnJ//kXw5gUmzitmtApqFfZmrcA+8fFi4PqDQx3TRO2utNqk8ZSP8i/LK0kzgLdOv2hrMbOuxwbLEY058eFNPqh+6yap7Sf7AIyTDHSgjsWPhmUV7rWcFS7vzVh0V1wvcg7m/mbfXSHtitGN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5065jgX1BrOD85EGEQS3q2tpksiXbvPebH+x0Qg9nPM=;
 b=nmA1UhXu7UeC/o8FG4kFBFSfEsINTUNuCf1+nbeeRcHhpqOEDVpPrBXmlmaJoH1G5VaLbYr2S7CfnIrBqIPGgMeYxsIZkaYXozo1ryAakfYtEyx+uzNwWfkA/mRU/SwWxW4aRTp/NNlnuDMm/LHEeHAzF19QrOd7hvglM/wWyC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 05:23:21 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 05:23:21 +0000
Message-ID: <6ae8f24e-494f-480d-9d5f-4100f50a6b63@amd.com>
Date: Mon, 24 Feb 2025 10:53:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] cpufreq/amd-pstate: Overhaul locking
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-6-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250219210302.442954-6-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::8) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9fa5dc-b123-49e8-f0f3-08dd54935a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eSs4TDVBb1B4M1JGRkg0V3oyMFFPanp3Unp5cmFyKzJnREdYaE13L1pzWXlI?=
 =?utf-8?B?bXJQaGllL2FzZ3h6aGttUG9kTW5HaExvd2wxVzBMY2tSVU0vaUJHN05POEVK?=
 =?utf-8?B?MFliSVFQSE1GUVJGd3cySnJWY0Y0eXRPRmNrUG11REdpYStaNnd0cXpBd1hr?=
 =?utf-8?B?TFNLdmVvUlVaYkkzU0hxZ1k5UWphc0pScXBMa0d5cUlOeUUrTGdudnhYQzFE?=
 =?utf-8?B?OGRIYXBDY2JjczJyQ2ZrOWFMRlVQeVB5UXlESmhxZklsaTdjQXlvai8vUjdp?=
 =?utf-8?B?U1VCSXdrd3RlSXVCMGdORUNqTVdFeFBSVFV3UytLWURycFBxbWhtRytmQlZx?=
 =?utf-8?B?RUNtR0xLWjJ5Z1dIYnR3MlJRSHpxSlM3b1FkSWVZcWZzWVF4V1RhZ1V6d0dz?=
 =?utf-8?B?ZGRuWjExcEVWem1MYUtzZmdWRVNlU0M0NkRPRDNhM1hhV25wSStOVXBvWEhQ?=
 =?utf-8?B?Qm52bFJVc3NLMm9tTGkvWTNkRDAwejlDa0Ywamd5dVBPY0FQUG5XY29hNmpa?=
 =?utf-8?B?OHdMTDFGRlNjMjVHalVSNEpwOWFtUitOdFJlOXprL2FIWTZJV2U0aU5FTERQ?=
 =?utf-8?B?aUV1Q2pUUDF1bDhjS3EzblFDVXhvYkFwYzJ1QjdrQi9ldnlTc2NjZ0JiWVNF?=
 =?utf-8?B?RFRFaXk4d3R4eW1EclVqTHUrU1FqeVRSY3FCSHowc2Z0S1lTOFRmUHQ4Uk9y?=
 =?utf-8?B?VVpMS2RkNG10Qi84YXFLOFR3V3Q5UXd2RnlyejNjeWFzT2xlTExzaG03QmtL?=
 =?utf-8?B?YTk5R3R2cTE0SUswQVFoa01TUTRWWCtlaEdsd21XZWxYSUVWV0dMY3ZUejRx?=
 =?utf-8?B?dThsTjJDeEFSZUhOR1JjdlhYNWo4Kyt2VDByMGQxbEVCaHd3NmQ4V2pQd2dG?=
 =?utf-8?B?K2hJSmpVTjZnY3FmY0dVNDRZTk95QW4xeTAwQnZNN0J0WWowU1BCejBuTXdQ?=
 =?utf-8?B?TDQweVJvMlpBM1E2dVZlVHJ5TWt2M25PQXZSUXkvMmNjMk95N0NJMFhzS1c5?=
 =?utf-8?B?Sy9rOXo1VU5yTHZjUk9kQTRwVFkvOGVVR0hqT1lZSkEwYVhnWTlKa0RHaHpW?=
 =?utf-8?B?VU1Cc2JXUlhpRFE0a29HNW5US2gydy9Lc2tCMEVuUWt0YnNUQTBVR2ZoZHN6?=
 =?utf-8?B?OEMzeVpSUzkvSmNwRjlzeXBvUko0RkNoMnl5UlJYOVZzTnZjQUFXcEVnWUhP?=
 =?utf-8?B?WDZqZmYwYjFlNDIwYmYxYzNZbFNnTTg4c1ZRY05oWUxMUEJCbUxTNitKdjFh?=
 =?utf-8?B?Y2pEdkRtZkk3QytETjJwZ3ZIYjRhelRaSEJPMng5UWx2VlJNUmVZWDFCMHNh?=
 =?utf-8?B?K3dFSGdMTkFyNFdRZDhHZ0ZrelpoTk1hZ0ZxVng2R1lFWGRMeUhoWmN1Nlh0?=
 =?utf-8?B?UGdxQW5QYW0zMDAxOFhaT0ZIWHcvdi82ZmRENGNYNnV0YlFuMXJHYUJlZFZo?=
 =?utf-8?B?K053NllkazluemhFS3hHbGtkV2FlNzhUU2FYN255cENDcVB3Qk5nZGJBT3BP?=
 =?utf-8?B?Y09mdzFZQnp4b3lCMmtobTg3STcrencrUkx0R0NBbklaZXcxVHBVSnlYWkJk?=
 =?utf-8?B?Ym9jTU5kOXRybkxQZHBJQzVxNWkxdjNoZFVtMmRiQXlUTEVLRU85aFpIYk5v?=
 =?utf-8?B?NFhnMmhJS3l1WDRQK1R1cEtKbDVseGhKN2JLbmJmMHpGVHFxWjhKT1pzL25o?=
 =?utf-8?B?c0o0UmFWSkhJbFZQNVlsNDdKY0xpeGlrSkVnN3ZNVWx3c29lMHlNQm9LbS9i?=
 =?utf-8?B?aVIrdzFWVzhXSHY4K090eVBlWEUrN1NZbGtla2FJYXg0K2Rkd3pBczVhRXNO?=
 =?utf-8?B?RXE4dnFBcWQvWFNLTkJDOG94ajNxTG9YdXRjTkNaNDlleUhtRFArei9tWmhQ?=
 =?utf-8?Q?+ov+jtLBEoXwV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3RzU2hlYXovdGljY2JUQ2YrS1o0aDdhV0ovWHRHc2EwZ25hcjV5Z0Y3dS9r?=
 =?utf-8?B?RnVISUVNV1ppaEtpcjB5eDRNTmtGTEVLVWNmelcvZG8vUEZ4Nm5MQmR0cGlr?=
 =?utf-8?B?NXJuSkJxTFFQM1hMU2xDU1NMbzlNZ2h4T1kxakJnM1BXUkxBYTRERWZNeVRU?=
 =?utf-8?B?TmtZcElSQXg5ZXRlMUFweFc2ZmUxcDhOT0VmU3FYSSt5VkVzV05YNGdIM3h3?=
 =?utf-8?B?NGpPUCszckd6bExWelpqMUJwUDhKbml1R05TZkVQckpLM3luSS9FSFZzZERW?=
 =?utf-8?B?OWVaaCtTQThIWEEwbFVSRlBPb0NXTFFPOVdtNWpmUlh5b1VQamF1a3hkR3Js?=
 =?utf-8?B?L3NEWnhBTGR0eS9XODVsZnBXYTZaWnJ2eG9yaWRXOU9yMEdVYnIrYzM4MXNY?=
 =?utf-8?B?UEhEcVJDc0RRUEN3ZXF1STlYVjhnVy84SmZzL0o1RzNOSW9hb0M5cGVlOUNs?=
 =?utf-8?B?NkxSc3JQZHY4RVNTS3NMRkFSNDE5amhvdmJ0ZUQ3ekZoQTFQR040SDlCT0FT?=
 =?utf-8?B?MStYaktZVHdFUkpGaFYyVTA4bm43SnJQSzhreUlONC9TSjgzSzk1N2UvYnNU?=
 =?utf-8?B?MkpLR2VhSyswWVFIV3ZEb2JTaldCeGF0TDRDTTlnN0RrMTFBenJmNUJUc3NE?=
 =?utf-8?B?cWFTL1JJdGtSU0lCclVWWkFHWDBRc3JQWG1MTUdJNDA4NTQ4cnBPRXZaOGg3?=
 =?utf-8?B?K21jMGtoRXlzVU02dEo0UE5KRDJ2eWNaZ0FpWTJFd2dTWTdKYUdWQVhHeXpa?=
 =?utf-8?B?UE8xTlJ2NnhCOU9ZTVZoQnVLSDBFbm9yNC8rdFF1Znc2ZXUrb1hlVkdrOU1u?=
 =?utf-8?B?cG5Rd3YvdHNIREJuYXBlNysyY1lSVytBekNVdE5Nd0NpNm5wSG0zVWhiTCts?=
 =?utf-8?B?c0xyS1VqN1pheFNZczdCM1h1a0hTTHplYkpMMng2a3dVbWEvSW9iQ0ROanht?=
 =?utf-8?B?eTk5RW11N2J2WFdYK2RRVjRqeG00OTJjUXJXSTZvbTViOElkZEVrQUMyaGlU?=
 =?utf-8?B?QkNNKzlkK1kvWFgvT3pxaVgwMDl4anpOK0UyMUZzL3N6akEyaktyY2RnVXI0?=
 =?utf-8?B?MVptZldCMWJEdmlRMjEvVm1iYWsxb3ZiYnpJZ3ZPWDVKQTh0ZzJtK3dXWDBD?=
 =?utf-8?B?NzZ3ZmgzVmE0Q1ZkUUZwTmJSeUt1eEZwNzllVHFRU0lHTGcrbnhyYm9uV0t2?=
 =?utf-8?B?V1p1cWUwWXRXQktaaGI0K3A1akdzKzNMUk8rV2dZWXAwajBpTW5qY0gyanYw?=
 =?utf-8?B?dHFCeDFsTTJEWmVvSG83bTNnTXhVVjdOYm9oRVZPaFBBNllpZ3VQSVlGSENW?=
 =?utf-8?B?VFFOQWhmWUxUZFJiaWFVQU9wOHU0YTR5eGV3Nkh3MXI0SG9wckdxaXhGbytq?=
 =?utf-8?B?T1dndDA2V0gwdkFhbHI0c0pLdmpycXp5dFViY2NIdStFNTlYMTdaMkMvUjRw?=
 =?utf-8?B?Nnh4bTJ6UlZUN2kyRXVSYUFMY3UrTit4WnFianNmamF5L1dYbW9ZSlpRTVU0?=
 =?utf-8?B?TnFxT2lmT3JMaFVURm1tS3g0M1VNYllhV1pubCt3N0xKR2RKWFJBNkFQYlVO?=
 =?utf-8?B?a3F3R3Y0WFpIZ1dydkQ4bDZ3K0VrTU5mbFpjekZEN3ppYXdsWGpWSzk3QWZo?=
 =?utf-8?B?T09oRENvSWJsTURtbzF4Nzd3dFQ4alZ6SE9nbnpSVDlGcGd0UjVxZnY0RXZV?=
 =?utf-8?B?NnA3S3pFMHp1OVVERVJwa3VFU045cmpwSGNHUTJZeEt3M1RmaUUvNngzU3hv?=
 =?utf-8?B?M016cHUvdXJSd01SS0M2dDEwV1Zod204NjNrcmQwYy9US0t3K0VhL0NrQi91?=
 =?utf-8?B?WVhmZUo2cUcxSmdoUlZVLzkyL1NvK2h5MXJQVU9mMDdDWDRiU1hxbFZWLyt5?=
 =?utf-8?B?NXFEZ21VYkdOUnFhOGVNLzFaNzA0OFBqWFVtK2s1b2FCSjM5Z1JYZ2lRVXpu?=
 =?utf-8?B?d0pNSnVCMW1EczJoQmFBWkMyWmJJWk9obzBmbXBDbk1sZnlvUjgxdmZJNG9n?=
 =?utf-8?B?ZzY5RlVRbm1rRmdnZXRxeXhsN3lNSlhiQ3ZTWFU0ZHBnWkRxVDVEcWMrWklV?=
 =?utf-8?B?U2lFajFxaWFodEV3SFNuTU45VS9KWUZqVUFtNTZnb2J0UnRaMUxsNFMzYUNq?=
 =?utf-8?Q?HQFTXpkMGpF92LqIkWHVj5yK5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9fa5dc-b123-49e8-f0f3-08dd54935a4e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 05:23:21.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFYuGtb4aoMyZilfgZ+J6AhJEA3UxALyBjYrE/osUQ9sJxYzIv0ufcDirbXqHLGeZUmyfhKEk1k5+epqBnuIfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745

On 2/20/2025 2:32 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> amd_pstate_cpu_boost_update() and refresh_frequency_limits() both
> update the policy state and have nothing to do with the amd-pstate
> driver itself.
> 
> A global "limits" lock doesn't make sense because each CPU can have
> policies changed independently.  Each time a CPU changes values they
> will atomically be written to the per-CPU perf member. Drop per CPU
> locking cases.
> 
> The remaining "global" driver lock is used to ensure that only one
> entity can change driver modes at a given time.
> 

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a6066fb4ffb63..85e3daddb56e0 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -196,7 +196,6 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>  	return -EINVAL;
>  }
>  
> -static DEFINE_MUTEX(amd_pstate_limits_lock);
>  static DEFINE_MUTEX(amd_pstate_driver_lock);
>  
>  static u8 msr_get_epp(struct amd_cpudata *cpudata)
> @@ -752,7 +751,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>  		return -EOPNOTSUPP;
>  	}
> -	guard(mutex)(&amd_pstate_driver_lock);
>  
>  	ret = amd_pstate_cpu_boost_update(policy, state);
>  	refresh_frequency_limits(policy);
> @@ -1175,8 +1173,6 @@ static ssize_t store_energy_performance_preference(
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	guard(mutex)(&amd_pstate_limits_lock);
> -
>  	ret = amd_pstate_set_energy_pref_index(policy, ret);
>  
>  	return ret ? ret : count;
> @@ -1349,8 +1345,10 @@ int amd_pstate_update_status(const char *buf, size_t size)
>  	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
>  		return -EINVAL;
>  
> -	if (mode_state_machine[cppc_state][mode_idx])
> +	if (mode_state_machine[cppc_state][mode_idx]) {
> +		guard(mutex)(&amd_pstate_driver_lock);
>  		return mode_state_machine[cppc_state][mode_idx](mode_idx);
> +	}
>  
>  	return 0;
>  }
> @@ -1371,7 +1369,6 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>  	char *p = memchr(buf, '\n', count);
>  	int ret;
>  
> -	guard(mutex)(&amd_pstate_driver_lock);
>  	ret = amd_pstate_update_status(buf, p ? p - buf : count);
>  
>  	return ret < 0 ? ret : count;
> @@ -1643,8 +1640,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  	if (cpudata->suspended)
>  		return 0;
>  
> -	guard(mutex)(&amd_pstate_limits_lock);
> -
>  	if (trace_amd_pstate_epp_perf_enabled()) {
>  		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
> @@ -1684,8 +1679,6 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata->suspended) {
> -		guard(mutex)(&amd_pstate_limits_lock);
> -
>  		/* enable amd pstate from suspend state*/
>  		amd_pstate_epp_reenable(policy);
>  


