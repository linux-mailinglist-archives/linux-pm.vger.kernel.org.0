Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B31C38ECB4
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhEXPWX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 11:22:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54042 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhEXPRb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 11:17:31 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14OFFrGa041504;
        Mon, 24 May 2021 10:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621869353;
        bh=GboA2Om6dWr6qVDBT1Ckg/PVdLDQm9AAnrekIIVfbC4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ezxz44WojYw81t7cpvqj9sVTor/6Nt3SS+z2gMEgyX+ijRNxI7/ljJP4TlP+YB19C
         1OIdg9qgMKnbRN+oVdMOyaNGMZ0GGnOOSMe+vN94M+lh5pbxkIoW09groq6bMFamFh
         JeLJh3J21Hf9L7J4UbCpnzFtDgauuSwUz879qIxk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14OFFrqk107878
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 May 2021 10:15:53 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 10:15:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 24 May 2021 10:15:52 -0500
Received: from [10.250.35.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14OFFqY7115517;
        Mon, 24 May 2021 10:15:52 -0500
Subject: Re: [PATCH] thermal: ti-soc-thermal: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>, <edubezval@gmail.com>
CC:     <j-keerthy@ti.com>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1621851963-36548-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <011fb94c-7775-6c3f-2215-bf9cb505d6d1@ti.com>
Date:   Mon, 24 May 2021 10:15:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1621851963-36548-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/24/21 5:26 AM, Yang Li wrote:
> Fix function name in ti-bandgap.c kernel-doc comment
> to remove a warning.
> 
> drivers/thermal/ti-soc-thermal/ti-bandgap.c:787: warning: expecting
> prototype for ti_bandgap_alert_init(). Prototype was for
> ti_bandgap_talert_init() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index ebe7cb7..ea0603b 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -770,7 +770,7 @@ static int ti_bandgap_tshut_init(struct ti_bandgap *bgp,
>  }
>  
>  /**
> - * ti_bandgap_alert_init() - setup and initialize talert handling
> + * ti_bandgap_talert_init() - setup and initialize talert handling
>   * @bgp: pointer to struct ti_bandgap
>   * @pdev: pointer to device struct platform_device
>   *
> 

