Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A414218570
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgGHLDW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgGHLDV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 07:03:21 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD5C08C5DC;
        Wed,  8 Jul 2020 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oKs1NW8INb5hZDk7/fI+/JTSaITHY2hLGGczbgCSe4g=; b=QPOFZPzsLlT/4uDGRXf8ntaP8
        p7ByDddo0WjIEHZNteMXE/wOFQ67hIDzR1zqA402m4BK1pil56TUnklJ38pHFkWL0+vZQW7RALtz/
        Oj54gAGu39LzgKvoa+bb1sxu83aQC/AE7YyZXLUCtygDZaLGAz5l9V3J8F+5UGO4RUmoM/KZk+iEW
        ogCLCWmUc29s85Hs8eL6FFVjgreAu4SCsRniv/lV+yg0SeoyARHCznmPDc4jhCUqnHS2aQMl1xSxr
        xRL5agm6LY2HD5EDhRoth3DiyjLb/JEEXQxnM53+GYWtRpusyv/lGRbKS8z+OBFjByAwVUQyT9De7
        QiGiRtdlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36852)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jt7qz-0007wf-6Q; Wed, 08 Jul 2020 12:03:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jt7qv-00011F-H1; Wed, 08 Jul 2020 12:03:01 +0100
Date:   Wed, 8 Jul 2020 12:03:01 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Zhang Rui <rui.zhang@intel.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] thermal: sun8i: Be loud when probe fails
Message-ID: <20200708110301.GB1551@shell.armlinux.org.uk>
References: <20200708105527.868987-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708105527.868987-1-megous@megous.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 08, 2020 at 12:55:27PM +0200, Ondrej Jirman wrote:
> I noticed several mobile Linux distributions failing to enable the
> thermal regulation correctly, because the kernel is silent
> when thermal driver fails to probe. Add enough error reporting
> to debug issues and warn users in case thermal sensor is failing
> to probe.
> 
> Failing to notify users means, that SoC can easily overheat under
> load.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 74d73be16496..9065e79ae743 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
>  
>  	calcell = devm_nvmem_cell_get(dev, "calibration");
>  	if (IS_ERR(calcell)) {
> +		dev_err(dev, "Failed to get calibration nvmem cell (%ld)\n",
> +			PTR_ERR(calcell));

Consider using:

		dev_err(dev, "Failed to get calibration nvmem cell (%pe)\n",
			calcell);

which means the kernel can print the symbolic errno value.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
