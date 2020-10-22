Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F152957EF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 07:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502857AbgJVFbs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 01:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392324AbgJVFbs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 01:31:48 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328532225F;
        Thu, 22 Oct 2020 05:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603344708;
        bh=c8Wft23L/OeRjPmbwqMGKdGIjZWj83EhGedVahVaRLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVEOe1U5r69NdS5pKv8pG1MpgKVIaf89W85IcxtsFc6v1wBrj38tClG2oFO3JWn0d
         HVBlbAiD2mtyxLFgf42d+euq52651Mcg+/SH5tTRwM46z1FhaNYO9PxE/IqE1HU+F2
         OykJOtA/FeRw7ftwBHav4t/Fg4Y0gyQLh/xNsMTg=
Date:   Thu, 22 Oct 2020 07:31:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / sysfs: Expose suspend resume driver flags in sysfs
Message-ID: <20201022053143.GB6523@kroah.com>
References: <20201022032324.25308-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022032324.25308-1-yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 11:23:24AM +0800, Chen Yu wrote:
> Currently there are 4 driver flags to control system suspend/resume
> behavior: DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
> DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME. Make these flags
> visible in sysfs as read-only to get a brief understanding of the
> expected behavior of each device during suspend/resume, so as to
> facilitate suspend/resume debugging/tuning.
> 
> For example:
> /sys/devices/pci0000:00/0000:00:15.1/power/driver_flags:4
> (DPM_FLAG_SMART_SUSPEND)
> 
> /sys/devices/pci0000:00/0000:00:07.3/power/driver_flags:5
> (DPM_FLAG_NO_DIRECT_COMPLETE | DPM_FLAG_SMART_SUSPEND)
> 
> Acked-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/base/power/sysfs.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

There is no Documentataion/ABI/ entry for your new file, which makes
this patch impossible to properly review by anyone, and prevents it from
being able to be accepted.

Please fix.

thanks,

greg k-h
