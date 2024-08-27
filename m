Return-Path: <linux-pm+bounces-12950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928ED96064B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49B21C2286F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0757D1993BE;
	Tue, 27 Aug 2024 09:53:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050AF15ADB4;
	Tue, 27 Aug 2024 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752429; cv=none; b=B0EgARhbeR0jsbb/E3PjkhKVJ7Un964DK2IOVVd2LrRZ2UeV07aBbtQigq8Z7I9ojry2syUMFjLE7Ty/rvKp97VYQy/8iTNSja0TtgwK9Zyoh9kAsichcW/sLqfYDPAuvOzDEexiRPVEYKTOYC+rXJdhNIE/t29JTWBtmUz8Dus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752429; c=relaxed/simple;
	bh=oYQTbtbf9WfaZ++h0etITYmbiL9CHD1FpokqLRbqH/w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CX4LN6ShE0VAVYBB4HRMrCe7vYZrUlYQvC9nk7q8fM7lNB4PaoI9u4LkWTkQU9g9c4pkHk5KXHrkd+qK3oc3gJNCi0mDbBu6gz1TTSJvKWzcBBGJkoC9s00e60Crx+yB+ePLxnf4NQXmLsPDo4BIuO0Lc01xhFo5lkeRlNfLmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtN862M71z6DB4F;
	Tue, 27 Aug 2024 17:50:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D1815140A71;
	Tue, 27 Aug 2024 17:53:44 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 10:53:44 +0100
Date: Tue, 27 Aug 2024 10:53:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konradybcio@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-msm@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 01/10] pmdomain: rockchip: Simplify with scoped for each
 OF child loop
Message-ID: <20240827105343.00003a72@Huawei.com>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-1-8320722eaf39@linaro.org>
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
	<20240823-cleanup-h-guard-pm-domain-v1-1-8320722eaf39@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 14:51:05 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Use scoped for_each_available_child_of_node_scoped() and
> for_each_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Ripe for some dev_err_probe() usage that will make this even nicer
as a cleanup.

Looks good as it stands
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 64b4d7120d83..5679ad336a11 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -804,11 +804,10 @@ static void rockchip_configure_pd_cnt(struct rockchip_pmu *pmu,
>  static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
>  				     struct device_node *parent)
>  {
> -	struct device_node *np;
>  	struct generic_pm_domain *child_domain, *parent_domain;
>  	int error;
>  
> -	for_each_child_of_node(parent, np) {
> +	for_each_child_of_node_scoped(parent, np) {
>  		u32 idx;
>  
>  		error = of_property_read_u32(parent, "reg", &idx);
> @@ -816,7 +815,7 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
>  			dev_err(pmu->dev,
>  				"%pOFn: failed to retrieve domain id (reg): %d\n",
>  				parent, error);
> -			goto err_out;
> +			return error;
>  		}
>  		parent_domain = pmu->genpd_data.domains[idx];
>  
> @@ -824,7 +823,7 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
>  		if (error) {
>  			dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
>  				np, error);
> -			goto err_out;
> +			return error;
>  		}
>  
>  		error = of_property_read_u32(np, "reg", &idx);
> @@ -832,7 +831,7 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
>  			dev_err(pmu->dev,
>  				"%pOFn: failed to retrieve domain id (reg): %d\n",
>  				np, error);
> -			goto err_out;
> +			return error;
>  		}
>  		child_domain = pmu->genpd_data.domains[idx];
>  
> @@ -840,7 +839,7 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
>  		if (error) {
>  			dev_err(pmu->dev, "%s failed to add subdomain %s: %d\n",
>  				parent_domain->name, child_domain->name, error);
> -			goto err_out;
> +			return error;
>  		} else {
>  			dev_dbg(pmu->dev, "%s add subdomain: %s\n",
>  				parent_domain->name, child_domain->name);
> @@ -850,17 +849,12 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
>  	}
>  
>  	return 0;
> -
> -err_out:
> -	of_node_put(np);
> -	return error;
>  }
>  
>  static int rockchip_pm_domain_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> -	struct device_node *node;
>  	struct device *parent;
>  	struct rockchip_pmu *pmu;
>  	const struct rockchip_pmu_info *pmu_info;
> @@ -918,12 +912,11 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
>  	 */
>  	mutex_lock(&dmc_pmu_mutex);
>  
> -	for_each_available_child_of_node(np, node) {
> +	for_each_available_child_of_node_scoped(np, node) {
>  		error = rockchip_pm_add_one_domain(pmu, node);
>  		if (error) {
>  			dev_err(dev, "failed to handle node %pOFn: %d\n",
>  				node, error);
> -			of_node_put(node);
>  			goto err_out;
>  		}
>  
> @@ -931,7 +924,6 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
>  		if (error < 0) {
>  			dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
>  				node, error);
> -			of_node_put(node);
>  			goto err_out;
>  		}
>  	}
> 


