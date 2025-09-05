Return-Path: <linux-pm+bounces-33895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54420B44B29
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 03:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBB0543FEC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 01:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F848287E;
	Fri,  5 Sep 2025 01:17:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE22175BF;
	Fri,  5 Sep 2025 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035026; cv=none; b=NENDudvl6dL/HN5bMTDd9X21KRqMt1p9OVDLahfPh6Rrmc4Hydd8fW6OYhAyHGlEmTH37RPb/s3IU9l3txFijSu83nn/SFYsTmTyWGfLJaxxUu8qe1/EOyUJBudCXRMNI3ML9CymKb5LQHh/23e9t0/yjEnA6Utqg2ral56XG3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035026; c=relaxed/simple;
	bh=mPxHzYaPkmr6KkIgdA9oWqxD9ZFGdjPYcXQ+veMs7Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gl3+JmZmDgE4UmcA0mhwCblUGbn9xqQakdDQVpAT9sI736fGg617KROkDYZazv+ed5jVhd+ampWuMWY+Bu5CxTFhB4xwZza1PiQU907D0X6mFad5Jgd3TiR58njxR5AQbo1L8e6LwTdxc6TFkhAhumlE9hnqNsLmtbkneWAhX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ff8138f289f511f0b29709d653e92f7d-20250905
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:dcb06d53-3ff1-40ce-8173-8c1e42a9ed10,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:cf7fe24487084871727860f52db0cecb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: ff8138f289f511f0b29709d653e92f7d-20250905
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 146792645; Fri, 05 Sep 2025 09:16:49 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 53643E008FA4;
	Fri,  5 Sep 2025 09:16:49 +0800 (CST)
X-ns-mid: postfix-68BA3A01-24742754
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 7AD66E008FA3;
	Fri,  5 Sep 2025 09:16:48 +0800 (CST)
Message-ID: <9aea1e94-3794-47e7-89cf-3a2e696e75e6@kylinos.cn>
Date: Fri, 5 Sep 2025 09:16:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] cpufreq: Drop redundant freq_table parameter
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Saravana Kannan <saravanak@google.com>, zhenglifeng
 <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-2-zhangzihuan@kylinos.cn>
 <CAJZ5v0hcnqD39OAjFfscCnQ2ZGu9Z1gP5WAPfu3jbeEWr6rGwQ@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0hcnqD39OAjFfscCnQ2ZGu9Z1gP5WAPfu3jbeEWr6rGwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/4 21:31, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Thu, Sep 4, 2025 at 5:22=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylino=
s.cn> wrote:
>> Since commit e0b3165ba521 ("cpufreq: add 'freq_table' in struct
>> cpufreq_policy"),
>> freq_table has been stored in struct cpufreq_policy instead of being
>> maintained separately.
>>
>> However, several helpers in freq_table.c still take both policy and
>> freq_table as parameters, even though policy->freq_table can always be
>> used. This leads to redundant function arguments and increases the cha=
nce
>> of inconsistencies.
>>
>> This patch removes the unnecessary freq_table argument from these func=
tions
>> and updates their callers to only pass policy. This makes the code sim=
pler,
>> more consistent, and avoids duplication.
>>
>> V2:
>>   - Merge three patches into one to fix compile error
>>   - simple the check suggested by Viresh Kumar
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Do I think correctly that this is a resend of
> https://lore.kernel.org/all/20250902073323.48330-1-zhangzihuan@kylinos.=
cn/
> ?
>
> There's no need to resend it.


Yes, this is indeed a resend.=C2=A0 Sorry for the noise.

> If you want to make new changes on top of it, just say in their
> changelogs that they depend on it.
>
> OTOH, if the new patch is not a resend, you should have listed the
> differences between it and the old one.
>
>> ---
>>   drivers/cpufreq/cpufreq.c         |  2 +-
>>   drivers/cpufreq/freq_table.c      | 14 ++++++--------
>>   drivers/cpufreq/sh-cpufreq.c      |  6 ++----
>>   drivers/cpufreq/virtual-cpufreq.c |  2 +-
>>   include/linux/cpufreq.h           |  7 +++----
>>   5 files changed, 13 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index a615c98d80ca..5fcc99f768d2 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2793,7 +2793,7 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *=
policy, int state)
>>          if (!policy->freq_table)
>>                  return -ENXIO;
>>
>> -       ret =3D cpufreq_frequency_table_cpuinfo(policy, policy->freq_t=
able);
>> +       ret =3D cpufreq_frequency_table_cpuinfo(policy);
>>          if (ret) {
>>                  pr_err("%s: Policy frequency update failed\n", __func=
__);
>>                  return ret;
>> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table=
.c
>> index 35de513af6c9..d5111ee56e38 100644
>> --- a/drivers/cpufreq/freq_table.c
>> +++ b/drivers/cpufreq/freq_table.c
>> @@ -28,10 +28,9 @@ static bool policy_has_boost_freq(struct cpufreq_po=
licy *policy)
>>          return false;
>>   }
>>
>> -int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>> -                                   struct cpufreq_frequency_table *ta=
ble)
>> +int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>>   {
>> -       struct cpufreq_frequency_table *pos;
>> +       struct cpufreq_frequency_table *pos, *table =3D policy->freq_t=
able;
>>          unsigned int min_freq =3D ~0;
>>          unsigned int max_freq =3D 0;
>>          unsigned int freq;
>> @@ -65,10 +64,9 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_=
policy *policy,
>>                  return 0;
>>   }
>>
>> -int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy=
,
>> -                                  struct cpufreq_frequency_table *tab=
le)
>> +int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy=
)
>>   {
>> -       struct cpufreq_frequency_table *pos;
>> +       struct cpufreq_frequency_table *pos, *table =3D policy->freq_t=
able;
>>          unsigned int freq, prev_smaller =3D 0;
>>          bool found =3D false;
>>
>> @@ -110,7 +108,7 @@ int cpufreq_generic_frequency_table_verify(struct =
cpufreq_policy_data *policy)
>>          if (!policy->freq_table)
>>                  return -ENODEV;
>>
>> -       return cpufreq_frequency_table_verify(policy, policy->freq_tab=
le);
>> +       return cpufreq_frequency_table_verify(policy);
>>   }
>>   EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
>>
>> @@ -354,7 +352,7 @@ int cpufreq_table_validate_and_sort(struct cpufreq=
_policy *policy)
>>                  return 0;
>>          }
>>
>> -       ret =3D cpufreq_frequency_table_cpuinfo(policy, policy->freq_t=
able);
>> +       ret =3D cpufreq_frequency_table_cpuinfo(policy);
>>          if (ret)
>>                  return ret;
>>
>> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq=
.c
>> index 9c0b01e00508..642ddb9ea217 100644
>> --- a/drivers/cpufreq/sh-cpufreq.c
>> +++ b/drivers/cpufreq/sh-cpufreq.c
>> @@ -89,11 +89,9 @@ static int sh_cpufreq_target(struct cpufreq_policy =
*policy,
>>   static int sh_cpufreq_verify(struct cpufreq_policy_data *policy)
>>   {
>>          struct clk *cpuclk =3D &per_cpu(sh_cpuclk, policy->cpu);
>> -       struct cpufreq_frequency_table *freq_table;
>>
>> -       freq_table =3D cpuclk->nr_freqs ? cpuclk->freq_table : NULL;
>> -       if (freq_table)
>> -               return cpufreq_frequency_table_verify(policy, freq_tab=
le);
>> +       if (policy->freq_table)
>> +               return cpufreq_frequency_table_verify(policy);
>>
>>          cpufreq_verify_within_cpu_limits(policy);
>>
>> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtu=
al-cpufreq.c
>> index 7dd1b0c263c7..6ffa16d239b2 100644
>> --- a/drivers/cpufreq/virtual-cpufreq.c
>> +++ b/drivers/cpufreq/virtual-cpufreq.c
>> @@ -250,7 +250,7 @@ static int virt_cpufreq_offline(struct cpufreq_pol=
icy *policy)
>>   static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *po=
licy)
>>   {
>>          if (policy->freq_table)
>> -               return cpufreq_frequency_table_verify(policy, policy->=
freq_table);
>> +               return cpufreq_frequency_table_verify(policy);
>>
>>          cpufreq_verify_within_cpu_limits(policy);
>>          return 0;
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 95f3807c8c55..40966512ea18 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -780,11 +780,10 @@ struct cpufreq_frequency_table {
>>                  else
>>
>>
>> -int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>> -                                   struct cpufreq_frequency_table *ta=
ble);
>> +int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy);
>> +
>> +int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy=
);
>>
>> -int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy=
,
>> -                                  struct cpufreq_frequency_table *tab=
le);
>>   int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_dat=
a *policy);
>>
>>   int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
>> --
>> 2.25.1
>>

