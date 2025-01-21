Return-Path: <linux-pm+bounces-20775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89035A18552
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 19:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845FF166BD0
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 18:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30111F4E4A;
	Tue, 21 Jan 2025 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iH4WJ50n"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022137.outbound.protection.outlook.com [40.93.200.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AD1DA0F1;
	Tue, 21 Jan 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737484863; cv=fail; b=S2A5qV9tYLglOXoYrlb93931x0/53mCaQjPyTNgF6JRS8oF4Bj2nI/zjPFUHkbpWGTNdb2bR/DFUM3FVr7AGsRN6Nor5cT66MppFJqy3SX0at4pJXMtKwIOEzPhMQdRfAxIbdIj80p8m1sjL+51E9NXRitTFaD9U9fna1x5va9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737484863; c=relaxed/simple;
	bh=BpF28PKSm7SWKETFryNEOA+uKNJhMuzUWeZuOblVUeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NfvBbFejl7yiEW8EddVRdTYbjQtWliDDfiBOOV8E1U8IvDjLb50Jm0J3m8Gc/ZrSH5sSv9QTCAGDyYiq4Vf14uOSfILDcmm2osn4s8Xr4qieubqFM7wsWKVfxxQCCf47PohECw9RrNGCKXxngrJ4UPieccZBxNIoxP9OMeunatY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=iH4WJ50n; arc=fail smtp.client-ip=40.93.200.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rm4neEAJOHa/WzZKqf+FIAB2g+El4oPh0NNOEWhevtlvR3S+XyVbAs4DPN/wbHKEvhF1J3yReQPRLos0+o1MoYuq9RxrrV+/HmBy1TxHIu8bTTDs44fEjb/iypLophpICfvFn5gcpzB0OMS7h9DEVfNeWwri7yXkT216aCISnUCmap3rKq48tsO2aPbzuQfqhvSpcZuDmiVetRh26PvoIHJmYWbp6AKjMRXZczAwcU+Cqq7ZXOlBE6wRbBZZZD7zItU/ZI3DD9ZbXe5XIbuqmiQxPUQKeiwSXaSgbmAQGBpIgpcIIebfYAglGFWO5ox/XxAfRvu6w3FnCjFCSD2R+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flgRsytMFqr+kw4Cd88HHA8+bHmdnUtF+C03Qe9juw0=;
 b=mj9Ie1tr7HGYQ0ZJfVMUTUtoM2jgYvdsnobDduNMmX3PqjGx/rB2obTfweak5R3olmIF+89XL5phM4Xc3A1Y1JT4roZFX9ya5Pi5EzG2nWc3PI0PlSFANdRO3liKkSmCoTT1p4DO7Na2VKTfX3qFc942lwT0dWs2PSXE3IuvDUtSHKqFox3v+HikZBsK1zFU7wG7MurtrPy6JOSlWu2ZrjwGA2t77TMcAYVbNbwOJEqVl9Pm50HwSrPO4eAZNCqpbUOc805abkzhgwbfae2B7w0Oq031o6g/XuOFaLmdr0YJh7/hB70n1GZp/8X3lplr9VBajTEzke45rLYPEGShew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flgRsytMFqr+kw4Cd88HHA8+bHmdnUtF+C03Qe9juw0=;
 b=iH4WJ50nqzq8i7AVeCPyACocyjzunHNqflQKvJAmhYqrIGqnl4nBZKdDjSFyeEZzy6dKm2Uca/5q7DNoguUO4lF1kq9b2r4xnEK3DLpyjMk3ZhBXpBCL/+pI2qCB8PI192Z3ipqQnOWltum9PTNqGRoa15aRyXWnj8mHXIkbdE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8529.prod.exchangelabs.com (2603:10b6:a03:55b::17) by
 MN0PR01MB7754.prod.exchangelabs.com (2603:10b6:208:37d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Tue, 21 Jan 2025 18:40:58 +0000
Received: from SJ2PR01MB8529.prod.exchangelabs.com
 ([fe80::2707:818a:2b2a:16e9]) by SJ2PR01MB8529.prod.exchangelabs.com
 ([fe80::2707:818a:2b2a:16e9%7]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 18:40:58 +0000
Date: Tue, 21 Jan 2025 10:40:55 -0800
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, ionela.voinescu@arm.com, 
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, rafael@kernel.org, 
	sumitg@nvidia.com, yang@os.amperecomputing.com, lihuisong@huawei.com, 
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v9 1/5] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
Message-ID: <j4s4amaknobmjvoq7jf734h7oieob3qxr5eigsrawakgxltszy@6kixp27xhwn6>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-2-beata.michalska@arm.com>
 <20250121104706.2gcegucb6hcuksrd@vireshk-i7>
 <Z4-52JUmR7A-7NJP@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z4-52JUmR7A-7NJP@arm.com>
X-ClientProxiedBy: CH2PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:610:58::14) To SJ2PR01MB8529.prod.exchangelabs.com
 (2603:10b6:a03:55b::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8529:EE_|MN0PR01MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b1f292-0516-49b1-c49a-08dd3a4b258c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bI5QBNnYo5nag+JLpoVQycecajFzrRTcXHOjo7U5W9gkZB5XdfZTdJOizm6m?=
 =?us-ascii?Q?lJ5UsdmcYE5fxcx0KJi8XiS1LLdj6XQ4hi8Fg1smDuKOvmNQE7NVtwQPYmlq?=
 =?us-ascii?Q?wrz52oIQy/m/oSb2Acc06VUnSeH26VxD8dkXiofqAqCS4EE2cJVEqpzNMMeg?=
 =?us-ascii?Q?ooDOF3VxkE0TsmiIZD0JMqHe5kJIDvIrUdRB5iYb7HwvjH3/6DpNEB/3jt2C?=
 =?us-ascii?Q?QZ+hGBGsQsSt9ERDUlbkCu12TnRUfc8lISyZky4MAZ7zwcilerc2kk/nw7uh?=
 =?us-ascii?Q?mVA2G7aeMzaUOBoXeJjWI4pSNiIygKkblIBVMlulsumUJWCCD9rTHv/FmKrF?=
 =?us-ascii?Q?vroTwQhcvgznL316P/wi56Xtfds3Nyvi2d55699SkeMoiWrPRbtVUpxdYIqw?=
 =?us-ascii?Q?rmq6nwKfwB3NfojwZUPvxaCcyy6CmHlpIRFnDv7WdY2zl7/z1rtUBiJvAYEK?=
 =?us-ascii?Q?7VdLtHN2zEFapnFFlAZn+9vdlv8T+67JpvpqoqU2BxWL8lzcSbKDduqyo7Ea?=
 =?us-ascii?Q?4Ght1BEhWGEeLyuKoKcARMWIv4XAes3R8c9MAiDd2x+uaPwIPXlGNqyzr86Z?=
 =?us-ascii?Q?1e/x7nLaeBVEG6sZ8+pyyF9ZaKjmWh5ipuS9cFWKHajxhVKJY7psdmA8zgU+?=
 =?us-ascii?Q?sXslKOJz3fm0gsIn/Uy3TAE+cf21jj4PX81F2l6DXgSHzMRSWmwQtFMerVS6?=
 =?us-ascii?Q?ZcaTvb+is4lURB7LtdlANjnb1dv/GerJX0bTwUUJBCUk4i/tmlJsQI0Ax3Jq?=
 =?us-ascii?Q?Vb+Y0F/oF66Iq5DKQjv+ujijbCGpy5I+XkYJOZOm14nrelCq+SSQXkKs1nv/?=
 =?us-ascii?Q?wNydd8rcLkOaeWUYA0O5ynfP/8wJ8/HHv/wxsEzXrDSunSdoYnxJhCeXUpy5?=
 =?us-ascii?Q?aCBNoaUdUNghVyXMpoygDt1v3zhPD57qaOmhEHhpWa1/3w09BN763fvpASC1?=
 =?us-ascii?Q?42JbS/8P2g92x5rplUxeFfndc8M7A4D0ZgBD50yXlVHYMoWyfAQ45bfifhTE?=
 =?us-ascii?Q?5igs5WoGKi52Uup5lmwM3HyVAKsWLq5BYMlEdDL2lztjFA0uH1OIgeFJO+uR?=
 =?us-ascii?Q?3qfIp0+tWErfW/vuLOGlZPC4/k3QzETOSBXODFzgxGmC9TIsdu2ATUdc6JUX?=
 =?us-ascii?Q?MwdgVBm+SG2t0bmPEbZu4nGVwmjaJ/o+x5qmEWOZ/VPEYv9mFruDqRWMDyCP?=
 =?us-ascii?Q?obK2Ty01a1kJ+KlVQjhtIADgt/SBQlMy9NdIFEBriI+TZXM3drLFQ4AxAYHW?=
 =?us-ascii?Q?I+Q7dSKA2pGLuf+q2QIHBdxA6CLxDzUfarzK73WZVRLbO/6KjJLK2ozLMOHE?=
 =?us-ascii?Q?6Q+Vsxd84+w1nZD1zf9/FqHtBieQthAjguEj2/v5CznCcLufxpKHSepuV2IS?=
 =?us-ascii?Q?wGIWUVaMV8prBEVpEwHjy+iB0l5d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8529.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VY1in18h7b7tqWPYGO1U0YugT3e/42wU1Mu9LSk+5oJqjYZqj4TPbvU6sz6M?=
 =?us-ascii?Q?2vxu1beKXghQlc73jIIiZ+BbBHF4tLMKYh/AD4USJjhQgFvITnI9WV/kANYx?=
 =?us-ascii?Q?VjJ00lx4zVGtt+bZ17O/xQYRzXocdtTT7rwSC0GK2+nRr/hYOVCfnE9UJAti?=
 =?us-ascii?Q?UlbY6TaC0ZCueKvAgeJ7MwTpIkY5CUFvviO6ai+PyWWAKIR7Qfsba3GwkA/b?=
 =?us-ascii?Q?RvsSl3ZH1V6BHl14BZmPcms6FNHEYu7qc8rSSakUpq9rI3/VgQfzezUL91Fg?=
 =?us-ascii?Q?iEfkajfcdBk5oKqE/7ONH1qjheSaH7EXeXGcOo+fDf8MKtqSgRo1doW6e9xR?=
 =?us-ascii?Q?ccxLXn6r3VkER6I7TEJTnN4I5loS3NDBbjS2NM9hGS8dYbbhQH6rgZFv0a5j?=
 =?us-ascii?Q?Dl20IjNAMRma+ry/qWvhimtCUM66nThnaYRJ0dvVIgKG9qTb+Ta4GMDZRcUO?=
 =?us-ascii?Q?pibbOEccvqaQps4Y51f+pOAT6/WNygIrBY+NaDLeoyxQc/h/T67T0Q0k1vMX?=
 =?us-ascii?Q?ASDmwXyOjuucU3FBOM8TfyHkUmMBRKYdT1rFgg/4BfNdT1OmdqGez1Fz8zP6?=
 =?us-ascii?Q?kYi8WPVsPgtwfvtNT+4hXG3vFwhEfe+MlGPwwAlcImvR2yKt2oOXJ54zGb/t?=
 =?us-ascii?Q?lZlFjbUkQ8q0qfjrc7zXUZK1ltiV5XoaV2rovwuz+MKWOeYkybAB21WPT7Fz?=
 =?us-ascii?Q?Yl4mjLkFQK1ofmJVzu4flLMZBSITmMkbTsojnW1T+p7fY46ESZkKn6T07EKY?=
 =?us-ascii?Q?ANQxER4rRBsSCVvZKuiKT3vnl4I+yibUfzkpGKNj2y3G0LiLq+pNM9c6sfkZ?=
 =?us-ascii?Q?tSgLmuYJmc4pT7+9r9Yqn3CLHE3/tezjhi6S4fuAjlpWNVhI/XQl/heTFxKV?=
 =?us-ascii?Q?gHHQsBo88uVbgRNpZr7nMQSJtEH/lkrwKtgHzLA15bkWlzvMxMU1HwxYWngy?=
 =?us-ascii?Q?4AOWyCqEQqbWy5iem9Cp/MhxW2N45WlEf1iVoNFcKF+gfwRzcqvqr62ZmOAl?=
 =?us-ascii?Q?Oy6gOJV1kmw2TGrDLkkaQiPvf1Bqnxc9dK5Y5hcKC9JjEIBapq8Di+AfQycV?=
 =?us-ascii?Q?uEin4khPE7BPNjBgox5O807cJZUWW4JaKqRwCFkWu3/xleEHiqWG4hgRvBNf?=
 =?us-ascii?Q?JXu2nZI5an6wjCR8FFMug/8gr58biRl+f7A4LftfPul385H8DgDHJehCv8Jb?=
 =?us-ascii?Q?ETXZEevMuXnAif4sF+OExYx1fO3lVWfV8k3bX66tswjtYxPeqbAWZU3psAl2?=
 =?us-ascii?Q?RbZKAT06UPaihpIJgyaqkXI0gAMJxMBmwG99SEcKQB55DVa1pJnW1jESqe8H?=
 =?us-ascii?Q?fpgxCvY0FxLIsHnfPKm8I6gFIrWDyb0DpqhWradDc07y8ab3TU2e+K7deFUq?=
 =?us-ascii?Q?lwe5iw7vSaQZDM228QM92K0nsrpONChluNFtMW9hXUUFPFHQJfGheemlimT+?=
 =?us-ascii?Q?dCRU2PTKOzXwJ4VXL+zisggjXwccRdozKtrDQK34Nj22vh+giCG1+sZDDfaq?=
 =?us-ascii?Q?q4agWOQTJ/z42dGW1a+6SoQ3eSKieC7/X+Y0ZjTQiCWY8XPgu5Ic2ujIhxme?=
 =?us-ascii?Q?FH0o8IJkOr/8P2FGIwGEg3xFCztc+TtUoLnqyvO68aEECnQXWc8rQBmvi5CT?=
 =?us-ascii?Q?OmYMaa4Uq+LXwzQTXOwA/e9dGCfPHHcCGAsGALTgy/op?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b1f292-0516-49b1-c49a-08dd3a4b258c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8529.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 18:40:58.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ap0hFJ5VUA+yU3WkgVCZAx9KuhMCo6Zz3R9QCmX6mHzLZ6Fq3h8LxqvGxkRCZyu5V6WbHmADun0isl6V654KmYcmXEG/VDp5im/2vFxER1bgOEj3vskyaWxWkGMrUdM3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7754

On Tue, Jan 21, 2025 at 04:14:32PM +0100, Beata Michalska wrote:
>On Tue, Jan 21, 2025 at 04:17:06PM +0530, Viresh Kumar wrote:
>> On 21-01-25, 08:44, Beata Michalska wrote:
>> > Allow arch_freq_get_on_cpu to return an error for cases when retrieving
>> > current CPU frequency is not possible, whether that being due to lack of
>> > required arch support or due to other circumstances when the current
>> > frequency cannot be determined at given point of time.
>> >
>> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>> > ---
>> >  arch/x86/kernel/cpu/aperfmperf.c | 2 +-
>> >  arch/x86/kernel/cpu/proc.c       | 7 +++++--
>> >  drivers/cpufreq/cpufreq.c        | 8 ++++----
>> >  include/linux/cpufreq.h          | 2 +-
>> >  4 files changed, 11 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
>> > index f642de2ebdac..6cf31a1649c4 100644
>> > --- a/arch/x86/kernel/cpu/aperfmperf.c
>> > +++ b/arch/x86/kernel/cpu/aperfmperf.c
>> > @@ -498,7 +498,7 @@ void arch_scale_freq_tick(void)
>> >   */
>> >  #define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
>> >
>> > -unsigned int arch_freq_get_on_cpu(int cpu)
>> > +int arch_freq_get_on_cpu(int cpu)
>> >  {
>> >  	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
>> >  	unsigned int seq, freq;
>> > diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
>> > index 41ed01f46bd9..d79f5845a463 100644
>> > --- a/arch/x86/kernel/cpu/proc.c
>> > +++ b/arch/x86/kernel/cpu/proc.c
>> > @@ -86,9 +86,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>> >  		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
>> >
>> >  	if (cpu_has(c, X86_FEATURE_TSC)) {
>> > -		unsigned int freq = arch_freq_get_on_cpu(cpu);
>> > +		int freq = arch_freq_get_on_cpu(cpu);
>> >
>> > -		seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
>> > +		if (freq <= 0)
>> > +			seq_puts(m, "cpu MHz\t\t: Unknown\n");
>> > +		else
>> > +			seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
>> >  	}
>> >
>> >  	/* Cache size */
>> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> > index 418236fef172..6f45684483c4 100644
>> > --- a/drivers/cpufreq/cpufreq.c
>> > +++ b/drivers/cpufreq/cpufreq.c
>> > @@ -728,18 +728,18 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
>> >  show_one(scaling_min_freq, min);
>> >  show_one(scaling_max_freq, max);
>> >
>> > -__weak unsigned int arch_freq_get_on_cpu(int cpu)
>> > +__weak int arch_freq_get_on_cpu(int cpu)
>> >  {
>> > -	return 0;
>> > +	return -EOPNOTSUPP;
>> >  }
>> >
>> >  static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>> >  {
>> >  	ssize_t ret;
>> > -	unsigned int freq;
>> > +	int freq;
>> >
>> >  	freq = arch_freq_get_on_cpu(policy->cpu);
>> > -	if (freq)
>> > +	if (freq > 0)
>>
>> >= ?
>>
>> Since we can return error now, 0 should be considered a valid
>> frequency value ?
>Theoretically speaking - it should, though what would 0 actually
>represent then ?
I would think the value of 0 would be valid and should be interpreted in a
product/architecture specific manner? From silicon behavior, to me only negative
frequency values wouldn't make any sense.

In Patch 1 of this series we interpret 0 as "Unknown" on a x86 system though. So
for the sake of consistency should we consider 0 a valid value everywhere?

Regards,
Vanshi

>
>---
>BR
>Beata
>>
>> >  		ret = sysfs_emit(buf, "%u\n", freq);
>> >  	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
>> >  		ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
>> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> > index 7fe0981a7e46..02fd4746231d 100644
>> > --- a/include/linux/cpufreq.h
>> > +++ b/include/linux/cpufreq.h
>> > @@ -1184,7 +1184,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>> >  }
>> >  #endif
>> >
>> > -extern unsigned int arch_freq_get_on_cpu(int cpu);
>> > +extern int arch_freq_get_on_cpu(int cpu);
>> >
>> >  #ifndef arch_set_freq_scale
>> >  static __always_inline
>> > --
>> > 2.25.1
>>
>> --
>> viresh

