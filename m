Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D3125F67E
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgIGJby (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 05:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgIGJbw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Sep 2020 05:31:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B382F2075A;
        Mon,  7 Sep 2020 09:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599471111;
        bh=eP5wyhYnUgbeM5N0DytP9/JFLIDxyhmR9T/dZ+SfNqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEK0NXYonD/CE8Y+G5BKcSukg0YWIon0CbRP/xlCInE2m+Qr3KT2RpmvGwPr+lL5V
         m3uvfqEV/7dBjjypb0/32ltnSaeYuR/vlhwZ4wKr+vpFR+hsm5ySbFS6X7Kl4nAYdB
         2aHK6g6YfUHVP12VokidWhyIsCISXd0ZotDABrR4=
Date:   Mon, 7 Sep 2020 11:32:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [RFC][PATCH] pinctrl: Rework driver_deferred_probe_check_state()
 evaluation since default timeout has changed
Message-ID: <20200907093206.GB1393659@kroah.com>
References: <20200808043512.106865-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808043512.106865-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Aug 08, 2020 at 04:35:12AM +0000, John Stultz wrote:
> In commit bec6c0ecb243 ("pinctrl: Remove use of
> driver_deferred_probe_check_state_continue()"), we removed the
> use of driver_deferred_probe_check_state_continue() which
> effectively never returned -ETIMED_OUT, with the
> driver_deferred_probe_check_state() function that had been
> reworked to properly return ETIMED_OUT when the deferred probe
> timeout expired. Along with that change, we set the default
> timeout to 30 seconds.
> 
> However, since moving the timeout to 30 seconds caused some
> issues for some users with optional dt links, we set the
> default timeout back to zero - see commit ce68929f07de ("driver
> core: Revert default driver_deferred_probe_timeout value to 0")
> 
> This in essence changed the behavior of the pinctrl's usage
> of driver_deferred_probe_check_state(), as it now would return
> ETIMED_OUT by default. Thierry reported this caused problems with
> resume on tegra platforms.
> 
> Thus this patch tweaks the pinctrl logic so that it behaves as
> before. If modules are enabled, we'll only return EPROBE_DEFERRED
> while we're missing drivers linked in the DT.
> 
> Cc: linux-pm@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Rob Herring <robh@kernel.org>
> Fixes: bec6c0ecb243 ("pinctrl: Remove use of driver_deferred_probe_check_state_continue()")
> Fixes: ce68929f07de ("driver core: Revert default driver_deferred_probe_timeout value to 0")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/pinctrl/devicetree.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
