Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ACB36682F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhDUJhq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 05:37:46 -0400
Received: from muru.com ([72.249.23.125]:57140 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238140AbhDUJhp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 05:37:45 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 44E5780F7;
        Wed, 21 Apr 2021 09:38:33 +0000 (UTC)
Date:   Wed, 21 Apr 2021 12:37:07 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Lin Ruizhe <linruizhe@huawei.com>, rui.zhang@intel.com,
        edubezval@gmail.com, j-keerthy@ti.com, amitk@kernel.org,
        radhesh.fadnis@ti.com, eballetbo@gmail.com,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] thermal: ti-soc-thermal: Remove unused variable 'val'
Message-ID: <YH/yQ5Hd+30DH4p/@atomide.com>
References: <20210421084256.57591-1-linruizhe@huawei.com>
 <YH/nK6xshH+lW7e0@kroah.com>
 <8e66040e-4330-d4f0-afbb-8cae62a5082e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e66040e-4330-d4f0-afbb-8cae62a5082e@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Daniel Lezcano <daniel.lezcano@linaro.org> [210421 09:07]:
> On 21/04/2021 10:49, Greg KH wrote:
> > On Wed, Apr 21, 2021 at 04:42:56PM +0800, Lin Ruizhe wrote:
> >> The variable 'val'in function ti_bandgap_restore_ctxt is
> >> the register value of read bandgap registers. This function is to
> >> restore the context. But there is no operation on the return value
> >> of this register, so this block is redundant. Hulk robot scans this
> >> warning.This commit remove the dead code.
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Fixes: b87ea759a4cc ("staging: omap-thermal: fix context restore function")
> >> Signed-off-by: Lin Ruizhe <linruizhe@huawei.com>
> >> ---
> >> v3:
> >> -Add Fixes tag and more accurate commit message in this patch.
> >> v2:
> >> -As suggest remove the whole unuesed block in fuction
> >>  ti_bandgap_restore_ctxt
> >>
> >>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 4 ----
> >>  1 file changed, 4 deletions(-)
> >>
> >> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> >> index d81af89166d2..684ffb645aa9 100644
> >> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> >> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> >> @@ -1142,14 +1142,10 @@ static int ti_bandgap_restore_ctxt(struct ti_bandgap *bgp)
> >>  	for (i = 0; i < bgp->conf->sensor_count; i++) {
> >>  		struct temp_sensor_registers *tsr;
> >>  		struct temp_sensor_regval *rval;
> >> -		u32 val = 0;
> >>  
> >>  		rval = &bgp->regval[i];
> >>  		tsr = bgp->conf->sensors[i].registers;
> >>  
> >> -		if (TI_BANDGAP_HAS(bgp, COUNTER))
> >> -			val = ti_bandgap_readl(bgp, tsr->bgap_counter);
> > 
> > Are you sure that this hardware does not require this read to happen in
> > order for it to work properly?
> 
> Yes, initially we had the same concern but we were unable to find
> anything specific in the history. The commit mentioned above removed the
> user of the 'val' code but without removing this block of code.
> 
> When looking at the current code, it really looks like an oversight.

Yes so it seems.

> There is nothing in the commit's changelog referring to a need of
> reading the counter register but perhaps I'm wrong because I'm not sure
> to understand correctly the changelog.
> 
> > Lots of hardware does need this, have you tested this?

I just tested this on omap3 logicpd torpedo devkit that can do off during
idle and reading /sys/class/thermal/thermal_zone0/temp works. So feel
free to add:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
