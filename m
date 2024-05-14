Return-Path: <linux-pm+bounces-7850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4548C58C6
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 17:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D6A1F22402
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEA717EB8A;
	Tue, 14 May 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Mq8Wk3Vm"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2023.outbound.protection.outlook.com [40.92.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FC1E480;
	Tue, 14 May 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700796; cv=fail; b=WbnaRZ8b6XEaE1jWVkdc/pYGIpfEzau0zbabMq0oCpJGnKcDE9w+24qPMH6SWYm3KoQlwID6YZxN2OOM0PbWmndomnz76VbsAKa091nxSTwNZmm8eg29mqF/hPeQezHY7+9DHFRG1ga/anPp7Mo+Uq4+Tav2zv9JfnDORCKsVRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700796; c=relaxed/simple;
	bh=ejcyrekh3mOEHmMr5Ze13N2XwQ0A0lGgKFBgS37OLfk=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-ID:
	 References:To:MIME-Version; b=Iqdf84Dp6vFcQ/JReVztkSuYrx1RiWOGD8Yu2ZiCoRLzqos+VC0ETVWlEo4fYIGfE3vGs1azt2QEUYuPrQ0exevVC1uUQNhBPUdueoB7xXezaiNYlaWon5BKbktHL5IPxHNLuGQvLGG9lPT3tppuHbs4970idr3HzkT0w8g1kOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Mq8Wk3Vm; arc=fail smtp.client-ip=40.92.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/LsEiJZ+kyZm/a6rpIgR71NI0b2Y47UgGeouvAHtIVgYd+n6sXgSceC5XUEWX0GCt3UTOvJxDybyZqIJXzMwLCWRqREaMmH5xt5HLMpOi0LPT6g4ILizmvGExNl5KrcYFj3iUgnRBqZfcu7VS9UFsHCV3TbMYr+Mkoo9snnRskW/9GRQ/s9D8OmyRM7WtYNh5oMgcc2NuMDvFtDl5JN7+WLLkviFu/0T8PnlqQ7ra3HXOKeiCTS7HMgF/7BVqQ1O93b2f90Dnmtoszlq8NQDBfZIReM8LrpkDboJ7/tAFV4OD5lCKX21d7ij8CW1PVRWFr+mAb2lNMzl8vo7gwEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otEsPmSlbM8fMeWq/RKWmjG0JpTU18lCx8BkQkZeHJA=;
 b=IB/gbNXwCm2Czss2EbQDh/1DJZmMOOJnLf6R42tBsI5PSxug66fTgmhJvQWkFLNb0Ml9125+ISJ3IchIszaObxOVrXzpcAYWYbo70G44u8lNqQ1tEbzJv6rgiUpKG79vjtAjeTL/2eRhd+QMR5U/vfxcY2/cGJulhld7PDsLBByRbzRX2Yqno8K7CPZcJKVIRi+0EDFjHEhRi0+MYJSySclkeHdzL87W2DKw/4+YE7xuArzJ0PTssxO3sqBwbsU/AHs/1jIZ9nHa27h2YwqL+/zyxfFb7ayv31JZuIhoataNVnFQuApLjsMbLpZgo0Bv0UK1pJHvE5D+Kxl4n+uHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otEsPmSlbM8fMeWq/RKWmjG0JpTU18lCx8BkQkZeHJA=;
 b=Mq8Wk3Vm0VZy1ZaKRGzKmU3gd13/NZKagBHoY5PdDdyC7m4Hm4WtaYaGWdZoEZjsMF4wrlHuJsjk+BVZbpHIFUQr6OwtAq7cAK75tIwC3WLlJtdcJ5kXWriyrUEIUq0ejG7yXW+SXhCIz4R5/d4dMY5jF07QxI+lsbUM2lu2tDIr6vCWAoiM88wHZ32NXrjdwa3P+1UeHeubE5rZ2THhEndlKjMxD7tDrpE6ih849Y4BMOSd3N/JqB2QNKrZjTUHamf2eTaecsFEBSC9cPi9DK2gUu6IHZSMpvurod7sQmlyz2x7QnMDI62BLkv3nCHNzOabozgTYyIVRPReTRZFwg==
Received: from TYZPR01MB5101.apcprd01.prod.exchangelabs.com
 (2603:1096:400:330::10) by PUZPR01MB4644.apcprd01.prod.exchangelabs.com
 (2603:1096:301:e8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 15:33:10 +0000
Received: from TYZPR01MB5101.apcprd01.prod.exchangelabs.com
 ([fe80::5a4f:cb3d:fb0b:fc44]) by TYZPR01MB5101.apcprd01.prod.exchangelabs.com
 ([fe80::5a4f:cb3d:fb0b:fc44%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 15:33:10 +0000
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH] cpufreq: amd-pstate: fix the memory to free after epp
 exist
From: mazhida <zhida312@outlook.com>
In-Reply-To: <CYYPR12MB8655C82734A252F7983A9EF49CE32@CYYPR12MB8655.namprd12.prod.outlook.com>
Date: Tue, 14 May 2024 14:27:07 +0800
Cc: "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 Peng Ma <andypma@tencent.com>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-ID:
 <TYZPR01MB5101C760CD59A20D411F31E992E32@TYZPR01MB5101.apcprd01.prod.exchangelabs.com>
References: <PUZPR01MB51206E9B32294882EC34B09592E32@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
 <CYYPR12MB8655C82734A252F7983A9EF49CE32@CYYPR12MB8655.namprd12.prod.outlook.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-TMN: [MzaZwYpLw/D5VAhXrrbjzalwDo896svS]
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To TYZPR01MB5101.apcprd01.prod.exchangelabs.com (2603:1096:400:330::10)
X-Microsoft-Original-Message-ID:
 <4DFA4DC6-D103-438F-BBDB-2D0DA4E81BFB@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5101:EE_|PUZPR01MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: fb00d0a9-b84b-43c8-a441-08dc742b28af
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3430499023|3420499023|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	bXFpyO7TmHA3xlOgbAV8VEk9PUGOVWDj0ThKTtV7zej3gIqP+iSx3wZCjQY9S2OgL1rRhOYBaS6chQwrlF6Szk/+FAS8aVDcoabrxzeho0OQ2Sar8gPYTjeH0yYwXmVotVDXmmVGCW0H/6Ge5nJf9j+UYQkKj3mcuUqW2v1OfbfKxfKeeJrZcpHt2m5c+bRfGnZBnNZ/efLdz22iXArCwCR6VUNtaq7/y7FdM4nAH5bkQHYoEbYhpq+70plpb1seLoU5mxeOjY9Rw0N0TzteG4nzNGqP+KaaGZHufNZ0TMbtIcFRRR2vkHLAOXet8U9jYgRN3FfyZ5rkrLGKE/9g76LnmFbOVFwxfdgInjJ+oRlk6kornTasnaxEZPzCyCIomhWl/ixdZMFdpVQdNXeVPmxbjdqPU0WzqaAbN6G7Sz3kQBzyb9SpRmrelhTNMtwgBc65F5PbmUtMV5U9RVPu7pKkCteGKeSg5ti1PHhZZtQrrCXYlY63IWw+cfYfYe0ig5bsQMKlKBFyYBq6K723aIuUGYUqlJSBhc1Ne6NVRaxFE3hXfb8EhpS2V6/3GSrI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dStpQkdVMHQ2UmRJSGhXMUxkbWxnRTZ5UlNHUlorOEZQZFdGNVZnMFhld2Qw?=
 =?utf-8?B?b2FwL2tHWWtIZTRFeU1lS1dlZmdqSDByZElOLzRmc3UxUWhKRGkraXZDUEdr?=
 =?utf-8?B?WmRKRC8xZnZTdEhVSjNWWUZBNnJtYmFVVlQ5U29NVFZPVXBXWkFHcUx0U1N5?=
 =?utf-8?B?RVRVM25NOHMrUTFCZ2l0TGhQc1RRbTA0RzJXaitjZGh6MVVZNUl4Ymw0Y2tX?=
 =?utf-8?B?c0ZTNXU3VVlTd055Y2NuWUZxMk9YTVF5L1dsTkVNMzFWL3ZkYXFVVm9SSm9M?=
 =?utf-8?B?VlpHMjErelFWSG0zWm55Wm9VTDA4U0xTb092ckg1ZGJUTVpFTVNNWEtZSjZq?=
 =?utf-8?B?aVFEK01zMWhEaUZkY1c1UEpMRE8reTljY2t1bkdQT0pBcWlPdEhPWWc1NmJl?=
 =?utf-8?B?UGU0QkJ1bGlmblFvL2FwdjIzc0RKTEFxdksrRGJzT1FYTE1IdVlKSWs5eEFm?=
 =?utf-8?B?aGVnZEtVUDZGam4yenNCcEVYOCs5dUEzU0Y4UUxzWmtNNkNnVk52ZFQwLzFC?=
 =?utf-8?B?QWt1MHc4MnMreExhV0V3WDBNaS9xdkw1bUpkY0p1cTdBeW0wcTJ0WVhLYlV5?=
 =?utf-8?B?TnFYb1BQMEhVcGNZUjBNdEhXY3A5ejdrUThnYWwydlJ0ZjhQZGw3SkYvaVVR?=
 =?utf-8?B?amw3alNpUkF1VzBLQS9FenowTCs4N0VqOFFOaEtSU1NVR21TUkZSQnlMOENQ?=
 =?utf-8?B?cFljWVp5ZTE4UDJlSU0vaklNN2ZRd3ZsK2I4WXVGa0Z3VzBkUmRpSDNYdWVz?=
 =?utf-8?B?cTVSSkhqREF6MXljZ1JRQXVvS3hwNlNhZjhzS3dPcEphNEVDcnhSeXhKbUI4?=
 =?utf-8?B?Zk9mOUFkQUJLN0lWOGFrL0FMaGdKRHZmNlowbG5zNEE1Rm1qakRLeEJqRmZ4?=
 =?utf-8?B?TWlKUEJZSEEzM04raVZLd20xbHYzVmJZS3Z3T3FzekdWdm9KQ1dYdzFQM1pN?=
 =?utf-8?B?NXdTRFFWREtIVy9WODEwUTdNMFE5M1pBc2VsK0JWTmhjRnFWUjM5Um1uVXdD?=
 =?utf-8?B?cE1ua0VtM0lOMEphTVluS24zYU1CRktCQVU4ZGZjaUhYVW56WDkrLy9DUGFs?=
 =?utf-8?B?S3RYeTFsUFdvUWVWdDBVZUd3NmptZ25Sa1Q4VFhIK0l5YkZ3ZzFIR3pXVjE5?=
 =?utf-8?B?YWZQUHRsMEovTkxhSWo2MHBOS2dyZXA4K0l2VnZVTXNETTAvN0tFb1UvdXNZ?=
 =?utf-8?B?cE9RTk9vL2xWOWVEblpIcFltTWplWWlKcmxWeWt6ZjFJeUhmaFBOR3ZoRDVB?=
 =?utf-8?B?eEplbm51WWFXOVQwQTZZTHZSeWdEWXg1N2JqN1JoZkgxWlcvS2RPY3BxcG9t?=
 =?utf-8?B?WEpxV1phcTBxWHZyc0I0Y3A1aXBUTnpaaVhOdVRubmRaWFZUejlhWFZWRHpH?=
 =?utf-8?B?TXBZK2lXb2JYNys1S0hWdTNkbkpJeUQxcGJiQUxnVG9KdUV2UXYvd29sUS9r?=
 =?utf-8?B?MGFkbmt0TXBoeU1XNjJvdENFY1lFSzhBTFovNnIzR1pCK1pwU2hwZk1YSENI?=
 =?utf-8?B?cXE5R1dhcWVuck90YU43d1NUM1ZYT081dWp3ZFBTbkNIeUlJclNuWDJHUFBG?=
 =?utf-8?B?K0N6M2F2cVIwVTBMRTdYVXJqQ0R1TERlQjh0OW9BTnhDbnk3MlhuREdjWTVp?=
 =?utf-8?Q?nIebrE+blOhTvaAkBdO/s/qLy3CDC4778LjwzFyaEC7w=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb00d0a9-b84b-43c8-a441-08dc742b28af
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5101.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 15:33:09.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB4644

Hi Perry,

	Yes=EF=BC=8COf course.

BR,
Peng

> 2024=E5=B9=B45=E6=9C=8814=E6=97=A5 12:51=EF=BC=8CYuan, Perry <Perry.Yuan@=
amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> Hi Peng,
>=20
>> -----Original Message-----
>> From: zhida312@outlook.com <zhida312@outlook.com>
>> Sent: Tuesday, May 14, 2024 11:17 AM
>> To: rafael@kernel.org; viresh.kumar@linaro.org
>> Cc: Peng Ma <andypma@tencent.com>; Huang, Ray <Ray.Huang@amd.com>;
>> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; linux-
>> pm@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH] cpufreq: amd-pstate: fix the memory to free after epp e=
xist
>>=20
>> From: andypma <andypma.tencent.com>
>>=20
>> the cpudata memory from kzmalloc in epp init function is not free after =
epp exist,
>> so we should free it.
>>=20
>> Signed-off-by: Peng Ma <andypma@tencent.com>
>> ---
>> drivers/cpufreq/amd-pstate.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>=20
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c=
 index
>> 2db095867d03..96a323f59a93 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1425,6 +1425,9 @@ static int amd_pstate_epp_cpu_init(struct
>> cpufreq_policy *policy)
>>=20
>> static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)  {
>> +     struct amd_cpudata *cpudata =3D policy->driver_data;
>> +
>> +     kfree(cpudata);
>>   pr_debug("CPU %d exiting\n", policy->cpu);
>>   return 0;
>> }
>> --
>> 2.33.0
>=20
> Thanks for the patch, how about change to be like below?
>=20
> if (cpudata) {
>     kfree(cpudata);
>     policy->driver_data =3D NULL;
> }
>=20
> Perry.
>=20


