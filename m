Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852D8AC7E5
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436494AbfIGRIo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 13:08:44 -0400
Received: from muru.com ([72.249.23.125]:60132 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394938AbfIGRIn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Sep 2019 13:08:43 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 79F03805C;
        Sat,  7 Sep 2019 17:09:11 +0000 (UTC)
Date:   Sat, 7 Sep 2019 10:08:38 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] cpufreq: ti-cpufreq: add support for omap34xx and
 omap36xx
Message-ID: <20190907170838.GH52127@atomide.com>
References: <cover.1567839375.git.hns@goldelico.com>
 <0eb7129f6148faac0150d6299ac97347484c7125.1567839375.git.hns@goldelico.com>
 <F12B47AA-DED2-4BD9-B144-2463A2AE6094@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F12B47AA-DED2-4BD9-B144-2463A2AE6094@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190907 07:38]:
> > Am 07.09.2019 um 08:56 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> > @@ -190,6 +272,11 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
> > 	{ .compatible = "ti,am33xx", .data = &am3x_soc_data, },
> > 	{ .compatible = "ti,am43", .data = &am4x_soc_data, },
> > 	{ .compatible = "ti,dra7", .data = &dra7_soc_data },
> > +	{ .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
> > +	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
> > +	/* legacy */
> > +	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
> > +	{ .compatible = "ti,omap3630", .data = &omap36xx_soc_data, },
> 
> Well, I just realized that with the latest DTS changes,
> 
> ti,omap34xx and ti,omap36xx are legacy and
> ti,omap3430 and ti,omap3630 are now official.

Heh :) Anyways, with that changed, this looks good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
