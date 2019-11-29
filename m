Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0EE10D4D0
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 12:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfK2L2p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 06:28:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62855 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfK2L2p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 06:28:45 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 1dd8f8aa4919ded0; Fri, 29 Nov 2019 12:28:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpuidle: Fix Kconfig indentation
Date:   Fri, 29 Nov 2019 12:28:43 +0100
Message-ID: <1785480.d7BT1UD6kJ@kreacher>
In-Reply-To: <1574306352-29264-1-git-send-email-krzk@kernel.org>
References: <1574306352-29264-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, November 21, 2019 4:19:12 AM CET Krzysztof Kozlowski wrote:
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
>  drivers/cpuidle/Kconfig     | 16 ++++++++--------
>  drivers/cpuidle/Kconfig.arm | 16 ++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 88727b7c0d59..c0aeedd66f02 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -16,7 +16,7 @@ config CPU_IDLE
>  if CPU_IDLE
>  
>  config CPU_IDLE_MULTIPLE_DRIVERS
> -        bool
> +	bool
>  
>  config CPU_IDLE_GOV_LADDER
>  	bool "Ladder governor (for periodic timer tick)"
> @@ -63,13 +63,13 @@ source "drivers/cpuidle/Kconfig.powerpc"
>  endmenu
>  
>  config HALTPOLL_CPUIDLE
> -       tristate "Halt poll cpuidle driver"
> -       depends on X86 && KVM_GUEST
> -       default y
> -       help
> -         This option enables halt poll cpuidle driver, which allows to poll
> -         before halting in the guest (more efficient than polling in the
> -         host via halt_poll_ns for some scenarios).
> +	tristate "Halt poll cpuidle driver"
> +	depends on X86 && KVM_GUEST
> +	default y
> +	help
> +	 This option enables halt poll cpuidle driver, which allows to poll
> +	 before halting in the guest (more efficient than polling in the
> +	 host via halt_poll_ns for some scenarios).
>  
>  endif
>  
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index d8530475493c..e91ab792d14d 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -3,15 +3,15 @@
>  # ARM CPU Idle drivers
>  #
>  config ARM_CPUIDLE
> -        bool "Generic ARM/ARM64 CPU idle Driver"
> -        select DT_IDLE_STATES
> +	bool "Generic ARM/ARM64 CPU idle Driver"
> +	select DT_IDLE_STATES
>  	select CPU_IDLE_MULTIPLE_DRIVERS
> -        help
> -          Select this to enable generic cpuidle driver for ARM.
> -          It provides a generic idle driver whose idle states are configured
> -          at run-time through DT nodes. The CPUidle suspend backend is
> -          initialized by calling the CPU operations init idle hook
> -          provided by architecture code.
> +	help
> +	  Select this to enable generic cpuidle driver for ARM.
> +	  It provides a generic idle driver whose idle states are configured
> +	  at run-time through DT nodes. The CPUidle suspend backend is
> +	  initialized by calling the CPU operations init idle hook
> +	  provided by architecture code.
>  
>  config ARM_PSCI_CPUIDLE
>  	bool "PSCI CPU idle Driver"
> 

Applied as 5.5 material, thanks!




