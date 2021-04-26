Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED036B535
	for <lists+linux-pm@lfdr.de>; Mon, 26 Apr 2021 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhDZOsu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Apr 2021 10:48:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37236 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbhDZOsu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Apr 2021 10:48:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13QElv3V095385;
        Mon, 26 Apr 2021 09:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619448477;
        bh=iDG5+O6QQERHsm2DMcoPa5ohDN2yRkbZKYFXFbTD0ZE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JEt8IY9FNCjl+EvBlXk4wfV1Wzmt4bZOGC2AHcyrE5/oZkXkmR2w/Fg9NZeGPluC1
         aPO8+Z8cq1URpAwBm8RgY7zd+XX1J9cC7ECgSUm/dLoWpc0J6ELM2w6Wk04PLH+ADE
         GBtx7ragOzxNrFwswxA+QdQuM3JBlOy813gPbb+o=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13QElvkW026986
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Apr 2021 09:47:57 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Apr 2021 09:47:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Apr 2021 09:47:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13QEl8jI025844;
        Mon, 26 Apr 2021 09:47:08 -0500
Date:   Mon, 26 Apr 2021 09:47:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] soc: ti: smartreflex after the relocation to maintain
 consistency
Message-ID: <20210426144708.3r3h4csg6wywyude@italics>
References: <1619090212-103038-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1619090212-103038-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19:16-20210422, Yang Li wrote:
> v2: According to Nishanth Menon's suggestion, the subject has been 
> corrected.
> https://lore.kernel.org/patchwork/patch/1383883/

The above does'nt belong to commit message. it should probably be posted
in diffstat section.

will also be good to rebase once 5.13-rc1 is out.
> 
> Fix the following coccicheck warning:
> ./drivers/soc/ti/smartreflex.c:820:0-23: WARNING: pm_sr_fops should be
> defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
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

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
