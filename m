Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B77AD163E50
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 08:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgBSH5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 02:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgBSH5c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Feb 2020 02:57:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B30321D56;
        Wed, 19 Feb 2020 07:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582099052;
        bh=dX6II76srch6B1FGnp5iAvUq0daDmqaINqk1Uwkiv7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSWnDFgkZCvfs4BxmO1i+z3Hx1ADug+aiVjtcyfa4bpW005OrxgcnTe4InbIoV+c/
         OiPP3h5bTJREVwMOz8BY5aM1ePubbMVN40KHH7NdvqCGR09/udT5pFMHbW0x0S22gH
         2EQv8yZYYrCMWU8O7NDH5P+FpTuxgTlbSlNR/HZU=
Date:   Wed, 19 Feb 2020 08:57:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20200219075730.GA2732797@kroah.com>
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <20200218220748.54823-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218220748.54823-2-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 18, 2020 at 10:07:48PM +0000, John Stultz wrote:
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -236,6 +236,7 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
>  }
>  #endif
>  
> +extern int deferred_probe_timeout;
>  void driver_deferred_probe_add(struct device *dev);

If this is going to be global now, can you rename it to
"driver_defferred_probe_timeout" to make it more in line with the other
exported symbols here?

thanks,

greg k-h
