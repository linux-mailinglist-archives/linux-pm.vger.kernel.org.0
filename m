Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53C22DC173
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 14:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgLPNlo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 08:41:44 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:60603 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgLPNlo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 08:41:44 -0500
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B6850100006;
        Wed, 16 Dec 2020 13:41:00 +0000 (UTC)
Date:   Wed, 16 Dec 2020 14:41:00 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: atmel-sysreg: add
 microchip,sama7g5-shdwc
Message-ID: <20201216134100.GG2814589@piout.net>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
 <1608123453-1423-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608123453-1423-3-git-send-email-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/12/2020 14:57:32+0200, Claudiu Beznea wrote:
> Add compatible for Microchip SAMA7G5's shutdown controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I'm pretty sure the first comment you'll get is to convert this file to
yaml ;)

> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 62cd4e89817c..7990358ac06e 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -91,7 +91,8 @@ SHDWC SAMA5D2-Compatible Shutdown Controller
>  1) shdwc node
>  
>  required properties:
> -- compatible: should be "atmel,sama5d2-shdwc" or "microchip,sam9x60-shdwc".
> +- compatible: should be "atmel,sama5d2-shdwc", "microchip,sam9x60-shdwc" or
> +  "microchip,sama7g5-shdwc"
>  - reg: should contain registers location and length
>  - clocks: phandle to input clock.
>  - #address-cells: should be one. The cell is the wake-up input index.
> @@ -103,7 +104,7 @@ optional properties:
>    microseconds. It's usually a board-related property.
>  - atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
>  
> -optional microchip,sam9x60-shdwc properties:
> +optional microchip,sam9x60-shdwc or microchip,sama7g5-shdwc properties:
>  - atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
>  
>  The node contains child nodes for each wake-up input that the platform uses.
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
