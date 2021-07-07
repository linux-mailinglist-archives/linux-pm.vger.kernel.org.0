Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC773BED43
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhGGRnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 13:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhGGRnX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 13:43:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A57061CC8;
        Wed,  7 Jul 2021 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625679641;
        bh=KGTnMF/YkGnnFlFUcLdeaUqIGat+Dw0CbfG9H5HQiI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdIDfftJhjR5BbnKPCM3p0vV8BLdq4A2b2qFqf1+r+X/P06b4y4K2r05Jvn/OwI8d
         vBAbbtxA/y6T4fu57WDILd1tp5Zsq3kzcqtTGZe4o+qRH4IoHkPiIe+FOzwAwmaz4r
         UeJFkW5kdXrM3zhFB6aN8G6JJ8bEFFLohfOWa+FA=
Date:   Wed, 7 Jul 2021 19:40:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] driver core: Add ability to delete device links
 of unregistered devices
Message-ID: <YOXnF4BBPeBEMB38@kroah.com>
References: <20210707172948.1025-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707172948.1025-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 07, 2021 at 08:29:46PM +0300, Adrian Hunter wrote:
> Hi
> 
> There is an issue with the SCSI UFS driver when the optional
> BOOT well-known LUN fails to probe, which is not a fatal error.
> The issue is that the device and its "managed" device link do not
> then get deleted.  The device because the device link has a
> reference to it.  The device link because it can only be deleted
> by device_del(), but device_add() was never called, so device_del()
> never will be either.

How was a link created for something that never had device_add() called
on it?  Who is doing that?

thanks,

greg k-h
