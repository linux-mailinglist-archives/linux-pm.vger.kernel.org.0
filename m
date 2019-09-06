Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E0DABCE5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 17:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390162AbfIFPri (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 11:47:38 -0400
Received: from muru.com ([72.249.23.125]:59962 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfIFPri (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Sep 2019 11:47:38 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1F90580CC;
        Fri,  6 Sep 2019 15:48:06 +0000 (UTC)
Date:   Fri, 6 Sep 2019 08:47:32 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Subject: Re: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be
 explicitly ti,omap3430 or ti,omap36xx
Message-ID: <20190906154732.GC52127@atomide.com>
References: <cover.1567587220.git.hns@goldelico.com>
 <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com>
 <20190905142734.GV52127@atomide.com>
 <4BC39938-D63E-4BDC-BA28-5132F77F602D@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BC39938-D63E-4BDC-BA28-5132F77F602D@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190906 07:53]:
> > Am 05.09.2019 um 16:27 schrieb Tony Lindgren <tony@atomide.com>:
> > compatible = "ti,omap3-ldp", "ti,omap3430", "ti,omap34xx", "ti,omap3";
> 
> After thinking a little about the whole topic the main rule of this change must be:
> 
> * do not break any existing in-tree DTS
> 	=> only *add* to compatible what we need to distinguish between omap34 and omap36
> 
> * additions shall only follow new scheme
> 	=> we only add "ti,omap34xx" or "ti,omap36xx"
>            but neither "ti,omap3630" nor "ti,omap3430"

Sorry I don't follow you on this one.. We should always add "ti,omap3630"
where "ti,omap36xx" is currently used so we can eventually get rid of
"ti,omap36xx". And the same for 34xx.

> * cover some out-of-tree DTS
> 	=> make the ti-cpufreq driver still match "ti,omap3430" or "ti,omap3630"
> 	   even if this duplicates compatibility
> 
> This would mean that the logicpd-som-lv-37xx-devkit.dts gets the additional "ti,omap36xx"
> while the omap3-ldp.dts would only get an "ti,omap34xx" but no "ti,omap3430" (since we
> do not use it anywhere).
> 
> Could you agree on this approach?

Yeah sounds like logicpd-som-lv-37xx-devkit.dts currently still needs
"ti,omap36xx" for now.

If modifying omap3-ldp.dts, also add "ti,omap3430" in additon to
"ti,omap34xx" that it already has.

So basically let's assume the following:

"ti,omap3430" == "ti,omap34xx"
"ti,omap3630" == "ti,omap36xx"

This means code needs to parse both.

And eventually we just drop the "xx" variants.

So while patching compatibles, let's also update for this to
avoid multiple patches churning the same compatibles over and
over.

Regards,

Tony
