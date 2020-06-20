Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87982025C6
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jun 2020 19:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgFTRyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Jun 2020 13:54:47 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50370 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgFTRyr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 20 Jun 2020 13:54:47 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jmhhO-001Q08-4n; Sat, 20 Jun 2020 19:54:38 +0200
Date:   Sat, 20 Jun 2020 19:54:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt: fix oops on armada37xx
Message-ID: <20200620175438.GS304147@lunn.ch>
References: <20200620164449.GA19776@mail.rc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620164449.GA19776@mail.rc.ru>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 20, 2020 at 05:44:49PM +0100, Ivan Kokshaysky wrote:
> Commit 0c868627e617e43a295d8 (cpufreq: dt: Allow platform specific
> intermediate callbacks) added two function pointers to the
> struct cpufreq_dt_platform_data. However, armada37xx_cpufreq_driver_init()
> has this struct (pdata) located on the stack and uses only "suspend"
> and "resume" fields. So these newly added "get_intermediate" and
> "target_intermediate" pointers are uninitialized and contain arbitrary
> non-null values, causing all kinds of trouble.
> 
> For instance, here is an oops on espressobin after an attempt to change
> the cpefreq governor:
> 
> [   29.174554] Unable to handle kernel execute from non-executable memory at virtual address ffff00003f87bdc0
> ...
> [   29.269373] pc : 0xffff00003f87bdc0
> [   29.272957] lr : __cpufreq_driver_target+0x138/0x580
> ...
> 
> Fixed by zeroing out pdata before use.
> 
> Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

Hi Ivan

A Fixes: tag would be good.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
