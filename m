Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3832B1D4B29
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 12:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgEOKjj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 06:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbgEOKji (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 May 2020 06:39:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6FF207CB;
        Fri, 15 May 2020 10:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589539178;
        bh=PrM+xPGfJLUiyDISNpS4vjvmsRnmHt+gojfva9KvB1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKedetK3gPz0GVdrzVQ0d2O10La+Y6bjL3cWBrZWWII43x/E4CYjMQXu8/BW6fZUM
         rh3QHk9e8A0x0zyw3F8au4UiM9tovwygfrHoJpIIAwzwWPGPmslwTrjQg5pd9oAXCN
         MBdfy7hljbo4joxXXgyVWcCioRg2NLkQcvSja5rc=
Date:   Fri, 15 May 2020 12:39:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 10/11] kernel/power: constify sysrq_key_op
Message-ID: <20200515103936.GA1712181@kroah.com>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
 <20200513214351.2138580-10-emil.l.velikov@gmail.com>
 <CAJZ5v0iM5H03=RTtk2sZtUzaW0XJ+AaX1M00C8QjvaNz0ZE3bQ@mail.gmail.com>
 <CACvgo52myKJ+3s8pYPnqNBxWqg6bCHQXqGJrLwmrSvocuqU=pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACvgo52myKJ+3s8pYPnqNBxWqg6bCHQXqGJrLwmrSvocuqU=pg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 15, 2020 at 11:11:57AM +0100, Emil Velikov wrote:
> On Thu, 14 May 2020 at 12:21, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, May 13, 2020 at 11:46 PM Emil Velikov <emil.l.velikov@gmail.com> wrote:
> > >
> > > With earlier commits, the API no longer discards the const-ness of the
> > > sysrq_key_op. As such we can add the notation.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jiri Slaby <jslaby@suse.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: linux-pm@vger.kernel.org
> > > Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> Thanks
> 
> > and I'm assuming that this is going to be applied along with the rest
> > of the series.
> >
> I believe so, although I have not heard anything from the TTY maintainers yet.

I will take them all, thanks.

greg k-h
