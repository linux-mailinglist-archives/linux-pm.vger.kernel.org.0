Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5011863BF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 04:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgCPDiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 23:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729383AbgCPDiH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 23:38:07 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CAEE205ED;
        Mon, 16 Mar 2020 03:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584329886;
        bh=0VZ0auaUnnxnmEvkvSQZVjExN3L/Ybt8ODLBIb6CQ/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vE7+fh6ob4BmhTho9ZwlDoDnDIGReEj1f07eRH4bog7bDD6dIFkrc98DP7R5iGq7g
         07MKoTtoCemvU4U+BklAP5n/9n0R78Ff8PMkEMgXvjzArTIxkaEs7ujgutpLOzD20r
         9Ksj744AXEEe5vg1xLW2iCAyvvoIeZrBqJX0rU2s=
Date:   Mon, 16 Mar 2020 11:37:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        dmitry.torokhov@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        wim@linux-watchdog.org, linux@roeck-us.net, daniel.baluta@nxp.com,
        gregkh@linuxfoundation.org, linux@rempel-privat.de,
        tglx@linutronix.de, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de,
        ronald@innovation.ch, krzk@kernel.org, robh@kernel.org,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 2/7] firmware: imx: add COMPILE_TEST support
Message-ID: <20200316033752.GF17221@dragon>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <1583714300-19085-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583714300-19085-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 09, 2020 at 08:38:15AM +0800, Anson Huang wrote:
> Add COMPILE_TEST support to i.MX SCU drivers for better compile
> testing coverage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  drivers/firmware/imx/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index 1d2e5b8..116707a 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -12,7 +12,7 @@ config IMX_DSP
>  
>  config IMX_SCU
>  	bool "IMX SCU Protocol driver"
> -	depends on IMX_MBOX
> +	depends on IMX_MBOX || COMPILE_TEST
>  	help
>  	  The System Controller Firmware (SCFW) is a low-level system function
>  	  which runs on a dedicated Cortex-M core to provide power, clock, and
> @@ -24,6 +24,6 @@ config IMX_SCU
>  
>  config IMX_SCU_PD
>  	bool "IMX SCU Power Domain driver"
> -	depends on IMX_SCU
> +	depends on IMX_SCU || COMPILE_TEST

Just reminded by Peng, as we go without adding stubs for !IMX_SCU, any
driver depending on IMX_SCU shouldn't have COMPILE_TEST.  I fixed it up
by dropping COMPILE_TEST from IMX_SCU_PD.

Shawn

>  	help
>  	  The System Controller Firmware (SCFW) based power domain driver.
> -- 
> 2.7.4
> 
