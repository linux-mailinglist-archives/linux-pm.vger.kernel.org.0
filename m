Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37F62B673A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 15:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgKQORd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 09:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgKQORc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 09:17:32 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C583C0613CF;
        Tue, 17 Nov 2020 06:17:32 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id x9so24435722ljc.7;
        Tue, 17 Nov 2020 06:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q2TfPNwbFsY7QYd8sTzRZEObhYP03ZOzna0totkapw8=;
        b=tpbjSkvU+/U5bphneMP5zx1QauR++bqzsNpKNWwGkCa+PufVLU6GU2WjJ9CT9ETQLG
         Qr6LmuKTCBC4gjIM9iQ45WLnY6WugGpP7V0JhxxL+f3xrcC+yT2Tc6dwG1BEPQK7Ffbq
         2fUN+9u4h3aF5li4Lrb6Yzcbeurz6YqqGo3uq4IyMd8C5RcNn1cX5SGIiEdz38rmRftB
         jWb011jbyhiyX0Ekj6ReRtAcUXsnnaNzHyMougSnniv5DqFm0paq7PSsVfMnDEZ6bYDr
         hjahkG3/GVm95dt2nJFJnFel61dr9CMeRWr6cZmgn/m7peRvbeMxTm5t31eK9ckl4Oar
         vfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q2TfPNwbFsY7QYd8sTzRZEObhYP03ZOzna0totkapw8=;
        b=MKULtg6h88rLP2SyY9DKNWk5xgsZ0AaHxKczOhN4iS3lpPQKOJVnWPUtLI6IOZi79T
         X1EaMPKiP24E9oHfTRNzKYH9D3Cbf5Fv3yhRqcpfbC5/FdXglRV/C0AIHIz6a2BfiKVC
         neWPcwIh+pn/n1LRWdmR0pgqu2MibryPfZF7lbKxR5U2vQgyY5k9dwNAPCe313zjA87f
         qEGUuR0Qcl7/OBivUqXLlD6Qmlx4hFw8FU2tCbW9N76/hwtyJw6lJ9Z2ypq8c6twHXIF
         pTMsSEpArBldOTIXe3zquGxqkv2LSg57vP4ttDORytvnCg8bts8yisFeKonId7nyYQ7u
         eRYA==
X-Gm-Message-State: AOAM531s+MrBy7COsYfNp9NloHKE74kIoz5QDFHCTn9DFWVcaiVuzbOM
        69bRHPjdR3fM6Xtzc009UTE=
X-Google-Smtp-Source: ABdhPJxSxv4CgsznF1M5m0HlswEk+5u5gaPfsgzrL0V1ke3IMer28jKI+apmnEdu3Hxzfog3p84yag==
X-Received: by 2002:a2e:b164:: with SMTP id a4mr1931742ljm.115.1605622650853;
        Tue, 17 Nov 2020 06:17:30 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id u12sm3170887lfm.39.2020.11.17.06.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 06:17:29 -0800 (PST)
Subject: Re: [PATCH v9 07/17] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201115212922.4390-1-digetx@gmail.com>
 <20201115212922.4390-8-digetx@gmail.com>
 <20201117100705.i62qr4gosvu76o22@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <956315a9-e806-3b18-6792-f01057a6c511@gmail.com>
Date:   Tue, 17 Nov 2020 17:17:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201117100705.i62qr4gosvu76o22@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

17.11.2020 13:07, Viresh Kumar пишет:
> On 16-11-20, 00:29, Dmitry Osipenko wrote:
>> This patch moves ACTMON driver away from generating OPP table by itself,
>> transitioning it to use the table which comes from device-tree. This
>> change breaks compatibility with older device-trees in order to bring
>> support for the interconnect framework to the driver. This is a mandatory
>> change which needs to be done in order to implement interconnect-based
>> memory DVFS. Users of legacy device-trees will get a message telling that
>> theirs DT needs to be upgraded. Now ACTMON issues memory bandwidth request
>> using dev_pm_opp_set_bw(), instead of driving EMC clock rate directly.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 86 ++++++++++++++++---------------
>>  1 file changed, 44 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 38cc0d014738..ed6d4469c8c7 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -19,6 +19,8 @@
>>  #include <linux/reset.h>
>>  #include <linux/workqueue.h>
>>  
>> +#include <soc/tegra/fuse.h>
>> +
>>  #include "governor.h"
>>  
>>  #define ACTMON_GLB_STATUS					0x0
>> @@ -155,6 +157,7 @@ struct tegra_devfreq_device {
>>  
>>  struct tegra_devfreq {
>>  	struct devfreq		*devfreq;
>> +	struct opp_table	*opp_table;
>>  
>>  	struct reset_control	*reset;
>>  	struct clk		*clock;
>> @@ -612,34 +615,19 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>  				u32 flags)
>>  {
>> -	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>> -	struct devfreq *devfreq = tegra->devfreq;
>>  	struct dev_pm_opp *opp;
>> -	unsigned long rate;
>> -	int err;
>> +	int ret;
>>  
>>  	opp = devfreq_recommended_opp(dev, freq, flags);
>>  	if (IS_ERR(opp)) {
>>  		dev_err(dev, "Failed to find opp for %lu Hz\n", *freq);
>>  		return PTR_ERR(opp);
>>  	}
>> -	rate = dev_pm_opp_get_freq(opp);
>> -	dev_pm_opp_put(opp);
>> -
>> -	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
>> -	if (err)
>> -		return err;
>> -
>> -	err = clk_set_rate(tegra->emc_clock, 0);
>> -	if (err)
>> -		goto restore_min_rate;
>>  
>> -	return 0;
>> -
>> -restore_min_rate:
>> -	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
>> +	ret = dev_pm_opp_set_bw(dev, opp);
>> +	dev_pm_opp_put(opp);
>>  
>> -	return err;
>> +	return ret;
>>  }
>>  
>>  static int tegra_devfreq_get_dev_status(struct device *dev,
>> @@ -655,7 +643,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  	stat->private_data = tegra;
>>  
>>  	/* The below are to be used by the other governors */
>> -	stat->current_frequency = cur_freq;
>> +	stat->current_frequency = cur_freq * KHZ;
>>  
>>  	actmon_dev = &tegra->devices[MCALL];
>>  
>> @@ -705,7 +693,12 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>>  		target_freq = max(target_freq, dev->target_freq);
>>  	}
>>  
>> -	*freq = target_freq;
>> +	/*
>> +	 * tegra-devfreq driver operates with KHz units, while OPP table
>> +	 * entries use Hz units. Hence we need to convert the units for the
>> +	 * devfreq core.
>> +	 */
>> +	*freq = target_freq * KHZ;
>>  
>>  	return 0;
>>  }
>> @@ -774,6 +767,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
>>  
>>  static int tegra_devfreq_probe(struct platform_device *pdev)
>>  {
>> +	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
>>  	struct tegra_devfreq_device *dev;
>>  	struct tegra_devfreq *tegra;
>>  	struct devfreq *devfreq;
>> @@ -781,6 +775,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	long rate;
>>  	int err;
>>  
>> +	/* legacy device-trees don't have OPP table and must be updated */
>> +	if (!device_property_present(&pdev->dev, "operating-points-v2")) {
>> +		dev_err(&pdev->dev,
>> +			"OPP table not found, please update your device tree\n");
>> +		return -ENODEV;
>> +	}
>> +
> 
> You forgot to remove this ?

Yes, good catch. I'm planning to replace this code with a common helper
sometime soon, so if there won't be another reasons to make a new
revision, then I'd prefer to keep it as-is for now.
