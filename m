Return-Path: <linux-pm+bounces-33794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E9FB431C2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18433B5C36
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 05:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469FA22577C;
	Thu,  4 Sep 2025 05:48:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AA632;
	Thu,  4 Sep 2025 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964890; cv=none; b=TUEG0617wKtDhvVCSKRgSmOBd0e0KXkeA5h7wT5wZjcQti432wXNMw9QuQ7Rl+rJpFhxmA6QzjQtj72qxvdW7bzdLU+abTiyCKjbub9MWKEsS8lS+4mQERFlyOdw4pu0teChmQnVEZNKbY/oVxkh29KmtFBSAX3P+JfGJR8d8BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964890; c=relaxed/simple;
	bh=IpNmrUdy8CvZ3z+f9f9HoqvRZnkztjy1It2MTZGjkrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2Yk3OjlG9ZRXvk+y22X5wxW+OIHWUgqywy5SPstFhUfwBONtLp59dW6089y53aFDprtwRhYaqvMKuwhj5HYegTcad85s+mwNu3qc8IxQK2cCDJfOHL440XLDdzcIhSPjisqUJoGC6UNS5GC7fRwJ672gfv83biIKUHS51y3rL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b882ea48895211f0b29709d653e92f7d-20250904
X-CID-CACHE: Type:Local,Time:202509041323+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1139f5f8-1815-40d3-8c36-998badc99a4c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b868f439536289f8e62dcf9eeb14dd12,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b882ea48895211f0b29709d653e92f7d-20250904
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1120577113; Thu, 04 Sep 2025 13:48:02 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3C5C6E008FA5;
	Thu,  4 Sep 2025 13:48:02 +0800 (CST)
X-ns-mid: postfix-68B92812-3133838
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 84329E008FA2;
	Thu,  4 Sep 2025 13:48:01 +0800 (CST)
Message-ID: <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>
Date: Thu, 4 Sep 2025 13:48:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even without
 frequency table
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
 Saravana Kannan <saravanak@google.com>, zhenglifeng
 <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
 <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
 <20250904053700.abdkh23zwi5x65do@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250904053700.abdkh23zwi5x65do@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/4 13:37, Viresh Kumar =E5=86=99=E9=81=93:
> On 04-09-25, 13:23, Zihuan Zhang wrote:
>> =E5=9C=A8 2025/9/4 12:48, Viresh Kumar =E5=86=99=E9=81=93:
>>> On 04-09-25, 11:22, Zihuan Zhang wrote:
>>>>    int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_=
data *policy)
>>>>    {
>>>> +	cpufreq_verify_within_cpu_limits(policy);
>>> So if we have a freq-table, we will call this twice now. Why make it
>>> bad for the existing users ?
>>
>> Just to clarify, in the third patch of this series we remove
>> cpufreq_generic_frequency_table_verify() from the table_verify path,
>> so cpufreq_verify_within_cpu_limits() is now only called here. There
>> won=E2=80=99t be any duplicate invocation for drivers that already hav=
e a
>> frequency table.
> Maybe I wasn't clear enough.
>
> int cpufreq_frequency_table_verify(...)
> {
> 	cpufreq_verify_within_cpu_limits(...);
>          ...
> }
>
> int cpufreq_generic_frequency_table_verify(...)
> {
>          cpufreq_verify_within_cpu_limits(...);
>          cpufreq_frequency_table_verify(...);
>          ...
> }
>
> For a driver with a valid freq-table, we will call
> cpufreq_verify_within_cpu_limits() unnecessarily, isn't it ?

I understand your point about the potential duplicate call to
cpufreq_verify_within_cpu_limits() for drivers with a valid freq-table.
However, in the third patch of this series, we removed the call to
cpufreq_generic_frequency_table_verify() from the table_verify path.


In the Third patch:

-int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy)
+static int cpufreq_frequency_table_verify(struct cpufreq_policy_data *po=
licy)
  {
  	struct cpufreq_frequency_table *pos, *table =3D policy->freq_table;
  	unsigned int freq, prev_smaller =3D 0;
@@ -73,8 +73,6 @@ int cpufreq_frequency_table_verify(struct cpufreq_polic=
y_data *policy)
  	pr_debug("request for verification of policy (%u - %u kHz) for cpu %u\=
n",
  					policy->min, policy->max, policy->cpu);
 =20
-	cpufreq_verify_within_cpu_limits(policy);
-
  	cpufreq_for_each_valid_entry(pos, table) {


Now, the verification and the CPU limits check are unified in the
generic function, so there is no longer a redundant invocation for
drivers with a frequency table.

Thanks!









