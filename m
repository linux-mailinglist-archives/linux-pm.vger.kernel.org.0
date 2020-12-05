Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1349C2CFAB7
	for <lists+linux-pm@lfdr.de>; Sat,  5 Dec 2020 10:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgLEI70 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 03:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgLEI7D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 5 Dec 2020 03:59:03 -0500
Date:   Sat, 5 Dec 2020 09:58:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607158692;
        bh=OPnvh6xw/Wh34g8mmY0Yjnso2AhGwtYHnzQkQdspIKk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=To1bkxWonyeZ8wsIeKP3GXeTRZxfRiIRc4Whn1hAWkMhKR5+MCYmbTshwsLm+arDI
         3riJEhz2fzfDh3Al2f+WmhO38i46Rn8dIuvEEkYimRIEq7PIScytzVpdDAB4d31QpR
         zzr9JhaEACKdu91v+EWAsF1wM6Ge4SyB81uKU+Xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Strudel <tstrudel@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PM: domains: create debugfs nodes when adding power
 domains
Message-ID: <X8tLoJ5Jl98EFLCo@kroah.com>
References: <20201205005716.307137-1-tstrudel@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205005716.307137-1-tstrudel@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 04, 2020 at 04:57:16PM -0800, Thierry Strudel wrote:
> debugfs nodes were created in genpd_debug_init alled in late_initcall
> preventing power domains registered though loadable modules to have
> a debugfs entry.
> 
> Create/remove debugfs nodes when the power domain is added/removed
> to/from the internal gpd_list.
> 
> Signed-off-by: Thierry Strudel <tstrudel@google.com>
> ---
> v2: fix forward declaration and genpd_debugfs_dir being NULL - Ulf
> v3: remove extra trailing char added by mistake in v2 - kernel test robot 
>  drivers/base/power/domain.c | 83 ++++++++++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 743268996336..3e40ef5cd9ab 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -24,6 +24,16 @@
>  
>  #include "power.h"
>  
> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/pm.h>
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/init.h>
> +#include <linux/kobject.h>

Why do you need all of these files included for debugfs stuff?

And why put it in a #ifdef at all?  Include files are not normally gated
that way.

> +static struct dentry *genpd_debugfs_dir;

That's the variable you want to only have declared or not, just #ifdef
for this :)

thanks,

greg k-h
