Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A357B174991
	for <lists+linux-pm@lfdr.de>; Sat, 29 Feb 2020 23:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgB2WNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Feb 2020 17:13:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgB2WNL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Feb 2020 17:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=qaft5TU1yxXKKuYNsJoRBGojYQzg8g2jogl+anXhnKQ=; b=aaHzDW0eJaKTaR8mp/hXCbfK9F
        hJAy5dl3JfqRObZdusXFfbhRIjSkPzDYYOMnmtt0mPnK7Qqm62S5HiKHUDeueEKFUjZtYSa71JXkG
        79bTGhQc/6JPQG8rxwweqANYwo1jqcELbVcDw37ssiM3R3RM3ghkiN5picjS7Gj97jtNhp0PAbZaj
        Z7vEOUiccnhRiEyQTQz6q7+FigzBhFK+TOEBWdl2diOHhIojzhINXx58wZpKcOTxYAovHVDVUEbI8
        j+4CkjdgLmYbu6hjtjOG6thjWfrmGlygWSjhaGp6CaKiAVphMh4wWcR+bayIsSfhk33kj4/8BdI7r
        pslWNW2A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8AMA-0005YE-Uv; Sat, 29 Feb 2020 22:13:11 +0000
Subject: Re: [PATCH] thermal: Rephrase the Kconfig text for thermal
To:     Linus Walleij <linus.walleij@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
References: <20200229204527.143796-1-linus.walleij@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3e91a244-042d-f19e-0f31-ac7301a49196@infradead.org>
Date:   Sat, 29 Feb 2020 14:13:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200229204527.143796-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/29/20 12:45 PM, Linus Walleij wrote:
> The thermal subsystem may have relied on sysfs in 2008 when it
> was introduced, but these days the thermal zones will more often
> than not come from the hardware descriptions and not from sysfs.
> 
> Drop the "Generic" phrases as well: there are no non-generic
> drivers that I know of, the thermal framework is by definition
> generic.
> 
> Reword a bit and fix some grammar.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/thermal/Kconfig | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5a05db5438d6..a88aa0f6c5a8 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -1,17 +1,18 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
> -# Generic thermal sysfs drivers configuration
> +# Generic thermal drivers configuration
>  #
>  
>  menuconfig THERMAL
> -	bool "Generic Thermal sysfs driver"
> +	bool "Thermal drivers"
>  	help
> -	  Generic Thermal Sysfs driver offers a generic mechanism for
> +	  Thermal drivers offers a generic mechanism for

preferably:               offer

>  	  thermal management. Usually it's made up of one or more thermal
> -	  zone and cooling device.
> +	  zones and cooling devices.


-- 
~Randy

