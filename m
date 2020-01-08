Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3577133E83
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 10:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgAHJpx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 04:45:53 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:46036 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAHJpx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 04:45:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 2550D3F4AC;
        Wed,  8 Jan 2020 10:45:49 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b="hSnh9X1+";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0b6EX6t8R-PL; Wed,  8 Jan 2020 10:45:48 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 29CF53F322;
        Wed,  8 Jan 2020 10:45:46 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id BF694234; Wed,  8 Jan 2020 10:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1578476745; bh=b8ABfWyk18Jn/VMg7nHgfFeaiagOwhh3UDBYQ/J+09E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSnh9X1+rz2qVIYAFOcfVuwVtxldo91kSc4g8LK9aEstmdx7AP7hCJrLIcHtKOOVw
         BFwBtd0SgGnYsXCvD++zJ/AWkh/PaG1B3baUHRNORGjy1Jdjg3+n0TmenXSkEtVGcf
         C5foHsAQKMQcRLeA098+/L3Faybs5R/aDOLi+pcA=
Date:   Wed, 8 Jan 2020 10:45:45 +0100
From:   Niklas Cassel <nks@flawful.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nishanth Menon <nm@ti.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] power: avs: qcom-cpr: remove duplicated include
 from qcom-cpr.c
Message-ID: <20200108094545.o5o4tpwt4eu5fpye@flawful.org>
References: <20200108015849.54289-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108015849.54289-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 08, 2020 at 01:58:49AM +0000, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/power/avs/qcom-cpr.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> index 9247f53550b3..9b1d7d919ee9 100644
> --- a/drivers/power/avs/qcom-cpr.c
> +++ b/drivers/power/avs/qcom-cpr.c
> @@ -25,7 +25,6 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/clk.h>
>  #include <linux/nvmem-consumer.h>
> -#include <linux/bitops.h>
>  
>  /* Register Offsets for RB-CPR and Bit Definitions */
> 
> 
> 

Thank you for this fix.

Acked-by: Niklas Cassel <nks@flawful.org>
