Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27351BE55A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD2RfY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 13:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgD2RfX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Apr 2020 13:35:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BB0208FE;
        Wed, 29 Apr 2020 17:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588181723;
        bh=kTj/YC+N0D5IZKKdecoXqvWmOkFRl7ivNAPi9A8eOho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfENhhFaRP6btb0G1FD1PRB0ifoF33+6KEbUNSG6wNVnTuHKIRBHJ/ra1uPqJxZpa
         OtKs0V51rEqOKjdWC2P8fG7dMTq5UbIlb1DQl3N3600wvE+/+snAtPtqxcHCy+/Hc5
         ybiB1+KKw3JkM5aQIoSvX1elPKTvtj+IPw2OiaKE=
Date:   Wed, 29 Apr 2020 19:35:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] regulator: Revert "Use driver_deferred_probe_timeout for
 regulator_init_complete_work"
Message-ID: <20200429173520.GA2332435@kroah.com>
References: <20200429172349.55979-1-john.stultz@linaro.org>
 <20200429172701.GO4201@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429172701.GO4201@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 06:27:01PM +0100, Mark Brown wrote:
> On Wed, Apr 29, 2020 at 05:23:49PM +0000, John Stultz wrote:
> > This reverts commit dca0b44957e5 ("regulator: Use
> > driver_deferred_probe_timeout for regulator_init_complete_work"),
> > as we ended up reverting the default deferred_probe_timeout
> > value back to zero, to preserve behavior with 5.6 we need to
> > decouple the regulator timeout which was previously 30 seconds.
> > 
> > This avoids breaking some systems that depend on the regulator
> > timeout but don't require the deferred probe timeout.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
> 
> I'm assuming this should go via the same path that the other revert
> went.

I'll be glad to take it that way :)

thanks,

greg k-h
