Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0424133311
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 22:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgAGVQI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 16:16:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45611 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbgAGVQC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 16:16:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so465341pfg.12
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2020 13:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aH3BVcM50df5G1nQCXtC0QKONcgriIhHLD8BWRsnpVk=;
        b=nET9u1hvWGviYYJ+/wTZQ2eFsZRKBNliZfmQXXO3ZptiJuiksmoXEXDBz/bDVwQt80
         HFDli5ZYHMREC9aNjKyxr7RnwbxZ8/bHjW5gb/W3Xmxj3w6163iW6m2PWoWL2HQ3L2gn
         YwutCfKQBrUM+4ojgdOgUIXkkXHbl+GL0MT41zdqnbkssW/i+4FHLzVEvYOs+6NDTPTf
         mZvgpkRqS/wZOflWMcF3CFZpJXz3BEUoV0gzARxmbF5tZSOprJnG3eeg6/ldQDLKYQAq
         H8mbDgem9xa/SuL+lzPiDlA3OiNLXSns8rvwSkBt/Ou4zD+Qg4Tfl+H0Y/14qkf0rsHE
         9vRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aH3BVcM50df5G1nQCXtC0QKONcgriIhHLD8BWRsnpVk=;
        b=ACEcvm6U/pK+sqDGJPb3Vvz8vsaWnU3NnekR70jsPgmeVS/zzxDf8jSxzGXJexXie9
         tydfKuRoFWObk1nV5+lcnw70ifmXZusINuz1XkW/bI9PCkrO3I1N9MHlaQ3Jks3NguWl
         UQuMf6sWDfb/X6LaysVrNBKk8FhCxqDRvAMQYDOQ7qkgmwu544bwzG8eJ6GwGY8Fe87Q
         krCL0hCcN6yLUs8hvj5KNOV3HSeAhZE75oK8PM6cfbm9q0LwN9cEmf+TSQ6JAqpepiXn
         o+ZyUfoLNkgssMS0xKxrBEI45i/w4vev2lKd4tq4a6fT054fXn93Dakqan/HEZlhkX2w
         eNiQ==
X-Gm-Message-State: APjAAAUFwdgc0HMtpCDVviSkCYPcpHDBog2lSVXKqToPqCMrex7FB44V
        87N0yVwlHkeIXb1M4CnxN9ogHQ==
X-Google-Smtp-Source: APXvYqwKI2P9klMDEXPPIFpXdnapCHhs8o+rT/bfatbGhOdHFU+rXR5KH0IGNTSGWwHYzsC85KcBdw==
X-Received: by 2002:a63:a019:: with SMTP id r25mr1467077pge.400.1578431761548;
        Tue, 07 Jan 2020 13:16:01 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f81sm482916pfa.118.2020.01.07.13.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:16:00 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:15:58 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, jcrouse@codeaurora.org,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Subject: Re: [PATCH 1/2] PM / devfreq: Add debugfs support with
 devfreq_summary file
Message-ID: <20200107211558.GA738324@yoga>
References: <20200107090519.3231-1-cw00.choi@samsung.com>
 <CGME20200107085812epcas1p12121f8ef6492ed78053dea4977216788@epcas1p1.samsung.com>
 <20200107090519.3231-2-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107090519.3231-2-cw00.choi@samsung.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:

> Add debugfs interface to provide debugging information of devfreq device.
> It contains 'devfreq_summary' entry to show the summary of registered
> devfreq devices as following and the additional debugfs file will be added.
> - /sys/kernel/debug/devfreq/devfreq_summary
> 
> [Detailed description of each field of 'devfreq_summary' debugfs file]
> - dev_name	: Device name of h/w.
> - dev		: Device name made by devfreq core.
> - parent_dev	: If devfreq device uses the passive governor,
> 		  show parent devfreq device name.
> - governor	: Devfreq governor.
> - polling_ms	: If devfreq device uses the simple_ondemand governor,
> 		  polling_ms is necessary for the period. (unit: millisecond)
> - cur_freq_hz	: Current Frequency (unit: hz)
> - old_freq_hz	: Frequency before changing. (unit: hz)
> - new_freq_hz	: Frequency after changed. (unit: hz)
> 
> [For example on Exynos5422-based Odroid-XU3 board]
> - In order to show the multiple governors on devfreq_summay result,
> change the governor of devfreq0 from simple_ondemand to userspace.
> 
> $ cat /sys/kernel/debug/devfreq/devfreq_summary
> dev_name                       dev        parent_dev governor        polling_ms cur_freq_hz  min_freq_hz  max_freq_hz
> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
> 10c20000.memory-controller     devfreq0              userspace       0          206000000    165000000    825000000
> soc:bus_wcore                  devfreq1              simple_ondemand 50         532000000    88700000     532000000
> soc:bus_noc                    devfreq2   devfreq1   passive         0          111000000    66600000     111000000
> soc:bus_fsys_apb               devfreq3   devfreq1   passive         0          222000000    111000000    222000000
> soc:bus_fsys                   devfreq4   devfreq1   passive         0          200000000    75000000     200000000
> soc:bus_fsys2                  devfreq5   devfreq1   passive         0          200000000    75000000     200000000
> soc:bus_mfc                    devfreq6   devfreq1   passive         0          333000000    83250000     333000000
> soc:bus_gen                    devfreq7   devfreq1   passive         0          266000000    88700000     266000000
> soc:bus_peri                   devfreq8   devfreq1   passive         0          66600000     66600000     66600000
> soc:bus_g2d                    devfreq9   devfreq1   passive         0          0            83250000     333000000
> soc:bus_g2d_acp                devfreq10  devfreq1   passive         0          0            66500000     266000000
> soc:bus_jpeg                   devfreq11  devfreq1   passive         0          0            75000000     300000000
> soc:bus_jpeg_apb               devfreq12  devfreq1   passive         0          0            83250000     166500000
> soc:bus_disp1_fimd             devfreq13  devfreq1   passive         0          0            120000000    200000000
> soc:bus_disp1                  devfreq14  devfreq1   passive         0          0            120000000    300000000
> soc:bus_gscl_scaler            devfreq15  devfreq1   passive         0          0            150000000    300000000
> soc:bus_mscl                   devfreq16  devfreq1   passive         0          0            84000000     666000000

This looks quite useful.

> 
> Reported-by: kbuild test robot <lkp@intel.com>

May I ask how the build test robot came up with this idea?

> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 80 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
[..]
> +/**
> + * devfreq_summary_show() - Show the summary of the registered devfreq devices
> + *				via 'devfreq_summary' debugfs file.

Please make this proper kerneldoc, i.e:

 * func() - short description
 * @s:
 * @data:
 * 
 * Long description
 * 
 * Return: foo on bar

[..]
> @@ -1733,6 +1803,16 @@ static int __init devfreq_init(void)
>  	}
>  	devfreq_class->dev_groups = devfreq_groups;
>  
> +	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
> +	if (PTR_ERR(devfreq_debugfs) != -ENODEV && IS_ERR(devfreq_debugfs)) {

Don't PTR_ERR() before IS_ERR().

> +		devfreq_debugfs = NULL;

I don't think you need this, given that debugfs_create_file() will fail
gracefully when passed and IS_ERR()

> +		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);

Afaict debugfs_create_() won't fail without printing a message already.

> +	} else {
> +		debugfs_create_file("devfreq_summary", 0444,
> +				devfreq_debugfs, NULL,
> +				&devfreq_summary_fops);
> +	}
> +
>  	return 0;
>  }
>  subsys_initcall(devfreq_init);

Regards,
Bjorn
