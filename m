Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04992A9042
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgKFH01 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgKFH01 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:26:27 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E72C0613CF
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 23:26:27 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so509317pfz.6
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 23:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iszUMX9XQ69DFWc+MhNBALOcQvlyTEUUCx/JW2obvyI=;
        b=jxLgNT0yJKjQKYTwXPRc+ugmIkNpIt9eh6dIyeLxG5yvVFrEmA0kiHx94esGqce6as
         vq24g9yf/g6LA5Uz4fB3sgd2pcQyuJvHX0Vb1zLc3ubJsQYZl7LxKDSXItEdR7CPHLzT
         kmIl+jiSp3z2jJyTA2cuqpU7b+nQmeO/LNGho6dhYUY4RBChpI8B5+PCC/PtaTdr5aY+
         MyUp77prU4csjw5yUVUgyT9bL2+7/ipCYPntK9j6Kzd7Kj3G1yJ+4OGFadSfpKkD61bl
         8tFAVVy/Uo1q4xcSaxJ0NznSH/VuIETWRk2vGSmYkbve6VcwSfFS96hFdWHteT7WiR6Q
         OZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iszUMX9XQ69DFWc+MhNBALOcQvlyTEUUCx/JW2obvyI=;
        b=WYtEydFSJWVlRUIatAboyRm77WSgMfzdQCtTLs3QKdI02WJfSWwhzzjw3Jh2mXizPm
         9z8NZPpPTf1PM1E+AlP4fbiRsq+jOya28I0mXuIGWfA3yZ7HUQ/IfwHqS9ug2ATF6PHT
         kjwFX9PrPaQo+8XhNHA5ssHNfY4KR66odhBsm8E8e9j6h54qHZn1mflJJx8GLqlob90/
         4xahy7YUcB7MwOifeSom0D/mSSnxv//GwZ4ZoNmrbsj1LZtXfYSoUl70H1eyrmvrwolp
         13eRbMev0115PgkXVhF+GT0aNWXFkcDV7opo2v2Bpu/Oawr/Abg3U8Z9cmPxS13RoPDp
         GM5g==
X-Gm-Message-State: AOAM5315sZavShsEj+vwwV0J9GGJrClfl3SXBlFNmJNIbq2ESdQ2JpGt
        JFzQRpdF82dZ0VtWcNQO3fXmrq9VSbwsZg==
X-Google-Smtp-Source: ABdhPJzMudjmsnAflVOqQiwenRD/t1+Dsu4JX36nuNDTRL/kpoJsTWHD7jNukonngjvlJSd5GV1NTQ==
X-Received: by 2002:a17:90a:588d:: with SMTP id j13mr1000147pji.236.1604647587117;
        Thu, 05 Nov 2020 23:26:27 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id z23sm776215pgf.12.2020.11.05.23.26.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:26:25 -0800 (PST)
Date:   Fri, 6 Nov 2020 12:56:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, robdclark@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] opp: Allocate the OPP table outside of opp_table_lock
Message-ID: <20201106072624.jfr4qloe47etzj47@vireshk-i7>
References: <ef43f01ac06976b2aa2b17266d307bb1a4f7e6f9.1604294460.git.viresh.kumar@linaro.org>
 <836b442002d598437e3e6b56d3e07087e5c08afd.1604294460.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <836b442002d598437e3e6b56d3e07087e5c08afd.1604294460.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-11-20, 10:51, Viresh Kumar wrote:
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> +/*
> + * We need to make sure that the OPP table for a device doesn't get added twice,
> + * if this routine gets called in parallel with the same device pointer.
> + *
> + * The simplest way to enforce that is to perform everything (find existing
> + * table and if not found, create a new one) under the opp_table_lock, so only
> + * one creator gets access to the same. But that expands the critical section
> + * under the lock and may end up causing circular dependencies with frameworks
> + * like debugfs, interconnect or clock framework as they may be direct or
> + * indirect users of OPP core.
> + *
> + * And for that reason we have to go for a bit tricky implementation here, which
> + * uses the opp_tables_busy flag to indicate if another creator is in the middle
> + * of adding an OPP table and others should wait for it to finish.
> + */
>  static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
>  {
>  	struct opp_table *opp_table;
>  
> -	/* Hold our table modification lock here */
> +again:
>  	mutex_lock(&opp_table_lock);
>  
>  	opp_table = _find_opp_table_unlocked(dev);
>  	if (!IS_ERR(opp_table))
>  		goto unlock;
>  
> +	/*
> +	 * The opp_tables list or an OPP table's dev_list is getting updated by
> +	 * another user, wait for it to finish.
> +	 */
> +	if (unlikely(opp_tables_busy)) {
> +		mutex_unlock(&opp_table_lock);
> +		cpu_relax();
> +		goto again;
> +	}
> +
> +	opp_tables_busy = true;
>  	opp_table = _managed_opp(dev, index);
> +
> +	/* Drop the lock to reduce the size of critical section */
> +	mutex_unlock(&opp_table_lock);
> +
>  	if (opp_table) {
>  		if (!_add_opp_dev(dev, opp_table)) {
>  			dev_pm_opp_put_opp_table(opp_table);
>  			opp_table = ERR_PTR(-ENOMEM);
>  		}
> -		goto unlock;
> +
> +		mutex_lock(&opp_table_lock);
> +	} else {
> +		opp_table = _allocate_opp_table(dev, index);
> +
> +		mutex_lock(&opp_table_lock);
> +		if (!IS_ERR(opp_table))
> +			list_add(&opp_table->node, &opp_tables);
>  	}
>  
> -	opp_table = _allocate_opp_table(dev, index);
> +	opp_tables_busy = false;

And here is a fix that will be merged with this patch while applying.  It is
required as _allocate_opp_table() (which calls _find_table_of_opp_np())  isn't
called with the opp_table_lock anymore.

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c718092757d9..6b7f0066942d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -112,8 +112,6 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
        struct opp_table *opp_table;
        struct device_node *opp_table_np;
 
-       lockdep_assert_held(&opp_table_lock);
-
        opp_table_np = of_get_parent(opp_np);
        if (!opp_table_np)
                goto err;
@@ -121,12 +119,15 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
        /* It is safe to put the node now as all we need now is its address */
        of_node_put(opp_table_np);
 
+       mutex_lock(&opp_table_lock);
        list_for_each_entry(opp_table, &opp_tables, node) {
                if (opp_table_np == opp_table->np) {
                        _get_opp_table_kref(opp_table);
+                       mutex_unlock(&opp_table_lock);
                        return opp_table;
                }
        }
+       mutex_unlock(&opp_table_lock);
 
 err:
        return ERR_PTR(-ENODEV);

-- 
viresh
