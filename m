Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 760D16CC24
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 11:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389773AbfGRJpk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 05:45:40 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:10824 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389725AbfGRJpk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 05:45:40 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190718094537epoutp04efab88fe7f397ad78515aead2e3cb27a~yd0ABI_9F0537105371epoutp04P
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 09:45:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190718094537epoutp04efab88fe7f397ad78515aead2e3cb27a~yd0ABI_9F0537105371epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563443137;
        bh=IUzvKwiihCCaFbylXw8HFyTv0vnTNdT51WeEMszXPSE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ugx20yte6JtYUGLCxDMrTFOij3pujkW/1Pc2lVP3skqrbbc4KTeinhgSsh6yVbOrr
         T+YpPKQH2kWQF0Dj6Nqd15AYpOiODCYKxyhdBPT2ixh/qVq5XnRc5IVIf8gtsHCPkr
         FjRVgK+zNiOVxR4fYSGBDOidzrMAeRsOVkc9xN9I=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190718094536epcas1p27d8cfb2336fd295199f678ee09f03edb~ydz-jbd721698816988epcas1p2d;
        Thu, 18 Jul 2019 09:45:36 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45q8Q61ffFzMqYkY; Thu, 18 Jul
        2019 09:45:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.88.04085.EBF303D5; Thu, 18 Jul 2019 18:45:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190718094533epcas1p45c6a0eb2630f8e002f47005cc7e3d2c5~ydz8cklBE2108621086epcas1p49;
        Thu, 18 Jul 2019 09:45:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718094533epsmtrp1fd51ee266c5a3392f477652fc8ca0588~ydz8arDzk1411314113epsmtrp1X;
        Thu, 18 Jul 2019 09:45:33 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-da-5d303fbe62a0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.2C.03638.DBF303D5; Thu, 18 Jul 2019 18:45:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718094533epsmtip19d0271ae4d8ce3ef31a341598b702929~ydz8RqNZX1887418874epsmtip1p;
        Thu, 18 Jul 2019 09:45:33 +0000 (GMT)
Subject: Re: [PATCH v4 18/24] PM / devfreq: tegra30: Optimize CPUFreq
 notifier
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ce18694a-4281-a245-7bdf-299fedc3c724@samsung.com>
Date:   Thu, 18 Jul 2019 18:48:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-19-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO9u8m9HyNrN+LjJ3w0JB3XXOrpE9yGJQhGHBKmxd3PGBe7W7
        hdU/mlFqLyUiWr6wLFNiJlo6Mksts7euF5olGFESRllRWdLd7iL/+5zf7/s73/M958jECjeh
        lOVaHNhuYU0UMVNytTs6LvbGKnWG+l3HLKbx8yhiDrpqJczDAx+ljNdTQTATx3oQU/LVRTBD
        hfUE89NTJWGOXx4gVgfr2obPI127a1iqO1Y0TuiOtzQg3URzRFrQ9rwVOZg1YnsktmRajbmW
        7BRqQ7phrUGbpKZj6WRmGRVpYc04hUrdmBa7PtfEH4iK3MOanHwpjeU4Kn7lCrvV6cCROVbO
        kUJhm9FkS7bFcayZc1qy4zKt5uW0Wp2g5YW78nJ+TRlsdVH5T71vRAVoYmEpCpYBmQgd76tF
        PlaQbQhO/U4tRTN5/oLguadOLCy+IxjoLUP/JgrvXyCERgeC1sHRwOITgr7aUr8qlEyD4qEH
        El9jLjmFoORnEeFriMlt0N3e6DckyBjofP/SXw8hVfDsx6h/WE6uhAtN9/wsIaPAe/Ox1Mdh
        pB7u9VRJBM0c6Dvz1s/BZBKcrhgQCfvPh8G31QFeBEWtZ/0ZgJwkoPraYCBDKrzu/RPgUBjr
        bZEKrIQPJw4FeD9c6ushhOFiBC2dT4KEhgY6607yDjLeIRrcnnihrIL2yUokGM+G8W9Hg3wS
        IOVQfEghSBaDd2RYJHA4nDtcQpQhyjUtjmtaBNe0CK7/ZjVI0oDmYRtnzsYcbdNOf+1m5P+s
        Mclt6M6jjV2IlCFqlvwlFZ+hCGL3cHvNXQhkYmqufOgDX5Ib2b37sN1qsDtNmOtCWv62y8XK
        sEwr//UtDgOtTdBoNEwinaSlaWq+vOp3dIaCzGYdOA9jG7b/mxPJgpUFqL16uHvptcYXesZq
        bPg8EuL8c7oA93eXdW4dI2+1ORdMjm7ismYY1qn6r/bPiBgrnxA36bJCQyovPq25ibz0zkT9
        yK07+SpP7YvNV/K33NYkPMpyV+6Qhp+Jbb6b525p1R9It+lOKo5UJRmfXV9Sv3vh0OtF+8ZN
        WD61RlOoJF5REi6HpWPEdo79C6j+tpvCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO5ee4NYg3ldCharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZv/7FFyxVrbhy+T5TA+Nn2S5GTg4JAROJxtPL
        2EBsIYHdjBKvn9ZCxCUlpl08ytzFyAFkC0scPlzcxcgFVPKWUeLsprvMIDXCAn4SvadvMYMk
        RASamCQ29V5gB0kwC0RK9MzdwgbRsYVR4vapNrAONgEtif0vboBt4xdQlLj64zEjiM0rYCex
        bMMpMJtFQFXi8oHzYINEBSIkJl3byQJRIyhxcuYTMJtTwExi+pxLTBDL1CX+zLvEDGGLS9x6
        Mh8qLi/RvHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1
        kvNzNzGCI0xLawfjiRPxhxgFOBiVeHhvKOnHCrEmlhVX5h5ilOBgVhLhvf0SKMSbklhZlVqU
        H19UmpNafIhRmoNFSZxXPv9YpJBAemJJanZqakFqEUyWiYNTqoEx+dTeF//2iFcwfw3/d95F
        cbOJr3sB9xnmzl8qpwUf8pR0W+v9UO17OY/5178f0//n1jrb+Rd69F7b9dOK69ri4g0XbsT4
        lOyZe15i9W/lf6UFVcc0F368cUllr5Rh5bZ7p/Xm+6wo/JS6Zk3xndm/bql+suNacSNMo+HD
        QaPY5TlKtvG8nqszlFiKMxINtZiLihMBMdrP66wCAAA=
X-CMS-MailID: 20190718094533epcas1p45c6a0eb2630f8e002f47005cc7e3d2c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223618epcas4p48e1e2ae7af04775ac50c68b7636f1a56
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223618epcas4p48e1e2ae7af04775ac50c68b7636f1a56@epcas4p4.samsung.com>
        <20190707223303.6755-19-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> When CPU's memory activity is low or memory activity is high such that
> CPU's frequency contribution to the boosting is not taken into account,
> then there is no need to schedule devfreq's update. This eliminates
> unnecessary CPU activity during of idling caused by the scheduled work.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 73 +++++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 9 deletions(-)

Patch4 add the 'cpufreq notifier' and this patch optimize the cpufreq notifier.
I think t hat you can combine two patches.

> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 43c9c5fbfe91..8d6bf6e9f1ae 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -216,10 +216,10 @@ static inline unsigned long do_percent(unsigned long val, unsigned int pct)
>  	return val * pct / 100;
>  }
>  
> -static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
> +static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
> +					    unsigned int cpu_freq)
>  {
>  	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
> -	unsigned int cpu_freq = cpufreq_get(0);
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
> @@ -239,15 +239,15 @@ tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
>  			      struct tegra_devfreq_device *dev,
>  			      unsigned long target_freq)
>  {
> -	unsigned long static_cpu_emc_freq;
> +	unsigned long cpu_emc_freq = 0;
>  
> -	if (dev->config->avg_dependency_threshold &&
> -	    dev->config->avg_dependency_threshold < dev->avg_freq) {
> -		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
> -		target_freq = max(target_freq, static_cpu_emc_freq);
> -	}
> +	if (!dev->config->avg_dependency_threshold)
> +		return target_freq;
>  
> -	return target_freq;
> +	if (dev->avg_freq > dev->config->avg_dependency_threshold)
> +		cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpufreq_get(0));
> +
> +	return max(target_freq, cpu_emc_freq);
>  }
>  
>  static unsigned long tegra_actmon_lower_freq(struct tegra_devfreq *tegra,
> @@ -531,16 +531,71 @@ static void tegra_actmon_delayed_update(struct work_struct *work)
>  	mutex_unlock(&tegra->devfreq->lock);
>  }
>  
> +static unsigned long
> +tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
> +				  unsigned int cpu_freq)
> +{
> +	unsigned long freq, static_cpu_emc_freq;
> +
> +	/* check whether CPU's freq is taken into account at all */
> +	if (tegra->devices[MCCPU].avg_freq <=
> +	    tegra->devices[MCCPU].config->avg_dependency_threshold)
> +		return 0;
> +
> +	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
> +
> +	/* compare static CPU-EMC freq with MCALL */
> +	freq = tegra->devices[MCALL].avg_freq +
> +	       tegra->devices[MCALL].boost_freq;
> +
> +	freq = tegra_actmon_upper_freq(tegra, freq);
> +
> +	if (freq == tegra->max_freq || freq >= static_cpu_emc_freq)
> +		return 0;
> +
> +	/* compare static CPU-EMC freq with MCCPU */
> +	freq = tegra->devices[MCCPU].avg_freq +
> +	       tegra->devices[MCCPU].boost_freq;
> +
> +	freq = tegra_actmon_upper_freq(tegra, freq);
> +
> +	if (freq == tegra->max_freq || freq >= static_cpu_emc_freq)
> +		return 0;
> +
> +	return static_cpu_emc_freq;
> +}
> +
>  static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
>  				      unsigned long action, void *ptr)
>  {
> +	struct cpufreq_freqs *freqs = ptr;
>  	struct tegra_devfreq *tegra;
> +	unsigned long old, new;
>  
>  	if (action != CPUFREQ_POSTCHANGE)
>  		return NOTIFY_OK;
>  
>  	tegra = container_of(nb, struct tegra_devfreq, cpu_rate_change_nb);
>  
> +	/*
> +	 * Quickly check whether CPU frequency should be taken into account
> +	 * at all, without blocking CPUFreq's core.
> +	 */
> +	if (mutex_trylock(&tegra->devfreq->lock)) {
> +		old = tegra_actmon_cpufreq_contribution(tegra, freqs->old);
> +		new = tegra_actmon_cpufreq_contribution(tegra, freqs->new);
> +		mutex_unlock(&tegra->devfreq->lock);
> +
> +		/*
> +		 * If CPU's frequency shouldn't be taken into account at
> +		 * the moment, then there is no need to update the devfreq's
> +		 * state because ISR will re-check CPU's frequency on the
> +		 * next interrupt.
> +		 */
> +		if (old == new)
> +			return NOTIFY_OK;
> +	}
> +
>  	/*
>  	 * CPUFreq driver should support CPUFREQ_ASYNC_NOTIFICATION in order
>  	 * to allow asynchronous notifications. This means we can't block
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
