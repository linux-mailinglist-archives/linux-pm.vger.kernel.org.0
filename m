Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 327A77F287
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 11:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405149AbfHBJt1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Aug 2019 05:49:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64240 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405137AbfHBJt0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2019 05:49:26 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id e1982bc9eb5b63f9; Fri, 2 Aug 2019 11:49:24 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] power: supply: Init device wakeup after device_add()
Date:   Fri, 02 Aug 2019 11:49:24 +0200
Message-ID: <5888477.sfNfyo0UZj@kreacher>
In-Reply-To: <20190801213330.81079-1-swboyd@chromium.org>
References: <20190801213330.81079-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, August 1, 2019 11:33:30 PM CEST Stephen Boyd wrote:
> We may want to use the device pointer in device_init_wakeup() with
> functions that expect the device to already be added with device_add().
> For example, if we were to link the device initializing wakeup to
> something in sysfs such as a class for wakeups we'll run into an error.
> It looks like this code was written with the assumption that the device
> would be added before initializing wakeup due to the order of operations
> in power_supply_unregister().
> 
> Let's change the order of operations so we don't run into problems here.
> 
> Fixes: 948dcf966228 ("power_supply: Prevent suspend until power supply events are processed")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>                                                                                                                      
> Cc: Tri Vo <trong@android.com>                                                                                                                                             
> Cc: Kalesh Singh <kaleshsingh@google.com>      
> Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> See this thread[1] for more information on how this will be necessary.
> 
> [1] https://lkml.kernel.org/r/20190731215514.212215-1-trong@android.com
> 
> 
>  drivers/power/supply/power_supply_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 82e84801264c..5c36c430ce8b 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1051,14 +1051,14 @@ __power_supply_register(struct device *parent,
>  	}
>  
>  	spin_lock_init(&psy->changed_lock);
> -	rc = device_init_wakeup(dev, ws);
> -	if (rc)
> -		goto wakeup_init_failed;
> -
>  	rc = device_add(dev);
>  	if (rc)
>  		goto device_add_failed;
>  
> +	rc = device_init_wakeup(dev, ws);
> +	if (rc)
> +		goto wakeup_init_failed;
> +
>  	rc = psy_register_thermal(psy);
>  	if (rc)
>  		goto register_thermal_failed;
> @@ -1101,8 +1101,8 @@ __power_supply_register(struct device *parent,
>  	psy_unregister_thermal(psy);
>  register_thermal_failed:
>  	device_del(dev);
> -device_add_failed:
>  wakeup_init_failed:
> +device_add_failed:
>  check_supplies_failed:
>  dev_set_name_failed:
>  	put_device(dev);
> 

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>




