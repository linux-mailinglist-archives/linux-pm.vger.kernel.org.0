Return-Path: <linux-pm+bounces-14579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008497EECF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 18:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901E61F22752
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 16:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CFE77107;
	Mon, 23 Sep 2024 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gnIph70o"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD527715;
	Mon, 23 Sep 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107411; cv=fail; b=hRnDDrk32efRSpja1iEjf9Ie9jU5pj76gwAoxulOW/1KYR5V4l8wfarzT4EHApQdj3xxKqFkrz3HLzrLunzJXR46+P/d59w0kdpzOUq9SJPQB7fd1TG/iGsRVjtMny1kx2Gtq9gIHb6ivOKT5oNf5ddDXUIz5tKL3qyXvqIobbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107411; c=relaxed/simple;
	bh=4iDrPG0RbDqe9jOqXf4m8ZSJ3MynPbmzsfBKIzCetcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=alR6h41/uFOzXG8amw3wkjlzwKUHubNrhd08+o/c9aCeC5HxoaoeR7q5uDIq5Ued3BJhYTBj1cJOo039dkqZLsDKHbiW6pe+sXYATbFIS0eh7aocr2XfeoYK9XUfPdcAvxluAMj18cU6ZRtcnU4TttUhYsJ1KN7DYHEfUXVvjY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gnIph70o; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX0eITzKxVVepTUt/xICfX9DZIfr3kskEfI7N5/fUFn8k4k8pddke7aV1MVwWB+40ZsTiSpl9O6/2piX+EQU4+6/V/s6U/jJDRUt7bhhsLG0OrNiQb4+QkBAt7yNgnx9JzBneEN7OcN8TqmCdNgxQCWc2NLpbPiqc4uWRFE117QqzeFoA8t5YpwZU4JEB4/LtZ6EeZ5KDzaoVx+d54MfYbeW97KXnmzY8hjCZCafR+4M961rppR6sKc6eHsO6zcvUqZYvCoTl5Zp3JO264ehuTNbDFTUKYUT2nDm3lUAxbCu8jp+yIrUqdsE5YN0HkCLERbSWXw7cw82tkREISZO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1FBJhn3vbX9pwb7o7ZHYMqwWTIxhepc48ofibZs5xk=;
 b=qELC74C5L9z4IJ/K7FVaYuq9ygeAlB6KU+cAyrnvydmEPoUWa+CRBDCTHRDuwL4I+K3FR1DyZTx5F7fxO4ysfp+c5c6RMyI5En4GC0av0A0O6Xttztw7inATiwimIckmGmot1ypRvfxf0r8CPx7SvxAfKlD2Dx8wQUdtBKzG9irJwfuVkIHTRVXxc/c1M7NTShVAuMOyc2kwfGeKer5xWZ9ZNz7alDxUXVOtl9+P95F6f1gyEug2pTWrVo40mNWwydUxGtNKBz7O7QoGDOOEyt8VY/rTQo8kz6hMQcl5EXuJ02VgF714sv+DA4eCm8ig+dsP8iuFoO9QUAljRWm/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1FBJhn3vbX9pwb7o7ZHYMqwWTIxhepc48ofibZs5xk=;
 b=gnIph70oWaLA4AkEhLdYgfdZXHB3WcApaVweuasOqMhJUx5km22OO/XhTFr/kW9GaWhCDEJ//6NsQJm3k7FiHkbzk+zUcZAONjQGhsp+1gQgJ00W1XvH4iNF1BaTnskxB9snsKABfUxt3xgtFkwyyOzFtu/kZxpaQdih8ZLTWj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 16:03:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:03:27 +0000
Message-ID: <1a9b611c-51f0-4c3d-8bc2-62c6b6104fd2@amd.com>
Date: Mon, 23 Sep 2024 11:03:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] acpi/x86: s2idle: handle Display On/Off calls
 outside of suspend sequence
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, luke@ljones.dev,
 me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922172258.48435-3-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240922172258.48435-3-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: e0436202-d40a-4736-04ba-08dcdbe9429c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUdnYXFEUG00WC84VUNIRzRVVWNaQkF6SnlOaXVDdEpLRTFoaUkxclhzTUFn?=
 =?utf-8?B?emtVWTJkVDB2NTNJNkdBVytseEJycTFNYXpkbWphRVFVVnpsU0hvVFQ3eG1w?=
 =?utf-8?B?em9Ma2pNcHVJTjdHZHEvSXA3TWVqTWFtQTFjZ2tBWTIycEJtQml1d0NmRDBo?=
 =?utf-8?B?V1dKR2t1L1JpVTBjeVV3RDlIekVaQjc5WE9Ncmd2ZmxHV1hQWGY1OFR5RUl4?=
 =?utf-8?B?UUd3d2MyS3VrSmVkM2t3ckF4Y2VtQi9qRHp1cXpzYlhVa28rcGVGeVlhcDBB?=
 =?utf-8?B?YlNBQjdieEJLWFFYbWoyTzBkcjBoK0tnVklXZTQvaU5ncldmRXA3Z1NpYVUy?=
 =?utf-8?B?VzdES0p1M2NvbFBUeUV4R2xod05KTlpQVFpHZUJxcnRDMm1ycjVENEZYTjV1?=
 =?utf-8?B?akVXOThzVEQwU01vWTJkQWUwdjVjM0hsMkJLR285UDNkZElKY1Z4a2JMejlU?=
 =?utf-8?B?OWswU0tObXJXOWdNMkt3V0FhWHl2bjZ1QWdSZEp1cHlDS0hsc1Q0R0k1bXdo?=
 =?utf-8?B?V2VWVitTZ0hpOE1KZXNSNFY2TTFlL204L05qcmJxaGdkamN4ZUVMallobmlk?=
 =?utf-8?B?K082a0V6VFRnSVZVNldFZndWYTI3ZWVJMXpmVzdCcTNpdDJQMG1BenVpbk1I?=
 =?utf-8?B?VjdhdjVheWxoN1VDelExOS9XRUU5ZVAwdkNOUmp2U2dFU09DeHRreGkvV3d6?=
 =?utf-8?B?dUF0dnNRQzRaQnNURlpZdm5zNUFvY2FCNjlCVnd1czZNV0pIMmhjdWRqbndl?=
 =?utf-8?B?VHhLMlZPQmIwcmpjcjZrcEEybVo5cHNFQ0l0RTI0SHZOWkxza3k4TEVOaWJI?=
 =?utf-8?B?a1lndWE2V0gvajF4Zy95aEQrdVUrNUVWT1NYcjZqU05nWnp4UzVoMXRWUUtS?=
 =?utf-8?B?eXljWU1IVTh3NHl0VzFZVWVRLzQ1dnM0YTdwMnhkYU4yV2VselVZVjRmNVZK?=
 =?utf-8?B?WFgvRk5LLytMazJuWk1QdDZYb0p2a0loVEh5V2RlUmRUNklITVZwVmhYcTIx?=
 =?utf-8?B?S0E2T2UwbG42cWx4elMycFErUno1blk5c2pSa09sa2N6U25iV1NLd200YnI4?=
 =?utf-8?B?emtrQWtKajF1QVJrSDRZR3ZtQ0VkUkVVMDA1OS9tZ2p5T0c2OFIySG5NN0xS?=
 =?utf-8?B?Z01KWEJ2aExKNHhUZVdHK3BlaHBYeXFSOVJQbVhnMk5TbFFSQnI2R09Wc1Jq?=
 =?utf-8?B?K2dqelBjVlJXQWhCUEtWV0ZOb25hVWdEQ28wZkpmUnVpQUpicnFDVTdmbUNK?=
 =?utf-8?B?MW92WGxxRHpGeDRwWWkzVW02WFBab3RYcGM0OTMzbWt2cWgzR2d0YmdKTkR5?=
 =?utf-8?B?YVBtTWE1WkYyTFpYUmw5SWtlTTdzN3JKQjgwVHNKNUxRV1pnbWVBVG02T1VF?=
 =?utf-8?B?dUR5U2lCOWlqVFdoSVJHRnNTRjFLRTZLQXBHNXROenh5NTNEN3VObm9SclZF?=
 =?utf-8?B?L2JGa0hhbnQ3SDdZU2JRV0JaWmw5bjBIdVFqNVVlOFF2SzViTXBLYkNVUTdt?=
 =?utf-8?B?R0dacFBheDljMG5ERWtzUFJVaGk3ZXd0MXNnQnM4UE1PVkFXY0FTUGVZVU9T?=
 =?utf-8?B?TXJHTXJCcXNxNEl3WG1EMkxNQ1RjbVFxam5jSmx6dWhwTHdReVM2UFF4aDBo?=
 =?utf-8?B?TEp2ZUdxVHhxVS9CMHRJTWgrNnR5QjJUU2VXZkZGZnZ6Q0I3d20vWm9INGFr?=
 =?utf-8?B?QjNSMFV2WHhvTXF5R0ZPZGE4eXZQSEVEQnltcHV6L3hrWlppSzZMYmF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkdYTWRDbVBtQW9KeU85d1h3NDlsb2RpNWVOMnF2a0NEVjkvNW53aXRvWEV1?=
 =?utf-8?B?NnRsSzRIWks2VDhPUWRRa2ViNDZmSm9NZ2F0WHRvbzFMZkVZRUpNQ2V2U0NC?=
 =?utf-8?B?bEhaTkc4R1hzSDV5TTdZUE9RYnhRR1VhVWdPTEtUNzBrUG1laEtpd0NzcTRK?=
 =?utf-8?B?UklZVTlxRmI3NitiWEpBNXp1OXV5a1IwaEpsRXJka21maDd6VHZDNjlhVExK?=
 =?utf-8?B?OG8yYlFJUnQzRFAvVlBlZW1wVStrMUU1SUZxV04yQUwxYmtTME01alE1dTc1?=
 =?utf-8?B?bGJ1bEhma1hTSmROVERFT3BkK1pIeTB5c1huV3NXZjB6Y2Q5VGoxT3FjdEsr?=
 =?utf-8?B?ZzJwN21oUG5qZVljZWFnUmhCbm8zeHZhWnljSk50TWVMSXYvUDNuQlE3SDFX?=
 =?utf-8?B?WEV1S0xGS1J1dVFabFd0ZDRRWDBxM1BjK0RIcXJRZXBLQk15RGpNU3RpakRy?=
 =?utf-8?B?UFZrOEtZTzNhNDg4KzVqU25INDdRZ1B4SzdadGFYS3p3ditBOFBsK3RNMEVP?=
 =?utf-8?B?RlVWYllId1ZST1d6VUxtc0djbmkxTENmbDhidm04bUpYT0xqcGJRd0IrZ214?=
 =?utf-8?B?YTlrQkhMT3hWeitLMGxxc1ZlZkhqT1plRjREck5oODk3dWFJc25saGVnTUNN?=
 =?utf-8?B?dGJGS05oVkZaT2N3OVpmTVh4TlJtSUxob3U4N0VaR2h3RDVIamRvUmJpS3gr?=
 =?utf-8?B?RFE4SU55L1JHcTNoaHBzSWhHMDF0WGt5RWpneHJqajA5NWRxZE1qN0JaZ1Vn?=
 =?utf-8?B?cjhtN3dOd0pjQ25uYUlxTDVqaG1iNUp0WnpPbm1ZcjdKZ05tOE5FeDROOUpW?=
 =?utf-8?B?YkZPYnR0a3ZRbmp1dkxuN1krTERoZHF4YTVwMlc0a1lTSHNnWDJLN09yRmg5?=
 =?utf-8?B?NWg0YTZjaWNiM0VrNk5uemFRZ2tBcHh5SWlHd3owKzE3Q1lLcWpIZkpmeElR?=
 =?utf-8?B?TlZsRTRST2pGZkNtVCtEUnJMeU8zeHF1VFhvVks1TFlKYWZneWJOblpDbGFW?=
 =?utf-8?B?K29UM3BZYVliZ0xKenFsZFpNS2owZ0cxcEtqaEtCNy92aHNlYmY1ejBscll3?=
 =?utf-8?B?ZXJuTDh3ZG9OOURKOFBqak9Dd3BzdjlZZ3pKb28rVlNMai9ENEtyTEVaT0l3?=
 =?utf-8?B?OWdNdjhoTjVBM1dUUFpNMEphTWc3UEdIQ09DSG50TFB4YVJIVVNqY0ZqVVlG?=
 =?utf-8?B?UVcrcGVmM0txalFPcnRVbFBhSzB1NGU3bFhKeUhlN2tWNjl6WkJXc2owamp3?=
 =?utf-8?B?N0xORkh3cWZVczFpWnlMMVhhNzVEZFlsWDltZCtndDc0a2ozWDNXNDB2NkNB?=
 =?utf-8?B?UVEzRE9LSStlMlQ5VTZ4NFZWQTI3dEVyM0xqaURDV0FGV21pbHBkTmJkdWFj?=
 =?utf-8?B?aFUxcStUb2ZpV0lSNW40NWN2bFBxSFN2R1FoamNrdUw2VHZBYjByNnRTMldr?=
 =?utf-8?B?a25jY2JLQS9YdklJWWpreWI4R0piVTArdjREdjUxRWx6RDQ1UzFJUHBoYWxY?=
 =?utf-8?B?UjFjeGtpNEI1VGNIazk5YWs3aWtPalBRWnJkU2hIVktVekQ3NFNMTGFZbyt3?=
 =?utf-8?B?QWxjWVdmV043dG8zbTUyWEZIYWZzb2NoNTZmV25wSk54RmlTUDhDVFVHeWhU?=
 =?utf-8?B?QnlLczliVjdvOTJGbSt1cGUxd212clZKRDV4YkNIYlhHeVZmZlFuaHZmcGJE?=
 =?utf-8?B?b280c20wVDNYUThUZ2dKWVJNZW5QaGdPcUNjOHRRNFNobE52U0FZdkFLUExF?=
 =?utf-8?B?K2cycVdEYTMrUjFPc2hiWWRQdVNoeUpCN2JSME9wM2hBVXRjeEtiUWwveEhS?=
 =?utf-8?B?Rmp6M29GVWpOTUM5eUR0SmdjdlN5YlZhdUhXeDVJK3lVWmd3RDYvbUJ2SGp6?=
 =?utf-8?B?czExTW9TUWw0cW14K3JRTElvQ2NQVXlRNk1iNmF5K0ZyTFMrWXpwRXZaL0t4?=
 =?utf-8?B?WE9VdCszUEEwTW5tMnZtbHFRQjZIS0xjRXYwemhoNjBoK1hEMGtzZ0UxeVBh?=
 =?utf-8?B?M0dxTXBHbk1va21lTVRhY0tyV1h3SDIzdFlOOTJXaTdweFVDV3hNMEF5M0pk?=
 =?utf-8?B?VUFZb0U1aWltQkE0T2cxa3NiZUNlTlEvYzhWdzNlLzdLT1plQjBpdE84Umd6?=
 =?utf-8?Q?FKpaA9QalxQ8TA8ILK36sCn2E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0436202-d40a-4736-04ba-08dcdbe9429c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:03:27.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Snci3IHxlnznyeahpIhYK4DhbOi6QaS5LxWY9cFyIUtn2LQqFMTMQ1rBRvuvUccC7N6Mf5lIO8sQ8TEViWaWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958

On 9/22/2024 12:22, Antheas Kapenekakis wrote:
> Currently, the Display On/Off calls are handled within the suspend
> sequence, which is a deviation from Windows. This causes issues with
> certain devices, where the notification interacts with a USB device
> that expects the kernel to be fully awake.
> 
> This patch calls the Display On/Off callbacks before entering the suspend
> sequence, which fixes this issue. In addition, it opens the possibility
> of modelling a state such as "Screen Off" that mirrors Windows, as the
> callbacks will be accessible and validated to work outside of the
> suspend sequence.
> 
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   kernel/power/suspend.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index c527dc0ae5ae..610f8ecaeebd 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -589,6 +589,13 @@ static int enter_state(suspend_state_t state)
>   	if (state == PM_SUSPEND_TO_IDLE)
>   		s2idle_begin();
>   
> +	/*
> +	 * Linux does not have the concept of a "Screen Off" state, so call
> +	 * the platform functions for Display On/Off prior to the suspend
> +	 * sequence, mirroring Windows which calls them outside of it as well.
> +	 */
> +	platform_suspend_display_off();
> +

I thought about it some more over the weekend and if moving the screen 
on/off _DSM at all I don't feel this is the right place for triggering it.

IMO it should be called by DRM core.  That is when the number of CRTCs 
active goes 1+ -> 0 call screen off and when it goes 0->1+ call screen on.

There could be an argument made only for eDP this happens, but I think 
that's a slippery slope if you end up with an AIO design that uses DP 
instead of eDP or a desktop for example.  So the safest policy should be 
across all CRTCs of all GPUs.  During the suspend sequence any that were 
left on will get turned off, and then it could be triggered at that time 
instead.

By making such a change then when the compositor turns off all displays 
at runtime you can potentially support dark screen background downloads 
that have specifically called this _DSM and any actions that are taken 
from doing so.

>   	if (sync_on_suspend_enabled) {
>   		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
>   		ksys_sync_helper();
> @@ -616,6 +623,8 @@ static int enter_state(suspend_state_t state)
>   	suspend_finish();
>    Unlock:
>   	mutex_unlock(&system_transition_mutex);
> +
> +	platform_suspend_display_on();
>   	return error;
>   }
>   


