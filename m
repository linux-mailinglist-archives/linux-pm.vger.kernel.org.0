Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3002F10A5F1
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 22:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfKZVYW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 16:24:22 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:52123 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfKZVYW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 16:24:22 -0500
Received: from localhost (lfbn-1-1723-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 52C00100003;
        Tue, 26 Nov 2019 21:24:19 +0000 (UTC)
Date:   Tue, 26 Nov 2019 22:24:18 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux@armlinux.org.uk, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 00/17] SoC and defconfig support for SAM9X60
Message-ID: <20191126212418.GQ299836@piout.net>
References: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 26/11/2019 15:12:04+0200, Claudiu Beznea wrote:
> Hi,
> 
> This series enables proper support for SAM9X60 in Kconfig and
> defconfig.
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v2:
> - cahnged cover letter title; previously it was:
>   "add defconfig support for SAM9X60"
> - have new entry in arch/arm/mach-at91/Kconfig for SOC_SAM9X60
>   independent of SOC_AT91SAM9 to be able to select only necessary
>   config flags for SAM9X60 (patches 02/17, 03/17)
> - select POWER_RESET_AT91_RESET and POWER_RESET_AT91_SAMA5D2_SHDWC
>   as for SAMA5D2 (patches 04/17, 05/17)
> - select DEBUG_AT91_RM9200_DBGU (patch 06/17)
> - shaped a bit the patches titles and commit desciptions for defconfig
>   patches (patches 09-17/17)
> 
> Claudiu Beznea (12):
>   ARM: at91: Kconfig: add sam9x60 pll config flag
>   ARM: at91: pm: move SAM9X60's PM under its own SoC config flag
>   drivers: soc: atmel: move sam9x60 under its own config flag
>   power: reset: Kconfig: select POWER_RESET_AT91_RESET for sam9x60
>   drivers: soc: atmel: select POWER_RESET_AT91_SAMA5D2_SHDWC for sam9x60
>   ARM: debug-ll: select DEBUG_AT91_RM9200_DBGU for sam9x60
>   ARM: at91: Kconfig: add config flag for SAM9X60 SoC

This patch should come before the other one making use of it.

>   ARM: at91/defconfig: use savedefconfig
>   ARM: at91/defconfig: enable config flag for sam9x60 SoC
>   ARM: at91/defconfig: enable config flag for atmel maxtouch
>   ARM: at91/defconfig: enable config flag for flexcom
>   ARM: at91/defconfig: enable config flag for XDMAC
> 
> Codrin Ciubotariu (3):
>   ARM: at91/defconfig: enable config flag for I2S Multi-channel
>   ARM: at91/defconfig: enable config flag for audio PROTO board
>   ARM: at91/defconfig: enable config flag for CLASSD
> 
> Tudor Ambarus (2):
>   ARM: at91/defconfig: enable config flag for SAMA5D2's ADC
>   ARM: at91/defconfig: enable config flag for ATMEL QUADSPI

Please squash all of those but the savedefconfig.

> 
>  arch/arm/Kconfig.debug             |  6 ++---
>  arch/arm/configs/at91_dt_defconfig | 55 ++++++++++++++++++--------------------
>  arch/arm/mach-at91/Kconfig         | 24 +++++++++++++++--
>  arch/arm/mach-at91/Makefile        |  1 +
>  arch/arm/mach-at91/at91sam9.c      | 18 -------------
>  arch/arm/mach-at91/pm.c            |  2 +-
>  arch/arm/mach-at91/sam9x60.c       | 34 +++++++++++++++++++++++
>  drivers/power/reset/Kconfig        |  4 +--
>  drivers/soc/atmel/soc.c            |  5 ++--
>  9 files changed, 92 insertions(+), 57 deletions(-)
>  create mode 100644 arch/arm/mach-at91/sam9x60.c
> 
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
