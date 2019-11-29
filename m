Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E82510D4D4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 12:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfK2L3v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 06:29:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48918 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2L3v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 06:29:51 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id b06a6a2dbb2630b1; Fri, 29 Nov 2019 12:29:49 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Fix Kconfig indentation
Date:   Fri, 29 Nov 2019 12:29:48 +0100
Message-ID: <2290445.U5tkkzJWrW@kreacher>
In-Reply-To: <1574306355-29316-1-git-send-email-krzk@kernel.org>
References: <1574306355-29316-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, November 21, 2019 4:19:15 AM CET Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> 
> Changes since v1:
> 1. Fix also 7-space and tab+1 space indentation issues.
> ---
>  drivers/cpufreq/Kconfig.powerpc |  8 ++++----
>  drivers/cpufreq/Kconfig.x86     | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
> index 35b4f700f054..58151ca56695 100644
> --- a/drivers/cpufreq/Kconfig.powerpc
> +++ b/drivers/cpufreq/Kconfig.powerpc
> @@ -48,9 +48,9 @@ config PPC_PASEMI_CPUFREQ
>  	  PWRficient processors.
>  
>  config POWERNV_CPUFREQ
> -       tristate "CPU frequency scaling for IBM POWERNV platform"
> -       depends on PPC_POWERNV
> -       default y
> -       help
> +	tristate "CPU frequency scaling for IBM POWERNV platform"
> +	depends on PPC_POWERNV
> +	default y
> +	help
>  	 This adds support for CPU frequency switching on IBM POWERNV
>  	 platform
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index dfa6457deaf6..a6528388952e 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -4,17 +4,17 @@
>  #
>  
>  config X86_INTEL_PSTATE
> -       bool "Intel P state control"
> -       depends on X86
> -       select ACPI_PROCESSOR if ACPI
> -       select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
> -       help
> -          This driver provides a P state for Intel core processors.
> +	bool "Intel P state control"
> +	depends on X86
> +	select ACPI_PROCESSOR if ACPI
> +	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
> +	help
> +	  This driver provides a P state for Intel core processors.
>  	  The driver implements an internal governor and will become
> -          the scaling driver and governor for Sandy bridge processors.
> +	  the scaling driver and governor for Sandy bridge processors.
>  
>  	  When this driver is enabled it will become the preferred
> -          scaling driver for Sandy bridge processors.
> +	  scaling driver for Sandy bridge processors.
>  
>  	  If in doubt, say N.
>  
> 

Applied as 5.5 material, thanks!



