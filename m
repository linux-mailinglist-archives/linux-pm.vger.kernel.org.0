Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D35202F75
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 07:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgFVFYR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 01:24:17 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8298 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgFVFYR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 01:24:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef040250000>; Sun, 21 Jun 2020 22:22:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 21 Jun 2020 22:24:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 21 Jun 2020 22:24:16 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 05:24:05 +0000
Subject: Re: [TEGRA194_CPUFREQ Patch v3 3/4] cpufreq: Add Tegra194 cpufreq
 driver
To:     kernel test robot <lkp@intel.com>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jonathanh@nvidia.com>, <talho@nvidia.com>,
        <linux-pm@vger.kernel.org>
CC:     <kbuild-all@lists.01.org>, Sumit Gupta <sumitg@nvidia.com>,
        Bibek Basu <bbasu@nvidia.com>
References: <1592775274-27513-4-git-send-email-sumitg@nvidia.com>
 <202006221149.73bmuu35%lkp@intel.com>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <31f4f0a0-7bc1-fa37-a27b-6fd27b190c14@nvidia.com>
Date:   Mon, 22 Jun 2020 10:54:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <202006221149.73bmuu35%lkp@intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592803366; bh=d/Xferoo9jRfIRDBatCBGSsOoNATiq2uTi/6Q3EcxJ4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VhGMJI676KdKW1qWy72/yZNrGDeP8yBrJlrpoJP2o8SttDecz5oBskmDJLDlzJ+Ml
         JIkOjfsaEZFgEGBdicPCpf43AhgZy8bVnHArl01W9jMWTSXILRoenVGLewEfbA2+br
         f622ldg864IEr+9rPjxEp8JnoevH7URhxbsJz1rGk/EHHQ/OKKwmIpNK+J+cLzQefh
         4K6BAGWaf6wH+BHtgISc/lwC4Ai/twU5s9Keg/Zp7AcztNPbsc6T3H06P5aq7kghIU
         XfAzoAKLKyjvPsNzyitnVURHSe/b1ACQT18Q2gYbel3ILUFtnL2V/qM92xUaIsQJno
         XxDzaumRAjFaw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

Thank you for the report.

> 
> Hi Sumit,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on pm/linux-next]
> [also build test WARNING on robh/for-next arm64/for-next/core v5.8-rc2 next-20200621]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Sumit-Gupta/Add-cpufreq-driver-for-Tegra194/20200622-053622
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Sure.
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> drivers/cpufreq/tegra194-cpufreq.c:86:5: warning: no previous prototype for 'map_freq_to_ndiv' [-Wmissing-prototypes]
> 86 | u16 map_freq_to_ndiv(struct mrq_cpu_ndiv_limits_response *nltbl, u32 freq)
> |     ^~~~~~~~~~~~~~~~
> 
> vim +/map_freq_to_ndiv +86 drivers/cpufreq/tegra194-cpufreq.c
> 
>      85
>    > 86  u16 map_freq_to_ndiv(struct mrq_cpu_ndiv_limits_response *nltbl, u32 freq)
>      87  {
>      88          return DIV_ROUND_UP(freq * nltbl->pdiv * nltbl->mdiv,
>      89                              nltbl->ref_clk_hz / KHZ);
>      90  }
>      91
> 

will take care of this in next version.
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
