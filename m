Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCBDC4BB86
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 16:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfFSObW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 10:31:22 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52483 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSObW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 10:31:22 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5EA3620016;
        Wed, 19 Jun 2019 14:31:14 +0000 (UTC)
Date:   Wed, 19 Jun 2019 16:31:12 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, mazziesaccount@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v15 0/7] support ROHM BD70528 PMIC
Message-ID: <20190619143112.GO23549@piout.net>
References: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
 <20190611200043.eib3g3acc7ilawsx@earth.universe>
 <20190612060328.GQ4797@dell>
 <20190613130529.kgswgbuszb24itxz@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613130529.kgswgbuszb24itxz@earth.universe>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/06/2019 15:05:29+0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jun 12, 2019 at 07:03:28AM +0100, Lee Jones wrote:
> > On Tue, 11 Jun 2019, Sebastian Reichel wrote:
> > > On Mon, Jun 03, 2019 at 10:23:37AM +0300, Matti Vaittinen wrote:
> > > > Patch series introducing support for ROHM BD70528 PMIC
> > > > [...]
> > > 
> > > I think all patches have been reviewed by the respective subsystem
> > > maintainers. Lee, can you provide an immutable branch with the MFD
> > > patches (1, 2, 4)? Looks like the other patches only depend on those
> > > and can go through their respective subsystems.
> > 
> > Yes.  It's on my TODO list.
> 
> Thanks.
> 
> > Would you prefer this method over me just taking them all and sending
> > out a PR?  The latter is my usual flow, but I'm happy with either.
> 
> Both methods are fine with me. I usually go with "my" method, since
> that results in less shared commits. It simplifies potential
> follow-up bug fixes, since there is only one tree to fix.
> 

Personally, I'm fine with Lee taking everything in his tree as it is
very unlikely to require follow up patches this cycle (i.e before rc1).


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
