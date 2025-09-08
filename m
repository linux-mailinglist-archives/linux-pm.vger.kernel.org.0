Return-Path: <linux-pm+bounces-34118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A69B481DF
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 03:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964EA167BA6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087847F4A;
	Mon,  8 Sep 2025 01:13:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC263B9;
	Mon,  8 Sep 2025 01:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293998; cv=none; b=GPsQFbDWFD13EK2Qf1yCEXIRgh485vADIdM/5R4ReXg0rZo5OQh2Nek8eBjSkvVt2Z6KUV83Og1BxgL5AJjXv5qj8PXkEGi1MpW9G9okWLa2g8IdBzzxmF4xYBN4aJWq3ZsOZth7t0YuVBvL2MyxsoKxrO2xCHZbzA4UNsfMxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293998; c=relaxed/simple;
	bh=jICxMNK9DzWQLdS3LLxmWn7/quzciSpbt0oIHrvdC2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kanZZOVU4Gd810a7NvMW86QTChV4FV+vtlCsm0NNdnW9q1KTaJ8UqP0s2O9iXOVvRMS3fhHBczpSr52HxZNDfFiVSLRuZjjGYJieWfI4KzccvWmjf6qu4WtWxol2LjwvG3nxzEWAKoM+fSSZD9ftXybcXla7HpuuVfTmEvFV+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f9abf3ec8c5011f0b29709d653e92f7d-20250908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:efd84b0b-3277-4fc8-a332-e9f350276621,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:bc725849a7d0b3c5083c9325fa76557f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850,TC:nil,Content:-
	10|-8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f9abf3ec8c5011f0b29709d653e92f7d-20250908
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2028215909; Mon, 08 Sep 2025 09:13:06 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 155EDE008FA4;
	Mon,  8 Sep 2025 09:13:06 +0800 (CST)
X-ns-mid: postfix-68BE2DA1-89269249
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id B1E7DE008FA2;
	Mon,  8 Sep 2025 09:13:04 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org
Cc: jonathan.cameron@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	viresh.kumar@linaro.org,
	zhangzihuan@kylinos.cn
Subject: Re: [PATCH v1 3/3] cpufreq: intel_pstate: Adjust frequency percentage
Date: Mon,  8 Sep 2025 09:12:59 +0800
Message-Id: <20250908011259.2047702-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3395556.44csPzL39Z@rafael.j.wysocki>
References: <3395556.44csPzL39Z@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1696,8 +1696,8 @@ unlock_driver:
>  static void update_cpu_qos_request(int cpunum, enum freq_qos_req_type =
type)
>  {
>  	struct cpudata *cpu =3D all_cpu_data[cpunum];
> +	unsigned int freq =3D cpu->pstate.turbo_freq;
>  	struct freq_qos_request *req;
> -	unsigned int freq, perf_pct;
> =20
>  	struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpufreq_=
cpu_get(cpunum);
>  	if (!policy)
> @@ -1711,14 +1711,12 @@ static void update_cpu_qos_request(int c
>  		intel_pstate_get_hwp_cap(cpu);
> =20
>  	if (type =3D=3D FREQ_QOS_MIN) {
> -		perf_pct =3D global.min_perf_pct;
> +		freq =3D DIV_ROUND_UP(freq * global.min_perf_pct, 100);
>  	} else {
>  		req++;
> -		perf_pct =3D global.max_perf_pct;
> +		freq =3D (freq * global.max_perf_pct) / 100;
>  	}
> =20
> -	freq =3D DIV_ROUND_UP(cpu->pstate.turbo_freq * perf_pct, 100);
> -
>  	if (freq_qos_update_request(req, freq) < 0)
>  		pr_warn("Failed to update freq constraint: CPU%d\n", cpunum);
>  }

Acked-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

