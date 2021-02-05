Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F64311018
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 19:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhBEQ4e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 11:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhBEQsW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 11:48:22 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6FAC0611C3;
        Fri,  5 Feb 2021 10:28:35 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id y21so1850754oot.12;
        Fri, 05 Feb 2021 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m24jKGGmGki3qeVOM6zz/wESINDsCmuIsOMA9QLVHHY=;
        b=nY7/EII8giBI27YgK2N32iOY7orsIskuUmQAmyFa9eEyds7Hw+Ww2IEzZj1XZDhdbp
         zQyMRL3A1Coc/q9SaFq/0NUKmTkdC0PLu1GRtfHbjbBQrIQTfQfnwMiBi5LRwFODyI4g
         ITA1QCMAoOGkxgRrnOaS8n6LtCqxekZEr7X75x9UsmBdFzf6sNcQZNZxQWb7ptTiHG4M
         yl/puPyK5Q09SGNKwS1Y7dZuYlBVE14mGxGKs4jrEawSr3xJBLDArtlppWFGK4XkJ6Bi
         PflvEkc+Nf/OTWSt2oTLvE7MFAR/68JMkyH7M9tW5BVgk1pqdvKVggKr7I33WcRKzgz/
         RTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m24jKGGmGki3qeVOM6zz/wESINDsCmuIsOMA9QLVHHY=;
        b=siiqd/AHJQ2ysECsalLPtP2qBYWzDLOW++Oz5mZqS+1OPU0bY4rwhkfAIOKQqx1D4/
         2rSpKDUvIewLVi2RnutwTvtixKMskpEsQbzEmfaGV8Q6/23vpbjcSKaxsIZKuU4+yrJN
         n/KpHPmgFEr5Xr6t+AlDVuyQWFi/YhFdoMo1FzNICBp0O23C2JHBp7ljZ7rn4itpuDT1
         E6GBjPfBFXeCT1Vqj93wY2rBFDye2eSVF3sUAiVn3DxX0iXnI3+AXSoBHyaFIIlXEc/0
         c5usskd3+VHAqj4gIGpaAHP21txv431d9ws1JD+gd99dfvV1Y4YBsOvS6tNRv6PwgdEa
         w86A==
X-Gm-Message-State: AOAM5319oXvPd6Z2nQ4eBRtjuZFdcSnlO88fI0b6sg5KHBQBs6R/xOj8
        FcFr1YNoolhvIzJ/cYJ24ivDyZV88Ww=
X-Google-Smtp-Source: ABdhPJyE2MF8OFOaDmpo0vh7Eo2L1g2amAJPTfQqAlqkEqPU8XrD8rxQEXHiuZfPi83S4TSCbsj/zQ==
X-Received: by 2002:a4a:aa8b:: with SMTP id d11mr952667oon.36.1612549714774;
        Fri, 05 Feb 2021 10:28:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d127sm1951329oib.26.2021.02.05.10.28.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Feb 2021 10:28:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 5 Feb 2021 10:28:32 -0800
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
Subject: Re: [PATCH 2/4] hwmon: Use subdir-ccflags-* to inherit debug flag
Message-ID: <20210205182832.GA186268@roeck-us.net>
References: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
 <1612518255-23052-3-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612518255-23052-3-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 05, 2021 at 05:44:13PM +0800, Yicong Yang wrote:
> From: Junhao He <hejunhao2@hisilicon.com>
> 
> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
> settings from Kconfig when traversing subdirectories.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

What problem does this fix ? Maybe I am missing it, but I don't see
DEBUG being used in a subdirectory of drivers/hwmon.

Guenter

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
