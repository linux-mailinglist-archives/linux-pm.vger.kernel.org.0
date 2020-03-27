Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60E0196185
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 23:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgC0Wxt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 18:53:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38183 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgC0Wxt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2020 18:53:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id x7so5293566pgh.5
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2020 15:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u//RFRwBb0m9lwVRnZnuN1wIsLwSxdDr93Wv4WL3gak=;
        b=sCLGEAWMh1HSvJ+QM8j2lloft3uPeNHMcMj6BmwhaTwvSP2P4K8TyvIbsSpX+ZbSQ6
         HERLK4yeWKux2ZLUriBsIVL77UetK/CkpdZTTh748tOxtGhooB5gcjlwQCggun6xvHX9
         d4EVzFEPqcWxprhJvN3A9oBIXMUz+cHkaovqJfucawus4FjC9X5GjfdcjR2J4hVl8ezd
         x/VGVaKjmWaXnxY6KQTQlBJgaxf1T3GqonDTIimI9rPYb6rHAPFd5J7IAIvTwVsZp0Tg
         YnEEmvMPcyGK9b+ts9frgqH2YOGDrb5VHekmJ1I5ZXzmQTmvnNwtxsnNi9iiosGJ63qm
         iSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u//RFRwBb0m9lwVRnZnuN1wIsLwSxdDr93Wv4WL3gak=;
        b=aTvJ8+kidmeruS54e8h++aiuTDp2txZsa8vkXzyJdTdnTuFiKgsbKifNeKHEQihxsm
         7+s5PLbn5hdumeTrFkbBmOGEi1SOjvllKY8aPPLYiFRqbhsKteYq5LFOw/li0fK1/zHq
         JDRN2nynUHXWoMreBh0+LIeu7ASmAe+s3hwp5L199n8skLRN9UkSWVKAr0nXIUNQLd1V
         3QBbXIFKMwEzRJRSPjFErM9vPZuJGuQ3ayEg94izd28HcWRCELohij8EkAvg7JlWhYO9
         wqdE8qucrmhHeB9KSdSFAcON1EbJPSk9akNcJ0iFC0wg14IsfUk/97mq0yZU+H2OmtLV
         fK2A==
X-Gm-Message-State: ANhLgQ2ycNl1gTpzZnxixPOJ669Sf+Gtsi926rn7RxF4YOaIzgLAvMo+
        kGnBvX2SlXBvtBI/jvJtjcSuiw==
X-Google-Smtp-Source: ADFU+vvmOFrFFFf0Ylaxpwo5cZwgZFAq0POqcMDvAU5keyfbpNREBBtPuvkrV6yluD9CWYp3jhMddA==
X-Received: by 2002:a63:78e:: with SMTP id 136mr1551884pgh.181.1585349628346;
        Fri, 27 Mar 2020 15:53:48 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t1sm4590766pgh.88.2020.03.27.15.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 15:53:47 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:53:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, agross@kernel.org, robh@kernel.org,
        amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v5 4/6] soc: qcom: Extend RPMh power controller driver to
 register warming devices.
Message-ID: <20200327225345.GH5063@builder>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
 <20200320014107.26087-5-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320014107.26087-5-thara.gopinath@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 19 Mar 18:41 PDT 2020, Thara Gopinath wrote:

> RPMh power control hosts power domains that can be used as
> thermal warming devices. Register these power domains
> with the generic power domain warming device thermal framework.
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v3->v4:
> 	- Introduce a boolean value is_warming_dev in rpmhpd structure to
> 	  indicate if a generic power domain can be used as a warming
> 	  device or not.With this change, device tree no longer has to
> 	  specify which power domain inside the rpmh power domain provider
> 	  is a warming device.
> 	- Move registering of warming devices into a late initcall to
> 	  ensure that warming devices are registered after thermal
> 	  framework is initialized.

This information is lost when we merge patches, as such I would like
such design decisions to be described in the commit message itself.
But...

> 
>  drivers/soc/qcom/rpmhpd.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 7142409a3b77..4e9c0bbb8826 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pd_warming.h>
>  #include <soc/qcom/cmd-db.h>
>  #include <soc/qcom/rpmh.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -48,6 +49,7 @@ struct rpmhpd {
>  	bool		enabled;
>  	const char	*res_name;
>  	u32		addr;
> +	bool		is_warming_dev;
>  };
>  
>  struct rpmhpd_desc {
> @@ -55,6 +57,8 @@ struct rpmhpd_desc {
>  	size_t num_pds;
>  };
>  
> +const struct rpmhpd_desc *global_desc;
> +
>  static DEFINE_MUTEX(rpmhpd_lock);
>  
>  /* SDM845 RPMH powerdomains */
> @@ -89,6 +93,7 @@ static struct rpmhpd sdm845_mx = {
>  	.pd = { .name = "mx", },
>  	.peer = &sdm845_mx_ao,
>  	.res_name = "mx.lvl",
> +	.is_warming_dev = true,
>  };
>  
>  static struct rpmhpd sdm845_mx_ao = {
> @@ -452,7 +457,14 @@ static int rpmhpd_probe(struct platform_device *pdev)
>  					       &rpmhpds[i]->pd);
>  	}
>  
> -	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
> +	ret = of_genpd_add_provider_onecell(pdev->dev.of_node, data);
> +
> +	if (ret)
> +		return ret;
> +
> +	global_desc = desc;
> +
> +	return 0;
>  }
>  
>  static struct platform_driver rpmhpd_driver = {
> @@ -469,3 +481,26 @@ static int __init rpmhpd_init(void)
>  	return platform_driver_register(&rpmhpd_driver);
>  }
>  core_initcall(rpmhpd_init);
> +
> +static int __init rpmhpd_init_warming_device(void)
> +{
> +	size_t num_pds;
> +	struct rpmhpd **rpmhpds;
> +	int i;
> +
> +	if (!global_desc)
> +		return -EINVAL;
> +
> +	rpmhpds = global_desc->rpmhpds;
> +	num_pds = global_desc->num_pds;
> +
> +	if (!of_find_property(rpmhpds[0]->dev->of_node, "#cooling-cells", NULL))
> +		return 0;
> +
> +	for (i = 0; i < num_pds; i++)
> +		if (rpmhpds[i]->is_warming_dev)
> +			of_pd_warming_register(rpmhpds[i]->dev, i);
> +
> +	return 0;
> +}
> +late_initcall(rpmhpd_init_warming_device);

...why can't this be done in rpmhpd_probe()?

In particular with the recent patches from John Stultz to allow rpmhpd
to be built as a module I don't think there's any guarantees that
rpmh_probe() will have succeeded before rpmhpd_init_warming_device()
executes.

Regards,
Bjorn
