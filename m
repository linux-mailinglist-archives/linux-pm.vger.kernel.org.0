Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349421E6380
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 16:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390833AbgE1OQz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 10:16:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33046 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390866AbgE1OQy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 10:16:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04SEGp14098090;
        Thu, 28 May 2020 09:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590675411;
        bh=HK7CIXSj8i46BQmDUrCSsRlBvvZmdKuuQKRIbzW1ZlA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zLpIZu/fzYxPLkDiHtSjc5YRXzSzbYQrNN1MSi9OU2JnFqWL/Poxzw4fEjBEwZEsr
         H3E11fEShawKz/Ljq6mNRS7ejrYAxqlRBHDZFFDE8XAqXx+iQ6Q8P0+Fw+0qKU2MMT
         kwSo9gzjbi5qhqDsb8KwQsSJ7y+uAhNGUIvIly+8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SEGp3Q039378;
        Thu, 28 May 2020 09:16:51 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 09:16:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 09:16:51 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SEGn6o049544;
        Thu, 28 May 2020 09:16:50 -0500
Subject: Re: [PATCH v11 1/4] power_supply: Add additional health properties to
 the header
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>, <sre@kernel.org>,
        <pali@kernel.org>, <robh@kernel.org>
CC:     <dmurphy@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sspatil@android.com>, Guru Das Srinagesh <gurus@codeaurora.org>
References: <20200528140546.25260-1-r-rivera-matos@ti.com>
 <20200528140546.25260-2-r-rivera-matos@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <66823f18-dc74-107f-39ae-aade2d3738c0@ti.com>
Date:   Thu, 28 May 2020 10:16:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528140546.25260-2-r-rivera-matos@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/28/20 10:05 AM, Ricardo Rivera-Matos wrote:
> From: Dan Murphy <dmurphy@ti.com>
> 
> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
> 
> HEALTH_WARM, HEALTH_COOL, and HEALTH_HOT properties are taken from the JEITA spec.


Wouldn't hurt to list the specific version of the spec these are from,
but not super important,

Acked-by: Andrew F. Davis <afd@ti.com>


> 
> Tested-by: Guru Das Srinagesh <gurus@codeaurora.org>
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
