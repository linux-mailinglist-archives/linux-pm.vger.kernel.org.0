Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31179CC51
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfHZJM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:12:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46856 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbfHZJM5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 05:12:57 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 78b9c760f8ec97f3; Mon, 26 Aug 2019 11:12:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Align in-parameter names for some genpd functions
Date:   Mon, 26 Aug 2019 11:12:26 +0200
Message-ID: <21786600.6syGFu3F7C@kreacher>
In-Reply-To: <20190716094320.20091-1-ulf.hansson@linaro.org>
References: <20190716094320.20091-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, July 16, 2019 11:43:20 AM CEST Ulf Hansson wrote:
> Align in-parameter names for the declarations of pm_genpd_add|
> remove_subdomain() and of_genpd_add_subdomain() according to their
> implementations, as to improve consistency.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  include/linux/pm_domain.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 91d9bf497071..baf02ff91a31 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -197,9 +197,9 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
>  int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev);
>  int pm_genpd_remove_device(struct device *dev);
>  int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
> -			   struct generic_pm_domain *new_subdomain);
> +			   struct generic_pm_domain *subdomain);
>  int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
> -			      struct generic_pm_domain *target);
> +			      struct generic_pm_domain *subdomain);
>  int pm_genpd_init(struct generic_pm_domain *genpd,
>  		  struct dev_power_governor *gov, bool is_off);
>  int pm_genpd_remove(struct generic_pm_domain *genpd);
> @@ -226,12 +226,12 @@ static inline int pm_genpd_remove_device(struct device *dev)
>  	return -ENOSYS;
>  }
>  static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
> -					 struct generic_pm_domain *new_sd)
> +					 struct generic_pm_domain *subdomain)
>  {
>  	return -ENOSYS;
>  }
>  static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
> -					    struct generic_pm_domain *target)
> +					    struct generic_pm_domain *subdomain)
>  {
>  	return -ENOSYS;
>  }
> @@ -282,8 +282,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>  				  struct genpd_onecell_data *data);
>  void of_genpd_del_provider(struct device_node *np);
>  int of_genpd_add_device(struct of_phandle_args *args, struct device *dev);
> -int of_genpd_add_subdomain(struct of_phandle_args *parent,
> -			   struct of_phandle_args *new_subdomain);
> +int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
> +			   struct of_phandle_args *subdomain_spec);
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>  int of_genpd_parse_idle_states(struct device_node *dn,
>  			       struct genpd_power_state **states, int *n);
> @@ -316,8 +316,8 @@ static inline int of_genpd_add_device(struct of_phandle_args *args,
>  	return -ENODEV;
>  }
>  
> -static inline int of_genpd_add_subdomain(struct of_phandle_args *parent,
> -					 struct of_phandle_args *new_subdomain)
> +static inline int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
> +					 struct of_phandle_args *subdomain_spec)
>  {
>  	return -ENODEV;
>  }
> 

Applied, thanks!




