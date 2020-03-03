Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE575178415
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 21:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbgCCUd4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 15:33:56 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:24943 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728176AbgCCUd4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 15:33:56 -0500
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Mar 2020 12:33:56 -0800
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg05-sd.qualcomm.com with ESMTP; 03 Mar 2020 12:33:56 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 404F04B06; Tue,  3 Mar 2020 12:33:56 -0800 (PST)
Date:   Tue, 3 Mar 2020 12:33:56 -0800
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     sebastian.reichel@collabora.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] power_supply: Add additional health properties to
 the header
Message-ID: <20200303203343.GA3496@codeaurora.org>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116175039.1317-3-dmurphy@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 16, 2020 at 11:50:37AM -0600, Dan Murphy wrote:
> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 2 +-
>  drivers/power/supply/power_supply_sysfs.c   | 2 +-
>  include/linux/power_supply.h                | 3 +++
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index bf3b48f022dc..9f3fd01a9373 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -190,7 +190,7 @@ Description:
>  		Valid values: "Unknown", "Good", "Overheat", "Dead",
>  			      "Over voltage", "Unspecified failure", "Cold",
>  			      "Watchdog timer expire", "Safety timer expire",
> -			      "Over current"
> +			      "Over current", "Warm", "Cool", "Hot"
>  
>  What:		/sys/class/power_supply/<supply_name>/precharge_current
>  Date:		June 2017
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index f37ad4eae60b..d0d549611794 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -61,7 +61,7 @@ static const char * const power_supply_charge_type_text[] = {
>  static const char * const power_supply_health_text[] = {
>  	"Unknown", "Good", "Overheat", "Dead", "Over voltage",
>  	"Unspecified failure", "Cold", "Watchdog timer expire",
> -	"Safety timer expire", "Over current"
> +	"Safety timer expire", "Over current", "Warm", "Cool", "Hot"
>  };
>  
>  static const char * const power_supply_technology_text[] = {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 28413f737e7d..bd0d3225f245 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -61,6 +61,9 @@ enum {
>  	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
>  	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
>  	POWER_SUPPLY_HEALTH_OVERCURRENT,
> +	POWER_SUPPLY_HEALTH_WARM,
> +	POWER_SUPPLY_HEALTH_COOL,
> +	POWER_SUPPLY_HEALTH_HOT,
>  };
>  
>  enum {

Tested-by: Guru Das Srinagesh <gurus@codeaurora.org>

Applied this patch and verified that the new enums and the display
strings match, using a downstream driver (currently under
development).
