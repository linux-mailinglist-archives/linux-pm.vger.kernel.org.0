Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750EE21B2E3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 12:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgGJKBX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 06:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgGJKBX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 06:01:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EFF820767;
        Fri, 10 Jul 2020 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594375283;
        bh=MxzhXqysRC2Q2wIhDKrEdVSYCa8BbaAT4kiEWoq8QiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ch+4C/sGMSWrYCVW2W1VaAnPz2KGzTnJ3KI2ebPsfsVCsYQeB9XNU8uk7WS2GwsAF
         mjY37YMqrbgt8dFEUnzIEtP0/yZ40QRqIpfvJp1U12Mb42VxEKq2g19g4RyVqrhkg/
         QF+34hiIBDppaRZioG3t17+cmLS1RDkTK0847kZw=
Date:   Fri, 10 Jul 2020 12:01:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH 4/5] power: supply: core: property to control reverse
 charge
Message-ID: <20200710100128.GD1197607@kroah.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
 <20200710084841.1933254-4-yanziily@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710084841.1933254-4-yanziily@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 04:48:40PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Interface to control wireless reverse charge.
> Supply reverse charge function when enabled.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 13 ++++++++++++-
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 1f42aa0c071e..1f489a250c19 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -737,4 +737,15 @@ Date:		Jul 2020
>  Contact:	Fei Jiang <jiangfei1@xiaomi.com>
>  Description:
>  		Reports wireless signal strength.
> -		The value show degree of coupling.
> \ No newline at end of file
> +		The value show degree of coupling.
> +What:		/sys/class/power_supply/<supply_name>/reverse_chg_mode
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +Description:
> +		The property supply interface to control wireless
> +		reverse charge mode.
> +
> +		Valid values:
> +		- 1: enabled
> +		- 0: disabled
> +
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 42fbe1b68255..4be762abba89 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -209,6 +209,7 @@ static struct power_supply_attr power_supply_attrs[] = {
>  	POWER_SUPPLY_ATTR(quick_charge_type),
>  	POWER_SUPPLY_ATTR(tx_adapter),
>  	POWER_SUPPLY_ATTR(signal_strength),
> +	POWER_SUPPLY_ATTR(reverse_chg_mode),

Again, uppercase for all of these?

thanks,

greg k-h
