Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D98C71587
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 11:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGWJxV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 05:53:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42898 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbfGWJxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 05:53:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so18868757pff.9
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wxAKjAu/+mN6d743LHf4H6YA8TBDV51KnDFYD4mHasM=;
        b=o/mAhl7jh1UIZHp1XTLOmf3rfByQ1xD3Uzxkpc/M/JopfB901CPWQKBe0Eif7Ibl+W
         TLo/TSAvyNmlD+2bwXzz/FiKdYyaz2YgosyePDVHRZ7aPQMkNSS/1zJU5ED+BbYKdUCU
         B3pE25F2SL5G2xVWxK9yK3zmrBHWHF0MsT/aKZqcsrPF7uL8GJ1DjyOgtyyu+qZMdSYE
         TpzVMyHgjy0GiKYnikFceulv1Hpp0q7m0SaMEnZdFjFMh1NlcRIGDmpreUwbvPqSSNHp
         Nxj8DIHlMFCS3nPMid727eHmsjVuBlGH11Pj4N7VVaNzr0Q1Mp3gUviOgfJMxX2DSvRQ
         XWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wxAKjAu/+mN6d743LHf4H6YA8TBDV51KnDFYD4mHasM=;
        b=tyR1xrzt1MpBjKJKC0t5rGA4szTl1crBedB64aW34VoNtzYFQbWQLS/fVuzk0sW2tc
         P3kiYXKbMFubYeTfCAEnKAO5GSNwGe9mYJpO7QVODWHh85eDTkev3GuqE/PncYLqlRtx
         bo/EkmLfUYgG+VpyofTBTmWrIPENvQ18WnUnSErEl5xbCvId4vtKx4ipUvORMmwl1kNe
         SYZCHQ7s0OyuBCfdxq2cBZjw2kTDrLdCuJxwiG3Ex7EVftvi8aoxd6Dgzx0O5XGK2NLD
         Eva2e3GsEWZ5r4P3UmJMZgfJ8y4+v7bQegoZ1F+84suGRq84WDNO3WihSyPVVRtjSOk9
         F4OA==
X-Gm-Message-State: APjAAAXPgOid6zIbQDOkvYjOl57cMeK+f7oVsaogMtHd/1TJ8XGSo3cZ
        +JKGGpcWfjakW+aqOKfiFqV83g==
X-Google-Smtp-Source: APXvYqxv5Cqk6GS06ASEcJWpNdpfMCongDlWJndKSh3rpy8p/fDB+DMskYKMH8NIIq6ysBxa43fabw==
X-Received: by 2002:a17:90a:ab01:: with SMTP id m1mr78299466pjq.69.1563875600379;
        Tue, 23 Jul 2019 02:53:20 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id r61sm55682863pjb.7.2019.07.23.02.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 02:53:18 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:23:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] OPP: Add function to look up required OPP's for a
 given OPP
Message-ID: <20190723095316.t5ltprixxd5veuj7@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717222340.137578-3-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-07-19, 15:23, Saravana Kannan wrote:
> Add a function that allows looking up required OPPs given a source OPP
> table, destination OPP table and the source OPP.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 11 +++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 438fcd134d93..72c055a3f6b7 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1883,6 +1883,60 @@ void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
>  
> +/**
> + * dev_pm_opp_xlate_opp() - Find required OPP for src_table OPP.
> + * @src_table: OPP table which has dst_table as one of its required OPP table.
> + * @dst_table: Required OPP table of the src_table.
> + * @pstate: OPP of the src_table.

You should use @ before parameters in the comments as well ? Just like
you did that below.

> + *
> + * This function returns the OPP (present in @dst_table) pointed out by the
> + * "required-opps" property of the OPP (present in @src_table).
> + *
> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> + * use.
> + *
> + * Return: destination table OPP on success, otherwise NULL on errors.
> + */
> +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,

Please name it dev_pm_opp_xlate_required_opp().

> +					struct opp_table *dst_table,
> +					struct dev_pm_opp *src_opp)
> +{
> +	struct dev_pm_opp *opp, *dest_opp = NULL;
> +	int i;
> +
> +	if (!src_table || !dst_table || !src_opp)
> +		return NULL;
> +
> +	for (i = 0; i < src_table->required_opp_count; i++) {
> +		if (src_table->required_opp_tables[i]->np == dst_table->np)

Why can't we just compare the table pointers instead ? Yeah, I know
that's how I wrote that in the other xlate function, but I am confused
now :)

> +			break;
> +	}
> +
> +	if (unlikely(i == src_table->required_opp_count)) {
> +		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> +		       __func__, src_table, dst_table);
> +		return NULL;
> +	}
> +
> +	mutex_lock(&src_table->lock);
> +
> +	list_for_each_entry(opp, &src_table->opp_list, node) {
> +		if (opp == src_opp) {
> +			dest_opp = opp->required_opps[i];
> +			dev_pm_opp_get(dest_opp);
> +			goto unlock;
> +		}
> +	}
> +
> +	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
> +	       dst_table);
> +
> +unlock:
> +	mutex_unlock(&src_table->lock);
> +
> +	return dest_opp;
> +}
> +
>  /**
>   * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
>   * @src_table: OPP table which has dst_table as one of its required OPP table.
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index af5021f27cb7..36f52b9cf24a 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -131,6 +131,9 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
>  struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
>  void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
>  int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
> +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
> +					struct opp_table *dst_table,
> +					struct dev_pm_opp *src_opp);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
>  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
> @@ -304,6 +307,14 @@ static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table
>  	return -ENOTSUPP;
>  }
>  
> +static inline struct dev_pm_opp *dev_pm_opp_xlate_opp(
> +						struct opp_table *src_table,
> +						struct opp_table *dst_table,
> +						struct dev_pm_opp *src_opp)
> +{
> +	return NULL;
> +}
> +

Keep the order of declaring routines same, so this goes before the
other xlate routine.

>  static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  {
>  	return -ENOTSUPP;
> -- 
> 2.22.0.510.g264f2c817a-goog

-- 
viresh
