Return-Path: <linux-pm+bounces-34116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83042B481B6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 02:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047D8167581
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD618A921;
	Mon,  8 Sep 2025 00:41:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E71C68F;
	Mon,  8 Sep 2025 00:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757292093; cv=none; b=rW9SZJvh+LoibebSKCB9VFzlRXIKFrvY3nhxFI7jZu1Vnu3rKaNGNtc7cdUwPMlnUJuB03XaYJC9/KqD5dT5XfgWf4ZSW2l1IUaYDaP6/tyMXRn+RSWfGp57dJnx73B6RLftlNFiTuI1vfeDr3NM9a54i7vj29twrxHoYXkWbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757292093; c=relaxed/simple;
	bh=7+TNF79jJvSYsblRzXFIJiGQ+i6MQnTG8YiZB/QvLyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7UOxPYo/xfnBmuxgLey/g/kbUg9bA+pE3lJmzKxxdwPBlopDyAtxrsZr8yt7zsgONbAWNuF4ebY9Upj9SFlJBs2S1an6AkDI1CeU2OjmIyjgJmJb1E/Gi4iFZdrEvTNmCmfWR9t++aW/+BOzytWlxYRp3fbL39W53+SpWBSyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 855ec6da8c4c11f0b29709d653e92f7d-20250908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:45b1f101-3491-40ef-ab6c-8642362d1aaf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b40aa844a40dcead21abd9529821ab80,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 855ec6da8c4c11f0b29709d653e92f7d-20250908
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2090132884; Mon, 08 Sep 2025 08:41:13 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E0A4AE008FA3;
	Mon,  8 Sep 2025 08:41:12 +0800 (CST)
X-ns-mid: postfix-68BE2628-72593311
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 9173CE008FA2;
	Mon,  8 Sep 2025 08:41:11 +0800 (CST)
Message-ID: <f099c236-b9d5-4d73-9176-c91f54acffd0@kylinos.cn>
Date: Mon, 8 Sep 2025 08:41:10 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] cpufreq: intel_pstate: Fix object lifecycle issue
 in update_qos_request()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <5028967.GXAFRqVoOG@rafael.j.wysocki>
 <2255671.irdbgypaU6@rafael.j.wysocki>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <2255671.irdbgypaU6@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/5 21:52, Rafael J. Wysocki =E5=86=99=E9=81=93:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The cpufreq_cpu_put() call in update_qos_request() takes place too earl=
y
> because the latter subsequently calls freq_qos_update_request() that
> indirectly accesses the policy object in question through the QoS reque=
st
> object passed to it.
>
> Fortunately, update_qos_request() is called under intel_pstate_driver_l=
ock,
> so this issue does not matter for changing the intel_pstate operation
> mode, but it theoretically can cause a crash to occur on CPU device hot
> removal (which currently can only happen in virt, but it is formally
> supported nevertheless).
>
> Address this issue by modifying update_qos_request() to drop the
> reference to the policy later.
>
> Fixes: da5c504c7aae ("cpufreq: intel_pstate: Implement QoS supported fr=
eq constraints")
> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/cpufreq/intel_pstate.c |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1708,10 +1708,10 @@ static void update_qos_request(enum freq
>   			continue;
>  =20
>   		req =3D policy->driver_data;
> -		cpufreq_cpu_put(policy);
> -
> -		if (!req)
> +		if (!req) {
> +			cpufreq_cpu_put(policy);
>   			continue;
> +		}
>  =20
>   		if (hwp_active)
>   			intel_pstate_get_hwp_cap(cpu);
> @@ -1727,6 +1727,8 @@ static void update_qos_request(enum freq
>  =20
>   		if (freq_qos_update_request(req, freq) < 0)
>   			pr_warn("Failed to update freq constraint: CPU%d\n", i);
> +
> +		cpufreq_cpu_put(policy);
>   	}
>   }
>  =20
Reviewed-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

