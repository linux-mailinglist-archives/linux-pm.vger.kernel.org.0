Return-Path: <linux-pm+bounces-34117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C04EB481B9
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 02:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5190E4E026A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 00:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B11155389;
	Mon,  8 Sep 2025 00:53:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E02F879;
	Mon,  8 Sep 2025 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757292805; cv=none; b=dZUQi4qZh8UzZju3vdCpQWlSZ9d1FZcsjrKoF3Am3t7w3l8B1g9QOY25uoS37wNvZtdnsW/1IjTNfKTmEh+W5B93smYRhElYWJEUlzcOQvLrSeHqzpN1JAprVKjDGihoMdJX49rq5Poz0kZpZjd/bwxJ2+LpSDHOde0MnsRpSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757292805; c=relaxed/simple;
	bh=VYFMaR7o0XIkQtik6aUEsQ2DZxVExnIgCuLnPiTZhVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMgsMg1exLBoDnJbWG6FHm90wZBAzYojKzVzKLkPcyHj30uaB/6OMKZ8C0TMhWxWa6gjQdBGGXw4xuzPaylmXshkp42gIvERpkAJ8zOYQR/7cBO3q3on2oDx8XE/k8gvBAYsCFQ5LnsW03Ug8pHAUSWNBuvLeEuwf1OdW7hYvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 34213a448c4e11f0b29709d653e92f7d-20250908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:92758440-117e-4e21-b390-14c090b4325c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:26e7e5f9d90a882a298c0a13321c1e81,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 34213a448c4e11f0b29709d653e92f7d-20250908
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 619401055; Mon, 08 Sep 2025 08:53:15 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A0095E008FA3;
	Mon,  8 Sep 2025 08:53:15 +0800 (CST)
X-ns-mid: postfix-68BE28FB-2495266
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id C1672E008FA2;
	Mon,  8 Sep 2025 08:53:14 +0800 (CST)
Message-ID: <a6104009-d0ad-4d76-9079-0e81e74cd32a@kylinos.cn>
Date: Mon, 8 Sep 2025 08:53:14 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cpufreq: intel_pstate: Rearrange freq QoS updates
 using __free()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <5028967.GXAFRqVoOG@rafael.j.wysocki>
 <3026597.e9J7NaK4W3@rafael.j.wysocki>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <3026597.e9J7NaK4W3@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/5 21:52, Rafael J. Wysocki =E5=86=99=E9=81=93:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Move the code from the for_each_possible_cpu() loop in update_qos_reque=
st()
> to a separate function and use __free() for cpufreq policy reference
> counting in it to avoid having to call cpufreq_cpu_put() repeatedly (or
> using goto).
>
> While at it, rename update_qos_request() to update_qos_requests()
> because it updates multiple requests in one go.
>
> No intentional functional impact.
>
> Link: https://lore.kernel.org/linux-pm/CAJZ5v0gN1T5woSF0tO=3DTbAh+2-sWz=
xFjWyDbB7wG2TFCOU01iQ@mail.gmail.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/cpufreq/intel_pstate.c |   65 ++++++++++++++++++++-----------=
----------
>   1 file changed, 32 insertions(+), 33 deletions(-)
>
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1693,43 +1693,42 @@ unlock_driver:
>   	return count;
>   }
>  =20
> -static void update_qos_request(enum freq_qos_req_type type)
> +static void update_cpu_qos_request(int cpunum, enum freq_qos_req_type =
type)
>   {
> +	struct cpudata *cpu =3D all_cpu_data[cpunum];


Maybe the parameter could be named int cpu instead of cpunum, and the=20
struct cpudata * variable could be renamed to cpudata =E2=80=94 this migh=
t read=20
a bit cleaner and help reduce potential confusion.

I also noticed that in this driver some places use one naming style and=20
others use another, so it might be worth unifying the style here.

Other than that, looks good to me.

>   	struct freq_qos_request *req;
> -	struct cpufreq_policy *policy;
> -	int i;
> +	unsigned int freq, perf_pct;
>  =20
> -	for_each_possible_cpu(i) {
> -		struct cpudata *cpu =3D all_cpu_data[i];
> -		unsigned int freq, perf_pct;
> -
> -		policy =3D cpufreq_cpu_get(i);
> -		if (!policy)
> -			continue;
> -
> -		req =3D policy->driver_data;
> -		if (!req) {
> -			cpufreq_cpu_put(policy);
> -			continue;
> -		}
> -
> -		if (hwp_active)
> -			intel_pstate_get_hwp_cap(cpu);
> -
> -		if (type =3D=3D FREQ_QOS_MIN) {
> -			perf_pct =3D global.min_perf_pct;
> -		} else {
> -			req++;
> -			perf_pct =3D global.max_perf_pct;
> -		}
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpufreq_=
cpu_get(cpunum);
> +	if (!policy)
> +		return;
> +
> +	req =3D policy->driver_data;
> +	if (!req)
> +		return;
> +
> +	if (hwp_active)
> +		intel_pstate_get_hwp_cap(cpu);
> +
> +	if (type =3D=3D FREQ_QOS_MIN) {
> +		perf_pct =3D global.min_perf_pct;
> +	} else {
> +		req++;
> +		perf_pct =3D global.max_perf_pct;
> +	}
>  =20
> -		freq =3D DIV_ROUND_UP(cpu->pstate.turbo_freq * perf_pct, 100);
> +	freq =3D DIV_ROUND_UP(cpu->pstate.turbo_freq * perf_pct, 100);
>  =20
> -		if (freq_qos_update_request(req, freq) < 0)
> -			pr_warn("Failed to update freq constraint: CPU%d\n", i);
> +	if (freq_qos_update_request(req, freq) < 0)
> +		pr_warn("Failed to update freq constraint: CPU%d\n", cpunum);
> +}
>  =20
> -		cpufreq_cpu_put(policy);
> -	}
> +static void update_qos_requests(enum freq_qos_req_type type)
> +{
> +	int i;
> +
> +	for_each_possible_cpu(i)
> +		update_cpu_qos_request(i, type);
>   }
>  =20
>   static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attr=
ibute *b,
> @@ -1758,7 +1757,7 @@ static ssize_t store_max_perf_pct(struct
>   	if (intel_pstate_driver =3D=3D &intel_pstate)
>   		intel_pstate_update_policies();
>   	else
> -		update_qos_request(FREQ_QOS_MAX);
> +		update_qos_requests(FREQ_QOS_MAX);
>  =20
>   	mutex_unlock(&intel_pstate_driver_lock);
>  =20
> @@ -1792,7 +1791,7 @@ static ssize_t store_min_perf_pct(struct
>   	if (intel_pstate_driver =3D=3D &intel_pstate)
>   		intel_pstate_update_policies();
>   	else
> -		update_qos_request(FREQ_QOS_MIN);
> +		update_qos_requests(FREQ_QOS_MIN);
>  =20
>   	mutex_unlock(&intel_pstate_driver_lock);
>  =20
>
>
>
Reviewed-by: Zihuan Zhang <zhangzihuan@kylinos.cn>



