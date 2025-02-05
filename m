Return-Path: <linux-pm+bounces-21427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F41A298D6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 19:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B8A1609FC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60B1FDE0A;
	Wed,  5 Feb 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bQixVIb1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBAD1FCFEE;
	Wed,  5 Feb 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779765; cv=none; b=f3om4a1I5hnH61Hv6aayjz2s2oN2+zONWFu8tT4+pn0dJxpCHP+RMfgQX65JJ/poZfBsn1CUYcFlvQqLtQRGeq3GXQX5uECuO4q/QqQaYrGQranxu9rDa/kAU2QDX91RhBr3XTpoVngp5QTOPlJ62xxQ3gYgjjnBYbgOpX6wUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779765; c=relaxed/simple;
	bh=UhKjAEvUlgLqcIBwowVI/5aAQM33TNsjXHHzxCT6W3o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=PsUBQC5UgS7YCNkOhrFfuZL/AppWBrpuQegWdNDwIEGr62bftDtSjyOK5dejIdZE5awcmOWZAiV4JTeHHC6IGHvCYtL68v6eN2ek33UdUrkp/Ns55+TI622CpmsLmo+d4RtOJHJEIFeaZbASE1c9YhO4BhK56FxnTuxRXpAJdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bQixVIb1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gc5FF000853;
	Wed, 5 Feb 2025 18:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fGyMzg
	dDHOTQOZby2pCVFXcYnOqjiULTzjKXP6uGg7s=; b=bQixVIb1ecIyMvGOyE1fYs
	FDQ3opWEf9zwGC75Lu/GMb/YuKYuGroCGMa0C+GXsT9GIblekFRw7vBptAuhEw1f
	ke0ABxYpd+8y/wc9naTYC17v8jybYZgUWfFnpmoVJg91CdPfOaUyMhHaPsi5VzYw
	i/qeZb3yIr7Pgd5PjmFJJkrEsxa9MDo9sRDhe2fG5ls074nKPE7ttI+XXzL0GhuM
	vDbqdOKb+eTddI1LgX7izveGf2uXbPgAejhuU6Ti1p3HFeIfLLD3wpO9S1acg1It
	v0zuYmYJw9jEqDKKLCs2dp1wE4nMgkEAIsA8L24sWqNJwnfydiz6iw9mq1nleEoA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44m3pnu5bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 18:22:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515GI2nZ024510;
	Wed, 5 Feb 2025 18:22:22 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxna6vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 18:22:22 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515IML5x15598238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 18:22:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE8C758054;
	Wed,  5 Feb 2025 18:22:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FAF358045;
	Wed,  5 Feb 2025 18:22:15 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.171.42.237])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 18:22:15 +0000 (GMT)
Message-ID: <f724fc01a5013e97c8414a36d754f08bd3093db2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] cpufreq: Introduce a more generic way to set
 default per-policy boost flag
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        zhanjie9@hisilicon.com, lihuisong@huawei.com, fanghao11@huawei.com,
        gautam@linux.ibm.com
Date: Wed, 05 Feb 2025 23:52:12 +0530
In-Reply-To: <20250205050147.hfctwo6aw75rardc@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
	 <20250117101457.1530653-3-zhenglifeng1@huawei.com>
	 <c9e56c5f54cc33338762c94e9bed7b5a0d5de812.camel@linux.ibm.com>
	 <20250205050147.hfctwo6aw75rardc@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FQvVeqg2XwWm83YKHIXLXaNQ1HYd9V9q
X-Proofpoint-GUID: FQvVeqg2XwWm83YKHIXLXaNQ1HYd9V9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050138

On Wed, 2025-02-05 at 10:31 +0530, Viresh Kumar wrote:
> On 04-02-25, 22:11, Aboorva Devarajan wrote:
> > I noticed that Viresh is working on a similar patch [1] as part of a broader patchset
> > to simplify boost handling, which should also resolve this issue.
> > 
> > Should we merge this patch [1] and related patches since this is causing a crash,
> > or submit a separate patch to fix this?
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d434096b7515..7c1f7f5142da 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1590,7 +1590,8 @@ static int cpufreq_online(unsigned int cpu)
>                 policy->cdev = of_cpufreq_cooling_register(policy);
> 
>         /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -       if (policy->boost_enabled != cpufreq_boost_enabled()) {
> +       if (cpufreq_driver->set_boost &&
> +           policy->boost_enabled != cpufreq_boost_enabled()) {
>                 policy->boost_enabled = cpufreq_boost_enabled();
>                 ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
>                 if (ret) {
> 
> I think the right fix for now should be something like this. My series
> (which will be part of next merge window) can go in separately and
> revert this change then (as we won't see this problem then).
> 
> Please send a fix with something like this if it works fine, so Rafael
> can apply.
> 

Hi Viresh,

Thanks, I have posted a patch for this:
https://lore.kernel.org/all/20250205181347.2079272-1-aboorvad@linux.ibm.com/

this should get past the boot-time crash for now, until your patchset 
to simplify boost handling is merged.

Regards,
Aboorva


