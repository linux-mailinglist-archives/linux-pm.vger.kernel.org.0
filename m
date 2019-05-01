Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BAB10456
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 05:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfEADna (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 23:43:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42818 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfEADna (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 23:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NX9lVh4U+E8N0tdek5TWZY7FDPPnmK0y+fQRg+gjxcc=; b=mtLLfELQooqikemDiLpl9Y8N7w
        xK/DC/j9Djd+FBLHw3fa6omLGrwIn9MTk7GSaOusgp9brphU33RyqEPwDdIEMFxZ/VraaoPfvzFt1
        Boq2DDzDV+ID9xP8FpGt3kNDyasVCINSk9tWg6PINrLcjb+PwM7nqzGjZhESGFyzbuYhxm1ZVVMad
        XBATV4F8LqsyyBCi66uHNh6XJgMHbgpX8AdvV41ah8CBcJNXYZd3MIpB0XS6LwyA6bx0z+OXrQaAI
        nu+MKSa92E5jUgKarpd3mC7nJeed77uJCupOYy8FUFzh72iNXV3o/ELcHR8N5gfdn/d40ZyiiTp93
        d5i+4LCg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLg9X-0004t2-65; Wed, 01 May 2019 03:43:27 +0000
Subject: Re: [PATCH v5 2/3] power: supply: Add driver for Microchip UCS1002
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190501033434.18548-1-andrew.smirnov@gmail.com>
 <20190501033434.18548-3-andrew.smirnov@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7002fe8e-7686-fe84-374f-766f99f8317d@infradead.org>
Date:   Tue, 30 Apr 2019 20:43:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501033434.18548-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/30/19 8:34 PM, Andrey Smirnov wrote:
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..c614c8a196f3 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
>  	 Say Y here to enable support for fuel gauge with SC27XX
>  	 PMIC chips.
>  
> +config CHARGER_UCS1002
> +        tristate "Microchip UCS1002 USB Port Power Controller"

Please indent the tristate line with a tab instead of spaces.

> +	depends on I2C
> +	depends on OF
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for Microchip UCS1002 Programmable
> +	  USB Port Power Controller with Charger Emulation.
> +
>  endif # POWER_SUPPLY


thnx.
-- 
~Randy
