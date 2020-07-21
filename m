Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C1E227A89
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGUIVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 04:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGUIVU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jul 2020 04:21:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9205720720;
        Tue, 21 Jul 2020 08:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595319680;
        bh=47k5aup1aXT1zMH3tH7/4fi4e3IvHVWxQa3HfzqrMDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1uelKJLZv+vYgaCIPNvkbzC9Ll2XoFHXW+f8T1U7kZ+d9eYMT368ZQliT7osFSOOn
         /v0COt4qkjjEv/+jcKYsVSabqPWva9tAEJb/2/WDP0K0I0ijDGSjWvKl9UvBq54lzu
         mqOchN/MFgsvHMe8scpLVuHek/a6FR6SFL0f5gdY=
Date:   Tue, 21 Jul 2020 10:21:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v5 4/4] power: supply: core: property to control reverse
 charge
Message-ID: <20200721082128.GE1655283@kroah.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
 <f58e4cc6f5235d463d96c950f2af2b9a47920e9d.1595301250.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f58e4cc6f5235d463d96c950f2af2b9a47920e9d.1595301250.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 21, 2020 at 01:59:37PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Interface to control wireless reverse charge.
> Supply reverse charge function when enabled.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 12 ++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 75ec7de2fe78..54647d6995d3 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -767,3 +767,15 @@ Description:
>  
>  		Access: Read-Only
>  		Valid values: 0 - 100
> +
> +What:		/sys/class/power_supply/<supply_name>/reverse_chg_mode
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +Description:
> +		Some phones support wireless reverse charge function which charge other phones.

Replace "phones" with "devices"?

And shouldn't these lines be wrapped properly at 72 colums or so?

> +		The property supply interface to control wireless reverse charge.

I can't understand this sentance.

> +		If enabled, start TX mode and detect RX. Disabled when timeout or manual setting.

Can this be set, or is it just something to be read?

thanks,

greg k-h
