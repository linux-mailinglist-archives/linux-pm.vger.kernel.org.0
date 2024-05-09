Return-Path: <linux-pm+bounces-7684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83B8C0FAC
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FE41C20ED8
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2783A130E2C;
	Thu,  9 May 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="2WeLbyJ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8914A90;
	Thu,  9 May 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258112; cv=none; b=QCBKxZFOPiBuf5X231M6/2t0OZfv+jtq6kiFpzUQSYUDQX3iNYTfkEm/4QcYBmSZQPPydXI5g1JBtOsE9vAZtAMLASC6LF3PuHqtLtpymFL44azq7zlDthp7Me+6kKe+3jhDzvhY8hC5Eij2YtP9+MA2Hf2pNjXAhYDXenjOvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258112; c=relaxed/simple;
	bh=I66ut8+KtUA6Bv3Xqx+VAizz2te0CAi50j3/JmvvNpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqiA64STSGCBzbaHOnofLHMtv9AvumsJieV3Mp8bvuy7j1e8xnWHHA7WvEGgEJVYHcEpFbWdvxvPaZlworU/NIKtJPWp9YZqSzXT48jPxPLlm4Cdq8CCX2fa8d4BderAVeWFo+5/0aax3QYVAo4wkozWAMJjc/1CdJNdytsnxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=2WeLbyJ2; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=SmlbI/FlmmuHIPcswkddkrEGDrmDZVS/Ndo9dCDCyeA=; t=1715258110;
	x=1715690110; b=2WeLbyJ2V1sI3RvSCn0Ay912av3FzAmVCb6XXIeSU0BAy8mSkmlxgMx7IHRix
	8NYit9qKEDou6zmmCHqJSh2u6VY9zo2x/h2p9gaouBF+79mjluPgVsKT0KH8/G05YBSoVJWdTKgu9
	ZFGmqbcmo2sYmcix4IDl06T24JO23zpL0aoDPxt1SWmEp8zTozljcLukuft1iMYxf3uO5FKUGioCl
	YjHpkaQ9Dq4nFrn4duQqgihIpq9qypsClKY0PKFzwAnVBVK3J3vUZoXBSVfXTqHz2oAdI79yokVW3
	tepbs/8bsQOIv3mJ1X3t7ftsTrpfYc3QHJ+NTzWa/+P2SF2TUA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s52zK-0006Xy-8j; Thu, 09 May 2024 14:35:06 +0200
Message-ID: <e6fc06eb-fe52-4cb3-b412-a602369ee875@leemhuis.info>
Date: Thu, 9 May 2024 14:35:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] OPP: Fix required_opp_tables for multiple genpds using
 same table
To: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Vladimir Lypak <vladimir.lypak@gmail.com>, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <2eb72832e852c80e5c11cd69e7d2f14cefd8b1cb.1712903998.git.viresh.kumar@linaro.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <2eb72832e852c80e5c11cd69e7d2f14cefd8b1cb.1712903998.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715258110;d806580a;
X-HE-SMSGID: 1s52zK-0006Xy-8j



On 12.04.24 08:41, Viresh Kumar wrote:
> The required_opp_tables parsing is not perfect, as the OPP core does the
> parsing solely based on the DT node pointers.
> 
> The core sets the required_opp_tables entry to the first OPP table in
> the "opp_tables" list, that matches with the node pointer.
> 
> If the target DT OPP table is used by multiple devices and they all
> create separate instances of 'struct opp_table' from it, then it is
> possible that the required_opp_tables entry may be set to the incorrect
> sibling device.
> 
> Unfortunately, there is no clear way to initialize the right values
> during the initial parsing and we need to do this at a later point of
> time.
> 
> Cross check the OPP table again while the genpds are attached and fix
> them if required.
> 
> Also add a new API for the genpd core to fetch the device pointer for
> the genpd.
> 
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Reported-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218682

Did this fall through the cracks? Just wondering, as from here it looks
like for about four weeks now nothing happened to fix the regression
linked above. But I might have missed something. Or is everybody waiting
for a test from the reporter?

Ciao, Thorsten


> Co-developed-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Fix an `if` condition.
> - s/Bugzilla/Closes/ and change ordering.
> 
>  drivers/opp/core.c        | 31 ++++++++++++++++++++++++++++++-
>  drivers/pmdomain/core.c   | 10 ++++++++++
>  include/linux/pm_domain.h |  6 ++++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e233734b7220..cb4611fe1b5b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2394,7 +2394,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>  static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>  			const char * const *names, struct device ***virt_devs)
>  {
> -	struct device *virt_dev;
> +	struct device *virt_dev, *gdev;
> +	struct opp_table *genpd_table;
>  	int index = 0, ret = -EINVAL;
>  	const char * const *name = names;
>  
> @@ -2427,6 +2428,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>  			goto err;
>  		}
>  
> +		/*
> +		 * The required_opp_tables parsing is not perfect, as the OPP
> +		 * core does the parsing solely based on the DT node pointers.
> +		 * The core sets the required_opp_tables entry to the first OPP
> +		 * table in the "opp_tables" list, that matches with the node
> +		 * pointer.
> +		 *
> +		 * If the target DT OPP table is used by multiple devices and
> +		 * they all create separate instances of 'struct opp_table' from
> +		 * it, then it is possible that the required_opp_tables entry
> +		 * may be set to the incorrect sibling device.
> +		 *
> +		 * Cross check it again and fix if required.
> +		 */
> +		gdev = dev_to_genpd_dev(virt_dev);
> +		if (IS_ERR(gdev))
> +			return PTR_ERR(gdev);
> +
> +		genpd_table = _find_opp_table(gdev);
> +		if (!IS_ERR(genpd_table)) {
> +			if (genpd_table != opp_table->required_opp_tables[index]) {
> +				dev_pm_opp_put_opp_table(opp_table->required_opp_tables[index]);
> +				opp_table->required_opp_tables[index] = genpd_table;
> +			} else {
> +				dev_pm_opp_put_opp_table(genpd_table);
> +			}
> +		}
> +
>  		/*
>  		 * Add the virtual genpd device as a user of the OPP table, so
>  		 * we can call dev_pm_opp_set_opp() on it directly.
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 4215ffd9b11c..c40eda92a85a 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -184,6 +184,16 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
>  	return pd_to_genpd(dev->pm_domain);
>  }
>  
> +struct device *dev_to_genpd_dev(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd = dev_to_genpd(dev);
> +
> +	if (IS_ERR(genpd))
> +		return ERR_CAST(genpd);
> +
> +	return &genpd->dev;
> +}
> +
>  static int genpd_stop_dev(const struct generic_pm_domain *genpd,
>  			  struct device *dev)
>  {
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 772d3280d35f..f24546a3d3db 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -260,6 +260,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>  int pm_genpd_init(struct generic_pm_domain *genpd,
>  		  struct dev_power_governor *gov, bool is_off);
>  int pm_genpd_remove(struct generic_pm_domain *genpd);
> +struct device *dev_to_genpd_dev(struct device *dev);
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>  int dev_pm_genpd_remove_notifier(struct device *dev);
> @@ -307,6 +308,11 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline struct device *dev_to_genpd_dev(struct device *dev)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
>  static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>  						     unsigned int state)
>  {

