Return-Path: <linux-pm+bounces-14805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B24498707B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 11:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3405B28855
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3FA1ABECC;
	Thu, 26 Sep 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IpxI82xz"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20CE1AB6C5
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343735; cv=none; b=azQeRYOfvCWaAXqEeA83DXDza/xE3vfsbKEZZnfxfSVMDfZ2HWVSikLEwdpS8VEmun5mPnw3qxKrCYyRJ0DS5NZqe5ejoo4ju1ahGG/MC2DbznFm7e2FAypFzbyIyRMWuWeuYVw3hD8Ftq6HbL4230UCZOdgvQSnPshaYjRNOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343735; c=relaxed/simple;
	bh=Mmwaj1GtxMNvEDdzSa5B5qcWEEX78+kzYr4imjzxaNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2iqt6y1LDgbVWIpSB5AKIhYuBEhp4sa5fyN5rmIGmlq0gdE3wHmPr5O0AciTB8L92YGKBbJBb7undQhOr/U5kB4L059C5dWnLlJCWHSVczjPqc5hsStBWS8y9MYf3Zkb4XUmKk0kAsWjLON7W9Ir29mzXU1hooqGAm6yGUulOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IpxI82xz; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48Q9g23Q123422;
	Thu, 26 Sep 2024 04:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727343722;
	bh=46hlGgR1REm+/3tX2Tix06jdKxwWNmJxRbXGSvY5FBA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IpxI82xz+L32vQsm/yLHPl7CVcJzmGApe8xbdb+kF2k/elLdPiI+qUmduizEjRmCK
	 6QFHN4ym7YXWyKDesj35bB7J5HAzHlMi37HoChn7jteZWQsLjIxJLwKblxvx8/ylAN
	 wonOMqbbswuZsQJ5uL6qHQCKTg9We2e1a9Y6lyvU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48Q9g2cG022940
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Sep 2024 04:42:02 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 04:41:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 04:41:58 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q9fvN6007634;
	Thu, 26 Sep 2024 04:41:58 -0500
Date: Thu, 26 Sep 2024 15:11:57 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
CC: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
        <ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>,
        <chenjun102@huawei.com>
Subject: Re: [RESEND PATCH v2 2/2] pmdomain: ti-sci: Use scope based
 of_node_put() to simplify code.
Message-ID: <20240926094157.imcrnueu6lnqmic4@lcpd911>
References: <20240926012551.31712-1-zhangzekun11@huawei.com>
 <20240926012551.31712-3-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240926012551.31712-3-zhangzekun11@huawei.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 26, 2024 at 09:25:51 +0800, Zhang Zekun wrote:
> Use scope based of_node_put() to simplify the code logic, and we don't
> need to call of_node_put(). Besides, put of_parse_phandle_with_args() in
> the while loop to make code more simple.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 0df3eb7ff09a..83729bc52c09 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -131,9 +131,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct ti_sci_genpd_provider *pd_provider;
>  	struct ti_sci_pm_domain *pd;
> -	struct device_node *np;
> +	struct device_node *np __free(device_node) = NULL;
>  	struct of_phandle_args args;
> -	int ret;
>  	u32 max_id = 0;
>  	int index;
>  
> @@ -153,12 +152,9 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>  	for_each_node_with_property(np, "power-domains") {
>  		index = 0;
>  
> -		while (1) {
> -			ret = of_parse_phandle_with_args(np, "power-domains",
> -							 "#power-domain-cells",
> -							 index, &args);
> -			if (ret)
> -				break;
> +		while (!of_parse_phandle_with_args(np, "power-domains",
> +						   "#power-domain-cells",
> +						   index, &args)) {
>  
>  			if (args.args_count >= 1 && args.np == dev->of_node) {
>  				of_node_put(args.np);
> @@ -172,18 +168,14 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>  				}
>  
>  				pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> -				if (!pd) {
> -					of_node_put(np);
> +				if (!pd)
>  					return -ENOMEM;
> -				}
>  
>  				pd->pd.name = devm_kasprintf(dev, GFP_KERNEL,
>  							     "pd:%d",
>  							     args.args[0]);
> -				if (!pd->pd.name) {
> -					of_node_put(np);
> +				if (!pd->pd.name)
>  					return -ENOMEM;
> -				}

Actually, just noticed there's a chance that we return early inside this
if block, so the else part now makes sense to me in the previous patch.
Please ignore my code comment but fix the commit message if you re spin.

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

