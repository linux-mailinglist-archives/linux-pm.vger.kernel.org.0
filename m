Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6138A21D1F5
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 10:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgGMImD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 04:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgGMImD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jul 2020 04:42:03 -0400
Received: from localhost (unknown [84.241.194.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 430ED2065D;
        Mon, 13 Jul 2020 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594629723;
        bh=LB10Hpmj34rIYqpojE3tjMY5Wd0jXgunZo/7a/Bdx4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBsrH+ChkJC1OsMwtxYqPtV4cdidDnE9+YMOyB83YvCXN0N3eNk/yqMpqeim6xS16
         Ji8yD26y/SmIgXaUrPhlPKUJkgOtrU2wjOA9rEuxoI9846VYCw+js05Vm3RGUlSGFB
         N/ANtkAKuMF7PmEtPMpizPaFGfQfGAxx0HtjHNPM=
Date:   Mon, 13 Jul 2020 10:42:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v2 2/5] power: supply: core: add wireless charger adapter
 type property
Message-ID: <20200713084200.GD215949@kroah.com>
References: <cover.1594612572.git.huangqiwu@xiaomi.com>
 <b20548fc825241c69878bfb05464b0e4f378f4ce.1594612572.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b20548fc825241c69878bfb05464b0e4f378f4ce.1594612572.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 13, 2020 at 12:03:37PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports what type of wireless adapter connection is
> currently active forthe supply.
> for example it can show if ADAPTER_PD capable source is attached.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 11 +++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index d3169d47e359..cd07d3f4e8b1 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -718,3 +718,14 @@ Contact:	Fei Jiang <jiangfei1@xiaomi.com>
>  		Access: Read-Only
>  		Valid values: Reported as integer
>  
> +===== Wireless Charger Properties =====
> +What:		/sys/class/power_supply/<supply_name>/tx_adapter
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +Description:
> +		Reports what type of wireless adapter connection is currently active for
> +		the supply, for example it can show if ADAPTER_PD capable source
> +		is attached.

Same question as before, what are the allowed types here?

> +
> +		Access: Read-Only
> +		Valid values: Reported as integer

What integer maps to what values?

thanks,

greg k-h
