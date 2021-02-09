Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27831525E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 16:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhBIPHo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 10:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhBIPHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 10:07:42 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64E3C06178A;
        Tue,  9 Feb 2021 07:07:01 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 123so4311658ooi.13;
        Tue, 09 Feb 2021 07:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bjxmsAAlaEuDY9+PSLnzX23gCEFtWGdplw8kECzDAe0=;
        b=j0Lv1K0lAyO/aXssmrb2JSZHcKCXRO4dHOzcsVMzGZ65kKP2JFgGXgG/PaJsPQmWyL
         PH8Szb7vv3OS37Av5B78PgUF9qUpBk+6szQZ0Mfc8jSxBierincFetlK43SpuOzrUSix
         JDDATP8QCbQ/aXeHyIJqqZd7pJSUDfMkAMtY2cLwiTzpZBSQR2VGEVrGoEiA/22eFBBo
         +2ZJvXCwq/arwcW35AZo8Y99RUJ3pHuVD2TUi39R4P3fZW+D3AHUywDpJIcez+2zvwAw
         fDD91rMnpF03sjoHuA3XsLqaWXEjraCCqrggCHNCij4oj5FWSNRnCtWAs9gcs4N0aJNk
         ZQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bjxmsAAlaEuDY9+PSLnzX23gCEFtWGdplw8kECzDAe0=;
        b=YJIY52PEM4ulXD/cjpIJtQfHfoIPkiYCOukIwyFI4G/+FxhMVrs51yjRk5sQDco0iz
         pLzXaKIpLSq7yQZ257pRcGzizqprQmAiTYOiFQ2o8uzflnEoqiGYKAL42DLOY0EQhS/z
         +XFLy6Ck4IWtnLqVRs8ZodsxW7WmKPXFPzKcCorvcf/3/1rK4yK7mZ4tE0wniSm8rPr5
         qD+tK3EWaPPGGJnxlIPgHAbOKTwbxKDyAVN3e1hr6TECp5FlLStbQJryHDjk11Q9g3Sg
         cgJSkTxeIhjnnyzw58HyBbUhNPzAUFxBMJg0eNmFD8los4gYCiof/3AUlkn4lVZwqaKh
         tk3w==
X-Gm-Message-State: AOAM532ZyTEl8RsS3B/kVAaNRyYBXgIc9vrVHUYsHaw9adMndNOHblzF
        pJ7fuUa1r2/NHQ1cfcRiJVg=
X-Google-Smtp-Source: ABdhPJzdEtSfPGrXG09x+Nc8Hru0U15ym9pUPhGZOCl+C3Q5W19I9KAYsqOfSP9595rJ8B9hyn1HDA==
X-Received: by 2002:a4a:97a7:: with SMTP id w36mr1076981ooi.64.1612883221140;
        Tue, 09 Feb 2021 07:07:01 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p23sm4534821otk.51.2021.02.09.07.06.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 07:07:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Feb 2021 07:06:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, jdelvare@suse.com,
        giometti@enneenne.com, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, kw@linux.com, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kbuild@vger.kernel.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, prime.zeng@huawei.com,
        linuxarm@openeuler.org
Subject: Re: [PATCH v2 2/4] hwmon: Use subdir-ccflags-* to inherit debug flag
Message-ID: <20210209150658.GA31002@roeck-us.net>
References: <1612868899-9185-1-git-send-email-yangyicong@hisilicon.com>
 <1612868899-9185-3-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612868899-9185-3-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 09, 2021 at 07:08:17PM +0800, Yicong Yang wrote:
> From: Junhao He <hejunhao2@hisilicon.com>
> 
> We use ccflags-$(CONFIG_HWMON_DEBUG_CHIP) for the debug
> message in drivers/hwmon, but the DEBUG flag will not pass to
> the subdirectory.
> 
> Considering CONFIG_HWMON_DEBUG_CHIP intends to have DEBUG
> recursively in driver/hwmon. It will be clearer
> to use subdir-ccflags-* instead of ccflags-* to inherit
> the debug settings from Kconfig when traversing subdirectories,
> and it will avoid omittance of DEBUG define when debug messages
> added in the subdirectories.
> 

The above paragraph doesn't add clarity and may as well be dropped.
On the other side, the commit message still doesn't mention that
pr_debug depends on DEBUG, which I am sure many people don't know
or remember. This is the prime reason why this patch is acceptable,
so it most definitely needs to be mentioned here.

Guenter

> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/hwmon/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 09a86c5..1c0c089 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -201,5 +201,5 @@ obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
>  obj-$(CONFIG_SENSORS_OCC)	+= occ/
>  obj-$(CONFIG_PMBUS)		+= pmbus/
>  
> -ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
> +subdir-ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>  
> -- 
> 2.8.1
> 
