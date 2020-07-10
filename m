Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A4D21B2E7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgGJKCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 06:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgGJKCa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 06:02:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0411120767;
        Fri, 10 Jul 2020 10:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594375349;
        bh=SmR6IT/MXuWfxOORNO/V7HwSFJmde+X24ehDnQuOjqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1UODG4kVvfnXKbSDxe5R2sDEHzP5au7UR5rexgFCTvd+qDsY1rPSoWr9uwf/WwCO
         gMhBwLpb4QL3Esk+CwDnKdsgdeqCokzvlx5ecKZrMeg7tJ7L1kL+KmG3RWyN4HjEXa
         aY6mB6S1OJMy42lNN4AgmnJRcLG4fthRfpqXW3a4=
Date:   Fri, 10 Jul 2020 12:02:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH 5/5] power: supply: core: supply battery soc with decimal
 form
Message-ID: <20200710100233.GE1197607@kroah.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
 <20200710084841.1933254-5-yanziily@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710084841.1933254-5-yanziily@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 04:48:41PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Broadcast battery soc with decimal form.
> soc_decimal is the decimal part of battery soc.
> soc_decimal_rate is update frequency of decimal
> part of battery soc.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  2 ++
>  include/linux/power_supply.h                |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 1f489a250c19..60c5a0dd1b98 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -349,6 +349,26 @@ Description:
>  		Access: Read
>  		Valid values: Represented in microvolts
>  
> +What:		/sys/class/power_supply/<supply_name>/soc_decimal,
> +Date:		Jul 2020
> +Contact:	jiangfei1@xiaomi.com
> +Description:
> +		Broadcast battery soc with decimal form.
> +		soc_decimal is the start decimal part of battery soc.
> +
> +		Access: Read
> +                Valid values: 0 - 100
> +
> +What:		/sys/class/power_supply/<supply_name>/soc_decimal_rate,
> +Date:		Jul 2020
> +Contact:	jiangfei1@xiaomi.com
> +Description:
> +		Broadcast battery soc with decimal form.
> +		soc_decimal_rate is the decimal part of battery soc update freqency.
> +
> +		Access: Read
> +                Valid values: 0 - 100

Why doesn't the existing battery attribute work for this?

Why can't this just be a new battery in the system and why just a single
attribute?

> +
>  ===== USB Properties =====
>  
>  What: 		/sys/class/power_supply/<supply_name>/current_avg
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 4be762abba89..8defc22e0d7f 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -210,6 +210,8 @@ static struct power_supply_attr power_supply_attrs[] = {
>  	POWER_SUPPLY_ATTR(tx_adapter),
>  	POWER_SUPPLY_ATTR(signal_strength),
>  	POWER_SUPPLY_ATTR(reverse_chg_mode),
> +	POWER_SUPPLY_ATTR(soc_decimal),
> +	POWER_SUPPLY_ATTR(soc_decimal_rate),

Again, uppercase?

thanks,

greg k-h
