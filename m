Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EA521B2E0
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 12:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgGJKBB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 06:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgGJKBB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 06:01:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC4520775;
        Fri, 10 Jul 2020 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594375261;
        bh=kOJc9WhNOM98kpWorCDKyqHEtzGaX9W9kQLh46fkPMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PX/99WvFuMWtVbE1zBdnuj4yudB9WY8DHvBlJ5+0jMoVerE52crOcsGmYht9pdhhM
         u1YIfQ4HAzGDrWGdmFwxmmmAYPM/OfubPy1L46CimGYUKuMxpdJeOxAPc5VmXskHtj
         GOl61RL4NCHb3f1CJCD0aDMdBGY/1F/TUjknv+Wc=
Date:   Fri, 10 Jul 2020 12:01:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH 3/5] power: supply: core: add wireless signal strength
 property
Message-ID: <20200710100106.GC1197607@kroah.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
 <20200710084841.1933254-3-yanziily@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710084841.1933254-3-yanziily@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 04:48:39PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> reports wireless signal strength.
> The value show degree of coupling between tx and rx.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 9 ++++++++-
>  drivers/power/supply/power_supply_sysfs.c   | 1 +
>  include/linux/power_supply.h                | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 2099cf194a89..1f42aa0c071e 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -730,4 +730,11 @@ Description:
>  
>  		Access: Read-Only
>  		Valid values: "ADAPTER_NONE", "ADAPTER_SDP", "ADAPTER_DCP", "ADAPTER_CDP",
> -		"ADAPTER_QC2", "ADAPTER_QC3", "ADAPTER_PD" or other private adapter.
> \ No newline at end of file
> +		"ADAPTER_QC2", "ADAPTER_QC3", "ADAPTER_PD" or other private adapter.
> +
> +What:		/sys/class/power_supply/<supply_name>/signal_strength
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +Description:
> +		Reports wireless signal strength.
> +		The value show degree of coupling.

What units are this in?  The "value" means what?

thanks,

greg k-h
