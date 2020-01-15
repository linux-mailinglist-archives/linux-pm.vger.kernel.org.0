Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797B113C829
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAOPmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 10:42:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35946 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgAOPmP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 10:42:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so13062167lfe.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 07:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=N8b+H5+4AZUL8IrGlHZ9KVMloMXldascwYgfWlKN9rE=;
        b=FdYmDlvQrDy1LEQoaENUdqQc5r3i7VCErTzZ5eHAyDXArk/GW99jkbp7T/Mxjk+CG5
         SBO4KnwzdCUIyGt6JV6AdRoxJFp1eVMUJMitA7oIj0LPDMFAhG6SktRL6shLejMecolJ
         RNf+yvdk+EcEmv89u84BAdIxqY6qt/udZVFDgOdC4nHiuekLe/06CWxUyaKL+AFPoM8w
         GqHLhnocT6dX9ydIprR4NVtLzNqnbWO7GY1L+fzMKUl0LPNlQ1Ga+enLfzmcwAk7YC4j
         GfKHXJAQBo9oZP4QqL1b03SoNylfIePIRZZLMJQmcOsmbTR8HAOcM5imRIIFSdmEOZAW
         3trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N8b+H5+4AZUL8IrGlHZ9KVMloMXldascwYgfWlKN9rE=;
        b=VoshyLja27lN8pI/m/IR/umMapFl/5/hcvQLBHYyDZlrkEssiGtl80QDHn0UhpWM92
         YQ5gLXuHj1WNYFLV2xo+r9si0AU8/HW/sryM9HgMr8P4wTkFcZcGSEcZCqONFc1jtedo
         FsYioTMwfgTQJnIZjCqNC/VrfiPXeaNrfko4rD9fZD0uxAP8dW0Kh93JmbQNADbvC9rS
         5vOYLMUguN5NblkEJ1Ab7y99FCfTBBPS5s21qYqkN3ZnoCoA2C6l03kqaEZhcqsWOPi+
         qlzlQHohfy+ZpxyZNyXJ0+ldctq4bsocWN6BxTTQ0dtM6ATiGdPHbnF+JfHQV4FWUoK6
         nz9w==
X-Gm-Message-State: APjAAAU1mWPjjUIu/pnYI6/fpwpz98Fi2lPQC38PXI1bLWEH8DVSXy4Z
        JqjBTyy0H1hd2lI75LMghynRAOWNin0=
X-Google-Smtp-Source: APXvYqzYfC/bkCYczOz0Rbf8DDPIo53usGVtIxNysW7JZRLyBZmcO/JlAzaVVBNPrSuP94EewnXcPA==
X-Received: by 2002:ac2:5503:: with SMTP id j3mr5100238lfk.104.1579102932939;
        Wed, 15 Jan 2020 07:42:12 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id g85sm9118361lfd.66.2020.01.15.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:42:12 -0800 (PST)
Date:   Wed, 15 Jan 2020 16:42:12 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] mtd: maps: physmap: Add minimal Runtime PM support
Message-ID: <20200115154212.GA977577@oden.dyn.berto.se>
References: <20200115131323.6883-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115131323.6883-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2020-01-15 14:13:23 +0100, Geert Uytterhoeven wrote:
> Add minimal runtime PM support (enable on probe, disable on remove), to
> ensure proper operation with a parent device that uses runtime PM.
> 
> This is needed on systems where the FLASH is connected to a bus
> controller that is contained in a PM domain and/or has a gateable
> functional clock.  In such cases, before accessing any device connected
> to the external bus, the PM domain must be powered up, and/or the
> functional clock must be enabled, which is typically handled through
> runtime PM by the bus controller driver.
> 
> An example of this is the Renesas APE6-EVM development board, which has
> an Ethernet controller and a CFI FLASH connected to the Bus State
> Controller (BSC) of an R-Mobile APE6 SoC.
> As long as the Ethernet driver, which had Runtime PM support since
> commit 3a611e26e958b037 ("net/smsc911x: Add minimal runtime PM
> support"), keeps the BSC powered, accessing the FLASH works.
> When the ethernet node in r8a73a4-ape6evm.dts is disabled, the BSC is
> never powered up, and the kernel crashes when trying to access the
> FLASH:
> 
>     Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>     pgd = (ptrval)
>     [00000000] *pgd=7fef2835
>     Internal error: : 1406 [#1] SMP ARM
>     CPU: 0 PID: 122 Comm: hd Tainted: G        W         5.5.0-rc1-ape6evm-00814-g38ca966db25b9dbd-dirty #136
>     Hardware name: Generic R8A73A4 (Flattened Device Tree)
>     PC is at chip_ready+0x12c/0x380
>     LR is at chip_ready+0x10c/0x380
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Probably the device should be powered down after probing, and powered
> up/down on-demand in the various {get,put}_chip() functions.  However,
> that is an optimization which touches more intimidate details of the
> internal MTD API, and can be done later.
> ---
>  drivers/mtd/maps/physmap-core.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
> index a9f7964e2edb6668..8f7f966fa9a7ee8a 100644
> --- a/drivers/mtd/maps/physmap-core.c
> +++ b/drivers/mtd/maps/physmap-core.c
> @@ -38,6 +38,7 @@
>  #include <linux/mtd/cfi_endian.h>
>  #include <linux/io.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/gpio/consumer.h>
>  
>  #include "physmap-gemini.h"
> @@ -64,16 +65,16 @@ static int physmap_flash_remove(struct platform_device *dev)
>  {
>  	struct physmap_flash_info *info;
>  	struct physmap_flash_data *physmap_data;
> -	int i, err;
> +	int i, err = 0;
>  
>  	info = platform_get_drvdata(dev);
>  	if (!info)
> -		return 0;
> +		goto out;
>  
>  	if (info->cmtd) {
>  		err = mtd_device_unregister(info->cmtd);
>  		if (err)
> -			return err;
> +			goto out;
>  
>  		if (info->cmtd != info->mtds[0])
>  			mtd_concat_destroy(info->cmtd);
> @@ -88,7 +89,10 @@ static int physmap_flash_remove(struct platform_device *dev)
>  	if (physmap_data && physmap_data->exit)
>  		physmap_data->exit(dev);
>  
> -	return 0;
> +out:
> +	pm_runtime_put(&dev->dev);
> +	pm_runtime_disable(&dev->dev);
> +	return err;
>  }
>  
>  static void physmap_set_vpp(struct map_info *map, int state)
> @@ -484,13 +488,19 @@ static int physmap_flash_probe(struct platform_device *dev)
>  		return -EINVAL;
>  	}
>  
> +	pm_runtime_enable(&dev->dev);
> +	pm_runtime_get_sync(&dev->dev);
> +
>  	if (dev->dev.of_node)
>  		err = physmap_flash_of_init(dev);
>  	else
>  		err = physmap_flash_pdata_init(dev);
>  
> -	if (err)
> +	if (err) {
> +		pm_runtime_put(&dev->dev);
> +		pm_runtime_disable(&dev->dev);
>  		return err;
> +	}
>  
>  	for (i = 0; i < info->nmaps; i++) {
>  		struct resource *res;
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
