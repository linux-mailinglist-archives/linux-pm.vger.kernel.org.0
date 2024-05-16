Return-Path: <linux-pm+bounces-7890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EAC8C723F
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 09:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D29B21446
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 07:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6676F4120A;
	Thu, 16 May 2024 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u6dArYXQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FF2EB10;
	Thu, 16 May 2024 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715845633; cv=fail; b=ulOENrOxn56B8bsnrAFXBzkCSw/RH6M0s+GaWB+1A9eiL6uYioqKjIwqPUIKVm+iyNOxKSCqyQQtdKyibl12Mlll/u2ZspR6HvelJNH8wacN5y5uJTWMQwUC/uyKt7zmcHMV8WGoUnE8F/u9hbiNmJ7EUaO1b0NDU4591VFZ1aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715845633; c=relaxed/simple;
	bh=RvacaqLrCdYESKURNe0XmZ0ElNNSc1BsbzduEbLhbl8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nm3/QC47iyGqqjuVyt4vXojoos6Olt5+3/xzINv2gxj6QZBbNpE3clL4Rz687gtVioLJ2llm+q+MJlACQZxsvHmRI4n47XhAqIiOdiNKePSpuYhyf0z/6vxSIWmlcb4iVpuhRlNKtIF2pI1at+TrDpHg7qi6DeMS8JwQweI7d+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u6dArYXQ; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGyaN5lBmcrwVRC3kUl3JAjDfjwCSC3dm9mGMpQAbBY18a3nVKnqaCNlvt6QHEY1nPaCFh6DS0oXr4zITMPAa9dgtLFmLzNSBMIfwBnTpq7p3yBfdMxTzgNicqNl+m6WuEOvExep1aKBg05MUD7YLV1gSZ1bkD+9A+lyY9ax6pvaqqmVpggCEzYqpoAsCM3mrKmKn+shfauB7f1Sxmm0YbAs3mmQ+17B/zI/Krkx13U0lQQXVNSTaZtyxUpWLMLkDp8QitGYKxUN8Trekp6MA+dREY0ud5smOttFhyiaJniRv+8EtflFfapRQkbK89ghfTytCHebvdP8bGvrvssCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omD6wcVps5lbQa8ibpWUtd2cIYS0+OREBcICs2txYfo=;
 b=IZWej8rRkl3/tufb5gbV0fouxnL+HMW/PUykvE+cgYRALdaFR2RQVL5z2eIRaBjex3Zbf46i/yMMrmYIOl9VcD8uWki0XiQsIT4kSNTnOhlyStP1X1L3KsB4pSEQe9zY8VExBItn2LT7Gr1vaxaFAx7Wu16uTvyvkokDHdMYh7c5RmfeVz6D9wYlbuJYQ53loK1oZiJzzIyuz9wWRrEOkehcKX6pfD4YcSywKoWPVkQUKie8t3oJ3u0/rU6ox3oPfDXS2oEvWSUlh0efEQJMzyXI/F92Rz1ux5C86JyHeuJq67Y9lCk/bQ3ZTPr6IOoEAlBrpvzrMOPDO6kCZyjsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omD6wcVps5lbQa8ibpWUtd2cIYS0+OREBcICs2txYfo=;
 b=u6dArYXQQSCB7z4nPs+cuNhBLngwbD/SB34IQ9LLYpeGtHWVhVvfqFH7ckc0DstuQ7Kww2kmtCppZmKnntayGKEK61rJpeRh1tcoJEKd5IumUV/xjhrIBjCx8jAo0MWENxss/OJ/oIGir2cBVqzMLTzgvbnpsYnxIKqAs2PrCPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 07:47:09 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%4]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 07:47:08 +0000
Message-ID: <a0ecb036-c760-447a-abfb-78fb7928fb9c@amd.com>
Date: Thu, 16 May 2024 02:47:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cpufreq: amd-pstate: fix the memory to free after epp
 exist
To: zhida312@outlook.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: Peng Ma <andypma@tencent.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Perry Yuan
 <perry.yuan@amd.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <PUZPR01MB5120A03DFF0EA1CE70E7334E92ED2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <PUZPR01MB5120A03DFF0EA1CE70E7334E92ED2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::15) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9f2a33-01e2-4207-932a-08dc757c6398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEhVQk83UXE5V0N2MWN0cUw0SUJxOEVHQ0FQbkI2MENKRjkrVkxQWlJLb21l?=
 =?utf-8?B?MCtBTWhkZ0twRnBkQXVjWktCcWVhOXRCUjlDeEtjQW1MRS9USlQ0a0FYT3VU?=
 =?utf-8?B?eHlpQ3h5QWFQQzB4N2Q2V3dWQnNxUTNNdGMwRUp1Wk0zTHArVkMrTXhzK01p?=
 =?utf-8?B?OWRFamtWNkFqUnlJOUpDekdtOUNKVGxVdHZpQVRqdG9mNVNLUlllNkhMc1Mw?=
 =?utf-8?B?dUgwWHVwQ2NOS0dnWklzTGlQQkwwOExJU3lMZ0ZlMFAxbkJBaURUMS9aSE0y?=
 =?utf-8?B?UHcxb2pSNVZIYWxhU1UzZldMNzZ2dVAzWVQ1S1orSjl5VjUyUC9sZnkyY0NQ?=
 =?utf-8?B?NFNQNU4xa0Uxci9PMDI5cXpVQzlNWDdIS2owczF1b01ZMFlTR01hT0R6UFpz?=
 =?utf-8?B?anhJN1NqekREUlpqNXBUMGdsK2xKNk9oelhmbG1mdXZVZmdRMVdZQ3hZWEU4?=
 =?utf-8?B?Y2Z2TGlYc29SYWgyVWRxazVRb0xtL0VvemRsbmNxWEpBUzhyMjZQWXpJRzRZ?=
 =?utf-8?B?MWZEY2F1Rnd6U3dDZndPSFJNR2dlbnN0UDd5TGsySHVwUzkreTR0VWl6UTls?=
 =?utf-8?B?MWh1MDcyMC9VNzVMaXhXd01ucjNwQ2d5MFB1R0xwU1VLb0tJbURFMVdSakQv?=
 =?utf-8?B?bThlT1ZjODJ1WnA0bE9KQnNmd3lBQ2NhbzlzaDMrSmZXZDBqRVVYT1ZPWnZR?=
 =?utf-8?B?K2VVV0JTbnFjUFU3V0FUZTdLQkdBU0Z4VEhxeUpyR3BQVThRckVpck52L2Nh?=
 =?utf-8?B?SXdOVUNrcjRWVHV2QVR1Zk4wUXd0TXA5Q2dlNkZEZWpBR05STmYyYVdDdnFR?=
 =?utf-8?B?TWRxNTEwdm56dnl5aGdIZ1NCWVgybUtGVUcyK3Y5bTlIQXcvbDc3bFpOc2FW?=
 =?utf-8?B?Q2I1Zi9hRlRJV0hmTG9KQVNlV0JrK25ta2EzWFJ0eUx1TVlmUmcxQkNXOFpr?=
 =?utf-8?B?WWhYNDkrWHROOGxsdkVSTmcrNTBaWnZEaVBpMDZmVEx2SWRWWXJ0anp3c0dm?=
 =?utf-8?B?SDdxdHdsalN4ckZLRS9abDh5emJmallFWEYrVk5rTXEvTGxHNXpPck1vNEov?=
 =?utf-8?B?aVJVNWpkT0cwVnBZc0o4d1dUMWxubUJPd21zWTNlc0dLRGVRQWNvSEtyS2M0?=
 =?utf-8?B?VWIrbFNVd1dtV01MWDVzVDZzZDlyS0c5aXE1RW50RldKRVlNYmNaMlRiM3lE?=
 =?utf-8?B?SXdybDViU2grT29uRjdZelZjMlNqSDVHaVpUV2c2OEltNE82elRxUUFuenlw?=
 =?utf-8?B?SWNqdFdPVURicnV0dXVsd1JuNnJwcmUyK1lOZXlyTytWYm80dUE2Ni9aSVBw?=
 =?utf-8?B?RklsTEFUOHFSeGZVaEpnU2FyZFI0NUdkSHJkTU56QzArcnV2RmZwVnk3VnBo?=
 =?utf-8?B?bWthZUoxVlFYY1lLVFphSVEvdlE3c2JmdzhWME5BaW9DcWVTeWQyUkEyNDZk?=
 =?utf-8?B?bjRKQU04R3JUUTlFU2t6aE9pZXllRHl4b3Z1U2RQUU54cFQrMEswZEk4UEdL?=
 =?utf-8?B?cTRoWk04Y0JIU0VmZjkvUmtmM3hYNUQ5S3RTejljaTJQWWVYeFFaRnlMdy9R?=
 =?utf-8?B?dFc4RDZXa25BaVJoVndpMjA5SWNSbUl6dFJkNW55SExqekNBdzZsdlVIblpW?=
 =?utf-8?B?Z0d2TDhycVdVOTVzNDNkYUlHYlB1UTM0S0p5ZlMvMDh3MWNxSWVVWWMxZlBT?=
 =?utf-8?B?d25BOWhSN3hiUERGeEhqYWVkUkUvdjMvU001UHQyRUNVaE9EcGtIb0pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck5weVVYV2o5bCtDbXk2QWtyZmk1ckZ4ZEszblZlRzIraTE2S2NLdW5GZUpN?=
 =?utf-8?B?Ry9EWmJwTURBZFAvZTJkQ0ZmZmRHMUhzS1crS0xEUm5LaTFXWEJBZHVNYk12?=
 =?utf-8?B?OU1wWmpwUVFXY0poaTlITFpjY0FUL2lrZnduSkVGaWNXT25uTWZxeHFhZzcy?=
 =?utf-8?B?c1BMZ3FYeUZMZHdZWnBUbU9PWnZoWFVsei8zc3BBdUdreHR4ZFhaYXRDaSsz?=
 =?utf-8?B?TXpKNGtIVktTN1lURjZBS09JR25RdEtLWVZndU9JUyt0S040OGU0TDVWVXpp?=
 =?utf-8?B?bitLZlB1Nmo1WUNhYkdzWUpZSGdOWndFMU8zMnA5eSsrRnFXa0U0Yi9aY3o1?=
 =?utf-8?B?RkhRQXhqNllHWUc0TGExNmRlVmdVdnBRVUlGUk5kOGR4OWhobEFxV0pXZ1lS?=
 =?utf-8?B?aDVOaE9HWXVGc0N0Z3p6STFMNkFuK280SThWV1gydWZRSmFFcStET3ovejBs?=
 =?utf-8?B?cDhaNjN0UHNpQ0JmbVh5MEJLVm0zT3U5bHNrUGRjQzZjbTZnSjJyZmdsOVpw?=
 =?utf-8?B?VDA5Tk10RHRlbFQ2Uy9ZQW9OMzc1SEJpVVYzeWc4QzZCSlZadGI0VUsvUUlq?=
 =?utf-8?B?RytHYVErMnNmTGFDbE5JcU9lVGtGYlZYODFrZE50NjJwbG1PUVBaaFdpV2xy?=
 =?utf-8?B?V0x6cy9pME1sdWxNcDI1am9sNlFKdTNwUVdtWEhScGdpR2lFN0NHcm1JVTkx?=
 =?utf-8?B?cEJERVB4NVBZU0tQNGoxY01xYmd3ZGNwN1pZOFhNOHVzQkptVXU0WWZRMzhz?=
 =?utf-8?B?N1pBVm5uS2xnbCszYTFxMzBaRnNVbDFIZ2tGcFFqb0hWNHE5L1BOWVgzSnBD?=
 =?utf-8?B?aElTRGFSNkNUK2Fvam82T3dXUzNEUy9tYitlWlNBYTgxMjRUM2ZTU0c5bGI4?=
 =?utf-8?B?R3dNNUZUMG1MUStmeC9TMFlubWlGVnFIWXFBb3k0YU04aDVobVJNS0V0RFhC?=
 =?utf-8?B?VXRqTkhjRjJvZ1ZudVZrKytnM0ZjaElsdXVtZlM0aEV0b1BTSldUMGRaM1c4?=
 =?utf-8?B?cXpvTWhFV2VhclREU0dNWUhnK1dqQmtXUWVMcjdWTzFoUHd4bHVJT1BWcXY0?=
 =?utf-8?B?cmJhWWR4Zm95dlZVQ0paMGlCVnJ3VzIwZ0E0VGdvRmZBU2xVY2h0KzZiVVRJ?=
 =?utf-8?B?NWxQMnkxMGZnaDg0RnZ1eEhGbVEzTDZCRzR0VlBGMEFXbW5obW9nNVIwMmFo?=
 =?utf-8?B?cUVrMHNMd0phS2FtTzNFSEZPSnJrVnlXa1hsN1ZjTlUrY2J4czFGMUNJd3Jp?=
 =?utf-8?B?Q3JUOThKNjh5dHZyOThWVE1xY1Q2TVA4cVY1cHovc3VPSmM2TUZTcUgrNTVY?=
 =?utf-8?B?ZWRrMlJ5Tnc2V3RpSVhpOG01Zk5Qd1luOWVKcmhKTUd5bndxVWt5V09YSTZx?=
 =?utf-8?B?bzg0Z2YvaitEcDJJRmlvYjl0Tkc0SG43QUZoSzcvVUVXY3B1cm1TSGZ2K28w?=
 =?utf-8?B?WTlMMmFZR2c1MVFDc0l0NGUvOTZhZ3RCbHJ3WkVlbTRCRDI1b3RDd1hoekF3?=
 =?utf-8?B?ZG5jNFVoSm1ocHE0azFVeWlpeTA1T21QWXBzK0dyOWVJakNUcHkrZFA0NzM3?=
 =?utf-8?B?Q2ltYUxOcXh3T3lHeHF6MEpnUnFsOGhxUDlaY205bWl6RVNJVVZCeVBSdDdN?=
 =?utf-8?B?QnV5WnZRbTNZMWExK0FuTGwvbGtBVE14QXk0NGFwTVFuVFB1Yy9udlhHWmN0?=
 =?utf-8?B?V1V4YjM0bVRtZDB3MWsxd1lONWZWWlU3UVZUMDdNajhPRkh1MXRHcXBVK1B4?=
 =?utf-8?B?K2FLaVI0MGJ4UzgyZVZTT29ES3lJdW9kcFR1Mmp4amsrdXNNUzd6SzF4UFpl?=
 =?utf-8?B?dWRidStHTHFOL1J3MXhIZEsvZndRdUpqL0dxRTBIVklFdkN2ME1LU0Evc2kv?=
 =?utf-8?B?cmhRUGlTRE5CWnFFZzJWdFo5Y0o4eTFCTnMvZXNpK2orV3NtT1BUbFFwUXBW?=
 =?utf-8?B?T1JNTTllVWFDUzhySm15Tzlmb01pWUdDeHRPcjRKY1ptOW5wYkRkNEdQSmFQ?=
 =?utf-8?B?Z0JqaitLY0Y1a3ZqSWU5ZlBtMnVjRy9VVHloSnFyWlVNL25vbHJGNFQwQWcv?=
 =?utf-8?B?QWtuWlc4M0JDL2FjdU9TUEg4bVpCTHVrenQ4UDVOWmdGWWJYclowYmVaOGZx?=
 =?utf-8?Q?0hE5rx68Bt9LLtOaAH8CG0Ea5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9f2a33-01e2-4207-932a-08dc757c6398
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 07:47:08.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBRwQHHgFeKSODGcZYYOKuc7vkNiBZghg8qav9ztUOW3WT/+niG4cLkV1Fh0rGtRfV5PbkJa5/Z7g7sreQAxJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966



On 5/16/2024 1:30 AM, zhida312@outlook.com wrote:
> From: andypma <andypma.tencent.com>
> 
> the cpudata memory from kzmalloc in epp init function is
> not free after epp exist, so we should free it.
> 
> Signed-off-by: Peng Ma <andypma@tencent.com>
> 
> Changes from v3 to v4:
> 	update subject used git command "git format-patch -1 -v x"
> 
> Changes from v2 to v3:
> 	update Signed-off-by to Peng Ma <andypma@tencent.com>.
> 	set a space between if and "(".
> 
> Changes from v1 to v2:
> 	check whether it is empty before releasing
> 	set driver_data is NULL after free
> ---

Thanks for your submission!

I would prefer the change list below the cut list, but otherwise this is 
fine.  Maybe Rafael can modify that while committing.

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

>   drivers/cpufreq/amd-pstate.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6a342b0c0140..1b7e82a0ad2e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1441,6 +1441,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   
>   static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>   {
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (cpudata) {
> +		kfree(cpudata);
> +		policy->driver_data = NULL;
> +	}
> +
>   	pr_debug("CPU %d exiting\n", policy->cpu);
>   	return 0;
>   }

