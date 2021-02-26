Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EEB325D84
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 07:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhBZGZx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 01:25:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57298 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZGZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 01:25:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11Q6Ob2f100191;
        Fri, 26 Feb 2021 00:24:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614320677;
        bh=2biBGk1+BsVwomDa/bJIak1U+MfLlq0iBBjwh0Cnf58=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=C+fn0jwGx7jTUjCQkNNAiipxOb9vXrYqZccJEnF4ePqGYovdqvi5aJAQXvGfUGXO1
         JjmDlUzUEClAxJsSyQLOXyVl9dSQUO0ZX3dL26hCb4wCZfYg6uCPVKduzJvkLXNBak
         pfRkH1VmuGsbBxF9W6w6KFVzXVtUg/E3PY5JYuL8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11Q6Ob5j086593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Feb 2021 00:24:37 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 26
 Feb 2021 00:24:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 26 Feb 2021 00:24:37 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11Q6ObeS063664;
        Fri, 26 Feb 2021 00:24:37 -0600
Date:   Fri, 26 Feb 2021 00:24:37 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <tony@atomide.com>
Subject: Re: [PATCH] PM: AVS: Replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
Message-ID: <20210226062437.lvhy3ehwgwgn5nom@likewise>
References: <1614156520-105525-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1614156520-105525-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16:48-20210224, Yang Li wrote:
> Fix the following coccicheck warning:
> ./drivers/soc/ti/smartreflex.c:820:0-23: WARNING: pm_sr_fops should be
> defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/soc/ti/smartreflex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
> index 5376f3d..b3c7460 100644
> --- a/drivers/soc/ti/smartreflex.c
> +++ b/drivers/soc/ti/smartreflex.c
> @@ -817,7 +817,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
> +DEFINE_DEBUGFS_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
>  			omap_sr_autocomp_store, "%llu\n");
>  
>  static int omap_sr_probe(struct platform_device *pdev)
> -- 
> 1.8.3.1
> 
LGTM.

Reviewed-by: Nishanth Menon <nm@ti.com>

Though $subject might be soc: ti: smartreflex after the relocation to maintain
consistency..

Upto santosh if he might want to locally change on applying the patch..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
