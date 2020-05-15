Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60B11D54DF
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgEOPhm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 11:37:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45144 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgEOPhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 11:37:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: evelikov)
        with ESMTPSA id 560F02A3375
Date:   Fri, 15 May 2020 16:35:02 +0100
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 13/19] power: supply: sbs-battery: add
 POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED support
Message-ID: <20200515153502.GE2836808@arch-x1c3>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <20200513185615.508236-14-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513185615.508236-14-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/05/13, Sebastian Reichel wrote:
> Add support for reporting the SBS battery's condition flag
> to userspace using the new "Calibration required" health status.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/power/supply/sbs-battery.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 4fa553d61db2..2a2b926ad75c 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -23,6 +23,7 @@
>  
>  enum {
>  	REG_MANUFACTURER_DATA,
> +	REG_BATTERY_MODE,
>  	REG_TEMPERATURE,
>  	REG_VOLTAGE,
>  	REG_CURRENT_NOW,
> @@ -94,6 +95,8 @@ static const struct chip_data {
>  } sbs_data[] = {
>  	[REG_MANUFACTURER_DATA] =
>  		SBS_DATA(POWER_SUPPLY_PROP_PRESENT, 0x00, 0, 65535),
> +	[REG_BATTERY_MODE] =
> +		SBS_DATA(-1, 0x03, 0, 65535),

Fwiw I really like how neatly the driver is split into components. One thing
which makes me wonder, have you considered reshuffling the sbs_data struct.

In particular:
 - index POWER_SUPPLY_PROP, kill off the REG_ enum
   - sbs_get_property_index() can go, alongside a couple of unreachable paths
   - replace batter_mode (needs calibration) with with PROP_HEALTH + comment
   - perhaps even add REG_ADDR_SPEC_INFO 0x1a under POWER_SUPPLY_PROP_PRESENT
 - using the min/max seems wasteful, considering only one register is in s16
   range while everything else is within u16


Regardless of the questions and trivial suggestions, the series looks spot on.

For the lot:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>


-Emil
P.S. The reg table is nearly complete only 0x01-0x07, 0x0E, 0x11, 0x1d-0x1f
remain o/
