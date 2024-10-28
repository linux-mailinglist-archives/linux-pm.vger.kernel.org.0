Return-Path: <linux-pm+bounces-16627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356999B3CC4
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 22:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E89B6B21C07
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920BF1E00A0;
	Mon, 28 Oct 2024 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="RYGTmMxJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8B19005F
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.0.186.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151223; cv=none; b=kayk2wy414D3nZZkr9NXaJB+tgDQ6nVFHxOg7/w1EYJ5B5rI6Ks+xv1jhyMYET3jFGsRzJMlNuJ81NHfH6aKFUPuE5U7yOE/3HC5DfEnNkd+ZGY78B4t69X+EfisR4qZ3Pcb0078DEMk478impHaNEIo1f/CD1VcqwCm5NY5t0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151223; c=relaxed/simple;
	bh=REJqBIp+u4tgztS67pNZ5sNBdoeBOrImDHIAMRBsbb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WU81sbbqOYj8Rd6T6oLW95AtTx+A0y8t2stldzhnDaNFCLq+DLlg/lpjlLt+ZyUKMsp5v11OKt8/sLcZi7qIW3n2zlZpe97AYl8UGdlciNmCdkeGZ9ZBBGyJJT5jUd2t3Lc9uY+OFDu1gqnXeVUHTXhO6tCQfaSogT+dqQoivF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=RYGTmMxJ; arc=none smtp.client-ip=142.0.186.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email-od.com
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1730151221; x=1732743221;
	h=content-transfer-encoding:content-type:in-reply-to:from:content-language:references:cc:to:subject:mime-version:date:message-id:x-thread-info:subject:to:from:cc:reply-to;
	bh=6doGIbPh3Cn0Hzi2wTIVT8G20SoeYWH9IUuwlNVcx4s=;
	b=RYGTmMxJE3qoYE3Bwspatj1BCe0GGaCH/3YfBfFJQtZHs/0/vDLaIIzTIaVzbJfK7ckaPq1L9J5Lju3nzvSJSP3K1GCHqqZHfzBKLvZ/IrudjbHWWhIjtBMSGIvCYByWP5pFN39f6MerJcl+2WJT+aM2+MrcByLBCOx+tROQjBM=
X-Thread-Info: NDUwNC4xMi40NzFlYTAwMDBjNjAwMGUubGludXgtcG09dmdlci5rZXJuZWwub3Jn
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from [192.168.0.167] (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPS id 9DD382CE0334;
	Mon, 28 Oct 2024 17:33:26 -0400 (EDT)
Message-ID: <894de4c2-ce04-4cc1-97d8-fc7c860e943d@nalramli.com>
Date: Mon, 28 Oct 2024 17:33:25 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6.1.y 0/1] cpufreq: amd-pstate: Enable CPU boost in
 passive and guided modes
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "nalramli@fastly.com" <nalramli@fastly.com>,
 "jdamato@fastly.com" <jdamato@fastly.com>,
 "khubert@fastly.com" <khubert@fastly.com>, "Yuan, Perry"
 <Perry.Yuan@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Huang, Ray" <Ray.Huang@amd.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Zw8Wn5SPqBfRKUhp@LQ3V64L9R2>
 <20241025010527.491605-1-dev@nalramli.com>
 <CYYPR12MB8655545294DAB1B0D174B2AC9C4F2@CYYPR12MB8655.namprd12.prod.outlook.com>
 <3a4596ba-1a83-4cd2-ba17-5132861eac00@amd.com>
Content-Language: en-US
From: "Nabil S. Alramli" <dev@nalramli.com>
In-Reply-To: <3a4596ba-1a83-4cd2-ba17-5132861eac00@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mario,

Thank you for taking a look at my patch.

What do you think about the following for the commit message in the next
revision of the PATCH, and omitting the cover letter since most of it is
incorporated here?

***********************************************************************

cpufreq: amd-pstate: Enable CPU boost in passive and guided modes

The CPU frequency cannot be boosted when using the amd_pstate driver in
passive or guided mode. This is fixed here.

For example, on a host that has AMD EPYC 7662 64-Core processor without
this patch running at full CPU load:

$ for i in $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); =
\
  do ni=3D$(echo "scale=3D1; $i/1000000" | bc -l); echo "$ni GHz"; done |=
 \
  sort | uniq -c

    128 2.0 GHz

And with this patch:

$ for i in $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); =
\
  do ni=3D$(echo "scale=3D1; $i/1000000" | bc -l); echo "$ni GHz"; done |=
 \
  sort | uniq -c

    128 3.3 GHz

The CPU frequency is dependent on a setting called highest_perf which is
the multiplier used to compute it. The highest_perf value comes from
cppc_init_perf when the driver is built-in and from pstate_init_perf when
it is a loaded module. Both of these calls have the following condition:

        highest_perf =3D amd_get_highest_perf();
        if (highest_perf > __cppc_highest_perf_)
                highest_perf =3D __cppc_highest_perf;

Where again __cppc_highest_perf is either the return from
cppc_get_perf_caps in the built-in case or AMD_CPPC_HIGHEST_PERF in the
module case. Both of these functions actually return the nominal value,
Whereas the call to amd_get_highest_perf returns the correct boost
value, so the condition tests true and highest_perf always ends up being
the nominal value, therefore never having the ability to boost CPU
frequency.

Since amd_get_highest_perf already returns the boost value we should
just eliminate this check.

The issue was introduced in v6.1 via commit bedadcfb011f ("cpufreq:
amd-pstate: Fix initial highest_perf value"), and exists in stable kernel=
s

In v6.6.51, a large change, commit 1ec40a175a48 ("cpufreq: amd-pstate:
Enable amd-pstate preferred core support"), was introduced which
significantly refactored the code. This commit cannot be ported back on
its own, and would require reviewing and cherry picking at least a few
dozen of commits in cpufreq, amd-pstate, ACPI, CPPC.

This means kernels v6.1 up until v6.6.51 are affected by this
significant performance issue, and cannot be easily remediated. This
patch simplifies the fix to a single commit.

***********************************************************************

On 10/28/2024 4:07 PM, Mario Limonciello wrote:
> On 10/24/2024 22:23, Yuan, Perry wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>> -----Original Message-----
>>> From: Nabil S. Alramli <dev@nalramli.com>
>>> Sent: Friday, October 25, 2024 9:05 AM
>>> To: stable@vger.kernel.org
>>> Cc: nalramli@fastly.com; jdamato@fastly.com; khubert@fastly.com;
>>> Yuan, Perry
>>> <Perry.Yuan@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; Huang, R=
ay
>>> <Ray.Huang@amd.com>; rafael@kernel.org; viresh.kumar@linaro.org; linu=
x-
>>> pm@vger.kernel.org; linux-kernel@vger.kernel.org; Nabil S. Alramli
>>> <dev@nalramli.com>
>>> Subject: [RFC PATCH 6.1.y 0/1] cpufreq: amd-pstate: Enable CPU boost
>>> in passive
>>> and guided modes
>>>
>>> Greetings,
>>>
>>> This is a RFC for a maintenance patch to an issue in the amd_pstate
>>> driver where
>>> CPU frequency cannot be boosted in passive or guided modes. Without
>>> this patch,
>>> AMD machines using stable kernels are unable to get their CPU
>>> frequency boosted,
>>> which is a significant performance issue.
>>>
>>> For example, on a host that has AMD EPYC 7662 64-Core processor
>>> without this
>>> patch running at full CPU load:
>>>
>>> $ for i in $(cat
>>> /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); \
>>> =C2=A0=C2=A0 do ni=3D$(echo "scale=3D1; $i/1000000" | bc -l); echo "$=
ni GHz"; done | \
>>> =C2=A0=C2=A0 sort | uniq -c
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 128 2.0 GHz
>>>
>>> And with this patch:
>>>
>>> $ for i in $(cat
>>> /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); \
>>> =C2=A0=C2=A0 do ni=3D$(echo "scale=3D1; $i/1000000" | bc -l); echo "$=
ni GHz"; done | \
>>> =C2=A0=C2=A0 sort | uniq -c
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 128 3.3 GHz
>>>
>>> I am not sure what the correct process is for submitting patches
>>> which affect only
>>> stable trees but not the current code base, and do not apply to the
>>> current tree. As
>>> such, I am submitting this directly to stable@, but please let me
>>> know if I should be
>>> submitting this elsewhere.
>>>
>>> The issue was introduced in v6.1 via commit bedadcfb011f ("cpufreq:
>>> amd-pstate: Fix initial highest_perf value"), and exists in stable
>>> kernels up until
>>> v6.6.51.
>>>
>>> In v6.6.51, a large change, commit 1ec40a175a48 ("cpufreq: amd-pstate=
:
>>> Enable amd-pstate preferred core support"), was introduced which
>>> significantly
>>> refactored the code. This commit cannot be ported back on its own,
>>> and would
>>> require reviewing and cherry picking at least a few dozen of commits
>>> in cpufreq,
>>> amd-pstate, ACPI, CPPC.
>>>
>>> This means kernels v6.1 up until v6.6.51 are affected by this
>>> significant
>>> performance issue, and cannot be easily remediated.
>>>
>>> Thank you for your attention and I look forward to your response in
>>> regards to what
>>> the best way to proceed is for getting this important performance fix
>>> merged.
>>>
>>> Best Regards,
>>>
>>> Nabil S. Alramli (1):
>>> =C2=A0=C2=A0 cpufreq: amd-pstate: Enable CPU boost in passive and gui=
ded modes
>>>
>>> =C2=A0 drivers/cpufreq/amd-pstate.c | 8 ++------
>>> =C2=A0 1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> --=20
>>> 2.35.1
>>
>> Add Mario and Gautham for any help.
>>
>> Perry.
>>
>=20
> If doing a patch that is only for 6.1.y then I think that some more of
> this information from the cover letter needs to push into the patch its=
elf.
>=20
> But looking over the patch and considering how much we've changed this
> in the newer kernels I think it is a sensible localized change for 6.1.=
y.
>=20
> As this is fixed in 6.6.51 via a more complete backport patch please
> only tag 6.1 in your "Cc: stable@vger.kernel.org" from the patch.
>=20

