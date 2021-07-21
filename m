Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7043D1266
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 17:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbhGUOsr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 10:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238083AbhGUOsr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Jul 2021 10:48:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68F3361019;
        Wed, 21 Jul 2021 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626881363;
        bh=6Z3/WQ4Gk2tsFmqm7hmsYlmSZnfofpUun0bNut/JX3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lat3ZQjeyVszUvAcZF4IkW/6EYcIVqgM9NKp3aE/kn3oxkU8/OAPMCCfDuhU6pXWa
         RN27s+sJxIt17yXIPxK7UzPe9A4YBpGntM3xbvNWmxFg6+UGR9tWBvzjze5PS2EGqr
         HND7b7dqZrSEK8v3VWBdfPJI4HqCleCc8aPCiQxE=
Date:   Wed, 21 Jul 2021 17:29:16 +0200
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
Subject: Re: [PATCH V4 1/2] driver core: Prevent warning when removing a
 device link from unregistered consumer
Message-ID: <YPg9TBLElQqcn3PS@kroah.com>
References: <20210716114408.17320-1-adrian.hunter@intel.com>
 <20210716114408.17320-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716114408.17320-2-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 16, 2021 at 02:44:07PM +0300, Adrian Hunter wrote:
> sysfs_remove_link() causes a warning if the parent directory does not
> exist. That can happen if the device link consumer has not been registered.
> So do not attempt sysfs_remove_link() in that case.
> 
> Fixes: 287905e68dd29 ("driver core: Expose device link details in sysfs")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # 5.9+
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
>  drivers/base/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index ea5b85354526..2de8f7d8cf54 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -575,8 +575,10 @@ static void devlink_remove_symlinks(struct device *dev,
>  		return;
>  	}
>  
> -	snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
> -	sysfs_remove_link(&con->kobj, buf);
> +	if (device_is_registered(con)) {
> +		snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
> +		sysfs_remove_link(&con->kobj, buf);
> +	}
>  	snprintf(buf, len, "consumer:%s:%s", dev_bus_name(con), dev_name(con));
>  	sysfs_remove_link(&sup->kobj, buf);
>  	kfree(buf);
> -- 
> 2.17.1
> 

I've applied this patch to my tree now.

thanks,

greg k-h
