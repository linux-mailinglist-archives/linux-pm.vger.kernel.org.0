Return-Path: <linux-pm+bounces-9019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7583F905636
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 17:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A25F285781
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B817F4F9;
	Wed, 12 Jun 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="ARHmj9r9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D716F91D
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204628; cv=none; b=Wj9AJtmw/F7RyZ9L15MrhvEAr/y1uxLDwWFy5yXAuA34lL3Ua3dZ5/Esvh0tHbtKdEyLE+i5CfJPQ2m+4nrc5p1JLoJMjiCOzOJkCbsttmJH6oo1YMvbNw09KSCzpnbEGJlE8jsup9dSP8acKtXhADzbEzKjjbMTUH3S7bI3Eig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204628; c=relaxed/simple;
	bh=EfEuwbAoApMXvW6k1ZwJxfOsW1afnAram1yUKJ1sbnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QTARIMnOSW6sZ/p5EfxOC7YSakk7Btix4rhq2rkDBITEecmbLsvb9apRPQWDm4mxeGzv9ZQofQe8uoVY6azvLVsXy/beBFscjOnLysljo3A/wENSn01cAX/H9B2e6ZPPdBYrwFSBDfn2IO4H/R2kUzL91hhh/zrjbk47ae59Ff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=ARHmj9r9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718204624; x=1718809424; i=aros@gmx.com;
	bh=FJJSCBDcQ8Rb61Va4wHZQ8a7Ojhock9yeC0dvo1co/U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ARHmj9r9wVf7W0skgerMAMT0tpxk//HdhYRUFjJ6ylohH3wxhaYWXyTOZxC0CY2A
	 2hUPMVvufU+3FCeEB2Ti19PahYrbWCIApP9oI0XwayD6n3Tc6CCHJiSoIvfNaMLnZ
	 1teeQtIkkQThhnKl6z705YHC2VjvYZ/d6vuO7fewiVBv2HA34QlaYOIh4seHfFqBf
	 kCYmYcmR8cWM9rD1UOw4hkwxYRudKqft/PhxRy+hZNdSXy7YxYi8hRjim1ORsSXZz
	 MELqOgpGn3F+hXhwqHJtQLr7wrkKUzqAZ2F72WtVAh08Ta0mDPai0JlqeOHHXIMha
	 1iBYKlICbVf26raV5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.44.110.2] ([89.149.39.134]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My32F-1scUpj0pw7-00zx9R for
 <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 17:03:44 +0200
Message-ID: <de539c7d-c22d-4619-90c5-fcf78a0fab92@gmx.com>
Date: Wed, 12 Jun 2024 15:03:43 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] cpufreq: amd-pstate: Allow users to write 'default' EPP
 string
To: linux-pm@vger.kernel.org
References: <20240612145737.1618-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20240612145737.1618-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sy07X8MqyL0OIU6aLFgdlqvnOo3q3gO9gLIsy+T1EBJWj2Q0BYY
 7ZPb0QMvc4Rfs1bFodtWMiFvBCPd918VI4RtinhJJmaCagpMEOR2Iiai1vfyR62NPeHQeuZ
 yOYhIBO5zsiD1isI2ST1FWKCIxKSe270gBP9GCLEh0a31DAQ6e4AXke1rF0eO5Qiqpv2+hv
 eAnPaR9pkB+ghTZqvIfBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:40tL5BueEh8=;te07n72pQvlRKiigVqjapA8iqw6
 5gD3Dcqt25cyl+UfAQ2QN2YTIXRfxhs9wh6kGrjp8mBuC/z7mtK2yDK4pn3aihFm8zcXWJFvv
 g5qzOT1X9Wv+zPm+wSPpqiZ/pm/v/06n3qESWuchn7t0yTn5ERohcAi2poRhpbXYL4mColjci
 p3B4fCvcxSq+deCKQxJ6gtqJRst4/FyFw52ooIRkYpk7WGUZTYgJ2l3+HJBBXV7SY0W5tJMmr
 IdHNxvUQZtlKaSd2TdEGMVrIVPNknCCJo3A3Q7kJsOLRsMoaNGL+SXpnlL9SIjTO6h8Pg/Qag
 CWI/ZKryk+qNR3PVmZMpKe8J0fso9GC+2G2ztJNWNMolRT9DKjRCi/v9e7K6HnQZksnDpe3Sf
 PJLqaxf222paMJyxnDLXsSMni6hnRYur2maja7dCJuOUYdsIkMQn/80S6C6fOqrTRVvHFC0mM
 Je7xaMx/dovJoyYE5CO2ejgpWvoy1Ldwvk0vn6LRgTfqHjUoZATob7MWklivsJsgDANcUFarg
 1qCSzcavnfJ/1wjwgWPmXl54GHm9U5AfGSScrLIH/4bdg9yBJH9IPvAaEPSDlZKVVWvRf8FKq
 zqLWf6X99o+SL1ufO1um8CcyqrSds5lqOHPfD+Axbj3OK9t3ZZQvIwGTpK8txJ90xNbbEiQgq
 rzc9PbLPhXd+n3u5dgrbl3kS2XwNLm6TxuwsehNLDbBbRFlbijzKnrrKj+HITudez5uX2QIbb
 vybnnRZPWHu1CzZkEehaV1LsEO6CfkmKIXoqFc+aKLK0m/U6RiRjVb3AalZaIDCBva2LouVpu
 gmgdQ715FePFZ5w6GkTZHjrtd3LY/1nOXsAnjBl7zJgUs=

That was blazing fast.

Thanks a ton!

On 6/12/24 2:57 PM, Mario Limonciello wrote:
> The EPP string for 'default' represents what the firmware had configured
> as the default EPP value but once a user changes EPP to another string
> they can't reset it back to 'default'.
>
> Cache the firmware EPP value and allow the user to write 'default' using
> this value.
>
> Reported-by: Artem S. Tashkinov <aros@gmx.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931#c61
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 8 +++-----
>   drivers/cpufreq/amd-pstate.h | 1 +
>   2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fda8f86c90e0..5bdcdd3ea163 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -282,10 +282,8 @@ static int amd_pstate_set_energy_pref_index(struct =
amd_cpudata *cpudata,
>   	int epp =3D -EINVAL;
>   	int ret;
>
> -	if (!pref_index) {
> -		pr_debug("EPP pref_index is invalid\n");
> -		return -EINVAL;
> -	}
> +	if (!pref_index)
> +		epp =3D cpudata->epp_default;
>
>   	if (epp =3D=3D -EINVAL)
>   		epp =3D epp_values[pref_index];
> @@ -1441,7 +1439,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_=
policy *policy)
>
>   	policy->driver_data =3D cpudata;
>
> -	cpudata->epp_cached =3D amd_pstate_get_epp(cpudata, 0);
> +	cpudata->epp_cached =3D cpudata->epp_default =3D amd_pstate_get_epp(cp=
udata, 0);
>
>   	policy->min =3D policy->cpuinfo.min_freq;
>   	policy->max =3D policy->cpuinfo.max_freq;
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index e6a28e7f4dbf..f80b33fa5d43 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -99,6 +99,7 @@ struct amd_cpudata {
>   	u32	policy;
>   	u64	cppc_cap1_cached;
>   	bool	suspended;
> +	s16	epp_default;
>   };
>
>   #endif /* _LINUX_AMD_PSTATE_H */

