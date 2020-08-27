Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3760A254301
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgH0KBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 06:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgH0KBI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 06:01:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C77CC061264
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 03:01:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so2349717pjx.5
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVFa87Gzs3By4YvbvT0mRKBEarvG0+o1jlknOHQh1bk=;
        b=gVD9cVF/zAxIeP1DEiHgj6yUQFF+LV7qSSbBZzzKtjf8+acXK/O8DMW21WfLGW1PvL
         55bJplcY2uW0RT8/FuAZuvB/frCDSq07yGgRHakqirqysT7ouv0XPTQYLjM2y3/BZN/n
         tU8MNFIseLrjg06NOCgaMEG0U7szmIdh5LUiRUwSi9pq/QU5ur3x+mjDO4mhbhI92bZs
         V+eR862RogLZOMZBOJiW8mON1QaLKXtpeJdENV3SjZSv4UKkjIzstlwKYbgl5HDPdg1v
         4gzLxyxsYkI15HDgu5EtTraNKniO39U8cxmcxOiPgqJ+nhNmyqEkSw1kgwIM5hxD33Su
         u2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVFa87Gzs3By4YvbvT0mRKBEarvG0+o1jlknOHQh1bk=;
        b=p4b+rtZB263xNmRYxT5jRL/sp+B7FFP5iI7bbYBZ1rtNYrFvp4qGflReMEi1XiQfEJ
         4jAlPrIvSrDVzEFeLk2aKO6s0cN3UW4ZPdq9aZiDayjWEMaY19sf/IlSVI88f+C0aM0G
         /TlZMPbhOV238o1PhMp+lodw1S1P4r5x8Nfv4aTtwbHUVPkwcGTy+mxakuoi/pZpiXeQ
         AUHP34bAK7j4olRQZp0ZEOSlGAhhbApvyADGtXPoSEqQP9tN2dQPsmnOP97cW1Fx5BVL
         XqoER7o8rp5VbXfaekeTSQ9YTbp5HbySmdryPj8rTpqoddvOBcYozGlKrSwG3cB+pQtE
         h/rw==
X-Gm-Message-State: AOAM532hExiZ7sFeGYs6AiznPq0HBaJ5fT4a2uOdD5cI879wvIhn1beE
        YuhBnT7Yt4z8luHNc/oSFbUabA==
X-Google-Smtp-Source: ABdhPJxhWRorvB+gpXZ6w7wfzkzjVUNNRfP/ARhG3lJTv4BmjYQxQZRwWK9rALeVRqpF/QmbZKwOvQ==
X-Received: by 2002:a17:90a:d3d4:: with SMTP id d20mr9680860pjw.111.1598522467847;
        Thu, 27 Aug 2020 03:01:07 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id s8sm1809939pgp.36.2020.08.27.03.01.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:01:06 -0700 (PDT)
Date:   Thu, 27 Aug 2020 15:31:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH v2] opp: Power on (virtual) power domains managed by the
 OPP core
Message-ID: <20200827100104.yuf2nzb6qras7zcw@vireshk-i7>
References: <20200826093328.88268-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826093328.88268-1-stephan@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-20, 11:33, Stephan Gerhold wrote:
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 8b3c3986f589..7e53a7b94c59 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -17,6 +17,7 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include "opp.h"
> @@ -1964,10 +1965,13 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>  		if (!opp_table->genpd_virt_devs[index])
>  			continue;
>  
> +		if (opp_table->genpd_virt_links && opp_table->genpd_virt_links[index])
> +			device_link_del(opp_table->genpd_virt_links[index]);
>  		dev_pm_domain_detach(opp_table->genpd_virt_devs[index], false);
>  		opp_table->genpd_virt_devs[index] = NULL;
>  	}
>  
> +	kfree(opp_table->genpd_virt_links);
>  	kfree(opp_table->genpd_virt_devs);
>  	opp_table->genpd_virt_devs = NULL;
>  }
> @@ -1999,8 +2003,10 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>  {
>  	struct opp_table *opp_table;
>  	struct device *virt_dev;
> -	int index = 0, ret = -EINVAL;
> +	struct device_link *dev_link;
> +	int index = 0, ret = -EINVAL, num_devs;
>  	const char **name = names;
> +	u32 flags;
>  
>  	opp_table = dev_pm_opp_get_opp_table(dev);
>  	if (IS_ERR(opp_table))
> @@ -2049,6 +2055,32 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,

I was about to apply this patch when I noticed that this routine does
return the array of virtual devices back to the caller, like the qcom
cpufreq driver in this case. IIRC we did it this way as a generic
solution for this in the OPP core wasn't preferable.

And so I think again if this patch should be picked instead of letting
the platform handle this ?

-- 
viresh
