Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85000163EAD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 09:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBSIPQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 03:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgBSIPQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Feb 2020 03:15:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1E242176D;
        Wed, 19 Feb 2020 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582100116;
        bh=2lJvgbRb9rP6Vhs0w8YL7pQP2f3DBRY6ioR0MgXbnAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KsUc4mlSoOf5rkLOIyakA9xHsbeBxTx9HmoTKBL5+29cWoHsD++AiexBiih06GTzT
         wbNMPotqi517j9MFy4wCrMP19VGEXYXceLGx8sDvgPBkp00r+Pb7da1tz28ua5QBoU
         NEHviUetaGrJLSX/r7WtHJDI3agfb13actQrPl9E=
Date:   Wed, 19 Feb 2020 09:15:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] driver core: Make deferred_probe_timeout global
 so it can be shared
Message-ID: <20200219081514.GA2735658@kroah.com>
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <20200218220748.54823-2-john.stultz@linaro.org>
 <20200219075730.GA2732797@kroah.com>
 <e67836f6-dcaa-c7b6-0779-35a9ff98ba38@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e67836f6-dcaa-c7b6-0779-35a9ff98ba38@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 19, 2020 at 12:00:09AM -0800, Randy Dunlap wrote:
> On 2/18/20 11:57 PM, Greg Kroah-Hartman wrote:
> > On Tue, Feb 18, 2020 at 10:07:48PM +0000, John Stultz wrote:
> >> --- a/include/linux/device/driver.h
> >> +++ b/include/linux/device/driver.h
> >> @@ -236,6 +236,7 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
> >>  }
> >>  #endif
> >>  
> >> +extern int deferred_probe_timeout;
> >>  void driver_deferred_probe_add(struct device *dev);
> > 
> > If this is going to be global now, can you rename it to
> > "driver_defferred_probe_timeout" to make it more in line with the other
> 
> or driver_deferred_probe_timeout please.

Yes, that's spelt better :)
