Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764FFAC7EB
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbfIGRJH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 13:09:07 -0400
Received: from muru.com ([72.249.23.125]:60186 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395130AbfIGRJH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Sep 2019 13:09:07 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9A72A805C;
        Sat,  7 Sep 2019 17:09:35 +0000 (UTC)
Date:   Sat, 7 Sep 2019 10:09:02 -0700
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
        Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] ARM: dts: omap3: bulk convert compatible to be
 explicitly ti,omap3430 or ti,omap3630 or ti,am3517
Message-ID: <20190907170902.GJ52127@atomide.com>
References: <cover.1567839375.git.hns@goldelico.com>
 <2c9eb085606de4a52d73a2461b1997265cdd2ea5.1567839375.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c9eb085606de4a52d73a2461b1997265cdd2ea5.1567839375.git.hns@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190907 06:57]:
> For the ti-cpufreq driver we need a clear separation between omap34 and omap36 families
> since they have different silicon revisions and efuses.
> 
> So far ti,omap3630/ti,omap36xx is just an additional flag to ti,omap3 while omap34 has no
> required entry.
> 
> Therefore we can not match omap34 boards properly.
> 
> This needs to add ti,omap3430 and ti,omap3630 where it is missing.
> 
> We also clean up some instances of missing ti,am3517 so that we can rely on
> seeing either one of:
> 
> ti,am3517
> ti,omap3430
> ti,omap3630
> 
> in addition to ti,omap3.
> 
> We leave ti,omap34xx and ti,omap36xx untouched for compatibility.

Thanks for doing this:

Acked-by: Tony Lindgren <tony@atomide.com>
