Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAEA3EEC4D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 14:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhHQMVI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 08:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234866AbhHQMVG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 08:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629202833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCWwKgC8vUsuE2WE9PyNVC6D7ecItWbGxz5ws2wCHCE=;
        b=U32vq/8vIvZPpsat+375ezdQefm7Vak1Lo3Axw6JMpYGSYdIpMNAFoMiYI/8A4rZm4TkRH
        sTR0WdnQGeKvHqwaDwlvx3w87ShsjlfjxfOiTgS18ghjAW5mgbsQaNFSstmfGjj2Q+YTNd
        BFvd/avnp7nUfbdpdkcAAMkArsh/QAU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-OffpmLtLPwK23dagrAmckQ-1; Tue, 17 Aug 2021 08:20:32 -0400
X-MC-Unique: OffpmLtLPwK23dagrAmckQ-1
Received: by mail-ej1-f71.google.com with SMTP id k12-20020a170906680cb02905aeccdbd1efso5949526ejr.9
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 05:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WCWwKgC8vUsuE2WE9PyNVC6D7ecItWbGxz5ws2wCHCE=;
        b=agQTHSffZKEg74VMnZWc1kmd9P/Tht5NIEEMam5flxyPk1F4mrF4G0XotZI3qQyANZ
         g0fwBA0TQ4SRelr8boaw1tWs9FSnRdmEMBpNUdHQX3QFwP+fCs/ec5Wlyh0ever3ESZM
         ABZKF12jcCwacDVz+hTCSjPNG7wwbihedujolK9KixvZEfqcbO9irLZvXsDuJ9aNGeGm
         XMzKMFjb9xVryYghWPHIL/Rt9MHxfnosHzTlKJS59glfjoimOVwZgsT2GOOtJ8YQGtbP
         yenpvjYlWR+VJGoYaHVjNaz40kVsp6LBqTmlmTMKZV4V6Cc/qog1SRZ0MjzKMlzKBIMX
         aydA==
X-Gm-Message-State: AOAM530bEkAsR/r3Qfy0/F1N5e3RfrB5BzY3LFGRSFSSi80PqPyFd4VS
        5QPCZMeuu4HT9JelCLljEm12JwzMLyMbX53WuJQeAexmB1VTxmMiYsGKplDI1IdLK9COP4Hxz7w
        6Ddh9qCzdCnx/cC+BxmA=
X-Received: by 2002:a05:6402:202:: with SMTP id t2mr3896507edv.116.1629202830893;
        Tue, 17 Aug 2021 05:20:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfibEi13rdYKjmR2wH9W3qnvKvw18KjDU95pwjXi8K1iXWhRDD7mNrmC0DlsP2FBPlov84Xw==
X-Received: by 2002:a05:6402:202:: with SMTP id t2mr3896495edv.116.1629202830763;
        Tue, 17 Aug 2021 05:20:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cq12sm862402edb.43.2021.08.17.05.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 05:20:30 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/intel: Move intel_menlow to thermal
 drivers
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, hpa@redhat.com,
        mgross@linux.intel.com, alex.hung@canonical.com,
        sujith.thomas@intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20210816035356.1955982-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <84a22ffa-9369-6da4-9bb9-67113174519e@redhat.com>
Date:   Tue, 17 Aug 2021 14:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816035356.1955982-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/16/21 5:53 AM, Srinivas Pandruvada wrote:
> Moved drivers/platform/x86/intel_menlow.c to drivers/thermal/intel.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

(with the 2 acks from the thermal subsys maintainers added)

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  MAINTAINERS                                            |  4 ++--
>  drivers/platform/x86/Kconfig                           | 10 ----------
>  drivers/platform/x86/Makefile                          |  1 -
>  drivers/thermal/intel/Kconfig                          |  9 +++++++++
>  drivers/thermal/intel/Makefile                         |  1 +
>  drivers/{platform/x86 => thermal/intel}/intel_menlow.c |  0
>  6 files changed, 12 insertions(+), 13 deletions(-)
>  rename drivers/{platform/x86 => thermal/intel}/intel_menlow.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd25e4ecf0b9..4231aea31a6f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9459,10 +9459,10 @@ F:	include/linux/mfd/intel-m10-bmc.h
>  
>  INTEL MENLOW THERMAL DRIVER
>  M:	Sujith Thomas <sujith.thomas@intel.com>
> -L:	platform-driver-x86@vger.kernel.org
> +L:	linux-pm@vger.kernel.org
>  S:	Supported
>  W:	https://01.org/linux-acpi
> -F:	drivers/platform/x86/intel_menlow.c
> +F:	drivers/thermal/intel/intel_menlow.c
>  
>  INTEL P-Unit IPC DRIVER
>  M:	Zha Qipeng <qipeng.zha@intel.com>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index d12db6c316ea..da312426b4a5 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -720,16 +720,6 @@ config INTEL_INT0002_VGPIO
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called intel_int0002_vgpio.
>  
> -config INTEL_MENLOW
> -	tristate "Thermal Management driver for Intel menlow platform"
> -	depends on ACPI_THERMAL
> -	select THERMAL
> -	help
> -	  ACPI thermal management enhancement driver on
> -	  Intel Menlow platform.
> -
> -	  If unsure, say N.
> -
>  config INTEL_OAKTRAIL
>  	tristate "Intel Oaktrail Platform Extras"
>  	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 7ee369aab10d..0d3af23f1186 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -72,7 +72,6 @@ obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
>  obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
>  obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
>  obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
> -obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
>  obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
>  obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
>  
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index e4299ca3423c..c83ea5d04a1d 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -90,3 +90,12 @@ config INTEL_TCC_COOLING
>  	  Note that, on different platforms, the behavior might be different
>  	  on how fast the setting takes effect, and how much the CPU frequency
>  	  is reduced.
> +
> +config INTEL_MENLOW
> +	tristate "Thermal Management driver for Intel menlow platform"
> +	depends on ACPI_THERMAL
> +	help
> +	  ACPI thermal management enhancement driver on
> +	  Intel Menlow platform.
> +
> +	  If unsure, say N.
> diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
> index 5ff2afa388f7..960b56268b4a 100644
> --- a/drivers/thermal/intel/Makefile
> +++ b/drivers/thermal/intel/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
>  obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
>  obj-$(CONFIG_INTEL_TCC_COOLING)	+= intel_tcc_cooling.o
>  obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
> +obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
> diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
> similarity index 100%
> rename from drivers/platform/x86/intel_menlow.c
> rename to drivers/thermal/intel/intel_menlow.c
> 

