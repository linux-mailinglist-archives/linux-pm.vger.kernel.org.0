Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975B93276B7
	for <lists+linux-pm@lfdr.de>; Mon,  1 Mar 2021 05:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhCAEf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Feb 2021 23:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhCAEf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Feb 2021 23:35:27 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460C2C061756
        for <linux-pm@vger.kernel.org>; Sun, 28 Feb 2021 20:34:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d12so8087003pfo.7
        for <linux-pm@vger.kernel.org>; Sun, 28 Feb 2021 20:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i9osdsSIkxdstrMXBrLYm99WRkbkxANC4iCZNYOVSSg=;
        b=gw7NyoPFNgY8PsipPfcdpS5Dvq6DCvUvZC/Zu7eGLdmROfBBAvjceQdCtYjjU02I8W
         UDpp3JnwhLhSg3zuyPDL1/T6f+EKpoEiBenaEy4Ew/dfE9ciaFJFThiURSj5a6SYlmc/
         N6WAzxkHla2hMySo6m5Tau4jyHVDyWo+V2n4EgufslgxZgXF81y/qjK/YJOhxfGrAjZC
         znmZp5pJetDv21bfkrRmPKw+05pGfSru+TSNfrGRmwc/xwnluNQVqK5v8nET4YqaCqXX
         6aOd6rv31602Eq7w7nMF19qxMYIFe6915IiunIMH1bq7tComEzxEfcRpFiUwRbn92wjb
         8VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i9osdsSIkxdstrMXBrLYm99WRkbkxANC4iCZNYOVSSg=;
        b=MmQ2yVdkHn3IiEVU1dXKGle7Inzuu5gAQPlOyw4we5+XOGanWondPyD3bEBl69j0/I
         uIfLfGYv8OUZaQeqQ8CBjjyyAK/AMLskw1je1Oe/byIWA9rPT+ZsgIEbzDHq6NqvhECw
         vLwCBk5htiv1bRTA8VMJnC4w/W+8eHpaJclcrBufdzuq8bOVhTKJJF7E+npiVVs6ERYC
         uOIbB31jEtcUpgAW99VUqzK55mHL0fz8W0HU576qmzUhz5vGsot1G6DEscVDAOmcC3Il
         wG55ivMGd7d8Gebmxrq6gdC2lF+4O8HnFQR+jd8s7fgQ85NxKQFeVzcXGQR0C0pLwgcK
         +pGg==
X-Gm-Message-State: AOAM5325vjP7ECvXRFsNDJsTZRKBv/6byX2IugTftkm2JBnix6z/bQsD
        7IA8tZhlvo4cGRyXvHBo6Ka5zA==
X-Google-Smtp-Source: ABdhPJyQ5HWnkD2hBCmKGlP5HS2VTvNWDNjZBe7FXjNYQ0jaoIUvqwaRsOvzNQsLismU3TppWAQ5AA==
X-Received: by 2002:aa7:8ad0:0:b029:1ed:fb30:e5d5 with SMTP id b16-20020aa78ad00000b02901edfb30e5d5mr13667116pfd.79.1614573286763;
        Sun, 28 Feb 2021 20:34:46 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id c6sm16496906pfc.94.2021.02.28.20.34.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Feb 2021 20:34:46 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:04:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: fix dereferencing freed memory 'data'
Message-ID: <20210301043444.rbuauzhiu4n6nkay@vireshk-i7>
References: <20210228013319.10469-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210228013319.10469-1-shawn.guo@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-02-21, 09:33, Shawn Guo wrote:
> Commit 67fc209b527d ("cpufreq: qcom-hw: drop devm_xxx() calls from
> init/exit hooks") introduces an issue of dereferencing freed memory
> 'data'.  Fix it.
> 
> Fixes: 67fc209b527d ("cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Viresh,
> 
> The issue was introduced by v2 of "cpufreq: qcom-hw: drop devm_xxx()
> calls from init/exit hooks", which misses the conversion of 'data->base'
> in error path.  Sorry!
> 
> Shawn
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d3c23447b892..bee5d67a8227 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -374,7 +374,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  error:
>  	kfree(data);
>  unmap_base:
> -	iounmap(data->base);
> +	iounmap(base);
>  release_region:
>  	release_mem_region(res->start, resource_size(res));
>  	return ret;

Applied. Thanks.
-- 
viresh
