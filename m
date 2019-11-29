Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75110D4D9
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 12:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfK2Lao (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 06:30:44 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44824 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfK2Lao (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 06:30:44 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id edf759f14a6c300f; Fri, 29 Nov 2019 12:30:42 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: minor Kconfig help text fixes
Date:   Fri, 29 Nov 2019 12:30:42 +0100
Message-ID: <13585617.HsJz9ZEzGy@kreacher>
In-Reply-To: <b0e9d1df-8bb9-9eee-f433-c7a8e8269e06@infradead.org>
References: <b0e9d1df-8bb9-9eee-f433-c7a8e8269e06@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, November 28, 2019 11:38:03 PM CET Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> End sentences in help text with a period (aka full stop).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/cpuidle/Kconfig.arm |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- lnx-54.orig/drivers/cpuidle/Kconfig.arm
> +++ lnx-54/drivers/cpuidle/Kconfig.arm
> @@ -65,21 +65,21 @@ config ARM_U8500_CPUIDLE
>  	bool "Cpu Idle Driver for the ST-E u8500 processors"
>  	depends on ARCH_U8500 && !ARM64
>  	help
> -	  Select this to enable cpuidle for ST-E u8500 processors
> +	  Select this to enable cpuidle for ST-E u8500 processors.
>  
>  config ARM_AT91_CPUIDLE
>  	bool "Cpu Idle Driver for the AT91 processors"
>  	default y
>  	depends on ARCH_AT91 && !ARM64
>  	help
> -	  Select this to enable cpuidle for AT91 processors
> +	  Select this to enable cpuidle for AT91 processors.
>  
>  config ARM_EXYNOS_CPUIDLE
>  	bool "Cpu Idle Driver for the Exynos processors"
>  	depends on ARCH_EXYNOS && !ARM64
>  	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>  	help
> -	  Select this to enable cpuidle for Exynos processors
> +	  Select this to enable cpuidle for Exynos processors.
>  
>  config ARM_MVEBU_V7_CPUIDLE
>  	bool "CPU Idle Driver for mvebu v7 family processors"
> 

Applied as 5.5 material, thanks!



