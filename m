Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B14288C0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 10:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhJKIaI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 04:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234913AbhJKIaH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Oct 2021 04:30:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E915360F21;
        Mon, 11 Oct 2021 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633940888;
        bh=DOwrpFJGRa6owRtbNZhTfEzzpZvhKOCToK9K0ouxKAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DatTPuLa8IB2ay0KjCnjg2/B0B4LL1NmXtGQ+gMRnwPc2SPZ6yWCZ8wPK0lcgy90L
         ePKhQWQRECvIpDYo6xMoLrXVTkapZQQbSj4uuFbhQ3xY6JPta+h9w+kNziO/WK2Aod
         Kiv89Zx0o8q91kLjaaZLojAi71wH86ROmX/06os8NO2RcjSRZQq+PML+H6kng5Fv+c
         TJ54zx3SVak0PJohE9LcRWKVO6XkKLjJIdKHFV/+9mh2srHgw776kQ1gyURnX6jzV+
         O0R1wVkOufyPlF2adbQXIsKrOeADb6qw1FTLauXFZO+cNhdKihUdIE7xFbfdeZt8oI
         Ff0yPmfjKs+4g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mZqf7-0002JM-8v; Mon, 11 Oct 2021 10:27:58 +0200
Date:   Mon, 11 Oct 2021 10:27:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 6/7] tty: serial: samsung_tty: Support runtime PM
Message-ID: <YWP1jX1DA/bgDyIn@hovoldconsulting.com>
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-7-marcan@marcan.st>
 <77ae3bb1-6da5-3ec6-de33-5e5f661b6145@canonical.com>
 <46109820-904b-4e87-5134-7d045dbbe57e@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46109820-904b-4e87-5134-7d045dbbe57e@marcan.st>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 11, 2021 at 02:32:29PM +0900, Hector Martin wrote:
> On 06/10/2021 16.43, Krzysztof Kozlowski wrote:
> > On 05/10/2021 17:59, Hector Martin wrote:

> >>   	if (port) {
> >> +		pm_runtime_get_sync(&dev->dev);
> > 
> > 1. You need to check return status.
> > 2. Why do you need to resume the device here?
> 
> As Rafael mentioned, this is basically disabling PM so the device is 
> enabled when not bound (which seems to be expected behavior). Not sure 
> what I'd do if the resume fails... this is the remove path after all, 
> it's not like we're doing anything else with the device at this point.

You still need to disable the clocks before returning from remove().
Consider what happens when the driver is rebound otherwise.

Johan
