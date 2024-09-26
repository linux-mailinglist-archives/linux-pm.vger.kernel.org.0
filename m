Return-Path: <linux-pm+bounces-14803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C6987048
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 11:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966CAB26D8D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063B61ACE19;
	Thu, 26 Sep 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o2Y5lrTV"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068451AD3E3
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343058; cv=none; b=vCeoozYm30i95eeyAPeoGBXzPBvZ6bKD8OfDIi1oKMBp+Oc0wDmnLPSvZSJatdXAw1imU1OzoDR5FWme7BJPisPVpEaV0+TF8jm52jRE3tlnhCl9wFfAs8Bzh3/gDSjHISinXGTEXmD6OuweXBA5M9kyKbtC31NiUeyNWD6Y4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343058; c=relaxed/simple;
	bh=LcfpctB3pXrCDI8cy+EOK/9DmGHn+WDYCGK/MkDL+rA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6dq2+QGUup3AKes03Qjep4aXi4wixizYf0Akm5rYYiDFhGmkbLle+Bcq9+ixofByLIDoNINRCbCoUQynLMR/OB+5KSAayUXbKeHDn/C33jPOHyX5+KtHaeCSKvCgFdZOXtf+fU9ha38VY7UyJiEFMXXlcppNa7jfQCqJJW9c/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o2Y5lrTV; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48Q9UYQL120157;
	Thu, 26 Sep 2024 04:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727343034;
	bh=WYHl0PmKNZ4hFlSOfiK2q0FOowagihBRbvPORb63ByI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=o2Y5lrTVoUeKU0Ub5OqMCmxSsmoFs5qvx+iGOPpk3NxAR2UMkaFRhiHczJk9qCgDk
	 dSxgTVrcUKEL5umTs3VXQmcZSrZX94hfL2iJUnsiconxhpAXHbViRFjDfDTWePqkLY
	 zREl6v7KAgkNlflCMDs9Qa+5bWn4nrTyphbczWvQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q9UY4b088680;
	Thu, 26 Sep 2024 04:30:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 04:30:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 04:30:34 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q9UXj0013632;
	Thu, 26 Sep 2024 04:30:34 -0500
Date: Thu, 26 Sep 2024 15:00:33 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
CC: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
        <ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>,
        <chenjun102@huawei.com>
Subject: Re: [RESEND PATCH v2 1/2] pmdomain: ti-sci: Add missing
 of_node_put() for args.np
Message-ID: <20240926093033.hxdfk7a2kowizowm@lcpd911>
References: <20240926012551.31712-1-zhangzekun11@huawei.com>
 <20240926012551.31712-2-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240926012551.31712-2-zhangzekun11@huawei.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 26, 2024 at 09:25:50 +0800, Zhang Zekun wrote:
> of_parse_phandle_with_args() need to call of_node_put() to decerement

s/need/needs
s/decerement/decrement ?

> the refcount of args.np. Adding backing the missing of_node_put().

Add back* the missing...

Also, Just curious on why you're saying "Adding back", was it was there before but someone
removed it?

> 
> Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
> v2: Add missing brackets.

where? Please specify links to previous revision patches.
Here, I have no real context of what's changes in V2 and why :)

> 
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

No need of else, I feel you just need to use of_node_put once, and it
can be done after the whole if block, no?

> +
>  			index++;
>  		}
>  	}
> -- 
> 2.17.1
> 
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

