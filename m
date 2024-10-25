Return-Path: <linux-pm+bounces-16486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B125D9B0E0C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 21:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B3D1F21A1C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BA73C482;
	Fri, 25 Oct 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F9tl/w43"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24620C301
	for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883676; cv=none; b=KkZO1o/YWHh1sMi45drTkkr6gePDefh/5LBrt16lSmzwbEdmyQbPy1uZoJXcAtiITSMdXS1SIfJzRbGq+tZzw/KW3xDfumg3kvPhOW1E9BSka1bNQunLXsI0Pcl1zyIpaIjdxKUNnkv2eEUNQtGJw3B+Uq28xmAhWqxILNR4JCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883676; c=relaxed/simple;
	bh=3KcR9b3g1326SaHe5G39JjV0bpcPIJvDLsy9axOhRIc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmEdkdbCwA/Zn5wfZCnoqD1nKGDCH2XCGGJ2WDyvfq76OXpjrBXaxkWXuWeypcRJFZPOmcoqu8WrE5H5quJRaNXcwfexN9oB/O5bu1WAbeHSJbB/DVxnMeCpPTujMwF0gqlxOzJXKsseKGm2UnTno8+4WBO/T1VrUTHJhT2vacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=F9tl/w43; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49PJEI1A043641;
	Fri, 25 Oct 2024 14:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729883658;
	bh=FXZVLDAZH4ZXnSMd3sgMoCVlxPKO8Bbc2V7wbVstwf4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=F9tl/w43n4bqiIzuRK//iXLYy+HN1nC/wF2s4vslBF9Jau+q5KaeA0qRLmjkZU4qB
	 Za4APp/byOUAINzRjKhTDThC8zINbxOLbci7Y8XSFQbcDaPzTou/ZGJNC3KhweE+oM
	 3lso02WwD+vhu3465E4m/sAKvZYy24K1ycX08Klw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49PJEHNQ044148;
	Fri, 25 Oct 2024 14:14:18 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Oct 2024 14:14:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Oct 2024 14:14:17 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49PJEGEw082685;
	Fri, 25 Oct 2024 14:14:17 -0500
Date: Sat, 26 Oct 2024 00:44:16 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
CC: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
        <ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>,
        <chenjun102@huawei.com>
Subject: Re: [PATCH v3 1/2] pmdomain: ti-sci: Add missing of_node_put() for
 args.np
Message-ID: <20241025191416.i6afl4ibtiy45s5e@lcpd911>
References: <20241024030442.119506-1-zhangzekun11@huawei.com>
 <20241024030442.119506-2-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241024030442.119506-2-zhangzekun11@huawei.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

On Oct 24, 2024 at 11:04:41 +0800, Zhang Zekun wrote:
> of_parse_phandle_with_args() needs to call of_node_put() to decrement
> the refcount of args.np. So, Add the missing of_node_put() in the loop.

Seems better worded now, thanks.
Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 1510d5ddae3d..0df3eb7ff09a 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -161,6 +161,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>  				break;
>  
>  			if (args.args_count >= 1 && args.np == dev->of_node) {
> +				of_node_put(args.np);
>  				if (args.args[0] > max_id) {
>  					max_id = args.args[0];
>  				} else {
> @@ -192,7 +193,10 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>  				pm_genpd_init(&pd->pd, NULL, true);
>  
>  				list_add(&pd->node, &pd_provider->pd_list);
> +			} else {
> +				of_node_put(args.np);
>  			}
> +

Avoid irrelevant changes..

>  			index++;
>  		}
>  	}
> -- 
> 2.17.1
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

