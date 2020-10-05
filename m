Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B383282FF3
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 07:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgJEFEt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 01:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgJEFEt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 01:04:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923E6C0613CE
        for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2020 22:04:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t7so5267367pjd.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2020 22:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zJ+HJBDflQGCB0biCQ/jEaCKlcM58uCP7NDTnA9FKso=;
        b=P2cI4HmqVhc0e7KFKXQns6ifoePmhY044x3VAIf54UY6NLAWvxsJevqU49S3GZ02a3
         BRSiTLuoXP+6vx6kXCS6SDXsH1tHd597/FvPlwP//HxyiIpx4SaDeIuYpVJMa7U2Tej8
         9pOr8M3ZUWBa3f/TjdRFEEj3xAkp/v1dy+kTFGUG+R94kcVRqFmqay2oVEob8ffTZk3b
         wrJG3kGfr/tVZkWP1eGEU8nYXyCHIThFoSEx8tPmj7b2rCGwKCZVxIbhcvaPVIwKmRVq
         EjozQPg9fA3gKGiuNZCi1PhiebGus6ruHJycT93HDKRbwkuBwds2ejxA6l4D5wnxMH9d
         9n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zJ+HJBDflQGCB0biCQ/jEaCKlcM58uCP7NDTnA9FKso=;
        b=uEERaFMsTzGaxp9/vyL44KngB/PXzALJpotU1aG9GimLSkvfbgKmXZfmcwxkMGseu6
         Ahvarq58XLKCRuwg2naAYUnHSvBbCzVH64ih4asFIn/6KXEy4qSec+T64DiQP9qukSOI
         JNJMkaIJV39bVL6AAb+BiDjdPT7OpJrk1x007pDdTPusLaobRdkpsysXE9cBkUEk/FZv
         EN3c9U7yH8xmZEIIxNz+Ye+x+kFUMnc6eG7+wRA04hFMZ7b3gvozX5dZFgU21P+rcdS2
         XCtoN3gZ66wkHqQ4AmP0ACie2rkRf5c7TcVexHPKkbL/ZV3GWQWm/jIb+C+r7op+t6cv
         hjIQ==
X-Gm-Message-State: AOAM533gpjYnfVBjdTeaZZZnPcB9ckBW8a5lSQic7ZEtk3ilrjCP5NwB
        K2s6/s5xQAZcOnGmUf48ABAlSg==
X-Google-Smtp-Source: ABdhPJx21/IAAUVh9Dd6fGaXlDzIv/pG0eUCG/LwtMPjqUBtjRI1MmFk8yP5J2tiHRDmgBjMTeEDiw==
X-Received: by 2002:a17:90b:3314:: with SMTP id kf20mr6332149pjb.19.1601874288838;
        Sun, 04 Oct 2020 22:04:48 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 125sm10574283pff.59.2020.10.04.22.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2020 22:04:47 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:34:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, kbuild-all@lists.01.org,
        linux-pm@vger.kernel.org
Subject: Re: [linux-next:master 7640/10763]
 drivers/cpufreq/tegra186-cpufreq.c:108:18: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <20201005050446.l34khuavbb24ndhx@vireshk-i7>
References: <202009251730.7KAszdTF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009251730.7KAszdTF%lkp@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-09-20, 17:15, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   d1d2220c7f39d0fca302c4ba6cca4ede01660a2b
> commit: b89c01c960511dcffe3666d89645c95445d00902 [7640/10763] cpufreq: tegra186: Fix initial frequency
> config: arm64-randconfig-s031-20200923 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-201-g24bdaac6-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b89c01c960511dcffe3666d89645c95445d00902
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout b89c01c960511dcffe3666d89645c95445d00902
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    drivers/cpufreq/tegra186-cpufreq.c:72:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *driver_data @@     got void [noderef] __iomem * @@
>    drivers/cpufreq/tegra186-cpufreq.c:72:37: sparse:     expected void *driver_data
>    drivers/cpufreq/tegra186-cpufreq.c:72:37: sparse:     got void [noderef] __iomem *
>    drivers/cpufreq/tegra186-cpufreq.c:87:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *edvd_reg @@     got void *driver_data @@
>    drivers/cpufreq/tegra186-cpufreq.c:87:40: sparse:     expected void [noderef] __iomem *edvd_reg
>    drivers/cpufreq/tegra186-cpufreq.c:87:40: sparse:     got void *driver_data
> >> drivers/cpufreq/tegra186-cpufreq.c:108:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *edvd_reg @@     got void *driver_data @@
>    drivers/cpufreq/tegra186-cpufreq.c:108:18: sparse:     expected void [noderef] __iomem *edvd_reg
>    drivers/cpufreq/tegra186-cpufreq.c:108:18: sparse:     got void *driver_data
> 
> vim +108 drivers/cpufreq/tegra186-cpufreq.c
> 
>     53	
>     54	static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
>     55	{
>     56		struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
>     57		unsigned int i;
>     58	
>     59		for (i = 0; i < data->num_clusters; i++) {
>     60			struct tegra186_cpufreq_cluster *cluster = &data->clusters[i];
>     61			const struct tegra186_cpufreq_cluster_info *info =
>     62				cluster->info;
>     63			int core;
>     64	
>     65			for (core = 0; core < ARRAY_SIZE(info->cpus); core++) {
>     66				if (info->cpus[core] == policy->cpu)
>     67					break;
>     68			}
>     69			if (core == ARRAY_SIZE(info->cpus))
>     70				continue;
>     71	
>   > 72			policy->driver_data =
>     73				data->regs + info->offset + EDVD_CORE_VOLT_FREQ(core);
>     74			policy->freq_table = cluster->table;
>     75			break;
>     76		}
>     77	
>     78		policy->cpuinfo.transition_latency = 300 * 1000;
>     79	
>     80		return 0;
>     81	}
>     82	
>     83	static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
>     84					       unsigned int index)
>     85	{
>     86		struct cpufreq_frequency_table *tbl = policy->freq_table + index;
>     87		void __iomem *edvd_reg = policy->driver_data;
>     88		u32 edvd_val = tbl->driver_data;
>     89	
>     90		writel(edvd_val, edvd_reg);
>     91	
>     92		return 0;
>     93	}
>     94	
>     95	static unsigned int tegra186_cpufreq_get(unsigned int cpu)
>     96	{
>     97		struct cpufreq_frequency_table *tbl;
>     98		struct cpufreq_policy *policy;
>     99		void __iomem *edvd_reg;
>    100		unsigned int i, freq = 0;
>    101		u32 ndiv;
>    102	
>    103		policy = cpufreq_cpu_get(cpu);
>    104		if (!policy)
>    105			return 0;
>    106	
>    107		tbl = policy->freq_table;
>  > 108		edvd_reg = policy->driver_data;
>    109		ndiv = readl(edvd_reg) & EDVD_CORE_VOLT_FREQ_F_MASK;
>    110	
>    111		for (i = 0; tbl[i].frequency != CPUFREQ_TABLE_END; i++) {
>    112			if ((tbl[i].driver_data & EDVD_CORE_VOLT_FREQ_F_MASK) == ndiv) {
>    113				freq = tbl[i].frequency;
>    114				break;
>    115			}
>    116		}
>    117	
>    118		cpufreq_cpu_put(policy);
>    119	
>    120		return freq;
>    121	}
>    122	

Jon,

Please send a fix for this.

-- 
viresh
