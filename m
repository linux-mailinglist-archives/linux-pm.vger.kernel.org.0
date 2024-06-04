Return-Path: <linux-pm+bounces-8592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0ED8FBA33
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 19:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3177E2833AF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2C14A081;
	Tue,  4 Jun 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gT3JSPbP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD05149DEE;
	Tue,  4 Jun 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521775; cv=none; b=ubBDZKrAWNn5bG+15jGLLYMhBLMHD0d+B4zgKaCevPTuW8HVmdFhICve0W1OyOb83JIXtBL2rx8BZ+A/IJ3ImJsZWqX+mnsFH0Rcep/uG+Ulz2iH0FrQeECcRpy93m2MDNTib0Q4ZjypzmpBY2sYBxQ7o8q6DOP2+c3XJO+X2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521775; c=relaxed/simple;
	bh=zCveD+V/5CJhFImS3OseggrWBf/lanov4KwrIfZjiIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F6g9XK+3WHttb4uUI2f4Q1jcX1bBQ36funVf94cWBPBv9KMnOI+9R0u3bLj7/fSxPesfQm5PMIma7eyvz6WPxSWGe2k+FNzrQkzDofUb4rbcxTIaeeLqmvwaQNKzfe9R2uN5Sh0vlCPrVir/HIv+bvB+zZpQIIr58W2g8XM1R24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gT3JSPbP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454Ec7bR026865;
	Tue, 4 Jun 2024 17:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T0XpzUE1bycJ6FuBRBz21Lfn3G8nnLpa7vH+/HBtluU=; b=gT3JSPbPWs5noi8j
	LCTe42Rrl6HRvYQ78Jz+el6lY8CqW53F83CSLQgq7rF92nYsiTdsOLw7Nj8AYX2t
	nhofffEXZmkpQzQuMdhwH+/wvKlnPbOQ4suiW8qx56jxMBADoNQ4KTADDQbxtL1f
	oT9wfBA7wr0JObEUApYSKi4zSyzs6mW9SMOmEde3p5LpTTSq3tvcCrQLO3O2JhPW
	bA1l/80CzCDg6I+6hswU5lv9d1Cdn5Ornj8r4UK+mQxNU2EjSUIz0Rrik+QMzWgt
	lBw/GUpuYMeskncdyKC9u/4P8zeX3tY12fhYch6binpyPv+BWmYxIK/ftCGlb5YD
	6QzjGQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj4v2gem7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 17:22:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 454HMedA030916
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 17:22:40 GMT
Received: from [10.110.104.132] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 10:22:39 -0700
Message-ID: <fa2174fe-a298-4c43-a3e5-0d35000c82b4@quicinc.com>
Date: Tue, 4 Jun 2024 10:22:39 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] pmdomain: core: Enable s2idle for CPU PM domains
 on PREEMPT_RT
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla
	<sudeep.holla@arm.com>, <linux-pm@vger.kernel.org>,
        Lorenzo Pieralisi
	<Lorenzo.Pieralisi@arm.com>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi
	<psodagud@quicinc.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <linux-rt-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
 <20240527142557.321610-2-ulf.hansson@linaro.org>
 <52dce8d3-acfa-4f2c-92d0-c25aa59d6526@quicinc.com>
 <CAPDyKFq0V9ke30zYAGzS1aU0yq49DdfDkfYzxkLBZuaVGsyGDA@mail.gmail.com>
 <24570028-42cf-43b1-95f2-b6f48233bef9@quicinc.com>
 <CAPDyKFoOxa1tmzxY4jrbPET5RKF6s-OAfYV=eZY9sPrJMR6jaQ@mail.gmail.com>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <CAPDyKFoOxa1tmzxY4jrbPET5RKF6s-OAfYV=eZY9sPrJMR6jaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rwaEp1JBFiAHYJixnb3pGI2MmDFwQA1P
X-Proofpoint-GUID: rwaEp1JBFiAHYJixnb3pGI2MmDFwQA1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406040139


On 6/3/2024 6:58 AM, Ulf Hansson wrote:
> On Thu, 30 May 2024 at 16:23, Nikunj Kela <quic_nkela@quicinc.com> wrote:
>>
>> On 5/30/2024 1:15 AM, Ulf Hansson wrote:
>>> On Tue, 28 May 2024 at 21:56, Nikunj Kela <quic_nkela@quicinc.com> wrote:
>>>> On 5/27/2024 7:25 AM, Ulf Hansson wrote:
>>>>> To allow a genpd provider for a CPU PM domain to enter a domain-idle-state
>>>>> during s2idle on a PREEMPT_RT based configuration, we can't use the regular
>>>>> spinlock, as they are turned into sleepable locks on PREEMPT_RT.
>>>>>
>>>>> To address this problem, let's convert into using the raw spinlock, but
>>>>> only for genpd providers that have the GENPD_FLAG_CPU_DOMAIN bit set. In
>>>>> this way, the lock can still be acquired/released in atomic context, which
>>>>> is needed in the idle-path for PREEMPT_RT.
>>>>>
>>>>> Do note that the genpd power-on/off notifiers may also be fired during
>>>>> s2idle, but these are already prepared for PREEMPT_RT as they are based on
>>>>> the raw notifiers. However, consumers of them may need to adopt accordingly
>>>>> to work properly on PREEMPT_RT.
>>>>>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>>       - None.
>>>>>
>>>>> ---
>>>>>  drivers/pmdomain/core.c   | 47 ++++++++++++++++++++++++++++++++++++++-
>>>>>  include/linux/pm_domain.h |  5 ++++-
>>>>>  2 files changed, 50 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>>>>> index 623d15b68707..072e6bdb6ee6 100644
>>>>> --- a/drivers/pmdomain/core.c
>>>>> +++ b/drivers/pmdomain/core.c
>>>>> @@ -117,6 +117,48 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>>>>>       .unlock = genpd_unlock_spin,
>>>>>  };
>>>>>
>>>>> +static void genpd_lock_raw_spin(struct generic_pm_domain *genpd)
>>>>> +     __acquires(&genpd->raw_slock)
>>>>> +{
>>>>> +     unsigned long flags;
>>>>> +
>>>>> +     raw_spin_lock_irqsave(&genpd->raw_slock, flags);
>>>>> +     genpd->raw_lock_flags = flags;
>>>>> +}
>>>>> +
>>>>> +static void genpd_lock_nested_raw_spin(struct generic_pm_domain *genpd,
>>>>> +                                     int depth)
>>>>> +     __acquires(&genpd->raw_slock)
>>>>> +{
>>>>> +     unsigned long flags;
>>>>> +
>>>>> +     raw_spin_lock_irqsave_nested(&genpd->raw_slock, flags, depth);
>>>>> +     genpd->raw_lock_flags = flags;
>>>>> +}
>>>>> +
>>>>> +static int genpd_lock_interruptible_raw_spin(struct generic_pm_domain *genpd)
>>>>> +     __acquires(&genpd->raw_slock)
>>>>> +{
>>>>> +     unsigned long flags;
>>>>> +
>>>>> +     raw_spin_lock_irqsave(&genpd->raw_slock, flags);
>>>>> +     genpd->raw_lock_flags = flags;
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static void genpd_unlock_raw_spin(struct generic_pm_domain *genpd)
>>>>> +     __releases(&genpd->raw_slock)
>>>>> +{
>>>>> +     raw_spin_unlock_irqrestore(&genpd->raw_slock, genpd->raw_lock_flags);
>>>>> +}
>>>>> +
>>>>> +static const struct genpd_lock_ops genpd_raw_spin_ops = {
>>>>> +     .lock = genpd_lock_raw_spin,
>>>>> +     .lock_nested = genpd_lock_nested_raw_spin,
>>>>> +     .lock_interruptible = genpd_lock_interruptible_raw_spin,
>>>>> +     .unlock = genpd_unlock_raw_spin,
>>>>> +};
>>>>> +
>>>>>  #define genpd_lock(p)                        p->lock_ops->lock(p)
>>>>>  #define genpd_lock_nested(p, d)              p->lock_ops->lock_nested(p, d)
>>>>>  #define genpd_lock_interruptible(p)  p->lock_ops->lock_interruptible(p)
>>>>> @@ -2079,7 +2121,10 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
>>>>>
>>>>>  static void genpd_lock_init(struct generic_pm_domain *genpd)
>>>>>  {
>>>>> -     if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
>>>>> +     if (genpd->flags & GENPD_FLAG_CPU_DOMAIN) {
>>>>> +             raw_spin_lock_init(&genpd->raw_slock);
>>>>> +             genpd->lock_ops = &genpd_raw_spin_ops;
>>>>> +     } else if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
>>>> Hi Ulf, though you are targeting only CPU domains for now, I wonder if
>>>> FLAG_IRQ_SAFE will be a better choice?  The description of the flag says
>>>> it is safe for atomic context which won't be the case for PREEMPT_RT?
>>> You have a point!
>>>
>>> However, we also need to limit the use of raw spinlocks, from
>>> PREEMPT_RT point of view. In other words, just because a genpd
>>> provider is capable of executing its callbacks in atomic context,
>>> doesn't always mean that it should use raw spinlocks too.
>> Got it! Thanks. Maybe in future, if there is a need, a new GENPD FLAG
>> for RT, something like GENPD_FLAG_IRQ_SAFE_RT, can be added to address this.
> Yes, I agree, something along those lines would make sense.
>
> BTW, did you manage to get some time to test the series on your end?

I haven't been able spend time testing it but I have requested Maulik to
test it and update you. Thanks


> Kind regards
> Uffe

