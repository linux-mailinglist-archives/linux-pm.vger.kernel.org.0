Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D246FCAE06
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbfJCSTm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 14:19:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34445 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbfJCSTl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2019 14:19:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so2299671pfa.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2019 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V3zfpA6pohOCQvyvizEapVU0+r/7JkIaALQBuXL6dpc=;
        b=RYYfr/9/HTri5GnuFK4sU0LwnzxScseFLrCQRKdo8R8x6zLw+7WbCPHGjzFa3JdRYl
         icU7yPc1Jhv7lKLLzrclUV0/jLKR4YF4nfpJ8RwAjFenmzu2M5fXNAmjFIAjaZawuBUc
         z3CkbEhB2CJkLZXBXbQ0MjGvQ21yczR1w6aRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V3zfpA6pohOCQvyvizEapVU0+r/7JkIaALQBuXL6dpc=;
        b=OgIiyZGmixcD3vMlLxNL3MwiIy4B3tKV8T0cin/PBJNpQf8B9eLwf1YbeF/Odgc8RS
         ItxPrkLwSawXngye6AzUnruli1aJUg5Tnm1LWggtJ7ripVDr8RsbMWbIlv/bk2+mnc+H
         llreXvF5h8lUarficzFSaZgKlZjYUoq4IvE204EeOjXlOcPrgF7VkPcpD7Qwliw5aYF8
         1bd5rKKUVydhXYMl5PoT41ETlvrV26atRvsEpJFvPm9p1e/hLN8qdX9naDQEKCMlABzi
         B62PQeN++BNBQZuLT6n2vqUHahVRfvEquO9GBfbFDQd7uJk44T9zJHAmN5cJIyXhTULM
         ggAw==
X-Gm-Message-State: APjAAAXW7zmsZUPAuGf2Ab8rfI5SzTp4IhE5SAeL1Fs6zZoQJ3oOUHPQ
        1IQzcCRR/yEHO6K+woXFS3m8kA==
X-Google-Smtp-Source: APXvYqxAEXRIRhtV+Dp3adyBB3Odhiyb27dhM9grTiYboHDrD+loFme6hzU61w45+soIrPB+w9SPcw==
X-Received: by 2002:a62:5e42:: with SMTP id s63mr12421616pfb.96.1570126781009;
        Thu, 03 Oct 2019 11:19:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id p189sm2794942pga.2.2019.10.03.11.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 11:19:40 -0700 (PDT)
Date:   Thu, 3 Oct 2019 11:19:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 6/8] PM / devfreq: Introduce get_freq_range helper
Message-ID: <20191003181938.GJ87296@google.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <c453bb60a74b41a5192e270f286dfc81c1088449.1570044052.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c453bb60a74b41a5192e270f286dfc81c1088449.1570044052.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 10:25:09PM +0300, Leonard Crestez wrote:
> Moving handling of min/max freq to a single function and call it from
> update_devfreq and for printing min/max freq values in sysfs.
> 
> This changes the behavior of out-of-range min_freq/max_freq: clamping
> is now done at evaluation time. This means that if an out-of-range
> constraint is imposed by sysfs and it later becomes valid then it will
> be enforced.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 110 +++++++++++++++++++++-----------------
>  1 file changed, 62 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 87eff789ce24..2d63692903ff 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
>
> ...
>
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	unsigned long min_freq, max_freq;
>  
> -	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
> +	mutex_lock(&df->lock);
> +	get_freq_range(df, &min_freq, &max_freq);

With this min/max_freq shown aren't necessarily those set through sysfs,
but the aggregated PM QoS values (plus OPP constraints).

I did some testing with a WIP patch that converts devfreq_cooling.c to
PM QoS. When reading sysfs min/max values to double check the limits
set earlier I found it utterly confusing to see the sysfs min/max values
fluctuating due to thermal throttling, and not being able to see the
configured values.

Looks like cpufreq does the same, but I'm not convinced this is a good
idea. I think we want to display the values set by userspace, as done
before managing the limits through PM QoS. Viresh, was this change of
userspace visible behavior done intentionally for cpufreq?
