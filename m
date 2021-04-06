Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E235A355490
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 15:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbhDFNHZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 09:07:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41352 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbhDFNHY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 09:07:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136D6vLo002198;
        Tue, 6 Apr 2021 08:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617714417;
        bh=uma/HGrD7FSNCA7vvx/wHhmqWGFic54vXdLDcyBqkzU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iOFmoAFC0it38WA1hWkUfWIIYyFgiaYp9wlsdcmZPU21THa0Ed0py7uQSsZFVKJVG
         RWOUhcNqciVDbgxc2m9cqOlILpHb1r7MleBBC2Ikg7nJcL9o81IbFpy6ZUxxJhfE3y
         /BXz44wNFYJY1hYRsduyBHwLdPlZQ7uPm7j973kI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136D6vhR008986
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 08:06:57 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 08:06:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 08:06:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136D6vSh112043;
        Tue, 6 Apr 2021 08:06:57 -0500
Date:   Tue, 6 Apr 2021 08:06:57 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Qiheng Lin <linqiheng@huawei.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] PM: AVS: remove redundant dev_err call in
 omap_sr_probe()
Message-ID: <20210406130657.c5edf3pakylxwavr@spoon>
References: <20210406122840.39-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210406122840.39-1-linqiheng@huawei.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20:28-20210406, Qiheng Lin wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
> ---
>  drivers/soc/ti/smartreflex.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
> index 5376f3d22f31..06cbee5fd254 100644
> --- a/drivers/soc/ti/smartreflex.c
> +++ b/drivers/soc/ti/smartreflex.c
> @@ -846,10 +846,8 @@ static int omap_sr_probe(struct platform_device *pdev)
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sr_info->base = devm_ioremap_resource(&pdev->dev, mem);
> -	if (IS_ERR(sr_info->base)) {
> -		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
> +	if (IS_ERR(sr_info->base))
>  		return PTR_ERR(sr_info->base);
> -	}
>  
>  	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  
> 
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
