Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707BD280B47
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 01:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbgJAXUD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 19:20:03 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54832 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgJAXUC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2020 19:20:02 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 44E3A60;
        Fri,  2 Oct 2020 01:20:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1601594400;
        bh=rfIIQwVRd/AeRqJEFC4VlBko7IIup6fEBhePqztkIR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D39RLFAyWjqKwgTPH1a8EHsX07hOSfHzj62ZmTqxirfGmrvGP/bNc+NtszXhl6VkN
         s/2MWQTd2wrRkETjQru4rieOG9kAhy0ON8UMTzUYGrqnlM0cL7JGAsCd5S7c/Yz0tb
         zIcNp663oGEWjRaTK/g4LECn89v68Mj7AMAsS75s=
Date:   Fri, 2 Oct 2020 02:19:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
        peter.ujfalusi@ti.com, rjw@rjwysocki.net, tomi.valkeinen@ti.com,
        tony@atomide.com, ulf.hansson@linaro.org, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
Message-ID: <20201001231922.GG3722@pendragon.ideasonboard.com>
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001225952.3676755-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

Thank you for the patch.

On Thu, Oct 01, 2020 at 03:59:51PM -0700, Saravana Kannan wrote:
> When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> adding all top level devices") optimized the fwnode parsing when all top
> level devices are added, it missed out optimizing this for platform
> where the top level devices are added through the init_machine() path.
> 
> This commit does the optimization for all paths by simply moving the
> fw_devlink_pause/resume() inside of_platform_default_populate().

Based on v5.9-rc5, before the patch:

[    0.652887] cpuidle: using governor menu
[   12.349476] No ATAGs?

After the patch:

[    0.650460] cpuidle: using governor menu
[   12.262101] No ATAGs?

:-(

> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/platform.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 071f04da32c8..79972e49b539 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -501,8 +501,21 @@ int of_platform_default_populate(struct device_node *root,
>  				 const struct of_dev_auxdata *lookup,
>  				 struct device *parent)
>  {
> -	return of_platform_populate(root, of_default_bus_match_table, lookup,
> -				    parent);
> +	int ret;
> +
> +	/*
> +	 * fw_devlink_pause/resume() are only safe to be called around top
> +	 * level device addition due to locking constraints.
> +	 */
> +	if (!root)
> +		fw_devlink_pause();
> +
> +	ret = of_platform_populate(root, of_default_bus_match_table, lookup,
> +				   parent);
> +
> +	if (!root)
> +		fw_devlink_resume();
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_platform_default_populate);
>  
> @@ -538,9 +551,7 @@ static int __init of_platform_default_populate_init(void)
>  	}
>  
>  	/* Populate everything else. */
> -	fw_devlink_pause();
>  	of_platform_default_populate(NULL, NULL, NULL);
> -	fw_devlink_resume();
>  
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart
