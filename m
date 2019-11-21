Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E010538E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 14:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUNwy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 08:52:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUNwy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 Nov 2019 08:52:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E8D820679;
        Thu, 21 Nov 2019 13:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574344371;
        bh=zYluV3+BkKDTzX4PhM/6p8mm4PW1N2NXyUniwFP2SIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x91gtEgxXBqjIgsQOgdk7x0GiDDCxwDmZtviKrjR+nByMeWgo19NAQ3WAymaWWviH
         zlvhAf78wNJ6qMg74R+JpoIChWrczxTrye0Dqzgrt3QEgMstRcO1YOiMWkib2fwuxM
         lj9DbLQHNzNo0L/bwdiNlP7atLCBlD7mllrCsiCA=
Date:   Thu, 21 Nov 2019 14:52:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com,
        Niklas Cassel <niklas.cassel@linaro.org>, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
Subject: Re: stable/linux-4.14.y bisection: boot on odroid-x2
Message-ID: <20191121135249.GA549340@kroah.com>
References: <5dd5fbf5.1c69fb81.0938.8061@mx.google.com>
 <20191121060811.mvzzh4zlfzlubzlv@vireshk-i7>
 <20191121065821.GA344102@kroah.com>
 <20191121085529.qjmj7pwew4wjmggu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121085529.qjmj7pwew4wjmggu@vireshk-i7>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 21, 2019 at 02:25:29PM +0530, Viresh Kumar wrote:
> On 21-11-19, 07:58, Greg Kroah-Hartman wrote:
> > On Thu, Nov 21, 2019 at 11:38:11AM +0530, Viresh Kumar wrote:
> > > On 20-11-19, 18:52, kernelci.org bot wrote:
> > > > commit 714ab224a8db6e8255c61a42613de9349ceb0bba
> > > > Author: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Date:   Fri Aug 3 07:05:21 2018 +0530
> > > > 
> > > >     OPP: Protect dev_list with opp_table lock
> > > >     
> > > >     [ Upstream commit 3d2556992a878a2210d3be498416aee39e0c32aa ]
> > > >     
> > > >     The dev_list needs to be protected with a lock, else we may have
> > > >     simultaneous access (addition/removal) to it and that would be racy.
> > > >     Extend scope of the opp_table lock to protect dev_list as well.
> > > >     
> > > >     Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > >     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > 
> > > @Sasha: Please drop this patch for now.
> > 
> > Drop it from 4.14 and 4.19?
> 
> Yes.

Now done, thanks.

greg k-h
