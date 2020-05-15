Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405601D46D3
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 09:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgEOHL4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 03:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgEOHL4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 May 2020 03:11:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B832D206F1;
        Fri, 15 May 2020 07:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589526715;
        bh=bO56gu0bStJa4vn7t8SHLVGqZOgUKV4d9WF3KRFluMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYnEKRSFxTIOOTXSSfz64gxCP9PnNitGXe0AzDZ3nhC+xisp2VmVbc0YTmdcBSE+a
         WkXOdmm6R6cdIWWcu3D2RsDqeLfO/2oUeFrgZCeogzvSgzXqqw2yTF6Vg3ZcNh7UYk
         V59vecakrN237UppeFjGXvdW+U40njZH1mLER2iY=
Date:   Fri, 15 May 2020 09:11:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] interconnect: Disallow interconnect core to be built as
 a module
Message-ID: <20200515071152.GA1274556@kroah.com>
References: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
 <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
 <66c3d470-48e2-619a-dd95-6064a85161e0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c3d470-48e2-619a-dd95-6064a85161e0@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 15, 2020 at 07:48:47AM +0300, Georgi Djakov wrote:
> On 9/12/19 19:33, Bjorn Andersson wrote:
> > On Thu, Aug 29, 2019 at 1:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>
> >> Building individual drivers as modules is fine but allowing a core
> >> framework to be built as a module makes it really complex and should be
> >> avoided.
> >>
> >> Whatever uses the interconnect core APIs must also be built as a module
> >> if interconnect core is built as module, else we will see compilation
> >> failures.
> >>
> >> If another core framework (like cpufreq, clk, etc), that can't be built
> >> as module, needs to use interconnect APIs then we will start seeing
> >> compilation failures with allmodconfig configurations as the symbols
> >> (like of_icc_get()) used in other frameworks will not be available in
> >> the built-in image.
> >>
> >> Disallow the interconnect core to be built as a module to avoid all
> >> these issues.
> 
> Hi Greg,
> 
> We had a discussion [1] a few months back about frameworks being built as
> modules. IIUC, you initially expressed some doubts about this patch, so i
> wanted to check with you again on this.
> 
> While i think that the possibility for a framework core to be a module is a
> nice feature, and we should try to be as modular as possible, it seems that
> handling dependencies between the different core frameworks becomes difficult
> when one of them is tristate.
> 
> This of course affects the drivers which use it (every client should express
> the dependency in Kconfig as a "depends on framework || !framework"), in order
> to avoid build failures in the case when framework=m and client=y. However, this
> is not a big issue.
> 
> But it gets more complex when another framework2 becomes a client of the modular
> framework and especially when framework2 is "select"-ed in Kconfig by it's
> users. When selects are used in Kconfig, it forces the option, without ever
> visiting the dependencies. I am not sure what we should do in this case, maybe
> we can continue and sprinkle more "depends on framework || !framework" also for
> every single user which selects framework2.. But i believe that this is very
> inconvenient.
> 
> Well, the above is not impossible, but other frameworks (regulator, clk, reset,
> pinctrl, etc.) are solving this problem by just being bool, instead of tristate.
> This makes life much easier for everyone. So i am wondering if it wouldn't be
> more appropriate to use the same approach here too?

Ok, if it makes things easier, perhaps this is the best way to handle
it.

thanks,

greg k-h
