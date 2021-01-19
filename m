Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964DB2FBB13
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 16:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390723AbhASPX0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 10:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391286AbhASPWV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Jan 2021 10:22:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0A3E23110;
        Tue, 19 Jan 2021 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611069701;
        bh=qk7bTIU32WQXEVpSYr8ZQ5kj+qrngrcgdHRTogxr7Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eoxZAwoaQ5d6ppq/JxVV+ZvPnmkXzAaC9P+yuT6raP3pPaU968h2eqioupYXq7+6e
         xl74BdLKtv+HGlEak8XzPTvbwxi/9J7S2EpeiwyloIpCViCIVYGst39naXNI3Vxybm
         MDvv8H20ZZEVUDe1FAGYKjyUuGTOrVvWf8YdTsOA=
Date:   Tue, 19 Jan 2021 16:21:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] driver core: Extend device_is_dependent()
Message-ID: <YAb5AofFj8akz3Kb@kroah.com>
References: <17705994.d592GUb2YH@kreacher>
 <CAJZ5v0gccJKSVuN-okBnvHPjNYJ_FbkzfOueb=AUDr2xHaL7Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gccJKSVuN-okBnvHPjNYJ_FbkzfOueb=AUDr2xHaL7Xg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 19, 2021 at 04:09:14PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 15, 2021 at 7:31 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If the device passed as the target (second argument) to
> > device_is_dependent() is not completely registered (that is, it has
> > been initialized, but not added yet), but the parent pointer of it
> > is set, it may be missing from the list of the parent's children
> > and device_for_each_child() called by device_is_dependent() cannot
> > be relied on to catch that dependency.
> >
> > For this reason, modify device_is_dependent() to check the ancestors
> > of the target device by following its parent pointer in addition to
> > the device_for_each_child() walk.
> >
> > Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > Tested-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Greg, are you going to pick up this one or do you want me to take care of it?
> 
> It has been reviewed by Saravana.

I'll take it, thanks.  sorry for the delay.

greg k-h
