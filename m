Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241013901BB
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhEYNKu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 09:10:50 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:58665 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhEYNKt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 09:10:49 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 8985CC9447;
        Tue, 25 May 2021 13:09:18 +0000 (UTC)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 59780FF812;
        Tue, 25 May 2021 13:08:53 +0000 (UTC)
Date:   Tue, 25 May 2021 15:08:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 2/9] rtc: bd70528: Drop BD70528 support
Message-ID: <YKz25PDL2Z6vgqJv@piout.net>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
 <2beaa677bde0f9516f366b97e91419598f1dfde4.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
 <YKzjtml4GL+dhP6j@piout.net>
 <83c091bef8adecd06a5c6fac9c86ca572bcc06d4.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c091bef8adecd06a5c6fac9c86ca572bcc06d4.camel@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/05/2021 11:59:58+0000, Vaittinen, Matti wrote:
> And in any case applying the MFD and RTC patches should be synced. RTC
> parts should be applied before MFD parts because few other PMICs use
> this same RTC driver and compilation would fail with missing headers if
> MFD was removed before RTC changes are applied.
> 
> Suggestions on how to guarantee the order of MFD and RTC - and how to
> resolve conflicts?
> 

The easiest is to take the RTC patches in one cycle and the rest in
the next cycle.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
