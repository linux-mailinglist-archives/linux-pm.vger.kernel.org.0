Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B8B1E7080
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 01:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437646AbgE1Xks (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 19:40:48 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40680 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437593AbgE1Xkq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 19:40:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04SNYfv7090690;
        Thu, 28 May 2020 18:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590708881;
        bh=rl7/xrN4dyHCY0P9+fejZ1982cTwA0TKyTv5w1Z40oA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iM2RRmz4/3X5f176xVtTiWBycEJKu+Heq2CbqG5eR0d6bNtQ+WIcMlVIcRDeC7/yl
         35/hMLFEeKXzzrrGHFsSXLXcDKemIdhgbvq3BOXdLZaqGnQ00zNDwv6BX4CpjpgCF5
         83y1ahAhQxC/Rc2zgX/gORZFZ62zBbjxsBlm71GI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04SNYfPu022920
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 18:34:41 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 18:34:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 18:34:40 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SNYdoL029206;
        Thu, 28 May 2020 18:34:40 -0500
Subject: Re: [PATCH v12 1/4] power_supply: Add additional health properties to
 the header
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>, <sre@kernel.org>,
        <pali@kernel.org>, <robh@kernel.org>
CC:     <dmurphy@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sspatil@android.com>, Guru Das Srinagesh <gurus@codeaurora.org>
References: <20200528225350.661-1-r-rivera-matos@ti.com>
 <20200528225350.661-2-r-rivera-matos@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <5be7933c-dc85-d526-a321-1cc0ce127ddc@ti.com>
Date:   Thu, 28 May 2020 19:34:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528225350.661-2-r-rivera-matos@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/28/20 6:53 PM, Ricardo Rivera-Matos wrote:
> From: Dan Murphy <dmurphy@ti.com>
> 
> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
> 
> HEALTH_WARM, HEALTH_COOL, and HEALTH_HOT properties are taken
> from JEITA specification JISC8712:2015
> 
> Tested-by: Guru Das Srinagesh <gurus@codeaurora.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>


You should collect the acks and such you have received in previous
versions here, like mine from v11:

Acked-by: Andrew F. Davis <afd@ti.com>


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
> index dcd5a71e6c67..8670e90c1d51 100644
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
> 
