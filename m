Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F1724E3D
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 13:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfEULmN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 07:42:13 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55273 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEULmN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 07:42:13 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E18C640003;
        Tue, 21 May 2019 11:41:49 +0000 (UTC)
Date:   Tue, 21 May 2019 13:41:49 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 0/8] support ROHM BD70528 PMIC
Message-ID: <20190521114149.GG3274@piout.net>
References: <cover.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
 <3a78cc77499d5027f527be51a7c40f6c5d70338c.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a78cc77499d5027f527be51a7c40f6c5d70338c.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/05/2019 11:01:53+0000, Vaittinen, Matti wrote:
> Hello All,
> 
> On Thu, 2019-05-02 at 12:11 +0300, Matti Vaittinen wrote:
> > Patch series introducing support for ROHM BD70528 PMIC
> > 
> Just thought I'd ask if there's any chances to get this series in 5.2?
> It seems to me the WDT part (patch 8) was already merged in but rest of
> the patches seem to be in limbo somewhere :)
> 
> I guess most of the patches have relevant acks - so wonder if the rest
> can go through Lee's tree? I admit I am getting slightly impatient -
> sorry for that :]
> 

Nope, the 5.2 merge windows is closed. This will have to wait for 5.3.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
