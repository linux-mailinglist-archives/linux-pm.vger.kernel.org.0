Return-Path: <linux-pm+bounces-10020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D891791F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7AC1F228F8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29F11487C4;
	Wed, 26 Jun 2024 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cC5C+Juk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC192175AA;
	Wed, 26 Jun 2024 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384330; cv=fail; b=DdDkdmmNUOn6yqio8LVJgYk1Lasy0vs8k+Me/cJqqySszWasqO/gNk4L2eX0NCTZy8ODE8sgRQTOKRJ5k3kbiagBxJaKk/JFph9ZDCNujKNYFadCfkKykDD10HUHVySsH7Tqsl78OluyFETwQDDJsXKDxRMzIHvqCv7Y64i8XGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384330; c=relaxed/simple;
	bh=Zdl8sLW2TqxMJ3VRflBuHCsHQzcgNvhA58CgjFCPC8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UHA8d1WbBII03L0Wj2kfz89nF+mc5K6JpcVzWAPttHu6KcFfAQ/bER8MfGS8Cu1J77Get66+AwHFh1d2sqGRbYUxc7fw4DIw6NKfHgAVg2VR6gPmiJiq+JTCa/ObqoV1IBLVaRlIFHiOFI+1jwH08c61X4xl+6fQQALzvRWgREs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cC5C+Juk; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAbMheX9tMAyyzGYZ1QYrJ0jpRBagPbOlvYjZiGaWHNFfdgKD/5OOKaDkGtMfb2oBVKrRFeuoP+a6DJqHZismBMVmmPG4ku4kj9cH/Aqh/lPBMH8+UPUAJ5/yrf0KOozttyh+E3LUsk9tSem7EakUPEtlXSpaF/TfLa7NrQB3mACrUcZiS/jVPUkuvQtfXZoJdF1MGMHN3mOq+x8onuyYUx4Wr55MJWYy65GLn4Hup2ZZ2k9NdcE224/TWpkUF3wkMzQ9efEB458dnuyFFJNEOE9el9A9mOoRZ09Zj49fnALZ574NfhgPJ7qH53xWlNC0qtwuH7N6JXUDTqhBhoDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D92DKrk8yT01eXDDG8adGUznJTQIro8b8YuHzbwF2/k=;
 b=Fv4+/JyvP7bFS9+WMkrfPiDLQ9g8ECZzb1gs/4cVJmVgk75m/+5Kucxt+VqoYGmqnlAbRcdrS7696U71jai8j5g7FntuncPg+2710Pz7+YqvebvEHOUik0G1cnBC94yxMFzYDvzktSaT2LH1pcj69lC+qXX7HAj/EyvMGdCoaL4PGwowA42rGU1wFrCL7QPATzYbLmtsOQRFRaBtfCpbjWo2A4X6Jp8kQOFyiLrcOnM4T5gBUDOhWQMB06kkj9j34AeIFHU0ad977cpS3YjFoWFZI2uK32GjfFEXXODTgoh9rixpQzlL7BJC8NBTw5FBkEpejPd7032iCtT9NR4bLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D92DKrk8yT01eXDDG8adGUznJTQIro8b8YuHzbwF2/k=;
 b=cC5C+JukpLSP3zqSLK92oM6ZNwgMzTOo8GmVQCGEYs6I71EGDE1tJZhlpzrGv4CRVkHfDehbrOWyl4OP6oGYiv4MMKJkNgNHR2SFqBaVb/Gbsdh+bxGjt6ClZOOUJE8o/CZjniEO7RAtdOBTtGAij5mkFUxSOMOFSyh3k7itQpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 06:45:26 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 06:45:24 +0000
Message-ID: <4214cbfd-b8d2-4eb6-9870-5c74c056e51f@amd.com>
Date: Wed, 26 Jun 2024 12:15:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
To: "Gautham R.Shenoy" <gautham.shenoy@amd.com>,
 "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "Huang, Ray" <Ray.Huang@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
 <95bdfe3e-610f-43de-be2e-294cf2576fc8@amd.com>
 <DM4PR12MB6351BDC3C062E65F0B26F7F0F7D62@DM4PR12MB6351.namprd12.prod.outlook.com>
 <875xtw2s8g.fsf@BLR-5CG11610CF.amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <875xtw2s8g.fsf@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::20) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 826962d7-eed4-4c87-f286-08dc95ab8e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022|921018;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHpxeG1rNWUrcCtMcHhiWUdYVUdLOVNOaEVzZlVkd0hBNkRUMkUzVVUwM2RB?=
 =?utf-8?B?ODBDaG5tUEw5UE51RHUxa1FxM1dpbTFBaGN6QTNUc2tEaGx0WWF5Zm43Sldz?=
 =?utf-8?B?WlVxNXZCaFhSU0tHWXRMaXBIc3VHMUJWQVBqSWdMbjhVdHcwSWpXd3hINmNL?=
 =?utf-8?B?MVVWdXVYaW1lNTkyK3VTVk4rcnFMSWZpU2dwWmdGRTRGazNnb0txK0pYQSs2?=
 =?utf-8?B?QXNTcVkwWEUwR0Z3OUowN01OU2JqMzIxL28zOHo2NTdpVEFlM3lqbWVCR2w5?=
 =?utf-8?B?YWhaVkdWNllETnBpMmR1WEFhMXZFWHZpclIyaVA1QzBhVklVMUtuRlliL3Ex?=
 =?utf-8?B?Wk52M2xnT0l5S212N0NtbDRQMDNKR1pSaitPOFR2WHEzSjYvYVNqYzFtOCty?=
 =?utf-8?B?bVFBRFY4NU0vRy9uUHZkdWR4RnZLQk90NTlBR3JGUmFqdWRSV2N3WjJzQWhh?=
 =?utf-8?B?cmVQVzRVejRNRUlqd1duQlhYaXFRR1dET3Exa2MxUkJyZ05xaER0RWlCZHo2?=
 =?utf-8?B?TVAveExuU0JOMTZnNFBQQWwvUW03MGV5OHRySXM4OWFJNUNvcTNNdzJUVFlM?=
 =?utf-8?B?aWllYWZwM2V2aXlQSDV3RUdYbDVNUmdyUy9HdnZOVllmV1N1T2ltazFYd2Fm?=
 =?utf-8?B?dmx2Q2JxZFFqUk1JRUhIcHJSL2IxSHNrQUJEZTNCSWk0QlRGTSt3cXVwZGJl?=
 =?utf-8?B?MzJ1bksxMldHTzZvanVVdnZuRzlxTVBFZUs3dGpMU3htUFR1enV2RDFwNGlo?=
 =?utf-8?B?OVpTZnd3aEtBLzZXMDJJRTAyb0ZpRTBOVjdpc0Z1K095MjJsN1plcC9XYWVU?=
 =?utf-8?B?MnYzS0NaWFQxU3VpTTdrTUVVcjh2WDZ2VWtwZ1F2ZDJnbnFTRGZNUGdWdkpI?=
 =?utf-8?B?aEUzZ21rcGhvdmR1ZnN5VW9vM1pPZmlYY0FGbTdBalRZVFRJRFh4VkIwenhl?=
 =?utf-8?B?Znk1S2o0RU9IOHhJRm1ENFVXb05JRjNGdGFWcFNhSi94ZlU5SGh6ZjRyV0I2?=
 =?utf-8?B?OTJPSlpKa0tPTzNDbzlWRmpWWVJqekI1YzFpejBsQ20xcnhWS1E2YWtabEw5?=
 =?utf-8?B?YXFBUjNtYldadEgrSnpMc3ZKSmlrei82b0IvRG5vcGVWaEpWOC9zN0psWU9C?=
 =?utf-8?B?aUZ3TDVRWGxGd1I0SExRc3FZMFR5dTYvUWNYQ1h3ekFzZE5zUFhEK3NIQzc0?=
 =?utf-8?B?YjBWT21SVFVYR1Y2S1MvZCtCMkVZakp3bjNRdE5VZzZuRWFETHJsdnJ6dlpq?=
 =?utf-8?B?MlE0M3hrMHhNWTRwb2J4UkpDQktwRytnbHg3NHZudzVwaTBRakFFYm9DU29S?=
 =?utf-8?B?WXhBTUdRbWU0Vk5sR09teHdMYnc0WUxOMFRhRi9hTXNxNGNOY01LQXNhdlJL?=
 =?utf-8?B?SWlUb1JzQ0NxcHE2THUzRjRhM3FUWHV2RTdkdmw0TzZsMUIxbkwwcGZaWXNa?=
 =?utf-8?B?ek1ocmZ3VTJjcU85NjNqejNhQVA5QnRvdFRmV0p4N2c2SlAvdm05Q2MzQjJ4?=
 =?utf-8?B?OWJncVNMeFltWVZGRTlTKzREdk1UNUgzUDM0dTk2OWcyUkdoS0VmWTJJNlFw?=
 =?utf-8?B?c05hbjVUUHRIWUYyNzdoZFUva0Z6Ujc0bGczb2orZ24vMjkrUHVZamZhTUFo?=
 =?utf-8?B?T2ZjcDcxdkhZYStpVVgrNTZJY09nQUN1bDh4Umh0dmFkNG5uUG50UkUvUVhn?=
 =?utf-8?B?WHJ3dFlFc1M2QnhJaXBkTHBNWjluUWp1NFdESU5YT0JzRzJVWkZYeXpKWjhy?=
 =?utf-8?B?Tk9aQmpwRlI1VCtneHozb3g0UTRjZDhRQlR2MVpsVGsrTEtKM1FHcnB0OVNy?=
 =?utf-8?B?U3lUc2dlYTZNU1BVdm5tb3EvYTRsV3VqVEU3dkwrSEdVZ0F0Rm4wYW5YZ29m?=
 =?utf-8?Q?42I9Pn7PQnR6k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkhFK0FqOTVCSEd0VE1DQ29KR2NhbkZXYXQxclV6cUJSR3ZveVJwQk9ZRTQ5?=
 =?utf-8?B?bFA5aDJnOGxub1hwZG1TOUY3Qnl6dTFsT2hDZEMvV2QyUGh4ZElNV0U3R3pq?=
 =?utf-8?B?ZytvL3JsclltMTdjeUZVVVYwRGlyWldCT1Bpdkd0YjdxTE42a3ltT094WWdh?=
 =?utf-8?B?OWZyR0p3UU1xTVFocVdUeWg3RnJkYjJtbGdtVFhSSTkvbWJPemo1YVd5WE83?=
 =?utf-8?B?NmlSaklxOGZZY05RTUhhaXAwVzhOb3BZcVQ5dnlZQkVKTzlZQndEeXUxdzFu?=
 =?utf-8?B?RENseExNd2kwMWhHWWg4a00xTHNZN1VZeUc5aVRsUXBWZmRDd2FFbU10a202?=
 =?utf-8?B?bHVMMHJHK1BXa1pRQUg1Z0ZQK3RTVjBtVzZiaHNXdERQM0xuajNtRzFVWDBV?=
 =?utf-8?B?YmRVMS9XL04wS25aRncxUjZwTHdwUmdaTGM4Y1lCUEJuUEg4MDJHaGRSMTdp?=
 =?utf-8?B?K1Z2RHpNQTk0TjIrSlova3pBZjFVcTZSaTgxWTdZdEtTUEFPeUR3Z2tROVJs?=
 =?utf-8?B?RVJIT1Q3Rmo1WFljMFVZRXV1Q2tScWs4N2wwbFpKNnoyZzNYd0JRRENwZVBL?=
 =?utf-8?B?RjhsSVVoZEUxdFRhNFlSejVqTzR1QU1ZRFp4OHA3WmtXdXBHSnNyVFg5eXBh?=
 =?utf-8?B?emc1dCtpSk1wdnNZTUdsYjN3WGFjYjFWMjJwVkJmdmdMWmVreGpFc1BCNFdF?=
 =?utf-8?B?bGNTVExkcWE4THNHSkFXQ0JUUEZjZFlvWC9yL0xVYmdKcjFDYmZuVUhMWWsr?=
 =?utf-8?B?R1UyRFh5NTlNaGdvMkZkOGxoOGtPVmRJQ2RJU2dXZkdhWXhNUEthUSsyWU9R?=
 =?utf-8?B?V0lHRnEwUmdUdVdQK1lvSUZaWUpyNWZ1d2JwekwyNVFLY3BidTVJRzI5Y1Zj?=
 =?utf-8?B?SnNEclo5U1lKVzNnQzd5THRMNDl5RmNwMmJ1KzJ1czV0bzRTNEFSRWg3S05i?=
 =?utf-8?B?eVphVHZxV2I1TURqbTE0eXFpMUFkSFpGMjdGMXZaNVBJNXRzQ05vdEhnaFZ5?=
 =?utf-8?B?ZHl6WncwaitjS0p6ZVBBV25QU2NUMWJzK2ltclBPY2JQc0d2Q2oxeEEyTVlr?=
 =?utf-8?B?NUZET0M0ZmErekJZbk5BZUd5MzRocnI2ZUoxNUZId2NXMXh1d3lkTHRWd3hX?=
 =?utf-8?B?Tm5OekVTSHpMNHp4dHpJMkowcC82ekFaKzEyZGFRRlNBNGppVGZpZFZma2R5?=
 =?utf-8?B?ckJUbDlVa21jTmQzRDUxUGZhbnN2QmJKMGNQMEFyeFBqYjhqejR2MzlCbGVW?=
 =?utf-8?B?TExkNTJpeUtYTnFycmFMWXRsUHJkNER5eVJQMldiQ0ZDWlhsNHBhZTRka0p5?=
 =?utf-8?B?SGRUYjZ3TlI3bDZCTXRDLzc0NmFpajFWZEJtRTlub2N5QjZKNkRtWHFLU1hq?=
 =?utf-8?B?VDFZOTdKQW1jSUl2Rmx4Q0pCd25lbzZOd041L25pam9zVERzWVc5WEUveUxQ?=
 =?utf-8?B?aXduMFdJTlNEckNqb3FhQ25mOFdrV282UldxQUk0bXpkTU1VMUNzZE9QNGJK?=
 =?utf-8?B?b3pUb2Ezd0QwUmxYTEpuK0lnZzg1WnBObUhheU9zVUQwdGtzWjRSUDBKUlBM?=
 =?utf-8?B?S2Y3bGNWQzJWU0I2bnltS1E0clYxei9uU2RLNEhBMXN2UlRnU1lDVGM1ZTJ1?=
 =?utf-8?B?SDBNZlE0eHNSYVFNdExRRTRJVWpUUUtubzlET01ZeHFGbEgzOEdJaXJtQzJ1?=
 =?utf-8?B?SEV1dkMvdFdYa0dROUhDSXlYLzMya0ZrTUE1K0E4TUp0eGcveHJkZWJlcXFT?=
 =?utf-8?B?SkZRc0I0M3pjSkhQSWZ3bUhPNWg4TFFvZXloUVI5ZUI3cnJYdVFob3h6bnlu?=
 =?utf-8?B?UzkrYU05M0lSWmhNSnkyNlhIakk1T0FGSE9GVUNLWjJ2VlBBb2hhTHhPa1dY?=
 =?utf-8?B?VUszKzVEZGZVZG5JeUpnRWM2a3NnbHhqdUxzS3Nxc0ltWVdtcDZ3LzNLaGR3?=
 =?utf-8?B?dGVTbnkyaGsvVUs1TGpZdVFxMi9ncmt6dkNlVXJEcG9qM0dlQVQzRGlsVVVL?=
 =?utf-8?B?TE9kbCszZGZqTE05dFVBWXhhNVFkaUhGdlRRWkcwNDFhOVFEVVpMYkE5NEtD?=
 =?utf-8?B?dEpYV3liV1BjMzM0ZDd0R0FqSmlzZ0lueHBmcC9WemlsU01FbEFycGVFdEw4?=
 =?utf-8?Q?Cz4mtxHEPTNtAbgalwmcEmi4J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826962d7-eed4-4c87-f286-08dc95ab8e79
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 06:45:24.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqFKqq4veR/ooDKdUtWDfJ08tw0NZWttvLDCVU/tT3smaSSVVstNBdcX8g3QDtZA3mX0yFtijVxx3sS/RJeLKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

Hello Gautham,

On 6/26/2024 10:52 AM, Gautham R.Shenoy wrote:
> "Meng, Li (Jassmine)" <Li.Meng@amd.com> writes:
> 
> Hello Jassmine,
> 
>>
>> Hi Dhananjay:
>> Sorry for the delay.
>>
>> I think the correction to this issue should be in function amd_pstae_init_freq() of file amd-pstate.c.
>> The value of norminal_freq should be consistent with other
>> values(max_freq,min_freq etc.).
> 
> Perry wanted nominal_freq to be in MHz since it is not exposed to the
> user via any of the cpufreq sysfs interfaces.
> 
> IMO, it woyuld be good to to rename the variables to have their units
> for better readability along with a bunch of other
> cleanups/code deduplication. But can it be done separately ?

Yes that could be part of a separate cleanup patchset.

> 
> 
>>
>>> -----Original Message-----
>>> From: Ugwekar, Dhananjay <Dhananjay.Ugwekar@amd.com>
>>> Sent: Tuesday, June 25, 2024 9:52 PM
>>> To: rafael@kernel.org; viresh.kumar@linaro.org; Shenoy, Gautham Ranjal
>>> <gautham.shenoy@amd.com>; Limonciello, Mario
>>> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>;
>>> skhan@linuxfoundation.org; Meng, Li (Jassmine) <Li.Meng@amd.com>;
>>> Huang, Ray <Ray.Huang@amd.com>
>>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
>>>
>>> Minor modification, the commit subject is supposed to be
>>> "cpufreq/amd-pstate-ut: Handle the inconsistency between nominal_freq
>>> and other *_freq units"
> 
> How about:
> 
> "cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons"

Sure, this seems easier to understand and more concise. Will update in v2.

> 
> Otherwise the patch looks good to me.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Thanks for reviewing!

Regards,
Dhananjay

> 
> --
> Thanks and Regards
> gautham.
> 

