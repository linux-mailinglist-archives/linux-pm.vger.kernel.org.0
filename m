Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E855944A677
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 06:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbhKIF5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 00:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhKIF5D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Nov 2021 00:57:03 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381EEC061764;
        Mon,  8 Nov 2021 21:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=yBvwR64i6SwdYtu8CmlPzw6iMLx7e8STOZsfXWyFGcY=; b=mf2WkuO7+uObCTKFXdpkAwVRUP
        /3ex5IRInDFTkGYKp+xbcZff40c/JEwEXLUznbqozq3yXCeVn/WZuQjiercOIHvfFsPYuvKm6EERl
        xaOaaZprujKfxGg6pkhZzinDW1mcLJWFtk7LBMDn1q90IaiuAU6GN6xCl0owzsY5BTaF4YqCAqO50
        RKM57KeJFbCEr1X745CScb50Ez9/ivo1CVJ3U9sLMkqXrYG90TZq813oq+K1jjTNowl+iVJnsmq/w
        8E6V2B1uyka7xEtOPlL5hx5ux+WB8LKqwC/N97D++WFhX0iBy4rzk6uw9w8AMPswUbBRN9SP7jRnJ
        O8kCvROw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkK5G-008lhI-Je; Tue, 09 Nov 2021 05:54:14 +0000
Subject: Re: [PATCH] thermal/drivers/int340x: limit Kconfig to 64-bit
To:     Arnd Bergmann <arnd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211108111347.3928294-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a22a1eeb-c7a0-74c1-46e2-0a7bada73520@infradead.org>
Date:   Mon, 8 Nov 2021 21:54:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108111347.3928294-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/8/21 3:13 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> 32-bit processors cannot generally access 64-bit MMIO registers
> atomically, and it is unknown in which order the two halves of
> this registers would need to be read:
> 
> drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c: In function 'send_mbox_cmd':
> drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c:79:37: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
>     79 |                         *cmd_resp = readq((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
>        |                                     ^~~~~
>        |                                     readl
> 
> The driver already does not build for anything other than x86,
> so limit it further to x86-64.
> 
> Fixes: aeb58c860dc5 ("thermal/drivers/int340x: processor_thermal: Suppot 64 bit RFIM responses")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/thermal/intel/int340x_thermal/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
> index 45c31f3d6054..5d046de96a5d 100644
> --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> @@ -5,12 +5,12 @@
>   
>   config INT340X_THERMAL
>   	tristate "ACPI INT340X thermal drivers"
> -	depends on X86 && ACPI && PCI
> +	depends on X86_64 && ACPI && PCI
>   	select THERMAL_GOV_USER_SPACE
>   	select ACPI_THERMAL_REL
>   	select ACPI_FAN
>   	select INTEL_SOC_DTS_IOSF_CORE
> -	select PROC_THERMAL_MMIO_RAPL if X86_64 && POWERCAP
> +	select PROC_THERMAL_MMIO_RAPL if POWERCAP
>   	help
>   	  Newer laptops and tablets that use ACPI may have thermal sensors and
>   	  other devices with thermal control capabilities outside the core
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
