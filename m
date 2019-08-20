Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60215955B0
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 05:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfHTDjd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 23:39:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39406 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHTDjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 23:39:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so2376976pgi.6
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 20:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DYGO86uLTSpBFsqyRPgG0kZAe1AG4hshV79weFR5920=;
        b=mCEsjGHEV/007JwSzWPqAL6lNivgf0WcmcgTIxpLCH3P6kLl8PO6XhqagkWFSQwVG3
         0nigHbGCULjYmojCXTzJbxmerZxC99eFsf34Rl9lwnGIimxMizNZZR/kod7JTk1xuaBm
         wutn87TaESpTlsiYFDwI2mD8yEgXKVxDWorWE+SyHugrIfo1WCgGOgDjM7TpBhrWjNxX
         y22qC45an5oM0evMP0ybn51EbI/K6vlPVv3IsB/sor+H03c9wTN4UlHfoazUZBUNijrc
         iN9o2hhErrOZ3fgcae9W3EdtBIrR5XxgdB2mOQcihllJofU8jNxLCkxyQqUicaYwG8v2
         IzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DYGO86uLTSpBFsqyRPgG0kZAe1AG4hshV79weFR5920=;
        b=ey0ld2QkRUCRvf9djK6VlqeTVvngguLxrx1Gke4a73SrCqEeoEUHMT4yAIoRGrijFK
         hy3krlrG9sh7Inr1nmTTmZELdTlqLq/NKdJaytv+FGofbmnrCSnqoVf4levQbRjKUibm
         rsxg2vlQnph9R6Ot31ECXv8uwv05az3yaHvWFZBaTBTqhXvVaXYmkXf1ttW9Gtusz4du
         mvyU1+EjnnRvV6vsMj8xbOKuo2y7j4fKT/W9byibH1yvOUitii31Qmp1Zr8qUYTpY8VS
         /NZB1dF0NKIeYVClOtNdhVLDFStpO0j7LQHT8VlZgMsndpQ4Dt8OVMQbjTC2ikROb9jB
         Ks6g==
X-Gm-Message-State: APjAAAUFRLX9IU+ZkmlIA03pxGMKZRuBZMCYvnb+UKGjetdUeQlRx9rs
        0bqnI0ugeOl6sB8wplfKuAxzVQ==
X-Google-Smtp-Source: APXvYqzFpEjUSmXBk62EUY/Mz1WvgYWKQh88SMa3hzj+OaxnG3lQPeO6zyJZ8hFl1UXHq9rv1X8Eug==
X-Received: by 2002:a65:6415:: with SMTP id a21mr21550631pgv.98.1566272371730;
        Mon, 19 Aug 2019 20:39:31 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id i137sm36834826pgc.4.2019.08.19.20.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 20:39:30 -0700 (PDT)
Date:   Tue, 20 Aug 2019 09:09:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
Subject: Re: [v4, 7/8] cpufreq: mediatek: add opp notification for SVS support
Message-ID: <20190820033927.72muldasu4xd6wb7@vireshk-i7>
References: <1565703113-31479-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1565703113-31479-8-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565703113-31479-8-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-08-19, 21:31, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> cpufreq should listen opp notification and do proper actions
> when receiving disable and voltage adjustment events,
> which are triggered when SVS is enabled.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 78 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 4dce41b18369..9820c8003507 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -42,6 +42,10 @@ struct mtk_cpu_dvfs_info {
>  	struct list_head list_head;
>  	int intermediate_voltage;
>  	bool need_voltage_tracking;
> +	struct mutex lock; /* avoid notify and policy race condition */
> +	struct notifier_block opp_nb;
> +	int opp_cpu;
> +	unsigned long opp_freq;
>  };
>  
>  static LIST_HEAD(dvfs_info_list);
> @@ -231,6 +235,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  	vproc = dev_pm_opp_get_voltage(opp);
>  	dev_pm_opp_put(opp);
>  
> +	mutex_lock(&info->lock);
>  	/*
>  	 * If the new voltage or the intermediate voltage is higher than the
>  	 * current voltage, scale up voltage first.
> @@ -242,6 +247,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  			pr_err("cpu%d: failed to scale up voltage!\n",
>  			       policy->cpu);
>  			mtk_cpufreq_set_voltage(info, old_vproc);
> +			mutex_unlock(&info->lock);
>  			return ret;
>  		}
>  	}
> @@ -253,6 +259,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  		       policy->cpu);
>  		mtk_cpufreq_set_voltage(info, old_vproc);
>  		WARN_ON(1);
> +		mutex_unlock(&info->lock);
>  		return ret;
>  	}
>  
> @@ -263,6 +270,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  		       policy->cpu);
>  		clk_set_parent(cpu_clk, armpll);
>  		mtk_cpufreq_set_voltage(info, old_vproc);
> +		mutex_unlock(&info->lock);
>  		return ret;
>  	}
>  
> @@ -273,6 +281,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  		       policy->cpu);
>  		mtk_cpufreq_set_voltage(info, inter_vproc);
>  		WARN_ON(1);
> +		mutex_unlock(&info->lock);
>  		return ret;
>  	}
>  
> @@ -288,15 +297,74 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  			clk_set_parent(cpu_clk, info->inter_clk);
>  			clk_set_rate(armpll, old_freq_hz);
>  			clk_set_parent(cpu_clk, armpll);
> +			mutex_unlock(&info->lock);
>  			return ret;
>  		}
>  	}
>  
> +	info->opp_freq = freq_hz;
> +	mutex_unlock(&info->lock);
> +
>  	return 0;
>  }
>  
>  #define DYNAMIC_POWER "dynamic-power-coefficient"
>  
> +static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
> +				    unsigned long event, void *data)
> +{
> +	struct dev_pm_opp *opp = data;
> +	struct dev_pm_opp *opp_item;
> +	struct mtk_cpu_dvfs_info *info =
> +		container_of(nb, struct mtk_cpu_dvfs_info, opp_nb);
> +	unsigned long freq, volt;
> +	struct cpufreq_policy *policy;
> +	int ret = 0;
> +
> +	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
> +		freq = dev_pm_opp_get_freq(opp);
> +
> +		mutex_lock(&info->lock);
> +		if (info->opp_freq == freq) {
> +			volt = dev_pm_opp_get_voltage(opp);
> +			ret = mtk_cpufreq_set_voltage(info, volt);
> +			if (ret)
> +				dev_err(info->cpu_dev, "failed to scale voltage: %d\n",
> +					ret);
> +		}
> +		mutex_unlock(&info->lock);
> +	} else if (event == OPP_EVENT_DISABLE) {

Does this ever get called for your platform ? Why are you using opp disable ?
Maybe we can avoid it completely.

> +		freq = info->opp_freq;
> +		opp_item = dev_pm_opp_find_freq_ceil(info->cpu_dev, &freq);
> +		if (!IS_ERR(opp_item))
> +			dev_pm_opp_put(opp_item);
> +		else
> +			freq = 0;
> +
> +		/* case of current opp is disabled */
> +		if (freq == 0 || freq != info->opp_freq) {
> +			// find an enable opp item
> +			freq = 1;
> +			opp_item = dev_pm_opp_find_freq_ceil(info->cpu_dev,
> +							     &freq);
> +			if (!IS_ERR(opp_item)) {
> +				dev_pm_opp_put(opp_item);
> +				policy = cpufreq_cpu_get(info->opp_cpu);
> +				if (policy) {
> +					cpufreq_driver_target(policy,
> +						freq / 1000,
> +						CPUFREQ_RELATION_L);
> +					cpufreq_cpu_put(policy);
> +				}
> +			} else
> +				pr_err("%s: all opp items are disabled\n",
> +				       __func__);
> +		}
> +	}
> +
> +	return notifier_from_errno(ret);
> +}
> +
>  static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  {
>  	struct device *cpu_dev;
> @@ -383,11 +451,21 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
>  	dev_pm_opp_put(opp);
>  
> +	info->opp_cpu = cpu;
> +	info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
> +	ret = dev_pm_opp_register_notifier(cpu_dev, &info->opp_nb);
> +	if (ret) {
> +		pr_warn("cannot register opp notification\n");
> +		goto out_free_opp_table;
> +	}
> +
> +	mutex_init(&info->lock);
>  	info->cpu_dev = cpu_dev;
>  	info->proc_reg = proc_reg;
>  	info->sram_reg = IS_ERR(sram_reg) ? NULL : sram_reg;
>  	info->cpu_clk = cpu_clk;
>  	info->inter_clk = inter_clk;
> +	info->opp_freq = clk_get_rate(cpu_clk);
>  
>  	/*
>  	 * If SRAM regulator is present, software "voltage tracking" is needed
> -- 
> 2.12.5

-- 
viresh
