Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9321B2D8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGJJ7z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 05:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgGJJ7z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 05:59:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFFC420767;
        Fri, 10 Jul 2020 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594375194;
        bh=c2o9Ui1ExEnEWh2k/NGuOvS6UjKlqtY1Sr48fn0/nSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LH0FwLaCFNJCJFuRGPFJSJJjL67w3zcgve3YAJpaFdpUzXXILpBk7qDcE5r38ypU1
         Nv5C5EvinHbNDEQRNLH0bl/kRhbfGAtYgfmv18Sbdos62R/IwLnnUJiKpL6O//Hm/r
         rvHd+XTnX+kBtTJ9f7eZDBsGmTu4I85fygX1RxMY=
Date:   Fri, 10 Jul 2020 11:59:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH 1/5] power: supply: core: add quick charge type property
Message-ID: <20200710095959.GA1197607@kroah.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710084841.1933254-1-yanziily@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 04:48:37PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports the kind of quick charge type based on
> different adapter power. UI will show different
> animation effect for different quick charge type.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 216d61a22f1e..0d9d6b46e239 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -708,3 +708,13 @@ Description:
>  
>  		Access: Read
>  		Valid values: 1-31
> +
> +What:		/sys/class/power_supply/<supply_name>/quick_charge_type
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +		Description:
> +		Reports the kind of quick charge type based on different adapter power.
> +
> +		Access: Read-Only
> +		Valid values: "QUICK_CHARGE_NORMAL", "QUICK_CHARGE_FAST", "QUICK_CHARGE_FLASH",
> +		"QUICK_CHARGE_TURBE", "QUICK_CHARGE_SUPER".

"QUICK_CHARGE_TURBO"?

> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index bc79560229b5..f95574c41898 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -206,6 +206,7 @@ static struct power_supply_attr power_supply_attrs[] = {
>  	POWER_SUPPLY_ATTR(MODEL_NAME),
>  	POWER_SUPPLY_ATTR(MANUFACTURER),
>  	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
> +	POWER_SUPPLY_ATTR(quick_charge_type),

Shouldn't this be all uppercase:
	QUICK_CHARGE_TYPE
?

And shouldn't there be a string with the expected values somewhere?

thanks,

greg k-h
