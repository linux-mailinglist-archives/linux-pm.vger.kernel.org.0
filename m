Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D517B1B42F0
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 13:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDVLSH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 07:18:07 -0400
Received: from foss.arm.com ([217.140.110.172]:47818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgDVLSH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 07:18:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A34A31B;
        Wed, 22 Apr 2020 04:18:05 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AE643F6CF;
        Wed, 22 Apr 2020 04:18:05 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 2CEA0682F3D; Wed, 22 Apr 2020 12:18:04 +0100 (BST)
Date:   Wed, 22 Apr 2020 12:18:04 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 10/17] mfd: vexpress-sysreg: Drop unused syscon child
 devices
Message-ID: <20200422111804.GV364558@e110455-lin.cambridge.arm.com>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-11-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200419170810.5738-11-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

Missing commit message?

On Sun, Apr 19, 2020 at 12:08:03PM -0500, Rob Herring wrote:
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/vexpress-sysreg.c | 36 -----------------------------------
>  1 file changed, 36 deletions(-)
> 
> diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
> index 0b9cc67706c7..90a4eda2ba2b 100644
> --- a/drivers/mfd/vexpress-sysreg.c
> +++ b/drivers/mfd/vexpress-sysreg.c
> @@ -43,10 +43,6 @@
>  
>  /* The sysreg block is just a random collection of various functions... */
>  
> -static struct syscon_platform_data vexpress_sysreg_sys_id_pdata = {
> -	.label = "sys_id",
> -};
> -
>  static struct bgpio_pdata vexpress_sysreg_sys_led_pdata = {
>  	.label = "sys_led",
>  	.base = -1,
> @@ -65,24 +61,8 @@ static struct bgpio_pdata vexpress_sysreg_sys_flash_pdata = {
>  	.ngpio = 1,
>  };
>  
> -static struct syscon_platform_data vexpress_sysreg_sys_misc_pdata = {
> -	.label = "sys_misc",
> -};
> -
> -static struct syscon_platform_data vexpress_sysreg_sys_procid_pdata = {
> -	.label = "sys_procid",
> -};
> -
>  static struct mfd_cell vexpress_sysreg_cells[] = {
>  	{
> -		.name = "syscon",
> -		.num_resources = 1,
> -		.resources = (struct resource []) {
> -			DEFINE_RES_MEM(SYS_ID, 0x4),
> -		},
> -		.platform_data = &vexpress_sysreg_sys_id_pdata,
> -		.pdata_size = sizeof(vexpress_sysreg_sys_id_pdata),
> -	}, {
>  		.name = "basic-mmio-gpio",
>  		.of_compatible = "arm,vexpress-sysreg,sys_led",
>  		.num_resources = 1,
> @@ -109,22 +89,6 @@ static struct mfd_cell vexpress_sysreg_cells[] = {
>  		},
>  		.platform_data = &vexpress_sysreg_sys_flash_pdata,
>  		.pdata_size = sizeof(vexpress_sysreg_sys_flash_pdata),
> -	}, {
> -		.name = "syscon",
> -		.num_resources = 1,
> -		.resources = (struct resource []) {
> -			DEFINE_RES_MEM(SYS_MISC, 0x4),
> -		},
> -		.platform_data = &vexpress_sysreg_sys_misc_pdata,
> -		.pdata_size = sizeof(vexpress_sysreg_sys_misc_pdata),
> -	}, {
> -		.name = "syscon",
> -		.num_resources = 1,
> -		.resources = (struct resource []) {
> -			DEFINE_RES_MEM(SYS_PROCID0, 0x8),
> -		},
> -		.platform_data = &vexpress_sysreg_sys_procid_pdata,
> -		.pdata_size = sizeof(vexpress_sysreg_sys_procid_pdata),

These were used for communication with the daughterboards. AFAIK there is no upstream
support for that in the kernel and even inside Arm I am almost sure there are no
users left.

With the commit message added:

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


>  	}, {
>  		.name = "vexpress-syscfg",
>  		.num_resources = 1,
> -- 
> 2.20.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
