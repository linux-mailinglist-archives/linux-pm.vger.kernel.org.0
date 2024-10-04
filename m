Return-Path: <linux-pm+bounces-15133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C418198FD6F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 08:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20802B209AE
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 06:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274F812E1CA;
	Fri,  4 Oct 2024 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jknPRU93"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475712E1C2;
	Fri,  4 Oct 2024 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024125; cv=fail; b=cwi7qnlq28isinsREE1NzGRDNz5iEb8jr/sSReSVRHGOjF94amOhavtPHB1WyeFS3YAXeYdvXjokCPBsqdr4SVzLH0pw3F+60fPjggzF3a4orkZ+Sp/4Kqsl5tWDl6bkCjcy5sa9HBZuWO53T5T1yyXo2c3XGhRDNpPveMDSdcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024125; c=relaxed/simple;
	bh=ezUyka8D65xtNnVFRsNlKI+OK6yB1amCxuc0tosv+Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c3CO0xJBUsdxsfxoHGrdxjMN6EEb3YCMdu5yAo2hfVxM8blncZNQMKmrI4Lqqyygp2Owex07w7I/vRdRssThIz6HuVNLqGZEn80lebh3FlHGDpSiY5rkEDV64OEKkOQWiW1f8P22nUbNg9qMpHJ/Z3e96Xs8jRtiiw1UuWRIJVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jknPRU93; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tULKTL7XRsXqKy7Qwou+tWIF9kua6fntNP/b+s+zHSQHToSe54QvGDgBKuUZtzCy5Ta4HXZLkN1N2dudoKvn2oIAsqnPEwiGPjVTxCTNNjfrOM/hX9AJ6WhVKeIBcw5y3cgyO8rIv/hfMu+mzU/f/fpL7Z7yHh0GGh/LztEewbZiGmMqJWD7BgskbEBixiEpTMrjNPv6WaykS9Fd32EHmIcPwfrKudCi/UqQVx8ENaawl8SgG9p8TK2JptJRbP7En/wrWBaQVJhuk4THQFFLGxRmRAJSOfI/RI4U/WJhtozPBxf++lMSk1CXU0Jk3nq4aHx2eveH0+w35f6wlzpsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtphnYwCscjJ0qv/r6G8VsFCvkFWccjh3LzSpVgHgmg=;
 b=EBg7SHSWhR1aaa6l7BBzR4LE8cJ+D5N1vUYOXAWW9pS/Mff83P7ObWWmPWHD4iZUnQUYGrcmw0RukCuqnb+1AaAdXLNV7nYq6oYBNsntRGaNjnbKmznnoPflkJ7Kt8KnsYLjLZT9CMt0dqV5OO3ktuJkCeb9B2CHcnFqBOlvM8VqGEcb+D1NsW17XDfiMbAw/+mEwmEDyPeaQKywmWO/7khSlRG9eeMNwVnLaJqEVmu0dP0PM/dYLz4Mj3NQZM90TTXKzt7Zo+VNRbNh5+nAksRYuVVU4kyh3tdtCwLTyGriXdJpdT7wOUaj7cLAtnX467cy2qYkT6oSD6SAQbKTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtphnYwCscjJ0qv/r6G8VsFCvkFWccjh3LzSpVgHgmg=;
 b=jknPRU93j/P9+0LuwRCoq8pD2L/huKVEvMifLdWDTHHIVfBuuPLcpOBnwXMtYbtXz8QIlPBhsAaQd2VhHCiSHSKt+eVpPl9nsc3Mm8qbKSbHgRxqKavyw5e1NaVHGEwcwP6ZX5/tu+1LziubZlQFgVVP15I3T8e2YlZN0n3pDhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 06:41:59 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 06:41:59 +0000
Date: Fri, 4 Oct 2024 12:11:50 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, ray.huang@amd.com,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
Message-ID: <Zv+OLnexTcFFXDiY@BLRRASHENOY1.amd.com>
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PNYP287CA0047.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::24) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5d35a1-1e7e-4ba4-e02b-08dce43fa57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awgs9/65iC85531M44w454iW9ysBPLmBkXwNCE1ibu0c6zrpQhcZD2G1HNat?=
 =?us-ascii?Q?gjous/F7aHbg4nnLYtunJwkYWrbN/a8zrlN2ZYcZwMj2DQlL7q5R7Fu511A8?=
 =?us-ascii?Q?D6RlSUfeHEpuXenoktSO8nTuBVvhsM7QdeaLYjdzn74NNUEcyGJMcRLya5jX?=
 =?us-ascii?Q?It+yQdsi/M+Al12o38HLAFRwrp/jnNvUW8yHKSISDj5LHkP46IEA1stjeg9i?=
 =?us-ascii?Q?QeYPUgA4b5D9R81f83U9cUdfSUINuiT9ORmtlR505HOOU9VOp73Tyeu3L3Qy?=
 =?us-ascii?Q?cXs05PHrI421hJduBa8m69/S2wD/5TRTKQsnpyOXUuH8c6MnZe8AmmXPiIAa?=
 =?us-ascii?Q?c5bvd0Y4yex1XtkA5Oq7XS1IYzRE5ElwXcRfSbVy6Tdy4oEnZa2l6cJA2pKi?=
 =?us-ascii?Q?MLIBMuzNrYSTZNykM1kIcNS6AXyXNNGiWVNBRttWdhBpv+t8qeVbxjNXrOqW?=
 =?us-ascii?Q?vjdmEyh3GihcC7UUovCRyTN1bTnknWSEufVaCCnaPG5No9jsLPbXYFPbOXMj?=
 =?us-ascii?Q?LszMpS0TYY33RdqTgCFZfcfxx6h38wXL03INcuBBviVox0WmFhjM/v+9uVlw?=
 =?us-ascii?Q?NXABVoG1TuUK3wGhCpHWT+34xtESSrunnIR5rGyPhVD5KlEMqBJLjVVjg2Lz?=
 =?us-ascii?Q?aV5Tn8mhzlqoE4bIlR1TasxJVGrdyMmBgBnJ1wqxhSIizpl3GlOW9A2IzY+z?=
 =?us-ascii?Q?wBa80wkbdOUwtXpNeGhbCni/cotCnRatl6iIBI7NZMrxLkkyaFkspmvDGvnT?=
 =?us-ascii?Q?xsZ1pC5AK6ngdtN3JWLGIg7ALJPlCpbHeCjKChmiTyAy7SKRfgmMeZ5K81ms?=
 =?us-ascii?Q?Xa+gRaWuPY8Gi24/S8PMJCpP1hw9HVn01koCBNdW7dcPJRv9IbzCv0cHXep/?=
 =?us-ascii?Q?hgrmvgsnvwqyXYPq6S+ZsxL7WIJTLYmixaAKMhRNndMFI7e1IaycMUclIhNj?=
 =?us-ascii?Q?10V7UjGPpnvmj/QuRquwLt2GfoGQ7CoTfNuppiFtIHU2fY0gF2AuZn7vvZCb?=
 =?us-ascii?Q?pNwIh6CsYFL/RMKMStlmqskCYqxw5bZWSk3vBxYaMlO3kfME5RZou+rRz4mD?=
 =?us-ascii?Q?+x/3JHrjDkY0G9BomXgooaXaCn9dqMTTfW+uz+T6F32uT5Ik3sQyke0cPYXS?=
 =?us-ascii?Q?eQFzmuGcBXaA8km0pGqxsUqVUpviJXCUFEghUrqPnYaof6AlvmRIwJ/GiQft?=
 =?us-ascii?Q?0b2yGltTsUIcV1MTkY6DPzQc6q8RcQ06720minTmbdRQg+ZYSeGbfA2dpkDE?=
 =?us-ascii?Q?VU5PeuOJNQo72C/lQ3CwZ0qXefadU3mwYuhmZxLMfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NYkVllag5TBcXagRnnXA9UOSQUVbwqIshR1yxlYJnQ2WJZ21qKfptSrA4Bbi?=
 =?us-ascii?Q?Y7d3EwjN/N6UEls40qNFDRGcWrpqU332c93I5/pZAWFrJcyyFAWckWA/vrd5?=
 =?us-ascii?Q?ergHBEKom94h7M/X9uUoml80WymIosttRr21GlEdIgarX5mYzLRTpdNhchXR?=
 =?us-ascii?Q?DnZPE5WUkisP7ksXDgKVf6XbYkpjgSFxO2BpvF9x6rTr3qJyg85PUDWV8L5B?=
 =?us-ascii?Q?lJxrUjWzF52o06YrZFdzSY0nidqvvvUPRaIqaXPFLBptVCVViawHlHX3PKxl?=
 =?us-ascii?Q?3pFmvRJIvTlj3pvHGdiKDPPir2g7TehM/2WPlY2erbEJSp56MMSbIPS12ROf?=
 =?us-ascii?Q?UeqpRPMtRgzGKJ4o+j1e/jgQ3dGsjD0pLQS+hzYNo7sDQydZ2984fdzzAMsp?=
 =?us-ascii?Q?dbOPLo6R1ov8bC2xczLcc9/tTgn5EKA5b+fMX/xovrFc51u/Ig5/ZngpyERl?=
 =?us-ascii?Q?vHXABX2+2T+I8jGzwDrEflEeI5idzLD680hA5uuQZSjpFw6Ie19i6glyTnnz?=
 =?us-ascii?Q?KrKN7RXX285wZNPWj7mN2ufrwmw1fl5pQ1ksPT0N3eag8MVkqgV/DPkEAnAb?=
 =?us-ascii?Q?OW4lgtaVQK57tQkmxNayPICbKIt0fckwa23GyyIF3kK1OLrIqpW6j73gP1hW?=
 =?us-ascii?Q?SymRE43EJrLHnWhMwpzgAqRMzsn5r3ojNwlH0etaSkgpV/AnSy0i8J/haC0Y?=
 =?us-ascii?Q?fr5zSL1AzE32auhAKbWIC8rgxBvwRVhfF7r3Mfz47mkc7WdQrHFMFvtztnVg?=
 =?us-ascii?Q?1U/BCMqKBWg43tKjD4caM1HCmK5Ak0Eai9bKT/JoILfBLIGZCTqBh6rxYBT1?=
 =?us-ascii?Q?E3LEKwRjeFOW2kdZmrcgZ+eY48dDGB5wp7TBVOVY+NWgUw6VMvFhghRYgSRD?=
 =?us-ascii?Q?qeDMwTyAu8pC8iO+3ExJF5+3q9B2KJ11wCtqSubqpTjhvW0HDNgX2i1Ck/JT?=
 =?us-ascii?Q?HIqDHqi3HATaETbsNNGVzFtAoEbJkXU47fU1xidA6YMA9ipKcQgSbkwYfC3K?=
 =?us-ascii?Q?V7TzKf7hIcA5Ar+2wbsK3pk9uvippn1z6/jyHJHV49RCK8ExTTL45OsGcG/R?=
 =?us-ascii?Q?FCUBLLJ0awW8Ys+cwC8c2ZZQTh2z+VtNJXZLq6OcpLrPrGz5konFniOMXjfk?=
 =?us-ascii?Q?Bmjsrsbxcoun7/B37gSZwgnoSUwZ2Rr9OzjxilVmyqAOy5n8ZxM+cz7c4v6s?=
 =?us-ascii?Q?wy1ihDbsu+fwluBd7UD44y0lELd+K2Jplyiu5qGjGWGmIWXxsXAOA4/mpkks?=
 =?us-ascii?Q?S4wVIr+QfAG7ZCOQENws118isaq7pAephtDQq41Gb2CpJxkoL83Kg66GQG4j?=
 =?us-ascii?Q?lg3tzPS2Iw/usCNpDBLtuzb+hBLjYYfnJZOuR1/SC+lMlvcHoW50xcSRLWsS?=
 =?us-ascii?Q?alcd+VfDNw2Q1u0+GqZJMStPKSVeeXjTq6HHfSTq5oYCjUCMYt9tluHboVhZ?=
 =?us-ascii?Q?KaMj0dDdA1nGbIW1iDShMrTiicSet6Z19gzeRgddW2SjZCyhugHAmif5S8cH?=
 =?us-ascii?Q?AHhnHulwQR3VDh1AXQGm66KE8kOuhHREwZw1k9yfERjFDvr+hU+xysw0tyjA?=
 =?us-ascii?Q?SpflZf3ZTOMwFNYnKjidC7ZJpafNugr5AgjdGfkt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5d35a1-1e7e-4ba4-e02b-08dce43fa57a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 06:41:59.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLI8nCAYghmkUDwQUOSL3ZW/49xkPJlRO3tShRnd7w7MqjCmer7RzAvD/+39NGgYV67ItReL9KBPRz9uOWcqsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480

On Thu, Oct 03, 2024 at 08:39:52AM +0000, Dhananjay Ugwekar wrote:
> Currently, there is no proper way to update the initial lower frequency
> limit from cpufreq drivers. Only way is to add a new min_freq qos
> request from the driver side, but it leads to the issue explained below.
> 
> The QoS infrastructure collates the constraints from multiple
> subsystems and saves them in a plist. The "current value" is defined to
> be the highest value in the plist for min_freq constraint.
> 
> The cpufreq core adds a qos_request for min_freq to be 0 and the amd-pstate
> driver today adds qos request for min_freq to be lowest_freq, where
> lowest_freq corresponds to CPPC.lowest_perf.
> 
> Eg: Suppose WLOG considering amd-pstate driver, lowest_freq is 400000 KHz,
> lowest_non_linear_freq is 1200000 KHz.
> 
> At this point of time, the min_freq QoS plist looks like:
> 
> head--> 400000 KHz (registered by amd-pstate) --> 0 KHz (registered by
> cpufreq core)
> 
> When a user updates /sys/devices/system/cpu/cpuX/cpufreq/scaling_min_freq,
> it only results in updating the cpufreq-core's node in the plist, where
> say 0 becomes the newly echoed value.
> 
> Now, if the user echoes a value 1000000 KHz, to scaling_min_freq, then the
> new list would be
> 
> head--> 1000000 KHz (registered by cpufreq core) --> 400000 KHz (registered
> by amd-pstate)
> 
> and the new "current value" of the min_freq QoS constraint will be 1000000
> KHz, this is the scenario where it works as expected.
> 
> Suppose we change the amd-pstate driver code's min_freq qos constraint
> to lowest_non_linear_freq instead of lowest_freq, then the user will
> never be able to request a value below that, due to the following:
> 
> At boot time, the min_freq QoS plist would be
> 
> head--> 1200000 KHz (registered by amd-pstate) --> 0 KHz (registered by 
> cpufreq core)
> 
> When the user echoes a value of 1000000 KHz, to
> /sys/devices/..../scaling_min_freq, then the new list would be
> 
> head--> 1200000 KHz (registered by amd-pstate) --> 1000000 KHz (registered 
> by cpufreq core)
> 
> with the new "current value" of the min_freq QoS remaining 1200000 KHz.
> Since the current value has not changed, there won't be any notifications
> sent to the subsystems which have added their QoS constraints. In
> particular, the amd-pstate driver will not get the notification, and thus,
> the user's request to lower the scaling_min_freq will be ineffective.
> 
> Hence, it is advisable to have a single source of truth for the min and
> max freq QoS constraints between the cpufreq and the cpufreq drivers.
> 
> So add a new callback get_init_min_freq() add in struct cpufreq_driver,
> which allows amd-pstate (or any other cpufreq driver) to override the
> default min_freq value being set in the policy->min_freq_req. Now
> scaling_min_freq can be modified by the user to any value (lower or
> higher than the init value) later on if desired.

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Rafael and Viresh, could you please weigh in on this new callback.

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++++-
>  include/linux/cpufreq.h   | 6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f98c9438760c..2923068cf5f4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1361,6 +1361,7 @@ static int cpufreq_online(unsigned int cpu)
>  	bool new_policy;
>  	unsigned long flags;
>  	unsigned int j;
> +	u32 init_min_freq = FREQ_QOS_MIN_DEFAULT_VALUE;
>  	int ret;
>  
>  	pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
> @@ -1445,9 +1446,12 @@ static int cpufreq_online(unsigned int cpu)
>  			goto out_destroy_policy;
>  		}
>  
> +		if (cpufreq_driver->get_init_min_freq)
> +			init_min_freq = cpufreq_driver->get_init_min_freq(policy);
> +
>  		ret = freq_qos_add_request(&policy->constraints,
>  					   policy->min_freq_req, FREQ_QOS_MIN,
> -					   FREQ_QOS_MIN_DEFAULT_VALUE);
> +					   init_min_freq);
>  		if (ret < 0) {
>  			/*
>  			 * So we don't call freq_qos_remove_request() for an
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index e0e19d9c1323..b20488b55f6c 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -414,6 +414,12 @@ struct cpufreq_driver {
>  	 * policy is properly initialized, but before the governor is started.
>  	 */
>  	void		(*register_em)(struct cpufreq_policy *policy);
> +
> +	/*
> +	 * Set by drivers that want to initialize the policy->min_freq_req with
> +	 * a value different from the default value (0) in cpufreq core.
> +	 */
> +	int		(*get_init_min_freq)(struct cpufreq_policy *policy);
>  };
>  
>  /* flags */
> -- 
> 2.34.1
> 

