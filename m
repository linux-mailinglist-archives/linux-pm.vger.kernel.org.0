Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC069F44C1
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 11:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfKHKjW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 05:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKHKjW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 05:39:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4B1207FA;
        Fri,  8 Nov 2019 10:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573209559;
        bh=/3cgKiUJ9juirczVtLqBhfMzf1soL4OejrPSFQ4t2w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ut776HMJFRJSHQFqF63ZvwBCxgOFV1R10wdRXbEP4OdEXIBsiSwJSUv2u9iVLflHG
         x0Rx07AB7qWSlep5s18OGsHZSZR3WIDbmYJ745fxel1oiHxVvEaaA21iM6U7NooJva
         UUTqccTO84eWe5nSfHOiT0BZbGw4RRJmAfXBEc6U=
Date:   Fri, 8 Nov 2019 11:39:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [GIT PULL] interconnect changes for 5.5
Message-ID: <20191108103917.GB683302@kroah.com>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
 <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 07, 2019 at 05:42:13PM +0200, Georgi Djakov wrote:
> Hi Greg,
> 
> On 11/7/19 16:21, Greg Kroah-Hartman wrote:
> > On Thu, Nov 07, 2019 at 02:46:53PM +0200, Georgi Djakov wrote:
> >> Hi Greg,
> >>
> >> This is a pull request with interconnect patches for the 5.5 merge window.
> >> All patches have been for a while in linux-next without reported issues. The
> >> details are in the signed tag. Please consider pulling into char-misc-next.
> > 
> > I don't know about
> > 0003-interconnect-Disallow-interconnect-core-to-be-built-.patch here.
> > Shouldn't you just fix up the dependancies of subsystems that rely on
> > this?  We are moving more and more to kernels that "just work" with
> > everything as modules, even on arm64 systems.  So forbiding the
> > interconnect code from being able to be built as a module does not feel
> > good to me at all.
> 
> Thank you for commenting on this! The initial idea was to keep everything as
> modular as possible. The reasons behind this change is that other core
> frameworks like cpufreq (and possibly others) want to call the interconnect
> APIs. Some of these frameworks are built-in only and it would be easier to
> handle dependencies if interconnect core built-in too. Now each user that
> can be built-in has to specify in Kconfig that it depends on INTERCONNECT ||
> !INTERCONNECT.

That's fine, when those subsystems start to use those apis, that
dependency needs to be added.  Nothing new here, and you forcing it to
either be "on or off" isn't going to change that.  Let's do it correctly
please.

thanks,

greg k-h
