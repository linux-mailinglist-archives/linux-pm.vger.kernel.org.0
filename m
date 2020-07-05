Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96EE214B91
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jul 2020 11:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGEJhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jul 2020 05:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgGEJhH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 5 Jul 2020 05:37:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF9F2073E;
        Sun,  5 Jul 2020 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593941826;
        bh=wExsVNlA8OBH3gMvy3MLlC4oFVBlISbS1WZHNOU2l2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ay2INal2pcNefvfAGMKg5ZpHsn1mCBTxd5zyrNSPig3oAPahfmPvLZulZTpPlaPxb
         Se01tIA9ntYiDejjJP7PAn2WBGWJGZSfieXwWNuQqhfS6XBBnEU2X3O2dyOqAqQaHJ
         ZldDjZ/kVbzv0Fg+lDmjQlm+knSwmmL272Yz+Hlg=
Date:   Sun, 5 Jul 2020 11:37:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gustav Wiklander <gustavwi@axis.com>
Cc:     Gustav Wiklander <Gustav.Wiklander@axis.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, kernel <kernel@axis.com>
Subject: Re: [PATCH] PM / Domains: Add module ref count for each consumer
Message-ID: <20200705093708.GA559523@kroah.com>
References: <20200610143943.12548-1-gustav.wiklander@axis.com>
 <20200610145229.GA2101163@kroah.com>
 <a6f1fbad-b753-db30-bf95-c314e9eea508@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6f1fbad-b753-db30-bf95-c314e9eea508@axis.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 10, 2020 at 07:24:02PM +0200, Gustav Wiklander wrote:
> On 6/10/20 4:52 PM, Greg KH wrote:
> > On Wed, Jun 10, 2020 at 04:39:43PM +0200, Gustav Wiklander wrote:
> > > From: Gustav Wiklander <gustavwi@axis.com>
> > > 
> > > Currently a pm_domain can be unloaded without regard for consumers.
> > > This patch adds a module dependecy for every registered consumer.
> > > Now a power domain driver can only be unloaded if no consumers are
> > > registered.
> > 
> > What is the problem with doing this?  Shouldn't when a power domain is
> > unregistered, the consumers are properly torn down?  Some subsystems
> > allow you to unload a module at any point in time, and properly clean
> > things up.  What is the problem today that you are trying to solve with
> > this (remember, removing modules only happens by developers, no
> > real-world system ever automatically onloads a module.)
> > 
> > 
> Hi Greg and Rafael,
> 
> Thanks for the quick reply.
> 
> PM domains shall call pm_genpd_remove at removal. As described in the
> definition pm_genpd_remove will fail if any device is still associated to
> it. *However*, at module removal the kernel ignores device removal failure
> and still unloads the powerdomain module.

So shouldn't the driver that controls that device be fixed up to
properly remove the association first?

Is there any in-kernel code that has this problem today?  Adding module
reference logic for an operation that has to be initiated by a developer
only, seems like it's not really needed.

thanks,

greg k-h
