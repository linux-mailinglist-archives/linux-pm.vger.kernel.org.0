Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F60F5E1B
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 09:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfKIIs1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Nov 2019 03:48:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfKIIs1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 9 Nov 2019 03:48:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E864B214E0;
        Sat,  9 Nov 2019 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573289304;
        bh=hukStfid93ctuxGqEwFn19+/1igLGrz5ibX+4aGbB/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLmg39AnE82EYdKpJ7Cvwfr0MacRpiG7/jJH8I+XjxMrSf+HAY+LM1L5Y5MDr4/3S
         /jwd5MN3FBl8GxMhGvmsrjfojBBgJggS3eozdPHTy5Le0IgFQ/YltJDatirFOWbudC
         zW0hcYe5sdhm/kazyHpRons/39aMJ6DMUXlotJjA=
Date:   Sat, 9 Nov 2019 09:48:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [GIT PULL] interconnect changes for 5.5
Message-ID: <20191109084820.GC1289838@kroah.com>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
 <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com>
 <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 08, 2019 at 05:36:46PM -0800, Bjorn Andersson wrote:
> On Fri, Nov 8, 2019 at 2:39 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Nov 07, 2019 at 05:42:13PM +0200, Georgi Djakov wrote:
> > > Hi Greg,
> > >
> > > On 11/7/19 16:21, Greg Kroah-Hartman wrote:
> > > > On Thu, Nov 07, 2019 at 02:46:53PM +0200, Georgi Djakov wrote:
> > > >> Hi Greg,
> > > >>
> > > >> This is a pull request with interconnect patches for the 5.5 merge window.
> > > >> All patches have been for a while in linux-next without reported issues. The
> > > >> details are in the signed tag. Please consider pulling into char-misc-next.
> > > >
> > > > I don't know about
> > > > 0003-interconnect-Disallow-interconnect-core-to-be-built-.patch here.
> > > > Shouldn't you just fix up the dependancies of subsystems that rely on
> > > > this?  We are moving more and more to kernels that "just work" with
> > > > everything as modules, even on arm64 systems.  So forbiding the
> > > > interconnect code from being able to be built as a module does not feel
> > > > good to me at all.
> > >
> > > Thank you for commenting on this! The initial idea was to keep everything as
> > > modular as possible. The reasons behind this change is that other core
> > > frameworks like cpufreq (and possibly others) want to call the interconnect
> > > APIs. Some of these frameworks are built-in only and it would be easier to
> > > handle dependencies if interconnect core built-in too. Now each user that
> > > can be built-in has to specify in Kconfig that it depends on INTERCONNECT ||
> > > !INTERCONNECT.
> >
> > That's fine, when those subsystems start to use those apis, that
> > dependency needs to be added.  Nothing new here, and you forcing it to
> > either be "on or off" isn't going to change that.  Let's do it correctly
> > please.
> >
> 
> Please no!
> 
> Making our frameworks tristate means that we can no longer rely on
> include file stubs (as framework=m, client=y will fail), so every
> single client must add the "depends on framework || framework=n" - in
> contrast to nothing the framework itself is bool.

What's wrong with a single "depends on framework"?  If your code relies
on this framework, you should depend on it, right?  Include file stubs
feels odd for a core functionality, if you can live without that
functionality, then sure, don't depend on it and all should be just
fine.

thanks,

greg k-h
