Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF362A1CF1
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 10:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgKAJgP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 04:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgKAJgO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Nov 2020 04:36:14 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD87720870;
        Sun,  1 Nov 2020 09:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604223373;
        bh=oVVJbpuCpdFDPmn7BbTaHQR1soNKyFAe5s0qbdFJSrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4P5TADe18hQahhs1sf/HEtUc3oe7X6ZnhtxpJ05cCMKio7OhXNKDgCPWIRSIoQZg
         42/hnf1YiwUBs9+HisZKrNoCeHx2pt6EGQ5y+Oj5iKJdLX1R7mBAXulPRP6YAcd/1V
         rtElF6VytLpdVt8t/64yxvmw+nHszvoIZY0tHeZ0=
Date:   Sun, 1 Nov 2020 10:36:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Saravana Kannan <saravanak@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: Re: [PATCH 0/3] PM: runtime: Fixes related to device links management
Message-ID: <20201101093610.GA9168@kroah.com>
References: <6543936.FbWAdBN1tG@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6543936.FbWAdBN1tG@kreacher>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 21, 2020 at 09:10:08PM +0200, Rafael J. Wysocki wrote:
> Hi Greg & all,
> 
> Commit d12544fb2aa9 ("PM: runtime: Remove link state checks in
> rpm_get/put_supplier()") merged recently introduced a weakness
> in the handling of device links in the runtime PM framework that
> may be confusing and even harmful.
> 
> Namely, the checks removed by that commit prevented PM-runtime from
> getting or dropping references to the supplier device whose driver
> was going away via its links to consumers, which specifically allowed
> the pm_runtime_clean_up_links() called from __device_release_driver()
> to run without interfering with runtime suspend/resume of consumer
> devices (which still might happen even though the drivers had been
> unbound from them by that time).
> 
> After the above commit, calling pm_runtime_clean_up_links() from
> __device_release_driver() makes a little sense and it may be interfering
> destructively with regular PM-runtime suspend/resume control flows, so
> it needs to be either fixed or dropped altogether.  I prefer the latter,
> because among other things this removes an arbitrary difference in the
> handling of managed device links with respect to the stateless ones,
> so patch [2/3] is doing just that.
> 
> However, in some rare cases pm_runtime_clean_up_links() may help to clean
> up leftover PM-runtime references, so if that function goes away, they
> need to be cleaned up elsewhere.  That's why patch [1/3] modifies
> __device_link_del() to drop them upon device link removal (which also
> needs to be done for stateless device links and that's why I'm regarding
> this patch as a fix).
> 
> Finally, to avoid pointless overhead related to suspending and resuming
> the target device for multiple times in a row in __device_release_driver(),
> it is better to resume it upfront before checking its links to consumers,
> which is done by patch [3/3].
> 
> While this series touches the driver core, it really is mostly related to
> runtime PM, so I can apply it if that's OK.

Please do, sorry for the delay in reviewing them:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
