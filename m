Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA61A080
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 17:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfEJPuU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 11:50:20 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:54520 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfEJPuT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 11:50:19 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id AF90F3C00C6;
        Fri, 10 May 2019 17:50:15 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TDuNWFWMQi7w; Fri, 10 May 2019 17:50:08 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id D64D73C004C;
        Fri, 10 May 2019 17:50:08 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May
 2019 17:50:08 +0200
Date:   Fri, 10 May 2019 17:50:05 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
CC:     Jiada Wang <jiada_wang@mentor.com>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <horms+renesas@verge.net.au>, <geert+renesas@glider.be>,
        <sergei.shtylyov@cogentembedded.com>,
        <marek.vasut+renesas@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <hien.dang.eb@renesas.com>,
        <fabrizio.castro@bp.renesas.com>, <dien.pham.ry@renesas.com>,
        <biju.das@bp.renesas.com>, <george_davis@mentor.com>,
        <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v4 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Message-ID: <20190510155005.GA499@vmlxhi-102.adit-jv.com>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190507235403.GA24112@bigcity.dyn.berto.se>
 <20190510104231.GA15836@vmlxhi-102.adit-jv.com>
 <20190510113608.GD28561@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510113608.GD28561@bigcity.dyn.berto.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Fri, May 10, 2019 at 01:36:08PM +0200, Niklas Söderlund wrote:
> Hi Eugeniu,
> 
> On 2019-05-10 12:42:31 +0200, Eugeniu Rosca wrote:
> > Hi Niklas,
> > 
> > On Wed, May 08, 2019 at 01:54:03AM +0200, Niklas Söderlund wrote:
> > > Hi Jiada,
> > [..]
> > > I really like this series, nice work.
> > > 
> > > Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > > Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > 
> > Is there anything off-the-shelf available for testing the rcar3
> > thermal driver, to avoid reinventing the wheel via
> > https://patchwork.kernel.org/cover/10913163/#22602335
> 
> Not that I know of, unfortunately :-(
> 
> I have a private home hacked testing framework (don't we all?) based on 
> tcl+expect where I have two basic tests for rcar_gen3_thermal. I'm 
> willing to share the tests if you by chance want them, but be warned 
> that they are highly specialised for my needs and I'm reluctant to 
> publish my whole hack tool as it just a ugly hack ;-)
> 
> On a high level the tests I have are
> 
> 1. thermal-load
>     Generates load on target and observes the temperature is increased 
>     using the /sys/class/thermal/thermal_zone*/temp" interface. This 
>     seems similar to the test case your reference using stress-ng.
> 
> 2. thermal-cooling
>     Emulate the passive trip point temperatures using the 
>     /sys/class/thermal/*/emul_temp interface and observe that the 
>     specified cooling state is achieved.
> 
> I should add a third test to make sure IRQ fires but this is just a pet 
> project for me so maybe I will get around to it sometime...
> 
> If you know of anything around to test thermal drivers or if you create 
> something please let me know so I can add it to my tests. And let me 
> know if you want my hacks for inspiration for your own testing.

Thanks for this summary. It would be definitely convenient to have
a set of tests covering the most important features of the driver.

I was particularly thinking of the test procedure in light of below:
 - I still can reproduce a few UBSAN (signed integer overflow) and
   KASAN (use-after-free) reports with the most recent vanilla driver.
 - There are a couple of thermal commits in rcar-3.9.x pending for
   mainline submission:

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=fe7d0d1c77f9 ("thermal: rcar_gen3_thermal: Use FUSE values if they are available")
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=2776ccd63649 ("thermal: rcar_gen3_thermal: Fix interrupt count issue")
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=9146af785f41 ("thermal: rcar_gen3_thermal: Enable selection between polling/interrupt mode")
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=55b262766ec2 ("thermal: rcar_gen3_thermal: PIO-INT can be selected for each TSC separately")
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=d323d9de0683 ("thermal: rcar_gen3_thermal: Add support for r8a77990")
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=fb8efb8bac29 ("thermal: rcar_gen3_thermal: Fix interrupts are not raised issue on E3")
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=5627c42a1bd5 ("thermal: rcar_gen3_thermal: Use DIV_ROUND_CLOSEST correctly as its description")
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=d4e41702e53b ("thermal: rcar_gen3_thermal: [H3/M3N] Update calculation formula due to HW evaluation")
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=958bd36e03b7 ("thermal: rcar_gen3_thermal: [E3] Update calculation formula due to HW evaluation")

Long story short, I think we will review more thermal commits in
hopefully not so distant future and it would be helpful to reach some
common understanding what kind of testing the new patches should pass.

Your summary already gives some insight in that direction. Thanks.

-- 
Best Regards,
Eugeniu.
