Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7749621B2DE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGJKAd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 06:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbgGJKAd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 06:00:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556F220767;
        Fri, 10 Jul 2020 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594375232;
        bh=wfOjbdLmDRRq6sS+T74nRU6/o+uCYi86CN57IhaKxvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsjnfvPdkorgc+lmepmJcD2m1t1QVnCHQfE219nCtEMGf84BVhaIRFJ3qdzTnzTVa
         22fYTX5s+Vj/zKmJY+Yvmn8T9e2NRR2iwAIcDqgYD/l11//lDlI+7uBFLkuYYxz553
         eJbX+bMPZSmHl8eRSMEZraLUTMTdIhcbzt9Yx/qo=
Date:   Fri, 10 Jul 2020 12:00:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH 2/5] power: supply: core: add wireless charger adapter
 type property
Message-ID: <20200710100037.GB1197607@kroah.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
 <20200710084841.1933254-2-yanziily@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710084841.1933254-2-yanziily@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 04:48:38PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports what type of wireless adapter connection is
> currently active forthe supply.
> for example it can show if ADAPTER_PD capable source is attached.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 13 +++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 0d9d6b46e239..2099cf194a89 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -718,3 +718,16 @@ Contact:	Fei Jiang <jiangfei1@xiaomi.com>
>  		Access: Read-Only
>  		Valid values: "QUICK_CHARGE_NORMAL", "QUICK_CHARGE_FAST", "QUICK_CHARGE_FLASH",
>  		"QUICK_CHARGE_TURBE", "QUICK_CHARGE_SUPER".
> +
> +===== Wireless Charger Properties =====
> +What:		/sys/class/power_supply/<supply_name>/tx_adapter
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +Description:
> +		Reports what type of wireless adapter connection is currently active for
> +		the supply, for example it can show if ADAPTER_PD capable source
> +		is attached.
> +
> +		Access: Read-Only
> +		Valid values: "ADAPTER_NONE", "ADAPTER_SDP", "ADAPTER_DCP", "ADAPTER_CDP",
> +		"ADAPTER_QC2", "ADAPTER_QC3", "ADAPTER_PD" or other private adapter.

Why are these strings not in the patch as well?

> \ No newline at end of file
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index f95574c41898..c864a14829ec 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -207,6 +207,7 @@ static struct power_supply_attr power_supply_attrs[] = {
>  	POWER_SUPPLY_ATTR(MANUFACTURER),
>  	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
>  	POWER_SUPPLY_ATTR(quick_charge_type),
> +	POWER_SUPPLY_ATTR(tx_adapter),

upper case?

thanks,

greg k-h
