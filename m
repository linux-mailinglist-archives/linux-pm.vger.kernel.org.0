Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3549317966D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 18:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgCDRMy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 12:12:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgCDRMy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Mar 2020 12:12:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7108221775;
        Wed,  4 Mar 2020 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583341973;
        bh=fGZO8IiDt6IouMRYJcdwHaQ/Nli/lNDUQPVQ+t4fUJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGSNA6SCwIwmnoXq6unuaIbYou3KDT8LlCwlB35VykB+lCFs9M3ouwd7ho1ObbzG1
         vc2rDlHbd4UG0eRfdCIbaSZIhpjLDBquwL0RNFqYK5keUyYUConYjvrxEeaIgYynhV
         0tLrwmAprP16lTXMmQO0oYYSp1tAww5C173kUmMw=
Date:   Wed, 4 Mar 2020 18:12:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/6] driver core: Improve and cleanup
 driver_deferred_probe_check_state()
Message-ID: <20200304171252.GA1852336@kroah.com>
References: <20200225050828.56458-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225050828.56458-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 25, 2020 at 05:08:22AM +0000, John Stultz wrote:
> This series goal is to improve and cleanup the
> driver_deferred_probe_check_state() code in the driver core.
> 
> This series is useful for being able to support modules
> dependencies which may be loaded by userland, far after
> late_initcall is done. For instance, this series allows us to
> successfully use various clk drivers as modules on the db845c
> board. And without it, those drivers have to be statically built
> in to work.
> 
> Since I first sent out this patch, Saravana suggested an
> alternative approach which also works for our needs, and is a
> bit simpler:
>  https://lore.kernel.org/lkml/20200220055250.196456-1-saravanak@google.com/T/#u
> 
> However, while that patch provides the functionality we need,
> I still suspect the driver_deferred_probe_check_state() code
> could benefit from the cleanup in this patch, as the existing
> logic is somewhat muddy.

This looks much better, thanks for sticking with it, all now queued up.

greg k-h
