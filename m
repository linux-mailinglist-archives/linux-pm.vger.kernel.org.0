Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9487C6A6B5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 12:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbfGPKn7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 06:43:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33936 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733164AbfGPKn7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 06:43:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so19451166ljg.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FnTfXGgjsLntS6jMo62yzl6Vn1EtGc1DavczK9ylaTg=;
        b=jHXFcCg5eMxU9fvvATy+HY8vK6OGkZoncERbEqWIX438Er7GL7G1sc7wTc9eC0T/7y
         tKNUGVP5SaCTkDkhNlhY2rfVXSDClMj9GcCJXTPyIgwUF3pdtizk9Ufe3c4sbdIdUtOD
         EOrgMCId1bCsWIe0H/zFann9m1M7rTbV+cgxnrs6T1UiDMLXwqeigxLHvHHLgLpmpHF3
         +xJ7As78LQoPBGkZ0hv2qrsBVTRdzcniNI3fjTmn7XHgZLF5sFeFYYRM9o1wk7kUmNjS
         Zcy9DLu2qcM3WYEHgx4gQ3VMRKpDPjJzrI7Mi0n4lfZ0mKr0Skc0ZHvyrUISPmzZvaF8
         jR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FnTfXGgjsLntS6jMo62yzl6Vn1EtGc1DavczK9ylaTg=;
        b=CoEvMXegIfsaZ0v0VWUoQR6mAPelolpoAt4M/8DvkW3qp2LLlFzmfWZhRj4vDB9Of0
         gYEXPBiDMeL+3DnmvRp0oXQrqtzSf7pSQF2yXAmI/1FzQi+YE9RDWSy8YbGQEQTR5Qt5
         kR11DfiXhIG7tXiwzAPG6B/n7tHDsfb12iz7Y6qLtMKpwnv4PdGmc+Jzr4GJjf+HbJ6y
         dirAOrLRqB+NjC+Gd/HwMOYoTBpgTEwgoA9EwIV6FsNntCGL7HmjrYATW64RLqgh+FfR
         AvtvY5eY5MLgQaAGurU++r2A4vSAoggbvMh02ny/qZmLlKD0S26l5WtBDN0a1veZcVXx
         an2Q==
X-Gm-Message-State: APjAAAVzTcKdPoHK4aY4XFPcu2mMn2k1A08gM0/uyXvbYFpQwnlJXN1Q
        Td1eli6AJ7v+QDR9cKz++lNs8A==
X-Google-Smtp-Source: APXvYqwrjsaHjjWEhxg9mvVXCnV8LgsPfXPdkWh4OMeVg0WuJU792Pm3t0xS4HUeqUeuo3TGp+m9xw==
X-Received: by 2002:a2e:6348:: with SMTP id x69mr17264128ljb.186.1563273836873;
        Tue, 16 Jul 2019 03:43:56 -0700 (PDT)
Received: from centauri (ua-83-226-229-61.bbcust.telenor.se. [83.226.229.61])
        by smtp.gmail.com with ESMTPSA id b192sm2748745lfg.75.2019.07.16.03.43.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 03:43:56 -0700 (PDT)
Date:   Tue, 16 Jul 2019 12:43:54 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Return genpd virtual devices from
 dev_pm_opp_attach_genpd()
Message-ID: <20190716104354.GA13780@centauri>
References: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 08, 2019 at 11:30:11AM +0530, Viresh Kumar wrote:
> The cpufreq drivers don't need to do runtime PM operations on the
> virtual devices returned by dev_pm_domain_attach_by_name() and so the
> virtual devices weren't shared with the callers of
> dev_pm_opp_attach_genpd() earlier.
> 
> But the IO device drivers would want to do that. This patch updates the
> prototype of dev_pm_opp_attach_genpd() to accept another argument to
> return the pointer to the array of genpd virtual devices.
> 
> Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> @Rajendra: Can you please test this one ? I have only compile tested it.
> 
>  drivers/opp/core.c     | 5 ++++-
>  include/linux/pm_opp.h | 4 ++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2958cc7bbb58..07b6f1187b3b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1775,6 +1775,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>   * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
>   * @dev: Consumer device for which the genpd is getting attached.
>   * @names: Null terminated array of pointers containing names of genpd to attach.
> + * @virt_devs: Pointer to return the array of virtual devices.
>   *
>   * Multiple generic power domains for a device are supported with the help of
>   * virtual genpd devices, which are created for each consumer device - genpd
> @@ -1789,7 +1790,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>   * This helper needs to be called once with a list of all genpd to attach.
>   * Otherwise the original device structure will be used instead by the OPP core.
>   */
> -struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
> +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
> +		const char **names, struct device ***virt_devs)
>  {
>  	struct opp_table *opp_table;
>  	struct device *virt_dev;
> @@ -1850,6 +1852,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
>  		name++;
>  	}
>  
> +	*virt_devs = opp_table->genpd_virt_devs;

Could we perhaps only do this if (virt_devs), that way callers can send in
NULL if they don't care about the genpd virtual devices.

Kind regards,
Niklas

>  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
>  
>  	return opp_table;
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index be570761b77a..7c2fe2952f40 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -131,7 +131,7 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
>  void dev_pm_opp_put_clkname(struct opp_table *opp_table);
>  struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
>  void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
> -struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
> +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
>  void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
>  int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
> @@ -295,7 +295,7 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
>  
>  static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
>  
> -static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
> +static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs)
>  {
>  	return ERR_PTR(-ENOTSUPP);
>  }
> -- 
> 2.21.0.rc0.269.g1a574e7a288b
> 
