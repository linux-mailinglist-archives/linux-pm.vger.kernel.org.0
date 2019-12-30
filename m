Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2660112CC19
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 04:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfL3D07 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Dec 2019 22:26:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42839 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfL3D07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Dec 2019 22:26:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so44570606otd.9;
        Sun, 29 Dec 2019 19:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gv0OLo3Ag/B/dHMfjPCdcXnTNQKEgoSIqR8n6vs8xDY=;
        b=ZnJdLw8VW4okXcIkq4ESy8hwfHq4ecHya/4fKuK6XkftkXS+vZeNz8jzVKDuAjQgUd
         2yLZSlugDjwLrUGW4ITrYIGidUsg7q9chApeWDMPJUHeOXBj3l3R64s5srJXrbGMXCHC
         LcOVr+oHVg4kgxj5UYQh0WLK1EHY4pQo0PKCVmPsZQtQaXnhDKBdWGLwvbxu4bQCi5KI
         onzBl2OhChp1o6Ifcm9vKoP8EGiXB5XMAEnAgMNZKfVOIOZciDXbkCGQQxZLSyEjDfno
         rvYP412jZKShdvVPMIQy4ksCNglFOFSGNXWgH3wjkoDzIqd7kcffSpDIHl/0pfFmu52G
         uC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gv0OLo3Ag/B/dHMfjPCdcXnTNQKEgoSIqR8n6vs8xDY=;
        b=SpoOqrREKbqRNl9Kpaa3HoQ+wnTOIO0Dw55txpEvuaKJoVay5rr5/OEwiloBV1bKb2
         cZbl1ECsBmBviZoQjF7uDXheq5+0ntJS/MpnanzTvY5ZU9oj8YiGBcAl3gt+yPfRtPT1
         XcBrGMN0bSZefHVPIAfHDC6I6BOV9laiZ7TG19uRstRZZhiAf2BTwvviSK8uvxVcqa27
         egNA4PPXeZ9oAqNSLvP/9OM28PTH622YaRSkuB1zBRcv8f5OvVTSU347OzVk8Fwp45D7
         XbElNZ7Xwpz3YbIFOTzhCADV0QBf5X2xM1pfwZ4yqrfP0E4ih6mnkEUj+SCYztb+xQpv
         NbXw==
X-Gm-Message-State: APjAAAXUDaV5ZXWQ4JzNQ6NqcCgk1E8y37dHO1CG1z0b2PdF8X2As0Ss
        H6xuyMKh1E/e0+fIkgxHVdo=
X-Google-Smtp-Source: APXvYqzWNAn/97ZpzmT9RQDbeo9S3yjjl1kpH30S3gStTMaZFtgU4rLjI4cCCw+VwlQ1LJ25BWZk7Q==
X-Received: by 2002:a9d:6481:: with SMTP id g1mr73581601otl.180.1577676417545;
        Sun, 29 Dec 2019 19:26:57 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q25sm15294943otf.45.2019.12.29.19.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 19:26:56 -0800 (PST)
Date:   Sun, 29 Dec 2019 20:26:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] PM / devfreq: Add debugfs support with devfreq_summary
 file
Message-ID: <20191230032655.GA40172@ubuntu-m2-xlarge-x86>
References: <CGME20191226060101epcas1p11a225c00bb7ab2f6b7895b4cb00b9871@epcas1p1.samsung.com>
 <20191226060749.13881-1-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226060749.13881-1-cw00.choi@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On Thu, Dec 26, 2019 at 03:07:49PM +0900, Chanwoo Choi wrote:
> Add debugfs interface to provide debugging information of devfreq device.
> It contains 'devfreq_summary' entry to show the summary of registered
> devfreq devices as following: And the additional debugfs file will be added.
> - /sys/kernel/debug/devfreq/devfreq_summary
> 
> [For example on Exynos5422-based Odroid-XU3 board]
> - In order to show the multiple governors on devfreq_summay result,
> change the governor of devfreq0 from simple_ondemand to userspace.
> 
> $ cat /sys/kernel/debug/devfreq/devfreq_summary
> dev name                       dev        parent dev governor        cur_freq     min_freq     max_freq
> ------------------------------ ---------- ---------- --------------- ------------ ------------ ------------
> 10c20000.memory-controller     devfreq0              userspace       165000000    165000000    825000000
> soc:bus_wcore                  devfreq1              simple_ondemand 400000000    84000000     400000000
> soc:bus_noc                    devfreq2   devfreq1   passive         100000000    67000000     100000000
> soc:bus_fsys_apb               devfreq3   devfreq1   passive         200000000    100000000    200000000
> soc:bus_fsys                   devfreq4   devfreq1   passive         200000000    100000000    200000000
> soc:bus_fsys2                  devfreq5   devfreq1   passive         150000000    75000000     150000000
> soc:bus_mfc                    devfreq6   devfreq1   passive         333000000    96000000     333000000
> soc:bus_gen                    devfreq7   devfreq1   passive         267000000    89000000     267000000
> soc:bus_peri                   devfreq8   devfreq1   passive         67000000     67000000     67000000
> soc:bus_g2d                    devfreq9   devfreq1   passive         333000000    84000000     333000000
> soc:bus_g2d_acp                devfreq10  devfreq1   passive         267000000    67000000     267000000
> soc:bus_jpeg                   devfreq11  devfreq1   passive         300000000    75000000     300000000
> soc:bus_jpeg_apb               devfreq12  devfreq1   passive         167000000    84000000     167000000
> soc:bus_disp1_fimd             devfreq13  devfreq1   passive         200000000    120000000    200000000
> soc:bus_disp1                  devfreq14  devfreq1   passive         300000000    120000000    300000000
> soc:bus_gscl_scaler            devfreq15  devfreq1   passive         300000000    150000000    300000000
> soc:bus_mscl                   devfreq16  devfreq1   passive         400000000    84000000     400000000
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 65 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index acd21345a070..d7177cc0a914 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kmod.h>
>  #include <linux/sched.h>
> +#include <linux/debugfs.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> @@ -33,6 +34,7 @@
>  #define HZ_PER_KHZ	1000
>  
>  static struct class *devfreq_class;
> +static struct dentry *devfreq_debugfs;
>  
>  /*
>   * devfreq core provides delayed work based load monitoring helper
> @@ -1670,6 +1672,62 @@ static struct attribute *devfreq_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(devfreq);
>  
> +static int devfreq_summary_show(struct seq_file *s, void *data)
> +{
> +	struct devfreq *devfreq;
> +	struct devfreq *parent_devfreq;
> +	unsigned long cur_freq, min_freq, max_freq;
> +
> +	seq_printf(s, "%-30s %-10s %-10s %-15s %-12s %-12s %-12s\n",
> +			"dev name",
> +			"dev",
> +			"parent dev",
> +			"governor",
> +			"cur_freq",
> +			"min_freq",
> +			"max_freq");
> +	seq_printf(s, "%-30s %-10s %-10s %-15s %-12s %-12s %-12s\n",
> +			"------------------------------",
> +			"----------",
> +			"----------",
> +			"---------------",
> +			"------------",
> +			"------------",
> +			"------------");
> +
> +	mutex_lock(&devfreq_list_lock);
> +

The 0day team has been doing builds with Clang and it pointed out that
when CONFIG_DEVFREQ_GOV_PASSIVE is unset, parent_devfreq is always
uninitialized. The else branch should probably be eliminated, moving the
parent_devfreq NULL initialization above the if preprocessor directive.

The full report is below.

> +	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
> +#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
> +							DEVFREQ_NAME_LEN)) {
> +			struct devfreq_passive_data *data = devfreq->data;
> +			parent_devfreq = data->parent;
> +		} else {
> +			parent_devfreq = NULL;
> +		}
> +#endif
> +		mutex_lock(&devfreq->lock);
> +		cur_freq = devfreq->previous_freq,
> +		get_freq_range(devfreq, &min_freq, &max_freq);
> +		mutex_unlock(&devfreq->lock);
> +
> +		seq_printf(s, "%-30s %-10s %-10s %-15s %-12ld %-12ld %-12ld\n",
> +			dev_name(devfreq->dev.parent),
> +			dev_name(&devfreq->dev),
> +			parent_devfreq ? dev_name(&parent_devfreq->dev) : "",
> +			devfreq->governor_name,
> +			cur_freq,
> +			min_freq,
> +			max_freq);
> +	}
> +
> +	mutex_unlock(&devfreq_list_lock);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
> +
>  static int __init devfreq_init(void)
>  {
>  	devfreq_class = class_create(THIS_MODULE, "devfreq");
> @@ -1686,6 +1744,13 @@ static int __init devfreq_init(void)
>  	}
>  	devfreq_class->dev_groups = devfreq_groups;
>  
> +	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
> +	if (PTR_ERR(devfreq_debugfs) != -ENODEV && IS_ERR(devfreq_debugfs))
> +		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);
> +
> +	debugfs_create_file("devfreq_summary", 0444, devfreq_debugfs, NULL,
> +			&devfreq_summary_fops);
> +
>  	return 0;
>  }
>  subsys_initcall(devfreq_init);
> -- 
> 2.17.1
> 

Cheers,
Nathan

On Thu, Dec 26, 2019 at 11:47:26PM +0800, kbuild test robot wrote:
> CC: kbuild-all@lists.01.org
> In-Reply-To: <20191226060749.13881-1-cw00.choi@samsung.com>
> References: <20191226060749.13881-1-cw00.choi@samsung.com>
> TO: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Hi Chanwoo,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linux/master]
> [also build test WARNING on linus/master v5.5-rc3 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Chanwoo-Choi/PM-devfreq-Add-debugfs-support-with-devfreq_summary-file/20191226-140227
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1522d9da40bdfe502c91163e6d769332897201fa
> config: arm64-defconfig (attached as .config)
> compiler: clang version 10.0.0 (git://gitmirror/llvm_project c5b4a2386b51a18daad7e42040c685c2e9708c47)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/devfreq/devfreq.c:1653:4: warning: variable 'parent_devfreq' is uninitialized when used here [-Wuninitialized]
>                            parent_devfreq ? dev_name(&parent_devfreq->dev) : "",
>                            ^~~~~~~~~~~~~~
>    drivers/devfreq/devfreq.c:1613:32: note: initialize the variable 'parent_devfreq' to silence this warning
>            struct devfreq *parent_devfreq;
>                                          ^
>                                           = NULL
>    1 warning generated.
> 
> vim +/parent_devfreq +1653 drivers/devfreq/devfreq.c
> 
>   1609	
>   1610	static int devfreq_summary_show(struct seq_file *s, void *data)
>   1611	{
>   1612		struct devfreq *devfreq;
>   1613		struct devfreq *parent_devfreq;
>   1614		unsigned long cur_freq, min_freq, max_freq;
>   1615	
>   1616		seq_printf(s, "%-30s %-10s %-10s %-15s %-12s %-12s %-12s\n",
>   1617				"dev name",
>   1618				"dev",
>   1619				"parent dev",
>   1620				"governor",
>   1621				"cur_freq",
>   1622				"min_freq",
>   1623				"max_freq");
>   1624		seq_printf(s, "%-30s %-10s %-10s %-15s %-12s %-12s %-12s\n",
>   1625				"------------------------------",
>   1626				"----------",
>   1627				"----------",
>   1628				"---------------",
>   1629				"------------",
>   1630				"------------",
>   1631				"------------");
>   1632	
>   1633		mutex_lock(&devfreq_list_lock);
>   1634	
>   1635		list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
>   1636	#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>   1637			if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
>   1638								DEVFREQ_NAME_LEN)) {
>   1639				struct devfreq_passive_data *data = devfreq->data;
>   1640				parent_devfreq = data->parent;
>   1641			} else {
>   1642				parent_devfreq = NULL;
>   1643			}
>   1644	#endif
>   1645			mutex_lock(&devfreq->lock);
>   1646			cur_freq = devfreq->previous_freq,
>   1647			get_freq_range(devfreq, &min_freq, &max_freq);
>   1648			mutex_unlock(&devfreq->lock);
>   1649	
>   1650			seq_printf(s, "%-30s %-10s %-10s %-15s %-12ld %-12ld %-12ld\n",
>   1651				dev_name(devfreq->dev.parent),
>   1652				dev_name(&devfreq->dev),
> > 1653				parent_devfreq ? dev_name(&parent_devfreq->dev) : "",
>   1654				devfreq->governor_name,
>   1655				cur_freq,
>   1656				min_freq,
>   1657				max_freq);
>   1658		}
>   1659	
>   1660		mutex_unlock(&devfreq_list_lock);
>   1661	
>   1662		return 0;
>   1663	}
>   1664	DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
>   1665	
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 
