Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C744366748
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 10:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbhDUIuZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 04:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237600AbhDUIuX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 04:50:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C15B613B6;
        Wed, 21 Apr 2021 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618994990;
        bh=gsqlZVxYz5Qu/ptEDC6eNZHIR/EEg/GOzaIv2HS032Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/Bz+9MQJzjl3Y7/TxkTL9Iu/exgAU06ZtJV7yebD+p7L5wJxnN6fkiz09zV/syQx
         F58BibsFDaWt658KqrPfJUPbVVHw7dyYdzDnyNw/SNJf6nEDKRpcWoHcpMnm8NqkbF
         8vnFbu+mMiw19PcS62SXxcvGxI6A9ydd2aFQQ0Wk=
Date:   Wed, 21 Apr 2021 10:49:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lin Ruizhe <linruizhe@huawei.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com, j-keerthy@ti.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, radhesh.fadnis@ti.com,
        eballetbo@gmail.com, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] thermal: ti-soc-thermal: Remove unused variable 'val'
Message-ID: <YH/nK6xshH+lW7e0@kroah.com>
References: <20210421084256.57591-1-linruizhe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421084256.57591-1-linruizhe@huawei.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 21, 2021 at 04:42:56PM +0800, Lin Ruizhe wrote:
> The variable 'val'in function ti_bandgap_restore_ctxt is
> the register value of read bandgap registers. This function is to
> restore the context. But there is no operation on the return value
> of this register, so this block is redundant. Hulk robot scans this
> warning.This commit remove the dead code.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: b87ea759a4cc ("staging: omap-thermal: fix context restore function")
> Signed-off-by: Lin Ruizhe <linruizhe@huawei.com>
> ---
> v3:
> -Add Fixes tag and more accurate commit message in this patch.
> v2:
> -As suggest remove the whole unuesed block in fuction
>  ti_bandgap_restore_ctxt
> 
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index d81af89166d2..684ffb645aa9 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -1142,14 +1142,10 @@ static int ti_bandgap_restore_ctxt(struct ti_bandgap *bgp)
>  	for (i = 0; i < bgp->conf->sensor_count; i++) {
>  		struct temp_sensor_registers *tsr;
>  		struct temp_sensor_regval *rval;
> -		u32 val = 0;
>  
>  		rval = &bgp->regval[i];
>  		tsr = bgp->conf->sensors[i].registers;
>  
> -		if (TI_BANDGAP_HAS(bgp, COUNTER))
> -			val = ti_bandgap_readl(bgp, tsr->bgap_counter);

Are you sure that this hardware does not require this read to happen in
order for it to work properly?

Lots of hardware does need this, have you tested this?

thanks,

greg k-h
