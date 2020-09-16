Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464C926C02B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIPJIy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 05:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIPJIx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 05:08:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F6BC061788
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 02:08:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d13so3535070pgl.6
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qwm01cIWY/VsraWej7K5Ms+WL7l4tRX3I6VJ48fegEk=;
        b=tDmtTdGvDCYHAAxoFRsjiLwoZ2x6hW6GcTNUAuD2gzS/h43T5Jar5Qcd/ILHN3l341
         HvSPahmSnAErKjQCtSEdpukGU4TmzfUOHoip+TUWCeqLSMvG7sVC/hwimZa9kltrRnbd
         quV6oJpIvvrbzF5mcH84qAe9un7bCy3onGOMAf8CnXUTecEgP9w8vbXq0PRuODLO6jFC
         J73LMTG/SILK3Y1c+0K5007taZWcPy31QWu2VCRF51+Y7+Q3iOuVp8sCDRgcAWRFvhPf
         osshUv7sxeFK39YsdYLY0Ky0EtKN+FJWAGtR+EE6QVpICFoo4Qh0bwIos6ra81kcwVAg
         xStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qwm01cIWY/VsraWej7K5Ms+WL7l4tRX3I6VJ48fegEk=;
        b=TJBbdf7rW9biCdqZ2GKrEbZ3nQJW9Ax3fAHpbk5OaqqPAla1MoVLf4Hy5omZSTwdF2
         6tnAkSfP029vQchWaFtO7juLNfUoXrxfcMl0rrxWnudsAvaxzhMeR6zijV4zu8UUxcoD
         0VK/3Ld4RIpk58ct/gi3qeWluudRLpmz1v6b6IkagZNsI9OZwNULYnBenXWsf/uZeqS9
         qp+00Q4RImS5yJJc9SHWw7KSczuh3P9zwWmBSUvdHjQ5gpAJJbGk/pqQRdjw9hJywxOH
         AAjpyNmCpxWINV2Mloaba7Zeoeh9oAgusHolv6MeOffIKeyJKrGiQcLSVWy664trpuM4
         iGoA==
X-Gm-Message-State: AOAM530pi4i1APJTzc5Tv2LpNM6kHq29n5reqAKaVPU3Y8C2Q29WPi7v
        gqp/8kSjw4x74dze6QxzMkJFGQ==
X-Google-Smtp-Source: ABdhPJxs6rsKzQ6o3iaNTmygSfIw778F1H3qX/p5YD9wMYhm5u6HZMs3NK7UuE0oCSNYZa8vbpj4Mw==
X-Received: by 2002:a63:2e42:: with SMTP id u63mr1479728pgu.292.1600247331884;
        Wed, 16 Sep 2020 02:08:51 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id y1sm13562457pgr.3.2020.09.16.02.08.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 02:08:51 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:38:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, stephan@gerhold.net,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        ulf.hansson@linaro.org
Subject: Re: [PATCH] opp: Handle multiple calls for same OPP table in
 _of_add_opp_table_v1()
Message-ID: <20200916090844.ur4ysyg57injydz5@vireshk-i7>
References: <99f1c7ff37b00d2f59fbce9d934abf23932363c5.1598956021.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99f1c7ff37b00d2f59fbce9d934abf23932363c5.1598956021.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-09-20, 15:57, Viresh Kumar wrote:
> Until now for V1 OPP bindings we used to call
> dev_pm_opp_of_cpumask_add_table() first and then
> dev_pm_opp_set_sharing_cpus() in the cpufreq-dt driver.
> 
> A later patch will though update the cpufreq-dt driver to optimize the
> code a bit and we will call dev_pm_opp_set_sharing_cpus() first followed
> by dev_pm_opp_of_cpumask_add_table(), which doesn't work well today as
> it tries to re parse the OPP entries. This should work nevertheless for
> V1 bindings as the same works for V2 bindings.
> 
> Adapt the same approach from V2 bindings and fix this.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/of.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index d8b623cc015a..6fc56660fa52 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -886,6 +886,16 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
>  	const __be32 *val;
>  	int nr, ret = 0;
>  
> +	mutex_lock(&opp_table->lock);
> +	if (opp_table->parsed_static_opps) {
> +		opp_table->parsed_static_opps++;
> +		mutex_unlock(&opp_table->lock);
> +		return 0;
> +	}
> +
> +	opp_table->parsed_static_opps = 1;
> +	mutex_unlock(&opp_table->lock);
> +
>  	prop = of_find_property(dev->of_node, "operating-points", NULL);
>  	if (!prop)
>  		return -ENODEV;
> @@ -902,10 +912,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
>  		return -EINVAL;
>  	}
>  
> -	mutex_lock(&opp_table->lock);
> -	opp_table->parsed_static_opps = 1;
> -	mutex_unlock(&opp_table->lock);
> -
>  	val = prop->value;
>  	while (nr) {
>  		unsigned long freq = be32_to_cpup(val++) * 1000;

This wasn't enough. Merged this diff as well to this patch:

 drivers/opp/of.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e72753be7dc7..aa829a569825 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -916,10 +916,14 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
        mutex_unlock(&opp_table->lock);
 
        prop = of_find_property(dev->of_node, "operating-points", NULL);
-       if (!prop)
-               return -ENODEV;
-       if (!prop->value)
-               return -ENODATA;
+       if (!prop) {
+               ret = -ENODEV;
+               goto remove_static_opp;
+       }
+       if (!prop->value) {
+               ret = -ENODATA;
+               goto remove_static_opp;
+       }
 
        /*
         * Each OPP is a set of tuples consisting of frequency and
@@ -928,7 +932,8 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
        nr = prop->length / sizeof(u32);
        if (nr % 2) {
                dev_err(dev, "%s: Invalid OPP table\n", __func__);
-               return -EINVAL;
+               ret = -EINVAL;
+               goto remove_static_opp;
        }
 
        val = prop->value;
@@ -940,12 +945,14 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
                if (ret) {
                        dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
                                __func__, freq, ret);
-                       _opp_remove_all_static(opp_table);
-                       return ret;
+                       goto remove_static_opp;
                }
                nr -= 2;
        }
 
+remove_static_opp:
+       _opp_remove_all_static(opp_table);
+
        return ret;
 }

-- 
viresh
