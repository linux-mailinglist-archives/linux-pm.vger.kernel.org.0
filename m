Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5BB21D20C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 10:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGMIoY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 04:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgGMIoX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jul 2020 04:44:23 -0400
Received: from localhost (unknown [84.241.194.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F9A82065D;
        Mon, 13 Jul 2020 08:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594629863;
        bh=KUdb4nh41mZvjlnlcASUhBfHECGZowa9Yivz08Vx3c0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VIlENMKrtnWBKZlCO6EVwM2WrgbGAkj8finWzrL4GnFY8kjCPVIKika9QBfPMkyPk
         wZatrsBZv9oRcEz1zY2xiRtUnbM+/7Lx0VPDIQY5jOVbfhuU0Vv6WuGzYpuVxQ0ESM
         RxDvujEwgIY+t7D2H5dbk8Egv3Fkb1GQ/djKpTvE=
Date:   Mon, 13 Jul 2020 10:44:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v2 5/5] power: supply: core: supply battery soc with
 decimal form
Message-ID: <20200713084420.GE215949@kroah.com>
References: <cover.1594612572.git.huangqiwu@xiaomi.com>
 <d7b0e268892b6143e537cf823d3a74214f6e6b1c.1594612572.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7b0e268892b6143e537cf823d3a74214f6e6b1c.1594612572.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 13, 2020 at 12:03:40PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Broadcast battery soc with decimal form.
> soc_decimal is the decimal part of battery soc.
> soc_decimal_rate is update frequency of decimal
> part of battery soc.
> We want to report such as 0.01 to 99.99% to
> user space to improve user experience
> when do very quick charging.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  2 ++
>  include/linux/power_supply.h                |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index f4234ba1684a..bcc8ccad8163 100644
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
> +		Valid values: 0 - 100

How can "100" be a valid decimal form here if this is a percent?


> +
> +What:		/sys/class/power_supply/<supply_name>/soc_decimal_rate,
> +Date:		Jul 2020
> +Contact:	jiangfei1@xiaomi.com
> +Description:
> +		Broadcast battery soc with decimal form.
> +		soc_decimal_rate is the decimal part of battery soc update freqency.
> +
> +		Access: Read
> +		Valid values: 0 - 100

I think you need to document this a lot better as I still don't really
understand what this is for or how to use it or report it.

And what does "soc" mean here?

thanks,

greg k-h
