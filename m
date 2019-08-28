Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D6C9FF0A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfH1KBs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 06:01:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:44806 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfH1KBs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 06:01:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 03:01:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="192540987"
Received: from deyangko-mobl.ccr.corp.intel.com ([10.249.168.35])
  by orsmga002.jf.intel.com with ESMTP; 28 Aug 2019 03:01:44 -0700
Message-ID: <77939df6136cc0f729ec1e5c8b80006a9cb5a9d8.camel@intel.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Use
 devm_add_action_or_reset() helper
From:   Zhang Rui <rui.zhang@intel.com>
To:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 18:01:53 +0800
In-Reply-To: <20190731184402.GL3186@bigcity.dyn.berto.se>
References: <20190731125053.14750-1-geert+renesas@glider.be>
         <20190731184402.GL3186@bigcity.dyn.berto.se>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-07-31 at 20:44 +0200, Niklas Söderlund wrote:
> Hi Geert,
> 
> Thanks for your work.
> 
> On 2019-07-31 14:50:53 +0200, Geert Uytterhoeven wrote:
> > Use the devm_add_action_or_reset() helper instead of open-coding
> > the
> > same operations.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
Hi, Geert,

https://patchwork.kernel.org/patch/11034969/ is the same fix submitted
a few days earlier, so I will take that patch instead. Thanks for the
patch anyway.

thanks,
rui

> > ---
> >  drivers/thermal/rcar_gen3_thermal.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/thermal/rcar_gen3_thermal.c
> > b/drivers/thermal/rcar_gen3_thermal.c
> > index a56463308694e937..2db7e7f8baf939fd 100644
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -443,11 +443,10 @@ static int rcar_gen3_thermal_probe(struct
> > platform_device *pdev)
> >  		if (ret)
> >  			goto error_unregister;
> >  
> > -		ret = devm_add_action(dev, rcar_gen3_hwmon_action,
> > zone);
> > -		if (ret) {
> > -			rcar_gen3_hwmon_action(zone);
> > +		ret = devm_add_action_or_reset(dev,
> > rcar_gen3_hwmon_action,
> > +					       zone);
> > +		if (ret)
> >  			goto error_unregister;
> > -		}
> >  
> >  		ret = of_thermal_get_ntrips(tsc->zone);
> >  		if (ret < 0)
> > -- 
> > 2.17.1
> > 
> 
> 

