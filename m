Return-Path: <linux-pm+bounces-16097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC199A69B6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85430B2B548
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F11EC01E;
	Mon, 21 Oct 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I2/QZ8fF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E41F76D0;
	Mon, 21 Oct 2024 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515923; cv=fail; b=H4U5d31mO/o0J/pdAA706/73VwYdsra01TA/SsrHhnu8IYptbMT38Zen/kTqeV+ProReGcQk9Zdml7hi69IMy6LjFynmOWj5o6iVYNl5tBT/FumBDUpLuImAzRESm8uMc3I96dF0jdRZDaA1s+nWgKGmoHI6GW0wUfbw2bZwJw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515923; c=relaxed/simple;
	bh=HPufvja0TfrBsED83DL4FOROoKsHhkNprV/XddK0mMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YA/RqFXSGzQcwBoL9uuaGV3aeMWS2rAAe5qVQIVmCzTZg6Bgv5IVIJOqZ+Y/PXopbKorjYl+VebJ+VDnPf9seujnezJSr4HTv42Ovy44uvQne21J7AlYYXJvjF3R6U5UMdcPTmzhqGprJodykzKJl66VeknnLA7MZA24DLdjHY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I2/QZ8fF; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyjNYwW7HTl3+Xqkr9TnyBWCqJICQQWzYxGg67MWmxk8vXVsXDBB2u5Q7MVVLV0FTK6An/pMSmoRdC0wvnlTIgu+4iOIC8lEoSvr9UYGc9Rc3M5aBsWC3PkPkfpKi3+hSGZCOQ+zibfauacwOgkU5C7r4tsKDizlgXWGiAThbaGdFS/6EmNncsC4D4VjAeySMEL6Kns885BfB/Y428Ef97C4QXjesvwr7TvnoFNMucEDutVDEI0Ix841LXBSgHv3XfVBStT2cgJLXGJVROY9F5jX/W1JIeq7Xvp/qriCVSQpj6nucBX61UakHran6DEA8BQnub0kx8XmY9W5qECWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykzdYzij+UtEN3xpRiEUjY7ODesdn0EVAgMB1s8nGTE=;
 b=qP/PtxkcAthEac/C/zImYg5AeWjbMVT0pYlyparRgW9ER9yVoqukIW31BP1o6HuWVopecFd45p6oOxDIjE3B48HDQ6xy6IK4Fxq4GWIDzIkKleXbjMJVdRMIBcAgNLVoVhh+1VqZqyCGV8asgc2gqcuPEePwSezyzF+lKs4vHPquKFe+GqZ1Oo+F4u0Jk0PB7gwGoZezqldIysqi4Na2rh9At4gN96IVDW0YgsOzs/7gX5+G88l3/y0sDCfeEs27UuBzRcBQ3d7DxUPINhXoAogv3nKblJZplYWdhB28Kc0dmSFTHpQClSHqi5dnARylnnCTX8QNBvadIoezDboEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykzdYzij+UtEN3xpRiEUjY7ODesdn0EVAgMB1s8nGTE=;
 b=I2/QZ8fFvJ7icUjoWzioa9kdbJYkdvSsLellROhq07nd+Fh10bDSHnuZS48/fbmY2r8gB3w0heZKirgEXYHd9OQivqelVClfnNk7skPE99DZySrPeUMc/W9DOTqbfQ7FsEZbLR0RQIr9cPetbVna2MbF4QJZRszIrZX5ikdaeD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.20; Mon, 21 Oct 2024 13:05:18 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 13:05:18 +0000
Message-ID: <d5d8783d-472d-4266-a0cd-e9eb7ba3cbac@amd.com>
Date: Mon, 21 Oct 2024 08:05:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] amd-pstate: Make amd-pstate the default driver on
 server platforms
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241021101836.9047-1-gautham.shenoy@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241021101836.9047-1-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:805:de::31) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfadd3f-90c2-4e05-0fa5-08dcf1d102d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emptWllCdi90Z29YWGU1dm5OMlhBYk9sV29uT3dFTlhqczF5OFViZ0d1MzdR?=
 =?utf-8?B?TkNQZmwvdGR4d1Z4dHRLTjZndzBiTGRIMVVoVE1yckYrVzhkWFNXY2tNeWVs?=
 =?utf-8?B?WlJWREoxL0VHWFYrd09FZ3AxdGxCR2c2cWJ4ZTN3QWpBU2ladnFxTUlpRGZa?=
 =?utf-8?B?OXBhaUd2TFhLTjhYY2VVUFZUYXFVNVc5SU8vd2VMNmtlM1YvNlpPUi9PR2hP?=
 =?utf-8?B?TisxTHBlcEhMZXEwNEN4ZFI1YUczUmZ5enltRklzVlNob1ZiWllrL1Y1ZnpK?=
 =?utf-8?B?Yk05dVBBNDNwL2pueGs4TXNtbDJDTmw3SE1DSXYrbFFlK0ZwakhRRmd0OW45?=
 =?utf-8?B?WTR6RW8zMVFRb00zK1ZqVDVwWVJjb2VLb0tBTS9QWjFUczdIWXozdFlnbDd3?=
 =?utf-8?B?UnR5YTJwdk9lTDZGNFd3UnVRbk94bE1Ta2NFbC9jeDZZMEYzTFcxVENpRWRt?=
 =?utf-8?B?VW5XWVkzMHlrdEhDUXBiSHZrSUlJNU5WQXhxSnZWSzBSa3h6UnBRbmNmUUJp?=
 =?utf-8?B?L0g2NHFpeGJmcU5YcXdKNWV0aVRoazBwQmhEc09tR2RraWx0bnRNbGV2LzJr?=
 =?utf-8?B?NW9VcysrNGcvSGp6TWNlcFJWc2prM25vTFlsMGhDdVVQV3dFV2lRT1plOE1E?=
 =?utf-8?B?TEludVcrUUZId25KMHhNaU9zMjhCcUJUMHhmWVptUEo2dXZSOU45SFhCNG9p?=
 =?utf-8?B?cjR2WDlFQWNDUHdoNEt4Q3ViK2xQdXNKcTlTVDduaHpadkY0eTZxSmRoUXRr?=
 =?utf-8?B?NElRTklZZmFCS0NUQ2tHaEozRHpadGNxNzJqUk1QMmlxUDh1MjVKOTAxODRR?=
 =?utf-8?B?d2pYZ2xYVkxKVkg0SEVvOHM4UTRWQUlSZHB2K0RSbEpOK2ZFS3RIMEUrd2xI?=
 =?utf-8?B?V2R1aTFGUk9CcFIwSURhUUtlbXp4ajZxUjdaaW9hOE44UWYxMWhzSEYvNXA5?=
 =?utf-8?B?K1ZmWHlXbUtKQ3dpck5qZFhFNWZla1EvQlU4OEtDWHZvQnMrN1NwOHRBdzky?=
 =?utf-8?B?UWdmUDA4RHlqNFpWaEdBeVFURTJQUElBc3pvWHM5VTI4WlJRTEJTWVFhUWtY?=
 =?utf-8?B?a2VsOVRHUzVtZnZBWXRjL2ZINnNmOUthZnJDRnVXZTViZmtoVTh0L2FnZHZu?=
 =?utf-8?B?aVh4UG1UVFNNV2ZYTHNXWVlvNmVPNTNOVit4VXNqM1VCKzkzV0Q4NlJ3VHYy?=
 =?utf-8?B?bVNDYzYyYlQ2MzNMc2FuM1RkRXViVWE0ZTROeENXZUtwVy9oUmltWEduK0Qr?=
 =?utf-8?B?UUZ5NmkvRUNrWWh2VWNJU25WYnVvYnI5QU1UbXh0c3EyL3JPOVpTaisvSFlr?=
 =?utf-8?B?T1dWbFpob2lhYVB6Q21wNHZyeUxLMWVOaldpRUQwZEIrcUJTT1pHa2h6ZmIr?=
 =?utf-8?B?S1lXL0hXYVRFenhwdFBhdkgxRXFYTlAyUXFiQUY1NE95dnZTcEpxREVRMmdG?=
 =?utf-8?B?aXl4emFxaXMzb0F0OUd2a0tKS3NkanZIazJURHA3Q2JiMWhNMGVqUDhucDhL?=
 =?utf-8?B?dEt6a3VzVEtoWmZYaU9HeXRpWVlSeFpTRW9ZdUoyc1JJck10WTB6ZU5ibUt4?=
 =?utf-8?B?U2FrdElpeTlzV2ttUVFiMVZ3WFVrelFOZ2doUzB4N3V6Wjh6R28zYlY0S1NQ?=
 =?utf-8?B?dE5UTnNkUkd0NWlMU0twSjdaMVowb2cxN0p6ODdzWkZjSGFhYjdwd1AzZklI?=
 =?utf-8?B?Ujc1OVpBUGs5M1oyNDJqU1YyYnBzS3ZHdjdBNzFyQzQ3ck9JK3FTUVEyNll5?=
 =?utf-8?Q?GvkrssRsf6jNyn0IMYt7HdiSzwy3sj0H18/yQY4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UndlamZtZFRyLzRhVGRPTDYrcGRKc1dHRTR0ejFVWG9xQ04xdS9yc0xNOEtR?=
 =?utf-8?B?RUU5VVV0enMzanZ6Wi80MzBQNkVGcUxoWEZXQVJvNU95OVJBWTIwUXVUZVFk?=
 =?utf-8?B?aGVOVmtZZjRiS2JHUStYS3B0cXYraDI1dXUzUE1ydzZxNjQvc052T0MwU0do?=
 =?utf-8?B?VjlpTnR6RTBRU3lFbHUrUmFxRXd1QXAwWmZzRmd0NTV2T2pLZTl0SzJyMUpr?=
 =?utf-8?B?NW0rVnpEV0h6clNMOUd3SlQxZldjQityK2pwclRqQngxRkVVU0dsV1d5Y1NU?=
 =?utf-8?B?S3lJNHUrdllmK010TzFTMHAybWJQcGRBNkdpaGZ3TGZ4amFVWEkvb2ZXRktw?=
 =?utf-8?B?NU14dTErOXdHYllpb3grTWtobnl4akgrN0tUcjlZWVNGVk5LMHB3MUxrWTlP?=
 =?utf-8?B?b1NTTmR5dUhQYUxybGYvOVJTNSsrM3E1WWErUHVmMmNOMmIxV2VXNFdTRElX?=
 =?utf-8?B?U1paYzZMck9WaE1HbkJ6aGN4ZGl4NkRsL1g0MThvWm80RncweFJ5OWNXNFZC?=
 =?utf-8?B?RTlGVXVDYTlXRk03VjJDTlhMeWs3M1JRUkxZVFZYMHRJMmx3TUpMRG9wVndu?=
 =?utf-8?B?bndhekF3ZDBqZGt5K3dtVzRMQk1EazJNcm92aktKbFA5N0w5OWM0VFdaVHpx?=
 =?utf-8?B?eUg2NmZKeTVORG1oeWF1SnpNQU4rbEM1OE5mN3V4blorc0VyZWJxdCs4Z1dB?=
 =?utf-8?B?N1VQOFA2eEJvT3ZGeHI3amhHL3dyemExeWY4TXMwcjlaN2p4MTIramFKMHA2?=
 =?utf-8?B?VHhJUGk2UW1OWFc2UWhmUGRialVwaGNyQkxnN3RockJkcHNtWEJFTXZRakdi?=
 =?utf-8?B?MzVJSWllZUJTNUFvelcrZ1puYmpOSHZaMldlTUNDYVBxelNrV0VJR2Nsd0Rz?=
 =?utf-8?B?aWNnOUo3K3ZJR2lOK3hwU21LQVlmZU0wOWNCbytxWVQ2VHlCd0wrZ0dFRkRX?=
 =?utf-8?B?eG45UGpkSHNidFFsN1N0UDM3eVFYaXhDVU5GaGMwTVl3VVE1VlFUaTJzWGVB?=
 =?utf-8?B?VkRhdDNCWndtNWxaRGI2NEpOMjl3blNFRmFxd29nUlRMV21YWUQwdGxtRWFm?=
 =?utf-8?B?THBNbmw1b1RlMjVKY00zZ2FsQVBrRU5mSlladko1TllIWjhia0hETGFadnRE?=
 =?utf-8?B?VkYwSVhFNDJNU2lyRXRGS1NOc1hpUDdwUlNaczFSdFUzU0VZeWk3QXpZUVIz?=
 =?utf-8?B?WFdEelJHMFRxR0FrN3lVY3o3cENuOE5LNmlxTG5XNFluUk5pOUlTckcrUFg5?=
 =?utf-8?B?WkhSb2tnWHZld2JLbzFYZUM3QTNkT04waE9WU29aV0NKU0krMnJySmRiOE9Z?=
 =?utf-8?B?SlF1SERBL3Zqbmxlbi9RR0VsNCt5dTJ0K0poaW1ySEE3SjFrV2ZtMHNsK1Fm?=
 =?utf-8?B?eU5oMFpZOWs1SkkyZUx4TG1ZbVlsTXA1SmpXdGhicE9SNHNXVmFDZXFtRzBi?=
 =?utf-8?B?MTlRTEpoc2g5SSt6RDVQUTdvcmY0RzZ0UGNqdllXRlBIWEE5VWVnbUlCVGNF?=
 =?utf-8?B?RVRxSlN2WGIra3ZPUHBBQUhnQWhNblR5UjNaWE94Mk84V3RqR0cxdVpHVm9R?=
 =?utf-8?B?eVlRb1pmOC9MQS8ySEpmWE1pNXNlQkhXc0RMUlVBV1g2V1hNMUJweEZ3bHdK?=
 =?utf-8?B?VkJHYjg0a1NEcEUxTUQ4ZlNmNmZrcjVDNzArWEZsNHdDQXBQdEdlTzJ3UE4w?=
 =?utf-8?B?UzZDZURMZzVVdGlQR0pBVEZlaHhjYVl5c3JWL1ZuUUxnUXJzZ2ZJUUIydzFK?=
 =?utf-8?B?dGJGTm4zcTV1U1VOSGZDWVJ4L0dWb3gwOUhnQXNmczVwdllMMFR4cFpsbTNT?=
 =?utf-8?B?cjB6aXNiaE5NUHVaNGplYUlZUnUrS2dKRXhvd01vY2pyK0JTZXBpYUlJcWpz?=
 =?utf-8?B?aCtCbGVqUnUyZENuKzFQeTdBMDlSN1VLZVQ3cStnL2hTUWNZOUY3NWYrQ3VZ?=
 =?utf-8?B?VTNoTHFQSjU4TFhmUmFwaTFZNG9uQWZqSGx0Q2RvM1hZZStaL0VYMmI0aE5O?=
 =?utf-8?B?QXJqVmJENHMvMDArKzd4MlU3azZPTmxXNTh3N25WMHFaOXpOK0VWdlJBTkRT?=
 =?utf-8?B?TkFoME5hT2ZPQ2lRbUNXZ0lTdldPcUJ1N2dmelN3ekx0UzlNYXVvRkU4ZUlO?=
 =?utf-8?Q?A/rXXDYvJi2Xh/irIMp/+YREI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfadd3f-90c2-4e05-0fa5-08dcf1d102d1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:05:18.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKeKx5hqjSmx4ierkPaC0EXsEnsBagbIDaVD4VDQnz/7sCzyfHaexbzuJoD5dXI4AM/57ffNUAnC/GIuFCBd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371

On 10/21/2024 05:18, Gautham R. Shenoy wrote:
> Hello,
> 
> This patchset contains two patches to
> 
> * Prevent frequency throttling on power-limited systems with
>    amd-pstate active mode with performance governor.
> 
> * Make amd_pstate default on EPYC Family 1A+. Based on tests, the
>    amd-pstate driver performs well enough on EPYC.
> 
> These patches are based on the "linux-next" branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> 
> Gautham R. Shenoy (1):
>    amd-pstate: Set min_perf to nominal_perf for active mode performance
>      gov
> 
> Swapnil Sapkal (1):
>    amd-pstate: Switch to amd-pstate by default on some Server platforms
> 
>   drivers/cpufreq/amd-pstate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this up for 6.13.

There were previously two differences for server and non-server:
  * amd-pstate not enabled by default
  * amd-pstate cpufreq policy starting in performance mode vs power-save?

This series adjusts the first for at least the newer parts, but I would 
like to ask does it make sense to also evaluating changing the default 
policy to powersave as a follow up, or should this policy delta remain?

