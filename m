Return-Path: <linux-pm+bounces-19392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8079F5719
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 20:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844F816DA9B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 19:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66E91FA157;
	Tue, 17 Dec 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p1n8uM/l"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703C1F9ED8;
	Tue, 17 Dec 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464693; cv=fail; b=RpXWqYXQj23m46zWh7RxAaNsHWAKNY9XgqPs/7nBaec+krB7zk6+VKZnVSBaw8AwPqPql3ZLPW3vvGN6YeoZWJMisHn6yYuIfhr6f2LamL5aEMd07zIF+dqd7heK1II6/H1FpRsiltoF/Ll+ODyw6O5fumdzVZeRJHhhnlYZhoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464693; c=relaxed/simple;
	bh=j8FsfzbJYbGrtmJZ6l84hhzIPxJlPuoZyKrfgvRPK+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FHp1FQBNGgnZZ8ebQZkx9jIYB4w0N35M+cP1T6yA+IRswgimTEYkrLjtWrqeVwKHgUZ6IYQhY+As0D6n3J8+VUoMHiIg40unioI/y7rxjH1IQNZyC/pE/+H3jo7yAN7bhKsGz2K7gtntmk1nLuhuX9w2N09GQ0x1lLFtAyG7KJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p1n8uM/l; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUC2yscmyzV2SYB0PcchehNQGaJXIfoHraDXxvhzHYq/v0OqQRTlkXJMWG4F04O9jtwhPet57Rn5NJCriYFaWOgd1AIW8hc3oSZbcreAuxCnC0hj7SA2uGcxay/9iSTiZ2HGrOt5loXCkSh7yL9tFVSA8DrOHi6ZjOBSc7R7nBqP9FRvP6Gbo9HrUrnVkqgTkyDHjniah6JtVIytep/Up2by30MPRi8Db4/C1R6lGt8XNXE7bFJYEyWBS5x5MlTryFs8/eEU+8cjZD/Wyf7ciyldVLFmI1iM4W448W6JJG+waSTMrRAT725W96C+PK6VqHDtHWd3MzLjKvNHo+4Pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyDvBIMgO8npDeocl3i0Ymq7WsbVU9Qhmun7+nlkxME=;
 b=XDMzkK+RCxoTxLgt1DguEwBUcTcLFRG+gzDQZp8zGW/4jjBCUJgDE9i3ViqJVeF1tZ82upg+QkwpgO4EvcgI1QyyOUiCeW19GMcBB2F5rpFGVROZv9u6nsVfRwSf7XzsmWgjd+I/Jui+MYFqBZvJfOxJ8FMz40XmHYyLJp8LSAKqXy+Q1yE//VeBDgXbxAqa4ZG4xg7hHJhnk69D6n7UbLBn7POX+k06URo44z0wagBKJQSM3Y8K+MCa/fHtPqVgqW727ZydIWyPvLz6KkyvtLxTlVWAYptkt1YiU87qJWPUmO3YFRyPTPtc2//867Lp0UujxphzI/kYipMtU97SGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyDvBIMgO8npDeocl3i0Ymq7WsbVU9Qhmun7+nlkxME=;
 b=p1n8uM/lYAR/iYRQlsPhIOXCtIF5BGAoxhktcz60IAOBTt38lgCTaRJ6s2OoFeuv6tXu6hO0TjUz/egjXSyVWcipk5hLicFBDqtTluX3C3PBDHeVvqnZaWuzJSMJiMQa+PiI56XBuarXMArxm4ctiwmcAT9cMlThWMFaoWd//Cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 19:44:48 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 19:44:48 +0000
Message-ID: <a3ef3276-a7d9-41eb-8307-cb0e61eed0b0@amd.com>
Date: Tue, 17 Dec 2024 13:44:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] cpufreq/amd-pstate: Move limit updating code
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241209185248.16301-1-mario.limonciello@amd.com>
 <20241209185248.16301-11-mario.limonciello@amd.com>
 <d120814f-7393-4d10-a6de-ba09948f4243@amd.com>
 <6ea8c643-6977-4ce2-be1e-b0b0a73e8306@amd.com>
 <5330c947-7bfc-4932-800e-9067a9f78470@amd.com>
 <a8c6ff3f-2ad8-4926-9ac3-f0f39ceffa2c@amd.com>
 <cfcbf8a4-7254-438a-8b0c-29807e07ed90@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cfcbf8a4-7254-438a-8b0c-29807e07ed90@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::17) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: dba28098-b0e4-4429-ca0c-08dd1ed343e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTdKZDdsQTRMMjVBbk1MLzNvSnJBSFhueGs4QytkdC9aWEhWU2JicXB0QnBQ?=
 =?utf-8?B?K25adVdTaENEWHlmUXptaWhrS05aMDRSdlFueityVEs3ZFBaSXBubFpZb2J6?=
 =?utf-8?B?TDJmM2MwRjdzOGdoN05xc3ZZZW9VUkYyTjNaSUZMUTNGZS9WTFpZMldJcHVV?=
 =?utf-8?B?aGJIU2t5dG9GQ2VpOVU0WTVGZEd3ZjZ4NkNtbHBsNTgwTm1vWU81cFhLUkEy?=
 =?utf-8?B?Ym84eHlGak9obm9qTEQvK3NVUXpyQ2JkNUNQT21RRnlmNklWRzBVRFRyclRk?=
 =?utf-8?B?Szd0WmNyM01KbjhycmpxWDhDQ3ZDeXZNMVVSNmlBdmE4VnQ5cVlyTGdGSE1C?=
 =?utf-8?B?bXVtNnIxaW9aaG1BMEpzdVF4b0pqSWVpVU5ZVWxVeFpGSVNsRGhNN1lXTzNj?=
 =?utf-8?B?RjZyamQyV3djZDJpZmRRNW5KcVlmaEJWSmg4ZHdyTGhIYWRsY1dhTGsvMGNk?=
 =?utf-8?B?ZlRPdmorR0wrWVVydnMzK0hhcEFiR1AwZWU5cDdjZDVXWkIxWk9lVFFGSXdj?=
 =?utf-8?B?eGZzK3B2eS9rV05WdGJFL0Y2SXVwQTM2RzFVWlFaZ0g0YjF5bzVHMG5ZTzJw?=
 =?utf-8?B?ZUVCdXBTTUFIa3ZjWTRaUFZaMU8rYzkrZ3BiZTlZdUprOUhSakVuRWtLNEk0?=
 =?utf-8?B?TmtoRzhyc0NMNmVuVnd4T0RLeENJb3hUVzdnejNyc3BLRWRRSXF1OXNUTUo1?=
 =?utf-8?B?RmZ3RlAzc3FXdkpiZTkzVEZabmJTZG5hbUdkaHV1SzhnZERTUytxcVp3NWhm?=
 =?utf-8?B?dTBoR2VxeksrekdxaDRZTlREMVlkMnF3OVZiSWxvcHhlMGZENDlCYW1hUW15?=
 =?utf-8?B?MDQ3MXp4L0VTUUFpRGFJdEhjNnBGYnBQQ0dTek4vc3RlelFib1pySGZabEcv?=
 =?utf-8?B?cko1Q1Y1TUZvanMzOHNZTDNJdnlzYU94aDJjVGNycGpnL3lwYmRTVlhsV0E3?=
 =?utf-8?B?a0YvSWlBejJKMnRreUh0RTBWSDhkNkQyTGNXZHZvQS9hK0E1M1d0R2dYVm5z?=
 =?utf-8?B?bzJWSWlaeTVad3k1WVJObFZienA5amo5S3JQUHVId3o3QUZvVks1dlFIM0NZ?=
 =?utf-8?B?anROTC84TVIxNGE5Z0pjemtCU1V6MHBoYjJ1MFpvSUpLWUk1a1RtQkJxU2dX?=
 =?utf-8?B?bkpTb0s3SW5mcUFnU01tK0ptdHJSK0JyaldXaENPYVNaUTdkOElpd3FlcGRW?=
 =?utf-8?B?NysvY0VwZE1FM1hUZlFnVW9PRDA5Z0FROEpHNWVxNGNiT2o2b2VUZTJxVm1u?=
 =?utf-8?B?Q3ovVXNjck1Oa1l1NUdKenkzeHBuVUpCRmEyekxFQ2pDczRWWEVZK3ZzZGNl?=
 =?utf-8?B?VVhnejFFVHdONVhsM01taXZKMlVTcXkwWDZKUlEwR0FENFhRTHgwNFNyM0tJ?=
 =?utf-8?B?S0QvZ3ZsZFErT0FaZi8wenp4S2xwUC92dy9NR3pSVWh3a29odWZlRU5QUDRU?=
 =?utf-8?B?TEZSUzlRWGgwSmloVUR0QU5aWUw5RjlVVjBPNW5wRlovaWZtRUdnL1ZBNHJj?=
 =?utf-8?B?YWxVMG4yVW5jTktRbUVkZ1BjRG1ZMFMxVllXVlRZR0k5OFkxY1daWkFlWjVP?=
 =?utf-8?B?UWNEL2JBbll3UkgxUWl2ZTR4aHBsYTNFUmFscnNScS91Z2NyNDYxeDF6S2J2?=
 =?utf-8?B?UWF2ckRWcWRHOEJCM096bVdMc3FYVmVGR0lZc3AwQUp2d2MyZWZLOUVUcTh2?=
 =?utf-8?B?ckpWODRNZkx2YnVBakROUVVFc1VEc0FBdmJCcVNISXJoR2VSMVVScjlJWWdn?=
 =?utf-8?B?bXlYalpEN1o5VjVxM3ZBRXFMdWwwM3RRSGhKRU5QbXVHTkpCS2hBODcvQjlF?=
 =?utf-8?B?TkVLK1VhNjJQS1c4T2dDZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWVhNzFUQWJaeEpIejR0Q3NQWGcrc0I0dEY1Tk10WksvVStSMkFsY2RXaitD?=
 =?utf-8?B?ek9JUi91bG5MV2NsbzNvUUNBazJJc0F5MUZ3Y1Z4NG53czJ6TGF1QnpBeGs5?=
 =?utf-8?B?azRIdWpkM01sUTh1aTdOM1BYeG9wKzRIN3EydnV2UFp2UUxRekRvNFQ2SXpI?=
 =?utf-8?B?djZ2QVlLeFFBWXJmZ2wwOXJGVm1rK0RidFM0VzJONjZGb1lFVzZJU3RZdStT?=
 =?utf-8?B?TnZ0ZldDenBnUHJUS3dWd1pKc1pHc1R4V2g5aTJmbDFjc3pEcVhEbWNuMTRj?=
 =?utf-8?B?YTFwQk5uTFBzM01JcE4xc1RxcWRSWHRwM0JnRUZvb1E4eFRrdU80RXA3WjRW?=
 =?utf-8?B?c1ZUVWZoek5sd1c4UlY3cU5UdGJnd1pabnpEY0p0Sm9PaEd4U0dDNWVRNUxk?=
 =?utf-8?B?QjZRQWVPeTI1Q1dFb3NLUDFkVEtkalpFUmhuc05sek5ZVU9UQXk3Q0d0dmJv?=
 =?utf-8?B?RnF0d1pCeHpVOFFOaGNtVytqblBHYW1HSGN6N09VZTVsM3JLNW5tdHNrTjhG?=
 =?utf-8?B?TElWWnY1KzlEbExGdnpKZzAveFNwV3Q5LzM5dG5sYjhFOERoSmU4TDVQaW0r?=
 =?utf-8?B?YzVvY2FNdXh2NElYT3BUeDJFU0p3NnkrVitpNjlRK0x6Mm0yOG82SHc0dkFO?=
 =?utf-8?B?NVFkcm9ralVob2NjMDFBdkRtQjRSbGJ3WVVJR3h4WU5iaEZFMjRRcUIyZjdZ?=
 =?utf-8?B?d1YxcFNocmJ3NGlVd0YybmpxLzZEQmJqemE1Y2tmcDU1QldmOExCanlSZmJ1?=
 =?utf-8?B?MlRuamwzVEoxWU1ybHV1YXQ2ZjgvSUlVVEZSeUJRTWdod3liTGxtNnBxcXE5?=
 =?utf-8?B?eU1QUStkYVFnM21xdFFDTm9Wb2psb2JGeUlJeVBXRnkzTDdjbTQ5NkQ0ZDg4?=
 =?utf-8?B?TDRNL21Ncjl5MFg4Y2ZuODJQSmNwdE1FUWNydWl0c0puMXlwUEMwQjZWVXVx?=
 =?utf-8?B?YmlleXU2WjJTRHQ0SXYzRUpqaXJqTXhkNXBFUWU0S0hRYWtNT3FaN1B6N1Vr?=
 =?utf-8?B?MitXend6ZmV0OG52eVQ3SkRCanM0UDdoMGtvYkp1a2x6S3BTZ05Lb2poOUJF?=
 =?utf-8?B?cTEyODVPT3FSbGVINDZlWjBrdFRGNTlGWGlSTVhRMUlpbGMxOHRnOGZGMEFt?=
 =?utf-8?B?V1cwRWR5QUtYR1EwVDVJczN2L0dvU21wVHBIdDQ3dmVGV0ZRYlZyd0pMVjBL?=
 =?utf-8?B?anhVQkVlNjdDc2pzdkpIMkJaM3lLdkRsbElBUGl4ZW1zYXI2T1ZFYmtndmc2?=
 =?utf-8?B?eVYrVTdEc1NiVlZiOXRMMUZHakJyZnMvdjNLb1lnL2U5MThhMFBCUDR6TUdH?=
 =?utf-8?B?VnhicUl1NExxTnQvVDlCTldab3NNS1RyWEl5VXIyM1BUQmdoK1FuSmhRSTc2?=
 =?utf-8?B?ZGhJcGtkV0dsSzd2QmRxMFRDYlZTb2NJMDNoK2pUSUZ4bHVLY0JBR3EyYk9F?=
 =?utf-8?B?c2VFbVI3UWFsRVpqSkt2R0lmTG1TZ2crRlpTaWNWVyttK2NhMUVFOHNtYUlK?=
 =?utf-8?B?TFhPNk9mZi9xR1lZOUwraVB3OEpZZnNYSncvVEJ2ejBoZkRmVzJ2Vmk0VGUv?=
 =?utf-8?B?NHdod2RDLyt1Wm80a2YrVlNxOHBJVkVwb0hRa3kvVG5RNmNzTVhKL0hZaktO?=
 =?utf-8?B?YlFtSGw5WTUySGVBREE1MEgxL0pRNUp5QkFveThmN0dhZEJDSkpuMW5BbFBY?=
 =?utf-8?B?Y0phdndFOHAzRHVyL1dFM1QxWHo2SEUza2lsZ0JmMUNNaHJ2ek1HOUhRczYz?=
 =?utf-8?B?RGRtR1JWSFhtMi9pRGd6V1pHRCsxbWxlM05RMkFrNE5pSGFDczMyb3U5SmlY?=
 =?utf-8?B?QmZpUVk0S204VUFGa1VEd2o5a1hmcWNYRmJNdkxVOGdTY3ZFNk8rWUh0ZG9r?=
 =?utf-8?B?YjA0VEttMVJRTi9Sc2ZteXR5TDR0TDVZbnFBQmJsMHVGQWJHYkhzTStJenor?=
 =?utf-8?B?Tk9GeDlRczQxSFJpb1BqOHJ6Y1ZsdmQvU2s3VEExZFFJMTVqSm9aYzlnRmk5?=
 =?utf-8?B?TzRXdW1zbXhuRDB3MVJrTkJoblQrQ1NjOWljOTRmcnIxZFo2Y0sxL2tBU3Jn?=
 =?utf-8?B?KzFUOXJua0V4WU0ySlM0djU1WFRwcjRKWlA0VCt5NjZIRWo4VG11ZWZpczc5?=
 =?utf-8?Q?GEfou0X9RoyIA979AopO+Of1z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba28098-b0e4-4429-ca0c-08dd1ed343e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 19:44:48.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+DQeSQx+zDKWVjd77RjvvfXquUwBNORmR3vtbyl0tOSWG9XiWaIY77wct9DLDFykYF4gJ64zxi+verSjG4Gyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456

On 12/17/2024 00:50, Dhananjay Ugwekar wrote:
> On 12/16/2024 9:09 PM, Mario Limonciello wrote:
>> On 12/16/2024 08:45, Dhananjay Ugwekar wrote:
>>> On 12/16/2024 7:51 PM, Mario Limonciello wrote:
>>>> On 12/16/2024 08:16, Dhananjay Ugwekar wrote:
>>>>> Hello Mario,
>>>>>
>>>>> On 12/10/2024 12:22 AM, Mario Limonciello wrote:
>>>>>> The limit updating code in amd_pstate_epp_update_limit() should not
>>>>>> only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
>>>>>> so other callers can benefit as well.
>>>>>>
>>>>>> With this move it's not necessary to have clamp_t calls anymore because
>>>>>> the verify callback is called when setting limits.
>>>>>
>>>>> While testing this series, I observed that with amd_pstate=passive + schedutil governor,
>>>>> the scaling_max_freq limits were not being honored and I bisected the issue down to this
>>>>> patch.
>>>>>
>>>>> I went through the code and noticed that in amd_pstate_adjust_perf(), we set the min_perf
>>>>> field in MSR_AMD_CPPC_REQ to "cap_perf" which is equal to cpudata->highest_perf (which is
>>>>> equal to 255 for non-preferred cores systems). This didnt seem logical to me and I changed
>>>>> cap_perf to cpudata->max_limit_perf which gives us the value updated in scaling_max_freq.
>>>>>
>>>>> I think as we removed the redundant clamping code, this pre-existing issue got exposed.
>>>>> The below diff fixes the issue for me.
>>>>>
>>>>> Please let me know your thoughts on this.
>>>>>
>>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>>> index d7b1de97727a..1ac34e3f1fc5 100644
>>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>>> @@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>>>>>            if (min_perf < lowest_nonlinear_perf)
>>>>>                    min_perf = lowest_nonlinear_perf;
>>> here^^^
>>>>>
>>>>> -       max_perf = cap_perf;
>>>>> +       max_perf = cpudata->max_limit_perf;
>>>>>            if (max_perf < min_perf)
>>>>>                    max_perf = min_perf;
>>>>
>>>> With this change I think you can also drop the comparison afterwards, as an optimization right?
>>>
>>> Umm I think it is possible that scaling_max_freq is set to a value lower than
>>> lowest_nonlinear_freq in that case this if condition would be needed (as min_perf
>>> is being lower bounded at lowest_nonlinear_freq at the location highlighted above).
>>> I would be okay with keeping this check in.
>>
>> Well this feels like a bigger problem actually - why is it forcefully bounded at lowest nonlinear freq?  Performance is going to be awful at that level
> 
> Actually this wont necessarily deteriorate the performance, as we are just restricting
> the min_perf to not go below lowest_nonlinear level. So we are actually ensuring that
> the schedutil doesnt select a des_perf below lowest_nonlinear_perf.
> 
> (hence why commit 5d9a354cf839a ("cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq") was done),

Sorry re-reading I didn't get my thought out properly, I meant to say 
performance is going to be bad BELOW that level.  We're in total 
agreement here.

>>
>> but shouldn't we "let" people go below that in passive and guided?  We do for active.
> 
> Yes I agree, we should allow the user to set min limit in the entire frequency range,
> I thought there would've been some reason for restricting this. But I dont see any
> reasoning for this in the blamed commit log as well. I think one reason would be that
> below lowest_nonlinear_freq we dont get real power savings. And schedutil might dip
> into this lower inefficient range if we dont force bound it.

OK I guess to avoid regressions let's leave it as is and do a minimal 
change and we can revisit lifting this restriction later after you get 
testing done with it to see what actually happens.

> 
> Thanks,
> Dhananjay
> 
>>
>>>
>>> Also, what is the behavior if max_perf is set to a value lower than min_perf in
>>> the CPPC_REQ MSR? I guess platform FW would also be smart enough to handle this
>>> implicitly, but cant say for sure.
>>>
>>
>> I would hope so too; but yeah you're right we don't know for sure.
>>
>>>>
>>>> As this is already in superm1.git/linux-next after testing can you please send a patch relative to superm1.git/linux-next branch?
>>>
>>> Sure, I'll send out the patch once we finalize on the above if condition.
>>>
>>> Regards,
>>> Dhananjay
>>>
>>>>
>>>> Thanks!
>>>>
>>>>>
>>>>> Thanks,
>>>>> Dhananjay
>>>>>
>>>>>>
>>>>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> ---
>>>>>> v2:
>>>>>>     * Drop lowest_perf variable
>>>>>> ---
>>>>>>     drivers/cpufreq/amd-pstate.c | 28 +++++-----------------------
>>>>>>     1 file changed, 5 insertions(+), 23 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>>>> index 3a3df67c096d5..dc3c45b6f5103 100644
>>>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>>>> @@ -537,10 +537,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>>>>>         u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>>>>>>         u64 value = prev;
>>>>>>     -    min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
>>>>>> -            cpudata->max_limit_perf);
>>>>>> -    max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>>>>>> -            cpudata->max_limit_perf);
>>>>>>         des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>>>>>>           max_freq = READ_ONCE(cpudata->max_limit_freq);
>>>>>> @@ -607,7 +603,7 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>>>>>       static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>>>>>     {
>>>>>> -    u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
>>>>>> +    u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
>>>>>>         struct amd_cpudata *cpudata = policy->driver_data;
>>>>>>           max_perf = READ_ONCE(cpudata->highest_perf);
>>>>>> @@ -615,12 +611,8 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>>>>>         max_limit_perf = div_u64(policy->max * max_perf, max_freq);
>>>>>>         min_limit_perf = div_u64(policy->min * max_perf, max_freq);
>>>>>>     -    lowest_perf = READ_ONCE(cpudata->lowest_perf);
>>>>>> -    if (min_limit_perf < lowest_perf)
>>>>>> -        min_limit_perf = lowest_perf;
>>>>>> -
>>>>>> -    if (max_limit_perf < min_limit_perf)
>>>>>> -        max_limit_perf = min_limit_perf;
>>>>>> +    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>>>>> +        min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
>>>>>>           WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>>>>>>         WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>>>>>> @@ -1562,28 +1554,18 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>>>>>     static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>>>>>     {
>>>>>>         struct amd_cpudata *cpudata = policy->driver_data;
>>>>>> -    u32 max_perf, min_perf;
>>>>>>         u64 value;
>>>>>>         s16 epp;
>>>>>>     -    max_perf = READ_ONCE(cpudata->highest_perf);
>>>>>> -    min_perf = READ_ONCE(cpudata->lowest_perf);
>>>>>>         amd_pstate_update_min_max_limit(policy);
>>>>>>     -    max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>>>>>> -            cpudata->max_limit_perf);
>>>>>> -    min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
>>>>>> -            cpudata->max_limit_perf);
>>>>>>         value = READ_ONCE(cpudata->cppc_req_cached);
>>>>>>     -    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>>>>> -        min_perf = min(cpudata->nominal_perf, max_perf);
>>>>>> -
>>>>>>         value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
>>>>>>                AMD_CPPC_DES_PERF_MASK);
>>>>>> -    value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
>>>>>> +    value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
>>>>>>         value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
>>>>>> -    value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>>>>>> +    value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
>>>>>>           /* Get BIOS pre-defined epp value */
>>>>>>         epp = amd_pstate_get_epp(cpudata, value);
>>>>>
>>>>
>>>
>>
> 


